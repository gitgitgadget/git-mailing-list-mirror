Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBAD1D90B3
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590819; cv=none; b=EiNZXuK04YyLWl1p3LTWdQxNvp83n8eO01uBYSAVxi8DFtrEfNNV21ZdXNp1FwALie/38ZiZWdgwEcWdmA4XHooUfyssjOkFitciuR+td210/j6QrThqe0y2AoDGhHqw9uA/wTkevrfuKemQxncMj8fEgbq/u14/MI65Qxn5oeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590819; c=relaxed/simple;
	bh=ucpN61xgCl8qx7reUMM3zdV+HuUWvFtycjkS8TGwtMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qAXRhCUzOycaAbPMXPg7hWLsqt2kw7IDaB1nhny0JkgmhLkNkJchWTMK7H1UuxWCWod8Uun87HslT5ptgx7GcZv5+Qq9r4+3GZuQQP4osNKPEOGoo/zDSVl8wwIvU3KKTpwHA32SXpdHf2kD2iRZzEY8gceAWjvPLLwuVVKTdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E3k0KFgp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e160TtVX; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E3k0KFgp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e160TtVX"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2DCFE2540130;
	Mon, 10 Mar 2025 03:13:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 10 Mar 2025 03:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741590817;
	 x=1741677217; bh=PGOtoRfukW7dv+Yz20doSCZJWwibZZrpXd5eDRBV0WA=; b=
	E3k0KFgpk8ikw8xCK3lvodnlZj3FSZsHHWw5T5w5FFzop1nSzFArL+Ustk0s5EGi
	7+zGzmbIceSlq8/6fYgDPDh0FA7RNUztDwkMrwZacAayaMiBH6GFNUEAQi6SpUCv
	t+qaBugC184/ArNRJJSZ4o4hIPrVu01nptwxeCwrQbJFGLyDH2flJI6iv8f0VFhz
	9MSl1hUw81n2Z4lj0YJPM23yODGGdZ534ieGdlTUJL9dIPSxMOSCyRr/eOMTSh44
	G26bAtCswKA9QpRKMeG+qnzKFenBqKmNCAkCPOHKI0p1/mxTxYxOYqb83eZGN85c
	3oT5wuNINYF90PoPfsvccw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741590817; x=
	1741677217; bh=PGOtoRfukW7dv+Yz20doSCZJWwibZZrpXd5eDRBV0WA=; b=e
	160TtVXPEwHqTx3df/F20RxvWksR4VO+CVjMgPAP1yT4zCaamh7BXWlkXtUl5Xxz
	uAEX5TXim0gVW8319iaTKpLTiBVUGQX0rszv1OjWi5gsXx561oV1g2JAgJ8al4Rk
	tI50GiaSuugiR1BpgXqB4OjuJY0Oq3PwNQvBNuJ98mnxbkYNYGTyBygMf5ZXS8ue
	gaF0xpeYMiSWGOC60Sy1Mem5a5Wkv5tyY8Zyq/WzcSZjlydps9kySlGnIOPctfDN
	XayAWCFVOjEsEIlVTrZ1zZVBvSjUQJLKT19P+J0HIZ7axT+wMBHkBElEtTNSeQVT
	EVvp3iSWOT+MeOQK64Uhw==
X-ME-Sender: <xms:IJHOZyRaos6v67QZCd8osZKWS2iX-jKm15PywhVbXjAwhRVHFYtXLg>
    <xme:IJHOZ3zVQnEJv7w_NDbnXYch9O4JDk1mdBK3FzNW9Lb1qMaC8ynjBVYSp1URcR2L0
    SlWFfTHNfE4ibhOhQ>
X-ME-Received: <xmr:IJHOZ_2l8pI_kNdUxgY5cShjU0qJUI-1aDnG5BVbhWnnt2L98CPsf6A_HltFcO5WjJz9nURuVflmUzH1AOuP2rsWabkPhdkaS_9irr63_ke5ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:IJHOZ-BmkUIrbr-Lu6BbzAscjvZQY-VH5FvS4XChh6aSKEZxgFol-Q>
    <xmx:IJHOZ7jRGU1zdbwqWUSdiRFlN84uYhm4Aa4Ug3B4DKUKSMyCOAUkig>
    <xmx:IJHOZ6o38GweresvczKssgKauIr8PX85FH09EsG0SB_HKuznmXDVqw>
    <xmx:IJHOZ-gAoGN59CMJGqqwXMjeRIU6ideMdriTXM4ICgMjSvMT6hSuGQ>
    <xmx:IZHOZ7fEqcYJHpmQHnatl0M2zKO0Y1nwyGHzQP9aG7k-FGQonymzHzEr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:13:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b5082241 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:13:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 10 Mar 2025 08:13:26 +0100
Subject: [PATCH v4 07/12] pack-bitmap-write: stop depending on
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-b4-pks-objects-without-the-repository-v4-7-f201b8ec57ba@pks.im>
References: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
In-Reply-To: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Elijah Newren <newren@gmail.com>
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

