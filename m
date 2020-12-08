Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B0EC2BBCD
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D56222B3
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgLHWFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730781AbgLHWFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:05:07 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D468C06179C
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:04:21 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id y74so166730oia.11
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ULT/P2uDpVwqEmdBgLYbNeuKth8g/ttngXB8MGQmitc=;
        b=SmFN+dtWoZ/86hxiy7bwz7jXyVlARAa5S46kr5bFuS9Qf6rHHP/w0mhUmDh+zXfMcj
         /o0tu0N37RFKjeQKoM6qZ7nnNHd+F96vkPpR3fIMTEuhjA1ZQ+dgqqmvIkcqE+VcheQ1
         xJcyPVHBe81wjsg10PcmQYliVHAzATJ79wdR7Ro7Jsjt5UfJT8oOhCDgntIYE+B79NQ9
         Her/mW5Vi5RvEZ9L2pF9t9SgN+qeVFKaGeaVlcO44KaDT1EL/k5YCLOEv7WQj/jXqvSE
         jjiwiaGlpZUeyj0QE6gJ6Pv58zuBbHKAzd1dB5fXihlEnyoPTTlLerWsCrm7nnMduF2D
         HtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULT/P2uDpVwqEmdBgLYbNeuKth8g/ttngXB8MGQmitc=;
        b=ONJZtSsvfrZDX5BXQFInHYIAlFemWLbUWXm2S2635T3I8u/v1kyNbjd7wbbRl7dO3Z
         dnYXao5NhM1UsVAqAqPgsMmoQXn2L9wdSrL0avVhnzvLkYvvPysMLJVSlBrJA25bEHYV
         n5rQiCJijpvxV8+gpccxWODwXA5RfBiDorHYfpMMQqYNBizBfoFcrsd+Qu2F7Tq8epHY
         JzgalUSU4FSlkpq1WJmtZjCPIxnEGYeToiItqaS0Uerh3TNmSi6s0z/OrHInkMn04scs
         C3+QQILC/pt99dc8sYoblltEVCdhvs1L2SLELKH4PSarze/IyAnF2JPcMqseaGvLhwj7
         kPfw==
X-Gm-Message-State: AOAM531hgiyccO6Aly07iObALKg+W1lfsIxRDqGODofm4x+OGCygO8w/
        S97GLV/Fs2Wag4A0l/2sDJZseLeLYfKmH5uj
X-Google-Smtp-Source: ABdhPJwyAqO6N1azhIM0nl7diKgZhpQwFUe70ncFD41AdkwqXEs4bVPJcWz41M3RmQJasmVw9YldsA==
X-Received: by 2002:aca:4d8b:: with SMTP id a133mr4537785oib.79.1607465060159;
        Tue, 08 Dec 2020 14:04:20 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id j15sm16898ota.39.2020.12.08.14.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:04:19 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:04:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 15/24] t5310: add branch-based checks
Message-ID: <76071f9f4e04c67bf8b4191df880aa5bfd3348c8.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The current rev-list tests that check the bitmap data only work on HEAD
instead of multiple branches. Expand the test cases to handle both
'master' and 'other' branches.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5310-pack-bitmaps.sh | 61 +++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index bf094cfe42..8bf02336d9 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -42,63 +42,70 @@ test_expect_success 'rev-list --test-bitmap verifies bitmaps' '
 	git rev-list --test-bitmap HEAD
 '
 
-rev_list_tests() {
-	state=$1
-
-	test_expect_success "counting commits via bitmap ($state)" '
-		git rev-list --count HEAD >expect &&
-		git rev-list --use-bitmap-index --count HEAD >actual &&
+rev_list_tests_head () {
+	test_expect_success "counting commits via bitmap ($state, $branch)" '
+		git rev-list --count $branch >expect &&
+		git rev-list --use-bitmap-index --count $branch >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "counting partial commits via bitmap ($state)" '
-		git rev-list --count HEAD~5..HEAD >expect &&
-		git rev-list --use-bitmap-index --count HEAD~5..HEAD >actual &&
+	test_expect_success "counting partial commits via bitmap ($state, $branch)" '
+		git rev-list --count $branch~5..$branch >expect &&
+		git rev-list --use-bitmap-index --count $branch~5..$branch >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "counting commits with limit ($state)" '
-		git rev-list --count -n 1 HEAD >expect &&
-		git rev-list --use-bitmap-index --count -n 1 HEAD >actual &&
+	test_expect_success "counting commits with limit ($state, $branch)" '
+		git rev-list --count -n 1 $branch >expect &&
+		git rev-list --use-bitmap-index --count -n 1 $branch >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "counting non-linear history ($state)" '
+	test_expect_success "counting non-linear history ($state, $branch)" '
 		git rev-list --count other...second >expect &&
 		git rev-list --use-bitmap-index --count other...second >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "counting commits with limiting ($state)" '
-		git rev-list --count HEAD -- 1.t >expect &&
-		git rev-list --use-bitmap-index --count HEAD -- 1.t >actual &&
+	test_expect_success "counting commits with limiting ($state, $branch)" '
+		git rev-list --count $branch -- 1.t >expect &&
+		git rev-list --use-bitmap-index --count $branch -- 1.t >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "counting objects via bitmap ($state)" '
-		git rev-list --count --objects HEAD >expect &&
-		git rev-list --use-bitmap-index --count --objects HEAD >actual &&
+	test_expect_success "counting objects via bitmap ($state, $branch)" '
+		git rev-list --count --objects $branch >expect &&
+		git rev-list --use-bitmap-index --count --objects $branch >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "enumerate commits ($state)" '
-		git rev-list --use-bitmap-index HEAD >actual &&
-		git rev-list HEAD >expect &&
+	test_expect_success "enumerate commits ($state, $branch)" '
+		git rev-list --use-bitmap-index $branch >actual &&
+		git rev-list $branch >expect &&
 		test_bitmap_traversal --no-confirm-bitmaps expect actual
 	'
 
-	test_expect_success "enumerate --objects ($state)" '
-		git rev-list --objects --use-bitmap-index HEAD >actual &&
-		git rev-list --objects HEAD >expect &&
+	test_expect_success "enumerate --objects ($state, $branch)" '
+		git rev-list --objects --use-bitmap-index $branch >actual &&
+		git rev-list --objects $branch >expect &&
 		test_bitmap_traversal expect actual
 	'
 
-	test_expect_success "bitmap --objects handles non-commit objects ($state)" '
-		git rev-list --objects --use-bitmap-index HEAD tagged-blob >actual &&
+	test_expect_success "bitmap --objects handles non-commit objects ($state, $branch)" '
+		git rev-list --objects --use-bitmap-index $branch tagged-blob >actual &&
 		grep $blob actual
 	'
 }
 
+rev_list_tests () {
+	state=$1
+
+	for branch in "second" "other"
+	do
+		rev_list_tests_head
+	done
+}
+
 rev_list_tests 'full bitmap'
 
 test_expect_success 'clone from bitmapped repository' '
-- 
2.29.2.533.g07db1f5344

