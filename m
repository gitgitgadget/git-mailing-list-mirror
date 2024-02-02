Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605EAF508
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871138; cv=none; b=mVHxn84Aqu0A4oUTQMiOX0mnEl4pVtSRpICUqqZ3JGSwQDB6SxiNzHdfR/XJ3JNtXYBPD+qKl62cAPQYh/SQsk+L2vKRenkYrDZgXgji1CTuC06z/E8XDNp+1dtWhcpURDIOcyz5DPd7OVkYJ78kxHer4Hv0ak7xDccs11YIh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871138; c=relaxed/simple;
	bh=+H1GSY1Dg9cor9KGXg9CgNRRQ02W10tTgrZcep8e2vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDO0VREaDlOINUQwCoHblfwTpojNdCm2JhmgRtTs9eIMUW+N8J18cbystfEVNk7CBOYEeUaf+pT//5G6n8FkJo479oEAi+r5D3eDiAuSldkXMqR6fQrPl2YD74zM8R7wDbQfGZWCXDXiJSddShp5joB5cyPCbuiDSiIOCM7JO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UiPvKthQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sdcUrd1Z; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UiPvKthQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sdcUrd1Z"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 2A43C5C0101;
	Fri,  2 Feb 2024 05:52:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 02 Feb 2024 05:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706871135; x=1706957535; bh=ytUEB8Aw8h
	QYVSNMlTzzV1tjbw45i/16zxZmVFiftc4=; b=UiPvKthQpPUwqyR2ro3JzdcFW8
	ubsV4QhtDFOG4kesGasEk/eWKy7+PWc5IpajgAF8GEB9SSNSbIXxcrUJe7IXpKmd
	2V3rxbycvEh9oxu/5jtJghKqj00pjJ0TkT9fhbef03C82qgforc6NwEWdjLEAOqq
	rlASI8DQ9qINUXezf7t7qy/GD9LJdZHReTAR2nHWSUH7Yn7Oiv1xNI82Gi3alLfF
	Cz7iqMYZaXrqDGh5r1OJvxD8zmQvYJj+6L0Rl7SJoOXYMyx+rqA8D7uv2FhGmmrT
	SJ0AXw5t05FTB/g1txhyvcXrcQH9IMC1736e4vdyljEEPhigZoSqVjhqQLKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706871135; x=1706957535; bh=ytUEB8Aw8hQYVSNMlTzzV1tjbw45
	i/16zxZmVFiftc4=; b=sdcUrd1Z0iX+/1QqUiSG+pxxkMl+n/+EE9/8fqbncx25
	IbegntbRBooQkv7LUGDW7y00JegusgfNiVjWtgCm8ZzElNwggcnyYhcuXpiJj1Hk
	ewgFF6VQroCvmkx/HdzIPztnWml8irWszOQ9VnT+DuH1To+vZHkOBgurB42uI1a8
	dFx4f/Yx/Xj+sOYRgOLxJz7+ljmkXmo1iZ7fGoCph5/Jn343QDLom3F6WeKZRjkE
	qhnEvhrZO2s5vwYGgNCT2YyGTPs1LQxrUDJ4LnMt0ARQTexiZ+XDnL1vtXRA4LWC
	7VmnvVdVLyI0DrfVA8P9+lnbmjYeyCW/a68mCtFbww==
X-ME-Sender: <xms:Xsm8ZSyOz1N7YWiZYDADk4aUm4wj-CqU9i8UKAvLWryGWpe5C1yQaw>
    <xme:Xsm8ZeQsoakZsm8KOx-yhioncTP-VXwZS9ljtR_-RkLJmMrA-2g7d_vu0625j9lJC
    VAvmwHljwJk7ZjFGQ>
X-ME-Received: <xmr:Xsm8ZUVNhRkHSJIHHVNFv09ISeM80pFgbtqgox_Q4Us-eic0oN8gNnM6Rl8S4iij3Agn5nsSlP0M8Q5oM8DDaSGXTKhQDnMW_KzVwua7SHQr1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Xsm8ZYhQrfdhC96dmfPs0HigWoD4rxVThVS96wBC3IpDvVL5H_8yWg>
    <xmx:Xsm8ZUA-yZRKeBOaJLYoo3bZFJbYLWMd0i4UC4mIv6Ffn9fye0RH7Q>
    <xmx:Xsm8ZZKdg4tMfJJs-oDyOVKD8yfOd10I-V896PMUmbAV-4hSzgrZaw>
    <xmx:X8m8ZXPTpadShJbujBZeb2aQ0E1Rm5Dyo8CjZ9gXGKEYRIi_2HAiyA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 05:52:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b6b9853d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Feb 2024 10:48:48 +0000 (UTC)
Date: Fri, 2 Feb 2024 11:52:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/2] refs: introduce reftable backend
Message-ID: <ZbzJWo-DBpGZiMO4@tanuki>
References: <cover.1706601199.git.ps@pks.im>
 <5598cd13074beef092a61235a505476d0cbceb90.1706601199.git.ps@pks.im>
 <CAOLa=ZTrPuRAbkDgg1Dh4M-3o58Rw1KruAMcw47o2V_LrK9KPg@mail.gmail.com>
 <ZbyoL3r7yEVYe35B@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tNyzHsM2cCgxIZwg"
Content-Disposition: inline
In-Reply-To: <ZbyoL3r7yEVYe35B@tanuki>


--tNyzHsM2cCgxIZwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 09:30:39AM +0100, Patrick Steinhardt wrote:
> On Thu, Feb 01, 2024 at 07:17:45AM -0800, Karthik Nayak wrote:
> > > +		iter->err =3D reftable_iterator_next_ref(&iter->iter, &iter->ref);
> > > +		if (iter->err)
> > > +			break;
> > > +
> > > +		/*
> > > +		 * The files backend only lists references contained in
> > > +		 * "refs/". We emulate the same behaviour here and thus skip
> > > +		 * all references that don't start with this prefix.
> > > +		 */
> > > +		if (!starts_with(iter->ref.refname, "refs/"))
> > > +			continue;
> > > +
> >=20
> > Since my patch series [1] to print all refs is now merged to next, maybe
> > you could add this in?
> >=20
> >     diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> >     index 895de0b273..3f4f905292 100644
> >     --- a/refs/reftable-backend.c
> >     +++ b/refs/reftable-backend.c
> >     @@ -348,11 +348,10 @@ static int
> > reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
> >      			break;
> >=20
> >      		/*
> >     -		 * The files backend only lists references contained in
> >     -		 * "refs/". We emulate the same behaviour here and thus skip
> >     -		 * all references that don't start with this prefix.
> >     +		 * Unless the `DO_FOR_EACH_INCLUDE_ALL_REFS` flag is use, we only
> >     +		 * list references contained in "refs/" to mimic the file-backen=
d.
> >      		 */
> >     -		if (!starts_with(iter->ref.refname, "refs/"))
> >     +		if (!(iter->flags & DO_FOR_EACH_INCLUDE_ALL_REFS) &&
> > !starts_with(iter->ref.refname, "refs/"))
> >      			continue;
> >=20
> >      		if (iter->prefix &&
>=20
> I'm still waiting for your patch series to hit `next` before making it a
> dependency of this series, but thanks for the patch!

Oops, didn't read this carefully enough and missed that it already is in
`next`. I'll adapt accordingly in the next version, thanks!

Patrick

--tNyzHsM2cCgxIZwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW8yVkACgkQVbJhu7ck
PpQOoQ//RMdiUTH2vJ9kJt9oOGoFzcRNbMlpE5l9mbwwxFj+O6XS1wlOMeQdW0PF
2ZzNv9C+bfl1ar83HXtMziavpwoFip6beW5hQJ5jkbl5yVklxIepwhyhceSOMUpt
5oQuJgVbZIIo4ptYesTm8WiWeeNRyrw28sNtDDK1ST/ZE7RDBs75swrChcWrewIo
QzAlqOwtNB24BswnMRy9q8RAgh6U6d5Tdv8RYVuRu4v074xUOT+/GjA+1HJJqoD/
jdNHQdoSUWrCWGR7D58SeoMj8uJ6bBNOGDQ9OJuk3JSotWZVBMZ+/ujbhS62EcYX
mJvCA1ow41To430/DnB2rOtdwyDK7fEpacV9TEyy//txTBnTqug2rjFKYzcBBq4d
wEjhaJH6G5Mk2+WJJGlA1gUbpcGWoVhWvz5k69P7uOcGxLHO+v/AUnNlKw9ANn2H
IENakdUZGQdC1ihPfjtpBa5gNrKYpNDOzS7KM84gBHEpKzu2aopmUNV4wjkheFTt
tes/VbUcbzC7KLtIljCTnC4gP/KDQPYCGYbDYwpVW3Hak8+EPQ1jvNx65VIh1rIM
8Qd6CZ/fZPWanPGPwigGRAxGsK7m/cSXtbVK2R7J5MWdTxkPTukncNDJMf9sWxaE
XgyYleJ/aARt5orl9rPRxYD7GFDIzfhT9tk19Z50KSD1LLjNzzc=
=FGW1
-----END PGP SIGNATURE-----

--tNyzHsM2cCgxIZwg--
