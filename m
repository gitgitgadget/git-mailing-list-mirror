Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE171FBA
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649482; cv=none; b=WCuyXeA44ztqlt3a5himE1DIjrrc7h/ViL4COmAXH71Sx/9S5EYTrFZESobu1jFKhmvyO8B6/LgBiAHAJ9/BQ5u//VYbIckgyms20mT4wfyXtwcHGN3q2nXmlYm6PMlpEVaZytyKkMTx87NMSk7OSqNE4QxaGdyRloCI0I7Rn84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649482; c=relaxed/simple;
	bh=E2dyWavcNszzLM0iD+kTy7NUIH2fkLzxAIWYlfrMamY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZo6PXJvO4b61qh/JKLOzfgq/G/6aAScu5o7FUBCHj66rJOavxkuKSAoFN46Wig2cAjA2l4ntYMJmOck4K7CE49IFLM+W5BOF1CCwzk1c7YDxz31UF6ZG/cNQ9b/67rh1trZqTlm9biQAir9VcaWOCx5c1PbB53l7W55bndoGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bZfv9v8o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CcaDDmLO; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bZfv9v8o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CcaDDmLO"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3088A1800186;
	Thu,  6 Jun 2024 00:51:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 06 Jun 2024 00:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717649479; x=1717735879; bh=36bJ8uf7KN
	DVkXCy4JunBVTRb5E/m/cEafncE6KgE1s=; b=bZfv9v8oKD5wqGF0ouWsT3+4xP
	nRA6+CkleYOikveSYMero1tF46E3yC6HzhBcQ/aMC6yvE3mmVRxZXWfiJLaZTQ8E
	tOHNjEQZrfNxxG7/mqxrQN6z31l+/qfBuZBQmyeTJOvOmZPq81kxvVjYeazlYc4k
	aMzk5MnKwjwMSEVyXDD9MvJttBAcCI/dW5Y+DiLJmjbyPj1Bbl0bIVEWlr9RipJZ
	rzXe8z7clM6ifbNAeIEcSMAFIkynl/o1L0SlPXDH2G5/AHSF2OybZcAfgZlPRHwi
	R77+asWPDQA38y1sGLi/Mg0HAfLdi0NUvRgL6tI3E11PuPx5oNGyh1piAbsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717649479; x=1717735879; bh=36bJ8uf7KNDVkXCy4JunBVTRb5E/
	m/cEafncE6KgE1s=; b=CcaDDmLOTN6a0blLAbTKLjDAwSw3oZcMPCgmhqu0WEyD
	qfRVR4PMf35kgExBbWe2IPGnlHG1geTkv0ktO0Z4FNZqdk1UwJ1Xo1j+cjRlUpSY
	Sopt/JhTvsfHjvkYQYTW8J9QEDe0pPnugyOgd9dwDxJNySHxBw0x2rhQR/6cfxdv
	mMGNW5+tjshcy5j9ux4hhctWszti/B8WKJcDLwkQV3as2e0yj38p3b8XOKe09W3g
	briUjUAO+XqhzZKm4H1lSNXk6x8oBbxCNIM2GbxboWQPWf7GM+MUdL1LVef56qVG
	PIZLYKk/bmRtIvJext+PfilGTpGaLqYLa0wMnPBs8g==
X-ME-Sender: <xms:R0BhZtQ7u_FqJXJSEDv6Dhz4MJvc3lyRpPv-dNs0_dfLRjNkbS5PRA>
    <xme:R0BhZmwN32uxHwJWRcrLBcaKtXTxf3w0WbnOOBb7STxjlYBDPgFwM5EQZOpuBtbnh
    mHWNpKPnKN9vq1kqw>
X-ME-Received: <xmr:R0BhZi0X-FJY5vwrXUY3YoUxWYa2N86lCueupfwYCQhNmzJKXPtHYvvd2QhWTNXL8ZqYpcQqBkffxpKsMcUT43IsIkXOjMCZukfKOaYeGd9m7y0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:R0BhZlC40-DKmE5d_f2KzlSsThM-hfr7tgbyL3-osfZP_AdA62nZOQ>
    <xmx:R0BhZmgewXdWexIw8fpUAN-Kca0MG0GMXBQegLn9F690s2NgvgSSPA>
    <xmx:R0BhZpr-UTdPqMErAZSQ3q6BBj7pxWdRSLNvSQrjDO1USe_zZtv2XA>
    <xmx:R0BhZhhVPe3nDPhIIvDMLMKDXezqlzgHRp9abMzc5qTlfTMvXYIExg>
    <xmx:R0BhZhU-fx5aaQuuYIAha0OIiQgmzTHaSXEmL0v9y4F4kbeXBGuvsP_T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 00:51:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d2a77749 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 04:50:48 +0000 (UTC)
Date: Thu, 6 Jun 2024 06:51:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 11/12] refs: implement logic to migrate between ref
 storage formats
Message-ID: <ZmFAQ1UT6ePxHtzq@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
 <20240605100318.GA3436391@coredump.intra.peff.net>
 <xmqq1q5buxzx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OSF+HxLansa7ZUam"
Content-Disposition: inline
In-Reply-To: <xmqq1q5buxzx.fsf@gitster.g>


--OSF+HxLansa7ZUam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 09:59:14AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > Coverity complains here of a leak of the xstrdup(). The return from
> > mkdtemp() should generally point to the same buffer we passed in, but if
> > it sees an error it will return NULL and the new heap buffer will be
> > lost.
> >
> > Probably unlikely, but since you are on a leak-checking kick, I thought
> > I'd mention it. ;)
> >
> > Since you have a writable strbuf already, maybe:
> >
> >   new_gitdir =3D mkdtemp(buf.buf);
> >   if (!new_gitdir)
> > 	...
> >   new_gitdir =3D strbuf_detach(&buf, NULL); /* same pointer, but now we=
 own it */
> >
> > Or since "buf" is not used for anything else, we could just leave it
> > attached to the strbuf. And probably give it a better name. Maybe:
> > ...
>=20
> Hmph, I think this is the second one we want to amend on the topic
> and it seems that I merged it a bit too prematurely.
>=20
> I do not mind reverting the topic out of 'next' and actually would
> prefer replacing it with a corrected version, which would allow us
> to merge the clean copy to the next release.

I wouldn't exactly say prematurely, given that it likely wouldn't have
gotten a review without the merge because it was spurred by Coverity :)
I really wish that the Coverity tooling was available to run at will and
locally in our pipelines so that we can stop reacting to it, but instead
address whatever it flags _before_ the code hits the target branch. But,
well, that's not how Coverity works.

Anyway, I'll send a revised version in a bit. Thanks for your extra
review, Peff!

Patrick

--OSF+HxLansa7ZUam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhQEMACgkQVbJhu7ck
PpSWvxAApzF4RNPbAvPWdRRutIddzNSEe9dcHIsNYqZh3p4oAlsXPzXQPag7XE61
g8/Ym6I69YgZJktVQHfeZiEytlGA3QIP+/CcO4xXLq9zGTuE9ldSFZnh+85cAsZm
V8cTIwsXn6h1+Hqye84eXMRlhMnMYyYh0MoI1BB5A+NW21c6qvBKaJFuCGpNsPeS
4ZKoKXsEnnVatZunDy2U9xD7gYoIB0sWyQ4xp2/+c8TTT1DeY6b61vfmPgt4/Mg+
IVbnURqJ0BUIvvkOuejkaJJgQSomDCtYfkuBjkE3CG61JGeD9Udz0c1SpcqLLUtj
e1SkubeTUm3Ow2e1rCIFTNLj+5bxo7YWpDXbFyCkdoh1E7k4+6PqKXTBz/j2quRO
vTQFQfEXz9ZAweqD8v7yECvBw09FrVnFTZJUcimVTx3AcOkJMB2ou2mZ8fcUh5kv
HaJPxw5reh42oIdm5JS4hg6TkytIF4ORnkpIjyFC1UUllQRGmQhY+dMTgzpKALIv
kD6oyKoPoZtjLnxt44zn4whkY1MHqH6vOb7C+DlbLeeSXdnkhE8WyXmhIc9/+i/L
rKb+E3q30cJsnxNKKq89km/5Kja1Cm84egvvA3q5vgxdEW6V263iutQU0os4eSIc
yewuoc+8sBwFloCyGybnBgfDQE+jSgWj6qeYyiAbBKSiQQjkw0c=
=6iV+
-----END PGP SIGNATURE-----

--OSF+HxLansa7ZUam--
