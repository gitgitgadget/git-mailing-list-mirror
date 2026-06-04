Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617433D6CB1
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572345; cv=none; b=YrIkTezMSc8rFDi9FhIS74j6C5JLdMbcypQB26b4RM6t/zAkaoNKyO7kQ5WoctSY+Goi25NOFrbcj0lXQdMeEA8Jd/IlpHfB3nnpKej+Mk/Bi/b7X9EX8b5snP0A0azi67SA+7/17efYagpfut/K7dwMPGNpowWK2VqoEUba9TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572345; c=relaxed/simple;
	bh=7csg79iI+R/FoeliuG477kbtvuDjGUTRUBOPEwstCuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDjewqYkf7pKgL7Vaq206712g2p/g24tZIG1J1VG6Geszmt0U09cB5BCfIGLuFXLNkO8y9RsngHfnP4SuZtx+EauSjPhhBjuW019J5KXsT8xw4qH582uCSluhTA8yFzzOdo5RuwaPKb1w/GRfq1ZV8+7/b4EWo2k3yzThy5sKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZR58Bp7B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M7bZGYkr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZR58Bp7B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M7bZGYkr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A7C13EC00CE
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:25:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Jun 2026 07:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572342;
	 x=1780658742; bh=I7IFRgb7EG5KUsSH9FzdDu5A9lq1iUiMH1W1lWNlkR0=; b=
	ZR58Bp7BhRg1bn294DrIF8bGWwxSsnQShWDmnEQF2i/SSz+WpfmxW1bUkFYZm7C9
	x3Ck6tjPcUz/zsN5Tah4gw3ySlShHcOvJ6VbLPejTnPahipPdEwz19b0tXgJlehR
	vYbRHuWeNw3Bn0WgBQzoVuIKkhRYoPWN/Uk4xIm7f3Q+sp3t0WTChuWlqKxyO4jP
	R6BrfjHdR2YHbtorOG2o2CvIWbgef4deEShC6xFc0xBvM7xkjbD1MnHxRIA+X5cx
	1FCyQgJk8reRAg3b8CJiWINT2zHp6aWWPx/AWwnp1bTEaOMOQW2NDVuqiyyvTMYQ
	drdSOpW9bkE4zZdnuNLFJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572342; x=
	1780658742; bh=I7IFRgb7EG5KUsSH9FzdDu5A9lq1iUiMH1W1lWNlkR0=; b=M
	7bZGYkrPrCRUdXoDxHuG3gEJo0xQ5yUiXfyG242Wzox9LYCjMXExg7GgDlGlIFfk
	a/fWUYGyceSRuZjDsp2QTn79awo25I0WrtVYtJkLniv81vlHj0gurCTSic6DNuG/
	3PIM9UvGpgDlNBXTh5v7JkAnP+jjYnzMuivgnUlTfhBkv/nPkO/XSqqNrIXgW4ne
	YZNOarxJG4KJJhUDlmk2p1g/T09XzRiuROZY38Zd1oEVUvhSqxAClCk77UCHdSD7
	KLJzSUHHZ/8/SNquZmNjtpDL4/r0rfsxtH1BJdUCzWSM0tSeg6QlEw84kNkkH9uY
	10wpEUw3PP9wU4GINFjGw==
X-ME-Sender: <xms:tmAhalCEia63OWIHZuDia981_XnRgV6NJ2b1Yw7BhlXlA3dXHxfFrA>
    <xme:tmAhaqdKzd3gYLNJgKZfO30nw8msguH_PaozjbcP3j-_aqXNRD8r5Y2_UALFlF8GV
    qT77GZpzgcft3-3j096YgImeDpk0Vur0P-5fGG7tEnK3QB_vW8YJkY>
X-ME-Received: <xmr:tmAhamM-kQFyETsOfUUoATK6UUE5FWr-fN-tVT3Kg4LFElffnUzRXuJa1ScsSxCYspy0a0_fwwniP36XWTD4jcaD2CygW21tsaPoiXgulto>
X-ME-Proxy-Cause: dmFkZTG1ZbTSTCt+QGOBx/ozxIEQhARBqr0/SlqS3JC3+zb5glHSVG1aoMYIj9aqeIu0zy
    sFSu/10DzZ9FxuAnUcFX6wAMbP9bcQrm5ozYikXKxnDFDplVWXkO3AcE+a89ybngC3lrIz
    /GVY5rm27PVrHphkJl/OHdHOPrCII5MKB9fWDnt3CbmEK2TBDSFR2xtzwFeqzHWM4uomo5
    7XY5VmmSTadEWmtllR1d1OawV3IdNUcjNTdgTRjA6Zegw5qOpq6fI/Dca+wbibUmVoNStb
    renMzkGmdPq7kqvux3p6g6SuTVtljNZSpQco4BML6yeKWNkQha+6iZyZlP37J3M3wliocm
    ZjJ7UmFm1bulNLyHM8aXPDuEc7U6C4Fb7UfwR+k62k6sR+syTG1nH8b+8QnOvx4N1xOzRX
    kvNiEmyq4HupfDJNdEjRrBetWM54rwegFVD/pi0Sc9cxDTK1pS9mhJ5zrDOX/n/nh8KsxC
    +k7Ri3pv3Kd5ISAN6I0RwdnNCp17cgvoIZNP/2Ukk1oivmDrHAHv6oHYBe2Y2LU64YpjoL
    SIQH8CsJOQ+fJbtrqGX3OjWE9Xw3Qp3FmACId82FruWBFndQFC98NcsFeKjLXU8A9lh6Kf
    O6fhIDaqocdI7VZkFBc6GkvxtRwUDPV+QF2tjTpGstKND3p3fDvrzuEdE1VQ
X-ME-Proxy: <xmx:tmAhak4Dnu5GzYJQxK_73WCFKaK1kkZBhfDKNgsX2YvpVUOnOLD3Zg>
    <xmx:tmAhaqJxTOEch4njDFj68oCYrYazIRX1o_MuaYxiAWHzn2YmKTbzmQ>
    <xmx:tmAhaufappoNE68rHuv9qkyOlRpJiXrSJWXVM0zRhy2R8eZxErKwYA>
    <xmx:tmAhatfHqe-Iuq2MQn3WBbrvNP1hFo9VM6pWsbKlDYrJDeFHui3n_Q>
    <xmx:tmAhakDCcfOTw8S7TZwp4lHFjbSS4TEfT2YQuVEfhhuTELXTdeu0CuWL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:25:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cbcf63b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:25:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:28 +0200
Subject: [PATCH 01/16] packfile: rename `struct packfile_store` to
 `odb_source_packed`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-1-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Not too long ago, we have introduced the packfile store in b7983adb51
(packfile: introduce a new `struct packfile_store`, 2025-09-23). This
struct is responsible for managing all of our access to packfiles and is
used as one of the two sources of objects for the "files" source.

Back when I introduced this structure I didn't have the clear vision yet
that it will eventually also turn into a proper object database source,
and how exactly that infrastructure will look like. Now though it's
becoming increasingly clear that it does make sense to treat it just the
same as any of our other ODB sources.

The consequence is that the naming is now a bit out-of-date: it's just
another source and will be turned into a proper `struct odb_source` over
the next couple of commits, but it's not named accordingly.

Rename the structure to `odb_source_packed` to align it with this goal
and to bring it in line with the other sources we already have.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.h |  4 ++--
 packfile.c         | 56 +++++++++++++++++++++++++++---------------------------
 packfile.h         | 32 +++++++++++++++----------------
 3 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/odb/source-files.h b/odb/source-files.h
index 23a3b4e04b..d7ac3c1c81 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -4,7 +4,7 @@
 #include "odb/source.h"
 
 struct odb_source_loose;
-struct packfile_store;
+struct odb_source_packed;
 
 /*
  * The files object database source uses a combination of loose objects and
@@ -13,7 +13,7 @@ struct packfile_store;
 struct odb_source_files {
 	struct odb_source base;
 	struct odb_source_loose *loose;
-	struct packfile_store *packed;
+	struct odb_source_packed *packed;
 };
 
 /* Allocate and initialize a new object source. */
diff --git a/packfile.c b/packfile.c
index 89366abfe3..a2d768d0ae 100644
--- a/packfile.c
+++ b/packfile.c
@@ -859,7 +859,7 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	return p;
 }
 
-void packfile_store_add_pack(struct packfile_store *store,
+void packfile_store_add_pack(struct odb_source_packed *store,
 			     struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
@@ -869,7 +869,7 @@ void packfile_store_add_pack(struct packfile_store *store,
 	strmap_put(&store->packs_by_path, pack->pack_name, pack);
 }
 
-struct packed_git *packfile_store_load_pack(struct packfile_store *store,
+struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 					    const char *idx_path, int local)
 {
 	struct strbuf key = STRBUF_INIT;
@@ -1068,7 +1068,7 @@ static int sort_pack(const struct packfile_list_entry *a,
 	return -1;
 }
 
-void packfile_store_prepare(struct packfile_store *store)
+void packfile_store_prepare(struct odb_source_packed *store)
 {
 	if (store->initialized)
 		return;
@@ -1084,13 +1084,13 @@ void packfile_store_prepare(struct packfile_store *store)
 	store->initialized = true;
 }
 
-void packfile_store_reprepare(struct packfile_store *store)
+void packfile_store_reprepare(struct odb_source_packed *store)
 {
 	store->initialized = false;
 	packfile_store_prepare(store);
 }
 
-struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *store)
+struct packfile_list_entry *packfile_store_get_packs(struct odb_source_packed *store)
 {
 	packfile_store_prepare(store);
 
@@ -1103,7 +1103,7 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 	return store->packs.head;
 }
 
-int packfile_store_count_objects(struct packfile_store *store,
+int packfile_store_count_objects(struct odb_source_packed *store,
 				 enum odb_count_objects_flags flags UNUSED,
 				 unsigned long *out)
 {
@@ -2160,7 +2160,7 @@ static int fill_pack_entry(const struct object_id *oid,
 	return 1;
 }
 
-static int find_pack_entry(struct packfile_store *store,
+static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
 			   struct pack_entry *e)
 {
@@ -2183,7 +2183,7 @@ static int find_pack_entry(struct packfile_store *store,
 	return 0;
 }
 
-int packfile_store_freshen_object(struct packfile_store *store,
+int packfile_store_freshen_object(struct odb_source_packed *store,
 				  const struct object_id *oid)
 {
 	struct pack_entry e;
@@ -2199,7 +2199,7 @@ int packfile_store_freshen_object(struct packfile_store *store,
 	return 1;
 }
 
-int packfile_store_read_object_info(struct packfile_store *store,
+int packfile_store_read_object_info(struct odb_source_packed *store,
 				    const struct object_id *oid,
 				    struct object_info *oi,
 				    enum object_info_flags flags)
@@ -2234,7 +2234,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	return 0;
 }
 
-static void maybe_invalidate_kept_pack_cache(struct packfile_store *store,
+static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
 					     unsigned flags)
 {
 	if (!store->kept_cache.packs)
@@ -2245,7 +2245,7 @@ static void maybe_invalidate_kept_pack_cache(struct packfile_store *store,
 	store->kept_cache.flags = 0;
 }
 
-struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *store,
+struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed *store,
 						       unsigned flags)
 {
 	maybe_invalidate_kept_pack_cache(store, flags);
@@ -2365,8 +2365,8 @@ int for_each_object_in_pack(struct packed_git *p,
 	return r;
 }
 
-struct packfile_store_for_each_object_wrapper_data {
-	struct packfile_store *store;
+struct odb_source_packed_for_each_object_wrapper_data {
+	struct odb_source_packed *store;
 	const struct object_info *request;
 	odb_for_each_object_cb cb;
 	void *cb_data;
@@ -2377,7 +2377,7 @@ static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
 						  uint32_t index_pos,
 						  void *cb_data)
 {
-	struct packfile_store_for_each_object_wrapper_data *data = cb_data;
+	struct odb_source_packed_for_each_object_wrapper_data *data = cb_data;
 
 	if (data->request) {
 		off_t offset = nth_packed_object_offset(pack, index_pos);
@@ -2411,10 +2411,10 @@ static int match_hash(unsigned len, const unsigned char *a, const unsigned char
 }
 
 static int for_each_prefixed_object_in_midx(
-	struct packfile_store *store,
+	struct odb_source_packed *store,
 	struct multi_pack_index *m,
 	const struct odb_for_each_object_options *opts,
-	struct packfile_store_for_each_object_wrapper_data *data)
+	struct odb_source_packed_for_each_object_wrapper_data *data)
 {
 	int ret;
 
@@ -2470,10 +2470,10 @@ static int for_each_prefixed_object_in_midx(
 }
 
 static int for_each_prefixed_object_in_pack(
-	struct packfile_store *store,
+	struct odb_source_packed *store,
 	struct packed_git *p,
 	const struct odb_for_each_object_options *opts,
-	struct packfile_store_for_each_object_wrapper_data *data)
+	struct odb_source_packed_for_each_object_wrapper_data *data)
 {
 	uint32_t num, i, first = 0;
 	int len = opts->prefix_hex_len > p->repo->hash_algo->hexsz ?
@@ -2519,9 +2519,9 @@ static int for_each_prefixed_object_in_pack(
 }
 
 static int packfile_store_for_each_prefixed_object(
-	struct packfile_store *store,
+	struct odb_source_packed *store,
 	const struct odb_for_each_object_options *opts,
-	struct packfile_store_for_each_object_wrapper_data *data)
+	struct odb_source_packed_for_each_object_wrapper_data *data)
 {
 	struct packfile_list_entry *e;
 	struct multi_pack_index *m;
@@ -2566,13 +2566,13 @@ static int packfile_store_for_each_prefixed_object(
 	return ret;
 }
 
-int packfile_store_for_each_object(struct packfile_store *store,
+int packfile_store_for_each_object(struct odb_source_packed *store,
 				   const struct object_info *request,
 				   odb_for_each_object_cb cb,
 				   void *cb_data,
 				   const struct odb_for_each_object_options *opts)
 {
-	struct packfile_store_for_each_object_wrapper_data data = {
+	struct odb_source_packed_for_each_object_wrapper_data data = {
 		.store = store,
 		.request = request,
 		.cb = cb,
@@ -2707,7 +2707,7 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	*out = len;
 }
 
-int packfile_store_find_abbrev_len(struct packfile_store *store,
+int packfile_store_find_abbrev_len(struct odb_source_packed *store,
 				   const struct object_id *oid,
 				   unsigned min_len,
 				   unsigned *out)
@@ -2832,16 +2832,16 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-struct packfile_store *packfile_store_new(struct odb_source *source)
+struct odb_source_packed *packfile_store_new(struct odb_source *source)
 {
-	struct packfile_store *store;
+	struct odb_source_packed *store;
 	CALLOC_ARRAY(store, 1);
 	store->source = source;
 	strmap_init(&store->packs_by_path);
 	return store;
 }
 
-void packfile_store_free(struct packfile_store *store)
+void packfile_store_free(struct odb_source_packed *store)
 {
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
 		free(e->pack);
@@ -2851,7 +2851,7 @@ void packfile_store_free(struct packfile_store *store)
 	free(store);
 }
 
-void packfile_store_close(struct packfile_store *store)
+void packfile_store_close(struct odb_source_packed *store)
 {
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next) {
 		if (e->pack->do_not_close)
@@ -2988,7 +2988,7 @@ int packfile_read_object_stream(struct odb_read_stream **out,
 }
 
 int packfile_store_read_object_stream(struct odb_read_stream **out,
-				      struct packfile_store *store,
+				      struct odb_source_packed *store,
 				      const struct object_id *oid)
 {
 	struct pack_entry e;
diff --git a/packfile.h b/packfile.h
index 49d6bdecf6..9cec15bc50 100644
--- a/packfile.h
+++ b/packfile.h
@@ -79,7 +79,7 @@ struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
 /*
  * A store that manages packfiles for a given object database.
  */
-struct packfile_store {
+struct odb_source_packed {
 	struct odb_source *source;
 
 	/*
@@ -138,19 +138,19 @@ struct packfile_store {
  * Allocate and initialize a new empty packfile store for the given object
  * database source.
  */
-struct packfile_store *packfile_store_new(struct odb_source *source);
+struct odb_source_packed *packfile_store_new(struct odb_source *source);
 
 /*
  * Free the packfile store and all its associated state. All packfiles
  * tracked by the store will be closed.
  */
-void packfile_store_free(struct packfile_store *store);
+void packfile_store_free(struct odb_source_packed *store);
 
 /*
  * Close all packfiles associated with this store. The packfiles won't be
  * free'd, so they can be re-opened at a later point in time.
  */
-void packfile_store_close(struct packfile_store *store);
+void packfile_store_close(struct odb_source_packed *store);
 
 /*
  * Prepare the packfile store by loading packfiles and multi-pack indices for
@@ -159,7 +159,7 @@ void packfile_store_close(struct packfile_store *store);
  * It shouldn't typically be necessary to call this function directly, as
  * functions that access the store know to prepare it.
  */
-void packfile_store_prepare(struct packfile_store *store);
+void packfile_store_prepare(struct odb_source_packed *store);
 
 /*
  * Clear the packfile caches and try to look up any new packfiles that have
@@ -167,20 +167,20 @@ void packfile_store_prepare(struct packfile_store *store);
  *
  * This function must be called under the `odb_read_lock()`.
  */
-void packfile_store_reprepare(struct packfile_store *store);
+void packfile_store_reprepare(struct odb_source_packed *store);
 
 /*
  * Add the pack to the store so that contained objects become accessible via
  * the store. This moves ownership into the store.
  */
-void packfile_store_add_pack(struct packfile_store *store,
+void packfile_store_add_pack(struct odb_source_packed *store,
 			     struct packed_git *pack);
 
 /*
  * Get all packs managed by the given store, including packfiles that are
  * referenced by multi-pack indices.
  */
-struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *store);
+struct packfile_list_entry *packfile_store_get_packs(struct odb_source_packed *store);
 
 struct repo_for_each_pack_data {
 	struct odb_source *source;
@@ -239,7 +239,7 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 	     repo_for_each_pack_data_next(&eack_pack_data))
 
 int packfile_store_read_object_stream(struct odb_read_stream **out,
-				      struct packfile_store *store,
+				      struct odb_source_packed *store,
 				      const struct object_id *oid);
 
 /*
@@ -248,7 +248,7 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
  * not found, 0 if it was and read successfully, and a negative error code in
  * case the object was corrupted.
  */
-int packfile_store_read_object_info(struct packfile_store *store,
+int packfile_store_read_object_info(struct odb_source_packed *store,
 				    const struct object_id *oid,
 				    struct object_info *oi,
 				    enum object_info_flags flags);
@@ -258,10 +258,10 @@ int packfile_store_read_object_info(struct packfile_store *store,
  * either the newly opened packfile or the preexisting packfile. Returns a
  * `NULL` pointer in case the packfile could not be opened.
  */
-struct packed_git *packfile_store_load_pack(struct packfile_store *store,
+struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 					    const char *idx_path, int local);
 
-int packfile_store_freshen_object(struct packfile_store *store,
+int packfile_store_freshen_object(struct odb_source_packed *store,
 				  const struct object_id *oid);
 
 enum kept_pack_type {
@@ -276,7 +276,7 @@ enum kept_pack_type {
  *
  * Return 0 on success, a negative error code otherwise.
  */
-int packfile_store_count_objects(struct packfile_store *store,
+int packfile_store_count_objects(struct odb_source_packed *store,
 				 enum odb_count_objects_flags flags,
 				 unsigned long *out);
 
@@ -285,7 +285,7 @@ int packfile_store_count_objects(struct packfile_store *store,
  * combination of `kept_pack_type` flags. The cache is computed on demand and
  * will be recomputed whenever the flags change.
  */
-struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *store,
+struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed *store,
 						       unsigned flags);
 
 struct pack_window {
@@ -365,13 +365,13 @@ int for_each_object_in_pack(struct packed_git *p,
  *
  * The flags parameter is a combination of `odb_for_each_object_flags`.
  */
-int packfile_store_for_each_object(struct packfile_store *store,
+int packfile_store_for_each_object(struct odb_source_packed *store,
 				   const struct object_info *request,
 				   odb_for_each_object_cb cb,
 				   void *cb_data,
 				   const struct odb_for_each_object_options *opts);
 
-int packfile_store_find_abbrev_len(struct packfile_store *store,
+int packfile_store_find_abbrev_len(struct odb_source_packed *store,
 				   const struct object_id *oid,
 				   unsigned min_len,
 				   unsigned *out);

-- 
2.54.0.1064.gd145956f57.dirty

