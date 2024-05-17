Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90517C61
	for <git@vger.kernel.org>; Fri, 17 May 2024 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929733; cv=none; b=a8J3UCi0XQ3VC84wceCMpnr+q3SEHVcp5BRORWEUpz2cq71FZteZdVeSHobado55hnGdqrI2BtCXpIi1z8dpyQnziSU+1EjR5O40gMJCXFhIiAEJVPXU2ZTJUdSLrjZn7tyUuUoRoMdjs5QMsd7a2XGgOb/18MC87fbJT9y9mQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929733; c=relaxed/simple;
	bh=wOxnTKDSlS35W199yOdBO6j77hvh2Mo4N///rEDRx3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGQ+GH61DHjuoasiuORLzbvRUUCohUFzG05CLbrgoZTRKill3ueRs1M26HBI4TY+8S98AO63LVV20UDoafuEz6ZatYSU54rDDybgXUoghhOHQG35bl1ORB3o4YUM629PWBETS8t78HslB9AXXLng+37IpFx7sxrWPAX5wXRP6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FNFOlR0Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KlkaBKak; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FNFOlR0Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KlkaBKak"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 4A7921C0016A;
	Fri, 17 May 2024 03:08:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 17 May 2024 03:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715929730; x=1716016130; bh=pMxrAhWaRs
	7UBcAeIofYL5CdWwoGUpIprR6dRAUumyA=; b=FNFOlR0YTnS//hjdUetY1WgX8k
	xsYUZ+troycuPfDy7oeRQLmbocnosdvrsg66gCJWk3HiaciImO9WOZXA9Q5qUv0r
	uqwP4tEI5BnzsMGyd891c69efl+CsC6larcBX0ZMVKM5i5RTwWLYl1HtuyV1y5hZ
	OXZshIpDhIsa2clP/9FYqQ8vA8DaEsX2bgC6sG4PzVFveWT+CbHEAzZR0A54ziJ2
	PRPhQ0q0kcZvVSDcf5XO4lfI3wFwpg2YxD1u2zTZ6636Z0q/UMPF+TtT+q52+J3y
	3XISL/gz2+/Yczl7hjqNJOoSdkEs8AicLxyZ1fRtfIOs105tgJapsXF9tPRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715929730; x=1716016130; bh=pMxrAhWaRs7UBcAeIofYL5CdWwoG
	UpIprR6dRAUumyA=; b=KlkaBKakBexu4meuISAZ7fVxiAX0Iq/qbSspWft4o0g2
	PzsYcQNTk5oxn5YH1bKMVwfP8ySaGR/GXW9NEQoPMhxL9otSaLZ6oEHy8CYTqdD6
	WZ719uBB3b/ApDGglZ1GUhFA+n9odj4hsVZua/jfxSGnssyWWGMdUugqnlt3d7/q
	cvRWTFq3qqkmjlOu4/GOeFYqvMWj6ErGcfVt+ftC1edIapx1PcDP3VtWCI0uYQYw
	mtAPXZeBN0pBdkQhmVHT3COvA2pOcHUkk2mMg/ujnCpePPx1YLJQ3XEzGaS+Z+89
	sZsJNrPlUtznr5UkqMXJAnlvDKGEcMt59DCHRGGFSw==
X-ME-Sender: <xms:ggJHZiQV8FgTwo-LjZLbCK1hpb2E0rWpv7AD8KxlpFIntsHl2GUbkA>
    <xme:ggJHZnx0XY5jAjAI4qR0ua8OnZcSwYekRol_yZtsahd0QFiDWgU44f-fMYN97NSw8
    5Oa2bPlP2_rOpmYJg>
X-ME-Received: <xmr:ggJHZv1YInbjQBesg7LGZNCFxycjOIyot0IrZa5fwIw-OdrxpVl-R_gu4AWbO_4Q9Dy13UBaJ1ZMRDuDfJ1ZTqNf4LqaxWv3EcxdtBkjpEyDaTrtVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ggJHZuCdstwjiW37K9tENForli2TsZC6E_g2vLGT2ktDUcdyweCrpQ>
    <xmx:ggJHZrg8qHhv893-U4wX6fxL0b63Dr2a9uNZ4Y9-xR27_Q6BPsV_uQ>
    <xmx:ggJHZqrGtZA5KKj7Eimf7tW5NphIj5bFkwrbbdGeUUvaYg5N-lWVrA>
    <xmx:ggJHZujjN_EOUzRyhEjT0FGUCV0mmjQGozkbkgyleRCKlWlpE-zhIQ>
    <xmx:ggJHZusoydYxZU2YSmGaNEC3gkm-u04mm0dvJ0CLhe_gai4mv1ah-sFY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 03:08:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0dc2ed94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 07:08:23 +0000 (UTC)
Date: Fri, 17 May 2024 09:08:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/16] refs: rename `init_db` callback to avoid confusion
Message-ID: <ZkcCf7kTfMkuANS4@tanuki>
References: <cover.1715836916.git.ps@pks.im>
 <3cc2b4e5501ebe1464a6d75b7aea9f2ad6030c4a.1715836916.git.ps@pks.im>
 <xmqqa5kpr4wr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I/S3a3WeHiSQtZit"
Content-Disposition: inline
In-Reply-To: <xmqqa5kpr4wr.fsf@gitster.g>


--I/S3a3WeHiSQtZit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 11:24:36AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Reference backends have two callbacks `init` and `init_db`. The
> > similarity of these two callbacks has repeatedly tripped myself whenever
> > I was looking at those, where I always had to look up which of them does
> > what.
> >
> > Rename the `init_db` callback to `create`, which should hopefully be
> > clearer.
>=20
> Hmph, create() may be clearer than init_db(), but then I am not sure
> what init() would do, differently from create(), so this rename
> takes me back to the puzzled square one state X-<.
>=20
> I am guessing that create is about creating on-disk structure, while
> init is about in-core structure out of an existing on-disk
> structure?  Once I understand the differences in these two things,
> it is much less troublesome to tell them apart, regardless of what
> they are called.  Between .init and .init_db, it would be obvious
> that the latter is about on-disk thing, without a rename done by
> this step.  On the other hand, contrast between <create, init> is
> just as opaque as <init_db, init>---the names do not tell readers
> that these two are about on-disk and in-core structures.
>=20
> Just my confused impression.

I certainly wouldn't claim that `create()` vs `init()` is perfect,
either. We could easily avoid that confusion if we were happy to make it
more verbose, e.g. by calling it `create_on_disk()`. I don't really
think that we also need to do the same for `init()`, mostly because it
is a common idiom in our codebase to have `init()` initialize data
structures. But that may also be my own personal bias.

I'll go with `create_on_disk()` for now. It's more verbose, but given
that this function isn't called all that much I think it's fine overall.

Patrick

--I/S3a3WeHiSQtZit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHAn4ACgkQVbJhu7ck
PpSBNw//aaXgJKWoH6C45ddaOGimbL9OHH8tv++afcsC84/5m6kJLFee9SLUCE+8
/wCQK/hYkpJfkfgu0VWjfu/SigRl9C5h5MO/uImzHx2WxzayndQ9Pv2FlJRuWm8W
Ccg/E6UAnQhSR8zuBG8cBr0zVxgm5JwCpFHvYSgteQc2fSBTvw+6tAHEzTVXo1fh
Oy9zwt4fXFlO51yo4Z135AxfCEVz3i31u3tGQDrc7LJvFeQeDMi4wU34j6WBrYSh
8NmN4D859x+FRPu2X92RqyP6GdrHY0yRrbxq2NT9CrOKBBmLiM+kkK6dVb32OAwh
GlhQzx2H+nw9SNNKtvBOXDshfNCrlMak8xj9Eq42/kB5QHhKzqrOoDI5oRztbbir
fvFIcbKyAL0zYNS9xVd9p8JiUZIy9N6t5vE1ZLka1C29haWXa0DeyFyOCMUa83Uu
4IQeDp6a/ARqBkJMvjf+G6dyHTpDCpfhmzVOb3ByxrS4HVdq81bAXPTMnZ4inQqd
4ATAZUBqOlDOeF8UTqAHPLts210qrQejHYC1jGku5gbbVeqH4hmwQHgL75xQly5G
3S4RS+GA0HAogHKO8vCJ9UUameT1wSwQOE1S7KVg+XYg+VYX39sKGi43YK76sYLl
1LSFrxEmD4HTkbtnIINSN4KeFTb71vSIFvOAan3V3eSPglz3tZw=
=DgLh
-----END PGP SIGNATURE-----

--I/S3a3WeHiSQtZit--
