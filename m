Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8F4C433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D57420716
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRW1EXjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgHHRBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgHHRB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 13:01:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5CCC061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 10:01:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 3so4601343wmi.1
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ofr+Hu5Tf6QDtMLwZu0ctJ5oDIF3fKZrk4aVgYXKZ84=;
        b=FRW1EXjl8rQ9exDkcdfLO1lOLvS7slZEOukup2D5KCJG5ETT7w+C2mxsFb8mHC1AQu
         M6PBbOc9vDUzguuGKOMh+HKf1c+RMWp4bOg5DnUg56Bej21F+Ck4LvjQoDqlg4T8yFGJ
         j2PFi0aI1hf5Aptt5uQ7KMBjZjx+yJbTrwAQGU605Gms84VjD3SkD0r5lnYs7FUb2Eg7
         0NLxl9iEeKdRMrQtwonORS7U6y4oFYScxOM1p0uzG5Hb26lq7eWuS/0s4GvOqfMci4w8
         fATxLWQk2Es8DASBXVzPowXDvOzQyUz7hA4Cq1FL/2vPPo7VJf9IM9JLb/fNWZSyQ0aF
         pDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ofr+Hu5Tf6QDtMLwZu0ctJ5oDIF3fKZrk4aVgYXKZ84=;
        b=iiJkRR0cvgY3zLPcxkICO/wTgeIU98ZJYicQsi7EXdA16TkpRmOQwyrZP6p7AT1S1P
         BuwFWsNeFqTjAd375TqXZ/wvmYPrPV8EDIVOCXUYGxQT2KmwPWLp2wPOFOZbtcj0OtbC
         40/HZ4SPxh6QMu2Oiu95a96mWKUdv8D3f4vGbW1GrlCdmk1VXcqKOIhPwHLIEpy5El2a
         aQYKt8X8eh6GCRN2oo8iaO83KdfGeTZVop6bq0fY/30RiIG1SIe+3j2fs8CxYufW2b29
         XTD0cZUafzwqv6zeyGDrHkwGQ3vsqVaCr5H3kh3nQBxelxDUS8Stsu/fjrBarj9UKPmV
         cDAw==
X-Gm-Message-State: AOAM530YQvuPTVBw99OEgHj5P42cZdZmTdCOTNMtxRNge0+tnssv/RiL
        T9IKT+8SozF8jaChtD+EoiqRtRWg
X-Google-Smtp-Source: ABdhPJwGu6Nl6ZCbjPPsvjZzaiITxgk82y+drFHFpNo+XxZiPRPPIYkOr3npRaXPPgLYSsAo2qkOCA==
X-Received: by 2002:a05:600c:414e:: with SMTP id h14mr8683022wmm.41.1596906085655;
        Sat, 08 Aug 2020 10:01:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm14731083wru.64.2020.08.08.10.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 10:01:25 -0700 (PDT)
Message-Id: <7f408b7d4069403b969d334f4940ebf87f1dc797.1596906081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
        <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Aug 2020 17:01:12 +0000
Subject: [PATCH v2 03/11] t6422: fix bad check against missing file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6422-merge-rename-corner-cases.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index f163893ff9..7da75c1736 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -906,7 +906,7 @@ test_expect_failure 'rad-check: rename/add/delete conflict' '
 		git rev-parse >expect \
 			B:bar  A:bar  &&
 
-		test_cmp file_is_missing foo &&
+		test_path_is_missing foo &&
 		# bar should have two-way merged contents of the different
 		# versions of bar; check that content from both sides is
 		# present.
@@ -974,8 +974,8 @@ test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 		git rev-parse >expect \
 			O:foo  O:bar  &&
 
-		test_cmp file_is_missing foo &&
-		test_cmp file_is_missing bar &&
+		test_path_is_missing foo &&
+		test_path_is_missing bar &&
 		# baz should have two-way merged contents of the original
 		# contents of foo and bar; check that content from both sides
 		# is present.
-- 
gitgitgadget

