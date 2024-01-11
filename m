Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01D646B6
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AIVXBctJ"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 892585A3A2;
	Thu, 11 Jan 2024 02:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1704941743;
	bh=+ToQjmy2M0cfgBiOSKt/ov1wIgpFpZpffYxUxBTfRXw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=AIVXBctJayOrZdZo190Dwh5fTIuIZPoGsy2YoUyuYj2nMxwlETziA5SddeV5MsIlp
	 nbueszmOYYKTx6NGkESS0dqFZBICSIPks82LFgMYzTpS1A0C7HDrxTWRhNmjvv0wGl
	 ta9isB9BJwmPuJKsecu4lMe4oCu9LPOOUD+Y6RFoGpbX9quLs6IAnj1/JMghKpfoyi
	 lO6uzPTml3pvvVYKpFaZ5lvAkVeuWoLLZB9dZVipi5aqTzmgTxtRLBxt02LzgyS9uR
	 xo/1wSZOZhB4JnfIIuyHaAeXszjNaBFw3OQml/0i26kiSUC0ecaneaRrqreHnpJqq4
	 JPPGNJZX7B+27oYCOfYdNx1chv24X6JFmlX/5qdzT5ID4ejkkrv/2DrtRTuAEOe/1P
	 of665P0YbLVdvVeTiS/F22/nqRaZ2XTIzNZ6S9ktvC5ZErmhvQLJeV6UniKNdEIR5q
	 0pJNlf4+9xbbF+Ay0j+8oiQPFn47DyWzSE34ntoHqh/KFkEd8q7
Date: Thu, 11 Jan 2024 02:55:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: rsbecker@nexbridge.com
Cc: 'Taylor Blau' <me@ttaylorr.com>, 'Junio C Hamano' <gitster@pobox.com>,
	'Dragan Simic' <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
Message-ID: <ZZ9YrYvW_L9A02aI@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	rsbecker@nexbridge.com, 'Taylor Blau' <me@ttaylorr.com>,
	'Junio C Hamano' <gitster@pobox.com>,
	'Dragan Simic' <dsimic@manjaro.org>, git@vger.kernel.org
References: <ZZ77NQkSuiRxRDwt@nand.local>
 <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <xmqqjzog96uh.fsf@gitster.g>
 <006b01da4412$96c6c500$c4544f00$@nexbridge.com>
 <ZZ8ZlX6bf+hjmhN+@nand.local>
 <007c01da4420$10a7b700$31f72500$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HDDMf8m/LSpusipK"
Content-Disposition: inline
In-Reply-To: <007c01da4420$10a7b700$31f72500$@nexbridge.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--HDDMf8m/LSpusipK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-10 at 23:52:21, rsbecker@nexbridge.com wrote:
> Unfortunately, none of the compiler frontends listed previously can be
> built for NonStop. These appear to all require gcc either directly or
> transitively, which cannot be ported to NonStop. I do not expect this
> to change any time soon - and is outside of my control anyway. An
> attempt was made to port Rust but it did not succeed primarily because
> of that dependency.

Can you tell us what the technical limitations are that prevent GCC from
being ported so we can understand better?  I know LLVM doesn't support
ia64, which you do support, but GCC is very likely the most portable
compiler on the planet and supports architectures and OSes I've never
otherwise heard of.

I strongly suspect that if GCC did end up on NonStop, Rust would be able
to be ported, too, and you'd also get access to gccgo, which would make
Git LFS possible on NonStop as well[0].

I'm not capable of porting GCC, but I have done some portability work in
the Rust ecosystem, and I'd be willing to provide context and some
assistance (within my time and capabilities) to help get Rust working on
NonStop if you want.

[0] For the record, as a maintainer of Git LFS, I'm happy to accept
portability patches for virtually any OS.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--HDDMf8m/LSpusipK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZZ9YrQAKCRB8DEliiIei
gXj8AP0c0KV5hqOVYTRlBID1xShuIzuTrq3JOc/Xh+NnU0g4ugD8Cosw3SQLL2lD
AosYTr3KmfMIlag2a0qEeA26ns6yFQk=
=SSzV
-----END PGP SIGNATURE-----

--HDDMf8m/LSpusipK--
