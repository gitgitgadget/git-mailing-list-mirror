Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F24C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30328206EB
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="N0zE5VMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgEDXMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEDXMe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:12:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F3FC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 16:12:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so158142pjh.2
        for <git@vger.kernel.org>; Mon, 04 May 2020 16:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xwp9MlTM06nhTCGk+Beg6uQkrBO7tHv/m7wbf/1smis=;
        b=N0zE5VMCaPfrlTv/ZGE1DdGa+8TNFbAFkZVatGuQCKuDQY/6bPCy2C64Qnr4N3Sf2l
         EWnJYn2HoFNaex9Sw1/2DoL3/piFRnnQvgft/YKqav53hMc2889Y2y+7p+lbM7eUBi4e
         NsIgbPoZCA0C9Ak4b5RBXsaZG7XSH2gp41f8Tu2kQ6tBGW16XPWQnTxD5+HKwxz++cyr
         8dKN/wODcgym3uPB0slC+vBGf1sbUYfj5q28DH36yhAMMrCUNvgvNN6rXX6BGPEyPYZM
         KPmX8tTWZaeqA7NTXSWhivVNaS+apKvOzdnwTAIqr3htnN5mA24jEyvC+XvxDB1xPXMl
         NcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xwp9MlTM06nhTCGk+Beg6uQkrBO7tHv/m7wbf/1smis=;
        b=RtNaSQschSELqsRqUgWy8ahoocdLsGALsdKWLxuwjFXEDd511/Eq/NOUpGgLc4U7PK
         F2OL5Jw5vmQqJYuB5pGl4h/HqMY70Le+9I2a+vyMD3OfS+X2AoL7+fHjXx1QHiUFaWE4
         2xnKabRgYzWHTnytd1lUHr5uYA1bjUkxlZHcqWdfSJipUJu3enkxRm8n7aMdRqIQf5WK
         f8qJdwbur9iQ8W4aJuBM8tTmR11QwN8nJjq4BTlvJ2iDdhkxQlX5w9sv9Po/gcSpI3gk
         q6Zy0Ow31nNunSTlr7V1Q2lFDJ5C1f/hB4+PoBGbY7YH0AkueAyiEzFXIsCSL/a9ogg1
         is5A==
X-Gm-Message-State: AGi0PuYCIMmasXaXPI7hSiZr3JWTjQDDTD+LC4eujQyw8i0liLtCKeya
        /XQ+/Ut4mIgsC+vxMF/tJE7C9QRdwtvm1Q==
X-Google-Smtp-Source: APiQypLlx8xLA+SFBD6gywgB3if8iTJOXvx2sD+nrOlmz1QJ7/Z0bT2Jvh6fTXjIIbahBppY1o0+wg==
X-Received: by 2002:a17:90a:cb09:: with SMTP id z9mr181453pjt.120.1588633953451;
        Mon, 04 May 2020 16:12:33 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d12sm166691pfq.36.2020.05.04.16.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:12:32 -0700 (PDT)
Date:   Mon, 4 May 2020 17:12:31 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 2/4] pack-bitmap.c: make object filtering functions generic
Message-ID: <b43a12894e7edf7d54ce2e9679f8db7dabec23e0.1588633810.git.me@ttaylorr.com>
References: <cover.1588633810.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588633810.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4f3bd5606a (pack-bitmap: implement BLOB_NONE filtering, 2020-02-14),
filtering support for bitmaps was added for the 'LOFC_BLOB_NONE' filter.

In the future, we would like to add support for filters that behave as
if they exclude a certain type of object, for e.g., the tree depth
filter with depth 0.

To prepare for this, make some of the functions used for filtering more
generic, such as 'find_tip_blobs' and 'filter_bitmap_blob_none' so that
they can work over arbitrary object types.

To that end, create 'find_tip_objects' and
'filter_bitmap_exclude_type', and redefine the aforementioned functions
in terms of those.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 49a8d10d0c..3693c9e62f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -715,8 +715,9 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
 	return 0;
 }
 
-static struct bitmap *find_tip_blobs(struct bitmap_index *bitmap_git,
-				     struct object_list *tip_objects)
+static struct bitmap *find_tip_objects(struct bitmap_index *bitmap_git,
+				       struct object_list *tip_objects,
+				       enum object_type type)
 {
 	struct bitmap *result = bitmap_new();
 	struct object_list *p;
@@ -724,7 +725,7 @@ static struct bitmap *find_tip_blobs(struct bitmap_index *bitmap_git,
 	for (p = tip_objects; p; p = p->next) {
 		int pos;
 
-		if (p->item->type != OBJ_BLOB)
+		if (p->item->type != type)
 			continue;
 
 		pos = bitmap_position(bitmap_git, &p->item->oid);
@@ -737,9 +738,10 @@ static struct bitmap *find_tip_blobs(struct bitmap_index *bitmap_git,
 	return result;
 }
 
-static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
-				    struct object_list *tip_objects,
-				    struct bitmap *to_filter)
+static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
+				       struct object_list *tip_objects,
+				       struct bitmap *to_filter,
+				       enum object_type type)
 {
 	struct eindex *eindex = &bitmap_git->ext_index;
 	struct bitmap *tips;
@@ -747,18 +749,21 @@ static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
 	eword_t mask;
 	uint32_t i;
 
+	if (type != OBJ_BLOB)
+		BUG("filter_bitmap_exclude_type: unsupported type '%d'", type);
+
 	/*
 	 * The non-bitmap version of this filter never removes
-	 * blobs which the other side specifically asked for,
+	 * objects which the other side specifically asked for,
 	 * so we must match that behavior.
 	 */
-	tips = find_tip_blobs(bitmap_git, tip_objects);
+	tips = find_tip_objects(bitmap_git, tip_objects, type);
 
 	/*
 	 * We can use the blob type-bitmap to work in whole words
 	 * for the objects that are actually in the bitmapped packfile.
 	 */
-	for (i = 0, init_type_iterator(&it, bitmap_git, OBJ_BLOB);
+	for (i = 0, init_type_iterator(&it, bitmap_git, type);
 	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
 	     i++) {
 		if (i < tips->word_alloc)
@@ -773,7 +778,7 @@ static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
 	 */
 	for (i = 0; i < eindex->count; i++) {
 		uint32_t pos = i + bitmap_git->pack->num_objects;
-		if (eindex->objects[i]->type == OBJ_BLOB &&
+		if (eindex->objects[i]->type == type &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos))
 			bitmap_unset(to_filter, pos);
@@ -782,6 +787,14 @@ static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
 	bitmap_free(tips);
 }
 
+static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
+				    struct object_list *tip_objects,
+				    struct bitmap *to_filter)
+{
+	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter,
+				   OBJ_BLOB);
+}
+
 static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 				     uint32_t pos)
 {
@@ -820,7 +833,7 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 	eword_t mask;
 	uint32_t i;
 
-	tips = find_tip_blobs(bitmap_git, tip_objects);
+	tips = find_tip_objects(bitmap_git, tip_objects, OBJ_BLOB);
 
 	for (i = 0, init_type_iterator(&it, bitmap_git, OBJ_BLOB);
 	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
-- 
2.26.0.113.ge9739cdccc

