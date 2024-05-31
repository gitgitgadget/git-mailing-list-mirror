Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A233993
	for <git@vger.kernel.org>; Fri, 31 May 2024 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143516; cv=none; b=brLRKlI4SwOxj+hg/T9eWxgCcah/KjNSm8PtFQUg01Fr6i5zkj9rvUm6cN9y7XzUS4eP4O4Dw1FSB4AKQHiBHEdRNT79p9AZQLHkPFIfyPH/OVpdgvfM12SSWeXw733kFZW4nSRTPOCjgzMLr6AeTWXEnLr4ZUPTB+CQAmcUJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143516; c=relaxed/simple;
	bh=hNi3JsSthR++Uy11wjUf4fNZw9JQkb/dRLn4o3WvMa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLnTP5wg0PSSAss/M0xJh+tTh1VLIo/R6C181jcjgcI1VMfDxMdg3Nf5TigGLla2cGtN4zScQojFOxitfavXSjJCtEaP9fucKMIpGSWTYWBZwZIQs6HW/a0Czrr+mUHOIfcEZiAG/Dca2tWIzx3/K1ZXOJ/5u+Xj3KcG3HSoiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cD3Xjei5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WzueDB60; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cD3Xjei5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WzueDB60"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id BA28913800E6;
	Fri, 31 May 2024 04:18:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 31 May 2024 04:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717143513; x=1717229913; bh=FWb6NdYxl4
	4pvMcK/6oA0+063+hek6qp+ZTM0aUOaf0=; b=cD3Xjei5lWWF8ygW1maC23XAj8
	pDdGzDhJj6lMp/tjbAcvDxCd5lwIBMP9nWgfqbZSsC8l4dIYco8cUKj7jpS3RCJa
	4UtFPOvFV3/2pPcmsirPJwFrHwc75Bkx0qtDgLqPECwuiUM6NZ8GPAjxcMOmJwl5
	6vd7XtBUFa03/uLKkW84xw2mUGUu2de6094m1DZD+eBzdnvaLrFuJ9hSL7HlIGDU
	ovBPP6dmyRcN+tzmtC1READLpRrh7fXiYf3+P07ImSDI4fYmfOPS083coISsgyQk
	X8o0LdvaRVO/sJ2ZZYcP6UjcXTAE7G83nSsxevum2eQxWsAtPdWh52ZY/lwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717143513; x=1717229913; bh=FWb6NdYxl44pvMcK/6oA0+063+he
	k6qp+ZTM0aUOaf0=; b=WzueDB60YOD5LnGeLhLgObqiJ1P1ag2jUQIHnjUEShBa
	HdX32HF35kMFqxWTkWdY54QcE0V4eGOs5EBFvaGV1s1uF92om50uvrVo/uylZF/S
	XvQJb1IbWLd5iyJUVELhbT868nA8zbsWcsS+ptZ3Zz904HltEtiD/7td+4aPgSE7
	6nWITPXeP4FoWiamxTubedYYGI6xaspta6r+yBely1zXNMA8WWizBEKjoUgIJscT
	MOposvre/xqDmvEOgZ7xlY/XNt2CznSVm7I91VnEKs8S0U4IrDx0VGcXSEfcqajX
	AoMAmVW2bARUkpwRvjmASx0L188w9KQ4W0nfu/5EOg==
X-ME-Sender: <xms:2YdZZtXHIH9jcMYH0CHPDKTsBGC0R3eowKwjXwFdJlGNoECevJDlsA>
    <xme:2YdZZtmP0MoUCJ2dJZHJlGJNAgkkGEMXcy0NX38VOx4DpNzO1p4GZl6YUVupXSg7k
    7Y1pGVQYwDWtse5MA>
X-ME-Received: <xmr:2YdZZpaNdn0yRgqgH3tkLv_Fm0gSR2mCN1W7S0Uw7omJWbPfszaTZAKK0OC5aNLrR3fEWq5koVoV9PY33Gz4--GZHDWatPTF4fMavvj35RNi3Wo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:2YdZZgV52s3nCmW_1jwmOEseEwlLcXGetSbWFTtsBGPl4MvfG5bQ2Q>
    <xmx:2YdZZnnJnxFNAbk-f7W3AMnvKq-IxySNEi8fQXROlz3oJIVVq0luMA>
    <xmx:2YdZZtcafjrwE18Plr2h7voj3XogIC_GQLH7iqDuhruF84qrPf7HFw>
    <xmx:2YdZZhEpoNaTb04O-5lWgvaPF3PVE9oufTNhs8Fk_3tG9ChHg1TcIg>
    <xmx:2YdZZgBpjfd6ZvOskYTkffy3DYzsA06rcCDZen17NW3e_pmosKlAqn0k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 04:18:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 490903f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 08:18:12 +0000 (UTC)
Date: Fri, 31 May 2024 10:18:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Stefan Metzmacher <metze@samba.org>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: safe.directory wildcards
Message-ID: <ZlmH1CFZWHokAqso@tanuki>
References: <715163c3-8d59-46ef-81bf-1dda10e6570c@samba.org>
 <xmqqplt4zjw7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NKGeJzFX0BHajHLO"
Content-Disposition: inline
In-Reply-To: <xmqqplt4zjw7.fsf@gitster.g>


--NKGeJzFX0BHajHLO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 09:02:16AM -0700, Junio C Hamano wrote:
> Stefan Metzmacher <metze@samba.org> writes:
>=20
> > given the recent importance of safe.directory, it would be great to
> > have something like '/data/git/*' to be supported, not just a single '*'
> > for a server that serves a lot of public git repositories owned by diff=
erent owners.
>=20
> Interesting.
>=20
> The original commit that introduced the '*' opt-out, 0f85c4a3
> (setup: opt-out of check with safe.directory=3D*, 2022-04-13), was
> done to specifically help those who have a large list of shared
> repositories.  We could have moved all the way to allow globs back
> then, and the possibility certainly was brought up.
>=20
>   https://lore.kernel.org/git/xmqqk0bt9bsb.fsf@gitster.g/
>=20
> But the loosening was done in a context of "brown paper bag fix"
> so it is very much understandable that we did the simplest and most
> obvious thing to avoid making silly mistakes in a haste.
>=20
> I am reluctant to use wildmatch() but I would expect that in
> practice "leading path matches" (in other words, "everything under
> this directory is OK") is sufficient, perhaps?

Is there any particular reason why you don't want to use wildmatch?
I'd think it to be a natural fit here, and it would provide a superset
of functionality provided by leading paths, only.

Patrick

--NKGeJzFX0BHajHLO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZh9MACgkQVbJhu7ck
PpQMuQ/+LQina718lDwMJH6CAHVAToUBoWLjqq3+c+6bOb/4J3A9xVqVJ1GWPkFp
bV4pk6SGcC7ZjTZIchJLbV1pRkJFY3hNgx5efOlM+V+diTcb4zrjSv8LIpk5Az8T
4p768q0FQ3EVoihvwysJWg1dkKX99oy0ig1MuwSdwDRfdtXa+DYlBPoXi2ytjye6
4oQLrLM0/A+hpNcV8GzUdPfR/hM6YHOr7uVD6rG5TzrgbwaqEi7mVkgd4ekjR2qw
ejUh5IlVNV4W3XtfWl/DWMSvUer8A7zzkN/7fqCBbHBHlrgfARU69AV89cz1p0x8
UPsK1FrTuLVwSiFgrGl9mfG48VPZWKUKEQBWXq3lofF6LYqIXGc4VyZgjMF8IwhE
lUXesK906Pmnj3e6vnofq6GdaPY6ElkGlXmOHcI49JHLyCJUWF3S4/BGZ3qWYwVM
YsN2+GTkzWwYxMNO9MOEdVrsNv+ZTHorbQvqwFHK0eP8yVkQpsVnXnuSoH5/KICu
zKVGMIWjDoqmy5+VDZhGum5ZUi6NVwOntgpsk9AYB8/+s4WgjvNv3K1Rnvp12gqx
RQi2Oox9uYuHFDPtK9lblC98SkNsy6WdxLqtxV53wRjhXZz+CX/L1cs2fTQuIBP+
wr6ZmSGYK4cdqGUD+mHS0Fy1yhKTso7u79FedmjsMDa5fl+wDb0=
=tIYj
-----END PGP SIGNATURE-----

--NKGeJzFX0BHajHLO--
