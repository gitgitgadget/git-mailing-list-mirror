Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F5F1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbdL1EPh (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:37 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:39367 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753282AbdL1EOK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:10 -0500
Received: by mail-it0-f44.google.com with SMTP id 68so27446181ite.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jmcy4I0e079Aoy/PqDqGgQsrX8XsK38k/iqXDxo7ztQ=;
        b=pnt+P3lxZyYU82ykasciZi2qzMI5t3e+/BjbOlslsxHmTB7VcNQ9iqiV9K0Ca65za2
         VAwSpfFxyDVbzXIEdKjBMuBMoj+NBPAaZb5+T5RFKix+xvA7VqV6MAyAX3tO7+MYZjHc
         RwwOym/wlapXH1aDRAE0x7+gujab0crR8+pGVrSBek1VkvbdAT/94gaiLKnLPY94zS+3
         zmSkxsjNfFLHxlj978evKQtMbiGN4xB8/jQ35wS8Ph6s/zzgYXBa2PPaEbfQxW8Cc4Xn
         NRHs3woh4rf+okcqncR/m0Ym5CBrzW19JhT5kDBtSDtncH7i9CN/UycirWI0/KngUnn8
         KBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jmcy4I0e079Aoy/PqDqGgQsrX8XsK38k/iqXDxo7ztQ=;
        b=tqo+QPS8undBIff5Yk8+Jl44Ob0r/pzhPU6BjCmfBH3xmsMgECzVmgXsmlw4uBf/Ic
         rszJu6xe0QNi8/NCQzSmrMZPNCH63oQTE/ZFOScTeq2QRmR8MvHnF2iKpUwjRs8VfBhz
         D/ZmDriJULozAowbv19z7rTZTLg1q86hwL3R0koEeEKXeXX6v7/xTZ3Dd0e8ob+8s9qt
         iFsItfQonElM2C+3iHOu58zPMF2KXao6WhxCIv/wpFfmgeYacyDOWLFm/qo1juyW89fa
         uJgv+MAFsFvA+GP1yJUBxzpDhx/mQ85blTaWDonxmgWOpcbnJin68DMoC1s3WM1y4W5m
         C+pA==
X-Gm-Message-State: AKGB3mLsbKjfVtmJ30msHXkkeBuGPj6RMNvOACZPdXhKpfiEaachXt1F
        5Ogj5udQZ4iWkJ79q/d4PGFXTw==
X-Google-Smtp-Source: ACJfBosCS5b7Ih7wxdRIV+brkRCQXvVNqpQfC+P9d6z+ktimzw3vurcSRVYlwmnpoNli75YbLoEi1A==
X-Received: by 10.36.227.3 with SMTP id d3mr27022354ith.47.1514434449527;
        Wed, 27 Dec 2017 20:14:09 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:08 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 09/34] directory rename detection: testcases checking which side did the rename
Date:   Wed, 27 Dec 2017 20:13:27 -0800
Message-Id: <20171228041352.27880-10-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 321 ++++++++++++++++++++++++++++++++++++
 1 file changed, 321 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 468d6d537..50fb8f41e 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -1138,4 +1138,325 @@ test_expect_failure '5d-check: Directory/file/file conflict due to directory ren
 #   back to old handling.  But, sadly, see testcases 8a and 8b.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 6: Same side of the merge was the one that did the rename
+#
+# It may sound obvious that you only want to apply implicit directory
+# renames to directories if the _other_ side of history did the renaming.
+# If you did make an implementation that didn't explicitly enforce this
+# rule, the majority of cases that would fall under this section would
+# also be solved by following the rules from the above sections.  But
+# there are still a few that stick out, so this section covers them just
+# to make sure we also get them right.
+###########################################################################
+
+# Testcase 6a, Tricky rename/delete
+#   Commit O: z/{b,c,d}
+#   Commit A: z/b
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/b, CONFLICT(rename/delete, z/c -> y/c vs. NULL)
+#   Note: We're just checking here that the rename of z/b and z/c to put
+#         them under y/ doesn't accidentally catch z/d and make it look like
+#         it is also involved in a rename/delete conflict.
+
+test_expect_success '6a-setup: Tricky rename/delete' '
+	test_create_repo 6a &&
+	(
+		cd 6a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >z/d &&
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
+		git rm z/d &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir y &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6a-check: Tricky rename/delete' '
+	(
+		cd 6a &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/delete).*z/c.*y/c" out &&
+
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 1 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :3:y/c &&
+		git rev-parse >expect \
+			O:z/b O:z/c &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6b, Same rename done on both sides
+#   (Related to testcases 6c and 8e)
+#   Commit O: z/{b,c}
+#   Commit A: y/{b,c}
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/{b,c}, z/d
+#   Note: If we did directory rename detection here, we'd move z/d into y/,
+#         but B did that rename and still decided to put the file into z/,
+#         so we probably shouldn't apply directory rename detection for it.
+
+test_expect_success '6b-setup: Same rename done on both sides' '
+	test_create_repo 6b &&
+	(
+		cd 6b &&
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
+		git mv z y &&
+		mkdir z &&
+		echo d >z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6b-check: Same rename done on both sides' '
+	(
+		cd 6b &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6c, Rename only done on same side
+#   (Related to testcases 6b and 8e)
+#   Commit O: z/{b,c}
+#   Commit A: z/{b,c} (no change)
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/{b,c}, z/d
+#   NOTE: Seems obvious, but just checking that the implementation doesn't
+#         "accidentally detect a rename" and give us y/{b,c,d}.
+
+test_expect_success '6c-setup: Rename only done on same side' '
+	test_create_repo 6c &&
+	(
+		cd 6c &&
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
+		test_tick &&
+		git commit --allow-empty -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		mkdir z &&
+		echo d >z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6c-check: Rename only done on same side' '
+	(
+		cd 6c &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6d, We don't always want transitive renaming
+#   (Related to testcase 1c)
+#   Commit O: z/{b,c}, x/d
+#   Commit A: z/{b,c}, x/d (no change)
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/{b,c}, z/d
+#   NOTE: Again, this seems obvious but just checking that the implementation
+#         doesn't "accidentally detect a rename" and give us y/{b,c,d}.
+
+test_expect_success '6d-setup: We do not always want transitive renaming' '
+	test_create_repo 6d &&
+	(
+		cd 6d &&
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
+		test_tick &&
+		git commit --allow-empty -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		git mv x z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6d-check: We do not always want transitive renaming' '
+	(
+		cd 6d &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:x/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6e, Add/add from one-side
+#   Commit O: z/{b,c}
+#   Commit A: z/{b,c} (no change)
+#   Commit B: y/{b,c,d_1}, z/d_2
+#   Expected: y/{b,c,d_1}, z/d_2
+#   NOTE: Again, this seems obvious but just checking that the implementation
+#         doesn't "accidentally detect a rename" and give us y/{b,c} +
+#         add/add conflict on y/d_1 vs y/d_2.
+
+test_expect_success '6e-setup: Add/add from one side' '
+	test_create_repo 6e &&
+	(
+		cd 6e &&
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
+		test_tick &&
+		git commit --allow-empty -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		echo d1 > y/d &&
+		mkdir z &&
+		echo d2 > z/d &&
+		git add y/d z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6e-check: Add/add from one side' '
+	(
+		cd 6e &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 4 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:y/d B:z/d &&
+		test_cmp expect actual
+	)
+'
+
+###########################################################################
+# Rules suggested by section 6:
+#
+#   Only apply implicit directory renames to directories if the other
+#   side of history is the one doing the renaming.
+###########################################################################
+
 test_done
-- 
2.15.0.408.g8e199d483

