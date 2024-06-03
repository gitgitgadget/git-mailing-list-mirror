Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7FA129E7D
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407046; cv=none; b=kZdxYYjxmiXVT0s9a6MvH8cUUm4+lVU86/xP7KbdXXbm4TC1SUGz/ZlhSTN9KTbk/c0K8pfz6upWnvtlpopVutlX8qOhDcESlvzVJZHWNawV0VnacHwCuCyja3kOq3PyTEKHG5y7DryJupjfmY+3sA6TzgZ/4QCGtBBhYBxd/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407046; c=relaxed/simple;
	bh=HAbBGoCrTzLWDSoHqrUwgvdIMpihJiEoSKiCW5NBj30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EggYn079OaeR4ryM0HBwUGi8KnvVmuu6naq8cLCV4fP/WjYMh8vtoZ2t9gRIaCWI7Fb5SCpx258FCO65nyUYIla/F4kVuALotpYMtxRGrgcwjH5scFlNs1QDSL5JiKQvVDWcj3ZYoSufqf+l3qDuBjrVYeF3QLewqMRCP9uIpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CXaYhWLo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffqiwkSX; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CXaYhWLo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffqiwkSX"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id ECD731C000F1;
	Mon,  3 Jun 2024 05:30:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407043; x=1717493443; bh=+VIjeN12Vf
	CYsi6OQMnmB6s76PVdeppv5DUg8dZperI=; b=CXaYhWLo3OFTJOwoYzYmAUgdL6
	3rWzLUXzsPMoK2D2x6QBYtTFMlJCWU852KHmDMLIId+DTxrcoB+mLJv+0OunX9lO
	Y+matSCISrQzES9MRR59senfh3lOX0GO0rqcC0q2fe9dAnVL4mMxVAmi9wJVNwx3
	GVuJuBTzJaIJ7nfJeQoNOD7gPhRNXjdfdJ+93JpqdyWH6eYss5W/7BAgymtGfAkm
	0jgPk4tdXSG/2M4qB0kuaSnIEtKy6Hxk39HVtZsEFZsJ54gJ6QOVrWKEh0sPDDm2
	fc2/z2WFb+02fkQfMWGRTVfkFJ/rqJoIqiP9ClJ/JJBdK7kpcB3gGMeCAyqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407043; x=1717493443; bh=+VIjeN12VfCYsi6OQMnmB6s76PVd
	eppv5DUg8dZperI=; b=ffqiwkSXEEIMDi2I0Q4KsgmHmF+XUZsgMwcoLRBMZnzR
	+kM6SVp1snzur8jS1GYdFWhTcNVHvtadJqXk8/Z3SJ4kgO7C/K5xIUb+Z0SMO0D+
	ue9g/BoT7/tCxJNq/Q1Dx6PCjFJDGrW2EqCuzBMF++dJkaMQMYvOQaKZD+mVcydo
	wl15ZAt3sDsGKyapPgoapw5Y1CVk7SesOIzZpHVsR1A39nMGyP+ivc/S+75zyqMy
	DYAuvUjLOxwLx0WkMBdlLwIsx1UJe4fB0B0WnJmKslzERUN1wWXXuGZvf4OvX8Q/
	EL1pBljMKyfFFKOJKk+I+qtd8VwtOZycCYd82SU8Hw==
X-ME-Sender: <xms:Q41dZnY66YbdOGJ1bGFu0E0UVJ8UZKCXS1H8OMUAQBzG8gkax2Ifyw>
    <xme:Q41dZmYEknwIDORyuxryZM8dEScM43fHtxQfqyqfEFH0ZE--vTUR85RGrntjKClaz
    uEXJ7qFaeZ9O1ZQHw>
X-ME-Received: <xmr:Q41dZp_bh7MVZdJRozYmXKRg97hGW3TWCXbcVUizLjBHrlfMaUjl9pObfmZ8iarwjVm9n3z-qquf3rZ6v6TbDtncacFl43Ffh5_Ehb5nqE78W-5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Q41dZtrIoB0rYUQfY3OFEmA3LDH_F5VuXPdbcQF53ochQTU_H4qtKA>
    <xmx:Q41dZiolJYPEJ8V_DJTk_SUQB1st0TqbiCkjJHXXwwajsH1zISrDAQ>
    <xmx:Q41dZjQr02X1jFBEYftmw_i4S7gssNN91Bt0xUInDcR9MWjsQX-PUg>
    <xmx:Q41dZqquR3KD7qA6ZKf5NJG_FCYRu4sPKhja030LMhhvJNvKfCmLIA>
    <xmx:Q41dZvACP-hsJJ873flED-6jNJwhlZ-EXqm6griEqjpTRj-82p4-D-VJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:30:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8660b339 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:30:18 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:30:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 07/12] refs/files: fix NULL pointer deref when releasing
 ref store
Message-ID: <56baa798fbb2838227fbc08ed54f200e38545d28.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UH+AMbmpHZio3seH"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--UH+AMbmpHZio3seH
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
2.45.1.410.g58bac47f8e.dirty


--UH+AMbmpHZio3seH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjT8ACgkQVbJhu7ck
PpTgHhAAhrQt+QcEHUFnPnv76/tlFNwYscl4zpczhP3rDuNqzQWq9B/Eqy9lV7Wn
HUMaKPwFzYnf8iMSxvlxExMlKqRknL+mnnhpizL+eF0v7qHEKWAnEA53PbfYQBek
mWmfVWZ4Md9WH5t0GFbycpt1SqiMEZ//MirVYrG80pw6H6h7AmsqPykW2GrDKQmx
JvEhV7zP/Y2vxY9wZt48CKHOtSK1pLByAyeHcZJZv3AdFcj1tC7j6mQ2gZQCH2/p
DfEuaPx1yOgYfC5rJnJGkplrf4l7S0gBAqVFfu1dCEQ4EXtuaDTg77vDJ01K0Uuw
YISQXADnZuNgEtdJzht9EwjaLlyxMFTRCmSQz9ZzTcFmNz+VcpHjLPdERDDCu9pb
D9j3CzuJxWtb2fDTaiSfLfc7HMRlId4VHD2ZOaYTkJDqwwotVcw+nSNq9xjEBPRf
k7RA0TRct0UfmtybhwdySj8LUa9gxNraOfKiCB+NPIuywkOTW5DM82JNbCwMdIKp
uQdljLnmy1Ki/V84tSMC9OercvK50MQufY+ZPRZ4osPiq1Wnpr12pGuZnWvTLucX
53ZvEkVrNCkxPXelN2BWvDfsbcKH1HyMNUYCV7jTAbrloEKJ4LyOEYRsKjDhtPah
7uoul9W6hRXyXwPyguR29NnnjsZXHZV/ammgfhD0qGUXamnNPnQ=
=fqar
-----END PGP SIGNATURE-----

--UH+AMbmpHZio3seH--
