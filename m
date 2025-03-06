Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FC20F08C
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273844; cv=none; b=YklcVQFribPF1PgxnsPxoaMX9jg024Rb/cgfdKlk59SS8v68BHe8LYD73UxB0h6tkoz9jx7X0RizFHq8rPXdkn435F0PoCE/54bAHO4ZuEcL1BgRt9ps4mEKkzNzFzUK3yvEssQLUUEt8wZgovy4RNTvfH6f2hAsFQY9RZnQYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273844; c=relaxed/simple;
	bh=PYH17YmmGS8rkq9pBJP0cuCouDbxqgVN1pXKQgI2HVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqYtp2BTATHXCNBitVzU0Dap/CBa9XEh3OATBVhdtMjqM4fSgBoLgpJL40r2l67a9HVlwyONiaYXf2rtYRz1SrTfbvYInf0r8Hc0mt49TeEZqMMY7onQJ3kY4ao7OrFxWyhRNi22TS6vCcyBdweCW2eZWroIUQUNxD6JtEy8m8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TqV58D8T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7LO+aKoN; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TqV58D8T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7LO+aKoN"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F2F825401EF;
	Thu,  6 Mar 2025 10:10:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Thu, 06 Mar 2025 10:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273841;
	 x=1741360241; bh=267en0M0CY+zTi11jNulvpcE8p75bbzY4a4VDDHMg3k=; b=
	TqV58D8TEjf6VccXDHAT5eWcvG8Wm3KahFdk1zSKjpCsq1o0J26scPpkmttq+yUd
	oIQZpFKr8wF4Tc7FSu9GQM5b2/j+2bOKvkXNm5pZAe3Hchj7SRvMrudR0b+FkZyW
	lnwOwWRoAI8KMt4mJ5F7K8596ZVMF4LXk+bw518Pc1bfmgtgShccVcxg38KQbUxa
	MnQNHL1AToBQpdLd3QOn2jd1HFJ1YpYwMSa9QOVWekhH3XCrgRSD9/RzrV9uP5rX
	5eYg4WTOz0S/P2Yv7Kt/GkvTKOeBN6I8pxl403mmUF+/if2vmWE2FLozuTbEIIpu
	wjCTVcA5mNCO6BMmOHL4bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273841; x=
	1741360241; bh=267en0M0CY+zTi11jNulvpcE8p75bbzY4a4VDDHMg3k=; b=7
	LO+aKoNfg0GwkwXH+pDazHh57jqCSQUbDfUXbSKo0tBCSh21r9aateN+k3YKPr/i
	BaT8Lzv+yWnG0UnPHiq0C89UqJuZQYWmZ+fo7IOPXdCYhdlL+3iJ4SApWuKVpni4
	XxutfwV9UK92vdg7l6c8CMzhQnCXkG8BWaorOnY7ZdZujCcc97uohqoAUetgkNH5
	O2lNUVv7DR29FlWPetbYmlypjfTjbrpbXjwLswXPCr3fXrCoeB+KDT5YmbFrrc0h
	zp64vW0JkSdV0EJH0e6xZetL1RcCMvUK8NbRaQb4CTmZEgQUP4ZflzlhuGoPbPpz
	M0kKl7OPMS8HEjmteoTYQ==
X-ME-Sender: <xms:8brJZw4TliWU0oADGGOXPc08_k1A0qkTQLbwPIe4wbt77Ml3W2aBTg>
    <xme:8brJZx7N4tKpzZMo1hBmUK1kdKbKa_GQ0LnA7sAXgGMK--pgx5ZjKVyHKohP8nIcB
    hOvgX5sdkbgOmXySA>
X-ME-Received: <xmr:8brJZ_eh4qE0_YH9SAOjbxY58g6sjDQWNajSgqzoOKsIXHv2HRSXQxP4NkwleeeMaCJm_1p5o0GdXIvEbRK1bsWhJ3eYZxOIjp989dsAbbkxpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8brJZ1JMmlHfwommZB63qlhTMnwavZcDnRhfl2Kq0Abanj2SHdYAGA>
    <xmx:8brJZ0LvHxNWmzq4bynoXlteEY6UAflbDVSlI3PyrH4ogIPUl-kkFg>
    <xmx:8brJZ2zHTCNB75RNQ-h6cvbJorahEuhl39XdNa6ddJ7PwU4nqjSuqA>
    <xmx:8brJZ4KCCfVAYTuWpa_QnMhVqHJhGykgjPlqg8T48lO3InjNZWUISQ>
    <xmx:8brJZ40uBgm_K9EFmyFwcRHFZ1LXRW284UAdLxbDsi3FE6hixr2XsTKJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:10:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c07fe951 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:10:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:10:31 +0100
Subject: [PATCH v2 07/12] pack-bitmap-write: stop depending on
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-b4-pks-objects-without-the-repository-v2-7-f3465327be69@pks.im>
References: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
In-Reply-To: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
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
2.49.0.rc0.416.g627208d89d.dirty

