Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33BD1F516
	for <e@80x24.org>; Sun,  1 Jul 2018 01:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeGABZf (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 21:25:35 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46793 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbeGABZT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 21:25:19 -0400
Received: by mail-ot0-f194.google.com with SMTP id v24-v6so13840874otk.13
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 18:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iRrSI2hizyLgQFbbRmz++2IJV6pFi1JUJG7eRuLwLEg=;
        b=shQpTyGyzf/98CfUn/eCX3hUUwt4da9blf24AWe2CugeG6cvbUtoxOyNegAQJQaMnW
         KUG9Ue1ObTaHl6AKx7ymaPAzz1kYBuwLVdKC+0ukj8X6bvdGIDhWzZm9DdqGsjmgQaGn
         fW6vwACvLoAlDUKQgEc4VLd4e+jXvpZ/dzC7xDRXXvjqi8zkspER8MC4yPqxAocT+hfG
         OOYb7zell/LIkTYU9fyys6NE6Bd5o3iWuC3avHhnnUH++x1IYGiXLD3SRZk3Ru6csqFW
         /1witi5quTB9CxpfQILhII+FBs2+GXaOnntgeIgs/gJjS3+beMM8dbG28I4NseQoREDD
         5mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iRrSI2hizyLgQFbbRmz++2IJV6pFi1JUJG7eRuLwLEg=;
        b=Ec+2yWTOpTswiJqvXBT0bf9ld4RJinUyeYI3ySt3oPdQPeWkEITieqPVKZyfTJUrPJ
         wAftZQsmjYsYrSc5e8RTX/LHZRH1gBtxgz1g0HITMpxV/xtnaD+xZoEVgv4MZcEzREHN
         NJVB6wOCdxAVUKdhWLsLOLDp36C5e0K4x9+tMaX5xyhuHHSSHNwJYwNpH4aDsNsDkkC8
         vIVZV2DKN2gNRfV8IzQQC1P+IsuBG941CNM2Dp/ZTUzjF8l5AqJbdsHhjEcMxWoJKF/y
         OTVUvZbKoQKpaej98CHalCKL57RiMHm/E14oUueUcVlElM0i9zyEFkpc+0KiEKtboQGk
         G4pg==
X-Gm-Message-State: APt69E3pHsWuYeCMjqpZxFYPPU8sqb3jy7GhV4nGQ0zCeOHsM4VNh3Rg
        k1rR32P05hDe5jpienliKE1AZA==
X-Google-Smtp-Source: AAOMgpfNgmXkpbLHupjtGES1EHLeVR4rJff5UJ5V6jf+h8M4A9trXvB6DsRewBB4gS1w9grdV73faQ==
X-Received: by 2002:a9d:2e2f:: with SMTP id q44-v6mr2256198otb.72.1530408318592;
        Sat, 30 Jun 2018 18:25:18 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id g20-v6sm3509394ote.38.2018.06.30.18.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 18:25:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 7/9] t6044: add more testcases with staged changes before a merge is invoked
Date:   Sat, 30 Jun 2018 18:25:01 -0700
Message-Id: <20180701012503.14382-8-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.137.g2a11d05a6.dirty
In-Reply-To: <20180701012503.14382-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
 <20180701012503.14382-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to Documentation/git-merge.txt,

    ...[merge will] abort if there are any changes registered in the index
    relative to the `HEAD` commit.  (One exception is when the changed
    index entries are in the state that would result from the merge
    already.)

Add some tests showing that this exception, while it does accurately state
what would be a safe condition under which we could allow the merge to
proceed, is not what is actually implemented.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6044-merge-unrelated-index-changes.sh | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index 1d43712c5..e609f14f8 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -137,6 +137,35 @@ test_expect_success 'merge-recursive, when index==head but head!=HEAD' '
 	test_i18ngrep "Already up to date" out
 '
 
+test_expect_failure 'recursive, when file has staged changes not matching HEAD nor what a merge would give' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	mkdir subdir &&
+	test_seq 1 10 >subdir/a &&
+	git add subdir/a &&
+
+	# HEAD has no subdir/a; merge would write 1..11 to subdir/a;
+	# Since subdir/a matches neither HEAD nor what the merge would write
+	# to that file, the merge should fail to avoid overwriting what is
+	# currently found in subdir/a
+	test_must_fail git merge -s recursive E^0
+'
+
+test_expect_failure 'recursive, when file has staged changes matching what a merge would give' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	mkdir subdir &&
+	test_seq 1 11 >subdir/a &&
+	git add subdir/a &&
+
+	# HEAD has no subdir/a; merge would write 1..11 to subdir/a;
+	# Since subdir/a matches what the merge would write to that file,
+	# the merge should be safe to proceed
+	git merge -s recursive E^0
+'
+
 test_expect_success 'octopus, unrelated file touched' '
 	git reset --hard &&
 	git checkout B^0 &&
-- 
2.18.0.137.g2a11d05a6.dirty

