Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06A16C856
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500392; cv=none; b=V/mUDjg/WCMYyZxSfrA5YH5UmA1yKdjI60l2+9WvYFqwOXoqjJiblsDpd3XTOlNVWEs9Q8DMXIEs2GpKlX8DVJVbmRk6VV++Z09noslhA7nulkjpcpvvt6XmMryqBDCPWFgvC1jJ0w40wpcW4LE2al6EQ7iWG5An17gvQ1UT5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500392; c=relaxed/simple;
	bh=HbJjg6vJnegIAuHnq4gigwlJklaaN/WaxdyBAOmhxdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/v0S4nX0lE995fO7ejyxjMAmmt/RSIwm0+oEjHYR7JjDdlXG6Q9GIqteEASEia+FnD1oD1ono2kvzn5CE2h08nB7W+/4ZFNMXXSCjokv/6bxXR11mR1mAn72sIRoXF6wBvLTKCLdLHg1LbGIwKVO4cCq5ha86o12C7rPFmLMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L3ZtaVX8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WASJaQ17; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L3ZtaVX8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WASJaQ17"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 57176138541D;
	Thu,  1 Aug 2024 04:19:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 01 Aug 2024 04:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722500389; x=1722586789; bh=fKocx4oG0a
	V/zcL2fQJP1OMq19MniV61Xz5d6W1I0bk=; b=L3ZtaVX8hZjSKeUWmugp3JKIGu
	/phUt0+7eg9VucvWNAOlYC/TY0bnoFOiMMeeVaqCpqsklHouQCyJeXdEIM9iSXzz
	DXjk3iVq6gfcJtl3vVmRE9J57L4Bv5+DwPHwIPX9fWlxQykqPl8ABeRtSVz5g2WI
	6L5NlLjx9tM9d1DyXZREzzlycfBZVUa+I+SGR4yX80T5TXDBrqg1Pq685TXfj++V
	hft9BhOAc9PcK7fhgypiL+P15hFPbAqSwJcEam71EtpB5HGID+81d1lcVJMQnyYm
	IwRET+klGpyHo+iX1lBcQsibPE4m5whS9j6aqgzQ+KH9BxrYvGNPS+nAvOQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722500389; x=1722586789; bh=fKocx4oG0aV/zcL2fQJP1OMq19Mn
	iV61Xz5d6W1I0bk=; b=WASJaQ175n64zFYB0uyN60i/n50qbvtjP0Lj1+oqJXS4
	WcwL/ahho6Nc76bVkAFBk1JelatVO89Bid6/GcdBVVgc1o1miLALNc9hMphjVIfx
	jTljx7lWTNQJFYdsyi7VaOByDuIgKSiCEotROiWbqjBOSSSn9qfYedZ6XOF2muEH
	Mw/8FFpF4QpKCzrPg+n1A2XF8/Npa5+YwELCLYDDwTHtY3vsKeJzE3z4PWWiRnqa
	IJCCz54j4HYMQw8fRgChUYDLHFXqS1El7xuzEpYO7t7JNYb6RT+D07VbCue0fwd3
	fDU/X8Cmj/F+3TD51csw/YD7RDlQ6K3wDTc+IY56vw==
X-ME-Sender: <xms:JUWrZhFnfNXzfKIXkq4RM8BhVImcBKd1REXYLvpq3PTQ_ibl7VlgUg>
    <xme:JUWrZmVEM7TxVi8xZVKv8rqhC4kQZ3M9mZTZzLu7KHEvIOcypHBF-XAwpZNn5luV9
    6FrxBcXCJQ1nLizKg>
X-ME-Received: <xmr:JUWrZjI1w2P8LaHGXMgHo8i9KGKfWG7441m4o-ebUuRJXO4FhJX-kKD_i9PWNNXUliaqjnXsa36I2VFu1OQUGqKsxWUiP2l3x-pKEo0bccsGtZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:JUWrZnH-44bo0DJCcAv3hv9iLJXCScmQG0mQgPNVBhyw_5yTreljAg>
    <xmx:JUWrZnWgHBBVYpD8BuHFLfrl3W3avCyNuC_tt_JOUaem6YD2a-cnZw>
    <xmx:JUWrZiMMHHf1i2qEl8moFUk8eS83uf75v8lq9Zd6c6WgrRxkDlhUgw>
    <xmx:JUWrZm0uuubVHDinuavfKlyMhBcwPo5kOx96aEpj271mSukNaU_H2g>
    <xmx:JUWrZkhnDXRofcutUiYrvN-CGTDjCLYkuKnStHCKzbpYHo7N8yqyzXCv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 04:19:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 41afbe66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 08:18:16 +0000 (UTC)
Date: Thu, 1 Aug 2024 10:19:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/23] Memory leak fixes (pt.3)
Message-ID: <ZqtFIblPxqoXww-p@tanuki>
References: <cover.1721995576.git.ps@pks.im>
 <Zqpt0/6zBOpYh4aj@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8yi8Bkt3pzPWDt7b"
Content-Disposition: inline
In-Reply-To: <Zqpt0/6zBOpYh4aj@nand.local>


--8yi8Bkt3pzPWDt7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 01:01:07PM -0400, Taylor Blau wrote:
> On Fri, Jul 26, 2024 at 02:13:43PM +0200, Patrick Steinhardt wrote:
> >  57 files changed, 251 insertions(+), 73 deletions(-)
>=20
> I took a careful read through these patches, and found most of them easy
> to review. I was admittedly a little lost with the "fix various leak"
> patches, and having slightly more context in the commit descriptions
> there would have been helpful.

Yeah, I was a bit torn here on whether to expand the commit messages or
not. I just didn't think it's all that useful to always say "Variable x
is allocated, but never freed" for trivial cases where allocation and
freeing need to happen in the same function, much less so if we repeat
such commits for every single such variable in the same subsystem. So I
just threw those fixes into a single bag.

Patrick

--8yi8Bkt3pzPWDt7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarRSAACgkQVbJhu7ck
PpSt/Q/9Ey3hEI5lgjY2hmNHn+Oo/0cxVVsQLofdV3Xg9kdfrzAN0biE2Jxi73Eq
B+p5ChHqW+qBogBMj2PLvuMkNlV6cdpQ6424GdiaxKK46HpzWNhpOzGItX3E1HB9
hv6y+JC96suRwSvKZLhe+oyhCwUSQ/raThZnthj7spD6AzBeNxbdhTjeJWfaPxT7
vHFfOInPN3lY9rRurFp4QdUjtjJIYn+83PspH9yniotfj/cJ4GX6eTppYjXu8CnW
6gibj4GcPgG/uedhsI6Z2A9ivPo5BVVgBgAsJgdJthnB0hLY3A3nDSyY5K9y7d76
tE9x98GEVTyl8JmxYMo0DqJptG1SfRduNxnqR3wsMQnofnVDz/8ThOimFrmDJv/S
VJ4LzA6XqE/AdY8swJufqgdT1wp+xI8xM9oPZ+tIezXJ6IJoBYG8S4tSab3K51eJ
z3kErCxLgilypaaDZIXKGLd/tRcy4Bt6HLMMfjGYfM0kdX3yY+Vqgz3J4w6xkeuK
HwJfnqZa+aR/8KwL49lKdowgz4BT7PZa1svfUugBP6y7/HePoKr7j8OUQSJ4OUiQ
Im5+phubtaw+Vh+zff2gBBL2tP6/2oZbMQOjLSGJ+z+EglMyirUO0nDAFF7RwEY+
iSetKtAZec70PEbfVM/kURM2dirVeiQVi/OlqHwMNWF1jMwEm/c=
=/jFM
-----END PGP SIGNATURE-----

--8yi8Bkt3pzPWDt7b--
