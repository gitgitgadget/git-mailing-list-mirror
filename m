Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7C15B0FA
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925056; cv=none; b=tlROTDZgHeQj8CIQ3AnuxRzmSZ3tvqiMw4rfrXKKWzqhlmZuRH44SGeOh0kSh+JG9C8+NXGvM0tgAw3N5EXkr4a72HaJW5dR7KHeeOWEwNoNiUjQ4ViBAHkR8rweIJD9+EHeJbwPtvkesiPXRR7dkuW6vpqqLFn8zTkZm5s3Sk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925056; c=relaxed/simple;
	bh=cCcxP8neC/x0gR4MtlQPAvyf/sc9uo9zTxZ9wv2JUS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GevoEvQ+borcBYuqHFjUPdvuvU1h/p1z6idQqcdKh4R85mynvXb+NgHN8CHTs4RIw3D7rB0mMXfsdXyxmBQ/HRBUhY4C+q0+ObRAW/gQcFag7gjUXkM8aQ9n+hhfZgUUHePEq7g1b5DDj/Waf+H0P5EfAeuPH7uTRNlONMGCntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C6R2QeOI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pv6tx9a5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C6R2QeOI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pv6tx9a5"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B58EA1148184;
	Tue,  6 Aug 2024 02:17:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 06 Aug 2024 02:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722925053; x=1723011453; bh=XG73HyuZ3Z
	p1rXNlE3JeAWyVNN612jZFMIZqVTVAcDw=; b=C6R2QeOI1vh1v33bKbdWkEU+WG
	rYMxqtjJWVSs+XsvEtFGCpoRwxQMEbstTKfdJaOGXSS/EaluwFv54nMrt+J8D63z
	omnqvHtPIqzfCtAQCVO2EmWpDUwRf9H8+sTX7wfdtquQIbvDQ5qgFgmzB1OkiQ1y
	SKdBk3sVVSwJln0uo9s04sS5HaBoD+snyYYSx0OQQaM1lJO9LkgMvxwxcpjzcS7p
	Bf7suY9MRm2HnbNpOKccZWDKOovpSERhXq9A/l62xrwWP/wlnyustXeAME6y9OAd
	8Y3ljakyPJ1LrJT1875rh7OjE3hb15/apr4oBOm6lm1NusgzFx1usr4zDyAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722925053; x=1723011453; bh=XG73HyuZ3Zp1rXNlE3JeAWyVNN61
	2jZFMIZqVTVAcDw=; b=pv6tx9a5dZNJC5i/Hl+PXjyDPBwcwKKj+qmrXdqS1rLc
	n4SruyuTeQ8wET82fgkfJq5Z8fM9wEL75LGEVIb82dNrp+1vTiprGWYFeh6FGNss
	M8lui9QdfbD1Qvs5+djhOtRd9TOQ+D2Jat9JEPiYWAx2qpnn6C3dP13NCER3N0DX
	lfMoc8xFRk5JAZGHXEgjWWkZ8ZcKZJUaA8FlhqRId1ObHDWGz8rSOgD1DwyTuVUW
	S0R0JJ6uREj0fWRVyVo+fziNApdRuO28Uu0LnaRc96L65+IzOVf9wh41e9m851D7
	GwSY+HQY+iq6HD8n6xSwBiJxKWTZRn0sKZGfi1/fbg==
X-ME-Sender: <xms:_b-xZm_8n9RWidQF-0YH8Z2-ZG0GZlmiEYsCW8n6h0bPDXaWq4RiMw>
    <xme:_b-xZmtRNIVG9N3c1MHkt6ucaf__lmXnsQr3qPo-kVKRi0ld4SgIyBCYAJR_TxjX7
    9N4IFuT2bhAJqFCUQ>
X-ME-Received: <xmr:_b-xZsAkcYjyo6hakSTifU_GZtxW9eSFayZ90pWKkU7fVvK8xKXGpX-RQih_XdL50FLyMADY8Gt0JlA-CSae0wRjim7d1Uc4jSygacrFnvuC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:_b-xZueRFGWkdXdBDPDyWYOWeotIyaNjK-Z4Y5Hsecotp4jBD_buug>
    <xmx:_b-xZrNtD5TvFbtLmPAmLVXdUI2rHgvcXcGKCxtImviyY6CydUV0yw>
    <xmx:_b-xZokjC8Npd93XrSVAomblHs0htGahOZtTR_feZ-iagLCT_Okxxw>
    <xmx:_b-xZtvIlBBrN1s-AmcJ1lKor96rhttAqjs7eSq5VW1o0AMGQdIFLA>
    <xmx:_b-xZm0Om3sT9wg5WeuAm-MBHfImPEDa82aMUvnLms4TuW-6IFmdhLiH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 02:17:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f68ed829 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 06:17:29 +0000 (UTC)
Date: Tue, 6 Aug 2024 08:17:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Han Jiang <jhcarl0814@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] config.c: avoid segfault with --fixed-value and
 valueless config
Message-ID: <ZrG_-Rgi85bswmId@tanuki>
References: <c78bacfa8fb274fbb48f259b13f4f30253932f69.1722532013.git.me@ttaylorr.com>
 <ZrDH3ryOO0wIJIDE@tanuki>
 <xmqqa5hr55yb.fsf@gitster.g>
 <ZrEsIhWTgkdNn3I/@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SvbEA8ngQCIAayrt"
Content-Disposition: inline
In-Reply-To: <ZrEsIhWTgkdNn3I/@nand.local>


--SvbEA8ngQCIAayrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 03:46:42PM -0400, Taylor Blau wrote:
> On Mon, Aug 05, 2024 at 08:45:32AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > Edge cases like this really make me wonder what the benefit of implic=
it
> > > bools is in our config files.
> > >
> > > So... why do we have them in the first place? Is there even a single
> > > good reason?
> >
> > There isn't any good reason to introduce such a syntax if we were
> > desigining the configuration file format from scratch.  It was added
> > because originally Linus thought it was a cute syntax, and these
> > days a lot lot more importantly, it is kept working because you will
> > break a lot of existing configuration files that were hand tweaked
> > if you remove the support suddenly.
>=20
> I agree. It's perhaps interesting to think about in the context of the
> discussion in [1], but I think also worth having some perspective above.
>=20
> Sure, this configuration syntax would not be invented anew today, but I
> also don't think it's worth breaking existing configurations, even in a
> hypothetical "Git 3.0" release.
>=20
> In some sense I am sympathetic to Patrick's argument, but I also think
> that having a bug in a relatively niche feature like --fixed-value that
> wasn't noticed for almost four years over 17 [2] releases isn't itself a
> strong argument for removing the feature.

I was really just wondering whether there is actually a good reason to
have it that I couldn't think of. I certainly think that this feature
shouldn't exist, but also agree that removing it now would create more
hassle than benefit.

Thanks for the context!

Patrick

--SvbEA8ngQCIAayrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaxv/gACgkQVbJhu7ck
PpTDGQ//cjeH2ubc3rtoHiNANY3G9/0WrpdH+rvkIF+cuH2mXJNCgXJ6rsIl5sIZ
KmXSdPaoj5CBkOx7AAuLs4hrhIBxgg3fZJc1k1zflplDKszv2MNRyk437j4vtTC8
WVHvVAy1rVOIpaiL6xmeFRtrSft+r1GjBWFcKG4kpEkoGXEWiTcPTIKXfdj44XXo
5Zhe85vSN3CHFJSP6lQOL9To/Cn6xSXJtekMpZjBwRo7b6FUhAJaFbV0c0Wn6cgg
s2lLUiu4G7j7x8AI6Sq76bNIQMsDYqgtVNkGARbHELYLwoniO7rciGG4tL4LeUJF
lCUJrkCQR9nA+LIr12yApND1yOow3K6BD2BP/9hEg7h3YxTUqb55il8t379om+Ra
fc+t9cgmqBMzDOJ014k4ZBeeJ40Xg7HKYSRjBnNXomCnxc+DM3GbP9gF6GpxE5He
5rUk/f9hLZkL632sQRSP138M1SAqoG9vj2TFpzbjfqss8q4IxTR3jCKBiICaoEAh
fettA5bQKNHZhp3igUiMmjqtI88I13QhyRe5kZE5YsURDxoiyNPpNfwpy4fMQyPb
xcVhQuLoOjzLEmyXIi0GHUk/2/R6uIAvw8isTnTBPTcayj+rUbWWBYCfYw93+9GN
x9f2sjm8KAFn8023tVHKApFU/GNzIUxGkgWhOWgnKueVgslkcns=
=KbNN
-----END PGP SIGNATURE-----

--SvbEA8ngQCIAayrt--
