From: Shantanu Pavgi <pavgi@uab.edu>
Subject: Re: git access using SSL certificates
Date: Mon, 28 Jun 2010 15:23:30 -0500
Message-ID: <16FCDB06-9C82-4CBF-BD25-A10BD3E829DE@uab.edu>
References: <CB7586D8-2C18-4BE9-9B32-3D02AA5F37ED@uab.edu>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 28 22:23:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTKri-0003ji-Rj
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 22:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab0F1UXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 16:23:32 -0400
Received: from uabexht2.ad.uab.edu ([138.26.5.102]:31887 "EHLO
	UABEXHT2.ad.uab.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab0F1UXc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 16:23:32 -0400
Received: from [10.0.0.23] (138.26.125.8) by relay.ad.uab.edu (138.26.5.102)
 with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 28 Jun 2010 15:23:30
 -0500
In-Reply-To: <CB7586D8-2C18-4BE9-9B32-3D02AA5F37ED@uab.edu>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149856>


Forgot to mention version info in my earlier email: 
Server/Public repo: CentOS 5.4 with Git 1.7.1 installed from source 
Client in earlier mail: Mac OS X 10.6 Git 1.6.5.2 

On Mac  git-push: 
{{{
mercury:fifa2010 shantanu$ git push --verbose
Pushing to https://condor-node2.lab.ac.uab.edu/git/fifa2010
error: Cannot access URL https://condor-node2.lab.ac.uab.edu/git/fifa2010/, return code 52
error: failed to push some refs to 'https://condor-node2.lab.ac.uab.edu/git/fifa2010'
}}}

On Debian with Git 1.5.6.5:
git-push
{{{
atlab@debian:~/fifa2010$ git push
error: Cannot access URL https://condor-node2.lab.ac.uab.edu/git/fifa2010/, return code 52
error: failed to push some refs to 'https://condor-node2.lab.ac.uab.edu/git/fifa2010'
}}}

On Debian with Git 1.5.6.5: 
git-pull 
{{{
atlab@debian:~/fifa2010$ git pull origin master
error: GnuTLS recv error (-12): A TLS fatal alert has been received.
fatal: Couldn't find remote ref master
}}}

It works on the same server system (CentOS 5.4 Git 1.7.1) using SSL certificates though.   

Any help/suggestions?  

--
Thanks,
Shantanu. 
 

On Jun 28, 2010, at 9:54 AM, Shantanu Pavgi wrote:

> 
> Hi,
> 
> I have configured a bare Git repository over HTTPS and client needs to have a SSL certificate-key to access the repository. I am able to access this repository using Firefox by loading client certificate in the Firefox, but it is not working with git command line client. 
> 
> I tried setting http.sslCert and http.sslKey configuration options, but it is not working. Following were steps in accessing the repository. Am I missing something in my configuration? Any pointers on how to share git using SSL certificates would be really helpful. 
> 
> Thanks,
> Shantanu. 
> 
> 
> * Try git-clone using HTTPS without client certs 
> {{{
> mercury:tempgit-ssh2 shantanu$ git clone https://condor-node2.lab.ac.uab.edu/git/fifa2010 --verbose
> Initialized empty Git repository in /Users/shantanu/tempgit-ssh2/fifa2010/.git/
> error: Empty reply from server while accessing https://condor-node2.lab.ac.uab.edu/git/fifa2010/info/refs
> 
> fatal: HTTP request failed
> }}}
> 
> * Try git-clone using ssh
> {{{
> mercury:tempgit-ssh2 shantanu$ git clone ssh://ssp@condor-node2.lab.ac.uab.edu/srv/gitpubrepos/fifa2010 --verbose
> Initialized empty Git repository in /Users/shantanu/tempgit-ssh2/fifa2010/.git/
> ssp@condor-node2.lab.ac.uab.edu's password: 
> remote: Counting objects: 7, done.
> remote: Compressing objects: 100% (4/4), done.
> remote: Total 7 (delta 0), reused 0 (delta 0)
> Receiving objects: 100% (7/7), done.
> }}}
> 
> * Change git remote url 
> {{{
> mercury:fifa2010 shantanu$ git remote rm origin
> mercury:fifa2010 shantanu$ git remote add origin https://condor-node2.lab.ac.uab.edu/git/fifa2010 
> }}}
> 
> * Try git-pull with HTTPS without certs 
> {{{
> mercury:fifa2010 shantanu$ git pull
> error: Empty reply from server while accessing https://condor-node2.lab.ac.uab.edu/git/fifa2010/info/refs
> 
> fatal: HTTP request failed
> }}}
> 
> * Try git-pull using certificates 
> {{{
> mercury:fifa2010 shantanu$ git config http.sslCert ~/Desktop/certs/usercerts/bob-svn/ssp.crt 
> mercury:fifa2010 shantanu$ git config http.sslKey ~/Desktop/certs/usercerts/bob-svn/ssp.key 
> mercury:fifa2010 shantanu$ git pull
> error: Empty reply from server while accessing https://condor-node2.lab.ac.uab.edu/git/fifa2010/info/refs
> 
> fatal: HTTP request failed
> }}}
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
