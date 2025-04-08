Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825E269836
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107864; cv=none; b=CX1vCRzytVILrJvtB8UuWaCnbmun8Ivf/ZhxoAHc8JIyLmh690OiuwNvcM/M1JtmJ58I//KLr+miOUMo4Spt40Q3uSZneWsVcJPJmNmYJLcJBZAGPbezks4vJf7/cZWziDlKbkpCjVSbNiGwmbfhpuP8+eAEZWx/QiQOGc2tA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107864; c=relaxed/simple;
	bh=sfeHwrLRUymAkKZ71+ezIKMsThUL86dGgv5jRpRdTpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=umlqdk0swzLAGeDOcK0URqH/WmrKTKSz0YRIH0RCRYdYGYE2AKK0la7F2t5h04QASCfRFILH0qZcVQQPLfuGPKchNBq8Iocg5JHrMZIoBYp9ze9HmZUpKFtZyN/cfCiDwiC4Q4hfAoI62ZpzLQPb5ug4p/Y716BZBU5JFpXrYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NTMdprsX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G5xDLfLT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NTMdprsX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5xDLfLT"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E0791140209
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:24:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 08 Apr 2025 06:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744107860;
	 x=1744194260; bh=RLJs02eWR/X+Is+t4UZb6+R5uqM43mbhImirMOh8Xc4=; b=
	NTMdprsXIe5ODOlnNcMMdM8RCD5LAtGTxH06UbFFI6NrZAuwNTYUMwfEmJonMQTx
	TLJkU7Z2FvgkmYtVFJznFAxaAqJoExqevnEjWcBSpMEGd7eZA2VGL3TrejVJja1N
	p+JIVa2it0x0YtWbGtd8r3ZA8bAXqnJwBfSL28CNXc5wzukoU/tMZZtpTKeDnldr
	SPHKmvQ/G2aierAyOxdebX5zGepF4gpalBiGjVXg39/LibZ9/TfQ68IkbJ7vPZHh
	pqhoQG/t5UWrGNRX6qASVvsfFV7JTH7Lce9Xlr/xfeCyuSoN+9EaXVPf8hf9vlde
	+QyyIk+03EZDlWltabUALA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744107860; x=
	1744194260; bh=RLJs02eWR/X+Is+t4UZb6+R5uqM43mbhImirMOh8Xc4=; b=G
	5xDLfLTv4tnfxcc2gHpAbL+rZ3eNp/OYgZOcVMn4BaHymyKi+bZpO1F2hB8X2Qz8
	Z1x/I+KmlADqiXSzQig8igyu1aUULTDY5RwmmgYZIAmyjDQlMQ+67WrdwDoq/o/s
	Uy4Xa3mdEphfXNe/16A2TpNPQSnzZ5Qtm1Ob8quGeDYLjpMKEmSLSmwL0QQ2sxGd
	jr2RnCsjgW6fowydynhBLawHT7/kKlRAGl282YGft3I7Sc2cGECS/USaLqKyLpxV
	3ey5i7hj2nsJ9ZhkIxQ9gYQCB5PCAlxA+x7ExkjYk14/55m/4LJIdChoeHdkgKIY
	/P86kze+/nlq+jOZEeoAQ==
X-ME-Sender: <xms:VPn0Z_4nKc6C8xgPwRX4OtNi7cck4b2knK-rgECmBqVseKWqtnHa7Q>
    <xme:VPn0Z05Xkis5VwvJFtH22DVT-gGdO010dZyFh-UJq7Zbn4j3OMe3EDXwAHCli4rqW
    fSFtA5UKifGBE1AaA>
X-ME-Received: <xmr:VPn0Z2eYBx9KoXk6JHUctNnliDFRJPpZnC_wLm0vIuNtj-G38DfCQ5c3J-Dr-abEMUInSmMI0s7n4upuw2QdHR26bCtzMdPu4LmpZAzz_m7l1-E7XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VPn0ZwLa_x7PSb9AJVOkp7Ng5yY8kDxQ_Ec7u6vxQv-Q36dweuCB_A>
    <xmx:VPn0ZzJj6QKlu1XZs00Ao72yDfUTXwUEApPoquXyJv7rTGTwbY9q6A>
    <xmx:VPn0Z5zEfDtvQjftTSJnkv1jfP0kRAWBQ2HeL1DeRbtrlGEuXP3w-Q>
    <xmx:VPn0Z_JvMWedEYDLiJuDTqi71XZziCZpp89u27wGRRTj0uIwXF5OQQ>
    <xmx:VPn0Z0V_p4StXSkH2N-kpEi-eFI8JEiVO72gL89oEm361dmTwzOgncDa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 8 Apr 2025 06:24:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e056cb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 8 Apr 2025 10:24:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 12:24:16 +0200
Subject: [PATCH 8/9] object-store: remove global array of cached objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-split-object-file-v1-8-f1fd50191143@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
In-Reply-To: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Cached objects are virtual objects that can be set up without writing
anything into the object store directly. This mechanism for example
allows us to create fake commits in git-blame(1).

The cached objects are stored in a global variable. Refactor the code so
that we instead store the array as part of the raw object store. This is
another step into the direction of libifying our object database.

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
index ea2d86c429b..17fa06a86fa 100644
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
2.49.0.682.gc9b6a7b2b0.dirty

