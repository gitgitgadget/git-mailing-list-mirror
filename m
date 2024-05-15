Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097C43AA2
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755858; cv=none; b=WqvIr2lTXu6Yr7ibZGMBAApkhfUoU2vVuFoUerD4/aWRn3SUXImG+LxeKph8jurrSZCfVu/QgkT7Lcuwt6jL6I0JnA0/jdJmYrOq8Z75cwmnHmltIh0ZdJukjHepHVz6D5FUxXSgWDuhdGzvYdhkAxXGOcuZjcxQvLy2M3U7TDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755858; c=relaxed/simple;
	bh=1WgV7JPSJ045xVp3ygSo6IxrxNULl2vN6J7CH2orFnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAb76wsnK22sUfZGakTP3ElUWM8Nw85A7XLti8Zr1V5ezu7hghFD2ZVR6Yueeq3xgMkwb9gYbUcFrslPS3FROEZV89ESTj9wfXnYyvbbmVdzXp4KC8X9/453eCgvBnE3+PT8DhyrvltVbw8+/qvdn5/6d9OOzZkcGrgcn2/g4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iTWwR+0N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCwv+JuQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iTWwR+0N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCwv+JuQ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2D9411140197;
	Wed, 15 May 2024 02:50:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 May 2024 02:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755856; x=1715842256; bh=YHMZgg/YbJ
	5KBr45ahQ4BfqSyAJOEyvhjY4AdGqVHC0=; b=iTWwR+0NrlLrPBQfhgkpJwZ7IN
	LpZpXY2UEQgjixA368hGhj4GwplToBxrkaWRgl1Cz1euUTGcWbWvxIJmELt4xXvK
	UWuErsOcAANGvYhONW9wPN6YW5XqHi02sDs/wfDwd5naasGy3nNSoVwlZRMKW5Ld
	Yk6HDw9PIqn7Gc999SvGh3FafeS+o0BsNYvf2/ih7QABM9Qm0//w17uZi4FhEmvT
	K73NKW7vKRCwjuluoD16cElxr1AuHTFf6VaHc1LlFaNMey899dUTd4MfmoYCMkmk
	XcVb+sTFBmefzXyGtEcGghCI3n3BAUivsdUnHFRle+CY5FWXNG4vEfnT/rVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755856; x=1715842256; bh=YHMZgg/YbJ5KBr45ahQ4BfqSyAJO
	EyvhjY4AdGqVHC0=; b=DCwv+JuQeKAQZvmD6gaaTW5DyFExjcx07q23LAlOMgpI
	nXzzdkmwkl0Re0IDRyvJajw3M2yQoCBN3Tm2nNYQz+vyF8QAHA49F8rvdIR19Flh
	ZSEE7nE4cYw+tc4/Sb8kXc1z8ANnTUSZp2txwX06mZmLKHoVqnWYF4oNuAYzJWRt
	Uhxg7I9wiCW7UOXFxy9WOf1j0ko/nb3A6Ov3axNOivVzL+6n5swfj8oZpA64E6wi
	ldNEY4UGIonJ/El2BIPayi3Vh21oTBrK+fbiQ/Ll0hHOWfx71kvfJ1JjDwkaZYet
	ZjaEIEGLSSQjm9rc181TwmifuXsatgCdn/sNMv1fhA==
X-ME-Sender: <xms:T1tEZix_JPOQPSFC1v3sMaeaUsqAaIvQBiY00ExkQsRHwdzaiq2GLQ>
    <xme:T1tEZuTJUf07vUuQA2EuajilXTKrqzB4eoUMVSj7ujQeTqlCJccGqGEDbuWc_RMFm
    SV83terTwd1Hggc4A>
X-ME-Received: <xmr:T1tEZkUmxiSn_f0HLox21Aysa7nAyVNurUrqHPLo-FASDlMXsfeEHmEPbX5tZM887Vz5_MwWvNcmFLQbQu6-dN6bgw0eQoN5YdX4u9Dlzo6UbW0y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:UFtEZoi1PxFBJX7RhXAdhw_-Inh_zuR-hABvPYWl2kjhzpNw3TFNMQ>
    <xmx:UFtEZkA_3BowENl44idkHfRaIh8jZ0SJubQSrx6M68LNJHm-8TvrWQ>
    <xmx:UFtEZpIKgaBMyt0BUQYIBA6q_zE7k6INSTRPLl--_I7YAsgBoCfu5Q>
    <xmx:UFtEZrA9phMIY6pi4OJURDuwJV1bUmn5mNGOtZKVFosYWdgQxjqN9Q>
    <xmx:UFtEZg0qj1FWd8gpziYgZtL6qX44pVlS6Rc3t5zr5IBnvUObCRxHDvSQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:50:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 56773455 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:50:31 +0000 (UTC)
Date: Wed, 15 May 2024 08:50:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v5 06/10] refs: do not check ref existence in `is_root_ref()`
Message-ID: <af22581c2212088ea6a380cc1a58923abfdc4fe1.1715755591.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5aQXoNEg4Frv1Tmp"
Content-Disposition: inline
In-Reply-To: <cover.1715755591.git.ps@pks.im>


--5aQXoNEg4Frv1Tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Before this patch series, root refs except for "HEAD" and our special
refs were classified as pseudorefs. Furthermore, our terminology
clarified that pseudorefs must not be symbolic refs. This restriction
is enforced in `is_root_ref()`, which explicitly checks that a supposed
root ref resolves to an object ID without recursing.

This has been extremely confusing right from the start because (in old
terminology) a ref name may sometimes be a pseudoref and sometimes not
depending on whether it is a symbolic or regular ref. This behaviour
does not seem reasonable at all and I very much doubt that it results in
anything sane.

Last but not least, the current behaviour can actually lead to a
segfault when calling `is_root_ref()` with a reference that either does
not exist or that is a symbolic ref because we never initialized `oid`,
but then read it via `is_null_oid()`.

We have now changed terminology to clarify that pseudorefs are really
only "MERGE_HEAD" and "FETCH_HEAD", whereas all the other refs that live
in the root of the ref hierarchy are just plain refs. Thus, we do not
need to check whether the ref is symbolic or not. In fact, we can now
avoid looking up the ref completely as the name is sufficient for us to
figure out whether something would be a root ref or not.

This change of course changes semantics for our callers. As there are
only three of them we can assess each of them individually:

  - "ref-filter.c:ref_kind_from_refname()" uses it to classify refs.
    It's clear that the intent is to classify based on the ref name,
    only.

  - "refs/reftable_backend.c:reftable_ref_iterator_advance()" uses it to
    filter root refs. Again, using existence checks is pointless here as
    the iterator has just surfaced the ref, so we know it does exist.

  - "refs/files_backend.c:add_pseudoref_and_head_entries()" uses it to
    determine whether it should add a ref to the root directory of its
    iterator. This had the effect that we skipped over any files that
    are either a symbolic ref, or which are not a ref at all.

    The new behaviour is to include symbolic refs know, which aligns us
    with the adapted terminology. Furthermore, files which look like
    root refs but aren't are now mark those as "broken". As broken refs
    are not surfaced by our tooling, this should not lead to a change in
    user-visible behaviour, but may cause us to emit warnings. This
    feels like the right thing to do as we would otherwise just silently
    ignore corrupted root refs completely.

So in all cases the existence check was either superfluous, not in line
with the adapted terminology or masked potential issues. This commit
thus changes the behaviour as proposed and drops the existence check
altogether.

Add a test that verifies that this does not change user-visible
behaviour. Namely, we still don't want to show broken refs to the user
by default in git-for-each-ref(1). What this does allow though is for
internal callers to surface dangling root refs when they pass in the
`DO_FOR_EACH_INCLUDE_BROKEN` flag.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ref-filter.c                   |  2 +-
 refs.c                         | 19 +++++--------------
 refs.h                         |  5 +++--
 refs/files-backend.c           |  4 ++--
 refs/reftable-backend.c        |  2 +-
 t/t6302-for-each-ref-filter.sh | 17 +++++++++++++++++
 6 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 361beb6619..23e81e3e04 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2756,7 +2756,7 @@ static int ref_kind_from_refname(const char *refname)
 			return ref_kind[i].kind;
 	}
=20
-	if (is_root_ref(get_main_ref_store(the_repository), refname))
+	if (is_root_ref(refname))
 		return FILTER_REFS_PSEUDOREFS;
=20
 	return FILTER_REFS_OTHERS;
diff --git a/refs.c b/refs.c
index c1c406fc5f..4fec29e660 100644
--- a/refs.c
+++ b/refs.c
@@ -856,7 +856,7 @@ static int is_root_ref_syntax(const char *refname)
 	return 1;
 }
=20
-int is_root_ref(struct ref_store *refs, const char *refname)
+int is_root_ref(const char *refname)
 {
 	static const char *const irregular_root_refs[] =3D {
 		"AUTO_MERGE",
@@ -865,26 +865,17 @@ int is_root_ref(struct ref_store *refs, const char *r=
efname)
 		"NOTES_MERGE_REF",
 		"MERGE_AUTOSTASH",
 	};
-	struct object_id oid;
 	size_t i;
=20
 	if (!is_root_ref_syntax(refname))
 		return 0;
=20
-	if (ends_with(refname, "_HEAD")) {
-		refs_resolve_ref_unsafe(refs, refname,
-					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-					&oid, NULL);
-		return !is_null_oid(&oid);
-	}
+	if (ends_with(refname, "_HEAD"))
+		return 1;
=20
 	for (i =3D 0; i < ARRAY_SIZE(irregular_root_refs); i++)
-		if (!strcmp(refname, irregular_root_refs[i])) {
-			refs_resolve_ref_unsafe(refs, refname,
-						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-						&oid, NULL);
-			return !is_null_oid(&oid);
-		}
+		if (!strcmp(refname, irregular_root_refs[i]))
+			return 1;
=20
 	return 0;
 }
diff --git a/refs.h b/refs.h
index d0374c3275..8a574a22c7 100644
--- a/refs.h
+++ b/refs.h
@@ -1052,7 +1052,8 @@ extern struct ref_namespace_info ref_namespace[NAMESP=
ACE__COUNT];
 void update_ref_namespace(enum ref_namespace namespace, char *ref);
=20
 /*
- * Check whether the reference is an existing root reference.
+ * Check whether the provided name names a root reference. This function o=
nly
+ * performs a syntactic check.
  *
  * A root ref is a reference that lives in the root of the reference hiera=
rchy.
  * These references must conform to special syntax:
@@ -1076,7 +1077,7 @@ void update_ref_namespace(enum ref_namespace namespac=
e, char *ref);
  *
  *   - MERGE_AUTOSTASH
  */
-int is_root_ref(struct ref_store *refs, const char *refname);
+int is_root_ref(const char *refname);
=20
 int is_headref(struct ref_store *refs, const char *refname);
=20
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0fcb601444..06240ce327 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -351,8 +351,8 @@ static void add_pseudoref_and_head_entries(struct ref_s=
tore *ref_store,
 		strbuf_addstr(&refname, de->d_name);
=20
 		dtype =3D get_dtype(de, &path, 1);
-		if (dtype =3D=3D DT_REG && (is_root_ref(ref_store, de->d_name) ||
-								is_headref(ref_store, de->d_name)))
+		if (dtype =3D=3D DT_REG && (is_root_ref(de->d_name) ||
+					is_headref(ref_store, de->d_name)))
 			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
=20
 		strbuf_setlen(&refname, dirnamelen);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 36ab3357a7..bc927ef17b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -354,7 +354,7 @@ static int reftable_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)
 		 */
 		if (!starts_with(iter->ref.refname, "refs/") &&
 		    !(iter->flags & DO_FOR_EACH_INCLUDE_ROOT_REFS &&
-		     (is_root_ref(&iter->refs->base, iter->ref.refname) ||
+		     (is_root_ref(iter->ref.refname) ||
 		      is_headref(&iter->refs->base, iter->ref.refname)))) {
 			continue;
 		}
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 948f1bb5f4..92ed8957c8 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -62,6 +62,23 @@ test_expect_success '--include-root-refs with other patt=
erns' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--include-root-refs omits dangling symrefs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git symbolic-ref DANGLING_HEAD refs/heads/missing &&
+		cat >expect <<-EOF &&
+		HEAD
+		$(git symbolic-ref HEAD)
+		refs/tags/initial
+		EOF
+		git for-each-ref --format=3D"%(refname)" --include-root-refs >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'filtering with --points-at' '
 	cat >expect <<-\EOF &&
 	refs/heads/main
--=20
2.45.GIT


--5aQXoNEg4Frv1Tmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEW0sACgkQVbJhu7ck
PpRB4g/9HOhHEcrTp1IWMIAqgazvBt6i+KN2ta2tm744f4CVwHrbJRcmUp+98Jz0
098/GJALRAygFeqifKECU9UccsTC7l4SeRBCMwYDTqT2q5TKf+kBrvSlzYwFnKWv
qgZq3GlBejELB7Tg+Bk8t5CK4TzOcMchg3xdoB1fvue5QB05KvkMtB9qM0/wgcLh
M0yEL6tKp0eIkAfv333D2SEs83ZJ3uwDABNgyVfO8Xs8IlBAPAc/aYZqGhfOIkqM
6J035d6VrurMBHn2DKGILOnFS2u0/IYpqNm7FhosxwnKeYp0eNy2eJwz8fmsNZCm
BHjjgpHX4l4LV+q/W42ilFZ4eagjEKK2hgZZopqRZRoZCVnla7aBTZ1vKervg5QV
M3zvVRcJ81jhUSSGGnO/WUBmpH+wyRE4rY/B6opwDdiL1diOc9fXHYYsXcYgBDmg
4AH2p4Mb5/ie0r9rBnBykNcgvR/Ttk4s4eyL2tkTqDtX5IVzhXwkY/9MXXWx0lv2
GEll7D4/4/yfFnx+uEZ4bZnaNDg8HHKtlC1uUZ5YQFPmcX3e6STp6df7wEtlUQGv
f9FwONNv6dHG5hciC8XIlv5NQxfLuLrkSU1QyXRBVvrYA7TNZcMiJhxJcwo1lxD9
YfI75JQMsFC4A45PnV3s1Tlsu/kcG9GX26F6KEvDiBLWd6H7ohw=
=Vbq4
-----END PGP SIGNATURE-----

--5aQXoNEg4Frv1Tmp--
