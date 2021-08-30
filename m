Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A868C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 02:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1610B60F57
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 02:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhH3Cts (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 22:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhH3Ctq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 22:49:46 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19CC061575
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 19:48:53 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id v2so14464583ilg.12
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 19:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kiHiSHjPuPMt3clmqyyR/wEP141MS7NOVQ9dHJoY0ck=;
        b=pHc88Own/6PlmtL+axICeOni0GxbaV1hkhH3CADgVCPk4J5kgN1HVVidVpE2RRnrrw
         yh2bVAhY6kSzWArfRhRZ/edNuJ5vTLZZ8zcyh+SNOqJS8lavoU5/E/lUuEMsYqvoGUIP
         9vglrZo/MXp+/kmwL4ylIPOTVgnqIX4vlxV2bZpReQKBy9jK40ZVGU65VgpEi973Ohuy
         SfIeT8ORbtyKjgDB2zfjtE5m6tQwpzoOJkNN2Tlk6XxXN/MOGrld/0WqiQu/CCbY9MUK
         bs2B61Bc80BDbeq6e5k7tTGHphF08wQB+TZywYuCyjFmeIMSlqz40+Ux/X1BlZrN7+ul
         J1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kiHiSHjPuPMt3clmqyyR/wEP141MS7NOVQ9dHJoY0ck=;
        b=SvMff4UEMMj6bkMyD8HrPEIJm4K+uw1Lp9GaUJMTNoIb5iWNZk5cEf+0bSsroCi40R
         06jEI9okjkpcNvzrfa5AJFrTboFHYv2Q4mgaJizBJQoCI80AGm9mHofkALlT32qc090g
         nWVOL5cxQnksbPFmXT2zyues9LcJIa68uNFj5Jy+qhRr3UVU/XnS8Uv/QzWd4/Elr+W6
         6I3DLQzpbDJyEaK3i1CQJGmbW6q9xYVOhqq/Nl5wKbtDm8rBN6JTLMhqpZ0EhMBI2Lpv
         AiUMu2N+qPKb/PlmP/q+mGxoVvKR3w7p39JAHcGN1A+ZgyCB1Sy7wrx8H/mwioyGselE
         ICuQ==
X-Gm-Message-State: AOAM530yZeUIQNAmf476L849HqyQLY41R9mVsfTLCgUKJkYyQe369zBb
        Xx7K3Bp+mCK+fj/C6CeLU0cqnNhVAn0KcCgk
X-Google-Smtp-Source: ABdhPJx2M2XaTwBNqFfTNOse5LpD9o1L7bqC2iqtzcTITvX5/EWMels6BWreenGMu7UZ4gGGQ7+PEQ==
X-Received: by 2002:a92:d0d1:: with SMTP id y17mr15328732ila.91.1630291733120;
        Sun, 29 Aug 2021 19:48:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z16sm7691740ile.72.2021.08.29.19.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 19:48:52 -0700 (PDT)
Date:   Sun, 29 Aug 2021 22:48:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 1/3] object-store.h: teach for_each_packed_object to ignore
 kept packs
Message-ID: <30df4374db583796389c64461c93730eb0a5aa89.1630291682.git.me@ttaylorr.com>
References: <cover.1630291682.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630291682.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next patch will reimplement a function that wants to iterate over
packed objects while ignoring packs which are marked as kept (either
in-core or on-disk).

Teach for_each_packed_object() to ignore all objects from those packs by
adding a new flag for each of the "kept" states that a pack can be in.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-store.h | 6 ++++++
 packfile.c     | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/object-store.h b/object-store.h
index d24915ced1..b4dc6668aa 100644
--- a/object-store.h
+++ b/object-store.h
@@ -455,6 +455,12 @@ enum for_each_object_flags {
 	 * Visit objects within a pack in packfile order rather than .idx order
 	 */
 	FOR_EACH_OBJECT_PACK_ORDER = (1<<2),
+
+	/* Only iterate over packs that are not marked as kept in-core. */
+	FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS = (1<<3),
+
+	/* Only iterate over packs that do not have .keep files. */
+	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
 };
 
 /*
diff --git a/packfile.c b/packfile.c
index 9ef6d98292..4d0d625238 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2205,6 +2205,12 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
 		    !p->pack_promisor)
 			continue;
+		if ((flags & FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
+		    p->pack_keep_in_core)
+			continue;
+		if ((flags & FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
+		    p->pack_keep)
+			continue;
 		if (open_pack_index(p)) {
 			pack_errors = 1;
 			continue;
-- 
2.33.0.96.g73915697e6

