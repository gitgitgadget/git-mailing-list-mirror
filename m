Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FE2F50
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723093522; cv=none; b=UzSNaNhln7MlsDZ8pdgdn7pRodWJrSBY06/NaK3MKTAUmBJs/bfAjOtkqaINeTfY/YvE+c3GPEmjYhoHM5FBMMmZ+sv/ajJSjxhP9JketWQdvmjoYQQwqj10HykM3mygMLyxlp19TCHKgAJtNv/9saVDI22LK3NkuoyQhDuzpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723093522; c=relaxed/simple;
	bh=SyxAl7C5Vlm3MpneEEIpHGQrvXHQ21R8pkV9HQhc7vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWHKhflJQqlF86Yzrb8ES9stSzRN6IE586t9U/0uGbIAKMeaV3rUoCXUJCT648rW3HAKXkUT2VZ5NJ6eGuqpxlYtOmlhfDycu7BduE7XMZTQjLP7g33ELoerkz72yO+/YD/GqWfXChsVerhW7VG6rKpswbvw4w3LBVHMgOtUClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OwaqIctz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HV7Ok/X2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OwaqIctz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HV7Ok/X2"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 89EFB138FD8B;
	Thu,  8 Aug 2024 01:05:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 08 Aug 2024 01:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723093520; x=1723179920; bh=lzyhl0LDSR
	oyb5ze12olqveeX1v9kfUTun6noz/sVjw=; b=OwaqIctzKudskPQMv+HCj56aRc
	rtG9qMInOMLA+PyRaBa28VFNAfy9g/mEvrrcPdsS/KW4bIQbWnX47XyCIoOqGULx
	srnCZGgp5tBxdFBsin4qXGKCSv4nihoPRD8LhUu20/gtqKxP5BjnkMnbfoEbVaaT
	wRTtg8hh9If7iI0K8LsJIDZBYMZ6ig+ocy2zoRJspl9jGCJsO7EIGrbZBd45eEaV
	Ncj/vJfgIsfPgVfMhtMbZiEWRIXv0OCpij4w2/yN5tIaRkpVRVwj/j8/W1BSUZ6n
	Sq8T5aZ5KgVTdaKL/h/qP2X7xla6L0mV/TRoRiN5ZIwRacE5CRTmkmdyw4yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723093520; x=1723179920; bh=lzyhl0LDSRoyb5ze12olqveeX1v9
	kfUTun6noz/sVjw=; b=HV7Ok/X2YQEoLdYqi2svdUbiaZO38AT2Ky0pjqSWAD4M
	YHOf7uDjeuAufpoxKDE8um7j87Ua4CM9tU3SayLLUJLAGzfh/p4o8jB45zv/kVY6
	2oi3ly4r5tHVepXeA+mEjMJiZKgMsU8e9EPY4EipTejQfqtydMqEZYpCEr9KMsxT
	vySWCFNpRYFMmV7MnUTbEp5kn+aaBeNTTgFAY5OI2PwGa2bfJzL6pb19vYqxrzk7
	YD3+KlkEFuLkaSRKsY2bdREsn4l+8HOqwbtMwP154p52Q5qFrrbuTDaSPWZkS+34
	ln7l4OtjDtKT8HXk5Gg8bcQEFoqvbPO55oTCycIxcg==
X-ME-Sender: <xms:EFK0ZsCxnBZJDqOoa6UDty0ScjjlYwHu1DbtpNQmfXWgiAgCyllneg>
    <xme:EFK0ZuhKYA0_rcoZxBbptj9-35TNrl86bATHnVHcjUasBZuUlquiEnccBQvnYBsCJ
    7I6Tr85a1APHgX27g>
X-ME-Received: <xmr:EFK0ZvmsjGqkqHWO0iuJBiX_n2zIItrU5BSAV-RAeS92Kb9sTJsfnQLZycNHGUFZv03kN-WCilwdjk6bjIRp9bpRRbAf61QyGi5E99el9X2u6pEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EFK0ZizIvGk5J89JZ83HjbRg8ByYopVUqJTemUXjaN3UdHhVZ-3XHQ>
    <xmx:EFK0ZhSHDI49_kOHMas2bMLHJZjSHLNFyyTj5LMVG2IatUWY2z0maw>
    <xmx:EFK0ZtYXCBxLYS8WPjI2ff7mwHIWJFrY4OjG_dcLYsYyLKjTUq5nyw>
    <xmx:EFK0ZqT7wTRfX5KSM6V8r3pN9aAkX_Ald8_0bbFn3ISs0mjCjsQTGQ>
    <xmx:EFK0ZsfiMcZ-cpzQ4FjV0kbmOTcNeDB8Vg2TnWTqDaWDnMmf45GSkRgy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:05:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c0936b75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:05:13 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:05:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 19/22] userdiff: fix leaking memory for configured diff
 drivers
Message-ID: <ZrRSDaCClfh9dMZK@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <ef780aa36039560fd069ec97ce87665eb0775200.1722933643.git.ps@pks.im>
 <D39KL8N6S0HC.HFB9VRAVWYOX@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lpqU87L+NJbYKzwG"
Content-Disposition: inline
In-Reply-To: <D39KL8N6S0HC.HFB9VRAVWYOX@jamesliu.io>


--lpqU87L+NJbYKzwG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 07:25:51PM +1000, James Liu wrote:
> > Refactor the code such that we have two pointers for each of these
> > strings: one that holds the value as accessed by other subsystems, and
> > one that points to the same string in case it has been allocated. Like
> > this, we can safely free the second pointer and thus plug those memory
> > leaks.
> >
> > diff --git a/userdiff.c b/userdiff.c
> > index c4ebb9ff73..989629149f 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -399,8 +399,11 @@ static struct userdiff_driver *userdiff_find_by_na=
melen(const char *name, size_t
> >  static int parse_funcname(struct userdiff_funcname *f, const char *k,
> >  		const char *v, int cflags)
> >  {
> > -	if (git_config_string((char **) &f->pattern, k, v) < 0)
> > +	f->pattern =3D NULL;
> > +	FREE_AND_NULL(f->pattern_owned);
> > +	if (git_config_string(&f->pattern_owned, k, v) < 0)
> >  		return -1;
> > +	f->pattern =3D f->pattern_owned;
> >  	f->cflags =3D cflags;
> >  	return 0;
> >  }
>=20
> I'm not sure if I understand this change completely. We don't seem to be
> using `pattern_owned` (and the other *_owned) fields differently from
> their regular counterparts.
>=20
> Is it because we can't do the following?
>=20
>         FREE_AND_NULL((char **)f->pattern);

Yup. We have a bunch of statically defined userdiff drivers, all of
which use string constants as patterns. We thus cannot reliably free
those and instead have to track the allocated strings in a separate
variable.

Patrick

--lpqU87L+NJbYKzwG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0UgwACgkQVbJhu7ck
PpT/XQ/7B7ssM3Y39m55Brvf0WYWx/VVdUrgn/VvTzK+7tE+2kt4PP0Ich2kIggv
UVpAxGXp221Agll1tGAs/Pg8dV9+nsGTNQfbWXa2mCfoOtSa00d7wmciW9fmCijb
urhGHKDRRqVkIHexsl8SOoU4MN6fFxXNI2N1X0AWFcjOKTDvjLCGK6z8/rHqvfVd
EmjDAqhcJtH3nR/gAMYJgRIJJifBEWAvm7qjD7RbbzJS1hOff78/rxCy2CX2sX3a
HMR6QwXAaUqEE6AUPkH7cEL1IqqmRkubGsQBzVETo+CG3XmL8BZ8Qmuh94G9sm+d
zCmJf/QK0J9qVwuwp8uR2OUhqDv56ROlZMuRuhxOeHEAOIlz2REUfWXYsPenEjLB
k1Nk0TpH1q3/eleZNN4tDzjWTpOX86FYyYb8qDZnS19UIBK3dxCcAT5bB1oN4sJi
clNI36f+qClX9q661kpyaU2LtwsMp84TeHKXR6qEBidSd3RkgRPmpIC5NTIR5D2S
5Q8unpRGBXwJ5kuQ6H4+NfxoFaLLf+6FzH1rJOHYCvGKuAcuMv1Ehs9EK5W8Wg97
dCSEW8e93BXVT1Q+umov1KTUg3BlD6UTm9kiCuud824RaTIh3OkSnsO2xozQfH9f
Yvjaxcizc6zlEturr4m9quIvqXYkErFru5gaydGGsIj80K2y4y8=
=gK3x
-----END PGP SIGNATURE-----

--lpqU87L+NJbYKzwG--
