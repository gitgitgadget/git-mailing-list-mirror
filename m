Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB7B15FCE7
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634587; cv=none; b=kEIFoLVTkjLsbeHIcE6y+NKxwkCGqM18SdI853ikzXsjZLRo7sVarsMlOYulNNrqdo8A0s7ieuuOW8mkztvDMhdVZWNc8XBIF+6OaDFYqVEY79h7WvtGHJz88V629mRP5+06DswRJA8bhz97VbxdujxlPvNUO6qvkqUte0buhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634587; c=relaxed/simple;
	bh=vQunsKTn0brbF8p0ROPLeB9lsXFYezxQXz9wBLA0GLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLjB08J/y8M3QEfGPYvnK/Hn6kxLWv052/Fxw8I9b6lzD/asxNGy+vjkL1TodoJ+MzzcciJ86NRkQ6G2K82ChZw2TtjYq67sf2/DfmDWYtFWHPNDFFKSMdLlNy5sqG1dN4w4hg8mLw7UA3oSUWdg7fvgYo8SaSgB1SUM3sJnaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mkJjJdpy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7Lx5hSQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mkJjJdpy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7Lx5hSQ"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CE2BB11401D4;
	Mon, 22 Jul 2024 03:49:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Mon, 22 Jul 2024 03:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721634583; x=1721720983; bh=Q4uk7X3JwV
	Xo4daCx1UZPdJoh3rYo0KaHVnAczwtrfQ=; b=mkJjJdpyvaCWqYp1XMsL1Foeea
	Y8i2JsaBO65tXjDnXac+xqVIGCIbKsg3KMK5bGm93IJO91b7TA6L2OkFKM1hTBxD
	DrijFgs3vUuM079+rlfklZRflrQG+AhMBk9+eXXAEwWjsgiZY+3HQISSVW8A4ZzI
	mqOklw+Mp+wjEeiYCwnJsURYZxOfgDXEIxYTik3ypXD/WdzKIWtHRWgmCmtOOI/o
	i7uJOhfHMW9R1m2Esw+5L9ps7qms1GxlgLohuHLhR0P1wMUV16Rj7zEYoX7f1F/x
	whN7+RPCVcqBLmNrb7sO/0D1bRqSlPmUrjCpEdk1rX317gH8n/i7UTIAFzEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721634583; x=1721720983; bh=Q4uk7X3JwVXo4daCx1UZPdJoh3rY
	o0KaHVnAczwtrfQ=; b=k7Lx5hSQVqCwstqHhkuCcXbjCG5xxci1n6QZqrINC67r
	0mh6phGhG8gUJjjiyaOTz3BD5c18m+iwTCQX9fXz+J23mLY/aqwhsmJhI+SL91rF
	AL6iNxIt8bBQLOvKDSaNezpvHD32VCdz48q7ScdKZP7vBAMI/aMem7YHUvuDiWoE
	YnwfMK03fkT+mDhRBYPYto0JTGENe63odMd4LqH/TlnRuTdZuRwa6Ibe/ZKAksTl
	jSmHwIJZvbY+rg/w/hbzWV0G5NuwZRqQk+Jqpg/NiS6QzDwq7n2hSI07W6CUW+Sd
	rNfeNoCWzRELdSSj1hY64JzBvnLYa5zHslNw0Ky7qQ==
X-ME-Sender: <xms:Fw-eZtst87kXlAOuUBAfhF8y0Bd1mdiIb1SHgaT2G-CVZ7h4hPuNDQ>
    <xme:Fw-eZmdklx_t_D5-xIlDCuqs9rgqtAs22Kp1dKXWMxUZqWEn9oL8TPZIouE8ssoYN
    xYxNWLsW-tiy7xM3g>
X-ME-Received: <xmr:Fw-eZgyi_k9wM6gPXQt7lG7p0esks_5354YVLqkiwRq-TqH8BLecOjuKYcNImQsaSm4aUgngzwZRpBRgagY53BmbUxZpR2_wV1vySkcN5qYTr1wH9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheeigdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Fw-eZkMz9eTHJwhWUxrxTfcNGOlMpPilYYLeJ-y2QKt5JYU3iGYvFw>
    <xmx:Fw-eZt_JfGDQkuWfU_HKqSw4FCasxoaq9s57R_otDVuWnhTSPxIhkQ>
    <xmx:Fw-eZkXq-i4jEJrlGm-lRBRnDctMzlJsC30uCm7vOzEFCsO2LUPokw>
    <xmx:Fw-eZudOia9dyh7rx13U_Ernz3KI3dLPynkLP4K3tzQvF_IWVclRNw>
    <xmx:Fw-eZvKTfVyL9Y9JEdBDF5O16RxxKQHihnABLTTz1nqqRWyOxmK_igJ0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 03:49:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ebe0f748 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jul 2024 07:48:28 +0000 (UTC)
Date: Mon, 22 Jul 2024 09:49:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation/glossary: fix double word
Message-ID: <Zp4PElBU1kLwLpGY@tanuki>
References: <20240717105432.2801097-2-martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="huy/Ws/5ZHhoXowx"
Content-Disposition: inline
In-Reply-To: <20240717105432.2801097-2-martin.agren@gmail.com>


--huy/Ws/5ZHhoXowx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 12:54:29PM +0200, Martin =C3=85gren wrote:
> Remove a spurious "that".
>=20
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>

This looks obviously correct to me. Thanks!

Patrick

> ---
>  This buglet was introduced in 74b50a5881 (Documentation/glossary: define
>  root refs as refs, 2024-05-15) as part of ps/pseudo-ref-terminology.
>=20
>  Documentation/glossary-content.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-=
content.txt
> index 30b394ab47..42afe04869 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -550,7 +550,7 @@ The following pseudorefs are known to Git:
>  	to the result.
> =20
>  [[def_ref]]ref::
> -	A name that that points to an <<def_object_name,object name>> or
> +	A name that points to an <<def_object_name,object name>> or
>  	another ref (the latter is called a <<def_symref,symbolic ref>>).
>  	For convenience, a ref can sometimes be abbreviated when used
>  	as an argument to a Git command; see linkgit:gitrevisions[7]
> --=20
> 2.46.0.rc0.321.g44c27ab58a
>=20

--huy/Ws/5ZHhoXowx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaeDwwACgkQVbJhu7ck
PpRSNxAAq0GbXChRRtHVs5dVqeAc4GvOc4JGo8KiyA8nWrMSKCfM9mJ6KgeMyWcK
9Gt+KZ8/4PApJCxv0FPNzVTLuXO9g4M/UTIJQ11KterTVbF9G+nAKeIJgYW6ZkQI
S0Hw/ritBqMQe9AupkSvYpaY6uyUNt+J1vJr0wlMg3qLCftOmvUul8euaqyEp7di
qJZWrVjK+W8/Kz6DTkXCazQnndIR+24pLjGGOc7WuS2gKA4SmxsCvlRVqQHPW9Uf
2ZxClofaXvWNHP2mI1wakycdPnk2idO1l9ZwvdaXwC+mjzX482sJpMmt7CGu71n8
bDU8IPzRtetf5X4XB8Tn2SHy+e2rGMmfSWhcHKg95g0EBgVe76PYH/HDd8yfcYyv
cZyv+dwy65VICEGwOtSyFDCv1r6C75+BA+Yhq1GGLP74bCJSoKA+5yG3+DaBCYpC
FqoY6T63VpuMV3l7jb3xLV4l5BdXs7dBwNGi/FxVWY2QByeRwuWyMkpgueJ2EKZG
xylzLzC9b725hlSoi7q2QvZ7NzRbDK5mvAKwjejdVfvahl1BTlI9m84VelCPvQB3
QdSeIZmTZJieuf2353Q702xnaj7rRmUpC8UGXVovAVt2NTmr3266B5P0dF4u6zVS
53WV8UWqHde4sjZzK8d50I66ifXTqzwgVYlIcsFD5s9D0ArQ+dY=
=RkhA
-----END PGP SIGNATURE-----

--huy/Ws/5ZHhoXowx--
