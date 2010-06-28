From: Shantanu Pavgi <pavgi@uab.edu>
Subject: git access using SSL certificates
Date: Mon, 28 Jun 2010 09:54:44 -0500
Message-ID: <CB7586D8-2C18-4BE9-9B32-3D02AA5F37ED@uab.edu>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 28 17:00:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTFoo-000210-Vz
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 17:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681Ab0F1PAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 11:00:12 -0400
Received: from uabexht3.ad.uab.edu ([138.26.5.103]:57111 "EHLO
	UABEXHT3.ad.uab.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab0F1PAL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 11:00:11 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jun 2010 11:00:11 EDT
Received: from [10.0.0.23] (138.26.125.8) by relay.ad.uab.edu (138.26.5.103)
 with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 28 Jun 2010 09:54:45
 -0500
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149831>


Hi,

I have configured a bare Git repository over HTTPS and client needs to have a SSL certificate-key to access the repository. I am able to access this repository using Firefox by loading client certificate in the Firefox, but it is not working with git command line client. 

I tried setting http.sslCert and http.sslKey configuration options, but it is not working. Following were steps in accessing the repository. Am I missing something in my configuration? Any pointers on how to share git using SSL certificates would be really helpful. 

Thanks,
Shantanu. 


* Try git-clone using HTTPS without client certs 
{{{
mercury:tempgit-ssh2 shantanu$ git clone https://condor-node2.lab.ac.uab.edu/git/fifa2010 --verbose
Initialized empty Git repository in /Users/shantanu/tempgit-ssh2/fifa2010/.git/
error: Empty reply from server while accessing https://condor-node2.lab.ac.uab.edu/git/fifa2010/info/refs

fatal: HTTP request failed
}}}

* Try git-clone using ssh
{{{
mercury:tempgit-ssh2 shantanu$ git clone ssh://ssp@condor-node2.lab.ac.uab.edu/srv/gitpubrepos/fifa2010 --verbose
Initialized empty Git repository in /Users/shantanu/tempgit-ssh2/fifa2010/.git/
ssp@condor-node2.lab.ac.uab.edu's password: 
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 7 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (7/7), done.
}}}

* Change git remote url 
{{{
mercury:fifa2010 shantanu$ git remote rm origin
mercury:fifa2010 shantanu$ git remote add origin https://condor-node2.lab.ac.uab.edu/git/fifa2010 
}}}

* Try git-pull with HTTPS without certs 
{{{
mercury:fifa2010 shantanu$ git pull
error: Empty reply from server while accessing https://condor-node2.lab.ac.uab.edu/git/fifa2010/info/refs

fatal: HTTP request failed
}}}

* Try git-pull using certificates 
{{{
mercury:fifa2010 shantanu$ git config http.sslCert ~/Desktop/certs/usercerts/bob-svn/ssp.crt 
mercury:fifa2010 shantanu$ git config http.sslKey ~/Desktop/certs/usercerts/bob-svn/ssp.key 
mercury:fifa2010 shantanu$ git pull
error: Empty reply from server while accessing https://condor-node2.lab.ac.uab.edu/git/fifa2010/info/refs

fatal: HTTP request failed
}}}
