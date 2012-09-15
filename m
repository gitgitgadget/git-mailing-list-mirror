From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 1/3] rebase -i: Refactor help messages for todo file
Date: Sat, 15 Sep 2012 16:08:27 -0400
Message-ID: <1347739709-15289-2-git-send-email-andrew.kw.w@gmail.com>
References: <CADgNjambUXj+WEFg=OWvtDQ1EKFhavwbjMbTVaP69rhh5DrphA@mail.gmail.com>
 <1347739709-15289-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 23:10:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCzde-0004gH-Kt
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab2IOVJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:09:59 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32836 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab2IOVJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:09:47 -0400
Received: by iahk25 with SMTP id k25so4417635iah.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hZZpBoKj2SQqqkz5kI0fLwSznchQZVwSPktPcdC8ooU=;
        b=O/TYQUZEI6bewVgwBLzB6iZW1Z13emiccdtTN0XSGjlZ/o021s+ynxGnApwF+e604C
         Q8kdSnlQvtkgZBBbSB/u9Vb0PhPT8QKKOHwsONoRAfXnerM37VVFXKIAhTo/dD4OD46t
         sICBXPNAXY0Sb+bkykVO19axkKWQxK1O2Jw3AOpPO6A40+pGEsYuXFYVW+7j/A3fCWq8
         Hsdzak27BIZudj5k2ooa9gmEj0dzVjHYxJMwL5MpxAMKp+XVXyP+g6zm2mKpNR5T267o
         gE0LwfUxkMjXLErKwOu0dJub1LQz9rg+VLOKWteBzzTonoMj82m7+GrFgsuEXJo/OFoY
         Tg0w==
Received: by 10.50.158.169 with SMTP id wv9mr2909143igb.25.1347743385580;
        Sat, 15 Sep 2012 14:09:45 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id d19sm2172495igp.6.2012.09.15.14.09.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 14:09:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g08bf5ad.dirty
In-Reply-To: <1347739709-15289-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205570>

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
1.7.12.318.g08bf5ad.dirty
