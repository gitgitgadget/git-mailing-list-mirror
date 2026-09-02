Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0B4534A9
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356108; cv=none; b=O+Y/sX1VT6101okEYTV7gb/G6zI1vw6XBeYZhkGT2Jau73Oi2cwQ9+jdlY9QNED0O7KSH5nZyyIvVunF1Jpg1ClAYvjY36SuCWfzMCvevYL8VY7Maej+Hy034T/MV6MaF29uTWSFtE87weHwB0cGo9WHBNkW2ZhSVLQkwJJGCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356108; c=relaxed/simple;
	bh=57fq3Jb6y6rdapN/7Bb7d2ODlWbO6PKQd5Xj4kIHoXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3UGRhzjWiMVj4gkBQpV3tLJ0+pRSwAbvXo6428N8FmjgNraWlqDO6q9Sh9Podh6cjq2iI+oTxNYUB4UMHn0T8vPH2PCeGGH0K5ixxCpjXh66BrfenXYoooNR4ptQNuy+ULwKslKT0Mxj3JzKA6QXGO2RW3UHxhkfQKuicny/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A8OIBEeH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kAM+tbXF; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A8OIBEeH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kAM+tbXF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 713CC1D0014A;
	Wed,  2 Sep 2026 09:35:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 09:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356104;
	 x=1788442504; bh=aorTq2KYx6W9EzY/Qr9rSXsEBLVmkaZPS84nBS5L6qU=; b=
	A8OIBEeHBSUJIZPaPWEA4ZCeWa4XmtpH5Zawliz373Sy6rVWyEIs5dTBsQYyJWzq
	uGErGPMBO84Jrqz0LMwr6BwYePxpNx6DLSrG5y3HiPem6qAkrvevAiCOyMHXpjfJ
	AvzgllZli5tsm2Yp3r2rTFB3Hfru0OWNMj0yN2arENVLLG0M5wFezyhJxL7ayxeW
	LllM0Ye1oPSisFNPmAxwRX+grOxfX1x/WKDL0/52ZrreR8YfQTrIwdcjLPXYB8L4
	3V1x6GRE0JZUsZ6mmmZvQuDnoyRN8BNJVQ1jH/WT2pIq+4ZLbKuOdcO9DxasWBqJ
	kdTNo540iSU9ygev+iexxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356104; x=
	1788442504; bh=aorTq2KYx6W9EzY/Qr9rSXsEBLVmkaZPS84nBS5L6qU=; b=k
	AM+tbXFBkwP9bAlg8U0NIelgGOKskH0cvE22bBfQB4PL17Gl523QAbIeeQ7sO8tV
	csCGdmQveNfJ4MDPU6kH5oBiADEiyG6fk+SgQopXPdUbqdPo6XA7ddQKS3Wu3QUt
	Nh00de4Pu9VZ6TaENLhlAwmk2J6gP9rhiccyIOHJRawYhp7yYgU+IcFL9djheRKW
	odwER2AuphECjdMyHl7bcCksM21EtqaJcbiUF52ItAyBifQ/iJawyHHBou95dw1/
	ysDef4uFbTJepksp/yUSu3D1yrLgHS+nvm/l170OYQJRU3hHpZGAVR6kpWKqY8eL
	BnYK4NQGO619csZOiUMMw==
X-ME-Sender: <xms:CCaYaqUX4cj10ek-ApgPUJzsTP2qcSKIo09_HZ_33v7fDnlKwJnmHw>
    <xme:CCaYasnuxH0HXCzunLtjt4vBxKUGHyK5symup7gJ_OK7TdIGIprAz_IxLnEiVFJJ8
    JVR9oNBbveGPO6EvKlRq_kOHY8xf5cnyrbGk4VyJNKTvlE-r6BP>
X-ME-Received: <xmr:CCaYasA39x4rXsZd7sdqN5hSh8qCI8iBSJJUGdKHY9CePFFpU1mejIzFu_OF-g2dIMdsNSY>
X-ME-Proxy-Cause: dmFkZTEYhr9e4Ywlb1TBHLwsOW3Qx1tjtKD+uhP71WKh33QJrNZx9AVMt7nD22Jis4lPrv
    MTCD/EPB8RsDNVjlqEtIpjdnI06qWWOaQew+wKEg9KR8NEV3XDj5+C+lq0GNXMUCyo4igS
    5U9v+KFkw0Evpwnc6cWUohg4b6qCrXyvPX0B7hrQw7zRUjz5YwzGQrgU3UxDXxxyR53YC+
    YQIYAIRjLTSjVluUg4RI0n2rU5GvrWBHjQHZRsaSRDQMiPpgohYZUdgz5LN2ECLLwBR9zC
    HYaTCafKUfTxhWvjtOGLyd4VXGi9YWUXrplxaROw1Cvb4DVWcs3zD8ZSMBcPlpw1IaHWml
    N4x/gwR4AYy5eTb5E3dXThTOwIkT/r+VMHbv5rJRwiJP+tXbURsjJOQF+8GDsZ0VGa8gvR
    pAwzGygCcsACl8eEm8LasSUewStDcWg5xlTJt9L3Zo7M0cD2iNdYTfUvDt3xvwldnJKEM2
    oynja1tU7pAq61jdgl8lonsLL664P7akVWVgi/BBj02I6g8BdfhJetOO8inC75h5TjFyCx
    X4rYdpJw1BDnkVroOr5YjJydpuJYBwvwUwJZWP5yYz3U2s4atfx972n997XnQyWzUIUc1W
    q6/WXd5O4913K6Y8GiRIaSOnzipPcLT/jw02bwOMMHM7oUNdug7DTFs9e1uw
X-ME-Proxy: <xmx:CCaYaseFM1hdhVy8YEExjoF_c5diFQSlWioKaijKDnFBfT5H5r1mCA>
    <xmx:CCaYanI9W6eIQZcfnecnGQ-w-3Te8x2WekRp_G4MeBfdKepwTzN_bA>
    <xmx:CCaYaveAvVku8DgzrCfuwdQoGlk4FCwh7myaNBGpuXkP43OXV2DUvw>
    <xmx:CCaYau2F1mjLyk5E7SfvmDDK0x5rzdqIPbl7E-Ey_6UxZs9HazhKgA>
    <xmx:CCaYalvcW4vJN84MJw-A4dERZLXA1mB4A3K8mPaCOtaFUlMyVVil3qW9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f643e63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:34:49 +0200
Subject: [PATCH v2 01/13] cache-tree: drop `the_repository` in
 `cache_tree_fully_valid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-1-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The function `cache_tree_fully_valid()` verifies whether the cache tree
owned by the index is valid or not. As part of that, the function checks
whether the objects referenced by the cache all exist. But because the
function has no repository available, it is using the object database of
`the_repository` instead.

We could of course adapt callers to pass in a repository as parameter
explicitly to get rid of this implicit dependency on global state. But
all of them pass the cache tree owned by a `struct index_state`, and
that structure already has a reference to its owning repository.

So instead, adapt the function to accept a `struct index_state`, which
ensures that callers will implicitly always pass the correct repository.
Adapt callers accordingly.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c |  2 +-
 builtin/commit.c   |  2 +-
 cache-tree.c       | 17 ++++++++++++-----
 cache-tree.h       |  2 +-
 sequencer.c        |  2 +-
 sparse-index.c     |  2 +-
 unpack-trees.c     |  2 +-
 7 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..505d3f7bf3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -921,7 +921,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 	}
 
-	if (!cache_tree_fully_valid(the_repository->index->cache_tree))
+	if (!cache_tree_fully_valid(the_repository->index))
 		cache_tree_update(the_repository->index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
 
 	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..840b6b4083 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -484,7 +484,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 				       LOCK_DIE_ON_ERROR);
 		refresh_cache_or_die(refresh_flags);
 		if (the_repository->index->cache_changed
-		    || !cache_tree_fully_valid(the_repository->index->cache_tree))
+		    || !cache_tree_fully_valid(the_repository->index))
 			cache_tree_update(the_repository->index, WRITE_TREE_SILENT);
 		if (write_locked_index(the_repository->index, &index_lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
diff --git a/cache-tree.c b/cache-tree.c
index a220372a42..6103b3fcb3 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -275,22 +275,29 @@ static void discard_unused_subtrees(struct cache_tree *it)
 	}
 }
 
-int cache_tree_fully_valid(struct cache_tree *it)
+static int cache_tree_fully_valid_recursive(struct object_database *odb,
+					    struct cache_tree *it)
 {
 	int i;
 	if (!it)
 		return 0;
 	if (it->entry_count < 0 ||
-	    !odb_has_object(the_repository->objects, &it->oid,
+	    !odb_has_object(odb, &it->oid,
 			    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
-		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
+		if (!cache_tree_fully_valid_recursive(odb, it->down[i]->cache_tree))
 			return 0;
 	}
 	return 1;
 }
 
+int cache_tree_fully_valid(struct index_state *istate)
+{
+	return cache_tree_fully_valid_recursive(istate->repo->objects,
+						istate->cache_tree);
+}
+
 static int must_check_existence(const struct cache_entry *ce)
 {
 	return !(repo_has_promisor_remote(the_repository) && ce_skip_worktree(ce));
@@ -775,7 +782,7 @@ struct tree *write_in_core_index_as_tree(struct repository *repo,
 	int was_valid, ret;
 
 	was_valid = index_state->cache_tree &&
-		    cache_tree_fully_valid(index_state->cache_tree);
+		    cache_tree_fully_valid(index_state);
 
 	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
 	if (ret == WRITE_TREE_UNMERGED_INDEX) {
@@ -811,7 +818,7 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 
 	was_valid = !(flags & WRITE_TREE_IGNORE_CACHE_TREE) &&
 		    index_state->cache_tree &&
-		    cache_tree_fully_valid(index_state->cache_tree);
+		    cache_tree_fully_valid(index_state);
 
 	ret = write_index_as_tree_internal(oid, index_state, was_valid, flags,
 					   prefix);
diff --git a/cache-tree.h b/cache-tree.h
index f8bddae523..4b3f60d6db 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -31,7 +31,7 @@ int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen)
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
-int cache_tree_fully_valid(struct cache_tree *);
+int cache_tree_fully_valid(struct index_state *);
 int cache_tree_update(struct index_state *, int);
 int cache_tree_verify(struct repository *, struct index_state *);
 
diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..11a95c031b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -814,7 +814,7 @@ static int do_recursive_merge(struct repository *r,
 
 static struct object_id *get_cache_tree_oid(struct index_state *istate)
 {
-	if (!cache_tree_fully_valid(istate->cache_tree))
+	if (!cache_tree_fully_valid(istate))
 		if (cache_tree_update(istate, 0)) {
 			error(_("unable to update cache tree"));
 			return NULL;
diff --git a/sparse-index.c b/sparse-index.c
index c1fa231a89..3d77dadae5 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -228,7 +228,7 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	if (index_has_unmerged_entries(istate))
 		return 0;
 
-	if (!cache_tree_fully_valid(istate->cache_tree)) {
+	if (!cache_tree_fully_valid(istate)) {
 		/* Clear and recompute the cache-tree */
 		cache_tree_free(&istate->cache_tree);
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 154d6d40a1..f6bb1e6d2b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2086,7 +2086,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			}
 
 			if (!o->skip_cache_tree_update &&
-			    !cache_tree_fully_valid(o->internal.result.cache_tree))
+			    !cache_tree_fully_valid(&o->internal.result))
 				cache_tree_update(&o->internal.result,
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);

-- 
2.55.0.979.g7e5102b832.dirty

