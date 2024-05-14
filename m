Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22329445
	for <git@vger.kernel.org>; Tue, 14 May 2024 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715669283; cv=none; b=LPHnxAJ6nZ7oO8kGnMAdDBRePJ9SNKAPSH7y8CMkoy6yf913d5bwk7c5VK0mfGhiMCjDYpYvH0qWMv8aSeCHXqBhTeFJSmSJbo8meYMgtyWncSO59/7LO9XvgbZANzRn/ksuCYNJ7mWSAbPBdgf6wyDG8oVMulud9+QdkzINNMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715669283; c=relaxed/simple;
	bh=ADFy7c6AQGCryobLErqnirHwu5+Exle7UBjUCSxlU6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyymzFgr/nZKnB4cN1M9EwwSRqRfm4EosEd6rRBEhUf7nIqsy2b1qqqImQ9pdDGZpiHdRq1MvXuhzK9ali80RgJXSPvJS8iq5Q1tuD89nBnfZJ9muGCT1DCva1wWdSxY323e9/LKhq5rRBqpjW1N32xovOQVaS+YJz2KPpYCZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I3XHdSt1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XHclr9z2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I3XHdSt1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XHclr9z2"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id C99C913810CA;
	Tue, 14 May 2024 02:48:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 14 May 2024 02:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715669280; x=1715755680; bh=RhcfTZOpFO
	MZRi+amp4d+PMs4DWWGG7o6YURWHBE/84=; b=I3XHdSt1y8mwMfcbmPfpIkHg69
	wBNXg/lkCkEb9XV7gIfrWJrwfydU325U8IcfaM031e5UR2eWu80ujP6bY+0TgVtK
	uiIR9yw8/fK2+PVxdgN514GtURC41meWe5m7AbYqpbsvGFAoS/Ie7ZkVHheWqHwk
	tKRsJMI/K462JLXbMnG9PiSx71q90tbexupQIvYf1eTsTbO7Np5UuQOtD0LQSVCr
	0uw8qNK1LZr/zioQCtaF5nTu61Y8lJiRcSHEbfG7te3p7ZcsNSHdSezNBj+gBgvx
	ceQIaDMb+3iVQcweGIFyD3pDU+F1OD3V+YQ1m8/4GA0XR1w5yShjC1Kpjzuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715669280; x=1715755680; bh=RhcfTZOpFOMZRi+amp4d+PMs4DWW
	GG7o6YURWHBE/84=; b=XHclr9z2dhhnsa0QNfCqvtsqlz4qbxd3YtkpsXKkfLLD
	Sy2i4lnZUH1x2TK8dLFeKWo4MM0L8eHQ+zrGFOhH9Qqpvxoul+fa9Ra1NtbT0fQE
	cCUzeN52CWMESF3jkmfsiPsBWxrtK+FBUG4/BL6vb1c6v3H+SlvR3e9RkkVH5Qnr
	7VzkC9ropijBd0tB8f8WTIKJeu6yXzHG7N9dADrsCX8dIg7Cfh+PXOi9c+pBF8/n
	lh4lcpxfGkDuw4rSCFgVLjP5XxmMyr/6JOTYLJMttmfNmYy7UswPpt/QBW5y7+dG
	3M5NCbp2cjC1SgJY81gkIMna+oe0k/NBBT02CbR8TA==
X-ME-Sender: <xms:IAlDZiDFJ2sbn9EW_V4uW2rQ-moo-tcBBiVbugHqViA0AIX495N3Ow>
    <xme:IAlDZsjKfxyg4XHaZQJRbWXypk9ERkxByUlw4bXZ8TZfmFwPhBLMH0hy06fGfrXdv
    nZnMaSC6ejqag1PFQ>
X-ME-Received: <xmr:IAlDZllfWUpSIrJJflRnkgF3960KNNGWxjaFfMaoT5jYYAbkdDuTt02ooGtUPym8g7goJWMsBIK4x5CJWqiVtMyEu3kLoa1_DhJG4h5OgeoiqptrqIgb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeghedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IAlDZgz7pkzbc6AyAHffZH0JPKI-tcth0oou3skCkzPQFjVbA-wrsQ>
    <xmx:IAlDZnRw-buurZvl0vLC34EPqZuKMn1DhO_gIXFKFH-H7eBoBCcdbg>
    <xmx:IAlDZra1E-iFtrUkBqzAsJjejJF_C9KgTQ_jEg9PoSyJFiq_TRWt1Q>
    <xmx:IAlDZgR0C1DvbOJ86GjqsfVoHiM0qiGvaXJQZhep9Z62vCJ_l_hQjQ>
    <xmx:IAlDZieYjjGjiFlWVHAI0wczAdp8ylTo9qdyJrroCedQwwoV14wVmKya>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 02:47:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0a74f1fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 06:47:38 +0000 (UTC)
Date: Tue, 14 May 2024 08:47:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: David Sanderson <yelliott@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git pull --prune --prune-tags yields a usage error In 2.45.0
Message-ID: <ZkMJHMtiQWw4qdT2@tanuki>
References: <CAC-6ESEfnjK1ubrzoAfUsegM55e55uKugCPSfxnBC607dmZJRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PUfVxNEUsp8ceDnT"
Content-Disposition: inline
In-Reply-To: <CAC-6ESEfnjK1ubrzoAfUsegM55e55uKugCPSfxnBC607dmZJRA@mail.gmail.com>


--PUfVxNEUsp8ceDnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 07:11:00PM -0400, David Sanderson wrote:
> I noticed that "git help pull"  mentioned the flag --prune-tags in
> conjunction with --prune, but actually supplying this flag to
> "git pull" results in a usage error.  For instance, the command
> "git pull --prune --prune-tags" fails with a usage error.  I would
> have expected that this would work, since it works with "git fetch".
>=20
> I could use "git fetch --prune --prune-tags" as I expected, and
> "git help fetch" does describe --prune-tags on its own as well as
> in the help for --prune.
>=20
> I confirmed that this behavior still exists in git version 2.45.0.

Indeed. The fact that we mention `--prune-tags` in git-pull(1) at all is
a bug because that command never even implemented this option. I could
see us going one of two ways:

  - Adapt the documentation so that we stop mentioning `--prune-tags`.

  - Implement support for `--prune-tags` in git-pull(1).

I find the value of `--prune-tags` to be rather dubious as it does the
exact same as `git fetch --prune refs/tags/*:refs/tags/*`. I am heavily
biased though as I understand refspecs just fine, which many of our
users may not. But the bigger downside of `--prune-tags` in my opinion
is that it doesn't only prune tags, but also fetches new ones. So the
effect of the option is somewhat counterintuitive.

So with that in mind I'd rather pick option 1 and stop mentioning the
option in git-pull(1). But that's only a preference of myself, not a
strong "no", and am very happy to be convinced otherwise.

So unless somebody does feel strongly that `--prune-tags` should exist
and provides the patches, my proposal would be to remove the mention of
`--prune-tags` from git-pull(1) for now. We can then add it back in if
somebody does implement the option in the future.

Patrick

--PUfVxNEUsp8ceDnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZDCRsACgkQVbJhu7ck
PpTAjg//Uk1vxQ4T8EAg65qeaF01lRgDWqklJIP+QrM1+xDYPYZ/mg1rKVXcdS4v
ubVkBSjI+dNtkKA6IT97U3qJ2uzOnLPhypi9AkbUUiIlnB7kYi/qH/I2smC6B35I
4TAEx2vrtxssVBxbFdkzeORv2PZEhVi0SqLt/K2iwlVcH8+BMXaDPD6QzYcBOWSe
z6zTev7rhF+h4B0HksxPVq1x1bq/NygWZfD0WFWYYJzaU+on3rMDK+/FVwMekmJ3
9OlJAeXcVz7ytUBXNzqhwzXdIi+T1VD9m4WCKFoueve+d+tRRSwrtWVQI7QTN7CE
hDMbyGke7hhjy/g2KKlGycjibAfTKBXFEJib5DhY3XF8oPQOx7byu3XT/UbvAeE6
ib9hbC4PMmNAfbHs3Q+Y6R6ri0E3FuhWW0niB+Ug/YVjUPFnO7RINWkNlOOx0QNK
RUi64qL7ZDgjOX+km9gv8p4Wj+Ur4EbbT3nYSF4G7hDOsop1WQ1PZzkcaNaxxkU0
x+30nzxIBzNeyP7VM8n6NmhZpUU/NDsDFG65V+mnu3njh1gLdNf2sll8GmHO8TT7
B/s6znLDrvWiSXTSuxNeMQsNLq0oWKKVTnGi9q/QinkWFb2LgX0ZPe1fAn3cXlVM
fFb8t0dmgU076Vxd8t5bjxVA7afIkByxb7ed2yqfdfSegE2m5Hw=
=a7Ji
-----END PGP SIGNATURE-----

--PUfVxNEUsp8ceDnT--
