Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39F13D276
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929581; cv=none; b=rxu/mieZgjDqrs4fim9lYnGEGlU5iqxkuve7OqkzTi03BsSiVv1NlPqKb4mPiEP/ZouH3YEWpMCiQLjEKMhnKuLFBImbaVy8cImxFpocLRQDOF1gXdVB6cFDT3vv9AuYp4I53L/7cGBthL8p8R+nC8c90mk0O8OZO9klv6t2m2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929581; c=relaxed/simple;
	bh=QHTwEfddnzLGoZw+K5gaITfC8rpmzEtSaK/qEY05AF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGgrWg2qIvcJn7el2+VPVsN5OZKz3jGCGfmCrqzU5U9EuQnHbZFG3vBFPG8UdRbv8mmYHNhlKCTtz63w2+7Watt9xAsi43z9O49Q8QalzKQhhs776icgE8oWQqnNFLE9xKcJs7rIecr/9EKGJWnq2fKy1zGZTc3FDB0Y0eqiKo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bjD85wNJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZpXqDnSm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bjD85wNJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZpXqDnSm"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 99410114AB25;
	Tue,  6 Aug 2024 03:32:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Aug 2024 03:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722929578; x=1723015978; bh=GH/H/MNYP0
	OiBpKd6McvclqeFJYY6p39Wp+muO+0mO0=; b=bjD85wNJZKzhmz/3+Y+Q/mNzpf
	MJQq3a5Poz1JhX10jf68sAFy7TtevpuJT6fKdIRKAWERUb24xpoFjRwrKcDv7XM+
	UjmEu3fDDXub8wppS50jZw6Si0zjqVRlbuaHlBGJzbh2hhZSp2lBOC2t8Xrj/d1V
	6PuuDbKTjGKdhGzVMwo/dPOkI8f7nn/Ts/WRinRsIL3ZHxZPspEnC8c0+JrTTN1z
	BGraSeWYIUa8pCw33G/ivKMP54cRc2SVmlgHKDSNTxf44dgBIn24gYSDpz9ZDOMs
	KYllHSpHE+Hhp/+h0batINLhUjdIflFoz9hmyKx659FPsIds95EyWX9SQ5tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722929578; x=1723015978; bh=GH/H/MNYP0OiBpKd6McvclqeFJYY
	6p39Wp+muO+0mO0=; b=ZpXqDnSmNPmK+Zz5ir7M6CQ+uRBazLXvGehRYIuv1hEK
	hXMsBi+vjdQmDavzj+8z+FVgBPBFK0DE8SF7vyaPEycESwa+z1sxu0tX7IPa0ps9
	Aqu7Jovaw7N8fVl8gO/vardF2VfJFjG7lBtu97z0qidmWPhVXMUsVVUxrGVetWKc
	DH03UHbRjCuUb0h5+AhKbUIZAiyZedDqtX/3QrgHocWjdlQsu/rljKA1NpdLaWvX
	oaW4JzUbMOIHC78hy0+ZgEh9iPvpuYZwKQnVQqZ06pWGx/vGuT8Ka1P4dTTaICfC
	XMZzS4D9u8hImK+sjhjrXfK6lOJ9GgRZxdZN3X1HNA==
X-ME-Sender: <xms:qtGxZlQZLuUl1Og2j0yDT3uuamt-3Q1AEcHWa4yn6cR2nRNtBBkeAw>
    <xme:qtGxZuxcyHj55rAvWCJ7eT3W0nsVLimAiUTbWqGJ5SCkx6pYl5S_MeqiSVCfJ-Fv7
    Ne8cbp61B3OavjQjQ>
X-ME-Received: <xmr:qtGxZq3wu7lhqa0i8TWdSDdd9PMpHXImaPqpE_TgiYZZx6sNAT5xECqqm0WeWmGfRIEdeNCZMi4me9QKZSgEcZIH_j8cHvFHaxq_PKnyO4L0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:qtGxZtBToBmarFX_Nj2uNWA4ix55Tfw1fwd3i7Rs94pAatne0SqfDA>
    <xmx:qtGxZuhTlNQaJxk5Gyzzr7RMjgWalaWIIzsxkS9FiCUKOpewBZUzRw>
    <xmx:qtGxZhrGUNH4BCYpCwfdzHlo3DAjrRBKpvoFPEHf2fVqz_IUMDhg9Q>
    <xmx:qtGxZphG9U-eELEeUhz_RL7N_Je-76ouN1-dAmNuN88MdiuQJm_rTQ>
    <xmx:qtGxZpV7ZDLvmApPXJZZhZoi4OGGoe1lpno7PHNMk72XfG6sIozH0swR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 03:32:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2ed9d1f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 07:32:54 +0000 (UTC)
Date: Tue, 6 Aug 2024 09:32:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v15 7/9] builtin/refs: add verify subcommand
Message-ID: <ZrHRpnpGkH19godh@tanuki>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
 <ZrEB16WGGc28dxu2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gKFthk66uYItPsgW"
Content-Disposition: inline
In-Reply-To: <ZrEB16WGGc28dxu2@ArchLinux>


--gKFthk66uYItPsgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 12:46:15AM +0800, shejialuo wrote:
> @@ -58,15 +63,44 @@ static int cmd_refs_migrate(int argc, const char **ar=
gv, const char *prefix)
>  	return err;
>  }
> =20
> +static int cmd_refs_verify(int argc, const char **argv, const char *pref=
ix)
> +{
> +	struct fsck_options fsck_refs_options =3D FSCK_REFS_OPTIONS_DEFAULT;
> +	const char * const verify_usage[] =3D {
> +		REFS_VERIFY_USAGE,
> +		NULL,
> +	};
> +	struct option options[] =3D {
> +		OPT_BOOL(0, "verbose", &fsck_refs_options.verbose, N_("be verbose")),
> +		OPT_BOOL(0, "strict", &fsck_refs_options.strict, N_("enable strict che=
cking")),
> +		OPT_END(),
> +	};
> +	int ret;
> +
> +	argc =3D parse_options(argc, argv, prefix, options, verify_usage, 0);
> +	if (argc)
> +		usage(_("'git refs verify' takes no arguments"));

Junio has posted a patch series [1] where he wants to get rid of
messages that simply say "no arguments" or "too many arguments". I guess
we can play nice and also move into the same direction here, where we
instead tell the user which argument we didn't expect.

So I'd propose to make this:

    argc =3D parse_options(argc, argv, prefix, options, verify_usage, 0);
    if (argc)
            usage(_("unknown argument: '%s'", argv[0]));

[1]: <20240806003539.3292562-1-gitster@pobox.com>

Patrick

--gKFthk66uYItPsgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax0aUACgkQVbJhu7ck
PpQzkg//frk3nV9pZ9Vv7XdjYgw88dDAVThzuK2KWmZbE0UdGKRZgSfvb/OUSSvy
dSFXFxwKKcBao5lX++oInAtvKd4wIBDWiMHJL+QATGKpVOyTi00CbKBCweBp8ABN
V5CqTRlTYPujr3a+9kWfjxdZ3QnXwwuJIwaqEVUO8wL6zTz2fCelb/d4RpUThEn2
wocqUBFlO//zIp+5I05YW2l5RidVslVEkoM7cgc1N/FdEOKuxGAVc40TzTQkv8mJ
DAwUSARW2uFp6Jk+4QZzGxWv4ZJZSH0l36aBmwk89xYWsbhKTm9wAhR7Sgo1qLSu
Pq8UmOnX6tl6Tn4EOkhfZ7Sanu3PHVITu7yiX8kr2ej1+QzMSKsdhfb8VxVPU7zt
wEUvNJYvQDjBjIYxKva1Gn3fdaClSHaBhkc1W0HeZ3jQs+GM60vGQBV7/etXnzVP
vU5sOsfUdDDIYI2hPU/DIsdL8rJArrcvdSrLUj2zCUBy0lR2+e0aCe1m5uD7ZQPt
KgvBsGw16zvlThMuFjJFrwSOr0BcD+zNhoqPDcGfbFssr+YZPUOMm2crXAEu5t1W
0ZUmrz6AWN7Mwlt/PtePv95Oy//wsoON3QpfiBQTmCk91tJkB9Q2QSmW4rgTzjYI
ZNaZepfVtBsd+GVYCoYmL/4v6gM+mGKSACmKRqv2c5oSU66n4m4=
=7Rg4
-----END PGP SIGNATURE-----

--gKFthk66uYItPsgW--
