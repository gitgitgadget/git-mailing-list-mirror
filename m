From: Gabor Gombas <gombasg@digikabel.hu>
Subject: git ls-files unreliable?
Date: Fri, 2 Apr 2010 20:08:43 +0200
Message-ID: <20100402180842.GA5798@twister.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 20:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxm51-00033N-35
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 20:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022Ab0DBS6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 14:58:51 -0400
Received: from relay01.digicable.hu ([92.249.128.189]:50856 "EHLO
	relay01.digicable.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab0DBS6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 14:58:50 -0400
X-Greylist: delayed 3004 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Apr 2010 14:58:49 EDT
Received: from [94.21.150.117] (helo=twister.home)
	by relay01.digicable.hu with esmtpa
	id 1NxlIR-00087e-LP for <git@vger.kernel.org>; Fri, 02 Apr 2010 20:08:43 +0200
Received: by twister.home (Postfix, from userid 1000)
	id 32E886C01; Fri,  2 Apr 2010 20:08:43 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Original: 94.21.150.117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143835>

Hi,

I want to verify from a script that the working directory is clean. Some
time ago Linus suggested to use "git diff --quiet --cached" followed by
"git ls-files --exclude-standard -o -d -m -u". But:

$ git status
# On branch git_workdir_check
# Your branch is ahead of 'origin/master' by 1 commit.
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   ../../../test
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
#   directory)
#
#       modified:   ../../../test
#
$ git ls-files --exclude-standard -o -d -m -u
$ echo $?
0

So there _were_ uncommitted changes, "git status" showed them, but "git
ls-files" did not. Unstaging the staged changes did not help, changing a
different file did not help. Tried git versions 1.5.4.2 and 1.7.0-rc2,
both showed the same behavior.

When I did a "commit" and changed a file after that, then ls-files
started to take notice. I don't know how to reproduce the state shown
above. But this means that I cannot rely on "git ls-files" to check if
the working directory is clean; so what should I use instead?
Restriction: any solutions must work with git versions as old as 1.5.4.

Gabor
