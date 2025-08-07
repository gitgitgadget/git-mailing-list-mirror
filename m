Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D142459D2
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554221; cv=none; b=Wd0ahSYdUuQwsl4tXpP84/sdhiqb/h4g/9giLOpDQNhL4FhbCCcteuVqLd+/a069IZJ1lAz7DYjIJGSMRWJYMjvraZSHWVc4HxfKnFr0WL1uu4hvF3c5lGhLqj7TaJblXglV8FfUGyAmPmKmtasTH40m9LpmFO+CgNrIUJc2d2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554221; c=relaxed/simple;
	bh=N7vA2hWKLr08M6ePx0TMm99/HvdIzDZQOJk46uPoVkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGnATBSLFwvfbUvsxBTEJhj6GImo9vok3Tso3I0WXTYsvDufyb+aORU4t7WOSdNjAyTiX4b2mHDtj6AnUxzwcLUc0ExGwcsuSbJAcLv30NbNtL14SB2ieA/wx2cuemF1BAgrfu9hdvonuwKjfn8a5DUlM1ifIDwSjFi/gx6Qok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=da01ohJn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HLy6yWc8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="da01ohJn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HLy6yWc8"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D4C9EC00D8;
	Thu,  7 Aug 2025 04:10:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 07 Aug 2025 04:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754554218;
	 x=1754640618; bh=Y6GWIL7HSQRKqeXpmbAXl3Hj3lE5YqyQtGzkjOOxCMU=; b=
	da01ohJnpyizmE7kUFn/XxTLauZ2JLvXRApNJdQJnFFRh/rMQo+gy2P8SC328hBw
	9sxjODzLcNxNJkoL+9UUktjAexF27XWf5N8u3epsP8vr2JolBEW8f7dhrQmPy9Jt
	9zeSdhKd1MqvUfZmtpYY/v1PMpYzWWEgRPk/ap+nG7443H9ixhfv+nmKa1+oBF+y
	3PNJqbL1bWzBYGHmYSi/K2ZCBW6WESPXNs5wH7JpEulr7A6TycJWiFDFJwq+VM4i
	2vSzEJqAGSpXNAm5kNlEcQGP9+oLzjzMff77O/Run9BzOjY6GyIYjpu3eYo0pv9m
	I0XLTmXc2aSBEkQX1YEnyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754554218; x=
	1754640618; bh=Y6GWIL7HSQRKqeXpmbAXl3Hj3lE5YqyQtGzkjOOxCMU=; b=H
	Ly6yWc8LfSW7qPq6JMzeUjbYOZznbfgKpxwziAUCQLzn1O/gUN1XiQPc/KFxopg6
	eVGxZYS7YzJ1ToAH8YB/W/d3R5QP86G1Vuj3IpmBKbAMkhJuwxQZDf6loHV8Xt3d
	SbMSVNO5ZHJRLHCDDavQ3iR+gS+uX+CznhSYpxaPYu1axhLu2SmOzqHEkaF/Nu8k
	eeFxUgC4Y1zgSfLO2IMHnR34LL2qdNdRW+3aJ/DVtegktC4+yKnuEKu6rJVypvy3
	X/kp/VEDJbvIBEVwHmMtvtolrjq9UaxiZoavxz8CYatEsEaZmaT+TUi3etda1doz
	TjLtLuP0pfqHzLOuPFtdQ==
X-ME-Sender: <xms:al-UaLWWpZqHlo-EoiBpzXH9zMGqCQthYLaEsMBD-5xdASu1bBuAeQ>
    <xme:al-UaG3RQbdnI0D9p4iiUwcXKBlEi5aoC2VrFB-QGoOjVarL8Eqv_2i9pFvGVQOhf
    lLz6OY9XYxIKe4wSA>
X-ME-Received: <xmr:al-UaA2ddKhpqqAkASzRcDRHueZU5qUOGL8AkJu9F-l6T_GY3PIK4Ohk0Umv-l9_8idezJq7GLBAPs5bm9r2n_jRadLrIBh8Q-r7F4nX6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:al-UaB8IHvec_aE9XnSCS9_z6gEiouxeL6svIeJ8-_7l7iRdPFHMAg>
    <xmx:al-UaF3QOpy5TdMMgQIEo5GOxkN2OvTMy1CiqtWRlr6FkHMBoSG_Pg>
    <xmx:al-UaG9PzYXqb6cYvz2mBu4DQSexR-0ZvVn_ZfPTUa_jb8cyvkqwyg>
    <xmx:al-UaNtMS012XWRjP9_o0zbZJawZp4U1RUYIoPGRikpinTS_0R3nbA>
    <xmx:al-UaFr8qMufr4_CGL4qzfXifbMej7mC5QHY_VDNWFwkAaZ4J6pkeIgh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:10:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27a423a0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:10:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:09:55 +0200
Subject: [PATCH v2 5/9] midx: drop redundant `struct repository` parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-midx-deduplicate-source-info-v2-5-bcffb8fc119c@pks.im>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

There are a couple of functions that take both a `struct repository` and
a `struct multi_pack_index`. This provides redundant information though
without much benefit given that the multi-pack index already has a
pointer to its owning repository.

Drop the `struct repository` parameter from such functions. While at it,
reorder the list of parameters of `fill_midx_entry()` so that the MIDX
comes first to better align with our coding guidelines.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c    |  2 +-
 midx-write.c              | 16 +++++++---------
 midx.c                    | 18 +++++++++---------
 midx.h                    |  6 +++---
 pack-bitmap.c             |  4 ++--
 packfile.c                |  4 ++--
 t/helper/test-read-midx.c |  4 ++--
 7 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3dd84495b8..b9fd685b8f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1733,7 +1733,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		struct multi_pack_index *m = get_multi_pack_index(source);
 		struct pack_entry e;
 
-		if (m && fill_midx_entry(the_repository, oid, &e, m)) {
+		if (m && fill_midx_entry(m, oid, &e)) {
 			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (want != -1)
 				return want;
diff --git a/midx-write.c b/midx-write.c
index 40580d8c73..37a0b1682f 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -944,8 +944,7 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
 			 */
 			if (flags & MIDX_WRITE_REV_INDEX ||
 			    preferred_pack_name) {
-				if (prepare_midx_pack(ctx->repo, m,
-						      m->num_packs_in_base + i)) {
+				if (prepare_midx_pack(m, m->num_packs_in_base + i)) {
 					error(_("could not load pack"));
 					return 1;
 				}
@@ -1568,7 +1567,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 		if (count[i])
 			continue;
 
-		if (prepare_midx_pack(r, m, i))
+		if (prepare_midx_pack(m, i))
 			continue;
 
 		if (m->packs[i]->pack_keep || m->packs[i]->is_cruft)
@@ -1614,13 +1613,12 @@ static int compare_by_mtime(const void *a_, const void *b_)
 	return 0;
 }
 
-static int want_included_pack(struct repository *r,
-			      struct multi_pack_index *m,
+static int want_included_pack(struct multi_pack_index *m,
 			      int pack_kept_objects,
 			      uint32_t pack_int_id)
 {
 	struct packed_git *p;
-	if (prepare_midx_pack(r, m, pack_int_id))
+	if (prepare_midx_pack(m, pack_int_id))
 		return 0;
 	p = m->packs[pack_int_id];
 	if (!pack_kept_objects && p->pack_keep)
@@ -1642,7 +1640,7 @@ static void fill_included_packs_all(struct repository *r,
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
 
 	for (i = 0; i < m->num_packs; i++) {
-		if (!want_included_pack(r, m, pack_kept_objects, i))
+		if (!want_included_pack(m, pack_kept_objects, i))
 			continue;
 
 		include_pack[i] = 1;
@@ -1666,7 +1664,7 @@ static void fill_included_packs_batch(struct repository *r,
 	for (i = 0; i < m->num_packs; i++) {
 		pack_info[i].pack_int_id = i;
 
-		if (prepare_midx_pack(r, m, i))
+		if (prepare_midx_pack(m, i))
 			continue;
 
 		pack_info[i].mtime = m->packs[i]->mtime;
@@ -1685,7 +1683,7 @@ static void fill_included_packs_batch(struct repository *r,
 		struct packed_git *p = m->packs[pack_int_id];
 		uint64_t expected_size;
 
-		if (!want_included_pack(r, m, pack_kept_objects, pack_int_id))
+		if (!want_included_pack(m, pack_kept_objects, pack_int_id))
 			continue;
 
 		/*
diff --git a/midx.c b/midx.c
index b9ca0915a6..8459dda8c9 100644
--- a/midx.c
+++ b/midx.c
@@ -450,9 +450,10 @@ static uint32_t midx_for_pack(struct multi_pack_index **_m,
 	return pack_int_id - m->num_packs_in_base;
 }
 
-int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
+int prepare_midx_pack(struct multi_pack_index *m,
 		      uint32_t pack_int_id)
 {
+	struct repository *r = m->repo;
 	struct strbuf pack_name = STRBUF_INIT;
 	struct strbuf key = STRBUF_INIT;
 	struct packed_git *p;
@@ -507,7 +508,7 @@ struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
 
 #define MIDX_CHUNK_BITMAPPED_PACKS_WIDTH (2 * sizeof(uint32_t))
 
-int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
+int nth_bitmapped_pack(struct multi_pack_index *m,
 		       struct bitmapped_pack *bp, uint32_t pack_int_id)
 {
 	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
@@ -515,7 +516,7 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
 	if (!m->chunk_bitmapped_packs)
 		return error(_("MIDX does not contain the BTMP chunk"));
 
-	if (prepare_midx_pack(r, m, pack_int_id))
+	if (prepare_midx_pack(m, pack_int_id))
 		return error(_("could not load bitmapped pack %"PRIu32), pack_int_id);
 
 	bp->p = m->packs[local_pack_int_id];
@@ -600,10 +601,9 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 					       (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
 }
 
-int fill_midx_entry(struct repository *r,
+int fill_midx_entry(struct multi_pack_index *m,
 		    const struct object_id *oid,
-		    struct pack_entry *e,
-		    struct multi_pack_index *m)
+		    struct pack_entry *e)
 {
 	uint32_t pos;
 	uint32_t pack_int_id;
@@ -615,7 +615,7 @@ int fill_midx_entry(struct repository *r,
 	midx_for_object(&m, pos);
 	pack_int_id = nth_midxed_pack_int_id(m, pos);
 
-	if (prepare_midx_pack(r, m, pack_int_id))
+	if (prepare_midx_pack(m, pack_int_id))
 		return 0;
 	p = m->packs[pack_int_id - m->num_packs_in_base];
 
@@ -912,7 +912,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 						  _("Looking for referenced packfiles"),
 						  m->num_packs + m->num_packs_in_base);
 	for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
-		if (prepare_midx_pack(r, m, i))
+		if (prepare_midx_pack(m, i))
 			midx_report("failed to load pack in position %d", i);
 
 		display_progress(progress, i + 1);
@@ -989,7 +989,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 
 		nth_midxed_object_oid(&oid, m, pairs[i].pos);
 
-		if (!fill_midx_entry(r, &oid, &e, m)) {
+		if (!fill_midx_entry(m, &oid, &e)) {
 			midx_report(_("failed to load pack entry for oid[%d] = %s"),
 				    pairs[i].pos, oid_to_hex(&oid));
 			continue;
diff --git a/midx.h b/midx.h
index 28c426a823..f7e07083e1 100644
--- a/midx.h
+++ b/midx.h
@@ -103,10 +103,10 @@ void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
 struct multi_pack_index *load_multi_pack_index(struct repository *r,
 					       const char *object_dir,
 					       int local);
-int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
+int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id);
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
 				   uint32_t pack_int_id);
-int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
+int nth_bitmapped_pack(struct multi_pack_index *m,
 		       struct bitmapped_pack *bp, uint32_t pack_int_id);
 int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
 		     uint32_t *result);
@@ -118,7 +118,7 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos);
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n);
-int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
+int fill_midx_entry(struct multi_pack_index *m, const struct object_id *oid, struct pack_entry *e);
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d14421ee20..fb0b11ca07 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -493,7 +493,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	}
 
 	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
-		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
+		if (prepare_midx_pack(bitmap_git->midx, i)) {
 			warning(_("could not open pack %s"),
 				bitmap_git->midx->pack_names[i]);
 			goto cleanup;
@@ -2466,7 +2466,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		struct multi_pack_index *m = bitmap_git->midx;
 		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
 			struct bitmapped_pack pack;
-			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
+			if (nth_bitmapped_pack(bitmap_git->midx, &pack, i) < 0) {
 				warning(_("unable to load pack: '%s', disabling pack-reuse"),
 					bitmap_git->midx->pack_names[i]);
 				free(packs);
diff --git a/packfile.c b/packfile.c
index a38544b87b..acb680966d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1091,7 +1091,7 @@ struct packed_git *get_all_packs(struct repository *r)
 		if (!m)
 			continue;
 		for (uint32_t i = 0; i < m->num_packs + m->num_packs_in_base; i++)
-			prepare_midx_pack(r, m, i);
+			prepare_midx_pack(m, i);
 	}
 
 	return r->objects->packed_git;
@@ -2077,7 +2077,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 	prepare_packed_git(r);
 
 	for (struct odb_source *source = r->objects->sources; source; source = source->next)
-		if (source->midx && fill_midx_entry(r, oid, e, source->midx))
+		if (source->midx && fill_midx_entry(source->midx, oid, e))
 			return 1;
 
 	if (!r->objects->packed_git)
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index da2aa036b5..e430aa247c 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -65,7 +65,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 		for (i = 0; i < m->num_objects; i++) {
 			nth_midxed_object_oid(&oid, m,
 					      i + m->num_objects_in_base);
-			fill_midx_entry(the_repository, &oid, &e, m);
+			fill_midx_entry(m, &oid, &e);
 
 			printf("%s %"PRIu64"\t%s\n",
 			       oid_to_hex(&oid), e.offset, e.p->pack_name);
@@ -126,7 +126,7 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 		return 1;
 
 	for (i = 0; i < midx->num_packs + midx->num_packs_in_base; i++) {
-		if (nth_bitmapped_pack(the_repository, midx, &pack, i) < 0) {
+		if (nth_bitmapped_pack(midx, &pack, i) < 0) {
 			close_midx(midx);
 			return 1;
 		}

-- 
2.51.0.rc0.215.g125493bb4a.dirty

