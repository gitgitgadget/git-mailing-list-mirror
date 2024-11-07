Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187EB212D38
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988655; cv=none; b=HQYeuLpE0q63TAX7nrwbOxRSJNXcWMxPqo8qdQq+BaCxxRN12EkP0L0YPTGEwIcoBaR7AksGSpYAAc7tVvIMS7Ye7Uwpbdbn5yKWeuOCEgolzcTmO2EupaLXhe6rkpdgXGRsUSdStyfldHsip3/R8AhJMDDEvbG9AkNqqX233to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988655; c=relaxed/simple;
	bh=qLIg5T8KR9Eao9z+C7HEPwKG1Rqei+w1QltFOf7LIWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCYGQ112AxXE/zdT+GDuMFWNZI4T8QMz7XUuKrvza7/OD6Spr9o0gULLvokjwI2QanTSBuVqw3vahj7JsV0VgeMV+RugOKYQOpw2IWRGhyzfZ6ua4qrO7RbNoSMXUdEWCz3q0J1iKv4c4Du4PfVwsQYYDw3TsVezi8ciwZoD4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXSW0OR7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXSW0OR7"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cebcf96fabso1199352a12.3
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 06:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730988651; x=1731593451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZgeCV4fvUha10RF5GPqBqyg5G/3NuGBxv4tTXXxp4o=;
        b=eXSW0OR7lgDrH+eYcmo3DxmnvT0PD14X9JRmFl+EOgfXXD04fM2vLj4rJul7zZTjaw
         yADuZxOYdNbjlNgFpUn88ezzy8fkspi6IjeA5ZGjD73t+s/DRD90Fz5OFL2ohEXafHF0
         RfgPtZZ9vynXJqRGkZEi96CYHApha6a4lL+hYbrtMZIVRGGN2iPY06STDDa3njHCaeC8
         ie98X+mYZ7daXh9F7C6HgTqk0qO6da17BH5Atrc8VPtMCTxqatOZ6EZ/6Bcu3POv7Dvc
         HhBoJ4UdkxrzItigkTrnpsNJJT/tYBeM69ATaJRspC5fCwDLps9wIHyDonyZHqQ2cbVt
         WnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730988651; x=1731593451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZgeCV4fvUha10RF5GPqBqyg5G/3NuGBxv4tTXXxp4o=;
        b=SKSFgtV7nRlGWUiNOcz1rn8QY5kAF7HW9zI0hdBisOlbyF6NipPVl/0s6ZvZ3XrjHK
         +O/AE8q6p+WlQ0PXv2Iip0RvJ99m/1fpp+hXC+ae9zvsmNPuYkHYr+ZCBtCrRr3gyjgL
         +uT4cbG8r1rPUjRolbCOjuEykH/opXuStWof4a4q/wF2479wiIsCN1xb7y+T66Xtj0SH
         VfNEScPVmr5oBv94Xcwm+DrRjzlKHsH0GhHvajBYuQa5/JwpMvFBCAILLOXDEE4TyzHl
         VcmRn6OR/BsdnZZ5ZXdtTSsiCyYuyDo9m1nzoRBqCkNKkPNywSdybIqraxD2B0gFy9Z/
         jvRQ==
X-Gm-Message-State: AOJu0Yw+EnEK+ZoHX4SLOPcwZmcaDUuqJ05UWg2qTdTM83cLUO2roVxy
	luA0W74YRt4OyTx3PB3ZbTZ+pGg2s/E5kaq+/z6C48i8vyXkxZL+
X-Google-Smtp-Source: AGHT+IGyJqGVNfzbCcl//liRI9ZacUdNqJF6AiJME5wLdqaCKS3jzIsySxxrJ7EuRJY80v6XgZeqfw==
X-Received: by 2002:a05:6402:5192:b0:5cf:57c:e693 with SMTP id 4fb4d7f45d1cf-5cf08bfc06amr91022a12.14.1730988651001;
        Thu, 07 Nov 2024 06:10:51 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ec90sm815424a12.58.2024.11.07.06.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:10:50 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v6 9/9] midx: add repository to `multi_pack_index` struct
Date: Thu,  7 Nov 2024 15:10:36 +0100
Message-ID: <2f9a14697806d3d358b79f0863d2d03ce79d1da8.1730976185.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730976185.git.karthik.188@gmail.com>
References: <cover.1730976185.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `multi_pack_index` struct represents the MIDX for a repository.
Here, we add a pointer to the repository in this struct, allowing direct
use of the repository variable without relying on the global
`the_repository` struct.

With this addition, we can determine the repository associated with a
`bitmap_index` struct. A `bitmap_index` points to either a `packed_git`
or a `multi_pack_index`, both of which have direct repository
references. To support this, we introduce a static helper function,
`bitmap_repo`, in `pack-bitmap.c`, which retrieves a repository given a
`bitmap_index`.

With this, we clear up all usages of `the_repository` within
`pack-bitmap.c` and also remove the `USE_THE_REPOSITORY_VARIABLE`
definition. Bringing us another step closer to remove all global
variable usage.

Although this change also opens up the potential to clean up `midx.c`,
doing so would require additional refactoring to pass the repository
struct to functions where the MIDX struct is created: a task better
suited for future patches.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx.c        |  1 +
 midx.h        |  3 ++
 pack-bitmap.c | 90 +++++++++++++++++++++++++++++++--------------------
 3 files changed, 59 insertions(+), 35 deletions(-)

diff --git a/midx.c b/midx.c
index 8edb75f51d..079c45a1aa 100644
--- a/midx.c
+++ b/midx.c
@@ -131,6 +131,7 @@ static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir
 	m->data = midx_map;
 	m->data_len = midx_size;
 	m->local = local;
+	m->repo = the_repository;
 
 	m->signature = get_be32(m->data);
 	if (m->signature != MIDX_SIGNATURE)
diff --git a/midx.h b/midx.h
index 42d4f8d149..3b0ac4d878 100644
--- a/midx.h
+++ b/midx.h
@@ -71,6 +71,9 @@ struct multi_pack_index {
 
 	const char **pack_names;
 	struct packed_git **packs;
+
+	struct repository *repo;
+
 	char object_dir[FLEX_ARRAY];
 };
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d34ba9909a..0cb1b56c9d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "commit.h"
 #include "gettext.h"
@@ -177,12 +175,21 @@ static uint32_t bitmap_num_objects(struct bitmap_index *index)
 	return index->pack->num_objects;
 }
 
+static struct repository *bitmap_repo(struct bitmap_index *bitmap_git)
+{
+	if (bitmap_is_midx(bitmap_git))
+		return bitmap_git->midx->repo;
+	return bitmap_git->pack->repo;
+}
+
 static int load_bitmap_header(struct bitmap_index *index)
 {
 	struct bitmap_disk_header *header = (void *)index->map;
-	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
+	const struct git_hash_algo *hash_algo = bitmap_repo(index)->hash_algo;
+
+	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + hash_algo->rawsz;
 
-	if (index->map_size < header_size + the_hash_algo->rawsz)
+	if (index->map_size < header_size + hash_algo->rawsz)
 		return error(_("corrupted bitmap index (too small)"));
 
 	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
@@ -196,7 +203,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 	{
 		uint32_t flags = ntohs(header->options);
 		size_t cache_size = st_mult(bitmap_num_objects(index), sizeof(uint32_t));
-		unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
+		unsigned char *index_end = index->map + index->map_size - hash_algo->rawsz;
 
 		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
 			BUG("unsupported options for bitmap index file "
@@ -409,7 +416,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (bitmap_git->pack || bitmap_git->midx) {
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
-		trace2_data_string("bitmap", the_repository,
+		trace2_data_string("bitmap", bitmap_repo(bitmap_git),
 				   "ignoring extra midx bitmap file", buf.buf);
 		close(fd);
 		strbuf_release(&buf);
@@ -427,7 +434,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		goto cleanup;
 
 	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum,
-		    the_repository->hash_algo)) {
+		    bitmap_repo(bitmap_git)->hash_algo)) {
 		error(_("checksum doesn't match in MIDX and bitmap"));
 		goto cleanup;
 	}
@@ -438,7 +445,9 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	}
 
 	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-		if (prepare_midx_pack(the_repository, bitmap_git->midx, i)) {
+		if (prepare_midx_pack(bitmap_repo(bitmap_git),
+				      bitmap_git->midx,
+				      i)) {
 			warning(_("could not open pack %s"),
 				bitmap_git->midx->pack_names[i]);
 			goto cleanup;
@@ -492,8 +501,9 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
-		trace2_data_string("bitmap", the_repository,
-				   "ignoring extra bitmap file", packfile->pack_name);
+		trace2_data_string("bitmap", bitmap_repo(bitmap_git),
+				   "ignoring extra bitmap file",
+				   packfile->pack_name);
 		close(fd);
 		return -1;
 	}
@@ -518,8 +528,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}
 
-	trace2_data_string("bitmap", the_repository, "opened bitmap file",
-			   packfile->pack_name);
+	trace2_data_string("bitmap", bitmap_repo(bitmap_git),
+			   "opened bitmap file", packfile->pack_name);
 	return 0;
 }
 
@@ -649,7 +659,7 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 {
-	struct repository *r = the_repository;
+	struct repository *r = midx->repo;
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
 	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitmap_git))
@@ -1213,6 +1223,7 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 {
 	struct bitmap_boundary_cb cb;
 	struct object_list *root;
+	struct repository *repo;
 	unsigned int i;
 	unsigned int tmp_blobs, tmp_trees, tmp_tags;
 	int any_missing = 0;
@@ -1222,6 +1233,8 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	cb.base = bitmap_new();
 	object_array_init(&cb.boundary);
 
+	repo = bitmap_repo(bitmap_git);
+
 	revs->ignore_missing_links = 1;
 
 	if (bitmap_git->pseudo_merges.nr) {
@@ -1280,19 +1293,19 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	 * revision walk to (a) OR in any bitmaps that are UNINTERESTING
 	 * between the tips and boundary, and (b) record the boundary.
 	 */
-	trace2_region_enter("pack-bitmap", "boundary-prepare", the_repository);
+	trace2_region_enter("pack-bitmap", "boundary-prepare", repo);
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
-	trace2_region_leave("pack-bitmap", "boundary-prepare", the_repository);
+	trace2_region_leave("pack-bitmap", "boundary-prepare", repo);
 
-	trace2_region_enter("pack-bitmap", "boundary-traverse", the_repository);
+	trace2_region_enter("pack-bitmap", "boundary-traverse", repo);
 	revs->boundary = 1;
 	traverse_commit_list_filtered(revs,
 				      show_boundary_commit,
 				      show_boundary_object,
 				      &cb, NULL);
 	revs->boundary = 0;
-	trace2_region_leave("pack-bitmap", "boundary-traverse", the_repository);
+	trace2_region_leave("pack-bitmap", "boundary-traverse", repo);
 
 	revs->blob_objects = tmp_blobs;
 	revs->tree_objects = tmp_trees;
@@ -1304,7 +1317,7 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	/*
 	 * Then add the boundary commit(s) as fill-in traversal tips.
 	 */
-	trace2_region_enter("pack-bitmap", "boundary-fill-in", the_repository);
+	trace2_region_enter("pack-bitmap", "boundary-fill-in", repo);
 	for (i = 0; i < cb.boundary.nr; i++) {
 		struct object *obj = cb.boundary.objects[i].item;
 		if (bitmap_walk_contains(bitmap_git, cb.base, &obj->oid))
@@ -1314,7 +1327,7 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	}
 	if (revs->pending.nr)
 		cb.base = fill_in_bitmap(bitmap_git, revs, cb.base, NULL);
-	trace2_region_leave("pack-bitmap", "boundary-fill-in", the_repository);
+	trace2_region_leave("pack-bitmap", "boundary-fill-in", repo);
 
 cleanup:
 	object_array_clear(&cb.boundary);
@@ -1718,7 +1731,8 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			ofs = pack_pos_to_offset(pack, pos);
 		}
 
-		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
+		if (packed_object_info(bitmap_repo(bitmap_git), pack, ofs,
+				       &oi) < 0) {
 			struct object_id oid;
 			nth_bitmap_object_oid(bitmap_git, &oid,
 					      pack_pos_to_index(pack, pos));
@@ -1727,7 +1741,8 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 	} else {
 		struct eindex *eindex = &bitmap_git->ext_index;
 		struct object *obj = eindex->objects[pos - bitmap_num_objects(bitmap_git)];
-		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
+		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
+					     &oi, 0) < 0)
 			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
 	}
 
@@ -1889,7 +1904,8 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 		bitmap_unset(result, i);
 
 	for (i = 0; i < eindex->count; ++i) {
-		if (has_object_pack(the_repository, &eindex->objects[i]->oid))
+		if (has_object_pack(bitmap_repo(bitmap_git),
+				    &eindex->objects[i]->oid))
 			bitmap_unset(result, objects_nr + i);
 	}
 }
@@ -1907,6 +1923,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	struct bitmap *haves_bitmap = NULL;
 
 	struct bitmap_index *bitmap_git;
+	struct repository *repo;
 
 	/*
 	 * We can't do pathspec limiting with bitmaps, because we don't know
@@ -1980,18 +1997,20 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	if (!use_boundary_traversal)
 		object_array_clear(&revs->pending);
 
+	repo = bitmap_repo(bitmap_git);
+
 	if (haves) {
 		if (use_boundary_traversal) {
-			trace2_region_enter("pack-bitmap", "haves/boundary", the_repository);
+			trace2_region_enter("pack-bitmap", "haves/boundary", repo);
 			haves_bitmap = find_boundary_objects(bitmap_git, revs, haves);
-			trace2_region_leave("pack-bitmap", "haves/boundary", the_repository);
+			trace2_region_leave("pack-bitmap", "haves/boundary", repo);
 		} else {
-			trace2_region_enter("pack-bitmap", "haves/classic", the_repository);
+			trace2_region_enter("pack-bitmap", "haves/classic", repo);
 			revs->ignore_missing_links = 1;
 			haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
 			reset_revision_walk();
 			revs->ignore_missing_links = 0;
-			trace2_region_leave("pack-bitmap", "haves/classic", the_repository);
+			trace2_region_leave("pack-bitmap", "haves/classic", repo);
 		}
 
 		if (!haves_bitmap)
@@ -2025,17 +2044,17 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	object_list_free(&wants);
 	object_list_free(&haves);
 
-	trace2_data_intmax("bitmap", the_repository, "pseudo_merges_satisfied",
+	trace2_data_intmax("bitmap", repo, "pseudo_merges_satisfied",
 			   pseudo_merges_satisfied_nr);
-	trace2_data_intmax("bitmap", the_repository, "pseudo_merges_cascades",
+	trace2_data_intmax("bitmap", repo, "pseudo_merges_cascades",
 			   pseudo_merges_cascades_nr);
-	trace2_data_intmax("bitmap", the_repository, "bitmap/hits",
+	trace2_data_intmax("bitmap", repo, "bitmap/hits",
 			   existing_bitmaps_hits_nr);
-	trace2_data_intmax("bitmap", the_repository, "bitmap/misses",
+	trace2_data_intmax("bitmap", repo, "bitmap/misses",
 			   existing_bitmaps_misses_nr);
-	trace2_data_intmax("bitmap", the_repository, "bitmap/roots_with_bitmap",
+	trace2_data_intmax("bitmap", repo, "bitmap/roots_with_bitmap",
 			   roots_with_bitmaps_nr);
-	trace2_data_intmax("bitmap", the_repository, "bitmap/roots_without_bitmap",
+	trace2_data_intmax("bitmap", repo, "bitmap/roots_without_bitmap",
 			   roots_without_bitmaps_nr);
 
 	return bitmap_git;
@@ -2256,7 +2275,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 					struct bitmap **reuse_out,
 					int multi_pack_reuse)
 {
-	struct repository *r = the_repository;
+	struct repository *r = bitmap_repo(bitmap_git);
 	struct bitmapped_pack *packs = NULL;
 	struct bitmap *result = bitmap_git->result;
 	struct bitmap *reuse;
@@ -2792,7 +2811,7 @@ int rebuild_bitmap(const uint32_t *reposition,
 uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 				struct packing_data *mapping)
 {
-	struct repository *r = the_repository;
+	struct repository *r = bitmap_repo(bitmap_git);
 	uint32_t i, num_objects;
 	uint32_t *reposition;
 
@@ -2948,7 +2967,8 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 				st_add(bitmap_num_objects(bitmap_git), i)))
 			continue;
 
-		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
+		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
+					     &oi, 0) < 0)
 			die(_("unable to get disk usage of '%s'"),
 			    oid_to_hex(&obj->oid));
 
-- 
2.47.0

