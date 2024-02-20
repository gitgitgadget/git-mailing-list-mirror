Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAA5FEE8
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420001; cv=none; b=sXhPWDWTg2E3ah0fkkgu8p9KanQNR1dmaeiP4Jy5cB9mrgR2jmQ7mrre25zEhR8E4NfPQl2QdQBu1hHnb7mt0k2rfmDgSEjDDxKwdgu55zeViB9xf5oM9i3aPN/KRHbiZrbcS0ZxtNxYoz0csdX6x7woSubJ3YUeTlrbPKuK79U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420001; c=relaxed/simple;
	bh=27splBBxv+Rm1rrabkraoC3LsmhqeltPw9NRFGcqP9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwCBi6fQoROfx2JGNA3mM/sHy3Gv97ELL0aa0nu568+MyjFNNLSACtg3uPcN6U0h69+A1bAzw0mCdDcYGCcom4OAYRoatX8foRGoVX7JB9rylL87dwCsC8of3ho/wH89m//Efx4iP4jLiV+LgnZ29W746t1FX1hgJXGeLDsFIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ndHdETb4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bedp0OSo; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ndHdETb4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bedp0OSo"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 165093200A17;
	Tue, 20 Feb 2024 04:06:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 20 Feb 2024 04:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708419997; x=1708506397; bh=JKCrXjctYw
	f4q1bugWTdiTBEhwmZuIOZO3Q0GEXZAnQ=; b=ndHdETb4eyhpF4S4K7hgiSUnHL
	6V+uC7/YxanoeLRyquSrbMJq1R91TWJ+GHm7jS9jKYMq4eFaVw33yZI6stAf03Sd
	JYZFbYzIXKm9/rqurdYG8PA6/5/ffTRkQ/NiNQa6bdrQU3l7Ox64W7wUktgIkxPT
	52DuKZoq2VEHPsvJFWk7zw5X7OHw776HuoUIA8IsywBSBMVLhWv+7dhe8jIt0g2H
	ayPkrsfoSE6C5teOat/Hp8qGuXY0jscviqiD+YxgIYqZAqn6UxWHERmNWY5yyp8J
	nUUfJDCzm2x/yhPQ2jB4Qk0lD0j5dpMlj1IgXagjz7BtvQT8/UtGPsUA47cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708419997; x=1708506397; bh=JKCrXjctYwf4q1bugWTdiTBEhwmZ
	uIOZO3Q0GEXZAnQ=; b=bedp0OSoN/u43JnhqazHRIUqxjx66rlLrxH4Tlfn6ik/
	LXsC0zTXF6+aTNlifIFmS3xJlo2DpfL6QgOQ+ngefLEnzmfe8HyhsMB/yiKlOoNP
	yYpucWQNpPfTpECKT34nBn7p2nBESONk0Mbilo6bLrsSPPg9uHwdRXvrcz90jSNR
	dhEIMycP7aU43B1NPv3n8Tsn0OUq7pTSrqYYxzblnxboAmF7iTJzaq6/hybwu9pt
	GOMguQMBjLvqcoki9rrD9aJJ1d0rqFd26fzz7tbOCbelpVrMTw5WYODmBgnVU3UD
	yTcXhVlvA/jszdXys8xVO/aiuTqZ3PVb4H5YoohLfg==
X-ME-Sender: <xms:nWvUZX6O0ou1b3V5sZnGAERRRuwemtemIvMz7HfGW7vksd1hQr-Ybw>
    <xme:nWvUZc77yZwcLp8Wib_zICrFeP6jpCHnK8Dr4gKIseniXj_se-iK6JiF2V6pA9hXh
    pCQCJEE4RwHV28jgQ>
X-ME-Received: <xmr:nWvUZeeig_cfhK_vchBJ4GLuNA3WaQrwIT0GT3ztAdumWhiTYlgPxmBapP0gYaetz2I2KGi60r8_uNx5JMYCIMAT0dbtJjUrIUf_tEl-mzE6Yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfe
    efgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:nWvUZYJSP2si41BOFltK7HJzmTkCJwi20OXJNeCoGMKv-tsr1V2AGQ>
    <xmx:nWvUZbKxMpavwTaPVi7pwcuAcpBYgYJOi_7FG5yfd85U3o5-DgjFHQ>
    <xmx:nWvUZRwxOiwSkewJK6Oiy_IuyWJLRK0FDK53tNPB2Yhx5HybJoBwOg>
    <xmx:nWvUZRhsie2yA5zLbB3k40nlZLLtD0msj4-sfv6EizYFK8ZFATjZIg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 04:06:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d18f331f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 09:02:34 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:06:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] refs: always treat iterators as ordered
Message-ID: <4254f23fd40076857ec093365a8adbb860803a72.1708418805.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708418805.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V2V5xAc06i4E6KmQ"
Content-Disposition: inline
In-Reply-To: <cover.1708418805.git.ps@pks.im>


--V2V5xAc06i4E6KmQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the preceding commit we have converted the reflog iterator of the
"files" backend to be ordered, which was the only remaining ref iterator
that wasn't ordered. Refactor the ref iterator infrastructure so that we
always assume iterators to be ordered, thus simplifying the code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  |  4 ----
 refs/debug.c            |  3 +--
 refs/files-backend.c    |  7 +++----
 refs/iterator.c         | 26 ++++++++------------------
 refs/packed-backend.c   |  2 +-
 refs/ref-cache.c        |  2 +-
 refs/refs-internal.h    | 18 ++----------------
 refs/reftable-backend.c |  8 ++++----
 8 files changed, 20 insertions(+), 50 deletions(-)

diff --git a/refs.c b/refs.c
index fff343c256..dc25606a82 100644
--- a/refs.c
+++ b/refs.c
@@ -1594,10 +1594,6 @@ struct ref_iterator *refs_ref_iterator_begin(
 	if (trim)
 		iter =3D prefix_ref_iterator_begin(iter, "", trim);
=20
-	/* Sanity check for subclasses: */
-	if (!iter->ordered)
-		BUG("reference iterator is not ordered");
-
 	return iter;
 }
=20
diff --git a/refs/debug.c b/refs/debug.c
index 634681ca44..c7531b17f0 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -181,7 +181,6 @@ static int debug_ref_iterator_advance(struct ref_iterat=
or *ref_iterator)
 		trace_printf_key(&trace_refs, "iterator_advance: %s (0)\n",
 			diter->iter->refname);
=20
-	diter->base.ordered =3D diter->iter->ordered;
 	diter->base.refname =3D diter->iter->refname;
 	diter->base.oid =3D diter->iter->oid;
 	diter->base.flags =3D diter->iter->flags;
@@ -222,7 +221,7 @@ debug_ref_iterator_begin(struct ref_store *ref_store, c=
onst char *prefix,
 		drefs->refs->be->iterator_begin(drefs->refs, prefix,
 						exclude_patterns, flags);
 	struct debug_ref_iterator *diter =3D xcalloc(1, sizeof(*diter));
-	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable, 1);
+	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable);
 	diter->iter =3D res;
 	trace_printf_key(&trace_refs, "ref_iterator_begin: \"%s\" (0x%x)\n",
 			 prefix, flags);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a7b7cdef36..51d57d98d2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -879,8 +879,7 @@ static struct ref_iterator *files_ref_iterator_begin(
=20
 	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;
-	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable,
-			       overlay_iter->ordered);
+	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable);
 	iter->iter0 =3D overlay_iter;
 	iter->repo =3D ref_store->repo;
 	iter->flags =3D flags;
@@ -2202,7 +2201,7 @@ static struct ref_iterator *reflog_iterator_begin(str=
uct ref_store *ref_store,
 	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;
=20
-	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 1);
+	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
 	iter->dir_iterator =3D diter;
 	iter->ref_store =3D ref_store;
 	strbuf_release(&sb);
@@ -2246,7 +2245,7 @@ static struct ref_iterator *files_reflog_iterator_beg=
in(struct ref_store *ref_st
 		return reflog_iterator_begin(ref_store, refs->gitcommondir);
 	} else {
 		return merge_ref_iterator_begin(
-			1, reflog_iterator_begin(ref_store, refs->base.gitdir),
+			reflog_iterator_begin(ref_store, refs->base.gitdir),
 			reflog_iterator_begin(ref_store, refs->gitcommondir),
 			reflog_iterator_select, refs);
 	}
diff --git a/refs/iterator.c b/refs/iterator.c
index 6b680f610e..f9a9a808e0 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -25,11 +25,9 @@ int ref_iterator_abort(struct ref_iterator *ref_iterator)
 }
=20
 void base_ref_iterator_init(struct ref_iterator *iter,
-			    struct ref_iterator_vtable *vtable,
-			    int ordered)
+			    struct ref_iterator_vtable *vtable)
 {
 	iter->vtable =3D vtable;
-	iter->ordered =3D !!ordered;
 	iter->refname =3D NULL;
 	iter->oid =3D NULL;
 	iter->flags =3D 0;
@@ -74,7 +72,7 @@ struct ref_iterator *empty_ref_iterator_begin(void)
 	struct empty_ref_iterator *iter =3D xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator =3D &iter->base;
=20
-	base_ref_iterator_init(ref_iterator, &empty_ref_iterator_vtable, 1);
+	base_ref_iterator_init(ref_iterator, &empty_ref_iterator_vtable);
 	return ref_iterator;
 }
=20
@@ -207,7 +205,6 @@ static struct ref_iterator_vtable merge_ref_iterator_vt=
able =3D {
 };
=20
 struct ref_iterator *merge_ref_iterator_begin(
-		int ordered,
 		struct ref_iterator *iter0, struct ref_iterator *iter1,
 		ref_iterator_select_fn *select, void *cb_data)
 {
@@ -222,7 +219,7 @@ struct ref_iterator *merge_ref_iterator_begin(
 	 * references through only if they exist in both iterators.
 	 */
=20
-	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable, ordered);
+	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable);
 	iter->iter0 =3D iter0;
 	iter->iter1 =3D iter1;
 	iter->select =3D select;
@@ -271,12 +268,9 @@ struct ref_iterator *overlay_ref_iterator_begin(
 	} else if (is_empty_ref_iterator(back)) {
 		ref_iterator_abort(back);
 		return front;
-	} else if (!front->ordered || !back->ordered) {
-		BUG("overlay_ref_iterator requires ordered inputs");
 	}
=20
-	return merge_ref_iterator_begin(1, front, back,
-					overlay_iterator_select, NULL);
+	return merge_ref_iterator_begin(front, back, overlay_iterator_select, NUL=
L);
 }
=20
 struct prefix_ref_iterator {
@@ -315,16 +309,12 @@ static int prefix_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)
=20
 		if (cmp > 0) {
 			/*
-			 * If the source iterator is ordered, then we
+			 * As the source iterator is ordered, we
 			 * can stop the iteration as soon as we see a
 			 * refname that comes after the prefix:
 			 */
-			if (iter->iter0->ordered) {
-				ok =3D ref_iterator_abort(iter->iter0);
-				break;
-			} else {
-				continue;
-			}
+			ok =3D ref_iterator_abort(iter->iter0);
+			break;
 		}
=20
 		if (iter->trim) {
@@ -396,7 +386,7 @@ struct ref_iterator *prefix_ref_iterator_begin(struct r=
ef_iterator *iter0,
 	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;
=20
-	base_ref_iterator_init(ref_iterator, &prefix_ref_iterator_vtable, iter0->=
ordered);
+	base_ref_iterator_init(ref_iterator, &prefix_ref_iterator_vtable);
=20
 	iter->iter0 =3D iter0;
 	iter->prefix =3D xstrdup(prefix);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a499a91c7e..4e826c05ff 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1111,7 +1111,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
=20
 	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;
-	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable, 1);
+	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable);
=20
 	if (exclude_patterns)
 		populate_excluded_jump_list(iter, snapshot, exclude_patterns);
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index a372a00941..9f9797209a 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -486,7 +486,7 @@ struct ref_iterator *cache_ref_iterator_begin(struct re=
f_cache *cache,
=20
 	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;
-	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable, 1);
+	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable);
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
=20
 	iter->levels_nr =3D 1;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 83e0f0bba3..1e8a9f9f13 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -312,13 +312,6 @@ enum do_for_each_ref_flags {
  */
 struct ref_iterator {
 	struct ref_iterator_vtable *vtable;
-
-	/*
-	 * Does this `ref_iterator` iterate over references in order
-	 * by refname?
-	 */
-	unsigned int ordered : 1;
-
 	const char *refname;
 	const struct object_id *oid;
 	unsigned int flags;
@@ -390,11 +383,9 @@ typedef enum iterator_selection ref_iterator_select_fn(
  * Iterate over the entries from iter0 and iter1, with the values
  * interleaved as directed by the select function. The iterator takes
  * ownership of iter0 and iter1 and frees them when the iteration is
- * over. A derived class should set `ordered` to 1 or 0 based on
- * whether it generates its output in order by reference name.
+ * over.
  */
 struct ref_iterator *merge_ref_iterator_begin(
-		int ordered,
 		struct ref_iterator *iter0, struct ref_iterator *iter1,
 		ref_iterator_select_fn *select, void *cb_data);
=20
@@ -423,8 +414,6 @@ struct ref_iterator *overlay_ref_iterator_begin(
  * As an convenience to callers, if prefix is the empty string and
  * trim is zero, this function returns iter0 directly, without
  * wrapping it.
- *
- * The resulting ref_iterator is ordered if iter0 is.
  */
 struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 					       const char *prefix,
@@ -435,14 +424,11 @@ struct ref_iterator *prefix_ref_iterator_begin(struct=
 ref_iterator *iter0,
 /*
  * Base class constructor for ref_iterators. Initialize the
  * ref_iterator part of iter, setting its vtable pointer as specified.
- * `ordered` should be set to 1 if the iterator will iterate over
- * references in order by refname; otherwise it should be set to 0.
  * This is meant to be called only by the initializers of derived
  * classes.
  */
 void base_ref_iterator_init(struct ref_iterator *iter,
-			    struct ref_iterator_vtable *vtable,
-			    int ordered);
+			    struct ref_iterator_vtable *vtable);
=20
 /*
  * Base class destructor for ref_iterators. Destroy the ref_iterator
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a14f2ad7f4..70a16dfb9e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -479,7 +479,7 @@ static struct reftable_ref_iterator *ref_iterator_for_s=
tack(struct reftable_ref_
 	int ret;
=20
 	iter =3D xcalloc(1, sizeof(*iter));
-	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable, 1);
+	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable);
 	iter->prefix =3D prefix;
 	iter->base.oid =3D &iter->oid;
 	iter->flags =3D flags;
@@ -575,7 +575,7 @@ static struct ref_iterator *reftable_be_iterator_begin(=
struct ref_store *ref_sto
 	 * single iterator.
 	 */
 	worktree_iter =3D ref_iterator_for_stack(refs, refs->worktree_stack, pref=
ix, flags);
-	return merge_ref_iterator_begin(1, &worktree_iter->base, &main_iter->base,
+	return merge_ref_iterator_begin(&worktree_iter->base, &main_iter->base,
 					iterator_select, NULL);
 }
=20
@@ -1723,7 +1723,7 @@ static struct reftable_reflog_iterator *reflog_iterat=
or_for_stack(struct reftabl
 	int ret;
=20
 	iter =3D xcalloc(1, sizeof(*iter));
-	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable, 1);
+	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable);
 	iter->refs =3D refs;
 	iter->base.oid =3D &iter->oid;
=20
@@ -1758,7 +1758,7 @@ static struct ref_iterator *reftable_be_reflog_iterat=
or_begin(struct ref_store *
=20
 	worktree_iter =3D reflog_iterator_for_stack(refs, refs->worktree_stack);
=20
-	return merge_ref_iterator_begin(1, &worktree_iter->base, &main_iter->base,
+	return merge_ref_iterator_begin(&worktree_iter->base, &main_iter->base,
 					iterator_select, NULL);
 }
=20
--=20
2.44.0-rc1


--V2V5xAc06i4E6KmQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUa5kACgkQVbJhu7ck
PpSg8xAAgw8Ss6Giq+h1nUBfVzmFYe7l9PZpYT/IeBLKkbPpq5+G7mRbwkRC1ir6
qTyeVNYryEn7EGwBXba7qGePF5mvObaplAARpyKF6qjuDXrHmNjwSSnJl3KcEq/n
Oq57tCToGTf6WZId+EJjr7WtfpQw6YT+X5PGHFMmwr7p3+6P+HenF4vIDtE0jl9p
d6Ta7Gy5TbhTCTn9j7pHB9Dd62x9tBL5xpYYrYua7fQEmQSQJn5izrR+X6SKw/QC
4EbSsE6YTc/C3+9Ul+X2fpHsTaTOADPLMLbsWR05aXfBSYdjzRWjLHFydvGneXxG
VEWBkTWpe6boaeDd4kxp1xukhCbtt992RKREdzzTzRk35IPdzJAW1NPyNBAqozDV
T29k9yPog2pyWY8cL+qfvwQ8Pr7H5hGLt0d73eBpvWiyMSAnsjP4p8B6Lwq+/iaa
7+384OmFabAb4jFkddQUeBpBAfvDpjTuUaROsu7ObhsNwudy0Lt6LHb8RHgzrwzk
EDEqUtPy6dPyob0ZqjPN4Kwr5k4pqEx6iIOQkSqjm6aKYVkt9I1s2oA3LaRZrzmG
oK8ERNJdhd9E2IH+Y5mWy5Be1ER0/uof4hskq9AyUqLUF18g/QRUeJqG/AFCGn9z
BS/72cEwRBIokTOveXE/F0m0VBjXBih8lH0nC0Giiu35ggD4CRc=
=IBp/
-----END PGP SIGNATURE-----

--V2V5xAc06i4E6KmQ--
