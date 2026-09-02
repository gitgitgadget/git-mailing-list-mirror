Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16E4320A00
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356109; cv=none; b=mdNnXIc5rrDpxJ1WKxhEOj+2xWy+iSbho7gUbba0Lc4KzXfN+lRD2IJbUedCdOvOSGwiEOmjTiXmPG2uFZB03RZYX/daX3El0hXo1cxTWuSHzAcxMiK+OCkBbTRtekJpeyUXWuTI+y8Vo+sqCYN9C2BrmjgrcyboDkWsCjwHjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356109; c=relaxed/simple;
	bh=uE260/TZSZGGl3IrOi8eh9VJ04K+fqpEN7vd3HHy7rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alebl8sFguxthco3Ot3HAWHKFwMCU4b0nfBosAPALNx0QDVaMpSPjfsK+2b/CC18lsp7n3gdmQchqIl2YM/zzxkoy0QZjn2NhYq8ZDEQ88QSIv7rKTG+75wGIKyo0O90tiiy25IW4wgWx9uTkXTcsr+r+rZ0FeGAFCbp1Hko3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D8AWIadT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=arVevS2V; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D8AWIadT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="arVevS2V"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7AEDD1D0014E;
	Wed,  2 Sep 2026 09:35:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 02 Sep 2026 09:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356105;
	 x=1788442505; bh=jvqFG9PRHMnPp12LhAmNmJXIbKpSIZzbpx4x9tAJU84=; b=
	D8AWIadTbN2lAsvq37qtkmkyyqOwXSJ5YwwHnlG479QMLpGPsst4HXR1Gse9ZO+A
	fP95Li1hHHgep/rS0fgCnKDfAOpNO2kuhJL06TJslqEAf4sKULKZvlnDXp2SE8Ma
	h9I2vTSNqcgFEC8/038oqBm0UE1muqpRJPImvkrj7dI2TKBpwS2ZjkSbyNVrqlwd
	UP7t1oLjyl0E7oCzv71RAxjBcWhJt4hj/HfawsO7uPBcS+SBLQ3b2f0L8nbwUKL/
	52ooNvYeEZ1sGJl4Af+boNn673MPkzXXLoh7X9TfVGgjeMrb0DnBFklpbH1hVKQM
	psb8nviPRjUanTa7uASIlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356105; x=
	1788442505; bh=jvqFG9PRHMnPp12LhAmNmJXIbKpSIZzbpx4x9tAJU84=; b=a
	rVevS2V1XXPgQFBX7XPOS/JkVCOiRsOYExRKwMHdRBklhaj74Sbmc4MTvvD2/u+L
	4T0CpDbSxbc5eLNVqwXd3H7Ahgyfwy3YN9i+D3MEBYMlseoq0I0AiJQYvJFw6ciz
	zqy8U91cm/zmuAg9U7HjIWcsgc36X5K18NzR/4G68O2vncnRftYA8+KssGeubwQS
	9bSEmlABMemqHzxIbMSPeaIudQexHYPKC3tiWfGYUeNLmYdjSL2qnAk22qt0lJdw
	YDE/Hw+J3Mp8v1gOU/htckW3i5Ih2TdOddoBoOczn/jCJ6fM9Zk1QjIWv3c97vKZ
	VhLl6NSlZyImiwCLFvKyA==
X-ME-Sender: <xms:CSaYaosm2PSDcyH3zC3MfBph94G8B4HNjAuumynDhUrjTOX9km_pwA>
    <xme:CSaYarfqYF3KPrQ3NPQuUS6wzY2-bgZdmgQDtUjAEpXh8-Ebp4goUTLyCj4usnZOf
    H8KY16tyzGaQATZ7noGJA9kI1GfnOg2c2wcNokfkW17IOwdlmjnHA>
X-ME-Received: <xmr:CSaYahZQIRyCg9vqjAFjGLQO7xX23RsuXDcSuFUtAmkfsUTE-qSWyE_RkRepTU_ImP7uatE>
X-ME-Proxy-Cause: dmFkZTEYhr9e4Ywlb1TBHLwsOW3Qx1tjtKD+uhP71WKh33QJrNZx9AVMt7nD22Jis4lPrv
    MTCD/EPB8RsDNVjlqEtIpjdnI06qWWOaQew+wKEg9KR8NEV3XDj5+C+lq0GNXMUCyo4igS
    5U9v+KFkw0Evpwnc6cWUohg4b6qCrXyvPX0B7hrQw7zRUjz5YwzGQrgU3UxDXxxyR53YC+
    YQIYAIRjLTSjVluUg4RI0n2rU5GvrWBHjQHZRsaSRDQMiPpgohYZUdgz5LN2ECLLwBR9zC
    HYaTCafKUfTxhWvjtOGLyd4VXGi9YWUXrplxaROw1Cvb4DVWcs3zD8ZSMBcPlpw1IaHWYD
    3bxi+zNx1CAbMkLgrvq/Cc1D9txGWpqfDNtFqhjR/2bRuXjuPDQYVyKIdqDET4DGYJTJX2
    4AN7+ckbShLKC1s4N1Ae4yx3U/2L7EtoNW+PyK+z3xVhEBAInh+TNa0ZrYsj7vo0kIO63J
    zbhM6KWx1D7JuDROPWSUCPgZ9DxuDt9bN5gl0b9LX+xbuLh3mqix9a/me/OIAcoYwpFVOW
    dg1HZUnG076PoBqCpQxpFtzcfsUt0t7mhHelCl61V+ncvPWQKIDBfknUdG+BIy0VpDCU1d
    YwBeKedYbvsy4vZaEmNMmrhrPWE0uq3HvZpvLjzifaTN8n9de/50TZPm+7hQ
X-ME-Proxy: <xmx:CSaYamUmRfiHLHl9mNb5HLja0VHmLPEoERW4l52pcN43x4dMXZ9KIA>
    <xmx:CSaYariU0rqhALpg-ZY_XcbMRrRacC8mgwVMrQjvMLZAQBHfg3Jx8g>
    <xmx:CSaYasWNfgS3k4laUrFs50F3wptoa20geoMp0vMKfRZvmHc8GEne6g>
    <xmx:CSaYaqMNcgD12GQOFZFcZmvqpAWRCRaQi5n2lf2J1V1GN6cSMKxT2A>
    <xmx:CSaYakFW8kYvNUoNHBpc8E9sstpVYBuyBnAjLUrtBn5T8UJavmLB-TUx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 02f19864 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:34:50 +0200
Subject: [PATCH v2 02/13] cache-tree: remove dependency on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-2-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.979.g7e5102b832.dirty

