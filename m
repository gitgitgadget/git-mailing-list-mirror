Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C787C33C9C
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F275E206DA
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2nzkk/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKUWFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43598 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfKUWFE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so6270976wra.10
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jp9fCPiVi8uv07s6DelseXp9idVSa4eBTh9PuKubi+E=;
        b=k2nzkk/G3edVtdwPWaMBa2iMgwUiy4x4HaObAlxhFlOdSIZDkzef2VR0S8K4lxjZC1
         JOdj1u5J8iV7HUI6VMb/McOYXDWpNOMMPHsHQH49xuCG3GkwEzviqpIlgoRmbK6lTvkW
         exyJnxjniI+X4ybcdoW3nKAsqGhAeYpQugBaP/TKXMBukmBSPdJbtQthjFxln5gV7F1M
         VqtW+ngj/Gk3v2ERqSZfUysOEQ9yYIlN4t3jBCRNfohOp7/IWGNfKcVoidKPobTgq1QD
         8px+9Hxk/c/PyMkbGF6bzD99AnqiEm+sqR2SfiHLyUS6cziOxUUw3QL3nX5FpwK3SO6d
         Ca/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jp9fCPiVi8uv07s6DelseXp9idVSa4eBTh9PuKubi+E=;
        b=ahY+E6HZVxAS1hCVOkymNBdAhMqH4+RqkA7JlGowh9ahAeYOAvD07//YCAYsHCAzMd
         I4xKBvWnc9/XZvCGbfVa9DsxMVJpnKkDmOchDpEPIHJvbu09eMhkjbWoBSnPj0qnLcDc
         I1StMeancGSq+J0s+v45rCnfGFax9pXw+Q4yOKY6fo9ZDb8GelL1Y2pvTJmGIDnBtVTI
         Wzt9/lNg19BN7qvv2CHhbM8zZYnfxB2Oailu3p7CH5K4iYg/ZVjqAstcu/gITI6Ot4xJ
         /yvHU639wyuZuO0lHk2IDZkzFb9hWbm1Qp0AB6pgmoalwrubVZM7yxX7hNkPa75BVMON
         9dsQ==
X-Gm-Message-State: APjAAAWaVFAEFs1st4bO3U69c2BCTuhBJIogjyjP/RcOh76bUwtxSo5b
        09TUZzcEWBC1DfGBa2JqrwJwSp9F
X-Google-Smtp-Source: APXvYqyLihRzApO5OE1K126Z785ENDIehVI23aHsHfNdTBaYytu9z5FOhzXoZIj9As5MSUdIaKpgWQ==
X-Received: by 2002:a5d:4946:: with SMTP id r6mr6281050wrs.155.1574373900217;
        Thu, 21 Nov 2019 14:05:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm5024989wrq.97.2019.11.21.14.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:04:59 -0800 (PST)
Message-Id: <0bc87c1a88f5419a9e11681e1d3c079b2426def2.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:39 +0000
Subject: [PATCH v6 07/19] trace2: add region in clear_ce_flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

When Git updates the working directory with the sparse-checkout
feature enabled, the unpack_trees() method calls clear_ce_flags()
to update the skip-wortree bits on the cache entries. This
check can be expensive, depending on the patterns used.

Add trace2 regions around the method, including some flag
information, so we can get granular performance data during
experiments. This data will be used to measure improvements
to the pattern-matching algorithms for sparse-checkout.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 33ea7810d8..01a05ff66d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1407,15 +1407,23 @@ static int clear_ce_flags(struct index_state *istate,
 			  struct pattern_list *pl)
 {
 	static struct strbuf prefix = STRBUF_INIT;
+	char label[100];
+	int rval;
 
 	strbuf_reset(&prefix);
 
-	return clear_ce_flags_1(istate,
+	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
+		  (unsigned long)select_mask, (unsigned long)clear_mask);
+	trace2_region_enter("unpack_trees", label, the_repository);
+	rval = clear_ce_flags_1(istate,
 				istate->cache,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
 				pl, 0);
+	trace2_region_leave("unpack_trees", label, the_repository);
+
+	return rval;
 }
 
 /*
-- 
gitgitgadget

