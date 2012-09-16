From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH v2 1/3] rebase -i: Refactor help messages for todo file
Date: Sun, 16 Sep 2012 11:17:01 -0400
Message-ID: <1347808623-1058-1-git-send-email-andrew.kw.w@gmail.com>
References: <7vwqzuxxmp.fsf@alter.siamese.dyndns.org>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 18:19:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDHZ2-0005oH-Hi
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 18:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab2IPQTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 12:19:11 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:32881 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab2IPQTK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 12:19:10 -0400
Received: by qcro28 with SMTP id o28so3947818qcr.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=A/mfYqSXJ72zjoSATEn9Of/utBDJFQdAFzno5yr+TwQ=;
        b=DLk/NXzOfZnIE5jPYR4ThX8zKZmAer5bjI9wvJfVQZ40Gmv5M3D/QNqwUe3Wa99PPR
         Z/HfQr7Qb7iX2aeD1HQAzymKRxfIT57wc1r27QDrmMH025scBYLu80N1CEQPZ+9BhTtj
         olJDUohejNUF0Y5k5EpJMQdqr03h/PYcLnXNIf4Ye5wTQj+m9AUMVSicp+0hVaQADCw6
         lXPFbAawKvVBjpp87ae3HJTRWQbn/TEX+1+zebVYDCjocqUGgM2WuiEKXnEE5f/Lf7eT
         WUr2+qSEvwz5U2ZVJ/xt1bpj/RBL9yX4JGlN7q1PbgM/wSlsJKO0rpgKDAszrTfKUTe/
         B4vA==
Received: by 10.224.212.3 with SMTP id gq3mr20074002qab.52.1347812349336;
        Sun, 16 Sep 2012 09:19:09 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id ha5sm11433393qab.1.2012.09.16.09.19.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 09:19:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g79683ba.dirty
In-Reply-To: <7vwqzuxxmp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205627>

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--interactive.sh | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a09e842..4d57e50 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -115,6 +115,23 @@ mark_action_done () {
 	fi
 }
 
+append_todo_help () {
+	cat >> "$todo" << EOF
+#
+# Commands:
+#  p, pick = use commit
+#  r, reword = use commit, but edit the commit message
+#  e, edit = use commit, but stop for amending
+#  s, squash = use commit, but meld into previous commit
+#  f, fixup = like "squash", but discard this commit's log message
+#  x, exec = run command (the rest of the line) using shell
+#
+# These lines can be re-ordered; they are executed from top to bottom.
+#
+# If you remove a line here THAT COMMIT WILL BE LOST.
+EOF
+}
+
 make_patch () {
 	sha1_and_parents="$(git rev-list --parents -1 "$1")"
 	case "$sha1_and_parents" in
@@ -901,18 +918,10 @@ test -n "$cmd" && add_exec_commands "$todo"
 cat >> "$todo" << EOF
 
 # Rebase $shortrevisions onto $shortonto
+EOF
+append_todo_help
+cat >> "$todo" << EOF
 #
-# Commands:
-#  p, pick = use commit
-#  r, reword = use commit, but edit the commit message
-#  e, edit = use commit, but stop for amending
-#  s, squash = use commit, but meld into previous commit
-#  f, fixup = like "squash", but discard this commit's log message
-#  x, exec = run command (the rest of the line) using shell
-#
-# These lines can be re-ordered; they are executed from top to bottom.
-#
-# If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
 #
 EOF
-- 
1.7.12.318.g79683ba.dirty
