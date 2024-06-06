Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B83B1BC
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651744; cv=none; b=rGNSSIbG6Rk0yJ3NVMVlBODUIaubIM8jpq/b7kKSQ6jlvJmAU/c8Rg+Qor3SJ5MapTXwdPKoOqBAkNu+c44olQlyV3UE5iS8usd8SvGolNfEO4mLzH4Sfs91j2clTcfACR04F7QB96sS5WKJUx6Qo9h9z4hhAMbvxfW/X1EiNFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651744; c=relaxed/simple;
	bh=Nq/8gJa+Kq3l8OiehupsScLUIBTADIvm5y7xr37Drn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF0B2wXHTmFClEWa8tyWTmP06bU0O4yBfHStd01mg70K4Du8sWs3Cn6JsyS3XxqSEhNfLtZkbIgM86EfG9eHkN05IeJLqpmYxDvUOJaNQs/2F6+rGY1TtOc5enSY3TtuSRVmynyWXOa+qSNvIJfHWx6CUhjb+7jFT7HDNJUmvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ez8k9f4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MnBHEiv2; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ez8k9f4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnBHEiv2"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id EFB3D1C001D0;
	Thu,  6 Jun 2024 01:29:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 01:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651741; x=1717738141; bh=qDOiKOuhcZ
	EX7/k455COCf87MTP6jZPoNKaStQCtCds=; b=Ez8k9f4LRJP+I8eU6djPaa7MCy
	huMpiueiaOecRNmmNTMI8NquCPzLJvskwLHJ7a80Qyz6pbShUikHPzY86a4S0P2D
	Sf7oIYdALzViCVUDcblQuzQJ/gO2sSNYFWzGRn34fg2nUCgcsxgFlQ/Iky3IbeoV
	zC6IHBtoCPKtxsN2BNOCkcdYxTbuO8MlwWsDDCLZJKcHh2rYy7ZR5e+f3jZ0OeUg
	zU47K0yCjaBmxXHNRwEwf6zDrRdsLytuf7vO+Edeq09b5TT3ak8RcPHUHEGEcqi/
	xLkxiRvxnRJum0V3APXuASXcyuU/yNLvbM8Ekkv68H2SKlgabne8oaPbbC8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651741; x=1717738141; bh=qDOiKOuhcZEX7/k455COCf87MTP6
	jZPoNKaStQCtCds=; b=MnBHEiv2cFcp743V86u5k6fjHSsgzhTQ2xlVprvhMPvV
	Zg4h8AWqfjE7MnrXF2Kc/8cwkaZ0iVB/2tbiNCqb9JfCv5HbAJ+nGBejH50+xNG6
	31nRQQE442Kxrw8B5UtpPPnI+4V3ndT8Rw0tPeuMmoyiNaRyE3CxcUBAas2nNzSL
	0B2ZDMhhq7VriT4mQ+fgw0d+xYnzvjTDSedR9MvxXR0+te4bqzuwY4F5BYIT8UW0
	2Fkv/+L3OEMisHghbEP3M0cLhsWNuOTTGIzc6qBUNEuurFhcpjvbiy6nYlWPj2Fq
	MCOLVbFw4m+5G62OlTmLU0iappa4Aq1gjBaT20kr3g==
X-ME-Sender: <xms:HUlhZiMGb_C0fzHa5bZpoa46LWmXqR4Ls8ipzYmHptOSZqTmG5cZjQ>
    <xme:HUlhZg8rA2k1106d-7M_sB3YzrFifROvsVJKZEmkPEb5F5Uqa_bvdQ1k-gd-r7VkY
    Z5JRpwOM9e-nV-_Ew>
X-ME-Received: <xmr:HUlhZpQnPTqHIKDk_fhlStKHiuzEajKvI2GGTs5HCHEBSHJmoZfvDa331f37Lo7CNrNq4jeANavEFSYcg5xu36Ae40jGaJhk6Hs3xm9tVXCFEAOH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HUlhZis-7NbfzXoXbinyoPTxd4CalJVidxYgrshddAm_WDprRzWMcQ>
    <xmx:HUlhZqfeWJgUSXUhYCXR376bzV_d2gacwW0Tx0x3xaNr33pdp4qKrg>
    <xmx:HUlhZm1zu0r4RpJy5YZsZ6q8TQA0Ufusy7saHS8wvwU5IkzbFNhSKg>
    <xmx:HUlhZu-knZy6OzuRL02QKSha_Dh18HNjWUO8wYoKBnmeGL54QUIWUg>
    <xmx:HUlhZguXWcWf79STh2uhL20qxnTqgH5mw6wgz3kQmeHTJXytTvRp3ot1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a5fca1da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:28:29 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:28:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 01/12] setup: unset ref storage when reinitializing
 repository version
Message-ID: <afb705f6a080d93284919ae951d7b24d0a43cc08.1717649802.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VUDm5JNhCWOeN+5X"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--VUDm5JNhCWOeN+5X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reinitializing a repository's version we may end up unsetting the
hash algorithm when it matches the default hash algorithm. If we didn't
do that then the previously configured value might remain intact.

While the same issue exists for the ref storage extension, we don't do
this here. This has been fine for most of the part because it is not
supported to re-initialize a repository with a different ref storage
format anyway. We're about to introduce a new command to migrate ref
storages though, so this is about to become an issue there.

Prepare for this and unset the ref storage format when reinitializing a
repository with the "files" format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/setup.c b/setup.c
index 7975230ffb..8c84ec9d4b 100644
--- a/setup.c
+++ b/setup.c
@@ -2028,6 +2028,8 @@ void initialize_repository_version(int hash_algo,
 	if (ref_storage_format !=3D REF_STORAGE_FORMAT_FILES)
 		git_config_set("extensions.refstorage",
 			       ref_storage_format_to_name(ref_storage_format));
+	else if (reinit)
+		git_config_set_gently("extensions.refstorage", NULL);
 }
=20
 static int is_reinit(void)
--=20
2.45.2.409.g7b0defb391.dirty


--VUDm5JNhCWOeN+5X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSRgACgkQVbJhu7ck
PpRE+Q/9E8rlMHlvF12wHTMW97g2h9g38l6nuJO0RxTDayzUIvamTXHDtuCZNCDc
YCTXmv6aXD6yZZJrBCXU0BRVGle9fiyRAe7maWNlS1jQ4EDaqB7R1FVxVsRDUxgd
VZfp+vuJq63KWc48jX7qJmRjZ942hmACCVKM8e+l6zLmu6FcfBGq95L+8pu3dFra
XASzrOtZ4lMwK3qlYAoLmCuZMjf4K1naas8L1cFOJn19gcd3iYmf8cRu+XJFe9XK
O+LiJWknFghjAWruu3jySlZ8TKi1Qz3vX+Rne8TWEQJPFEvWh5SSytHI606SpQOD
J6PPP0XRtvl9fpYpepuIdWAvIp7ht7UPrbFITjNwkd50Rjo1YlMAFlCgEuo8T2ly
MlwQMIUnaOQ40+sS6bgAE0PllGtiooXmPEgLEM1vzq4kUGugfGj6pQtMCiFdAQYY
TM/XVuW6Cr4fO3Ox2wPTJ7sOQZjGfsCVqHcAEoHhF6t6/RogRXbgSKo2WB3Ucmp7
nM8GTJnzLa8Ffj+FlLvZBdEdB7ajn9B3U02SVhOstlqnjWek4qq9+KCOlFVpFKKl
FfYB1hr0p34/gseXlX57dM87CrDgKu43EeeFIOlVqR1LT9QC5bHNzM29G1qOgW35
y8TgZx1475wQgfEqfNHwAks/gFHi6SuoHW332FUgNZDhLrgUfPA=
=ONDK
-----END PGP SIGNATURE-----

--VUDm5JNhCWOeN+5X--
