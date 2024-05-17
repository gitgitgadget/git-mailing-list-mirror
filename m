Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225724215
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933935; cv=none; b=l1letTI8nCiOCIGk+/pjuobzHKPmoFffSU1ufseNTF66eYhWT0cLnmvX87n3NJad7ITvq8Amc/9ki3UDJVqzsBVH3hGCDymYIh1n2YoSRjEUB5tdvwypXx4E90AhyjCQA6NRSviyoZ41LTAGfUdQEKBXGWV6K79bpdyA4RzL3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933935; c=relaxed/simple;
	bh=4YXQoQM9Y9hw1XSnOJme6sAwnBfbkEb07yzfXWD1qa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYNRy9Xh4EEbfy+ehcMS1Bebl1/E8mC+jcNmsbThdRtIj7FcMNAYnWg20D/wkzR+Da28K20FpBLyyLxgq11qqi1KWR2iUp0ErfRSuMDuDG4ERMBZOAf9g16c+Nm1XYHi6iSpzDsnDBgDgEuUdpwX+bvMV7onZ5mJHgaRm4vF1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p9IBuum2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dY2W8tH1; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p9IBuum2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dY2W8tH1"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2D14E1800178;
	Fri, 17 May 2024 04:18:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 17 May 2024 04:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933932; x=1716020332; bh=CK6uec6NSq
	CU8ZuRMyAcNGm6d1LXPxgWyVt6KQubaHo=; b=p9IBuum2LHgyeSCrVjXCfGvFNr
	M5eEltWKlqnLyHljunee5F81+KdbSLsY0T92CALshB8OsgHcezIaLRsXS/hfcpqm
	2rqiwXOooaSMhcDREWgiId3Hs+WCRIRvBXfsnwwKoPsPYXQC5R+73LIk3iDyzjsk
	w9EeB3DmMxerasq2qXUTrVlv8krfYHuPjRpDPaMutx4H+y2hEHaS81Iji12BhDvV
	jFLeAbqUhd2VzkVHmvXjgfvxJQj5VCrz81NHNrsBjp7/DB8N9iUPSA9I575x0vvX
	0EGP+FtVJISNH82lWOQXY7inrSy6cm45b+k0IESZ/A1UJUnOTLFb0ixWNrGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933932; x=1716020332; bh=CK6uec6NSqCU8ZuRMyAcNGm6d1LX
	PxgWyVt6KQubaHo=; b=dY2W8tH1VOdTDex2l5ZSe5+kfTdqGMsi6PTbw3c9rPuT
	kwzu3pFpYFs/nt8WyQgKTHwtoL6+rxlzOta17jem30nLIJTRHXZwimdvFVIm3bjd
	dBy0pgmqvsb8F1wf5PtwXlApEA8wCH+soSFILZERJkok9e2wHpp3Cq0Wl0xQ2Yqo
	vJUbDcpof+ybU+cvQOZOQpylTz/gWxdwSIaXDjmmHeuo4X3It20GnKwhF+z+lT3W
	OifvnUfA+33ipnGoXjT5tdE8GH+2p3pZ/Kgj+TjhnX4IeL8w84dJGklQ64kfJCK3
	4HWlEPiy0psuJIwRkUFXjO2f2tKNtiRqo8vkc1AIzw==
X-ME-Sender: <xms:7BJHZmZKgNreDsZSOmO_EfoemjBsB8HCDPyjyJnWq7cdLTxyVbYbgw>
    <xme:7BJHZpZtdZ2JhRGgxlT6s9gDlxDNOQ2KFasLCiIQsYD5DdKDdl6HcAJQ5EXIIlQkK
    Vk0RtEswWB-J_2euA>
X-ME-Received: <xmr:7BJHZg_FHJ0FaGaFkS6aHceY2S9XOUdJPxtSBJzHEbIKa_Qwa_3DE-058DjKCRlkddjfUKoA7oguMF5VJO9y2t2-kULRgnMTXLTmaXoyMFymMorJ6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:7BJHZorNAq8JG2yRLGTRB8dfQu7Gkb9sD2ELEIzb_ydc62qEMkIj5g>
    <xmx:7BJHZhpEV2wRWcSs82XDBfdQLGk54xUS7anAe7r3D8hKglCA1avcRA>
    <xmx:7BJHZmT3NV3QgUs01M39IK9ee7lNzuo8RaDLTC9yEQQYXCPa2vn53w>
    <xmx:7BJHZhq_C2dGvoee_wFoAMvgDmsCIAY3grsRa_dx9Ccmwcfjsr6yfQ>
    <xmx:7BJHZoVluEv0bnY1DaEXJmTIT6iGu_ELjDK8Egj7BonvSh3Fl1Ieu5jx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:18:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7e409ba4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:18:24 +0000 (UTC)
Date: Fri, 17 May 2024 10:18:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/16] refs: convert iteration over replace refs to accept
 ref store
Message-ID: <5306122d5806cf563cb6908480b78fcb12ba06c1.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0FEXXCRniDvPHsx1"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--0FEXXCRniDvPHsx1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `for_each_replace_ref()` is a bit of an oddball across the
refs interfaces as it accepts a pointer to the repository instead of a
pointer to the ref store. The only reason for us to accept a repository
is so that we can eventually pass it back to the callback function that
the caller has provided. This is somewhat arbitrary though, as callers
that need the repository can instead make it accessible via the callback
payload.

Refactor the function to instead accept the ref store and adjust callers
accordingly. This allows us to get rid of some of the boilerplate that
we had to carry to pass along the repository and brings us in line with
the other functions that iterate through refs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/replace.c    | 13 ++++++----
 refs.c               | 58 ++++++--------------------------------------
 refs.h               | 17 ++-----------
 refs/iterator.c      |  6 ++---
 refs/refs-internal.h |  5 ++--
 replace-object.c     | 10 +++++---
 6 files changed, 28 insertions(+), 81 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index bc2a948c80..b09c78b77d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -43,11 +43,12 @@ enum replace_format {
 };
=20
 struct show_data {
+	struct repository *repo;
 	const char *pattern;
 	enum replace_format format;
 };
=20
-static int show_reference(struct repository *r, const char *refname,
+static int show_reference(const char *refname,
 			  const struct object_id *oid,
 			  int flag UNUSED, void *cb_data)
 {
@@ -62,11 +63,11 @@ static int show_reference(struct repository *r, const c=
har *refname,
 			struct object_id object;
 			enum object_type obj_type, repl_type;
=20
-			if (repo_get_oid(r, refname, &object))
+			if (repo_get_oid(data->repo, refname, &object))
 				return error(_("failed to resolve '%s' as a valid ref"), refname);
=20
-			obj_type =3D oid_object_info(r, &object, NULL);
-			repl_type =3D oid_object_info(r, oid, NULL);
+			obj_type =3D oid_object_info(data->repo, &object, NULL);
+			repl_type =3D oid_object_info(data->repo, oid, NULL);
=20
 			printf("%s (%s) -> %s (%s)\n", refname, type_name(obj_type),
 			       oid_to_hex(oid), type_name(repl_type));
@@ -80,6 +81,7 @@ static int list_replace_refs(const char *pattern, const c=
har *format)
 {
 	struct show_data data;
=20
+	data.repo =3D the_repository;
 	if (!pattern)
 		pattern =3D "*";
 	data.pattern =3D pattern;
@@ -99,7 +101,8 @@ static int list_replace_refs(const char *pattern, const =
char *format)
 			       "valid formats are 'short', 'medium' and 'long'"),
 			     format);
=20
-	for_each_replace_ref(the_repository, show_reference, (void *)&data);
+	refs_for_each_replace_ref(get_main_ref_store(the_repository),
+				  show_reference, (void *)&data);
=20
 	return 0;
 }
diff --git a/refs.c b/refs.c
index 70e712fcef..d705add3b8 100644
--- a/refs.c
+++ b/refs.c
@@ -1576,53 +1576,12 @@ struct ref_iterator *refs_ref_iterator_begin(
 	return iter;
 }
=20
-/*
- * Call fn for each reference in the specified submodule for which the
- * refname begins with prefix. If trim is non-zero, then trim that
- * many characters off the beginning of each refname before passing
- * the refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to
- * include broken references in the iteration. If fn ever returns a
- * non-zero value, stop the iteration and return that value;
- * otherwise, return 0.
- */
-static int do_for_each_repo_ref(struct repository *r, const char *prefix,
-				each_repo_ref_fn fn, int trim, int flags,
-				void *cb_data)
-{
-	struct ref_iterator *iter;
-	struct ref_store *refs =3D get_main_ref_store(r);
-
-	if (!refs)
-		return 0;
-
-	iter =3D refs_ref_iterator_begin(refs, prefix, NULL, trim, flags);
-
-	return do_for_each_repo_ref_iterator(r, iter, fn, cb_data);
-}
-
-struct do_for_each_ref_help {
-	each_ref_fn *fn;
-	void *cb_data;
-};
-
-static int do_for_each_ref_helper(struct repository *r UNUSED,
-				  const char *refname,
-				  const struct object_id *oid,
-				  int flags,
-				  void *cb_data)
-{
-	struct do_for_each_ref_help *hp =3D cb_data;
-
-	return hp->fn(refname, oid, flags, hp->cb_data);
-}
-
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 			   const char **exclude_patterns,
 			   each_ref_fn fn, int trim,
 			   enum do_for_each_ref_flags flags, void *cb_data)
 {
 	struct ref_iterator *iter;
-	struct do_for_each_ref_help hp =3D { fn, cb_data };
=20
 	if (!refs)
 		return 0;
@@ -1630,8 +1589,7 @@ static int do_for_each_ref(struct ref_store *refs, co=
nst char *prefix,
 	iter =3D refs_ref_iterator_begin(refs, prefix, exclude_patterns, trim,
 				       flags);
=20
-	return do_for_each_repo_ref_iterator(the_repository, iter,
-					do_for_each_ref_helper, &hp);
+	return do_for_each_ref_iterator(iter, fn, cb_data);
 }
=20
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_dat=
a)
@@ -1652,12 +1610,12 @@ int refs_for_each_fullref_in(struct ref_store *refs=
, const char *prefix,
 	return do_for_each_ref(refs, prefix, exclude_patterns, fn, 0, 0, cb_data);
 }
=20
-int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *=
cb_data)
+int refs_for_each_replace_ref(struct ref_store *refs, each_ref_fn fn, void=
 *cb_data)
 {
 	const char *git_replace_ref_base =3D ref_namespace[NAMESPACE_REPLACE].ref;
-	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
-				    strlen(git_replace_ref_base),
-				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_ref(refs, git_replace_ref_base, NULL, fn,
+			       strlen(git_replace_ref_base),
+			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
=20
 int refs_for_each_namespaced_ref(struct ref_store *refs,
@@ -2425,8 +2383,7 @@ struct do_for_each_reflog_help {
 	void *cb_data;
 };
=20
-static int do_for_each_reflog_helper(struct repository *r UNUSED,
-				     const char *refname,
+static int do_for_each_reflog_helper(const char *refname,
 				     const struct object_id *oid UNUSED,
 				     int flags,
 				     void *cb_data)
@@ -2442,8 +2399,7 @@ int refs_for_each_reflog(struct ref_store *refs, each=
_reflog_fn fn, void *cb_dat
=20
 	iter =3D refs->be->reflog_iterator_begin(refs);
=20
-	return do_for_each_repo_ref_iterator(the_repository, iter,
-					     do_for_each_reflog_helper, &hp);
+	return do_for_each_ref_iterator(iter, do_for_each_reflog_helper, &hp);
 }
=20
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
diff --git a/refs.h b/refs.h
index 90a7e2dde3..fa1f19464e 100644
--- a/refs.h
+++ b/refs.h
@@ -298,16 +298,6 @@ struct ref_transaction;
 typedef int each_ref_fn(const char *refname,
 			const struct object_id *oid, int flags, void *cb_data);
=20
-/*
- * The same as each_ref_fn, but also with a repository argument that
- * contains the repository associated with the callback.
- */
-typedef int each_repo_ref_fn(struct repository *r,
-			     const char *refname,
-			     const struct object_id *oid,
-			     int flags,
-			     void *cb_data);
-
 /*
  * The following functions invoke the specified callback function for
  * each reference indicated.  If the function ever returns a nonzero
@@ -329,6 +319,8 @@ int refs_for_each_branch_ref(struct ref_store *refs,
 			     each_ref_fn fn, void *cb_data);
 int refs_for_each_remote_ref(struct ref_store *refs,
 			     each_ref_fn fn, void *cb_data);
+int refs_for_each_replace_ref(struct ref_store *refs,
+			      each_ref_fn fn, void *cb_data);
=20
 /*
  * references matching any pattern in "exclude_patterns" are omitted from =
the
@@ -353,11 +345,6 @@ int refs_for_each_fullref_in_prefixes(struct ref_store=
 *refs,
 				      const char **exclude_patterns,
 				      each_ref_fn fn, void *cb_data);
=20
-/**
- * iterate refs from the respective area.
- */
-int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *=
cb_data);
-
 /* iterates all refs that match the specified glob pattern. */
 int refs_for_each_glob_ref(struct ref_store *refs, each_ref_fn fn,
 			   const char *pattern, void *cb_data);
diff --git a/refs/iterator.c b/refs/iterator.c
index 9db8b056d5..d355ebf0d5 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -440,15 +440,15 @@ struct ref_iterator *prefix_ref_iterator_begin(struct=
 ref_iterator *iter0,
=20
 struct ref_iterator *current_ref_iter =3D NULL;
=20
-int do_for_each_repo_ref_iterator(struct repository *r, struct ref_iterato=
r *iter,
-				  each_repo_ref_fn fn, void *cb_data)
+int do_for_each_ref_iterator(struct ref_iterator *iter,
+			     each_ref_fn fn, void *cb_data)
 {
 	int retval =3D 0, ok;
 	struct ref_iterator *old_ref_iter =3D current_ref_iter;
=20
 	current_ref_iter =3D iter;
 	while ((ok =3D ref_iterator_advance(iter)) =3D=3D ITER_OK) {
-		retval =3D fn(r, iter->refname, iter->oid, iter->flags, cb_data);
+		retval =3D fn(iter->refname, iter->oid, iter->flags, cb_data);
 		if (retval) {
 			/*
 			 * If ref_iterator_abort() returns ITER_ERROR,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 178a355eb0..07e24c8481 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -503,9 +503,8 @@ extern struct ref_iterator *current_ref_iter;
  * adapter between the callback style of reference iteration and the
  * iterator style.
  */
-int do_for_each_repo_ref_iterator(struct repository *r,
-				  struct ref_iterator *iter,
-				  each_repo_ref_fn fn, void *cb_data);
+int do_for_each_ref_iterator(struct ref_iterator *iter,
+			     each_ref_fn fn, void *cb_data);
=20
 struct ref_store;
=20
diff --git a/replace-object.c b/replace-object.c
index 523215589d..73f5acbcd9 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -8,12 +8,13 @@
 #include "repository.h"
 #include "commit.h"
=20
-static int register_replace_ref(struct repository *r,
-				const char *refname,
+static int register_replace_ref(const char *refname,
 				const struct object_id *oid,
 				int flag UNUSED,
-				void *cb_data UNUSED)
+				void *cb_data)
 {
+	struct repository *r =3D cb_data;
+
 	/* Get sha1 from refname */
 	const char *slash =3D strrchr(refname, '/');
 	const char *hash =3D slash ? slash + 1 : refname;
@@ -50,7 +51,8 @@ void prepare_replace_object(struct repository *r)
 		xmalloc(sizeof(*r->objects->replace_map));
 	oidmap_init(r->objects->replace_map, 0);
=20
-	for_each_replace_ref(r, register_replace_ref, NULL);
+	refs_for_each_replace_ref(get_main_ref_store(r),
+				  register_replace_ref, r);
 	r->objects->replace_map_initialized =3D 1;
=20
 	pthread_mutex_unlock(&r->objects->replace_mutex);
--=20
2.45.1.190.g19fe900cfc.dirty


--0FEXXCRniDvPHsx1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEugACgkQVbJhu7ck
PpQHgw/8DU7MsEv8GxCkZ7XsUkOZnUFg53fzzlh6GLJ87TcqrCFVOQ7EdEgQfg3i
k0xFq8IMDP3ohScZb/11PI35X9dHkoQDoFhpMZ/oYnZBgqtBNfSbImaGs3cPosB5
m0N4RriFpVdKYA97Db3vCuvUcZnsd9B/nsV3h5jO4niuKYDlxNXKH3X8//3bjo9D
TEbZp41UPCHB7dOm72aeCHnNkWPAGgiGJp6Fw0caS49A+x/4zHkg5ZJJ7DeGksQx
qnrxJZ5W68tgO6J8/V5Byydt7pvNlH4QizjsKZpMreTyKqlPrHrDpK8lCTJJaaE7
sKFgu6KyBuKHS13wqV3+N8o+Wi0IuKtsXPYqAZmfOZ7vTQwSU9phXJrtXzx8uOLr
FaiUwB+/gVpsJOpwkcCoKs50Ledg++KD0TqQiYSs3WZrijp75cy4Qa2j109y6VFi
2R+qgMhGHoc7LMq+LcMQEbAdDtpNAudr8/Y1fe6z/foY/a4egTvTM0n2Mj5CNCfC
OGCQ5r1tskcVOpLoKe8GeELLMzB7Wj0hXtJDDRGn/UZsbxOe4q/mAtpxAfxB4E6f
8jfpkPr6nRyiql5hDzZvI1NX0X/5I48kTc+oIwH8PJrvUpTxiLahiEUgknj6QmMv
3nX9jNxTTYKvG1jVeCudEITPuSlTSqW3zoC0z7b8xiaupIjWPLc=
=pfGV
-----END PGP SIGNATURE-----

--0FEXXCRniDvPHsx1--
