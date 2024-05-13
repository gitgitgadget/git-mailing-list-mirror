Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17131474BF
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589384; cv=none; b=TgVCb0ev+lC0wAc86F6ZeVudrwISs/NUyBT5sYXIeTfL5r69rG5TXFGU4j6+KdnT5rIxeEo9Il6spskPukeh49qDLguhP/92SGcJ/KZwh4Is8txjOAzx44D6RHWAHmXcpNa5Hb0bzv23Xkj2iP/U//30IFrDk/ICxOsWKjQa3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589384; c=relaxed/simple;
	bh=1HzhTbgqIBrs1AtMUe/Y1jeaj9A4HVaIHHWXSY71rFw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MebsJhp3xGADYWKYeCqNz9ogpmlw/XWNz8eq41vg22SqfMBt84fJIhrOjC1nMJKWv6axYIXzEOuz9biVIxzgidXnsHy549LRGkqcXC5dzC1gby2J2pRgW5FwWfncTz5esiVvGc2pqa7BtNle8uNg1JFh37rfTuI8MyGJ5EiA3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=om26pNkY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jg0IaOXE; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="om26pNkY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jg0IaOXE"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 1D9F11C000DC
	for <git@vger.kernel.org>; Mon, 13 May 2024 04:36:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 13 May 2024 04:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715589381; x=1715675781; bh=1HzhTbgqIB
	rs1AtMUe/Y1jeaj9A4HVaIHHWXSY71rFw=; b=om26pNkYmsECcOfGGcJbCMY8ZK
	EPPQDcvRFtAigv3xKGmlNSi0g/s+czAtXybsekBjCQtXnrVYW+dhH5MtkXA3/vV7
	ivnGoLsjRzWq5JnkD4L7n+SQ/9wUxVIQo7o/GPyDs8R+blPTQLFDOxKL+CP4raW5
	1zCC8RseDw3IPTDpZvCK/iDKEXbthoKjb9+jtS7dV+uKUQFHet1EPn8lKRsqUv0s
	bV0x7QEBs1AKA+xIRea114YGR6N1UF+5Pc9vPqF0bv5zGKA6iXyzArmeP32w7SjQ
	SntiBhC8O1wQO9G2U1JAKLJHAEsrGnFGJ6pCkr3SNd3GUMevfg9F64YGWb/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715589381; x=1715675781; bh=1HzhTbgqIBrs1AtMUe/Y1jeaj9A4
	HVaIHHWXSY71rFw=; b=jg0IaOXEVt4OWmcSayiJsONI+xbIzzBUPt3zTvDwFcZJ
	deVwxB2kkZwxfFzwp4nClkUCu2ezoQONtsc227BoS6Bw0HNGHa0EEQjzMZNDJN2X
	0MpkEPOF9odxWgwBh6bh9xFNQS6UNph8dBlGUthWd02E4yX5+FBpadQca4juZ3mW
	PQBdEhugxsK4ubkXiVchrFjGlMwIc1inGreDN1i/PX4714WfvsEF5whBAYnzU8lf
	WR6NKqkFDyucgxk05IFX/xHOx0LsnKybyICQczmb33I3SG8X/wLvKXb64I9OlcnI
	6UEMANhRpExK0phTeAUlBf9tkwmLYRcOaoJNO+Ccrw==
X-ME-Sender: <xms:BdFBZjPnJ_AA5J8ivYrKfCd6C0vU-V_yUIgGowKulGa0whVrBJn0-A>
    <xme:BdFBZt9er78Xee3dV3kN6cWXhN8bJ-wiG_UbR3wL2q828oiVrrF3xwZIRsq0X364J
    IOGPQNS2FZGC7CF9w>
X-ME-Received: <xmr:BdFBZiQX3PuQGGfOgH9BoTEy3s__Y5tBCI1OBSQK82eYWYmtlvpYbvBBnTZ91u263RAlBDWjryOl4jEJiXpONqraZOCBXaIa-d6VLOO-YhsRLm0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BdFBZnuek8sPbYBy_UTMKPG5Q2lupf65_wPhV6c6Lkp74MthxonxRw>
    <xmx:BdFBZrfA5E2DyxqHe0AmRmKjZSdk3xztuu_Pw2Blgv-SN5cV-fdyKw>
    <xmx:BdFBZj0UJYvkJjgIqzBT6kQVP9XUzlKLolh5FoGqp2_y2f2Ynw2F_Q>
    <xmx:BdFBZn_90Y9MvBm8qfTkiTsEnobXxbqQ4P0SDxFDQkZB6ewq4oAunw>
    <xmx:BdFBZjHek1U-caKbm48kytXevhfBoUftabbWGGImjzyXYzjofikKy6i3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 13 May 2024 04:36:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ad48c2ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 13 May 2024 08:36:02 +0000 (UTC)
Date: Mon, 13 May 2024 10:36:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 08/13] reftable/merged: simplify indices for subiterators
Message-ID: <ZkHRApu7WvdihQBe@tanuki>
References: <cover.1715166175.git.ps@pks.im>
 <f0f42cd56b9e54e9c7d58be41fcc4e226d5c76ff.1715166175.git.ps@pks.im>
 <uecirknp6pdo5amkv6kvfvxryiptqrgblttbu6dhz3vh74obzd@7dwnx3agsllr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RY0AzqVUC4892qif"
Content-Disposition: inline
In-Reply-To: <uecirknp6pdo5amkv6kvfvxryiptqrgblttbu6dhz3vh74obzd@7dwnx3agsllr>


--RY0AzqVUC4892qif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:25:09PM -0500, Justin Tobler wrote:
> On 24/05/08 01:04PM, Patrick Steinhardt wrote:
> > When seeking on a merged table, we perform the seek for each of the
> > subiterators. If the subiterator hasa the desired record we add it to
>=20
> s/hasa/has/

Fixed.

> > the priority queue, otherwise we skip it and don't add it to the stack
> > of subiterators hosted by the merged table.
> >=20
> > The consequence of this is that the index of the subiterator in the
> > merged table does not necessarily correspond to the index of it in the
> > merged iterator. Next to being potentially confusing, it also means that
> > we won't easily be able to re-seek the merged iterator because we have
> > no clear connection between both of the data structures.
>=20
> Ah, I also found this a bit confusing. I think this is a good change.
> >=20
> > Refactor the code so that the index stays the same in both structures.
>=20
> Was there any advantage to not adding subiterators to the stack
> originally? It looks like it adding them doesn't affect anything.

Not to the best of my knowledge, no.

Patrick

--RY0AzqVUC4892qif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB0QEACgkQVbJhu7ck
PpQgDw/+Pmv701xJG3AiBEDxuFlidpxv5aNY0XkFXOn/FkV7EX3uX8vNf5HHrmId
ATGK/ZTanVSHlJ1QCdpwIMJdTKcJif26nulMX1MOn144kA6yUJyW1T9F2EySJ5bF
Y8IiHYo+SJXua5illOwkySu0sqjlYCo+xdkfQHLJHiwKZwGc5cO7+AFShD4ZC0Nz
cW/7TJChsqZoDUg7Fd1krxEIVNN84yC9zPUrHJxKULb1IiCRpVeIu7KgMIltLYcQ
Gyb6ZBo4LAPTZ+aMN70LCD6O2rUTLkBut8xd0SqAw7t6fQZD/KeXLVKW3oQcg+WN
FzY+i4WDq4cD9gfrC19reN2KsFQeiqxH7WznFTSAHqCp9yBSfztzCsja2TgD5kw+
gKKK6ie/e38N99AmqIAna4/eT5aTeW/CBVPphmxkYGIqhXB5RuUtncdenVmI7o/S
+Zsikm+VX8AJRQjdLHrXqRX11WNVWzEKJk3jjBfQl7vFfi2caS2hyIX/rc4c0fzM
DvjQCa51MArejXRbUb3ycrBtA/cvgJ76J91GO8mmHz5adgUVHpmuLNMkb29HEyDL
QN4S99BkIgJ19d8hpprtB+12shV7XdosexK8ih5fogKYOLCQQqpAEYPWiEdUsTD8
CzN+Z9ZNONjl7f/vsePm63WqCXd00jPPiljBGm+g0lEigBUXoq4=
=uyLB
-----END PGP SIGNATURE-----

--RY0AzqVUC4892qif--
