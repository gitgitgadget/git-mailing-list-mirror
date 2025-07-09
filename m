Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A70D272E5E
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047736; cv=none; b=ixt9xyWe4opLKJjCcpugDuHbKwUpXrElnOSubE/QbdUTg9CtXF1r9B6NQoyEKtLwFCL+jLxOGZGg/PuJOGzGWpDGf2LmV5AIvzqUdlTnVdJiDEAgnaSZAV13FdW4IrLlUM3ZkrAoAf5jKAFpXHHiBnxzL5FwSxQkr79dj+Z4CQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047736; c=relaxed/simple;
	bh=AWF2VByzbZ4Ipl5fobHshZGD4UJOr2epRsJxJ7QLNLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tNIrbtcHKGtSXEk8uPOYhJbe3xuO0pUAF5qmYaxBM41E0OIGoJvhM3CEBI31JglqIypXGa8TCGu3nc+1yJJ5E8aarH8SVrdrO5PQuedB1Y9LhEkwWsDoy9QPPDvhJ0bZO7W7FaqNRcSC0C8gMhDyRCPDlO1Df2UdVf5JLEnvciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wStctMDn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e3ZaGVrh; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wStctMDn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3ZaGVrh"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 99680140007C
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 03:55:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 03:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752047733;
	 x=1752134133; bh=fJ774DVgy90v4ZP1HVi7T7Qpj2Vn/rOVlAQ2kxTRufw=; b=
	wStctMDnqkBz0cYJhvgvNoHzLqhuSfVkBzpOkU37In41VTbi/rxJgmKsA39LzdBn
	KnILnq0ZIQQkL0nNvR00myg0mMyMXFBltkQy1cz4nOC9BoByLzaE5LhHs2+5bs2c
	NcTEqzfvkTV+TDuu3tyIDbL4GsRgnL4r+D2TXSHIQXPPyuBiPZ6h1KL28H7E8jxn
	ct4X70jOG8622dgdAYJUs7hiOIk9vRVMJbjmcdJ/UocjImTGnWg3WCEggPKF/qNo
	n9ZFUvK6CmrQm6xST/oeOdvUqQZLkFBV9LJSXjVDdi1uaEw8nq1d36q7+DkdCNeb
	V2EhV7A2qq83Z3BFVIXlWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752047733; x=
	1752134133; bh=fJ774DVgy90v4ZP1HVi7T7Qpj2Vn/rOVlAQ2kxTRufw=; b=e
	3ZaGVrhq1OmUYVNHl44r81C4F4U1HXbeUNpEKI9rAZCYKGNT2gUBfiYgKodOe1xX
	O0AB1BDmtTvLbRrc9DWwoLYkDUlHq2cn0gO2DzEJLzbRlWfPdpfAZ0VRdgjUT70P
	PpcOc6rLUZmlnwD5G5EaVNkObJ91mQq+Fn9pfLf3qhNBGQ1BeM8H/yIsuc0W8SZc
	x3CR/lR6bya8IKacYNkWrK+/fe7bEJBzLX0zAj1b+j4sfCcYAY1+HnGOleqXsOEk
	A94F4Roypo5hK3h/guASDLiEkAEeQp/cVgbB5KJUfmJqoNg1vof45LaoL2vv5H51
	vTw4FpMo9JryvEvL0ueHw==
X-ME-Sender: <xms:dSBuaFPe7r57f6G7TDEeZYl5W8xBliclRxjIOvsufdmXXiI7nM3Cig>
    <xme:dSBuaJ-mGVKhXsi_58ifhdtO5eXicFnhxIT1g76pLV561DNH1ovXzQhnh73WlbKgn
    k3OwUmxEbzQW-XdkA>
X-ME-Received: <xmr:dSBuaNpMqOVW3Er2aDkFuxpWKZD-tICxS-UEWSzfIniG1HSzWm1LVgE2gnQpDBbKG2tOOrkmiS3z5LDd4rNgIEhY3YA3DOEleZU3K_zdOHOg1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:dSBuaD6K0YO4MvCfrsCbeebcscjuvHqSW7m6_WaOcEa-QY5lKeAbtg>
    <xmx:dSBuaFN9Pllt4RmAEQ4KvWpXN9ElwjIb6PYgnJbVyhgB8iCD3paUlA>
    <xmx:dSBuaNP3trVoghTimLoar8xliMPNUUexfFGbyPzATk-krIMylVYbDw>
    <xmx:dSBuaF-2pgrdU-SP5ZaQ-jNg5XsT-xtXG1E8Fu68lgYI-EZvXo8rcA>
    <xmx:dSBuaK26i9FxAMuNrrfC5ET2e_-tvLFC7IUaPiDY9lZgNMp_k4SQ8cS0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 03:55:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7f070107 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 07:55:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 09:54:53 +0200
Subject: [PATCH 5/8] packfile: refactor `get_multi_pack_index()` to work on
 sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-midx-via-odb-alternate-v1-5-f31150d21331@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
To: git@vger.kernel.org
Cc: 
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
 builtin/pack-objects.c |  9 ++++++---
 builtin/repack.c       |  4 ++--
 midx-write.c           | 22 ++--------------------
 object-name.c          | 21 ++++++++++++++-------
 pack-bitmap.c          | 20 ++++++++++++++------
 packfile.c             | 30 +++++++++++-------------------
 packfile.h             |  3 +--
 7 files changed, 50 insertions(+), 59 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5781dec9808..f889e69e07d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1701,7 +1701,6 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 {
 	int want;
 	struct list_head *pos;
-	struct multi_pack_index *m;
 
 	if (!exclude && local && has_loose_object_nonlocal(oid))
 		return 0;
@@ -1721,9 +1720,13 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		*found_offset = 0;
 	}
 
-	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
+	odb_prepare_alternates(the_repository->objects);
+
+	for (struct odb_source *source = the_repository->objects->sources; source; source = source->next) {
+		struct multi_pack_index *m = get_multi_pack_index(source);
 		struct pack_entry e;
-		if (fill_midx_entry(the_repository, oid, &e, m)) {
+
+		if (m && fill_midx_entry(the_repository, oid, &e, m)) {
 			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (want != -1)
 				return want;
diff --git a/builtin/repack.c b/builtin/repack.c
index 9bbf032b6dd..5956df5d927 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -218,9 +218,9 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
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
index ddafe7f9b13..1e7fdcb90a8 100644
--- a/object-name.c
+++ b/object-name.c
@@ -198,16 +198,19 @@ static void unique_in_pack(struct packed_git *p,
 
 static void find_short_packed_object(struct disambiguate_state *ds)
 {
-	struct multi_pack_index *m;
 	struct packed_git *p;
 
 	/* Skip, unless oids from the storage hash algorithm are wanted */
 	if (ds->bin_pfx.algo && (&hash_algos[ds->bin_pfx.algo] != ds->repo->hash_algo))
 		return;
 
-	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
-	     m = m->next)
-		unique_in_midx(m, ds);
+	odb_prepare_alternates(ds->repo->objects);
+	for (struct odb_source *source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
+		struct multi_pack_index *m = get_multi_pack_index(source);
+		if (m)
+			unique_in_midx(m, ds);
+	}
+
 	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
@@ -792,11 +795,15 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 
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
index 0a4af199c05..7b51d381837 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -692,14 +692,16 @@ static int open_midx_bitmap(struct repository *r,
 			    struct bitmap_index *bitmap_git)
 {
 	int ret = -1;
-	struct multi_pack_index *midx;
 
 	assert(!bitmap_git->map);
 
-	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
-		if (!open_midx_bitmap_1(bitmap_git, midx))
+	odb_prepare_alternates(r->objects);
+	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
+		struct multi_pack_index *midx = get_multi_pack_index(source);
+		if (midx && !open_midx_bitmap_1(bitmap_git, midx))
 			ret = 0;
 	}
+
 	return ret;
 }
 
@@ -3307,9 +3309,15 @@ int verify_bitmap_files(struct repository *r)
 {
 	int res = 0;
 
-	for (struct multi_pack_index *m = get_multi_pack_index(r);
-	     m; m = m->next) {
-		char *midx_bitmap_name = midx_bitmap_filename(m);
+	odb_prepare_alternates(r->objects);
+	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
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
index e5d9d7ac8bc..e1ced050451 100644
--- a/packfile.c
+++ b/packfile.c
@@ -963,14 +963,17 @@ static void prepare_packed_git(struct repository *r);
 unsigned long repo_approximate_object_count(struct repository *r)
 {
 	if (!r->objects->approximate_object_count_valid) {
-		unsigned long count;
-		struct multi_pack_index *m;
+		unsigned long count = 0;
 		struct packed_git *p;
 
 		prepare_packed_git(r);
-		count = 0;
-		for (m = get_multi_pack_index(r); m; m = m->next)
-			count += m->num_objects;
+
+		for (struct odb_source *source = r->objects->sources; source; source = source->next) {
+			struct multi_pack_index *m = get_multi_pack_index(source);
+			if (m)
+				count += m->num_objects;
+		}
+
 		for (p = r->objects->packed_git; p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
@@ -1074,21 +1077,10 @@ struct packed_git *get_packed_git(struct repository *r)
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
+	return source->multi_pack_index;
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
2.50.1.327.g047016eb4a.dirty

