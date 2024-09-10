Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEFB17DE16
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935360; cv=none; b=D6CCh8OMEhm8vljFlFYtjZVNVVeJo+h7NQrxF0akaa2ofDBBbn31MhjuPkdL/rfw5yX0w20PV54vEls7BlVVmauJjeov89cPE+zNSU9rsqof7W6GAk91ZEz34Sff4qJ9vZlHqUE5t9W6nYLcXgU7ekhLoRnALoOjaHMZvSjS1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935360; c=relaxed/simple;
	bh=ttDuIh7z4Xnl03pc9eNTRzaKs1ja7alLscoirLt4hJA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XUs5ZDC8yQHzW6HaGzdeSrk4lCLRNFmhxCtuia9ItU1CRPpWr9kn+rwKeb3D3hXZhfEU0G/3W2nHaIoYXJJ091/DZU1LakuaVg6efECLCLwtu3u8+e9RlSq4QHRo3pZOeGH0YuF8+j+I8Q6Ft5tTXVMev0Bfiq+PprwmORkj9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4B+t/5w; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4B+t/5w"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso22396966b.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935356; x=1726540156; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMpP/BeX9sULLuqaiDSEQp87PU3BsZjmiWXIXZZTv0I=;
        b=U4B+t/5wCwoDvcRYWiMqeguAjMJ7PGSRgivW2A+YpDhpoQdOgXrL7iZOkc0HD1m4SU
         7eiQ5bpHLKfjuwpWvn75y+F/n9vepG+nvXkI5mmtNlS/4S54RKpxvJumReNeslFaDAbX
         IqdVYLSMdnZsdjFp8uI+8thmCD3BAZmIUqlo2bnR8xLZvol9DSCFHKsmSlOPEpMXea+h
         Jbq8k9gYN0XAHFFhDAfp3V0nIJ4NdZyIEVKwEoBb3XmuATFmoXEwlCFr3/Ij/tldjR7D
         urowStUz9pBujPlnIYTOrndH38vmKQ9vTwunvz/x/z2y573kUtGtV6VmX1lBQ4s0ol4e
         BMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935356; x=1726540156;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMpP/BeX9sULLuqaiDSEQp87PU3BsZjmiWXIXZZTv0I=;
        b=P9mtyf7Isq4tbyxhAZ+UGDTvlxeojqCWwoSsHJ5pAP9mQHgTz7glqhGQ4g28xeFjWG
         8k9mr0UarOYULO434/05BDcOkUDmpNjKeXJHHLxbl3iRbH07w0t4w1xz1W/qejBsrkDr
         VHpScTfo7t2/8mOTGlvqR4s/lfYW4TEbOUc79PyJdNAiGKJXIzvSuddsDO6IGkCz2FtY
         0xsUHwzJ627FtJ5Dl1mFd1shOqHJtXSTUmP7kWYVNpA4bhG05VAwwX2FaWXZiP5DfdZn
         nBdakwtwZed40LOqbYwsXfO4wTmIlHI1TV2loWC7zM0uZbtO24BCxNYT7hM7Wd2ajMcQ
         V4qg==
X-Gm-Message-State: AOJu0Yx2Zn/1g+vFF0Y2VzNGqDVmdlvnl2iDjLcppw7BP7nIfqM6WmJ+
	+aGGuqpnjHMO8xUS65kOJt32s4lcRYBjxTRYrqqVj2/awSu8Fiqq2o0ZeQ==
X-Google-Smtp-Source: AGHT+IEEZCB61l66b9Cts+iPAG7zacznUPZCX+lD4eIQU0sJcJHy2rFghn+0jP28NjvylpDL4mS9TA==
X-Received: by 2002:a17:907:940a:b0:a8a:83e9:43e2 with SMTP id a640c23a62f3a-a8a885bdf9emr937945466b.12.1725935356321;
        Mon, 09 Sep 2024 19:29:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2598b85bsm413200666b.77.2024.09.09.19.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:15 -0700 (PDT)
Message-Id: <78168d98bfc0df7151eac5280e12b95c9fb694ec.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:44 +0000
Subject: [PATCH 19/30] path-walk: add prune_all_uninteresting option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This option causes the path-walk API to act like the sparse tree-walk
algorithm implemented by mark_trees_uninteresting_sparse() in
list-objects.c.

Starting from the commits marked as UNINTERESTING, their root trees and
all objects reachable from those trees are UNINTERSTING, at least as we
walk path-by-path. When we reach a path where all objects associated
with that path are marked UNINTERESTING, then do no continue walking the
children of that path.

We need to be careful to pass the UNINTERESTING flag in a deep way on
the UNINTERESTING objects before we start the path-walk, or else the
depth-first search for the path-walk API may accidentally report some
objects as interesting.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 path-walk.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 path-walk.h |  8 +++++++
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/path-walk.c b/path-walk.c
index 65f9856afa2..08de29614f7 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -23,6 +23,7 @@ struct type_and_oid_list
 {
 	enum object_type type;
 	struct oid_array oids;
+	int maybe_interesting;
 };
 
 #define TYPE_AND_OID_LIST_INIT { \
@@ -139,6 +140,9 @@ static int add_children(struct path_walk_context *ctx,
 			list->type = type;
 			strmap_put(&ctx->paths_to_lists, path.buf, list);
 			string_list_append(&ctx->path_stack, path.buf);
+
+			if (!(o->flags & UNINTERESTING))
+				list->maybe_interesting = 1;
 		}
 		oid_array_append(&list->oids, &entry.oid);
 	}
@@ -161,6 +165,40 @@ static int walk_path(struct path_walk_context *ctx,
 
 	list = strmap_get(&ctx->paths_to_lists, path);
 
+	if (ctx->info->prune_all_uninteresting) {
+		/*
+		 * This is true if all objects were UNINTERESTING
+		 * when added to the list.
+		 */
+		if (!list->maybe_interesting)
+			return 0;
+
+		/*
+		 * But it's still possible that the objects were set
+		 * as UNINTERESTING after being added. Do a quick check.
+		 */
+		list->maybe_interesting = 0;
+		for (size_t i = 0;
+		     !list->maybe_interesting && i < list->oids.nr;
+		     i++) {
+			if (list->type == OBJ_TREE) {
+				struct tree *t = lookup_tree(ctx->repo,
+							     &list->oids.oid[i]);
+				if (t && !(t->object.flags & UNINTERESTING))
+					list->maybe_interesting = 1;
+			} else {
+				struct blob *b = lookup_blob(ctx->repo,
+							     &list->oids.oid[i]);
+				if (b && !(b->object.flags & UNINTERESTING))
+					list->maybe_interesting = 1;
+			}
+		}
+
+		/* We have confirmed that all objects are UNINTERESTING. */
+		if (!list->maybe_interesting)
+			return 0;
+	}
+
 	/* Evaluate function pointer on this data, if requested. */
 	if ((list->type == OBJ_TREE && ctx->info->trees) ||
 	    (list->type == OBJ_BLOB && ctx->info->blobs))
@@ -203,7 +241,7 @@ static void clear_strmap(struct strmap *map)
 int walk_objects_by_path(struct path_walk_info *info)
 {
 	const char *root_path = "";
-	int ret = 0;
+	int ret = 0, has_uninteresting = 0;
 	size_t commits_nr = 0, paths_nr = 0;
 	struct commit *c;
 	struct type_and_oid_list *root_tree_list;
@@ -215,6 +253,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 		.path_stack = STRING_LIST_INIT_DUP,
 		.paths_to_lists = STRMAP_INIT
 	};
+	struct oidset root_tree_set = OIDSET_INIT;
 
 	struct oid_array tagged_tree_list = OID_ARRAY_INIT;
 	struct oid_array tagged_blob_list = OID_ARRAY_INIT;
@@ -227,7 +266,9 @@ int walk_objects_by_path(struct path_walk_info *info)
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
+	root_tree_list->maybe_interesting = 1;
 	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
+
 	if (prepare_revision_walk(info->revs))
 		die(_("failed to setup revision walk"));
 
@@ -247,11 +288,17 @@ int walk_objects_by_path(struct path_walk_info *info)
 		oid = get_commit_tree_oid(c);
 		t = lookup_tree(info->revs->repo, oid);
 
-		if (t)
+		if (t) {
+			oidset_insert(&root_tree_set, oid);
 			oid_array_append(&root_tree_list->oids, oid);
-		else
+		} else {
 			warning("could not find tree %s", oid_to_hex(oid));
+		}
 
+		if (t && (c->object.flags & UNINTERESTING)) {
+			t->object.flags |= UNINTERESTING;
+			has_uninteresting = 1;
+		}
 	}
 
 	trace2_data_intmax("path-walk", ctx.repo, "commits", commits_nr);
@@ -318,6 +365,21 @@ int walk_objects_by_path(struct path_walk_info *info)
 		oid_array_clear(&tagged_blob_list);
 	}
 
+	/*
+	 * Before performing a DFS of our paths and emitting them as interesting,
+	 * do a full walk of the trees to distribute the UNINTERESTING bit. Use
+	 * the sparse algorithm if prune_all_uninteresting was set.
+	 */
+	if (has_uninteresting) {
+		trace2_region_enter("path-walk", "uninteresting-walk", info->revs->repo);
+		if (info->prune_all_uninteresting)
+			mark_trees_uninteresting_sparse(ctx.repo, &root_tree_set);
+		else
+			mark_trees_uninteresting_dense(ctx.repo, &root_tree_set);
+		trace2_region_leave("path-walk", "uninteresting-walk", info->revs->repo);
+	}
+	oidset_clear(&root_tree_set);
+
 	string_list_append(&ctx.path_stack, root_path);
 
 	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
diff --git a/path-walk.h b/path-walk.h
index 637d3b0cabb..7c02bca7156 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -50,6 +50,14 @@ struct path_walk_info {
 	 * the sparse-checkout patterns.
 	 */
 	struct pattern_list *pl;
+
+	/**
+	 * When 'prune_all_uninteresting' is set and a path has all objects
+	 * marked as UNINTERESTING, then the path-walk will not visit those
+	 * objects. It will not call path_fn on those objects and will not
+	 * walk the children of such trees.
+	 */
+	int prune_all_uninteresting;
 };
 
 #define PATH_WALK_INFO_INIT {   \
-- 
gitgitgadget

