//
//  ViewController.swift
//  Calculator
//
//  Created by 唐铭良 on 2018/1/19.
//  Copyright © 2018年 唐铭良. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var inputflag  = false
    @IBAction func append(_ sender: UIButton)
    {
        
        let digit = sender.currentTitle!
        if inputflag{
            display.text=display.text!+digit
        }
        else{
            display.text=digit
            inputflag = true
        }
    }
    var displayvalue:Double{
        get{
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set{
            display.text="\(newValue)"
            inputflag = false
        }
    }
    var opstack  = Array<Double>()
    @IBAction func enter() {
        inputflag  = false
        opstack.append(displayvalue)
        print("op=\(opstack)")
    }
    //op：
    func performop (operation1:(Double,Double)->Double){
        if opstack.count>=2{
            displayvalue=operation1(opstack.removeLast(),opstack.removeLast())
            enter()}
    }
    func performop (operation1:(Double)->Double){
        if opstack.count>=1{
            displayvalue=operation1(opstack.removeLast())
            enter()}
    }
    @IBAction func ope(_ sender: UIButton) {
        let operation=sender.currentTitle!
        if inputflag{
            enter()
        }
        switch operation {
        case "✖️":performop(operation1: {$0*$1})
        case "➗":performop(operation1: { (op1, op2) in
            op2/op1
        })
        case "➕":performop(operation1: { (op1, op2) -> Double in
            op1+op2
        })
        case "➖":performop(operation1: { (op1:Double, op2:Double) -> Double in
            op2-op1
        })
        case "√":performop(operation1: { sqrt($0)})
        default:
            break
        }
        
        
    }
    
    
    
}

