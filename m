Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6290EEEAD
	for <git@vger.kernel.org>; Fri, 31 May 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144105; cv=none; b=Tr6S4+N37kXJEieBDs8G2j4pFY+lWduaoctTnXyiD08tlvyiM5ewjk1adww/7HxX6B8WAisAOqS4qQFvrB0Rx85/071QccTcwhEaE4NxIsRZhe3ba+k6Nfe0+2cfKFTUPk2fofE71HciPKGaVXHbrigGUkf2aAWDYlkLwqyGfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144105; c=relaxed/simple;
	bh=LQIMLudf9zmyVl7TeRnPgIX81+x0Im1FHMto+6Rmd84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdnG0lafqrT7+wYLIgCdKAcIBjIwhmtLO2CAStye48EgkecgIw3oU/uxrADLJ7yCH4YTr8iF5XwD+5uepSDhNDYE6W3MKm3e7byA7J8py+vraN4O2G3JzBa8hmc4c8oqr4e+gVKU0rgObx4grBKIPI9t8tAc7JB93TZ0IfmKaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OtTzdpTM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KSiSIBtJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OtTzdpTM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KSiSIBtJ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7E3CD114010D;
	Fri, 31 May 2024 04:28:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 31 May 2024 04:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717144103; x=1717230503; bh=LQIMLudf9z
	myVl7TeRnPgIX81+x0Im1FHMto+6Rmd84=; b=OtTzdpTMlTn5G7FrHonADvREMC
	KM0+j6Qvc1BWp5NfnZLlHULuA1e9htyquweMzcYcjDaIBuAN9Y4MQRivtjwBBwil
	J+/I7lQTVs8kkkPIi1ir/tCtQ+uJ8bqx0UP+XHBUMOtyio6zPnrHucFnkTOeQLna
	c/h9snAQq3Fl+vdihFX2sD2CUDCL0lrb2/J5Hg37H+sqRbaTMeDnhTSqgiYst7im
	9wZkcwu4T8dxZDJjIVwYx+RqzOs1I6ldWDAf6/ye5kxOdOqP0VHHyaI+HlRTuitF
	y2XtB9nDx2iXXc6iS1eEzC6pF7JqUnev05SrrQZAteHu6MkupWzCRG17Gx7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717144103; x=1717230503; bh=LQIMLudf9zmyVl7TeRnPgIX81+x0
	Im1FHMto+6Rmd84=; b=KSiSIBtJb0nCuHeu58fmsAjB/zL/9eCoRWXGwJcwp1TI
	yYa7VoyDXtcF4yGSTnAaShG4TntB0snYkOQ9j9QcVYsWP8/PF3JmSC+ntqiV825J
	BbU8F5/mIt9SNzXN3V65jaq1PaFGNg/S/zTzDHyuHHZW7zF65SmnnGM3EdSEFHYv
	edZpVqc/9Mr5K0c4DpW12ax0urgQzZ8oLEAOtntswXtjZzycnbhUpox6jOYMLGB3
	YY2J1K3VUvyDMYBgMDcpeooMz0ECrMBkAkApJ4On0GFb9hX45fnWebBXwhhOFDC/
	ofneX/y5kHE8lNdMOPwdpSoFQgoq2lrxiN105nBKsA==
X-ME-Sender: <xms:J4pZZhY9wXV5RKjw7uSUtfQOQwhaCpF7TjzzRKGe1RVzB2mbYqk0fg>
    <xme:J4pZZobiZmwVntTs6-2xZpWvfySnzdVI6ENOFniL_xWfSsQCMkbRUiuX6WywzB_BK
    pTvool9ZT7StJlCHQ>
X-ME-Received: <xmr:J4pZZj8vO5ZOvo3QdVKXE2tTYLuvEXkXmJFRAnlVUVwNxzFP6kdhusqh00NeGerJCMgcZXcA_GkM0mpHI4hST2zGFRQw2S664TU-2ZhtbNJGDug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:J4pZZvojnZhRvyDrhdEYhtswvslw2yeq-Qed78PnYh95C77LmFzopA>
    <xmx:J4pZZsqx9lsI8vB3Qd1tUHgfijYupJOhZmCit_Rt3VoSF87Fv0axcg>
    <xmx:J4pZZlTL4148H-FxCcWceU1UwkIi2fd7vj2CpBRO8ZqwpZCZWiUNFQ>
    <xmx:J4pZZkqcuMv_AqTCJYIGkhWd1UuC16x6I7jDsak5yFgvgv0HDb2KbA>
    <xmx:J4pZZhB0lmtcehDonWYb-F5ln7LeTgOT2j7Bh4O5xmB-FfYDzEjLWrOb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 04:28:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 16db6332 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 08:28:02 +0000 (UTC)
Date: Fri, 31 May 2024 10:28:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] midx-write: miscellaneous clean-ups for
 incremental MIDXs
Message-ID: <ZlmKIqmoLydp6cKT@tanuki>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
 <20240530071432.GD1949834@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xADg6DNoVcfdpb7u"
Content-Disposition: inline
In-Reply-To: <20240530071432.GD1949834@coredump.intra.peff.net>


--xADg6DNoVcfdpb7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 03:14:32AM -0400, Jeff King wrote:
> On Wed, May 29, 2024 at 06:55:15PM -0400, Taylor Blau wrote:
>=20
> > This is a small reroll of my series which has a grab-bag of midx-write
> > related cleanups that I pulled out of a larger series to implement
> > incremental MIDX chains.
>=20
> These all look pretty reasonable to me. Thanks for breaking them off of
> the larger series. I think it's generally nice to get things in smaller
> chunks.
>=20
> Sometimes it is a little tough to evaluate refactorings without seeing
> the larger context in which they'd be used. But all of these were either
> immediate improvements, or didn't take much imagination to see where
> they'd make later things easier.

I've read through the range-diff and didn't spot anything unexpected
there. So this version looks good from my point of view, thanks.

And I very much agree that it's nice to split out smaller topics like
this. I think it's okay to send patch series that have dozens of commits
when most of the commits are trivial. But the changes in the MIDX aren't
that and require the reviewer to dive deep. For me this has the result
that I need an hour or more on such large patch series to review them.
And because I often do not find the time for that I push them onto my
pile of shame of stuff that I do want to review.

I get though that this isn't always easy, and in any case it's a
tradeoff.

Patrick

--xADg6DNoVcfdpb7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZiiEACgkQVbJhu7ck
PpQdMw//WF3bFuEm1nkuMBm/Ug7aXorcfUYJKgVntiLKCWwCoxTujwBrAobkv642
hdcQInC6Oz87vzqmtfWcgXVnhaa4QgMOgCWk+cYqosEwQqIJc7Ed4VW1yegdPfv3
jiFZYli8dlyuKhtFx8iW0eWEHAQNix1SieEUd8lM2dRr6EyAtskmrkTDqFDI7zQh
YGtWAHfSSOMyEv8yNlHZFxMn/RpIiVEXQUZEX2xwcPK3qiGPFLWJzSe+SN5UjsXV
O4/s3F4UYNHOgk2JYzXdME/xkxXjzrLlyhlR4G+60NSly9UJngB0y8KW6FGgV1Kt
8/D5rHSqpIo21WUuPIKwMfwvJ/A8mcXKavhkx3uYOPB1UC3UmqqZVtJVaFjxgYXC
GUdeFlSlUIrN3geJNCcD2L9pXiqRfAL2fn9d3WNbh+fjU7i+425saqerZAZQb9TE
w4LoA1HyKMN7fRavKv+KDyMxUTtEUYbK8erhWgS+PJhfX3qQh83EYxStczhhmuNW
GDtklKrh0jBoSOYulVPEGvEZUYPGUghGec6UncsOEBBYPVYK9jVFvYVkoo+jT8Ss
Y9iW2zkKowC1pKPwuhKUtNDjKJqVNNW+wrDbquiwxGaAr7/vagpO82gQ9a7le0w2
u1kC8nYVl3t70XAZGazdiCUp8A4LQEPpxnopaJkb9M7ilGiVzaA=
=Zde6
-----END PGP SIGNATURE-----

--xADg6DNoVcfdpb7u--
