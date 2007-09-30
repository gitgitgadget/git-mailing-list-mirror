From: Bruno Haible <bruno@clisp.org>
Subject: suggestion for git stash
Date: Sun, 30 Sep 2007 20:50:41 +0200
Message-ID: <200709302050.41273.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 20:52:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic3ty-0006RN-Mc
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 20:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbXI3SwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 14:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbXI3SwR
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 14:52:17 -0400
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:44302 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbXI3SwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 14:52:17 -0400
Received: from mo-p07-ob.rzone.de (mrclete-mo-p07-ob.mail [192.168.63.176])
	by charnel-fb-08.store (RZmta 13.2) with ESMTP id V02e3bj8UHFRyD
	for <git@vger.kernel.org>; Sun, 30 Sep 2007 20:52:14 +0200 (MEST)
	(envelope-from: <bruno@clisp.org>)
Received: from linuix.haible.de ([81.210.217.73])
	by post.webmailer.de (mrclete mo38) (RZmta 13.2)
	with ESMTP id j05b9dj8UFdpsU ; Sun, 30 Sep 2007 20:50:39 +0200 (MEST)
	(envelope-from: <bruno@clisp.org>)
User-Agent: KMail/1.5.4
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY7QaSDm1JE
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59547>

Hi,

"git stash" has the effect of losing the distinction between untracked
changes and changes in the index.

To reproduce:
- Clone the gnulib repository or of any repository with at least 2 files.
- Make changes to two files, say, README and NEWS.
  $ git add README
- $ git status
  now reports:
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   README
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   NEWS
#

- $ git stash
- $ git stash apply
- $ git status
  now reports:
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   NEWS
#       modified:   README
#
no changes added to commit (use "git add" and/or "git commit -a")

Could "git stash" be changed to memorize which changes were already
scheduled for commit and which didn't?

Bruno
