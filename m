Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84BE1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbdL1EPr (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:47 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:37478 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753225AbdL1EOF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:05 -0500
Received: by mail-io0-f195.google.com with SMTP id n14so13892033iob.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H8/IncnGGbE9QOeeDr/Jc48CXkxG72A4Q3NbT4P+6tg=;
        b=a3s5PdhsmvjrCEdmQo5JCJZZb9DgbF6BqwU+s7MkUZuv4/t3kM8x2FsqvqHiJIYouV
         GgVaa6FXCWIgA0CjXfkcuNYZ6kQFbdJRtQcTbOJ1jQujSM8zgVk/HCjtPyBURjNbvtcY
         z7EX3SCY5N6YerKlxcdyJUum9cWCVK4mwWxkXiNUTC51wce119se/xv4fUy8GgsngGz5
         jRBs+0/CAUgdBSerpepILij9A9WJXrpuPSKqD2cGa8qv5aXNyb8ntjc9XAgpGX5Gl0GZ
         juQ0DSJvGkMlellQGzfsNLQnc1rJH8rMTrFP2CQXCDYzwKZ9Fv3kOZkAIPKtiyan5kGj
         Eweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H8/IncnGGbE9QOeeDr/Jc48CXkxG72A4Q3NbT4P+6tg=;
        b=o5TMy37XCJ1i/Of3oWkcwR1IEILE4Lxa6I82a6QxTo3ijMiItEa3Cu5l4jgobz8FAn
         pPUvQscUahGWLZ/ESJyMMn0r0n6pbIOdgZjY786knn1A/fSAcPFsSrMm1BpoX5u6v3X9
         78WpmPd9b6Xj+W2/p0kff9vEO08LP4QJswgPVZWF5AV38J+kkuOULoIFUJY6umtMr2GZ
         E7H6L4HK1TaiTpqvIK+k0/Lfsg75Jb24cU6oZ1Xgp+BOT7VI5duhn2dIPs1DC8jB2GtY
         +PAugUQQBMJEWR11dyxcoCbv1hgsrA4SrTqgPQdaH7Olgdxh7oFnuhk0ICG06juVz33O
         AG+g==
X-Gm-Message-State: AKGB3mK+I8vtt81rspWs3c8nne5m5ukV21P2P9y0hoNPbTSBRqBVdoug
        SHS4Un0k30KcYGzqovB7mpb1DQ==
X-Google-Smtp-Source: ACJfBotMysLtgvBbWajXbXH/wjiwPYWb+Y5osYY8y7WePdhhZoHfxlSuNhDG7aXVdChU0KyqscBgZw==
X-Received: by 10.107.25.132 with SMTP id 126mr39726841ioz.173.1514434444691;
        Wed, 27 Dec 2017 20:14:04 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:03 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 05/34] directory rename detection: directory splitting testcases
Date:   Wed, 27 Dec 2017 20:13:23 -0800
Message-Id: <20171228041352.27880-6-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 137 ++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index d8ead7c56..acf49d6b4 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -427,4 +427,141 @@ test_expect_failure '1f-check: Split a directory into two other directories' '
 #   in section 2, plus testcases 3a and 4a.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 2: Split into multiple directories, with equal number of paths
+#
+# Explore the splitting-a-directory rules a bit; what happens in the
+# edge cases?
+#
+# Note that there is a closely related case of a directory not being
+# split on either side of history, but being renamed differently on
+# each side.  See testcase 8e for that.
+###########################################################################
+
+# Testcase 2a, Directory split into two on one side, with equal numbers of paths
+#   Commit O: z/{b,c}
+#   Commit A: y/b, w/c
+#   Commit B: z/{b,c,d}
+#   Expected: y/b, w/c, z/d, with warning about z/ -> (y/ vs. w/) conflict
+test_expect_success '2a-setup: Directory split into two on one side, with equal numbers of paths' '
+	test_create_repo 2a &&
+	(
+		cd 2a &&
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
+		mkdir y &&
+		mkdir w &&
+		git mv z/b y/ &&
+		git mv z/c w/ &&
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
+test_expect_failure '2a-check: Directory split into two on one side, with equal numbers of paths' '
+	(
+		cd 2a &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:w/c :0:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/d &&
+		test_cmp expect actual &&
+		test_i18ngrep "CONFLICT.*directory rename split" out
+	)
+'
+
+# Testcase 2b, Directory split into two on one side, with equal numbers of paths
+#   Commit O: z/{b,c}
+#   Commit A: y/b, w/c
+#   Commit B: z/{b,c}, x/d
+#   Expected: y/b, w/c, x/d; No warning about z/ -> (y/ vs. w/) conflict
+test_expect_success '2b-setup: Directory split into two on one side, with equal numbers of paths' '
+	test_create_repo 2b &&
+	(
+		cd 2b &&
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
+		mkdir y &&
+		mkdir w &&
+		git mv z/b y/ &&
+		git mv z/c w/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir x &&
+		echo d >x/d &&
+		git add x/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '2b-check: Directory split into two on one side, with equal numbers of paths' '
+	(
+		cd 2b &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 >out &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:w/c :0:x/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:x/d &&
+		test_cmp expect actual &&
+		test_i18ngrep ! "CONFLICT.*directory rename split" out
+	)
+'
+
+###########################################################################
+# Rules suggested by section 2:
+#
+#   None; the rule was already covered in section 1.  These testcases are
+#   here just to make sure the conflict resolution and necessary warning
+#   messages are handled correctly.
+###########################################################################
+
 test_done
-- 
2.15.0.408.g8e199d483

