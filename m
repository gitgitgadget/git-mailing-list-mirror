Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6122714A4C7
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557193; cv=none; b=Ga0MEdVn7jhjwffaREOY4ywR8aRqeDCEXNvjlkRBAqzRoOZ7b1CdRP575wonxWjlYJlhCVxv3TC5Ms/4nMAx8QdQkrlR5wjUZ0JN8IC4WifCplH2UR4rhmtzMEAciHbuN//0z5m2pX5JlE39QHXTwzlWVKys9Io6/N+6e272qDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557193; c=relaxed/simple;
	bh=3oH2eGObXMn1TaHj0L8hh7t0IfqI1UDySBNt6HrGl0Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md6j0F/ow8jsP7xBrIntD3jGsHmvrcE2QZrk7SqcmXJ20CcPocvrZFYzUMfCxxd9EE0ZgZgppuMay/cdcEA3vAUoM9U41GgKZpPm3Dma5nb2SB8Z4gTClwJQqwPRUYjTb6EBqWDwZTeBFHP4RZbi5xmWR3EeZpNtFTDtJrgY7nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BxG3GMBS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YV7p3OPc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BxG3GMBS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YV7p3OPc"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 79E11138040D
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 03:13:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 17 Sep 2024 03:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726557190; x=1726643590; bh=31VA38Xhra
	YguSc5Ad2XZk0WA2n2Gg6nK9xEUHpSVRg=; b=BxG3GMBS+e2czCcEtMcNrLlNNJ
	8EzemRDoH8uoGZ4Vjo6qu37hLkmYqhv8QWl6GVmsludAK1ThUr8KR1l9Jp3cTF8O
	OmZwZR7lRmJ1gTlp4nooTIFeRYxJ1PaWhQqRhgy5ZndPjvyWDcsK/fMDOYRPmL+H
	znG9fAhpalYilVfsKKW1BfyG8O9wN+oYbgtSAqIjbyUPqlQ97WqmZiIOEZ4upK5m
	ZE5jCdUu+y3BjOKJVTQYW84tMWLEercH2yoqHw8iKy//wg/76jX49GbveFgG4sxl
	LO+RYbtznNBPbFaY7U9IqzpPBVF+34fnzvIeljrHhXqidOKeYAmwqs2L0F1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726557190; x=1726643590; bh=31VA38XhraYguSc5Ad2XZk0WA2n2
	Gg6nK9xEUHpSVRg=; b=YV7p3OPcE0l5rX+w5diuQyx0vLAta9f24M8nI2jmx725
	LS96C9ZE4w6b/PdjA8vV1aO+YoV/TCuALqf3m8DJPzWcHmsLUdI7+906srno8xLl
	x1dLvmKcAU1eUt3/H+YIqneD2k7TVdCqjCKuaUoS1ikV231SRi3nwtj88qs9IrFm
	WqQenT05ojayJpJ86G7o4SUT9tcklmctWN0uCrkoii8pIrSt0pNsDKztSxRpgE3A
	359tNFF+6OxLrocOopSekm0H5uV270YHBMEyOpbFe+mogW2wUZ/Nl1XXV3bwl2gz
	ArGGt7JqoFa4k55LZZWsrWJYnnb9HKV0cZy4ffEvcw==
X-ME-Sender: <xms:BizpZuhCM3DldDAWrF95kPS7riyJW9KFWA1BBF8vXjkh2CqCURChMA>
    <xme:BizpZvAIxvnJtpLqUClDYTY6kSTTrKysWMuOPAPCt84lr2s0Dlb6VLIMj5FAdXMop
    bqBDRzN3ryNgBFQ7Q>
X-ME-Received: <xmr:BizpZmHG-ZlQMdVEFp9wcsBZuWoCV1PVqkd1DGLe3_HlCebxo-OEzub1rHRT-0yQmQupQu4RvJrPXzjpiiXZDEqprUY-pjdWi6lU4eYheBzB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekiedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BizpZnQJ5DsmdFW_YevC5Q7yyJ-zjH5_l3GVMqhmDa5NmxOeK3WGQQ>
    <xmx:BizpZrwCyuuOUkQvGrJXAJ6lKvWGanEjn6By8ZC-Vva9Gel2FsgRaA>
    <xmx:BizpZl6urvF_6upWcOhm_ypTbb-_YJMt95dN0NDKfbVe5pJqgzX5_w>
    <xmx:BizpZoxDTo2Csn2esP6N4AkwNZT2ifD1QWKVXu71w8c9goGaqdPCKw>
    <xmx:BizpZkpPX9-xrDMw5Vv3XNqEHFoDGzy0UA0dXFA3ZJa43y8dyt6BdBhl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Sep 2024 03:13:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 55675f10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Sep 2024 07:12:50 +0000 (UTC)
Date: Tue, 17 Sep 2024 09:13:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/3] cache-tree: refactor verification to return error codes
Message-ID: <1f13bc0e3259ea9b76f1417303a8ef063f3a7cbe.1726556195.git.ps@pks.im>
References: <cover.1726556195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726556195.git.ps@pks.im>

The function `cache_tree_verify()` will `BUG()` whenever it finds that
the cache-tree extension of the index is corrupt. The function is thus
inherently untestable because the resulting call to `abort()` will be
detected by our testing framework and labelled an error. And rightfully
so: it shouldn't ever be possible to hit bugs, as they should indicate a
programming error rather than corruption of on-disk state.

Refactor the function to instead return error codes. This also ensures
that the function can be used e.g. by git-fsck(1) without the whole
process dying.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 cache-tree.c   | 97 +++++++++++++++++++++++++++++++++++---------------
 cache-tree.h   |  2 +-
 read-cache.c   |  5 +--
 unpack-trees.c | 10 ++++--
 4 files changed, 79 insertions(+), 35 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 50610c3f3cb..4228b6fad48 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -2,6 +2,7 @@
 
 #include "git-compat-util.h"
 #include "environment.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "tree.h"
@@ -864,15 +865,15 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 	return 0;
 }
 
-static void verify_one_sparse(struct index_state *istate,
-			      struct strbuf *path,
-			      int pos)
+static int verify_one_sparse(struct index_state *istate,
+			     struct strbuf *path,
+			     int pos)
 {
 	struct cache_entry *ce = istate->cache[pos];
-
 	if (!S_ISSPARSEDIR(ce->ce_mode))
-		BUG("directory '%s' is present in index, but not sparse",
-		    path->buf);
+		return error(_("directory '%s' is present in index, but not sparse"),
+			     path->buf);
+	return 0;
 }
 
 /*
@@ -881,6 +882,7 @@ static void verify_one_sparse(struct index_state *istate,
  *  1 - Restart verification - a call to ensure_full_index() freed the cache
  *      tree that is being verified and verification needs to be restarted from
  *      the new toplevel cache tree.
+ *  -1 - Verification failed.
  */
 static int verify_one(struct repository *r,
 		      struct index_state *istate,
@@ -890,18 +892,23 @@ static int verify_one(struct repository *r,
 	int i, pos, len = path->len;
 	struct strbuf tree_buf = STRBUF_INIT;
 	struct object_id new_oid;
+	int ret;
 
 	for (i = 0; i < it->subtree_nr; i++) {
 		strbuf_addf(path, "%s/", it->down[i]->name);
-		if (verify_one(r, istate, it->down[i]->cache_tree, path))
-			return 1;
+		ret = verify_one(r, istate, it->down[i]->cache_tree, path);
+		if (ret)
+			goto out;
+
 		strbuf_setlen(path, len);
 	}
 
 	if (it->entry_count < 0 ||
 	    /* no verification on tests (t7003) that replace trees */
-	    lookup_replace_object(r, &it->oid) != &it->oid)
-		return 0;
+	    lookup_replace_object(r, &it->oid) != &it->oid) {
+		ret = 0;
+		goto out;
+	}
 
 	if (path->len) {
 		/*
@@ -911,12 +918,14 @@ static int verify_one(struct repository *r,
 		 */
 		int is_sparse = istate->sparse_index;
 		pos = index_name_pos(istate, path->buf, path->len);
-		if (is_sparse && !istate->sparse_index)
-			return 1;
+		if (is_sparse && !istate->sparse_index) {
+			ret = 1;
+			goto out;
+		}
 
 		if (pos >= 0) {
-			verify_one_sparse(istate, path, pos);
-			return 0;
+			ret = verify_one_sparse(istate, path, pos);
+			goto out;
 		}
 
 		pos = -pos - 1;
@@ -934,16 +943,23 @@ static int verify_one(struct repository *r,
 		unsigned mode;
 		int entlen;
 
-		if (ce->ce_flags & (CE_STAGEMASK | CE_INTENT_TO_ADD | CE_REMOVE))
-			BUG("%s with flags 0x%x should not be in cache-tree",
-			    ce->name, ce->ce_flags);
+		if (ce->ce_flags & (CE_STAGEMASK | CE_INTENT_TO_ADD | CE_REMOVE)) {
+			ret = error(_("%s with flags 0x%x should not be in cache-tree"),
+				    ce->name, ce->ce_flags);
+			goto out;
+		}
+
 		name = ce->name + path->len;
 		slash = strchr(name, '/');
 		if (slash) {
 			entlen = slash - name;
+
 			sub = find_subtree(it, ce->name + path->len, entlen, 0);
-			if (!sub || sub->cache_tree->entry_count < 0)
-				BUG("bad subtree '%.*s'", entlen, name);
+			if (!sub || sub->cache_tree->entry_count < 0) {
+				ret = error(_("bad subtree '%.*s'"), entlen, name);
+				goto out;
+			}
+
 			oid = &sub->cache_tree->oid;
 			mode = S_IFDIR;
 			i += sub->cache_tree->entry_count;
@@ -956,27 +972,50 @@ static int verify_one(struct repository *r,
 		strbuf_addf(&tree_buf, "%o %.*s%c", mode, entlen, name, '\0');
 		strbuf_add(&tree_buf, oid->hash, r->hash_algo->rawsz);
 	}
+
 	hash_object_file(r->hash_algo, tree_buf.buf, tree_buf.len, OBJ_TREE,
 			 &new_oid);
-	if (!oideq(&new_oid, &it->oid))
-		BUG("cache-tree for path %.*s does not match. "
-		    "Expected %s got %s", len, path->buf,
-		    oid_to_hex(&new_oid), oid_to_hex(&it->oid));
+
+	if (!oideq(&new_oid, &it->oid)) {
+		ret = error(_("cache-tree for path %.*s does not match. "
+			      "Expected %s got %s"), len, path->buf,
+			    oid_to_hex(&new_oid), oid_to_hex(&it->oid));
+		goto out;
+	}
+
+	ret = 0;
+out:
 	strbuf_setlen(path, len);
 	strbuf_release(&tree_buf);
-	return 0;
+	return ret;
 }
 
-void cache_tree_verify(struct repository *r, struct index_state *istate)
+int cache_tree_verify(struct repository *r, struct index_state *istate)
 {
 	struct strbuf path = STRBUF_INIT;
+	int ret;
 
-	if (!istate->cache_tree)
-		return;
-	if (verify_one(r, istate, istate->cache_tree, &path)) {
+	if (!istate->cache_tree) {
+		ret = 0;
+		goto out;
+	}
+
+	ret = verify_one(r, istate, istate->cache_tree, &path);
+	if (ret < 0)
+		goto out;
+	if (ret > 0) {
 		strbuf_reset(&path);
-		if (verify_one(r, istate, istate->cache_tree, &path))
+
+		ret = verify_one(r, istate, istate->cache_tree, &path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
 			BUG("ensure_full_index() called twice while verifying cache tree");
 	}
+
+	ret = 0;
+
+out:
 	strbuf_release(&path);
+	return ret;
 }
diff --git a/cache-tree.h b/cache-tree.h
index faae88be63c..b82c4963e7c 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -33,7 +33,7 @@ struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct index_state *, int);
-void cache_tree_verify(struct repository *, struct index_state *);
+int cache_tree_verify(struct repository *, struct index_state *);
 
 /* bitmasks to write_index_as_tree flags */
 #define WRITE_TREE_MISSING_OK 1
diff --git a/read-cache.c b/read-cache.c
index 4e67dc182e7..d72a3266b6f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3331,8 +3331,9 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	int new_shared_index, ret, test_split_index_env;
 	struct split_index *si = istate->split_index;
 
-	if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
-		cache_tree_verify(the_repository, istate);
+	if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0) &&
+	    cache_tree_verify(the_repository, istate) < 0)
+		return -1;
 
 	if ((flags & SKIP_IF_UNCHANGED) && !istate->cache_changed) {
 		if (flags & COMMIT_LOCK)
diff --git a/unpack-trees.c b/unpack-trees.c
index 9a55cb62040..21cc197d471 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2070,9 +2070,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->dst_index) {
 		move_index_extensions(&o->internal.result, o->src_index);
 		if (!ret) {
-			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
-				cache_tree_verify(the_repository,
-						  &o->internal.result);
+			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0) &&
+			    cache_tree_verify(the_repository,
+					      &o->internal.result) < 0) {
+				ret = -1;
+				goto done;
+			}
+
 			if (!o->skip_cache_tree_update &&
 			    !cache_tree_fully_valid(o->internal.result.cache_tree))
 				cache_tree_update(&o->internal.result,
-- 
2.46.0.551.gc5ee8f2d1c.dirty

