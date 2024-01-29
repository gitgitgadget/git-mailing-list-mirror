Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6E605D7
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528934; cv=none; b=lYoF5qpJdleoOuyVsZc2G5LTkyL+PLfoadx242xQp0CGx7QHqbLz3hvisEArnqsrWzENiiODzQi5Dc8Ccn2BamOZv7u0xkQTV+RqR5tmewB2kU/1RdBljlPYTnTm2JhfqJ/Ps5x3bhosB1Nk7VNxcuLgI46PDXBa+LXGsUEMLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528934; c=relaxed/simple;
	bh=DW8EOiiF6SLDWbjlfYnvG9dydNHCLyvD/DZMqrRFYOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mO+l+twuMItN3nWKE3nXZARzIiLeXnZgFL6d7sKsFv5nnDwy0TdxRbhZxYZ69ED65+D7SA78pBrVod/6s5LDY4qC2D1O6xovJWqZv4F+0YJKiHVaCDdedO53nHNooEy134L40y7NNR8sAUf2vkZ1rOE83iXc21nzKf5WiJVq6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EWB4bS3x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y3BMO7wU; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EWB4bS3x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y3BMO7wU"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 6564B5C00CE;
	Mon, 29 Jan 2024 06:48:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 06:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706528931; x=1706615331; bh=sw3j2QKmNh
	BP2V+qOTLOS/flLZ4atp+xPLy+o6zzLFI=; b=EWB4bS3xX4LO1z987OMctzziiA
	N1TIYVFNiNNtLTpbUjpONcwUTAf/XGea0ATk0C+1dztHJQpaQlmJYXBTPBWCoGEP
	V6tpcsqEzmeJEVa//1O0qmmzbBIr5pJheZeAZtci8/FDDohsXarUA4OKPkPAF5xt
	RyMR5r5Ofp/Uy+KK4gMka0sDlTEbUeB/ATsC/3NWkzhBtN3BPH7JwQAQqgRYB+IR
	EG67ug5cjqUn/EY/MnPUuSYWQ71DbWqFr8UKhLppbZLdeHuxhCqP/Tx3naWrb+Gl
	re/KQQ0Xz+0jq/yxzFGKppImDJWQTeNKGUkapk66/n+G6KyiPhjSXK/lew+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706528931; x=1706615331; bh=sw3j2QKmNhBP2V+qOTLOS/flLZ4a
	tp+xPLy+o6zzLFI=; b=y3BMO7wUwMpmwIj9X+72XjvPEIOTk5A9rr89wv+HSY5+
	7nxuGNPLFxxuJmG7RwIlBJ4L76wXZzISsXvAzotjjJfMxj8aAvCBiugnT5jRJX3C
	e9yjN68SNGdKv5UJw1BcybhWPBHiP+kgQgVXWd36T/Uh2Muu7jefVnOzbIoPD559
	h2HTN/7sXewxI6pVrN9+roCMuzzPcOQzdq1rqFiP7oiHW+Lx7qfbyNohf77iBScs
	CiyigpX3Q3GdoNaGqLHtoD0VcBGlFPH4vx4rx80RHJ/4nr6PKHi1/isY+Tzt+Ih9
	rme4UYD6pps3hWNrjpcBCAKV0qlzxJe7fdz7GgnzJQ==
X-ME-Sender: <xms:o5C3ZfQFqHGJh2TukGFEpv3E9XcqFPmaSu4aeP6R0D_eKAYs7R1p9A>
    <xme:o5C3ZQzdybZWi3lIkaGyQuuR4qBXZuFB7hxjMJHSApjDfeD2FF6I7FRxOJ9BaMy5H
    0i4rzPE4oMFpd7KXw>
X-ME-Received: <xmr:o5C3ZU0-_FbmcuLPwzNbbX9ym6YHuzG6tuXq4kMrJfTOOIE4XF4Lh99XKu6i-IGUPkvB5yvfkxY5RS0BUzGmk-1QiyfzRJy7hPb4mo-oD6vNCiVlWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:o5C3ZfAgPyPSKhiHAIYXPGu4AWo6cWP36V3sCiDI5T5QFFI1tTUEUg>
    <xmx:o5C3ZYhq_HIbEk5DxK4X2ksHmIKGmMQtjmaDbZ_G_Tf2EQUT37r6Kw>
    <xmx:o5C3ZToodmMSywtnTEQMhHnWycbOXe9WIb2iyVL6K8PIiuEpbNs2hw>
    <xmx:o5C3ZUZan67_ULokX6xNmoOrOWd5TlGf9XBk5v2ns4UDOKhsMOF0zw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:48:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 541ef646 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:45:33 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:48:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] checkout: remove HEAD special case
Message-ID: <ZbeQoDh_MPDDufk3@tanuki>
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
 <20240128181202.986753-4-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MdzXLGLTc43+ZyYs"
Content-Disposition: inline
In-Reply-To: <20240128181202.986753-4-shyamthakkar001@gmail.com>


--MdzXLGLTc43+ZyYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 11:41:23PM +0530, Ghanshyam Thakkar wrote:
> run_add_p() is capable of handling HEAD in any form (e.g. hex, 'HEAD',
> '@' etc.), not just string 'HEAD'. Therefore, special casing of HEAD
> does not have any effect.

Are there any tests that cover this behaviour? If so, it would be nice
to point them out in the commit message. Otherwise, we should add them.

Patrick

> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
>  builtin/checkout.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index a6e30931b5..6b74e5fa4e 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -539,12 +539,11 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
>  		 * recognized by diff-index), we will always replace the name
>  		 * with the hex of the commit (whether it's in `...` form or
>  		 * not) for the run_add_interactive() machinery to work
> -		 * properly. However, there is special logic for the HEAD case
> -		 * so we mustn't replace that.  Also, when we were given a
> -		 * tree-object, new_branch_info->commit would be NULL, but we
> -		 * do not have to do any replacement, either.
> +		 * properly. Also, when we were given a tree-object,
> +		 * new_branch_info->commit would be NULL, but we do not
> +		 * have to do any replacement.
>  		 */
> -		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))
> +		if (rev && new_branch_info->commit)
>  			rev =3D oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
> =20
>  		if (opts->checkout_index && opts->checkout_worktree)
> --=20
> 2.43.0
>=20
>=20

--MdzXLGLTc43+ZyYs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3kJ8ACgkQVbJhu7ck
PpRwKhAAq+mDDja2FvDDfM0zpHaIRNcyCwLcG4d1PYDgwIiWFy1G3QY0w8oXBkFJ
WpKo6/4+l32++Xm9kkCm+5UJKxBHz8wIHOoim9kgP8VE/cNX5d6iNr1g0oZQrHKI
dIxwM3BntxCGqN6yVzah3vVqtwa5t9NDsTB9Mdy1vJbqN/jfzDo/pqXmEl3vHYnB
Gtz/r0iCwQKCyGYBXVTVkTu/StfoCjy1nnWDuh7w9NLWx7LHI59c+JuNOgqDGf4X
qtxjNq8xmOrsVtqodVwO+teRmhq3OYNmhOgbuhMrqxJsQx+UF8HtoOlB0XKR+sIS
TuSV1NFQ34gyvD+x7Z2oWuth5rBjJ+eP9Ny3HTszdxhYHn/4QKbOxkIj4SNEskLA
qIjodbTY9Y5wzmf7imQZmpq7AD7Q8VOUF18pEAw9wlvOpMS/Ssc34y3WNzDgfz2T
NX9djQyyWfuF77ZenoXoAizAcYz9pu40ATFyJ8X0ap7EzAgZXqxDejFU0rtkjYoR
7uHoZ9WpRY2s6G+gvFotHxpRiNwJvaMYS9CJDokbbiaRS4PmBpVaIjC5BA51mUoK
jVyirFd78AmY28E45tSi2g+QUbra+I553izZeX5HC/p91RkfsEyaHWJk9CMP0eHS
aCjOL5RYCDyvrzyTbrGfcrf5rCUxmn9G2WlOVke8nciFjElU4Ms=
=ce9e
-----END PGP SIGNATURE-----

--MdzXLGLTc43+ZyYs--
