Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB162E62C6
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718716; cv=none; b=G/+iM/K00uJFIQ8URJmRJdloi80EVrwFqvH41i7vv0KAvibzwj/ARS8oNhNfBJ4eldpCtMd9YYzFebmfg/2/r1ox6H44FNndGSR5rywiiH6AV8BjBxpn2N2tMTTA4QGps/iBHNGSL54b2QO2VvFnGVBil+mxLD9t45eJa8tWCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718716; c=relaxed/simple;
	bh=3n2MNTeVE/QGnClaqQx07mP88OuxcBbDy2rbi0tjuuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7dAlBGP4unmoyM6RGBBD6Tp20sv3lHUL6kyE/FTdwa7ZD71JU0IOKjjPtlMgQF0geN1XyzZUzHYnJ7r545JZ/T/H3vxgRdLRe+nhAAcYI+6WsAWk8dIpfYXzV3bygD/Vc7vk/+7BGDbEft7D/vgdL97/Bl4DYKnbLfyu8s8JBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=iFqCVgWk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iFqCVgWk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743718712;
	bh=3n2MNTeVE/QGnClaqQx07mP88OuxcBbDy2rbi0tjuuc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=iFqCVgWkYohGSRdBJsWxUI4w3DDnaS90HGRHE3PsLsCWPz45dqoxszNCmxA2pwexA
	 yDgLTNjvwD531Mh1e1d9uaTPK1fHnjfUVtfPA+/VlAUbJrzkC92oh5bM93vs+KuKko
	 JM9+7IBiz9/IEEtTIFHNPSx7Qvkp1dC1v2r1tK8XdhAhNOjfK/2mSYzVOe2KM2Ejkq
	 iFqwHO0YB0glWcZuTWWRI0cWTQNDMRO73TpoVFxKOu7xmPVKE2XNgSkOIJNREaJrlI
	 aT4sUlFwpmYza/GGP3qeR2TEpWSgUJSf7DPoiauqFA4sMNeT90gK1ezcuXgK13X4Yz
	 YqPS25L3NG7TFGuIwmjbX9FVUFR5JR664+xp0chqFyoqyU/bAECIec1zbh7a3lw79M
	 /ICramiO5Lfeu3AniYAhhRWGLaW7a3YGMSTR36CJkUgdeBJtO6L+AOlI+C6f0/jcnA
	 EY2MsdBlVFe/veTVYBPs3OyW/Td5WC9+1fa/bNVxEHx3HVNOrgB
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5DAEB200BE;
	Thu,  3 Apr 2025 22:18:32 +0000 (UTC)
Date: Thu, 3 Apr 2025 22:18:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 14/16] refs/iterator: implement seeking for packed-ref
 iterators
Message-ID: <Z-8JN5ZXrgACgYvN@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
 <20250312-pks-update-ref-optimization-v6-14-f778e0414f55@pks.im>
 <CABPp-BFBqC_t5QSexRQpYsqXBa11WK+OqGt167E=K=xod=buQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sINYnUmyEuz/oJBN"
Content-Disposition: inline
In-Reply-To: <CABPp-BFBqC_t5QSexRQpYsqXBa11WK+OqGt167E=K=xod=buQw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--sINYnUmyEuz/oJBN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-03 at 19:56:39, Elijah Newren wrote:
> In this case, the utf-8 characters will have individual bytes whose
> values are greater than 127, which for a signed character will be
> represented by a negative number.  I tried tweaking the loop to:
>=20
>         while (prefix && *prefix) {
>             if ((unsigned char)*refname < (unsigned char)*prefix) {
>                 printf("Comparing %d to %d\n",
>                        *refname, *prefix);
>                 printf("Comparing %s to %s\n",
>                        refname, prefix);
>                 BUG("packed-refs backend yielded reference preceding
> its prefix");

I was mentioning this to Elijah earlier, but I think we might want to
use more emojis in testing things like refs and other text patterns in
our testsuite.  Because most of them are in astral planes, that will
help us exercise our UTF-8 and UTF-16 surrogate handling, which is also
relevant to a variety of languages, like Chinese, which we obviously
want to support but which contributors may be less familiar with.  Since
emoji are more universal, it's easier for anyone to add a test for these
kinds of cases and we might be able to catch some of these kinds of
things earlier.

That's in addition to the fact that many people use emojis in things
like commit messages because they're fun and we want to make those work.

Next time I'm sending patches, I'll endeavour to cover a wider variety
of codepoints in my testing.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--sINYnUmyEuz/oJBN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+8JNwAKCRB8DEliiIei
gfzHAP9sBwZKpPsm3cWTA5P1DXMC8LVpA401U9mT52EPbEVwiAD/cN29gh0yVvMT
YFLX8p6S2gUUQwb7yIS8I76p6/UFXA0=
=KPAC
-----END PGP SIGNATURE-----

--sINYnUmyEuz/oJBN--
