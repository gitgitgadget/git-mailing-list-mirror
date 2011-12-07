From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/15] t3310 (notes-merge-manual-resolve): fix && chaining
Date: Thu,  8 Dec 2011 01:06:47 +0530
Message-ID: <1323286611-4806-12-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNKJ-0001Jr-8v
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549Ab1LGTij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:39 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48222 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab1LGTih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:37 -0500
Received: by mail-qy0-f174.google.com with SMTP id z2so701321qcq.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lwG2oN1Va1Rj0sQfsw6VJaqCFUkkql2T6zk0e9EUNkw=;
        b=PIJdIqQu3wtL3AXnlqxKGgpgoTbZuATTu+8FnF5zNt6KKhseHHPzdhnGlD3GlOaycm
         Ks6U9lZSAkN4k2wig94v832mPzCpRh+1afQu7m1evv9WOCuefZMPbWms83717bibiMWg
         T5c0FA2Pa5dgK9e4M3zijMM1CPwpydDQo9TrY=
Received: by 10.50.12.227 with SMTP id b3mr277721igc.24.1323286717454;
        Wed, 07 Dec 2011 11:38:37 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:36 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186493>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3310-notes-merge-manual-resolve.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 4ec4d11..4367197 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -389,7 +389,7 @@ test_expect_success 'abort notes merge' '
 	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# m has not moved (still == y)
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
@@ -525,9 +525,9 @@ EOF
 	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
 	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
 	# Refs are unchanged
-	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
-	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)"
-	test "$(git rev-parse refs/notes/m)" != "$(git rev-parse NOTES_MERGE_PARTIAL^1)"
+	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
+	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
+	test "$(git rev-parse refs/notes/m)" != "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
 	# Mention refs/notes/m, and its current and expected value in output
 	grep -q "refs/notes/m" output &&
 	grep -q "$(git rev-parse refs/notes/m)" output &&
@@ -545,7 +545,7 @@ test_expect_success 'resolve situation by aborting the notes merge' '
 	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# m has not moved (still == w)
-	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
+	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
-- 
1.7.7.3
