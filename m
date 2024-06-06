Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13A1EB3E
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651771; cv=none; b=fsnjSO0dBGs1KMJZoi3QAOL5nCJqj6iiA+lenJPP1P3ki6GTEGmCkDhEEr0X9Jg0hB9PqG5sXMPqwCO+uKQI1o7iG/RKg2sQvyq/SSykzTj/34kXvha8Kwi0MntNYy3NdjqFMYF3fdtfeYtdk9JnhWtTB2aotLSMPdhAKEu6lrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651771; c=relaxed/simple;
	bh=1YdQl7j7f+9Y19Av3QmNoFuFJrRzizkSS0fFsV+HNdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki/I7bVXeTVvZPuRAkL3ejahe5mVnxdchKcCsBHt2/1s1gFv1mVnI2pqLsRa1fbyZDLXRjWcX9RjvhKL06mDFMSylts7lDj5WDBhtPo1rk1s5DX/Wyfg3VcXZCUowoTCC8IzSO5jl+diuz3wIpt2B3aqP7BKFTWadQXXUf5up20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dZ93h024; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jmsuNm+X; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dZ93h024";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jmsuNm+X"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 687EB180019C;
	Thu,  6 Jun 2024 01:29:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 01:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651769; x=1717738169; bh=rK+Q01T0xB
	NzBMGjzOJmAYTcwS9seinEch1wZkGBYBg=; b=dZ93h024MHAEZE/mvVzb+SjMq/
	JzN8PBSoSom/KirHZbieXgMMuGVWjbnx76qk/PDCMFGDamxjfVHXVJSBK+/vwh4b
	z8l/hD5rRcS6o/yZiorK3mJpOVaBmW9ye+Oo5Wq5Mm0ETMsE0rDeKWrB154w24F9
	M4gkZGzg0dGDY/0hCvOxrVfXK3aN8A9lX7GNZwMOzVMiqzMjQu8mK9HiRbRXdwdg
	2gJVFHYxDsl0s12OCh8vWh+OmxsjS040MVTupkqlSOUGRH1PuRRHzuYRtZPc9PSV
	V23vQPIaGIKvfMguptuAsIhGbOMmgEgJ9UhTh5/k4QKjFThcP8H//7ZThdgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651769; x=1717738169; bh=rK+Q01T0xBNzBMGjzOJmAYTcwS9s
	einEch1wZkGBYBg=; b=jmsuNm+XvpMq+YCVTmNHzALwMRpxSF6lw5YF0Jd8FbqT
	AfUeoOq/5urDj+SZMRCzXoW1mZj396n3AwvPFuwLVS/50dI09gjeP7Ckhth0NS7R
	GKDJgaApsHpZu0TOpp2kUq7+MX27pSZUUjQUfE2jUjjWDW8pGXVVY9PJN6jN7kKl
	q1p1Teg84Z3wYqBa5Gmuhv2JxhPdhkys2rw90SS6laRIpc/0EeFSl4RezdPOPm76
	fNKg8QN/87dTzaenB634Rz+kH1JeOjDgVE+LpLqTdXiUwRgejgrsTpvAk4w4b07Z
	FNUKYBr44GmLQOQ7wM6ZyQ4pAGUQ1Pzlg+m4dDRQdg==
X-ME-Sender: <xms:OElhZpyv3J3rMXsowfkFaSVup3okR0KLaDXsvq_BgcF-FLRpgtTHkw>
    <xme:OElhZpQJg_Ax32zh6SXzDF0F4Gy2bjOasPoxHP1u8XS00sFmAPcchEPFIhWkERVhy
    bsDOBcFzFmlcs_q_Q>
X-ME-Received: <xmr:OElhZjVkNka4hXgCYyMGuXqE380fKXm5l08NduMu4i-yzLnRdJ5hD7E_X183qwupDXUefKSfyErug2OTMtkfNHmwUxRdpL3v2liFTrsuRe0pD7s9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:OElhZri0714n9khIq0G2eIJ2cF86VMKWETfop3zlbLVg7C9w_WxlBQ>
    <xmx:OElhZrAGUS5purR921tSYBtYRrZQb8-PNQos7jbMUJSih-Qyr6k63g>
    <xmx:OElhZkKVqM9UrVJA0fl-OPwpcmAg2QM6Lki4YOAWDYj3tZJI4pDQBA>
    <xmx:OElhZqBqVigSOkoxNFXB53WcliQMReyL4hrK8TZmGk0DNX6xQ_Dj0w>
    <xmx:OUlhZtAg0uCEplbkbyUSGR74d8ACtPQbzUyWHdTCz0eGer4u_Wz5G2aD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7ffdc90c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:28:57 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:29:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 07/12] refs/files: fix NULL pointer deref when releasing
 ref store
Message-ID: <6b0aaf2ac829fe2c223a7e7b6ea0d86732a6a0eb.1717649802.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5+iv9InFwlTWxmgF"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--5+iv9InFwlTWxmgF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `free_ref_cache()` function is not `NULL` safe and will thus
segfault when being passed such a pointer. This can easily happen when
trying to release a partially initialized "files" ref store. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/ref-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index b6c53fc8ed..4ce519bbc8 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -71,6 +71,8 @@ static void free_ref_entry(struct ref_entry *entry)
=20
 void free_ref_cache(struct ref_cache *cache)
 {
+	if (!cache)
+		return;
 	free_ref_entry(cache->root);
 	free(cache);
 }
--=20
2.45.2.409.g7b0defb391.dirty


--5+iv9InFwlTWxmgF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSTQACgkQVbJhu7ck
PpSV7A//T6wEKmnw/Y/4zy+0aPWNdAHHNVFWIJSDMal1m5Muk9JByoS9QFPAlc+8
T3Jngl9XFpJJNIx790+jtFRVdmirngVwc6BkNuihp6XgCQEaTVpYUIaO+9dZh6C1
bD6V5GcsfQrhKgKJd64eo7jMwT+TMWh+n0l2XxTPujQMT0nbPCetvXohgplh+ax6
P+njgn4PmTWFsiozFIhMzErbSDKTk7L6TBgs73XFxrPvQawQ9IxgHkBHE77P/uDr
OaBjvxRbFz4JOXjg9R2utsbRUzNls5SVUCpJV/jK7+nlxGN0FsrVKCFcG7M7QGoL
QS0fSVXq3sMZigkij3ZoqprV1PyZ5enWtph9ZjB/A1eBypBCbwSjrjKEX0mvH21q
Lr09zRieyytYulzRXuoVt8m9TRdDlx2d03cCiTDIPLWBte6s/diFHJu2Na/LR06d
ZKbzVw94f+FAU+i68v/JcFXTyzqn8w1CfDq3TBg75iAOscTFSg0Dh80QqfKh9csZ
Ql/3OVOuyprP6XGlhYSwl5HvB8k/s13jVLOv5od66sp/CmlHYVNiYesBYroQkGtp
gelY0ndCS0g+KlQIQzeDE4PuhUB17MvFL0IV8CyWkYdAbRKlFKmnqbxpIm8Ag8To
kwft5HqNsXBy2hK8plHQn901XUoJmr2dopQRNR+EavCijiOkeX4=
=rh5g
-----END PGP SIGNATURE-----

--5+iv9InFwlTWxmgF--
