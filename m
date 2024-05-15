Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8C40875
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755853; cv=none; b=Ci3W+c8GBoEveZPmHR23fScPrV4pt7s7Em06CSZsN/NGoXpHNiOHeWDKqQEO1Gepdtzu7C2EBSjlhfijaoE52Rgl9CGBurxyVe/2R8+3ghwJtHYTWxbHWoNTy1igFe/QkHQD/LVrl3ycJsjTDs54pN8mm6UHP2Nj1i8QxsiU8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755853; c=relaxed/simple;
	bh=MF+/Gs8dabaw3lRBATuTHr12+GG+5SntcG+wqdzodJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5ZKWuBvp5e5VP6DMmVQAX4X/23sozKL0/rvj7j3Mbzjuq63FHLtkAUH9SajcAPXTE7fCsnPDhPoOxT4MAkIaFd9dlNQVjKaEjLiJa5waF5LzOKh0KI7J7AUpjwoSeJAigxhmnO45gQEtvaYIO9yiVtFP+O6EFGwTuPLVx2WkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B0UPH0/W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KCkFrzqC; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B0UPH0/W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KCkFrzqC"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7EED7114019A;
	Wed, 15 May 2024 02:50:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 May 2024 02:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755851; x=1715842251; bh=ty5B4beUFx
	tfwVNbbaxeFzih4EmjoctjrBN/4acglR0=; b=B0UPH0/WrVlavi/opUcrvSX/Ty
	eOKg5bZxTwKhOmNnR0QlRV1uXaUbCebJ+yWG+LZ4tgUKcMjLCaMMRF2SrBe8pKhr
	GyV3w4RhcyklpN/phr4K8AaOAyM/ADo7hB06eU05VcQ1RGSgBdfT8mXAvPDBYwJX
	q6kTo5Ymdt4F3PQ97o6SE2s7zT4LSXG2Tzccyg7TS43cUR2YSbVvO5Qo7IgSV4HX
	OpGUYlBQWAWgQt6j7b2XcMMBxl1GETLme+xDkDcWNUtyW0trGZ8gRgbs40CcCv/A
	TJVx67K9w5DCdV7LWmJE5zkEJqCcW0Pa64Ko3mIHAtkXG6gIJ9G2IHEVqoGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755851; x=1715842251; bh=ty5B4beUFxtfwVNbbaxeFzih4Emj
	octjrBN/4acglR0=; b=KCkFrzqC/EQ6TSeaacvUyzqD1YZlUJ/OPTUWzymeM92q
	ydFiWIVPlMfUW1Aox9l+I3jz/bVKHo35klEcbIYmWTUC/f34MDsQ7XXPIgzqLYax
	QBn/cocvY4XJwIhcKzW2YixeiY5VXhQvTIzrINyL8VDYDUY8WDh5/QTOTPslRZHo
	wk3A14eiANXbajQ0gP3wtyhKPMv6qwl00+v4inKYNCniH2nQ9KIxqGaamGnwlvU9
	nC/JV12OZixOjzym8TfkfLfv56uZojor52uZN5qTCSg4oi9mrI4167Ry7RibWstS
	yX+S3WhheFKbPgs+mgpqrWizFPdiLgWlOjNJW192fQ==
X-ME-Sender: <xms:S1tEZmHIoJ6Qy-x5JbN0B53ig34C8EWlHYLLVCHfz5UPQx-YeOwpQg>
    <xme:S1tEZnWT3h2omJISWBDB6VUkOj9K51BL-j7lrTHK-IjyN_If42KGoFvEXzu3_Xatv
    VWV-J-iWNQx--3lxw>
X-ME-Received: <xmr:S1tEZgI_fA2A02U0pLDzpvm2dvnEloxfvGO_ldCTKoMI2o_BfNNBPrT3DjT5T2GTS55dGMvD_qCfRVgE5b1pYCWjWwMTm9RAYah6ry8VYfIjc6yz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:S1tEZgEMPnVTvl4hMeq9mljK2J_oneAmr_HNI_j5-hBNtSnPBsTFnA>
    <xmx:S1tEZsXGY9Vv1dpCCbhiJx_tkrfizORDaF-LTsIYf1MDyFgGREcqGw>
    <xmx:S1tEZjM8kxSLbqvv0CtftnKTFqp3LCLNe_KUe07unePBX_aOaWZjrQ>
    <xmx:S1tEZj0FaDYsYE3l8RS1Gdshi6fNwtOF_y4XUeZ0wd-cjzm30l-5cg>
    <xmx:S1tEZgrsoOk5_fMeaFnba1JZhqcCbl-vTyCFD4f9WS6r8e3XCpwxCIfY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:50:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0929b76f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:50:27 +0000 (UTC)
Date: Wed, 15 May 2024 08:50:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v5 05/10] refs: rename `is_special_ref()` to `is_pseudo_ref()`
Message-ID: <9087696d8206c9a099463c27c9274b7bab2b86dc.1715755591.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="naXR3SnYHdxGAcPK"
Content-Disposition: inline
In-Reply-To: <cover.1715755591.git.ps@pks.im>


--naXR3SnYHdxGAcPK
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
index 434c4da7ce..c1c406fc5f 100644
--- a/refs.c
+++ b/refs.c
@@ -1872,13 +1872,13 @@ static int refs_read_special_head(struct ref_store =
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
@@ -1887,17 +1887,17 @@ static int is_special_ref(const char *refname)
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
@@ -1908,7 +1908,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, co=
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
2.45.GIT


--naXR3SnYHdxGAcPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEW0YACgkQVbJhu7ck
PpQWnxAAl7jXONtPGPgxiVNb8RcHBZzkSMwIRHNBLxOD8oNiChy+lWwA23kzJH0E
/acXHnumb2xGIB982KiteJeK3HOPZRrvCalNZMihqprKBQeaMSNSg5MgAj5TAmDA
wXWd8rcLU+0w5jIYDJjsHYI+x18xN3wTRaihLUFo4Mce7Dn/VhNKK9+iohVlE8qT
lQ3R+3m3xuZwYNxLH654IiWmwTflGBemG9Q40PQ13TS6zbxyjWwgMAr7OC/IKevP
R3YBHo7nsKPPzUXcbP5a67GxXBWQWDTcr0WK+mDEjSxGclJ0+IzmN0eRrhIwywuK
34gufJp2QDps+POtKcV0WEsV0iKnjf8JmvnP2IvhJVPwcFfDfI7685ng+wClk1Nx
qdCw7FedshyZDylNIyn0S+QV9T3lu3Gm4eCHEM3Xf1jtp186ly8zxg9QdUzWphM/
L+nK8AwsI19W45IJUQTrh9bUBqXeKFeBU7UF39c5ywFHisuCmL6CNPgz1M0lxCex
NcMX4goSl5LJ4TmYoiKLV/xrPWteIA80SQOtw+uMGAY4LTdgA4KQTyD/ErpCAMXK
6Mz9DYrAsm4acoemsHIr9mozxKdp6GLRquFjYDZonzTMtzw+LZ5wuGJnDCfsw+hy
JTlEorRrpavHy9aeUwlCRG2x2clcMrl1RZM19ZzLzit/f9zlRlE=
=HOox
-----END PGP SIGNATURE-----

--naXR3SnYHdxGAcPK--
