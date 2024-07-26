Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1A17B506
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996911; cv=none; b=l3PoCk1SQc/5jY9UG/tJFboqKpl01a9ih4EtHu3uj702PYMjEDJ7rIbw50GDQMPyMGFJ1pJDyAW1zLxv/nhmRoLss447n1TTGDnw3h2B3YvY22qDLOuc/FnfJGLoV2f0UNybgHyyEe6toMe87OLW9DUcQgk8pxUDeJZnl21T8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996911; c=relaxed/simple;
	bh=NWdRViLuSSga3JU1AFU1YKdW/jHs9ircn0tmBHV54rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuYfNaz0iHkTG9p5v0B+RPOUi1FnmFjDkhdB+NPx17GWYa+gq9l9m8oIe5zPqM/P8eGzAKrXRRzx8Vsee8w88YKHYExqTW3AyicFq+IU5QXH/gtoou81owBC+OFK0mZPARcZzFeR8z8tw3NIw+rNxG6OCy1Txo9PHLk1JFhZL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yk/6UWPB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eVHZZ5+M; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yk/6UWPB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVHZZ5+M"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 989E311401C4;
	Fri, 26 Jul 2024 08:28:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 26 Jul 2024 08:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996908; x=1722083308; bh=0wgXTzpP1u
	JrxEvYMk8LVYTL7aQ2/dPc+adHHvy+c+Q=; b=Yk/6UWPBjC0nLGSCKIB7T5qQdc
	EyFvtHYX3KfVIqhsgrwMYNCULXoU2/K6waXHqX1YmmaXhCHfMiDWuD5uUd7W+WCu
	X/JDOAcFpLgcyn+aK+SvLAFael357fmu2GXAHg8KDW3ctPo1KupTCJv7PJ2htGGJ
	vxq9kyi4x/9nFXEPD++cQURhu5YrCXbl5N3esjwphfBFVI/JYjTcK61p1wFlGkZ4
	XmrrMi+r4WQu3zGA/dSp147fJvLH0aqHSkHaH4cVNGWKmC6OjGT4Xxh6BZenzwhK
	Qebo8A+qUIWojTEXz7kbSw3PFLadJfihBeswgxozqY2Wi7K914zQsVdk9Z8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996908; x=1722083308; bh=0wgXTzpP1uJrxEvYMk8LVYTL7aQ2
	/dPc+adHHvy+c+Q=; b=eVHZZ5+MHPeuvQBj76WCAU2vUx7h52tec/2XHXkNWjXj
	BP4FIONVntTIHGW72pi4E+C6cFv7WER00k74cCGvqGpKWKoA76t6HqOD6lAvsHB1
	OtbQp1i7+VDc2BIa9A8fZeKrWWEnm2iqDUVkgvRlVMNW7CH/EBlZvcRxWGNPf6wY
	oDTnbDWP7FTbqpDXuK4ZRy9JbxJn/rwlMrrT4eZPRZlbOMzLVOfIBMyhZN4STQSR
	HhC8H197a80er6YunCBpSgOIQ+IykB/6HxeEft6WsLCAASGzRPTAqro1XvcxorEM
	Y0SRyrRK+JHFAI+0xSNrYQESjuOrMLGIsINHkbZ5Kg==
X-ME-Sender: <xms:bJajZqH0PGhW-Beo0aK5Bqf1sp5abuDLEK7ektroEuX6_MC9skwWHw>
    <xme:bJajZrXqHpAHGtXc08pAf5wds531MM1av0MJ4cPB3R7Xr0iXna3j06A-LCvfI0F_H
    tbWDQbqRHZ9E-I-Jg>
X-ME-Received: <xmr:bJajZkLlRHCeOuH0QgI0gaudR2nLrsS04RVBHwOS1JIyAPfHS74XjjDJcBFcEtauaqN-1sH3WIQnU3ZOhKoX3EjlIh1_XhbR-9bZ5J-nfHhjbeMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:bJajZkFVCo1M59yM4Kygs9F_asZi6h88llin57aNfaOf4LQqpVkApA>
    <xmx:bJajZgV3Loh7pQx7R91XpY6YoHJhYjnsl7zVWVwLBGQ6gmY26rlL6A>
    <xmx:bJajZnPHOUqDCqUr1nWEC-6U3T1OO2ZDIu8YcCjB9RW0E1QeeWdAQQ>
    <xmx:bJajZn3PbI4PiYF6aT97C1rYV2w5by8d9PDqckz4gJ8swpb-HwLnFw>
    <xmx:bJajZuzw5-U8mpZyHRBTuS9XynGPvi_KGhxr8eXfOurkfzM2CBOn_ePb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 08:28:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3c769d5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Jul 2024 12:27:04 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:28:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Alexander Shopov <ash@kambanaria.org>, git@vger.kernel.org,
	worldhello.net@gmail.com
Subject: Re: [PATCH  1/1] show-ref: improve short help messages of options
Message-ID: <ZqOWUrynjUN2A5TM@tanuki>
References: <20240724111116.91615-1-ash@kambanaria.org>
 <ZqH7mDh73vkX4bPT@tanuki>
 <xmqqr0bhldjp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="16F0NqFvj891JwZO"
Content-Disposition: inline
In-Reply-To: <xmqqr0bhldjp.fsf@gitster.g>


--16F0NqFvj891JwZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 08:03:06AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Agreed, I think that this is a sensible change. In practice, this
> > feature can also be combined with `--head`, so in that spirit we might
> > even change it to:
> >
> >     "only show tags (can be combined with --branches and --head)"
> >
> > Not sure though whether this is getting too noisy?
>=20
> It is somewhat an oxymoron that "*only* show X" can be combined with
> "*only* show Y" in the first place.

Yeah, this is the root of the problem why those braces are required in
the first place. But that being said, the option is somewhat funny
because it indeed limits what we show to only show tags. The fact that
it can be combined with other options to expand on what it shows doesn't
change that, so I think "only" is okay-ish even though it certainly is
not perfect.

> For a reader to accept it without finding it awkward, the reader
> must understand that
>=20
>  (1) the command shows by default everything, but
>=20
>  (2) if any of these "only show" options are given, the command
>      stops showing everything and the user can pick which subset of
>      "only show" options to give, which work additively.
>=20
> But if the reader knows that much already, it is redundant to say
> "can be combined with", isn't it?

Hum. I personally find the way that this is worded intuitive and think
that I would find it helpful when reading it as a less-knowledgeable
user. But naturally, I'm quite biased and may be too unimaginative to
come up with a better wording.

Meanwhile, I think that the proposed change strictly improves this
message and thus don't see a reason not to take it. Unless we see
somebody come up with a less-awkward solution, that is.

Patrick

--16F0NqFvj891JwZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajllEACgkQVbJhu7ck
PpSqfhAAm5C1FH3W6ZS/PEuPR7O0FSixzWsZ23FlLC7iUOvN9Cerh7NQ0hVHVThI
6XCn1FtLO89LMk7BpDJ8TyuJePlzeNetMhbY6+/pyh+penln3SUNKU7RGlnOlDZS
QtF4YkmJo1sZ9VMt0wwSzMMZa85xX/C0hpOBIuZ59mavLN01ZPD/zgkZAiTThi2b
bVHJxx4Wno56DtEurvPZIUTcXQPAXlIbMlw3T3hWK0wWwQv0vlBJmxgEblR7rByY
uEn+1FmG397SFff3P1frBNA2Zi2HVszPuQMv3J2SmFBfRcslRBXvRNotywiBt8F3
scky6qHbx8bSiUEPKvhwIaiPPjcUL04opTcGfg3NJSreX9bj9DO/7T/D3UPsQMP6
zQXmEyfwzo/qBBb8fQ5f4vnVTbioalR623Twa/gilRQGwzqKxThHKECL+eyWsRPo
YJsZDVfUQFelFIHMYZCL/N7omrhRUBGnRvBrfDfaWnvhoTraxB9Y6y4NzLUjAt5c
fBdbOHhUVswObLb29DqwENXUcUkmmLhRMK7WcgNpOdFoG76jiOWWq2864Nt+mWpJ
hUO3d9GbnHDd/JXSQsPys3GrkPPDc9spsysQ7PWKOTT+tP9j6ICFJ+iLolEh8DdW
zH9IXGaFcRWS8ckqg1J/szLP/r8YTGPUp1/Ps86pDzrrf6WIpC0=
=SZgi
-----END PGP SIGNATURE-----

--16F0NqFvj891JwZO--
