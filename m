From: Daniel Mierswa <impulze@impulze.org>
Subject: whitespace ignoring during diff -M
Date: Sun, 31 May 2009 22:28:50 +0200
Message-ID: <4A22E882.8020500@impulze.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 22:34:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MArjL-0005yF-4F
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 22:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbZEaUd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 16:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbZEaUd4
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 16:33:56 -0400
Received: from eta-ori.net ([91.121.142.51]:47976 "EHLO orion.eta-ori.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239AbZEaUdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 16:33:55 -0400
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 May 2009 16:33:55 EDT
Received: by orion.eta-ori.net (Postfix, from userid 1006)
	id 0EF1648CEDE; Sun, 31 May 2009 22:23:38 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr0 (2008-06-10) on
	orion.eta-ori.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=8.0 tests=NO_RELAYS autolearn=ham
	version=3.2.5-gr0
Received: from [IPv6:2a01:198:229:0:217:31ff:fe81:8c8] (istari.fallback.kleinerfeigling.org [IPv6:2a01:198:229:0:217:31ff:fe81:8c8])
	by orion.eta-ori.net (Postfix) with ESMTPSA id 93D3048CED3
	for <git@vger.kernel.org>; Sun, 31 May 2009 22:23:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090522)
X-Enigmail-Version: 0.95.7
OpenPGP: id=ADF32F97
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120431>

Hi list,
I was told to try it here after visiting #git/Freenode
I want git to think that the diff of two branches where filenames and
whitespace amount differ are the same.
The following is a snippet from my terminal with output, is there a
chance to make git think that those are equal?

impulze@istari ~/gittest $ git init
Initialized empty Git repository in /home/impulze/gittest/.git/
impulze@istari ~/gittest $ touch initial
impulze@istari ~/gittest $ git add initial && git commit initial -m
'initial commit'
[master (root-commit) 7b67dcd] initial commit
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 initial
impulze@istari ~/gittest $ git checkout -b another
Switched to a new branch 'another'
impulze@istari ~/gittest $ echo -e "   abcdef   \n   ghijkl " > file.cc
impulze@istari ~/gittest $ unix2dos -a -u file.cc
impulze@istari ~/gittest $ git add file.cc && git commit file.cc -m
'another commit'
[another 37826f4] another commit
 1 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 file.cc
impulze@istari ~/gittest $ git checkout master
Switched to branch 'master'
impulze@istari ~/gittest $ echo -e "\t\tabcdef\t\n\tghijkl\t" > file.c
impulze@istari ~/gittest $ git add file.c && git commit file.c -m
'master commit'
[master f9f0ac5] master commit
 1 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 file.c
impulze@istari ~/gittest $ git --no-pager diff another -M -w
diff --git a/file.c b/file.c
new file mode 100644
index 0000000..18364be
--- /dev/null
+++ b/file.c
@@ -0,0 +1,2 @@
+               abcdef
+       ghijkl
diff --git a/file.cc b/file.cc
deleted file mode 100644
index 1a303ea..0000000
--- a/file.cc
+++ /dev/null
@@ -1,2 +0,0 @@
-   abcdef
-   ghijkl


-- 
Mierswa, Daniel

If you still don't like it, that's ok: that's why I'm boss. I simply
know better than you do.
               --- Linus Torvalds, comp.os.linux.advocacy, 1996/07/22
