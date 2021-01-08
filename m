Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E16C43332
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA19C23A7A
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbhAHSSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbhAHSSU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:20 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A40C061380
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:25 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id h16so4699499qvu.8
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RFUmAYihgEn8U2ycrvgYAS4mVFzyah6mujmtOpaH3X4=;
        b=TLn7nm6snlOzbdPggwIlrSD5o6u/6wRBwPgcfa2jjDbnL95b4xHIquUtpSaRK92W4S
         wuw4DxsUX4ewePJK1p8//isAi3agHWAZD1c1hCJpoIgYf76pvAqakScTNTIvs/5PEgm/
         RSI+nyH/7Y9uUaA8w8d4eo+zhZ+QkJAczXkyyKotThJ56koJj1liNEPCz8u5gbccd6sw
         LAkmZbyBpLBrO9/Mtv44SSCULm35X5LQndJ1r2gnS4qLfV9x2z9V96nO3p2eSYd2TY1Q
         GFZ6/MBI63pxkJ9KsvYS0exjqlTPM9EzSDbnGZyKP8Ye0dkke0YbPlUdfIFSFRd8DZZZ
         E0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RFUmAYihgEn8U2ycrvgYAS4mVFzyah6mujmtOpaH3X4=;
        b=d9yTGyU0ODbC8RITZH4af5YXuP9s6C2QSSE+VOHKT7pPMBmCA4lRrS4F36k1l0wCib
         vvHHYcH09ipX56Ll4qG8lLr7arP5UNQ6QnuAt3V0k9eA20VaPsVJlWfjO1T19TCdaAmS
         okWnO0UzBQNf7ZSAU/bsP+rS+L7KTxPkHH4VsSVBtBHTAs2p5MT7gFliTAvqNADIcPRS
         /pn+O1pORblZrRPZezkPYUUVHiq6GucexrpATomdNoK81dkmxMpSxc6KcCQCwv1H2qlx
         prQAaFjdOcasdXCx5cuN8IKdPhiWkniOIEh/UwYqgmG2aw+C6v8KrOJsuxUw5Ts7ZH2y
         kYfw==
X-Gm-Message-State: AOAM532XHnbMVwpdhZz5NekZpa6sUJ29A2by6t1+9lyr6Ip/48CAdFbC
        uE/xlvMZ4Rvk+LtkI/1ZbBOYSpVaibnY/Q==
X-Google-Smtp-Source: ABdhPJwRheSdvexf7SS4KqRaV4fME7WPHWcwTq+sS8JmlASbh/LmWtAnS947utx5TNrsGMaOrkQw0Q==
X-Received: by 2002:a0c:bd2b:: with SMTP id m43mr4937665qvg.32.1610129844177;
        Fri, 08 Jan 2021 10:17:24 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id q27sm5079620qkj.131.2021.01.08.10.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:23 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 10/20] rebuild_existing_bitmaps(): convert to new revindex API
Message-ID: <97eaa7b2d6d923da0dca6e96b890d4b85bf9d7d8.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove another instance of looking at the revindex directly by instead
calling 'pack_pos_to_index()'. Unlike other patches, this caller only
cares about the index position of each object in the loop.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3f5cd4e77d..24b9628dca 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1392,11 +1392,10 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 
 	for (i = 0; i < num_objects; ++i) {
 		struct object_id oid;
-		struct revindex_entry *entry;
 		struct object_entry *oe;
 
-		entry = &bitmap_git->pack->revindex[i];
-		nth_packed_object_id(&oid, bitmap_git->pack, entry->nr);
+		nth_packed_object_id(&oid, bitmap_git->pack,
+				     pack_pos_to_index(bitmap_git->pack, i));
 		oe = packlist_find(mapping, &oid);
 
 		if (oe)
-- 
2.30.0.138.g6d7191ea01

