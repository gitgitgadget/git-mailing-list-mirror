Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B88288CB3
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709911; cv=none; b=HzCX7D0VUVNijKJ4OkIvqUwH96UEvLbOLfMYLYPIW7QR50dQTOu6xf82/iNvadMo3Zed9yh/7TEBWUiFcqpqDjjAmS2ycVOj/f4UJu1ETZSs6XzwDwY7WKGZqDdxGrjXAYrJ9a0DkC1g/TT25svumIaBD7tlHCHmdH++aTQfS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709911; c=relaxed/simple;
	bh=Bqx2izYpnOQrOxL9NlYaEyMg7rwHrTxxhjLXx1DRpd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bwE4U/XfP7cOVE2ERqjdhmEbsWIfq1fOn3+ilSVWbGlbh1iqmWuFEBSJONNPzI47NpuWX9muXfa+WzZdKiyvZN26pMijRlh3Cj+doDVmJqQi8VvtYb0gz9nniV2olKRDYJt7haIFVU9UzAZvr22J5ssOR89nyC7GZneahIp3uSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hNbY1fan; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IaWKuwk5; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hNbY1fan";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IaWKuwk5"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C4AE254037A;
	Tue, 15 Apr 2025 05:38:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 15 Apr 2025 05:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744709907;
	 x=1744796307; bh=xmUKAWYsrQ4TbyiM0E3Jt+4OYEu/baQiBcppiLTrN2Q=; b=
	hNbY1fanNFch+NejsJrdC4pb63qmf+LvWJWvbStTepTABuSYq97XxKz8Ddp04uzC
	2u/MylDp4dcFEN442jNBL9cvk9tENHEIdC/W7j8OGL1xKnp9fpCQWzELbiWhpcE6
	h/Wm2j3MSsmCKP9UBkUjcFM+dA57tC/aujU6FMYR1P14zSOTJzNYyQYgHUSwYIA3
	unhA/59ObD/E58AbNCE+9j7eFClZDGNbc3ZL/fDJ5tqULcMczL+0KgewKGxv3/g/
	eo9pv9aSxa6+gpXb5ImRy9AS1mawgJRMSk45lPDa9HnYO5wFn0aTkcnpQq08v5Mp
	fpbvCh0StY9G0FzeWtmOOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744709907; x=
	1744796307; bh=xmUKAWYsrQ4TbyiM0E3Jt+4OYEu/baQiBcppiLTrN2Q=; b=I
	aWKuwk5pZYIKPXiyWTnQsf1UdqH1NKp6obHI2PybBRxcPgoyYTjJv7o7KRlYzdu8
	lgYbxN3pVkvF/VTTnXpk/xU95BNn6y5KJaGXNRBIeD2JGbppzErfo2Ane93eOWNj
	vcJp1qHEUNxoqB+8MjVl0LF3QDP+oHAnCz/T3vX6RhjGZc6AedyqNSm4nQxD24+z
	S0rICHBnKB0SH7ICbyLyAXxJDrG3xxp21mLZukHmRgWeSRhsMJAVLKATX58LmVFg
	8vWccujNE9wMYZqD+4EhEnL8MbEv3f25V9Ak2rZuSwRny3O1ZDjfvByRuKCYesAc
	8wunR3I+4df+Ddg242ecg==
X-ME-Sender: <xms:Eyn-Z9tFcQiNGxK5zTq7l3R_mIIQ4y1zE86eDqknVytactMPeWwT-w>
    <xme:Eyn-Z2ec1_SggpXigUSjWlDWTeeE2UF-2DUbBUCXgyK189YYGAR3Qk3mgJjGnMvEj
    dX85n9I7-XHAi6S1A>
X-ME-Received: <xmr:Eyn-Zwx6pm7-zMZns40n38iRhaPHS9Z3m9Fn6kdRcvEouUyNW9qkpdchrZaUf8oCorFFRKEAhhkNZ939RyjY9Q34BJESYMYmaamzQb0CZKFvrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:Eyn-Z0MrfN5ELaMjSOdJJxlLbB8DsKCxNoEQmkW_3UNge1OH7Rhpgg>
    <xmx:Eyn-Z99hxIEZgKUcU3NL1odhX-KipXBTTUDhHIrLa_fnPd3L6a_j0g>
    <xmx:Eyn-Z0WiBs2SRWL6QMxT0_ovYV9FsTMwbpnQhvGxu-tNUpBady7Mgg>
    <xmx:Eyn-Z-em1iGnBoS3Q4E92amJPS0QJ3VY2pcz_QP759Z-jhznzpA8IQ>
    <xmx:Eyn-Z_lo9AdKw2J0De2E_QIqaCH2FZ-Fej0gtlpjyg98WAeWRKotY9PR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:38:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dbc6414c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:38:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:38:22 +0200
Subject: [PATCH v3 09/10] object-store: remove global array of cached
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-pks-split-object-file-v3-9-6aa7db7ad7b0@pks.im>
References: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
In-Reply-To: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Cached objects are virtual objects that can be set up without writing
anything into the object store directly, which is used by git-blame(1)
to create fake commits for the working tree.

These cached objects are stored in a global variable, which is another
roadblock for libification of the object subsystem. Refactor the code so
that we instead store the array as part of the raw object store.

This refactoring raises the question whether virtual objects should
really be specific to a single repository (or rather a single object
store). Hypothetical usecases might for example span across submodules,
and here it may or may not be the right thing to provide virtual objects
across submodule boundaries.

The only existing usecase is git-blame(1) though, which does not know to
blame across submodule boundaries in the first place. As such, storing
these objects both globally and per-repository would achieve the same
result right now. But arguably, if we learned to blame across submodule
boundaries, we would likely want to create separate fare working tree
commits for each of the submodules so that the user can learn which
worktree a specific uncommitted change belongs to. And even if we would
want to create the same fake commit for each of the submodules we could
do that when storing separate virtual objects per object store.

While this is all rather hypothetical, the takeaway is that handling
virtual objects per-object store gives us more flexibility compared to
storing them globally. In a hypothetical future where we have achieved
full libification one might be able to handle unrelated repositories in
a single process, where the state of one repository should not have an
impact on the state of another repository. As such, storing these cached
objects per object store will enable more usecases and should lead to
less surprising outcomes overall.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 blame.c           |  2 +-
 object-store-ll.h | 14 +++++++++++++-
 object-store.c    | 39 +++++++++++++++++++++++----------------
 3 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/blame.c b/blame.c
index 703dab43e78..b7c5bd692e6 100644
--- a/blame.c
+++ b/blame.c
@@ -277,7 +277,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 	convert_to_git(r->index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
-	pretend_object_file(buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
+	pretend_object_file(the_repository, buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
 
 	/*
 	 * Read the current index, replace the path entry with
diff --git a/object-store-ll.h b/object-store-ll.h
index 8bb0f33f9a8..bb5e8798a1b 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -151,6 +151,8 @@ static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
 	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
 }
 
+struct cached_object_entry;
+
 struct raw_object_store {
 	/*
 	 * Set of all object directories; the main directory is first (and
@@ -203,6 +205,15 @@ struct raw_object_store {
 		unsigned flags;
 	} kept_pack_cache;
 
+	/*
+	 * This is meant to hold a *small* number of objects that you would
+	 * want repo_read_object_file() to be able to return, but yet you do not want
+	 * to write them into the object store (e.g. a browse-only
+	 * application).
+	 */
+	struct cached_object_entry *cached_objects;
+	size_t cached_object_nr, cached_object_alloc;
+
 	/*
 	 * A map of packfiles to packed_git structs for tracking which
 	 * packs have been loaded already.
@@ -272,7 +283,8 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
  * object in persistent storage before writing any other new objects
  * that reference it.
  */
-int pretend_object_file(void *, unsigned long, enum object_type,
+int pretend_object_file(struct repository *repo,
+			void *buf, unsigned long len, enum object_type type,
 			struct object_id *oid);
 
 struct object_info {
diff --git a/object-store.c b/object-store.c
index 896d9ac3509..0f1dcc113ed 100644
--- a/object-store.c
+++ b/object-store.c
@@ -30,31 +30,31 @@
  * to write them into the object store (e.g. a browse-only
  * application).
  */
-static struct cached_object_entry {
+struct cached_object_entry {
 	struct object_id oid;
 	struct cached_object {
 		enum object_type type;
 		const void *buf;
 		unsigned long size;
 	} value;
-} *cached_objects;
-static int cached_object_nr, cached_object_alloc;
+};
 
-static const struct cached_object *find_cached_object(const struct object_id *oid)
+static const struct cached_object *find_cached_object(struct raw_object_store *object_store,
+						      const struct object_id *oid)
 {
 	static const struct cached_object empty_tree = {
 		.type = OBJ_TREE,
 		.buf = "",
 	};
-	int i;
-	const struct cached_object_entry *co = cached_objects;
+	const struct cached_object_entry *co = object_store->cached_objects;
 
-	for (i = 0; i < cached_object_nr; i++, co++) {
+	for (size_t i = 0; i < object_store->cached_object_nr; i++, co++)
 		if (oideq(&co->oid, oid))
 			return &co->value;
-	}
-	if (oideq(oid, the_hash_algo->empty_tree))
+
+	if (oid->algo && oideq(oid, hash_algos[oid->algo].empty_tree))
 		return &empty_tree;
+
 	return NULL;
 }
 
@@ -650,7 +650,7 @@ static int do_oid_object_info_extended(struct repository *r,
 	if (!oi)
 		oi = &blank_oi;
 
-	co = find_cached_object(real);
+	co = find_cached_object(r->objects, real);
 	if (co) {
 		if (oi->typep)
 			*(oi->typep) = co->type;
@@ -853,18 +853,21 @@ int oid_object_info(struct repository *r,
 	return type;
 }
 
-int pretend_object_file(void *buf, unsigned long len, enum object_type type,
+int pretend_object_file(struct repository *repo,
+			void *buf, unsigned long len, enum object_type type,
 			struct object_id *oid)
 {
 	struct cached_object_entry *co;
 	char *co_buf;
 
-	hash_object_file(the_hash_algo, buf, len, type, oid);
-	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
-	    find_cached_object(oid))
+	hash_object_file(repo->hash_algo, buf, len, type, oid);
+	if (repo_has_object_file_with_flags(repo, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
+	    find_cached_object(repo->objects, oid))
 		return 0;
-	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
-	co = &cached_objects[cached_object_nr++];
+
+	ALLOC_GROW(repo->objects->cached_objects,
+		   repo->objects->cached_object_nr + 1, repo->objects->cached_object_alloc);
+	co = &repo->objects->cached_objects[repo->objects->cached_object_nr++];
 	co->value.size = len;
 	co->value.type = type;
 	co_buf = xmalloc(len);
@@ -1021,6 +1024,10 @@ void raw_object_store_clear(struct raw_object_store *o)
 	o->odb_tail = NULL;
 	o->loaded_alternates = 0;
 
+	for (size_t i = 0; i < o->cached_object_nr; i++)
+		free((char *) o->cached_objects[i].value.buf);
+	FREE_AND_NULL(o->cached_objects);
+
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	close_object_store(o);
 

-- 
2.49.0.805.g082f7c87e0.dirty

