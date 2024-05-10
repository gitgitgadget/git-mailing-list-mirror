Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0A168B0C
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336035; cv=none; b=FsoxwnB1fRI/w9183AQeUGOWfKyh+ox0vwzwZh4EFusRJYK/cvtgV15FxAfDn/CQ1fJrTX5s1rAmNcsUzTxgrWP0KRbQxo0cK88TBlm/L7876jx2EykW3GC/g3Brs45/iR63EsQ6JvjDeZGom70vnzC7dPOY0UM+XpothEQ+dps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336035; c=relaxed/simple;
	bh=nzZEW4qFaKavv3SM7qs545p+L2xyoaTRneLKjYTGWBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9GKegeZrkIPwua95Re8fgP8+Br7Tc0HmTGixCafa/cMaijk782JLUySZYLTDqxbUGzf3SqVJi6xh2G9wYFfrX6E2+HEyzrrDC9TKawNSmPdnjB7nWhdKyCP5UozzvuxFvyHPFCd2snSBP6B2GanN4UAQC/bCszuLCNvooskop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OlRhP33k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dkrvBp71; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OlRhP33k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dkrvBp71"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id D95A51C000CF;
	Fri, 10 May 2024 06:13:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 May 2024 06:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336025; x=1715422425; bh=s09B3udCwt
	oXWh/v2Unn5HLmX0IDTz5aJK5i9U+HSno=; b=OlRhP33k47JcYoH3WWafBt1kDT
	h07HWM0VOFRx4atL89swquoS1x0VLmWIfFI+fLt99+CgJXjXLqzkHHoVDSd31lMz
	iWVh0ZM9eZXO89lZI0tJtbV+5VlQJvXdPTaHdUSzg3/kI+gRUmUHyieB3OpLOvVn
	Gn/9BNjMT7ONCeOiMTV8KYNUUFBYqS7XSi0R3UbIygQuQWfNjUrK1ZB2wUbyvIVN
	8vovaC3LSB2a+tuxPSxCTZ5wOqO5SXkWJJWBite9G/sulZK8wsur5v+raJ/7fTMj
	bskAZ6e5anjen++scGCKuh4z3awyKTD0i961TH/sKvofxjHH4F9gR2EageTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336025; x=1715422425; bh=s09B3udCwtoXWh/v2Unn5HLmX0ID
	Tz5aJK5i9U+HSno=; b=dkrvBp71+rt2U177+01DHJgeFkTIQ2zoy45mVtTLfMBS
	odBxsuJTTlEZ4hjfsxyLC1aed21EKcJSgPS91alurSwXKDbYIjduIT9Uvr80trHf
	3+GEuJHfaDguMdhSvZzRJXBfc6NmV2Hw15mmCgoFu48SJ6yvOgpOtZonrSqSvEoD
	Hl+tXXiLVgyLAxmtuZIMYstlJ6jbyEtGzegshCEgJWo8J7DuoOMcegFkS/M+EVZf
	FtUS7Lj0OMIfzs59wxYndxwrxAIZpb/GgVCQF2oiqTQb+BQeZ8aYhD62pq7Efwqg
	4mquOSSy529c3qlNXE6XX2it5q0NOsW7/e0ylT0Euw==
X-ME-Sender: <xms:WfM9ZpJw4tUnEMtY2HpH4J18mWtWvjpS-niMQN8M9ZrxtOn37tRsMQ>
    <xme:WfM9ZlI2Gy2fgncdUje-67-S6OGzDfDCQLy53NcritwOUoPXdYLpDvj3E9vfEXDD8
    CbHqHWapU70_NtKZA>
X-ME-Received: <xmr:WfM9ZhslXM74Evv91drFVSYu5rI_TRpetmb8Jb_2oIc6PsY3w6WBbdAKxqTZN1iZ6SMXpYVM0iOKeWycghG3xa_2sVX25D_e-5HjPJocBHSH-0ETww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:WfM9ZqZ6WYpoMRbNoNjPnsHUJAQNHwpZmpKECTW8YPR6XS-ioJ_7VA>
    <xmx:WfM9ZgYhlo28vK0Y7T0V8tMNzaaI24Pr0NBGpWQxORq_K31Vs9Eozg>
    <xmx:WfM9ZuAPBlEUuazkWZlMeFpGfP2gbONwJaHh4xWAffRuKITOOJY_9w>
    <xmx:WfM9ZuaT9UZPx_Xwgr01dTvC7bGRZgNUH_AMVmvzScO2Ky75MZeL4Q>
    <xmx:WfM9ZvkIhrsdfAKf-No6v0Y_23xFxttI-2kOsZpvowyIaio-5ObMnJhe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:13:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d6d642c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:13:31 +0000 (UTC)
Date: Fri, 10 May 2024 12:13:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/11] refs/reftable: allow configuring block size
Message-ID: <Zj3zVQbASOx4EPgu@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <b4e4db5735beb106511980adca48dc416c4b0d95.1714630191.git.ps@pks.im>
 <CAOLa=ZR7=hVXyGr2iSZW2C8mtwR2SHLikuCVKS-qTB7AE+0+hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sWaoBjyvaQZQUGcy"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR7=hVXyGr2iSZW2C8mtwR2SHLikuCVKS-qTB7AE+0+hQ@mail.gmail.com>


--sWaoBjyvaQZQUGcy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:29:19AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> [snip]
>=20
> > @@ -230,6 +231,23 @@ static int read_ref_without_reload(struct reftable=
_stack *stack,
> >  	return ret;
> >  }
> >
> > +static int reftable_be_config(const char *var, const char *value,
> > +			      const struct config_context *ctx,
> > +			      void *_opts)
> > +{
> > +	struct reftable_write_options *opts =3D _opts;
> > +
> > +	if (!strcmp(var, "reftable.blocksize")) {
> > +		unsigned long block_size =3D git_config_ulong(var, value, ctx->kvi);
> > +		if (block_size > 16777215)
> > +			die("reftable block size cannot exceed 16MB");
> > +		opts->block_size =3D block_size;
> > +		return 0;
>=20
> nit: unecessary return

It's unnecessary indeed. I first wanted to defend this, but then I
noticed that I'm also being inconsistent here where the last branch
won't have `return 0;` at the end of this series.

Will remove.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static struct ref_store *reftable_be_init(struct repository *repo,
> >  					  const char *gitdir,
> >  					  unsigned int store_flags)
> > @@ -245,12 +263,24 @@ static struct ref_store *reftable_be_init(struct =
repository *repo,
> >  	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
> >  	strmap_init(&refs->worktree_stacks);
> >  	refs->store_flags =3D store_flags;
> > -	refs->write_options.block_size =3D 4096;
> > +
>=20
> Nit: do we need this newline?

I think it's easier to read that way.

> >  	refs->write_options.hash_id =3D repo->hash_algo->format_id;
> >  	refs->write_options.default_permissions =3D calc_shared_perm(0666 & ~=
mask);
> >  	refs->write_options.disable_auto_compact =3D
> >  		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
> >
> > +	git_config(reftable_be_config, &refs->write_options);
> > +
> > +	/*
> > +	 * It is somewhat unfortunate that we have to mirror the default block
> > +	 * size of the reftable library here. But given that the write options
> > +	 * wouldn't be updated by the library here, and given that we require
> > +	 * the proper block size to trim reflog message so that they fit, we
> > +	 * must set up a proper value here.
> > +	 */
> > +	if (!refs->write_options.block_size)
> > +		refs->write_options.block_size =3D 4096;
> > +
>=20
> Wouldn't it be to import and use `reftable/constants.h` here?

Headers in the "reftable/" directory which do not have a "reftable-"
prefix are considered to be private. So those shouldn't be used.

Patrick

--sWaoBjyvaQZQUGcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY981UACgkQVbJhu7ck
PpSsChAAi+enUFfjjsTpRZGCXd7X5DI+1HkR6Rg+I618rZSDXUUNkao9cECgbrXf
VZQYx2JfHtAltW2Pg3p9JQYcvVQ6f1x6ZZEFYt+P3qkKb05NUnJOikfezv6SSfWs
YjpHp+7FjVzJ4JMfOt37pjDN9IrBiqInKrhps5E10VJzZgXiXoyEadjODcMOsw5K
7Nzl+E28bzDwd1mEul/Y6xB41cDSjERSk2kBIljy6nz+MsRq8N1jtXXUfs50+ew6
pKgONjmoISz3A3m6N6kwysmqsUaeFYK+r0/SKmN+psxie0Unx2ajyzhp10K6uPTx
wDaIeJ9bJbsadEIp7mFbcsymkEwAfvyx9rAOQbB/rY4yHt7NKS+MO8Vo3dufVaG5
XaMtdE/sQdj2jKV0gf+QhTqPXlytu6IV/I5xWD0zy2GSnriLcdFcNUEG9jl1K3+X
xFLkPYHNHghv8XXUThQsE3twxIlZdgOLt4OzpCYSrHTdDipg3hbtlxHywpyJXY30
WrTtidGxwwf/ge7HmEEdmAHSJYiadXDcJsF5L+PL10XMee18grcxiDybchjJlh68
eCdpXH+9VXJXfH+gsc7cZT4AMe+W1jVaUu/3L6JejNZ2dPeRdYZ49r29n7pHdUb0
W+baOefRcB10/Oj1pvo9+FVloIeEwj2xQcIFH4UZmXroI3aazc4=
=NKO+
-----END PGP SIGNATURE-----

--sWaoBjyvaQZQUGcy--
