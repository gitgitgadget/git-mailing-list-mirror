Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC851567D
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373197; cv=none; b=IAtO0yx9+MzXO/c1Ci137EHWLOY1cXZxSMfDcNWGofqaSrn28SctrODx/2i1t3oEBWzmRujmMW5JIb3p/X1IVgTNmg0SvoWrbbOHKjtV1KtC4n2ypJHLSM3rs61KX/Ey6UY8C7B0AxH9w1fIGEWvCuz9nABVZu+vSA6jb1sdiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373197; c=relaxed/simple;
	bh=rnyuQfWIj36/Q81nhNFLlSQvDpG5661HbMRr4eHZ+Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WastukCCp/URM0Mp7DXFpYWdpUzw66V/C4osjsQcDk3jg8qr2GIuFRiimphxfEbNT5EtNu4DXUbFLUAzy0vGDyY86y4eFAcWShbqGOAlpvyWZj+SMkXJiKdTbhlZPR0DIrostYtzfgNsgt+yUNQQecLExHTuJunUOVdTvcQAQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TXdGttBw; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TXdGttBw"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 496605DA76;
	Fri, 10 May 2024 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715373191;
	bh=rnyuQfWIj36/Q81nhNFLlSQvDpG5661HbMRr4eHZ+Pg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=TXdGttBwYVpG5eIMB8D8RDjrutirn5hb1arZLZdR0U0ef2w0F0/SMMzVV0HOqGm3T
	 2P+UHSbdPHJGVAK9huslIphlTth4korcmi7zZSzCibsH0l6Fkql41nhx8kwmpZxxum
	 2eJJ7WARsj845IjSNWRNQhofGlEduIbKph6aarp1TYzH6uGlSEzqMYlrRBFEM7IrB9
	 qYj7YxhUJP7ZLbmaEeTC3zxbfhjzMew4gWiLFykm7ikEXRbahPQLt/QO68A4OHTFOG
	 hTh5q5M7d9sTPhfXIZg7rROX2b2oisCW1Bh/9yssnNBJutpE5tIihsyc9dDn/QdJrh
	 TnCc14NY8q9Xl+JWUx4a76fOpoMt7A6quDvvUv4Ypj1GAkMMaROK8QyiB0541tg2TO
	 vLYoJC4xAtzb/sHnMMbgqSBoBONmYKqdxSIgnZa2fi+VSzFffBQZzxxr3fCLZPSxcP
	 pIVDrfkO3dyPp+67s776C/x/lOWtns6ZFDIucSYcxdm9CYTI8cL
Date: Fri, 10 May 2024 20:33:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Bo Anderson <mail@boanderson.me>,
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] osxkeychain: lock for exclusive execution
Message-ID: <Zj6EhJi9MgALC5Ti@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Bo Anderson <mail@boanderson.me>,
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
 <D7A8539F-E33C-44F3-A7BF-5F5D4A26F2A4@boanderson.me>
 <20240510200114.GC1954863@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pGeYBCCNy/14VpY5"
Content-Disposition: inline
In-Reply-To: <20240510200114.GC1954863@coredump.intra.peff.net>
User-Agent: Mutt/2.2.12 (2023-09-09)


--pGeYBCCNy/14VpY5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-10 at 20:01:14, Jeff King wrote:
> And I think there are several problems with that, besides inefficiency
> and locking. See this old patch, which fixes it by remembering when
> a credential came from a helper:
>=20
>   https://lore.kernel.org/git/20120407033417.GA13914@sigill.intra.peff.ne=
t/
>=20
> But we didn't merge it because some people rely on the behavior of
> helpers feeding back to themselves. I outlined some solutions there, but
> it would definitely be a change in behavior that people would have to
> adapt to.
>=20
> Some possible alternatives:
>=20
>   - we could remember _which_ helper we got the credential from, and
>     avoid invoking it again.

This will break the new `state[]` feature, which relies on being able to
see the state after the fact to know whether the operation was
successful.  As an example of the functionality the current approach
allows, authentication could use an HOTP (like TOTP, but using a counter
instead of time) value, and storing the correct used counter on success
would be important.

I agree it's not super important if we're just using a username and
password, but considering I just added support for arbitrary
authentication schemes, which can include things such as limited-use
OAuth tokens, one-time use passcodes, and certain types of HMAC-based
signing, we probably don't want to choose this approach.

>   - we could record a bit saying that the credential came from a helper,
>     and then feed that back to helpers when storing. So osxkeychain
>     could then decide not to store it.

This is actually possible with the new `state[]` feature.  `osxkeychain`
can simply set that field to something like `osxkeychain:seen=3D1` and
simply do nothing if it sees that field.

All the credential helper needs to do is declare support for that
functionality with the appropriate capability and emit the field if it
gets that capability on standard input.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--pGeYBCCNy/14VpY5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZj6EhAAKCRB8DEliiIei
gWPKAP42RK3sSTp/3EtdLsp5Tix0TMPCkasmFo4dWoiuSaLjGgD/QM4quxsPvZsx
1f8zPUkQH3WRbg7HA6I3wvlp26QKHgU=
=zl7o
-----END PGP SIGNATURE-----

--pGeYBCCNy/14VpY5--
