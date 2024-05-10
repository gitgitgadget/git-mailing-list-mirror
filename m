Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4E14A0AD
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330890; cv=none; b=nQWsxBxfw9bWAIlsh96pFVAOQ33rITONWn2NNaRNVFc17WDBjHrMVTey1b/t+lVwpCsd5Z+12tSD/GCSGFwUanuE+JECPzto6txNNK+Kuxc8IAozGM1Em/Ea5LjnDoUQEtU7L9CIiPEUQuuQIBUuJwIa1inbbNWeWl+oTF2b6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330890; c=relaxed/simple;
	bh=EhnoMJw4Sdhoxbam/yjZwg3zpoYHi1y3zAjyu19g3cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXbCrxg7Z0zyx9KLPK+JSr8s6+KtN7DYDCbFTopfaqZYDpel5FHTQ8k/LFs6UpjhuGAXd1RbSPgVU4N7qHMWGKI5OmimHrxfZT+EgwhANeofjix44oCxcjAUXPKgacsgQKV7peNYOxnPbCaRmh0Me+8Wz4Kb3Wl2U7gvtYi++ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tIwLUBDw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LCEIsVbw; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tIwLUBDw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LCEIsVbw"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 607C91C000F3;
	Fri, 10 May 2024 04:48:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 May 2024 04:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715330887; x=1715417287; bh=fUw/qtF3O7
	0GjS3WxW128VESAI3cxELxrMdNgfZSD30=; b=tIwLUBDwDOSAkNY2+RelFxq3MR
	lpgLhtI1JaM0D6950Vx1UxzIHZ8DD17IZ7gIrx8hy1ZpWHtiHNaA+DWoqLRlay9H
	ac8te9aoT1j6qOY/mkUe18pLyifvescSBKBCRC/sLbnwOyfjVV+6mNXANmHEq+Ee
	GH5TrzLhZDMx4WJ11e1LYA/yDYtBQwXUUS0rxnVZl4BU5o7oWGsSCe3/Z3EuM5mO
	zqekl5Qx6WIcR9biiRyJ9/YmAbYK20dvuVyiPW+Mg+6FZ4H9luIrPvXAcxWaoMOi
	azRI3paarwU6E4O940vASlrF/K0dHNcQK87Y1Z7lE41bAzTT2Fdp0sbnkecw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715330887; x=1715417287; bh=fUw/qtF3O70GjS3WxW128VESAI3c
	xELxrMdNgfZSD30=; b=LCEIsVbwFjY+wlr3tJXGGiSCVSqhfJtvgfOPR0Nod9pK
	rznjFKDXCRUfOqBmYy1KR/fSHOetNVH4N0kM22MYiTw4xe7PDqTSQhP1zTosOXdN
	hEE/j0NEp0z9fPnEG5YbTS2RybHRTArKQlLqfVGV96mb1n255GzbD1X/kP3yYunZ
	5eMQrcAknmrCSFz/BNM4RgEWM+pYPNbXsZ6ERoqY4x2Zu6AZV5r6EHScaOZS72MP
	BWoO57fTX3xWaGiaa1IqISocXARAxnnDLxtP34bFDdTz7IMWkQW26zyRkPalwKiU
	iwG2jVwUAljm/yw5Hdi68JiUrxtRtU7JRdPCgMM9IA==
X-ME-Sender: <xms:Rt89ZonUgZmWSgJXJCy4vGQ_6xsgj-D9li7Dr728g2ILvZ3THglLfg>
    <xme:Rt89Zn2wfAX4veaUw7gZV9uqg5UlBLHxnbfBIho05K2c9EWpNs7hiwgKGnOpTPG_y
    PKf21X6wNz1nAtN3g>
X-ME-Received: <xmr:Rt89ZmrLQ20JPjrb7uBpeB5OGs62xSwolzzEyCQADhhq-d9bcTmpzKGtk4Z7JPEgABh-anEZCHv5AguryGGF4k3CvEvYLyRGcvt-rDFujoScvSxA9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Rt89ZklEOiWgDJVw4cUSVdfy4uGAJ_HYwMpgr4WZSjWROkM4iDh1EA>
    <xmx:Rt89Zm1tuLCkoJSsrvsNoAtOtmKPWbIsQmG57ugNnaVQk_8oSImfpQ>
    <xmx:Rt89ZrshOdiy5sdsNojem0RnFccGNzAIFV5KIxcOGrM4W69eP-BAzQ>
    <xmx:Rt89ZiXwohl4z3ONrGusKxbcR_CjXt6no29kENCvrxPV_KQnejkJog>
    <xmx:R989ZnJihGmfN_ZoRlpun39IGol8q7_XTJn3gzwYu7VEjYURFtSwwoSW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:48:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8e36128c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:47:51 +0000 (UTC)
Date: Fri, 10 May 2024 10:48:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v4 00/10] Clarify pseudo-ref terminology
Message-ID: <cover.1715330206.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kmfQj4cl/8Cb/ZbY"
Content-Disposition: inline
In-Reply-To: <cover.1714398019.git.ps@pks.im>


--kmfQj4cl/8Cb/ZbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thi sis the fourth version of my patch series that aims to clarify the
pseudo-ref terminology. Changes compared to v3:

  - Render refs in "Documentation/glossary-context.txt" more
    consistently with backticks, only.

  - Reorder patches 6 and 7 such that we first correct `is_root_ref()`,
    and then adapt `is_headref()`.

  - Furthermore, I have inlined `is_headref()` into `is_root_ref()`
    completely now as it didn't have any users anymore.

Thanks!

Patrick

Patrick Steinhardt (10):
  Documentation/glossary: redefine pseudorefs as special refs
  Documentation/glossary: clarify limitations of pseudorefs
  Documentation/glossary: define root refs as refs
  refs: rename `is_pseudoref()` to `is_root_ref()`
  refs: refname `is_special_ref()` to `is_pseudo_ref()`
  refs: root refs can be symbolic refs
  refs: classify HEAD as a root ref
  refs: pseudorefs are no refs
  ref-filter: properly distinuish pseudo and root refs
  refs: refuse to write pseudorefs

 Documentation/glossary-content.txt |  72 +++++++++----------
 builtin/for-each-ref.c             |   2 +-
 ref-filter.c                       |  16 +++--
 ref-filter.h                       |   4 +-
 refs.c                             | 108 ++++++++++++++---------------
 refs.h                             |  48 ++++++++++++-
 refs/files-backend.c               |   3 +-
 refs/reftable-backend.c            |   3 +-
 t/t5510-fetch.sh                   |   6 +-
 t/t6302-for-each-ref-filter.sh     |  34 +++++++++
 10 files changed, 185 insertions(+), 111 deletions(-)

Range-diff against v3:
 1:  e651bae690 !  1:  b1fc4c1ac7 Documentation/glossary: redefine pseudore=
fs as special refs
    @@ Documentation/glossary-content.txt: exclude;;
     ++
     +The following pseudorefs are known to Git:
     +
    -+ - "`FETCH_HEAD`" is written by linkgit:git-fetch[1] or linkgit:git-p=
ull[1]. It
    ++ - `FETCH_HEAD` is written by linkgit:git-fetch[1] or linkgit:git-pul=
l[1]. It
     +   may refer to multiple object IDs. Each object ID is annotated with=
 metadata
     +   indicating where it was fetched from and its fetch status.
     +
    -+ - "`MERGE_HEAD`" is written by linkgit:git-merge[1] when resolving m=
erge
    ++ - `MERGE_HEAD` is written by linkgit:git-merge[1] when resolving mer=
ge
     +   conflicts. It contains all commit IDs which are being merged.
     =20
      [[def_pull]]pull::
 2:  66ac046132 =3D  2:  dce3a0fa7e Documentation/glossary: clarify limitat=
ions of pseudorefs
 3:  243d616101 !  3:  79249962f5 Documentation/glossary: define root refs =
as refs
    @@ Documentation/glossary-content.txt: The following pseudorefs are kno=
wn to Git:
     +match these rules. The following list is exhaustive and shall not be
     +extended in the future:
     ++
    -+ - AUTO_MERGE
    ++ - `AUTO_MERGE`
     +
    -+ - BISECT_EXPECTED_REV
    ++ - `BISECT_EXPECTED_REV`
     +
    -+ - NOTES_MERGE_PARTIAL
    ++ - `NOTES_MERGE_PARTIAL`
     +
    -+ - NOTES_MERGE_REF
    ++ - `NOTES_MERGE_REF`
     +
    -+ - MERGE_AUTOSTASH
    ++ - `MERGE_AUTOSTASH`
     ++
     +Different subhierarchies are used for different purposes. For example,
     +the `refs/heads/` hierarchy is used to represent local branches where=
as
 4:  0a116f9d11 =3D  4:  ee2b090f75 refs: rename `is_pseudoref()` to `is_ro=
ot_ref()`
 5:  484a0856bc =3D  5:  2c09bc7690 refs: refname `is_special_ref()` to `is=
_pseudo_ref()`
 7:  92a71222e1 !  6:  5e402811a6 refs: root refs can be symbolic refs
    @@ Commit message
         does not seem reasonable at all and I very much doubt that it resu=
lts in
         anything sane.
    =20
    -    Furthermore, the behaviour is different to `is_headref()`, which o=
nly
    -    checks for the ref to exist. While that is in line with our glossa=
ry,
    -    this inconsistency only adds to the confusion.
    -
         Last but not least, the current behaviour can actually lead to a
         segfault when calling `is_root_ref()` with a reference that either=
 does
         not exist or that is a symbolic ref because we never initialized `=
oid`.
    @@ refs.c: int is_root_ref(struct ref_store *refs, const char *refname)
      	size_t i;
     =20
      	if (!is_root_ref_syntax(refname))
    -@@ refs.c: int is_root_ref(struct ref_store *refs, const char *refname)
    - 	if (is_headref(refs, refname))
    - 		return 1;
    + 		return 0;
     =20
     +	/*
     +	 * Note that we cannot use `refs_ref_exists()` here because that also
    @@ refs.c: int is_root_ref(struct ref_store *refs, const char *refname)
      }
     =20
      int is_headref(struct ref_store *refs, const char *refname)
    - {
    --	if (!strcmp(refname, "HEAD"))
    --		return refs_ref_exists(refs, refname);
    -+	struct strbuf referent =3D STRBUF_INIT;
    -+	struct object_id oid =3D { 0 };
    -+	int failure_errno, ret =3D 0;
    -+	unsigned int flags;
    -=20
    --	return 0;
    -+	/*
    -+	 * Note that we cannot use `refs_ref_exists()` here because that also
    -+	 * checks whether its target ref exists in case refname is a symbolic
    -+	 * ref.
    -+	 */
    -+	if (!strcmp(refname, "HEAD")) {
    -+		ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
    -+					 &flags, &failure_errno);
    -+	}
    -+
    -+	strbuf_release(&referent);
    -+	return ret;
    - }
    +
    + ## refs.h ##
    +@@ refs.h: extern struct ref_namespace_info ref_namespace[NAMESPACE__C=
OUNT];
    + void update_ref_namespace(enum ref_namespace namespace, char *ref);
     =20
    - static int is_current_worktree_ref(const char *ref) {
    + /*
    +- * Check whether the reference is an existing root reference.
    ++ * Check whether the reference is an existing root reference. A root =
reference
    ++ * that is a dangling symbolic ref is considered to exist.
    +  *
    +  * A root ref is a reference that lives in the root of the reference =
hierarchy.
    +  * These references must conform to special syntax:
    =20
      ## t/t6302-for-each-ref-filter.sh ##
     @@ t/t6302-for-each-ref-filter.sh: test_expect_success '--include-root=
-refs with other patterns' '
 6:  c196fe3c45 !  7:  b32c56afcb refs: classify HEAD as a root ref
    @@ Commit message
         - The "files" and "reftable" backends explicitly called both
           `is_root_ref()` and `is_headref()`.
    =20
    -    This change should thus essentially be a no-op.
    +    This also aligns behaviour or `is_root_ref()` and `is_headref()` s=
uch
    +    that we also return a trueish value when the ref is a dangling sym=
bolic
    +    ref. As there are no callers of `is_headref()` left afer the refac=
toring
    +    we absorb it completely into `is_root_ref()`.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## refs.c ##
    +@@ refs.c: static int is_root_ref_syntax(const char *refname)
    + int is_root_ref(struct ref_store *refs, const char *refname)
    + {
    + 	static const char *const irregular_root_refs[] =3D {
    ++		"HEAD",
    + 		"AUTO_MERGE",
    + 		"BISECT_EXPECTED_REV",
    + 		"NOTES_MERGE_PARTIAL",
     @@ refs.c: int is_root_ref(struct ref_store *refs, const char *refname)
    + 	return ret;
    + }
     =20
    - 	if (!is_root_ref_syntax(refname))
    - 		return 0;
    -+	if (is_headref(refs, refname))
    -+		return 1;
    -=20
    - 	if (ends_with(refname, "_HEAD")) {
    - 		refs_resolve_ref_unsafe(refs, refname,
    +-int is_headref(struct ref_store *refs, const char *refname)
    +-{
    +-	if (!strcmp(refname, "HEAD"))
    +-		return refs_ref_exists(refs, refname);
    +-
    +-	return 0;
    +-}
    +-
    + static int is_current_worktree_ref(const char *ref) {
    + 	return is_root_ref_syntax(ref) || is_per_worktree_ref(ref);
    + }
    =20
      ## refs.h ##
     @@ refs.h: void update_ref_namespace(enum ref_namespace namespace, cha=
r *ref);
    @@ refs.h: void update_ref_namespace(enum ref_namespace namespace, char=
 *ref);
       */
      int is_root_ref(struct ref_store *refs, const char *refname);
     =20
    -+/*
    -+ * Check whether the reference is "HEAD" and whether it exists.
    -+ */
    - int is_headref(struct ref_store *refs, const char *refname);
    -=20
    +-int is_headref(struct ref_store *refs, const char *refname);
    +-
      #endif /* REFS_H */
    =20
      ## refs/files-backend.c ##
 8:  8bd52e5363 !  8:  19af8c754c refs: pseudorefs are no refs
    @@ refs.c: int is_root_ref(struct ref_store *refs, const char *refname)
     +	if (!is_root_ref_syntax(refname) ||
     +	    is_pseudo_ref(refname))
      		return 0;
    - 	if (is_headref(refs, refname))
    - 		return 1;
    +=20
    + 	/*
     @@ refs.c: static int refs_read_special_head(struct ref_store *ref_sto=
re,
      	return result;
      }
 9:  cd6d745a01 !  9:  86f7f2d2d8 ref-filter: properly distinuish pseudo an=
d root refs
    @@ refs.c: int is_per_worktree_ref(const char *refname)
      		"MERGE_HEAD",
    =20
      ## refs.h ##
    -@@ refs.h: int is_root_ref(struct ref_store *refs, const char *refname=
);
    +@@ refs.h: void update_ref_namespace(enum ref_namespace namespace, cha=
r *ref);
       */
    - int is_headref(struct ref_store *refs, const char *refname);
    + int is_root_ref(struct ref_store *refs, const char *refname);
     =20
     +/*
     + * Pseudorefs are refs that have different semantics compared to
10:  6956fccced =3D 10:  640d3b169f refs: refuse to write pseudorefs

base-commit: 0f3415f1f8478b05e64db11eb8aaa2915e48fef6
--=20
2.45.0


--kmfQj4cl/8Cb/ZbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY930AACgkQVbJhu7ck
PpSGTQ/9FoOvC4RZoPMymxDVzoFjV/OjdEjslwva56EPMU+YYTKrpdomErGLrvIE
5VQZQ24h5DQlBq12Zz/jSJ5U5YmYIFPlw4CXin3Gt04pLcK54AbvnpBvOKZ4kkBh
jut58drmI9nf4MRG9ZhPyVGKJQruC5yzHm51dsTAB8fELiMu4SCXf7pLux97m/SI
vLuCWSwhqjujE4YjFLykEP8b96QOGJoJ1p/o52WzWrVldng5Ztf6YFmR6EGyeEcd
xdZ0sD1n0xXISCJD3/hJJINo2zZS0b6vdl4sWVNCQkjKzwI67F+yIxQ/GgB3dCsk
DlPeHqB2UwDIi+cPBuRhSGz6veN1wrOQrjbZ/Or2hxd6G8YZJUVO9POH8nknQWzZ
lBNotZALvQguipNmJqBTy2YeA3hX8zW2redCmWcUrLut6f4mCbm1zTbZm6DQLG/9
XHYMA/HOtSSs0vsSo5YMAqdhtWZQqEXjtHyXtyZ/29N4x6JJ9D5vbc9Ndq+xZD0N
G3jrmtFAFp3m+jOQA2NJj8K5QM3ECVuN+kLvfk/5VYVQKAyQkWn8H+kZNJ2iAEHT
VHiqYZ9knKZoB/cCuk6Z+UEYRmqpdMPHIamRXi2YSBtTp72Va+s19yr+ygT+34hP
CxLJ5J7j6D9nQjVAglhtgBnkvjB/u8k72pZFFl8H7x5YvW8H2Bg=
=7Icf
-----END PGP SIGNATURE-----

--kmfQj4cl/8Cb/ZbY--
