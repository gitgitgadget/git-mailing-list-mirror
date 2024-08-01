Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28716C856
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500366; cv=none; b=gqhgomeLPrk3YFD2iWH4qVNtduTL5RWKPnJ6JhFNDw6IRsDkKCFnqYmVeOkCBmJHGwusv2ubYf8qD09ifh2slAIvpx+NxAJT1lpjhA4zDIwlGPa8J3iTksnTUfDWjw38/u2G9AUgjpUN6iV0zIM/V1IRIgL4FLLSsuCi5qB90p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500366; c=relaxed/simple;
	bh=Od2NYDFsZHk9cPtnmNfG6sMreavI3wZLWgrWp2nG2n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJRDm4YKBa4N9z7AsZCDdBPZ4n7Y/+yn6NuLrMQ1GMKPzbuXJv3NzK3fPWg4GG1i6Kr0ZLeKyqkQijBTEhJvA7e7erythTKJvTGcLur+jLV99ZgsuN+/8NCft32fOPQR8q9kLuapyfYt08lLlkjCNxz6kXyas156Lbtx3YHJ8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jkiUFDk/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p+M9OgcN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jkiUFDk/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p+M9OgcN"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4573B114AB2F;
	Thu,  1 Aug 2024 04:19:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Aug 2024 04:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722500363; x=1722586763; bh=uU+h3Ahgcz
	qH8Y4JHK+bw8GFbKvPCJ5wS5JBeiEaqcw=; b=jkiUFDk/jtQq8Iclx7r2Oh93ha
	axbiB0bjKD2CXhgsMjpjkBGMlgesPiD01UhlLNgFxv8fIWZ7fPELsuVRc+qyajVp
	whtapU/F/pw15vC4zOTaNDRfpEDVk3CQGnIdPwkknrxK48GYSiMrq8LaZvvQpynI
	MU3w73euv87wWhj4uWpGj/d5F7kDVNSA+mwV+NHgOOej9i+ln92Nieq8yyRnDB3n
	IrteCcr8knAPqwQ99wwI9vugQ7lST6NnNvXMXXO+9QgBgTrfcwrnM/IpiAcU0ONC
	Oxxyc46XbA4uVeONsqjtEo22SCnDXmThcye6Xfd/JW+tnQQf+rmHRs1Z5goA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722500363; x=1722586763; bh=uU+h3AhgczqH8Y4JHK+bw8GFbKvP
	CJ5wS5JBeiEaqcw=; b=p+M9OgcNMQGOcztva5eVa07P6/bIgHEN6ZlQ8LXRURgF
	HnMb19fhXl7ppRALxOWro+8J+N8UP4inaQUAfKz39BBsFCQE/H1JxDDxwrc5rn14
	UuoVD96gb7H8afyC7KDHKhbJFnV19zmO0GLKB8L19jT4KRYd1ft6JbyhEktHpZhS
	r8daWL2OHRzU3578rf2cbjvbwzaH/93fXQnYpf34snO083ffE90wruAAT2pUMDO7
	aHyJTO0Uev2yQIoPVRGKyNZDsEVkIFVQ0UyQagSbdioPFfXeXJzcNY9QpqFALLfh
	afCliI9lwz4nnYft+e0KmQoY2wrQRo1YtDZZJidrJA==
X-ME-Sender: <xms:C0WrZqWLPt1c-ZumExJP7MvwTkA-XJRvPa0m_dTNBNZ4Q-g8VzRD7Q>
    <xme:C0WrZmnPKX-xOVZwBk-kmMBydA7KZvSh8kSspMtsjf7W9OHUjiaPEb_5InhT-oqd2
    5oLXBOEeybVQUsXPQ>
X-ME-Received: <xmr:C0WrZub9Ue8SNt83rdPm4vKqT4B0ypFyhF-Z3ZPRLLhYWO3jHaLEkKpBbxr_ATx-bFAn-HbbgH3EGG1tUKbJSSALGbGfP5rT4BA-BLZZc8kFZJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:C0WrZhUr8Vj5_4TGFgQfdJa5sU6CDKyjWzxqSZFVrX8KsKHaV2EMWQ>
    <xmx:C0WrZkn6A7UaJHFsNQwc7IYzh9GRw5nM5cJ2olBxzVNwYo5u-uQSnw>
    <xmx:C0WrZmfDwS_zk3haYHMnBxhrHcQISKvai8ZGW-Qfy8JPr0jCpjADtg>
    <xmx:C0WrZmFOoFIYvwOVf7Lg_GWal82HOZ_DnRoaYm4SEcaLyFGBOJo_0w>
    <xmx:C0WrZpynTg5T5tdGn6dT5hOj-2SupHD_OwsR5gfBp4u9DJ_Jv9UDmzw_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 04:19:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9f450c0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 08:17:48 +0000 (UTC)
Date: Thu, 1 Aug 2024 10:19:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/23] builtin/ls-remote: fix leaking `pattern` strings
Message-ID: <ZqtFBTEDMsv1A91Q@tanuki>
References: <cover.1721995576.git.ps@pks.im>
 <d42152654bf91e90b8b417316f255746a3a75155.1721995576.git.ps@pks.im>
 <Zqpn0bLD+aLgY9PN@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mVGbDqGImUDEHDsz"
Content-Disposition: inline
In-Reply-To: <Zqpn0bLD+aLgY9PN@nand.local>


--mVGbDqGImUDEHDsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:35:29PM -0400, Taylor Blau wrote:
> On Fri, Jul 26, 2024 at 02:15:24PM +0200, Patrick Steinhardt wrote:
> > Users can pass patterns to git-ls-remote(1), which allows them to filter
> > the list of printed references. We assemble those patterns into an array
> > and prefix them with "*/", but never free either the array nor the
> > allocated strings.
> >
> > Fix those leaks.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/ls-remote.c          | 11 +++++++----
> >  t/t5535-fetch-push-symref.sh |  1 +
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> > index debf2d4f88..500f76fe4c 100644
> > --- a/builtin/ls-remote.c
> > +++ b/builtin/ls-remote.c
> > @@ -47,7 +47,7 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
> >  	int status =3D 0;
> >  	int show_symref_target =3D 0;
> >  	const char *uploadpack =3D NULL;
> > -	const char **pattern =3D NULL;
> > +	char **pattern =3D NULL;
> >  	struct transport_ls_refs_options transport_options =3D
> >  		TRANSPORT_LS_REFS_OPTIONS_INIT;
> >  	int i;
> > @@ -96,9 +96,8 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
> >  	if (argc > 1) {
> >  		int i;
> >  		CALLOC_ARRAY(pattern, argc);
> > -		for (i =3D 1; i < argc; i++) {
> > +		for (i =3D 1; i < argc; i++)
> >  			pattern[i - 1] =3D xstrfmt("*/%s", argv[i]);
> > -		}
>=20
> Instead of xstrfmt()-ing these strings directly, it may be more
> ergonomic to use a strvec here and call strvec_pushf(). That would save
> you explicitly CALLOC'ing the array, and would also save you the
> explicit free() on each element of pattern below.

Agreed, that reads way better. Thanks!

Patrick

--mVGbDqGImUDEHDsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarRQQACgkQVbJhu7ck
PpRf7A/+I/aHbQBBY+60AoEyTOhGWpX1QseZLtTmzAjGbtgHKmm96MS1J2szksXo
Ja0y6z3YH15m7qWPK4pBjiGwP6zVqlqMaGB9tlJuQc+4T/qZCam7ncQFLIfo8e0S
6lmgwb1xt5d+bxiK4GHd/C3gJDiP6DcVhb26amHk/6PwmhShCtaPcjGAL5HUucny
uavHZI2emgz5h9SmW7WdFvaIBSrqN2F3FeNp0M3iCM1EX60olRzOfKxyw6uFMIsS
duTceR9oFMKjKpo56EnNacKJ8E9unsSRYzExagCIsm8Lmb9HVftiop+0vP/YTE04
He6gVsHFLQ1czNmSG970Jf+aC0otH+MwySMs4Jqs8DSE2gT25K+SkO90b8XZbExH
ZrUbpnjsHr8KeC2+1soB1yfnH8GwFm7tiJh6yLmEcw6NFB68Vh1xmgz7b9aaCOm1
sAv3YYTvOFs2N57i59sRj6Uwz3OHaK5LQCbhV0VgUQRMmjHytapfBG5EWC87kj3R
t8wvfgyu3mZb+/p6eWUQ6gSwpLdVj1yfjf3zaLxPu5d79w2sG0nxRox5GY7uUUO/
Rtj71tjqrH5cHO64bJM82KJrYyOqYAbVvU45woFVA/a3r45jAIXSSEUl8OiPRuWz
ENEo2jfqxbiLTUtMoUzjuvdSc2zoYJIz4glCbLGNecHJKWaQ3/I=
=pzY1
-----END PGP SIGNATURE-----

--mVGbDqGImUDEHDsz--
