Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620AC6931C
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378134; cv=none; b=JYhan6sdYtLI5GUeE4OssLv5Q6bFp3vOjjTIGJrxKKIEmOjAXahmkjV48++TbeQrIKu8QKceBbl9sxeHkX26CKmgevRSNTC9bAdGnSLd1jqiG7A4ooq0axSt9+W+PKYteQY24OJQ9tigWA562rGR0NIoYxwn3twOXfWvwwlY21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378134; c=relaxed/simple;
	bh=z091TZxHFl6YB/sEM4VRaswRuSLW1RLozNMpvPJoTaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIvhNptHD9wng67OUCx9EdQ22kdtL9MQjlBgUqAGsHQsRs8qziq3JaVEURpEJfkH+rTTqQs7l/+DZnKghOOHsOjXYIe0uSsNFUVQ/CE5k8ZHb6qdYjHtKJ/pGzVl3vrN4t02mxNcWnW+CXNCgd98IkkzzInuiJ/HZVbvhbn9qQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qm7Tgpi8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SI7uhY/8; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qm7Tgpi8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SI7uhY/8"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1293B180006C;
	Thu,  8 Feb 2024 02:42:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 08 Feb 2024 02:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707378129; x=1707464529; bh=j1SJgYsEMU
	iHthPd8nT6rFPDDNgwCc89u2wnjaSzzuc=; b=qm7Tgpi8SR0NNx/5ZrEYvDPSGN
	UAfLD5zOoJ1qkUBP/t1epULbL3g++aOQL3sAeFAPMkv0EV1SLQjmwSGkRVaeXyRN
	/gVchpy145+uwAbNfYjcW+w3chVaQ1+lQ8YYtPVjnxX+UIzia+mFKskzUhbaooHI
	8nKTe/PABvIGiUF/bZU//3EHdSSjxvdhTMcvAkhw6LJU52A3TjDxNHDqHnQG0F5E
	GTdKpYxVPyObffYdRGOgHOzSPrKTxwRiTaZzNpdwIZ0dPtuF0q7OYXJaRQqIr8Ss
	wyOZa8D3NM3m1NBJ1DovBnmBjSVhCRiGjzMhXyOu581XJwhIguPLc4zWzTxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707378129; x=1707464529; bh=j1SJgYsEMUiHthPd8nT6rFPDDNgw
	Cc89u2wnjaSzzuc=; b=SI7uhY/8TTk3nuUEjtuiLH0p05rFRPBzujcfx1LsT1Zf
	jNi/2/frQlDN3R/zrtx+24WC6GHb1GxEIz2EQeaUnglV4W7lUKpgI1QkS+AodomW
	rvVD+GuEojk6Bk//Ms6d8H5t3807cOZeSQpeWjXp5zKVrHnL8gHYy05zfiYpxAWZ
	9lM6f45EOeYqVcUeSvfVHSoE1ID7SZ33FNIa1w78rDYx2nYwrXCVqDB+Z6k33iex
	GflvVvjKLpSk1jrfzMmMg3b/H3sW5I1BaCbYxSgLGdso+IqurlnBnuWI5SX+IeTI
	WAyXkWEK9zKdGaxMvEBrZNYJ0m/j0r1TNnVb14AghQ==
X-ME-Sender: <xms:0YXEZUKuXZX4Wa_tkH0ldZdlfxOGSkbLby8Y5U8AGAauaq8Jpdhddw>
    <xme:0YXEZUKaQOwYtr7r2XiXRmCFX1fW1TXUxRnHo0vQUR3kCdz3uBPRI8IrAXbh0yacP
    rg5kTKk02qPloDNZA>
X-ME-Received: <xmr:0YXEZUtSUQqtdNDBVzMRaR9meh_MZ-MmtZgeNZ2XlQbD_CZJidDgwL-b-TAKKNLhsrIP_nLng_PUpB98pYSgwFCtHdEJepqW6CQSc4qqWbgDC0fU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0YXEZRbYlqCjnswYaOnC5nMaPSy29E8ojQ3J0nD-Kjmq3n4ILiX7YQ>
    <xmx:0YXEZbaJ6Wp-Ae6k6qtD0O2U30ZqDdtF0nfkXtF7pHDZVvgqTiJOIg>
    <xmx:0YXEZdDC159aaX5ZJx5jQUpPl1Fl8YFzYKD6uqz6vezD-S-ajuOZOg>
    <xmx:0YXEZaUf2EzzyofPVs0_Xh7CeSSMBEIKQ101C3QWi7wlqoH4UOghUQo2daw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 02:42:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9dca4e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 07:38:31 +0000 (UTC)
Date: Thu, 8 Feb 2024 08:42:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 0/5] completion: remove hardcoded config variable names
Message-ID: <ZcSFy864re825MZu@tanuki>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
 <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
 <xmqq8r3w53nc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Cuf9sEc5m2OGFZA"
Content-Disposition: inline
In-Reply-To: <xmqq8r3w53nc.fsf@gitster.g>


--1Cuf9sEc5m2OGFZA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 02:08:07PM -0800, Junio C Hamano wrote:
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > Changes since v1:
> >
> >  * Corrected my email in PATCH 2/5 (sorry for the noise)
> >
> > v1: This series removes hardcoded config variable names in the
> > __git_complete_config_variable_name function, partly by adding a new mo=
de to
> > 'git help'. It also adds completion for 'submodule.*' config variables,
> > which were previously missing.
> >
> > I think it makes sense to do that in the same series since it's closely
> > related, and splitting it would result in textual conflicts between both
> > series if one does not build on top of the other, but I'm open to other
> > suggestions.
> >
> > Thanks,
>=20
> Neither rounds of this series unfortunately got any review.
> Comments from anybody interested in helping to improve completion
> scripts?

Well, I've spent some time with Bash completion recently, so let me give
it a go. I was trying to avoid the dense Bash logic and thus shied away
=66rom reviewing it. But the end result of having less hardcoded values is
quite nice indeed.

Patrick

--1Cuf9sEc5m2OGFZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXEhcoACgkQVbJhu7ck
PpTN2RAAowpLXvuaplyE1iX1dME04YqHQB3cljKT1Rj6MFC0A36xwn/cXSAQ4Xef
y81vJy4AqBUKH8glO9slya6JPP5t2KhU4r4tmd+95K+4x4f65DieXR38VRpm2CUU
csZco8UkImX9vyMT1nVbkeWr0Jzsl0cHZpnZ0dvB7nUMHxeLQ0nyvlF2yPywpQVl
WomyfI6MWNnSbl4x8Dw+jMytDVsIUgfyiK2hCuAY7CYWhwFCej6wALdyXlpChunJ
LB1G42ax1QULDP/6Wds/WQH9FkUz3yFq6s9osDc5NYmRLbfQr15haXgepzJkZUlR
bizxB2Baf3CfOwmZniy+wrZexu0jUX2Ob9gLSkNonMEHIpiy6bRHYs+u0fIqDTs+
B2HA87rOI5u/u1s31ZhzX10Lwy+0LC3eB9sqAOriOYafNYn2MnQ4O4rRJ18VDuX7
a1mHb8SEAtPf1pdJu+1TbAODdD41Fr5RfugRNy+6oYZUrUCIelF888RIF6rDCh/Y
Pk2lGZrJi25vW/+b4U/MiBYjnPsilFRARWy+LmgJIARcT/bYQYb3rPQhbtpNztZA
3yAxfDhkuNP3Gd4sm++iWymcb6Y3OqckDQUYEiew3Fz15P0gnMulItWhSfFMpNxp
k5U4LFDJwyRsTYlQ5QqcvO1jO5KbU8aP2DHi9k09aqdtnveqHbg=
=XsLE
-----END PGP SIGNATURE-----

--1Cuf9sEc5m2OGFZA--
