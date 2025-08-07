Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7592586FE
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554230; cv=none; b=EAQQP6a15CPGp8fHW44rRc1e10CqRpSl0K9k9mIbglhdAoQKVRwHHDw5DZE5KUMJVe8dybLYN6QSv/0K7lufRABCkgLQBScMxEyZago8dSd/h197Yx9HkleUgcV5af6OlhYBYKliCmqhX5Yrwemrq6f4/iN9g1ZgrrntrWaiCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554230; c=relaxed/simple;
	bh=pg3HaLthwdb1oHHpOZQxwars1ZQdDUHsgbDbnKCbiyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVHR+8UHu8s6bhKeMmBIsBfmJOmZatCdjDpUdMJIfXyED7bFF4iUZ4r8kfG4ImgbzN09Dm2P3RnU0sGD0HTJZdI8XrqXalUHakbiZQL2u9lJABc0FURIkSoOyP7daQgd5mVC4kpaM5kyuskDZmrnhWIyKscXs/1va2KQtO4SQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fsnoVWbl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WEmPKFbY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fsnoVWbl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WEmPKFbY"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A60DEC018B;
	Thu,  7 Aug 2025 04:10:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 07 Aug 2025 04:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754554227;
	 x=1754640627; bh=GCii9StSe2ei+vONsm1jmlb/thhieOs6Lx9nvsLXSPQ=; b=
	fsnoVWbl+2UpTgjw7jFDB3v+zKITJvDHgtaL/2lz5WlT/JAZm5s3ioQGwnjA3CiQ
	nGG7C/ztG+GQUm+sTPPay7xKAqeUxFUKS3xZxNY+HxeK1TRPRAOYEJFacxif/pYq
	KNXmdEAm9D5Wfu38WIeQQr2Zv8JZeVuRLjr0Zk48mkbH8871HK15mVvD//wpXCG7
	/ridsDUBBlVNV0IAAtJpQv5oiIqaegtSYI4SODh169e/agKuDHMSyadZMnQpvDrk
	k1z/2UWOXe5ePdtWcRkeRg2m0UynA0+rO/DGwW0o/3TxaUxlBK4IOB3v8ZdVm96n
	o/V7ocNNT1l3C/J2iYb2vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754554227; x=
	1754640627; bh=GCii9StSe2ei+vONsm1jmlb/thhieOs6Lx9nvsLXSPQ=; b=W
	EmPKFbYy76+NN10ZQN2NT68rvciADDfpUTJBQhQhJ1ED2JTgzdlo7JPm4xWeNKyI
	lfnx2FpzsKztXTGukT1sGtmIMSqcAE6MW+uK2KcwL802w2jCmIJXSaBi5QeBDzRb
	gcAhzYAaeKWcSMBs5vR3lzrVqgK99F1w0dGTQ9jlSu20X3c1NHXs9/Ie8d/99zoZ
	AyuaMPG1bk+W3zhMVsmc0oq1mJDcpzkqwNeTfaOd8AFnPCgTyG3TMpM1z6oVT7Jm
	4DTB/jlGN2v3DpFes2/9XwyaFLYxZeX4ZgvtoPebuSDKPNeO7cUt1jAhwtRk+BTF
	7eoNaKIjMlLkVU0xWR81g==
X-ME-Sender: <xms:c1-UaLDxeDhh3m9cGZzx0szuERqcGpyBqUoSsR8k8G585MrNaujWiw>
    <xme:c1-UaEwQYVcqf3H52gw7pwNZa-b7s9yI4gFdhd4Gbtx_4PcDBayYmxVm-KSlnYARR
    wn0OQTuUb1QZJZEuQ>
X-ME-Received: <xmr:c1-UaAC80j-DOiFx_ad5NCbUt__niyMJpa20jaBQIkTtTPT8Fn2yMP1fSh5bFJU439bva-83M8HppXEOUYE7wFHPufwaRGd_sVbp7Zk9xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:c1-UaJaHAzxqxlLK9ekJeJwoRD0I-BAFdVsIyDDDHLOz7uHXPqbVgw>
    <xmx:c1-UaAgAK9bz7xFDdJnZgnerf6V5KC6RRNZa8aqdzPItHlzuKH8Mhw>
    <xmx:c1-UaD49iTcpw467ekSJp1lNcdSJSktavBHG1msGBGE8UC1Yv4LQIQ>
    <xmx:c1-UaP6Hy46DZdah2BrXn6gBRtMQpa6iwzkG5rq4OrLCC2tGtHWlkg>
    <xmx:c1-UaBnv2sg0A8iqdeN1kxwFCZKXVpbX4PT9Zha4d2TexuhhRurwZMpn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:10:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7829bab9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:10:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:09:58 +0200
Subject: [PATCH v2 8/9] midx: stop duplicating info redundant with its
 owning source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-midx-deduplicate-source-info-v2-8-bcffb8fc119c@pks.im>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
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
2.51.0.rc0.215.g125493bb4a.dirty

