Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911212BE7AC
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417427; cv=none; b=YiWpbcFMr//TpGZNqAcUm1R5FuLFXKA3PYS8KRMM1+e/2rfbfTAIcFB7tCtgsXRInCFBNnhrrOee5OoruaUVseI5HCJ8BWrcRGaEssekPmLgnelcvAirwLQRS+r4AV5frkQML0dWYtbvgTjyeVjKRh01lbYjCxgjS8hM0xLpOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417427; c=relaxed/simple;
	bh=8pnqTXrXI+1Vt3PkPQyREodWcdEG8qDY51GE3Xdp8+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTnj6WDpqmYSk9QkqNamA8rlj2BUKC63KQ7pnsxb4p/I4BYXQCnAP3csbrmzrcxXLGMEGU259iJi76mDlgDjp1chpLfHhKoTXVw+Ad3QE54IwstDZ437xKIF++Q+uovchpKy2p2xR42cxBDxTEDMb4EDmv58zfxRJc8+nE+otjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wjQv7Z7W; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wjQv7Z7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756417424;
	bh=8pnqTXrXI+1Vt3PkPQyREodWcdEG8qDY51GE3Xdp8+w=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wjQv7Z7W7sgxnkDwAnphITgkscUuUs++xwRAeGggeiy0SpRNxMNPVTeVb/gEWy6N0
	 4nGW+JpMCgASsG47kjuJLo0qVuDkGOLxw7QvhGBD1xpyge8PcWpMxzlb506frLy+su
	 zDH94zAjLykGQF9zaWvu1V1uov6kwTmM9NpEUG3wthT21rpaQUPGLyd7TUmvn5F0Sy
	 xktsx1dqebliupTV7PJL/kswQKHaHG7uv5Po9KOtUdh7iBy2LlbqJUMMCTtpr8qvfi
	 Z8NrcCavIoUCF9EYiGwCrKwqxltE1c464sooB84p+ioVSy/YfhWMLBoUpeoNqKMwXv
	 EESp6GGi3irBP+E+gvqtWKpYmY+74Udy/npYnFk/++8hfoYX+3953H3JofY8jZVkwA
	 f6VaeNiM4mVhbntlZUI8dvCOPRr7OqcEoVrvmeNR6jIXc03ASmDXnUsnCknOjCRS25
	 7Ocmuyk7A9ISVSwieJAmymgtCtDSCVhKn6XzIbWBugFIoDqbs6/
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:db8f:7ecf:23e1:9783])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A620A200C5;
	Thu, 28 Aug 2025 21:43:44 +0000 (UTC)
Date: Thu, 28 Aug 2025 21:43:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Efficiently storing =?utf-8?Q?SHA-1_?= =?utf-8?B?4oaU?= SHA-256
 mappings in compatibility mode
Message-ID: <aLDNj5GPYA9nR3xR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Wong <e@80x24.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Nieder <jrnieder@gmail.com>
References: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>
 <20250827190817.M36986@dcvr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qN1oS5u3m/dA0yE3"
Content-Disposition: inline
In-Reply-To: <20250827190817.M36986@dcvr>
User-Agent: Mutt/2.2.13 (2024-03-09)


--qN1oS5u3m/dA0yE3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-27 at 19:08:16, Eric Wong wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> > TL;DR: We need a different datastore than a flat file for storing
> > mappings between SHA-1 and SHA-256 in compatibility mode.  Advice and
> > opinions sought.
>=20
> <snip>
>=20
> > Our approach for mapping object IDs between algorithms uses data in pack
> > index v3 (outlined in the transition document), plus a flat file called
> > `loose-object-idx` for loose objects.  However, we didn't anticipate
> > that we'd need to handle mappings long-term for data that is neither a
> > loose object nor a packed object.
> >=20
> > For instance, with shallow clones, we must store a mapping for the
> > shallows the server has sent us[1], since we lack the history to convert
> > objects otherwise.  Similarly, if there are submodules or we're using a
> > partial clone, we must store those mappings as well, since we cannot
> > convert trees without them.  We can store them in the
> > `loose-object-idx`, but since it's not sorted or easily searchable, it's
> > going to perform really terribly when we store enough of them.  Right
> > now, we read the entire file into two hashmaps (one in each direction)
> > and we sometimes need to re-read it when other processes add items, so
> > it won't take much to make it be slow and take a lot of memory.
>=20
> This really seems ideal for SQLite, which has come a long way
> since 2005 when git started.
>=20
> I really wish git would've relied on more on existing formats
> (e.g. LMDB refs) rather than introducing more one-off data
> formats that require more cognitive overhead to document and
> learn[1], especially when SQLite is extremely portable and works
> on tiny devices.

SQLite is not an option because it performs poorly with Java and we want
our formats to work with other implementations, like JGit.  That's why
we created reftable instead of using SQLite.

Also, in general, I'm not interested in being tied to a single
implementation.  If the developers of SQLite decide to dramatically
change the license of all their code like Oracle did with Berkeley DB,
we're going to have a problem.  Yes, we can use the older versions, but
we'd still need people to maintain the library and update it.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--qN1oS5u3m/dA0yE3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLDNjgAKCRB8DEliiIei
gae4AP401jauDL3eRIzNZYemP33wmxqgdCqyrpi5aZhcwpHEeAD9FdbXp9wuTcbY
Oa+YatcNypAKZiX+0UuO5dx8dFUgAgo=
=pUQz
-----END PGP SIGNATURE-----

--qN1oS5u3m/dA0yE3--
