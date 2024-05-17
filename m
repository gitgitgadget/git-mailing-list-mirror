Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA12B18651
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715934328; cv=none; b=oLqbcijABullpzvY5BsB4zzwSjfnniVCgAgD6TWITZ+k48HYNsVDSoCqhiPjoFe6gRI9/vIRsUt1juM+PhLTcoo6krQqp016OPRRYLgUFJogxxoux7jX+XQTuk8TiJegTURgRMQqfTfFbaz4XrCNiVX/dnMCk3ovQIrYAP1ZOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715934328; c=relaxed/simple;
	bh=Lmt4k7niWDn/Y3tr3aMOBuAf+nQD3AnbXZcjdw7sOYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksNpGDUuiFLIcAAq0eL2EzZBf2Mp4ROOeSBqNninHmvOEQmTkhSfzPCDrUwxXWZkVu8zX4z3atP6wbINZ7N/lZ0gu6leRk0LeAUzEX4Xa3KVy6+YzjIIYVkudFfMobh90wzZi8tKgqY3IctJr+6UfzkkD2xfmzaQeRMEV4fMaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ocg78hIF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0+Kqpfw; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ocg78hIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0+Kqpfw"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id C8BEB1C000C8;
	Fri, 17 May 2024 04:25:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 17 May 2024 04:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715934325; x=1716020725; bh=Lmt4k7niWD
	n/Y3tr3aMOBuAf+nQD3AnbXZcjdw7sOYs=; b=ocg78hIFAcrpF8MDj+75m3lVTu
	Ot1PpA10bP3y4wwQuY84ngqSWFuoJiqOQZ1A91zeTLEwmiFnhPaa3v0D9Uos0n2i
	9f764kF3/F0E0o1BXhoQyI1zuM2EMgHd4/6nBK+hja3bmRIExCMiOGQtfeD0FzsR
	nbhcnvuGi6MYLEXr552sM7QcanhjcYg5tRsEFVc4wdEObgjoHNjTgGG/A8Xiie88
	wow73XRlUhjWugvdYGq7/nDlPwcbJXhiQpA8b/OuN9/rUJCYnsnDm9WXl6uVJAS4
	F+bCLJJDwJ7/LgQieqVAbDk1OgSXm3yXFr0pEN8q1Oh6gCac8rl4siQu9Xag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715934325; x=1716020725; bh=Lmt4k7niWDn/Y3tr3aMOBuAf+nQD
	3AnbXZcjdw7sOYs=; b=b0+KqpfwNFaTfvEd9IG/jq2tyjw0TA5fTpvKUQzre5KI
	G8vahQfwGd5XXUeUz2d0cqb35YEyHPZz4Ud0BVSQEdIA2pH+c95GA9dXzINoUXgI
	DeunTIXZbCqsriRNuk6j058PYceGuOBFNMQbkqpaIL5ckoD5aW+U/J9wGeAXl6ps
	+D63JB7xyvEPWyDLBtsWIR8C2Qdypx0G7qhPxqUMQPOBK1XCA+XP8EOqREVBeesf
	6KS534FlVvAPJM7ohk3zjVxGidRflf1qzfb6hRmyTOBFC+0+8dA8MGsUSxmSSP/8
	zZ5oW+BMOfWfSDgo9u36fX1ihd0fF6yPMLSk5fjaPg==
X-ME-Sender: <xms:dRRHZkuGpWHAeKE5GVbkPphvlq7A0tr73YQ_GzOEAcfLoELwpLBoMg>
    <xme:dRRHZhesO2mjS2bQArV56RoMt0QM--gK0oO1SaXkO60pg-zHzalBY7WrOXYGZ52Uv
    YjB6irUd140cnQHCQ>
X-ME-Received: <xmr:dRRHZvxHmfkCJjIWIUPWGTBFNpWj0XDvgH5uX1q4_9nYWJUkZD4rW6GhRhIWnnv4glekrxpiE5AmghjS88VHF-5Eng-g1_sOJSYStiRBSXCa-FP1vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:dRRHZnN6IyZAmwQ-tSQRZuY3HL3WsXQ1wkflxaHCBGt4QJFReX5-cA>
    <xmx:dRRHZk85ZvUuAzb_70dgHl7fT3f5EjktbqUl_dMDfiZGtUeBgvHscA>
    <xmx:dRRHZvX8vSvUT5w-vz5wT7s3rEhhAuKNbllj2y7Ujuep_IO9ktG6mQ>
    <xmx:dRRHZtdjomuIK9jW3NN9LlgXjW6LfGHNQZ1jWxO53y7kNfD5ZXdurw>
    <xmx:dRRHZjYsq0N6ztrJOxrpd406QoyimuP8w8T5JeG7W_2iEUSnFrIX32Kd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:25:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6ae1d779 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:24:56 +0000 (UTC)
Date: Fri, 17 May 2024 10:25:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
Message-ID: <ZkcUcPhrTrbSbZO8@tanuki>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162544.GC1708042@coredump.intra.peff.net>
 <Zj3F9EVpSmQtyy0R@tanuki>
 <20240510201348.GE1954863@coredump.intra.peff.net>
 <Zj8blb0QqC2zdOAC@framework>
 <ZkX9w6etjDVAh-ln@tanuki>
 <20240517081132.GA1517321@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/FcKjTlhtL2ZZpmB"
Content-Disposition: inline
In-Reply-To: <20240517081132.GA1517321@coredump.intra.peff.net>


--/FcKjTlhtL2ZZpmB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 04:11:32AM -0400, Jeff King wrote:
> On Thu, May 16, 2024 at 02:36:19PM +0200, Patrick Steinhardt wrote:
[snip]
> One can guess that scalar is in waitpid() waiting for git-fetch. But
> what's fetch waiting on? The other side of upload-pack is dead.
> According to lsof, it does have a unix socket open to fsmonitor. So
> maybe it's trying to read there?

That was also my guess. I tried whether disabling fsmonitor via
`core.fsmonitor=3Dfalse` helps, but that did not seem to be the case.
Either because it didn't have the desired effect, or because the root
cause is not fsmonitor. No idea which of both it is.

> Curiously killing fsmonitor doesn't un-stick fetch, and nor does killing
> fetch unstick scalar. So either my guesses above are wrong, or there's
> something else weird causing them to hang.
>=20
> I imagine there may be better tools to poke at things, but I'm at the
> limits of my macOS knowledge. But maybe the recipe above is enough for
> somebody more clueful to recreate and investigate the situation (it
> probably would also be easy to just run the --stress script locally if
> somebody actually has a mac).

Let's hope it is :)

Patrick

--/FcKjTlhtL2ZZpmB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHFG8ACgkQVbJhu7ck
PpSGeg//fe1hQNbGUVPnwj5MR15nVL+qBribioJAPFjp16cI1w1pBSX3wSSW3Ktj
ApSy44rbnIhMNtYTYJKYn9QwYWz2E5gsB00MRYLZ1jIzR3nd5uFZiNe46J66i0oz
ErUV7Xsj37VR7FJUtklGd3Fi2liUwWAbFRVQxRmKwaoMsXhsLotecYY+Z6Fgh628
MfH8Jw2jqAPLHSnEJbAws02Y75NCzeJDI+DQClaZRA0lctAsJ86xDcUQHT3U0lky
pbtrz/OVc1PdLHnTcvmYYlD2ImlNs9qxqYCTqS3PfLRppHZR98QHmx+AUPm4bcUf
LtHInzzwTRsV4I07e+yoEkr/+Y3OSn+kdfx3gjJXXmXPlXb23LgceYe0HII/My4w
IZVM7+3y7Z06//r/xj5ghjTr3rI2CtdYo+y3JjziRps/mOteE+ImvfThHAdaNQK+
kL6JDh3j8vUCgK5pIz7oE3bCtbjbhIlWZeoZEVcQpC/DzuO1xDCY4p8UUAaoH+lQ
z9r4MPpIwT4i4zuLc+6bBRmHdL+lTO90I9HAFRVGHkBKwq9pJM5vDqrK4BlDGs9/
blphuNXEuJtzWHoz1+qvzG1GHvbcnFzdmNtqfZhiiGcNcAd0a3P9DwGw4CvaCLfp
42UbbzwQuE6UsSY9QT3zdssgNIPpT5ggyo0mU0GiLBXc5FuzaPI=
=jqA9
-----END PGP SIGNATURE-----

--/FcKjTlhtL2ZZpmB--
