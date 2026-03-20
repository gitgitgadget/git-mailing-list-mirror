Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39CA3009C7
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007268; cv=none; b=FoI8SIuGcpEQkaP4i7CdC2gkB+jOd3NMAFEJ//bWzOv//Y+Hi48SxSbTwVvaB7MUbkjlnGzSLNG8VTT80l1+BKYNZ/9QOF2BjIQ6vHczlKNIuNhpR1nssYGrYTVnag7MYx9DDI1HTxBIbm6ecD1KJBGQuXtDF9BLA8I14HeSoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007268; c=relaxed/simple;
	bh=qdtiK7IfAGsWDl2NBrI1WGyZHg+dzY5hAxtkaJF3jDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZMP3ISVTA3lyuUPDpocY3F8Ek2wOwV3aznCItdm6D1ZBrAcFXpVJgpzkQC7O3fEpP7rEPf/0cT4lJxJG0yAhgpp0vmExCPh574FcVkXVQWz0PWmKIrcHbY8nBPOzqVwup3izYfjKAAFAUk6/Q/uIhkNAFXsjTsUmFGLJ+H13oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oV796xaj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+ZfJ2FE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oV796xaj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+ZfJ2FE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE5101400176
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 07:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007265;
	 x=1774093665; bh=k1Q1dN2eol+3F6BSYpAbSPlrASMO2vAKxdgaxBfcsYQ=; b=
	oV796xajOCcqUqm2kMu4owIr6De9BHZJFf6Bnj75hlinQBTVu6ajivUQQwQHCvgr
	QuujvwZ6Lsu072RIjDyRDEf4MgprUQ+Ro4Eu2wbSNOFBHCLjF8bBHHlmfSPb1SVO
	C1idK/8rBjlKQwQpa+9lsSEOW1s1wR+Ayc0O++gtZxlhCxoS5xpCJX5ksKolpV95
	sARZ36FaIxTtt3P4gHVeh8soIdDv+H7zK/ag7sIE/yLPV0mqE7Oko6AhU3CHQVIk
	5jPC4g1aiqgZeNIxLYCgOvFfJCRMWx2II04yxSX0g8s9jWninZ1XMcqHiM0rVciU
	l/CcxSiNPBKtlicVoVizrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007265; x=
	1774093665; bh=k1Q1dN2eol+3F6BSYpAbSPlrASMO2vAKxdgaxBfcsYQ=; b=e
	+ZfJ2FEkwNsfXy/93G3Roflo+61jbIqVHwSvAEWrAjRWfJIhzi2rsiPzllSmIeza
	kl8wPQCpyAlQGHP5o8sEGn1FT9gsd2TqEawRcebMnOaqlXq20SPhSlAAnYnXx8qM
	SmnfMSxrzOWPMBx5wicc8srJnbTl2gYcHhz5Df3WSMJxTgVX7F16X19qiKhTcx5x
	TqD+csBYVsB/ziBO6B5yqIbNamytJJj0k4lnA2+V9mvtktS5YWtP5xSyqth/qCO8
	Xq7H82IiCb1J20PISYqkjXHmPQw5wWZ+7z3VwAAEy3vXVuQFSsY1X5mxis7OTaHa
	4DuK5ZsHyRF79HVgkjVTw==
X-ME-Sender: <xms:4TO9aXx_bflOcG7s67IctyJUhmzRuTPnuKyQ9lcf3hSFFOW0UPCyaw>
    <xme:4TO9aWPEGEneyc6HNHHkkf_XQ-qXuX07WCM6fjCIZq77jBp1Yx-rLAUkek0jSf7nO
    mfA3-cQ3sUkF4N5a6VT6ILf1uL8hMLo2lbSvkbQXQGKakPvTxQZ>
X-ME-Received: <xmr:4TO9aW_7YsFGVE4ToEvh9HOehOZPll-aOy0bbAztqw853Qs9Wj6mL-5uGgxpzoTa90twRzTvJna1_Bp1VM5vfJ4RuKRGpTX1Vvfn1rA8Ozqj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:4TO9aWpJ1LmVxy8QU1_0iVAFnSvz-ravnhFzs_ezj7LiWPIoA48blg>
    <xmx:4TO9aY5zNRQoBRoHRD4tXmII7WpCoXBI5mhAizV--QqCgQ2FuB3g_Q>
    <xmx:4TO9aWO0Jg2CPywaYayrKVHi83mi4VAukG9IbX6YlQvD83-Bagu9xA>
    <xmx:4TO9aaPJzpMY1NQhs3fxueO9ziJJSsuSGChPZvhGuunNfV_Ly8ua3g>
    <xmx:4TO9aVzHdT3KPVG0_TF0-aa630MtJoH9u5R8gmRzYBJg1xeh4C0venP1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f3045b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:47:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:06 +0100
Subject: [PATCH 01/14] fsck: drop `the_repository` in `fsck_walk()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-1-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `fsck_walk()` and its object type specific functions
`fsck_walk_tree()` et al implicitly rely on `the_repository`. Remove
this dependency by injecting the repository as a parameter instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c           |  6 +++---
 builtin/index-pack.c     |  2 +-
 builtin/unpack-objects.c |  2 +-
 fsck.c                   | 40 ++++++++++++++++++++++++++--------------
 fsck.h                   | 15 ++++++++++++---
 5 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9bab32effe..15477767c7 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -186,7 +186,7 @@ static void mark_object_reachable(struct object *obj)
 
 static int traverse_one_object(struct object *obj)
 {
-	int result = fsck_walk(obj, obj, &fsck_walk_options);
+	int result = fsck_walk(the_repository, obj, obj, &fsck_walk_options);
 
 	if (obj->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)obj;
@@ -244,7 +244,7 @@ static int mark_unreachable_referents(const struct object_id *oid,
 	}
 
 	options.walk = mark_used;
-	fsck_walk(obj, NULL, &options);
+	fsck_walk(the_repository, obj, NULL, &options);
 	if (obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
 
@@ -413,7 +413,7 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 			   printable_type(&obj->oid, obj->type),
 			   describe_object(&obj->oid));
 
-	if (fsck_walk(obj, NULL, &fsck_obj_options))
+	if (fsck_walk(the_repository, obj, NULL, &fsck_obj_options))
 		objerror(obj, _("broken links"));
 	err = fsck_object(obj, buffer, size, &fsck_obj_options);
 	if (err)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d1e47279a8..a3d37d34cc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -954,7 +954,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			if (do_fsck_object &&
 			    fsck_object(obj, buf, size, &fsck_options))
 				die(_("fsck error in packed object"));
-			if (strict && fsck_walk(obj, NULL, &fsck_options))
+			if (strict && fsck_walk(the_repository, obj, NULL, &fsck_options))
 				die(_("Not all child objects of %s are reachable"), oid_to_hex(&obj->oid));
 			if (record_outgoing_links)
 				do_record_outgoing_links(obj);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6fc64e9e4b..52b62ff6d4 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -244,7 +244,7 @@ static int check_object(struct object *obj, enum object_type type,
 	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, &fsck_options))
 		die("fsck error in packed object");
 	fsck_options.walk = check_object;
-	if (fsck_walk(obj, NULL, &fsck_options))
+	if (fsck_walk(the_repository, obj, NULL, &fsck_options))
 		die("Error on reachable objects of %s", oid_to_hex(&obj->oid));
 	write_cached_object(obj, obj_buf);
 	return 0;
diff --git a/fsck.c b/fsck.c
index 0f02cf8f77..c6b6f533be 100644
--- a/fsck.c
+++ b/fsck.c
@@ -353,14 +353,17 @@ const char *fsck_describe_object(struct fsck_options *options,
 	return buf->buf;
 }
 
-static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *options)
+static int fsck_walk_tree(struct repository *repo,
+			  struct tree *tree,
+			  void *data,
+			  struct fsck_options *options)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
 	int res = 0;
 	const char *name;
 
-	if (repo_parse_tree(the_repository, tree))
+	if (repo_parse_tree(repo, tree))
 		return -1;
 
 	name = fsck_get_object_name(options, &tree->object.oid);
@@ -375,14 +378,14 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			continue;
 
 		if (S_ISDIR(entry.mode)) {
-			obj = (struct object *)lookup_tree(the_repository, &entry.oid);
+			obj = (struct object *)lookup_tree(repo, &entry.oid);
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s/",
 						     name, entry.path);
 			result = options->walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
-			obj = (struct object *)lookup_blob(the_repository, &entry.oid);
+			obj = (struct object *)lookup_blob(repo, &entry.oid);
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s",
 						     name, entry.path);
@@ -401,7 +404,10 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 	return res;
 }
 
-static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_options *options)
+static int fsck_walk_commit(struct repository *repo,
+			    struct commit *commit,
+			    void *data,
+			    struct fsck_options *options)
 {
 	int counter = 0, generation = 0, name_prefix_len = 0;
 	struct commit_list *parents;
@@ -409,7 +415,7 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 	int result;
 	const char *name;
 
-	if (repo_parse_commit(the_repository, commit))
+	if (repo_parse_commit(repo, commit))
 		return -1;
 
 	name = fsck_get_object_name(options, &commit->object.oid);
@@ -417,7 +423,7 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 		fsck_put_object_name(options, get_commit_tree_oid(commit),
 				     "%s:", name);
 
-	result = options->walk((struct object *) repo_get_commit_tree(the_repository, commit),
+	result = options->walk((struct object *) repo_get_commit_tree(repo, commit),
 			       OBJ_TREE, data, options);
 	if (result < 0)
 		return result;
@@ -470,34 +476,40 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 	return res;
 }
 
-static int fsck_walk_tag(struct tag *tag, void *data, struct fsck_options *options)
+static int fsck_walk_tag(struct repository *repo,
+			 struct tag *tag,
+			 void *data,
+			 struct fsck_options *options)
 {
 	const char *name = fsck_get_object_name(options, &tag->object.oid);
 
-	if (parse_tag(the_repository, tag))
+	if (parse_tag(repo, tag))
 		return -1;
 	if (name)
 		fsck_put_object_name(options, &tag->tagged->oid, "%s", name);
 	return options->walk(tag->tagged, OBJ_ANY, data, options);
 }
 
-int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
+int fsck_walk(struct repository *repo,
+	      struct object *obj,
+	      void *data,
+	      struct fsck_options *options)
 {
 	if (!obj)
 		return -1;
 
 	if (obj->type == OBJ_NONE)
-		parse_object(the_repository, &obj->oid);
+		parse_object(repo, &obj->oid);
 
 	switch (obj->type) {
 	case OBJ_BLOB:
 		return 0;
 	case OBJ_TREE:
-		return fsck_walk_tree((struct tree *)obj, data, options);
+		return fsck_walk_tree(repo, (struct tree *)obj, data, options);
 	case OBJ_COMMIT:
-		return fsck_walk_commit((struct commit *)obj, data, options);
+		return fsck_walk_commit(repo, (struct commit *)obj, data, options);
 	case OBJ_TAG:
-		return fsck_walk_tag((struct tag *)obj, data, options);
+		return fsck_walk_tag(repo, (struct tag *)obj, data, options);
 	default:
 		error("Unknown object type for %s",
 		      fsck_describe_object(options, &obj->oid));
diff --git a/fsck.h b/fsck.h
index 65ecbb7fe1..4bd54865fe 100644
--- a/fsck.h
+++ b/fsck.h
@@ -208,14 +208,23 @@ struct fsck_options {
 	.error_func = fsck_refs_error_function, \
 }
 
-/* descend in all linked child objects
- * the return value is:
+/*
+ * Perform consistency checks for the given object and all of its decendents.
+ *
+ * If set, the `walk` callback function in the options structure will be called
+ * for every commit. The data parameter will be passed as callback data.
+ *
+ * Returns:
+ *
  *    -1	error in processing the object
  *    <0	return value of the callback, which lead to an abort
  *    >0	return value of the first signaled error >0 (in the case of no other errors)
  *    0		everything OK
  */
-int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
+int fsck_walk(struct repository *repo,
+	      struct object *obj,
+	      void *data,
+	      struct fsck_options *options);
 
 /*
  * Blob objects my pass a NULL data pointer, which indicates they are too large

-- 
2.53.0.1055.ga2ffed1127.dirty

