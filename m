Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4F5D477
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275902; cv=none; b=n0MvXpXLnBDBB8vzG5sJd1RsCv/tBmOceBCJ9YoPKsXxTpLrMQcjDAV7F0UpOCu+rEj28ZLzQ8QDvx7rLdk7ZFJTuSOuHBG7yjcDPr4NxXycpPGKJKTPjDORASD2SUcP6fHG2FYwq20DXFmCM8qz67kyoi/Az7UZ1EUUVc3invA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275902; c=relaxed/simple;
	bh=AUYc22wSOGPlZB0KShJt3BRQZGa9yu9+9oIS3O/KD6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwhC5TDt72aWr2GPTUmkb0jeOWBtzTK3sbDZ/IGpDfc3PlENvcYN8ym4S/wdAGB1XDjjUNUinDxX5aUJFpF0Q+gcq8KnO7kijEWT6GeOcCdaaf52jHV+n5LVzniS7BX+tils77CCXTGJDeJ19u1ha6IEGJV1yAHpwavM0X4kKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O1pTNxTV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KX6p8Ofd; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O1pTNxTV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KX6p8Ofd"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BEFBA138034A;
	Mon,  7 Oct 2024 00:38:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 07 Oct 2024 00:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728275899; x=1728362299; bh=uN4jtwgOGZ
	WntI0xlqqIEFk1jv3waCoLgB5UzjTlXYc=; b=O1pTNxTVeAc/G4QcncRu+LcFPd
	2XYXVsTzrkWBw3SBcORf1LZ/+o53ftCYRI7KPGJ+aQ6a40OM+LkECZMDyZimOaoW
	VJloVJ/Ui3NTckFRABqsf/wR77GhKvSe0uoBvtYhNg9zkRTUHtwua2TT4yryseTH
	mhdXU1lYtbIgGFYSmHFzTYou/2fBTU3dH7N+gUmvje22UohMS8ld0L/81OYpBBdW
	GjnZSdx76IT2A8NJs6WfK58VRzb8zg5alxqNUxJRP10OgMtmaBcdTEn1euhfUWv/
	eZrvfAyQNYV1rJY41LyvxUEeoNfvL28rnhxxPZNoobYbBrQFDpEMRAWb5LsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728275899; x=1728362299; bh=uN4jtwgOGZWntI0xlqqIEFk1jv3w
	aCoLgB5UzjTlXYc=; b=KX6p8OfdQAkhcBFS5ifMiHeP5e8insfm6hC5tMzkEUFJ
	LHZtt2yiDrbMXEPwsdlR+JOLZJOHczXOZSTt4v6//AEm5RLuzGeDnRFF7H0l9NtC
	EPBp6ZONX/fZ0wu5B6tdJMkV733TLpjElz8bRmLJ6y69tsH1QCD/7ugt0zPfzlJM
	UfygF0Nbep9cUT4DnS+p2v+vO+Yx3rG2LiCbmiLVRQqcrI2upNX5emtE9lO7LUiv
	2Pgdnrs3U3kwBifzKxV8W9QaUmdvRn7KseQXMX/QDq1Qqi9jELEtCrqj/xzYWCjm
	594Bqt5Qk1oLZizB6h8RB/edJkqKD0nPwJAk3hv7pw==
X-ME-Sender: <xms:u2UDZ9XucfjZtYFu-MI-2MkPSRT1Gx_ldKdwfdJYTadZxxJU6i7agg>
    <xme:u2UDZ9kqaE_5W8SzSoKTC0ZtVTZEGUXY4WWfV4TXB6iKk-wwti_uzVRbpvMsgHJMl
    TlDvHiVdbQURLOezg>
X-ME-Received: <xmr:u2UDZ5aMRQuwkHFZWcV7lUze7ZF8ahi138mOXlBA467hbXm-OIDPg4h26GSog7l2_35opc2XtxKCfIdrDqV9FLeotu2z3dhVVqa4QB0-kSIuJNvKbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:u2UDZwUMFzyAA1TxF21YyMYIUpzVQfQu28Ry7xyZDHHM5zBnvBzj3Q>
    <xmx:u2UDZ3lgfPFPl4TCr8dExEVrv6iMzE09F1uC-W6P7qnJ4FbHzeYTmg>
    <xmx:u2UDZ9dlFO-gJhT65jW2KvBAJdTPLRpyauuEJ2Hi3nXt_6e8vYBXNg>
    <xmx:u2UDZxEYAOYpqb1uLhGmuSzN_RhZpys8S1LuYpz8G5nmLWEKgp3k1g>
    <xmx:u2UDZ1gPnaOeaNfL1TxUwit00C82eWTducMn6Ea8-WrhLmvUPPkXFYmV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 00:38:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8f00077b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 04:37:19 +0000 (UTC)
Date: Mon, 7 Oct 2024 06:38:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] cache-tree: refactor verification to return error
 codes
Message-ID: <df5a2d0dbcdf291d3a0f6e0cc24facf29ad09685.1728275640.git.ps@pks.im>
References: <cover.1726556195.git.ps@pks.im>
 <cover.1728275640.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728275640.git.ps@pks.im>

The function `cache_tree_verify()` will `BUG()` whenever it finds that
the cache-tree extension of the index is corrupt. The function is thus
inherently untestable because the resulting call to `abort()` will be
detected by our testing framework and labelled an error. And rightfully
so: it shouldn't ever be possible to hit bugs, as they should indicate a
programming error rather than corruption of on-disk state.

Refactor the function to instead return error codes. This also ensures
that the function can be used e.g. by git-fsck(1) without the whole
process dying. Furthermore, this refactoring plugs some memory leaks
when returning early by creating a common exit path.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 cache-tree.c   | 97 +++++++++++++++++++++++++++++++++++---------------
 cache-tree.h   |  2 +-
 read-cache.c   |  5 +--
 unpack-trees.c | 10 ++++--
 4 files changed, 79 insertions(+), 35 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 50610c3f3c..4228b6fad4 100644
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
index faae88be63..b82c4963e7 100644
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
index 4e67dc182e..d72a3266b6 100644
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
index 9a55cb6204..21cc197d47 100644
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
2.47.0.rc0.dirty

