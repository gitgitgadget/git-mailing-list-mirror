From: Gerrit Pape <pape@smarden.org>
Subject: merge doesn't remove files
Date: Sat, 3 Feb 2007 22:48:19 +0000
Message-ID: <20070203224819.20131.qmail@b1b53206edee41.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 23:48:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDTfw-0000Kg-Hb
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 23:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbXBCWr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 17:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbXBCWr7
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 17:47:59 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:58280 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1751802AbXBCWr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 17:47:59 -0500
Received: (qmail 20132 invoked by uid 1000); 3 Feb 2007 22:48:19 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38617>

Hi, please see http://bugs.debian.org/403104

Shouldn't git remove the original file after merging a commit that moved
the file away?  Here's a simple test case:

$ mkdir repo && cd repo
$ git init-db
defaulting to local storage area
$ echo a >foo && git add foo
$ git commit -a -m'add foo'
Committing initial tree 86de5e13286a8449a8a706a58e63be6781770b12
$ git branch b  
$ git mv foo bar
$ git commit -a -m'move foo'
$ git checkout b
$ echo ttt >>foo
$ git commit -a -m'change foo'
$ git pull . master
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with adc07a8eac73cdb1cb3764ec50747556ed2abc99
Merging:
92eff19 change foo
adc07a8 move foo
found 1 common ancestor(s):
ba043e5 add foo
Merge made by recursive.
 foo => bar |    0 
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename foo => bar (100%)
$ git status
# On branch refs/heads/b
# Untracked files:
#   (use "git add" to add to commit)
#
#       foo
nothing to commit
$ ls
bar  foo
$ 

Thanks, Gerrit.
