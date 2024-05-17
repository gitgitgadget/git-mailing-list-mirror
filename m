Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20CB14AA8
	for <git@vger.kernel.org>; Fri, 17 May 2024 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929784; cv=none; b=Rifq69ATNH05LmOrky5+jhLuF3VCUg/2SQMcbk2/2zAEuc0tnV+rBlPwGTYOijqE6t7LJ43kkxA3otBq7ypoqE0Ae3Rv029D88ZrJCdvQkmX/q8XvcKf6uxnafjonwYkaI9VqihsIHWAGeQnNU4fHHfwo6FQ/9P/N+ofXQHXa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929784; c=relaxed/simple;
	bh=Cam/b5a/pDk5qmSBKualt9YOv3ccZ0ue0Q+g3ME4sUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9gDQu5rs6+VPzkugRHcYi+mISnO1LhATcWJGW65XcIBiH1NwF/1tOC+7PSm+w0XhZuSgnaIMIX5DtEKq8pciEgggBjFfEtkqFSd6PYpLJDxMJ7FRd8loEGOGiNQQchOIeE/W/OT6ecU5fZyy8szxBEYE1Mr+KdPymPBbBdrmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l7E6U4TX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VgyzAbpi; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l7E6U4TX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VgyzAbpi"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 13CB71C0016F;
	Fri, 17 May 2024 03:09:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 17 May 2024 03:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715929781; x=1716016181; bh=88Ako6HTHK
	tGio+daHssSxgV4iLGhzTgAy9Th44OosU=; b=l7E6U4TXKV0iQQHLZhsDAfzRnz
	fKdR83VBFl6IKLMXLNl2Io9L6f5I1kUyfjlcfYeH8Va7iKidz9xcJ9WBBUtzg+Q3
	y+HJJRbNK+3RC6AHbGr5R2gT5/dW9Cz+z+KquhS19Q0u1VTKG9yqtW+Jw9ZxuuWQ
	AXwRAi+FKMHOGOr/+lmvrWqdcMJqUFQhcZhSRCUVEcPndyWj9q0eohX5cyShqAb2
	c4PjVPELnoYpHa8nsizgafTML3x870bZIyxLTbJCG8QRP12jIK92cRXnvoNn07VP
	9dAipTf2hXTSfjImQyUAMKMhKFbG4Txywl//jIM4/Q14Sf60XJnGy6jzc6Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715929781; x=1716016181; bh=88Ako6HTHKtGio+daHssSxgV4iLG
	hzTgAy9Th44OosU=; b=VgyzAbpimJxu1iV+R+ZXbnBVNdTaj5SmlgAUCMI051Im
	FX/rgcKZE28R3+AbVqa5lhHMi/Fzr3p3EJhUzTBiehhfz2Cfr3f6s/N1ho14LZky
	SVG4qys6EhfxVvV+PJAbzNrYr4LhlHygTj47a0/12dz+3XU5bRcpIwqqNuQCguig
	GEcNI3BfYLI1z8BqL3xQVYRCRaMvBcQBTawjCi6qTHosPHfWq4/9+Y1i1oo22ukG
	1LRRFhbWOZ3FMDhoNX7WEOXGEUp2DlfKIvHlamx+glBT8slfuXh8wBVjxwmO9Xe5
	6aG0jPd9SfqDYeOvPFcFw05VMZGuJVR4pVJO6TZXGw==
X-ME-Sender: <xms:tQJHZs2Xas1vGiHWOIcvCIHfOgX90EHwtIbQk_nEowYl4wW7ZyQkyg>
    <xme:tQJHZnHstjld8qjpa6wWNDDUuyheU-7eSL6U7lQs8jnNcy5OzUtnLIAQLN3DtfgTO
    c8whWqi58HELL7gbA>
X-ME-Received: <xmr:tQJHZk6K3Nhozo_-ZeYUjdzKeUEtCyG8JloPURk23ZG0I6LR01as_BLyKqZx21N0zxSLoXu-zIC360VGMJbs9NA_IGoxoXkaPr3-vJgpPAYBOot3WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:tQJHZl1j9OJ_O1PDFJ4usf_NUVQDvbM7WizNBpoH7SYVaH-cRD46dQ>
    <xmx:tQJHZvGgU69UtXPCztN_pYqn1qHk08sVAvMGFemOf_s_oHbxaLvWzA>
    <xmx:tQJHZu-oRqYQdLE2_l3pO9hJtj1m-F-0l9pJha-y9Z_t8i2QXQqLBQ>
    <xmx:tQJHZkk5zrgneOWn7MYjXlv-gq4rEYPNUyyran3NMVQMboV0Hyzb7A>
    <xmx:tQJHZkR7XTns6ShBshJDFUMe1Sl119Ad9DdjMoQ16QzRXLxOtckQPP8h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 03:09:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cd981cb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 07:09:13 +0000 (UTC)
Date: Fri, 17 May 2024 09:09:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/16] refs: pass repo when retrieving submodule ref store
Message-ID: <ZkcCstjnqBJ6zecV@tanuki>
References: <cover.1715836916.git.ps@pks.im>
 <1d48289809d5bff3d168b42b2b7f150e3ee953e2.1715836916.git.ps@pks.im>
 <xmqqy189ppfi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CtI7b1FMnq2hDAHl"
Content-Disposition: inline
In-Reply-To: <xmqqy189ppfi.fsf@gitster.g>


--CtI7b1FMnq2hDAHl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 11:44:17AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Modify the function to accept the parent repository as parameter and
> > move the global map into `struct repository`. Like this it becomes
> > possible to look up submodule ref stores for arbitrary repositories.
>=20
> Hmph.
>=20
> > diff --git a/refs.c b/refs.c
> > index 542acb25ff..86008ce7b4 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1949,8 +1949,7 @@ int resolve_gitlink_ref(const char *submodule, co=
nst char *refname,
> >  	struct ref_store *refs;
> >  	int flags;
> > =20
> > -	refs =3D get_submodule_ref_store(submodule);
> > -
> > +	refs =3D repo_get_submodule_ref_store(the_repository, submodule);
> >  	if (!refs)
> >  		return -1;
>=20
> This still wants to work on the_repository, which means at this 5th
> step of 16-patch series, we cannot do a submodule of a submodule
> that hangs below the top-level superproject yet?

Yeah, this gets fixed in the next patch.

Patrick

--CtI7b1FMnq2hDAHl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHArEACgkQVbJhu7ck
PpQ4WA/+MZVgRdL304uuyLTLaJR8mpiE7i63FIO/FVh5fbpbD3Sltj8dcFFIGWjz
wzFUdnkZghkvpo9XXZgaR5wzzfYQ2C7zpBWy+i4kALm23wt0Fjq29sMUqyP2ZFFR
d4wHGZ+Ria8zemGWCRVmequgbk4LvsNP83qqPgtCtb1mYUOf+RjHiekF8XtuOcDX
QfdcBqEoRvcYgq/qdiVRFhbER2k/q2ns0nrFN/VxrWHesOv0YFygAKpKrMY4VeEp
YD2ehxkIOK8e6ynJxE12ai2rqfDmgMU63TprYUyvyaHPFUI4/796tbQ2l5jRSW9a
kmPf5yc5PHbAmPflpuTHq4SJfcfn5GBIN7/WpxF9fCwayFPxkP/Z5hwPy2+ST7Cb
uCVGPIRiRqYPEdL0CquzbiX5jg6fe0EVDRmtUCFf7twHYvTGtvVEd7jAWq/RwQ1Y
U1JA7AesTvdQSoctIcxnkbA9v5IBLhzrRViXGdzX0dfPmOB2/A77i/IK9eb9BjXh
nzZfkifvgiFCwTtv39mrmAPGol+hqFu5686+8YMv2EF/UIKrJaqSBd8GgWOmEGeB
WVd+c5PrBPoqDKPabjtkb28b1v/yAH+hkbzR4HFUP3OmG3yXFPbiRzVyur9+zAMt
Ezkmgc112Mvq2KcsnRZEMAaxyaLIDJvcL5bJZt/qLDqTuSl7X+Q=
=g3um
-----END PGP SIGNATURE-----

--CtI7b1FMnq2hDAHl--
