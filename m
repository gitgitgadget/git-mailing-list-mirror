Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC33876CE
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260979; cv=none; b=oocTojZIkcFsLZmmz+sj0m91qLncl2yQGSFQko7a1lZz9I4ws7m9wb/IVHYA3gER6KB0nXYAl9Sbt2fGUoshEqGtre9GsrlnhbyC0ytr682j9IloBT0sQ5v9hm9wHmQjckM6yHhL5uRvrTdtsz9IyuKErAD4UNlI7/qT10OEjTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260979; c=relaxed/simple;
	bh=X5jXdGQ7e83i2NIs50mbO3xH+BUO0QMnEUNlJhLpoEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQmMypIuCn2FPWWsJdBcCMRrKHWBYJhq4y0NYaufytZV5W3GoxZgM1Gu79p+Fd+/31VZf3G4YbnhFDUCJqffX3dlfISC9YdY+1UN/te8zzDCB49tVlu/uoZdv+E/wmc7hShWG8ipHBSrq2iSU6dHThEKxmhblrr+iDeDfsVtH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pBDkd5sx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g3kMVaa8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pBDkd5sx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g3kMVaa8"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A477140004E
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:09:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 01 Sep 2026 07:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788260976;
	 x=1788347376; bh=OjzoaSxTnqHLhv/qRTM3xXbZJgAo/AipwyGVs4PnLkg=; b=
	pBDkd5sxW6HbJFlILrilIIeBOJA7Uli6/7rPoWkZNXahHvpH/GkrDUhyuc/ZktSG
	WxpZ8hi/UdHOsjquYDaiJlyZn1HeyGb0fKy4EqwHtUoJcd/iccXVccnO2p/ICpQO
	uivOozu+uGjVEyUlqdN0x4RCP01xR0W/CRF/JSfKGF99HKorli1gS0Tt3ntQjpQ5
	yYdTEAiQBGnvfTr2SNabiYrl1ZWIIlfrHHCIIVk/qETkldz+/bWOBKjmysl9zwVg
	FgOF8KVum/CH8YD2qSeh6o/H1gJXZEAaGO4Zx1cF/C6zxD/8z6CQ55yTXSIuCUa0
	IlEQmblw3SztwNBwXHwu3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788260976; x=
	1788347376; bh=OjzoaSxTnqHLhv/qRTM3xXbZJgAo/AipwyGVs4PnLkg=; b=g
	3kMVaa8lVHAtWELoigTt5pMpbZ0tiSz9C7k7K9twBwwaau1VX69snyekFgXMfobb
	0nn9uzjDuL61O1/SL4r6i5NuS5utIZxM65He38miggV1eye1Wy0YbYY6n8zy/3Y6
	cPT6KRLUJodhSuYKAgkmNUs35JayHHLx06jRBhNB+M2+ewnWycdvn/MqqrEueZJX
	YwyySkLjtfxgdhRuXDejEiniTI7vN6dw2AVLMAYX6arzpfEo5OePcLRF9M+PTNJS
	l0JWiTyEf7eDAFCMoy5ixdKlg/fkH2/AX0MxmXjG4h6b8GYqzP9NL5qpIVfJBnXC
	Cox7yFDebwd/3NSiOmdxA==
X-ME-Sender: <xms:cLKWajmbrZqKN0m5R3XofynxxuRbW2BRAZ8FJPQjJj6-_-AlkJMeGg>
    <xme:cLKWatxhjALoPGOw__qYVx3LfDqcMMC4hkfyR-xlL4WchjGi9bZyj-h4xDCFiPBVm
    Ce9N1NsClaDl4tgK85GESkF8659N2gZ0q2pfKhrDXeH9I50FmTheHY>
X-ME-Received: <xmr:cLKWavS9o7Brs7K-j3D5A3J-cKvxQCcT9YvvQAVvqhq2HZAhpRbo8Q>
X-ME-Proxy-Cause: dmFkZTEN9g1Fe0QNve9ECoP2TiUiX4EEH5POEiwmRiQIlHZ+xDbzHkU7NDd2M3NVK6/umO
    bXXkzUK3COWchLgt1/LK6gQ+MqeSaO5Oixh8RPOTrogDUVvdApPqyytnFYWyXEx31a/UW/
    VrRjQoyTePvVd8NFe+FYtwmzmG6MTjOdJtb92EaY7FcVv+MSIEhwv9SzJucvjBA0gTjUZ5
    irBlskFAJd/x0/Ql5UqM+PWol2xq0PhHqo6xS2QHAKohbPBqVxfe/t/HxXIdPstzFq1tQ2
    zZWYaDW+dfkh9KQoVCr2N9lwFiWtupwGIIOt/EhVGn/DGYrANZ/6T7aifXl4bC+/EDNaTF
    d9j9UdEPAWys5J0fbjfOAgRWf260UWKVXcRSAe9p09rwGkEKJaJqL+G9705q7q5cbTFp1K
    COLvXmFCOoiZGmg/GrqiNXN9RQOJVQkOu4ORoTvtBkpazEpl/7RzI43MIdnLeVcXoLOe2b
    YnsbVII9jE68JvFJ6g+yCSbH4v9lWc4Jd22CEaXM1IVwDsvNCk1+ZzdDHrDqT8JOGI3j7D
    BiDky6U3AXWh7zxTUiSUfSfeAMA6olJ3nRLcbp2Wz8adWfriIxnL7/9mgd9ylVR4CDIOgs
    akRyhBgbo4z5kIIH5kr8uyk8cqILR/DPg0uVU2JuF9mZsrnNd0qDlQhaqxbQ
X-ME-Proxy: <xmx:cLKWaguaxm8kUWjVJWutxb2xbO8rttG0eeEYr_6GZcp6r3pqUrWJTQ>
    <xmx:cLKWahtuPjOu7yf8C38MhvarvZSa0B-TUeuaqiJ844pnGTse5_Whqg>
    <xmx:cLKWamwQEJV-vJ4HpXtVKby1cP0fXifYPhM2jGKpOOhsu21p2p24Uw>
    <xmx:cLKWangPJ8GlZkJl9DJOBFpYBxWBjdMKFbpOZW6Mh2EYIDvqyO6B2w>
    <xmx:cLKWaj2CkT02GWYsOi8wBXS4TEvkRAEwLqUcOnlo6_7lUTnXz3xIVVNX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:09:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8d8ff52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:09:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:00 +0200
Subject: [PATCH 01/12] cache-tree: remove dependency on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-1-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
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
 builtin/checkout.c |  2 +-
 builtin/commit.c   |  2 +-
 cache-tree.c       | 88 +++++++++++++++++++++++++++++-------------------------
 cache-tree.h       |  7 +++--
 read-cache-ll.h    |  5 ++--
 read-cache.c       |  9 +++---
 sequencer.c        |  2 +-
 sparse-index.c     |  2 +-
 unpack-trees.c     |  9 +++---
 9 files changed, 68 insertions(+), 58 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..60d106f4d5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -921,7 +921,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 	}
 
-	if (!cache_tree_fully_valid(the_repository->index->cache_tree))
+	if (!cache_tree_fully_valid(the_repository, the_repository->index->cache_tree))
 		cache_tree_update(the_repository->index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
 
 	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..02df1c2feb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -484,7 +484,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 				       LOCK_DIE_ON_ERROR);
 		refresh_cache_or_die(refresh_flags);
 		if (the_repository->index->cache_changed
-		    || !cache_tree_fully_valid(the_repository->index->cache_tree))
+		    || !cache_tree_fully_valid(the_repository, the_repository->index->cache_tree))
 			cache_tree_update(the_repository->index, WRITE_TREE_SILENT);
 		if (write_locked_index(the_repository->index, &index_lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
diff --git a/cache-tree.c b/cache-tree.c
index a220372a42..6e4d82f3e8 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -275,28 +274,30 @@ static void discard_unused_subtrees(struct cache_tree *it)
 	}
 }
 
-int cache_tree_fully_valid(struct cache_tree *it)
+int cache_tree_fully_valid(struct repository *repo, struct cache_tree *it)
 {
 	int i;
 	if (!it)
 		return 0;
 	if (it->entry_count < 0 ||
-	    !odb_has_object(the_repository->objects, &it->oid,
+	    !odb_has_object(repo->objects, &it->oid,
 			    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
-		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
+		if (!cache_tree_fully_valid(repo, it->down[i]->cache_tree))
 			return 0;
 	}
 	return 1;
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
@@ -334,7 +335,7 @@ static int update_one(struct cache_tree *it,
 	}
 
 	if (0 <= it->entry_count &&
-	    odb_has_object(the_repository->objects, &it->oid,
+	    odb_has_object(repo->objects, &it->oid,
 			   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 		return it->entry_count;
 
@@ -375,7 +376,8 @@ static int update_one(struct cache_tree *it,
 		sub = find_subtree(it, path + baselen, sublen, 1);
 		if (!sub->cache_tree)
 			sub->cache_tree = cache_tree();
-		subcnt = update_one(sub->cache_tree,
+		subcnt = update_one(repo,
+				    sub->cache_tree,
 				    cache + i, entries - i,
 				    path,
 				    baselen + sublen + 1,
@@ -439,10 +441,10 @@ static int update_one(struct cache_tree *it,
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
@@ -474,12 +476,12 @@ static int update_one(struct cache_tree *it,
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
@@ -489,16 +491,16 @@ static int update_one(struct cache_tree *it,
 
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
@@ -516,7 +518,7 @@ static int update_one(struct cache_tree *it,
 
 int cache_tree_update(struct index_state *istate, int flags)
 {
-	int inflight = !!the_repository->objects->transaction;
+	int inflight = !!istate->repo->objects->transaction;
 	struct odb_transaction *transaction;
 	int skip, i;
 
@@ -528,14 +530,14 @@ int cache_tree_update(struct index_state *istate, int flags)
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
@@ -547,7 +549,8 @@ int cache_tree_update(struct index_state *istate, int flags)
 	return 0;
 }
 
-static void write_one(struct strbuf *buffer, struct cache_tree *it,
+static void write_one(struct repository *repo,
+		      struct strbuf *buffer, struct cache_tree *it,
 		      const char *path, int pathlen)
 {
 	int i;
@@ -573,7 +576,7 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 #endif
 
 	if (0 <= it->entry_count) {
-		strbuf_add(buffer, it->oid.hash, the_hash_algo->rawsz);
+		strbuf_add(buffer, it->oid.hash, repo->hash_algo->rawsz);
 	}
 	for (i = 0; i < it->subtree_nr; i++) {
 		struct cache_tree_sub *down = it->down[i];
@@ -583,15 +586,16 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
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
@@ -625,13 +629,14 @@ static int parse_int(const char **ptr, unsigned long *len_p, int *out)
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
@@ -658,7 +663,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 		if (size < rawsz)
 			goto free_return;
 		oidread(&it->oid, (const unsigned char *)buf,
-			the_repository->hash_algo);
+			repo->hash_algo);
 		buf += rawsz;
 		size -= rawsz;
 	}
@@ -686,7 +691,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 		struct cache_tree_sub *subtree;
 		const char *name = buf;
 
-		sub = read_one(&buf, &size);
+		sub = read_one(repo, &buf, &size);
 		if (!sub)
 			goto free_return;
 		subtree = cache_tree_sub(it, name);
@@ -703,16 +708,17 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
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
@@ -775,7 +781,7 @@ struct tree *write_in_core_index_as_tree(struct repository *repo,
 	int was_valid, ret;
 
 	was_valid = index_state->cache_tree &&
-		    cache_tree_fully_valid(index_state->cache_tree);
+		    cache_tree_fully_valid(repo, index_state->cache_tree);
 
 	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
 	if (ret == WRITE_TREE_UNMERGED_INDEX) {
@@ -803,7 +809,7 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
 	entries = read_index_from(index_state, index_path,
-				  repo_get_git_dir(the_repository));
+				  repo_get_git_dir(index_state->repo));
 	if (entries < 0) {
 		ret = WRITE_TREE_UNREADABLE_INDEX;
 		goto out;
@@ -811,7 +817,7 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 
 	was_valid = !(flags & WRITE_TREE_IGNORE_CACHE_TREE) &&
 		    index_state->cache_tree &&
-		    cache_tree_fully_valid(index_state->cache_tree);
+		    cache_tree_fully_valid(index_state->repo, index_state->cache_tree);
 
 	ret = write_index_as_tree_internal(oid, index_state, was_valid, flags,
 					   prefix);
@@ -859,7 +865,7 @@ static void prime_cache_tree_rec(struct repository *r,
 			struct cache_tree_sub *sub;
 			struct tree *subtree = lookup_tree(r, &entry.oid);
 
-			if (repo_parse_tree(the_repository, subtree) < 0)
+			if (repo_parse_tree(r, subtree) < 0)
 				exit(128);
 			sub = cache_tree_sub(it, entry.path);
 			sub->cache_tree = cache_tree();
diff --git a/cache-tree.h b/cache-tree.h
index f8bddae523..5d49308de9 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -28,10 +28,11 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
 int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen);
 
-void cache_tree_write(struct strbuf *, struct cache_tree *root);
-struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
+void cache_tree_write(struct repository *repo, struct strbuf *, struct cache_tree *root);
+struct cache_tree *cache_tree_read(struct repository *repo,
+				   const char *buffer, unsigned long size);
 
-int cache_tree_fully_valid(struct cache_tree *);
+int cache_tree_fully_valid(struct repository *, struct cache_tree *);
 int cache_tree_update(struct index_state *, int);
 int cache_tree_verify(struct repository *, struct index_state *);
 
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
diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..97f4119bed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -814,7 +814,7 @@ static int do_recursive_merge(struct repository *r,
 
 static struct object_id *get_cache_tree_oid(struct index_state *istate)
 {
-	if (!cache_tree_fully_valid(istate->cache_tree))
+	if (!cache_tree_fully_valid(istate->repo, istate->cache_tree))
 		if (cache_tree_update(istate, 0)) {
 			error(_("unable to update cache tree"));
 			return NULL;
diff --git a/sparse-index.c b/sparse-index.c
index c1fa231a89..102a9dadeb 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -228,7 +228,7 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	if (index_has_unmerged_entries(istate))
 		return 0;
 
-	if (!cache_tree_fully_valid(istate->cache_tree)) {
+	if (!cache_tree_fully_valid(istate->repo, istate->cache_tree)) {
 		/* Clear and recompute the cache-tree */
 		cache_tree_free(&istate->cache_tree);
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 154d6d40a1..20e6d6d824 100644
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
@@ -2086,7 +2087,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			}
 
 			if (!o->skip_cache_tree_update &&
-			    !cache_tree_fully_valid(o->internal.result.cache_tree))
+			    !cache_tree_fully_valid(the_repository, o->internal.result.cache_tree))
 				cache_tree_update(&o->internal.result,
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);

-- 
2.55.0.979.g7e5102b832.dirty

