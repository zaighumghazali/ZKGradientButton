//
//  ZKGradientButton.swift
//  ZKGradientButton
//
//  Created by Zaighum on 4/1/23.
//

import UIKit
@IBDesignable class ZKGradientButton: UIButton {

    @IBInspectable var gradientStartColor: UIColor = UIColor.red
    @IBInspectable var gradientEndColor: UIColor = UIColor.orange
    
    private var shadowAdded: Bool = false
    public var cornerRadius: CGFloat?
    private var shadowLayer: UIView?
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [gradientStartColor.cgColor, gradientEndColor.cgColor]
        gradient.opacity = 1.0
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradient, at: 0)
        setTitleColor(.white, for: .normal)
        if let radius = cornerRadius {
            layer.cornerRadius = radius
        }
        layer.masksToBounds = true
        applyShadow()
    }

    func applyShadow() {
        if shadowAdded {
            return
        }
        shadowAdded = true
        shadowLayer = UIView(frame: self.frame)
        shadowLayer?.backgroundColor = UIColor.clear
        shadowLayer?.layer.shadowColor = UIColor.orange.cgColor
        shadowLayer?.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        shadowLayer?.layer.shadowOffset.height = 4.0
        shadowLayer?.layer.shadowOpacity = 0.5
        shadowLayer?.layer.shadowRadius = 4
        shadowLayer?.layer.masksToBounds = true
        shadowLayer?.clipsToBounds = false
        shadowLayer?.tag = 112
        self.superview?.addSubview(shadowLayer ?? UIView())
        self.superview?.bringSubviewToFront(self)
    }
    public func removeShadow() {
        for view in self.superview?.subviews ?? [] where view.tag == 112 {
            view.removeFromSuperview()
        }
    }
}
