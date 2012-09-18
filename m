From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 2/4] rebase -i: Refactor help messages for todo file
Date: Mon, 17 Sep 2012 21:28:08 -0400
Message-ID: <1347931690-20625-3-git-send-email-andrew.kw.w@gmail.com>
References: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com>
 <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 04:29:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDnZT-0002lx-5Y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 04:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374Ab2IRC3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 22:29:37 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:33129 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab2IRC3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 22:29:35 -0400
Received: by mail-gh0-f174.google.com with SMTP id g15so1696524ghb.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 19:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=A/mfYqSXJ72zjoSATEn9Of/utBDJFQdAFzno5yr+TwQ=;
        b=bY2P4/FtuKtzgFHQv9AlDMN+WEFf5bd3bQ9ummjc/NRzP4gM7HSReXX8bb+h4RJ8jk
         jmA9JhVisxsoP5PCTmPfcgK+sHeW/gide1V/mKuM/6OPDlks/D/2tXR+2luoL9bxjYJj
         qVWpb3splsYcMw4M7xZk98gN5koK+t3GtRQrAxulBOPwfgb3dg/MnTG2Mnt99poAagzO
         DJb9mbaosXAUPOy8BUNN4o0eVwCrOc0woeitecwKTH0puzVHXJ2ki0Ayx5BIv1mCSZj1
         hH59vYPkoINf1H46EkciQbJbvaG+6XP0DcSEITgzAHQVxKC0lGSNPAZlWuk9cooG2EGu
         sIyA==
Received: by 10.236.103.194 with SMTP id f42mr13599984yhg.94.1347935375163;
        Mon, 17 Sep 2012 19:29:35 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id s12sm11226868anh.2.2012.09.17.19.29.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 19:29:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g79683ba.dirty
In-Reply-To: <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205781>

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
