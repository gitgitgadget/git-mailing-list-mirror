Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCE4C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509BD2075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxpep1eU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbgAXVTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:19:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41193 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbgAXVTs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:19:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so3694381wrw.8
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pl9kK0IVJdtZMHXu52/f8Sm0g3stqkcV9VxPh4NkuJo=;
        b=Lxpep1eUBp9JchdGWVLWu+l3WlLs8VNjesKeDidIgl8i2n/j/d+r8S3Lp3U5u09FRn
         HAf91MZp7RECi16NlCYbt74Pom+r9VeDNf+QPEaUhqVSf1/PJ3fQXoi/89tHCyd6MMq4
         p90cvWeYPVKlKJqrJ7SndcQCHvLJ//UOX6rfHJk6/RSnSuksEbBYOj7oKHWvpWByn4li
         iQujC+CVlKtujB6E5dLlaKUsEqE3M/imhF4v7b0736v1pC6KIRmv64aV+TYvO66F+p+A
         UTLE30c+VzeD2NQulDKmHxEf/XHChTBSA8eXqQlMqO04rRGhAxLrvRYgtDaAPAN/havW
         vlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pl9kK0IVJdtZMHXu52/f8Sm0g3stqkcV9VxPh4NkuJo=;
        b=Y/UAIC0Nuj3tSS/rBMDbpLx+AkwdYZg9oJAsYZ12ov456Vdpjfyd1dDAil1Dz4psvJ
         XM1OcbwoarR/FJ3gHKbmlvelsQ4lXzV1rRDi5ow2tu4hjoHklhSbBBeV8t8zyuL9Hjvu
         nksKlVrkxtBKcUzJ8fXOsOAGF0f5WnbRwvY3oQUio802OG/AjLim0HWhgzAwDlLK9DFO
         otcghVie4cFMw/ecNzx8q2oBoN/tQCSF5ZT6LbvWTuUvahQ1yDjeFjRgQ8hxY5ztEAjA
         LPAgkRhF3d/PIgb70LqONb/14CClzhI/vXu2hZXhRVxy/eh5HUxrenMv1cpbfRwBYpBg
         KR+g==
X-Gm-Message-State: APjAAAXrog/KXI5reGnXQyCzvhiileVGGpKIeX3IM5/hfPHrY9kcmXu8
        +CZU3lz69fA55PbG/KLiMFynBCQh
X-Google-Smtp-Source: APXvYqwx2Feha4Z5mzypL8XhrsSa30Su6vjZZVA1H8Ee3LWVMd/bRM8P6akSYHLY1SfyW2Tm8vgOYQ==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr6116054wrn.133.1579900787355;
        Fri, 24 Jan 2020 13:19:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b137sm8711166wme.26.2020.01.24.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 13:19:47 -0800 (PST)
Message-Id: <ae78c3069b08557e3acc544601c71ee932ace19d.1579900782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
        <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 21:19:35 +0000
Subject: [PATCH v2 05/12] sparse-checkout: fix documentation typo for
 core.sparseCheckoutCone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 3b341cf0fc..4834fb434d 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -106,7 +106,7 @@ The full pattern set allows for arbitrary pattern matches and complicated
 inclusion/exclusion rules. These can result in O(N*M) pattern matches when
 updating the index, where N is the number of patterns and M is the number
 of paths in the index. To combat this performance issue, a more restricted
-pattern set is allowed when `core.spareCheckoutCone` is enabled.
+pattern set is allowed when `core.sparseCheckoutCone` is enabled.
 
 The accepted patterns in the cone pattern set are:
 
-- 
gitgitgadget

