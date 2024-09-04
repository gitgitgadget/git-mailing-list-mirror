Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60BA4400
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458504; cv=none; b=d7ookJsaXo/3tB3Mcr9ltPA223/meDKqFLLxHKTlZpXqSyZ02gx85AkmL9Lbb96CxECpJSyZEmYMMe4jUByjs9N2IqIBUQlrxbNXjdMHum2uNrgKxP/V622ux/UrJwTwaKcU5vaol6JHFZ2y6hv5HdsbtKxEKOztOnJ43Cuo+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458504; c=relaxed/simple;
	bh=0glsumhkfZYA/1J0qihENHr4ltgNmX0uQDxoP1qQT3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHBD2ME/5oekKMeBd3u6td2Dho/nlFT6PqbFJb68Fotn3acn0zq+JGq5M4W0JVcRHbRe0P6vKrpAcC4ALIlas+lYmcDLo0Fnpy3rUS1IhnH0u4xGCl/8wQ4t91pHV0UTrmjcrOgGi1seC5weaf8nLLqVJ+UrnDy67PcUKV/6JqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=QHZE3vCv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QHZE3vCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1725458494;
	bh=0glsumhkfZYA/1J0qihENHr4ltgNmX0uQDxoP1qQT3k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=QHZE3vCv8Uh4XUKHvqpnnzpLJAMhF2ysTWYuhquUsNUsCxfjmcrjVsbcE6jrT+Pf6
	 9h4z0FtSorvTPTgyLl9RrKb9hWiKOHChjG3MwExYhnsZS+bKok2udI+UMC2N/+zqRf
	 7m9JoKKIhNZXVMZKoQWkbmkNVcT1O8jpFt7VlvOMf6dzxN+C/QXtkWCa3l74BVLeo+
	 ujv6eqZVG4LthJYjMXRBc7KIM8wM9e85OdyHK3JBM7fc4DfyRArl+Kufs6q2orHHND
	 +iDpg96sMS+9kBVpsbO01sreaa4NQ7AEhveCRcaq6yJCsNZTqMyKF7M65bWelu6Y6k
	 ugG5T6T4g6sj903VQU/qtKneN3EOMOGhXwPxoWl9ctBD4wcGhUj0y+es8rlhj7yYNe
	 Le9yHyBltFBAa1cXis6zS3xc2MkBnZEse8uILXfUSDlKF1XtZqbc6ODUMRmiPL2LHK
	 Ax+MXx5FTgzfq1ALWEmORDR0s9fdnQ+Ua9ByBPnnBybCW86LqX1
Received: from tapette.crustytoothpaste.net (unknown [74.12.158.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3AFE624454;
	Wed,  4 Sep 2024 14:01:34 +0000 (UTC)
Date: Wed, 4 Sep 2024 14:01:04 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <ZthoII9swrVNLIqZ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
 <Ztdn25zfi8WHO+GS@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e+XzCzuCyzwCPfNH"
Content-Disposition: inline
In-Reply-To: <Ztdn25zfi8WHO+GS@nand.local>
User-Agent: Mutt/2.2.13 (2024-03-09)


--e+XzCzuCyzwCPfNH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-03 at 19:47:39, Taylor Blau wrote:
> We still run any packs through index-pack before landing them in
> $GIT_DIR/objects/pack, and index-pack still uses the collision-detecting
> SHA-1 implementation (if the repository uses SHA-1 and Git was compiled
> with it).
>=20
> So if I were a malicious attacker trying to compromise data on a forge,
> I would have to first (a) know the name of some pack that I was trying
> to collide, then (b) create a pack which collides with that one before
> actually pushing it. (b) seems difficult to impossible to execute
> (certainly today, maybe ever) because the attacker only controls the
> object contents within the pack, but can't adjust the pack header,
> object headers, compression, etc.

Packing single-threaded is deterministic in my tests, so it would seem
that this is possible, even if inconvenient or difficult to execute.
It's not very hard to get access to the configuration a forge is using
either because it's open source or open core, or just from getting the
on-premises version's configuration, so we have to assume that the
attacker knows the configuration, and we also can determine what packs
are on the server side if we've pushed all of the objects ourselves.

> But even if the attacker could do all of that, the remote still needs to
> index that pack, and while checksumming the pack, it would notice the
> collision (or SHA-1 mismatch) and reject the pack by die()-ing either
> way. (AFAICT, this all happens in
> builtin/index-pack.c::parse_pack_objects()).

If we're certain that we'll always index the pack, then I agree we would
detect this at that point, and so it would probably be safe.  As you and
I discussed elsewhere, I'm not the expert on the pack code, so I'll
defer to your analysis here.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--e+XzCzuCyzwCPfNH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZthoHwAKCRB8DEliiIei
gYYLAQCzbyT/Dj6TdOiOhUJd8FpVfrvH8Yr+Sodl3uemWtstSAD/Z/SRA7va9Ulk
85hJSq4gfGit6vFUAwc5WkirBk2oHw8=
=MA9j
-----END PGP SIGNATURE-----

--e+XzCzuCyzwCPfNH--
