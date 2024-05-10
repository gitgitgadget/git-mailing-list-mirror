Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7399482D0
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324421; cv=none; b=S0KTN5Ge091KyUAE7FbwAndztf/kNkx0FEY7L16wbeLL/pCLIsUEPpJO6kYbZA9UYLzJ/Y7+Aiql0bFFY/EYE4pIEPlf01f+f7DCUKIllWtI7WCx4WyEbzJGZd8MY5dR/G/4JNsT9QiXoOsnrC+uNBrKoDWc4JkZJBijWLxOiGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324421; c=relaxed/simple;
	bh=T+Wuw2D2d/lc9jCakawxNb80342cP0N48K7vtj0p4x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz+bbwF1bbH6K4uBVigUE8/fHGNZuknO5PCEil5lsWt/KDQkmvM9EFHiB2bVg+SyV1g3MfTZDaIbpLHUzB9v/NPLg9X94PG+O9T2i/DoEjHKJH0Kob6O7yWvRoVwpyrO/0Ekbw7/Z3oMwerLiYo4h4IDfOS1xMd9R2GIW8IHYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=usPjr31J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KUbf/Gnt; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="usPjr31J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KUbf/Gnt"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id ADB0B1C00123;
	Fri, 10 May 2024 03:00:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 10 May 2024 03:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715324410; x=1715410810; bh=JlsfSF5jLw
	GfmKRxX1In1c1qWNCr76LiTli6Qgao1JE=; b=usPjr31JM8sq+ww67VPTYFs9df
	T9lI/yb3CZmkYlRfYFHTEPnyKEFnMpSA5gM0TN+tSB8U7GsAtJRFc6MYZ5CJHkgY
	jbtnp4e8mK6TcpMEcXa80obR5+g1HeZAjEv3qLGjFrPGUYpnOYejkN6ch1Vit82W
	amwBKzswzPhdtoI9csKv06WzV3JN2RWbMgYPXj0Fvcq0/jsFTb04S1V+sElpqmwt
	HcT8sBDHaogSNcblC/ilmpdDma4m8nDjNQUrELyigsR96nJKqVgG6RiVLCx6E9eM
	IU+KKxvMwjCa/G49xN44yw5hAMY6d4LU27hVGrhKp2pbNzJK2XoiJrvHghdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715324410; x=1715410810; bh=JlsfSF5jLwGfmKRxX1In1c1qWNCr
	76LiTli6Qgao1JE=; b=KUbf/GntJCqy35WlAOCtGwSKX/NCbr4e2dGr0HSlRbY1
	NIKcmxMbb7Ofh0OPkVK0FgmkbDk/zxVLgECnDfqJEK5ipwhYeMf21PnAoRNwsGpB
	EEZFQOFKrRfbzIbS9X22UlGyiaU3+iySEq2kbBsKzrKfbqjYeO5QB6cz1igPI/ZR
	mk25TdBpOpaG+Ag3d62EHvW48ltRPu6ckDJpd6+ZPH/cfjjEuRbJ0HKkYgmREH+Z
	3hRn9CmCaNIeAeCmVlQy7b0QbNLpFOaK0sSkrfk8/ucPwJTdnp4vlbXuMYgM5Nc8
	TBJSDlExzKgNyfIjZcqyRItxPOWZ5ktGrN2qvwpa+w==
X-ME-Sender: <xms:-sU9ZoGFkExji-eVoJtsi6EMk5mKaUG3aiwilU8Vsc9Eug4yGC2IPQ>
    <xme:-sU9ZhXaXKrm8gCuvK-63KWxQbbiyQsWYn-bzHCJvWD1z5R-UBMe2k3d1FFWyDW7w
    MMwTIHya63D5aeMvQ>
X-ME-Received: <xmr:-sU9ZiIRNC6h66zLJuXiZk27nrYNzYvuVygLNIqcXrxoBaZKchUUJBt4CYCt3mhNFc5NE5__YtFJjPZ34Owx0DfOFHv-jUbCvPdLCnFcJz8oSxCtmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:-sU9ZqFDy__Brx3yJ46U8Xn53ELIklFbjFwOOk06R9fnbAjVYUQlQg>
    <xmx:-sU9ZuU1_rrY8naKUYV50LPiMaQaYv4_ExsgwQR1_UFKsCsxo6CM0g>
    <xmx:-sU9ZtNMq8jyPyIqB34M4I8xlOkoOUzFLGzTcRRQDluH_zbrvGHirg>
    <xmx:-sU9Zl3ZFpdAXSm3IAlVprqjh4kJeJon6s6ogMaDrcbRE66Z79M3dA>
    <xmx:-sU9Zrg6IsDtNsEpfjJIW_e5qhm3KwwayLTf-2bsXaSNt7vWiU1f7cmm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 03:00:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 68cabc83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 06:59:54 +0000 (UTC)
Date: Fri, 10 May 2024 09:00:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
Message-ID: <Zj3F9EVpSmQtyy0R@tanuki>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162544.GC1708042@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LmvLH/8V4S0m77LZ"
Content-Disposition: inline
In-Reply-To: <20240509162544.GC1708042@coredump.intra.peff.net>


--LmvLH/8V4S0m77LZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 12:25:44PM -0400, Jeff King wrote:
[snip]
> I'd like to report that this let me get a successful CI run, but I'm
> running into the thing where osx jobs seem to randomly hang sometimes
> and hit the 6-hour timeout. But I did confirm that this lets us get to
> the actual build/test, and not barf while installing dependencies.

Yeah, this one is puzzling to me. We see the same thing on GitLab CI,
and until now I haven't yet figured out why that is.

>  .github/workflows/main.yml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 5f92a50271..13cc0fe807 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -285,7 +285,6 @@ jobs:
>              pool: macos-13
>            - jobname: osx-gcc
>              cc: gcc-13
> -            cc_package: gcc-13

As far as I can see this means that we don't install GCC at all anymore
via Homebrew. Does this mean that we now rely on the GCC version that is
preinstalled by Homebrew? Won't this break every time that Homebrew
changes the default GCC version?
=20
I may be missing the obvious.

Patrick

--LmvLH/8V4S0m77LZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY9xfMACgkQVbJhu7ck
PpRfwg//aDj2FfYWCewtvJ15u2hoAJIhKEjimu8uCAVMuYQWpmEtM6y4J8X1xKQV
Z9GJItGN49JNybI9B5RSscaJhBLyI6WyoJxcwbJ0K9vcZfw2SJBO5VqMHK4IiL2q
4wsJhfxA807VBG/Ae8YtL5kEQgRy1rFSzPa2l5Px+VX+1u+Z9q9ghGhHngt1uS/B
+cEGnXCcYBLwWi8VlofZ3eBYelGwjU9t/9rG2Bz2tMODTGgMSyXFEyHRKsR8IgJ6
GlP9fN6xVaAK1tq1tO1e+gFouoT8uS+3oCF1cqj5L5KmMcshBPSqz8G7xSM45Q70
J1ngGvBUkmXUZfMX40FuamIG7v53tZe2cCEV0HnqIvcVD+AnVH7YIarbbP5PSDc+
hDFuR+/ZAJXIKAWrVVGtifYDeEQjaPZ0oCjaS/McHTUt/5GIC5qNV0408Md7hZO9
URgIvj1oMioJ3DzVE4iQ2Z7iY1CJBFQitxXDB1XmavocpSECrRiJitckWJeW3Rlf
IF8LVzfrzbOCCGYEmIOaJzMNQvsMzXPJ/LYYSCYZI5U2lb1opWANbzO9srKrm/+S
PhOD5o6yuXvpdy1MwJHAiu14BrU8JkGWsYNwy9ZyoJ+aGDwYQ0SyEvI6XEfdnmvC
nddW3OLfoQtbtNZOQdT57StrZW2NIpXYdO0pc7JM8aEaL66udfY=
=lyeI
-----END PGP SIGNATURE-----

--LmvLH/8V4S0m77LZ--
