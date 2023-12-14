Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0+DpLgiH"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E643E4
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 18:27:17 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 728AD5B11A;
	Thu, 14 Dec 2023 02:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1702520836;
	bh=8iJlvkDpY+a3dPYufUW6LmoEpxuu4rOfd0+KKoaWIks=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0+DpLgiHGDP4Bl26JPyp4gfqw/g4gQqwSKMbDYu6XxmogxwV2bB4GFG9+IIcltxMs
	 s8s1PUs4DjvdIdpPI8ZlVz2qn4H3p4JQNTpeiIKbVofbaLgYLSrTTDDMKU1AX3aWMl
	 YgAEmHONtqDHGpfEkMczWDD0Fm8i2tgVfEU7WFDJyJXzJeqDRtNnVM1xw9hd6kWkFN
	 sAavyOc40eJsDYY5mi+4qzyOblgIXzShdSbbiy6/IS3c/0iWsOyhmw0AgXbSjfiwEs
	 JjN9QiNh7ahM+lCzPjQsM91CWRKshAgxqNz/hbDhUPUf9OxvYNKHljH5gDVL3VrGUL
	 i1Sc+rkZqOWk3m6t4S0jHEjhd2suMLSAUT7MI0ktQF2oGIDl46+f2M4VtXwQm98JvX
	 TztdVjIvmIe9TYydwOcspZ6yyQSNFOwk4kNQoR51kH/ZDc82SPlhWeioDYDUakYWK5
	 P891GN7nnRfo/8jzUm7lVQcpOMyOhpqakUK7iPyQdrrYQ9uWkGI
Date: Thu, 14 Dec 2023 02:27:13 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Alexander Zhirov <azhirov1991@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Communication channel interruption
Message-ID: <ZXpoAVZ5BP9WqiZi@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alexander Zhirov <azhirov1991@gmail.com>, git@vger.kernel.org
References: <71f2b28b-3e27-4773-8408-2f4c13757b73@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2lzGKmOwxKyikRbc"
Content-Disposition: inline
In-Reply-To: <71f2b28b-3e27-4773-8408-2f4c13757b73@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--2lzGKmOwxKyikRbc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-12-13 at 09:54:30, Alexander Zhirov wrote:
> When cloning a repository from GitHub, I have a channel break, although t=
he
> connection is stable. What could be the problem?
>=20
> # git clone https://github.com/Thinstation/thinstation.git
> Cloning into 'thinstation'...
> remote: Enumerating objects: 79839, done.
> remote: Counting objects: 100% (535/535), done.
> remote: Compressing objects: 100% (319/319), done.
> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly: CANCEL
> (err 8)
> error: 7473 bytes of body are still expected
> fetch-pack: unexpected disconnect while reading sideband packet
> fatal: early EOF
> fatal: fetch-pack: invalid index-pack output

It would be helpful to know what version of Git, libcurl, and operating
system you're using.  This type of error is often caused by proxies,
including non-default antivirus or firewall programs (very especially on
Windows), TLS middleboxes, and monitoring software.  If you have such
software, it should be completely uninstalled and you should reboot, and
usually that will fix the problem.  (Simply disabling it often does not
fix things.)

I should point out that while I'm aware that this does occur for many
people, I have never, ever seen it when using GitHub, nor do I believe
it is actually sent by GitHub servers.  Thus, my experience leads me to
believe the problem lies elsewhere.  It is theoretically possible that
libcurl or one of its dependencies has a bug in your version, but
without more details, it's hard to tell.

As Junio suggested, you could try forcing HTTP/1.1 and see if that fixes
the problem for you as well.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--2lzGKmOwxKyikRbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZXpoAQAKCRB8DEliiIei
gQJdAQCCJ3VhePouPBkFeRo3Ax9KFSmiGthsuz8OU3MZCQjsAgEA6cP7DyXRfx/5
fuXdfsImpTSoNoRSjHqoEPTuQF+aPgM=
=Ar8V
-----END PGP SIGNATURE-----

--2lzGKmOwxKyikRbc--
