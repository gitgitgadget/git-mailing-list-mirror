Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FC5C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83C16124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhFUW1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhFUW1T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:19 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DD3C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:03 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id o5so15881901iob.4
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hjqOo5CugurnPssJWxo0/V9fUpxV95Iays7iB0BsfD8=;
        b=FfemrMkohGcYAL1hDqC6bptlECdTPvXBx0Jv9uMdi4Dc/UI5xHrWYA+wGkCUpLCZ63
         4Igy/l8TRDnOEiIOM3I8O+0ZECFDzNajd0ZvrTzDZgD3IGmkfCxfQYhQhaOzPBE6gR90
         ppBIJUHE/8NCZOBxOnhlMMd+1Y/78vtN808ukXHJGLAUL7j4i8p1ONNJMup2Q/LTZf3j
         C45BZMIrlieMPe1ypRNYR6t9/azlqmrgSfcEtPyOijNlSIcfsz8y4vZzeqhHFaa3Q23E
         PLDg2iIc/THqosq6+RURLs82r5qJ37orMKQYUtNFY8KTszFxF++F21Dj3eb6Ki1YtIkp
         aatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hjqOo5CugurnPssJWxo0/V9fUpxV95Iays7iB0BsfD8=;
        b=pNZ+TSYonnS0k5uDrzRCIDBOvxZ/KwKTcK5Ozn5Taf9UOYJh15ZHuTDnE+PfStefsa
         I4+damijjcvBLbsal1NfABGesTlmBS/EcaIaplcDlYqNpZqKxQlCAgGeM05Gfy/6rpc7
         ar8rKrW9IcHpCM7NPfnPQerVh/pFnV3d9UNF849809FsApuIXu52lwwFuuCxWTDVBv5g
         c+TVK9MD0x/ORNqfEPCpXgv19ONlr97ewxZWQGRZLkgTXlSvFN2wnyWjb9Q2e8fM4M3y
         6Qpvntxb/AWbOdm26UzOE2iq5T1Eoba5ALArLQwvxXLAx3gpSIyJ/dR1Ix2ZEIp3u2Zx
         ZAnA==
X-Gm-Message-State: AOAM533RDGNHKfus1Z84gabHBX2Kr93CwZEAQ+vbshuPY+Z+4uzoY8eP
        KemNdnajfTZH8QGbMRxLD6gaLmGUokNfjGla
X-Google-Smtp-Source: ABdhPJwwEuNT78iTk8PsyfuqreVi9hqhgw+77uPwtPT6DtN7cx7+7QZZoTacQo6btbwA+7BBiDMfNQ==
X-Received: by 2002:a02:ccf2:: with SMTP id l18mr650706jaq.128.1624314302946;
        Mon, 21 Jun 2021 15:25:02 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id r4sm1057463ilq.27.2021.06.21.15.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:02 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 02/24] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
Message-ID: <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The set of objects covered by a bitmap must be closed under
reachability, since it must be the case that there is a valid bit
position assigned for every possible reachable object (otherwise the
bitmaps would be incomplete).

Pack bitmaps are never written from 'git repack' unless repacking
all-into-one, and so we never write non-closed bitmaps (except in the
case of partial clones where we aren't guaranteed to have all objects).

But multi-pack bitmaps change this, since it isn't known whether the
set of objects in the MIDX is closed under reachability until walking
them. Plumb through a bit that is set when a reachable object isn't
found.

As soon as a reachable object isn't found in the set of objects to
include in the bitmap, bitmap_writer_build() knows that the set is not
closed, and so it now fails gracefully.

A test is added in t0410 to trigger a bitmap write without full
reachability closure by removing local copies of some reachable objects
from a promisor remote.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c   |  3 +-
 pack-bitmap-write.c      | 76 ++++++++++++++++++++++++++++------------
 pack-bitmap.h            |  2 +-
 t/t0410-partial-clone.sh |  9 ++++-
 4 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index de00adbb9e..8a523624a1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1256,7 +1256,8 @@ static void write_pack_file(void)
 
 				bitmap_writer_show_progress(progress);
 				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
-				bitmap_writer_build(&to_pack);
+				if (bitmap_writer_build(&to_pack) < 0)
+					die(_("failed to write bitmap index"));
 				bitmap_writer_finish(written_list, nr_written,
 						     tmpname.buf, write_bitmap_options);
 				write_bitmap_index = 0;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 88d9e696a5..d374f7884b 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -125,15 +125,20 @@ static inline void push_bitmapped_commit(struct commit *commit)
 	writer.selected_nr++;
 }
 
-static uint32_t find_object_pos(const struct object_id *oid)
+static uint32_t find_object_pos(const struct object_id *oid, int *found)
 {
 	struct object_entry *entry = packlist_find(writer.to_pack, oid);
 
 	if (!entry) {
-		die("Failed to write bitmap index. Packfile doesn't have full closure "
+		if (found)
+			*found = 0;
+		warning("Failed to write bitmap index. Packfile doesn't have full closure "
 			"(object %s is missing)", oid_to_hex(oid));
+		return 0;
 	}
 
+	if (found)
+		*found = 1;
 	return oe_in_pack_pos(writer.to_pack, entry);
 }
 
@@ -331,9 +336,10 @@ static void bitmap_builder_clear(struct bitmap_builder *bb)
 	bb->commits_nr = bb->commits_alloc = 0;
 }
 
-static void fill_bitmap_tree(struct bitmap *bitmap,
-			     struct tree *tree)
+static int fill_bitmap_tree(struct bitmap *bitmap,
+			    struct tree *tree)
 {
+	int found;
 	uint32_t pos;
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -342,9 +348,11 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 	 * If our bit is already set, then there is nothing to do. Both this
 	 * tree and all of its children will be set.
 	 */
-	pos = find_object_pos(&tree->object.oid);
+	pos = find_object_pos(&tree->object.oid, &found);
+	if (!found)
+		return -1;
 	if (bitmap_get(bitmap, pos))
-		return;
+		return 0;
 	bitmap_set(bitmap, pos);
 
 	if (parse_tree(tree) < 0)
@@ -355,11 +363,15 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			fill_bitmap_tree(bitmap,
-					 lookup_tree(the_repository, &entry.oid));
+			if (fill_bitmap_tree(bitmap,
+					     lookup_tree(the_repository, &entry.oid)) < 0)
+				return -1;
 			break;
 		case OBJ_BLOB:
-			bitmap_set(bitmap, find_object_pos(&entry.oid));
+			pos = find_object_pos(&entry.oid, &found);
+			if (!found)
+				return -1;
+			bitmap_set(bitmap, pos);
 			break;
 		default:
 			/* Gitlink, etc; not reachable */
@@ -368,15 +380,18 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 	}
 
 	free_tree_buffer(tree);
+	return 0;
 }
 
-static void fill_bitmap_commit(struct bb_commit *ent,
-			       struct commit *commit,
-			       struct prio_queue *queue,
-			       struct prio_queue *tree_queue,
-			       struct bitmap_index *old_bitmap,
-			       const uint32_t *mapping)
+static int fill_bitmap_commit(struct bb_commit *ent,
+			      struct commit *commit,
+			      struct prio_queue *queue,
+			      struct prio_queue *tree_queue,
+			      struct bitmap_index *old_bitmap,
+			      const uint32_t *mapping)
 {
+	int found;
+	uint32_t pos;
 	if (!ent->bitmap)
 		ent->bitmap = bitmap_new();
 
@@ -401,11 +416,16 @@ static void fill_bitmap_commit(struct bb_commit *ent,
 		 * Mark ourselves and queue our tree. The commit
 		 * walk ensures we cover all parents.
 		 */
-		bitmap_set(ent->bitmap, find_object_pos(&c->object.oid));
+		pos = find_object_pos(&c->object.oid, &found);
+		if (!found)
+			return -1;
+		bitmap_set(ent->bitmap, pos);
 		prio_queue_put(tree_queue, get_commit_tree(c));
 
 		for (p = c->parents; p; p = p->next) {
-			int pos = find_object_pos(&p->item->object.oid);
+			pos = find_object_pos(&p->item->object.oid, &found);
+			if (!found)
+				return -1;
 			if (!bitmap_get(ent->bitmap, pos)) {
 				bitmap_set(ent->bitmap, pos);
 				prio_queue_put(queue, p->item);
@@ -413,8 +433,12 @@ static void fill_bitmap_commit(struct bb_commit *ent,
 		}
 	}
 
-	while (tree_queue->nr)
-		fill_bitmap_tree(ent->bitmap, prio_queue_get(tree_queue));
+	while (tree_queue->nr) {
+		if (fill_bitmap_tree(ent->bitmap,
+				     prio_queue_get(tree_queue)) < 0)
+			return -1;
+	}
+	return 0;
 }
 
 static void store_selected(struct bb_commit *ent, struct commit *commit)
@@ -432,7 +456,7 @@ static void store_selected(struct bb_commit *ent, struct commit *commit)
 	kh_value(writer.bitmaps, hash_pos) = stored;
 }
 
-void bitmap_writer_build(struct packing_data *to_pack)
+int bitmap_writer_build(struct packing_data *to_pack)
 {
 	struct bitmap_builder bb;
 	size_t i;
@@ -441,6 +465,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	struct prio_queue tree_queue = { NULL };
 	struct bitmap_index *old_bitmap;
 	uint32_t *mapping;
+	int closed = 1; /* until proven otherwise */
 
 	writer.bitmaps = kh_init_oid_map();
 	writer.to_pack = to_pack;
@@ -463,8 +488,11 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		struct commit *child;
 		int reused = 0;
 
-		fill_bitmap_commit(ent, commit, &queue, &tree_queue,
-				   old_bitmap, mapping);
+		if (fill_bitmap_commit(ent, commit, &queue, &tree_queue,
+				       old_bitmap, mapping) < 0) {
+			closed = 0;
+			break;
+		}
 
 		if (ent->selected) {
 			store_selected(ent, commit);
@@ -499,7 +527,9 @@ void bitmap_writer_build(struct packing_data *to_pack)
 
 	stop_progress(&writer.progress);
 
-	compute_xor_offsets();
+	if (closed)
+		compute_xor_offsets();
+	return closed ? 0 : -1;
 }
 
 /**
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 99d733eb26..020cd8d868 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -87,7 +87,7 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 		unsigned int indexed_commits_nr, int max_bitmaps);
-void bitmap_writer_build(struct packing_data *to_pack);
+int bitmap_writer_build(struct packing_data *to_pack);
 void bitmap_writer_finish(struct pack_idx_entry **index,
 			  uint32_t index_nr,
 			  const char *filename,
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 584a039b85..1667450917 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -536,7 +536,13 @@ test_expect_success 'gc does not repack promisor objects if there are none' '
 repack_and_check () {
 	rm -rf repo2 &&
 	cp -r repo repo2 &&
-	git -C repo2 repack $1 -d &&
+	if test x"$1" = "x--must-fail"
+	then
+		shift
+		test_must_fail git -C repo2 repack $1 -d
+	else
+		git -C repo2 repack $1 -d
+	fi &&
 	git -C repo2 fsck &&
 
 	git -C repo2 cat-file -e $2 &&
@@ -561,6 +567,7 @@ test_expect_success 'repack -d does not irreversibly delete promisor objects' '
 	printf "$THREE\n" | pack_as_from_promisor &&
 	delete_object repo "$ONE" &&
 
+	repack_and_check --must-fail -ab "$TWO" "$THREE" &&
 	repack_and_check -a "$TWO" "$THREE" &&
 	repack_and_check -A "$TWO" "$THREE" &&
 	repack_and_check -l "$TWO" "$THREE"
-- 
2.31.1.163.ga65ce7f831

