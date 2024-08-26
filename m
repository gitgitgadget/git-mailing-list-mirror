Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA4413AA31
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656935; cv=none; b=I30VTPS9sC8JOP5r2lPuK0vJPqcfynCgU0C4ah1+HzV9rwQ5BDzgN9pS158QcyKSLsnfTj2wZaVDhOBL0lklTJyOu9Nsi3oLz76TeEQa6agHIFUVkNu46No4nXP5TcDye4ynDpGQXPwFLRdvGgRHb7YklRfni1H2RwyStPGcOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656935; c=relaxed/simple;
	bh=2U9y8pdBxKwnz2IWwhLB3s5SJYY1TehMtri3gEAg0Qk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyXNSlHGQWIEGSEWz5zTN1a8z0Q9h/3QP9Mz7zdmbzUEtK0ZjmCFoS6ZkIlR/dDsAfbDO94k2KrDt4RRcMGikQueEw4m7Yw5ilS5j97aT/0BMrOSv+8ItbIIUEPqRtNSVYitlYmHWa/mi6HhjQ6aeHF18UcGZ3Y+wWkOLup8FbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h+ESup6e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R860KZKX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h+ESup6e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R860KZKX"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6CC261151AA5
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 26 Aug 2024 03:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656932; x=1724743332; bh=MPdgnE0IZr
	u4aOi3L/glqaXlot6UK0KOXC7Vw4vB4GE=; b=h+ESup6e2jl32LTA0rCnuuAOmX
	tkKy7droD9lq+foDepSAuReaZCIuhL36Pdjjsne4jhOxxgf+PiSW/ZOkh3Llgok3
	4wmynTmh7XLO7gMEgfxFBwF02eAtL7mmbXjyI6LCvaQ8dKxreNwdwPuYDhfhRHLc
	AzqQydXi9MDNLc0VP7+mYSnMS+SaRmG12HUeRIEdoNI7g0L7aeuVfWu1fmaz0VFE
	qwqgpOZeeY6Lj8YhX4t5XLvtcAOOChypg0xFAG6q192r70S2UvAtRfjffzEhzWn1
	kIqHWh9W3bs5P+g5AYqyPk94YasfdiXRsrgJN5wcfWsyt6r+q2IK5NkAJ4vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656932; x=1724743332; bh=MPdgnE0IZru4aOi3L/glqaXlot6U
	K0KOXC7Vw4vB4GE=; b=R860KZKXmVqc/JhLjpMIo0ba3SXJOPktoKrIUCCcKuQD
	qtAw9VXPYaypP1oJKSVr7HfmPNMGQ9moXjKagaCAF7Jwrtqh/iRjRXQPwkQ5Si0H
	u4iYppLBSNGExhwmlKHtHo0oUOdVR6XdSlPXg1vlD7EvgOQmsSVWI7iBVmRb/JKh
	TN+OgaUh5/7Zw+FYXLIQSGAwCenZLgVoLddWvURxE5W561HYtj4jrw2otbLW+h0N
	oN7pyYlsXLo/nNr3O3VoPgelOB2rc52YHkx4hTHYxzfV2DrMlozZ1KUUUkcvfPmQ
	0Os+TW3mufPxbu0GwRnkegJMWGCRnjgT5F4DgJhGAA==
X-ME-Sender: <xms:JC3MZqU3QEsZ3ElHDomEdqY7sYhFcxUg0-7_5IUgmtDStpbUKPVWBA>
    <xme:JC3MZmkLaGbcLoHPwWEU92GKAeG-zDoQQCBNMthOQ_w_8RqgLR943K7vVxRlJrMN1
    YiMQIZqKReyuUievg>
X-ME-Received: <xmr:JC3MZuaJuZ4m1DiNQQc6nf2CsQDnhxp7ohF4Qh_erFjiwzvx_a4IOpNYjb04mXCLtHicf_7rplIVoljPUq49InwBXSKZS5LMe8xfglRp30sJNK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JC3MZhXHzx-fejVeLqDoDDjEYvEk9-f8qxc859Wur1sSlTAWqHA9JQ>
    <xmx:JC3MZklm9DGnotDTVh9Z5mj-A771UzakR1VAibx4j3zkfaMRnAAjag>
    <xmx:JC3MZme_J_N3idyF2UOxq_RCoE5F6bZdBH2mTE7zrP6EnkpupfRN5g>
    <xmx:JC3MZmGadHWF3yo4Q1FubbAss7TuK_GcvE6566MHgFSdwXnxsTBw_w>
    <xmx:JC3MZgvAzhJmlkPxOQlLpR_CXVCkJwRP8PNUdM9DWVXaal52CVi9_010>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c40780c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:10 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/22] object: clear grafts when clearing parsed object pool
Message-ID: <922b8640a55c74e91ce69f6976d20f948be55765.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

We do not clear grafts part of the parsed object pool when clearing the
pool itself, which can lead to memory leaks when a repository is being
cleared.

Fix this by moving `reset_commit_grafts()` into "object.c" and making it
part of the `struct parsed_object_pool` interface such that we can call
it from `parsed_object_pool_clear()`. Adapt `parsed_object_pool_new()`
to take and store a reference to its owning repository, which is needed
by `unparse_commit()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit.c     | 14 +-------------
 commit.h     |  3 ++-
 object.c     | 14 +++++++++++++-
 object.h     |  4 +++-
 repository.c |  2 +-
 shallow.c    |  2 +-
 6 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/commit.c b/commit.c
index ec9efc189d5..bbef0e81c65 100644
--- a/commit.c
+++ b/commit.c
@@ -177,7 +177,7 @@ int commit_graft_pos(struct repository *r, const struct object_id *oid)
 		       commit_graft_oid_access);
 }
 
-static void unparse_commit(struct repository *r, const struct object_id *oid)
+void unparse_commit(struct repository *r, const struct object_id *oid)
 {
 	struct commit *c = lookup_commit(r, oid);
 
@@ -318,18 +318,6 @@ int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 	return ret;
 }
 
-void reset_commit_grafts(struct repository *r)
-{
-	int i;
-
-	for (i = 0; i < r->parsed_objects->grafts_nr; i++) {
-		unparse_commit(r, &r->parsed_objects->grafts[i]->oid);
-		free(r->parsed_objects->grafts[i]);
-	}
-	r->parsed_objects->grafts_nr = 0;
-	r->parsed_objects->commit_graft_prepared = 0;
-}
-
 struct commit_buffer {
 	void *buffer;
 	unsigned long size;
diff --git a/commit.h b/commit.h
index d62b1d93f95..5ba0f77b1eb 100644
--- a/commit.h
+++ b/commit.h
@@ -108,6 +108,8 @@ static inline int repo_parse_commit_no_graph(struct repository *r,
 
 void parse_commit_or_die(struct commit *item);
 
+void unparse_commit(struct repository *r, const struct object_id *oid);
+
 struct buffer_slab;
 struct buffer_slab *allocate_commit_buffer_slab(void);
 void free_commit_buffer_slab(struct buffer_slab *bs);
@@ -240,7 +242,6 @@ int commit_graft_pos(struct repository *r, const struct object_id *oid);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
 void prepare_commit_graft(struct repository *r);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
-void reset_commit_grafts(struct repository *r);
 
 struct commit *get_fork_point(const char *refname, struct commit *commit);
 
diff --git a/object.c b/object.c
index d756c7f2ea3..94ea8fb8d2c 100644
--- a/object.c
+++ b/object.c
@@ -545,11 +545,12 @@ void repo_clear_commit_marks(struct repository *r, unsigned int flags)
 	}
 }
 
-struct parsed_object_pool *parsed_object_pool_new(void)
+struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
 {
 	struct parsed_object_pool *o = xmalloc(sizeof(*o));
 	memset(o, 0, sizeof(*o));
 
+	o->repo = repo;
 	o->blob_state = allocate_alloc_state();
 	o->tree_state = allocate_alloc_state();
 	o->commit_state = allocate_alloc_state();
@@ -628,6 +629,16 @@ void raw_object_store_clear(struct raw_object_store *o)
 	hashmap_clear(&o->pack_map);
 }
 
+void parsed_object_pool_reset_commit_grafts(struct parsed_object_pool *o)
+{
+	for (int i = 0; i < o->grafts_nr; i++) {
+		unparse_commit(o->repo, &o->grafts[i]->oid);
+		free(o->grafts[i]);
+	}
+	o->grafts_nr = 0;
+	o->commit_graft_prepared = 0;
+}
+
 void parsed_object_pool_clear(struct parsed_object_pool *o)
 {
 	/*
@@ -659,6 +670,7 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	free_commit_buffer_slab(o->buffer_slab);
 	o->buffer_slab = NULL;
 
+	parsed_object_pool_reset_commit_grafts(o);
 	clear_alloc_state(o->blob_state);
 	clear_alloc_state(o->tree_state);
 	clear_alloc_state(o->commit_state);
diff --git a/object.h b/object.h
index 05691486ebf..17f32f1103e 100644
--- a/object.h
+++ b/object.h
@@ -7,6 +7,7 @@ struct buffer_slab;
 struct repository;
 
 struct parsed_object_pool {
+	struct repository *repo;
 	struct object **obj_hash;
 	int nr_objs, obj_hash_size;
 
@@ -31,8 +32,9 @@ struct parsed_object_pool {
 	struct buffer_slab *buffer_slab;
 };
 
-struct parsed_object_pool *parsed_object_pool_new(void);
+struct parsed_object_pool *parsed_object_pool_new(struct repository *repo);
 void parsed_object_pool_clear(struct parsed_object_pool *o);
+void parsed_object_pool_reset_commit_grafts(struct parsed_object_pool *o);
 
 struct object_list {
 	struct object *item;
diff --git a/repository.c b/repository.c
index 9825a308993..e6fc2c6aa9d 100644
--- a/repository.c
+++ b/repository.c
@@ -54,7 +54,7 @@ void initialize_repository(struct repository *repo)
 {
 	repo->objects = raw_object_store_new();
 	repo->remote_state = remote_state_new();
-	repo->parsed_objects = parsed_object_pool_new();
+	repo->parsed_objects = parsed_object_pool_new(repo);
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
 
diff --git a/shallow.c b/shallow.c
index b8cd051e3b6..a10cf9e9d5d 100644
--- a/shallow.c
+++ b/shallow.c
@@ -97,7 +97,7 @@ static void reset_repository_shallow(struct repository *r)
 {
 	r->parsed_objects->is_shallow = -1;
 	stat_validity_clear(r->parsed_objects->shallow_stat);
-	reset_commit_grafts(r);
+	parsed_object_pool_reset_commit_grafts(r->parsed_objects);
 }
 
 int commit_shallow_file(struct repository *r, struct shallow_lock *lk)
-- 
2.46.0.164.g477ce5ccd6.dirty

