Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6D01C54A6
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514366; cv=none; b=f9GLKoV3b8JF1j5M57QGR/1O/KHLKybPzz6yuDvalBVkWllfGDSgkxrLYH2qfJsuT+JSmh10KRPteWG3Y2Rfwtoeryr2cZQ39HQ6HJS9QC4PMgjrMyJb59ebwgy0zbW5w9iSvuCweBw0lAAsEEgM2wDxViyfki8eLaDkX5eCXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514366; c=relaxed/simple;
	bh=mWCDxlnP4EA2cwrSuexeAkVHBa3RaAcqfYITfHPTG08=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BXVl8SbBy/S4AKS2tedIM0rgchFjubOmthFuJts4g+9h2Y0R9Q+h7W5fEiRZAr2dCYncJuProPUwmB8lQvZEqYFw22KjqPyUBMwcpQ/1+QConXBbeZ0RM3jR5OBipx3V+uzjWDg4i8yREULQmG6x+/LFu7GNsrqV9VdnBGxNH/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8MyBCHj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8MyBCHj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso16521945e9.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 11:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733514362; x=1734119162; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqI0dMIvJko0v5Cd1bI1d5v5tx3+K8n6axocKDPWY+Q=;
        b=X8MyBCHjQdasIX+Wf8fD0j2FDqWOIA+AVWT++ltR9x8QQp/jSw1ohnau6wn1/3w0x5
         08ihVSFFNQX7dN1vTZwq7USOK+xBCVvHd8y4fp3UAUcFE/9iXQlI7QlybTm7INCC78/i
         w60C4qgwMoDuT9n+bbuGwJIlq+jRGKEN7gIrZnLhViqsnAVwz5Ibkn4nA8bgSIk///Nl
         WiP2dEHiHhzH2v7ibpqI6HUaAPatcbWI4RJ6eKZ6Kfeq2FmqsufwPAum4IbqbcikZxyK
         rpYQc56nYgnQQSBUwtPnZbIqWSEnUg3naC0k3LnJcRU5XcGQ1jzA6KGT48lkvVWeiGV3
         aziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514362; x=1734119162;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqI0dMIvJko0v5Cd1bI1d5v5tx3+K8n6axocKDPWY+Q=;
        b=X2oUPqZCLIdmghUKySgmoFSqr26XKAuhb0KOONgJVgc+cWMe1e8P6Kkte2t8xBrDuK
         IoK3bo+aZfjacdTSu0jaJZ9ft5Em7N6qziV5HzEA4G/gLwCQ+1EXRSuw8YqMVWq3r7Ia
         NTRMBztx11BEoDibnBf4aGtPoiNy8ZEqWKT4uFS1KjUpzelVred3B5i/LpTjD2mi/sXS
         DUECjzC+Off21nEOrwFBgSzrMwYccc9Vai0dCsVJ7FAocs/lWcOlHgFnTX0BufC43sF7
         MouGrKL1eS1GgRk1HhDTww9DxI5dbtbBInFnJZXChqyBUtGdkWk0xYeG8hSvDM4uZrYV
         P6qQ==
X-Gm-Message-State: AOJu0Yw0Wt8sA/mG01zbBscoNwt6MaLhY3TyapsbDQRYQqvWU270/uPW
	MkStaCPBhrZEsc6xno//8fOrm0LO1x9ItXH7U/e0/NIfxxRAKakLp8to0g==
X-Gm-Gg: ASbGncvyhRgMJ9bisVpgG1dtkv7dki0YUps0OVUjYsbQagfYdaA43gh13tlAcdLpl2Z
	jkhl56gNfUidEEcSgSHg/HnD/dvMmMG1onScMh/TxJ7Qe/fyJRT92wQgdHYdMNjb5xrXvgo31ee
	Kz9NrSuilXbxNj/hF3M1gZRKLyLL+c7r2+woCuHe/aBHC3+QN39kYLfN35dQEOxpgFT1JQ2a4Ir
	srluDs29PBxUY9y6ufopsMnZTw2UfejLV7Vf+8g1IPn8/Egrtk=
X-Google-Smtp-Source: AGHT+IEvOuSCaL90FaTiqRMidKYhk7oiG7U1BzgqawWIHLexoi9Vo62FfnMoMICmmCda6KeyWHwzkg==
X-Received: by 2002:a05:6000:481e:b0:385:eed9:cbca with SMTP id ffacd0b85a97d-3862b364148mr3262990f8f.27.1733514361809;
        Fri, 06 Dec 2024 11:46:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273131sm101597915e9.12.2024.12.06.11.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:46:01 -0800 (PST)
Message-Id: <b7e9b81e8b32313f00d38257ba731e73d17224cb.1733514358.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
	<pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 19:45:52 +0000
Subject: [PATCH v3 1/7] path-walk: introduce an object walk by path
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
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In anticipation of a few planned applications, introduce the most basic form
of a path-walk API. It currently assumes that there are no UNINTERESTING
objects, and does not include any complicated filters. It calls a function
pointer on groups of tree and blob objects as grouped by path. This only
includes objects the first time they are discovered, so an object that
appears at multiple paths will not be included in two batches.

These batches are collected in 'struct type_and_oid_list' objects, which
store an object type and an oid_array of objects.

The data structures are documented in 'struct path_walk_context', but in
summary the most important are:

  * 'paths_to_lists' is a strmap that connects a path to a
    type_and_oid_list for that path. To avoid conflicts in path names,
    we make sure that tree paths end in "/" (except the root path with
    is an empty string) and blob paths do not end in "/".

  * 'path_stack' is a string list that is added to in an append-only
    way. This stores the stack of our depth-first search on the heap
    instead of using recursion.

  * 'path_stack_pushed' is a strmap that stores path names that were
    already added to 'path_stack', to avoid repeating paths in the
    stack. Mostly, this saves us from quadratic lookups from doing
    unsorted checks into the string_list.

The coupling of 'path_stack' and 'path_stack_pushed' is protected by the
push_to_stack() method. Call this instead of inserting into these
structures directly.

The walk_objects_by_path() method initializes these structures and
starts walking commits from the given rev_info struct. The commits are
used to find the list of root trees which populate the start of our
depth-first search.

The core of our depth-first search is in a while loop that continues
while we have not indicated an early exit and our 'path_stack' still has
entries in it. The loop body pops a path off of the stack and "visits"
the path via the walk_path() method.

The walk_path() method gets the list of OIDs from the 'path_to_lists'
strmap and executes the callback method on that list with the given path
and type. If the OIDs correspond to tree objects, then iterate over all
trees in the list and run add_children() to add the child objects to
their own lists, adding new entries to the stack if necessary.

In testing, this depth-first search approach was the one that used the
least memory while iterating over the object lists. There is still a
chance that repositories with too-wide path patterns could cause memory
pressure issues. Limiting the stack size could be done in the future by
limiting how many objects are being considered in-progress, or by
visiting blob paths earlier than trees.

There are many future adaptations that could be made, but they are left for
future updates when consumers are ready to take advantage of those features.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |  45 ++++
 Makefile                                  |   1 +
 path-walk.c                               | 263 ++++++++++++++++++++++
 path-walk.h                               |  43 ++++
 4 files changed, 352 insertions(+)
 create mode 100644 Documentation/technical/api-path-walk.txt
 create mode 100644 path-walk.c
 create mode 100644 path-walk.h

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
new file mode 100644
index 00000000000..c550c77ca30
--- /dev/null
+++ b/Documentation/technical/api-path-walk.txt
@@ -0,0 +1,45 @@
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
index 00000000000..24cf04c1e7d
--- /dev/null
+++ b/path-walk.c
@@ -0,0 +1,263 @@
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
+	 *
+	 * Use path_stack_pushed to indicate whether a path
+	 * was previously added to path_stack.
+	 */
+	struct string_list path_stack;
+	struct strset path_stack_pushed;
+};
+
+static void push_to_stack(struct path_walk_context *ctx,
+			  const char *path)
+{
+	if (strset_contains(&ctx->path_stack_pushed, path))
+		return;
+
+	strset_add(&ctx->path_stack_pushed, path);
+	string_list_append(&ctx->path_stack, path);
+}
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
+		}
+		push_to_stack(ctx, path.buf);
+
+		/* Skip this object if already seen. */
+		if (o->flags & SEEN)
+			continue;
+		o->flags |= SEEN;
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
+	if (!list->oids.nr)
+		return 0;
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
+		.path_stack_pushed = STRSET_INIT,
+		.paths_to_lists = STRMAP_INIT
+	};
+
+	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
+
+	/* Insert a single list for the root tree into the paths. */
+	CALLOC_ARRAY(root_tree_list, 1);
+	root_tree_list->type = OBJ_TREE;
+	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
+	push_to_stack(&ctx, root_path);
+
+	if (prepare_revision_walk(info->revs))
+		die(_("failed to setup revision walk"));
+
+	while ((c = get_revision(info->revs))) {
+		struct object_id *oid = get_commit_tree_oid(c);
+		struct tree *t;
+		commits_nr++;
+
+		oid = get_commit_tree_oid(c);
+		t = lookup_tree(info->revs->repo, oid);
+
+		if (!t) {
+			warning("could not find tree %s", oid_to_hex(oid));
+			continue;
+		}
+
+		if (t->object.flags & SEEN)
+			continue;
+		t->object.flags |= SEEN;
+		oid_array_append(&root_tree_list->oids, oid);
+	}
+
+	trace2_data_intmax("path-walk", ctx.repo, "commits", commits_nr);
+	trace2_region_leave("path-walk", "commit-walk", info->revs->repo);
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
+	strset_clear(&ctx.path_stack_pushed);
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

