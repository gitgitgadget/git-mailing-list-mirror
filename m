Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672121B9F6
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357148; cv=none; b=JRUFaVALOQ4fZ9ac0By9dL2ESnnpdMcY1FDB3k9z18Egzvm3F4djrzKRzN48YMvtCP0BCX9PS2V2Ln/J/L/mpLfiMiK3+HP/jUa2NckGYmT7/PhDWQ2qKtegsa1OfDfmmPGniMjRb0hKNGd46oC3yRop7LLwIViDR67CUogukZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357148; c=relaxed/simple;
	bh=ucpN61xgCl8qx7reUMM3zdV+HuUWvFtycjkS8TGwtMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lNyfF2jybK3egEwRBbanfe/7XpRpisQkyJSWxs8ptaAVQjM50BkE2L7aN2EtaezwA6oLLY4TxSdMFd+Jp2ZDfouUJTY6Q4uTlRywuQ+qn1bQ2F+2RNnGFckXOr9In2zlkC/IaflfvT0xV1cDrr/Z+TuUp52FdysBgwKp+HwwykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=klyGFXMx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mEkO3omz; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="klyGFXMx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mEkO3omz"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D9A0A114018E;
	Fri,  7 Mar 2025 09:19:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 07 Mar 2025 09:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741357145;
	 x=1741443545; bh=PGOtoRfukW7dv+Yz20doSCZJWwibZZrpXd5eDRBV0WA=; b=
	klyGFXMxXaRhN2f4uL3SJdwxja8J5atZqOprCnepYiGXIism6+FBEepCZQ+jHGzZ
	tX8an/8ur+HIYw2rkIIbbdty5+gpaFDe33yedKXbSfgLSkkQmwTLql7StNWhU3L1
	QXpqq3PxE2Ken1D8w1xxIuALQm/OXtzji0yK0Bn8w0ZxJnoj5IH4hlzFvbkb6tMs
	GCeXgD5Iql83MxlFULBnPiwyWkMwaNoJwWPhIUX2HAcypXG5Q/E1AP/EFTRxatDp
	9pmrMObf0xhvKfTP6sIlhYq9q5a3C6/LPDn4Z0uQMb3Hi1d29H+FCB0muBjp74jX
	wMfavROq2gSXiYp0Z0ZQeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741357145; x=
	1741443545; bh=PGOtoRfukW7dv+Yz20doSCZJWwibZZrpXd5eDRBV0WA=; b=m
	EkO3omza9VEqm28xVprrJVHZz+UNCs1PNQDjM0fnKll+pYuAWzuwCr4c9kYeaquY
	tO+UdxzFgC+EBIBbw9DsOlD+UGEOMvng9ytREF7Ed2q5KXJ16ePXfnAp40FXwHXb
	na8DdXZpiq4jI/AqJiEKVeLwja5Pluj5ZO+Zz4+Y48kxPM3A8V/utgFbWJe/svtP
	8Ha3MbwtaIJxzci/wFwss1viwpQQ3Z7sHI8RP9iJebt4i6HlOO/ba8bPny3Wx/ms
	X1m6UQWJlAY5dQUS23qjbiFV05oAR8zd/lghKux7d12ISq9ngekYO4Zn81IUqNNl
	hrzeGp/O2TaPJwTldjdKw==
X-ME-Sender: <xms:WQDLZ-lHz9Zf9NDDOuyqGENr51IBkeg5T6nbF6W45Ja0uLDQglHWBA>
    <xme:WQDLZ10Qn1H5qrhafPgpwWvHSvidnhVBZBepp3HEdXtkIZumH4v0nWmgjgMiYEVA5
    7rCSCMsAKBbdjAHpQ>
X-ME-Received: <xmr:WQDLZ8rdiVyLfU1GLdoCtQMteChzHO6XvqXqjAxZFTvUuDV977MnTGnWOZzrW_7D4DRCwK-mAc_Us_RpqXZ7VEb6xEKSt6M_s4Dmu_bPxpMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WQDLZylXEisKnLLsD0k1--DIGgGk1uuiPNB6TZacEq7KRpD8SkqQTw>
    <xmx:WQDLZ822LfXRTFrmqxnDLri6bM9430CLBd5TaWdrNdz8BVjT5ECR6g>
    <xmx:WQDLZ5uflUK5kL8Igo8xLGQvCe9qUFtmB8BTRT149Z37mlw_VmysXg>
    <xmx:WQDLZ4XIm8ZUDk7H3fAGtvyU_x5Gk92Dmm8R1KEGxPbm2upPvhjZoQ>
    <xmx:WQDLZ5w9er9OUbr4zBEX2KBAHtrQ4KLKt1oUeTj4sgfH7KsB4kmidA27>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 09:19:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 343feabf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 14:19:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Mar 2025 15:19:00 +0100
Subject: [PATCH v3 07/12] pack-bitmap-write: stop depending on
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-b4-pks-objects-without-the-repository-v3-7-7bccf408731e@pks.im>
References: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
In-Reply-To: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
2.49.0.rc1.455.g4cd33545ba.dirty

