Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4471F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeAEUal (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:30:41 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:42150 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeAEU2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:24 -0500
Received: by mail-io0-f193.google.com with SMTP id x67so6967420ioi.9
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oLYF0pXG3qVnuONQAidT0sc/ZQS5hWg+Bc0sec5AzVw=;
        b=fFZS0yJZ1I4LPWC2PdHApxU5Y365YDWXjX1CGmic7gnmwSIF2HaIDcfdNd1qSHyXZr
         dMWb4VmRfUqIwVfxu4nF8vDJFzvXQ1CpfmHUgNuUPI/3FUd78BCn3nYCo0UJHlCcUciC
         eJq1IXmZplP9YpoCTqh7gq80Q/Fm5fvIC/6f7ENlYSnumYxCLSKCl2kYt1LppqbxI8+L
         8pO3AaDaNkB5WuAdf83EA2PN8FFg5m1PXFEuA6lE93XDrBzsxGhz51g/yOsmK34csz8Z
         BXN9idD8UHksafh/lJIPUIQPL7LvIP9EL5wXM5nA6H5RvkXSgb0kgmdXoSSwf96+jjZD
         Ou7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oLYF0pXG3qVnuONQAidT0sc/ZQS5hWg+Bc0sec5AzVw=;
        b=OdGi8SzmzgDPwDav9XmAK+zX4UNVo8IHMlxQz+ONI5TBb5ZCvV/ur8pji7SyDCTt0s
         1iB2KlwtmoSCrvb4R/RNWph/6bdupLvH0u6/WSPgRgw1ggGRpBgdB8us0k7J0bCdWbXj
         CloE744Sb8e39Wyez3wFwrFC8O//PSesqwmAgR3993TuhZXSygdRY8k65uX3o8C04ljX
         Q9Np7tpawddxcmm9s6GqqHey3Mxremnbvw7CI7zrWULjlRIkAxjEcGK74LDGsaWoJ9Jx
         6et8lmKNuXDEzBWREKIJpVwB8dB2PnL/GIROXu7t5L2leD2DvFIroxUDUU1HTfWXCzZE
         eigA==
X-Gm-Message-State: AKGB3mLsu+RjxlzKTINUmvX2Wla81xo7qY4p52IzYCQVNwHLZK8nFoJA
        etQVeRIvo8vko5pfuQRZczJbmMoP
X-Google-Smtp-Source: ACJfBotU7yjDT9XwFbijKBeWqOm2gjkBohSzH5p7OA6j92XtN0WwBBGClkY7UvUidi3mIl05wPsiXw==
X-Received: by 10.107.142.215 with SMTP id q206mr4234879iod.25.1515184103527;
        Fri, 05 Jan 2018 12:28:23 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:23 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 03/31] directory rename detection: testcases to avoid taking detection too far
Date:   Fri,  5 Jan 2018 12:26:43 -0800
Message-Id: <20180105202711.24311-4-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 153 ++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index f36493289..239819f2d 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -582,4 +582,157 @@ test_expect_success '2b-check: Directory split into two on one side, with equal
 #   messages are handled correctly.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 3: Path in question is the source path for some rename already
+#
+# Combining cases from Section 1 and trying to handle them could lead to
+# directory renaming detection being over-applied.  So, this section
+# provides some good testcases to check that the implementation doesn't go
+# too far.
+###########################################################################
+
+# Testcase 3a, Avoid implicit rename if involved as source on other side
+#   (Related to testcases 1c and 1f)
+#   Commit O: z/{b,c,d}
+#   Commit A: z/{b,c,d} (no change)
+#   Commit B: y/{b,c}, x/d
+#   Expected: y/{b,c}, x/d
+test_expect_success '3a-setup: Avoid implicit rename if involved as source on other side' '
+	test_create_repo 3a &&
+	(
+		cd 3a &&
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
+		test_tick &&
+		git commit --allow-empty -m "A" &&
+
+		git checkout B &&
+		mkdir y &&
+		mkdir x &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		git mv z/d x/ &&
+		rmdir z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '3a-check: Avoid implicit rename if involved as source on other side' '
+	(
+		cd 3a &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:x/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:z/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 3b, Avoid implicit rename if involved as source on other side
+#   (Related to testcases 5c and 7c, also kind of 1e and 1f)
+#   Commit O: z/{b,c,d}
+#   Commit A: y/{b,c}, x/d
+#   Commit B: z/{b,c}, w/d
+#   Expected: y/{b,c}, CONFLICT:(z/d -> x/d vs. w/d)
+#   NOTE: We're particularly checking that since z/d is already involved as
+#         a source in a file rename on the same side of history, that we don't
+#         get it involved in directory rename detection.  If it were, we might
+#         end up with CONFLICT:(z/d -> y/d vs. x/d vs. w/d), i.e. a
+#         rename/rename/rename(1to3) conflict, which is just weird.
+test_expect_success '3b-setup: Avoid implicit rename if involved as source on current side' '
+	test_create_repo 3b &&
+	(
+		cd 3b &&
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
+		mkdir y &&
+		mkdir x &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		git mv z/d x/ &&
+		rmdir z &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir w &&
+		git mv z/d w/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '3b-check: Avoid implicit rename if involved as source on current side' '
+	(
+		cd 3b &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
+		test_i18ngrep ! CONFLICT.*rename/rename.*y/d &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :1:z/d :2:x/d :3:w/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:z/d O:z/d O:z/d &&
+		test_cmp expect actual &&
+
+		test_path_is_missing z/d &&
+		git hash-object >actual \
+			x/d w/d &&
+		git rev-parse >expect \
+			O:z/d O:z/d &&
+		test_cmp expect actual
+	)
+'
+
+###########################################################################
+# Rules suggested by section 3:
+#
+#   Avoid directory-rename-detection for a path, if that path is the source
+#   of a rename on either side of a merge.
+###########################################################################
+
 test_done
-- 
2.14.2

