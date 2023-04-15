//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var labelComp: UILabel!
    @IBOutlet weak var progressComp: UIProgressView!
    
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    var mins:Int = 0
    var count: Int = 0
    var timer = Timer()
    
    var progressStep:Float = 0.0
    var hardness = ""
    
    var player: AVAudioPlayer!
    @IBAction func eggButtonPressed(_ sender: UIButton) {
        hardness = sender.currentTitle!
        if (hardness == "Soft"){
            mins = softTime
        }
        if (hardness == "Medium"){
            mins = mediumTime
        }
        if (hardness == "Hard"){
            //print("\(hardTime) mins")
            mins = hardTime
        }
        
        self.resetParameters()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                                     block: { _ in self.updateCounting()
        })
    }
    
    func resetParameters(){
        if(player != nil){
            player.stop()
        }
        labelComp.text=hardness
        progressComp.progress=0
        timer.invalidate()
        count=0
    }
                                     
    func updateCounting(){
        let totalseconds = mins*1 //instead 1 should use 60
        var diff = totalseconds - count
        
        print("\(diff) seconds")
        count+=1
        progressStep = 1.0/Float(totalseconds)
        progressComp.progress=progressComp.progress+progressStep
        
        if(count == totalseconds){
            self.timer.invalidate() // invalidate the timer
            print("Timer invalidated")
            count=0
            labelComp.text = "Done"
            playSound()
        }
    }
    
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
