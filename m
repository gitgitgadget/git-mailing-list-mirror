Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2773DC433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E028223A7C
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbhAHSSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbhAHSSD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:03 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82574C0612FF
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:04 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id d14so9206719qkc.13
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hW41lKfGSKRpSEd8Eam9htWLIgeE/xQG0bzdJaPFRss=;
        b=vKkYatt+vzPLHZsZpQ8aKYIW6fbnqfpE8CVL2T26lciODHBJIi6FOLYoepjhjB/JIk
         qapMn5/SBYw5th27CgROldjsNj9bvUnVwkgA0lWyZsFA0JOUAYoTqFpFFvhJIfCHqwIO
         zdKrGuRZHQOTpaD1ysbrQmkLk3Wge01jSN9B9+a4aR8Ej5gPCbSKvJTLLX8ow8WJFvBH
         gQcitupXlFGG9/HDyARliIgS3S0wEhDYP4II5AhSaMwkExOiYRf7Ng8wI8h6zLvzyIqC
         GO5HZFHDxAh1sNgJ2H0UzammfEKiuIVxt6bio7Q4Jm7B7rU5H+uudBLYPyyXrgsrruY1
         ASTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hW41lKfGSKRpSEd8Eam9htWLIgeE/xQG0bzdJaPFRss=;
        b=tHa7QzPIpH34O0cRxjs0QQP4HeZbfdk1s8rd+UIo9aNFA5CKFRQEEir0zwPZmYNgID
         LKlC9bvtFgbb4PNC+Dqp5RJ7RR/GwqEQBI6AapFDcTH6WUMczleLIXmQd+Bklgu2Rub3
         +FczzdLYRGYdrObkHsQKmTb0Ma3YZrnplnsJIKi7yi8V41tSODP4Rit3TS0UclA7c+ot
         0Dlz087IRgLciAs+aUfS6/C+EPoNxUtQ/nsYLA4VubzzPcVFS0m/MPFhp3cR8a8SaoHT
         CKhFulF18AezVRoW3nk4FfLj8tiyi/vb2Fq2Ck4NcH5+mxbnDXFCQDlafGNGue9IEHw9
         dhkA==
X-Gm-Message-State: AOAM530vSBv7Ao3D1WeFvp7BF8lkLJfkSnrnC2AXaITVgmW2D0aUxkY1
        olNJWVzDNkD2tow7Ou+gJ5pKfmZtP988xQ==
X-Google-Smtp-Source: ABdhPJxQK3AiDQAhz+awoClWI08Anb8hYj0Ilamm27JI5JcKWdb5RQziaXlSNzMss9tyt1gcv3kFRg==
X-Received: by 2002:a37:9b04:: with SMTP id d4mr5104249qke.408.1610129823474;
        Fri, 08 Jan 2021 10:17:03 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id k141sm5167348qke.38.2021.01.08.10.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:02 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 05/20] check_object(): convert to new revindex API
Message-ID: <c47e77a30eb40d9841a60a28b620671860dc2461.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace direct accesses to the revindex with calls to
'offset_to_pack_pos()' and 'pack_pos_to_index()'.

Since this caller already had some error checking (it can jump to the
'give_up' label if it encounters an error), we can easily check whether
or not the provided offset points to an object in the given pack. This
error checking existed prior to this patch, too, since the caller checks
whether the return value from 'find_pack_revindex()' was NULL or not.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4341bc27b4..a193cdaf2f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1813,11 +1813,11 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 				goto give_up;
 			}
 			if (reuse_delta && !entry->preferred_base) {
-				struct revindex_entry *revidx;
-				revidx = find_pack_revindex(p, ofs);
-				if (!revidx)
+				uint32_t pos;
+				if (offset_to_pack_pos(p, ofs, &pos) < 0)
 					goto give_up;
-				if (!nth_packed_object_id(&base_ref, p, revidx->nr))
+				if (!nth_packed_object_id(&base_ref, p,
+							  pack_pos_to_index(p, pos)))
 					have_base = 1;
 			}
 			entry->in_pack_header_size = used + used_0;
-- 
2.30.0.138.g6d7191ea01

