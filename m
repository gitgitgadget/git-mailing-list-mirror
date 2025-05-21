Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6521C32
	for <git@vger.kernel.org>; Wed, 21 May 2025 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747864143; cv=none; b=oZg0yeeFP88Pf88W9GbuxxL7hunKTMPPxsCl8jFerqpsWuNQwWGLWxDDWs0aFAUO1i3Ur2KcaIALIcA1CPrnyebh7/lTyNVQ3Nh/NWYoFevR00nyyhXmHlvOxi0ZDcApU/UjRYO+Mo0qQXG9KYEVHp0KwkMlG2BoDxYqdVgP3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747864143; c=relaxed/simple;
	bh=AiyGJSkQVevxWeU00a66qW5ViHg/vuZpV629rwWGgfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QewxZylGF6sFXDGYRq3HeTcKdf/tq/NgjMZFOIprHGGCrUXcSruhxjSDDtV6GeBc4RBov2irgfwR0Ob+/KtWewMi0BHljeIhuA54rcIsxpnCLpHYJcuo5sS0J2nZh3nlncYUidx5sKN9TZb9BWYPzt/Yo7MHQFU1yjBp2RM2o+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=q1NTSiLF; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="q1NTSiLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747864133;
	bh=AiyGJSkQVevxWeU00a66qW5ViHg/vuZpV629rwWGgfQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=q1NTSiLFwacEkcSvKdFgql5Ks4fGB0EISrw2e3b/LpZWqrfNtk4cQQ9AMwhjrHA4c
	 MzVq1l9/GRrPObJuGi8tFAf/zwb/btwne1X+732RH/DIdMQG8Z4dTOYCqTXo98jz2h
	 +8tpAJP8DjqmXr4Jsbp2IIo3TtA7S3uS6kA8dCBzX6rNccamxQOwsMdVTRHHGO9xRc
	 X0h4lQA+zy3BrDvqVZta26wy/tOmoBrrDA4o88jY+C1YkOknix80MOcQ8lDB33a0yH
	 BnReMPDiON7lCQigLg80f50I9hS9fMNixZAldxXKHGN2YqKuvCHXg9n4O4+OKLGixI
	 C3te8EoqOMVirwHrCfs62TPNEB90hOZoMpJLNCeasFHCtG44QefcI5YZ+updwdZor8
	 o1gxIfwQ8KYDnKW09aHRqbAEHn9GsB3m6ULTZgMTmen39wlX8F7ME/9WjmkQHq3sKO
	 cPJ+kmvjiL76T59eJpaWNhVSwIZZjaJfI2Eew3Hj18ZRVaUG3O0
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D830E2010F;
	Wed, 21 May 2025 21:48:53 +0000 (UTC)
Date: Wed, 21 May 2025 21:48:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= <opohorel@redhat.com>
Subject: Re: [PATCH] cvsserver: avoid precedence problem between ! and %s
Message-ID: <aC5KRBop9m3K5JtE@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= <opohorel@redhat.com>
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
 <xmqqplg2c8ow.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vm4v/ua71WYkkbsH"
Content-Disposition: inline
In-Reply-To: <xmqqplg2c8ow.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--vm4v/ua71WYkkbsH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-21 at 14:58:07, Junio C Hamano wrote:
> "Ond=C5=99ej Poho=C5=99elsk=C3=BD via GitGitGadget" <gitgitgadget@gmail.c=
om>
> writes:
>=20
> > diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> > index a4e1bad33ca..076c10cb2c2 100755
> > --- a/git-cvsserver.perl
> > +++ b/git-cvsserver.perl
> > @@ -5009,7 +5009,7 @@ sub escapeRefName
> >      #   =3D "_-xx-" Where "xx" is the hexadecimal representation of the
> >      #     desired ASCII character byte. (for anything else)
> > =20
> > -    if(! $refName=3D~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
> > +    if(! ($refName=3D~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/))
>=20
> Interesting.  Shouldn't it be using !~ instead if it wants to assert
> that the refname does not match the pattern?

Yes, it should.  It's likely the reason this is getting a warning is
that `!` is higher precedence than `=3D~` and `!~` (see `man perlop`) and
switching to `!~` is the customary way of writing this.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--vm4v/ua71WYkkbsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmguSkMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+Pz6D3oomUWhH6DA5h9xwgAt6P8ufrnmZmbvesFogEb
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAAkIAP9P3qgGA3cFPMEMNWpzAC53iQBq
UWyyTb/q8ofr+xgpKgD5AWYDPxObK6odFllgdP68I70fv5e/vG0va8YDQfQgoA8=
=i+Hf
-----END PGP SIGNATURE-----

--vm4v/ua71WYkkbsH--
