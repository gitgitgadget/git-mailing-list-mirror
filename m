Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9569DFD
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519061; cv=none; b=AyeGS3K7bYNKQQXqOl56R/uN6z2V02Pvh0ERtmXPfjjh8KkYHsGl+oPTz2DjqDcyBF2ae3gOc9EIr/26ewIaVi54SdYOpWm67VPf/5f2teON1QEqjbSPpjHUtFvPYN5cUV+8TD8dFNBaVVJzu4epHcbSAjiJ3pZHFZrX9zj9OEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519061; c=relaxed/simple;
	bh=QBzY9NdMKWp+HsXy1tfz3bnnDF8y1+tkay1Cb9QtoVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOQ45Bd83rMxLhpSLA1tuhV0hofkfJlzhB2KTmnx5hT8mAipGlX/fh8dB9+P9zEgEAwDwra0Ltohn8glJr42+ac7n1taSRDLUcMJByR6/2OsiDiMKwwGhlGILsYvaoGrZ9kbM+jNF3lyng8ZruoT4Zwe1wCM2n8b6lbY1B6hpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o5g/SO21; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K1ci/9js; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o5g/SO21";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K1ci/9js"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 240B91C000AE;
	Wed, 21 Feb 2024 07:37:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 21 Feb 2024 07:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708519058; x=1708605458; bh=45atAu8403
	KWs/dfmMULSDbV0WyoKvBnKyfbk/eblDQ=; b=o5g/SO21Uni5SZFzOxH72qrQbx
	qKrCR9jYgEZ/n4qtWoyi9OTFCYW5Rf9MQCEVrDRY7ZShfIrfZUrkIxjg9r74uLan
	0AxCJsHnReTiIV1obwEE5SfIAfFZAEGH8OmXnJkkR/MAALTqIscJDIN3r/NvIkgK
	O1ldTsx4B1COJOzfOmeESNuGHKhNDhf7+diUQkEFNxeA2v9FuhBmQuIjbXfPc263
	NyCY59d8laUYNr20T0WMerMaKu/2RT+7sOJpilltdUBAM/JKgfgzUKZ0wGN0O8M6
	2z5rZ07nEnzBhbNeM5fKzCIK4Jbv3J2hzpkq0O5jgcXmiVFOdjhzmZJO8jrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708519058; x=1708605458; bh=45atAu8403KWs/dfmMULSDbV0Wyo
	KvBnKyfbk/eblDQ=; b=K1ci/9jsAOxW3qCyim+v8lkEG60j8HPgdfz8vVzEJ8U1
	UBCyFDsQpHFctYMJjcV49fdEWuX7CmvbJGms1JghlXLoT0kRf35wBv6UBP3g3nee
	sK+d+i44mG1/ga5dBiyPaMcMlsuzq5/XQN5PsFOUbokHt7tZbTTEfzP3Og7qvJ+0
	UR6WMkVmsjkZVAnKmbU3RAwjfYSd3BHonWBS6IaiJ8lszj08MOC9v4Ev/NLvGhp9
	zAK5w9BOFXo5xMfuQ4k5IiVpiFR0dEbMaDZcbOYFN/wE7vEDq1xTlNKZiBpQM1VI
	pRc57YRfo2ulVBJPn5ozZEm8Thv1CIpuLbe1Laut8w==
X-ME-Sender: <xms:ku7VZSEalwD2n0udeivnCwE2pHrByrw17QcNawZfbkCvMwxr3dAxsg>
    <xme:ku7VZTXiMf5nsIuxCx1vpeD6jmbt_G6PHJ-BBNFUVCcDCqhuoiV5l6ZO1OqETpbVI
    ABo6nPUDumtLmTBuA>
X-ME-Received: <xmr:ku7VZcJGtYJVWBq7Bb1G9VWWIh1r0ef9IWNCJoAntJ3qyjTkvSbJ9ZO_GiAjJMeYzCNgQQCHnPbvddn1j4zMIG3nrG-7LIZI63ReswcOS3oz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ku7VZcHYfECBfYxFNLkrQ9QRfjKqqU-A-tWIooL1P47lC1vbJhWptA>
    <xmx:ku7VZYV0FQyHVeBEAu3LJsLl7qZpCyYB-lOsLrWiOplng7XQQi_r0Q>
    <xmx:ku7VZfO2VK3PpY0ku6QgsOXNW9k53I8bdR9BM-YrG9Divj6mxQlRaQ>
    <xmx:ku7VZVitJhHcvexSx_2TAlIYWqXGRSAKMheSVtCRedYwhNQvMJQl0Pd3YMk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 07:37:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 379bfc84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:33:33 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:37:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/8] refs: always treat iterators as ordered
Message-ID: <d44564c8b3959e5f54c92f925afef67c71615820.1708518982.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708518982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I/A2NiU4qw0Z7maP"
Content-Disposition: inline
In-Reply-To: <cover.1708518982.git.ps@pks.im>


--I/A2NiU4qw0Z7maP
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
index 551cafdf76..05bb0c875c 100644
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
@@ -2220,7 +2219,7 @@ static struct ref_iterator *files_reflog_iterator_beg=
in(struct ref_store *ref_st
 		return reflog_iterator_begin(ref_store, refs->gitcommondir);
 	} else {
 		return merge_ref_iterator_begin(
-			1, reflog_iterator_begin(ref_store, refs->base.gitdir),
+			reflog_iterator_begin(ref_store, refs->base.gitdir),
 			reflog_iterator_begin(ref_store, refs->gitcommondir),
 			ref_iterator_select, refs);
 	}
diff --git a/refs/iterator.c b/refs/iterator.c
index b7ab5dc92f..9db8b056d5 100644
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
@@ -250,7 +248,6 @@ static struct ref_iterator_vtable merge_ref_iterator_vt=
able =3D {
 };
=20
 struct ref_iterator *merge_ref_iterator_begin(
-		int ordered,
 		struct ref_iterator *iter0, struct ref_iterator *iter1,
 		ref_iterator_select_fn *select, void *cb_data)
 {
@@ -265,7 +262,7 @@ struct ref_iterator *merge_ref_iterator_begin(
 	 * references through only if they exist in both iterators.
 	 */
=20
-	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable, ordered);
+	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable);
 	iter->iter0 =3D iter0;
 	iter->iter1 =3D iter1;
 	iter->select =3D select;
@@ -314,12 +311,9 @@ struct ref_iterator *overlay_ref_iterator_begin(
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
@@ -358,16 +352,12 @@ static int prefix_ref_iterator_advance(struct ref_ite=
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
@@ -439,7 +429,7 @@ struct ref_iterator *prefix_ref_iterator_begin(struct r=
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
index 51f612e122..a9b6e887f8 100644
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
@@ -399,11 +392,9 @@ enum iterator_selection ref_iterator_select(struct ref=
_iterator *iter_worktree,
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
@@ -432,8 +423,6 @@ struct ref_iterator *overlay_ref_iterator_begin(
  * As an convenience to callers, if prefix is the empty string and
  * trim is zero, this function returns iter0 directly, without
  * wrapping it.
- *
- * The resulting ref_iterator is ordered if iter0 is.
  */
 struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 					       const char *prefix,
@@ -444,14 +433,11 @@ struct ref_iterator *prefix_ref_iterator_begin(struct=
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
index 68d32a9101..39e9a9d4e2 100644
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
@@ -532,7 +532,7 @@ static struct ref_iterator *reftable_be_iterator_begin(=
struct ref_store *ref_sto
 	 * single iterator.
 	 */
 	worktree_iter =3D ref_iterator_for_stack(refs, refs->worktree_stack, pref=
ix, flags);
-	return merge_ref_iterator_begin(1, &worktree_iter->base, &main_iter->base,
+	return merge_ref_iterator_begin(&worktree_iter->base, &main_iter->base,
 					ref_iterator_select, NULL);
 }
=20
@@ -1680,7 +1680,7 @@ static struct reftable_reflog_iterator *reflog_iterat=
or_for_stack(struct reftabl
 	int ret;
=20
 	iter =3D xcalloc(1, sizeof(*iter));
-	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable, 1);
+	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable);
 	iter->refs =3D refs;
 	iter->base.oid =3D &iter->oid;
=20
@@ -1715,7 +1715,7 @@ static struct ref_iterator *reftable_be_reflog_iterat=
or_begin(struct ref_store *
=20
 	worktree_iter =3D reflog_iterator_for_stack(refs, refs->worktree_stack);
=20
-	return merge_ref_iterator_begin(1, &worktree_iter->base, &main_iter->base,
+	return merge_ref_iterator_begin(&worktree_iter->base, &main_iter->base,
 					ref_iterator_select, NULL);
 }
=20
--=20
2.44.0-rc1


--I/A2NiU4qw0Z7maP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXV7o4ACgkQVbJhu7ck
PpSA8Q//STj2FW6nulfnFu0e6y0zIsD6tE5vvmHRgWuyzS0kOwHT+L0p2wzTBMmD
RU45bn0a6zHy1cDCwH8uJ24gFxGEVx8B1L4Hf1X446QDwIqbWP1OJy7oDallbtFc
RCnPkU2F/QHT2QQkzkXCGCpkrKWkEqrtt9bnQ5R/1FK36VB21A1tNkUzJjZ8BAQr
qwkJrUzaJmuPYjs5WuLvsHmPijE+gkkE3nKjba1FkV6KgOPC3nehZ1eI7KTPvd4q
U9Vqd3PpCSmqYZGe+XWvRITKflczxqxYNfwsXEUQPiyL6YnRU4+MM8oHKlxdFXg8
TzJzgglfgv/EyExUK9Ha+o1Lml92tiihSCz1vBTwxqzZMOqJoxbTZpSi2fP6Krk+
5JAnUpiEN8ifkVmtcgMrfahl6Sqc7FeiAzY1TOSV8POGrv5HrQVty0Zk7F8AvX5T
jzXSmpzzg0QS/TkpEVDAignq1a5W76YWXZc+ZrwnZDPXWwWuu1OAGpNPLjQvK9j0
+10a3OYjHnEw5suZ0oH4By1RUuA6Cn55oz8HyGikfnAcLLAR6RcN4X5Gs5zq7RjY
G6YCkpEPEueub+p+NQBjmLz9n4lAnTquRKsTQF1IxcUxuJTQdjDwl8OnXeLlPSbp
U2abc5G96FtHxFv3xYv66pA9SeCVyaDb069WWAI0PU+s7ee+OJ0=
=un5y
-----END PGP SIGNATURE-----

--I/A2NiU4qw0Z7maP--
