Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FC67E6A
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431568; cv=none; b=uIiOKgyF9zkk0TYTRD5s6eKlyfam2jbr/sv8tQ4c/KkIXEHLj7h6lgaaBeI+Q1iyx3yHJHakyzPrB6McyP3ObXEbDjt48R1TS9ZEe9YExgqYHaoT7+Nq0vyzhg6XH5JHpyafU29ewNgwl+Fz/PXO4sDi0LpUFzoTNKxffxa31vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431568; c=relaxed/simple;
	bh=cAkvBH8x0VWzEhwwh/ABBC5piSlECmug9OgwIMcaR9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrsTffmnaY7iaUMEbjYAZKQTRqnA+8eXeftamQZUPuLXGXW1WJkAHt21EpUuqUT0/hXVScPdX39Za6kQYQxfFV8r4KCBQlUPhAWm97Hwe7FQXB7RUuhXwtV1L1mNxbwCQDCfpAoYNvHDQldN5OpVdxlfY0uRF9UOIyRbjAQelTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SxQlMZSK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h21DprOL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SxQlMZSK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h21DprOL"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6F7A411400BC;
	Tue, 20 Feb 2024 07:19:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 20 Feb 2024 07:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708431564; x=1708517964; bh=Z4i/B7qcB6
	pndmu2kR906sowK5cO/HnS0BbKRUQAvWA=; b=SxQlMZSKHk8xnPBTc8pYmAEatq
	7R5dSnGyqrDSZ+KsJNcoqDWn3xEgIKM8fE4CLLZ8Dcm/IsUoLeIqSuf/rKqlPIcZ
	dDzf/lWgVw/rEAgBtou4RmoQrooX0EsCeK7xPOXkgAzSgj/RSYvh4CMTT2fLc7yC
	61SwJ6OCI9/Qy9EUH6I3l4RFE3RpGj2tQP6cMQf94UnEpWxiEm6xpOKg6GKzdDiG
	CZFw/IyNY+fCJ7cPmCRNRjq5UaSJNlLfyqNbZRLaDXTvhoS9zvqtcIbbzgGVhkFI
	qpxY5q7r2P1aU595dHosEkRKGvt8zHUDiealPB/DFKXYkIEfpa9z8WYLoH1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708431564; x=1708517964; bh=Z4i/B7qcB6pndmu2kR906sowK5cO
	/HnS0BbKRUQAvWA=; b=h21DprOLmedjwl/Huj621oM1nMY4MalbEkxxex9Rdrxk
	dxH6+vl/lqoKyUOP0X2Vsa6eBUyyONEho6gf5L5a+c70zRhdazZOO0eb7cTXPEEf
	9cpUsRN6XMnSy0rbFyuoUrD17WF+g9lT5L3h4pwMSVjEtA48fbGAlmFgMV/y/QI1
	U5Hcco/sKJ2Wj8xP0e/qe3fBR3LKunYMaytfjs4duy6VTAWitRL9uJ0DsSQg1wbT
	NSnzudETK6M3pdZAdyjozpJIVT6GjGtJUhjkVp615JkGxeu1xZcd4IVe3oUd/tI6
	HKmxUPAwhwaWCsEhblmAmqkfvLj4SLl//pQSE5vi1g==
X-ME-Sender: <xms:y5jUZUL33kF-Y04chFwtiivw5FbzEQ2YO54h_-P0WIfui2nkmVR56w>
    <xme:y5jUZUKv4tJWLolfme0foQk4sF6nfUdtHSdli1lUuxYnGhrYJAhy9Y7TxwYcEtD8T
    ZoT9kLGEXn0TywFSQ>
X-ME-Received: <xmr:y5jUZUtDMjhgAc-iJWW4_LVXzMRBhw6W5nddOh0VBHPYw11zvf3fFZfxtx9C2Fr02_dBEMTuwLmQY5hcz6Xy_XFKLX71nhOjW18oTbwKDljsJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfelgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:y5jUZRZ14225JH3BeIDYziDlkdxPUWL12bpdNIRc7PizpgnGWQXpPw>
    <xmx:y5jUZbZilmUctU1GPKF3Vy9V1jydCIR_K8TWk6Ij_p9s-pnuxRQ6MQ>
    <xmx:y5jUZdAnZrKCXlGZhPzCMDP3acyNyoPQA0KdNpcO8HpWZUV09Fzruw>
    <xmx:zJjUZf6NPm0RNqNjUQIuJbK6_MyiWlDHwdaYgpJtPm9f3lZESQGOfg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 07:19:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 553cd140 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 12:15:16 +0000 (UTC)
Date: Tue, 20 Feb 2024 13:19:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>,
	Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Emily Shaffer <nasamuffin@google.com>,
	Philip Peterson <philip.c.peterson@gmail.com>
Subject: Re: [PATCH 0/5] promise: introduce promises to track success or error
Message-ID: <ZdSYxF3Hd6Zqt3Wd@tanuki>
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
 <bd340a27-bfb4-41b2-a1fa-356ab7dbbd36@gmail.com>
 <20240220025722.GE2713741@coredump.intra.peff.net>
 <70a81f5a-32d8-4517-83ea-8019be5f97d5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xdaJeL9X6d51/sR"
Content-Disposition: inline
In-Reply-To: <70a81f5a-32d8-4517-83ea-8019be5f97d5@gmail.com>


--3xdaJeL9X6d51/sR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 10:53:06AM +0000, Phillip Wood wrote:
> Hi Peff
>=20
> On 20/02/2024 02:57, Jeff King wrote:
> > On Mon, Feb 19, 2024 at 02:25:29PM +0000, Phillip Wood wrote:
> >=20
> > > I'm sure this has been discussed in the past but I didn't manage to t=
urn
> > > anything up with a quick search of the archive on lore.kernel.org.
> >=20
> > There's some discussion in this sub-thread:
> >=20
> >    https://lore.kernel.org/git/20171103191309.sth4zjokgcupvk2e@sigill.i=
ntra.peff.net/
> >=20
> > that also references this earlier thread:
> >=20
> >    https://lore.kernel.org/git/20160927191955.mympqgylrxhkp24n@sigill.i=
ntra.peff.net/
>=20
> Thanks for digging up those links
>=20
> > I still think this is a reasonable way to go. At one point I had a
> > proof-of-concept conversion of some of the ref code, but I don't think I
> > have it any more.
>=20
> Ah, that's interesting - the ref transaction functions already take a str=
uct
> strbuf to populate with an error message so maybe that would be a simple
> place to start with a conversion to an error struct.

I would certainly welcome such a change. It might make sense to wait a
bit until the reftable dust has settled, but once that code has landed
I'd be quite happy to see improvements to our error handling.

While we're already at it throwing ideas around, I also have to wonder
whether this would be a long-term solution towards computer-friendly
errors. One of the problems we quite frequently hit in Gitaly is that we
are forced to parse error messages in order to figure out why exactly
something has failed. Needless to say, this is quite fragile and also
feels very wrong.

Now if we had a more structured way to pass errors around this might
also enable us to convey more meaning to the caller of Git commands. In
a hypothetical world where all errors were using an explicit error type,
then this error type could eventually become richer and contain more
information that is relevant to the calling script. And if such rich
error information was available, then it would not be that far fetched
to ask Git to emit errors in a computer-parsable format like for example
JSON.

Patrick

--3xdaJeL9X6d51/sR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUmMQACgkQVbJhu7ck
PpShvQ/8DrX9cUDfKg58q8mlj9KIpSsQB8+X4TXlsW2s+vLaZZjv9EyMrVZItbsX
JxL8y3NpWYOOgU6ZOOi67fGJV7qvOAIv4XWq31lCT+PREKK8hZ+3RPJZXb2Z9qH8
okR4UEMPoNueYPeBDGRxcJ8Du5e6DaP7Hvgb/Op45nmav6nVjSNaEHam6duOytyU
nowb8V8yxuD7QUWyqi08yIMfw7TuutEQh2/hLQ2D2NesGHyfWwZZZ41Gx2V5hhQH
frqqsLj/DyeQyf19ohal3V2pziyAHSvhnQhAXD0UumuN5dwQHSyflVeS5eKSwlpL
Qlwtj1Bcw1v+dxyQ85yIerMQGIu+1zxRertUb1Ahvj23gR/G4hFRusXlMHVgcHLw
Y4lhO3deDNu6JIi7Uy+7F0A/HH6SLUGEhTTJ9NWiiUb77rol4cy6vQzSbdxY+82p
f8gzu0j9NZf31BHSxK42jfXLpVIy18aFdEoSWk4Wu74x1pQfFZGhoLZ5vUVf+hNU
iGa4W+EhQ/XgkpLJ5flk+MqQtCsXvYsmtRxgs3eI1IJaeWsEw/kDN5gEGnPCHz8y
fPAkPg+EFMM9Thv/z7eLiIWCSLqfIUiW9Ke1lhxrY0/21pb4c8vZC+/4pMSTe557
3DI3Lkjp6pEeNkxb3Gw1s095sp02YLOLd8tqOVqQfYhozxO0fHI=
=P8Ht
-----END PGP SIGNATURE-----

--3xdaJeL9X6d51/sR--
