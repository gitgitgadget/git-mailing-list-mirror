Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6E336B0D
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637868; cv=none; b=aB6PtoG7pegUYvr+dUiYd6tI83Py1IIg6Xx3t36/nP0eypdvcfUIHjl09CKnAoRllIWPYJHVuM7b8csn3bT//Ys54F140B2uXD8SbOdMKlZlDDfdPAqGS+kMnVYXk6H3jfdaCIoaGb9d6GI3jWBIXn2d01SPQNkGZbofzG20bY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637868; c=relaxed/simple;
	bh=ZgXg1CpgHxDCZtX0yhEKqFu6jsPVqMBWTsqho0ewmfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJpxS6ogdWXj6GGw9SF0Sm9yAPv5JI8zDdMZuk7oW/uYxOqrBBT1r9801JN+hRTSVAEPJq9GEEoPSmhpCRAuJLCKwt3bWV2bKh6MgFdBLKBunjcOPYrztUSVRh8hjK2pm1fJA4qIkrJceAnDvWwN1lEVVwDMrl0NaCsgBOCq1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WEsJHjLN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/dXPDwB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WEsJHjLN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/dXPDwB"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0348E1140112;
	Thu,  2 May 2024 04:17:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 May 2024 04:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637866; x=1714724266; bh=nBpjVZ8uYT
	w+41G0z4MBjdNaXf+WL/x+K0mN+Zg7x2U=; b=WEsJHjLNP10nKAgd6JtjPGd2RG
	aiMGvS0nHZBGGiim2cES/fZgyTFQEDS84UAr9vgT1oFYLaO52ZmZyCqxsuL2fr5V
	Rpfzsv0aYqtK1A7LIyzxlGQSrUfq8ZRd4+kDqk88YNor72F6pA1FH40Xi2tcy4Om
	Wblv9Vtll1+NhRnXhNppVd7F3qJw3go4M+CtWAPSSH1Dw4uU4ewSrcZLhf5nNFa4
	U0Jp/szpOt7w4UHUXQQYps3hXb3WEfADoGOYUTrp6s4hvEDp5RSESbFpGdWgKufM
	k0phuexTmWPVEDrTE0vA0op1IrQeJpi1V3g0937VSlCP58XgBlxdBNfW1KRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637866; x=1714724266; bh=nBpjVZ8uYTw+41G0z4MBjdNaXf+W
	L/x+K0mN+Zg7x2U=; b=U/dXPDwBxScuInJdQRDWXOFZ3Zg1BY/R7NHoROhmipjz
	/jDpEWlovEqkGcfg3f1ECFfbsNreqEnMVVPIW1ROLoODAqI/bDApD0HjXsyZm4Ax
	YwDMVrp332N3yX+QMvvjLmuX6w0YDhCo0sQfWvnYHVrX/YwYpo3O70zlv2b2+/UP
	//ZvLVkZRs96avALMoBxVGXio3ouuUeOK7Nex60mxBCmrov82CrWPqj3mTDD1AqE
	QCDuZZqpuC02I1/PtPcExaM8lgsUxvksw0JPlbYCGiMRW223t4KbgKIFQPKgal0O
	OZ23wz+xQlVrz/SFhmGBHh+0ULPhpAmg1l0JkdoTmQ==
X-ME-Sender: <xms:KUwzZuknzDLaUEWLp0EVdRmKykArlicL3yYMy3IYAx9DvOKr_cHFMQ>
    <xme:KUwzZl1wii0e_JE3YlkfS5p1BdQJpjcENB9813FK90RwR6OkKNx8W-5fZ2oFNVcje
    8nFApP8_fBkH0npCA>
X-ME-Received: <xmr:KUwzZsq9AfgSS6mtqafIZAVBogPCMdp6KUxwtZmLdiPbNZhjvUYc9g9tpRoSkp56Y5eI6mg6DYQPnCkk6EqJoDIL16q0t7u1glzWi3_KVdsKB5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:KUwzZim3XJDvmYYl5u2pKqXZGgnwwIyde_o9VvLIEiP5bKA6FVowMg>
    <xmx:KUwzZs2WGGhhxteBBTKZ1lJq6vi8GlbeGqY_sZzVNfCzfSNUnK4BZQ>
    <xmx:KUwzZpv_1rUzbroYG55qPF53yILV8v7dfQMylIJeqmOou9sI89pBFQ>
    <xmx:KUwzZoWosRWK23dM-JtKt_meySArSqzpzIDoYc0p3daRaWF8lju9lg>
    <xmx:KUwzZtnLlGHKVISnDFxVihq0IJd6xuvkfkFCMedNiDaTKoq25PIzq7VU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:17:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f52e4df4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:17:18 +0000 (UTC)
Date: Thu, 2 May 2024 10:17:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 07/10] refs: root refs can be symbolic refs
Message-ID: <92a71222e1067ca4ce9ecaaa555d78d0cce0d9d0.1714637671.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gV5dmvb7bTCU0oYl"
Content-Disposition: inline
In-Reply-To: <cover.1714637671.git.ps@pks.im>


--gV5dmvb7bTCU0oYl
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

Furthermore, the behaviour is different to `is_headref()`, which only
checks for the ref to exist. While that is in line with our glossary,
this inconsistency only adds to the confusion.

Last but not least, the current behaviour can actually lead to a
segfault when calling `is_root_ref()` with a reference that either does
not exist or that is a symbolic ref because we never initialized `oid`.

Let's loosen the restrictions in accordance to the new definition of
root refs, which are simply plain refs that may as well be a symbolic
ref. Consequently, we can just check for the ref to exist instead of
requiring it to be a regular ref.

Add a test that verifies that this does not change user-visible
behaviour. Namely, we still don't want to show broken refs to the user
by default in git-for-each-ref(1). What this does allow though is for
internal callers to surface dangling root refs when they pass in the
`DO_FOR_EACH_INCLUDE_BROKEN` flag.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                         | 50 ++++++++++++++++++++++++----------
 t/t6302-for-each-ref-filter.sh | 17 ++++++++++++
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 5b89e83ad7..ca9844bc3e 100644
--- a/refs.c
+++ b/refs.c
@@ -869,7 +869,10 @@ int is_root_ref(struct ref_store *refs, const char *re=
fname)
 		"NOTES_MERGE_REF",
 		"MERGE_AUTOSTASH",
 	};
-	struct object_id oid;
+	struct strbuf referent =3D STRBUF_INIT;
+	struct object_id oid =3D { 0 };
+	int failure_errno, ret =3D 0;
+	unsigned int flags;
 	size_t i;
=20
 	if (!is_root_ref_syntax(refname))
@@ -877,30 +880,49 @@ int is_root_ref(struct ref_store *refs, const char *r=
efname)
 	if (is_headref(refs, refname))
 		return 1;
=20
+	/*
+	 * Note that we cannot use `refs_ref_exists()` here because that also
+	 * checks whether its target ref exists in case refname is a symbolic
+	 * ref.
+	 */
 	if (ends_with(refname, "_HEAD")) {
-		refs_resolve_ref_unsafe(refs, refname,
-					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-					&oid, NULL);
-		return !is_null_oid(&oid);
+		ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
+					 &flags, &failure_errno);
+		goto done;
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(irregular_root_refs); i++)
+	for (i =3D 0; i < ARRAY_SIZE(irregular_root_refs); i++) {
 		if (!strcmp(refname, irregular_root_refs[i])) {
-			refs_resolve_ref_unsafe(refs, refname,
-						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-						&oid, NULL);
-			return !is_null_oid(&oid);
+			ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
+						 &flags, &failure_errno);
+			goto done;
 		}
+	}
=20
-	return 0;
+done:
+	strbuf_release(&referent);
+	return ret;
 }
=20
 int is_headref(struct ref_store *refs, const char *refname)
 {
-	if (!strcmp(refname, "HEAD"))
-		return refs_ref_exists(refs, refname);
+	struct strbuf referent =3D STRBUF_INIT;
+	struct object_id oid =3D { 0 };
+	int failure_errno, ret =3D 0;
+	unsigned int flags;
=20
-	return 0;
+	/*
+	 * Note that we cannot use `refs_ref_exists()` here because that also
+	 * checks whether its target ref exists in case refname is a symbolic
+	 * ref.
+	 */
+	if (!strcmp(refname, "HEAD")) {
+		ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
+					 &flags, &failure_errno);
+	}
+
+	strbuf_release(&referent);
+	return ret;
 }
=20
 static int is_current_worktree_ref(const char *ref) {
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
2.45.0


--gV5dmvb7bTCU0oYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzTCUACgkQVbJhu7ck
PpQcTg//YEmlASAzFnQDpSjomTMMshccNflPwYIjrw3Uw+9ymdj1EJCz27mETuh5
EVHJLXc9pVN1Glz7aBaocheMWWRG5PmiooWFWYF6zngEI53W7igeL0XZ3cjWlpxQ
vVscWfD+4P4rhOg2OIML3x+eKCmCJtu155JpQp8XxtfJJW4QAkGizcKPxJqPdC0Z
PgGwucz/qS6PVcCwNmkePgziMcNjNaqIYRs8O/m0SaE1KqzZlGT3fE/ETDzRg7DQ
a4ta28+Z07iIWSQ+9XHEBjamJIv3Zv7g8l9zY1D5KRyu8ehrhHtUoMpk1uNK/CnF
CMdb9WogEWkhfvM0S6gfbc5Z76Dwkp7r/7ArowqfVWz/wjNfdbKI+wl5cKNHfMbA
sPHw28YoNO4wb66TXacNy1dtGzwjQdt2w0nr6MKsR9zHdH8uSmJo6qoEx0W49wfm
SA8a7iu/kOiDxIUTKLaBJnj6wqrr5Ov3l5bsQsC373VUiNJ5pxqaBFuoSNq0VmzT
eI7xyba0pCkdrvKLMtUszRtORheVCftZQnfUFUqvhXBTImKUFJtEp08i3TRLi90p
bMj0ptDkounVqO+bqD+D0FXqxnp2hCr48xLzNV4MJlWitt0DMN5KP3tvHOTJ0Mcw
/Gr8RFETSCTAL0Sw6PKgc+3usBstWuw888gBpgFkRxzpLYMz+Sg=
=fNie
-----END PGP SIGNATURE-----

--gV5dmvb7bTCU0oYl--
