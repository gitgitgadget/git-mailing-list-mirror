Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3BB13B780
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 04:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722315320; cv=none; b=J3zM00f2EZse0vNtS0eaV6vEfY+twacVUFFilVjoMWSGMX/szrvX45r345ULLfeeW3/ZpDQs3wULJJcPcteHhU+V5FcclYf+Whq8SvSEG6rkL96dmmvp/xpbB1hDylYFGvOr1uw4Dd3qBKwkVsvjpqvIRLyoXqCz7KL/xpD4ofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722315320; c=relaxed/simple;
	bh=hFSK3MOoXvphJhGinSRW6QUQHLzvuVI0fj+ntJgmSmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahs4xK/RO13B9fD0Qabza+dmaWfr7Cpnuf8eWwp1ccROYkApjpE4NO/MnE7/pEqFY7OJCBvGR3oXlJFSDJ4acd2jS6OePZwFLTpDH+CIOQHUJjhQ101VvO9bEFZz5Serx74M8fKjTvQ+lPC2d/Cq0mMH88ia7ehfcopF2X6GRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OkRXO4/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hz62xCh6; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OkRXO4/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hz62xCh6"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id C816A138080E;
	Tue, 30 Jul 2024 00:55:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Jul 2024 00:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722315316; x=1722401716; bh=ITSTkMqgEt
	cRPWBTAQYUt2TTwMycBlxlpqutEGGBUNA=; b=OkRXO4/Hpf8RPyzhq4SUnv8TYe
	RVgz2PrCd4ibcOL28447ZumYxgXAwxQCZN4irKrZn5U4WMXmJbyfz4tXql07Khst
	fgbnrtR5mdRGou1tRJZD/HYVFvh3OwdE02CBcgwB0hjVXaKNYjsGTGXiPF+/7Ib0
	fIY1rbDOwJxwbISd+n4ABAfSgz09z20omtPa7Xip2fu2WMu3PinYA0tjcLScU0bP
	DzslnZuNJ9beHSgBrgBt4zc8RRWCKYtNYe/jTrN2o74kbXy8ZjL0HrGH6/qlPLG/
	slJ40Bt3olL0w3T44eG758uflyHhi8AnZ06trmCGzBhzNSUFBU82PnSVz5qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722315316; x=1722401716; bh=ITSTkMqgEtcRPWBTAQYUt2TTwMyc
	BlxlpqutEGGBUNA=; b=Hz62xCh67n85Mqja/6F09HhCbR/6OUZmh6uOm4jnrl4K
	mIWLeGOQraTYaGu6kyc/Z7p8PhxJf1Bon3GS1wIyFsbYOo4hAOjCvcCwKQ35nLF3
	hA/ZNicILKS32ILibFIuYApOG1MOEGt2u2ZNcg16pBosRV74Wy3LqNJiRbmKPqX4
	BQ3fQ6m2uAhwhNky6qiB5KTzvR4i7ssWW9knvgaChcf3sziMMz/TKifjSd4FfM5p
	JkFxFE3NAOemR9c+osCsrkgkAhetjKquPsrBpEw/UfUomq3FU69vZtUk4zQ2qQ7R
	bFjz9GOUlNRM0X7Tsl9G65LGemh/d/YxENWzgsnvOQ==
X-ME-Sender: <xms:NHKoZnnhYSZP2adoBwTKCZ-bOMRP93yG2FdZNnD6vRsIiIwb3t2UNQ>
    <xme:NHKoZq3SwVn7Dku3mLJsmWGq5jII2rHNNrBcYUyowzn1ZliArMC3XEoY35XgLfpk_
    YEzN7Z8NL3eXHW_gA>
X-ME-Received: <xmr:NHKoZtp5qo8FdvUyWiqat_d-yeeWVOkDOQ4RXhj63jrP2Z3NJtQWkYjgZk5zLGM0CGk-Tb5wU9nvhnwQdjtLyiioe9hzTnrpAUfFqAsnfe7prUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:NHKoZvkp6_ry841u5f8_4yrlDHcTXk2OF5ud5NcKbeO3ciVCMUIDBw>
    <xmx:NHKoZl1ZpvnKWYGf4cqSvTOaUoLhbBaVA1qOBuRGLSLaFyat1i9_wg>
    <xmx:NHKoZus2wEjhksW8NbIcjfu5wYqVKg0o_HVOopb5dLUok7JXgqmvNA>
    <xmx:NHKoZpUVcIjtj6Bt73VVxWvVIkpil0xESLp8Aq2UZ-s-DwCNt4-BQg>
    <xmx:NHKoZjBVLupbELLasdxoxfliqtKC1w3rUC5fsFGynYWq-Nw5K-aYl2sY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 00:55:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b5c95218 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 04:53:47 +0000 (UTC)
Date: Tue, 30 Jul 2024 06:55:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] patch-id: tighten code to detect the patch header
Message-ID: <ZqhyI7Ta9g_4AwfI@tanuki>
References: <20240621231826.3280338-1-gitster@pobox.com>
 <20240621231826.3280338-6-gitster@pobox.com>
 <ZqeGBJrqIrU2A4jl@tanuki>
 <xmqqwml4gdol.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GZ+P2cn4pnSpM3Oc"
Content-Disposition: inline
In-Reply-To: <xmqqwml4gdol.fsf@gitster.g>


--GZ+P2cn4pnSpM3Oc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 01:12:42PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Fri, Jun 21, 2024 at 04:18:26PM -0700, Junio C Hamano wrote:
> >> @@ -196,11 +211,13 @@ static void generate_id_list(unsigned flags)
> >>  	struct strbuf line_buf =3D STRBUF_INIT;
> >> =20
> >>  	oidclr(&oid);
> >> +	flags |=3D GOPID_FIND_HEADER;
> >>  	while (!feof(stdin)) {
> >>  		patchlen =3D get_one_patchid(&n, &result, &line_buf, flags);
> >>  		if (patchlen)
> >>  			flush_current_id(&oid, &result);
> >>  		oidcpy(&oid, &n);
> >> +		flags &=3D ~GOPID_FIND_HEADER;
> >>  	}
> >
> > I think I'm missing the obvious. But why don't we have to set
> > `GOPID_FIND_HEADER` when we have flushed the current patch ID? Is this
> > because we know that `get_one_patchid()` stops once it finds the next
> > line starting with a commit?
>=20
> Yup the original control flow is rather convoluted.  The first call
> stops when it finds the header that begins the log message part and
> returns, but the subsequent calls are to (1) skip the log message
> and then (2) parse and hash the diff part, until it finds another
> header that begins the log message part of the _next_ patch and
> return.  GOPID_FIND_HEADER bit is used to tell the callee when we
> haven't found the header (hence we can stop at a line whose
> beginning looks like a hash) or the previous round already found the
> header and we positively know we are now in the "skip the log
> message" phase (hence a line whose beginning looks like a hash is
> not a new header).

Okay.

> > Makes me wonder what happens when there is
> > non-diff garbage between patches for which we are about to generate
> > patch IDs.
>=20
> "Skip non-diff garbage until we see a patch" is the mechanism used
> to skip the log message, so it would be a reasonable thing to skip
> such no-diff garbage between patches, no?

Oh, yes, it is reasonable. I just didn't quite figure out the flow of
the above loop when reading through the code. As you say, it is somewhat
convoluted and not all that straight forward.

In any case though, your changes improve readability, so the fact that
things are not quite straight forward is not the fault of this patch
series here.

Patrick

--GZ+P2cn4pnSpM3Oc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaoci8ACgkQVbJhu7ck
PpT6qBAAp7VvpnXhb84cqwGR77FzbMOFZvd95VMUXHcoYwRHPLyEWUjTNSigxNpa
gbC/HUE/t7uN6Xn9KFoKZJAq+dvE6YQrLVLBqvZS2yynP/EcV+MqutxWe88Ta4xv
cJwsEO+ydbTOd3CS2EAdq/++h1SdhkSDRaPuV8H3bWywWmSEJXH1VjJQ6vPUiHmu
Gwq6uziIfU2A9KrqtRZsFByL0Jinw2efUecJnyFs+cUbeb4GmygC6+y3d0p4KEH1
pnt6Hx0Zm3MfTXXXtD1SfwHX4INtXPm5JQDDReNsOyizEPyNSetRWmMQfHppOw8a
Pl+hco8Mov3e5745QI7bCPZ+AW86yUJbe8mJev9lN4fSSaDRX7ZlyUfztbp8cb7+
r/4uiP66EUquqd8xTurvZ6AExv7RRCCQ6RVJ5TOWXp2YKvIOflMhz261YcG2tRFl
BNL5mlGrV4ZnFbCWhPaG3xtEt/uHijeVxdKoVcE2uVm54UViI0hMnkKTpzn+xixt
NJ3ZblFGt42wAtHb7saQsUFVaiv20FiS7qB1dnrp1cslC96A6lS5X+vYc2cZjIvq
6chROssV76lkqmbi57toFDM7LQnPh8LpGH+hK+wE6amHMReH4P7AvRc4rynzKlkf
pqH8xWh337iA4IhbnMXODgn/1lFAcDKMMl8cYQru6Ias06p/5/c=
=d1Ql
-----END PGP SIGNATURE-----

--GZ+P2cn4pnSpM3Oc--
