Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F12EE268
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891188; cv=none; b=FwG1YYj4qCOz/anH2qzEDJ7JVyuAtMVHydChm294SWI6CUqjs93nTVup2PwXmfVZXMaxLWcaEt7OZCIoz2qsnq925qSPUbI5crUw2eYm0zGnEMg9q/Mifyv/wHiF+VfcLEh8+ILSOSrWpfuRAzqrXJGnde/h+NDq7S2HZupm/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891188; c=relaxed/simple;
	bh=pURm0fZBvTIBZMLyK7fL5VJWtMIQolqciAcdZqJHXZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZlTVpCoVlNqFNfMTwIIU7L5MDLqmIbwdE8yq0yPZ6hkj+Y5BnVUGmdy20aqX5ck7lQFRUa9AKypMwVUOsw18na3nXnUlC8BYMExyawurCHbrhI0gdPvaEsw8NNeLsqmpVtePfiEsSRET9/K3zKjqW6JzVDzRyNLI1XsaK6UI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HVDXwRSX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZqpJkssS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HVDXwRSX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZqpJkssS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 83060EC0246;
	Fri, 31 Oct 2025 02:13:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 31 Oct 2025 02:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891184;
	 x=1761977584; bh=QSchwE95vsjDrEuaQ1VeZM9aimajBRlNHVKwGaRzmC0=; b=
	HVDXwRSX6pY2umj0I6j4zU2cNoymv7lyMWdh8pgN59PPjv+oPI28EV25wBj8DX1g
	fTuzA/ubT0630fvK5NplsNdZ3WbIU5ycAzq1Sa08p3BVQ22nokD+ykFMubbpKceF
	YSiyg9czxZVY5Y9z9rcejXERx1t0MFFxrnGdtVOtIWlSChlXgVyAQQQqbGT6B6Zq
	TdSfhbDtpARbf3Xi6A1or7klgjdKIAAGC9dWb8C2N/1oILtseIoguzuDIROYqYHL
	u5doBaTm/Gccl/GdWUyiZDitPUYsn3XHxlMbwkHL5PkqK7NUylfe6o0g6vRtelm5
	utCrDHR/iupOJ5lkvg2OTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891184; x=
	1761977584; bh=QSchwE95vsjDrEuaQ1VeZM9aimajBRlNHVKwGaRzmC0=; b=Z
	qpJkssSbe8vB5v2HL1CaCObmbTw9AM1b5LvDQEvauU+zvMYhUV8dUxA9tgn61hY+
	7VhqqFOqREL2HGa//MRtxv++ui/j6fr2eS7qA3KFn2aT3zgv3qtDJR2lrLRDN+pm
	Z5P8RnpgBkJnLgaESyynrqAbEJ2jTyB0yFCb5KGuVNEkt1erBkevYhXSZKm6hJRL
	T2wTOznaY02pckcPskdJwQh7VVu12MSaR+Pswoqa+eLFY2nHSzdpPz7st0DC/4KW
	CJGCZQ9p4NHgv0mTi/g8qhJ5Dn4vMJpVb0mEuRXzpDxim+rTKDfoRm+PByNoQZEo
	LhSb4NCdXVhlnDVieJGoA==
X-ME-Sender: <xms:cFMEaUGAUynXWfPxRcBWuhpa4Tgpd_lm6tCFMiw91vTkuK0Ym5ZSIg>
    <xme:cFMEaUz5hekSGPxzxJ0s4b_0FDDrBMOLeIRWGNVQtkgoyXf2QtwF2Z3G5q4qDifxn
    GKEsaeg0gXkLQg0nvp-41Ymz5JttWiKwe02-8AFKDcV-HAy0YQA5iA>
X-ME-Received: <xmr:cFMEabh1k7oiNSZdceFz4OQYDVwZxLxWBQmwF-0LWTPW7hnYrq_eYuKcZpVoOoHK2gZ0G3r4Sj1JqI50soFrTGZHTJScmqqog0DxI5-bhongqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:cFMEafzy9uqnkScd42TseGlwM7HBRkN6DcievaUrLmhh1YZsLQpyAQ>
    <xmx:cFMEaeJYJdxBAfDHWejb6wasWhgjtgJhM-JaH2nEkIP1WAGK6QzfLw>
    <xmx:cFMEaWRlq0CrV6FuZjUw6AilbDpFASi7rhbpHE_TBTzN9ECbKAMllQ>
    <xmx:cFMEaWoNFSRF8A3A3iP1RAFDNVOREJ7LKAAiR1uEjYjuvXMpl7pq3g>
    <xmx:cFMEaYy6n8CBzVHT3kkecJNbZ2yDkM7CESIt_41NISxIWhj6LNPndaR3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:13:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3b2fb305 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:13:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:42 +0100
Subject: [PATCH v2 06/13] object-file: move loose object cache into loose
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-6-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Our loose objects use a cache that (optionally) stores all objects for
each of the opened sharding directories. This cache is located in the
`struct odb_source`, but now that we have `struct odb_loose_source` it
makes sense to move it into the latter structure so that all state that
relates to loose objects is entirely self-contained.

Do so. While at it, rename corresponding functions to have a prefix that
relates to `struct odb_loose_source`.

Note that despite this prefix, the functions still accept a `struct
odb_source` as input. This is done intentionally: once we introduce
pluggable object databases, we will continue to accept this struct but
then do a cast inside these functions to `struct odb_loose_source`. This
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
index 4dfea0ebebd..8a3db2877ee 100644
--- a/object-file.c
+++ b/object-file.c
@@ -223,7 +223,7 @@ static int quick_has_loose(struct repository *r,
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		if (oidtree_contains(odb_loose_cache(source, oid), oid))
+		if (oidtree_contains(odb_loose_source_cache(source, oid), oid))
 			return 1;
 	}
 	return 0;
@@ -1802,44 +1802,44 @@ static int append_loose_object(const struct object_id *oid,
 	return 0;
 }
 
-struct oidtree *odb_loose_cache(struct odb_source *source,
-				const struct object_id *oid)
+struct oidtree *odb_loose_source_cache(struct odb_source *source,
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
@@ -2006,5 +2006,8 @@ struct odb_loose_source *odb_loose_source_new(struct odb_source *source)
 
 void odb_loose_source_free(struct odb_loose_source *loose)
 {
+	if (!loose)
+		return;
+	odb_clear_loose_cache(loose->source);
 	free(loose);
 }
diff --git a/object-file.h b/object-file.h
index d9d2de5055e..887b48725a0 100644
--- a/object-file.h
+++ b/object-file.h
@@ -20,6 +20,18 @@ struct odb_source;
 
 struct odb_loose_source {
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
 
 struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
@@ -29,8 +41,8 @@ void odb_loose_source_free(struct odb_loose_source *loose);
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
  */
-struct oidtree *odb_loose_cache(struct odb_source *source,
-				const struct object_id *oid);
+struct oidtree *odb_loose_source_cache(struct odb_source *source,
+				       const struct object_id *oid);
 
 /* Empty the loose object cache for the specified object directory. */
 void odb_clear_loose_cache(struct odb_source *source);
diff --git a/object-name.c b/object-name.c
index f6902e140dd..77e33e693aa 100644
--- a/object-name.c
+++ b/object-name.c
@@ -116,7 +116,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 	struct odb_source *source;
 
 	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
-		oidtree_each(odb_loose_cache(source, &ds->bin_pfx),
+		oidtree_each(odb_loose_source_cache(source, &ds->bin_pfx),
 				&ds->bin_pfx, ds->len, match_prefix, ds);
 }
 
diff --git a/odb.c b/odb.c
index f1b250ceffe..5a5e770dcd0 100644
--- a/odb.c
+++ b/odb.c
@@ -370,7 +370,6 @@ static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
 	odb_loose_source_free(source->loose);
-	odb_clear_loose_cache(source);
 	loose_object_map_clear(&source->loose_map);
 	free(source);
 }
diff --git a/odb.h b/odb.h
index f7e1bf87803..ad57193c66a 100644
--- a/odb.h
+++ b/odb.h
@@ -51,18 +51,6 @@ struct odb_source {
 	/* Private state for loose objects. */
 	struct odb_loose_source *loose;
 
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

