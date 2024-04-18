Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC515E7EC
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442589; cv=none; b=InOsme7eMa6BqOC9M1mxbFnLugwtg9KvhWfssxJa7zLhtOKvC1ZFFuj66PK0iJNF8CS75+8NI9H0XrRJgE6KJLKfT700eHt2RRDmmYEmu+6nyBQgwqa92ncNREfugZP09diOAqFkoJbI4E0CoUU+DHMhqqOipFuI8j6gF47GMOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442589; c=relaxed/simple;
	bh=fDTOpxUO+nGxZNNj9YnaD2Q+G0f8+eQtRwe6XHwwHDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O95E+jlT4ULXM3ZDHXCBR8t1WSnIC2xyXS50cCmykwnpYEUiqvOjTd7cu7eQBC/e55qjFX4lKKJzE5eEL2ygN39RAiZiRBXny324h6qvYbOzx0iO8tB9n2Ji1qAodolWj6U7JPmlpoCyNUHV5TRRiQDJu8mCm9+02iEmjN5Pf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kzxo1KkF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQBHckl0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kzxo1KkF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQBHckl0"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1F15011400F7;
	Thu, 18 Apr 2024 08:16:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 18 Apr 2024 08:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713442587; x=1713528987; bh=fDTOpxUO+n
	GxZNNj9YnaD2Q+G0f8+eQtRwe6XHwwHDA=; b=Kzxo1KkFDgx7NUlGDEf5GIB4UC
	VnobzOdU9graiJ9GC9U30+eNV2ihO8RNY40Y4IWJrame/ebj94uWM9DZJ4/gbqYz
	W+EqJWBLOx44V8ntq07uAd5p8zrvjVrBZcHK0e9KKZUMKElsTDbtDrS7qJepn1XN
	xZtlkOzpChfE4iR7viPiqLhSQ6lMXWmVmWrI/GiG4MFDIHI4opGVcmO9UQzoo/Gu
	jgExAepBbqsbwo8ZIFvRycE5DhIPbQs5o6xE3pMqJUDNm1Q5NC/Qwc4iDDhjWkPV
	PLF7leQdzKMBNqHoXpiQRQ4fZ3+s5J2Qn8GrAYXJGf8zo0nt7OTi2jdMAXnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713442587; x=1713528987; bh=fDTOpxUO+nGxZNNj9YnaD2Q+G0f8
	+eQtRwe6XHwwHDA=; b=fQBHckl0cpx6C15QME/Tmws005qKKCk/XlXQh+XWsu60
	AuGOumd6FgkV90pyehnAap/yoWA9EFIYBM/5BP1pPnAnxKGtvIYuTaPlfKiPWigI
	QUKsVvNLGYa5r6KEiQSF1qc6FY99ZeuUClWVcm72lrkhEUhnWSwvaJX8uLtI8H9U
	nLxmLdzFXaSBsxBK/5hQgux5yeqnoPtiKa4tTouCO8oBwmwGsNYjM+y7Jc7sWXab
	AGa5tEfgkFuwj/iT2MsXX2TCK56AOLHN544VSjrZq2CuhhC2g9Gq0bn9MHtGTs6u
	mldTn9457cNDBEkQxDSCwVilg14Er+08zzkLJnDMCg==
X-ME-Sender: <xms:Gg8hZsciTJ74Hh11UUxZ0yI6Ani6At4qc6Rv3Z9Zfwl40f33jHD8ow>
    <xme:Gg8hZuO0E7eavDeZBUdvowrDBBpaO3e8uAJJ_k0d_oxsjgHiqBBxoRVHFQ95adujW
    8QIwriIzS6vy3uJ2Q>
X-ME-Received: <xmr:Gg8hZthOjDoWp0PZzdERnVZz_ZiAxVFmhXJYQgT3g-ibsp8DY60sRYuZc_iyI_NgDUVPhFfaabmiG-I03ggux6U9L2LsBW0K2NWu9II4y6rJnK33zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Gg8hZh8Ol0BhEVpLqBooBdW6fA_VVW3vH0srwA1_4iVNml18o8gIVg>
    <xmx:Gg8hZouh2FnNyV0ATwkN4Ts8-D0yOKuObDt-pONlecYKBDul-Unb0A>
    <xmx:Gg8hZoFGatlo-CM28u9GUWN77WKSw-hjoQH5yOMx-lhbOi7qwO5aHA>
    <xmx:Gg8hZnN8IV2lzCAmRgmHawlfzxI88ayjsDEoc2RRK1-2hpQ6pq2Jew>
    <xmx:Gw8hZh41JIz7WAV4mUveB3DeDxkW7JrU82MYRB_YV9lGV9e6XYT9oR1L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 08:16:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e4d1bb7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:16:00 +0000 (UTC)
Date: Thu, 18 Apr 2024 14:16:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] global: drop external `the_index` variable
Message-ID: <ZiEPF59Ra27ORJ7w@tanuki>
References: <cover.1713180749.git.ps@pks.im>
 <CAOLa=ZQmCWh_UHJ+JWbzd_b=Ob=gUE=5wEKy3gpaxu=Bru+Wvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4/iMhKOlrw7aZQmf"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQmCWh_UHJ+JWbzd_b=Ob=gUE=5wEKy3gpaxu=Bru+Wvg@mail.gmail.com>


--4/iMhKOlrw7aZQmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:40:24AM -0700, Karthik Nayak wrote:
> Hello,
>=20
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Hi,
> >
> > this patch series converts remaining users of `the_index` to stop using
> > it, instead using `the_repository->index`. This gets rid of one more
> > global variable and brings a project over the finish line that has
> > started back in 2007.
> >
> > I realize that this patch series is quite large, and that reviewers will
> > eventually start to just gloss over things because the conversions are
> > kind of boring, too. Also, due to the size it's quite likely to conflict
> > with in-flight topics. So if you think that this is too large, please
> > let me know and I will happily split this up into multiple series.
>=20
> I gave it a glance review. I also wanted to run the tests on each
> commit, but couldn't apply the series cleanly on either master or next.

Huh, weird. It applies cleanly on top of both 21306a098c (The twentieth
batch, 2024-04-16) and 701ccded8b (Merge branch 'rs/apply-reject-long-name'
into next, 2024-04-17) for me.

Patrick

--4/iMhKOlrw7aZQmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYhDxYACgkQVbJhu7ck
PpS/Ug/+PXIXggeNs9f5dSWrspx76i7A6HCqE2AMqIAltL3oOxHzPeGI3yGMJtqL
jdu+hvjV97siidjYdH+rjie5OCq/n0afxgavITD/eamViP4KEKleuDK3YRV3G99W
PNQ+qOhcKquP55+k904ee/HsoXz77XidTiOByDmCO9gkEONeqgAidEi1g3TRreei
RZTKeyTPWS5vkYtouyip9wQka0KFGBnxDqzwiBmtgs2IaEtb3K6fSXYFG4f2ls74
WTGiyN1rr4p75pEHcnFaRun9CS8Ak70oUshc3sTMSbEgvUMW1tm2d1Mv6tTQ2PT8
5ugTzAalCcrdhzfEFrKzn8cdH2ILNVxet1k/A+xhjl9mjbV8xbcUHh5aLiApuxWh
rYVIQjKSXlVkUOzTjBL5t7M+P2AZclbfrdC7oIjUuersoxiJHZlyddqQFYt147cT
1jpiDdZc6k/HUryTtAU+2tcRaJkaZfyc4UCFxyzweGnp0p9+gzYyl9opPrciME00
GdHuqTIMqMG8pawziOXUCFtDsdCw+S7GPDaDnHF53oQFwg/rTOsHREPVyneGa5hk
M0umEq/Ntcj7mJ87RM5RAz2O1sUOqKOk5oDXLHBHJmkH3Qbr6j3qBpL5gR7Q6Pxi
pK6rGuamy3coLb6qZ7QqNG4bQvnP3boSvpW+mYU5n1COhlZvY9s=
=kG5V
-----END PGP SIGNATURE-----

--4/iMhKOlrw7aZQmf--
