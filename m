Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874D208D0
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105915; cv=none; b=MPE94zqT80oqTlgEtXwI2WOdd9VNwqhF12jG7LU6CYH9lFHo2+xvppkhE8kaVKHgZb/ACfhq+ANEHXagpQIIUbdpy/UxTgVihdI4GBBVzeD00f4N4yMT8lAVYsY5Nrf2dEGoTEHHsvQAELZtO/yvVykGu4mZDvujXWsViKmOmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105915; c=relaxed/simple;
	bh=I6PO4/BzosFeDrrv7+cysnv0nGkgHHfu21vDtYUn1CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQ0MP/3f5Tapd6bzVRSlwrGzfnpmqrLv9LGkQE+R21eVzaauKBzGRXTmeeSFfQEf8WVYQeg4OKMXm9arNFO/BnxuLFqIVih0JVfrtufFcGW5aBY+xyNWk1WUcShTIWRzwsnazncs4zPsEi52zyOeB53KVyLnNckzawXiCqBhNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m5CotogX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CcV1DQhW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m5CotogX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CcV1DQhW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D1BBFEC00F8;
	Fri, 11 Sep 2026 01:51:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 11 Sep 2026 01:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105911;
	 x=1789192311; bh=6evjam9/ZL8oHG7dpMJUDx75j0/GXWcK4zWH4Tww3PY=; b=
	m5CotogXVXtH1Xc6UdTKJbafV+9Hk5v9JjYdCUdT24C/XxuyIgFoP/Q4fcWVYJeK
	zMo1EGNojqxVblkJ6LvbhYnQjrKU9u8dhwP0DTXJlRhHlP1rZ9LTE2hNVsReNuOB
	EQHN8QL4Hxi2RKzUbhoDN8GQlBuWqOhPNOk8i4KRnXv63Uh0QKaw8t8W7Y9hjNVt
	PKqkIjNpZ/ROY+Aw81Gxkk228HlVawiJqZ96Skh46/BYObG6iY0fl2f9tbatiid3
	w6hjqvju7gSyWiiQ+2fu2sJq1HuavDrU+2WCkD98ugMGDV6ed4Lf17KarZ0sIBKR
	mRiQuSQ0Nk0ibIVHYC8M+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105911; x=
	1789192311; bh=6evjam9/ZL8oHG7dpMJUDx75j0/GXWcK4zWH4Tww3PY=; b=C
	cV1DQhWxNBnX279ND4Ar5uccqFi9CQSsxo17iJh2cnbzUzPpAApPyEd0oQGkpUq+
	qosuBo6/wgDPF39h8l3Xgx4B5uQt9Azsr3L1IZkfaiPZFXBx/+UIXGile+4Pr44j
	xMPs/jWYSrc5hcFPgK3vEDhttg9PLjVLMmjsBmZH2m8/XObehV19bzRsJSYgbz4b
	IQjVAvB6sVqoIU2Dw5asG5HavatBiakwH2LgYtf/sUCdRwyKQemAsiM5O89C6iBr
	VsBmFiOSVgGjDYsQ78bKUpn9fP9+ajIt6etGc3e4AMfhl24F1SX9K7C9lLaaP8VG
	KhxZCS4joCHPnXyT9jfmQ==
X-ME-Sender: <xms:95ajatRSxSPFmQISXfpIF1_cBb2oj__7qG7i1sv2gSORQrojh0VdCQ>
    <xme:95ajaqDEXOv3V52-hwidUrnEWWQEhIgmMa1Gx2B0Fqg7OMfM474MrdQmkEM9rNE5y
    GqlQrQMfebG3svS66Jkf-0guHy2tTLTiu9jLFpM_9roSJmiS96jYtM>
X-ME-Received: <xmr:95ajasT7cXtzHzLDG4RjaJnlro80_2830OVIBBNVUWDNI1HiDSi_GwP9FTc6Cop07DYW6Q>
X-ME-Proxy-Cause: dmFkZTGbR+PpiMq/fYfcuarwQV619CtY/MIm8GXs7zsD2KuWA4drZUKw2GRt7Zp2Cy/Liq
    c5iYI85CYguPgbniJsqKgoamONuuzuQR7prkUQk0vuMFV3jCpFs/aGLCVSaoY0btBxL5Wh
    SwcyTSk8tz3IRcGYsoFeunEvJWfWh03ARictEtKUvntt91alGWX/E9rvWaeneBCcmEQe1V
    evMAVbUeFKJG1HnDZeJ+md2JETzWXS2/Xno+f6T1i0PYk7SHmwaHOjoSdLbXITljySQNyr
    9BV2JnubFRVMA2jKadAOPtRfLbGlVVfih1dCfcOs7+VCAxXW8e7jj62ep8WEieEfgbOaeR
    Ncwct5PtI3pHcceoaVLdfPcly3g/jjpCSmyn7ojSctQWppA0WGWMunHtk3uN1hBElA9apf
    5DfnuTb/EqWrVzS+vz3/E19+CmYHHDZFR9XpdfEy+ybRmZ1e4FWWLPFzO+HWQqhn81Z4du
    XMK/dwNKde07ECBstWPXRKlrLdmM3tJqzHDjs+uSXkryUVYTzDPSdBv/lTg42f06t7lMIV
    Jw4WgaCzdejYhAXcdVH21KOkBjIgm41f+TRmcjzR/i2FdG/F3OCVmhR4s6/Fu8AQmXxJfB
    E5997lcUdcVS5tu0TqWuNdasAFlNqsbaqrG4st91EVdbuWPmXsV2EPtLpxwg
X-ME-Proxy: <xmx:95ajagrGy3KuowuvjUTVA3q5Tqj7wDGZa8X6YO3cw7ai9U0jmeXSug>
    <xmx:95ajamzPeTxLKKF5V1PmdNbit6A5u3QYRaTlM9PviU-8mtALtns5zA>
    <xmx:95ajatJim31Ajy1KnrSAok4YqrJsjU92HHFw_wFsAuFyQfRE3d6Xyw>
    <xmx:95ajagKAuK4NykJN-RW1LI3Xrv2bwgBgnwvArimvcP1dAQaq1O2FqQ>
    <xmx:95ajaipBWR0jGG4SERycPW_hDau_4bb5wK4BKoZiiJoRSTwCHvxIjAh0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:51:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a513dab9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:51:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:44 +0200
Subject: [PATCH v3 01/13] cache-tree: drop `the_repository` in
 `cache_tree_fully_valid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-1-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
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
2.55.0.1074.ge7621b4bad.dirty

