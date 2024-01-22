Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178E3D0A1
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923427; cv=none; b=AZc8a5v1y4xAVdNDyWYgA9TP6TYPrtRvXHC8wPveJBjaqrKQHlTtXJjAMUAMjVIEHxXBdvfB2XKxSPYYUAjJt1LK1DGdoYD/aCYns+jTtKyGjULfVxjG0lXDEXnjDIVqLjvsJygn/kRiw41ytBXCU6PeDK+OJv70iYCObs4CHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923427; c=relaxed/simple;
	bh=qkwySoCntBRL5RvsIx8PmD/negvShavn67qrymum4wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMAz+0Gxcwvd4Wk2uBVY5t2fDXsn7ACqVlPYSPxja+cMl3nkEd8rO1T8HAztjXouZCw2VlDYFtrATOh55gXlc9uhKu7R+shapQ0ljp3cWIsOop7/0exPE6ENvKm872PK314gXuelsTtcgdlTZP4xAGm9lWlET4DtzBY5GjZDRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DGCvRCrL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j8qWz5rQ; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DGCvRCrL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j8qWz5rQ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 06FC73200A8F;
	Mon, 22 Jan 2024 06:37:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 22 Jan 2024 06:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705923424; x=1706009824; bh=3tLFDwRg1a
	47QFSiHwmGBNFynNHLbh75BARXuFYzfdE=; b=DGCvRCrL7r8M58aVKZPY1e8EJ5
	k0EN+uaPhhWeyol/9Yu6+RC1fcFhT1vBDyu9z0HnfCKNmJrOp6CLgxdjHmUywmQT
	lUxjl7fHQ/oknlGroZZvt+/SXsc+Ay21NCkatfkXC9vbSLKkMZc7bDBNKEuQ10yh
	J9mICg1ZjGO8ifBl7XyweWdkyipFu8ks1e/wHxb0M+2J0tyt9pDseAppIU42VYY8
	IOhcPfhnPpLuc2+xdnnLAKH4XdTrP4oA7gj5zOCQumY/05N/ncvKEBkSkrRjWlAl
	f8ndnk+K7VYnQM9fTKolQ/SN85IW7kZr/bLgqJXyOYJtSHxOORPyMHHIXHDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705923424; x=1706009824; bh=3tLFDwRg1a47QFSiHwmGBNFynNHL
	bh75BARXuFYzfdE=; b=j8qWz5rQ0gVTxQkhb7pB1nsEjINSPwwaKaLR8CpmnrDi
	yEhyRq7bB6i94LR5RNVDrRzJG8DixziXUaMsZpELeYZ1CRrUG1Zr5jyihUuKivsQ
	kEoeYwZTOK1wJqwREJ05UoMhTVcJ3Gi7os88jdbeFPHWQ/FKjlR/N+VvP1Smp0NH
	51fd3ePuUxx+s6x7oLwFBTG5mEUMTNZznn6W8BiB/otwKf/XffgzgfjJvFy3FhCV
	OjavO+WckbNZnQc7F+RiaG11IokpEgiwfdDmDDtmZGipdUIPgdP7PX6g3UGdP0GN
	KNV/ITCFQKbGN+n6ydYkqzGWxRXfFoDDnQfCh4JZYw==
X-ME-Sender: <xms:YFOuZQUDCbRQ9rblRAttt3Y7bNoJLXgzzYEDXr1BCZTbdnI0HHSqgw>
    <xme:YFOuZUnjHicSALDu8f-f5hEi5WIGhrWIrCn1efWUd8GNFaaNw_kOeULV4sLMWB2yX
    4evqLwp7-oZZ0ukWA>
X-ME-Received: <xmr:YFOuZUa0BjXZezcuXbQ56OXbc0NLuEIRvvMw0GUbWHLylMwbng36ScXEAyst3Y3jB4H0v_X0gKlURfeMfAxc76PURik_mZBOd5RfAGQyFqbHPw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YFOuZfURPcPONdlMgIa5s9mFE-E6KYHXnbHq0oXMxjUpsV3sNX3Ngw>
    <xmx:YFOuZamHQj8A4nEeGMUNdOGW29ueN0sDTjpG9KIxDQAnCm87dA8ylg>
    <xmx:YFOuZUc16NPez3P5wRe_SzEeIwB950kUJkinaKwJ0wv7e23SMbfcxQ>
    <xmx:YFOuZeuGxveV5BjU9GCygyUgTmt3JmFTUUeipRnHqZiLIi4PnltLtQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 06:37:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6857624 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jan 2024 11:33:58 +0000 (UTC)
Date: Mon, 22 Jan 2024 12:36:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 00/12] Group reffiles tests
Message-ID: <Za5TW-q4cKS8pNNc@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oZ51qLCH/i7zvkDZ"
Content-Disposition: inline
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>


--oZ51qLCH/i7zvkDZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 08:18:48PM +0000, John Cai via GitGitGadget wrote:
> This series groups REFFILES specific tests together. These tests are
> currently grouped together across the test suite based on functionality.
> However, since they exercise low-level behavior specific to the refs back=
end
> being used (in these cases, the ref-files backend), group them together
> based on which refs backend they test. This way, in the near future when =
the
> reftables backend gets upstreamed we can add tests that exercise the
> reftables backend close by in the t06xx area.
>=20
> These patches also remove the REFFILES prerequisite, since all the tests =
in
> t06xx are reffiles specific. In the near future, once the reftable backend
> is upstreamed, all the tests in t06xx will be forced to run with the
> reffiles backend.
>=20
> Changes since V1:
>=20
>  * Moved some pack-refs tests to t0601 instead of t0600
>  * Clarified some commit messages
>  * Converted a test to be refs-backend agnostic
>  * Other minor rearranging of tests

I've got two minor nits, but other than that this looks good to me. I've
also verified that all tests continue to pass with the current version
of the reftable backend.

There's a minor merge conflict with db4192c364 (t: mark tests regarding
git-pack-refs(1) to be backend specific, 2024-01-10). This conflict
comes from the fact that both patch series add the REFFILES prereq to
t3210, semantically the changes are the same. So it doesn't quite matter
which of both versions we retain as they both do the same.

Patrick

--oZ51qLCH/i7zvkDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWuU1oACgkQVbJhu7ck
PpS0xg/9FbDbSHiK47a56Sg4Db2RYa0Ky5z8zrhUvwvB29z/YaxbnCSv9XhU6pW2
603+UaemeZlajhIqw9TSJ8i4O+hncjUzq6TT336GcREg8P0g1jEihr/LdK5XUJvL
r1i1Kgw1Fu1IXVTUitm7vN+t1tl8fIbjf7VgRIL6HGW/vbscgO6vLFVrU5oNsFwH
sCQ86F71pRVpfigS30mnqY3FSMp60bstyKK5Mzag3NuV6aZZ3zOM77adJWiJn0vp
OeFJLdN7u/NEJoQUMaCT5ukK934E6kUT4C0t8qoTC2NaUpnvJVJm+KXnH8dTT/cD
5c4z/OlHj7xmGTrByqnU6Wd1ooYh1UBYTvhnTQfTGZwvt75SXIIKqLBhCT8QSAag
fwQtVyVqven9QUxOMcIpf97CS4htMJgzQPeDKbtaNj0rnY/cAWbub91VNcNzQYCf
d53dq4CcgvaFdX2hvRKl0858bIXIoMyQZaoQyQXvMrhS4UHWI92xM8ch7FfruTmg
yxQcwNmaWx2xlBmUhSrcLSuhYdYmdOqz/Uc2Z3tmJKYT2aymiyNOgHD6Lz1+59tA
6KzWbKDHxaZaEdKi1lrRo6FkevHICDcv67f8LsV00SCObTRHebjwfXytjP5PcTkx
9x66D1NWcckeSRXmu4cQWnLxhGePNx0shkd2H2V3B1jfSqyQZ04=
=yHTL
-----END PGP SIGNATURE-----

--oZ51qLCH/i7zvkDZ--
