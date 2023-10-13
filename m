Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26337A
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VbF5OqAM"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD7BB
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 13:18:27 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 252555B07B;
	Fri, 13 Oct 2023 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1697228307;
	bh=G9a2SRtXdtyqYu2+cdKgze0py929uSto5UK0N52H3Ko=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=VbF5OqAMS8l4bQKweu+2VNpUiGA3lxaojafXkxnGIPWtH+6WYRrwhvjUBq2gBSHdW
	 fyj0mZPQvVWBHTyGZ0/58dCpR8eISY0hviN00A3Cc7cVCF3iyGATCWZ6GJMdJwC8zP
	 a8UPe/1/mOYeW/BYp6QyOzNRXnwR8mqwq072BX5ajf51VnDpLAZjXZiFbru90GV5jd
	 ChkaMHw1a1BIRElWqhmj57RHBR9+HBKrEtJWw77taMM9vNnI4AXE/ngq/UQVa4XOdM
	 zyV8Ki6H4ogk2bmZ8A4B7yCw5G7RDU/HGjzVoocKihD6eV3KkZaKje1NxIAaS6er5L
	 mEQAgiKQsXAK1jAh/tD8Kk6kKDAaw/gB4fw44GEhFCftLwzDSk+OwWmSUsonSpj3+7
	 ZVBlZtRFqeedKyeXeSNVxgoEo3Wu+ztgDEPYLdKDQlBIRwRgPpJ5kF8pS9FhSafYDV
	 sPuEOn3rAW54k9CcXY1PXDhdFN94zoK+etKRlpdBzxuDmL+FrOe
Date: Fri, 13 Oct 2023 20:18:23 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Jason Hatton <jhatton@globalfinishing.com>
Subject: Re: [PATCH v2 1/2] t: add a test helper to truncate files
Message-ID: <ZSmmD5sz7TPWCGRd@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Jason Hatton <jhatton@globalfinishing.com>
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
 <20231012160930.330618-2-sandals@crustytoothpaste.net>
 <xmqqsf6f312s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ugNeLwGxJaitNLGr"
Content-Disposition: inline
In-Reply-To: <xmqqsf6f312s.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--ugNeLwGxJaitNLGr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-12 at 22:52:59, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +	fd =3D open(argv[1], O_WRONLY | O_CREAT, 0600);
> > +	if (fd < 0)
> > +		die_errno("failed to open file %s", argv[1]);
>=20
> contrib/coccinelle/xopen.cocci tells us to write this simply as
>=20
> 	fd =3D xopen(argv[1], O_WRONLY | O_CREAT, 0600);

Sure, I can do that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--ugNeLwGxJaitNLGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZSmmDwAKCRB8DEliiIei
gU+eAQCCSLkAX3iGqyAdYHivdE6LH+6Ln0tsjLvHsWJkZlOIzgEA8z23DCVvXW3g
Yb1z4WN3rwzHJrv24Rid3ilyr5h5HAY=
=JkIS
-----END PGP SIGNATURE-----

--ugNeLwGxJaitNLGr--
