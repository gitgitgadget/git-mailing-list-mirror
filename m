Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B962941B
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566068; cv=none; b=EqDGCmAJhQwlePDpwoQjdOUyzIrWo0//fJVh/wS/jJfh/WGfDmBT0S6N2hA5U9IL/Qo+8SPqKVjZhhK/uyt/ehHUM3BTYvDurBLYKVpio3omsUCfvYwzM676+aGfMtJ7isUwZedDLxwyM9AADIqbGAAIJu3uhFL91HCoC1bJ9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566068; c=relaxed/simple;
	bh=hyqZtiTND+OYKd/ml9JNC0SQBpxiYfjxqqGdQv8gaKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIg5YZMNASRZ1ulsOhJZfyd3DTmvFqZ/+A972HKAjE6wMWbWwWFzWgclamddunK59EqPSSzwEjUDnbIz67Q3qhPwWI8NEt9G5sp3wmlMN4/WaUl31lQUfbbUo0ngnZh5/1eecXZv6ah4+6+vAsJIB/h8I+b9RGnEFsVSP0WENNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ad1FCHYd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kkK3GG2p; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ad1FCHYd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kkK3GG2p"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id EB7E918000E8;
	Wed,  5 Jun 2024 01:41:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Jun 2024 01:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717566064; x=1717652464; bh=XEGapUxRfw
	Bs+QuCT48qvql+9Lk5FULEsM4lth310ac=; b=Ad1FCHYdZ+6BlIO5SVvliHgFoA
	xYoNe1ykYzZxO9AcXsi4Mh/+S3WVBC3CkREzDHSbRlJu39L0SVdEeQ++hDhRtJv6
	UKqLMQHHxSFNAay0QymnFFNX8knFxdwyeSjHKMAJUy+PrNx4Iz52kHykUyT2MBCL
	9q/x9mH4e/qofHX5a70Kn3dJRKQodJD/sfIQP0fYJyY4ky8hn3vu6AJ7iczZ62zW
	S7D5Gw6iMbj0nl+iFGFUrJchgSuBQohjPhtH7nFHcjhTLdLRDQ/ATHwO9n2gy5Ke
	G3TN1p137Lg/smp6CjL8sHYVmC2QRFuWzY5WECE3WyxoDbWYBHThvQV2znxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717566064; x=1717652464; bh=XEGapUxRfwBs+QuCT48qvql+9Lk5
	FULEsM4lth310ac=; b=kkK3GG2p7/uDX+Vm+EeDwPHGqiQwlNVrlB1y7CCW4E9N
	AaAVq7zrkHWZhazncUmLsZ1FZyCTn22Zu7s2bFZ/hbek2OG3IdgoIwI4wM41kqdc
	gJcOuaS8g3cbJAIdZo9oF1zGLUQJLCHVE9ZsUn93idOdqRc2UIXLi8UV3wkEadO7
	ImE4XeLXhV/ZfJsIu5aD0zlAypaeTx7GzPQb2omvfYAEix2sckQQK3fMWuJNwVt8
	dd+YHOCshoMOspiqr6AKTeOWCC0H3r6OfNAYbwR8mLT2Ov7SDLlYxjtzY5k6jxyR
	J9uevDnKE764pbD1nFvJJNpTsGfSLW4ngwvHmb1nIQ==
X-ME-Sender: <xms:b_pfZpKFk7szmGzhgP31nY1DGKmlaI6IB-zHOYouOHp9k0aPrxQPoA>
    <xme:b_pfZlInX27TDzEPWwQFKtiui0-5HeKS6HpMzdLI1DnW0iSuhfxw3Arh2y3Nt4Rbz
    LchuK-lo03Tw8gFuw>
X-ME-Received: <xmr:b_pfZhvCz87NVPV5fb0nZ6_xsIqo-Odkqn_Uykd6iBPTJXihf_NdlRRAhcnciU2DZ8_yBHuZutZxmxyuDH6MmQB6jnbv-2P0c6b2a2T_ziuj6uz1-04>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:b_pfZqZToVYD8Tj3NTq3Mhr0MwCD6IOkfZjkgLbCaOjy1rojo8-Ldg>
    <xmx:b_pfZgaGIyEh5sbLYJMjTmHkZFZ04wEZW7T_Yiu2L4SvpoyBWRBHZw>
    <xmx:b_pfZuAQ-EgYfAWWouiJUf0cxknLP_Cz50AWcb-P6VFvVG4SZHFPkQ>
    <xmx:b_pfZuYA5jFCJJl7TGZUdnQzNhLuVnmIGWfnuYmszmX3Rfpe3WyQUA>
    <xmx:cPpfZvxTvz4hel7Y7nmKppqDUX-PqiySPRzV8FQXUtv5urL4mjsH0Rlx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 01:41:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ddaf35c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Jun 2024 05:40:33 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:40:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 24/27] builtin/rebase: do not assign default backend
 to non-constant field
Message-ID: <Zl_6anUl_C3W2j2Z@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
 <e19457d20c80f9ce332f2d890a5089972e28f0cf.1717504517.git.ps@pks.im>
 <be8a315a-3fa7-40d3-80e1-6a5c01afee70@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ueZeAxY+6BmRy1OE"
Content-Disposition: inline
In-Reply-To: <be8a315a-3fa7-40d3-80e1-6a5c01afee70@gmail.com>


--ueZeAxY+6BmRy1OE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 03:06:38PM +0100, Phillip Wood wrote:
> Hi Patrick
>=20
> On 04/06/2024 13:38, Patrick Steinhardt wrote:
> > The `struct rebase_options::default_backend` field is a non-constant
> > string, but is being assigned a constant via `REBASE_OPTIONS_INIT`.
> > Refactor the code to initialize and release options via two functions
> > `rebase_options_init()` and `rebase_options_release()`. Like this, we
> > can easily adapt the former funnction to use `xstrdup()` on the default
> > value without hiding it away in a macro.
>=20
> Personally I'd be happy with
>=20
> -		.default_backend =3D "merge",		\
> +		.default_backend =3D xstrdup("merge"),	\
>=20
> rather than adding an init function. I do agree that adding
> rebase_options_release() is a good idea and the rest of the changes look
> good to me

Do we have any other cases where we allocate inside of a `_INIT` style
macro? If so, I'd go with that precedence and just allocate inside of
the macro. But if we don't, then I think I'm leaning more towards the
way I did it in this patch.

Happy to be convinced otherwise, I don't really feel all that strongly
about this. I'm merely aiming for the interface wth least surprises.

Patrick

--ueZeAxY+6BmRy1OE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZf+moACgkQVbJhu7ck
PpTACRAAnV7ZBlUM4kU7mwrTaWcZZJpMXMqg20OjxLuPdNelryaPvma0Qvbub5vC
NMUxRzxxAXoVNQ2RQWQyvTDctTuFKIUrTe18Nz+t2B3ytZ4zAoCjM71PmNKNL/4V
MO0I51vZIQCP4CgLnfln+G216JZHq61h1jLEI+YeIkki2j/G1pyKoEXt0zMw2mW1
m6jgw1HEq4urmgvg8yltfQgnnJUmEvQQk24yYicu9/K0MnQEfEqBhVoSxFbuOweW
NczWcEBesgpoqF2+nzG5+X9AeZnskwtfjoUUhPZvNNwIa4O0glb/rnQZok7A5aNg
sOv/7nVWG5Kph99WkvqrMm3xIKuXUzwLW0SM5GJng69P0UDR2UDk0Om+R8BJnFiI
Y73P3P93HRqwtJDuwB514ZbVw8m+KobsRQ4fqPdv7R58dwlUV7gjpvtoUCLxZrpF
XoZMWjgAzjsG2dUjQ69h3MpleJ77Bh8135uO7Sxvu1cacAuDAtSgSCr9gHjgag3k
juU1LbT0N3SsOMGmkGfPxCKLkkUP1caEOguPcJHSI1zBWmJm9TTCCrtuHXhFkT5o
iwGBw9ofzkAub0VIjwkM19ul+4ZNPZKX7dw7DBQAttMoQrvqL4MFr6a+TIBfDIED
lvfkIWWP1oY78r4PjEEAc7q2AdQLSUDgHMq6HPIuXDzm9zD7al8=
=p2cd
-----END PGP SIGNATURE-----

--ueZeAxY+6BmRy1OE--
