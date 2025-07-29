Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1CC1E521F
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798388; cv=none; b=qo5dpNTtatNWhQDFme9UHIbC3p4/oJ6X+ysoxerjcqWRY4v40QJilB/+jRhlwRmGhHP6xikKtIwRTqva6MevopC1uaJRWIldrhiagTlbaQC484+WFDLXB0PbAU2zp5edZJ+7Hm+kwoMbn0JrwJpi4ZFVHK4th9HNKZ49TkyaPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798388; c=relaxed/simple;
	bh=+E2klzp/9RaGnVJL9U6sqIwyeaAiW2cjwLHCBZPfLDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sR1FtX0+gARMSNh/S/n5hm5iLX4TG0igMwXCcDKJa3QQ32yjf82hG6KhnKT1hP8hJ7p8QvOqejXhLjjesOogJ9SJhgaTuoG3YxacLFoEMVO9F05HuxU065cdocwScgkrBuQwrApFtpUQtQNu4GtCV5u/W2Sgoxqx4IQTX5fFw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J8+12FkN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGG58EU7; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J8+12FkN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bGG58EU7"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id F04AB1D007E0;
	Tue, 29 Jul 2025 10:13:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 29 Jul 2025 10:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753798385;
	 x=1753884785; bh=gp3KR5VDUkoiceLWH0dnn5u9tsOYQt5ynDefocTfed8=; b=
	J8+12FkN7QW607aqcTEiSSiTBnBKvBWP2L9artawOq4gsuQHSLfGgokcVb3lAVUW
	frmbI5O8jiefk7qlT/b5llPzfIk9jvFJWCqzy3hbrS8csJ5P9C9f5JpbnJ8/h6X0
	spkVbQ8+trot4Cpkw/imTrMP5t7G7pNtnoGFff12SxUDPKLs9iE+Jm7F7Xq+oWzm
	Yxw0gf6wDN2IXCoE586fzKbhsg5LvrnqvMuyVw3XxX6N+fbmfDsxQUsR0VkTS8Xs
	xfNMZKSQKW56xSHLOWCQxoWawB27SiMevYBwerQeGll5ap8R+/gUxhR2FaToF60v
	BUI0gRp7WfwPkKJV+N2z4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753798385; x=
	1753884785; bh=gp3KR5VDUkoiceLWH0dnn5u9tsOYQt5ynDefocTfed8=; b=b
	GG58EU76CxYPr4qK9I/AK6PwMGqUhVLS1c2veATHL/0IK9WQCq1ahHU99eAajkYL
	LHTO4qUGduN34H6Rg8gcOesKcjcFMau2c2FgsU2ijVj28aaKw2CnbKD8BwXeiFf4
	fO7ytBhKFdh3thVtY+FyYFlus9mOvjWCYsQ+u4X+iRTtqyC34YEd3bspjG6xCs/a
	EpDoL6t2uAfJWuT8H15flgQV+Ti9keVvl6V53UggZ5DPzAhbXGt/vg8a29WNgMDF
	CRFehzTEIfRwDuH2nlcveFHzAC86q1EHx65GOM++FoUHRbMakTxGnHhrTZ6ZLdkv
	QwU1ogxbDMuAk+8/yUf6A==
X-ME-Sender: <xms:8daIaMpgiT0NjKQPSAhB-TglesPE2n7iaoziouXXL4clwXAqX7s0uw>
    <xme:8daIaC2o9DpSgUzsAwaXD4fgJQsqTCTITTNw7KWFIDGO08_aTpEsnW-DTYtUFTV6G
    p51jtFZoXZ0w_Dw0w>
X-ME-Received: <xmr:8daIaDBSmiDsVkKvFmJn2uZKzYLHf8p8_Gdty1nIvLF9Ru5oabojtTNZt3jIHhnHvia3P8NMHDLXO2NHrHa7TqGpasRmm4_GfRI3_fqRbpE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelhedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8daIaCecktXbJsR4kGXH8HU-oOW2PkHGtc22kbIQr33_D5TQwBV1zg>
    <xmx:8daIaAhyQwu9c_gnSNFtgI2Cl4Ui08BBHM_V82asf7_Bm2yGUvVVRw>
    <xmx:8daIaCpwH0-nvAJEirlR_9Sk6ir5xAmnffdIr65cIqfstdjiKNTPYw>
    <xmx:8daIaIF1snNWnFWTsFBo3IMzlMjBFvcbfGD3YhgTFXpwiPXJov0hTg>
    <xmx:8daIaFGa2PrCqHY79F0eub-7DA1j-PcTzpSMD0WchWf3PquacKOZe3z1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 10:13:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6429270 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 14:13:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 16:12:46 +0200
Subject: [PATCH 7/8] midx: stop duplicating info redundant with its owning
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-pks-midx-deduplicate-source-info-v1-7-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Multi-pack indices store some information that is redundant with their
owning source:

  - The locality bit that tracks whether the source is the primary
    object source or an alternate.

  - The object directory path the multi-pack index is located in.

  - The pointer to the owning parent directory.

All of this information is already contained in `struct odb_source`. So
now that we always have that struct available when loading a multi-pack
index we have it readily accessible.

Drop the redundant information and instead store a pointer to the object
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c          |  5 +++--
 midx-write.c              |  9 +++++----
 midx.c                    | 21 +++++++++++----------
 midx.h                    |  7 ++-----
 pack-bitmap.c             | 13 +++++++------
 pack-revindex.c           | 14 +++++++-------
 t/helper/test-read-midx.c |  2 +-
 7 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 94dec26f18..5af3e27357 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -223,9 +223,10 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct multi_pack_index *m = get_multi_pack_index(the_repository->objects->sources);
+	struct odb_source *source = the_repository->objects->sources;
+	struct multi_pack_index *m = get_multi_pack_index(source);
 	strbuf_addf(&buf, "%s.pack", base_name);
-	if (m && m->local && midx_contains_pack(m, buf.buf))
+	if (m && source->local && midx_contains_pack(m, buf.buf))
 		clear_midx_file(the_repository);
 	strbuf_insertf(&buf, 0, "%s/", dir_name);
 	unlink_pack_path(buf.buf, 1);
diff --git a/midx-write.c b/midx-write.c
index bf7c01d4b1..84f76856d6 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -981,10 +981,11 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	for (i = 0; i < ARRAY_SIZE(midx_exts); i++) {
 		const unsigned char *hash = get_midx_checksum(m);
 
-		get_midx_filename_ext(m->repo->hash_algo, &from, m->object_dir,
+		get_midx_filename_ext(m->source->odb->repo->hash_algo, &from,
+				      m->source->path,
 				      hash, midx_exts[i].non_split);
-		get_split_midx_filename_ext(m->repo->hash_algo, &to,
-					    m->object_dir, hash,
+		get_split_midx_filename_ext(m->source->odb->repo->hash_algo, &to,
+					    m->source->path, hash,
 					    midx_exts[i].split);
 
 		if (link(from.buf, to.buf) < 0 && errno != ENOENT) {
@@ -1109,7 +1110,7 @@ static int write_midx_internal(struct odb_source *source,
 			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
 				error(_("could not load reverse index for MIDX %s"),
 				      hash_to_hex_algop(get_midx_checksum(m),
-							m->repo->hash_algo));
+							m->source->odb->repo->hash_algo));
 				result = 1;
 				goto cleanup;
 			}
diff --git a/midx.c b/midx.c
index 831a7e9b5f..81bf3c4d5f 100644
--- a/midx.c
+++ b/midx.c
@@ -26,7 +26,7 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 {
-	return m->data + m->data_len - m->repo->hash_algo->rawsz;
+	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
 }
 
 void get_midx_filename(const struct git_hash_algo *hash_algo,
@@ -128,11 +128,10 @@ static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
 	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	FLEX_ALLOC_STR(m, object_dir, source->path);
+	CALLOC_ARRAY(m, 1);
 	m->data = midx_map;
 	m->data_len = midx_size;
-	m->local = source->local;
-	m->repo = r;
+	m->source = source;
 
 	m->signature = get_be32(m->data);
 	if (m->signature != MIDX_SIGNATURE)
@@ -446,7 +445,7 @@ static uint32_t midx_for_pack(struct multi_pack_index **_m,
 int prepare_midx_pack(struct multi_pack_index *m,
 		      uint32_t pack_int_id)
 {
-	struct repository *r = m->repo;
+	struct repository *r = m->source->odb->repo;
 	struct strbuf pack_name = STRBUF_INIT;
 	struct strbuf key = STRBUF_INIT;
 	struct packed_git *p;
@@ -458,7 +457,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
 	if (m->packs[pack_int_id])
 		return 0;
 
-	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
+	strbuf_addf(&pack_name, "%s/pack/%s", m->source->path,
 		    m->pack_names[pack_int_id]);
 
 	/* pack_map holds the ".pack" name, but we have the .idx */
@@ -469,7 +468,8 @@ int prepare_midx_pack(struct multi_pack_index *m,
 					strhash(key.buf), key.buf,
 					struct packed_git, packmap_ent);
 	if (!p) {
-		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
+		p = add_packed_git(r, pack_name.buf, pack_name.len,
+				   m->source->local);
 		if (p) {
 			install_packed_git(r, p);
 			list_add_tail(&p->mru, &r->objects->packed_git_mru);
@@ -528,7 +528,8 @@ int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
 		     uint32_t *result)
 {
 	int ret = bsearch_hash(oid->hash, m->chunk_oid_fanout,
-			       m->chunk_oid_lookup, m->repo->hash_algo->rawsz,
+			       m->chunk_oid_lookup,
+			       m->source->odb->repo->hash_algo->rawsz,
 			       result);
 	if (result)
 		*result += m->num_objects_in_base;
@@ -559,7 +560,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	n = midx_for_object(&m, n);
 
 	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n),
-		m->repo->hash_algo);
+		m->source->odb->repo->hash_algo);
 	return oid;
 }
 
@@ -734,7 +735,7 @@ int prepare_multi_pack_index_one(struct odb_source *source)
 
 int midx_checksum_valid(struct multi_pack_index *m)
 {
-	return hashfile_checksum_valid(m->repo->hash_algo,
+	return hashfile_checksum_valid(m->source->odb->repo->hash_algo,
 				       m->data, m->data_len);
 }
 
diff --git a/midx.h b/midx.h
index d162001fbb..71dbdec66e 100644
--- a/midx.h
+++ b/midx.h
@@ -35,6 +35,8 @@ struct odb_source;
 	"GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL"
 
 struct multi_pack_index {
+	struct odb_source *source;
+
 	const unsigned char *data;
 	size_t data_len;
 
@@ -50,7 +52,6 @@ struct multi_pack_index {
 	uint32_t num_objects;
 	int preferred_pack_idx;
 
-	int local;
 	int has_chain;
 
 	const unsigned char *chunk_pack_names;
@@ -71,10 +72,6 @@ struct multi_pack_index {
 
 	const char **pack_names;
 	struct packed_git **packs;
-
-	struct repository *repo;
-
-	char object_dir[FLEX_ARRAY];
 };
 
 #define MIDX_PROGRESS     (1 << 0)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index fb0b11ca07..01e14c34bd 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -216,7 +216,7 @@ static uint32_t bitmap_num_objects(struct bitmap_index *index)
 static struct repository *bitmap_repo(struct bitmap_index *bitmap_git)
 {
 	if (bitmap_is_midx(bitmap_git))
-		return bitmap_git->midx->repo;
+		return bitmap_git->midx->source->odb->repo;
 	return bitmap_git->pack->repo;
 }
 
@@ -418,13 +418,13 @@ char *midx_bitmap_filename(struct multi_pack_index *midx)
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (midx->has_chain)
-		get_split_midx_filename_ext(midx->repo->hash_algo, &buf,
-					    midx->object_dir,
+		get_split_midx_filename_ext(midx->source->odb->repo->hash_algo, &buf,
+					    midx->source->path,
 					    get_midx_checksum(midx),
 					    MIDX_EXT_BITMAP);
 	else
-		get_midx_filename_ext(midx->repo->hash_algo, &buf,
-				      midx->object_dir, get_midx_checksum(midx),
+		get_midx_filename_ext(midx->source->odb->repo->hash_algo, &buf,
+				      midx->source->path, get_midx_checksum(midx),
 				      MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
@@ -463,7 +463,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 
 	if (bitmap_git->pack || bitmap_git->midx) {
 		struct strbuf buf = STRBUF_INIT;
-		get_midx_filename(midx->repo->hash_algo, &buf, midx->object_dir);
+		get_midx_filename(midx->source->odb->repo->hash_algo, &buf,
+				  midx->source->path);
 		trace2_data_string("bitmap", bitmap_repo(bitmap_git),
 				   "ignoring extra midx bitmap file", buf.buf);
 		close(fd);
diff --git a/pack-revindex.c b/pack-revindex.c
index 0cc422a1e6..b206518dcb 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -379,25 +379,25 @@ int load_midx_revindex(struct multi_pack_index *m)
 		 * not want to accidentally call munmap() in the middle of the
 		 * MIDX.
 		 */
-		trace2_data_string("load_midx_revindex", m->repo,
+		trace2_data_string("load_midx_revindex", m->source->odb->repo,
 				   "source", "midx");
 		m->revindex_data = (const uint32_t *)m->chunk_revindex;
 		return 0;
 	}
 
-	trace2_data_string("load_midx_revindex", m->repo,
+	trace2_data_string("load_midx_revindex", m->source->odb->repo,
 			   "source", "rev");
 
 	if (m->has_chain)
-		get_split_midx_filename_ext(m->repo->hash_algo, &revindex_name,
-					    m->object_dir, get_midx_checksum(m),
+		get_split_midx_filename_ext(m->source->odb->repo->hash_algo, &revindex_name,
+					    m->source->path, get_midx_checksum(m),
 					    MIDX_EXT_REV);
 	else
-		get_midx_filename_ext(m->repo->hash_algo, &revindex_name,
-				      m->object_dir, get_midx_checksum(m),
+		get_midx_filename_ext(m->source->odb->repo->hash_algo, &revindex_name,
+				      m->source->path, get_midx_checksum(m),
 				      MIDX_EXT_REV);
 
-	ret = load_revindex_from_disk(m->repo->hash_algo,
+	ret = load_revindex_from_disk(m->source->odb->repo->hash_algo,
 				      revindex_name.buf,
 				      m->num_objects,
 				      &m->revindex_map,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index bcb8ea7671..6de5d1665a 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -66,7 +66,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 	for (i = 0; i < m->num_packs; i++)
 		printf("%s\n", m->pack_names[i]);
 
-	printf("object-dir: %s\n", m->object_dir);
+	printf("object-dir: %s\n", m->source->path);
 
 	if (show_objects) {
 		struct object_id oid;

-- 
2.50.1.619.g074bbf1d35.dirty

