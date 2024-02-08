Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381767C51
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707369982; cv=none; b=umppKNzc/x9/EUzmo+xqI6BLfhzChFfK8jz7JQ4IKNkG/lbJQdc8p6aSoKuP3FydvK0BJ6oHUGOwN+G41SQIKVfS34QIEBY2E7ypUkrdhwkxvDECBGUl8i77fieh2rQBzsATX6Mjam/I1V9L0yZULGKQ7bmN9nSXEcbUj7yOLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707369982; c=relaxed/simple;
	bh=oQKVPkVTcA1zJnwC7hxKQ7mOPDZHTJoShwl3f4hZyA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mgdfwkMSSo9lRrD9lyJcvJw0+w8CangKivaMum/q3ePw+YeA9s4nVU34EJopjTLlpRvoCGAv8jBO/3mGkv7K1yFPImu2Hf2aVPrwsDlHZiEowNUZd0ManoQ3LYoJmavyna53GOetRlgu8+dyih6ccYy6uhR1ikiBfYATUkOEq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r1mglsRa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PkylRCIx; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r1mglsRa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PkylRCIx"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 939A35C0103;
	Thu,  8 Feb 2024 00:26:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 08 Feb 2024 00:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1707369978; x=1707456378; bh=6+HcZ6s96geoW+BAReGG1l3qRUDrO0Jd
	9v3TyQWvF1A=; b=r1mglsRaKAXxiOFSaqC2LUOvTwL1oGh308fKujCp0JaEN3nS
	GZZLuHdm1kAwd0KaaMrzrj+pC71ghnWM9DhwV8W5mj7omrp85PYMCKJPCloCiXnp
	JRKG/oJB9Ei90clZv/+AiuAEKCfxg1KnqSM7+zgLndkLsT5O8jousjDT1j+7aewX
	olIkNnIUkRwKDSeNYWga5oUX3seaDSZmttInlnM2ZkIUHbsEVfjefoC6Jg38pOP9
	YNJAm/Go0brDMP4z8V1vyRETOMW8gc7vTf6VAo5olPd1IeOG+2LZTYIw2UgwJo2n
	d9gc6JgC3RxI7xEEM0swCJZgK0UnkpmCbt6Xkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707369978; x=1707456378; bh=6+HcZ6s96geoW+BAReGG1l3qRUDrO0Jd9v3
	TyQWvF1A=; b=PkylRCIxG8AH6a/D1lynRtN8gLHEtG3+g6nxD2TR2UNctgdO+SG
	08lDlCVKhldoOuS1aDfkynZMp7kbRvFWpy7VNKa7oh/asPrNla4Ho89gg9zM/SHX
	pLmsZIKyE7MoqRQEWzSl74fO8honf3KA7imDdtspzoMtU8cEEqTpdkOV72QLg8H1
	uUPm5itMh6iLSUCVCHEVcckufEFjikw42VXMYjIgHd4tQjD14KI44BDz67fN9Q9k
	c63eL0ikIM282YcqxuNMsoX5RK9sJMbLyfFQbg5YqbO3J2XNN1tnJRdcRKdOtPqF
	noTNO8/kCC/R8f7ISq7tfbYvvXNas1fN4iA==
X-ME-Sender: <xms:-mXEZYhgy7-BD9CfWHFbi4bGMKBZyqzskWNlQ9IFon3AHSvI6Vkxvg>
    <xme:-mXEZRBmqJdHKHIni2dJY9BCitnNxzA9DLY4KTE3BWoP9xGvDJt3kAAqi9tDeGvZA
    b_yS5t8DZXUqaehCw>
X-ME-Received: <xmr:-mXEZQEthsy_-sUHNB6a9iIVF7CO8zmEGxPTvJznZtNi5M08INJnVR33A0JaioY25kktjPMZIyoNEyAP88YgeiOAcveK5JmH30u8U6QqqWevKWd6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepuefguedtueeiheetleevgedujeekjeehleejje
    fhhffghfevgfekueekjedtieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-mXEZZR7X0EllKYpCTQfAiz1cSyx9UBx9i6ALDn-2fNALseHaptpqA>
    <xmx:-mXEZVxaYh-d7htAC9dJ08R0LCAYRnFOkWaOafY_vyBJkQIeVI6hfw>
    <xmx:-mXEZX69xU_5ITrP5XyPvZN03IgUgITGljhREAOl_K8wuEZAaYYwOw>
    <xmx:-mXEZWrlyp4h_da_hJ7x81CYNTINURG9Qc602j1Nm5w84BbxkQuXoQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 00:26:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 457a8aa1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 05:22:42 +0000 (UTC)
Date: Thu, 8 Feb 2024 06:26:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH] refs/reftable: fix leak when copying reflog fails
Message-ID: <02f7a97a451927f9a7ee06f3c5ea5af4c4eb6645.1707369907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1jupAWvD3401hMwP"
Content-Disposition: inline


--1jupAWvD3401hMwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When copying a ref with the reftable backend we also copy the
corresponding log records. When seeking the first log record that we're
about to copy fails though we directly return from `write_copy_table()`
without doing any cleanup, leaking several allocated data structures.

Fix this by exiting via our common cleanup logic instead.

Reported-by: Jeff King <peff@peff.net> via Coverity
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 85214baa60..a14f2ad7f4 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1503,7 +1503,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	 */
 	ret =3D reftable_merged_table_seek_log(mt, &it, arg->oldname);
 	if (ret < 0)
-		return ret;
+		goto done;
=20
 	while (1) {
 		ret =3D reftable_iterator_next_log(&it, &old_log);
--=20
2.43.GIT


--1jupAWvD3401hMwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXEZfUACgkQVbJhu7ck
PpS7DQ/+LbIF7rbDTrUnME04SVXzzIN6ORIITEynxnqCbNohQlGd9S7RUCnrq1WU
pbHUSvuHMPlqRDlxcH0XATNYgoud+a09L3Z+Eh35bjkkOlgKcp6YK/bA92pgMquU
uRV+yfUvHf/cXd428ai0nJ/0OotARW98/+tA8WGzL7+CTNNt9XW8lYOJIE9sZRiR
v0pV92mbeQtbsNlusfA8dxb0i6UV06qrT0FJVCkzLPagPCBT9UzzsCwNQQr7K1Rn
+LQcaqCEHulzE6eGuh1fhNd1aaCgdYkwMaE2cCEk7cznYcDb6nPZonNpfN5+Kx9p
jlx10n6/Hp1AZpryD/W/mw0g/pI6gUeeCYsOc/bimJv0z+wD8SP+d0jEt6mv7HjG
zLFg4yPqhR8DskD9KYcDou9v4djY4dsPcGeoe6gaIT/iHCbmg+N0H+z8EZduRd9P
8U9Q3t4VNsAAW6E0K0oeeQiEBfx6jjLkbmfvhG/0AwMg4ZRgfHFxuAjLfGkzYAac
Hm+aefQlH76Tnw0k2mJe37HC2FLVh4ASHSVVZkzzjGtH86YaP5qHZa7RgXuFGGld
55WXMOc6dOwDMF0kIdpWoJHCZlW/jys/fSvq/S/41KSYQh97zjOXaljbF8drOEI9
sITUgNTGlLunAHBU/KOVxZbDIEN+v1WZKeLSsynHEZHcAU4Upac=
=vTV5
-----END PGP SIGNATURE-----

--1jupAWvD3401hMwP--
