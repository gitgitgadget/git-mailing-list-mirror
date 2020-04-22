Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32543C55186
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBB42076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="d+0YJhLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDVXNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVXNc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 19:13:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED73C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:13:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 7so2946199pjo.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ReCoUBhA6DuS6qYAUTxKUmQY/vAN9JfYI6V6uyzE6G4=;
        b=d+0YJhLkUUlkwDUMr9LcBZl49ADqeqmK121qebFUNzwn4EiJnsXTa0VTAhJ1vOQgAn
         0VnLrHjTyuS+hR8wi9jUiU8viF0bJNrBbo+Wf2x9rMdtvmXl9kOY4H8jv+SsUhkiRFqh
         ppHG3Fv3Mz2U+jKTCFZF3kGULYYrD64RRjbkuGm+PNnbFvslDkzfxvs8K3cYpF3bUbOc
         k/wvFT7YS8qOdcwqbt/m6w6RzjfulOMm37q/MTrSyaqTT49Q6uN1Bin3faLrC3H1ksGo
         voq0K34wT/02cw9zbpUrfP7FOZ2/IQIXSzx7GGHgCyMVQy1Nt1s4N4oj14AoEJvjt/qd
         NI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ReCoUBhA6DuS6qYAUTxKUmQY/vAN9JfYI6V6uyzE6G4=;
        b=ejKvJi7xBS0OMkrDNSq4ZQENQ3DJtxCwSRfetrnjPni8JWZw0RUxMaNQA+AVFJauP4
         lLV5OlMbcm2braEYelTY9csB2gR+Q6mCspqtShbvnRB1UclFFvA90GttCZaNbRxJKWV8
         6C+UIk3lo6HMILlNILsKQucWQvs0LOY4Osfsz9IeF3vEAPKTAPrrUxMjLuS00XHgQRSW
         8PicGg626+OcFrJgfwWffdwP8pR2rwtXMpJzm4Jo6O0r+Sc+XOCPJjrJ7jj3EUoJM85+
         AvGTAKRU+Qe5yrBx8qu2pM8SYDPSjzDgm1FZcQk/6htdFfvzsF1jkX4FvwFA4wxf7HRG
         PjmA==
X-Gm-Message-State: AGi0PuYqzp6Wb59eIH+scPLDhGHeNJO5F5cUfuzo02xjNXicGKPFXbKG
        LwNK81ig+Gnb/wDEZ7MIV6yn94umIHpTqA==
X-Google-Smtp-Source: APiQypLzlTXS4ltpyPZxKVgmjX29JvY1Qo7lcHCgjN/pMFKL2dXtB5l6047qCX/ilrpGzYSe3xFLdw==
X-Received: by 2002:a17:902:d201:: with SMTP id t1mr1063791ply.328.1587597210568;
        Wed, 22 Apr 2020 16:13:30 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id u15sm291441pjm.47.2020.04.22.16.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:13:29 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:13:29 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 2/4] pack-bitmap.c: make object filtering functions generic
Message-ID: <ec6d73d365d23cc926b98dabb1f30ee4232791db.1587597151.git.me@ttaylorr.com>
References: <cover.1587597151.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587597151.git.me@ttaylorr.com>
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
2.26.2.112.g65467a058e

