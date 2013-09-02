From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] t: rev-parse-parents: fix style
Date: Mon,  2 Sep 2013 01:30:36 -0500
Message-ID: <1378103439-3225-2-git-send-email-felipe.contreras@gmail.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 08:35:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNjZ-0003jJ-Mw
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484Ab3IBGf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:35:26 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:60781 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab3IBGfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:35:25 -0400
Received: by mail-oa0-f44.google.com with SMTP id l17so4846832oag.31
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 23:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X1SB2JdltDR4Kb445OQIpvFqKsCtq2w8bgbzG5uGdYQ=;
        b=Z7iu8MVAxT/wAGhmu+YqfAYQUeTTOmE5VVgk73TiATERrN6epRgdrrhyDykbpCsxiY
         /lI5DsxdwcicTUQ12yGP2bidwNfFJiOh+LiWjwUu4ZI3FHXhEpySXunw08HvlmQ6zY1E
         VBaAI+MDIbyiGrabDqKrJ23KPbo0nLlRkQaU0GDCxRjoWvAauE9eK/M+EWBpWat1kmwL
         atyPXknG8tVEVyNi8nkbf5EbDB3tWKGxAnhC70vyOaMYQAzjjveoIf2f11Xt4AQ31+b0
         DKB7VuQkcHQF4ihYxqtgBAw5UmO+p4SwYs6cWHsB1DFqx7elzMGA9K9vb+Z8cZ+DFtSh
         Iuhg==
X-Received: by 10.182.144.136 with SMTP id sm8mr15862628obb.63.1378103725145;
        Sun, 01 Sep 2013 23:35:25 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm11966126obc.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 23:35:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233611>

Pretty much all the tests follow a different style.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t6101-rev-parse-parents.sh | 74 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index e673c25..bead4d7 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -17,21 +17,62 @@ hide_error save_tag start2 unique_commit "start2" tree
 save_tag two_parents unique_commit "next" tree -p second -p start2
 save_tag final unique_commit "final" tree -p two_parents
 
-test_expect_success 'start is valid' 'git rev-parse start | grep "^[0-9a-f]\{40\}$"'
-test_expect_success 'start^0' "test $(cat .git/refs/tags/start) = $(git rev-parse start^0)"
-test_expect_success 'start^1 not valid' "if git rev-parse --verify start^1; then false; else :; fi"
-test_expect_success 'second^1 = second^' "test $(git rev-parse second^1) = $(git rev-parse second^)"
-test_expect_success 'final^1^1^1' "test $(git rev-parse start) = $(git rev-parse final^1^1^1)"
-test_expect_success 'final^1^1^1 = final^^^' "test $(git rev-parse final^1^1^1) = $(git rev-parse final^^^)"
-test_expect_success 'final^1^2' "test $(git rev-parse start2) = $(git rev-parse final^1^2)"
-test_expect_success 'final^1^2 != final^1^1' "test $(git rev-parse final^1^2) != $(git rev-parse final^1^1)"
-test_expect_success 'final^1^3 not valid' "if git rev-parse --verify final^1^3; then false; else :; fi"
-test_expect_success '--verify start2^1' 'test_must_fail git rev-parse --verify start2^1'
-test_expect_success '--verify start2^0' 'git rev-parse --verify start2^0'
-test_expect_success 'final^1^@ = final^1^1 final^1^2' "test \"$(git rev-parse final^1^@)\" = \"$(git rev-parse final^1^1 final^1^2)\""
-test_expect_success 'final^1^! = final^1 ^final^1^1 ^final^1^2' "test \"$(git rev-parse final^1^\!)\" = \"$(git rev-parse final^1 ^final^1^1 ^final^1^2)\""
-
-test_expect_success 'repack for next test' 'git repack -a -d'
+test_expect_success 'start is valid' '
+	git rev-parse start | grep "^[0-9a-f]\{40\}$"
+'
+
+test_expect_success 'start^0' '
+	test $(cat .git/refs/tags/start) = $(git rev-parse start^0)
+'
+
+test_expect_success 'start^1 not valid' '
+	if git rev-parse --verify start^1; then false; else :; fi
+'
+
+test_expect_success 'second^1 = second^' '
+	test $(git rev-parse second^1) = $(git rev-parse second^)
+'
+
+test_expect_success 'final^1^1^1' '
+	test $(git rev-parse start) = $(git rev-parse final^1^1^1)
+'
+
+test_expect_success 'final^1^1^1 = final^^^' '
+	test $(git rev-parse final^1^1^1) = $(git rev-parse final^^^)
+'
+
+test_expect_success 'final^1^2' '
+	test $(git rev-parse start2) = $(git rev-parse final^1^2)
+'
+
+test_expect_success 'final^1^2 != final^1^1' '
+	test $(git rev-parse final^1^2) != $(git rev-parse final^1^1)
+'
+
+test_expect_success 'final^1^3 not valid' '
+	if git rev-parse --verify final^1^3; then false; else :; fi
+'
+
+test_expect_success '--verify start2^1' '
+	test_must_fail git rev-parse --verify start2^1
+'
+
+test_expect_success '--verify start2^0' '
+	git rev-parse --verify start2^0
+'
+
+test_expect_success 'final^1^@ = final^1^1 final^1^2' '
+	test "$(git rev-parse final^1^@)" = "$(git rev-parse final^1^1 final^1^2)"
+'
+
+test_expect_success 'final^1^! = final^1 ^final^1^1 ^final^1^2' '
+	test "$(git rev-parse final^1^\!)" = "$(git rev-parse final^1 ^final^1^1 ^final^1^2)"
+'
+
+test_expect_success 'repack for next test' '
+	git repack -a -d
+'
+
 test_expect_success 'short SHA-1 works' '
 	start=`git rev-parse --verify start` &&
 	echo $start &&
@@ -39,6 +80,7 @@ test_expect_success 'short SHA-1 works' '
 	echo $abbrv &&
 	abbrv=`git rev-parse --verify $abbrv` &&
 	echo $abbrv &&
-	test $start = $abbrv'
+	test $start = $abbrv
+'
 
 test_done
-- 
1.8.4-338-gefd7fa6
