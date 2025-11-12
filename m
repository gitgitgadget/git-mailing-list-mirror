Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A702F3638
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762990674; cv=none; b=JrlcrgKyX8uhfBAYX2G2B+cfG9JjyOsR+nA0xYueSXyOw0LuZVRh2GJX5oqNODnBL8tn/rmZBub5n10axuDCYpg2r7JtjMug1j0yr8Z4IEHMT8AvP+W3WRMguGC1iNQAiuNt9BPxoQ8dWudgZwRUQai92MbyKLefhE3U4Km9hRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762990674; c=relaxed/simple;
	bh=lYb7e/pubjqUf1Ds23clNEDlFAtAt3oTyD0mn4xyJzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcGVtz1HGK6iznk9Vz88NaEp4N4wENsyB317PqWRGW9G2l5xh9Xvb9u1bblp0FMAkVh1OaZg+aigO/NwKAUmKdPhmdxBpW9lin13V7CM4nszMmVFTZERCeZQXFui7LacfG4/p0hPLXFh2EXoW8QyMA789B5NOt84B3rpdtrLBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Hm59YUsy; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Hm59YUsy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1762990665;
	bh=lYb7e/pubjqUf1Ds23clNEDlFAtAt3oTyD0mn4xyJzY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Hm59YUsySl/yqkZsH2DPh3XOJ1AyMqPIIQDZvnOmJ6zP2Phot6CkzHoh2T1C7k7mf
	 F5gPtk/M2ydrWygON+IxBO+YOf+qvUXA8H7LoylbmkltA1R5eaBazg/O3o0bKui4NJ
	 QBZn7Y1S5opyYUKUi2o3J/edW2sdblTHMzkwwn272hr1VSvNcDzbdai42kbFbde8p/
	 VXZo332ZiSO4XbR835pYehX33Ftwm8XGGtgDcUhgbQPPPgPbceADO+HuKTGMYVULUc
	 Fo9MxizOljMm/dnCoSBNERzVfAoejjtRsqVXULZE8xcocsfDIcQFq72SAZ5dJ0JV0Q
	 LMLHuxc4hJO12E5BN1inNZLeSC2fPsyP4/SH4ZfCF/zeUUyTSuOfsXYFWx7cSXYSbj
	 3MG6JUV3VxRuCdAMbLKkzTc3MrkE3+p6oZmGkQL7xiD7NK0GwRuytjiJ1ZyvhkMqy1
	 D+4IhLYwKWc+STosBPKnldX8FiJNCLKOn3hOBPQtU0gVIDn8yNt
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b668:e49e:abfe:cbc7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0610820065;
	Wed, 12 Nov 2025 23:37:45 +0000 (UTC)
Date: Wed, 12 Nov 2025 23:37:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Martin Wilck <mwilck@suse.com>, git@vger.kernel.org,
	Adrian Schroeter <adrian@suse.com>
Subject: Re: git fails to checkout SHA1 submodule in SHA256 repo with
 --depth=1
Message-ID: <aRUaR6IfH9imrF5A@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Martin Wilck <mwilck@suse.com>,
	git@vger.kernel.org, Adrian Schroeter <adrian@suse.com>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
 <xmqq7bvvtdoe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VMM4ai6Yy0OztlEl"
Content-Disposition: inline
In-Reply-To: <xmqq7bvvtdoe.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--VMM4ai6Yy0OztlEl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-12 at 16:32:01, Junio C Hamano wrote:
> Martin Wilck <mwilck@suse.com> writes:
>=20
> >> Subject: Re: git fails to checkout SHA1 submodule in SHA256 repo with =
--depth=3D1
>=20
> I think it is not supposed to work to mix repositories like this,
> regardless of any other option like --depth.  I think brian gave a
> response to that effect in a thread in the past few months.
>=20
>     ... goes and looks ...
>=20
> https://lore.kernel.org/git/aJ5gOPQ9oologqj-@fruit.crustytoothpaste.net/
> https://lore.kernel.org/git/aKPJNNWMW9gtueEK@fruit.crustytoothpaste.net/

Yes, that isn't going to work and it never will unless we add some
extension mechanism for that purpose.  The repository in question is
corrupt.

I've just written a patch to check for this case and produce an error in
git add, which I will send shortly.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--VMM4ai6Yy0OztlEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaRUaRwAKCRB8DEliiIei
gcT0AP9WMod5QbTx1Eb5kxYfrXnmH8a5P/b9KnInhkN+cpitjgEAszzAXGJNlCb3
Wo5O4gpDjqlnpetXbvEY5E0jXcD2Rws=
=gTIA
-----END PGP SIGNATURE-----

--VMM4ai6Yy0OztlEl--
