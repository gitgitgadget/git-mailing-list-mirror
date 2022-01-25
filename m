Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD668C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiAYWlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiAYWlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:41:09 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5A4C061747
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:09 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id n17so9662085iod.4
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o3cZnVO8w1c7TKCyj2ZX43g+cuHGhPEkV6O2CLZiv00=;
        b=enHy0Y90b54XbfTy8Y0wRnWJiTp0/dLHHZ8FH/jCSA/zcadqNtIv/HGaLwinsADtSY
         5S4DRn3ao9QR+jKLR8d0tFxlXlUR/fvQ1LsHFAOipg47tiIcu1KlSZzEXHunUON3Cw1K
         asE4r0YgJaU/ttJABZGpFAV0q7uvAh6KCaoTUjo8aEBB40t+lRw9gNiPuVYY8AZL7GmL
         aViueJ6s60JcgeoAQnFI8uqlwE8GomReLD77Sr7gAsT6OKLLhSKRXgM79suzT/4wX0ZP
         U0ApRGnE7SEx5afhjJveaeQyzevkKqcNGva9On10L0Z1vpIYd/gBYgRDPCNAcqx7omcz
         dDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o3cZnVO8w1c7TKCyj2ZX43g+cuHGhPEkV6O2CLZiv00=;
        b=acDx0QM/NmHZAZgmgctdJN7yzJ4fM02ANYhsSaAyXdlUAyZF90E4O+ZrdyL8Iz885F
         ssVmzSfaN08yeDTX2jZqRlSpU0tcalwbwnAmYyTy2TkPujpzQUSeZwE4Gt7ODMLFc6Mx
         zveuoBtt+UJtGBE/LnPAn8HyKkxBFOmYUTBRzdlJU8ypyBn5XoSmm2gav/bWTTDU5VA4
         YfLJNjiWmuZnMyPMpjTr4k1QoWpDwSX+wy61IITCZleyyakaPyKNoYCff9oohP3eVkJP
         iXscEB0mFASFcQkKjyGQuXcy79GM5sI/fjJHKkmckde0w8E/rbn5NZ0cKS0/cXkJa08/
         opVA==
X-Gm-Message-State: AOAM532Bx1lNSP4rWDxEV+QFFTrLj3Ssws41LU63sjSImlQhY6poqzbj
        Nq25iy8S5Z1PYjgg6LJikQprAvv4l5uqDw==
X-Google-Smtp-Source: ABdhPJxt+fMIR9+yYBcW0zkb8nh2ZZmlq0ulNHlwYHW+5gofkgpiiPrxwOtoUHrqI9X1DzHQRyyzRw==
X-Received: by 2002:a05:6602:2c0c:: with SMTP id w12mr12202931iov.125.1643150469210;
        Tue, 25 Jan 2022 14:41:09 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8sm10186314ilq.14.2022.01.25.14.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:41:08 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:41:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com
Subject: [PATCH v4 4/9] t5326: drop unnecessary setup
Message-ID: <80589d7ae6de8e33211916c7483ed9d9dd9c9ef9.1643150456.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1643150456.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core.multiPackIndex config became true by default back in 18e449f86b
(midx: enable core.multiPackIndex by default, 2020-09-25), so it is no
longer necessary to enable it explicitly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5326-multi-pack-bitmaps.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 353282310d..1a9581af30 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -19,10 +19,6 @@ midx_pack_source () {
 
 setup_bitmap_history
 
-test_expect_success 'enable core.multiPackIndex' '
-	git config core.multiPackIndex true
-'
-
 test_expect_success 'create single-pack midx with bitmaps' '
 	git repack -ad &&
 	git multi-pack-index write --bitmap &&
-- 
2.34.1.455.gd6eb6fd089

