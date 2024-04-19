Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A538D
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713500757; cv=none; b=Rc2AqCBP/NRsGJyrHAymvRpll8fWyxOxEzjk9Q1LpWr/+H9TcloE8WVSyM0VpZXd+aYmLCK2S4jkUUwJQO4WOu4Cq+tbsEDef5RxR7hlPnXngoHxYMsCxzO4fDJukC4LUD7PR4Q0q8UipNj8n0RzSMm2A2AW5N6R/A+vXX/TeU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713500757; c=relaxed/simple;
	bh=ZEgxDa7pxgQapo9DUbTOOYEBrZ9dCNgYJxDU4Vh42EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLU3gYbFUQUktmttV13KKMYlx/YCm40Dk6hpaqsfsLP3xLzlPfN3XfYj4n4muvOjRBNt0G/bzSyahrbvYJc5/yJdoa2KpL3zS8Inn/lE79h8DRZXzkBOXWdn1an9HzTOb/QSDt4mWIruSNS0yoySMOWvRFxOWe5TSOnMWN/VAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pv64PxKZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hMY2JFTw; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pv64PxKZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMY2JFTw"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 35FDC1380232;
	Fri, 19 Apr 2024 00:25:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 19 Apr 2024 00:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713500754; x=1713587154; bh=X6Dv6cDI4z
	YVKYRdnVsdsvXnYsoFlkkmFfeI1doUoZA=; b=pv64PxKZfZ1V1sNkt4K4Rq6Azo
	BoK0QEkJSN37TM3ovgallSqdpW9+rimfMhIllHiPzIAePp1Oy9OgPPtUt5XgH4YG
	2KPjRgYuQbRaN1c5O+PqkoRELtKerQKPEi4t045mZGLe4K9eYUcG8oJk5vh/UEhX
	JOLhILBJie87Adh9gyJqnYQRDK99TdVsRcQUXfj32iqY4Fzo4v9TDy5CrdaHwBdH
	L5C9RllAq8qMk4+z/9EBN3pVVgHzJWH/wOt+Vg2KuQyYvySDICqwFvgbVVbenXjP
	c6ExQolmpKvgfCjODyOLUTGZzGGTax6gjhqwnxT5U8hiIpYKLnvFTc+dnaxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713500754; x=1713587154; bh=X6Dv6cDI4zYVKYRdnVsdsvXnYsoF
	lkkmFfeI1doUoZA=; b=hMY2JFTw3FIFFpLTFN5rcswzMs9je+7bu1qE6IXJ3G2j
	k0vBcOMD0TRQZUuXRiYJy1v5At5rA7A17sR/EjB0egfMIEYjo7lEagW0xvvwPkKm
	0+i1JDMjjHtOKSaMiiaPdKZovWjE3gwvJATKxLcqEWm6SBN7WW4C+A/V+TioDF7f
	nbVQ3cgnpXv6d6C2uGw4ebEJWZ2vaC+ZzxnUfO6MX7wu1LtSNkIHFy1tc09bfjsL
	X3x5BS4LWerDoy/kQYhno/nHbWPF7vLnycjL5UeUuhvtxPoV4OOcV+lq2NMDMJXr
	/Q8cDP985VYSqCar2DN0NXhnud4jG0nhwOO3790mYw==
X-ME-Sender: <xms:UvIhZpw4ZahBVZOGK6EMaJ9UzPFRubLEOPfgYclL6SZGh0pKo-A4Dg>
    <xme:UvIhZpReu2MiUjBwwc1Jm_-PgIwrAMJFGxOrvII6Z9okJnj6nnYm5SW-w9PuKm_yi
    FgJpN-XxwntGzIThA>
X-ME-Received: <xmr:UvIhZjWVkE2VVgJpLdOIkraMcspkgS0kaqHpqjt7E4wYGOBNWDcOzeYhyX_l-he70gLfnxUAutV7kSWJBShHIGfHK8NvrZfFAl5_TrOovsGekvlyXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:UvIhZriRXLRQ_2FoXcOAV8fOccEwOWmBxWEAlNGE3IkfbnoifFW2qw>
    <xmx:UvIhZrAfORikoB_1e7yuTwve1XxaQGIXk0YqM5JBESokKwIk5jt1yg>
    <xmx:UvIhZkI68fk9TU2zuZhljZ4z6TYYIZeowmCA4RTXTPjVjEA48lUIkA>
    <xmx:UvIhZqCrgondmJSdXuuccL1rKn91xmtvDKMkhogG0btSQHSLY2QpiA>
    <xmx:UvIhZm8OgmWbWJzliUYkJ3Ftht_FGmR9yDZHtxj06Caf72YDPo4YdcAE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 00:25:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ca0c4b8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 04:25:25 +0000 (UTC)
Date: Fri, 19 Apr 2024 06:25:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/6] global: drop `the_index` variable
Message-ID: <ZiHyTgb9QrfptexL@tanuki>
References: <cover.1713180749.git.ps@pks.im>
 <cover.1713442061.git.ps@pks.im>
 <xmqq34ritqdb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jbziwS5rt7AzdT9/"
Content-Disposition: inline
In-Reply-To: <xmqq34ritqdb.fsf@gitster.g>


--jbziwS5rt7AzdT9/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:36:32PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > this is the second version of my patch series that aims to drop
> > `the_index`.
> >
> > Changes compared to v1:
> >
> >   - This version goes a bit further now and completely drops the
> >     static `the_index` variable, as well. The repository's index gets
> >     allocated dynamically now, like all the other sub-structures like
> >     the ODB.
> >
> >   - This also allows this series to remove `initialize_the_repository()`
> >     now. Instead, callers call `initialize_repository()` now.
> >
> > There is still quite an ugly hack in `initialize_repository()` which
> > requires us to treat `the_repository` specially. This is because
> > `the_hash_algo` maps to `the_repository->hash_algo`, and we rely on it
> > being initialized to SHA1. So we need call `repo_set_hash_algo()` on
> > `the_repository`. On the other hand, we cannot set the hash algo on
> > repos which are not `the_repository`, because that breaks stuff, as
> > well.
> >
> > I'm currently prepping another patch series that builds on top of this
> > series and cleans up this mess. It surfaces several bugs that got masked
> > by our setup, like for example `git rev-parse --short=3D` not working
> > correctly with SHA256 because we always truncate to the maximum length
> > of SHA1.
>=20
> I'll take a look, and may even comment on them later, but let me
> otherwise place this series on the back burner, not because I am in
> love with the_index (I am not) and not because I think the "index"
> member in the repository struct is a mistake (I suspect it is, but I
> am not convinced either way), but because I'd prefer to see our tree
> to be quiescent when we apply a tree-wide patch like [2/6], but
> we'll be in -rc period soonish, during which time we'd want to be
> able to concentrate on fixing regressions without having to worry
> about being able to reapply such tree-wide changes to keep 'next'
> and 'seen' building.

Makes sense, thanks!

Patrick

--jbziwS5rt7AzdT9/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYh8k0ACgkQVbJhu7ck
PpRzMQ//WajF0L5SZw3xPpnq6v257wKQAz+8g4j8Ut3xgETAazx3WmLMOW2xou3D
+YP9DJdkCfTCVPt2LnZdpIOJUb5F/+jKvCkJIq4tT9H4Sy/OkbroCexQVepeG86s
eQIIFfhZeCf5GKkwXWqlpyKZwdexclNsApon7M8s5fxwH5tiFzFwfIQJF0dDVNNV
BdQX05mLfW/wqQg0cxfjDbpYVkI7kces91tU+W5Mcb/xIYoAJ67Ci/zeuh0bJ43D
L3qQyALF0Kjc1oM5AQPPGj+IOpj8g8p9/zV+VvLuKQkZG/1zMtX86RYn6QhiKNX1
ARhjoqC559yRTEkkkggh0Kh4EmlWhCeoAyoPUa9MryGAVSmCop2wNUsxHJCK6uD2
fq6q5uJS+6Lm8AKzM3ectxyQN4YJe2ziA1FoCCd690LbVAiLt0O0usgPZZvjAROd
8VywvyJ9B0byzlEsvB/tivjQn+eAchfn30kGioq87LL+qoG1/ULAjPHe+pFsH3EE
SRpxDPejsrmacSFXz2RZAZQXrRhtwEs+jQle/5Oce/l9M5lRAklP+vjwbYFzJWFZ
e8xwUfMnVPLDqd9Lqnwa1t8n/RYY0ggSFoAzcqDzxYpElW7yE5d3Bf6KEM3KRVMS
h8kyfI6BKn4argSIupHGxb8a4rT+9AG8o2+1k51f8/PBbiuNbUg=
=YuSB
-----END PGP SIGNATURE-----

--jbziwS5rt7AzdT9/--
