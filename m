Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DCE183989
	for <git@vger.kernel.org>; Thu, 30 May 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068635; cv=none; b=igqpaJPcSIO7X88bxoXiG+e378SY/gd1hU6GuHooHDjLbxw66QukDm9LDQTRxPVg2m23R4FXtvHMiKPaXMn+UVxuyvXgQiIGlp1rPkKGVWsaICwIZJ+GbhRKmbReWrPFx/cpQ2/3JtQpL5C3ctZHeKzyEETUBDh8s96oQdtBMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068635; c=relaxed/simple;
	bh=iLcISUfWOcU1dyih1ui9WWFI4btxWeWwTlb4gNyefc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+8cwdQisXfb941LJ2eYHmXzdtMR/ukr2R5Xv7IsFkBhk+lG6S4nBbe6v8kzazYELPAFr1hhN2GFQv6wb+yvt/qTuYg3uWrTaoiShqDuxIB4ujBMJtvvIlOedzePGvIKsgczrUR4nG9SoMziQQzeEWshf6uj7WcqKEh+2yH/K1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B7JpSmHR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FE6TG15/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B7JpSmHR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FE6TG15/"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D3D4413801C0;
	Thu, 30 May 2024 07:30:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 May 2024 07:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717068632; x=1717155032; bh=luFURJYv6t
	mOqJtZTSBGNQAgLCigYdRxcR9R6kNWXlQ=; b=B7JpSmHRCKUJz9OmnFHHOzh4+S
	RpJo1FWeWlATaJWxldcNlzTigX/tt+KqlHK8DNGoA29u40LzNYY6JdePolNxvCNb
	GpKYlDeAzP2/PtAJ+7UgtX7xZgVGdmJJddzq35hdibq3T/W5VCuUZS6GWSYqox+l
	2cs4ys5Clrfv7pXqgCYBVWNxg/hCQWtoL9VdQVDQ21z2FCHC4YCWsDUGoBVJ4ma+
	pSW12O6EE7Y/bmrc6os0WtCq6A5GfmVNWwxOjy4GgLXPuqsuUXZM3hdakot8iAHO
	OMZb1EF2XqmTu6lg+atJssPNLRBZTcU0Njk+bKKchGiGWw5a4S2wIXryb0WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717068632; x=1717155032; bh=luFURJYv6tmOqJtZTSBGNQAgLCig
	YdRxcR9R6kNWXlQ=; b=FE6TG15/Ufu2ojj6Gw+TfNkDx9pN2OKLewpx2UB+0Gfa
	it9hoMI3XKmeTSh+77zitmE06ib4TaUB7Yr7GVxY0J04vxsio2itgvTM+MCN5UvD
	3orzOkAftYrVG4Nl19SbO+pi3F47SHnkCqYjyCRDzuzueC6GbIPCRQF9VIZpsQNs
	XVTF2oMbU+whpyZ1oj/wsuwIPnwPHerB3qMIZ+bUMbDqbxu0OUIF6zrhk9cxwaCb
	4gqWtOLKSFwH0EixHKncQFAYcbs+FIf3RN3681VKGUeI5rwrPVKXljloXSli7Vaq
	mK7eaC+7ZvlRa6j3wI22/Y3CT7MnkYKJXtoDOwe8Dw==
X-ME-Sender: <xms:WGNYZqn8Dzj7dOSdrRW_r9d9z_qYtMCL1ltc4lGOtoecEMhA9Sd6Tw>
    <xme:WGNYZh2GkP2Iv05FKYDN1gfsdBijkRjUIUmi8lE2FHWKdk0mGQz8Ca9VYD1IpqKcf
    5stnXh_NWKgokUbuw>
X-ME-Received: <xmr:WGNYZoqAI48u9WtE8yzMjLCIQq4uylN6fOilxgyZGTUqPT7yrD3rNqbC2aIwOY3Gu4CNcwYdV7bOQitgo7ckfmSrJ5oGjBgej-xfQ05jeUlaDDpKwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WGNYZukitUchv0JbJJhQfAEjCG_FAPGygnatBH-1UnRywdSCzeOWaw>
    <xmx:WGNYZo33jL4sHpY_lqxeQqjlIa6Xxs0NmKSjLHXI4FHTxqEe9u341A>
    <xmx:WGNYZluxUMWyoIQ7mX2UMPe73EMeWEWT0x4olF1IVgy9Jhk2eoWQpg>
    <xmx:WGNYZkXXNF9iDk4OxHA4fkb7VMAbd671hedkpBDv6geC-N12LgP0VQ>
    <xmx:WGNYZlzHXZrQ6P5WYcHXrF-2zYVJEIO2kH1HFFBCcWRGJNwjtgGo00Dg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 07:30:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 083d9e52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 11:30:14 +0000 (UTC)
Date: Thu, 30 May 2024 13:30:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/19] reftable: improve const correctness when assigning
 string constants
Message-ID: <ZlhjVIEld7_T0q-M@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <dc5d85257eef747f2331638ed718b0f7a5bb1da2.1716983704.git.ps@pks.im>
 <xmqqed9ky0mk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SW4ma6pX22Vge8Dp"
Content-Disposition: inline
In-Reply-To: <xmqqed9ky0mk.fsf@gitster.g>


--SW4ma6pX22Vge8Dp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:43:47AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > diff --git a/reftable/basics_test.c b/reftable/basics_test.c
> > index 997c4d9e01..af9209d535 100644
> > --- a/reftable/basics_test.c
> > +++ b/reftable/basics_test.c
> > @@ -58,8 +58,8 @@ static void test_binsearch(void)
> > =20
> >  static void test_names_length(void)
> >  {
> > -	char *a[] =3D { "a", "b", NULL };
> > -	EXPECT(names_length(a) =3D=3D 2);
> > +	char *names[] =3D { (char *)"a", (char *)"b", NULL };
> > +	EXPECT(names_length(names) =3D=3D 2);
> >  }
>=20
> I would have preferred to see this kind of rewrite more than
> separate and clearly writable variables that are initialied with the
> constant contents e.g. branches[] =3D "refs/heads/*", we saw in
> earlier steps.  Wouldn't that approach, combined with making the
> literal constants stored in read-only segment to trigger runtime
> failure when a bug causes the "unfortunately non-const" variables
> to be written, give us a better result?

Depends on what we mean by "better", I guess. But yeah, I was torn
myself when writing this commit because there are so many string
constants in the reftable tests that we assign to non-constant fields. I
didn't find the result particularly easy to read when putting each of
the constants into a separate variable.

Revisiting this again though I don't think it's all that bad. I'll adapt
accordingly.

Patrick

--SW4ma6pX22Vge8Dp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYY1MACgkQVbJhu7ck
PpSOSw/8DGlWaSHddmb/hs9im9osVHhanq8evvB/L122t0+xhFAJeCSCZh+AKMJY
NXsho8lBByDvjEUrFlwIyG1UR5GXQrrsWLah8hlo3kZs/+J8j6enz8sF2WgkZg+T
EX6UZyswZ1FGPQm9bOO+SJWC2F6TJ1N9nNIZnPMOC/fi+5u3UFKkkoact3P9gbn4
9xbwpxv5z2Jb/zegBLV0lyJaY95v2gsGm94b3KBOGuPGgOFtIxBoGvRPq/js5zuU
v8DTrM9qOTXzg5MnvXHGvNmYsGz/3A6D2S42m30SPH0e1cJBEM9tfs6f5fgdW4e0
OT0szudnb4S/Zym8hYpjG14hy/rQMBTnzVxPd4FEy1GLnwfOT/mDnfcvrIgFHWbg
qkn3Gt2oLLR8Zyj1JjWTQvexi9FKGiI6S2pEWxtnXU6qFogGpoyfOsSWUf2MFPE3
2mGasTgSTn1fpHHj3/Y/Pvjf7u8L6+iFqfN/xNGvNE7B1jIw11lnLhJcs/XHejFJ
flemoUF42ezcrI9yiTCixDwy/nxxA+msxLYDFkDprHAMGd7fC3TbY8f58EjW4uap
hLs966TLIBKH6sZCLb9PGBjzkQWvrP6yP9NGr3p4dNl/1XX+1UrK0y/fQkl9ET4u
CXsKjfB4q4g3kt518MvWxNfY+SX8yc9v+/QRrZIwXSzbmjAuRbU=
=3kq9
-----END PGP SIGNATURE-----

--SW4ma6pX22Vge8Dp--
