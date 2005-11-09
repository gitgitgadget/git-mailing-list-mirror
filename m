From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: succesfull use of git-shell
Date: Wed, 9 Nov 2005 21:52:07 +0000
Message-ID: <200511092152.07195.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 09 22:54:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZxrd-0006Ko-M6
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 22:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161255AbVKIVwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 16:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbVKIVwJ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 16:52:09 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:46209
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1161253AbVKIVwH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 16:52:07 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EZxrS-0001xN-BN
	for git@vger.kernel.org; Wed, 09 Nov 2005 21:52:06 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11417>

I just wanted to give a heads-up on a successful set up and push to a 
repository where the account accessing the repository runs git-shell.

It turned out to be extremely simple to do - but the documentation that I 
could find is so terse in places that I wasn't sure it was going to work 
until I tried it.  Two main issues.

1) the man page for git-push describes <repository> as

remote.machine:/path/to/repo.git/

the tutorial isn't much help either as it says

git push <public-host>:/path/to/my-git.git master

whereas I knew I wanted to access an account that was different from mine

2) the directory paths are always specified as absolute in the documentation, 
but (particularly if you are going to set up a public repository which 
several people may be pushing to) its helpful not to know exactly which path 
on the server the repository exists.


In my setup I did the following simple things 

1) created an account called git with a home directory at /var/lib/git and a 
shell of /usr/local/bin/git-shell (you can see where my git is installed) on 
my server (called roo.home)

2) created a an empty repository at /var/lib/git/famtree.git 

a) Logged in as root into the machine that was the server
b) Became a git user with 

su -s /bin/bash git

(You can't do a normal su git because the default shell immediately throws you 
straight out again)
c) mkdir famtree.git; GIT_DIR=famtree.git git-init-db
d) chmod +x famtree.git/hooks/post-update
(planning to allow http anonymous access)

3) back on my development machine - pushed the master branch of my current 
repository out to the new one just created with

git-push git@roo.home:famtree.git

It is this last simple command line that I _really_ like.  If I wanted to set 
up some form of centralised development with multiple access to the 
repository, I only have to append the public keys of those people into the 
authorized_keys file on that account on the server and I am done.



 

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
