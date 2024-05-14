Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC43182C82
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716622; cv=none; b=pb601B0qNzOvQVDtj+DaCvG3D62opXrIkjs3aF+Fnl1pQ+GLmLRuu+afO46ITYDB+69P26JdakGL55QtYF5kCPLsI95b04zrj75v66yse63hMA0s040sebDvwWmZ6HIfNxcat2fUXCqxtDld89FxGGI1wEuWyUVMkcHlRFIGuAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716622; c=relaxed/simple;
	bh=CNg4deGubRUAz+pRbeXT+ffC+76ZH/AizxXckhP7Dc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc232sWPCctujSinX8/jbR5q2g2H+9nBBbPdpI4hmtscYlv3nmjA1sZko44LTJremsSt3e7P2B1cTFPspHxMuY0oQRu6miX3odAylIbzPSdFbYKKrvtkJsTmHLOO4HpWp0rsNcP3/UiWLYOw4OocEmylX5mGcRNmUcY5jCQWuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Q6jkkfks; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Q6jkkfks"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43e1e98aaf0so11895851cf.2
        for <git@vger.kernel.org>; Tue, 14 May 2024 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715716618; x=1716321418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DThBoV6ZkeVEdLxgfRTlNqQ/RRoQh0N1BBK/XCcO1E8=;
        b=Q6jkkfksm2hPqLPc6mzaVn5co1EflhQUSL4f8wqUpLyfOc37Z+d7l87aNFSjmS+n0q
         inhqfmHwg/gawf5O2Wllm3u84ZbGJhOQ7jWU74qRmQuvqBb0YleJ3hg+gVbHVXPWtlAK
         xPVjIC7XPUtAyYz1Byj1TyrnY2rSsM0sj/s47d7iaJLqUka/SwhpkBhzzmkA/wR0tQQr
         icTdCBw1+GqN+Gqw2feTHBUEwgCHu2dy2oRc/2Dy2LfrNJTHMi129J3Ss25EmEDk9Vdm
         ewoiVD2vlB0TUraYWjJmY7VxeteExPm/c+dle4/nr09MXSqsxfEDvpU4l/1yrmLgAee8
         MgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716618; x=1716321418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DThBoV6ZkeVEdLxgfRTlNqQ/RRoQh0N1BBK/XCcO1E8=;
        b=TQe7mhrHMogaKTsT0q8+pTXXgeJsRZYfmkg1P5n/OVhm65DzqJL4VcpwGs5WrDEx9O
         MpqeSLqqtFjhKpQdQ/3JhXef5Hvyf5J5AQNXYTSbCganJETJB5V+7NJevkGnQ5dUqFhv
         nJskUqhAiogv61hgLpfrMeIUL2qZIKQy1690eQouwf91Vqr98KhCBl2rYnfw+K5nvQn5
         u6uhGnlwwEWZCsAOMFLU0/WldJYNb4BUQF3fYgaWpin6FlApouwO1OpMGrq/GDMUrArV
         6W5xAmAsx0PNl+oiR0XAS9R0xOW5SC0g1ECO48XZiamSU4g6+u4SGjtp6QkTtXU0dt1g
         lWtg==
X-Gm-Message-State: AOJu0Yw0D+bdD2ZKpGVZ5P4+LhE4U3IK5J5bJZKQd3XupgsdoP+IPyU+
	Yew3RPW3f5ITE5D8RGNWSGpU3Frz+RddYGza12CkeekgTFBy2vxEQgc/3zmcWeHdfMVAaFSnzi7
	R
X-Google-Smtp-Source: AGHT+IH99Gwe+tsUitvc0B/syml+D3yKlJSYZmXrSsiqlEpmX/XjClEOiAUtaMqlWnUPsNeQjHq58A==
X-Received: by 2002:ac8:7f0a:0:b0:43b:4bc:6606 with SMTP id d75a77b69052e-43dfdae7392mr163400851cf.24.1715716618343;
        Tue, 14 May 2024 12:56:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e2467c2ecsm17874631cf.72.2024.05.14.12.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:56:57 -0700 (PDT)
Date: Tue, 14 May 2024 15:56:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] pack-bitmap: avoid use of static `bitmap_writer`
Message-ID: <65ee69acfeb9c66404aa85f0c4b09891d3b8fc27.1715716605.git.me@ttaylorr.com>
References: <cover.1715716605.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1715716605.git.me@ttaylorr.com>

The pack-bitmap machinery uses a structure called 'bitmap_writer' to
collect the data necessary to write out .bitmap files. Since its
introduction in 7cc8f971085 (pack-objects: implement bitmap writing,
2013-12-21), there has been a single static bitmap_writer structure,
which is responsible for all bitmap writing-related operations.

In practice, this is OK, since we are only ever writing a single .bitmap
file in a single process (e.g., `git multi-pack-index write --bitmap`,
`git pack-objects --write-bitmap-index`, `git repack -b`, etc.).

However, having a single static variable makes issues like data
ownership unclear, when to free variables, what has/hasn't been
initialized unclear.

Refactor this code to be written in terms of a given bitmap_writer
structure instead of relying on a static global.

Note that this exposes the structure definition of the bitmap_writer at
the pack-bitmap.h level. We could work around this by, e.g., forcing
callers to declare their writers as:

    struct bitmap_writer *writer;
    bitmap_writer_init(&bitmap_writer);

and then declaring `bitmap_writer_init()` as taking in a double-pointer
like so:

    void bitmap_writer_init(struct bitmap_writer **writer);

which would avoid us having to expose the definition of the structure
itself. This patch takes a different approach, since future patches
(like for the ongoing pseudo-merge bitmaps work) will want to modify the
innards of this structure (in the previous example, via pseudo-merge.c).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  19 ++--
 midx-write.c           |  16 ++--
 pack-bitmap-write.c    | 209 +++++++++++++++++++++--------------------
 pack-bitmap.h          |  38 ++++++--
 4 files changed, 159 insertions(+), 123 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index baf0090fc8..ba4c93d241 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1245,6 +1245,7 @@ static void write_pack_file(void)
 	uint32_t nr_remaining = nr_result;
 	time_t last_mtime = 0;
 	struct object_entry **write_order;
+	struct bitmap_writer bitmap_writer;
 
 	if (progress > pack_to_stdout)
 		progress_state = start_progress(_("Writing objects"), nr_result);
@@ -1339,8 +1340,9 @@ static void write_pack_file(void)
 				    hash_to_hex(hash));
 
 			if (write_bitmap_index) {
-				bitmap_writer_set_checksum(hash);
-				bitmap_writer_build_type_index(
+				bitmap_writer_init(&bitmap_writer);
+				bitmap_writer_set_checksum(&bitmap_writer, hash);
+				bitmap_writer_build_type_index(&bitmap_writer,
 					&to_pack, written_list, nr_written);
 			}
 
@@ -1358,11 +1360,16 @@ static void write_pack_file(void)
 				strbuf_addstr(&tmpname, "bitmap");
 				stop_progress(&progress_state);
 
-				bitmap_writer_show_progress(progress);
-				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
-				if (bitmap_writer_build(&to_pack) < 0)
+				bitmap_writer_show_progress(&bitmap_writer,
+							    progress);
+				bitmap_writer_select_commits(&bitmap_writer,
+							     indexed_commits,
+							     indexed_commits_nr,
+							     -1);
+				if (bitmap_writer_build(&bitmap_writer, &to_pack) < 0)
 					die(_("failed to write bitmap index"));
-				bitmap_writer_finish(written_list, nr_written,
+				bitmap_writer_finish(&bitmap_writer,
+						     written_list, nr_written,
 						     tmpname.buf, write_bitmap_options);
 				write_bitmap_index = 0;
 				strbuf_setlen(&tmpname, tmpname_len);
diff --git a/midx-write.c b/midx-write.c
index 65e69d2de7..5fdc8f2ff5 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -798,6 +798,7 @@ static int write_midx_bitmap(const char *midx_name,
 {
 	int ret, i;
 	uint16_t options = 0;
+	struct bitmap_writer writer;
 	struct pack_idx_entry **index;
 	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name,
 					hash_to_hex(midx_hash));
@@ -819,8 +820,10 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
-	bitmap_writer_show_progress(flags & MIDX_PROGRESS);
-	bitmap_writer_build_type_index(pdata, index, pdata->nr_objects);
+	bitmap_writer_init(&writer);
+	bitmap_writer_show_progress(&writer, flags & MIDX_PROGRESS);
+	bitmap_writer_build_type_index(&writer, pdata, index,
+				       pdata->nr_objects);
 
 	/*
 	 * bitmap_writer_finish expects objects in lex order, but pack_order
@@ -838,13 +841,14 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[pack_order[i]] = &pdata->objects[i].idx;
 
-	bitmap_writer_select_commits(commits, commits_nr, -1);
-	ret = bitmap_writer_build(pdata);
+	bitmap_writer_select_commits(&writer, commits, commits_nr, -1);
+	ret = bitmap_writer_build(&writer, pdata);
 	if (ret < 0)
 		goto cleanup;
 
-	bitmap_writer_set_checksum(midx_hash);
-	bitmap_writer_finish(index, pdata->nr_objects, bitmap_name, options);
+	bitmap_writer_set_checksum(&writer, midx_hash);
+	bitmap_writer_finish(&writer, index, pdata->nr_objects, bitmap_name,
+			     options);
 
 cleanup:
 	free(index);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 2ae82b8696..e22fa70745 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -27,43 +27,30 @@ struct bitmapped_commit {
 	uint32_t commit_pos;
 };
 
-struct bitmap_writer {
-	struct ewah_bitmap *commits;
-	struct ewah_bitmap *trees;
-	struct ewah_bitmap *blobs;
-	struct ewah_bitmap *tags;
-
-	kh_oid_map_t *bitmaps;
-	struct packing_data *to_pack;
-
-	struct bitmapped_commit *selected;
-	unsigned int selected_nr, selected_alloc;
-
-	struct progress *progress;
-	int show_progress;
-	unsigned char pack_checksum[GIT_MAX_RAWSZ];
-};
-
-static struct bitmap_writer writer;
+void bitmap_writer_init(struct bitmap_writer *writer)
+{
+	memset(writer, 0, sizeof(struct bitmap_writer));
+}
 
-void bitmap_writer_show_progress(int show)
+void bitmap_writer_show_progress(struct bitmap_writer *writer, int show)
 {
-	writer.show_progress = show;
+	writer->show_progress = show;
 }
 
 /**
  * Build the initial type index for the packfile or multi-pack-index
  */
-void bitmap_writer_build_type_index(struct packing_data *to_pack,
+void bitmap_writer_build_type_index(struct bitmap_writer *writer,
+				    struct packing_data *to_pack,
 				    struct pack_idx_entry **index,
 				    uint32_t index_nr)
 {
 	uint32_t i;
 
-	writer.commits = ewah_new();
-	writer.trees = ewah_new();
-	writer.blobs = ewah_new();
-	writer.tags = ewah_new();
+	writer->commits = ewah_new();
+	writer->trees = ewah_new();
+	writer->blobs = ewah_new();
+	writer->tags = ewah_new();
 	ALLOC_ARRAY(to_pack->in_pack_pos, to_pack->nr_objects);
 
 	for (i = 0; i < index_nr; ++i) {
@@ -88,19 +75,19 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 
 		switch (real_type) {
 		case OBJ_COMMIT:
-			ewah_set(writer.commits, i);
+			ewah_set(writer->commits, i);
 			break;
 
 		case OBJ_TREE:
-			ewah_set(writer.trees, i);
+			ewah_set(writer->trees, i);
 			break;
 
 		case OBJ_BLOB:
-			ewah_set(writer.blobs, i);
+			ewah_set(writer->blobs, i);
 			break;
 
 		case OBJ_TAG:
-			ewah_set(writer.tags, i);
+			ewah_set(writer->tags, i);
 			break;
 
 		default:
@@ -115,23 +102,25 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
  * Compute the actual bitmaps
  */
 
-static inline void push_bitmapped_commit(struct commit *commit)
+static inline void push_bitmapped_commit(struct bitmap_writer *writer,
+					 struct commit *commit)
 {
-	if (writer.selected_nr >= writer.selected_alloc) {
-		writer.selected_alloc = (writer.selected_alloc + 32) * 2;
-		REALLOC_ARRAY(writer.selected, writer.selected_alloc);
+	if (writer->selected_nr >= writer->selected_alloc) {
+		writer->selected_alloc = (writer->selected_alloc + 32) * 2;
+		REALLOC_ARRAY(writer->selected, writer->selected_alloc);
 	}
 
-	writer.selected[writer.selected_nr].commit = commit;
-	writer.selected[writer.selected_nr].bitmap = NULL;
-	writer.selected[writer.selected_nr].flags = 0;
+	writer->selected[writer->selected_nr].commit = commit;
+	writer->selected[writer->selected_nr].bitmap = NULL;
+	writer->selected[writer->selected_nr].flags = 0;
 
-	writer.selected_nr++;
+	writer->selected_nr++;
 }
 
-static uint32_t find_object_pos(const struct object_id *oid, int *found)
+static uint32_t find_object_pos(struct bitmap_writer *writer,
+				const struct object_id *oid, int *found)
 {
-	struct object_entry *entry = packlist_find(writer.to_pack, oid);
+	struct object_entry *entry = packlist_find(writer->to_pack, oid);
 
 	if (!entry) {
 		if (found)
@@ -143,17 +132,17 @@ static uint32_t find_object_pos(const struct object_id *oid, int *found)
 
 	if (found)
 		*found = 1;
-	return oe_in_pack_pos(writer.to_pack, entry);
+	return oe_in_pack_pos(writer->to_pack, entry);
 }
 
-static void compute_xor_offsets(void)
+static void compute_xor_offsets(struct bitmap_writer *writer)
 {
 	static const int MAX_XOR_OFFSET_SEARCH = 10;
 
 	int i, next = 0;
 
-	while (next < writer.selected_nr) {
-		struct bitmapped_commit *stored = &writer.selected[next];
+	while (next < writer->selected_nr) {
+		struct bitmapped_commit *stored = &writer->selected[next];
 
 		int best_offset = 0;
 		struct ewah_bitmap *best_bitmap = stored->bitmap;
@@ -166,7 +155,7 @@ static void compute_xor_offsets(void)
 				break;
 
 			test_xor = ewah_pool_new();
-			ewah_xor(writer.selected[curr].bitmap, stored->bitmap, test_xor);
+			ewah_xor(writer->selected[curr].bitmap, stored->bitmap, test_xor);
 
 			if (test_xor->buffer_size < best_bitmap->buffer_size) {
 				if (best_bitmap != stored->bitmap)
@@ -348,7 +337,8 @@ static void bitmap_builder_clear(struct bitmap_builder *bb)
 	bb->commits_nr = bb->commits_alloc = 0;
 }
 
-static int fill_bitmap_tree(struct bitmap *bitmap,
+static int fill_bitmap_tree(struct bitmap_writer *writer,
+			    struct bitmap *bitmap,
 			    struct tree *tree)
 {
 	int found;
@@ -360,7 +350,7 @@ static int fill_bitmap_tree(struct bitmap *bitmap,
 	 * If our bit is already set, then there is nothing to do. Both this
 	 * tree and all of its children will be set.
 	 */
-	pos = find_object_pos(&tree->object.oid, &found);
+	pos = find_object_pos(writer, &tree->object.oid, &found);
 	if (!found)
 		return -1;
 	if (bitmap_get(bitmap, pos))
@@ -375,12 +365,12 @@ static int fill_bitmap_tree(struct bitmap *bitmap,
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			if (fill_bitmap_tree(bitmap,
+			if (fill_bitmap_tree(writer, bitmap,
 					     lookup_tree(the_repository, &entry.oid)) < 0)
 				return -1;
 			break;
 		case OBJ_BLOB:
-			pos = find_object_pos(&entry.oid, &found);
+			pos = find_object_pos(writer, &entry.oid, &found);
 			if (!found)
 				return -1;
 			bitmap_set(bitmap, pos);
@@ -397,7 +387,8 @@ static int fill_bitmap_tree(struct bitmap *bitmap,
 
 static int reused_bitmaps_nr;
 
-static int fill_bitmap_commit(struct bb_commit *ent,
+static int fill_bitmap_commit(struct bitmap_writer *writer,
+			      struct bb_commit *ent,
 			      struct commit *commit,
 			      struct prio_queue *queue,
 			      struct prio_queue *tree_queue,
@@ -436,7 +427,7 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 		 * Mark ourselves and queue our tree. The commit
 		 * walk ensures we cover all parents.
 		 */
-		pos = find_object_pos(&c->object.oid, &found);
+		pos = find_object_pos(writer, &c->object.oid, &found);
 		if (!found)
 			return -1;
 		bitmap_set(ent->bitmap, pos);
@@ -444,7 +435,8 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 			       repo_get_commit_tree(the_repository, c));
 
 		for (p = c->parents; p; p = p->next) {
-			pos = find_object_pos(&p->item->object.oid, &found);
+			pos = find_object_pos(writer, &p->item->object.oid,
+					      &found);
 			if (!found)
 				return -1;
 			if (!bitmap_get(ent->bitmap, pos)) {
@@ -455,29 +447,31 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 	}
 
 	while (tree_queue->nr) {
-		if (fill_bitmap_tree(ent->bitmap,
+		if (fill_bitmap_tree(writer, ent->bitmap,
 				     prio_queue_get(tree_queue)) < 0)
 			return -1;
 	}
 	return 0;
 }
 
-static void store_selected(struct bb_commit *ent, struct commit *commit)
+static void store_selected(struct bitmap_writer *writer,
+			   struct bb_commit *ent, struct commit *commit)
 {
-	struct bitmapped_commit *stored = &writer.selected[ent->idx];
+	struct bitmapped_commit *stored = &writer->selected[ent->idx];
 	khiter_t hash_pos;
 	int hash_ret;
 
 	stored->bitmap = bitmap_to_ewah(ent->bitmap);
 
-	hash_pos = kh_put_oid_map(writer.bitmaps, commit->object.oid, &hash_ret);
+	hash_pos = kh_put_oid_map(writer->bitmaps, commit->object.oid, &hash_ret);
 	if (hash_ret == 0)
 		die("Duplicate entry when writing index: %s",
 		    oid_to_hex(&commit->object.oid));
-	kh_value(writer.bitmaps, hash_pos) = stored;
+	kh_value(writer->bitmaps, hash_pos) = stored;
 }
 
-int bitmap_writer_build(struct packing_data *to_pack)
+int bitmap_writer_build(struct bitmap_writer *writer,
+			struct packing_data *to_pack)
 {
 	struct bitmap_builder bb;
 	size_t i;
@@ -488,11 +482,12 @@ int bitmap_writer_build(struct packing_data *to_pack)
 	uint32_t *mapping;
 	int closed = 1; /* until proven otherwise */
 
-	writer.bitmaps = kh_init_oid_map();
-	writer.to_pack = to_pack;
+	writer->bitmaps = kh_init_oid_map();
+	writer->to_pack = to_pack;
 
-	if (writer.show_progress)
-		writer.progress = start_progress("Building bitmaps", writer.selected_nr);
+	if (writer->show_progress)
+		writer->progress = start_progress("Building bitmaps",
+						  writer->selected_nr);
 	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
 			    the_repository);
 
@@ -502,23 +497,23 @@ int bitmap_writer_build(struct packing_data *to_pack)
 	else
 		mapping = NULL;
 
-	bitmap_builder_init(&bb, &writer, old_bitmap);
+	bitmap_builder_init(&bb, writer, old_bitmap);
 	for (i = bb.commits_nr; i > 0; i--) {
 		struct commit *commit = bb.commits[i-1];
 		struct bb_commit *ent = bb_data_at(&bb.data, commit);
 		struct commit *child;
 		int reused = 0;
 
-		if (fill_bitmap_commit(ent, commit, &queue, &tree_queue,
+		if (fill_bitmap_commit(writer, ent, commit, &queue, &tree_queue,
 				       old_bitmap, mapping) < 0) {
 			closed = 0;
 			break;
 		}
 
 		if (ent->selected) {
-			store_selected(ent, commit);
+			store_selected(writer, ent, commit);
 			nr_stored++;
-			display_progress(writer.progress, nr_stored);
+			display_progress(writer->progress, nr_stored);
 		}
 
 		while ((child = pop_commit(&ent->reverse_edges))) {
@@ -549,10 +544,10 @@ int bitmap_writer_build(struct packing_data *to_pack)
 	trace2_data_intmax("pack-bitmap-write", the_repository,
 			   "building_bitmaps_reused", reused_bitmaps_nr);
 
-	stop_progress(&writer.progress);
+	stop_progress(&writer->progress);
 
 	if (closed)
-		compute_xor_offsets();
+		compute_xor_offsets(writer);
 	return closed ? 0 : -1;
 }
 
@@ -590,7 +585,8 @@ static int date_compare(const void *_a, const void *_b)
 	return (long)b->date - (long)a->date;
 }
 
-void bitmap_writer_select_commits(struct commit **indexed_commits,
+void bitmap_writer_select_commits(struct bitmap_writer *writer,
+				  struct commit **indexed_commits,
 				  unsigned int indexed_commits_nr,
 				  int max_bitmaps)
 {
@@ -600,12 +596,12 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
-			push_bitmapped_commit(indexed_commits[i]);
+			push_bitmapped_commit(writer, indexed_commits[i]);
 		return;
 	}
 
-	if (writer.show_progress)
-		writer.progress = start_progress("Selecting bitmap commits", 0);
+	if (writer->show_progress)
+		writer->progress = start_progress("Selecting bitmap commits", 0);
 
 	for (;;) {
 		struct commit *chosen = NULL;
@@ -615,8 +611,8 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 		if (i + next >= indexed_commits_nr)
 			break;
 
-		if (max_bitmaps > 0 && writer.selected_nr >= max_bitmaps) {
-			writer.selected_nr = max_bitmaps;
+		if (max_bitmaps > 0 && writer->selected_nr >= max_bitmaps) {
+			writer->selected_nr = max_bitmaps;
 			break;
 		}
 
@@ -638,13 +634,13 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 			}
 		}
 
-		push_bitmapped_commit(chosen);
+		push_bitmapped_commit(writer, chosen);
 
 		i += next + 1;
-		display_progress(writer.progress, i);
+		display_progress(writer->progress, i);
 	}
 
-	stop_progress(&writer.progress);
+	stop_progress(&writer->progress);
 }
 
 
@@ -670,12 +666,13 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 	return &index[pos]->oid;
 }
 
-static void write_selected_commits_v1(struct hashfile *f, off_t *offsets)
+static void write_selected_commits_v1(struct bitmap_writer *writer,
+				      struct hashfile *f, off_t *offsets)
 {
 	int i;
 
-	for (i = 0; i < writer.selected_nr; ++i) {
-		struct bitmapped_commit *stored = &writer.selected[i];
+	for (i = 0; i < writer->selected_nr; ++i) {
+		struct bitmapped_commit *stored = &writer->selected[i];
 
 		if (offsets)
 			offsets[i] = hashfile_total(f);
@@ -688,10 +685,11 @@ static void write_selected_commits_v1(struct hashfile *f, off_t *offsets)
 	}
 }
 
-static int table_cmp(const void *_va, const void *_vb)
+static int table_cmp(const void *_va, const void *_vb, void *_data)
 {
-	struct bitmapped_commit *a = &writer.selected[*(uint32_t *)_va];
-	struct bitmapped_commit *b = &writer.selected[*(uint32_t *)_vb];
+	struct bitmap_writer *writer = _data;
+	struct bitmapped_commit *a = &writer->selected[*(uint32_t *)_va];
+	struct bitmapped_commit *b = &writer->selected[*(uint32_t *)_vb];
 
 	if (a->commit_pos < b->commit_pos)
 		return -1;
@@ -701,15 +699,16 @@ static int table_cmp(const void *_va, const void *_vb)
 	return 0;
 }
 
-static void write_lookup_table(struct hashfile *f, off_t *offsets)
+static void write_lookup_table(struct bitmap_writer *writer, struct hashfile *f,
+			       off_t *offsets)
 {
 	uint32_t i;
 	uint32_t *table, *table_inv;
 
-	ALLOC_ARRAY(table, writer.selected_nr);
-	ALLOC_ARRAY(table_inv, writer.selected_nr);
+	ALLOC_ARRAY(table, writer->selected_nr);
+	ALLOC_ARRAY(table_inv, writer->selected_nr);
 
-	for (i = 0; i < writer.selected_nr; i++)
+	for (i = 0; i < writer->selected_nr; i++)
 		table[i] = i;
 
 	/*
@@ -717,17 +716,17 @@ static void write_lookup_table(struct hashfile *f, off_t *offsets)
 	 * bitmap corresponds to j'th bitmapped commit (among the selected
 	 * commits) in lex order of OIDs.
 	 */
-	QSORT(table, writer.selected_nr, table_cmp);
+	QSORT_S(table, writer->selected_nr, table_cmp, writer);
 
 	/* table_inv helps us discover that relationship (i'th bitmap
 	 * to j'th commit by j = table_inv[i])
 	 */
-	for (i = 0; i < writer.selected_nr; i++)
+	for (i = 0; i < writer->selected_nr; i++)
 		table_inv[table[i]] = i;
 
 	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
-	for (i = 0; i < writer.selected_nr; i++) {
-		struct bitmapped_commit *selected = &writer.selected[table[i]];
+	for (i = 0; i < writer->selected_nr; i++) {
+		struct bitmapped_commit *selected = &writer->selected[table[i]];
 		uint32_t xor_offset = selected->xor_offset;
 		uint32_t xor_row;
 
@@ -748,7 +747,7 @@ static void write_lookup_table(struct hashfile *f, off_t *offsets)
 			xor_row = 0xffffffff;
 		}
 
-		hashwrite_be32(f, writer.selected[table[i]].commit_pos);
+		hashwrite_be32(f, writer->selected[table[i]].commit_pos);
 		hashwrite_be64(f, (uint64_t)offsets[table[i]]);
 		hashwrite_be32(f, xor_row);
 	}
@@ -770,12 +769,14 @@ static void write_hash_cache(struct hashfile *f,
 	}
 }
 
-void bitmap_writer_set_checksum(const unsigned char *sha1)
+void bitmap_writer_set_checksum(struct bitmap_writer *writer,
+				const unsigned char *sha1)
 {
-	hashcpy(writer.pack_checksum, sha1);
+	hashcpy(writer->pack_checksum, sha1);
 }
 
-void bitmap_writer_finish(struct pack_idx_entry **index,
+void bitmap_writer_finish(struct bitmap_writer *writer,
+			  struct pack_idx_entry **index,
 			  uint32_t index_nr,
 			  const char *filename,
 			  uint16_t options)
@@ -796,20 +797,20 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
 	header.version = htons(default_version);
 	header.options = htons(flags | options);
-	header.entry_count = htonl(writer.selected_nr);
-	hashcpy(header.checksum, writer.pack_checksum);
+	header.entry_count = htonl(writer->selected_nr);
+	hashcpy(header.checksum, writer->pack_checksum);
 
 	hashwrite(f, &header, sizeof(header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz);
-	dump_bitmap(f, writer.commits);
-	dump_bitmap(f, writer.trees);
-	dump_bitmap(f, writer.blobs);
-	dump_bitmap(f, writer.tags);
+	dump_bitmap(f, writer->commits);
+	dump_bitmap(f, writer->trees);
+	dump_bitmap(f, writer->blobs);
+	dump_bitmap(f, writer->tags);
 
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
 		CALLOC_ARRAY(offsets, index_nr);
 
-	for (i = 0; i < writer.selected_nr; i++) {
-		struct bitmapped_commit *stored = &writer.selected[i];
+	for (i = 0; i < writer->selected_nr; i++) {
+		struct bitmapped_commit *stored = &writer->selected[i];
 		int commit_pos = oid_pos(&stored->commit->object.oid, index,
 					 index_nr, oid_access);
 
@@ -818,10 +819,10 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 		stored->commit_pos = commit_pos;
 	}
 
-	write_selected_commits_v1(f, offsets);
+	write_selected_commits_v1(writer, f, offsets);
 
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
-		write_lookup_table(f, offsets);
+		write_lookup_table(writer, f, offsets);
 
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index c7dea13217..5a1890a2c5 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -97,9 +97,29 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_i
 
 off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
 
-void bitmap_writer_show_progress(int show);
-void bitmap_writer_set_checksum(const unsigned char *sha1);
-void bitmap_writer_build_type_index(struct packing_data *to_pack,
+struct bitmap_writer {
+	struct ewah_bitmap *commits;
+	struct ewah_bitmap *trees;
+	struct ewah_bitmap *blobs;
+	struct ewah_bitmap *tags;
+
+	kh_oid_map_t *bitmaps;
+	struct packing_data *to_pack;
+
+	struct bitmapped_commit *selected;
+	unsigned int selected_nr, selected_alloc;
+
+	struct progress *progress;
+	int show_progress;
+	unsigned char pack_checksum[GIT_MAX_RAWSZ];
+};
+
+void bitmap_writer_init(struct bitmap_writer *writer);
+void bitmap_writer_show_progress(struct bitmap_writer *writer, int show);
+void bitmap_writer_set_checksum(struct bitmap_writer *writer,
+				const unsigned char *sha1);
+void bitmap_writer_build_type_index(struct bitmap_writer *writer,
+				    struct packing_data *to_pack,
 				    struct pack_idx_entry **index,
 				    uint32_t index_nr);
 uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
@@ -109,10 +129,14 @@ int rebuild_bitmap(const uint32_t *reposition,
 		   struct bitmap *dest);
 struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit);
-void bitmap_writer_select_commits(struct commit **indexed_commits,
-		unsigned int indexed_commits_nr, int max_bitmaps);
-int bitmap_writer_build(struct packing_data *to_pack);
-void bitmap_writer_finish(struct pack_idx_entry **index,
+void bitmap_writer_select_commits(struct bitmap_writer *writer,
+				  struct commit **indexed_commits,
+				  unsigned int indexed_commits_nr,
+				  int max_bitmaps);
+int bitmap_writer_build(struct bitmap_writer *writer,
+			struct packing_data *to_pack);
+void bitmap_writer_finish(struct bitmap_writer *writer,
+			  struct pack_idx_entry **index,
 			  uint32_t index_nr,
 			  const char *filename,
 			  uint16_t options);
-- 
2.45.1.151.g7cc3499008c

