Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809FF472F82
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141876; cv=none; b=D89darTsCBMU1Dl4iq8kcuiyS1W+uau2Xa4xMcvLtXjerb9K818r8LQ009ZQan6SqOGBg7ygXH5Ckwaw+CzJ/rm3ptstIQ3ourITwm+ZL7GXX2F4DrLZ5s6MJQxOsQg4xfRP5g9B45jRee/g3wwueLU0gZla095bDZ3p3G+1dIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141876; c=relaxed/simple;
	bh=uQAPNB7ZhRJi+kwMvJPaXwWLNb33SsaGI8qWfTE2PHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTL4hRUgqvJZYNZ+RNLcf52FI5l9Gk3LFGFQ+BTzkhPbKZ0JbKASdRvtEJiM99dvFo5H1hZ1ZIMsi+L/XriTTaQkQDG6fZQkWjj+cLReipvtq9gv9qOl/ScJgCfCCE2df+6Jr1QrD+zR9c0Ls2R8SxpXYKJh6RetHoxzd6e9Zoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OO77PEWj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WgLb8UVD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OO77PEWj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgLb8UVD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9379014001B2;
	Wed, 19 Aug 2026 08:17:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 19 Aug 2026 08:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787141873;
	 x=1787228273; bh=G94gyOFNztk1IlJjNKRQul7sSIHZgspj780YAxls3Qo=; b=
	OO77PEWjET0BDWiQIRNDz+NXntSVzGIxQfe+YSlbFjqYUp0JDCVcpTiMrYClrxFi
	mcJMjBeuEldJABVkkT/obD32xqEh158MWOEm8qSwax5HPGh5xVRXYj05S3p19aeu
	wFbXkum+MuoA0WHsH5VaDpBkjZmslxUbSHcW99RqCS+EReFn7VtIgad+ZHlnK/kS
	9TvabPHlw9xzLgf9zp+qNDsigX8l+acJ5zE4IIC1YI+aKKtWItepfHpwaEKrj26P
	5U5SrZU5I/0oEl1d+XoX6iotIbM3JK6zQh0IEkSL2rYzc5Aq1lukQD3Gz5a26Lm0
	N6BVDyM5IS13UKMUQmua0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787141873; x=
	1787228273; bh=G94gyOFNztk1IlJjNKRQul7sSIHZgspj780YAxls3Qo=; b=W
	gLb8UVDpAU34YoE23583jAK2oF8357H3f3NaE+V7N5ziiRBSMg9+Gxv+42J+U4KZ
	Nrq0RWU10MiibwopTe9xGEkkBmkcMg7wstU99N8KiCV7o5kMPDQkkVh75QWDPsQx
	gDx20hIpFVza19fsPUdk8Og0BH6MIlSHMMHyJ9g6bFYDTqCmzI3KBcm19TWGtCUy
	VmvSnQG6DjQsp/s4NL+urEOzT9S03k7i92/Mgr18FWKnaj8oIrNAzcKa02+/1Fki
	XU13vfGjJ88kVJa8LMt+Co75HoU5XN3ci1P1FV30Pf1qEzNYiVnvTVbld3Apo4VV
	KXv0iUmUv6I467S2gnv0g==
X-ME-Sender: <xms:8Z6Fau_wbdvvJ5SiqQNra6jk8mL3GxGTFkQ8vpFKomB9PwcnUmV_og>
    <xme:8Z6FakvvLWtE1p2czomUjD6va4MRODgYnO74_1Mr6VY_4Ob4Uf2DQebWWycU_qK0W
    qqStoR6B4dMuHW2uH37Ur2POXenoOj9J3Z14niJq_tqUWOsI7oLvg>
X-ME-Received: <xmr:8Z6Faho7-b5u7yvSMW70OYk5S8XfMeA7XtdnBVDAmBkQAmimAd_qeKLzp1x-dPAJ_PmFbhr798eTpy5GsbNZHRqW1rwQezhsx74AF7cU>
X-ME-Proxy-Cause: dmFkZTFt3KbsDQuBL7cFlReuI8sAuUXG1gDaCOmZir1zJuMHZiy99MhcYTSDjVTcjs4k+p
    OaeHKDAf4waq9z0KwfVNDjXq7SKVCHbtyhY6URXzzz/mbkLU5md4FwNSnpyeGLl3T/xaRC
    0TwIzFL+o6vUmA0j/iq01Wg+CMdFzetPi85mwEGxYmtyHy3Xp9U5TSxv+g839sV4gNCXEf
    Pv5k5EGXDNHpMTHb121ZZB7K2Cw89g2MkQgzvQL0RpvUH6WI4MzrO1mGvHHyVhnbWt2bnl
    SekELlC8gVrP5RVFYrzxJXeUMXnPspPKcWdKAxT/6PHFmFlkOcBLKXnyjO75NLnPc8gCnQ
    7RnjUOB4iU3AUQPKYmRvojr4njJU+/IOu27AoqMMyK+QeATb5HpqWKb6pEHudWPtM4aF78
    Zgtl/USuL332nuWIA23gl4/W1iSf69QiV1bBmw/v0y6ykkLn6NmFTGa5Ro6wXFGuvpO1oQ
    MYPq7Skc5iVzpQ80ckT8y/nct8Jx7ULmtRNoRGDA9bB3uVzTpl3MZ7W71r59X7MDedIWN7
    Zt2lmaQDzcH9B2MCzytSLZoa5AJZMCRGq5JXqtlkAFmDRd8GG1lN2tTJ5tDIO1A3Eb1m9p
    Y1WRlkvxVQXv1TudB0c0hXutUMDz/GlEn2OdtIXRlIdfEKvQz1qEjop/uGBA
X-ME-Proxy: <xmx:8Z6FahnPCWs5VIIjqyLBveAmXagBjVZPYzcXACCXF6tXAtI93G6-pw>
    <xmx:8Z6FalwhEOZaycInZjjPpubFX8bD1xva25XSyyQDYUDhl3AkADtwTg>
    <xmx:8Z6FapnHPpl_nENezLe6GXzvTjDOTirwo0DLlxPVfS1_xNAP1sqOhg>
    <xmx:8Z6FauckrzEDPgyFXP-jpBMOinZ8QWjduZA3NhtkcOmMi73BVhvUug>
    <xmx:8Z6FaqUi0XJ4SjwfqQFoyTyaxcZuFqM_2rci9g67jRY1rlq8VQPO9AJC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 08:17:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f4d9fbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 12:17:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Aug 2026 14:17:20 +0200
Subject: [PATCH v2 2/5] odb/source: introduce error status when reading
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-pks-odb-generic-corrupt-objects-v2-2-a984e3a0ad6f@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
In-Reply-To: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The `read_object_info()` callback of `struct odb_source` is documented
to return a negative error code in case reading the object has failed,
and zero otherwise. This is overly broad though, as there are two very
different kinds of failures:

  - The object may not exist in the source at all.

  - The object exists, but reading it has failed, for example because
    its on-disk state is corrupt.

This distinction matters to callers: when an object is corrupt in one
source we may still find a good copy of it in another source, so we may
still be able to proceed with a given operation.

The "packed" source already distinguishes these cases by returning a
positive value for missing objects and a negative value in case reading
the object has failed. But it is the only such source that distinguishes
those cases, and the returned value is translated into a negative error
code by the "files" backend anyway.

Introduce a new error status that is specific to reading objects and
adapt the infrastructure to return it. For now, we only discern
successful reads from generic failures, which mostly matches the status
quo. In subsequent commits though we're about to add an error that
explicitly tells the caller that an object does not exist.

Note that we keep the "packed" backend as-is with its positive return
code for missing objects. This will be fixed in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 | 16 ++++++++--------
 odb.h                 | 15 +++++++++++----
 odb/source-files.c    |  8 ++++----
 odb/source-inmemory.c |  8 ++++----
 odb/source-loose.c    |  8 ++++----
 odb/source-packed.c   |  8 ++++----
 odb/source.h          | 22 +++++++++++-----------
 7 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/odb.c b/odb.c
index caf1d0f542..1b37b26376 100644
--- a/odb.c
+++ b/odb.c
@@ -547,9 +547,9 @@ static int register_all_submodule_sources(struct object_database *odb)
 	return ret;
 }
 
-static int do_oid_object_info_extended(struct object_database *odb,
-				       const struct object_id *oid,
-				       struct object_info *oi, unsigned flags)
+static enum odb_read_status do_oid_object_info_extended(struct object_database *odb,
+							const struct object_id *oid,
+							struct object_info *oi, unsigned flags)
 {
 	const struct object_id *real = oid;
 	int already_retried = 0;
@@ -696,12 +696,12 @@ static int oid_object_info_convert(struct repository *r,
 	return ret;
 }
 
-int odb_read_object_info_extended(struct object_database *odb,
-				  const struct object_id *oid,
-				  struct object_info *oi,
-				  enum object_info_flags flags)
+enum odb_read_status odb_read_object_info_extended(struct object_database *odb,
+						   const struct object_id *oid,
+						   struct object_info *oi,
+						   enum object_info_flags flags)
 {
-	int ret;
+	enum odb_read_status ret;
 
 	if (oid->algo && (hash_algo_by_ptr(odb->repo->hash_algo) != oid->algo))
 		return oid_object_info_convert(odb->repo, oid, oi, flags);
diff --git a/odb.h b/odb.h
index fca67e8253..43cbcc3aba 100644
--- a/odb.h
+++ b/odb.h
@@ -435,14 +435,21 @@ enum object_info_flags {
 	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
 };
 
+enum odb_read_status {
+	/* The read was successful. */
+	ODB_READ_OK = 0,
+	/* The read resulted in a generic error. */
+	ODB_READ_ERROR = -1,
+};
+
 /*
  * Read object info from the object database and populate the `object_info`
  * structure. Returns 0 on success, a negative error code otherwise.
  */
-int odb_read_object_info_extended(struct object_database *odb,
-				  const struct object_id *oid,
-				  struct object_info *oi,
-				  enum object_info_flags flags);
+enum odb_read_status odb_read_object_info_extended(struct object_database *odb,
+						   const struct object_id *oid,
+						   struct object_info *oi,
+						   enum object_info_flags flags);
 
 /*
  * Read a subset of object info for the given object ID. Returns an `enum
diff --git a/odb/source-files.c b/odb/source-files.c
index 5a68af7d84..a28aa5042d 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -59,10 +59,10 @@ static void odb_source_files_prepare(struct odb_source *source,
 	odb_source_prepare(&files->packed->base, flags);
 }
 
-static int odb_source_files_read_object_info(struct odb_source *source,
-					     const struct object_id *oid,
-					     struct object_info *oi,
-					     enum object_info_flags flags)
+static enum odb_read_status odb_source_files_read_object_info(struct odb_source *source,
+							      const struct object_id *oid,
+							      struct object_info *oi,
+							      enum object_info_flags flags)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 3e71611b8e..53d2e3a852 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -56,10 +56,10 @@ static void populate_object_info(struct odb_source_inmemory *source,
 		oi->source_infop->source = &source->base;
 }
 
-static int odb_source_inmemory_read_object_info(struct odb_source *source,
-						const struct object_id *oid,
-						struct object_info *oi,
-						enum object_info_flags flags UNUSED)
+static enum odb_read_status odb_source_inmemory_read_object_info(struct odb_source *source,
+								 const struct object_id *oid,
+								 struct object_info *oi,
+								 enum object_info_flags flags UNUSED)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
 	const struct inmemory_object *object;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index ef0e919277..ad8662842d 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -206,10 +206,10 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 	return ret;
 }
 
-static int odb_source_loose_read_object_info(struct odb_source *source,
-					     const struct object_id *oid,
-					     struct object_info *oi,
-					     enum object_info_flags flags)
+static enum odb_read_status odb_source_loose_read_object_info(struct odb_source *source,
+							      const struct object_id *oid,
+							      struct object_info *oi,
+							      enum object_info_flags flags)
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
 	static struct strbuf buf = STRBUF_INIT;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 16fa4f5769..dce68a57f7 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -35,10 +35,10 @@ static int find_pack_entry(struct odb_source_packed *store,
 	return 0;
 }
 
-static int odb_source_packed_read_object_info(struct odb_source *source,
-					      const struct object_id *oid,
-					      struct object_info *oi,
-					      enum object_info_flags flags)
+static enum odb_read_status odb_source_packed_read_object_info(struct odb_source *source,
+							       const struct object_id *oid,
+							       struct object_info *oi,
+							       enum object_info_flags flags)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
 	struct packed_git *bad_pack = NULL;
diff --git a/odb/source.h b/odb/source.h
index d69f8e2d1c..7b8ff3d19d 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -110,13 +110,13 @@ struct odb_source {
 	 *     second read in case they know that the first read would have
 	 *     already surfaced the object without reloading any on-disk state.
 	 *
-	 * The callback is expected to return a negative error code in case
-	 * reading the object has failed, 0 otherwise.
+	 * The callback is expected to return an `enum odb_read_status`. Please
+	 * refer to the individual values that can be returned.
 	 */
-	int (*read_object_info)(struct odb_source *source,
-				const struct object_id *oid,
-				struct object_info *oi,
-				enum object_info_flags flags);
+	enum odb_read_status (*read_object_info)(struct odb_source *source,
+						 const struct object_id *oid,
+						 struct object_info *oi,
+						 enum object_info_flags flags);
 
 	/*
 	 * This callback is expected to create a new read stream that can be
@@ -340,12 +340,12 @@ static inline void odb_source_prepare(struct odb_source *source,
 
 /*
  * Read an object from the object database source identified by its object ID.
- * Returns 0 on success, a negative error code otherwise.
+ * Please refer to `enum odb_read_status` for the individual error codes.
  */
-static inline int odb_source_read_object_info(struct odb_source *source,
-					      const struct object_id *oid,
-					      struct object_info *oi,
-					      enum object_info_flags flags)
+static inline enum odb_read_status odb_source_read_object_info(struct odb_source *source,
+							       const struct object_id *oid,
+							       struct object_info *oi,
+							       enum object_info_flags flags)
 {
 	return source->read_object_info(source, oid, oi, flags);
 }

-- 
2.55.0.822.g20453c30eb.dirty

