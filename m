Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6983129E6E
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663735; cv=none; b=qTETpT49upxf8pYR5n3QwWmjDamMlfWx8sRa7IjYBv4i343T8Edf9lS3EGuKMLKrIHBn830M/dtyJURMefoboEOdkju5FSBOknH3u9BfBy/6rIOCD8YNY1fptedXm7BIDPpVx0kE2+pxBrqIml51mrkSlLJYpsKi1zfR1rqLvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663735; c=relaxed/simple;
	bh=78ZYktBIrElKlklIsHF/MExS8ALF6ntZdpSvNOr6Xso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIro+Cu7/oIaawCghol8o0zlPlBcNhHUK4jG1QCnqnCyGMy6QkyldxPwty3mCHOQSstcF/l76JvM7lnt4bzGAx+HjHVqzip96ZjlQJEGr2WQvC/DwFxl+mYi7PIdaU9BfumgVqCxzCYmwsfxOjbOkIR44i47x1LcwVC2CykdGDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qn4Q6QrY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v+l/YNCa; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qn4Q6QrY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v+l/YNCa"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 6BBA11C000AE;
	Tue,  9 Apr 2024 07:55:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 09 Apr 2024 07:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712663731; x=1712750131; bh=heesfdmxyx
	iik5lTlh14vc4lc9fNzFj6nAkyL6jwRkQ=; b=Qn4Q6QrYMYVeCsqYpU9NsLSwlF
	iLCoj2641cKmdh4E9YU7GUGiNy0KTQLt2A45mDtuEgEJ3eR9s60T47tcrMW40qeB
	Kso/cqxr3Rh7D8dXJmaaLvFB7Jh/krhqmmEmQr0DC/tVoYDtjiFb6T0XzsSQHhNr
	ad1aJLUuRdFOXY8NIq3KwjfBQTEXxcSKPlpBDuetF/i6KBQ/t+5/+Ls22AtOi3rE
	1EufVa742ITMm/9ecRfG0yEXk97X5dgBWAxD8Gl6/jb6h+ir39mvb8pjuyo+4cIJ
	ArML/QQTAk2aefSgaaUckD3oYLQ2yisIKqXVa5uZ19VyFWygExm4UH7igMWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712663731; x=1712750131; bh=heesfdmxyxiik5lTlh14vc4lc9fN
	zFj6nAkyL6jwRkQ=; b=v+l/YNCa0j+YVdqYzZV44edrnj7SieTUIu4RxNXM48Vg
	LOeUzx/MD/fEr0U11PO4gT7PzYZCdqapuVDwK22d7ZoAbTewuUjnjmRqRfyjrMjH
	ZvB+w/xZCYJAgelcUnH5EEcFHshOw/Shi1sjwWQZQQ3z9vGrrRWPMPBtovFKTZTX
	y1DjLXGj9KFNWXF96EvE1lBRxIw011JFGRdmSLqPeJejBxRamJEYFeVBLjoEcwNk
	v8nf2sWh9MmYJYNjzY8xfPzZXeoaXTsYnU0dQep1rGYLvfKqzwqgIAxf7rgsUzZq
	f4+XzKaNiqn9hvO2vZtlur5FfVbVAaIZfG6deQvjMQ==
X-ME-Sender: <xms:sywVZm6QbJMb3A-oFkltpOIXURDnKLcrWAV4geK9CQjaZsknBnVncw>
    <xme:sywVZv5uWiDBIEE8s975bGwlExqWqGqwlMPGjSLqcHsuSQhpf5zWGlPy4bYGQHjrz
    APxFW_23V_NguK6rw>
X-ME-Received: <xmr:sywVZlfOwZP-bEsRS2hva1QEyRP8worgOHCvue0gBSiT4JBNXh6YSpqZXsRZnPp5Yki1YMQLZQBUhm2P0MIMBMf9k2iwbmhGkETRp3vk6wFy4gfam_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehtddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:sywVZjJx_vdd1zrtvr1-ag--UDINVQrMgFNvkhQmHfqzgnt9VttNjg>
    <xmx:sywVZqLiZCNHchgK9TPULCETGmW25k8OJpvC_AJQ4ti0H0YiO0rfKQ>
    <xmx:sywVZkyn0J9qcL41X9rEbr9_Aicn_5nq9_bEvsp0F2gFmLkjIXsbfw>
    <xmx:sywVZuIU0xYBq1zWAjpDHLsOB48OiBQ5Q64Xgokb0X0iwcF8na3dGg>
    <xmx:sywVZvGdycK7JCBGPVmnxP6GUixPr8SkEXDHkdolUoIfLoF02cdvS-aR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Apr 2024 07:55:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id dd00ffb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 11:55:20 +0000 (UTC)
Date: Tue, 9 Apr 2024 13:55:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Chris Torek <chris.torek@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
Message-ID: <ZhUsrolJ0_HOH1eU@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240330224623.579457-8-knayak@gitlab.com>
 <xmqqy19yf40l.fsf@gitster.g>
 <CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
 <xmqqplvadmeq.fsf@gitster.g>
 <xmqqle5xeun1.fsf@gitster.g>
 <Zgv4H66NmLZ_o1IC@tanuki>
 <xmqqil0z7m5y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kw96IuP5yZJhzZRb"
Content-Disposition: inline
In-Reply-To: <xmqqil0z7m5y.fsf@gitster.g>


--kw96IuP5yZJhzZRb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 09:40:41AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > because they have been supported by Git all along. It simply makes our
> > lifes easier when we don't have to special-case creations and deletions
> > in any way.
> >
> > So I'd really not want those to go away or become deprecated.
>=20
> That is a good input.
>=20
> Do you have anything to add as a counter-proposal?  The "I do not
> care what was there before" update mode does make it necessary to
> have a "zero" value for symrefs that can be distinguishable from
> not having a value at all.
>=20
> Thanks.

Sorry for taking this long to answer your question.

I might have missed it while scanning through this thread, but why
exactly is the zero OID not a good enough placeholder here to say that
the ref must not exist? A symref cannot point to a ref named after the
zero OID anyway.

In my opinion, "update-symref" with an old-value must be able to accept
both object IDs and symrefs as old value. Like this it would be possible
to update a proper ref to a symref in a race-free way. So you can say:

    git update-ref SYMREF refs/heads/main 19981daefd7c147444462739375462b49=
412ce33

To update "SYRMEF" to "refs/heads/main", but only in case it currently
is a proper ref that points to 19981daefd7c147444462739375462b49412ce33.
Similarly...

    git update-ref SYMREF refs/heads/main refs/heads/master

would update "SYMREF" to "refs/heads/main", but only if it currently
points to the symref "refs/heads/master". And by extension I think that
the zero OID should retain its established meaning of "This ref must not
exist":

    git update-ref SYMREF refs/heads/main 000000000000000000000000000000000=
0000000

This would only update "SYMREF" to "refs/heads/main" if it does not yet
exist.

Patrick

--kw96IuP5yZJhzZRb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYVLKgACgkQVbJhu7ck
PpSP1A//XWRTLixmg2FPCv0pWK8KYN4lJsnFZFwz6Z12UEJ8ziTv0e5lVTFX8Smy
zbsPuXTkF/H57WD2Li3rn2sRzoJet05MWvmcTixrzOfhKmpFr7Vx27rlvpyCo5Oy
hD3VI/gWf+Bek4QmFlB67bcsVcOSWTAYjhlJeNUXV97kf/cJl3LDVNEgBD8PbAg4
whQMDbIo6GNCc7qsu7jWUiQ6vagrNom8zLYEpg1BFcFJQ8rnNyff1x+VYzD35b9z
a8nAXKEp7me/qg6skQ2D3mRYmj1lOvg4pYiN0pleHm34tABCDDBXAGf0UI3WuxDk
LmTLvyv6m3YEnDBUS2wsneJKR1OSYWAaEPnSYFwc7oaIXEndvjlFjLss2GiXUUHG
tJTohe57diqH5JBITS2mwGUjpYOtN+2qseKtkYQ3yFOyqLNsZw165VI/xlp35x3m
3DDFemO3UOUavGQvXKDEbiP4XJqxLsTEH04xdA6Ct+fVFycB0Sv9fXBJWSgdugi2
a0RX4smhTLaxoAe+PhsJwo6e/JVsQS5LbQtGJ5An8JBHacYPOrwBNyzcdjxCfrbQ
1TjwHHEWB2hD8QkBfMg+6LEzzzZgI7Fj/FmkJhcuFnBcxX6C7sRXsFvrInohDfJh
xKBOQxlNHeH3ETk6wxhdtjH8pxfGGfhHB7bcDhBOIYA82MHqQkM=
=8nRb
-----END PGP SIGNATURE-----

--kw96IuP5yZJhzZRb--
