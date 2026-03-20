Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838853AA4FD
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007299; cv=none; b=OeQ/pHcWqImhqOnXq9OX6KhX4STRaDvy5u/AmkhoOcovjUlqK/qB0x5MSnAVrlD3XXkjmSbtzzruVtJeTLrPPm3maRY1hR7lsqi3r4HU+iDS2S7JBcuASNtmjJanrZVglplmpBMLfiAjDxCtCmN7xvxoOguCwhxBSCiSa8+uLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007299; c=relaxed/simple;
	bh=uNzFKL211ZQ81jUtLLcvq2vqbcZmGweTXzkvnre04bM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJ08Uco8d0nWRYvfX/Ed8krmUk9Mlh78V2HFkhvCOyoDSw1t42iwY5w4UosfIrd1n5Q0uYgihZ8VaelpylMO2KicCePqx/pYkcOadW8GgXNPUuhH4k8uNAKvj2V43mASow9PNAfSKl60CYmm9LyR1UiEuZtcReiF88x/NQTDWck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iiTawTwI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q8C81LW0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iiTawTwI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q8C81LW0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D319A1400182
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 20 Mar 2026 07:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007297;
	 x=1774093697; bh=Haoc1WLY2z35zaVjO9L0Ej65rI36Q8KZZrKTvaL4qcU=; b=
	iiTawTwIRe4I++UBuVOg1DX1jIcETebpJAM2NKRCI+AwE565bSfFJz7o8tkRlq+N
	88MoUgfgXw6oMEDzLeanUnHGp4WPc0SFljBzVCZPeAkz27WcT6jJnmp3JNEj/lus
	hRVpPgsFs74HftWi9bGbZgcHeLl2ZKIXcaJZcFswVh46V/Mm1/tk9OLgGm4yzVsf
	28qkBy/JtjQIOQ1eyf7QDGm7l7VpQVpEU0pkOEiLQjHdusRSGu2t0yqQWDZbn0TB
	sCWUHkVa5M3qW25fEKG6tz7IfQyHjzEWJ5ZaIZb1E6hPJNpbw/4cXVaoae4H8Blv
	TxK239//VsUmvKNwAsWyNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007297; x=
	1774093697; bh=Haoc1WLY2z35zaVjO9L0Ej65rI36Q8KZZrKTvaL4qcU=; b=Q
	8C81LW0WcZUQUqLpirL6iKOrrz1O8u7QxsWO1DW1shd84q/mWPz0fv6/47M94SFF
	3Cc4Gi6rbZlIvZ3z42MlLqVz6KL4LCopJZihD0+uHvg1RWqBLZMzqT9FdSJjjlM4
	Z6THATQwwLXGJbcKKVhvsAGRrqtTgGPBNnXw9MgBU7WSf0Uzn10k6LUP4846NCq8
	uVIUFDFlLt9d24/S5XfSxepe2Fg8Sf0stTuKYSbS5uLEEQtCU86kzRqZer6lYzjn
	Uo5vYFXiCEelWMYuutxeK2+Dip67Ktk17+MiQWUIowGeyQ33mr4Bw3i25EZfF4bi
	hyK9E3y2KK/mmQj5vly7g==
X-ME-Sender: <xms:ATS9ad0rdwST_P9vUkZIt-CLEpe2WoTZbc-AeIRxCAsheR_CqL-c6A>
    <xme:ATS9abBPgrT6vC5ZVbm0NHVTwQIEg4hWF94cu55XrEMPx7mbzfwmaoXOr4j7Z1pN_
    uhZ7ssBzm6R2TR5jlGCZJIEq5G-cgMLE4bx7nTERG3-mfO_cpjKiYk>
X-ME-Received: <xmr:ATS9aTh5doEHPFYvmqJCchmYUrEwRut2oD9sJ7kxUlZvdkFApJZbrk2L5X0L84ItsC-Q2Duyb7Gzr_VYZ3PWbVtjRE__w_9Jsl0fqo1_BYJi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ATS9af9tb0hZp8ueMVmGUJOe8ew7YMaQqXwTv5PJKorvah15sGD7hA>
    <xmx:ATS9af_kfR6cVGX_YeqrwdTj8bA_8p8KsU9bhS7awFS_RMuGfI4kMw>
    <xmx:ATS9aYCHFhbBhI0pZTojG8HSXbTE2b8dFV5Rhdz-gCspZ6pJqhHHXg>
    <xmx:ATS9afy6U576dc-V7NM3PSUa5vV3Q1Z2GiSolKpERHrMbMfyNSGkrg>
    <xmx:ATS9aTE7pxwLx_-aICbBX8urq7slhQtPNWcSA9S_7F2x3seoE1mM5r31>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f3d93aff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:48:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:17 +0100
Subject: [PATCH 12/14] builtin/fsck: stop using `the_repository` when
 marking objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-12-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We implicitly rely on `the_repository` when marking objects for
connectivity. Refactor this to instead inject the repository via the
callback payload.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 55 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 874af76e05..b15708d155 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -123,10 +123,16 @@ static int fsck_objects_error_func(struct fsck_options *o UNUSED,
 
 static struct object_array pending;
 
+struct mark_object_data {
+	struct repository *repo;
+	struct object *parent;
+};
+
 static int mark_object(struct object *obj, enum object_type type,
-		       void *data, struct fsck_options *options UNUSED)
+		       void *cb_data, struct fsck_options *options UNUSED)
 {
-	struct object *parent = data;
+	struct mark_object_data *data = cb_data;
+	struct object *parent = data->parent;
 
 	/*
 	 * The only case data is NULL or type is OBJ_ANY is when
@@ -153,7 +159,7 @@ static int mark_object(struct object *obj, enum object_type type,
 		return 0;
 	obj->flags |= REACHABLE;
 
-	if (is_promisor_object(the_repository, &obj->oid))
+	if (is_promisor_object(data->repo, &obj->oid))
 		/*
 		 * Further recursion does not need to be performed on this
 		 * object since it is a promisor object (so it does not need to
@@ -162,7 +168,7 @@ static int mark_object(struct object *obj, enum object_type type,
 		return 0;
 
 	if (!(obj->flags & HAS_OBJ)) {
-		if (parent && !odb_has_object(the_repository->objects, &obj->oid,
+		if (parent && !odb_has_object(data->repo->objects, &obj->oid,
 					      HAS_OBJECT_RECHECK_PACKED)) {
 			printf_ln(_("broken link from %7s %s\n"
 				    "              to %7s %s"),
@@ -179,14 +185,21 @@ static int mark_object(struct object *obj, enum object_type type,
 	return 0;
 }
 
-static void mark_object_reachable(struct object *obj)
+static void mark_object_reachable(struct repository *repo, struct object *obj)
 {
-	mark_object(obj, OBJ_ANY, NULL, NULL);
+	struct mark_object_data data = {
+		.repo = repo,
+	};
+	mark_object(obj, OBJ_ANY, &data, NULL);
 }
 
 static int traverse_one_object(struct repository *repo, struct object *obj)
 {
-	int result = fsck_walk(repo, obj, obj, &fsck_walk_options);
+	struct mark_object_data data = {
+		.repo = repo,
+		.parent = obj,
+	};
+	int result = fsck_walk(repo, obj, &data, &fsck_walk_options);
 
 	if (obj->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)obj;
@@ -222,10 +235,11 @@ static int mark_used(struct object *obj, enum object_type type UNUSED,
 
 static int mark_unreachable_referents(const struct object_id *oid,
 				      struct object_info *oi UNUSED,
-				      void *data UNUSED)
+				      void *data)
 {
+	struct repository *repo = data;
 	struct fsck_options options = FSCK_OPTIONS_DEFAULT;
-	struct object *obj = lookup_object(the_repository, oid);
+	struct object *obj = lookup_object(repo, oid);
 
 	if (!obj || !(obj->flags & HAS_OBJ))
 		return 0; /* not part of our original set */
@@ -237,14 +251,14 @@ static int mark_unreachable_referents(const struct object_id *oid,
 	 * (and we want to avoid parsing blobs).
 	 */
 	if (obj->type == OBJ_NONE) {
-		enum object_type type = odb_read_object_info(the_repository->objects,
+		enum object_type type = odb_read_object_info(repo->objects,
 							     &obj->oid, NULL);
 		if (type > 0)
 			object_as_type(obj, type, 0);
 	}
 
 	options.walk = mark_used;
-	fsck_walk(the_repository, obj, NULL, &options);
+	fsck_walk(repo, obj, NULL, &options);
 	if (obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
 
@@ -384,7 +398,7 @@ static void check_connectivity(struct repository *repo)
 		 * traversal.
 		 */
 		odb_for_each_object(repo->objects, NULL,
-				    mark_unreachable_referents, NULL, 0);
+				    mark_unreachable_referents, repo, 0);
 	}
 
 	/* Look up all the requirements, warn about missing objects.. */
@@ -484,7 +498,7 @@ static void fsck_handle_reflog_oid(struct repository *repo,
 						     "%s@{%"PRItime"}",
 						     refname, timestamp);
 			obj->flags |= USED;
-			mark_object_reachable(obj);
+			mark_object_reachable(repo, obj);
 		} else if (!is_promisor_object(repo, oid)) {
 			error(_("%s: invalid reflog entry %s"),
 			      refname, oid_to_hex(oid));
@@ -589,7 +603,7 @@ static int fsck_handle_ref(const struct reference *ref, void *cb_data)
 	obj->flags |= USED;
 	fsck_put_object_name(&fsck_walk_options,
 			     ref->oid, "%s", ref->name);
-	mark_object_reachable(obj);
+	mark_object_reachable(repo, obj);
 
 	return 0;
 }
@@ -829,7 +843,7 @@ static int fsck_cache_tree(struct repository *repo, struct cache_tree *it,
 		}
 		obj->flags |= USED;
 		fsck_put_object_name(&fsck_walk_options, &it->oid, ":");
-		mark_object_reachable(obj);
+		mark_object_reachable(repo, obj);
 		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, _("non-tree in cache-tree"));
 	}
@@ -871,7 +885,7 @@ static int fsck_resolve_undo(struct index_state *istate,
 			obj->flags |= USED;
 			fsck_put_object_name(&fsck_walk_options, &ru->oid[i],
 					     ":(%d):%s", i, path);
-			mark_object_reachable(obj);
+			mark_object_reachable(istate->repo, obj);
 		}
 	}
 	return 0;
@@ -902,7 +916,7 @@ static void fsck_index(struct index_state *istate, const char *index_path,
 				     "%s:%s",
 				     is_current_worktree ? "" : index_path,
 				     istate->cache[i]->name);
-		mark_object_reachable(obj);
+		mark_object_reachable(istate->repo, obj);
 	}
 	if (istate->cache_tree)
 		fsck_cache_tree(istate->repo, istate->cache_tree, index_path);
@@ -911,9 +925,10 @@ static void fsck_index(struct index_state *istate, const char *index_path,
 
 static int mark_object_for_connectivity(const struct object_id *oid,
 					struct object_info *oi UNUSED,
-					void *cb_data UNUSED)
+					void *cb_data)
 {
-	struct object *obj = lookup_unknown_object(the_repository, oid);
+	struct repository *repo = cb_data;
+	struct object *obj = lookup_unknown_object(repo, oid);
 	obj->flags |= HAS_OBJ;
 	return 0;
 }
@@ -1064,7 +1079,7 @@ int cmd_fsck(int argc,
 
 	if (connectivity_only) {
 		odb_for_each_object(repo->objects, NULL,
-				    mark_object_for_connectivity, NULL, 0);
+				    mark_object_for_connectivity, repo, 0);
 	} else {
 		odb_prepare_alternates(repo->objects);
 		for (source = repo->objects->sources; source; source = source->next)

-- 
2.53.0.1055.ga2ffed1127.dirty

