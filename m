Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED32BF3D7
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155750; cv=none; b=GhNs0TP7JrPR+UBZD/nAU+srLeexhk/MU+FOAb2HTP7HF4UiYIY05vl+NGs8Kx5TojO+fbWKgmFcT91Ve9n8LXAr0xCnisiZhI2FYCrJx+PRHSQUlpQX/by35O9rXVOKL0nnB+zSBkW3R01S1jsnQRyMsPr1udUlDu5qBqX0YCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155750; c=relaxed/simple;
	bh=q8UXdCaX0dc0sf4Jes3oBRSvW3xXrorc2Yfus4cxBJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hK22GxZ039B1g6TTla7mAJDiNP62ural9U521pkWhTIfSQo+4zetIQAQUzZuIM/PSmoLDY5KfrwxlZ0xoZ9+ylq1PMLCq1wAJCiI/6gulKn8lQvELTyLmoHCtO1TmHOOINBMI94VegwX98m30xLT8O9/RJ1mJt1s82X1usFKgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n9tQJnqS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WdDEi8Fp; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n9tQJnqS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WdDEi8Fp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2C2067A009B;
	Mon,  3 Nov 2025 02:42:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 02:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155748;
	 x=1762242148; bh=5UXyQgTvagZixwLzsBeIzqcBNtOQpuA29xXrTe/BHs0=; b=
	n9tQJnqS+Aob2IsmTjdOcxja+rMESKhldxjBGnjxM1jPNlhNWhvgb9w5ocPcpTlX
	bL47y1vei6YP5Z21I/LCsyOFfRi5sdVGyvJMEMpA9SdcnZJokCH17LMcb+wpjgvk
	G3oMGBXQ5eJ1WugMIYRhFKesgaNMZrF2hX44MmVsDrR5ZfQwqYvJY4mS8zPq9HQ4
	kIEEq8s5rwHC6CdvvEdHoP7o2f+hR10JlBn44TFE9hJ4B6AxpbHa5OkBTQdSA/jn
	JsNu5FcwtE6+orUTxXX+ZxixtuXkwiVK/bg9I3XHAmuaIbxmSQBHBF/GHqSLZCGO
	eBZ3R8faeIet6f0hHNsNFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155748; x=
	1762242148; bh=5UXyQgTvagZixwLzsBeIzqcBNtOQpuA29xXrTe/BHs0=; b=W
	dDEi8Fpmb+LJmdAtrk2x2pcMSRtaPYPNLYLDCfIo2UAbPEL8ungBniNw19gkFqY4
	2e1SEhbTkBk9wObBxnw5S7dltBFwoBstztjPKxku/ZZEWIBznvSBlAKjYo/sUgiU
	00Qu29cbgMFXMDyif47O3sJ0q6XNWbsUBfOKpMXQKtDYiu6eJDjhVmBApgbD+6z8
	i65s0boGVPgnIBka2lroyevQFwywYc1WoSYs/6NuuC5rLRj+FyammBc1JKmEfAgu
	cZx7R55NvX+VmVvs6ENkz18Nl2C/l1aJbbyEg49nhFop0R55hWoi1BDXGY6tVevU
	CW9MvIsS4Elvb2P5l2Myw==
X-ME-Sender: <xms:41wIaUBrNxRdiEE0XHZAN8Juvh433Kpxo9wa42kevFXwcZhLHHbJIQ>
    <xme:41wIad8hxnbpdA2vF-W9bsYCrjBRuWLMPdEIo48g0dV4vRE-jhNfjQqNoGAqTpAD2
    v_aYHV_11bMtBm3SLK72P12eC59irNz2Zef1IShZ3BibL7zCwo_bQ>
X-ME-Received: <xmr:41wIaU_O3GSWMeLCOhV2NTqMM-dJGag7RsFe_WpMNBnNZpF83gKEAFlOIWC-s1YgaSt4-b8NzfUBfaHx6kSyX1LeB3pt1TEi4scY_Btypuu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:41wIaUdV_e6HNgvvak7RefaBJ-NpuKnN7EzaOol0xjK4a0GgLM6qVQ>
    <xmx:41wIadGUUPYyAVuImT4u3824YRwJsg13kxrIx57CJvvsAg60TTlybQ>
    <xmx:41wIaSekQL_ryAa_MvyrpHzeN0UGRVcsFo8RQGf44ZZ6oHE7je-gLQ>
    <xmx:41wIaXH4xxWk7gQdJvGKQCFbHAH-5ugsA_AvbZNEo4pmGdGz-liPvQ>
    <xmx:5FwIad84_oWKoIyr9e15X6dfpNSDhBSjUdzhCdwoNE0Zs7JglZuRygnW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0d77880 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:42:01 +0100
Subject: [PATCH v3 06/13] object-file: move loose object cache into loose
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-6-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Our loose objects use a cache that (optionally) stores all objects for
each of the opened sharding directories. This cache is located in the
`struct odb_source`, but now that we have `struct odb_source_loose` it
makes sense to move it into the latter structure so that all state that
relates to loose objects is entirely self-contained.

Do so. While at it, rename corresponding functions to have a prefix that
relates to `struct odb_source_loose`.

Note that despite this prefix, the functions still accept a `struct
odb_source` as input. This is done intentionally: once we introduce
pluggable object databases, we will continue to accept this struct but
then do a cast inside these functions to `struct odb_source_loose`. This
design is similar to how we do it for our ref backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c       |  9 +++++----
 object-file.c | 35 +++++++++++++++++++----------------
 object-file.h | 16 ++++++++++++++--
 object-name.c |  2 +-
 odb.c         |  1 -
 odb.h         | 12 ------------
 6 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/loose.c b/loose.c
index e8ea6e7e24b..8cc7573ff2b 100644
--- a/loose.c
+++ b/loose.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "hash.h"
 #include "path.h"
+#include "object-file.h"
 #include "odb.h"
 #include "hex.h"
 #include "repository.h"
@@ -54,7 +55,7 @@ static int insert_loose_map(struct odb_source *source,
 	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
 	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
 	if (inserted)
-		oidtree_insert(source->loose_objects_cache, compat_oid);
+		oidtree_insert(source->loose->cache, compat_oid);
 
 	return inserted;
 }
@@ -66,9 +67,9 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source
 
 	if (!source->loose_map)
 		loose_object_map_init(&source->loose_map);
-	if (!source->loose_objects_cache) {
-		ALLOC_ARRAY(source->loose_objects_cache, 1);
-		oidtree_init(source->loose_objects_cache);
+	if (!source->loose->cache) {
+		ALLOC_ARRAY(source->loose->cache, 1);
+		oidtree_init(source->loose->cache);
 	}
 
 	insert_loose_map(source, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
diff --git a/object-file.c b/object-file.c
index cd6aa561fa7..fef00d6d3d0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -223,7 +223,7 @@ static int quick_has_loose(struct repository *r,
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		if (oidtree_contains(odb_loose_cache(source, oid), oid))
+		if (oidtree_contains(odb_source_loose_cache(source, oid), oid))
 			return 1;
 	}
 	return 0;
@@ -1802,44 +1802,44 @@ static int append_loose_object(const struct object_id *oid,
 	return 0;
 }
 
-struct oidtree *odb_loose_cache(struct odb_source *source,
-				const struct object_id *oid)
+struct oidtree *odb_source_loose_cache(struct odb_source *source,
+				       const struct object_id *oid)
 {
 	int subdir_nr = oid->hash[0];
 	struct strbuf buf = STRBUF_INIT;
-	size_t word_bits = bitsizeof(source->loose_objects_subdir_seen[0]);
+	size_t word_bits = bitsizeof(source->loose->subdir_seen[0]);
 	size_t word_index = subdir_nr / word_bits;
 	size_t mask = (size_t)1u << (subdir_nr % word_bits);
 	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
-	    (size_t) subdir_nr >= bitsizeof(source->loose_objects_subdir_seen))
+	    (size_t) subdir_nr >= bitsizeof(source->loose->subdir_seen))
 		BUG("subdir_nr out of range");
 
-	bitmap = &source->loose_objects_subdir_seen[word_index];
+	bitmap = &source->loose->subdir_seen[word_index];
 	if (*bitmap & mask)
-		return source->loose_objects_cache;
-	if (!source->loose_objects_cache) {
-		ALLOC_ARRAY(source->loose_objects_cache, 1);
-		oidtree_init(source->loose_objects_cache);
+		return source->loose->cache;
+	if (!source->loose->cache) {
+		ALLOC_ARRAY(source->loose->cache, 1);
+		oidtree_init(source->loose->cache);
 	}
 	strbuf_addstr(&buf, source->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
 				    source->odb->repo->hash_algo,
 				    append_loose_object,
 				    NULL, NULL,
-				    source->loose_objects_cache);
+				    source->loose->cache);
 	*bitmap |= mask;
 	strbuf_release(&buf);
-	return source->loose_objects_cache;
+	return source->loose->cache;
 }
 
 void odb_clear_loose_cache(struct odb_source *source)
 {
-	oidtree_clear(source->loose_objects_cache);
-	FREE_AND_NULL(source->loose_objects_cache);
-	memset(&source->loose_objects_subdir_seen, 0,
-	       sizeof(source->loose_objects_subdir_seen));
+	oidtree_clear(source->loose->cache);
+	FREE_AND_NULL(source->loose->cache);
+	memset(&source->loose->subdir_seen, 0,
+	       sizeof(source->loose->subdir_seen));
 }
 
 static int check_stream_oid(git_zstream *stream,
@@ -2006,5 +2006,8 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source *source)
 
 void odb_source_loose_free(struct odb_source_loose *loose)
 {
+	if (!loose)
+		return;
+	odb_clear_loose_cache(loose->source);
 	free(loose);
 }
diff --git a/object-file.h b/object-file.h
index 695a7e8e7c4..90da69cf5f7 100644
--- a/object-file.h
+++ b/object-file.h
@@ -20,6 +20,18 @@ struct odb_source;
 
 struct odb_source_loose {
 	struct odb_source *source;
+
+	/*
+	 * Used to store the results of readdir(3) calls when we are OK
+	 * sacrificing accuracy due to races for speed. That includes
+	 * object existence with OBJECT_INFO_QUICK, as well as
+	 * our search for unique abbreviated hashes. Don't use it for tasks
+	 * requiring greater accuracy!
+	 *
+	 * Be sure to call odb_load_loose_cache() before using.
+	 */
+	uint32_t subdir_seen[8]; /* 256 bits */
+	struct oidtree *cache;
 };
 
 struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
@@ -29,8 +41,8 @@ void odb_source_loose_free(struct odb_source_loose *loose);
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
  */
-struct oidtree *odb_loose_cache(struct odb_source *source,
-				const struct object_id *oid);
+struct oidtree *odb_source_loose_cache(struct odb_source *source,
+				       const struct object_id *oid);
 
 /* Empty the loose object cache for the specified object directory. */
 void odb_clear_loose_cache(struct odb_source *source);
diff --git a/object-name.c b/object-name.c
index f6902e140dd..ba12ebf16f5 100644
--- a/object-name.c
+++ b/object-name.c
@@ -116,7 +116,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 	struct odb_source *source;
 
 	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
-		oidtree_each(odb_loose_cache(source, &ds->bin_pfx),
+		oidtree_each(odb_source_loose_cache(source, &ds->bin_pfx),
 				&ds->bin_pfx, ds->len, match_prefix, ds);
 }
 
diff --git a/odb.c b/odb.c
index 2d06ab0bb85..87d84688c63 100644
--- a/odb.c
+++ b/odb.c
@@ -370,7 +370,6 @@ static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
 	odb_source_loose_free(source->loose);
-	odb_clear_loose_cache(source);
 	loose_object_map_clear(&source->loose_map);
 	free(source);
 }
diff --git a/odb.h b/odb.h
index 49b398bedae..77104396afe 100644
--- a/odb.h
+++ b/odb.h
@@ -51,18 +51,6 @@ struct odb_source {
 	/* Private state for loose objects. */
 	struct odb_source_loose *loose;
 
-	/*
-	 * Used to store the results of readdir(3) calls when we are OK
-	 * sacrificing accuracy due to races for speed. That includes
-	 * object existence with OBJECT_INFO_QUICK, as well as
-	 * our search for unique abbreviated hashes. Don't use it for tasks
-	 * requiring greater accuracy!
-	 *
-	 * Be sure to call odb_load_loose_cache() before using.
-	 */
-	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
-	struct oidtree *loose_objects_cache;
-
 	/* Map between object IDs for loose objects. */
 	struct loose_object_map *loose_map;
 

-- 
2.51.2.1041.gc1ab5b90ca.dirty

