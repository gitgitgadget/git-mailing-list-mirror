Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008F2DCBF3
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578985; cv=none; b=gEF0kbAeJLWNLgZiQXACgEI3Z+gSd+eCJQWDKl99iracfcKpuEYFTpCaQqnlyT557XNFuFmb0XozNnzq6GX9hyrNXLShCg84PPiQlY1NDWRIKFI2/CvCKe/iKmSoPzUyVcMBe8DpN9jGqffPSAt9uLxQWzcm6qGdbRPaMd7h4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578985; c=relaxed/simple;
	bh=kUuEPxDtjhSHsZpN8Yk+CVPLKc0jJ7owUJ9Lahrk3uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCh8G4NURWR8xCIrFCfn6d8qFu5IYJZBEkUrytWWxOijFbGsh+E8wVykZ7i8rkFr1ie0CD8P271QQ5He2Keb4ROZm35ib1ZKjgONe+Z0aYwBgnPfTfeqgRtcMs8yxODkwUh9/NHHhxdLSA6FMOgEMhPFZSutElzhpXZAlqfW/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rgbo0ydz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ICgLNdDR; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rgbo0ydz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ICgLNdDR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A0D014002D9;
	Tue, 15 Jul 2025 07:29:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 15 Jul 2025 07:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752578982;
	 x=1752665382; bh=e69VBn308F6QWDiaUr0zIrJAQHsKcry6RXP5gh+a04c=; b=
	rgbo0ydzzhg8YwbYUW1hVdIvzdfn7qreCrLvuTd55vc037UyVPls3d1+CGSF+WPm
	uQBcqKDrAeby2YlfxBbriz/beJ5i7B7RDRmeF3Lb1OBH3LiqKYNmAQXHyiK3jH6c
	mM0faEmh0rAaHQywBvhRCVbsrSTeNx61yyHWi16AsaqiMy0Kre/EzRVn4v2CgyLI
	yEbt8WJ59ZJljHoatCDim8a4JK3Q5A8j/QKB0CdlDkGFRfe6/JwDnIvnkLFn42Za
	VMWU4kx+lwGfmBdX0ilO6WfdlyAENjx2ITeiooaOvtAdPL5nPhIKG7LpoPmrpy1Q
	mZ0yktMGK5K7swTOPoFMhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752578982; x=
	1752665382; bh=e69VBn308F6QWDiaUr0zIrJAQHsKcry6RXP5gh+a04c=; b=I
	CgLNdDRXiRB1V3YO+V5uIODux2mnS6TQFMQTU308BGnzMDvRmGb7rCS7YFFwdMp7
	ZX9mr1pMpFuOD6s+DXqtpZD9N4M2PYNglTslRmx6k1DbHNVo9NfvoYNzRLstzNWy
	gMbntdp3vKYoijuzXBiEwbjQ/SGk6rR59m6KviWHsWrTg2G/aS32fHCFPVNY8U9i
	IYkiXHvaEypzOIAMxRRv3fsZ58+hxBjGLJ/j8ctD8BKqBHBNFg7ApnbDBYkBKw53
	WCYZuHHZqK71Kv4ZRD1QiFbQsghUW/U8hGHlOV3hvKtAKKq/1WcB4y0tRDpgmGjs
	UkSeecK/SyJlY92v3vsmg==
X-ME-Sender: <xms:pjt2aHlIY00yfz7kjIRUJ8_7WEohKHk9Qwj_2ceUHoUREiZEBGgk0A>
    <xme:pjt2aFaf2FEuMjnLmD9NcCpnS4Uc5FR_yzJzT2eWIrS2dId0w0PzW_oINsfa_mZMo
    r3zHaHmnxw9wuISQg>
X-ME-Received: <xmr:pjt2aKMpy8gdvCo87NhbVrB77gFqjPGMhUEqm_nW0MeVIAfzd8vkWtFE6qQMongCinx-mOtdKtp5ItYtRHHlvGjOJXvH7QlW3lX5Klu4spUxag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pjt2aCZibm9o4ewqb85NWiQz1oJxe7P0pZR59WtIw4p4BAyNYkql-Q>
    <xmx:pjt2aA08zFt0V3g-s09kSDv-_3zS6RTwgTqRMw4ZL-B_4cNMH6OY3g>
    <xmx:pjt2aAdT0L0gnzjhTaroemDoWNhNg5jTYmK0sMLGftvwYi2eh59sCA>
    <xmx:pjt2aJGK7LMGKZs_havRKLPKxHGL7q4-Zp_LBji7ximhMiayYXrnCQ>
    <xmx:pjt2aJLibW86W4dTv-usczDUg6ZGVcjtDW6RgROpWKlHi_KCq-eWP0pJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:29:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e4e6145 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:29:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Jul 2025 13:29:21 +0200
Subject: [PATCH v2 4/7] packfile: refactor `get_multi_pack_index()` to work
 on sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-b4-pks-midx-via-odb-alternate-v2-4-b0ca0b4b516e@pks.im>
References: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
In-Reply-To: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The function `get_multi_pack_index()` loads multi-pack indices via
`prepare_packed_git()` and then returns the linked list of multi-pack
indices that is stored in `struct object_database`. That list is in the
process of being removed though in favor of storing the MIDX as part of
the object database source it belongs to.

Refactor `get_multi_pack_index()` so that it returns the multi-pack
index for a single object source. Callers are now expected to call this
function for each source they are interested in. This requires them to
iterate through alternates, so we have to prepare alternate object
sources before doing so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 10 +++++++---
 builtin/repack.c       | 10 +++++-----
 midx-write.c           | 22 ++--------------------
 object-name.c          | 22 +++++++++++++++-------
 pack-bitmap.c          | 21 +++++++++++++++------
 packfile.c             | 31 ++++++++++++-------------------
 packfile.h             |  3 +--
 7 files changed, 57 insertions(+), 62 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 067b9e322a9..3dd84495b86 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1706,8 +1706,8 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 				     uint32_t found_mtime)
 {
 	int want;
+	struct odb_source *source;
 	struct list_head *pos;
-	struct multi_pack_index *m;
 
 	if (!exclude && local && has_loose_object_nonlocal(oid))
 		return 0;
@@ -1727,9 +1727,13 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		*found_offset = 0;
 	}
 
-	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
+	odb_prepare_alternates(the_repository->objects);
+
+	for (source = the_repository->objects->sources; source; source = source->next) {
+		struct multi_pack_index *m = get_multi_pack_index(source);
 		struct pack_entry e;
-		if (fill_midx_entry(the_repository, oid, &e, m)) {
+
+		if (m && fill_midx_entry(the_repository, oid, &e, m)) {
 			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (want != -1)
 				return want;
diff --git a/builtin/repack.c b/builtin/repack.c
index 5e89d96df13..d63e1a9fec2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -223,9 +223,9 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct multi_pack_index *m = get_local_multi_pack_index(the_repository);
+	struct multi_pack_index *m = get_multi_pack_index(the_repository->objects->sources);
 	strbuf_addf(&buf, "%s.pack", base_name);
-	if (m && midx_contains_pack(m, buf.buf))
+	if (m && m->local && midx_contains_pack(m, buf.buf))
 		clear_midx_file(the_repository);
 	strbuf_insertf(&buf, 0, "%s/", dir_name);
 	unlink_pack_path(buf.buf, 1);
@@ -1531,7 +1531,7 @@ int cmd_repack(int argc,
 		 * midx_has_unknown_packs() will make the decision for
 		 * us.
 		 */
-		if (!get_local_multi_pack_index(the_repository))
+		if (!get_multi_pack_index(the_repository->objects->sources))
 			midx_must_contain_cruft = 1;
 	}
 
@@ -1614,9 +1614,9 @@ int cmd_repack(int argc,
 
 	string_list_sort(&names);
 
-	if (get_local_multi_pack_index(the_repository)) {
+	if (get_multi_pack_index(the_repository->objects->sources)) {
 		struct multi_pack_index *m =
-			get_local_multi_pack_index(the_repository);
+			get_multi_pack_index(the_repository->objects->sources);
 
 		ALLOC_ARRAY(midx_pack_names,
 			    m->num_packs + m->num_packs_in_base);
diff --git a/midx-write.c b/midx-write.c
index f2cfb85476e..c1ae62d3549 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -916,26 +916,8 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir)
 {
-	struct multi_pack_index *result = NULL;
-	struct multi_pack_index *cur;
-	char *obj_dir_real = real_pathdup(object_dir, 1);
-	struct strbuf cur_path_real = STRBUF_INIT;
-
-	/* Ensure the given object_dir is local, or a known alternate. */
-	odb_find_source(r->objects, obj_dir_real);
-
-	for (cur = get_multi_pack_index(r); cur; cur = cur->next) {
-		strbuf_realpath(&cur_path_real, cur->object_dir, 1);
-		if (!strcmp(obj_dir_real, cur_path_real.buf)) {
-			result = cur;
-			goto cleanup;
-		}
-	}
-
-cleanup:
-	free(obj_dir_real);
-	strbuf_release(&cur_path_real);
-	return result;
+	struct odb_source *source = odb_find_source(r->objects, object_dir);
+	return get_multi_pack_index(source);
 }
 
 static int fill_packs_from_midx(struct write_midx_context *ctx,
diff --git a/object-name.c b/object-name.c
index ddafe7f9b13..27138b55b47 100644
--- a/object-name.c
+++ b/object-name.c
@@ -198,16 +198,20 @@ static void unique_in_pack(struct packed_git *p,
 
 static void find_short_packed_object(struct disambiguate_state *ds)
 {
-	struct multi_pack_index *m;
+	struct odb_source *source;
 	struct packed_git *p;
 
 	/* Skip, unless oids from the storage hash algorithm are wanted */
 	if (ds->bin_pfx.algo && (&hash_algos[ds->bin_pfx.algo] != ds->repo->hash_algo))
 		return;
 
-	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
-	     m = m->next)
-		unique_in_midx(m, ds);
+	odb_prepare_alternates(ds->repo->objects);
+	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
+		struct multi_pack_index *m = get_multi_pack_index(source);
+		if (m)
+			unique_in_midx(m, ds);
+	}
+
 	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
@@ -792,11 +796,15 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 
 static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
-	struct multi_pack_index *m;
 	struct packed_git *p;
 
-	for (m = get_multi_pack_index(mad->repo); m; m = m->next)
-		find_abbrev_len_for_midx(m, mad);
+	odb_prepare_alternates(mad->repo->objects);
+	for (struct odb_source *source = mad->repo->objects->sources; source; source = source->next) {
+		struct multi_pack_index *m = get_multi_pack_index(source);
+		if (m)
+			find_abbrev_len_for_midx(m, mad);
+	}
+
 	for (p = get_packed_git(mad->repo); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 0a4af199c05..64278e2acf7 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -691,13 +691,15 @@ static int open_pack_bitmap(struct repository *r,
 static int open_midx_bitmap(struct repository *r,
 			    struct bitmap_index *bitmap_git)
 {
+	struct odb_source *source;
 	int ret = -1;
-	struct multi_pack_index *midx;
 
 	assert(!bitmap_git->map);
 
-	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
-		if (!open_midx_bitmap_1(bitmap_git, midx))
+	odb_prepare_alternates(r->objects);
+	for (source = r->objects->sources; source; source = source->next) {
+		struct multi_pack_index *midx = get_multi_pack_index(source);
+		if (midx && !open_midx_bitmap_1(bitmap_git, midx))
 			ret = 0;
 	}
 	return ret;
@@ -3305,11 +3307,18 @@ static int verify_bitmap_file(const struct git_hash_algo *algop,
 
 int verify_bitmap_files(struct repository *r)
 {
+	struct odb_source *source;
 	int res = 0;
 
-	for (struct multi_pack_index *m = get_multi_pack_index(r);
-	     m; m = m->next) {
-		char *midx_bitmap_name = midx_bitmap_filename(m);
+	odb_prepare_alternates(r->objects);
+	for (source = r->objects->sources; source; source = source->next) {
+		struct multi_pack_index *m = get_multi_pack_index(source);
+		char *midx_bitmap_name;
+
+		if (!m)
+			continue;
+
+		midx_bitmap_name = midx_bitmap_filename(m);
 		res |= verify_bitmap_file(r->hash_algo, midx_bitmap_name);
 		free(midx_bitmap_name);
 	}
diff --git a/packfile.c b/packfile.c
index 7b350f018ca..d0f38a02035 100644
--- a/packfile.c
+++ b/packfile.c
@@ -963,14 +963,18 @@ static void prepare_packed_git(struct repository *r);
 unsigned long repo_approximate_object_count(struct repository *r)
 {
 	if (!r->objects->approximate_object_count_valid) {
-		unsigned long count;
-		struct multi_pack_index *m;
+		struct odb_source *source;
+		unsigned long count = 0;
 		struct packed_git *p;
 
 		prepare_packed_git(r);
-		count = 0;
-		for (m = get_multi_pack_index(r); m; m = m->next)
-			count += m->num_objects;
+
+		for (source = r->objects->sources; source; source = source->next) {
+			struct multi_pack_index *m = get_multi_pack_index(source);
+			if (m)
+				count += m->num_objects;
+		}
+
 		for (p = r->objects->packed_git; p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
@@ -1074,21 +1078,10 @@ struct packed_git *get_packed_git(struct repository *r)
 	return r->objects->packed_git;
 }
 
-struct multi_pack_index *get_multi_pack_index(struct repository *r)
-{
-	prepare_packed_git(r);
-	return r->objects->multi_pack_index;
-}
-
-struct multi_pack_index *get_local_multi_pack_index(struct repository *r)
+struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 {
-	struct multi_pack_index *m = get_multi_pack_index(r);
-
-	/* no need to iterate; we always put the local one first (if any) */
-	if (m && m->local)
-		return m;
-
-	return NULL;
+	prepare_packed_git(source->odb->repo);
+	return source->midx;
 }
 
 struct packed_git *get_all_packs(struct repository *r)
diff --git a/packfile.h b/packfile.h
index 53c3b7d3b43..f16753f2a9b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -147,8 +147,7 @@ void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
-struct multi_pack_index *get_multi_pack_index(struct repository *r);
-struct multi_pack_index *get_local_multi_pack_index(struct repository *r);
+struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
 struct packed_git *get_all_packs(struct repository *r);
 
 /*

-- 
2.50.1.404.ge9779f6434.dirty

