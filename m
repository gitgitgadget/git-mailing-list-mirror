Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E9128385
	for <git@vger.kernel.org>; Fri, 24 May 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533797; cv=none; b=WEQqPDbTxfFaJMUbCqQr4dCMYePzaEJiVcZmoJCqmCAFJSFOkGwCoD8s6rSeKH6h+xYaTkYBJ6W8Ekj9Kl94VdDT4+E6ESTyInVCU61RDzbSePHdmJB7kFxwV8ShxZkGujl+pIL8x5iflZWFmuZ/PYRt4IAAmdv+9Sm9W9iL5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533797; c=relaxed/simple;
	bh=obVEsS2RjJAVcpXvZaGv9Xw1BcKnt0Hh9bMf21Esn1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMqOu6pAvLvWDIfpwpIJQQbkmJpQ+AmNI62hsKRYaQlkWA9Ci0ObK3TwOP32W+dlXpIuCLz3+DPhKVU9rnBfKX1cD5OPZxbZdwO01UySQMPGFYjQo4Kl3F6IsjD3Qf4PfvRuiu6QRJMZbcl9u4BuQ3CGtRT3YCtg1/dAWrbplrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QToQpJ+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hjC2WqWl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QToQpJ+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjC2WqWl"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9D5A511401CE;
	Fri, 24 May 2024 02:56:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 24 May 2024 02:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716533794; x=1716620194; bh=6MGLFeHuj7
	eYDiPJEkI1fxNKMlyeS6dCzofLMJ/lmcQ=; b=QToQpJ+1Xm9Ka0jQxXqvP8k4Uy
	p9xT+2FwNb+cEa2s+VynFxWfIlCZRzakTR5EfGKDisApUbchlkZGqNgP/5mETCJu
	fHQOsQ+vNyY8RAN1FLymK6dRvkt9Vl79gpzYsP5axFqmDP9GkwNzYxMTLBcHRi0t
	znHKCovrH2Ye3/j0YGLTviszjVsBAvRSuKdFFnkACRbaBWZdmu0ovWOWP61nlBi/
	XhDFlcVfBoD1PHATaRZqrITS3uGrIFITDl0qwHzZRUcspNUQwe16SZQkhTnndlbY
	bj8OBsWS9ymeQUg03KxsOQU9zw8k9V460iLfqKmQYVJKX4LB/4G1elKNGhSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716533794; x=1716620194; bh=6MGLFeHuj7eYDiPJEkI1fxNKMlye
	S6dCzofLMJ/lmcQ=; b=hjC2WqWl8A/wNUPlkNFp6mOt66wPkGRgH0OA1aj0mcyF
	kH6WwDYdvDbOcbbVii5aFLJtribEMNz4KL9WXzIrSZOVEO1/1lb6JHefWxZpwZ6j
	tyivE20DEBqEMFm/QTyFVIH3vqOMgjC1wYTOwjhUBk927nxblvOQYrh6cbdhzWUs
	QFaKsw2WP8Xc3bVi6tGhUPMji59LZ16vSzvx62/F8J5jmT2znYkCStNiL+hxYKOt
	Zs5tmBKG1XDFoMBDTqOt6jslp6KQhzezJ0XWmuCaR0TNfrmAlB+r+gSS8BkJ/doj
	BmEwI2AzsyCl25xqpwobtwgc8vF0/qAs3qN2HpqqpQ==
X-ME-Sender: <xms:IjpQZrWhaqOk5I1aqLNzqzrFAHBf3-PY_iRR1Ne4b0CSkcXHIt-U_A>
    <xme:IjpQZjmUgbKlTeG3fPFk5AwbqdZmiIGw7adqx4bMB6Nfv9B8FFW17ZDegXoR4f2Y9
    f_EAsH5WzGDvqkf_w>
X-ME-Received: <xmr:IjpQZnaqQ3aKAPWUz9UJJIxRKFf6fxibkER-1Fxp4Y1lXPPn6RdVcgybolWbnI4s12Y6HjMNY42QFM5JhDHZrDbQ_7s-wRJzcaCCc_PkigL_sCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:IjpQZmUEoeNwtKoxUEjnS3T7H2v-oy9zy2DtaG5vyWMruEs38bnOdw>
    <xmx:IjpQZllh4XQY5v5inLTKA24VG_mhRkPbosMDvraKN6-VU19WsISAqQ>
    <xmx:IjpQZjcFX65IY4kFp2K-mMrEHwiKxWBUI0xADHtkyh2_wM2nhDGukA>
    <xmx:IjpQZvEzdpAVLXQJGrusXBiLZDCk_pSAzMYzzDuvitg73cFLDS3Djw>
    <xmx:IjpQZqzgKyLuwiZpcHCG8CjIVgCcMhvauCzu1D4OM6HEiWjLTQJPRKse>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 02:56:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c2c38334 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 06:56:25 +0000 (UTC)
Date: Fri, 24 May 2024 08:56:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 16/20] strvec: add functions to replace and remove strings
Message-ID: <ZlA6GkowIo16qprV@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <c43c93db3bdc0ea5283a6d5c71d37d6fe949dd8c.1716465556.git.ps@pks.im>
 <CAPig+cTKrUL1AzY4Y+M130AvH5S=kSTdwo542T_GdFC=6JUu=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FNh0DnagFt6OWzuc"
Content-Disposition: inline
In-Reply-To: <CAPig+cTKrUL1AzY4Y+M130AvH5S=kSTdwo542T_GdFC=6JUu=Q@mail.gmail.com>


--FNh0DnagFt6OWzuc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 01:09:39PM -0400, Eric Sunshine wrote:
> On Thu, May 23, 2024 at 8:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > Add two functions that allow to replace and remove strings contained in
> > the strvec. This will be used by a subsequent commit that refactors
> > git-mv(1).
> > [...]
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/strvec.c b/strvec.c
> > @@ -56,6 +56,26 @@ void strvec_pushv(struct strvec *array, const char *=
*items)
> > +const char *strvec_replace(struct strvec *array, size_t idx, const cha=
r *replacement)
> > +{
> > +       char *to_free;
> > +       if (idx >=3D array->nr)
> > +               BUG("index outside of array boundary");
> > +       to_free =3D (char *) array->v[idx];
> > +       array->v[idx] =3D xstrdup(replacement);
> > +       free(to_free);
> > +       return array->v[idx];
> > +}
>=20
> The reason you delay calling free() until after xstrdup() is to
> protect against the case when `replacement` is a substring of the
> string already stored at `v[idx]`, correct?

Yup. The patches for the strvec API have been lying around for quite a
while as I have originally implemented them in a different context. And
there I did hit this edge case indeed. It's rather unlikely to happen
overall, but I think it shouldn't hurt to be prepared.

There is no coverage of this scenario in this patch series though. Let
me add a unit test for this.

Patrick

--FNh0DnagFt6OWzuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQOhkACgkQVbJhu7ck
PpQ8GQ//W/Oh6J43CIAzp6YbYDebRznKP/YO64BIVWkmJUoxPyBBv8xoDdJ/bsz4
IZUFVzy9OGI+3KArD0/qbxBFAgODVShA83ozGu23xPsaI43JXKq1utxqDuJQpk9f
1hA5ZN6s3M1hQI8eF0NUSbnVe/7TkC5e2lK2rm5uTyCKWq/Hk/XofzDCe6MZIym6
CpPpSaY2pP7+lBIR0XIXRvifcDUpm4uuPt2RPe3ayXZewdCTiheKizNJ4tnXqNkh
TTySfIjT8zTIXzGbh4hjcLlfWCID82EdtbBCXlvYz6Q1Q65BnxEMI64Vl/qIrdkG
jW/tplMdOfJXsCYqe2j47ZgPRkjGPuUYiOLUosfhCshuZEwGCGUhLlAtgqMkbNc4
bWJG5IdnATFYuIRU/KjS+VEOR0n255eJEYF+sNc6bPC4gnMIjHeTCziz2R8lihKw
1wP5y74pTMw1QFT/K6HNayGCyons0c8rATp97yLhFeZRqJIqAUYSEyg4b3Fb4esV
1oGGu/64s2Dwfi7aUGl8L0FbwkofTAYBVSGkMvDLdN4T3Xab1Bg1gdlqTW0zVJv5
d4+nu58RQBD2kwcTmToHy5YNJuf6sUZA7GkLVY1/jtwUH6YVm3vbjDqRswFW7tJq
SX8wX49/mgY7lWLF06No72pxKTcnoqSGW+PMRJaaKvYiGz9KJw4=
=FmLu
-----END PGP SIGNATURE-----

--FNh0DnagFt6OWzuc--
