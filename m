Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18AEC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B122467F
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be9I1Hny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfLSV2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:28:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42037 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSV2c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 16:28:32 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so6298059edv.9
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 13:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H1rfc3Xakcj/y7/qH6kpuw834RYNToBjdWGDvsRGWdg=;
        b=Be9I1Hnym8k1pBm8KNIgTAARpJiut0zWKEbm6sPjqgQf30SvKaWgdjmWSKeC83Ai/L
         8sLZ5TprAiraOMujLUrH1DjKL6b3TYSGMD/LSEsGcY1vrmc81Dcmp/5PaRCQf1YmXNWK
         J3qbRK8JrModu/7BLmZ01IAPRjd7eJYoXmXYpJbIyEiQVWeCvJcy4PXKoqQM4qv6KJMW
         moa/m28Lfc3VIE/sH1lcrKBPLEPNOV6ci1dZDctAI8B2YuwNDTwOH6s/heamJ7nnoBz0
         67pVvU6IjmSiozTj9/+mfAEpnhNkksGDCd4TdcTrgWCNDMls69PoVHgESbewhW4viJxj
         uMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H1rfc3Xakcj/y7/qH6kpuw834RYNToBjdWGDvsRGWdg=;
        b=LvsUHVo3BQ3Kb/kdUHFF6iaNUhz0RFaPNmcqtqbOKxGjP68owQMjlREAnpHEVoop6C
         USWKgJlv+cjS2+7aZitbCklAZJ15Ld8ea4XJJrQPb4W0FCPoT5D0paLu69s+cG9WxU6k
         oqgjPlwbmM52h8jrMo4em9MtJeTWCEFvLwaWq9xEroSffxlRbTYBJtWtqqLjBrQpNfdq
         YidRfWeRwCXFzVrELPVfestogBL5CtMERgm7f2q5xhwILlXr90xjGx2BYrl8bLUpgpam
         RvY+8tktmjZOQBjx5bR26jJ/JxgZqVrApp7BCAVPO3kFhsrDhtIJM/clyRxDeidzPXLy
         9ELw==
X-Gm-Message-State: APjAAAXDfg77jJigST0j39xLNZNN0/rs599pamBOYqpqwLsajT3VaRSF
        op/lOXDiW/0ZJotcDCZiaDjDlEsa
X-Google-Smtp-Source: APXvYqxBGKnAVU5TdSBM7UPxqYZfKurWyIrKjI1eDRtWvYEmcyi+mX5HANtowU1oFWnNU1dH0wX5PQ==
X-Received: by 2002:a17:906:7e41:: with SMTP id z1mr11865966ejr.23.1576790911016;
        Thu, 19 Dec 2019 13:28:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24sm679211edr.83.2019.12.19.13.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 13:28:30 -0800 (PST)
Message-Id: <d6f858cab122869425f5801d98713bcbb6d00334.1576790906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
References: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
        <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 21:28:21 +0000
Subject: [PATCH v5 3/8] dir: remove stray quote character in comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 0dd5266629..5dacacd469 100644
--- a/dir.c
+++ b/dir.c
@@ -373,7 +373,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		    !ps_strncmp(item, match, name, namelen))
 			return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 
-		/* name" doesn't match up to the first wild character */
+		/* name doesn't match up to the first wild character */
 		if (item->nowildcard_len < item->len &&
 		    ps_strncmp(item, match, name,
 			       item->nowildcard_len - prefix))
-- 
gitgitgadget

