Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48367C43333
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B9C23A7B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbhAHSSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbhAHSSU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:20 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EC9C06129F
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:20 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id et9so4699114qvb.10
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oBPwtvmJDVwAFmKX8JceYJERtX7VHhW3pjdbq3SSgHQ=;
        b=jjiQuuTTa/ZSnR42pLtw8GCotnwd+vk3GueVyqZgi/0rV6IQBEjy9PraLhNhaDJqLx
         +EkX80DAMkEZpZctaAR0sfp5bodda3RDx771Hv332xJ2VTMX/w4OUlpuLqamv4uklFXU
         O/dAQK6IBJ7IDWkhKeNyQCkkzs6wcXNM4AS5u55KNOJsOuVVh6mCagbbaQMunFjfq37q
         h3udhRwlmOWYjr1Z2h7YpxL8sS72n4LoJOsAGmUK/KnFqbS35KPcF83jaavC39sc027R
         XR4dOrXKjW75FeYj9e8yl0UYUzG0p1D/hARiwIyAAygnEzr+4CjJsh087UlYGR4Nt6Hs
         U1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBPwtvmJDVwAFmKX8JceYJERtX7VHhW3pjdbq3SSgHQ=;
        b=RDNHM1AMEGwLPZzRi/o+oMtKX7LAviwk+yQpmxBXMJ2IwAlJMCTHxnVJp6Q5vVxNU7
         rIyGMUXk2MkIODiMvo7OVxoMcdAZUGqzTJ68E9oEMeS5xaCVqWhA5t8iNAMLSFKQuYM9
         mmiFwe5dc0i9mTMMLc7dwkc75P9r/KI6dJtGli2olPh3nP3Jy75zilcEeZARA2URcvzy
         QIdPNVHGTsk8tPjOKAy197Xeg9Ndp4qzxuArUITB54Oh9O0mHLvmggzPr5sPWmKbQQHc
         ItymOXe8twrw2xRqneG2mThD/2ukbA9pJjvnC7svOLM7kXxdHevb0B+W89paAda9EpAD
         Akxg==
X-Gm-Message-State: AOAM533fXU65M55hb8SfpWo1M9Fe0xm9oQcsq2aLB/ZG+7gR97UN9EP/
        LXA9PdTgXZlH352UNfx+8oRhkw8V8s5QBA==
X-Google-Smtp-Source: ABdhPJzwM5Ax+YZvy57TBctMtbM83klOzLXnQHzmP8GYIUOYh3POoXdFP9UzDBprCMKYutCZrRjSbg==
X-Received: by 2002:a0c:c583:: with SMTP id a3mr4716509qvj.15.1610129839965;
        Fri, 08 Jan 2021 10:17:19 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id o29sm4842457qtl.7.2021.01.08.10.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:19 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 09/20] try_partial_reuse(): convert to new revindex API
Message-ID: <54f4ad329f56808432549aa885f2847d5c9a8ac6.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove another instance of direct revindex manipulation by calling
'pack_pos_to_offset()' instead (the caller here does not care about the
index position of the object at position 'pos').

Somewhat confusingly, the subsequent call to unpack_object_header()
takes a pointer to &offset and then updates it with a new value. But,
try_partial_reuse() cares about the offset of both the base's header and
contents. The existing code made a copy of the offset field, and only
addresses and manipulates one of them.

Instead, store the return of pack_pos_to_offset twice: once in header
and another in offset. Header will be left untouched, but offset will be
addressed and modified by unpack_object_header().

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 422505d7af..3f5cd4e77d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1069,23 +1069,21 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 			      struct bitmap *reuse,
 			      struct pack_window **w_curs)
 {
-	struct revindex_entry *revidx;
-	off_t offset;
+	off_t offset, header;
 	enum object_type type;
 	unsigned long size;
 
 	if (pos >= bitmap_git->pack->num_objects)
 		return; /* not actually in the pack */
 
-	revidx = &bitmap_git->pack->revindex[pos];
-	offset = revidx->offset;
+	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
 	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
 	if (type < 0)
 		return; /* broken packfile, punt */
 
 	if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA) {
 		off_t base_offset;
-		int base_pos;
+		uint32_t base_pos;
 
 		/*
 		 * Find the position of the base object so we can look it up
@@ -1096,11 +1094,10 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 		 * more detail.
 		 */
 		base_offset = get_delta_base(bitmap_git->pack, w_curs,
-					     &offset, type, revidx->offset);
+					     &offset, type, header);
 		if (!base_offset)
 			return;
-		base_pos = find_revindex_position(bitmap_git->pack, base_offset);
-		if (base_pos < 0)
+		if (offset_to_pack_pos(bitmap_git->pack, base_offset, &base_pos) < 0)
 			return;
 
 		/*
-- 
2.30.0.138.g6d7191ea01

