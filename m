Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E8198E92
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530957; cv=none; b=Tn1GIYFoQLU8fUPXK9t52AnPa+vsrXqIpDL84XbKRBvyHWWnWpJpaouW1WSuu8d+hLmhgc0Oqg6zM6g6k7ZXFAbUH0wR90u+HnE7udgWWn3HhhTCfzbjxGeTWHYs+MOdaSUuqnOHaaXfJNzdNEDvWEY1lOryxAdSUYKSk51QoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530957; c=relaxed/simple;
	bh=6zPjpWr4TK0j8N3Y3dH6yv/43Aqz6+EAHeag5wp1ZFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOTAecj3BB4WbE3j337CzyVIqOokhoLBjzJ0KEo6mxH9zSnSn36Y+ZSLkygK//draOHiVr53En2UtS7UvwNBX2GpZK5MMcso3UIpd4ZwGVXAuNJvIq9f+vriKRVGKpDYUsoh/JiDPKfcWLxQM4gmq9DmEi/O6CwdRpdstMNER1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dRS5RQUN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQGmxjhb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dRS5RQUN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQGmxjhb"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 22CA31380348;
	Thu,  5 Sep 2024 06:09:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Sep 2024 06:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530955; x=1725617355; bh=uJNcX4nM8Q
	E6wZH+PZIxDeZWyxn8KA2X29CTGWFlHWw=; b=dRS5RQUNSvHOqF9/S3ReSXs6x3
	DtKJtDBDAx/9qElqCUFaWatStK05BEgAjEGKk620NLUJ6HWX9Ht9YRc/PyUUirzQ
	KvAi+VFDNJkbM0kx9PzaiBM75zPu3AjyXD05u8PiwBV0QGjerPNPb9BkriO5PWul
	cmRdXqeHXJZhpFWzTmDH89Bc7JII4DFSjn6k8HjaOVuSIOOn2NUCpFDbZSDdw7+3
	E3s8OAcvh3/BK44OAw0h+y7fAED3iCKE+7m4Tfd+iZg2oPfegzH2YjhnCpRCAowf
	5CiX++sLtEyGgQx3nX6wcv9al0CwsWgEhX3L1RSS7uMKOGWF9z8AdQMUzkPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530955; x=1725617355; bh=uJNcX4nM8QE6wZH+PZIxDeZWyxn8
	KA2X29CTGWFlHWw=; b=TQGmxjhbgIOWNB2IpLwhuQKan5/E4TiCRDZ32n3II70G
	BVqCxTA1G/Vkai+SHQiJQgQqOBlm9Qe+QbmQhRW+PY1cz7NyXiHFILM23M35M7PI
	N+Bzzm3TnjYRCj3ipzqsYUui6NqelDvdigNmz4zWuoLU1rgMDNcbHYUTH86tMmCE
	E3tUdGmfK5HmqmOYaDD2OCnKJkRO+bVvdge0VeTGxxgrlObhhsZVr6k6w5M46yZK
	yr/idOVvg1ZrI8M7Io6feH+eGkelzhYkhUxDGvOr8paJFt1DR575aM45h7Bcv4xw
	JCT441nvfgxyZxG30ET2wkN4oLl18xC92bwMBwUBHQ==
X-ME-Sender: <xms:S4PZZp7BDW6DaWAEIOUS1NDL-7JKClVbw_ckiQ9pC9jat2T7QLQNMA>
    <xme:S4PZZm6AbQGWbqTAqHGGrO9r1RligwFzBU7bTvCO8pA4Y7LOLrGgCX3Vh6i69GLng
    V5RDCMhP60gc0f_lw>
X-ME-Received: <xmr:S4PZZgfbyr3-GEz9sdebSJ1l0RRYQTj05ncW2QhyfA9INKFHz6l1GCjZaETB90xRl1BZ-AVFuk2YbfInKD0HUc1RBtu2cg0DjJeoLWD8xMla8Dk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvg
    drtghomhdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:S4PZZiL4flFr45i1nsJeK3cQtONy39v4F0LKRW9BoNcwH6ZZ0mLWug>
    <xmx:S4PZZtL2mT2mOpI4emvPZzW5oyvdD5XR8N8OJa0H0TAenlJEpEmcCA>
    <xmx:S4PZZrxfzbTUyhK6XssVrvthEewRHz60X3r1AvppwSqywcOxvtu7Lg>
    <xmx:S4PZZpI8YjtHI0Nruo5EGBWIBGKdyVG4dIqfPrrVi4Zijnam5DzSyg>
    <xmx:S4PZZl_KBrR5Sp8cEOXQ-RET1xlqW3OgSu1RupRzQ0x60StApa8l_odZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 13c8e337 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:02 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 12/22] object: clear grafts when clearing parsed object
 pool
Message-ID: <242f6b76db397cddf2b3f1ced69bdd0b36711192.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

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
2.46.0.519.g2e7b89e038.dirty

