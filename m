Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAA41A928
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786804402; cv=none; b=WbS0K6JTQ1VLd3VtTXQ6BKnLYISLbMyWa+Tbdb/mykc5XxM3yrpSVxWbS5zL54B7dZjaCgONhPUOHpYlzMyBNIrcbvXE/rQ1iz7kdvkAKsmpRk6nQqzP3xw82iEnyJPp8Txg1CpjMEqBRpoeuEPxZuJYiQhOlpiaK+H7K3Ab/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786804402; c=relaxed/simple;
	bh=Gu+5R/J3DzTXZKtwJYgBoKEqpQBl0uSjP3ybbuoUVa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY0CDiyrXx2kcnww24+O3VuSVAeFX/wrYtCnnRjbOt+jn10pHSnfeoYkmuKvq1H/kgrbzzHB+R/8kSKPLaK7qYA2VKqTzq1sVrPBJxuvvLUiXyQLY55L7aoPvaltTBz1xRddS4J5qg5ZEYvqsMzTXyGXWdHjEnp9sTStaz+o2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RWak0BCh; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RWak0BCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1786804390;
	bh=Gu+5R/J3DzTXZKtwJYgBoKEqpQBl0uSjP3ybbuoUVa8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=RWak0BChEahifL/aAeDit1TdhBAQHFnGtZ2wY7nsTf+uaorf0bSEArlXU5ccnRAp/
	 lz1RlTn4wx4SlCNkaumov7sD6IS3fe9q0JL/7LIl/KoUAlyiOzhSofdEYUH7+bQl9O
	 KWk44EvpvuPjner7t5zuAE+PoZPhM/xSw9lK0Ne8tOoZB/jryPUvcTPD7BMRqn1kcC
	 g3KCVUFuEo+maefoNo6t0M2S0J1qJBUj900SIZXHTDLTQb4kr3n2viIwg8m6Dyque2
	 J+M9RaSKbwgsJ7UtijzXAsuQkoKihzTxW065jFhYX8oKaX6j+JpWxe1UMiwe1wWU9I
	 YlEDsEZlYuAlQmBpoDRK3MjhxUTr1eUKvCI6VARbDOPUqXYYXuVWsZLSLC+he+XJSf
	 edVsO2fcFje39B/GvxgWPpJ1oXGkoRdlt8BYEbh4c/UhE9bM1ywX8SlQg7xP3DpWqC
	 cjkSjhKaPEuxcETyYgmBMtr0MmyKmI1VIWn9hIyttrG1X6iJCZU
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ea5a:ed07:43ea:5e04])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F0770200C6;
	Sat, 15 Aug 2026 14:33:10 +0000 (UTC)
Date: Sat, 15 Aug 2026 14:33:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Peter Morris <mrpmorris@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] git worktree: use filesystem cloning where supported
Message-ID: <aoB4pOTtJ65PjwPA@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Peter Morris <mrpmorris@gmail.com>, git@vger.kernel.org
References: <CAOqWQbKn88m=OBDF7W8bBPjeOxtRsvNmhsqNy9AryMKrOKtLUA@mail.gmail.com>
 <7d0e9933-1a5f-4755-8bc5-fa4fea42f61c@app.fastmail.com>
 <CAOqWQb+YzvVeqS85qYjQKK8jrUqDwV01eKqC8i1jgT886ixCwA@mail.gmail.com>
 <CAOqWQb+XY_u2OUNnBJ9GBGBz8B73ocHWp+V1tDBS-4a5-OviYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PIz5ylLl+cyQEgJI"
Content-Disposition: inline
In-Reply-To: <CAOqWQb+XY_u2OUNnBJ9GBGBz8B73ocHWp+V1tDBS-4a5-OviYA@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--PIz5ylLl+cyQEgJI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-14 at 13:29:26, Peter Morris wrote:
> The PR says it only supports Linux and macOS, but ReFS
> is available on Windows too.
>=20
> I believe that if the source and destination are on the same ReFS
> volume the Windows CopyFile API will use block cloning automatically,
> so if CopyFile were used we would get this for free on Windows Dev
> Drives.

ReFS has serious defects in its implementation.  If the data has been
written but not flushed to disk, the resulting copy will be corrupt.  I
just saw this come in with Git LFS[0] and I described it to a colleague
as "horribly broken".  I definitely don't recommend adding support for
this to Git until only fixed versions of Windows are publicly available.

[0] https://github.com/git-lfs/git-lfs/issues/6312
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--PIz5ylLl+cyQEgJI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqAeKUJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ5q99Jq4CxuATtRrHKu2m43uK01m/h4rrRjbxL0ehDA5
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAIf6AQCZR6ouTUUMTNjMADZxZQqrk0dn
Hfj1VtP2ToHSiHvm+AD/dBQrBY+tSQO0WnPNivGlCsq2nO6tRsj2gX/FhynHswY=
=BGPj
-----END PGP SIGNATURE-----

--PIz5ylLl+cyQEgJI--
