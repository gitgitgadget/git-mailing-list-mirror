From: William DiNoia <william.dinoia@mac.com>
Subject: git for local web development
Date: Fri, 17 Apr 2009 00:56:34 +0000 (UTC)
Message-ID: <loom.20090417T005116-449@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 03:01:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LucSe-0002Kr-OQ
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 03:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbZDQBAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 21:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbZDQBAG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 21:00:06 -0400
Received: from main.gmane.org ([80.91.229.2]:37696 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533AbZDQBAF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 21:00:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LucR0-0008QR-Mz
	for git@vger.kernel.org; Fri, 17 Apr 2009 01:00:03 +0000
Received: from c-76-117-28-254.hsd1.pa.comcast.net ([76.117.28.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 01:00:02 +0000
Received: from william.dinoia by c-76-117-28-254.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 01:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 76.117.28.254 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.7) Gecko/2009032803 Iceweasel/3.0.6 (Debian-3.0.6-1))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116723>

Hello,

I am having a bit of trouble trying to setup git for web development.
I would like to have a git repository in /var/www/sites which I can clone and
work on from my ~/Desktop. Working from the desktop clone, I would like to be
able to git-push and have the work tree updated. It seems this is a common
request as it is in the FAQ entitled, Why won't I see changes in the remote
repo after "git push"?

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

Something like the following is returned, and the work tree at
/var/www/sites/test.com is not updated

Counting objects: 5, done.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 277 bytes, done.
Total 3 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /var/www/sites/test.com/.git
   9b490a2..5e5cc63  master -> master
error: unable to unlink old 'index.html' (Permission denied)
error: hooks/post-receive exited with error code 1

The interesting part is that if I change to /var/www/sites/test.com and run
"git-checkout -f" it updates the work tree...
Should I be using a different hook? 
