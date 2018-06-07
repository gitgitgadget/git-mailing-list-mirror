Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7223A1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 19:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753607AbeFGTE3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 15:04:29 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41080 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753588AbeFGTE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 15:04:26 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so5186838pgl.8
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0OXATUdimQcdp4NlsLV2BXOHkhSVtvgXH2ST+m+fLEk=;
        b=LfxsB1UOHZwVcT891Kx9A9+wYWyxly50Vfvflkl8RKwCI/ALcT3new+TH5ip55tKAa
         8ZWyBu9za4FLmZG0c/BX1ZIFYEtzMkG6o9hbaD1DVDfLx/uxQEPEn8vkVEHsyACqTuen
         vCH+DSzMVZPlWkv/VF7kDzfXB9md2+kKvWqKjKxCB+z16M3Hf6oZxRH3peEacfQC7x/o
         +YqA4MdED/2EYloYCySevx8FTok1uucs9Em3/gq4EpY+7YcFCy+igtqjLqIG7tsaiQb7
         dCIopIGyb6FPKtWuSXkK5VJTKuwgKSFIQuawV0EpbYIg7SAjxBK/qrg0tOaaIGgXQk9Y
         PYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0OXATUdimQcdp4NlsLV2BXOHkhSVtvgXH2ST+m+fLEk=;
        b=p9x1wto5k3yNyLWGspnYu6MUlBBCt7CjvyIyhU56dOrTuRCXEXGfbW8YnfPMMF8zAp
         vexLlhPOamUTO0SxXckSyv5NsHtv2Rq97XJ+ot4bj3RXiEg70IxQM6w06th1q8Hi1zXe
         R08lfDusEVdGeL8mmCUNm+7Obcq9KPhbaBQUAH3f3nACdpQDdv4hA6cBP6oERkKJeO7J
         Y671y+cDO6k1lwMRO0KFrYrEucKhLMMDU809FLuFltmDrDPB9gc1eD8MYPySjIjDWc2v
         QeR3h9WkR3rjAZvhBE94nXbxKxm4ZJhahQ6vqYHDbYbUR4csNHhvXKP0HPX4yToUu1Sl
         Zovg==
X-Gm-Message-State: APt69E2CWz/x5iJXKC4i42PWYRBkqUhEhKhA1EHJ5L4DVKnyxU6iXkT2
        vu4IyLIostuHhy1Pm+5pFA9ssBBZO4I=
X-Google-Smtp-Source: ADUXVKLhfyFMb+vJjwyDi4DiKKSBwQogpL57NE4aaA+4gj9Dy9YuvE9lHQ2rxSj5qXWZa2IqX7u0jw==
X-Received: by 2002:a62:f807:: with SMTP id d7-v6mr2871309pfh.213.1528398264146;
        Thu, 07 Jun 2018 12:04:24 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x2-v6sm16324624pfn.11.2018.06.07.12.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 12:04:22 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH 1/2] pack-bitmap: remove bitmap_git global variable
Date:   Thu,  7 Jun 2018 12:04:13 -0700
Message-Id: <d4d4fec265c1c53e14da465904d93e559ff2c17d.1528397984.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528397984.git.jonathantanmy@google.com>
References: <cover.1528397984.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the bitmap_git global variable. Instead, generate on demand an
instance of struct bitmap_index for code that needs to access it.

This allows us significant control over the lifetime of instances of
struct bitmap_index. In particular, packs can now be closed without
worrying if an unnecessarily long-lived "pack" field in struct
bitmap_index still points to it.

The bitmap API is also clearer in that we need to first obtain a struct
bitmap_index, then we use it.

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/pack-objects.c |   6 +-
 builtin/rev-list.c     |  11 +-
 pack-bitmap-write.c    |   6 +-
 pack-bitmap.c          | 317 ++++++++++++++++++++++-------------------
 pack-bitmap.h          |  19 ++-
 5 files changed, 201 insertions(+), 158 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 71056d829..d064f944b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2929,11 +2929,13 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	if (prepare_bitmap_walk(revs) < 0)
+	struct bitmap_index *bitmap_git;
+	if (!(bitmap_git = prepare_bitmap_walk(revs)))
 		return -1;
 
 	if (pack_options_allow_reuse() &&
 	    !reuse_partial_packfile_from_bitmap(
+			bitmap_git,
 			&reuse_packfile,
 			&reuse_packfile_objects,
 			&reuse_packfile_offset)) {
@@ -2942,7 +2944,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 		display_progress(progress_state, nr_result);
 	}
 
-	traverse_bitmap_commit_list(&add_object_entry_from_bitmap);
+	traverse_bitmap_commit_list(bitmap_git, &add_object_entry_from_bitmap);
 	return 0;
 }
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index fadd3ec14..cce42ae1d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -16,6 +16,7 @@
 #include "reflog-walk.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -514,8 +515,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (revs.count && !revs.left_right && !revs.cherry_mark) {
 			uint32_t commit_count;
 			int max_count = revs.max_count;
-			if (!prepare_bitmap_walk(&revs)) {
-				count_bitmap_commit_list(&commit_count, NULL, NULL, NULL);
+			struct bitmap_index *bitmap_git;
+			if ((bitmap_git = prepare_bitmap_walk(&revs))) {
+				count_bitmap_commit_list(bitmap_git, &commit_count, NULL, NULL, NULL);
 				if (max_count >= 0 && max_count < commit_count)
 					commit_count = max_count;
 				printf("%d\n", commit_count);
@@ -523,8 +525,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			}
 		} else if (revs.max_count < 0 &&
 			   revs.tag_objects && revs.tree_objects && revs.blob_objects) {
-			if (!prepare_bitmap_walk(&revs)) {
-				traverse_bitmap_commit_list(&show_object_fast);
+			struct bitmap_index *bitmap_git;
+			if ((bitmap_git = prepare_bitmap_walk(&revs))) {
+				traverse_bitmap_commit_list(bitmap_git, &show_object_fast);
 				return 0;
 			}
 		}
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 7b2dc3e7d..03e122563 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -360,11 +360,13 @@ static int date_compare(const void *_a, const void *_b)
 
 void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack)
 {
-	if (prepare_bitmap_git() < 0)
+	struct bitmap_index *bitmap_git;
+	if (!(bitmap_git = prepare_bitmap_git()))
 		return;
 
 	writer.reused = kh_init_sha1();
-	rebuild_existing_bitmaps(to_pack, writer.reused, writer.show_progress);
+	rebuild_existing_bitmaps(bitmap_git, to_pack, writer.reused,
+				 writer.show_progress);
 }
 
 static struct ewah_bitmap *find_reused_bitmap(const unsigned char *sha1)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 06771113f..7795444b0 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -25,14 +25,14 @@ struct stored_bitmap {
 };
 
 /*
- * The currently active bitmap index. By design, repositories only have
+ * The active bitmap index for a repository. By design, repositories only have
  * a single bitmap index available (the index for the biggest packfile in
  * the repository), since bitmap indexes need full closure.
  *
  * If there is more than one bitmap index available (e.g. because of alternates),
  * the active bitmap index is the largest one.
  */
-static struct bitmap_index {
+struct bitmap_index {
 	/* Packfile to which this bitmap index belongs to */
 	struct packed_git *pack;
 
@@ -90,8 +90,7 @@ static struct bitmap_index {
 	unsigned int version;
 
 	unsigned loaded : 1;
-
-} bitmap_git;
+};
 
 static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
 {
@@ -259,7 +258,7 @@ static char *pack_bitmap_filename(struct packed_git *p)
 	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
 }
 
-static int open_pack_bitmap_1(struct packed_git *packfile)
+static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
 {
 	int fd;
 	struct stat st;
@@ -280,117 +279,121 @@ static int open_pack_bitmap_1(struct packed_git *packfile)
 		return -1;
 	}
 
-	if (bitmap_git.pack) {
+	if (bitmap_git->pack) {
 		warning("ignoring extra bitmap file: %s", packfile->pack_name);
 		close(fd);
 		return -1;
 	}
 
-	bitmap_git.pack = packfile;
-	bitmap_git.map_size = xsize_t(st.st_size);
-	bitmap_git.map = xmmap(NULL, bitmap_git.map_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	bitmap_git.map_pos = 0;
+	bitmap_git->pack = packfile;
+	bitmap_git->map_size = xsize_t(st.st_size);
+	bitmap_git->map = xmmap(NULL, bitmap_git->map_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	bitmap_git->map_pos = 0;
 	close(fd);
 
-	if (load_bitmap_header(&bitmap_git) < 0) {
-		munmap(bitmap_git.map, bitmap_git.map_size);
-		bitmap_git.map = NULL;
-		bitmap_git.map_size = 0;
+	if (load_bitmap_header(bitmap_git) < 0) {
+		munmap(bitmap_git->map, bitmap_git->map_size);
+		bitmap_git->map = NULL;
+		bitmap_git->map_size = 0;
 		return -1;
 	}
 
 	return 0;
 }
 
-static int load_pack_bitmap(void)
+static int load_pack_bitmap(struct bitmap_index *bitmap_git)
 {
-	assert(bitmap_git.map && !bitmap_git.loaded);
+	assert(bitmap_git->map && !bitmap_git->loaded);
 
-	bitmap_git.bitmaps = kh_init_sha1();
-	bitmap_git.ext_index.positions = kh_init_sha1_pos();
-	load_pack_revindex(bitmap_git.pack);
+	bitmap_git->bitmaps = kh_init_sha1();
+	bitmap_git->ext_index.positions = kh_init_sha1_pos();
+	load_pack_revindex(bitmap_git->pack);
 
-	if (!(bitmap_git.commits = read_bitmap_1(&bitmap_git)) ||
-		!(bitmap_git.trees = read_bitmap_1(&bitmap_git)) ||
-		!(bitmap_git.blobs = read_bitmap_1(&bitmap_git)) ||
-		!(bitmap_git.tags = read_bitmap_1(&bitmap_git)))
+	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
+		!(bitmap_git->trees = read_bitmap_1(bitmap_git)) ||
+		!(bitmap_git->blobs = read_bitmap_1(bitmap_git)) ||
+		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
 		goto failed;
 
-	if (load_bitmap_entries_v1(&bitmap_git) < 0)
+	if (load_bitmap_entries_v1(bitmap_git) < 0)
 		goto failed;
 
-	bitmap_git.loaded = 1;
+	bitmap_git->loaded = 1;
 	return 0;
 
 failed:
-	munmap(bitmap_git.map, bitmap_git.map_size);
-	bitmap_git.map = NULL;
-	bitmap_git.map_size = 0;
+	munmap(bitmap_git->map, bitmap_git->map_size);
+	bitmap_git->map = NULL;
+	bitmap_git->map_size = 0;
 	return -1;
 }
 
-static int open_pack_bitmap(void)
+static int open_pack_bitmap(struct bitmap_index *bitmap_git)
 {
 	struct packed_git *p;
 	int ret = -1;
 
-	assert(!bitmap_git.map && !bitmap_git.loaded);
+	assert(!bitmap_git->map && !bitmap_git->loaded);
 
 	for (p = get_packed_git(the_repository); p; p = p->next) {
-		if (open_pack_bitmap_1(p) == 0)
+		if (open_pack_bitmap_1(bitmap_git, p) == 0)
 			ret = 0;
 	}
 
 	return ret;
 }
 
-int prepare_bitmap_git(void)
+struct bitmap_index *prepare_bitmap_git(void)
 {
-	if (bitmap_git.loaded)
-		return 0;
+	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_pack_bitmap())
-		return load_pack_bitmap();
+	if (!open_pack_bitmap(bitmap_git) && !load_pack_bitmap(bitmap_git))
+		return bitmap_git;
 
-	return -1;
+	return NULL;
 }
 
 struct include_data {
+	struct bitmap_index *bitmap_git;
 	struct bitmap *base;
 	struct bitmap *seen;
 };
 
-static inline int bitmap_position_extended(const unsigned char *sha1)
+static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
+					   const unsigned char *sha1)
 {
-	khash_sha1_pos *positions = bitmap_git.ext_index.positions;
+	khash_sha1_pos *positions = bitmap_git->ext_index.positions;
 	khiter_t pos = kh_get_sha1_pos(positions, sha1);
 
 	if (pos < kh_end(positions)) {
 		int bitmap_pos = kh_value(positions, pos);
-		return bitmap_pos + bitmap_git.pack->num_objects;
+		return bitmap_pos + bitmap_git->pack->num_objects;
 	}
 
 	return -1;
 }
 
-static inline int bitmap_position_packfile(const unsigned char *sha1)
+static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
+					   const unsigned char *sha1)
 {
-	off_t offset = find_pack_entry_one(sha1, bitmap_git.pack);
+	off_t offset = find_pack_entry_one(sha1, bitmap_git->pack);
 	if (!offset)
 		return -1;
 
-	return find_revindex_position(bitmap_git.pack, offset);
+	return find_revindex_position(bitmap_git->pack, offset);
 }
 
-static int bitmap_position(const unsigned char *sha1)
+static int bitmap_position(struct bitmap_index *bitmap_git,
+			   const unsigned char *sha1)
 {
-	int pos = bitmap_position_packfile(sha1);
-	return (pos >= 0) ? pos : bitmap_position_extended(sha1);
+	int pos = bitmap_position_packfile(bitmap_git, sha1);
+	return (pos >= 0) ? pos : bitmap_position_extended(bitmap_git, sha1);
 }
 
-static int ext_index_add_object(struct object *object, const char *name)
+static int ext_index_add_object(struct bitmap_index *bitmap_git,
+				struct object *object, const char *name)
 {
-	struct eindex *eindex = &bitmap_git.ext_index;
+	struct eindex *eindex = &bitmap_git->ext_index;
 
 	khiter_t hash_pos;
 	int hash_ret;
@@ -413,27 +416,34 @@ static int ext_index_add_object(struct object *object, const char *name)
 		bitmap_pos = kh_value(eindex->positions, hash_pos);
 	}
 
-	return bitmap_pos + bitmap_git.pack->num_objects;
+	return bitmap_pos + bitmap_git->pack->num_objects;
 }
 
-static void show_object(struct object *object, const char *name, void *data)
+struct bitmap_show_data {
+	struct bitmap_index *bitmap_git;
+	struct bitmap *base;
+};
+
+static void show_object(struct object *object, const char *name, void *data_)
 {
-	struct bitmap *base = data;
+	struct bitmap_show_data *data = data_;
 	int bitmap_pos;
 
-	bitmap_pos = bitmap_position(object->oid.hash);
+	bitmap_pos = bitmap_position(data->bitmap_git, object->oid.hash);
 
 	if (bitmap_pos < 0)
-		bitmap_pos = ext_index_add_object(object, name);
+		bitmap_pos = ext_index_add_object(data->bitmap_git, object,
+						  name);
 
-	bitmap_set(base, bitmap_pos);
+	bitmap_set(data->base, bitmap_pos);
 }
 
 static void show_commit(struct commit *commit, void *data)
 {
 }
 
-static int add_to_include_set(struct include_data *data,
+static int add_to_include_set(struct bitmap_index *bitmap_git,
+			      struct include_data *data,
 			      const unsigned char *sha1,
 			      int bitmap_pos)
 {
@@ -445,9 +455,9 @@ static int add_to_include_set(struct include_data *data,
 	if (bitmap_get(data->base, bitmap_pos))
 		return 0;
 
-	hash_pos = kh_get_sha1(bitmap_git.bitmaps, sha1);
-	if (hash_pos < kh_end(bitmap_git.bitmaps)) {
-		struct stored_bitmap *st = kh_value(bitmap_git.bitmaps, hash_pos);
+	hash_pos = kh_get_sha1(bitmap_git->bitmaps, sha1);
+	if (hash_pos < kh_end(bitmap_git->bitmaps)) {
+		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, hash_pos);
 		bitmap_or_ewah(data->base, lookup_stored_bitmap(st));
 		return 0;
 	}
@@ -461,11 +471,14 @@ static int should_include(struct commit *commit, void *_data)
 	struct include_data *data = _data;
 	int bitmap_pos;
 
-	bitmap_pos = bitmap_position(commit->object.oid.hash);
+	bitmap_pos = bitmap_position(data->bitmap_git, commit->object.oid.hash);
 	if (bitmap_pos < 0)
-		bitmap_pos = ext_index_add_object((struct object *)commit, NULL);
+		bitmap_pos = ext_index_add_object(data->bitmap_git,
+						  (struct object *)commit,
+						  NULL);
 
-	if (!add_to_include_set(data, commit->object.oid.hash, bitmap_pos)) {
+	if (!add_to_include_set(data->bitmap_git, data, commit->object.oid.hash,
+				bitmap_pos)) {
 		struct commit_list *parent = commit->parents;
 
 		while (parent) {
@@ -479,7 +492,8 @@ static int should_include(struct commit *commit, void *_data)
 	return 1;
 }
 
-static struct bitmap *find_objects(struct rev_info *revs,
+static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
+				   struct rev_info *revs,
 				   struct object_list *roots,
 				   struct bitmap *seen)
 {
@@ -501,10 +515,10 @@ static struct bitmap *find_objects(struct rev_info *revs,
 		roots = roots->next;
 
 		if (object->type == OBJ_COMMIT) {
-			khiter_t pos = kh_get_sha1(bitmap_git.bitmaps, object->oid.hash);
+			khiter_t pos = kh_get_sha1(bitmap_git->bitmaps, object->oid.hash);
 
-			if (pos < kh_end(bitmap_git.bitmaps)) {
-				struct stored_bitmap *st = kh_value(bitmap_git.bitmaps, pos);
+			if (pos < kh_end(bitmap_git->bitmaps)) {
+				struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
 				struct ewah_bitmap *or_with = lookup_stored_bitmap(st);
 
 				if (base == NULL)
@@ -543,7 +557,7 @@ static struct bitmap *find_objects(struct rev_info *revs,
 		int pos;
 
 		roots = roots->next;
-		pos = bitmap_position(object->oid.hash);
+		pos = bitmap_position(bitmap_git, object->oid.hash);
 
 		if (pos < 0 || base == NULL || !bitmap_get(base, pos)) {
 			object->flags &= ~UNINTERESTING;
@@ -556,10 +570,12 @@ static struct bitmap *find_objects(struct rev_info *revs,
 
 	if (needs_walk) {
 		struct include_data incdata;
+		struct bitmap_show_data show_data;
 
 		if (base == NULL)
 			base = bitmap_new();
 
+		incdata.bitmap_git = bitmap_git;
 		incdata.base = base;
 		incdata.seen = seen;
 
@@ -569,22 +585,27 @@ static struct bitmap *find_objects(struct rev_info *revs,
 		if (prepare_revision_walk(revs))
 			die("revision walk setup failed");
 
-		traverse_commit_list(revs, show_commit, show_object, base);
+		show_data.bitmap_git = bitmap_git;
+		show_data.base = base;
+
+		traverse_commit_list(revs, show_commit, show_object,
+				     &show_data);
 	}
 
 	return base;
 }
 
-static void show_extended_objects(struct bitmap *objects,
+static void show_extended_objects(struct bitmap_index *bitmap_git,
 				  show_reachable_fn show_reach)
 {
-	struct eindex *eindex = &bitmap_git.ext_index;
+	struct bitmap *objects = bitmap_git->result;
+	struct eindex *eindex = &bitmap_git->ext_index;
 	uint32_t i;
 
 	for (i = 0; i < eindex->count; ++i) {
 		struct object *obj;
 
-		if (!bitmap_get(objects, bitmap_git.pack->num_objects + i))
+		if (!bitmap_get(objects, bitmap_git->pack->num_objects + i))
 			continue;
 
 		obj = eindex->objects[i];
@@ -593,7 +614,7 @@ static void show_extended_objects(struct bitmap *objects,
 }
 
 static void show_objects_for_type(
-	struct bitmap *objects,
+	struct bitmap_index *bitmap_git,
 	struct ewah_bitmap *type_filter,
 	enum object_type object_type,
 	show_reachable_fn show_reach)
@@ -604,7 +625,9 @@ static void show_objects_for_type(
 	struct ewah_iterator it;
 	eword_t filter;
 
-	if (bitmap_git.reuse_objects == bitmap_git.pack->num_objects)
+	struct bitmap *objects = bitmap_git->result;
+
+	if (bitmap_git->reuse_objects == bitmap_git->pack->num_objects)
 		return;
 
 	ewah_iterator_init(&it, type_filter);
@@ -622,16 +645,16 @@ static void show_objects_for_type(
 
 			offset += ewah_bit_ctz64(word >> offset);
 
-			if (pos + offset < bitmap_git.reuse_objects)
+			if (pos + offset < bitmap_git->reuse_objects)
 				continue;
 
-			entry = &bitmap_git.pack->revindex[pos + offset];
-			nth_packed_object_oid(&oid, bitmap_git.pack, entry->nr);
+			entry = &bitmap_git->pack->revindex[pos + offset];
+			nth_packed_object_oid(&oid, bitmap_git->pack, entry->nr);
 
-			if (bitmap_git.hashes)
-				hash = get_be32(bitmap_git.hashes + entry->nr);
+			if (bitmap_git->hashes)
+				hash = get_be32(bitmap_git->hashes + entry->nr);
 
-			show_reach(&oid, object_type, 0, hash, bitmap_git.pack, entry->offset);
+			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, entry->offset);
 		}
 
 		pos += BITS_IN_EWORD;
@@ -639,20 +662,21 @@ static void show_objects_for_type(
 	}
 }
 
-static int in_bitmapped_pack(struct object_list *roots)
+static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
+			     struct object_list *roots)
 {
 	while (roots) {
 		struct object *object = roots->item;
 		roots = roots->next;
 
-		if (find_pack_entry_one(object->oid.hash, bitmap_git.pack) > 0)
+		if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
 			return 1;
 	}
 
 	return 0;
 }
 
-int prepare_bitmap_walk(struct rev_info *revs)
+struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 {
 	unsigned int i;
 
@@ -662,12 +686,11 @@ int prepare_bitmap_walk(struct rev_info *revs)
 	struct bitmap *wants_bitmap = NULL;
 	struct bitmap *haves_bitmap = NULL;
 
-	if (!bitmap_git.loaded) {
-		/* try to open a bitmapped pack, but don't parse it yet
-		 * because we may not need to use it */
-		if (open_pack_bitmap() < 0)
-			return -1;
-	}
+	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
+	/* try to open a bitmapped pack, but don't parse it yet
+	 * because we may not need to use it */
+	if (open_pack_bitmap(bitmap_git) < 0)
+		return NULL;
 
 	for (i = 0; i < revs->pending.nr; ++i) {
 		struct object *object = revs->pending.objects[i].item;
@@ -699,26 +722,26 @@ int prepare_bitmap_walk(struct rev_info *revs)
 	 * in the packfile that has a bitmap, we don't have anything to
 	 * optimize here
 	 */
-	if (haves && !in_bitmapped_pack(haves))
-		return -1;
+	if (haves && !in_bitmapped_pack(bitmap_git, haves))
+		return NULL;
 
 	/* if we don't want anything, we're done here */
 	if (!wants)
-		return -1;
+		return NULL;
 
 	/*
 	 * now we're going to use bitmaps, so load the actual bitmap entries
 	 * from disk. this is the point of no return; after this the rev_list
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
-	if (!bitmap_git.loaded && load_pack_bitmap() < 0)
-		return -1;
+	if (!bitmap_git->loaded && load_pack_bitmap(bitmap_git) < 0)
+		return NULL;
 
 	object_array_clear(&revs->pending);
 
 	if (haves) {
 		revs->ignore_missing_links = 1;
-		haves_bitmap = find_objects(revs, haves, NULL);
+		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
 		reset_revision_walk();
 		revs->ignore_missing_links = 0;
 
@@ -726,7 +749,7 @@ int prepare_bitmap_walk(struct rev_info *revs)
 			BUG("failed to perform bitmap walk");
 	}
 
-	wants_bitmap = find_objects(revs, wants, haves_bitmap);
+	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap);
 
 	if (!wants_bitmap)
 		BUG("failed to perform bitmap walk");
@@ -734,13 +757,14 @@ int prepare_bitmap_walk(struct rev_info *revs)
 	if (haves_bitmap)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
 
-	bitmap_git.result = wants_bitmap;
+	bitmap_git->result = wants_bitmap;
 
 	bitmap_free(haves_bitmap);
-	return 0;
+	return bitmap_git;
 }
 
-int reuse_partial_packfile_from_bitmap(struct packed_git **packfile,
+int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
+				       struct packed_git **packfile,
 				       uint32_t *entries,
 				       off_t *up_to)
 {
@@ -750,7 +774,7 @@ int reuse_partial_packfile_from_bitmap(struct packed_git **packfile,
 	 */
 	static const double REUSE_PERCENT = 0.9;
 
-	struct bitmap *result = bitmap_git.result;
+	struct bitmap *result = bitmap_git->result;
 	uint32_t reuse_threshold;
 	uint32_t i, reuse_objects = 0;
 
@@ -770,8 +794,8 @@ int reuse_partial_packfile_from_bitmap(struct packed_git **packfile,
 		const unsigned char *sha1;
 		struct revindex_entry *entry;
 
-		entry = &bitmap_git.reverse_index->revindex[reuse_objects];
-		sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
+		entry = &bitmap_git->reverse_index->revindex[reuse_objects];
+		sha1 = nth_packed_object_sha1(bitmap_git->pack, entry->nr);
 
 		fprintf(stderr, "Failed to reuse at %d (%016llx)\n",
 			reuse_objects, result->words[i]);
@@ -782,48 +806,50 @@ int reuse_partial_packfile_from_bitmap(struct packed_git **packfile,
 	if (!reuse_objects)
 		return -1;
 
-	if (reuse_objects >= bitmap_git.pack->num_objects) {
-		bitmap_git.reuse_objects = *entries = bitmap_git.pack->num_objects;
+	if (reuse_objects >= bitmap_git->pack->num_objects) {
+		bitmap_git->reuse_objects = *entries = bitmap_git->pack->num_objects;
 		*up_to = -1; /* reuse the full pack */
-		*packfile = bitmap_git.pack;
+		*packfile = bitmap_git->pack;
 		return 0;
 	}
 
-	reuse_threshold = bitmap_popcount(bitmap_git.result) * REUSE_PERCENT;
+	reuse_threshold = bitmap_popcount(bitmap_git->result) * REUSE_PERCENT;
 
 	if (reuse_objects < reuse_threshold)
 		return -1;
 
-	bitmap_git.reuse_objects = *entries = reuse_objects;
-	*up_to = bitmap_git.pack->revindex[reuse_objects].offset;
-	*packfile = bitmap_git.pack;
+	bitmap_git->reuse_objects = *entries = reuse_objects;
+	*up_to = bitmap_git->pack->revindex[reuse_objects].offset;
+	*packfile = bitmap_git->pack;
 
 	return 0;
 }
 
-void traverse_bitmap_commit_list(show_reachable_fn show_reachable)
+void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
+				 show_reachable_fn show_reachable)
 {
-	assert(bitmap_git.result);
+	assert(bitmap_git->result);
 
-	show_objects_for_type(bitmap_git.result, bitmap_git.commits,
+	show_objects_for_type(bitmap_git, bitmap_git->commits,
 		OBJ_COMMIT, show_reachable);
-	show_objects_for_type(bitmap_git.result, bitmap_git.trees,
+	show_objects_for_type(bitmap_git, bitmap_git->trees,
 		OBJ_TREE, show_reachable);
-	show_objects_for_type(bitmap_git.result, bitmap_git.blobs,
+	show_objects_for_type(bitmap_git, bitmap_git->blobs,
 		OBJ_BLOB, show_reachable);
-	show_objects_for_type(bitmap_git.result, bitmap_git.tags,
+	show_objects_for_type(bitmap_git, bitmap_git->tags,
 		OBJ_TAG, show_reachable);
 
-	show_extended_objects(bitmap_git.result, show_reachable);
+	show_extended_objects(bitmap_git, show_reachable);
 
-	bitmap_free(bitmap_git.result);
-	bitmap_git.result = NULL;
+	bitmap_free(bitmap_git->result);
+	bitmap_git->result = NULL;
 }
 
-static uint32_t count_object_type(struct bitmap *objects,
+static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 				  enum object_type type)
 {
-	struct eindex *eindex = &bitmap_git.ext_index;
+	struct bitmap *objects = bitmap_git->result;
+	struct eindex *eindex = &bitmap_git->ext_index;
 
 	uint32_t i = 0, count = 0;
 	struct ewah_iterator it;
@@ -831,19 +857,19 @@ static uint32_t count_object_type(struct bitmap *objects,
 
 	switch (type) {
 	case OBJ_COMMIT:
-		ewah_iterator_init(&it, bitmap_git.commits);
+		ewah_iterator_init(&it, bitmap_git->commits);
 		break;
 
 	case OBJ_TREE:
-		ewah_iterator_init(&it, bitmap_git.trees);
+		ewah_iterator_init(&it, bitmap_git->trees);
 		break;
 
 	case OBJ_BLOB:
-		ewah_iterator_init(&it, bitmap_git.blobs);
+		ewah_iterator_init(&it, bitmap_git->blobs);
 		break;
 
 	case OBJ_TAG:
-		ewah_iterator_init(&it, bitmap_git.tags);
+		ewah_iterator_init(&it, bitmap_git->tags);
 		break;
 
 	default:
@@ -857,32 +883,34 @@ static uint32_t count_object_type(struct bitmap *objects,
 
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
-			bitmap_get(objects, bitmap_git.pack->num_objects + i))
+			bitmap_get(objects, bitmap_git->pack->num_objects + i))
 			count++;
 	}
 
 	return count;
 }
 
-void count_bitmap_commit_list(uint32_t *commits, uint32_t *trees,
+void count_bitmap_commit_list(struct bitmap_index *bitmap_git,
+			      uint32_t *commits, uint32_t *trees,
 			      uint32_t *blobs, uint32_t *tags)
 {
-	assert(bitmap_git.result);
+	assert(bitmap_git->result);
 
 	if (commits)
-		*commits = count_object_type(bitmap_git.result, OBJ_COMMIT);
+		*commits = count_object_type(bitmap_git, OBJ_COMMIT);
 
 	if (trees)
-		*trees = count_object_type(bitmap_git.result, OBJ_TREE);
+		*trees = count_object_type(bitmap_git, OBJ_TREE);
 
 	if (blobs)
-		*blobs = count_object_type(bitmap_git.result, OBJ_BLOB);
+		*blobs = count_object_type(bitmap_git, OBJ_BLOB);
 
 	if (tags)
-		*tags = count_object_type(bitmap_git.result, OBJ_TAG);
+		*tags = count_object_type(bitmap_git, OBJ_TAG);
 }
 
 struct bitmap_test_data {
+	struct bitmap_index *bitmap_git;
 	struct bitmap *base;
 	struct progress *prg;
 	size_t seen;
@@ -894,7 +922,7 @@ static void test_show_object(struct object *object, const char *name,
 	struct bitmap_test_data *tdata = data;
 	int bitmap_pos;
 
-	bitmap_pos = bitmap_position(object->oid.hash);
+	bitmap_pos = bitmap_position(tdata->bitmap_git, object->oid.hash);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&object->oid));
 
@@ -907,7 +935,8 @@ static void test_show_commit(struct commit *commit, void *data)
 	struct bitmap_test_data *tdata = data;
 	int bitmap_pos;
 
-	bitmap_pos = bitmap_position(commit->object.oid.hash);
+	bitmap_pos = bitmap_position(tdata->bitmap_git,
+				     commit->object.oid.hash);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&commit->object.oid));
 
@@ -922,21 +951,22 @@ void test_bitmap_walk(struct rev_info *revs)
 	khiter_t pos;
 	size_t result_popcnt;
 	struct bitmap_test_data tdata;
+	struct bitmap_index *bitmap_git;
 
-	if (prepare_bitmap_git())
+	if (!(bitmap_git = prepare_bitmap_git()))
 		die("failed to load bitmap indexes");
 
 	if (revs->pending.nr != 1)
 		die("you must specify exactly one commit to test");
 
 	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
-		bitmap_git.version, bitmap_git.entry_count);
+		bitmap_git->version, bitmap_git->entry_count);
 
 	root = revs->pending.objects[0].item;
-	pos = kh_get_sha1(bitmap_git.bitmaps, root->oid.hash);
+	pos = kh_get_sha1(bitmap_git->bitmaps, root->oid.hash);
 
-	if (pos < kh_end(bitmap_git.bitmaps)) {
-		struct stored_bitmap *st = kh_value(bitmap_git.bitmaps, pos);
+	if (pos < kh_end(bitmap_git->bitmaps)) {
+		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
 		struct ewah_bitmap *bm = lookup_stored_bitmap(st);
 
 		fprintf(stderr, "Found bitmap for %s. %d bits / %08x checksum\n",
@@ -957,6 +987,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 
+	tdata.bitmap_git = bitmap_git;
 	tdata.base = bitmap_new();
 	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
 	tdata.seen = 0;
@@ -1004,7 +1035,8 @@ static int rebuild_bitmap(uint32_t *reposition,
 	return 0;
 }
 
-int rebuild_existing_bitmaps(struct packing_data *mapping,
+int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
+			     struct packing_data *mapping,
 			     khash_sha1 *reused_bitmaps,
 			     int show_progress)
 {
@@ -1017,10 +1049,7 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 	khiter_t hash_pos;
 	int hash_ret;
 
-	if (prepare_bitmap_git() < 0)
-		return -1;
-
-	num_objects = bitmap_git.pack->num_objects;
+	num_objects = bitmap_git->pack->num_objects;
 	reposition = xcalloc(num_objects, sizeof(uint32_t));
 
 	for (i = 0; i < num_objects; ++i) {
@@ -1028,8 +1057,8 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 		struct revindex_entry *entry;
 		struct object_entry *oe;
 
-		entry = &bitmap_git.pack->revindex[i];
-		sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
+		entry = &bitmap_git->pack->revindex[i];
+		sha1 = nth_packed_object_sha1(bitmap_git->pack, entry->nr);
 		oe = packlist_find(mapping, sha1, NULL);
 
 		if (oe)
@@ -1042,7 +1071,7 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 	if (show_progress)
 		progress = start_progress("Reusing bitmaps", 0);
 
-	kh_foreach_value(bitmap_git.bitmaps, stored, {
+	kh_foreach_value(bitmap_git->bitmaps, stored, {
 		if (stored->flags & BITMAP_FLAG_REUSE) {
 			if (!rebuild_bitmap(reposition,
 					    lookup_stored_bitmap(stored),
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 5ded2f139..19f70043a 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -34,13 +34,20 @@ typedef int (*show_reachable_fn)(
 	struct packed_git *found_pack,
 	off_t found_offset);
 
-int prepare_bitmap_git(void);
-void count_bitmap_commit_list(uint32_t *commits, uint32_t *trees, uint32_t *blobs, uint32_t *tags);
-void traverse_bitmap_commit_list(show_reachable_fn show_reachable);
+struct bitmap_index;
+
+struct bitmap_index *prepare_bitmap_git(void);
+void count_bitmap_commit_list(struct bitmap_index *, uint32_t *commits,
+			      uint32_t *trees, uint32_t *blobs, uint32_t *tags);
+void traverse_bitmap_commit_list(struct bitmap_index *,
+				 show_reachable_fn show_reachable);
 void test_bitmap_walk(struct rev_info *revs);
-int prepare_bitmap_walk(struct rev_info *revs);
-int reuse_partial_packfile_from_bitmap(struct packed_git **packfile, uint32_t *entries, off_t *up_to);
-int rebuild_existing_bitmaps(struct packing_data *mapping, khash_sha1 *reused_bitmaps, int show_progress);
+struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs);
+int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
+				       struct packed_git **packfile,
+				       uint32_t *entries, off_t *up_to);
+int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
+			     khash_sha1 *reused_bitmaps, int show_progress);
 
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);
-- 
2.17.0.768.g1526ddbba1.dirty

