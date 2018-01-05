Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E555D1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeAEUaK (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:30:10 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:43317 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeAEU2f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:35 -0500
Received: by mail-it0-f68.google.com with SMTP id u62so2884570ita.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CHTVBNG9bjX8SWiPnt52XVcvmiGQ9jZHDUGvd2NoDAw=;
        b=uYfZsWXLnBOr6eCyXjtBLYrAXvJNXDKpaVYZ9afpLpNUaq4wG5A8Se83FY7wbYB/S+
         ITv+m6bUd/uuxU1M2A9shLuApDPvDxNTOoMgIQgBVr7YELp28cZ429+pQYsaZg1Yck7o
         9f/RoGFfh/XmhhZJNsMGHuv5zpDPKaTXqbgzZpjgvmTABw7DVJ+FlxD6XI+ohrk8E2G8
         lRxVbySRWG1yzP3j65sdl5MeFWbEfUfe33AIcI29mEfm2wDrx+rjuzg8Y9T52RC3HWKk
         kufQg+zAJH6KDcInZsLb8sK+/EvJZ0/QnOXROpWGNuHJR/noGeEng0qsdEIujQL+bySl
         3bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CHTVBNG9bjX8SWiPnt52XVcvmiGQ9jZHDUGvd2NoDAw=;
        b=BHxiXOgOCGU0am5EayXN8sXUFQzPHuWE6EQTyXTyAZ8rza/2MDRv6H0UInyZpXhZvS
         5RmPNoaYAQ+zcKk6Ctqt8yto01DPjAWI0P3qKGWmXZk6pcmg968z/zVeFgg8t3AbHc8u
         aEXTh8poOQlk4u44W1wOZMTrmJeTktAEIOpomriwfQpyYnW4q/oLSBYiVFBKCXKPNo0N
         lroY4LfG/5vB3uZnB6hJKW9E5Nmo5HkDYrDJT0nBn4fAmsRim8r4qTOKOI4qDpRPols+
         mD4ycbbm2BJSucBtVs6FzGxvDg8Qls+rYQ8TBYVLeOikHIlPqZHfahHNq47N/IzrWjjm
         mfWg==
X-Gm-Message-State: AKGB3mL0cKkr9m5ozjpGtqFesg5sPUSwazRwCZephjCxzAz4T4lujaDD
        Dh/fdZE9Y/S+LmjLbAz99URoQFhS
X-Google-Smtp-Source: ACJfBovJoZDKLjh5hx3yoo6Tbjj7d8Co/5ODPJdBz67cA6+6gHAQBtCFpnX8MUgbFJurhNzzz0sfYw==
X-Received: by 10.36.104.210 with SMTP id v201mr3964009itb.64.1515184114154;
        Fri, 05 Jan 2018 12:28:34 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:33 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 11/31] directory rename detection: tests for handling overwriting dirty files
Date:   Fri,  5 Jan 2018 12:26:51 -0800
Message-Id: <20180105202711.24311-12-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 458 ++++++++++++++++++++++++++++++++++++
 1 file changed, 458 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 5a2a4449d..d69d26951 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3222,4 +3222,462 @@ test_expect_failure '10e-check: Does git complain about untracked file that is n
 	)
 '
 
+###########################################################################
+# SECTION 11: Handling dirty (not up-to-date) files
+#
+# unpack_trees(), upon which the recursive merge algorithm is based, aborts
+# the operation if untracked or dirty files would be deleted or overwritten
+# by the merge.  Unfortunately, unpack_trees() does not understand renames,
+# and if it doesn't abort, then it muddies up the working directory before
+# we even get to the point of detecting renames, so we need some special
+# handling.  This was true even of normal renames, but there are additional
+# codepaths that need special handling with directory renames.  Add
+# testcases for both renamed-by-directory-rename-detection and standard
+# rename cases.
+###########################################################################
+
+# Testcase 11a, Avoid losing dirty contents with simple rename
+#   Commit O: z/{a,b_v1},
+#   Commit A: z/{a,c_v1}, and z/c_v1 has uncommitted mods
+#   Commit B: z/{a,b_v2}
+#   Expected: ERROR_MSG(Refusing to lose dirty file at z/c) +
+#             z/a, staged version of z/c has sha1sum matching B:z/b_v2,
+#             z/c~HEAD with contents of B:z/b_v2,
+#             z/c with uncommitted mods on top of A:z/c_v1
+
+test_expect_success '11a-setup: Avoid losing dirty contents with simple rename' '
+	test_create_repo 11a &&
+	(
+		cd 11a &&
+
+		mkdir z &&
+		echo a >z/a &&
+		test_seq 1 10 >z/b &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z/b z/c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo 11 >>z/b &&
+		git add z/b &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '11a-check: Avoid losing dirty contents with simple rename' '
+	(
+		cd 11a &&
+
+		git checkout A^0 &&
+		echo stuff >>z/c &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+
+		test_seq 1 10 >expected &&
+		echo stuff >>expected &&
+		test_cmp expected z/c &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 1 out &&
+		git ls-files -o >out &&
+		test_line_count = 4 out &&
+
+		git rev-parse >actual \
+			:0:z/a :2:z/c &&
+		git rev-parse >expect \
+			O:z/a B:z/b &&
+		test_cmp expect actual &&
+
+		git hash-object z/c~HEAD >actual &&
+		git rev-parse B:z/b >expect &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 11b, Avoid losing dirty file involved in directory rename
+#   Commit O: z/a,         x/{b,c_v1}
+#   Commit A: z/{a,c_v1},  x/b,       and z/c_v1 has uncommitted mods
+#   Commit B: y/a,         x/{b,c_v2}
+#   Expected: y/{a,c_v2}, x/b, z/c_v1 with uncommitted mods untracked,
+#             ERROR_MSG(Refusing to lose dirty file at z/c)
+
+
+test_expect_success '11b-setup: Avoid losing dirty file involved in directory rename' '
+	test_create_repo 11b &&
+	(
+		cd 11b &&
+
+		mkdir z x &&
+		echo a >z/a &&
+		echo b >x/b &&
+		test_seq 1 10 >x/c &&
+		git add z x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv x/c z/c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		echo 11 >>x/c &&
+		git add x/c &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '11b-check: Avoid losing dirty file involved in directory rename' '
+	(
+		cd 11b &&
+
+		git checkout A^0 &&
+		echo stuff >>z/c &&
+
+		git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+
+		grep -q stuff z/c &&
+		test_seq 1 10 >expected &&
+		echo stuff >>expected &&
+		test_cmp expected z/c &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -m >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 4 out &&
+
+		git rev-parse >actual \
+			:0:x/b :0:y/a :0:y/c &&
+		git rev-parse >expect \
+			O:x/b O:z/a B:x/c &&
+		test_cmp expect actual &&
+
+		git hash-object y/c >actual &&
+		git rev-parse B:x/c >expect &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 11c, Avoid losing not-up-to-date with rename + D/F conflict
+#   Commit O: y/a,         x/{b,c_v1}
+#   Commit A: y/{a,c_v1},  x/b,       and y/c_v1 has uncommitted mods
+#   Commit B: y/{a,c/d},   x/{b,c_v2}
+#   Expected: Abort_msg("following files would be overwritten by merge") +
+#             y/c left untouched (still has uncommitted mods)
+
+test_expect_success '11c-setup: Avoid losing not-uptodate with rename + D/F conflict' '
+	test_create_repo 11c &&
+	(
+		cd 11c &&
+
+		mkdir y x &&
+		echo a >y/a &&
+		echo b >x/b &&
+		test_seq 1 10 >x/c &&
+		git add y x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv x/c y/c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir y/c &&
+		echo d >y/c/d &&
+		echo 11 >>x/c &&
+		git add x/c y/c/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '11c-check: Avoid losing not-uptodate with rename + D/F conflict' '
+	(
+		cd 11c &&
+
+		git checkout A^0 &&
+		echo stuff >>y/c &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "following files would be overwritten by merge" err &&
+
+		grep -q stuff y/c &&
+		test_seq 1 10 >expected &&
+		echo stuff >>expected &&
+		test_cmp expected y/c &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -m >out &&
+		test_line_count = 1 out &&
+		git ls-files -o >out &&
+		test_line_count = 3 out
+	)
+'
+
+# Testcase 11d, Avoid losing not-up-to-date with rename + D/F conflict
+#   Commit O: z/a,         x/{b,c_v1}
+#   Commit A: z/{a,c_v1},  x/b,       and z/c_v1 has uncommitted mods
+#   Commit B: y/{a,c/d},   x/{b,c_v2}
+#   Expected: D/F: y/c_v2 vs y/c/d) +
+#             Warning_Msg("Refusing to lose dirty file at z/c) +
+#             y/{a,c~HEAD,c/d}, x/b, now-untracked z/c_v1 with uncommitted mods
+
+test_expect_success '11d-setup: Avoid losing not-uptodate with rename + D/F conflict' '
+	test_create_repo 11d &&
+	(
+		cd 11d &&
+
+		mkdir z x &&
+		echo a >z/a &&
+		echo b >x/b &&
+		test_seq 1 10 >x/c &&
+		git add z x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv x/c z/c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		mkdir y/c &&
+		echo d >y/c/d &&
+		echo 11 >>x/c &&
+		git add x/c y/c/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '11d-check: Avoid losing not-uptodate with rename + D/F conflict' '
+	(
+		cd 11d &&
+
+		git checkout A^0 &&
+		echo stuff >>z/c &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+
+		grep -q stuff z/c &&
+		test_seq 1 10 >expected &&
+		echo stuff >>expected &&
+		test_cmp expected z/c
+
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -u >out &&
+		test_line_count = 1 out &&
+		git ls-files -o >out &&
+		test_line_count = 5 out &&
+
+		git rev-parse >actual \
+			:0:x/b :0:y/a :0:y/c/d :3:y/c &&
+		git rev-parse >expect \
+			O:x/b O:z/a B:y/c/d B:x/c &&
+		test_cmp expect actual &&
+
+		git hash-object y/c~HEAD >actual &&
+		git rev-parse B:x/c >expect &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 11e, Avoid deleting not-up-to-date with dir rename/rename(1to2)/add
+#   Commit O: z/{a,b},      x/{c_1,d}
+#   Commit A: y/{a,b,c_2},  x/d, w/c_1, and y/c_2 has uncommitted mods
+#   Commit B: z/{a,b,c_1},  x/d
+#   Expected: Failed Merge; y/{a,b} + x/d +
+#             CONFLICT(rename/rename) x/c_1 -> w/c_1 vs y/c_1 +
+#             ERROR_MSG(Refusing to lose dirty file at y/c)
+#             y/c~B^0 has O:x/c_1 contents
+#             y/c~HEAD has A:y/c_2 contents
+#             y/c has dirty file from before merge
+
+test_expect_success '11e-setup: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
+	test_create_repo 11e &&
+	(
+		cd 11e &&
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
+		git mv z/ y/ &&
+		echo different >y/c &&
+		mkdir w &&
+		git mv x/c w/ &&
+		git add y/c &&
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
+test_expect_failure '11e-check: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
+	(
+		cd 11e &&
+
+		git checkout A^0 &&
+		echo mods >>y/c &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "Refusing to lose dirty file at y/c" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 7 out &&
+		git ls-files -u >out &&
+		test_line_count = 4 out &&
+		git ls-files -o >out &&
+		test_line_count = 4 out &&
+
+		echo different >expected &&
+		echo mods >>expected &&
+		test_cmp expected y/c &&
+
+		git rev-parse >actual \
+			:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :2:y/c :3:y/c &&
+		git rev-parse >expect \
+			O:z/a O:z/b O:x/d O:x/c O:x/c A:y/c O:x/c &&
+		test_cmp expect actual &&
+
+		git hash-object >actual \
+			y/c~B^0 y/c~HEAD &&
+		git rev-parse >expect \
+			O:x/c A:y/c &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 11f, Avoid deleting not-up-to-date w/ dir rename/rename(2to1)
+#   Commit O: z/{a,b},        x/{c_1,d_2}
+#   Commit A: y/{a,b,wham_1}, x/d_2, except y/wham has uncommitted mods
+#   Commit B: z/{a,b,wham_2}, x/c_1
+#   Expected: Failed Merge; y/{a,b} + untracked y/{wham~B^0,wham~B^HEAD} +
+#             y/wham with dirty changes from before merge +
+#             CONFLICT(rename/rename) x/c vs x/d -> y/wham
+#             ERROR_MSG(Refusing to lose dirty file at y/wham)
+
+test_expect_success '11f-setup: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
+	test_create_repo 11f &&
+	(
+		cd 11f &&
+
+		mkdir z x &&
+		echo a >z/a &&
+		echo b >z/b &&
+		test_seq 1 10 >x/c &&
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
+		git mv z/ y/ &&
+		git mv x/c y/wham &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/d z/wham &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '11f-check: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
+	(
+		cd 11f &&
+
+		git checkout A^0 &&
+		echo important >>y/wham &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "Refusing to lose dirty file at y/wham" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 4 out &&
+
+		test_seq 1 10 >expected &&
+		echo important >>expected &&
+		test_cmp expected y/wham &&
+
+		test_must_fail git rev-parse :1:y/wham &&
+		git hash-object >actual \
+			y/wham~B^0 y/wham~HEAD &&
+		git rev-parse >expect \
+			O:x/d O:x/c &&
+		test_cmp expect actual &&
+
+		git rev-parse >actual \
+			:0:y/a :0:y/b :2:y/wham :3:y/wham &&
+		git rev-parse >expect \
+			O:z/a O:z/b O:x/c O:x/d &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.14.2

