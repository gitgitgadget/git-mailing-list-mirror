Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79513183989
	for <git@vger.kernel.org>; Thu, 30 May 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068622; cv=none; b=BglwGIBOnimyWNnvHqGvopqSEJfF04vFsrN6rBTiRoD5LTLTQz3wi2r4Xn0a/d0plwwr4tTr/c7xu38U3S94MCT2aTak+LgRQ+tEgM4mF9tSm5N8zYGe33vvn4Uh75+R3ScWfLxhGUBZ/9VAB5SHAiEwWvuN7TY3goBdfi9yfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068622; c=relaxed/simple;
	bh=Xw8PUoSTuW3Ee+kJgdjnRii7yYiOSm0m/bnFvpDPHiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxrli3ehtrU71ArqMcngYhtx7zEpAQ3c8VjAb9wNvTkWUOq+nG8HZr/kbX8HcsJEpBFybL2R8l7DL0PQXoS6GcXRmSeWZwYDVH0DUSz8Hdy+dyZHrTm/KNmOTAkW96+sCtgQYUwbAvBcxUQN6J4G/l0n32x6Bxnb7w3CgL0egKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JzDUYlQh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X6BCDJvx; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JzDUYlQh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X6BCDJvx"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9367E1380176;
	Thu, 30 May 2024 07:30:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 30 May 2024 07:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717068619; x=1717155019; bh=GK9fPtSa1c
	KUA5OlNQ7ZO6tEquNtSoGyCv7KpJzH2DM=; b=JzDUYlQhYiJ6zNqg+zIusRkK65
	3bNVbmRxqaONBrJgQHGu9xQZb5vwsSFH6Np+5o7zM7sbG3hCznoUCx0oPQLcI+/L
	kxgw5pyO8+Uta3QUXHUlmRiB2T6+WRqNdn4VViD3KU10R/EOFGAa+c109hZUnFng
	1bJryNEOIAy1bS5RfGhJg4rbwBwgPFdX4eHb3WgyYI+SToaDHlPoqjoNVNPn9LA6
	q+2DU+axiKh8sn+/khQZqkw7Xb3G1XD/9zy3kDRG7cZ3dt1WRGXbM6G3yrXLfCMv
	a0589pwCjJ3FX1k9FZxV/l113nnPi07bzrTEJo2xyTSR6aEHAmD80AOYcMFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717068619; x=1717155019; bh=GK9fPtSa1cKUA5OlNQ7ZO6tEquNt
	SoGyCv7KpJzH2DM=; b=X6BCDJvx5HFFBfC1OGTGRD34Wx8qvDb9ZwNA34iPIzDW
	B074Qa/HqpokSspY5Ub4aRJfQY3OtPQ52NfLvaxuJXTvN7cE979Q5rp1F9+YRO6r
	kL8GwCKayug5sYclNpsit1JTfxiaE0JTH1Nj7UWTctRLxleZb3e/3JoZEbEF5Tx1
	0iIWGFpJ74ImknXB6PEH2QxpKke1KZ8Ib4JKQRdijdYFyXGfaJTUIrgxKxvgYzDE
	c1utcqinypMWnyp3GXeqy4ZIVsSVsoPOso7ngxLg9kW+NRRTLy+Wd7mBfGAQKzdw
	nLK/ADBBWRx/X3QKsCkL38w8lLnBkU3EaK+liTpbOw==
X-ME-Sender: <xms:S2NYZhfZys6fT6TswJMrlQwpai270y3sX-hR85QlgoSnssXBh-p2og>
    <xme:S2NYZvM0k6ZzRpCoNHY82iVNm0TFsLlMxa93-1I0mg7qVBaYAdjVGjFB750Z7biK6
    8uoEnhtckCBjDzq0Q>
X-ME-Received: <xmr:S2NYZqg1pK_oIiHyjrCXRHfXM2m6cNQe4YBNSCaYVJZDxv8PTJY5DBOTz-7hK8cLcKxd2kBwjJEOgdUDp6AEdPViSm5Ry_xVrYFYQXCv64orA-6LLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehfefhuedtvedtfeeiteeugefgfeelge
    elveehffeukeelfefhieekteevudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:S2NYZq8047y1PTkxIjJL10VC415zo7xb5O2vhjp0FFLhNNf-d-r0Yw>
    <xmx:S2NYZttsqh3bv1zGktqg1QmFRaKIKKaJF2uUYYMWRiA_ubdrothQAw>
    <xmx:S2NYZpG3J4SkUCMx8vd40bxThq5Xp3U2JMJoYxGZuYlalALH_FGofw>
    <xmx:S2NYZkMAH16RrIuExJYsE98J-TasF7J_t-g_f_BY9dlOcREFdUL-5w>
    <xmx:S2NYZlIevzBHL8URG1gr2KPEhJ7BJwjjWPvyr3_cezOpkR0KpRnGDHRd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 07:30:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2c4aadae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 11:30:01 +0000 (UTC)
Date: Thu, 30 May 2024 13:30:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/19] global: convert intentionally-leaking config
 strings to consts
Message-ID: <ZlhjRtRwxlnchOaV@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <8f3decbb762916a536ec7a8d319c5903bd8f30c1.1716983704.git.ps@pks.im>
 <xmqqle3sy1cq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="55Xqtn3yesDqtT5b"
Content-Disposition: inline
In-Reply-To: <xmqqle3sy1cq.fsf@gitster.g>


--55Xqtn3yesDqtT5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:28:05AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > There are multiple cases where we intentionally leak config strings:
> >
> >   - `struct gpg_format` is used to track programs that can be used for
> >     signing commits, either via gpg(1), gpgsm(1) or ssh-keygen(1). The
> >     user can override the commands via several config variables. As the
> >     array is populated once, only, and will never be free'd, it is fine
> >     to treat the program as a quasi-constant.
> >
> >   - `struct ll_merge_driver` is used to track merge drivers. Same as
> >     with the GPG format, these drivers are populated once and then
> >     reused. Its data is never free'd, either.
> >
> >   - `struct userdiff_funcname` and `struct userdiff_driver` can be
> >     configured via `diff.<driver>.*` to add additional drivers. Again,
> >     these have a global lifetime and are never free'd.
> >
> > All of these are intentionally kept alive and never free'd. Let's mark
> > the respective fields as `const char *` and cast away the constness when
> > assigning those values.
>=20
> It is not unclear where the linkage between "not freed" and "must be
> const" comes from.  What am I missing?

It comes from `-Wwrite-strings`, which will mark string constants as
`const char *`. This will cause warnings in all of the above cases
because the fields are being assigned constants, but those fields are
currently `char *`. Will clarify.

Patrick

--55Xqtn3yesDqtT5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYY0UACgkQVbJhu7ck
PpQ8UxAAhIuHk3QCpOZIaH71kqM+63mY0gFaU5FUwqvbVUuHZJDeUj06wfYp5o0+
awXYVL8MaNpVMFVRq7oNfOdKBvejnp0lXsjaUt9LAYkPS2FrQCtuVbSP20Dmo4ax
p56qIRI4WgqDx29gMoqMQFu+csqB86tQ5vhyJQVMbaYLGrRbQbnLKSmA7ulAK6ME
t7xk/Pjf0PVY/UjN5n8orXufcCH4UGE7rkhXHgH0WeGURlNDYV75R8uUFaePFvkO
Lb/KBMiTIHRn7xBk60fR9SfoJLRmZ6PJH8fwzv3oKhFdsTnEC8H0knBtxetroBGL
eTXxDOxgefjI4vRktF9BU9U3XjtHmEq1LqZYH/HGQ/dt1+NXW2NZ4I3Pcay7isgi
dLVwfPkdRaozeueO70xnJWcBgr72FvMJLph0fakTKK/kbvHI+K7YmXue9L9cOgiq
TARgwmmzod/gFbc9Mv9zdATu9QSW6b6C2gnY8jCP3lU+1elqlgk1wepOK3i3ep0O
JwB7a7Y1nK9iZahqngteYagmZfSOq0rxldTw21DeIZrBfKehlSXN5MZbtSl2gKn7
M4ZnYfCQEYLswGPPD81M295JY+r4Vnfy+NUOqLRbeOy4R3kkCtyGj3XJAXDjjx1N
UNGDBt5IaMBqsfD2DEO6zYrqhmEIE1+UXLnPvCc6htMSsbLUFOs=
=aDK1
-----END PGP SIGNATURE-----

--55Xqtn3yesDqtT5b--
