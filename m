Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDE758AB2
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199463; cv=none; b=j0eZqyQfb7ybi0q1FhgYtgRuvZo1h6XwSIr0iHFId4+AAyT1xKA3Jv823bKWpOv7vahkvKY/o6w/ukRYJiZSKSAnIGpuaHVlbpuqmGZJMQEM5Mf0VxABV0F25LtIHdplipL5n07vFtn7H9oOtqccuJ/AcKkAGc97gdJslwthXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199463; c=relaxed/simple;
	bh=TLv1yOe8uUase4Y9arkKEvZfAOsUoHbcqGgdw4Dawqk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQiVH6NuCGtYLWnESO4wOa7m/LLpHD602XgNewc1K+uQQTYE1JH10SrLXr7CVV5OaIVI8x4TqKWBEFwnnuPwPJIjPHukRAkuz1W7M74WUC9rV25MqqpUEWywIXgHixPrgXVaOvx0x26UR9eHsTdGZmfWcsr0Dlw7fOWCdjdVqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hRRZlf4+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M3TMdofE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hRRZlf4+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M3TMdofE"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 59DF91140125;
	Mon, 11 Mar 2024 19:24:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Mar 2024 19:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199461; x=1710285861; bh=r68a+8RZJg
	cD7y43PT9E5QtHzDSkbliPDXh5zpQb3tQ=; b=hRRZlf4+y6a3ktXydeolPuuDuw
	dYqkwciqd2DRiplAwEyS4gzSVeSU33b2n0lD/tDVh4YRTxbEQ3mSBrGaAj+0uTif
	FRRtYrRP2pg27MenY81Xlecm3DwRhP4TahjQNB/OSQ66gYmbEOzu2RzxbzhhQOk7
	qlsNpH/3O1WhFoObDIkPgu3T3+pR5+T51FEijKa3HfJkKzj1JZTDoY00sS4NEaZb
	rNnb4SIAEENvSO8X1Q1xQhmcfX46M9WAGwpbXJEwcZDxViBI+MStZAzqM2G+jLR6
	7p9iaBtgpAufecFcmmv7m/w+WFEw8HWJOihGd/+tG0L4KBdL0/6DGcEQpBRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199461; x=1710285861; bh=r68a+8RZJgcD7y43PT9E5QtHzDSk
	bliPDXh5zpQb3tQ=; b=M3TMdofEnR4aHtYfUC0ImQDTk1wM+7jj2PW7NWY/dt+V
	iPF2HD7D4qA9yRcF0BNB/p/9MfBC7noqX/BFSf1dDDnKXVC/gEOHUhHxm7+upL8D
	s8sCnfz+D8Zf0suY4yx2QZOy6SqIp6v2Yk7th5yNTPWMjSBkxs4h+PkiXDpGoDdW
	Rc2h2xJc1X/JUH9mqqC3M47Nj0bs5UkJnCtiuXRFYQ+QFgpTU6oFaAX+SMYAc1TJ
	okLUxxmxAv/VL7pvsjai5CZrJxRyHOev56Sn9zMIaEFjq7WXZzzb/yxjl0VsAL5q
	Z3yS/7CLhb8err8XhnNy/kdzlokie18QiBOLwVaeHg==
X-ME-Sender: <xms:pZLvZXLcOE7bTXb-Zutb0q4nakcprzBPLG_i-EATvKwmDxLLSn6yPQ>
    <xme:pZLvZbJkUsEDQCMS1ljyLexF-fQIsC6a_JQ4QCa3Zg1huFsw4x_KiN7E6F1WO5Phs
    wxPn7pAay5WzaW1dg>
X-ME-Received: <xmr:pZLvZfsjBX5Kf2_75dM5wQxP26C9xDPTrzXYzh7iP8jyikL92v1NzSiGH_UOiKV2iudiTk1WUEOAcoiHMA0fWQd4ozWi5fcskwUzXKoj72RzwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:pZLvZQZAy2BHucva-Cfjt-cyViHNre_LZLFzB61hjDv8RqO92GP3kw>
    <xmx:pZLvZeZq20cQexsinQ8mB0yjJbvF6pLi4eZ1YcY1BvIXihz3e4HpxQ>
    <xmx:pZLvZUDEZTtP34Yuv8V05g-nfCrMBhoPVZnlbFJvKpqCkCRg5AnCsA>
    <xmx:pZLvZdmutpQWY30hK6T2iUCC2Q0L5unEQc3sBolnAb-ipTq6_hkBoQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:24:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59b7ca1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:19:40 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:24:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/7] refs/reftable: reload correct stack when creating
 reflog iter
Message-ID: <Ze-SnjgaLNoMvzW5@tanuki>
References: <cover.1709640322.git.ps@pks.im>
 <b0414221ecad1920c84f4ab498e55edec57f06b6.1709640322.git.ps@pks.im>
 <Ze9Or6vctPJGOV_l@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lNFVO0SbhnD+iBcU"
Content-Disposition: inline
In-Reply-To: <Ze9Or6vctPJGOV_l@google.com>


--lNFVO0SbhnD+iBcU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:34:23AM -0700, Josh Steadmon wrote:
> On 2024.03.05 13:10, Patrick Steinhardt wrote:
> > When creating a new reflog iterator, we first have to reload the stack
> > that the iterator is being created. This is done so that any concurrent
> > writes to the stack are reflected. But `reflog_iterator_for_stack()`
> > always reloads the main stack, which is wrong.
> >=20
> > Fix this and reload the correct stack.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs/reftable-backend.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index 249a618b5a..f04be942ac 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -1682,7 +1682,7 @@ static struct reftable_reflog_iterator *reflog_it=
erator_for_stack(struct reftabl
> >  	if (ret)
> >  		goto done;
> > =20
> > -	ret =3D reftable_stack_reload(refs->main_stack);
> > +	ret =3D reftable_stack_reload(stack);
> >  	if (ret < 0)
> >  		goto done;
> > =20
> > --=20
> > 2.44.0
> >=20
>=20
> Is it possible to write a test to demonstrate the bug that was fixed
> here, or is it too much of a race condition to reliably trigger?

I wouldn't really know how to test for this in a way that is even
somewhat reliably, unfortunately. You have to have at least two
concurrent commands, one reading and one writing, where the first
command loads the worktree stack and then tries to create an iter as
above.

Now if this was part of the reftable library we could do it rather
easily via t0032, which contains unit tests for the reftable library.
But in the reftable backend it's much harder.

Patrick

--lNFVO0SbhnD+iBcU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkp0ACgkQVbJhu7ck
PpSNGhAAqvGsyxnX+HnB4mtFCMmmTKWQJDQZkSfQIC6xMiZ8I1sXRnPp+vDw40Jq
OoEq+VGgsDbk4U9o7q1RZmcyUPdRPUYGOggqP9O+xc94nO3mJ2iyoj1xrQvaLQRz
RHfkh1Ugt5EhXDgjmHuZ6r6/69YZqdeVFVbHkl7zD+uoeZ+vob7gaDP2bCWXv4yn
PMMW4MU2BeYhezTF3VW1M7ZxSfqMcPXSMHv67EnF+Oy4fUIJ4dp/hO0hErlBBPOx
NyxAMXYrHDcTC9xm9zbAmmGuQG/KGjhcGCDSPYt29rC4X2TQlfI+YjmbDa5LyAj3
eAD4lKUOIx4qRmJfEIvopNmdXQTI0jVV9ZACY9VZBiBo8AN/Hwy4gWnHJfFrtxxV
IE1pmnYrmqN/A1p5J/Sbc74nPy27UMa0BaDsuXsP8BHpXqNCSufbX2m82pQ4YE1R
YRbA8+4W/ZPJeuSspxF5GRHrZUt78NR87WWPl2NCi2cgb919ac8RFBVKiVsF+PCc
z/jDiOOZpNkTFSV5/QXjikXo3yMs/L9fVTFoTYEkanhjDe4RZ0u4VhsfS3Y/GTk3
6qMfO+jeg7ymJ3qwiD/13ncSXPqHoP54V0SygF1GPMkU5RAp+b/74XIGzLIDg2tz
X4MI3TGU5T981SW/PI2B/v9VK/wEp981YmwsrDDtyVo7/ABXrHU=
=VVMY
-----END PGP SIGNATURE-----

--lNFVO0SbhnD+iBcU--
