Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F021422BB
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985786; cv=none; b=BtwTXcnOQZEiCPJdV8MpkJ+JVXbP92j3+Go/drqlv0Zvmt4yv3K/ooY+hRj/pscjXOcPr5NWUlKVCqXsXF2yoYOwIVNC7VoNRRX01AcnSFyPPyMs/Scc+ZPQSLGrBPo43PQWS9zt8c0HSjsxBrDWWrmNsN0xh5swKBnrTThx16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985786; c=relaxed/simple;
	bh=DJ+V8hP5AeZpTcdTh/EZpVS3LhwVN+WUZv0PHto+cH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu3IEWldnaMC1FSZGMbWLvd1QEbjTBf6C/4ofQeTVRLeOxAOsTMEaY+VipouljMI4VeEpvwR4Axqavrd1hLXTu1A6AsstFDKskfYyFrnzwjKJP1YAfxxEVspABf2zguOSZgWGyS+P2PKmPFUVqjsxSBTFvR2AC0AYP8JuKmhIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rzXZG38C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ACtEibIk; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rzXZG38C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACtEibIk"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 88BAE1C000AE;
	Mon,  6 May 2024 04:56:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 May 2024 04:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985783; x=1715072183; bh=L0ypZ1GleS
	baz+2Ny9iAiNCBjilLztBJOtPPfr82U/U=; b=rzXZG38CSGhU1TjefVyplAf/g2
	mgmhmrsoyZaPUIoym3jyJKFDfkwL8NRwVsi+ZHQ/2/M5Jeq3w3l4UzSoI2iAA5tl
	2mr7GxFTbZprI06h4HFvCsEnIFTJtE7H5nQBKTyWbURkPK02d7H6ALyea9KeSVe2
	D0ijaYW7mO7lQJ7hd5bT1Ggodd9URkAaLbGSIkSnb3DHvmH70tv2iwstlnCq3EJK
	zEA//2OlwRhHdDES4AJWXxKI8v4XSpKFKZwQ7s6hODBuvY1PuG6RjcMrtrPcU7ZW
	+WmVwX1Qwjj1htplVupp76EjHC5Eu1GurrebMeEQqAxofsVUBFc4WBN2+MhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985783; x=1715072183; bh=L0ypZ1GleSbaz+2Ny9iAiNCBjilL
	ztBJOtPPfr82U/U=; b=ACtEibIklBAmRsORFvXHgXEscwf43oUIOXiUjyj8broU
	luAzgPCg9b+T1iowMuvPVT3PWMPQnRYgul5c+Q+aWNDdVgFX6Jh7U5B9SjA9eB0A
	E2GvrQm5cdi/c7anDJNTVj4QdidYcYBzMJJtXdveJmCRTxOE+zd/fS2J8VOp2uuC
	pv3Lj3ZqRBteWd7QknqkQx9BRTM7bqjUHZBW0dwNYS4UFB7xmJtFLllD7L6nP/Cw
	FeowxFrpquXKODyiz4vQBJ+5A8gDI9kcaTQupmZZpmIDv5kFFMa5+uBreCwf42nd
	nSYlVjnW4/0UKmM/OmgkmyxyxR2UN/QTLngMyscY0A==
X-ME-Sender: <xms:Nps4ZlcYTOssUv7a1fFUsVNyctNAwwvPZclOzrVi26HUi55gaXMpxQ>
    <xme:Nps4ZjOjbrdMnHJa4AGe54fhRNZv3WSkFg_gBiPUNH8X1Znj3Yiul8-L-CFfkXI_6
    hcfHsgp2yUNXVwySw>
X-ME-Received: <xmr:Nps4ZuimHyUzJiGrsfH94VYnk2RnzXDB03LSl8bWnvkpr72S8eN9LnbygzEyav6HBawXSI5ibIe6AUDT7lltJ0zpi1614hRmQyAGhsv0HkAnSDiT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:N5s4Zu_sMZFdNLOHDDWIEnQscA-7Lt-DKjoU22g77UTxKpZRPul6Mg>
    <xmx:N5s4ZhtguJfHUtk8MNMKq3dpsNMj4AxMyXpVaKgZaBgVzGVClA0KGQ>
    <xmx:N5s4ZtHJo8MC83Wzk5pjzhlEER_gavU41IAOuBf7DpC8SSJERnGfOQ>
    <xmx:N5s4ZoNFWDH6gS06sw-Nuz3SuEpu4vUZddyqLuinEGoZ-P6K1gJDYw>
    <xmx:N5s4ZnAZJoVOdssmYT4yVbvHQ-aMu-PagGF41xInl5Dzb-5SYn5ach_R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:56:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2b30051b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:56:16 +0000 (UTC)
Date: Mon, 6 May 2024 10:56:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 06/14] builtin/config: pull out function to handle `--null`
Message-ID: <df1a6f14e6a267b8867d9784531ec8327a170d6d.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t6uSCVUNuokDQneB"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--t6uSCVUNuokDQneB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pull out function to handle the `--null` option, which we are about to
reuse in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8c7cd30cb4..59877065f8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -698,6 +698,14 @@ static void handle_config_location(const char *prefix)
 	}
 }
=20
+static void handle_nul(void) {
+	if (end_nul) {
+		term =3D '\0';
+		delim =3D '\n';
+		key_delim =3D '\n';
+	}
+}
+
 static struct option builtin_config_options[] =3D {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -760,12 +768,7 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
 	handle_config_location(prefix);
-
-	if (end_nul) {
-		term =3D '\0';
-		delim =3D '\n';
-		key_delim =3D '\n';
-	}
+	handle_nul();
=20
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
 		error(_("--get-color and variable type are incoherent"));
--=20
2.45.0


--t6uSCVUNuokDQneB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4mzIACgkQVbJhu7ck
PpR12g/+MSStzRX/qDz/9bDXCd3HubvNbDvLnLuhxYTaWDZbG0jfVyGlQcSYZyba
nWVukYd5IUNsRABORcUC71XZwsAOpL7ev3xAUokDLgcYNSfz0pKQOsLrQWB50nN4
25TmJqdPgWsf5cKo0GAO4cIRu4U3ofinvf9zU3Z/IqvryDI3X3Q9xvp/5clUZcSB
HZaO9arxUQ8r2tBN0ABzNnSYaFMPnGDMFouD0Kx4nEC32z1oomZXgmGvdd6qAxHP
MmLVQG/8dEZMywmUaUdz+/Os3W09LZ/QFkvxgvlxoiEanVji3G71/zPv23SZSXZ0
5n+nEz1ItW+kHuJvyZ8TjG1zLoyNTRbnA3xtf3wL5eiNjdiS/JcPqUJvETfwyVYh
h3W9etvYXsxj1WpttzXGXoz+KkLOUMmV3ZKg4uj8asD3wPTQIswlYmWmkuCRRjRn
tJ1r5KEL5a9b3+BP/Mwfl3UXlE5Csqh9xFJSOODVqxw8XL9hlmdFihwCSSDyzMVY
tm0UaAMt2fZiK8Khd/fpk7VO9s/urTp3FBllVUd97BzcWUhRmAiz5eZGHOw1Ir7E
fjCteqdpSCR3dfeRGi9XjF+fWp+94JN9RA1qexGUkWj4wqXffw0pyJczW1IMpElJ
4oToyQmreKILN+l2qNk+Dctt2N/yGwhnlpnVfBtgTFuai0bAcf8=
=2Dfm
-----END PGP SIGNATURE-----

--t6uSCVUNuokDQneB--
