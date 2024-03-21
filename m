Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758B84FA0
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031983; cv=none; b=adGBafVml6iaa9PPTm34nlJ4enI06eaFHSj5ne8YjyKWH4tjzk54KWk+gJvagErmlcq7ZReUBOii/ZnZOS6VsFP+JHI+Wcl12UIEKLOMspk8Oe37RoeODMhANsrhJj6Us3a7DzIBHghlKwqdaKVFfpnpLwO7S1N9iyBZ1SkUPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031983; c=relaxed/simple;
	bh=mXaluiar+20mwY4sq/PfIYrpqGLtT4nQFf9GxEuH7QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNrUO3cf3VXGlRhBiN5mdqQOrxpKkKQYR5FdRdeb3gqe82TrVDqNMw/lfhoFiIPf+yzkX1Qzl/j7WoG7q3DIcfXI2mPSAbos2vZ7M8azz2+fvuHs74U2wlGYQ59/oK/SFnU3smKzzVd04/Eq373g9kMl50VDjE5rl1wKAFcAW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WhXc1rr6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sAlHoT5q; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WhXc1rr6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sAlHoT5q"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5FB3418000B4;
	Thu, 21 Mar 2024 10:39:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Mar 2024 10:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711031979; x=1711118379; bh=mXaluiar+2
	0mwY4sq/PfIYrpqGLtT4nQFf9GxEuH7QQ=; b=WhXc1rr6B+Z71O4Ceu+dQAXE1S
	ofys3jJaGdAGWxIm+YCbsYARSbCiqV6tmBA4T00F910FrBKwo5vdztmbGQBUSCgc
	QuEp0vlPKQJcnYd2K5RKb2bhtZ+6bcl0SJC3baVpfHhwmPq76q6PHanYaSA2bTv5
	JoyReT3/IwOUeecmKwqsXtLk4K7NU6jHY6H+7pEoMjcZ+el0g9TSgq90lsvh1Sez
	4sfPamgJmXxuDOftx+5jdUQMf6oXbe+pM5hcUqsk0qY+1A98stfd3o5iLpR7/grh
	ExpSDT0UtgWjN1jRizyzqEVk7iNOXYMrIG1Pi45j262Y3P2LZztr+0HiNusQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711031979; x=1711118379; bh=mXaluiar+20mwY4sq/PfIYrpqGLt
	T4nQFf9GxEuH7QQ=; b=sAlHoT5qvQeXU6r8yTlp0V9qkpp6N+jnx4kotTtNT9hV
	FrVeuN1moCBsFU19tORtf0l4tYBptJpXgojDZOCwYN7bQzV8JmFVpOyusftzJMMj
	B8X9VIehOiC8Vu8j1O6yB3O1+TnIb0B80Q8d8O5e1fRBSyP5uj+KHVSRUaH+vmj9
	0PIOl9g4rfcs/QivM1FVedhIo8aUqGGm4s7qOnUn2087/3ENQfBJXvTlN40gpGsM
	un38CH0SJPDCZ2OyrmqiDMY2nsrEXikia26h1rYLavdSLsU7FkdZz+/S9WAJfzVZ
	Nt1Qm6A9Nk5le+jJOL9KsjtN2LBOt+YLOLXiBf2rWA==
X-ME-Sender: <xms:q0b8ZdpXMnhuFTVBDh7WxbFLyU98bKZ_G6Pn6rR-UasB2ZmSDw3nXA>
    <xme:q0b8ZfpfS7nqG8LpKyMaHbpqepD-2ZXxTDKcd0uqYSaahuSD2QFOQc_qn0tzYMf70
    bOOK3XbmdogJRLOSA>
X-ME-Received: <xmr:q0b8ZaPRKtsmImpFofyZI9DSuJF9INIyGIkiFCLbJTJpFK5AO-c9ot8kB07UH_glhB5jlTeVuq7JKoPVGKPiLgkcRrI3DpstPsEwnPH7cVf3hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:q0b8ZY4gu6p0Vx-th5q_V9hQeVBzMoJ5sl_CxlgpyQw4FUJ_0RdEMg>
    <xmx:q0b8Zc40GDSj6DmyKCCPpzk0mvTyvmNfS5NU1xPZEkp3CT2yCqdUXw>
    <xmx:q0b8ZQgsjsBJBXsWv1YZIpm2pO08elyimdfagajSLlHdzMACGenaLw>
    <xmx:q0b8Ze6AFbLj9QLaxioDcDH50p6TVG6weLtbXKHFLd2oOYpgyN6l9A>
    <xmx:q0b8ZZtnrSMB9PtJ8wqt7nw0wVGcocGATVAwqtesH1zoa-YQC5l-TXZTizY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 10:39:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a3b9ee0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 14:39:33 +0000 (UTC)
Date: Thu, 21 Mar 2024 15:39:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aryan Gupta <garyan447@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PROPOSAL v1] Refactor git-bisect(1) to make its state
 self-contained
Message-ID: <ZfxGp6p6RiS5i5SD@tanuki>
References: <CAMbn=B4HDXOAThvAmmyA5GEzG1nnvbGvc4yjpg7FHSHQQ-WQfw@mail.gmail.com>
 <ZfwsnMWg12S2gV3C@tanuki>
 <CAMbn=B73ioQ8oRucG4X8anhwrnbhJRky7BSe7DKpQad85Dt5xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="is4CnEauiHvaevv7"
Content-Disposition: inline
In-Reply-To: <CAMbn=B73ioQ8oRucG4X8anhwrnbhJRky7BSe7DKpQad85Dt5xg@mail.gmail.com>


--is4CnEauiHvaevv7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 02:27:56PM +0100, Aryan Gupta wrote:
> On Thu, Mar 21, 2024 at 1:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wr=
ote:
[snip]
> > If you want to stick with this idea then I would strongly recommend that
> > you mention this in your proposal.
> >
> I am open to changing to another idea, I won't mind that. Because my
> ultimate aim to add something (even it's a small patch) to git and if
> this project will never be in use. I am willing to change it. Let me know
> what you think about it.

I'll leave it up to you to pick the project you're most interested in. I
only want to ensure that you have as much information as required to do
a proper assessment of the different proposed projects. So if you want
to stick to the idea then that's fine. If you want to switch now, then
that is fine, too.

Patrick

--is4CnEauiHvaevv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8RqYACgkQVbJhu7ck
PpQGNBAAiPQP8UDUTJa16mxhb5NM+tIQrLkU6lY/QQ85njTbzAZV5Z2BwYCNJi7F
uJaKAYllO8foy5K3mPJGlIUgDqbItAb2RiJKfAmsNkR9g0rjmM1EriKg0iinxbYG
dO2YhYKGT8bEOh06pRtE0nHxO6EwZ/skN+kQead75ew8qRd+8cLw9tFroZsMQERH
8uYG6iLUAIga5ikGAfVDD8iqT6NFTE984W4aGCTfeIPU7vddNK0dnNhw8GPy7wBN
mFvLsiMMKF3nar9TRfE+KKrfV+HsYeB4oH8Zzvgx/M6ZHylFpKiE7Y8ACG6fKQsz
jacFZ3yNIIYefTI2QILHAngPM4gfjRSCXWAa3y6QLYYESIl69PMaiu52b2vYGz2R
wCASHLVD0kFsmGMU2Dqn/ALD9nPsNqxhbvEBT6lPydEva1xPJ6+NF4vle8bcoF5S
igHYoezEO8+6zijnl31IU8Zutibpc1XIZZg2JtkuFY3yzXdkEmxY0QcwPe9jg+Uy
cQ/704pXFeY2+DzN08ft8NmweMWCWze1DKfThHuJxpS+aODeeJBQ6KfW3Se7LSBm
Yys5JL4rTfEEjK+nzxcAnUiDeiBNl64ioVcU9FNo3G6+I/NtqOG3w8SpG4v4qVO6
6St+7F1b2Mgy+9BnNouD4fcOCkJzg6Msp/uXES180tfLtUJOZ/g=
=lK0u
-----END PGP SIGNATURE-----

--is4CnEauiHvaevv7--
