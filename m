Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A51F7568
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237058; cv=none; b=V1VaKVJIxDtDYiiGafET7VNxP/mVE30mDH5KEwdYPOn+hEiwEE+HniUa+SVP9MKPd6N7fe8h9jXMpt3Jgo2uwXPHch0Xz4xAgTU/3dRYGRoq1Rr7v5VUN2xmL2EAt3fdm8gqtbQIKiHxJbiQB9gp/gx5I8nXRioh+zhqxTaYRLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237058; c=relaxed/simple;
	bh=LoiQnzPFKHUaOa1zvlaYPIb9RzPIaZ9FWF6B5rIRFMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS7sGwENErS89XqWnOdeu6jDrtOwWW4yXGp1sB+s4vaVsauub+uowBj5pNXmt94Va4i1jFVB4P284jo6fki9Of05+drHkpr91wpZd2y0V98qQbGk73ijP4o0h1ADrZ+n6WSbOnUoCaKVdEtvdqKTcTyZ/ekVEsJ7vkm2cA14yP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK95nlrB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK95nlrB"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de92be287so8330052e87.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 06:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733237054; x=1733841854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VHiQz9DwZa9vgJZhYSKjaI0ZMnL6k4bPMVuPsZDPKM=;
        b=kK95nlrBjzh1uqSwnQ5aD8MNRJlwCM/N62QqubE3w+EuFbymGpJpCOTQn8GO7dq+n0
         BOzrJ2CUTPa/vT59J6utUBRAwzW9NmsrYrzmMo8RJtX0AeaM15vNoSJUiUqGSquLpeDJ
         p/4cypBUDM+iFJhdHHI7T301f7x3Bgn1bAQEQg307IhEp9vDcDIe0gWmiKnixTQTE8x0
         vxzeoDRft5MaIIo0BUgkgNVdTJbZO86kl0r1GOWaDWrBg7DnljccajhWysxF00RTGHa5
         waOKt7ySRfsrzmfPxGPn5Lpp6PxcDdVzWjtsDjZFsJDoQXrfVu6Qmz/w3/M/Ds7m7A+k
         q9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237054; x=1733841854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VHiQz9DwZa9vgJZhYSKjaI0ZMnL6k4bPMVuPsZDPKM=;
        b=Ho5U8Eg9P3jGns/Kp8QO4sKyWC+2D/C3Dh0jSEYVVYTPlbzO/U0bs/XZQLv/McIZwk
         mkMWdcRRnP6yPYIT0wdyMDPon53qm455sG3PPohXIt5q+i9PxhIrE9LF+2SKwws/yGib
         gvoq8b42Cusj+u1Ve0JavaWb+w8fsIwrU3N8YW0ySHacq5qCnIdDSFPiJ9Jx3pXFy5Lz
         lOm/Xm0++bRBY9LKXMKBjPZKV9EPFQ9hbikJamnTFLvHBt9uHEle+bmZaacsw/Jn08Sr
         Ob6W8xsEjMfB/wjetJdkSwKifLyWNNHai/rhta0lc+whpgBOLBPdAWD4Cq//x9/zToXH
         GxvA==
X-Gm-Message-State: AOJu0YzKdTJ9uHHyS8i7Tg5RWgCMHAw0JXcTPOKEymiwrVXeqszQKdgD
	NY0nIHE5SBOL1wRPxcUm5w8EEDj3Sn79xWGXpOm9MTteY+/D5GHd/jcpRz6I
X-Gm-Gg: ASbGnctdb+a0MozxPUTICm1ZNKZEGmc2dotf7+XV5icQlATjWZ9tfWDYL3g2qPBomzs
	c/3rso0r8mbjRmnYLyTj/hes8ZEzdzszrGXZU4zWIv+9LcLsrLc37/RN/MFzFFDoGufDsrCZwCh
	oInugbV41LAYrLQMcGfMr7ND9E+eW1iZ22KdMzvaYhd3Iw3kJF/AeHjBm7UaHW+Ix08GL14glmX
	97DOQ++XshIbUbZs/A0uUkFaVBtyANnKB/VltnTNwYgcsK0Gmak32HvxTeyrDjNK68G
X-Google-Smtp-Source: AGHT+IEJyOUbz4KZ6n3r07X7+dHgBzapxgTE0I47ertjeS/CLMXu+R7sBZ1+yrtjQFPLOTKj6xVdSQ==
X-Received: by 2002:a05:6512:3c99:b0:53d:ed95:9bfa with SMTP id 2adb3069b0e04-53e129ef865mr3022868e87.7.1733237054138;
        Tue, 03 Dec 2024 06:44:14 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de782sm619021466b.56.2024.12.03.06.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:44:13 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v10 09/10] midx: add repository to `multi_pack_index` struct
Date: Tue,  3 Dec 2024 15:44:03 +0100
Message-ID: <6e0ec955e65a359f72d1b14736fd91cb226efb66.1733236936.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733236936.git.karthik.188@gmail.com>
References: <cover.1733236936.git.karthik.188@gmail.com>
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
2.47.1

