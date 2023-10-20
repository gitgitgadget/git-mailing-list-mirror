Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82149361
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sKA1p6ie"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F183DC0
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:33:52 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EC80B5B08B;
	Fri, 20 Oct 2023 00:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1697762031;
	bh=BWzsCeBmQgqjWT8rK25/FEv7uyQjiynj3riqriRgxkc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=sKA1p6ieQhIJWJdao5vnJB7rSTvMa1FH1aMijyhMk/LgYscG2L7CalsIqP65d0nP1
	 RseN4nq2+Qr525Rg3A+ECb+8z39BRrW0uUjkysV6Ze9RBkJo9ZE/ANMlsiaK/ZjMRm
	 cQxRvJykUpGXIPm6HXD3xfkT/5YlEXVQ2uGiU6BlJzW9IRyWQ/rrPtAQ5Ld32lnZTs
	 yYmhECB2gooW9FCmSrxiE+vi5lmsQFJCAiIgjN+gcMMcfWAzYwR02qVkYdv2jbLKWa
	 cXAdloHRSaUbTG7vQNV2cXll69c9lhGqZAtPyrCqNAzvSp0nTVQoXhN6OxonBuLeqQ
	 mbam6QsohjzIaQt7AugsbqbHt0bL4e2dFmcUc/tGDKj4XkvcR4QyOnBecB0V2gSObk
	 zWg33oqtSn5HfiM8R3BMBxBAmhsHvpw+PFmbmN5mRIUmZ68fKYaDgznk5pz4+BHKEy
	 faaUiAkFkCdThr3M5YuENB7Gc8JYfEzrjfvzjmw3seCAfo9D67F
Date: Fri, 20 Oct 2023 00:33:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Daniel Santos <daniel.dlds@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Pulling from a linux box to a Solaris 9 OS
Message-ID: <ZTHK7o5LXvMB5EeJ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Daniel Santos <daniel.dlds@gmail.com>, git@vger.kernel.org
References: <20A47898-41F6-4E94-822C-10509EC1E3B9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bvIXsnrgo4qd/Dzh"
Content-Disposition: inline
In-Reply-To: <20A47898-41F6-4E94-822C-10509EC1E3B9@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Level: *


--bvIXsnrgo4qd/Dzh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-19 at 21:49:53, Daniel Santos wrote:
> Hello,
>=20
> I have a bare repo on a linux box. I can push and pull from a modern macO=
S X.
> But I also have a Solaris 9 box with a checkout of that same repo. when I=
 try to pull I get the messages:
>=20
> bash-2.05$ git pull
> command-line: line 0: Bad configuration option: SendEnv
> fatal: Could not read from remote repository.
>=20
> Please make sure you have the correct access rights
> and the repository exists.
>=20
> The cause maybe the =E2=80=98old-ness=E2=80=99 of solaris software.
> Is there any way to get around this ?

By default, if the SSH binary is the default ("ssh"), Git assumes that
it's OpenSSH and sends certain options to enable protocol v2, including
-o SendEnv.

If you don't want that, you can set "ssh.variant" to "simple", in which
case Git will send only the username and the host, but not -p port, -4,
-6, or -o.  If you do need a different port, then you're out of luck,
and will either have to install Putty (in which case, the ssh.variant
value would need to be "putty") or upgrade OpenSSH.  Otherwise, the
simple value should work fine.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--bvIXsnrgo4qd/Dzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZTHK7QAKCRB8DEliiIei
gQDaAQD4QC0NW1oarXqzpj74rdeew7TE6o7/QfPHm5PG+Ap1dgEAm7n0ElxBHsRA
c8uEyY+VYujdGYNMOwfSgIK/0X88gwI=
=ON8A
-----END PGP SIGNATURE-----

--bvIXsnrgo4qd/Dzh--
