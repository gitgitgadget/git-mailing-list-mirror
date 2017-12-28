Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A75D1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbdL1EOH (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:07 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:36417 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753260AbdL1EOE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:04 -0500
Received: by mail-it0-f45.google.com with SMTP id d16so27469718itj.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kNLb+CMO3HYr5m6dqxrcP7fX2Nlm5qp7GNDKEXiXgwA=;
        b=ChRByB1rDvje8uTUdiYalgfJT+hAwKnGV64WwFMeeYwIthL1pXV2w42ghtaZX5CXN/
         7S7gHpAmeyqgVeyGgUrPE7Ta+b8jQ3mIlxC1Uh+qI2tcaAq7XwwRLeoUlEe2k5zH3O9c
         RJyRTcbyiu7/rlgjsL3DUtahF1ULk6bXkdYnFZ5WJsGv4MS+aKqU/eyobTzCVY7c1LJD
         x+0wCI3nvnwdYv4DFDnu/oSPS+HGsPI5XyStY6yBYzgzmDhBmFjWjgYrxOBhtCBNnNI3
         hj2frNT/e/9G3m/EKmcAuhEuK6vw7qE3n4atnZU08dW6EOk8Eoe+OLOZn0YFfaeDyLMZ
         vZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kNLb+CMO3HYr5m6dqxrcP7fX2Nlm5qp7GNDKEXiXgwA=;
        b=fq9C9UG1mAQRIH0BUpKkytSDmOZqYYaG6dJYfH3QKZzAd0McLy5wThUABB2QgECte1
         KYNt8fNJF5NArIYBfFaMcTc2gJ6N9BFTLpcvFbveVKBuSEF+O1WFqF39h1IG0hjLGtfj
         xQdOyh/NUX/fiQRbAOu4bzJ83qKge0pgo3gEtcr1UPpqUIktet1doMUbqSYoki06WWuV
         KeyJgYau3BUKQ04VGYwB8Fo00gSXs5tcquxYxJNNkirm3cUjGMxjs/ksdC5H4g3jqLcn
         xsQCKFAFqHj0V1CDAnStg/j4KtdIgO0cAJY/toWhskk77g4U/jgpLxVUsXo/rm6DJh/y
         /VHQ==
X-Gm-Message-State: AKGB3mIyr6WH3FtPSSA4/ZoaNbc+1QOqYcEWJ4zoaa8XwO3a+PdaFK0r
        G6aX093B3U1bE11Sjq1v7uQxcg==
X-Google-Smtp-Source: ACJfBour/7OOD4R9EP6de+IGmW9gH6hhAqp9u8rY9yqgfVKdjdPjEzLfyo8f8x0pFLiWuGjBGnENRg==
X-Received: by 10.36.204.85 with SMTP id x82mr38685673itf.95.1514434443641;
        Wed, 27 Dec 2017 20:14:03 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:02 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 04/34] directory rename detection: basic testcases
Date:   Wed, 27 Dec 2017 20:13:22 -0800
Message-Id: <20171228041352.27880-5-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 430 ++++++++++++++++++++++++++++++++++++
 1 file changed, 430 insertions(+)
 create mode 100755 t/t6043-merge-rename-directories.sh

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
new file mode 100755
index 000000000..d8ead7c56
--- /dev/null
+++ b/t/t6043-merge-rename-directories.sh
@@ -0,0 +1,430 @@
+#!/bin/sh
+
+test_description="recursive merge with directory renames"
+# includes checking of many corner cases, with a similar methodology to:
+#   t6042: corner cases with renames but not criss-cross merges
+#   t6036: corner cases with both renames and criss-cross merges
+#
+# The setup for all of them, pictorially, is:
+#
+#      A
+#      o
+#     / \
+#  O o   ?
+#     \ /
+#      o
+#      B
+#
+# To help make it easier to follow the flow of tests, they have been
+# divided into sections and each test will start with a quick explanation
+# of what commits O, A, and B contain.
+#
+# Notation:
+#    z/{b,c}   means  files z/b and z/c both exist
+#    x/d_1     means  file x/d exists with content d1.  (Purpose of the
+#                     underscore notation is to differentiate different
+#                     files that might be renamed into each other's paths.)
+
+. ./test-lib.sh
+
+
+###########################################################################
+# SECTION 1: Basic cases we should be able to handle
+###########################################################################
+
+# Testcase 1a, Basic directory rename.
+#   Commit O: z/{b,c}
+#   Commit A: y/{b,c}
+#   Commit B: z/{b,c,d,e/f}
+#   Expected: y/{b,c,d,e/f}
+
+test_expect_success '1a-setup: Simple directory rename detection' '
+	test_create_repo 1a &&
+	(
+		cd 1a &&
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
+		git mv z y &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo d >z/d &&
+		mkdir z/e &&
+		echo f >z/e/f &&
+		git add z/d z/e/f &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '1a-check: Simple directory rename detection' '
+	(
+		cd 1a &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 4 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:y/e/f &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/d B:z/e/f &&
+		test_cmp expect actual &&
+		test "$(git hash-object y/d)" = $(git rev-parse B:z/d) &&
+		test_must_fail git rev-parse HEAD:z/d &&
+		test_must_fail git rev-parse HEAD:z/e/f &&
+		test ! -d z/d &&
+		test ! -d z/e/f
+	)
+'
+
+# Testcase 1b, Merge a directory with another
+#   Commit O: z/{b,c},   y/d
+#   Commit A: z/{b,c,e}, y/d
+#   Commit B: y/{b,c,d}
+#   Expected: y/{b,c,d,e}
+
+test_expect_success '1b-setup: Merge a directory with another' '
+	test_create_repo 1b &&
+	(
+		cd 1b &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		mkdir y &&
+		echo d >y/d &&
+		git add z y &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		echo e >z/e &&
+		git add z/e &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z/b y &&
+		git mv z/c y &&
+		rmdir z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '1b-check: Merge a directory with another' '
+	(
+		cd 1b &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 4 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:y/e &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:y/d A:z/e &&
+		test_cmp expect actual &&
+		test_must_fail git rev-parse HEAD:z/e
+	)
+'
+
+# Testcase 1c, Transitive renaming
+#   (Related to testcases 3a and 6d -- when should a transitive rename apply?)
+#   (Related to testcases 9c and 9d -- can transitivity repeat?)
+#   Commit O: z/{b,c},   x/d
+#   Commit A: y/{b,c},   x/d
+#   Commit B: z/{b,c,d}
+#   Expected: y/{b,c,d}  (because x/d -> z/d -> y/d)
+
+test_expect_success '1c-setup: Transitive renaming' '
+	test_create_repo 1c &&
+	(
+		cd 1c &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		mkdir x &&
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
+		git mv z y &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/d z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '1c-check: Transitive renaming' '
+	(
+		cd 1c &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:x/d &&
+		test_cmp expect actual &&
+		test_must_fail git rev-parse HEAD:x/d &&
+		test_must_fail git rev-parse HEAD:z/d &&
+		test ! -f z/d
+	)
+'
+
+# Testcase 1d, Directory renames (merging two directories into one new one)
+#              cause a rename/rename(2to1) conflict
+#   (Related to testcases 1c and 7b)
+#   Commit O. z/{b,c},        y/{d,e}
+#   Commit A. x/{b,c},        y/{d,e,m,wham_1}
+#   Commit B. z/{b,c,n,wham_2}, x/{d,e}
+#   Expected: x/{b,c,d,e,m,n}, CONFLICT:(y/wham_1 & z/wham_2 -> x/wham)
+#   Note: y/m & z/n should definitely move into x.  By the same token, both
+#         y/wham_1 & z/wham_2 should too...giving us a conflict.
+
+test_expect_success '1d-setup: Directory renames cause a rename/rename(2to1) conflict' '
+	test_create_repo 1d &&
+	(
+		cd 1d &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		mkdir y &&
+		echo d >y/d &&
+		echo e >y/e &&
+		git add z y &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z x &&
+		echo m >y/m &&
+		echo wham1 >y/wham &&
+		git add y &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv y x &&
+		echo n >z/n &&
+		echo wham2 >z/wham &&
+		git add z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '1d-check: Directory renames cause a rename/rename(2to1) conflict' '
+	(
+		cd 1d &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+
+		test 8 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
+		test 3 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:x/b :0:x/c :0:x/d :0:x/e :0:x/m :0:x/n &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:y/d O:y/e A:y/m B:z/n &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse :0:x/wham &&
+		git rev-parse >actual \
+			:2:x/wham :3:x/wham &&
+		git rev-parse >expect \
+			A:y/wham B:z/wham &&
+		test_cmp expect actual &&
+
+		test ! -f x/wham &&
+		test -f x/wham~HEAD &&
+		test -f x/wham~B^0 &&
+
+		git hash-object >actual \
+			x/wham~HEAD x/wham~B^0 &&
+		git rev-parse >expect \
+			A:y/wham B:z/wham &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 1e, Renamed directory, with all filenames being renamed too
+#   Commit O: z/{oldb,oldc}
+#   Commit A: y/{newb,newc}
+#   Commit B: z/{oldb,oldc,d}
+#   Expected: y/{newb,newc,d}
+
+test_expect_success '1e-setup: Renamed directory, with all files being renamed too' '
+	test_create_repo 1e &&
+	(
+		cd 1e &&
+
+		mkdir z &&
+		echo b >z/oldb &&
+		echo c >z/oldc &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir y &&
+		git mv z/oldb y/newb &&
+		git mv z/oldc y/newc &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo d >z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '1e-check: Renamed directory, with all files being renamed too' '
+	(
+		cd 1e &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/newb HEAD:y/newc HEAD:y/d &&
+		git rev-parse >expect \
+			O:z/oldb O:z/oldc B:z/d &&
+		test_cmp expect actual &&
+		test_must_fail git rev-parse HEAD:z/d
+	)
+'
+
+# Testcase 1f, Split a directory into two other directories
+#   (Related to testcases 3a, all of section 2, and all of section 4)
+#   Commit O: z/{b,c,d,e,f}
+#   Commit A: z/{b,c,d,e,f,g}
+#   Commit B: y/{b,c}, x/{d,e,f}
+#   Expected: y/{b,c}, x/{d,e,f,g}
+
+test_expect_success '1f-setup: Split a directory into two other directories' '
+	test_create_repo 1f &&
+	(
+		cd 1f &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >z/d &&
+		echo e >z/e &&
+		echo f >z/f &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		echo g >z/g &&
+		git add z/g &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir y &&
+		mkdir x &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		git mv z/d x/ &&
+		git mv z/e x/ &&
+		git mv z/f x/ &&
+		rmdir z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '1f-check: Split a directory into two other directories' '
+	(
+		cd 1f &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:x/d HEAD:x/e HEAD:x/f HEAD:x/g &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:z/d O:z/e O:z/f A:z/g &&
+		test_cmp expect actual &&
+		test ! -f z/g &&
+		test_must_fail git rev-parse HEAD:z/g
+	)
+'
+
+###########################################################################
+# Rules suggested by testcases in section 1:
+#
+#   We should still detect the directory rename even if it wasn't just
+#   the directory renamed, but the files within it. (see 1b)
+#
+#   If renames split a directory into two or more others, the directory
+#   with the most renames, "wins" (see 1c).  However, see the testcases
+#   in section 2, plus testcases 3a and 4a.
+###########################################################################
+
+test_done
-- 
2.15.0.408.g8e199d483

