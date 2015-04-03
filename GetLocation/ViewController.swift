/*
The code uses CoreLocation Framework which reverse geocodes current location and prints the sublocality.

*/

import UIKit
import CoreLocation

//Assigning the ViewController as the delegate for CLLocationManagerDelegate

class ViewController: UIViewController , CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()   //constant for CLLocationManager
    
    /*
    For retrieving the updates we use the delegate functions of CLLocationManager namely : didUpdateLocations and
    didFailWithError.
    */
    
    
    //gets called when the new updates are accessible.
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        // location co-ordinates are passed to the function CLGeocoder().reverseGeocodeLocation
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark    //placemark is an array for location
                self.viewLocality(pm)
                
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    //gets called when it can't retrieve the updates.
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Can't Update Location " + error.localizedDescription)  //prints this error on the terminal
        
    }
    
    func viewLocality(placemark: CLPlacemark!) {
        
        locationManager.stopUpdatingLocation()
        println(placemark.subLocality)         //prints the sub locality on the terminal
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Defining the location accuracy and retrieving updates from CoreLocation
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization() // prompts for Location and shoots the alert.
        self.locationManager.startUpdatingLocation()
        
        
        
        
    }
    
    
}

