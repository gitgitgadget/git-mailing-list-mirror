Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D980EC48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C218060FE9
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhFUW1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhFUW1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:21 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5B2C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:06 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id v3so11905433ioq.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dj8bSAAyMgcbrNeyMR+hYayZQXjJBIgzVAauMYnE+HQ=;
        b=Ly8drg4DEbUKn+Uolci2SeZGJT6f3bTo1jxOpCJWtUdk+9eBPtZ/zkd57YbI68uw7f
         k8bqFWmMtlLdeATK4PolMLYN8qUiQGFxBXFZg9UYzMSCIdKYqm+k3M3SN9a9DQf4fYHZ
         oPhQijgldeH2dMGNz1d65bVrswxkROvZIvm27xcGd82HjoQVwwBzVMixfyeyLP75SRR0
         ZOROB6zIBpC7NEQyZwALaeVo4XBJeEUKaF8Je98nCHyFnn0Zhlyzjch4DksAy7jNKoNv
         lxmemwWJ0TScFJrmQ6XH11zE+wwD6b20cQepBfX5SZRdKlpnpcA8d7kdkHvhFim9y+MH
         l7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dj8bSAAyMgcbrNeyMR+hYayZQXjJBIgzVAauMYnE+HQ=;
        b=iNVkHa4YdrO6GcT3gR/joHjDq9jVzn6FkwSUk7d7JhmrT5Fp3J/hCebYvsMEWsuUwS
         PtK9Z7a3Hu4ljxRhEz4Sh0eoHLfG9HCEeJiYFM7o5Wb7O9mdwnyOWxrlr0fmBvPRZT0j
         XeEIOoCrTS1/S9FrXGvAI7kPIpakoiYJ4FBvoflYnvVafjHhwzdqFasi8iNtkY0PgX1H
         5v8Ux1+9JS4zbVH/fxvZO8y68HANbcrm8YURFgay7aUlukRSCOnL6xDv7EBXQZmBi5CD
         5zq7NYSoLrowdkOK9nqiH5p7Nr0eZontIfqwgeCX6N+zzXqUgaE1jGRAPS/1B7HW2J8b
         ynPQ==
X-Gm-Message-State: AOAM533FH1qOyaCylNUj/RADGCs8XVzzYEIMtJwC72cy+OOhLwDi22t9
        d/5CVcIDTFid6yshkGqZDS4cf4YJYfgy17XD
X-Google-Smtp-Source: ABdhPJxt8kb2L1RWp4U7yvXh86QzVUBnjGgdncBoT7SGlJvoz81hWpFaglEeOGvEqa8JNqTdlhl+Eg==
X-Received: by 2002:a5d:9f11:: with SMTP id q17mr240111iot.62.1624314305682;
        Mon, 21 Jun 2021 15:25:05 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id j2sm6399093ilr.45.2021.06.21.15.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:05 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 03/24] pack-bitmap-write.c: free existing bitmaps
Message-ID: <490d733d121e206ccdc335812c03f31c380bcd86.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new bitmap, the bitmap writer code attempts to read the
existing bitmap (if one is present). This is done in order to quickly
permute the bits of any bitmaps for commits which appear in the existing
bitmap, and were also selected for the new bitmap.

But since this code was added in 341fa34887 (pack-bitmap-write: use
existing bitmaps, 2020-12-08), the resources associated with opening an
existing bitmap were never released.

It's fine to ignore this, but it's bad hygiene. It will also cause a
problem for the multi-pack-index builtin, which will be responsible not
only for writing bitmaps, but also for expiring any old multi-pack
bitmaps.

If an existing bitmap was reused here, it will also be expired. That
will cause a problem on platforms which require file resources to be
closed before unlinking them, like Windows. Avoid this by ensuring we
close reused bitmaps with free_bitmap_index() before removing them.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index d374f7884b..142fd0adb8 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -520,6 +520,7 @@ int bitmap_writer_build(struct packing_data *to_pack)
 	clear_prio_queue(&queue);
 	clear_prio_queue(&tree_queue);
 	bitmap_builder_clear(&bb);
+	free_bitmap_index(old_bitmap);
 	free(mapping);
 
 	trace2_region_leave("pack-bitmap-write", "building_bitmaps_total",
-- 
2.31.1.163.ga65ce7f831

