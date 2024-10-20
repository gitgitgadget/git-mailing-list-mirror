Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576B1922C4
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431819; cv=none; b=hX1xj+m2iqvKJtPDcXG5DrIqgHGLrPlPSWGF51n97ZRp5aHeltZq5SD/593mcUEudKJFpkuWah3x3jEUhl5qpLAPYJTycASyxPGbIPgF53C9N0vVTR40eaSLvb5zhv+MafXg41pdELJaoxQ8Vsuhv3ArZfU3PwwYml+xMnBGBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431819; c=relaxed/simple;
	bh=3RFrCpMyIeHwWLPS6FhFaejRqzgyAuxob4aFUYg9mHg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GVCUgJtABpNtSnyybTxFtIj9UKehAIZoG2gsKz6o5D5wAGM/3ncpyUzh/Z6hV0Pw7elTscikN67jY8ar3LE4M5rpyoIvVcK4/FenfkrmI9Fi4qBXj9rKiZC6XTy/C2/DfeSjz26hba7Z81rwLbnLdKAd2CnK/TiFB3xwvIG9uD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRva8AUd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRva8AUd"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so599858066b.1
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431814; x=1730036614; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVcW7vVL9aO5GkPyipqtIhpIRCh8ACMxU0E0nCA63JA=;
        b=fRva8AUdoX2U+Wkb6T5YO3B5nqBCkyIrfJJ67IW5VkdnvpDXyQi844BmW2yjxcdDyp
         Pg5766N+ddpF93gT6PJATDBUcdGJK71oThP3ZVnuQazhn9LDEvXagUgmjSaScBFAa4Nx
         s7nZ6cKxzvs/6pLEfGcaqf0ZPURqzKvXEvqNEa0MAhX0oAVt+WlfZeb60SHEC/X3cqEJ
         OJAggUow1grpKq6CSTlhnDxuU9Blx2h+/Hb7hXp9/Shi1DyhwURhmzguMJ7enhndTcxK
         fMWspBXHUqjKKcPaA+hNIoXeL0qVpqPoy97kCeKR3wy1DOwEsPaP9iu70HeH72uIZQp8
         ex+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431814; x=1730036614;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVcW7vVL9aO5GkPyipqtIhpIRCh8ACMxU0E0nCA63JA=;
        b=kd6xCyXAggyHmjEyVcpG+TIvdr/5Issz8jznP4lWcD5Ly+2fiRKv+Sl+EKB6kG5uhx
         nyTXh7Onq8fRpefxhHAT6K4MFEjvY82lSz364bHrNknI+j9fqEOdJW0S2/5XTxGU6O30
         PMNdVqse8WFJ/PrlSU2vIGZ55mlE6imy3Rkg3EYEK0OBhi57kZzgIxYKIjBYTB8rk5FU
         8gmly0YZg8gHUH9pRpp052kkn+NuwPg5h4NJ/J2PRB/PJG1Tg2CE8Sbfb2Tttnt7OE6V
         Q9U+f/HVgNoFYr2XncHIQmPm+M8BzbAU7WCjshslmHH82vRUbD6NRWS0OEIBSIfM2DZH
         qy6g==
X-Gm-Message-State: AOJu0YwnfpFZtNZhCfQac+l2DYjKc+TJqqh/Rfn0WInt1TZsdXLq6pbG
	QYAneezBWR9ILX+KkDWz0A7gGATBMYvLeNpO6qJyltaH+6bXrGjlaTiVUQ==
X-Google-Smtp-Source: AGHT+IGEfG68dRoUtC2bTmuw3KY98RLST7HQcJPkeeHodwWf4B9KcofpLeHKFjFjp4fuOWaLJBKl4g==
X-Received: by 2002:a17:907:97cb:b0:a9a:33c:f6e4 with SMTP id a640c23a62f3a-a9a69c9eb72mr841046566b.40.1729431813928;
        Sun, 20 Oct 2024 06:43:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e9csm91655366b.136.2024.10.20.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:33 -0700 (PDT)
Message-Id: <98bdc94a773d797152bebfbfda88fa1bb0707821.1729431810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:14 +0000
Subject: [PATCH v2 01/17] path-walk: introduce an object walk by path
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
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In anticipation of a few planned applications, introduce the most basic form
of a path-walk API. It currently assumes that there are no UNINTERESTING
objects and does not include any complicated filters. It calls a function
pointer on groups of tree and blob objects as grouped by path. This only
includes objects the first time they are discovered, so an object that
appears at multiple paths will not be included in two batches.

There are many future adaptations that could be made, but they are left for
future updates when consumers are ready to take advantage of those features.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |  54 +++++
 Makefile                                  |   1 +
 path-walk.c                               | 241 ++++++++++++++++++++++
 path-walk.h                               |  43 ++++
 4 files changed, 339 insertions(+)
 create mode 100644 Documentation/technical/api-path-walk.txt
 create mode 100644 path-walk.c
 create mode 100644 path-walk.h

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
new file mode 100644
index 00000000000..6472222ae6d
--- /dev/null
+++ b/Documentation/technical/api-path-walk.txt
@@ -0,0 +1,54 @@
+Path-Walk API
+=============
+
+The path-walk API is used to walk reachable objects, but to visit objects
+in batches based on a common path they appear in, or by type.
+
+For example, all reachable commits are visited in a group. All tags are
+visited in a group. Then, all root trees are visited. At some point, all
+blobs reachable via a path `my/dir/to/A` are visited. When there are
+multiple paths possible to reach the same object, then only one of those
+paths is used to visit the object.
+
+When walking a range of commits with some `UNINTERESTING` objects, the
+objects with the `UNINTERESTING` flag are included in these batches. In
+order to walk `UNINTERESTING` objects, the `--boundary` option must be
+used in the commit walk in order to visit `UNINTERESTING` commits.
+
+Basics
+------
+
+To use the path-walk API, include `path-walk.h` and call
+`walk_objects_by_path()` with a customized `path_walk_info` struct. The
+struct is used to set all of the options for how the walk should proceed.
+Let's dig into the different options and their use.
+
+`path_fn` and `path_fn_data`::
+	The most important option is the `path_fn` option, which is a
+	function pointer to the callback that can execute logic on the
+	object IDs for objects grouped by type and path. This function
+	also receives a `data` value that corresponds to the
+	`path_fn_data` member, for providing custom data structures to
+	this callback function.
+
+`revs`::
+	To configure the exact details of the reachable set of objects,
+	use the `revs` member and initialize it using the revision
+	machinery in `revision.h`. Initialize `revs` using calls such as
+	`setup_revisions()` or `parse_revision_opt()`. Do not call
+	`prepare_revision_walk()`, as that will be called within
+	`walk_objects_by_path()`.
++
+It is also important that you do not specify the `--objects` flag for the
+`revs` struct. The revision walk should only be used to walk commits, and
+the objects will be walked in a separate way based on those starting
+commits.
++
+If you want the path-walk API to emit `UNINTERESTING` objects based on the
+commit walk's boundary, be sure to set `revs.boundary` so the boundary
+commits are emitted.
+
+Examples
+--------
+
+See example usages in future changes.
diff --git a/Makefile b/Makefile
index 7344a7f7257..d0d8d6888e3 100644
--- a/Makefile
+++ b/Makefile
@@ -1094,6 +1094,7 @@ LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
+LIB_OBJS += path-walk.o
 LIB_OBJS += pathspec.o
 LIB_OBJS += pkt-line.o
 LIB_OBJS += preload-index.o
diff --git a/path-walk.c b/path-walk.c
new file mode 100644
index 00000000000..66840187e28
--- /dev/null
+++ b/path-walk.c
@@ -0,0 +1,241 @@
+/*
+ * path-walk.c: implementation for path-based walks of the object graph.
+ */
+#include "git-compat-util.h"
+#include "path-walk.h"
+#include "blob.h"
+#include "commit.h"
+#include "dir.h"
+#include "hashmap.h"
+#include "hex.h"
+#include "object.h"
+#include "oid-array.h"
+#include "revision.h"
+#include "string-list.h"
+#include "strmap.h"
+#include "trace2.h"
+#include "tree.h"
+#include "tree-walk.h"
+
+struct type_and_oid_list
+{
+	enum object_type type;
+	struct oid_array oids;
+};
+
+#define TYPE_AND_OID_LIST_INIT { \
+	.type = OBJ_NONE, 	 \
+	.oids = OID_ARRAY_INIT	 \
+}
+
+struct path_walk_context {
+	/**
+	 * Repeats of data in 'struct path_walk_info' for
+	 * access with fewer characters.
+	 */
+	struct repository *repo;
+	struct rev_info *revs;
+	struct path_walk_info *info;
+
+	/**
+	 * Map a path to a 'struct type_and_oid_list'
+	 * containing the objects discovered at that
+	 * path.
+	 */
+	struct strmap paths_to_lists;
+
+	/**
+	 * Store the current list of paths in a stack, to
+	 * facilitate depth-first-search without recursion.
+	 */
+	struct string_list path_stack;
+};
+
+static int add_children(struct path_walk_context *ctx,
+			const char *base_path,
+			struct object_id *oid)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct strbuf path = STRBUF_INIT;
+	size_t base_len;
+	struct tree *tree = lookup_tree(ctx->repo, oid);
+
+	if (!tree) {
+		error(_("failed to walk children of tree %s: not found"),
+		      oid_to_hex(oid));
+		return -1;
+	} else if (parse_tree_gently(tree, 1)) {
+		die("bad tree object %s", oid_to_hex(oid));
+	}
+
+	strbuf_addstr(&path, base_path);
+	base_len = path.len;
+
+	parse_tree(tree);
+	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
+	while (tree_entry(&desc, &entry)) {
+		struct type_and_oid_list *list;
+		struct object *o;
+		/* Not actually true, but we will ignore submodules later. */
+		enum object_type type = S_ISDIR(entry.mode) ? OBJ_TREE : OBJ_BLOB;
+
+		/* Skip submodules. */
+		if (S_ISGITLINK(entry.mode))
+			continue;
+
+		if (type == OBJ_TREE) {
+			struct tree *child = lookup_tree(ctx->repo, &entry.oid);
+			o = child ? &child->object : NULL;
+		} else if (type == OBJ_BLOB) {
+			struct blob *child = lookup_blob(ctx->repo, &entry.oid);
+			o = child ? &child->object : NULL;
+		} else {
+			/* Wrong type? */
+			continue;
+		}
+
+		if (!o) /* report error?*/
+			continue;
+
+		/* Skip this object if already seen. */
+		if (o->flags & SEEN)
+			continue;
+		o->flags |= SEEN;
+
+		strbuf_setlen(&path, base_len);
+		strbuf_add(&path, entry.path, entry.pathlen);
+
+		/*
+		 * Trees will end with "/" for concatenation and distinction
+		 * from blobs at the same path.
+		 */
+		if (type == OBJ_TREE)
+			strbuf_addch(&path, '/');
+
+		if (!(list = strmap_get(&ctx->paths_to_lists, path.buf))) {
+			CALLOC_ARRAY(list, 1);
+			list->type = type;
+			strmap_put(&ctx->paths_to_lists, path.buf, list);
+			string_list_append(&ctx->path_stack, path.buf);
+		}
+		oid_array_append(&list->oids, &entry.oid);
+	}
+
+	free_tree_buffer(tree);
+	strbuf_release(&path);
+	return 0;
+}
+
+/*
+ * For each path in paths_to_explore, walk the trees another level
+ * and add any found blobs to the batch (but only if they exist and
+ * haven't been added yet).
+ */
+static int walk_path(struct path_walk_context *ctx,
+		     const char *path)
+{
+	struct type_and_oid_list *list;
+	int ret = 0;
+
+	list = strmap_get(&ctx->paths_to_lists, path);
+
+	/* Evaluate function pointer on this data. */
+	ret = ctx->info->path_fn(path, &list->oids, list->type,
+				 ctx->info->path_fn_data);
+
+	/* Expand data for children. */
+	if (list->type == OBJ_TREE) {
+		for (size_t i = 0; i < list->oids.nr; i++) {
+			ret |= add_children(ctx,
+					    path,
+					    &list->oids.oid[i]);
+		}
+	}
+
+	oid_array_clear(&list->oids);
+	strmap_remove(&ctx->paths_to_lists, path, 1);
+	return ret;
+}
+
+static void clear_strmap(struct strmap *map)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	hashmap_for_each_entry(&map->map, &iter, e, ent) {
+		struct type_and_oid_list *list = e->value;
+		oid_array_clear(&list->oids);
+	}
+	strmap_clear(map, 1);
+	strmap_init(map);
+}
+
+/**
+ * Given the configuration of 'info', walk the commits based on 'info->revs' and
+ * call 'info->path_fn' on each discovered path.
+ *
+ * Returns nonzero on an error.
+ */
+int walk_objects_by_path(struct path_walk_info *info)
+{
+	const char *root_path = "";
+	int ret = 0;
+	size_t commits_nr = 0, paths_nr = 0;
+	struct commit *c;
+	struct type_and_oid_list *root_tree_list;
+	struct path_walk_context ctx = {
+		.repo = info->revs->repo,
+		.revs = info->revs,
+		.info = info,
+		.path_stack = STRING_LIST_INIT_DUP,
+		.paths_to_lists = STRMAP_INIT
+	};
+
+	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
+
+	/* Insert a single list for the root tree into the paths. */
+	CALLOC_ARRAY(root_tree_list, 1);
+	root_tree_list->type = OBJ_TREE;
+	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
+
+	if (prepare_revision_walk(info->revs))
+		die(_("failed to setup revision walk"));
+
+	while ((c = get_revision(info->revs))) {
+		struct object_id *oid = get_commit_tree_oid(c);
+		struct tree *t = lookup_tree(info->revs->repo, oid);
+		commits_nr++;
+
+		if (t) {
+			if (t->object.flags & SEEN)
+				continue;
+			t->object.flags |= SEEN;
+			oid_array_append(&root_tree_list->oids, oid);
+		} else {
+			warning("could not find tree %s", oid_to_hex(oid));
+		}
+	}
+
+	trace2_data_intmax("path-walk", ctx.repo, "commits", commits_nr);
+	trace2_region_leave("path-walk", "commit-walk", info->revs->repo);
+
+	string_list_append(&ctx.path_stack, root_path);
+
+	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
+	while (!ret && ctx.path_stack.nr) {
+		char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;
+		ctx.path_stack.nr--;
+		paths_nr++;
+
+		ret = walk_path(&ctx, path);
+
+		free(path);
+	}
+	trace2_data_intmax("path-walk", ctx.repo, "paths", paths_nr);
+	trace2_region_leave("path-walk", "path-walk", info->revs->repo);
+
+	clear_strmap(&ctx.paths_to_lists);
+	string_list_clear(&ctx.path_stack, 0);
+	return ret;
+}
diff --git a/path-walk.h b/path-walk.h
new file mode 100644
index 00000000000..c9e94a98bc8
--- /dev/null
+++ b/path-walk.h
@@ -0,0 +1,43 @@
+/*
+ * path-walk.h : Methods and structures for walking the object graph in batches
+ * by the paths that can reach those objects.
+ */
+#include "object.h" /* Required for 'enum object_type'. */
+
+struct rev_info;
+struct oid_array;
+
+/**
+ * The type of a function pointer for the method that is called on a list of
+ * objects reachable at a given path.
+ */
+typedef int (*path_fn)(const char *path,
+		       struct oid_array *oids,
+		       enum object_type type,
+		       void *data);
+
+struct path_walk_info {
+	/**
+	 * revs provides the definitions for the commit walk, including
+	 * which commits are UNINTERESTING or not.
+	 */
+	struct rev_info *revs;
+
+	/**
+	 * The caller wishes to execute custom logic on objects reachable at a
+	 * given path. Every reachable object will be visited exactly once, and
+	 * the first path to see an object wins. This may not be a stable choice.
+	 */
+	path_fn path_fn;
+	void *path_fn_data;
+};
+
+#define PATH_WALK_INFO_INIT { 0 }
+
+/**
+ * Given the configuration of 'info', walk the commits based on 'info->revs' and
+ * call 'info->path_fn' on each discovered path.
+ *
+ * Returns nonzero on an error.
+ */
+int walk_objects_by_path(struct path_walk_info *info);
-- 
gitgitgadget

