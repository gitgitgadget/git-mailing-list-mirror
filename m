Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2F613CFBA
	for <git@vger.kernel.org>; Fri, 10 May 2024 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715382766; cv=none; b=ahoK53kKlv/heHqK06nRswzCMW018cT1dAeD0Xp2vp1H//YQWBrnLQnan/iJ81drM63h0XvfWHldOj5RYu0gk56w6IjizdnYIUz8dOTw6QwfwTpNBuCwlmVgaRxwfbX4xW8R+MMcSd4sRN6i+PqUt/i5ggwdxY6uWrEBq0b9kmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715382766; c=relaxed/simple;
	bh=VAkSdgCwtxUpXrKoyC2+tpF9YWOyWlGn2nkLwVCxnf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTf0ZrP/smCqeDyFEWKbXaCKM1oVE678xBoEEhojUjc+YjaHlOWEvlBsNnFirPYdcK3DMXNV3/s6NxZ/nM//bWozND2BGy51u2xEBw9T0NaCnXwypVlke92RUeoYDDBHi+JRjZK3RPjcw2LO8wbPynn08pplRgvCUBsIkpNJzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LB+72ubs; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LB+72ubs"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D8CA95DA7B;
	Fri, 10 May 2024 23:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715382762;
	bh=VAkSdgCwtxUpXrKoyC2+tpF9YWOyWlGn2nkLwVCxnf8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=LB+72ubskG7s25pDkwdZ3peBIeBPNNvswJ4qhsRUPTVcZfxiURm9H6xXw3tAlBJhe
	 pcxEus/TLxOuQBBY59BSNXRwn6BtqM4ecw7J670VZKZrMgzoCMuBwAWNJndBBRMTHZ
	 qGllBcnsvJVVDqCfzfTa8ZLDDwP74drm85hrO+p5Dkga/npapZ0WtcTmPKNgNmFnOR
	 4hwAlQURaCFCKJpFYKx3VUVGl0csMpXMWJaLIGmWQ8t1SgK6nzVretN5chmtqB5XJU
	 2o20k2GYibyN30RHLG6UMZtWk+QUbMdiAAIvpoOk88QEoL0bwCqrW3iB5R8nTcsAQi
	 0r0ty3mJGkn8XvHdS8Qndmwhseon/VW+K/GNhY6nhmHb4ZtEuIDamlcAVCh0Ez3WuN
	 yL1/AIM0ZoCyjtY99xFo7j2KX+PyW+DW2IxF+61AIMZezPibVQz+6vt+3zKIZ7aurF
	 ojErJ3AQvaLiqMif1EQfmwzQ0fU2c/4gikY7ThPmDinqaa7http
Date: Fri, 10 May 2024 23:12:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Bo Anderson <mail@boanderson.me>,
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] osxkeychain: lock for exclusive execution
Message-ID: <Zj6p6df2DOVocbNl@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Bo Anderson <mail@boanderson.me>,
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
 <D7A8539F-E33C-44F3-A7BF-5F5D4A26F2A4@boanderson.me>
 <20240510200114.GC1954863@coredump.intra.peff.net>
 <Zj6EhJi9MgALC5Ti@tapette.crustytoothpaste.net>
 <20240510220715.GB1962678@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SR91JMcvDAOpiw7t"
Content-Disposition: inline
In-Reply-To: <20240510220715.GB1962678@coredump.intra.peff.net>
User-Agent: Mutt/2.2.12 (2023-09-09)


--SR91JMcvDAOpiw7t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-10 at 22:07:15, Jeff King wrote:
> On Fri, May 10, 2024 at 08:33:08PM +0000, brian m. carlson wrote:
> > All the credential helper needs to do is declare support for that
> > functionality with the appropriate capability and emit the field if it
> > gets that capability on standard input.
>=20
> If I understand the protocol, it is just:
>=20
>   printf("capability[]=3Dstate\n");
>   printf("state[]=3Dosxkeychain:seen=3D1\n");
>=20
> in the helper when it returns a username/password? And I guess the
> matching parse/check on "store".
>=20
> Sounds like that would be easy for folks on macOS to play with.

Yup.  It may receive `state[]` fields from other helpers, so it needs to
check that the entries are its own (presumably starting with
`osxkeychain:`) when it reads them, but otherwise, that's it.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--SR91JMcvDAOpiw7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZj6p6AAKCRB8DEliiIei
gcNrAQDKMdCt8UFb421FxA6zmVMW9qi8u4kb+z1CoRXhwcoN9AD+PnhU/awhEW/T
Ay7qSCsOO1QymoB8bv9e3foSXB+iLQ8=
=wtxY
-----END PGP SIGNATURE-----

--SR91JMcvDAOpiw7t--
