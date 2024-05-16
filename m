Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF34134404
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846693; cv=none; b=HZfxUq3nshf13t7BefmpP2HZXZH5POfLnkw6UyjYg8hK5kR6XtHHyAu1Ee8Y6Y4bZv8LIjeLXgwg/pZr2upTLhHPgv7CqTUbx54n6NP6zcNWyFj1pfL3gI+O8gBmY8HbFdDFU31DngHsQBjXzHwMuoZ8t717jxO+PjvJOzFerHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846693; c=relaxed/simple;
	bh=2VsIhrbv5RIlC8mwbqnmdNsmUyeJpPYli18bVJzGWR0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm3g9IpIEfvBq68rCwk5S1+TAyEb/1GXJ4nAxmSoJUH3jl0CoplZhaAdo7lkBAWDb7im2+ue3FFq6gdck8JX5EiFTkos3z8NHj4pXpmDGvmhgMrYvQShrVQxPEo9YuA8IvgDIhZjZFpKRRYx3Cs7OEAeWPZAKhYBoSuOfEFwOw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=olyz5Q4K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fW1oe5Mg; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="olyz5Q4K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fW1oe5Mg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0C86F1380282
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:04:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 16 May 2024 04:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846691; x=1715933091; bh=ieijI9OHGb
	iVAeodlTBlD7C1wksib4B9ge48d94o3qE=; b=olyz5Q4Kqz/E40OG0Oa9lOZ+eN
	pC2es3LjDGtKXfa6eYXEw5yIAIiH7HbFMX8de87KQnCsnv57+4KqXl8oAYrJ4rjn
	uHmMQlPREl4UNectNwqkjb9uushcaEErhZsZf0NCgKSueVOHvkSBnl8MGGw1qcsY
	Q5eJwM6AqSxbIDhPvvFVS3AOU1gnpRuVk7HyTlSkFAvQHQo2SQbUnH8HJ5Slb2XW
	w+9QlnvqDg/paI9N8MrikikwXHKdKcvCcwCnqstIvIAQdn/8YPo1yQU7PiGYEbQI
	pghO+z2rVjbn3cNbck0rq1Nak5C3ySDGDjhpEqOKedkM0/Nms8wrPgjoPUSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846691; x=1715933091; bh=ieijI9OHGbiVAeodlTBlD7C1wksi
	b4B9ge48d94o3qE=; b=fW1oe5MgF/9y9gF3nl1UnwfcFbk7rZ/SaFc9qOwHX4jN
	ULNSX1U0OA7nXv52cGca+kZZuTwktHxJD6p7cEnYSStIRskkaztWox/AlVPqiVkM
	vQz9mBKhgHNlrpl9F2/Y6Nv0OEJ48xk5KBSc/SEKNYgkYunEzogIhAWNT5i+O/JY
	SNewejnpCAZl++5jAeioD0Ql9lnDw4K9UrkJS+HAjpv/exvSIk33r6g8Cka5ZGqs
	tjo8Wjzrb5o2ZOAAvNLYseK9k2tpBxkUqALDskAyLerSj7DUmFr1JZh6K1VxxWi0
	jizjciVTC//YYR9Rm/DmiivBAWAEHl+jX/88f/B8gg==
X-ME-Sender: <xms:Ir5FZqLeA9cs8dS6a8Sb4_2rUVRt9FxEW6PpytmJ_Yy7-Cg8MLp38g>
    <xme:Ir5FZiJz-QdWdBYL6VIcW-ESwwc4cqlUoUyN0VqjwXCeOVXiUw5HOb6TdrVF8k8Hf
    7kTamJSp3CMiccphg>
X-ME-Received: <xmr:Ir5FZqvpXhmHuQUhIvLavLn1gelf7Fc_u0x5t2QcGR9UkFSzmR6fSeAcqBFTFITm545fgVB9M7wqU1dxSmrsmPhOEa-kRo5Fq4zGQfS2DICfBv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Ir5FZvaL4AsGzvjTn3QzZQvLPTuMhLbJPXQ7kZWMeXqw53AEvZcdXA>
    <xmx:Ir5FZhZgZmOz0koXG4hvws5RUckyMrCS5uk6qN_Bxav1ACnrUrb9fw>
    <xmx:Ir5FZrBJGXYy179JcEtc8Emo6PbXdtzQp3JTc8OmCvdLNOK27cbNaA>
    <xmx:Ir5FZnYR1gGS3Y4gCUOBUL5fuhC9kSc5KXKe8DsAFDCJvhVXZxa9cw>
    <xmx:I75FZgzgxB5dovEDgdCivDGOvEoXKDFwPgfy3WcDgjUv09MknEUw7jwa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:04:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0112ae4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:04:25 +0000 (UTC)
Date: Thu, 16 May 2024 10:04:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/16] refs: convert iteration over replace refs to accept
 ref store
Message-ID: <160e64e42ac2aebb5cb070c2834315b105214991.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sRmPhZS0AgUImj3o"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--sRmPhZS0AgUImj3o
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
index 03bf5d0e69..345d6a1e06 100644
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
index 5a2b493507..77f9887235 100644
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
index 3c3f9a3555..fc77240c93 100644
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


--sRmPhZS0AgUImj3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvh8ACgkQVbJhu7ck
PpSJYQ/+MqJErglLF85TI1ytqa/5vrrJaU6LtcIsCbHSYfJokSba9HDBqRfL5SRK
qfmX13p5FgVrQUYI3CmKmOAUZz77V2r4uoJChSLjKqgNytUpOW3WteR1ui3hEZpm
jTctmi0DAwwaW6hm7a6GbWS3Ki3Z2cHv8FkWfZWTkwWGoe25hF2jW7SVBFUgygI2
UZdW5IQVtqdmf8T6BIfV5Oc4sX+2iSX0gSChRL1azlwharP+zyoGvwKOHbLDL9qB
c5ynd8QHXtZLNJZqU5aS6fjm191wrQEIxqHwqqS6AEWLluXPjRw1fpmsAsucHR3/
VCYkV9zV6U/xOIi5vskQfiPGiApD5856RYKw55VyNvt+lriU3vk4ADY6LMYXCCMc
gEn+jDZVMT88hkKwW+EVXwYt8jZTW5+dNwL9NoJJ4zQbRg4Y+yvF9fzXses75/0t
WcAgAS1rw+84XyvtU7x71uFfJwE01iAQ2urlmArYdoSiIprP2PUNzMnT52bIuF6i
VzYvv8qdGJNpia95/d0cKUzSZOgoG7PPl/TIaGCiEFamfIPspAMNGyuSvajNgskC
K9Hr0yEvXpnJ5Ea+EUFEhbC+Rp/ocWjjivvloJjppD1zbxWGF9xcHl2i35HEf50Q
VebVb0zCqFHwraRdjXA9PvlGHQtnnLVV8eA90sm5GfHrKE9GI6w=
=h8te
-----END PGP SIGNATURE-----

--sRmPhZS0AgUImj3o--
