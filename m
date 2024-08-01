Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B9184549
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520537; cv=none; b=fCtmuJ6azglyy/zfumYhm982bkoUAzdlA+6sHNOLrvzxAeJRxzcSkvPxnmXH36pXNvV2c1IGMnSErVqY7hhuU7/DwwanzsqL3QofI5VY7uc4R54J8EZsdYn42LpGGYp4Pi/gWPnR9CsJror2+VmqAeZq75/H9ITUZ/nDqqsCNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520537; c=relaxed/simple;
	bh=1/SmPvlFFpEe3i9xCPirysT3JZRIiK5dm2JaPoa0GAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkCbcDzdlfmDVLqqae/oes4HC732S4KgaY2AqwrDx63BCKVA7bep28nA1eXff5HstQwu26+8Mn0eCXmUf2WtLrI3IFFW4xWF/ddpohUgg8EaVO7LgObXrhNzDchi2xE8pTdBSqAlSlyYQI+UA/lPSil2IkcBWpj7L7geqYzL8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YLc6PnTh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jpehrbA6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YLc6PnTh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpehrbA6"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 87D231387F38;
	Thu,  1 Aug 2024 09:55:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 01 Aug 2024 09:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722520534; x=1722606934; bh=1/SmPvlFFp
	Ee3i9xCPirysT3JZRIiK5dm2JaPoa0GAo=; b=YLc6PnThUUPFPis7Pe0m8ksANE
	MOR+oc90eprr3FPNFMrWw1ve6pmtjqcq0mSocumRvrtWtJB0pxIZlRBU3uhLJU0O
	VoZt7yPWl/9gM8yVUASiTCNiXrxW+7N2luF9DKm7B7dUjWze73/2pD+4GS/DAqYh
	fUGAFiYjqGFfvh7XwW2HCSyOu1pDOCK4Z5LmEBg3KcL+emFPzg8o7b8iqdyjTJB1
	gtshfcR2b/JFeQvlqDX+xmFkgxcKl8i7uS3Feuuv8UzaYURRHUm0yfOR1GtkYNi3
	5gsM5ywUsxdad1IR0jmaOlUVIQBomYpFLUIyfvKtPPMIzThO5fER5nfLTpqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722520534; x=1722606934; bh=1/SmPvlFFpEe3i9xCPirysT3JZRI
	iK5dm2JaPoa0GAo=; b=jpehrbA6UejtNGmZqElGXf6fS+y+824AYKKmF/yQ9GsD
	fA2OMoRVCJcPFdK+vP+/voiDxPwmD+iFaxSSyupPqE0zuTz1c2HA0DdRyMRktRKn
	YqQ/I0/f+prgYMZr6U/zQ8ul7NNmFMDTA+NBzLpb4lfTkI6nsfUB+TFvdxW786N8
	Yr4wAAo+RTrxwv16pyKIxKroqVsbvzjPGT70iOiJlTwXNI4YJlkNenmIVvVt35WT
	7OBXa9TsnhVck9lGFnh7/nINmZ3RytKG8Q31/CJe1L/w5IN9Gj0wMNzK3DO0rWe7
	ELKYIN34M+p+XMm9QIBO4yGlixRmT9WCYl98fwTvMA==
X-ME-Sender: <xms:1pOrZp0WiRw20Czn0RzYEGQmPeFi4bf7Jd4dH5nk3673SrZD0U604A>
    <xme:1pOrZgHLYZch7JPggnWGwnKQSnl9KGL1iwKk5YDyu8PvOdVRaOSHpS56r_ZF89mW6
    SNWKIxONYrWk2Wbdw>
X-ME-Received: <xmr:1pOrZp6tUktxxw_nZZPtEPB4YBJk6Pls0smH_-4QCBPmLK3XrpfecVLgrHMf_dCwva5BaHOvAWR0KD3OQPumFTeFZc2XJO9psyyDT4OONlX4ZYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:1pOrZm1Mu7D88LDXKaX1f2noM70MqMei7nkgSAjnhfhBejv_ElOIUQ>
    <xmx:1pOrZsE8Kb1hTlgtJ7EBjUPHfj76yoxwiqLAPJ6ep6Kq782r4uRL-Q>
    <xmx:1pOrZn_g9ndVXbdq4u8atT1zgBO9HdfQljyY1wp-Vf57NHFVYhAYcw>
    <xmx:1pOrZplBgWs1YPb3eypvDLwhfWYjdOyqIrPjjSAP-U9GueM4ThRdwg>
    <xmx:1pOrZn0XSIJmeBt6e1U-TKnOR6tUsKJ0AXBNVNcq4f6wc0xvi5Se54kE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 09:55:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0d17f01b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 13:53:58 +0000 (UTC)
Date: Thu, 1 Aug 2024 15:55:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Josh Steadmon' <steadmon@google.com>, git@vger.kernel.org,
	=?utf-8?B?J1JlbsOp?= Scharfe' <l.s.r@web.de>,
	'Junio C Hamano' <gitster@pobox.com>,
	'Kyle Lippincott' <spectral@google.com>,
	'Phillip Wood' <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 1/3] t: import the clar unit testing framework
Message-ID: <ZquT0B-UXy73x6QI@ncase>
References: <b3db953e88ece99b441993c9248223cc0ecc6be8.1722415748.git.ps@pks.im>
 <463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr>
 <00a801dae384$de2780d0$9a768270$@nexbridge.com>
 <ZqtWDtqkXzjz2A8u@tanuki>
 <01c201dae40c$821ab5e0$865021a0$@nexbridge.com>
 <024601dae411$faab2cb0$f0018610$@nexbridge.com>
 <ZquPfiAWgYjIPGRB@tanuki>
 <025f01dae419$636bb790$2a4326b0$@nexbridge.com>
 <ZquSkkR_aw2IUdX2@ncase>
 <027301dae41a$41ea7ce0$c5bf76a0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2BFCvFirzLFegCxC"
Content-Disposition: inline
In-Reply-To: <027301dae41a$41ea7ce0$c5bf76a0$@nexbridge.com>


--2BFCvFirzLFegCxC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 09:53:52AM -0400, rsbecker@nexbridge.com wrote:
> On Thursday, August 1, 2024 9:50 AM, Patrick Steinhardt wrote:
> >On Thu, Aug 01, 2024 at 09:47:38AM -0400, rsbecker@nexbridge.com wrote:
> >> On Thursday, August 1, 2024 9:37 AM, Patrick Steinhardt wrote:
> >> >As mentioned in another mail, we do not use its Makefile at all. Did
> >> >you
> >> check
> >> >whether the version I have proposed here works when running `make tes=
t`?
> >>
> >> That is the commit I have been trying to use. make test in clar or git?
> >
> >In Git itself. `make test` builds and runs our unit tests, and that now
> also includes
> >unit tests based on clar with this patch series. The clar Makefile exists
> only because I
> >did a 1:1 import of the upstream dependency. We could just as well remove
> it
> >altogether, including other bits that we don't end up using.
>=20
> I see. Well, the 2.46.0 test passes. I ran 'seen' 5 days ago and 'next' is
> going now. Would that catch it?

No, as the patches in this thread are only up for discussion right now
and have not been merged to any of the branches. You'd have to apply
them on top of v2.46.0 first :)

Patrick

--2BFCvFirzLFegCxC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmark88ACgkQVbJhu7ck
PpSsZw/9FQL/m4if8V/yDYPXA897XAp6jzH1gAlhZblw+u5ye38NDZ7nbQy3FwJT
jS8EZSLH8XaJqMw6fPFuY9+TwN6VUfzDQ0e+6jGA7ObnrTInvTOMMJypFkVxUqLw
RdF29Vk0WejQsTdtoFSMq4qOJzlQLedNGV45vvuvVfIYpT/XgLqQBtnGYfmGmvCj
uUrIqp3QpIU1SCNsSDGniPf+RYDOwFTkLdql2mWAo67G186Dfyw6SpCnz69fHMYq
kA+YMvwnjSvB6anWA0lqVRskO7CsLGfYJGiU4nc+on1x9XDM07hOcHFb6ygsJA9N
w0E7GfdW+A20AnrFxOgsxcjNyJKchTKnmhfTORkm7X4afIgQGbhX8ZOUCoUNPG4C
6rzEBPHXyoDUEQmSC48mQqq8zANWNq0ZxJg/AZhx9ocD2//FdNKTDjjVKZwHenlA
moiHowH5IQuUgj8EdeE31zaktxqfSzykc3bFCQyM5thzqDXuMjdgJh3lJRZ2SBxp
DNwlj5jR8l51u29RV57+yOvqGqAZ0oGL0yrV737IXDizCD4AH5Zs7HXJOuySPOAw
K15low8WYvx4OD8U1Vh21mEx9U7OqRbX9EysD4+cpMpAeND3hVo9yy7m+abHshfN
UScXFcs/TiwDNvgHN06hzq9YWvTzh5zJBDJgo7S6yHKVSyOPpm0=
=V3lp
-----END PGP SIGNATURE-----

--2BFCvFirzLFegCxC--
