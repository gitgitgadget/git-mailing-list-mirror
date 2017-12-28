Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 047AB1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbdL1EOR (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:17 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:43453 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbdL1EOP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:15 -0500
Received: by mail-it0-f68.google.com with SMTP id u62so26971821ita.2
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YbA6UqTLh1Y9u/71loSgN6qlcdz75PKDn1QMHe82W/s=;
        b=SL/hwTcFI19UDT3dovQKDH4JFyaHqdhvN9N/YLMIKsqiL226AN2L6Ss2dv+wtRy8pI
         YJkQXJrFYmsLLrARBd3xdRo5yRPHg1UBvt2xlwPvlywsfkksUumAR0XbmPKdg6A6f1/y
         10A0EWaPeg5RZFCRkbjX7tKzwpS0vb95k51qxS1W0JPoFLoWy7oFZ3y17mUytjju8clR
         9eqO4Wd6DVgu7Ib64S9O99aGUPQIr0FQUe8HtLafelBZpY+KA98Z+RrI9cg78d31DqWi
         B1nfUvZu0I8DF0n3DhL5WK8fuPELuAo9dDQYTyRVqXenp4bVjsp4f8wAaqVIDiY2le5n
         Qt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YbA6UqTLh1Y9u/71loSgN6qlcdz75PKDn1QMHe82W/s=;
        b=K15kgI9FqIvcAsSKI2rFPeZF8zBbxuKbE+g7o2IHmQM5BEqCQn9riRRI3YYqMFBy2l
         nIdU/L7dmipuyfLlQee76CVktik2UW+vQFtE5R8s7nSnVdf/u+rC/NDTxnnJ3+Q8Vnkb
         p4yobKOZGIMr9fnLF85C/8dw6xIz7L5mrHNNjfumOU/fE7X0rEkXCAnYaVTlv2E6LMiQ
         mDyutt+PfKYn2lUFX4JDpi6XqD5LlJdwWFVN9Jpuc9xn3lBalu3E0o/aCgLJ8jW6WAYz
         RnkE7M4vETKDV1E2yq19iom9Ay68HRWzobuC+4fP99E+g/YVWYWyxZwoxwZ5FdolNKeM
         eIgA==
X-Gm-Message-State: AKGB3mKGVuj+G9j1r62uWA/LfsoTfG2nWv0utKw32bY2X8TrATbOxG1u
        7bXxQkdmUqpoEmuKLSFqNIozXA==
X-Google-Smtp-Source: ACJfBosMiJFkmhIrAr2Yx9Z0fNPRmH8PbPcMt85Nfx0ieycQ+qcNXnRcgbazyH4OwaTHJrEwdWP1fg==
X-Received: by 10.36.170.14 with SMTP id b14mr3898502itf.13.1514434453632;
        Wed, 27 Dec 2017 20:14:13 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:13 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 13/34] directory rename detection: tests for handling overwriting untracked files
Date:   Wed, 27 Dec 2017 20:13:31 -0800
Message-Id: <20171228041352.27880-14-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 337 ++++++++++++++++++++++++++++++++++++
 1 file changed, 337 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index c731a1b03..7248c3807 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2768,4 +2768,341 @@ test_expect_failure '9g-check: Renamed directory that only contained immediate s
 #   side of history for any implicit directory renames.
 ###########################################################################
 
+###########################################################################
+# SECTION 10: Handling untracked files
+#
+# unpack_trees(), upon which the recursive merge algorithm is based, aborts
+# the operation if untracked or dirty files would be deleted or overwritten
+# by the merge.  Unfortunately, unpack_trees() does not understand renames,
+# and if it doesn't abort, then it muddies up the working directory before
+# we even get to the point of detecting renames, so we need some special
+# handling, at least in the case of directory renames.
+###########################################################################
+
+# Testcase 10a, Overwrite untracked: normal rename/delete
+#   Commit O: z/{b,c_1}
+#   Commit A: z/b + untracked z/c + untracked z/d
+#   Commit B: z/{b,d_1}
+#   Expected: Aborted Merge +
+#       ERROR_MSG(untracked working tree files would be overwritten by merge)
+
+test_expect_success '10a-setup: Overwrite untracked with normal rename/delete' '
+	test_create_repo 10a &&
+	(
+		cd 10a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git rm z/c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z/c z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '10a-check: Overwrite untracked with normal rename/delete' '
+	(
+		cd 10a &&
+
+		git checkout A^0 &&
+		echo very >z/c &&
+		echo important >z/d &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "The following untracked working tree files would be overwritten by merge" err &&
+
+		test 1 -eq $(git ls-files -s | wc -l) &&
+		test 4 -eq $(git ls-files -o | wc -l) &&
+
+		test "very" = "$(cat z/c)" &&
+		test "important" = "$(cat z/d)" &&
+		test $(git rev-parse HEAD:z/b) = $(git rev-parse O:z/b)
+	)
+'
+
+# Testcase 10b, Overwrite untracked: dir rename + delete
+#   Commit O: z/{b,c_1}
+#   Commit A: y/b + untracked y/{c,d,e}
+#   Commit B: z/{b,d_1,e}
+#   Expected: Failed Merge; y/b + untracked y/c + untracked y/d on disk +
+#             z/c_1 -> z/d_1 rename recorded at stage 3 for y/d +
+#       ERROR_MSG(refusing to lose untracked file at 'y/d')
+
+test_expect_success '10b-setup: Overwrite untracked with dir rename + delete' '
+	test_create_repo 10b &&
+	(
+		cd 10b &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git rm z/c &&
+		git mv z/ y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z/c z/d &&
+		echo e >z/e &&
+		git add z/e &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '10b-check: Overwrite untracked with dir rename + delete' '
+	(
+		cd 10b &&
+
+		git checkout A^0 &&
+		echo very >y/c &&
+		echo important >y/d &&
+		echo contents >y/e &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "CONFLICT (rename/delete).*Version B^0 of y/d left in tree at y/d~B^0" out &&
+		test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B^0 instead" out &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
+		test 5 -eq $(git ls-files -o | wc -l) &&
+
+		test $(git rev-parse :0:y/b) = $(git rev-parse O:z/b) &&
+		test "very" = "$(cat y/c)" &&
+
+		test "important" = "$(cat y/d)" &&
+		test "important" != "$(git rev-parse :3:y/d)" &&
+		test $(git rev-parse :3:y/d) = $(git rev-parse O:z/c) &&
+
+		test "contents" = "$(cat y/e)" &&
+		test "contents" != "$(git rev-parse :3:y/e)" &&
+		test $(git rev-parse :3:y/e) = $(git rev-parse B:z/e)
+	)
+'
+
+# Testcase 10c, Overwrite untracked: dir rename/rename(1to2)
+#   Commit O: z/{a,b}, x/{c,d}
+#   Commit A: y/{a,b}, w/c, x/d + different untracked y/c
+#   Commit B: z/{a,b,c}, x/d
+#   Expected: Failed Merge; y/{a,b} + x/d + untracked y/c +
+#             CONFLICT(rename/rename) x/c -> w/c vs y/c +
+#             y/c~B^0 +
+#             ERROR_MSG(Refusing to lose untracked file at y/c)
+
+test_expect_success '10c-setup: Overwrite untracked with dir rename/rename(1to2)' '
+	test_create_repo 10c &&
+	(
+		cd 10c &&
+
+		mkdir z x &&
+		echo a >z/a &&
+		echo b >z/b &&
+		echo c >x/c &&
+		echo d >x/d &&
+		git add z x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir w &&
+		git mv x/c w/c &&
+		git mv z/ y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/c z/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '10c-check: Overwrite untracked with dir rename/rename(1to2)' '
+	(
+		cd 10c &&
+
+		git checkout A^0 &&
+		echo important >y/c &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B^0 instead" out &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+		test 3 -eq $(git ls-files -u | wc -l) &&
+		test 3 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :3:y/c &&
+		git rev-parse >expect \
+			O:z/a O:z/b O:x/d O:x/c O:x/c O:x/c &&
+		test_cmp expect actual &&
+
+		test "important" = "$(cat y/c)" &&
+		test "important" != "$(git rev-parse :3:y/c)" &&
+		test $(git hash-object y/c~B^0) = $(git rev-parse O:x/c)
+	)
+'
+
+# Testcase 10d, Delete untracked w/ dir rename/rename(2to1)
+#   Commit O: z/{a,b,c_1},        x/{d,e,f_2}
+#   Commit A: y/{a,b},            x/{d,e,f_2,wham_1} + untracked y/wham
+#   Commit B: z/{a,b,c_1,wham_2}, y/{d,e}
+#   Expected: Failed Merge; y/{a,b,d,e} + untracked y/{wham,wham~B^0,wham~HEAD}+
+#             CONFLICT(rename/rename) z/c_1 vs x/f_2 -> y/wham
+#             ERROR_MSG(Refusing to lose untracked file at y/wham)
+
+test_expect_success '10d-setup: Delete untracked with dir rename/rename(2to1)' '
+	test_create_repo 10d &&
+	(
+		cd 10d &&
+
+		mkdir z x &&
+		echo a >z/a &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >x/d &&
+		echo e >x/e &&
+		echo f >x/f &&
+		git add z x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z/c x/wham &&
+		git mv z/ y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/f z/wham &&
+		git mv x/ y/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '10d-check: Delete untracked with dir rename/rename(2to1)' '
+	(
+		cd 10d &&
+
+		git checkout A^0 &&
+		echo important >y/wham &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "Refusing to lose untracked file at y/wham" out &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
+		test 4 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/a :0:y/b :0:y/d :0:y/e :2:y/wham :3:y/wham &&
+		git rev-parse >expect \
+			O:z/a O:z/b O:x/d O:x/e O:z/c O:x/f &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse :1:y/wham &&
+
+		test "important" = "$(cat y/wham)" &&
+		git hash-object >actual \
+			y/wham~B^0 y/wham~HEAD &&
+		git rev-parse >expect \
+			O:x/f O:z/c &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 10e, Does git complain about untracked file that's not in the way?
+#   Commit O: z/{a,b}
+#   Commit A: y/{a,b} + untracked z/c
+#   Commit B: z/{a,b,c}
+#   Expected: y/{a,b,c} + untracked z/c
+
+test_expect_success '10e-setup: Does git complain about untracked file that is not really in the way?' '
+	test_create_repo 10e &&
+	(
+		cd 10e &&
+
+		mkdir z &&
+		echo a >z/a &&
+		echo b >z/b &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z/ y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo c >z/c &&
+		git add z/c &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '10e-check: Does git complain about untracked file that is not really in the way?' '
+	(
+		cd 10e &&
+
+		git checkout A^0 &&
+		mkdir z &&
+		echo random >z/c &&
+
+		git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep ! "following untracked working tree files would be overwritten by merge" err &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 3 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/a :0:y/b :0:y/c &&
+		git rev-parse >expect \
+			O:z/a O:z/b B:z/c &&
+		test_cmp expect actual &&
+
+		test "random" = "$(cat z/c)"
+	)
+'
+
 test_done
-- 
2.15.0.408.g8e199d483

