From: Wincent Colaiuta <win@wincent.com>
Subject: HFS+ Unicode weirdness
Date: Tue, 4 Sep 2007 14:30:51 +0200
Message-ID: <052099D2-F79B-4063-82D3-BFB5D0102A55@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 14:31:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISXZC-00014E-L4
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 14:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbXIDMbb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 08:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbXIDMbb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 08:31:31 -0400
Received: from wincent.com ([72.3.236.74]:40425 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbXIDMbb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 08:31:31 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l84CVTfF002153
	for <git@vger.kernel.org>; Tue, 4 Sep 2007 07:31:30 -0500
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57557>

On a brand new clone of git.git the file "gitweb/test/M=E4rchen" is =20
provoking some weird behaviour running on Mac OS X and the toy HFS+ =20
filesystem. Note how the unmodified checkout of the file is shown as =20
"untracked" by "git st", but on deleting the file it's shown as =20
"deleted". If I build a copy of Git based on the clean working tree =20
then the resulting build has a version number of "1.5.x-dirty".

Any suggestions on where to start investigating the cause of this? =20
About the only lead I have is that if I create a file with that name =20
by typing it's name  it's encoded as "Ma\314\210rchen", but the file =20
in the git.git repo is encoded as "M\303\244rchen".

Cheers,
Wincent

$ git clone git://git.kernel.org/pub/scm/git/git.git
Initialized empty Git repository in /tmp/git/.git/
remote: Generating pack...
remote: Counting objects: 12259
Done counting 58277 objects.
remote: Deltifying 58277 objects...
remote:  100% (58277/58277) done
Indexing 58277 objects...
remote: Total 58277 (delta 40699), reused 58034 (delta 40521)
  100% (58277/58277) done
Resolving 40699 deltas...
  100% (40699/40699) done
$ cd git
/tmp/git
$ git st
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       gitweb/test/M=E4rchen
nothing added to commit but untracked files present (use "git add" to =20
track)
$ ls -laF gitweb/test
total 24
drwxr-xr-x   5 wincent  wheel  170 Sep  4 14:18 ./
drwxr-xr-x   9 wincent  wheel  306 Sep  4 14:18 ../
-rw-r--r--   1 wincent  wheel   17 Sep  4 14:18 Ma??rchen
-rw-r--r--   1 wincent  wheel   31 Sep  4 14:18 file with spaces
-rw-r--r--   1 wincent  wheel   37 Sep  4 14:18 file+plus+sign
$ rm gitweb/test/M=E4rchen
$ git st
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    gitweb/test/M=E4rchen
#
no changes added to commit (use "git add" and/or "git commit -a")