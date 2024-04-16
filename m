Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566DA3BBE6
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713245250; cv=none; b=SYws2ZPDFM7oeJcKBb4L48hbcWpwofpFx+zzvQ/McHG9KaNnX7peLw1Dito19FK1axenlw1FgUr6lTX6f6puy/6ppbk1sdrata+kGmTjxA96+aQtdzbyqdZwyn+X6rEKsDpqzn8jthkbssugGGNMSgqWDE+0sODUvkL59Zhugm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713245250; c=relaxed/simple;
	bh=PPNujpTuPdxdqKmRLQISkDxgHdn0Cv8VrYYMQe23rIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKloKYw81/FBr76l3nR5OUt4OSZO8kyddcwjWocAj8BAjVcIG1nWolx/MBMJ0esPY0eLbo9Sk0SDiGiH3wZ+AViKFxe2ZRxNvuKJrpknMo6dFvhiVFt6ejJxwAQZ65kBbtEpDZCI/hGhdFH2qjkdwnhYvo0asCQRx82c8l3trYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lPpLNeoZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cSZRtps2; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lPpLNeoZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cSZRtps2"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2886618000C8;
	Tue, 16 Apr 2024 01:27:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 16 Apr 2024 01:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713245247; x=1713331647; bh=+bGm7mxI6l
	VNkiqwg2JFOV+VfdUn5xOeGcLWxkQmbcg=; b=lPpLNeoZN+KTab7E07D0Th+0p9
	bEY6N9Hjrmd9f6+jnXqBNxjr0Yd/wIH4j/hjhKmP5VWJ1bCDwg0H7Q8PX/C+Nloh
	CO4YiRv7dgdQACcJhPLfo6+w6hp5AbbVGG2hdGeFxhMAvZxl+gTBf+cEvEVL6HOq
	SfkdIQOkeNaw2W/5R+AhoOOev4ZACPbgF/SuoYQcDK1iEdlki/mdwug0+acnjGnv
	8OhzTmuPFKDMptcsy4GQ54+XV1ECNVeGqE8bjj+EQwl7yGnwW/1i5YaFaNjIhpMK
	sYp8G79blXX/DOJd+8Wx2+JOXSPGk6iMtitpubcoxEBbgm5CPG4b1QMlFfmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713245247; x=1713331647; bh=+bGm7mxI6lVNkiqwg2JFOV+VfdUn
	5xOeGcLWxkQmbcg=; b=cSZRtps2dVpqCY+H2SolG9ot/COJMAGHGwYfDglQr3gG
	EYC8cfDWl5599v5ITJBlMUueBLmXOWmcNKKPNsFz0ST2ik5+4vinbjCuarO1XdwB
	SYWO2cJfKgfH58+BdYE15+igNGv97WZxJsNu4V09BQd/JTjIpcO5ChZW+zfREhTU
	SmrnNAdO88uHgVc7pksphdnIiBe09+5Tx9A32YHUhfDPJl+D6bs6i3X04/qujl1j
	jR79X368IM0sRWENkDzFhDxtPaOCreDLc386/xYRawYEz7Taef7tNmoC/8Xd2mTd
	Y/GF/Obx/FvWxvd5NRFOM4/SrJEhfFPKh1IzRhCN3Q==
X-ME-Sender: <xms:PwweZt8NeooydEPbLod6z6d6eeyW6GhkTmXNYDdFL-QaDpeXyo6H8A>
    <xme:PwweZhte-BFmcA_Z15guUnEonI4L6gEnxMld5xZzlUTY1XM9uFNwFQ5VrVfeZjBJg
    NYYlHc-APoZZEvRHg>
X-ME-Received: <xmr:PwweZrCrkO1kQAHAm2YeJAQ4tDdZ1N2SmJu_D0awHaomyn1qNw_PUYj85xNjw4Zc6FNpV8Bjba0GleEM7Z37b7uetS9IMoU5cBepqNWXw3xgNWZyMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejfedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PwweZhem_EvgmB-8S16XJaGe4pZuKOx4_EvKVWA4H_bIJFLm1Hn-rA>
    <xmx:PwweZiMmQ6PjcvRa-SbohuFHuLQbDsSv14lbgrwYuuXrTSHiaegZPQ>
    <xmx:PwweZjlLBdtmLZTICRywwOD2Yv9SeAEse9mN6gAha9o8ldtBaQZSuQ>
    <xmx:PwweZsvO_zvjegD1MpZPFlnacOE-bw8JjpaxqZV8a06PpbYMgCGrIw>
    <xmx:PwweZvp-TLGpgtogYx7ijACWgn_xTxGtkoUGEuh1pgFqJAhYtp8Ji8HU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 01:27:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b149c5c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Apr 2024 05:27:02 +0000 (UTC)
Date: Tue, 16 Apr 2024 07:27:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] global: drop external `the_index` variable
Message-ID: <Zh4MOkyOrM8kYeiK@tanuki>
References: <cover.1713180749.git.ps@pks.im>
 <28541f00-9054-4aa0-8e47-348043b5f863@gmail.com>
 <xmqq8r1eo6pz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2OBdQRptQc31hp9S"
Content-Disposition: inline
In-Reply-To: <xmqq8r1eo6pz.fsf@gitster.g>


--2OBdQRptQc31hp9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:50:48AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>=20
> > Maybe I've got the wrong end of the stick but my impression is that it
> > is the use of "the_repository" in library code (i.e. the files outside
> > builtin/) that causes most of the pain. With that in mind would be we
> > better focusing contributor and reviewer effort on eliminating
> > "the_repository" from those files instead? It would need to be done in
> > carefully in stages but would bring real benefits.
>=20
> I am afraid that it would take a much larger effort.
>=20
> I have a suspicion that many of the users of the_index do not have
> to even need that the index_state they work on is connected to any
> instance of a repository object (in other words, I tend to think
> that the value of having a pointer to an index_state in an instance
> of a repository structure is dubious), so in a sense, this rewrite
> of code that use the_index to use the_repository may be going in a
> wrong direction.

I wouldn't say it's going in a wrong direction. It simply makes explicit
what already is implicit and thus simplifies our ability to reason about
the code.

At least it does that for me -- if others disagree then I will rethink
my approach. But the third patch demonstrates that the current approach
also causes weird inconsistencies in how we track the state of both
`the_index` and `the_repository` in tandem.

> In other words, these functions may eventually want to take a pointer
> to an index_state structure as their parameters, without having to
> deal with the whole repository structure, but this rewrite assumes
> they would eventually want to all work with a repository structure
> when the_repository dependency is lifted.  I'll need to see the
> codepaths involved more carefully and think about it.

Yes, that's something that we will have to do eventually. I simply think
that the easiest way to approach this is bottom-up by moving the level
at which we inject the index one level up at a time. And with every
level that we move up we should figure out the intent of the code so
that we can decide whether it should use a local copy, the index of the
repository or something else.

Patrick

--2OBdQRptQc31hp9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYeDDkACgkQVbJhu7ck
PpTisQ//e9Ft8E6WgU+QQ6Glye+BUcJmi0jqDjiDreycvMVhG0VlcwS5tFeTal+f
6mchodFFM+diDsbllgR77t1DJNHoA8GNT7rKi+HjDZxiFtOTxU3yA5hkbQgGpell
YToBnkZYt7mJ7WyK8xcrCugu1zwPqjTjJrIcN3GAO9oOJcIZwULVPXqGVLItPW/m
qrgZtWeg3XcSoIItgLs50vhM5JHJEdVbS5r94JtD5XGWDR5ZQlQk9gMDzQlSs6Y5
KQuwp4qK4GfDMIA56CmmTEbTeiIbrBB/ml4QZcmMS1xEyecj6eWPhvOhJqmXOave
15LKulc1rZoDFfaaajP9XB1e3p/43iWlLLggp9yIB6JP5RyMSKRMXzmFku3xuMBB
zrfbsQR7F/YjNXnTwXV93GJL1n4fqvux0bfLXWo6LKiqopsHYBN14FnUDbFcFjTi
AVR/iffhHLlKDtTNG1e4m5wM6yoX9gElAhcyQg2Er7LH3DnnHQ2d7EuxXr4tznsj
c/0Eo0UbibHEJ0BZi1ooZbZqGPcJ9zXr1i36pQ/HclJ5TONYoyEtY51np+2UUp41
3er7acGSDyce3ToFm0+fK/Pa0jnOUj7/FUVqOeye9vWa9jFm7tRpIiIBGzNUwuYY
O8P2yfiwGiYdr+OXoPffwpJ8EnB6d5vH0YLY0nM5m9m1ViDAKEc=
=bUo9
-----END PGP SIGNATURE-----

--2OBdQRptQc31hp9S--
