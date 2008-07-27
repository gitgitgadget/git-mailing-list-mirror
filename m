From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH] Documentation: clarify diff.external limitations
Date: Sun, 27 Jul 2008 13:12:15 +0200
Message-ID: <1217157135-25090-1-git-send-email-mail@cup.kalibalik.dk>
Cc: gitster@pobox.com, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 27 13:13:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN4Bj-0006oe-HY
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 13:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbYG0LMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 07:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbYG0LMS
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 07:12:18 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:36022 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbYG0LMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 07:12:17 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 76DCA14062;
	Sun, 27 Jul 2008 13:12:14 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 4545C1405A;
	Sun, 27 Jul 2008 13:12:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90329>

The diff.external examples pass a flag to gnu-diff, but that is not
actually supported.

Without the flag, diff will still complain about an extra operand
because git is passing 7 parameters to the external command.

Both of these are fixed by suggesting a diff-wrapper and pointing to
the description of the parameters passed.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 Documentation/config.txt     |   10 ++++++----
 Documentation/git-config.txt |    2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 798b551..1a13abc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -92,7 +92,7 @@ Example
 
 	# Our diff algorithm
 	[diff]
-		external = "/usr/local/bin/gnu-diff -u"
+		external = /usr/local/bin/diff-wrapper
 		renames = true
 
 	[branch "devel"]
@@ -563,9 +563,11 @@ diff.autorefreshindex::
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
-	given command.  Note: if you want to use an external diff
-	program only on a subset of your files, you might want to
-	use linkgit:gitattributes[5] instead.
+	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF'
+	environment variable.  The command is called with parameters
+	as described under "git Diffs" in linkgit:git[1].  Note: if
+	you want to use an external diff program only on a subset of
+	your files, you	might want to use linkgit:gitattributes[5] instead.
 
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 697824c..28e1861 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -222,7 +222,7 @@ Given a .git/config like this:
 
 	; Our diff algorithm
 	[diff]
-		external = "/usr/local/bin/gnu-diff -u"
+		external = /usr/local/bin/diff-wrapper
 		renames = true
 
 	; Proxy settings
-- 
1.5.4.3
