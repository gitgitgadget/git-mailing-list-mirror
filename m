Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BEB15A487
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079001; cv=none; b=uuOKe54KqdCcPujFDyJoh6a73uskQOaicAbY5UhP3AKfSvuZ2R1DIpdLldR4SgMHF/wUUnWLJWfkjT/qp0rzzy0cUeqxtk81bagvstobNStkFKtgDPbgdkrKJTxAD4VB4XOg5VOMMlG8r/vohAcmVWs3Hwfe04vNN1USF3yC/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079001; c=relaxed/simple;
	bh=DL/fJqg5BuBS+IO/Cnubx8rtLEq9Ew1QPm7dQ+ge+80=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFVrPQZr0JZKK/upqPqa+CPEIPykgx3EwORUvQkpIPKEpid7FJ7HMSolYM7KxJKHll9Xr/b6atuOeVNkqP5VhhVLOPNMiGTfO5Xick4koSraTYvptaFkrlpNE2RkL/HYZtkODNvEtDL4iksdvFVXeNbWL2emHMWnkeZQVmwUgKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ky2i0CIN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=htSBE1mQ; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ky2i0CIN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="htSBE1mQ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 51C0E18000A6
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:29:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 02 Apr 2024 13:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078998; x=1712165398; bh=J+dn4g0C73
	LhQUEMahsPUesir3d5EZiFGQnTsRcm4lM=; b=ky2i0CIN2Od0hoQrwMLMwv90uy
	PaPu5LKyvit8lX6K5zWCqlfgpBTJNknjmPloaE97lLN4ti2cP69lLOZY0CEo+W1v
	iZVoQhNadYVvyGKx7sScIvmyje6FQUk+B/dJPhjsxxwD+SbiMB+i69PByJcd84IS
	vcmUVAakcX6mZcn6ufT6NNT/EP78iDS6LzFpfrrY73HGLZkBv9cziGyqa9YYKNzc
	5ev/ZuwUdU8TJY5QKhRQcDgadBO7Q2Eojy6vzyrzgsLIoJPiX1rTseJX0s2BM6k5
	mYkf8ZCn+N79jIw2m3SNYKb2cml9y6j7ZpiL+uJ3+fwCPL2JCPsP4PBC0YCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078998; x=1712165398; bh=J+dn4g0C73LhQUEMahsPUesir3d5
	EZiFGQnTsRcm4lM=; b=htSBE1mQ1Ve1xWO4T5ApvM28/YE6fr2rB5ZZyVzcIrKJ
	EJ4cnqqG06J2hynhCpafEfhiyWdf1pY2fLPC645o8FiNttY17H1s2psg3Hwpumaf
	xJ+2D9GGPNgM3SfibW/YOPIhwatlMLNFMZR1ah6LByEqHiKyVXM6vwln+JjyUToe
	uIABhMqzM0IdKg3dVXOTaCX80/UvqiLUCuzfeS55KCJl9j6FScMwTOYzippK2BUu
	TkJMd6ojWGMBC14WjJG+f2xE/Xo0uG1dJ5Bk1EdFYWPtTqPg77celsfH+ExVEiX8
	hdc5AtQ3vvselMOchzTGtPGIMBxpp++ASxwMLwljVA==
X-ME-Sender: <xms:lkAMZhMeQ61OwfexRS_dwrGeS0yD2zKQvgLxV_GkwEHfsuDgG1p12g>
    <xme:lkAMZj_8Eo6qZvH53HBL2UjdzvlHa-dACvuUI2a2F1D632jrRThbF5KtYHBqw_4rA
    JtaGNJwgDbE36IOtw>
X-ME-Received: <xmr:lkAMZgRZKrBhERI_YK_fHucQ8jv_1mn8zx96mkto9J3Ig9HDjTUluFHy7MH_xfhaV9Y6P90sifTlHqUW1ZpOu80jXHSfjoKjQBTaLleRoD9l55k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:lkAMZtvqlNoZjGCNlzQRsikE5nxRlA8axvi42WpcmklP_CzVNVft-g>
    <xmx:lkAMZpeFkITRhbZhAEsGSCAQdYkRmffP1jePYxbPYxVOJZeCHQoj3A>
    <xmx:lkAMZp0nqePQBFpIPJhZYCAp-nWkQqvwUQfAhb-5Fh9UFN4vuAKCMQ>
    <xmx:lkAMZl999gUgCGagb78BYA4PafSjYNdQ13MWFNoFJYZmc2Mlb85ngw>
    <xmx:lkAMZqoOOK5CfBnnBYkr15jtoMsFuDG9jaUxOHNpdgYy7V51ukgwmaAF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:29:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 77ac0417 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:29:49 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:29:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/9] refs/reftable: perform explicit D/F check when writing
 symrefs
Message-ID: <55db366e61c9292fef0e1d0c61be1da105023bab.1712078736.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6BvRyofuNPvcVCPX"
Content-Disposition: inline
In-Reply-To: <cover.1712078736.git.ps@pks.im>


--6BvRyofuNPvcVCPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We already perform explicit D/F checks in all reftable callbacks which
write refs, except when writing symrefs. For one this leads to an error
message which isn't perfectly actionable because we only tell the user
that there was a D/F conflict, but not which refs conflicted with each
other. But second, once all ref updating callbacks explicitly check for
D/F conflicts, we can disable the D/F checks in the reftable library
itself and thus avoid some duplicated efforts.

Refactor the code that writes symref tables to explicitly call into
`refs_verify_refname_available()` when writing symrefs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    | 20 +++++++++++++++++---
 t/t0610-reftable-basics.sh |  2 +-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 0358da14db..8a54b0d8b2 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1217,6 +1217,7 @@ static int reftable_be_pack_refs(struct ref_store *re=
f_store,
 struct write_create_symref_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
+	struct strbuf *err;
 	const char *refname;
 	const char *target;
 	const char *logmsg;
@@ -1239,6 +1240,11 @@ static int write_create_symref_table(struct reftable=
_writer *writer, void *cb_da
=20
 	reftable_writer_set_limits(writer, ts, ts);
=20
+	ret =3D refs_verify_refname_available(&create->refs->base, create->refnam=
e,
+					    NULL, NULL, create->err);
+	if (ret < 0)
+		return ret;
+
 	ret =3D reftable_writer_add_ref(writer, &ref);
 	if (ret)
 		return ret;
@@ -1280,12 +1286,14 @@ static int reftable_be_create_symref(struct ref_sto=
re *ref_store,
 	struct reftable_ref_store *refs =3D
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create_symref");
 	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
+	struct strbuf err =3D STRBUF_INIT;
 	struct write_create_symref_arg arg =3D {
 		.refs =3D refs,
 		.stack =3D stack,
 		.refname =3D refname,
 		.target =3D target,
 		.logmsg =3D logmsg,
+		.err =3D &err,
 	};
 	int ret;
=20
@@ -1301,9 +1309,15 @@ static int reftable_be_create_symref(struct ref_stor=
e *ref_store,
=20
 done:
 	assert(ret !=3D REFTABLE_API_ERROR);
-	if (ret)
-		error("unable to write symref for %s: %s", refname,
-		      reftable_error_str(ret));
+	if (ret) {
+		if (err.len)
+			error("%s", err.buf);
+		else
+			error("unable to write symref for %s: %s", refname,
+			      reftable_error_str(ret));
+	}
+
+	strbuf_release(&err);
 	return ret;
 }
=20
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 055231a707..12b0004781 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -255,7 +255,7 @@ test_expect_success 'ref transaction: creating symbolic=
 ref fails with F/D confl
 	git init repo &&
 	test_commit -C repo A &&
 	cat >expect <<-EOF &&
-	error: unable to write symref for refs/heads: file/directory conflict
+	error: ${SQ}refs/heads/main${SQ} exists; cannot create ${SQ}refs/heads${S=
Q}
 	EOF
 	test_must_fail git -C repo symbolic-ref refs/heads refs/heads/foo 2>err &&
 	test_cmp expect err
--=20
2.44.GIT


--6BvRyofuNPvcVCPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMQJMACgkQVbJhu7ck
PpQ4QQ/6A9cUPYslc+3aaXpH3Yeoik/pi6qnZVyOcLMifO0TyIF/1PTW2Yp9cRy5
vCZLWXw2DcZDsjdaff2c9nM4tcmG8R6TAB/5znDkWhT+99V/sMQdLi7vWGtlfFEJ
McsI1K9Nn+z1UBooj231DU+KYaqY5WIgw+WvWsA+MwQEngKfoCcsXbCFLGT4dNYc
pXflxLlFodvDgzZiqF0ZJVB6pjzf5KXNM6LBhE//iArtOrgbrbhtSyxzMZm6NuPO
GmVIGfT+bkvp41DSyGMI6bhm4VneR1hFZWg7NAGiXGEQ3ce846Sc29m7S81twAYn
P1Gd7Ov+iMNJwRyoNa5FmLsSRlzNfQ0O8LdrbDzDRTryKWNzctDbpYZCjS01YtPc
dLrwsk01/HgrPFVwiL6w7ySLu/7TfQp2CVj5gcJIF/eZueeFdokZhDLvRBjfjvXU
aaYngnuLINmIT0yCXXWP/GtpJmf7JRsmgpAJYlWVTu6/A3HIEgEnU6dXUj1nYGbe
eImLusIQzPzrlVvy8p0UfEUNE/S1b780/VQdHIf8UMOCDDiCS4yu7Iiskzir8aYh
620AVY5oTOAWJCHPw22xZl1jUmjSEZYvO2PhMjIKenmV1HagtBIe8KNSjwPGZkBa
VOBijUwNFXSmt2JAsN6xyBNX4S3adBpNdkaX51iWCzSZGca1PEA=
=uBBN
-----END PGP SIGNATURE-----

--6BvRyofuNPvcVCPX--
