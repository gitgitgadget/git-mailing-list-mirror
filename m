From: Steve Folly <steve@spfweb.co.uk>
Subject: git stash pop not reapplying deletions
Date: Sun, 14 Feb 2010 19:45:03 +0000 (UTC)
Message-ID: <loom.20100214T200110-615@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 20:45:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgkPN-0006Gi-7y
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 20:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0BNTp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 14:45:28 -0500
Received: from lo.gmane.org ([80.91.229.12]:52052 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134Ab0BNTp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 14:45:27 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NgkPF-0006Bn-8d
	for git@vger.kernel.org; Sun, 14 Feb 2010 20:45:25 +0100
Received: from cpc1-haye16-0-0-cust629.haye.cable.virginmedia.com ([92.234.82.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 20:45:25 +0100
Received: from steve by cpc1-haye16-0-0-cust629.haye.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 20:45:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.234.82.118 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_2; en-gb) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139933>

Hi,

I'm not sure if I've found a bug in 'git stash' or if I'm using 
it the wrong way? (This is with git 1.6.6):

$ git init stashtest
$ cd stashtest
$ mkdir dira
$ touch dira/a dira/b dira/c
$ git stage dira
$ git commit -m "added dira"
$ git mv dira dirb
$ git status   # correctly shows renames

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	renamed:    dira/a -> dirb/a
#	renamed:    dira/b -> dirb/b
#	renamed:    dira/c -> dirb/c
#

$ git stash
$ git stash pop

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   dirb/a
#	new file:   dirb/b
#	new file:   dirb/c
#
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be 
committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	deleted:    dira/a
#	deleted:    dira/b
#	deleted:    dira/c
#
Dropped refs/stash@{0} (cf9efdede3a3ee8e078192b574520fd2ed7f3d9b)

It's added the new files in dirb but hasn't deleted the old files in dira. Is
this right?

Regards,
Steve
