Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E796A8A7
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057630; cv=none; b=Gh67dHz9hz4jItmxKezKffvFgnhnKdZLATUaA/ncEQs5MuP2Eb9K72CTqkGx80MhnPuJDimIvKh3DHDWOGl9a3HMIxFLZzQ5+ECCkE9S7sAF7NeyVI2KhqjxxDL+zDNLu2u8A0BSGksD/3G3ioNV/Lgd0YUX8VhDvrj5+ByndXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057630; c=relaxed/simple;
	bh=m4eTzM+HkFfPxdYmAwjVsJKQRsUj1U3ioXiaH+8A89s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlVsE1l7oi/4K8BShIRAj4/Umzb+tCcGEO6dEARFiBKS/BFlgFzthmoXi7NNPJbafOg169EVz1k4xjC5EAsvuRc95hiNpPO0NiOzB/DRA6EGNTZ2j6TPe4Fq/ZLAQo2iDCmM4DdyEwmIE0XHR+ynZHTPMlvVQc3gEKo9x1B3eF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NgpshvOa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GD+01PU9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NgpshvOa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GD+01PU9"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7C446138024A;
	Tue,  7 May 2024 00:53:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 07 May 2024 00:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057628; x=1715144028; bh=mvGNzcKym1
	jNRBcbY5mALWha3y1wILNnyHEbRcy0bKs=; b=NgpshvOam0ZhM0+hp3zyEqNo17
	4IlskxhhVCuqRhXRqwoh5e5DWZNHyQKkxnJPWwInH59UV1l9iQUknkDS4yvykLdS
	ToYs4/awVh5g+8Eej3YA3ABpvPdxfNerxSWt05CbGQCFFj314RmaA2wF3J3KrzVs
	nXORtjJQle6Zg+j8Utq9rgLZt6gT3qMPVwnK9AcgxJUlaB03tzSCzFOrewgrr98u
	osorgrzE2etk5ho2S/lapV3zM1WceVMfJ7+NOWwzLuIbEla7d4RCp4uV/0Rbl/Ff
	WbQM6xZzUspsgDuMpR3fdPsYGeeHNR50m50uTjIWYy3Xu0NM9SZ77MezKenA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057628; x=1715144028; bh=mvGNzcKym1jNRBcbY5mALWha3y1w
	ILNnyHEbRcy0bKs=; b=GD+01PU9u7aCV5u4c+do/qgHh6YJOCkH8Pb0duTVcYUG
	sBIP/lRfDwExT/KIXmP+0ABuqYKAEAWg3PrfpzoG4RnWrKaHNrAio1hsk2Vj9V8K
	JcTxrHElikdfmmt+/sPog0/jP63KC9UpX4ic9XyAJ8WVK6qkaTLTRC3H5Ccht9G5
	l65/JwHOVipF9h6wAgAIudmYi4HbNGGdaFD31P2UVbBhBorhhQ99oOfrhs2D8LTj
	iVc9yysSBPDudkpkws7eseY7IycDknh+080Ke32OpildGQIOxrAzZ4jiR7ubOnSl
	Z3P5RGt0Tn51wQZeJoirZ/fs4U/gPJO+eI5bk6qcRA==
X-ME-Sender: <xms:3LM5ZmQoHUQPeuG0mCVHmmiXNsO8IQi1oME7cY-GFGreZAN40eOxKg>
    <xme:3LM5Zrwm2m7DkciLn7vuf2DhBoGgufJaVjlmHWiiAK_YR7FhphpElH7kuiduY-5wU
    25Xf-AiEqs_q5pd4w>
X-ME-Received: <xmr:3LM5Zj2-X-aT05XKHU_Vq79VvVp5SFoFemy63YJ9tPNut2aS4kQe6VBM88-kYQdNUFS1w6IBZ4KMmT6z4fq_bAj99S83RtI6gzHojEr7y-74WsFrPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3LM5ZiA6zqZC1Ojg9BOje-wiqR2KN6juEhcv6Pvse0ZNWUu1L-V9gw>
    <xmx:3LM5ZvhDy99JA_Ua4OMxRdoNW9EZdTRgwPV1vAmB3lZXtVOQJ0T3sQ>
    <xmx:3LM5ZupcIyJcU6TjmUwZvlCpVMh1CM35S-9AVtxPGt5Dsj5YONb-Xw>
    <xmx:3LM5Zihd3lS_KVqyq-E91Ehn8t3jy4QwRggb_oDstYfJb3LFnxc8WQ>
    <xmx:3LM5ZvdoP7DBRpVjpCZlBTGptKAgOCpEcbdZ6vkzdzvmbMl47MscmnWY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:53:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 59c793e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:53:40 +0000 (UTC)
Date: Tue, 7 May 2024 06:53:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 13/13] repository: stop setting SHA1 as the default object
 hash
Message-ID: <950b08bc78a76a6f627698372306e2eccc0f3c39.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oE+98R4myOfSBg5/"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--oE+98R4myOfSBg5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

During the startup of Git, we call `initialize_the_repository()` to set
up `the_repository` as well as `the_index`. Part of this setup is also
to set the default object hash of the repository to SHA1. This has the
effect that `the_hash_algo` is getting initialized to SHA1, as well.
This default hash algorithm eventually gets overridden by most Git
commands via `setup_git_directory()`, which also detects the actual hash
algorithm used by the repository.

There are some commands though that don't access a repository at all, or
at a later point only, and thus retain the default hash function for
some amount of time. As some of the the preceding commits demonstrate,
this can lead to subtle issues when we access `the_hash_algo` when no
repository has been set up.

Address this issue by dropping the set up of the default hash algorithm
completely. The effect of this is that `the_hash_algo` will map to a
`NULL` pointer and thus cause Git to crash when something tries to
access the hash algorithm without it being properly initialized. It thus
forces all Git commands to explicitly set up the hash algorithm in case
there is no repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/repository.c b/repository.c
index 2118f563e3..15c10015b0 100644
--- a/repository.c
+++ b/repository.c
@@ -25,28 +25,8 @@ void initialize_repository(struct repository *repo)
 	repo->remote_state =3D remote_state_new();
 	repo->parsed_objects =3D parsed_object_pool_new();
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
-
-	/*
-	 * Unfortunately, we need to keep this hack around for the time being:
-	 *
-	 *   - Not setting up the hash algorithm for `the_repository` leads to
-	 *     crashes because `the_hash_algo` is a macro that expands to
-	 *     `the_repository->hash_algo`. So if Git commands try to access
-	 *     `the_hash_algo` without a Git directory we crash.
-	 *
-	 *   - Setting up the hash algorithm to be SHA1 by default breaks other
-	 *     commands when running with SHA256.
-	 *
-	 * This is another point in case why having global state is a bad idea.
-	 * Eventually, we should remove this hack and stop setting the hash
-	 * algorithm in this function altogether. Instead, it should only ever
-	 * be set via our repository setup procedures. But that requires more
-	 * work.
-	 */
-	if (repo =3D=3D the_repository)
-		repo_set_hash_algo(repo, GIT_HASH_SHA1);
 }
=20
 static void expand_base_dir(char **out, const char *in,
 			    const char *base_dir, const char *def_in)
--=20
2.45.0


--oE+98R4myOfSBg5/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s9gACgkQVbJhu7ck
PpSa0RAAgy6GA+FpOaIU+kX5tazzW9jHJC2msY9KeJAn3uRnjS1b+hRCCV8D4MMM
KIOn076SHtuElce/Xx25NiOCWoQTMAp4zSiOgM8xKbYsxO4PnC8diilqoGpoBUsc
URN08Hev7fEa/3oGgN57XKSetm2RxAW7EDFKriNh0O/0dSIgJCex0vovVfeltwFs
LcgNjNtBz1yqbAkWWYMvLppCTeobkVj1tNxWtezrnRPzO/zcSe9j0VD8V3N4OGAn
NP9J5F1gXJysA99idk5nSo3DiH4Q+J+eUCNM/IFb9HdozAniEoxrEPNzQalspMco
7SB52aIeIfmryxOy7jGOSsD4dx0ybFvw3qLjve7C2K8n1IdiQKhIwOD799AdcGM7
/mPOWZELpbxOsjVAHBzzqEsmo95ZWjCETMFjKHK8hr5kCMs/aKoKwv8076aag4Oh
FHKFhQ9G7WXHhHCJlhMTeq2jhdtgr2TkRSxnzJESbPqGKqevuUNmvlgRiGGJo+Oq
699/rcBAFhIFMbs8NrrMAvNLvRCN+1Iwj0fW4l6h4wrxoRiiv5/rcnxf6lG/LxeK
DGpm1SoTFJtHTItmE3a/iS3ewb2QumQplFheXXUh1IaHkzUmvIZahkHynKZwFbCF
LuwHE9iwB5hhX5xcVsIYGZXTX+XhtcmFUNF9+V4AC9DpteUAA4M=
=iooi
-----END PGP SIGNATURE-----

--oE+98R4myOfSBg5/--
