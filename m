Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1385C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B456A23A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgLHAGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgLHAGY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:06:24 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3AFC0611CA
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:05:44 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id o25so17553816oie.5
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LViEVk8iVCd/Fue2tk1lTGL+H9g9t3D0HHU/a47NVcM=;
        b=PZ0qwWqea+1gSo3pCG66yDSQDQtNavM2ugrjq6cDQG+Dy2vqmlfQom5PzDIGaWRMyo
         5SWChe1uCgOzpEBJ2N8H8lopnA8vBTjRl7Q2LchV+kVK27TtkqAHOch8/n53juY37Qt7
         u1euhgHEjTz0Cxz93iXBDIifFfaghqL8WzDTDo6uYpCiWjccO0l1SbCmN136+I4WF32x
         uxcGd2X+ygWtpPOh1J9SdzLjc9VuV2LAJ3bHQFzwoesjCkWUct4srTDJYr+wpqswTlHP
         ZlU1aQIWGgB0bD6nbaMe2x4NhbKwWkUOjzefh5+XtahksjNe+l+GK1ISPrILlqFmtNDe
         utDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LViEVk8iVCd/Fue2tk1lTGL+H9g9t3D0HHU/a47NVcM=;
        b=srt0Xq6CXqHkn+M4qRPTbAnElZGuWRRmY7mbOPtvYWdpcpGRs/tV60YMy9Ff0XFbPj
         FfGf6hCU6jsc3kdhUjSy6if1Yz3VRZ3NChBIFuc/smk1AZiT3E7XUF8aBRz3JYCPQamY
         taR0NcFMEEqBdKW+a9cscWoGP0yJwSssi1IwK7jrBR/bj7KByGi671/2QHtvLCWim4WJ
         3v5N8E2lpZEhIeuBM1wqKQRrQDUYvYIvbmbGJD7dE9AFbDKFw65q7vzFtzz6Tso9Db3d
         GsJrPPWig1a5jjoUkInFTgxVOsochb2Yevnp99xuj3rLxTIl5tj7Y5mY8g0fRykkPXI9
         bg/w==
X-Gm-Message-State: AOAM530/NOJS1/LBgyluWHewZfTGSn3wFNQuGHXHupWdmtTFUxTXAS6W
        Jgja23Jip58ypnWnQT8snxzmi/dis2diDYMu
X-Google-Smtp-Source: ABdhPJxJIlwuJTLZ+CV67vaR+RZzhwJv/qvxbcyFZ3yYeDeUppgPZ3TvV6DYYLE+DcFeuSm1DKlqmA==
X-Received: by 2002:aca:e146:: with SMTP id y67mr969596oig.70.1607385943165;
        Mon, 07 Dec 2020 16:05:43 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i82sm3314112oia.2.2020.12.07.16.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:05:42 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:05:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 20/24] pack-bitmap: factor out 'bitmap_for_commit()'
Message-ID: <d5ef2c7f81de5bdba3a013c926a73a48d3208fc5.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of callers within pack-bitmap.c duplicate logic to lookup a
given object id in the bitamps khash. Factor this out into a new
function, 'bitmap_for_commit()' to reduce some code duplication.

Make this new function non-static, since it will be used in later
commits from outside of pack-bitmap.c.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 33 +++++++++++++++++++--------------
 pack-bitmap.h |  2 ++
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d1368b69bb..5efb8af121 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -380,6 +380,16 @@ struct include_data {
 	struct bitmap *seen;
 };
 
+struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
+				      struct commit *commit)
+{
+	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
+					   commit->object.oid);
+	if (hash_pos >= kh_end(bitmap_git->bitmaps))
+		return NULL;
+	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
+}
+
 static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 					   const struct object_id *oid)
 {
@@ -465,10 +475,10 @@ static void show_commit(struct commit *commit, void *data)
 
 static int add_to_include_set(struct bitmap_index *bitmap_git,
 			      struct include_data *data,
-			      const struct object_id *oid,
+			      struct commit *commit,
 			      int bitmap_pos)
 {
-	khiter_t hash_pos;
+	struct ewah_bitmap *partial;
 
 	if (data->seen && bitmap_get(data->seen, bitmap_pos))
 		return 0;
@@ -476,10 +486,9 @@ static int add_to_include_set(struct bitmap_index *bitmap_git,
 	if (bitmap_get(data->base, bitmap_pos))
 		return 0;
 
-	hash_pos = kh_get_oid_map(bitmap_git->bitmaps, *oid);
-	if (hash_pos < kh_end(bitmap_git->bitmaps)) {
-		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, hash_pos);
-		bitmap_or_ewah(data->base, lookup_stored_bitmap(st));
+	partial = bitmap_for_commit(bitmap_git, commit);
+	if (partial) {
+		bitmap_or_ewah(data->base, partial);
 		return 0;
 	}
 
@@ -498,8 +507,7 @@ static int should_include(struct commit *commit, void *_data)
 						  (struct object *)commit,
 						  NULL);
 
-	if (!add_to_include_set(data->bitmap_git, data, &commit->object.oid,
-				bitmap_pos)) {
+	if (!add_to_include_set(data->bitmap_git, data, commit, bitmap_pos)) {
 		struct commit_list *parent = commit->parents;
 
 		while (parent) {
@@ -1282,10 +1290,10 @@ void test_bitmap_walk(struct rev_info *revs)
 {
 	struct object *root;
 	struct bitmap *result = NULL;
-	khiter_t pos;
 	size_t result_popcnt;
 	struct bitmap_test_data tdata;
 	struct bitmap_index *bitmap_git;
+	struct ewah_bitmap *bm;
 
 	if (!(bitmap_git = prepare_bitmap_git(revs->repo)))
 		die("failed to load bitmap indexes");
@@ -1297,12 +1305,9 @@ void test_bitmap_walk(struct rev_info *revs)
 		bitmap_git->version, bitmap_git->entry_count);
 
 	root = revs->pending.objects[0].item;
-	pos = kh_get_oid_map(bitmap_git->bitmaps, root->oid);
-
-	if (pos < kh_end(bitmap_git->bitmaps)) {
-		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
-		struct ewah_bitmap *bm = lookup_stored_bitmap(st);
+	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
 
+	if (bm) {
 		fprintf(stderr, "Found bitmap for %s. %d bits / %08x checksum\n",
 			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index afa4115136..25dfcf5615 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -78,6 +78,8 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 int rebuild_bitmap(const uint32_t *reposition,
 		   struct ewah_bitmap *source,
 		   struct bitmap *dest);
+struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
+				      struct commit *commit);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 		unsigned int indexed_commits_nr, int max_bitmaps);
 void bitmap_writer_build(struct packing_data *to_pack);
-- 
2.29.2.533.g07db1f5344

