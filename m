Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684C1C433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAD56134F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353409AbhJAKHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353285AbhJAKG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8116C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u18so14617275wrg.5
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vWqQaKK/VPFM0wvbIKSOyHH+DQv3Kzr8GXPKthuFnjY=;
        b=R2gpjvXMCQdqJ2hDIjNjsCBq8OiELt0UCxoD5NRVzYutyg6TlQccrignKOKemFQU26
         kYiu/dN3nkBqrIkyHlKbLsWi2hPyYl0qFgir5AvEyEpzBumNXom9deFWqc8wpeeyNumK
         Sjt43svfXVOWdDYZcPNBdaMMg/UQU43qRmOMND5J/7d4olBW1H/RpRU6Op1hVLV5CRet
         ZFMD0OYw8sof8BtCAJADTOmKIhmK/1le2fHak/R4rt1pQhiimtcCAFQm7lXKIQCtpg78
         vWXB/0rxEyPxR34jBeQKgdiYiRgouVAOGuQqO1XqyLRqTgO3ZXf++mBaPaX7WfvJJD5y
         GVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vWqQaKK/VPFM0wvbIKSOyHH+DQv3Kzr8GXPKthuFnjY=;
        b=oAUyAUcSgF5c1h62FHEp1mm3sccAeYH02tDXMaNIPBsNBkq35Gow+/1zLccZoYuUxV
         cTQ0H4DML1SbufBWDJWZJi/r1PthAgPz9ECY6SEMVzo0ixLLheFfbVVdyOdNuo8RzOSa
         MaJQhBju6BLXc77wzQsN7wQdyHKe4JLq0TmuLLKMBjh/DWB/5uADyrHnB4whiaRF3+bj
         RK9FHr0OfhsPzttSQlld6Z9HuTdqaFPYxpcWgvdCGTjGkv8z9oSBsmWOJU6ZqcBTZRN4
         X42LK2Ecs245SnUvOdp9WoWwgXiCavcqK0yTcwqdMFsTDIwFfnN8Z4SVHGzvW3eq+B4f
         NLfQ==
X-Gm-Message-State: AOAM531HYLV7vdK9c2aPFzGlq1OIcctuYGYP+j8PulCF+d0hzrSHZsg5
        Y/AZ0TUdSbDF1t6WO120yQ8d0sSCWkc=
X-Google-Smtp-Source: ABdhPJyaCLZk11Ggh7t7niBFQ0q3/VQEf6jWdmGNPiHE/KlP62hvQd9oFJkCYLPnAccFEMVrSbinzg==
X-Received: by 2002:adf:eb12:: with SMTP id s18mr11337878wrn.97.1633082705431;
        Fri, 01 Oct 2021 03:05:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l124sm7161048wml.8.2021.10.01.03.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:05 -0700 (PDT)
Message-Id: <c8f641132160d6bbd72a5e4921f1c9f0b3d40242.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:04:53 +0000
Subject: [PATCH 02/11] reset_head(): fix checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The reset bit should only be set if flags contains RESET_HEAD_HARD.
The test for `!deatch_head` dates back to the original implementation
of reset_head() in ac7f467fef ("builtin/rebase: support running "git
rebase <upstream>"", 2018-08-07) and was correct until e65123a71d
("builtin rebase: support `git rebase <upstream> <switch-to>`",
2018-09-04) started using reset_head() to checkout <switch-to> when
fast-forwarding.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reset.c b/reset.c
index 79310ae071b..fc4dae3fd2d 100644
--- a/reset.c
+++ b/reset.c
@@ -57,7 +57,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
-	if (!detach_head)
+	if (reset_hard)
 		unpack_tree_opts.reset = 1;
 
 	if (repo_read_index_unmerged(r) < 0) {
-- 
gitgitgadget

