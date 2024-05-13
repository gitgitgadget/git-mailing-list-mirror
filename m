Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A2147C6A
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589390; cv=none; b=OvLNCcMe5SGQWcbGvfZMUT0RYDrW7cm5LJrZ3pS82uBD2S+u5z/XAiMQVD8BcF08mkuRaV5GNo0pwjLpjKJ238fkmwML3UP/D/mgu6t9HM/PzVc9Xxl7bl90hqHnZaB/tE0ZInvOXRt7RJ0zcwsT81jpVFVEfV3Q50C2xUSbCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589390; c=relaxed/simple;
	bh=rNWgJ8oLwPIYP5PB9hwxCfSvyzuZyjczZK83SQpTkbU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXnQeIWvk6MwdDDGVQxVE8nX0bZTc9dQYOl6fLFbbpfEdWsu/kQ0S6oo+qTbV3P/ETSCWz7DE9pHiBhQskQtds8XIzlaGajyrVm9tEwQpUFWTe4dk8tkLSgm/r5cStES8hp+pQCuYxETeZhzBTkO28Q7j+KUD4dN+EPeEf6FBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XWuoFR7y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UsDOuIxz; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XWuoFR7y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UsDOuIxz"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 940311C000DC
	for <git@vger.kernel.org>; Mon, 13 May 2024 04:36:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 13 May 2024 04:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715589388; x=1715675788; bh=JiGo68zeHL
	Px8ma3wVH4mjOKZaVoxEDL/JvS/fg4Tjc=; b=XWuoFR7yD+Ks79WQqKuLDM8d2C
	XS45r8sG9jt5aCiIGeH29RrKbd6K9f4fkBhLRJdTBMPqkr6H3whhUQu91cRGpU52
	ynQokYu/cXbanP0XiLTQfuMKPVhx6e+hxnACV11qBEhRCkkCt868TI5GRptNOEPD
	O7JHd2lhX9XLLIBGKJWWQrjARQubeEmbvDiwR9CucQpubvNuDi3O8rvcqhqlpQRL
	yYEuFUX+9pyONb4ons2TuwIJanfX5VTl15arSYZK6xPWEY/XeAJgLy7uHXNl6PHQ
	ZJQfVHoajYWyh3ZIIg6cNUuxGLgnZxZcI2WwSrHcag2sJv5qugyMe0bBb2Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715589388; x=1715675788; bh=JiGo68zeHLPx8ma3wVH4mjOKZaVo
	xEDL/JvS/fg4Tjc=; b=UsDOuIxz5bEikb8wRIKIPpHGl89938tJgc8G/sR6rwU1
	AltspTOsirSnWhhHeWkJRNvcqpuo4K5zXymURT/eromLGtwpVeKD4LxR6haxA6D7
	8b6Y/Dk1ewGUOunMIsDh1eA5kCXCvGBaJYlnLQ6PlJEgE3v+gx/9hRHX1wXtULIs
	7fj/0ijyKwog1Sv3/KNPt7doRd88U3307oay57/FAH8fC59jXSdCGb641ETX6H6v
	sa79q6FXNvgO9RQbvd9Zc9HlDmLgox5fmc28thUOjaXjy60bGekcWsLBNDoJy0vX
	tII3PMtMmnFG48GCTmWENXQ41ZvtRIoIjqfBJJzsNw==
X-ME-Sender: <xms:DNFBZqPUfFSfLG1nkF4reGckmIXTAXaxmgU15fFaklXAvg6pTIFM0w>
    <xme:DNFBZo8Xa8hqV2u7JeCZFquwfgl_EWoIhXYxhIbuwEpcZW7f_tNt8CI700mwmXnrS
    aTiPEdfa2gH9rzKfg>
X-ME-Received: <xmr:DNFBZhTa9z0ppvVNmuCuU4ZdGDfp6rwiaGHoRdpcRW5OBIco1Irt9YBK3-oUWVs0KhzQWuxMlTEKLFfcgVr-LdxUA8a6C2tk76_r-gXAvKKjUYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:DNFBZqs-ybdEnEo9MBoKBtONZBBhI0jyABQuX8W1xFJbjLainRwSCw>
    <xmx:DNFBZicV5VpY5KLb4Zj6nQ33VS-bIrVdAvYMTPmHLW_llJnnkXNYtg>
    <xmx:DNFBZu2nZVdvo2m8QkVqWdt-74GZCUhjKfKfAAgjQT43Cifu7SNdXA>
    <xmx:DNFBZm__QFIH81VbEFepyN8o9dmQd92W8gowEgsmAqg_0eagROPW_A>
    <xmx:DNFBZmFU6w2U89LSGvhyp85nj5HFt77MO3Lrc7wph6uP7cUz5BryfsCH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 13 May 2024 04:36:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9e077d45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 13 May 2024 08:36:09 +0000 (UTC)
Date: Mon, 13 May 2024 10:36:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 09/13] reftable/generic: move seeking of records into the
 iterator
Message-ID: <ZkHRCKwJiAfx0Z1a@tanuki>
References: <cover.1715166175.git.ps@pks.im>
 <859b399e71e92dd7aa0fa7fc9f2d9ca6f389d34a.1715166175.git.ps@pks.im>
 <4pyzm53ioaqt5men72ti4ffu7zjbpigytfgcyg4h2q7657zoji@7hlrvlt2cws2>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TMNSZa+6705AoRQk"
Content-Disposition: inline
In-Reply-To: <4pyzm53ioaqt5men72ti4ffu7zjbpigytfgcyg4h2q7657zoji@7hlrvlt2cws2>


--TMNSZa+6705AoRQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 04:44:54PM -0500, Justin Tobler wrote:
> On 24/05/08 01:04PM, Patrick Steinhardt wrote:
> > Reftable iterators are created by seeking on the parent structure of a
> > corresponding record. For example, to create an iterator for the merged
> > table you would call `reftable_merged_table_seek_ref()`. Most notably,
> > it is not posible to create an iterator and then seek it afterwards.
> >=20
> > While this may be a bit easier to reason about, it comes with two
> > significant downsides. The first downside is that the logic to find
> > records is split up between the parent data structure and the iterator
> > itself. Conceptually, it is more straight forward if all that logic was
> > contained in a single place, which should be the iterator.
> >=20
> > The second and more significant downside is that it is impossible to
> > reuse iterators for multiple seeks. Whenever you want to look up a
> > record, you need to re-create the whole infrastructure again, which is
> > quite a waste of time. Furthermore, it is impossible to for example
> > optimize seeks, for example when seeking the same record multiple times.
>=20
> The last setence could use some rewording.
>=20
> "Furthermore, it is impossible to optimize seeks, such as when seeking
> the same record multiple times."

Done.

[snip]
> > diff --git a/reftable/generic.c b/reftable/generic.c
> > index b9f1c7c18a..1cf68fe124 100644
> > --- a/reftable/generic.c
> > +++ b/reftable/generic.c
> > @@ -12,25 +12,39 @@ license that can be found in the LICENSE file or at
> >  #include "reftable-iterator.h"
> >  #include "reftable-generic.h"
> > =20
> > +void table_init_iter(struct reftable_table *tab,
>=20
> The following table related functions are prefixed with `reftable_`. Do
> we want to do the same here?

Functions with the `reftable_` prefix are supposed to be public, whereas
functions without them are private. So this is intentionally missing the
prefix.

[snip]
> > @@ -23,6 +23,13 @@ static void filtering_ref_iterator_close(void *iter_=
arg)
> >  	reftable_iterator_destroy(&fri->it);
> >  }
> > =20
> > +static int filtering_ref_iterator_seek(void *iter_arg,
> > +				       struct reftable_record *want)
> > +{
> > +	struct filtering_ref_iterator *fri =3D iter_arg;
> > +	return iterator_seek(&fri->it, want);
> > +}
>=20
> I've found the `filtering_ref_iterator_seek()` here to be a little
> confusing. At first, I assumed that the `filtering_ref_iterator` would
> have referenced `filtering_ref_iterator_vtable` thus resulting in a
> cycle, but on closer inspection this does not seem to be the case and is
> in face always set to some other iterator operation.
>=20
> Am I understanding this correctly?

Yes. The filtering ref iterator wraps a _different_ iterator, which is
`fri->it` in the above case, and only returns a subset of the records of
that wrapped iterator. So we eventually end up calling the callbacks of
the wrapped iterator, which are likely not a filtering ref iterator
themselves (even though that would in theory be possible).

Patrick

--TMNSZa+6705AoRQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB0QcACgkQVbJhu7ck
PpRPnxAAnBzfMIWDfKHsGxGrHWQ227xkAeI9al7ck4Su9FQgDXO/Hqc+Stqz54/k
6j1knVmzUILa27YQ0Y5NUFrz5lFHe1Dh7Tzu2i0sDY2NkNilN6rNzHb1R3zC0oq0
4Yj569EkvHuCax2+l6iBBimQEv8Cc3pEsc8ACxL4K1aobgbWVYU8TmidzECM9Clt
NgT02jXkCAv3Pwyc+mBB/BZHNGdtGe9YIljqLDLYjIFq1+tl1q1jlvTgo6PnGGko
lzvx9z0+3LAiREu0OQ1BfkcPTsCwV0Y2dKTQZrNUADs6HvSo59GxirSUbgi0sVJ4
pq4HYu32vK3T9dYU+q0hNGJP/lWno4SmEzsWwQZLn/qgRpLjj1w/gzmYwuxAUl26
mfPwFKE8TDYexs59aMVuxOT3Y76nx5Oby2IAEQ4emGhabeFyyi5y+yGVjUDTjVSK
PD5DoYFlrHgjIs8sHx39lm5YR43hNhFLz8Mg0wR/Vmq5Y7dSHrzIksxapuvq6etY
cYJjXm1vEom+Df2IeUyCFFG/hfBeI0jroDew7JT//7/u0lQe6EY95T+FNKm9zlDH
TNeJo9vo+YXArXVpaXnBHw+5wLT6AGhgsLVzGRigPwAJFCX8O6g8FuS/DH1D+vub
AsOjqlR4ZfJHrUGUIwjNoXQZOn1BW6QLQF7HLbMONPSEIuroQME=
=bmee
-----END PGP SIGNATURE-----

--TMNSZa+6705AoRQk--
