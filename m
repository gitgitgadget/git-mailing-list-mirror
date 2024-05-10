Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709915F40C
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330912; cv=none; b=jYLx51sLpe6f5CH9ip+Y7kudPTeTFjB5lhymYOyTRVkUs9qrmspEMD2STbabd2VAFdYDX22ck8nYzdUuivlNB1cvLLhP/mXF7A88OMGFZaw9sJfjpOtQFM97cRXecVwyBAFXYnzEi3qhZKiS1DZEOtra1qfgRrHix25ntg/gtDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330912; c=relaxed/simple;
	bh=Qm0v3n3cT6p7CopohHHj2US+nmVWtP9O7WA5m25MK1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkSIzCYAukfDcT/ob+Yd094LhbMM4JQfe/P/gyuHL/ntM6UQO5pe+5iARfNun12NcVKdgqIRQWipZLhgwIzGDLKdDtm8q5zjnrexwm7mblL2D6xffAMZ8Id0Hjt0nCqn9buSxn3PeY/QGXC+6KgA7Fab/BokgpwL6/2DyJylrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CswoF7YE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKrf86an; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CswoF7YE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKrf86an"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 1E5831C000F5;
	Fri, 10 May 2024 04:48:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 May 2024 04:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715330909; x=1715417309; bh=NkJB0JE2g1
	g+427Ni3GUN07MPLRO8YiWLgoCIDjskSM=; b=CswoF7YEsePv9QGKluSEHWIMNb
	ygcw5PyNVIZVDttZLHBRWsVvxmnNBX7C9Lb/MoKO1t/8nPcoGZSbCJoAYAXYoqUM
	SUyYc1/QFjEkzN1kIOEE92DZGYSZxyFIkRzgdydHYyk3fekVHFWOFOm1UtUEjeqC
	MudjH9JAAnWSXtg9N9oR3eABde/EZv8vnzEdazgoU5/EVSzN44nsgs0zblptq+gO
	XXe7ZFGdKl90FVr032sSZ2pfA1WinQfmW6X6yRXaA20AJAdgTRmGLSETQ0CJz+yC
	yrs6amYFJ8d9Y7LnRwxHf1J9rEGoRWYFZKDR6xzyFt7s6YzSS4AO7wMUgZsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715330909; x=1715417309; bh=NkJB0JE2g1g+427Ni3GUN07MPLRO
	8YiWLgoCIDjskSM=; b=UKrf86anEwFvNOtwR3sFQFfcpQnYdaskCM/T7bgIEKCr
	QJ4bq5tZvI3YjlBeQFtZRWpASaFTaSjOCJXpLSC2tHx+914MhMf8DGdIAVdJdtRg
	YtJo+T13gIQ1MaBNAQGmcwe9UxuDsTHRk/VbJvXhwpwHSVCYD81+G75G9fb16A2V
	nEIU2J9qs48RSYY0PcLgF2aXz6APZGfA/x86ySEBYQ9wWaprM0PBYIbqdzdaXuIM
	HUPDYjfPA5mvEARgtHbh4SX5/qxdIZTI9OMX4s4FsfQZHVy/jgViC2brCah9nCgP
	oOPCT4Hr90MdPYzST9Sn9Zgv/oAuzM9Fg+d082M15w==
X-ME-Sender: <xms:Xd89ZnnkBsww8snHHy_pyPpzru-MxzqjB2BT2bWaThaWMq-CX8K8Ww>
    <xme:Xd89Zq0ZtuU1n8cCraQIAFiooNd0kthPVsrsLSzWLJ_q7yLPiIK9BNyX2ij5gQNBq
    9wtQStrX0JavIQ9hg>
X-ME-Received: <xmr:Xd89Ztq0dhLE2_fTt1F7GMQvPEv1Irv-GaUDaQhnxc8eieMx5MgNJMFva2DKGrbks7aEuNmuUAjUKTttNMvaBFWBi2xjzsnpBQGIjNqP4Cx9bk8rcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Xd89ZvlI4ozZjCBMKufTWP2t319E780SGaF1nildwTUZ53psptphYw>
    <xmx:Xd89Zl2MuLknNrG8maYL8zuha8G_OHK_o0kEp0JLvtgZAXxwEyPKaQ>
    <xmx:Xd89ZuvtUW4mbM5MX-5mMin2alytkyNkZ-b8-UatCX0T4iAlATntZw>
    <xmx:Xd89ZpUA5SU2taF9I-xtl_nDpfRn2s3KGekw8X60-Y7OGV_oVpNg4w>
    <xmx:Xd89ZuKHBIiQrHf3O4GqmWwfscDRa16e88jvvZA_V6BFsnH8AX6D21bd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:48:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4de4c7f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:48:15 +0000 (UTC)
Date: Fri, 10 May 2024 10:48:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v4 05/10] refs: refname `is_special_ref()` to
 `is_pseudo_ref()`
Message-ID: <2c09bc7690f1126d5f72ae809fad5e4832beb8b4.1715330206.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715330206.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PSLlvhRtBU8cx6xX"
Content-Disposition: inline
In-Reply-To: <cover.1715330206.git.ps@pks.im>


--PSLlvhRtBU8cx6xX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rename `is_special_ref()` to `is_pseudo_ref()` to adapt to the newly
defined terminology in our gitglossary(7). Note that in the preceding
commit we have just renamed `is_pseudoref()` to `is_root_ref()`, where
there may be confusion for in-flight patch series that add new calls to
`is_pseudoref()`. In order to intentionally break such patch series we
have thus picked `is_pseudo_ref()` instead of `is_pseudoref()` as the
new name.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 0a4acde3ca..6266f77474 100644
--- a/refs.c
+++ b/refs.c
@@ -1876,13 +1876,13 @@ static int refs_read_special_head(struct ref_store =
*ref_store,
 	return result;
 }
=20
-static int is_special_ref(const char *refname)
+static int is_pseudo_ref(const char *refname)
 {
 	/*
-	 * Special references are refs that have different semantics compared
-	 * to "normal" refs. These refs can thus not be stored in the ref
-	 * backend, but must always be accessed via the filesystem. The
-	 * following refs are special:
+	 * Pseudorefs are refs that have different semantics compared to
+	 * "normal" refs. These refs can thus not be stored in the ref backend,
+	 * but must always be accessed via the filesystem. The following refs
+	 * are pseudorefs:
 	 *
 	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
 	 *   carries additional metadata like where it came from.
@@ -1891,17 +1891,17 @@ static int is_special_ref(const char *refname)
 	 *   heads.
 	 *
 	 * Reading, writing or deleting references must consistently go either
-	 * through the filesystem (special refs) or through the reference
+	 * through the filesystem (pseudorefs) or through the reference
 	 * backend (normal ones).
 	 */
-	static const char * const special_refs[] =3D {
+	static const char * const pseudo_refs[] =3D {
 		"FETCH_HEAD",
 		"MERGE_HEAD",
 	};
 	size_t i;
=20
-	for (i =3D 0; i < ARRAY_SIZE(special_refs); i++)
-		if (!strcmp(refname, special_refs[i]))
+	for (i =3D 0; i < ARRAY_SIZE(pseudo_refs); i++)
+		if (!strcmp(refname, pseudo_refs[i]))
 			return 1;
=20
 	return 0;
@@ -1912,7 +1912,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, co=
nst char *refname,
 		      unsigned int *type, int *failure_errno)
 {
 	assert(failure_errno);
-	if (is_special_ref(refname))
+	if (is_pseudo_ref(refname))
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type, failure_errno);
=20
--=20
2.45.0


--PSLlvhRtBU8cx6xX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY931kACgkQVbJhu7ck
PpRvABAAoNtgTmDcVdZEBi/LEowdbYGMw+X6mgubaqMmOWqvuIMLrURS97F70BNn
U/oo/kIvpxwLKFM0+9eJ+dV2Y4val9efLajUIzWrKhsDLanGvUUgniJ9Tg1pNQJJ
ME6FH1kezXL3zEIJDTEFXoORZO6U+Q7HuIZQugnePORFb55cQEfqCWZvGHF4e8NZ
lc2XyXH1AEZP/yIn/NHV8pdgv1XcI39YIn5U0UwRS7PnGxqD5OXmaybpArfQYEF8
GRDij2RK3KllXLXC5yQDjWnK/dchJwZcJkrnUO4QRKyLr8S8/j6HpjBn0hpAFd40
gVIfPfA9KqFst0MbzfLHIwJUisZ1p+9RQqq3EsSemY5Pm4vsJtnuMGH9q4xyhGiK
Nf6dUP1hymguucD+XN7JzJBuczh9Mx6y54u0HfOu5v1b73KnsbUSHXorC4uMDqEy
FOdw9SYsY0kZBqX9x3WVE3X+IbasDmQUFq2hc6+0YGuD6XbxDlHoRZWFyH01ufxA
bpryCNGFrJBUYTPv3Pawvu9OnR8kBPeC3wcE/Su3CgMViL/HmauE3I07h5FQh1hT
tMIf47622UvjOIx03auVY/ih3dlHdwogHJbnbzzivMxZt60CdfzgRPCwUQoKay75
ZGoBFYVBhD+ps01JTDHZUpsNo5+o3jHzkabvu/jSjtwsso93tZU=
=X0jH
-----END PGP SIGNATURE-----

--PSLlvhRtBU8cx6xX--
