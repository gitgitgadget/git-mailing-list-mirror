Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3591CA82
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848853; cv=none; b=M0zPEsq8jiW+ZlBs/EYUMYuY9NTnAQc+6P6kIAzlF1WX0MmdmqfX8ktp2939MdG09xKsDBhlOknuRlTs2Pohz4tXnexXGjY8RfB6VbSaz2RMD/sEhYoNfLmCld6sofDCSzdswHm9QHJYwztHBBAgWs2sQmvKZPgmelVPhaZ9Hmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848853; c=relaxed/simple;
	bh=VAMRxG/By8Ho5fxEvNM2Ekl6yfflAcG1nfUP4LkoWXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8PVJrLgxztqC/v9SgxPS8APJMQIqOtTAbmBschv3+YBJMvuOHaTDj4l0tfg7VuNTWyNoQeglydM7tTvLopPRGjcjLsnKxrOdLt4tTC1msDK3kt5I7st8l6XV2a7sP2B18/XQPyo4XsdTEROEQmfS57CiuycA5lQ28AAJIFRaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RNCr5MW2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IveJhPhS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RNCr5MW2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IveJhPhS"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0ED761380253;
	Tue, 23 Apr 2024 01:07:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 23 Apr 2024 01:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848850; x=1713935250; bh=qVKHFDjepx
	DSXEZQlBYkSKHDX24eH2v0Clw48bFhSpg=; b=RNCr5MW2K8pH/1MDrB1FndwBNq
	aG17/IuTrcY6/acJ4UFHtjnbOWfZU56wtmApb3wnzhTE0LAkJZol8SguurTSXmZX
	zVa5IbV1C1Y13/tFOVWgRPAfRsSy36oxTYmtQU7bCMrgzT/iT9qMsFqPFOraJRZc
	HYOx1l0RLjtDiMwuYDWcnrk6hj4kFnUMd6Duk2dzxaq6VOpvsqWMJL01TxzUbbIM
	fUDtEF7ewpBMT7SSxOKTkAvmG61ntBZWLFsJ6/Xglvd4+qBeGslNAVEj7rbwnUf9
	xWPYkEGB9p8Y3bMxrPuzE+njr+gtCmRkV7jKHBatIe6KZTZxhRfuHf1peb9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848850; x=1713935250; bh=qVKHFDjepxDSXEZQlBYkSKHDX24e
	H2v0Clw48bFhSpg=; b=IveJhPhSFOAp7u6jueZomt8ut6gT4mki4/DAOpqA/b8O
	uLG03qFgtCaznBifKVDCYIQHfJ20piAytq/YzGm/uzBqC0fyfJV5beW0mK9FkUVT
	L4SeHNJEr+8G08Hs5gbzPzft047nf/n7zi/YzO6sECfRB59MXcZoKRZGrvD6qOEg
	FU5Vljycg+ltY3gMWvFhWJoHOKBqJgOm4Z21IwdJviH9zhLhku8PKn8y/mCDe7ff
	W+JAgu3IA+c7M2775/Q4AouxXYNiLRM2GZHVb8Tjag/kIdV8c98+FWkrQobCZfRP
	SRNHJIllKVcA61TIZVH51vhrKZLwIfWtYwN6JfbrNg==
X-ME-Sender: <xms:EUInZkv8RlFTx5SHpfMo7A1M2My8FxoGgSrfrhYkL-2QdneU8clbVQ>
    <xme:EUInZhfq_kifkyimOqFsaSnvLIVRvkCfP7wTnxJ7v-hJT7Jr8_jRAyfep7oi95gRl
    dvjkyKj0KTf5fQbTA>
X-ME-Received: <xmr:EUInZvytbtFGpKyJJva2YXG48cf9Bpe763ixI2Oz9sGljoGt_PTB41UTn2lH8IRGxTAC2IUIf5o9EGFjE_poRp4KxyxZqe_Bn7JqYcZl1gSiMJbq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EUInZnPoo81K2V3SyU37Mxq5BinPUcXNqVGsEV-qrt7n02nTYqcJOw>
    <xmx:EUInZk8P6RHWvaJdZALx6zMKjn7V3YbbrPws64lvmFwEaUWnoXdXaA>
    <xmx:EUInZvUatyNrG8MKqd9FlPkdzTlOZmkvIAby-8Ti_I79GlQ9DWRGbQ>
    <xmx:EUInZtcpqHkcuZUu2S3qX5OYLcQZhkCsYWUDCsZvNb6EMnVHqSvw1Q>
    <xmx:EkInZoZ8rgqv0bu-XzPb8hqqNpFMCCfIlmsAdhUuNz2fEJrdZqqPlK2z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:07:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9aa70d36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:07:21 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:07:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 01/12] path: harden validation of HEAD with non-standard
 hashes
Message-ID: <a986b464d3e0250fc01f82ea8f8b91625eceeffe.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HSzFWUzVGJqfnM6s"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--HSzFWUzVGJqfnM6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `validate_headref()` function takes a path to a supposed "HEAD" file
and checks whether its format is something that we understand. It is
used as part of our repository discovery to check whether a specific
directory is a Git directory or not.

Part of the validation is a check for a detached HEAD that contains a
plain object ID. To do this validation we use `get_oid_hex()`, which
relies on `the_hash_algo`. At this point in time the hash algo cannot
yet be initialized though because we didn't yet read the Git config.
Consequently, it will always be the SHA1 hash algorithm.

In practice this works alright because `get_oid_hex()` only ends up
checking whether the prefix of the buffer is a valid object ID. And
because SHA1 is shorter than SHA256, the function will successfully
parse SHA256 object IDs, as well.

It is somewhat fragile though and not really the intent to only check
for SHA1. With this in mind, harden the code to use `get_oid_hex_any()`
to check whether the "HEAD" file parses as any known hash.

One might be hard pressed to tighten the check even further and fully
validate the file contents, not only the prefix. In practice though that
wouldn't make a lot of sense as it could be that the repository uses a
hash function that produces longer hashes than SHA256, but which the
current version of Git doesn't understand yet. We'd still want to detect
the repository as proper Git repository in that case, and we will fail
eventually with a proper error message that the hash isn't understood
when trying to set up the repository format.

It follows that we could just leave the current code intact, as in
practice the code change doesn't have any user visible impact. But it
also prepares us for `the_hash_algo` being unset when there is no
repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 67229edb9c..cc02165530 100644
--- a/path.c
+++ b/path.c
@@ -693,7 +693,7 @@ int validate_headref(const char *path)
 	/*
 	 * Is this a detached HEAD?
 	 */
-	if (!get_oid_hex(buffer, &oid))
+	if (get_oid_hex_any(buffer, &oid) !=3D GIT_HASH_UNKNOWN)
 		return 0;
=20
 	return -1;
--=20
2.45.0-rc0


--HSzFWUzVGJqfnM6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQg0ACgkQVbJhu7ck
PpSaQA/+KpFCZj8fD/k2qTXoF5JxjjD13EcspX4oNzQez5nEO1jtItca03+4HTNF
wJXVYTZQh2HzvkUD8zIh6+wDTvt9G8r25up11zWMlWHT/iMsSFOsHBJX24cWFt5o
cKIyMkgL0/VvZoe6cOjEg18kSK+OBevf74PL3tyImLtqydIWekWuK5TegMLLbhnO
MdtaOjeiSMqDPrt0AvPmywmECXM5AbWXeZvwBYM8Iyk4IujjmQpyZd/aieIIM2Yc
CEbp6+O9INxRCcZTWJ0Yx4ReoWd4+L17cwGjJdaKRU+fp0ecjV6HZ1MqfCHVYDiH
pRtCqqf8vViQZzb0/01SXz0ZVoghWIZzqrdtW+QSKvnvLIEyQWA+Pdsy6YxLQN++
H+A+pBtDdzjbwdw6OdoqCXLL1I4JihCy2Q0z8YvnzQgG1ZGHZnt465DtncpQYbHQ
0VNDUURX1idjHkNN14shAdw144D2kOIEQ7b6pG/x/2kytVYHsQnPDcsfI2VFDHPf
D90nM5mx37L7KlKKTrFWmHJwMj1KlXlcGbqK861a0dQVi6D/59GGU6p8x84PZHr/
CKLtUpQpFX98sbeftk5kWYZKlCXndZl5y3fx0AIK3sP0KicNfJOUdTdae9u4mb+G
t4DjUQsRNaAxC+EIXhzvuCP0NMpECY5ko1MYYXyzbrHdp750/7Y=
=LyBy
-----END PGP SIGNATURE-----

--HSzFWUzVGJqfnM6s--
