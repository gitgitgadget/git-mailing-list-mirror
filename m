Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB0168AE2
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336031; cv=none; b=FsST0NjmrGENjU7NXrAJZSyuXNV/dSYEKTHXVxoXnUagix3vIXObejXSKfSTKkjluYL/cKaOICTzBzVMHsV9108CO9BBFNui+ZIzAq2TX0ZiQNy82XztqWTJ9KhPWBZ64Bfd5neo+PjIRshlX+aDte8m41n9l5rmgbxt2k9kezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336031; c=relaxed/simple;
	bh=0YBrJkzbuZnzkFIZd1UfDhi+SzdZNywesMdt0FmuDtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOevPcDp7YO6o5w8+AnZlwZxiPEQzi3r8U2bYtSz9FTt0Y9iHbPFitTD81AcTGQozuk3M72tNlWlR2aX36rI4+VxZXfzXrZOKEjNLfSV1cEoc/FepjQxpPsKuubjFICLvbgUicpqcN56To7GcIUiooUmeWRYZouHdcEqli1C1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eGYNwHyR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yvpkeqx+; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eGYNwHyR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yvpkeqx+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 282D01C000B5;
	Fri, 10 May 2024 06:13:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 May 2024 06:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336020; x=1715422420; bh=Dr5A/nZLMX
	oA1ftifSB5+1Nm4seYTeyGv9+VgusLsoE=; b=eGYNwHyRqu3riijGI4ILIc9ROE
	BnYCu2yr3KsKBrkzB4guMrk968p4oMa+urCgRsjta/V0ClU7OYBRE8CV6f7UuCMd
	+KVjfJEykZGzabA4pv4zXs61hTKzxsOWb3TTL8d+4ruLQ/ZVAYxORLa2FP+0CHU4
	rxHIKA+TrOnagSJNnD1X0e4ibguNu3cYkMWL3rZ+bWlWWEXMhnlit0JbQqTV4PN8
	8yRAeRtNidjIPmI9/VRoECXowKPvRsvHh/wG7uSi0RYl/5UEUnsKaRsDr6amfhMv
	TAs8g25ASWsnA14AJx7cc+9yQLp4gUTdj+X9hLlnA8F792wVrrJEu8KTcXLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336020; x=1715422420; bh=Dr5A/nZLMXoA1ftifSB5+1Nm4seY
	TeyGv9+VgusLsoE=; b=Yvpkeqx+r315k+aJlX7eIZ94fCrYLpGhHI32vRBlOGtZ
	fKaY/uu0VdA5kFI1KTnLYJ+y4kMck3RPbxUuw6kfqOKpdvR62h0/zHryfiIP+viD
	Ry4dMSj4+w34w/p59b4cB1ZKCOIeimqtD2pQQf/2KujzXpVjXIIiozOIdoayt503
	pJCyjuNRHRDBo6aZTTyJUmjkHyTEl6J/NdzTFOK7HgkOmporoS3Yu75Ah90gnHvX
	2I/8lem5IETd/sjrBlcvwC7LHAwIAjOja+2rIydXTrRW1SQHBRf5Syre9/cWfv9O
	mWQMtqjJzvRrnlLDj6HVNvH4e3oA88tzXXrCSPARGw==
X-ME-Sender: <xms:VPM9Zge-mLBTlwthnmO8v_uN__XrId-K58hg8TT8Id2Ab2SVJj5OoA>
    <xme:VPM9ZiNPLfSg9CiDx0WimfFFVoM5rzeSV7S2VF3hmyCwrX-hKl75r0ygQGaoCTZXE
    -xKa4x_hqCbrge_zQ>
X-ME-Received: <xmr:VPM9Zhh8CPJTu6PVslyoPw1PQbZ2lk5wCKeI6oYyp5Y-MxqwBaE3K8I09d8LDVE7niWOnyZteHX4PxltIs90bjrOcRKpnW5nKXIhWQCqlD7mAifuYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:VPM9Zl_SHSjT4U6yI7vOOKo_CWh_RW4Bwhg4hTSBLM_5q4-Gw_P8lg>
    <xmx:VPM9Zsuwi23aME-KnhOaONbYHsx94DBBzpPi78xCtqTpGXDA0kDc1A>
    <xmx:VPM9ZsFEW6usdoB9dUsgq7r-Xtxt1vrVGyy-oV7vTurB0ra2U6FG0A>
    <xmx:VPM9ZrM9Kyhj-9fyxXGLQyZws7amLHEHvCON4J3AaLuZiXLGGKUq1g>
    <xmx:VPM9Zl7s8UDLYDlWNNKl9R4J5dkICgjq4TSVYalzaC0_eng8_SQZLmFk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:13:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id be247290 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:13:25 +0000 (UTC)
Date: Fri, 10 May 2024 12:13:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] reftable: consistently refer to
 `reftable_write_options` as `opts`
Message-ID: <Zj3zT0AQMIVh-Y4P@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <47cee6e25ebaac5af9fd0c9eaad7fc50b2547cad.1714630191.git.ps@pks.im>
 <CAOLa=ZQ3m3HOxpAUVK8_KASfQwmhXNraYrm-M-T2BTHUm5c5ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0ajc2AwPDcKhV5A9"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ3m3HOxpAUVK8_KASfQwmhXNraYrm-M-T2BTHUm5c5ZQ@mail.gmail.com>


--0ajc2AwPDcKhV5A9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:00:31AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Throughout the reftable library the `reftable_write_options` are
> > sometimes referred to as `cfg` and sometimes as `opts`. Unify these to
> > consistently use `opts` to avoid confusion.
> >
>=20
> I think one location was missed:
>=20
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 3316d55f19..40eb793b3c 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -396,7 +396,7 @@ static void
> test_reftable_stack_auto_compaction_fails_gracefully(void)
>=20
>  static void test_reftable_stack_validate_refname(void)
>  {
> -	struct reftable_write_options cfg =3D { 0 };
> +	struct reftable_write_options opts =3D { 0 };
>  	struct reftable_stack *st =3D NULL;
>  	int err;
>  	char *dir =3D get_tmp_dir(__LINE__);
> @@ -410,7 +410,7 @@ static void test_reftable_stack_validate_refname(void)
>  	};
>  	char *additions[] =3D { "a", "a/b/c" };
>=20
> -	err =3D reftable_new_stack(&st, dir, cfg);
> +	err =3D reftable_new_stack(&st, dir, opts);
>  	EXPECT_ERR(err);
>=20
>  	err =3D reftable_stack_add(st, &write_test_ref, &ref);
>=20
> Rest of the patch looks good. Thanks

This section has been removed in 485c63cf5c (reftable: remove name
checks, 2024-04-08), so it doesn't exist in `master` anymore. Which is
cheating a bit because the topic does not build on top of anything where
that commit would be reachable. But both rebasing the topic and
willfully creating a conflict would probably make Junio's life harder
now, so I'll just leave it at that and lie by ommission.

But thanks anyway for reading this carefully and double checking the
results!

Patrick

--0ajc2AwPDcKhV5A9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY9804ACgkQVbJhu7ck
PpRDkw/9F3LHRFph+7HMlanW9m4xEnuaR21U4szl+EJcx3tiEFPN+ZBv7GTdOjFu
gxFbVDEjFPihuhdbUZRoEmKNHnyGawfGVFUDI/H31iFOi1GoXnSdHrK1BBD1Kacc
pm5SVYo4iHcctxV3bwosh+b5FYyTmHLvjjs4lrpTSVXMasSN1nx4st8uxVnyCrj5
9lQY2pvufD3a/LlZ4N1b1UMa9Qkg/8sAD3FgsGRkWc5Cuvk8PPdBRO5SvzYjAd45
mIEyrzqFVRP+LJJiLGNto5hbHgX/6RKCCy+FdV0aIwkOZI+bFvSuvwM/ckGcFQXI
dEdQppkDSNqwcVazOYygADHB4k6Nqv3uGY5vKbnuaMPPQT/ILq994UagvqAgjDUU
Pr1pW7LSNUqquhaNkNRKLqfP3TsdvS8oOuSH5hVKYCAxSBFw7KzREmxr3rOw9pGT
Fjv28nT1O/RR0dbUFQ6o7IBy9JCDEYPAUb+HRuG3J3R7FNv+MX5XvPkHpz/ajbzV
nDPu0eFAP4Wpdt8ZssOEmPi9dRoYHI2qeWnlzv07pTRYyOpAQlwrKY5JqwFfnCDg
rdHYpT1se4mORfnCyxqmgRq3wQaqSank/9c4c6qAGISq31wkD8TED2zMXRZN66kV
+j44+ix2fkz1UH3q3tWgIgwdwD2EcbnTuTOW1glCkNyvGWYDGf4=
=sU3n
-----END PGP SIGNATURE-----

--0ajc2AwPDcKhV5A9--
