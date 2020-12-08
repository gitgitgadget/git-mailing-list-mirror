Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0E5C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1AC423A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgLHAGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbgLHAGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:06:08 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD9EC061793
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:05:22 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id x16so17574656oic.3
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ctuYLhWvckLzSg3MCjV41UN7lDM7tbErVdpu0ikEr+4=;
        b=tyim3oOZe01QqFAM/RlTTsQ1rjkd95uK+MqA9bIwOoCt7qfR+RqpgNhEvTTPQKt2yK
         9AqGUa7VbN8wPQx0wt/0sd9oygzZsN7bel91wqDjIkVZLfQhf7S2PpHEa3dbutHEN/bJ
         SPHLBH6z2zhRIYp8NsOpwsxnPflm+tKKpASrfx3sECnX6MXd47RYbgHNQaZI4dBWOD45
         fl2+YwHztIirttkHBuC6ed3MOJOyTW0+5HGGtgN4shJ8bF3FmqJK4dLSUodKZGYGccZp
         WlFhodiK9ccWYWwl8AOPtN30XQrLyPlb20OBXQH5RNvVIThw7UioXTAQ3BsEplgh17n1
         U96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ctuYLhWvckLzSg3MCjV41UN7lDM7tbErVdpu0ikEr+4=;
        b=ESy3c0m3LGaPjZU5Ll2vbj/oadt4mjCqpV1qvJFTb3MPTDFZucVuqNzGu6CCJLF2lN
         NJhDQuCxU0qTI/JWcSfFrhS7X2WCjKQHsEVOjYHm0byW5IQRKKO9pXI+zoXw5rE2rvCl
         ZcUte6jAjIXJvMxajTWbKdbZchYa+6lmzWuwfeVo5Q6j21J/9NccF0wWbiQKEYU61olw
         JQgsIdsEMQReybwb4FB9/Id2Ubht8qCR5M0352JrW4AJmiTvO0aKf7TamzUJp/lSOMHt
         f7XWWxNh1E858IAINwCtONPAjMKsaNRfnkj+P07923yNW9YZjBgwiKSJ9X1xFiq7Bv+3
         lF7Q==
X-Gm-Message-State: AOAM533/UA16VIFMdQ1epcAu2eC1070AHXOSmy84z8PcKrv9zZWCJtaP
        0AJxGPQdM4mpDx4PhtMWIDTIt1fDQos/2SZQ
X-Google-Smtp-Source: ABdhPJynebarMuI4y0pb/RwgGQRzYcUE2nDq/k4Ce0Fca30jx2zBHa5CwJHPlI8UGn+e/M6BVbm4xg==
X-Received: by 2002:aca:f1c1:: with SMTP id p184mr990663oih.54.1607385921191;
        Mon, 07 Dec 2020 16:05:21 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d15sm2880285otk.62.2020.12.07.16.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:05:20 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:05:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 15/24] t5310: add branch-based checks
Message-ID: <c2cae4a8d0a000b1c42f1617c9872b6cbf00babd.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The current rev-list tests that check the bitmap data only work on HEAD
instead of multiple branches. Expand the test cases to handle both
'master' and 'other' branches.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5310-pack-bitmaps.sh | 61 +++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 8a2a3b2114..b1248f1cc8 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -41,63 +41,70 @@ test_expect_success 'rev-list --test-bitmap verifies bitmaps' '
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
 		git rev-list --count other...master >expect &&
 		git rev-list --use-bitmap-index --count other...master >actual &&
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
+	for branch in "master" "other"
+	do
+		rev_list_tests_head
+	done
+}
+
 rev_list_tests 'full bitmap'
 
 test_expect_success 'clone from bitmapped repository' '
-- 
2.29.2.533.g07db1f5344

