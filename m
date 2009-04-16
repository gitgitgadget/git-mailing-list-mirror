From: William DiNoia <william.dinoia@mac.com>
Subject: git for local web development
Date: Thu, 16 Apr 2009 19:04:10 -0400
Message-ID: <135754252540163221910297561025355826788-Webmail@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 02:06:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LubaY-0007Cl-RR
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 02:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbZDQAEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 20:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755267AbZDQAET
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 20:04:19 -0400
Received: from asmtpout014.mac.com ([17.148.16.89]:58393 "EHLO
	asmtpout014.mac.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451AbZDQAET (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 20:04:19 -0400
X-Greylist: delayed 3599 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2009 20:04:19 EDT
Received: from spool003.mac.com ([10.150.69.53])
 by asmtp014.mac.com (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec
 16 2008; 32bit)) with ESMTP id <0KI700A79UQY3450@asmtp014.mac.com> for
 git@vger.kernel.org; Thu, 16 Apr 2009 16:04:10 -0700 (PDT)
Received: from webmail044 ([10.13.128.44])
 by spool003.mac.com (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec
 16 2008; 32bit)) with ESMTP id <0KI700KO7UQYBZ80@spool003.mac.com> for
 git@vger.kernel.org; Thu, 16 Apr 2009 16:04:10 -0700 (PDT)
Received: from [76.117.28.254] from webmail.me.com with HTTP; Thu,
 16 Apr 2009 19:04:10 -0400
Received: from [ 96.17.76.37] from webmail.me.com with HTTP; Thu,
 16 Apr 2009 19:04:10 -0400
X-Originating-IP: 76.117.28.254, 96.17.76.37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116720>

Hello,

I am having a bit of trouble trying to setup git for web development. I would like to have a git repository in /var/www/sites which I can clone and work on from my ~/Desktop. Working from the desktop clone, I would like to be able to git-push and have the work tree updated. It seems this is a common request as it is in the FAQ, Why won't I see changes in the remote repo after "git push"?

This is what I've done...

as www-data from /var/www/sites/

$mkdir test.com
$cd test.com
$git-init
$git-config core.worktree /var/www/sites/test.com
$vim .git/hooks/post-receive
 #!/bin/sh
 git-checkout -f
$chmod +x .git/hooks/post-receive

Then as william from /home/william/Desktop/

$git-clone /var/www/sites/test.com
$cd test.com
$vim index.html
 testing, testing, 1,2
$git-add index.html
$git-commit
$git-push origin master

Something like the following is returned, and the work tree at /var/www/sites/test.com is not updated

Counting objects: 5, done.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 277 bytes, done.
Total 3 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /var/www/sites/test.com/.git
   9b490a2..5e5cc63  master -> master
error: unable to unlink old 'index.html' (Permission denied)
error: hooks/post-receive exited with error code 1

The interesting part is that if I change to /var/www/sites/test.com and run "git-checkout -f" it updates the work tree...
Should I be using a different hook? 
Is there something wrong with the script?
Is there a better, more elegant way to achieve updating of the work tree? 
