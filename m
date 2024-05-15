Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598E381A4
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754960; cv=none; b=fkmgQm3MJ63lFmbigbKqqJDj4cqCMZ8wzoeJCr8FZiKklQ148FV6QovEsOXnS9pOU0MAe3u68wrEbmCDOzEtAm8FrJlbmmFiN4pT6r3bNDOCTPyyyDn2TbYDNbVaHXww+0cvoQDWRh1AUHtj2kXAh061t2KvYQ2nX3PIpA0SgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754960; c=relaxed/simple;
	bh=CCvwPNPgbF9m8X97OMT6aWSwxW3rAA46ncwzpkv9J/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5oMyS8bUyuGstuHSoIKO7350Aq/hkIFF7fR6AyVE3Xcyej2C6weuJDNKgcwe+scX5c9lMUy4onX3gHVa4ACdk5GquJk+YNXlUbp2Cw5MWzeLusXfCOC6fismRO6hOKZqEKDybesbk9BNB+gIyMmNFrRdfWN147YYpSl6S1UAr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U6NGBUtz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OT7u6e8I; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U6NGBUtz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OT7u6e8I"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 087DB114018E;
	Wed, 15 May 2024 02:35:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 15 May 2024 02:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715754958; x=1715841358; bh=CCvwPNPgbF
	9m8X97OMT6aWSwxW3rAA46ncwzpkv9J/o=; b=U6NGBUtzFXBpSN2C8cXoWubpL5
	E2H/ECK+EJYHN3TeijUaU7PHyqkg1662tdwOZ3CYVx6VvWbYszuwqz/jukQWYUlf
	e+lZRjey0qj3DRj8Hi+LP8vVpUFY5M11IMT04131fjKIM7Z+4PMzjPMAy52wFIRM
	9vuCq49IDt3gtQCvDSvmi8RcrUqGDkngC+IxsJL63uFRTlOlOej9uvzJc4ct5t5o
	qBDOHBGCnAJMTQ3rT0zZxcC563ZFH5gQ0c4GBoIf2cxnZjkK9Ov32bgauEl+67dx
	uYFROHOU9hOKC6DHxAqApK+qOR1zeRbdBiWyRByjlXkdE/ZClG8gxk7Rp8Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715754958; x=1715841358; bh=CCvwPNPgbF9m8X97OMT6aWSwxW3r
	AA46ncwzpkv9J/o=; b=OT7u6e8IVz9wbkPA+Jq2G8a48Gy7gLThgkKv4VgdLhIm
	Fy0j+wb/iut8jkHVJvGtYaX4nNm0nil8c7Y+HFEoUOvy9G2OTU6wSGlrw88hiJwf
	d0qzIrOzX08CX9fGXPudPMMtM/otaOZNrN+FKfAnSXxF21om6jxU2mXXacaiiiqm
	gO+fc0QTQs9E8nIN+t8plFj5lyXJncucKXSQLa2D4kNxYlm3FBi9Qr8NOA8VWYs7
	6jpTSRIkVV2d1EdMQ2nybfXV4o2usqrZ9yjtlUfvv//2jKX9L1J/riOBj3dEWEt0
	708a+fj/DgpDUy5d87J7afr/P/EiNBW/W0h4zSfHiw==
X-ME-Sender: <xms:zVdEZqTDYmqqXHUDxSAEzI9EOZ4oDHYW11f3CPqjXm4bL9y4NSbJ1A>
    <xme:zVdEZvzA-OJ4bMH44pvcWjKOISuLvtdrkiKa0jthZ6yB6UuIEfzYbNGDP5K8fF1tS
    i639qcPCx6ipR6Ejg>
X-ME-Received: <xmr:zVdEZn3r_IhcV6cJVdqHoRRC1jl9aupNP6Sj-shQGCMPREdkpznmCn14O43ul6nb9hajLFXhVZ35eQ0RmCT8GvLe8CdMPyNfDrqd1mjyzuTZaNkG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:zVdEZmD-YVGfTmOqR-DGHKVkUMCxQ_RcEg9OdSpbEWU0HxwI_CsNcg>
    <xmx:zVdEZjhTB66X-ID7pgpgcEIvfn4GVXNljgtks6dKDGuai5GfmfqDRw>
    <xmx:zVdEZipbaXb8zVrI_6O008DgdXl7QUUYNppBsNNF93nNPbZAgrYR8g>
    <xmx:zVdEZmgeGfwNf9ieRqPKulPy-5ZivRReE5fbGsZYp1NXI9fueGAgHA>
    <xmx:zVdEZjiCRHdKq5c5WOtUgqX76iOgPNX3GWz7g5Dh1rrxDwpzSLjlpH3N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:35:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3a4e49fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:35:32 +0000 (UTC)
Date: Wed, 15 May 2024 08:35:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v3 07/10] refs: root refs can be symbolic refs
Message-ID: <ZkRXyH0dX3At3vDm@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
 <92a71222e1067ca4ce9ecaaa555d78d0cce0d9d0.1714637671.git.ps@pks.im>
 <20240503181339.GH3631237@coredump.intra.peff.net>
 <ZkQ3EiL1OY10Y2JP@tanuki>
 <ZkQ8mDrBB2eGg8Ns@tanuki>
 <20240515062220.GC110841@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Q6wlJ40QUZrfpmD"
Content-Disposition: inline
In-Reply-To: <20240515062220.GC110841@coredump.intra.peff.net>


--+Q6wlJ40QUZrfpmD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 02:22:20AM -0400, Jeff King wrote:
> On Wed, May 15, 2024 at 06:39:52AM +0200, Patrick Steinhardt wrote:
>=20
> > On Wed, May 15, 2024 at 06:16:18AM +0200, Patrick Steinhardt wrote:
> > > On Fri, May 03, 2024 at 02:13:39PM -0400, Jeff King wrote:
> > > > On Thu, May 02, 2024 at 10:17:42AM +0200, Patrick Steinhardt wrote:
> > [snip]
> > > > And arguably is_pseudoref_syntax() should be taking into account the
> > > > "_HEAD" restriction and special names anyway. It is a bit weird that
> > > > even if we tighten up the refname checking to use is_pseudoref_synt=
ax(),
> > > > you'd still be able to "git update-ref FOO" but then not see it as a
> > > > root ref!
> > >=20
> > > True, as well. I'm less comfortable with doing that change in this
> > > series though as it does impose a major restriction that did not exist
> > > previously. We probably want some escape hatches so that it would sti=
ll
> > > be possible to modify those refs when really required, for example to
> > > delete such broken refs.
> > >=20
> > > I would thus like to defer this to a follow up patch series, if you
> > > don't mind.
> >=20
> > Arguably, we don't need `is_pseudoref_syntax()` (which is being renamed
> > to `is_root_ref_syntax()`) at all anymore after this series lands
> > because it can be neatly rolled into `is_root_ref()`. The only caller,
> > `is_current_worktree_ref()`, should really call `is_roof_ref()` and not
> > `is_root_ref_syntax()`.
>=20
> Yeah, and I'd expect that the more-strict check_refname_format() that I
> proposed elsewhere would be in the same boat. The only reason I used the
> "_syntax()" variant is that it was obviously wrong to do existence
> checks there. Once those are gone, then naturally it should be able to
> rely on is_root_ref() itself.

This series hasn't been queued/merged yet, right? Do you plan to reroll
it? I think that the changes in there are a good complementary addition
to the clarifications in my patch series.

Patrick

--+Q6wlJ40QUZrfpmD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEV8cACgkQVbJhu7ck
PpTxSA/+NVbwbZbYnvWbTSNhkJgLCw3SLD1Fjs9g58aQcPXscDEgPcD6YFgIHBiC
WWA2N+UcqMiNY/kNOlyxxe5VSTZPDuNW9enXNbNZB2AVg0ypFr3QyUCQ3tIjM9uB
OYrbueNbzjlowpypoDwdetF5WtNcOYn5CHGruC5wRTxsUSsFch8O0OixpNNbJG2t
JKEt/su/brpO44RN5HxcC1FA83G6RTx7bTi6mMn0HNv5U+Xk7rNdkexXdxhrROpZ
zjbj1ZlM/63A2CsNBLhD0VudS59cZalCIKmcoX6/XRBlBIm+6bytlQqeo72f2b3N
L7JQ6pxqJJ9w2j3Zoq1M+PSy69enD3z3wmZvwVK9FH9RZ+oiOK1yZyZJqWrfG4hw
1JNydZIs7tsckQa2OJlP80KJEqHszMOizjk1Z+qa8RUr3sGIPt1mmZVCOMWQcE4E
LZhUgi22iXZzp2G44bBurcPia4VyyeZ0n5tqTiE6OO3nbHWjsny/3tx8ZaqZUZzT
zCapeTd8j9b2rRCA9h1b3tcFlQd9b3on/qHBBNyEtgMj6jEqBO9yQaIIChzHbdJ0
PbkScbx3kdDJaZAdRRUZl3IF8d6EsVb+PcOAQPHRea4P1U2VBWmKdlDP/9DqY1Y/
Ys5mowJ7DgnwDEKflzozWHvxu/Dp1VmP/P/OAuLgvaar8oabsEk=
=Kz8L
-----END PGP SIGNATURE-----

--+Q6wlJ40QUZrfpmD--
