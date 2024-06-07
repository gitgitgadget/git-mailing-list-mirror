Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73E1B974
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 05:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717738142; cv=none; b=QeIWww/mTVFlpkxHpnJu/3H9MMKztSRow6nj8VcQ/VGLMQ85psoMAjWbzdh2p39Q1MvjeW2tDm5sPPcgS2ooRZ+GffW4BaeMNSN0kk5MKq4fsFYB4jMznAatZLSb+OgsjpmIt6t3wdep80utH9wBsWXAGsIjgylJ6c53YhOirq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717738142; c=relaxed/simple;
	bh=8UlJmNkoJu2pQ3+vko15XX/TWHF5kCPxhe2ib7BfiMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSln50MpJyWj+CDZVQWg+QLROQ3uwW4zkAAZ0hNGbR6T5PtxpjMBFw8z/wAEz1iDzRfhTu6HhQi/tilX+lew7kIrKjyC9F2HkMW8bQ3UZfM3/K2D6OUOH7JHhQ6iSEHKd4wcUBKohV8VHCqOg1pkKB4SebFspZMWDeipkHbvesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oniV5Gxh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lsFBYOmi; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oniV5Gxh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lsFBYOmi"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 234A41140227;
	Fri,  7 Jun 2024 01:28:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 07 Jun 2024 01:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717738139; x=1717824539; bh=lEDMw4lCs5
	qM7O/vZxRqND7ZaocK0aMRnJe0W8jOfYE=; b=oniV5GxhgX/JioZB48OIRaxrT+
	0CuRG2tfeMEihpMfhohc4oVZDKhorh7kxaVN3o598nk2xMewW4baO4Q/vOSyLfu9
	bN3D6Qv3CvAZ1r8atfu6BiETCAO6o8MeuZjAEfvLTe27Ppi8hYEbVg0FtR4gXk+f
	oOIfHOtCVh2rOOUAfdRSkL7lPu16uW0gPMNcjwsEexlTnS8e41kDX9v9bUvTPyYf
	pbZ5SJIWTR88EJ5absI9vYem3NtVIvh4T7GAQ1ScTZPvlfU6HSGzzem31lyp9cIr
	np5Mwvnw1bKkrZZ8JmJLswvsLhoEL8jKjNANkUPjrRSBAsJp43unkM7aw3Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717738139; x=1717824539; bh=lEDMw4lCs5qM7O/vZxRqND7ZaocK
	0aMRnJe0W8jOfYE=; b=lsFBYOmi5TsFEJsnkWD3fcMmfDUBtHUNcbSaMYqpHpKI
	m5/tBWubjiKTNYv3XfBd2m3iPsguJ/X/9QPHundNPGSuy90zyZNkrtd+ul5YNomU
	Le9++08yoTR1zrDpHzXE6A29j637LQ4Puu3xv+NzuJPVWwDs2w0fmqz9yjUGuHwl
	nFn+uyAhC2rzQvSUNyvk6TO5bGTeuZgKpnF5/RBIzyvskdJVL8dmiL2+kYZhPJR5
	gE2qasTLEXVrUYNRl91vhlEe81yCrQvLUQz810mot1MbaQC438KMrUarDqBXHi66
	duTUTPhvG5nupwI+S6slqUOTTf9KNHn++XeB7K1IVA==
X-ME-Sender: <xms:mppiZpeNtCwcyQ5oLnvOJDdbTmui4i6nWrXssMwgpx9p_newdb-1sg>
    <xme:mppiZnMPQAGLOkoyKkfMI7BRuz7jp9w-LPVX13szFMKfMN2IFGfHI8xAN0Yo3R-eb
    kI-RoUNu9MMwDxpAg>
X-ME-Received: <xmr:mppiZig-jAXd1Ci7LluEMkyLrBWUgk3QPI1cELG9UL8A11pPj2CITNdQhg5K0HcsZ7QAkpcI5uX_jq37dm4_GaSWn2X1VA_VhaXrwx_GGOLqmWVN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mppiZi_TUZ4cA7D45TjDOyDLezbSjvMbYqG-DKb3tEaCzVLCrA3auA>
    <xmx:mppiZlvpKpqaGRdnfjZTSzxATct6GlIdV4eZBFpliv7ImaQCDfxxUA>
    <xmx:mppiZhG6t7xvh6HdulYTWcFSVhYQ6vrivGeoaMaEjLm06XnyBKK1rQ>
    <xmx:mppiZsMQryMYD0gwOA7DMSg_zscj0bommmWjdWIRq3V7pye6f5iIHg>
    <xmx:m5piZtLwXMlu88zhD1FId7_wCBivn3suSUugu5n8jKNNfrAPIs5-lCSx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 01:28:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5112cfff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 05:28:55 +0000 (UTC)
Date: Fri, 7 Jun 2024 07:28:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] ci: compile "linux-gcc-default" job with -Og
Message-ID: <ZmKalkqR3GqCXfqz@tanuki>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717662814.git.ps@pks.im>
 <bdf0e40a770c57b63e7519983d37b97a85ce07bf.1717662814.git.ps@pks.im>
 <xmqqplsum2cz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BjgsxYEVJiAWisAX"
Content-Disposition: inline
In-Reply-To: <xmqqplsum2cz.fsf@gitster.g>


--BjgsxYEVJiAWisAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 10:02:04AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > I was a little torn whether we really want to name the variable `O`
> > here because it feels so easy to set it by accident. We could rename
> > this to `OPTIMIZATION` or `OPTIMIZATION_LEVEL`, but that's quite a
> > mouthful.
> >
> > Alternatively, if we don't want to have this variable in the first
> > place, then I'm also happy to adapt the script itself to pass the
> > optimization level via an argument.
>=20
> The latter is much more preferrable.  It is too easy to stomp on
> people's established workflow that already uses that variable for
> other purposes or expects slightly different syntax.

We're unlikely to break existing workflows though if we name this
variable something like `OPTIMIZATION_LEVEL`. The workflows of both you
and Peff would keep on working without any modification. Also, doesn't
the fact that both of you have similar workarounds hint that this is
something that other devs might want to have, as well?

We could also generalize this a bit and introduce `CFLAGS_APPEND`
instead. Optimization levels are last-one-wins anyway, so people can use
that to append their own flags without overriding existing values. It
would also mean that we can avoid repeating the CFLAGS that we already
have in our Makefile in our CI scripts.

I'll send a version along these lines. If people are still unhappy with
that direction, then I'll give up and just repeat the whole CFLAGS in
"ci/run-build-and-tests.sh".

Patrick

--BjgsxYEVJiAWisAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZimpUACgkQVbJhu7ck
PpTgRg//epmNtN5UMxIly3+3J4IBxQlfZRSYKO1dUeDca9B9TOY0J/laX6OxZ1co
aKzMxu3lDPpGdBMKg6lR796mihaIGzdCjh+wblYBJGke/utfItBEMnZ2M+fLlrAo
sduvyIjI2BIMePNmacci+qr8H4OD4mLxQNMfCGPmV0PVKn3aqM+hmWezRwnUJ0k2
/268E5KtGZhG12rZF93ZU1uqta3TgOE2i7CYPUR3MfriQHDPJYOAsvAwAQPpJzkb
1GtaCogGUmZth9qpEkhq+EVCvcyv/ZGyimft+gHeXYwIJmYyAFfqCkzqnWf/b3PG
PwV9iQoGTqjXjI/TV60qpZ+Oa0n4nqSjXlNlPjwti4Lu7mkTRJ5o9wkETStrjInu
svB8yB29Ro+X91yARWkgbYXS6odIpKQdRzj144cv/U7q9DbLJ7Q9+INc9E90CrVb
PH11g8ZC8Fss2dKpZxZsTs2mCCGvxC7PW7lZOWMu3Xk6aAvWB31M/Yd2ixrr986x
clQPDowk5hNTboPrEvpnaBtw7CZg1luepC1S7ClxgdI9RYDpOBf3pMkPp2j/KX3G
B96ypxB8cz6+yNmz1M9Zujp6X5/bVtQQkGYtQnZrCKbpOnZCysFKvFp80HGk3QU2
OQ3iH42bBp4MpX9m2E1s+NHNjHB37eFswmalbAPCil1ge8Sqmrk=
=9sUr
-----END PGP SIGNATURE-----

--BjgsxYEVJiAWisAX--
