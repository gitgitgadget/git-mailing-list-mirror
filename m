Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127AB1F3B8A
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991665; cv=none; b=ZwR5G8AlrHC3FHzZXMnLAtnP7nsFaGnq78e7I5ss7/XCLPC+DH+/gDDRZTLKBzVhSNUm0ziyb1nlJL0haoS22pQqbHosQFVjZEb0NIjjBYVZ1n8XCVh20ddvLreF4Jj/tS5RGXUZfwivV+zhb9o+xa1kR16Z646+7V5z1/Ivqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991665; c=relaxed/simple;
	bh=Aftyxwl0sLh/5lmSPpFyZKFt0Nsz9mQeGc1950t1T5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uAFptoaA6iBk8USe+bxI8zN4cReREHj8y8a8CGg5SmI2B4LRslNjKLEsH8d8IUseKuQxltcWa03cwf+j7doAiN0xswSgkR6gu3a7zr8hfnD23CGYNpexM0ghNGA56YeJM9KCFuDkzDXK8bYmni0T75mTxsbjnbLNTGbywUMJYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AXdLAGF1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nWUEeq+Z; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AXdLAGF1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nWUEeq+Z"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0500725401AC
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 03:47:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Mon, 03 Mar 2025 03:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740991661;
	 x=1741078061; bh=phDgkQtqst5AhocWnaAYUxiYwpWdEQtfAUw3pZcJLKs=; b=
	AXdLAGF1DVVDqeC/ZkeYFpjy2uF6YvElBjVCAzfHMrmffhXNogTHa8rpnpKXwDe9
	wczwxjbpSaxB8gFCf6BE3AHwypMImrnJcQrHeXN5/Uld6WZ0SSDkW2N/iXacd0OX
	GUZCvMQuezNyvxfUsN74o+Y7Bwjfu+KCi9yYwOit4gqWnPnSwEwMgMpE14Uxr0tC
	Zcq+6UElYsTHsYLDE0bNepWzZoJJxfOnKaEh63p0NQsYoaz20z/t8vHuAVth8E8D
	yRMZ8ScRRBWZudNh4tlJ9k5Vq9kzNO36jUob9XMkZDLREFR0fe24Rtu/yNLJk0mx
	S5eo8BDcTH4Tw5Cd2d5Gvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740991661; x=
	1741078061; bh=phDgkQtqst5AhocWnaAYUxiYwpWdEQtfAUw3pZcJLKs=; b=n
	WUEeq+ZyYJa+HTn1iAa4iVEW/dZF9d1havff/mPYHcD1SkMyracq5L9AzY/7ffsT
	hFHNi4mnbu2PLrJKhq2k9sGFOqRnjN4HYBklga3g7zX7DyFNmTNhQVZImVoWDuXE
	eJARZDsrexExsk9Sfol/oa7XostNx6LQ/nHDHIXniiTf2YDXGAwCP9BSzw/8ceuX
	IZNcYRZ04KYzK7CZdseFmI2ZZkIIAMgL+gbUIy/PpJGvCgIyHfXFyiOqIu2jjZT3
	ebqUJH17ecMc9ninUNtJzvqiBp7VQa19Mn2jTPngZotRYofAXRJ1TWRrlO5gJ4S+
	acdCh8U2nocPBA9lBB2sQ==
X-ME-Sender: <xms:rWzFZ2mAxn5HgG0VJNgOYghqF2QWYAb16vQ3epiOx0na-sA7Fu2yBA>
    <xme:rWzFZ90epQh92r_KwVyvjhmkzP3srapP2eP_ytC0EsBe6bNgmwqJGSPgkoecOMWmU
    zAbtXqvId4WP9HbIA>
X-ME-Received: <xmr:rWzFZ0oKJRmuHi8q0_em71rQDw-QEiC-Z85RXbt8W59uJUCyHfOgq_p4GvngIDAT6HnBEexG9TucRN-gyaHnXZ1bLL6wLrl1yBsrjeB6_u0zka8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rWzFZ6lJH-lQGh8PLAtcS6K3g-sa6TK3viJPY25b-wsIzjWIF7u3EA>
    <xmx:rWzFZ033jxAc-GbK9x1B4B5eD7fOc8b9PzGdjxuI8EMc2ID_rn81Nw>
    <xmx:rWzFZxsWXqcBUbt-qtX-jPKM2LsZOjlGECoY2b3vKWYQO_HBIvWRuw>
    <xmx:rWzFZwU9bQgMkAVUAMUuMuevG5LtVLilr50Wfm9WOO18p0bJlyaa6Q>
    <xmx:rWzFZx-BjDOgl_zxo1pp34eP-3rucGN-QBJAZuZ7D8Tm9K__FBncta_y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Mar 2025 03:47:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f611e482 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Mar 2025 08:47:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Mar 2025 09:47:36 +0100
Subject: [PATCH 07/12] pack-bitmap-write: stop depending on
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-pks-objects-without-the-repository-v1-7-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

There are multiple sites in "pack-bitmap-write.c" where we use the
global `the_repository` variable, either explicitly or implicitly by
using `the_hash_algo`.

Refactor the code so that the `struct bitmap_writer` stores the
repository it is getting initialized with. Like this, we can adapt
callsites that use `the_repository` to instead use the repository
provided by the writer.

Remove the `USE_THE_REPOSITORY_VARIABLE` define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap-write.c | 36 ++++++++++++++++++------------------
 pack-bitmap.h       |  1 +
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 50e5c491ccb..6a97b52b36d 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -48,6 +47,7 @@ void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r,
 	memset(writer, 0, sizeof(struct bitmap_writer));
 	if (writer->bitmaps)
 		BUG("bitmap writer already initialized");
+	writer->repo = r;
 	writer->bitmaps = kh_init_oid_map();
 	writer->pseudo_merge_commits = kh_init_oid_map();
 	writer->to_pack = pdata;
@@ -415,9 +415,9 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 		bb->commits[bb->commits_nr++] = r->item;
 	}
 
-	trace2_data_intmax("pack-bitmap-write", the_repository,
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
 			   "num_selected_commits", writer->selected_nr);
-	trace2_data_intmax("pack-bitmap-write", the_repository,
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
 			   "num_maximal_commits", num_maximal);
 
 	release_revisions(&revs);
@@ -460,7 +460,7 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
 			if (fill_bitmap_tree(writer, bitmap,
-					     lookup_tree(the_repository, &entry.oid)) < 0)
+					     lookup_tree(writer->repo, &entry.oid)) < 0)
 				return -1;
 			break;
 		case OBJ_BLOB:
@@ -536,7 +536,7 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 				return -1;
 			bitmap_set(ent->bitmap, pos);
 			prio_queue_put(tree_queue,
-				       repo_get_commit_tree(the_repository, c));
+				       repo_get_commit_tree(writer->repo, c));
 		}
 
 		for (p = c->parents; p; p = p->next) {
@@ -590,11 +590,11 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 	int closed = 1; /* until proven otherwise */
 
 	if (writer->show_progress)
-		writer->progress = start_progress(the_repository,
+		writer->progress = start_progress(writer->repo,
 						  "Building bitmaps",
 						  writer->selected_nr);
 	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
-			    the_repository);
+			    writer->repo);
 
 	old_bitmap = prepare_bitmap_git(writer->to_pack->repo);
 	if (old_bitmap)
@@ -645,10 +645,10 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 	free(mapping);
 
 	trace2_region_leave("pack-bitmap-write", "building_bitmaps_total",
-			    the_repository);
-	trace2_data_intmax("pack-bitmap-write", the_repository,
+			    writer->repo);
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
 			   "building_bitmaps_reused", reused_bitmaps_nr);
-	trace2_data_intmax("pack-bitmap-write", the_repository,
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
 			   "building_bitmaps_pseudo_merge_reused",
 			   reused_pseudo_merge_bitmaps_nr);
 
@@ -711,7 +711,7 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
 	}
 
 	if (writer->show_progress)
-		writer->progress = start_progress(the_repository,
+		writer->progress = start_progress(writer->repo,
 						  "Selecting bitmap commits", 0);
 
 	for (;;) {
@@ -960,7 +960,7 @@ static void write_lookup_table(struct bitmap_writer *writer, struct hashfile *f,
 	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++)
 		table_inv[table[i]] = i;
 
-	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
+	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", writer->repo);
 	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++) {
 		struct bitmapped_commit *selected = &writer->selected[table[i]];
 		uint32_t xor_offset = selected->xor_offset;
@@ -987,7 +987,7 @@ static void write_lookup_table(struct bitmap_writer *writer, struct hashfile *f,
 		hashwrite_be64(f, (uint64_t)offsets[table[i]]);
 		hashwrite_be32(f, xor_row);
 	}
-	trace2_region_leave("pack-bitmap-write", "writing_lookup_table", the_repository);
+	trace2_region_leave("pack-bitmap-write", "writing_lookup_table", writer->repo);
 
 	free(table);
 	free(table_inv);
@@ -1008,7 +1008,7 @@ static void write_hash_cache(struct hashfile *f,
 void bitmap_writer_set_checksum(struct bitmap_writer *writer,
 				const unsigned char *sha1)
 {
-	hashcpy(writer->pack_checksum, sha1, the_repository->hash_algo);
+	hashcpy(writer->pack_checksum, sha1, writer->repo->hash_algo);
 }
 
 void bitmap_writer_finish(struct bitmap_writer *writer,
@@ -1030,15 +1030,15 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	if (writer->pseudo_merges_nr)
 		options |= BITMAP_OPT_PSEUDO_MERGES;
 
-	f = hashfd(the_repository->hash_algo, fd, tmp_file.buf);
+	f = hashfd(writer->repo->hash_algo, fd, tmp_file.buf);
 
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
 	header.version = htons(default_version);
 	header.options = htons(flags | options);
 	header.entry_count = htonl(bitmap_writer_nr_selected_commits(writer));
-	hashcpy(header.checksum, writer->pack_checksum, the_repository->hash_algo);
+	hashcpy(header.checksum, writer->pack_checksum, writer->repo->hash_algo);
 
-	hashwrite(f, &header, sizeof(header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz);
+	hashwrite(f, &header, sizeof(header) - GIT_MAX_RAWSZ + writer->repo->hash_algo->rawsz);
 	dump_bitmap(f, writer->commits);
 	dump_bitmap(f, writer->trees);
 	dump_bitmap(f, writer->blobs);
@@ -1072,7 +1072,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 
-	if (adjust_shared_perm(the_repository, tmp_file.buf))
+	if (adjust_shared_perm(writer->repo, tmp_file.buf))
 		die_errno("unable to make temporary bitmap file readable");
 
 	if (rename(tmp_file.buf, filename))
diff --git a/pack-bitmap.h b/pack-bitmap.h
index d7f4b8b8e95..53cd42772f3 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -104,6 +104,7 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_i
 off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
 
 struct bitmap_writer {
+	struct repository *repo;
 	struct ewah_bitmap *commits;
 	struct ewah_bitmap *trees;
 	struct ewah_bitmap *blobs;

-- 
2.49.0.rc0.375.gae4b89d849.dirty

