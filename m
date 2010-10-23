From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 01/10] Better "Changed but not updated" message in git-status
Date: Sat, 23 Oct 2010 18:31:12 +0200
Message-ID: <1287851481-27952-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 23 18:32:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9h1e-0005n2-24
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 18:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952Ab0JWQcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 12:32:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51627 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757923Ab0JWQcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 12:32:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9NGPAmX027282
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 23 Oct 2010 18:25:10 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P9h09-0006cE-U9; Sat, 23 Oct 2010 18:31:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P9h09-0007He-Rs; Sat, 23 Oct 2010 18:31:25 +0200
X-Mailer: git-send-email 1.7.3.2.537.g7e355
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 23 Oct 2010 18:25:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9NGPAmX027282
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1288455914.1509@aBgJgA6OjsJXYJa5h3dCvA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159795>

Older Gits talked about "updating" a file to add its content to the
index, but this terminology is confusing for new users. "to stage" is far
more intuitive and already used in e.g. the "git stage" command name.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/gittutorial-2.txt |    2 +-
 t/t7508-status.sh               |   34 +++++++++++++++++-----------------
 wt-status.c                     |    2 +-
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index ecab0c0..9b17a71 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -373,7 +373,7 @@ $ git status
 #
 #       new file: closing.txt
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #
 #       modified: file.txt
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c9300f3..bfb47a2 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -44,7 +44,7 @@ cat >expect <<\EOF
 #
 #	new file:   dir2/added
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -73,7 +73,7 @@ cat >expect <<\EOF
 # Changes to be committed:
 #	new file:   dir2/added
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #	modified:   dir1/modified
 #
 # Untracked files:
@@ -140,7 +140,7 @@ cat >expect <<EOF
 #
 #	new file:   dir2/added
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -167,7 +167,7 @@ cat >expect <<EOF
 # Changes to be committed:
 #	new file:   dir2/added
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #	modified:   dir1/modified
 #
 # Untracked files not listed
@@ -202,7 +202,7 @@ cat >expect <<EOF
 #
 #	new file:   dir2/added
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -260,7 +260,7 @@ cat >expect <<EOF
 #
 #	new file:   dir2/added
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -320,7 +320,7 @@ cat >expect <<\EOF
 #
 #	new file:   ../dir2/added
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -392,7 +392,7 @@ cat >expect <<\EOF
 #
 #	<GREEN>new file:   dir2/added<RESET>
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -521,7 +521,7 @@ cat >expect <<\EOF
 #
 #	new file:   dir2/added
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -614,7 +614,7 @@ cat >expect <<EOF
 #	new file:   dir2/added
 #	new file:   sm
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -673,7 +673,7 @@ cat >expect <<EOF
 #	new file:   dir2/added
 #	new file:   sm
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -718,7 +718,7 @@ test_expect_success 'status -s submodule summary' '
 
 cat >expect <<EOF
 # On branch master
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -766,7 +766,7 @@ cat >expect <<EOF
 #	new file:   dir2/added
 #	new file:   sm
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -819,7 +819,7 @@ cat > expect << EOF
 #
 #	modified:   sm
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -931,7 +931,7 @@ cat > expect << EOF
 #
 #	modified:   sm
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #   (commit or discard the untracked or modified content in submodules)
@@ -989,7 +989,7 @@ cat > expect << EOF
 #
 #	modified:   sm
 #
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
@@ -1067,7 +1067,7 @@ test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary
 
 cat > expect << EOF
 # On branch master
-# Changed but not updated:
+# Changed but not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
diff --git a/wt-status.c b/wt-status.c
index fc2438f..afb3c78 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -88,7 +88,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	color_fprintf_ln(s->fp, c, "# Changed but not updated:");
+	color_fprintf_ln(s->fp, c, "# Changed but not staged for commit:");
 	if (!advice_status_hints)
 		return;
 	if (!has_deleted)
-- 
1.7.3.2.537.g7e355
