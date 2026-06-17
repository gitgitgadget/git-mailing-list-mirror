Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0CE3B14C5
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678402; cv=none; b=hpD5NCt/03HGAnwExbP6o60Y+6Kb+ZJfEzxTFVmb0i9OfMeVIrX7Z8bjaA/fd9uYsXZXRfpR0f+jznfKY48QSjhrAiHB9tIohZTrvrd2R6mGagUi5yAzPrmLYCfxRmvEGc68ZjtH/maJbhYtt34q9zdse9Mdzh2eQjehVwJqcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678402; c=relaxed/simple;
	bh=oogFYFfMKMUKmn0locVk76hGJUXMc86OMTErmt5umyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KkS/IM7OgHIqqFQuZpEN450I0QoJDm9oUe6+Wj9hrxOW9atRl5CMPQX01mHogiXPIeclDTKUfzPl72lbK719kZSyZ1al8+lPthyzv6Hr4HrIAbAhty/ZOjiVUkSDtFWy5p/eASzhsi6H2svdYTorhWJ2uKcjto1CVuHw+x3FK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QT5+HGt0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GzjGfqho; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QT5+HGt0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GzjGfqho"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03B9E7A00D0;
	Wed, 17 Jun 2026 02:39:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 17 Jun 2026 02:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678399;
	 x=1781764799; bh=b+ax/AWPVZh9IIqXgNFD849lC0EIOvVgBxuBPX0ROh4=; b=
	QT5+HGt0iZp3WDwPrE/QeX838PsLUNleG6QYocFHxIodolFDx5RCZtHk5W5yd0oX
	DB+Tc2TyIsT8jvOkyi6pDrNtekWWit72IUZItfOsgA8zvqHMwJQQcu5UTgAsZxzE
	nqFWhlIctO5wBpkhELSL9/uhDw2hiqu5vG4JipmT+7J0829yRg9uCoiMyydl7uTy
	QdhKCntuGQbQx4YtzPHeJ+gM1cETAZkhEuSFCQGgMxaHHhZIMdH6teD/5kZIFBv/
	cu/hLhh/ITmJAMiBVV54H3nj8v9LEZ9BUe2W7i7dbVrrLkEBNDJNHEtFV2e7cJdR
	rLg/Ljln10jWNtbFkwhe7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678399; x=
	1781764799; bh=b+ax/AWPVZh9IIqXgNFD849lC0EIOvVgBxuBPX0ROh4=; b=G
	zjGfqhoj8krNOxsYwyvTtH8oTC02pkUsNzBHEeBEmRyphDXLP4auua2pApXGLzm3
	Niy61TEijlJno6aIMsxBtfFcQ9AgYwc56z4dhtO4sV84f5bQq8EE53bPM+Wc4WwQ
	AMlLWm4JG2K3SN4tGOw1YdGXOnhmLDBBT5f2itIiaP0ZlKM4ZVW7CLB9h1WnmxzC
	imUVf/KKgBd5xW4+IPv0i8mgX2yHn165Qfvrbblpe+Rv5BDGp/AEWyJ+Uf1cN+Sq
	qKC6OrCdBEYH3C5bUf3Ca8jFdRB9P4YGEF40GQw0SLl8vBiAdn5tP3CU4l5vip+k
	E6xSE/t6UPLO0mksoqDGw==
X-ME-Sender: <xms:P0EyaqPzse4wDjl--qaKsOvQpoFVOj5Og4Y8vK_WMsPRpeN2P9Meig>
    <xme:P0EyagYmvygRa8HuLuzFBVJGvxEmfS0RhjlACRgXRXHl_ID_-cqDUNKiU7cf_m_z2
    EC7O16m_E8uz3sEtWApf_Acimv9UClRIU0ThFoLMvUW75YT7nuF>
X-ME-Received: <xmr:P0EyauqckotAVDCbVjMII3I2DyOO283XGBfjwPLzWQJbxr-hY-Y5Q_R_Q-DWVkDQZvdUqkVu32L_LBMjd5VmFzofngkk_1IAvySvM8k>
X-ME-Proxy-Cause: dmFkZTEnB39eLvyMgsk+d1zBATJAS2Dd09yZUP4TCe4zWysBccoWgY8Y+enBv1+9aJfPT8
    oVvaCC5MWGV30uZzKswgiCAK2gGSGYELp/F+QCNhRNY/bQx6x+ywijOIUW8TKDwAx48Lcx
    KhLHoOJu9m1Ux2Kfz7iOtjqmT/hnPJJkdtWT0xsGgHMCb1yqiVx9G0A93DDw8nseLTKulF
    USUks9qtFi47cv66z4EPIfMktSNXs9lIOpQJ4JZJ8Sqt4LT7yml6xL5bA1DQ7F1XoINCS5
    8+0eJLKjW+BUl0nBlxv0Wa8T6T4Bg1YQKal6uMYv+KeVZbCqw870pv0xnOpn9ZF3vGEMGC
    0Vd9EP83UcAeP6PVvNdKYBOEGOe08M8tSyPWesOkIFWk2cjl3dRU5Mss3abn3It6ZJV9RH
    Txi/5+EcMwxkcLKLfxVGQaae168j14mh/OndTBPVr+GRU24uxsyYOZ0B8FRbdQwN3Vd+iM
    H30BP+8u5jdbomCRtPKt9gvetSU1XJWb79yBICKLGt+DLYG79rKO62YvMR9f5kgROVN373
    j4QTNQqGZKtddfIw0t7KmfUOmpX8j9cPTIvJg9M46cJz3r/aMS1eE2aS1u9dgztGuLSxef
    ZxvTp5ajgmpQSUdyoIZ4cBZtle7o//zUmhMdDk364ASxdpMmCxRIgPPLQEqw
X-ME-Proxy: <xmx:P0EyakaP6aJp2lwYFDJbAglOwlmrjNl7LJPrcbuWdKDM4ws8KX3RNg>
    <xmx:P0EyamRgFGfRnHR_HKjCoEwpSkcE3n39L3Xd25EGbWGVey1hsMh0Og>
    <xmx:P0Eyar5jCNHiwebnFEfeMjrY1npsmDLVFDPWfTMmMHt3J-QuWypDHw>
    <xmx:P0Eyarw1Kq8J_XoUHkmRc4t3y5NpY401SGZFsq5uPXgN_ne3M4KHiA>
    <xmx:P0Eyaq1uA4QdER9Cty1iKdJsoquhwAW0EThjQ7xUuPkDyX4Kg6lydFHB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:39:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5a93917 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:39:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:44 +0200
Subject: [PATCH v3 01/17] packfile: rename `struct packfile_store` to
 `odb_source_packed`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-1-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
2.55.0.rc0.786.g65d90a0328.dirty

