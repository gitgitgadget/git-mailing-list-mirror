Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5030E49E13D
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105919; cv=none; b=FtTQYw8plywVLVLFCa1yg8UXBuNugnxOsKNCrOJeHei1vn5Qx6ZT8FjFcq5inuYnc4oZa6PXxglZa4+Q4zb4hdfH6zB0/OgOXAu+rC/bCf+hhkskfx198mWsCs8iOUtZngQhHchWiTkkjPo4zefdVvQFtgerE66HqNR5KQY8icI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105919; c=relaxed/simple;
	bh=TtTjNJjhCOPRyg0KW2VQr2OLqQZo22T1uhlzwmnu1CI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3qKgXkqEnEGR7L47oZGtYxAozMqh/u/CxKUx+zNQfNK4pkCQjs2HzmyzQYp528FPbmGKkwRzDu/t9pv5UtOh5CUjF5IEZSJtPudhoh86fkKnCwEQ79ppueoYpbPiaU+FdRKg3nnJrb+wIjLe5ZlTowGzg2v0XHixKT5nECLzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WERSqgSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZjlNCYLK; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WERSqgSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZjlNCYLK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B79EC1400166;
	Fri, 11 Sep 2026 01:51:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 01:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105914;
	 x=1789192314; bh=hGRybzOYyUv4QogMWSCy/aj11tDviPR2nSzc/DOmmzk=; b=
	WERSqgSBLo32lESdfyHUn768XtDN99t/PmC2Y/Musec7JEk3vju1yGo6iQ90X8eC
	zqoy6klhvGjIj/OYbqtjbMO+axRNjlMNGhBHT6mTORkZ1Wp18LDfifpo6412Tt6f
	7nZdsMVjMntjPW0/whXryaNBKz6ltJsBEZUSjNZOyP9PFkgPFZx/FcSHuIhFC2SM
	/0M43FxnMs/iw2rsZYNogdb/XMXe76CpQZPLPioiPOYA6mnl45JcsuGT5dd5RuMS
	nW0kCU4sUhguHX227wltNYm5AngbBCv+Y8bfhcPWgEJE2SwF9UzpOFZhTbB0/zjz
	SECGNe3e3PQv9vMxfrByhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105914; x=
	1789192314; bh=hGRybzOYyUv4QogMWSCy/aj11tDviPR2nSzc/DOmmzk=; b=Z
	jlNCYLKEbNVGebeYmAs9471LOKgyZb0GBScs5BFkws+ZZb2IoVkzKTiYwXoVxDHL
	lEF9eVwpy8nmSjQIuecATkJEQCBoqBN6OlTEVMY6em3ljyyQ2ufC7ViN5Kn8pjZL
	zpedtZn9CHH4+LUc0NYUgMgvHo2rPjr0a0U6zsyiUhQSeAJ5A1kTFfA/fEQcAtFG
	KWdLYQcmFUA1WeUuiiLsDERSjhQ4asgMM5sl66WkN8qKKknhjYtiHX9kHuh2DCtd
	ZnXVdQDNCjFnOl2Um3ftGs8hqyLFQFu2MMJVJHOqraYIeRyVAwdbYI4CfOUOWSZK
	YhqRuMm5NShMXAya2zBaQ==
X-ME-Sender: <xms:-pajag1K0AX6FBnGV57GMm4uBF28Vk2ED1X5j78p0GRSCWOwqpd7qA>
    <xme:-pajaigtBdiFILWAPTDcnQEHQxp2-PZcXFE50O6TqoLdWBQUChp0lbeRnAxF0k6YO
    Az4vcv_YtvdARcvaTM6jz4pMGgwP9w1OSBPHD2CWzLDJ99rn5DXUX0>
X-ME-Received: <xmr:-pajamQyJCYHJugWcs0vrW88kPi82xAhBT1-YUDYU4SQKqt_thGty4OPmSQWPDRW9mqz2w>
X-ME-Proxy-Cause: dmFkZTGqDaxbQw0b1XGVch0RkJ4AYeStw4PVBa3bcgIhUpfXL1D6qKF9ClM/osX1kPXWWN
    hZ0NT40O+O16tVxkmUBWLrsXM7cDu3P8G5BMeU4gYimHiWjnabaEVtKRxcG1l+2SA3fruH
    qRnh0hjRkfKPwown19wLAyxIYGG+i0Wl5FE/Rbkq7YeNsUHxZujxfc278JFrX8fxdGcQMU
    Zqn/M9ArmY/+TRmYrIr63NgZ71so+SD7J52GrLBaP6PmZ+zA3ndtkL/5Qn8hU7ZeHPpzWW
    4ssHe4DDpJmHyk40v0a080QSCBc1X3HpUYZkVeLrhRzkJxHahEsdvtwfsiDQ/CzxZ/A8OC
    yLzBXJGTkUhzEqNSq3XTxNOgHsCsInHvBjz1TrN3SOv6kNlbLOIX2ceyBCppu2UTNpzLb7
    BqLc4gE1rfIIrBgCJgp4qY8V0smvhX85VToxkJ14g3k+xrTo4jl2rSp5OVyPtZQxM6KJFk
    p1VpRbHL2rMqSQOdMMWipxGkIDvvBC5Nc2mOdp5kGs/mRuayt/Zq6E4jmeKHwFX3fBz3Yo
    6nzD9fec+/a8bglv0SNaCuPinT7DM9hYM2ioVCmrf26Ec1I2BNk/fS1HgUCIOAW4ARYYxu
    YbP2m/tLo5GW59VTZgty0246edr5V7gT8rPDsZXwirj/vt7ZE55FkHE29PsA
X-ME-Proxy: <xmx:-pajajjQqdffsUmG0gLXMYgYBJp-y6qdrsn7ckflQjxtg2248TfpmQ>
    <xmx:-pajam5zYVLrNeyUQPWZ98BmQkghydirbi1ASafucAyc1GsKbHg3UQ>
    <xmx:-pajagB7LHnlcaYjrjT6Fxag8WTb2hmfs_TIkoo2Jnw9Oz9Ew9QS8A>
    <xmx:-pajatZoRWB8-Cyu6bDrCOv8E3s80BNFC6DSSOZbWiXAmUaAyHqZ6w>
    <xmx:-pajamjZVz1ZYa7M1VW9CrqYbobiOZkVnsk05uwudQe4mQlIRK2txuLT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:51:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0cc7d70a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:51:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:45 +0200
Subject: [PATCH v3 02/13] cache-tree: remove dependency on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-2-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

The "cache-tree" subsystem still depends on `the_repository`. Adapt it
to instead use repositories provided via the context, either as a new
parameter or the one passed in via `struct index_state`.

Besides getting rid of `the_repository`, this also removes the last
dependency on registering submodule sources with the main object
database. When reading gitmodules from a submodule's index we implicitly
read that object via `the_repository`'s object database, which is of
course wrong. This works though because we would then register the
submodule's object database with the main object database, but a later
patch is going to get rid of that mechanism.

You can verify that we indeed no longer depend on this mechanism by
running tests with `GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=true`. Without
this patch we fail in t1092, with this patch we never register submodule
object databases anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 cache-tree.c    | 78 +++++++++++++++++++++++++++++++--------------------------
 cache-tree.h    |  5 ++--
 read-cache-ll.h |  5 ++--
 read-cache.c    |  9 ++++---
 unpack-trees.c  |  7 +++---
 5 files changed, 57 insertions(+), 47 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 6103b3fcb3..b8cbb5da22 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -298,12 +297,14 @@ int cache_tree_fully_valid(struct index_state *istate)
 						istate->cache_tree);
 }
 
-static int must_check_existence(const struct cache_entry *ce)
+static int must_check_existence(const struct cache_entry *ce, void *cb_data)
 {
-	return !(repo_has_promisor_remote(the_repository) && ce_skip_worktree(ce));
+	struct repository *repo = cb_data;
+	return !(repo_has_promisor_remote(repo) && ce_skip_worktree(ce));
 }
 
-static int update_one(struct cache_tree *it,
+static int update_one(struct repository *repo,
+		      struct cache_tree *it,
 		      struct cache_entry **cache,
 		      int entries,
 		      const char *base,
@@ -341,7 +342,7 @@ static int update_one(struct cache_tree *it,
 	}
 
 	if (0 <= it->entry_count &&
-	    odb_has_object(the_repository->objects, &it->oid,
+	    odb_has_object(repo->objects, &it->oid,
 			   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 		return it->entry_count;
 
@@ -382,7 +383,8 @@ static int update_one(struct cache_tree *it,
 		sub = find_subtree(it, path + baselen, sublen, 1);
 		if (!sub->cache_tree)
 			sub->cache_tree = cache_tree();
-		subcnt = update_one(sub->cache_tree,
+		subcnt = update_one(repo,
+				    sub->cache_tree,
 				    cache + i, entries - i,
 				    path,
 				    baselen + sublen + 1,
@@ -446,10 +448,10 @@ static int update_one(struct cache_tree *it,
 		}
 
 		ce_missing_ok = mode == S_IFGITLINK || missing_ok ||
-			!must_check_existence(ce);
+			!must_check_existence(ce, repo);
 		if (is_null_oid(oid) ||
 		    (!ce_missing_ok &&
-		     !odb_has_object(the_repository->objects, oid,
+		     !odb_has_object(repo->objects, oid,
 				     ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
@@ -481,12 +483,12 @@ static int update_one(struct cache_tree *it,
 		/*
 		 * "sub" can be an empty tree if all subentries are i-t-a.
 		 */
-		if (contains_ita && is_empty_tree_oid(oid, the_repository->hash_algo))
+		if (contains_ita && is_empty_tree_oid(oid, repo->hash_algo))
 			continue;
 
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
-		strbuf_add(&buffer, oid->hash, the_hash_algo->rawsz);
+		strbuf_add(&buffer, oid->hash, repo->hash_algo->rawsz);
 
 #if DEBUG_CACHE_TREE
 		fprintf(stderr, "cache-tree update-one %o %.*s\n",
@@ -496,16 +498,16 @@ static int update_one(struct cache_tree *it,
 
 	if (repair) {
 		struct object_id oid;
-		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
+		hash_object_file(repo->hash_algo, buffer.buf, buffer.len,
 				 OBJ_TREE, &oid);
-		if (odb_has_object(the_repository->objects, &oid, ODB_HAS_OBJECT_RECHECK_PACKED))
+		if (odb_has_object(repo->objects, &oid, ODB_HAS_OBJECT_RECHECK_PACKED))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
 	} else if (dryrun) {
-		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
+		hash_object_file(repo->hash_algo, buffer.buf, buffer.len,
 				 OBJ_TREE, &it->oid);
-	} else if (odb_write_object_ext(the_repository->objects, buffer.buf, buffer.len, OBJ_TREE,
+	} else if (odb_write_object_ext(repo->objects, buffer.buf, buffer.len, OBJ_TREE,
 					&it->oid, NULL, flags & WRITE_TREE_SILENT ? ODB_WRITE_OBJECT_SILENT : 0)) {
 		strbuf_release(&buffer);
 		return -1;
@@ -523,7 +525,7 @@ static int update_one(struct cache_tree *it,
 
 int cache_tree_update(struct index_state *istate, int flags)
 {
-	int inflight = !!the_repository->objects->transaction;
+	int inflight = !!istate->repo->objects->transaction;
 	struct odb_transaction *transaction;
 	int skip, i;
 
@@ -535,14 +537,14 @@ int cache_tree_update(struct index_state *istate, int flags)
 	if (!istate->cache_tree)
 		istate->cache_tree = cache_tree();
 
-	if (!(flags & WRITE_TREE_MISSING_OK) && repo_has_promisor_remote(the_repository))
-		prefetch_cache_entries(istate, must_check_existence);
+	if (!(flags & WRITE_TREE_MISSING_OK) && repo_has_promisor_remote(istate->repo))
+		prefetch_cache_entries(istate, must_check_existence, istate->repo);
 
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", istate->repo);
 	if (!inflight)
-		odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
-	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
+		odb_transaction_begin_or_die(istate->repo->objects, &transaction, 0);
+	i = update_one(istate->repo, istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
 	if (!inflight)
 		odb_transaction_commit_and_finalize_or_die(transaction);
@@ -554,7 +556,8 @@ int cache_tree_update(struct index_state *istate, int flags)
 	return 0;
 }
 
-static void write_one(struct strbuf *buffer, struct cache_tree *it,
+static void write_one(struct repository *repo,
+		      struct strbuf *buffer, struct cache_tree *it,
 		      const char *path, int pathlen)
 {
 	int i;
@@ -580,7 +583,7 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 #endif
 
 	if (0 <= it->entry_count) {
-		strbuf_add(buffer, it->oid.hash, the_hash_algo->rawsz);
+		strbuf_add(buffer, it->oid.hash, repo->hash_algo->rawsz);
 	}
 	for (i = 0; i < it->subtree_nr; i++) {
 		struct cache_tree_sub *down = it->down[i];
@@ -590,15 +593,16 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 					     prev->name, prev->namelen) <= 0)
 				die("fatal - unsorted cache subtree");
 		}
-		write_one(buffer, down->cache_tree, down->name, down->namelen);
+		write_one(repo, buffer, down->cache_tree, down->name, down->namelen);
 	}
 }
 
-void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
+void cache_tree_write(struct repository *repo,
+		      struct strbuf *sb, struct cache_tree *root)
 {
-	trace2_region_enter("cache_tree", "write", the_repository);
-	write_one(sb, root, "", 0);
-	trace2_region_leave("cache_tree", "write", the_repository);
+	trace2_region_enter("cache_tree", "write", repo);
+	write_one(repo, sb, root, "", 0);
+	trace2_region_leave("cache_tree", "write", repo);
 }
 
 static int parse_int(const char **ptr, unsigned long *len_p, int *out)
@@ -632,13 +636,14 @@ static int parse_int(const char **ptr, unsigned long *len_p, int *out)
 	return 0;
 }
 
-static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
+static struct cache_tree *read_one(struct repository *repo,
+				   const char **buffer, unsigned long *size_p)
 {
 	const char *buf = *buffer;
 	unsigned long size = *size_p;
 	struct cache_tree *it;
 	int i, subtree_nr;
-	const unsigned rawsz = the_hash_algo->rawsz;
+	const unsigned rawsz = repo->hash_algo->rawsz;
 
 	it = NULL;
 	/* skip name, but make sure name exists */
@@ -665,7 +670,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 		if (size < rawsz)
 			goto free_return;
 		oidread(&it->oid, (const unsigned char *)buf,
-			the_repository->hash_algo);
+			repo->hash_algo);
 		buf += rawsz;
 		size -= rawsz;
 	}
@@ -693,7 +698,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 		struct cache_tree_sub *subtree;
 		const char *name = buf;
 
-		sub = read_one(&buf, &size);
+		sub = read_one(repo, &buf, &size);
 		if (!sub)
 			goto free_return;
 		subtree = cache_tree_sub(it, name);
@@ -710,16 +715,17 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	return NULL;
 }
 
-struct cache_tree *cache_tree_read(const char *buffer, unsigned long size)
+struct cache_tree *cache_tree_read(struct repository *repo,
+				   const char *buffer, unsigned long size)
 {
 	struct cache_tree *result;
 
 	if (buffer[0])
 		return NULL; /* not the whole tree */
 
-	trace2_region_enter("cache_tree", "read", the_repository);
-	result = read_one(&buffer, &size);
-	trace2_region_leave("cache_tree", "read", the_repository);
+	trace2_region_enter("cache_tree", "read", repo);
+	result = read_one(repo, &buffer, &size);
+	trace2_region_leave("cache_tree", "read", repo);
 
 	return result;
 }
@@ -810,7 +816,7 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
 	entries = read_index_from(index_state, index_path,
-				  repo_get_git_dir(the_repository));
+				  repo_get_git_dir(index_state->repo));
 	if (entries < 0) {
 		ret = WRITE_TREE_UNREADABLE_INDEX;
 		goto out;
@@ -866,7 +872,7 @@ static void prime_cache_tree_rec(struct repository *r,
 			struct cache_tree_sub *sub;
 			struct tree *subtree = lookup_tree(r, &entry.oid);
 
-			if (repo_parse_tree(the_repository, subtree) < 0)
+			if (repo_parse_tree(r, subtree) < 0)
 				exit(128);
 			sub = cache_tree_sub(it, entry.path);
 			sub->cache_tree = cache_tree();
diff --git a/cache-tree.h b/cache-tree.h
index 4b3f60d6db..7a2177de83 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -28,8 +28,9 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
 int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen);
 
-void cache_tree_write(struct strbuf *, struct cache_tree *root);
-struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
+void cache_tree_write(struct repository *repo, struct strbuf *, struct cache_tree *root);
+struct cache_tree *cache_tree_read(struct repository *repo,
+				   const char *buffer, unsigned long size);
 
 int cache_tree_fully_valid(struct index_state *);
 int cache_tree_update(struct index_state *, int);
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 8eb266cfd1..066dd8bc3b 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -269,9 +269,10 @@ void validate_cache_entries(const struct index_state *istate);
  * the given predicate. This function should only be called if
  * repo_has_promisor_remote() returns true.
  */
-typedef int (*must_prefetch_predicate)(const struct cache_entry *);
+typedef int (*must_prefetch_predicate)(const struct cache_entry *, void *cb_data);
 void prefetch_cache_entries(const struct index_state *istate,
-			    must_prefetch_predicate must_prefetch);
+			    must_prefetch_predicate must_prefetch,
+			    void *cb_data);
 
 /* Initialize and use the cache information */
 struct lock_file;
diff --git a/read-cache.c b/read-cache.c
index 8044ff820b..e40f290bb3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1748,7 +1748,7 @@ static int read_index_extension(struct index_state *istate,
 {
 	switch (CACHE_EXT(ext)) {
 	case CACHE_EXT_TREE:
-		istate->cache_tree = cache_tree_read(data, sz);
+		istate->cache_tree = cache_tree_read(istate->repo, data, sz);
 		break;
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo = resolve_undo_read(data, sz, the_hash_algo);
@@ -3012,7 +3012,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	    !drop_cache_tree && istate->cache_tree) {
 		strbuf_reset(&sb);
 
-		cache_tree_write(&sb, istate->cache_tree);
+		cache_tree_write(istate->repo, &sb, istate->cache_tree);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_TREE, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
 		if (err) {
@@ -3733,7 +3733,8 @@ static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_ta
 }
 
 void prefetch_cache_entries(const struct index_state *istate,
-			    must_prefetch_predicate must_prefetch)
+			    must_prefetch_predicate must_prefetch,
+			    void *cb_data)
 {
 	int i;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
@@ -3741,7 +3742,7 @@ void prefetch_cache_entries(const struct index_state *istate,
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
-		if (S_ISGITLINK(ce->ce_mode) || !must_prefetch(ce))
+		if (S_ISGITLINK(ce->ce_mode) || !must_prefetch(ce, cb_data))
 			continue;
 		if (!odb_read_object_info_extended(the_repository->objects,
 						   &ce->oid, NULL,
diff --git a/unpack-trees.c b/unpack-trees.c
index f6bb1e6d2b..1802809ad3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -416,7 +416,8 @@ static void report_collided_checkout(struct index_state *index)
 	string_list_clear(&list, 0);
 }
 
-static int must_checkout(const struct cache_entry *ce)
+static int must_checkout(const struct cache_entry *ce,
+			 void *cb_data UNUSED)
 {
 	return ce->ce_flags & CE_UPDATE;
 }
@@ -477,7 +478,7 @@ static int check_updates(struct unpack_trees_options *o,
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
 		 */
-		prefetch_cache_entries(index, must_checkout);
+		prefetch_cache_entries(index, must_checkout, NULL);
 
 	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
 
@@ -487,7 +488,7 @@ static int check_updates(struct unpack_trees_options *o,
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
-		if (must_checkout(ce)) {
+		if (must_checkout(ce, NULL)) {
 			size_t last_pc_queue_size = pc_queue_size();
 
 			if (ce->ce_flags & CE_WT_REMOVE)

-- 
2.55.0.1074.ge7621b4bad.dirty

