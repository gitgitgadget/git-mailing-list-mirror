Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NBpgnszH"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77EBAA
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 14:18:38 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7D9755B118;
	Tue, 12 Dec 2023 22:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1702419517;
	bh=nr96RlCu1RvtJId9vPjpmMyYLwgHHFOIF/DDwtPEg2Q=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=NBpgnszHm3DP/CKfEH/sQBTVOfor3bgkdhhCP4zaHAsy1sX7nBjQknfJ8/ZSIhzfW
	 qx4R+Wla4QjAYQV1J0wGrDntffg7h+Qi2zEGit26MXkTDlTU4qR7kg43c+bIiKOyps
	 fJxZyJi7oyDFrOcDYmVx0T0RNmoU7lVdGvPnxV8QXz8xn/EM4xBEsR/TOla2smmyuB
	 6PWPIdVsaeGrM1nJd3O8DtNxBBM+j122zJ59janG9GHX4BC0HsgHkElYklOLWVfAwO
	 rvmfJaU2CkanH6rYQPFUS/YNoLYTo+NFUfjmK2Jyl1lF9R3aRaNCGl5YlOKeAHH8xZ
	 Vhb6T43dpzRPjLMh6cLEHGIHQ1V8KzXnlQCFOM+wk0jbIGYiX3BT6GY0PfPVC/V3KU
	 5EhUaoyFrNaw6hxdCzy0uFHLkegtB8Twjpu30AEuGDL3d6AtHZZVZ0BmqTCO1ZwGoN
	 pYl0C8B7mt9kHI4n5Yd9OyNZT1TSBqCLIACG3Kn6fgCPbEVVGeu
Date: Tue, 12 Dec 2023 22:18:34 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Test breakage with zlib-ng
Message-ID: <ZXjcOtQ8s60X8FEQ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
 <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w0WbDfJ9PQ1cEDFB"
Content-Disposition: inline
In-Reply-To: <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--w0WbDfJ9PQ1cEDFB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-12-12 at 17:04:55, Ren=C3=A9 Scharfe wrote:
> --- >8 ---
> Subject: [PATCH] t6300: avoid hard-coding object sizes
>=20
> f4ee22b526 (ref-filter: add tests for objectsize:disk, 2018-12-24)
> hard-coded the expected object sizes.  Coincidentally the size of commit
> and tag is the same with zlib at the default compression level.
>=20
> 1f5f8f3e85 (t6300: abstract away SHA-1-specific constants, 2020-02-22)
> encoded the sizes as a single value, which coincidentally also works
> with sha256.
>=20
> Different compression libraries like zlib-ng may arrive at different
> values.  Get them from the file system instead of hard-coding them to
> make switching the compression library (or changing the compression
> level) easier.

This definitely seems like the right thing to do.  I was a bit lazy at
the time and probably could have improved it then, but it's at least
good that we're doing it now.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--w0WbDfJ9PQ1cEDFB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZXjcOgAKCRB8DEliiIei
gW4ZAQD7kzVh/YMOtTAIwFMT5tOl5/x6CRZaJ5G3obO/A2yxbQD/fCSJIyU3AFm5
kXSMe6ND7AN6gflm5+u4OvGhzOyTPwc=
=BFOA
-----END PGP SIGNATURE-----

--w0WbDfJ9PQ1cEDFB--
