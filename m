Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F29208AF
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209703; cv=none; b=o+6CQfiqeVjTvsJCp+S957UxwtMQHvWVP19GGyzjrx0wICgxTd6kBBjV8nIUm28HBoEaHYpaBAIL4+o/GZhMbHo2h61sYCseveOrDafmpJaUUDzwHJDP9ewmdHcdXwL6ag2ow2a07Sma4f7Sj1GrsO4Mby1DTSUR/BsxkOYRNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209703; c=relaxed/simple;
	bh=ey/GG7+CEOlx8VGEgkEZ6Tktl7ZvWmGmm7RTm32wyLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS9GCR9xHqG5rEeC6EK2bIIfz9OO2hFigOPigzLkpgC4NllNHLMVcdEUcEGnFhrLFEAM0j2TauLn8mR7Bq4zYWrbThzKf8qXAbk2yK8bSgnRcEiLS3rzGpts3VI2+SaIYnt5VJjef9V1lQbZAP72UjI3oSv/XpyB9jS0+X+82X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ehWkrFLK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXKDTQDM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ehWkrFLK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXKDTQDM"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B35C61140116;
	Thu,  4 Apr 2024 01:48:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Apr 2024 01:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209700; x=1712296100; bh=l3+GOPD7B/
	sd278+NC3wm1yDk8JIBufNvgRT5/7ZG2c=; b=ehWkrFLKgLrpzhYJK7SQRZOvTI
	OnX4R2oBU8BVLvywmkk71MUJQfpb0cm0pzXRxkeiGCZVWROi7PA7o9x3mvr4++x3
	ocMnxIIv+bm203hvtHM6PAsnpmOZ8bDlBe/rpEortD4pxKu9mGEvdguO35ag3icM
	uDdnAw6bl1MRWYafRedEP5cM+EZrkxqogXriqlofHaLX1BVOw7cTi97uykjEk0f3
	nIQkv6fzFc4zi9ddgqoxb44qMP7nnYLcHr9oquddExe+/mkOcJHErALIFErI3nvn
	S9qZdt9Him9cRmc1S77RNTmNEUERtgUxC51VksdVyBl6ANQZ2fsdRhXYKcnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209700; x=1712296100; bh=l3+GOPD7B/sd278+NC3wm1yDk8JI
	BufNvgRT5/7ZG2c=; b=mXKDTQDMWG2woim75d+mXTzw1TjYCccelvrl7DZlkJfs
	mcuVALyfR2CTku8FaOR8lCtjVt/DMKrYCr7m5kLlcmWDAWhQBuspmM50MTMb2sOy
	AFJ8LA/fIVLUO2WumiDbpnwlQwx7rqxCuyHXmxmMM7lmAEg+umCwIDsxgJfVOr0O
	frp8POksPmYjxUiQ/2XYPhoYeefTjMTqopyrUh8N7Hw72FELMdsN5aHQilyF3iD8
	YDNI/iCqrJv72rcjfnGaD64kcyH6XO7xoDvwjvjkFMOM3l1Le6kzOnspZ9XU5Utv
	NggGcgiItC+GD2KDnBqSutjWIeI4UMthWjbxADMtWw==
X-ME-Sender: <xms:JD8OZhPIFrbDXcOFo2wZ_u5odNdTTu75xnmDg6pU5yDcreMqamOU_w>
    <xme:JD8OZj9e7jJUBygSrLhjTT13c3XaCzl7ilunvDUiLGD-Hd2vCh7eAyhwjA95kqzkQ
    fgr9BLl8LXjqyWSJg>
X-ME-Received: <xmr:JD8OZgQTn1MNjVugmtHDfI6GKX3beexj5hzChK3P0YcvGFyVjtUuTTQhBOwWtNGBCATVGlHIMOMRH2ymwXUGTpwZ7YHbTReTmo1AUIWDtdvVJf9f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtd
    fhgeeftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JD8OZtscZMo7qDYD7goeywt-FJ4NY9YGM5Eguw3bb-j1rcuGvRauCw>
    <xmx:JD8OZpfPtN5Dz9LQ-1ODJ6ts0E-iAYB-sdCxP4SQlnEHQIKSe6J4mA>
    <xmx:JD8OZp2pmBc_Z028Rmzv2mpA2kykBtZysyfrvRteUBpnC8WonaMHHA>
    <xmx:JD8OZl_XvCkk-KUvDHf1faWBJHgz-xt0qpawTOuYJ8A5X0CVhqdXdg>
    <xmx:JD8OZg5TyCHwLPGZH7UItCCpGd3QCWe1oYdItpuROMkHBKUveRoOHrwZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 134d9060 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:16 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 03/11] refs/reftable: skip duplicate name checks
Message-ID: <80008cc5e7772f5b6cc93d3cc898b2d2951a3588.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/m1DB64npauK3He7"
Content-Disposition: inline
In-Reply-To: <cover.1712209149.git.ps@pks.im>


--/m1DB64npauK3He7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All the callback functions which write refs in the reftable backend
perform D/F conflict checks via `refs_verify_refname_available()`. But
in reality we perform these D/F conflict checks a second time in the
reftable library via `stack_check_addition()`.

Interestingly, the code in the reftable library is inferior compared to
the generic function:

  - It is slower than `refs_verify_refname_available()`, even though
    this can probably be optimized.

  - It does not provide a proper error message to the caller, and thus
    all the user would see is a generic "file/directory conflict"
    message.

Disable the D/F conflict checks in the reftable library by setting the
`skip_name_check` write option. This results in a non-negligible speedup
when writing many refs. The following benchmark writes 100k refs in a
single transaction:

  Benchmark 1: update-ref: create many refs (HEAD~)
    Time (mean =C2=B1 =CF=83):      3.241 s =C2=B1  0.040 s    [User: 1.854=
 s, System: 1.381 s]
    Range (min =E2=80=A6 max):    3.185 s =E2=80=A6  3.454 s    100 runs

  Benchmark 2: update-ref: create many refs (HEAD)
    Time (mean =C2=B1 =CF=83):      2.878 s =C2=B1  0.024 s    [User: 1.506=
 s, System: 1.367 s]
    Range (min =E2=80=A6 max):    2.838 s =E2=80=A6  2.960 s    100 runs

  Summary
    update-ref: create many refs (HEAD~) ran
      1.13 =C2=B1 0.02 times faster than update-ref: create many refs (HEAD)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8a54b0d8b2..7515dd3019 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -247,6 +247,11 @@ static struct ref_store *reftable_be_init(struct repos=
itory *repo,
 	refs->write_options.block_size =3D 4096;
 	refs->write_options.hash_id =3D repo->hash_algo->format_id;
 	refs->write_options.default_permissions =3D calc_shared_perm(0666 & ~mask=
);
+	/*
+	 * We verify names via `refs_verify_refname_available()`, so there is
+	 * no need to do the same checks in the reftable library again.
+	 */
+	refs->write_options.skip_name_check =3D 1;
=20
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
--=20
2.44.GIT


--/m1DB64npauK3He7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPyAACgkQVbJhu7ck
PpSsSw//QguoDqUFli9VzHmnVPuNW9RbTXCrehMtoBHYFHk43SJAfxxd3RK5RsDe
PBhx2ITquCYEIJhuq6LqhotetsAnlAyAdZ9tkNJRXV6fDu2JU13oTUv3yTnNKf7U
y7Pr8DQZcGcb6p3VhIrRrcMms7CCzdB8xlzV9vMCytYWVIwc/ptwydUHCug0J2X0
g3YfmlJTOl2SfpLwVKuh2faFgogy8DSJk5KltEw8y44AoohCPNm1zHoSRNmyFURV
4qEMpO1cVZlyOsGLXoBaSJOGtfJkHKL8+0oE4zkMGF56tZDv7/9qbBbWXAX4i+OQ
D3e83bf3Ew6ScgTRjjqtOiPRl2s+gu6TtGIU7oEjXesk0qpTEXqcdTcQ48IlSW8Q
gudwWpbEZtFQlPGW8VsqDZCXw0QblgdgcvVpkXmp7mZ2Ht4JYcdWvEDSbEXqBO10
0f6vWE2qH/CvmoZ4cHpuGjVskqMHjsfVmKRp+3JG48TmIvXFxxM/RDyU9eC4rhjZ
zsWLAK+jGvEgzcufHKF2c6ZUTIfSZrT+vmej3W202vjEESCVTXFvz+plJY4WKr79
oDfxVDq/s0GCgBwdIm5VSH3FxQ0I6AWVEPydFPefjeBzYUk1c6l+8b/12UOivqc/
R2X6RAai0pULTqzNilYTTK4tp3ElyByYAwFRF9w5Qhg0SFCIZ6Q=
=+Hll
-----END PGP SIGNATURE-----

--/m1DB64npauK3He7--
