Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D684D2C
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090034; cv=none; b=niTiRPLiLeQHFYWdDI5b4iClTRjMcvxUjcoiaoLG0YqIByHLMUqvyPq6KJ3j2+zBvyrqikOp0IfSK1a/AtrSQDcvZ2J1Ga8Qv7BzIkplOsyWGoDkzBAJq2+dJPM9tmfmLskcONP7T4mA7u2wVLs7rRhiNwS56iscy0qZh7Y+t7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090034; c=relaxed/simple;
	bh=t2U/fzZvAUK5/9PpCBXVQ8inLOdIw7dDq51rLOsajy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTG+QZPIGwrclwQtPUvVXx0Z5DCINDQZ6k4qYIOfaLMRyD26PyebqMX/kpewWyi2sIG09umu/WdU/uzwe/SqR9oCVWCz44BpZwvzzuE2tYzEJWPKyAjI317YzApu/CS0w22EpdO9G2BtbBPiUnJ0y/ix4UIsL+nE2PGNMy2AHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gh7Rq9Ne; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nti6ZNIL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gh7Rq9Ne";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nti6ZNIL"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 82F831151C3E;
	Thu,  8 Aug 2024 00:07:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 00:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723090030; x=1723176430; bh=49narjUtbt
	apFyr/611MrBNjO/j7a55oUhBkdNFKW+M=; b=gh7Rq9NeDwHRW1KlFKq23Wnrwc
	ZX6yBfxr50URAqYjmC5O+DOWmRIuL1Swjqm/LQWch7z/imnQt7jO8JzfP137oQK3
	QrfrS7YdwJsuWoqk+W//aDZXMyGZWHGWUL+mtC471HjhpwkzA+nHD9fozvf1f2rE
	9h/oeHc3BNyi2zYi4vNLxn23WsMM6FU+7+CJpA/F/+tDFuYq/NZDPZeyzcqEVOeY
	WpEewWKSwvHHZoszEnUnVJZ46gJSFPfjcaGgP+kpsz9aP9xS4Bh28kJj+kxl3J+i
	Ylc3ENvZlN4zeIzJMEafonF4CNQkRe/S2dtPMdrT/jJ+8DezQmzvMMv+XCJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723090030; x=1723176430; bh=49narjUtbtapFyr/611MrBNjO/j7
	a55oUhBkdNFKW+M=; b=nti6ZNILL9GNq3R+zzzirWfPoBZftJOZDI5C1EutQtf1
	+usESk2jpQnxD9pN9q2c6Xmb8HhzJiS1WzGK03E7maVXVADFM7Ebrr77zCuWPjr1
	ldVwN+W5rZgMDp3fO68u+51H4xfNks9Q/jRN65Sj4wTphs2C6cX3B2Ko7Sbs/NY6
	8X6E0C0CIikyiNv7K2PP9b2gZRTUM2/ayTeIwlw0VSbpC8w6JdDU0EhSXsF+DS8L
	kus1re4VDbC8c41W3EbUHordGme9c3PXO5y3hH/TQGKvMlBMwK1dKgdncjFGure/
	sYlYqV1Q0+28b63/Z+D+puYZxUqHr0k9ItYq0ZA/fw==
X-ME-Sender: <xms:bkS0Zl5RslUoAKrYgl3wTOD5WAySqNnl9dm8laIGFpkpZEk8HtevBA>
    <xme:bkS0Zi41pYD9_lVWyxLTku86BM8MQVcLUcBghbhGFKAUo67g2M_uqEAM1prFT2JI6
    scQ-NFoZiPvzVYwjQ>
X-ME-Received: <xmr:bkS0ZsdQ5xVeHqoBeiWOz_KqCyeMgclqmjGoocFaxu13Q9anEvndDv0rdFvE07XCAUQY6CEhjxRHDMWc9Zo5JhF0W-c0m2hrOq6kkbwFbUYf9rNZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeel
    fefhieekteevudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomhdprhgt
    phhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:bkS0ZuKaZ3RjYo7h5MF9dDo9unj_uBvZAMAWiyqTL_FBuOPKJI4MBA>
    <xmx:bkS0ZpLC36W9n_LMh92m4gKBCAyZZnbVgIjrqJTZDABpGBDlj8HJIg>
    <xmx:bkS0ZnygkyQoY7eF-IPNuUnuLFgf7dSjjxhI4fCGraV7_w2lwxDcew>
    <xmx:bkS0ZlJO-CFb-5ZsMOjA3Nf4zyoBuFW90tLC0ytuEuxKGM0toj-g6Q>
    <xmx:bkS0Zp0ZSYOAK0CPn76Y3s01qixOyWK9w5Pe5Dnxqx2oQ6btKD62KW3S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 00:07:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 592146b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 04:07:00 +0000 (UTC)
Date: Thu, 8 Aug 2024 06:07:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/6] t-reftable-stack: use reftable_ref_record_equal() to
 compare ref records
Message-ID: <ZrREaGKQmriAfnIV@tanuki>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240806142020.4615-5-chandrapratap3519@gmail.com>
 <ZrME3EXwf2qDfTew@tanuki>
 <CA+J6zkTSBsrTZf2xyec-RaiqP3vJqvJmhVuW8GusbV-ia8CQ=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="46FuJeeJmMb+X9KR"
Content-Disposition: inline
In-Reply-To: <CA+J6zkTSBsrTZf2xyec-RaiqP3vJqvJmhVuW8GusbV-ia8CQ=A@mail.gmail.com>


--46FuJeeJmMb+X9KR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 08:12:58PM +0530, Chandra Pratap wrote:
> On Wed, 7 Aug 2024 at 14:11, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Aug 06, 2024 at 07:43:40PM +0530, Chandra Pratap wrote:
> > > diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftabl=
e-stack.c
> > > index 14909b127e..0c15e654e8 100644
> > > --- a/t/unit-tests/t-reftable-stack.c
> > > +++ b/t/unit-tests/t-reftable-stack.c
> > > @@ -145,7 +145,7 @@ static void t_reftable_stack_add_one(void)
> > >
> > >       err =3D reftable_stack_read_ref(st, ref.refname, &dest);
> > >       check(!err);
> > > -     check_str("master", dest.value.symref);
> > > +     check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
> > >       check_int(st->readers_len, >, 0);
> >
> > I think the change itself is sensible as long as we have tests that
> > verify that `reftable_ref_record_equal()` itself behaves as expected. I
> > don't think we have such tests anywhere though, uncovering a test gap.
>=20
> We _do_ test reftable_record_equal (which is a wrapper for
> reftable_ref_record_equal in the case of ref records) in the
> recently ported t-reftable-record test. Here is the test exercising
> this function in unit-tests/t-reftable-record.c:

Ah, great, never mind then! I didn't see this test because we are
using `reftable_ref_record_equal()` here, whereas the test uses
`reftable_record_equal()`. But the latter uses the former for ref
records, so that's fine.

Patrick

--46FuJeeJmMb+X9KR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0RGMACgkQVbJhu7ck
PpSZiRAAmF0+cqiaHLKxS7Z8IEcuKP/jEalQ+19F2LCYCDcdJTGqRyOdW+t5stC/
E0e7lcrufCI2CkUhS9Gf/45ajOTzCteMQeLILjumosphL6mkdATveN9r+aOUzA+L
YJ9TWatSFC2k3wkTQE+ZNLG9gdP2pyFlHOjaIXqIUstVL6bFRGTCN5gQy8i5tZdY
cxoin9e8yi28Z0zP8jwITVTTCdnJ76SZ1a6yIe2c0OKlCm8ILZZGD9ahiAdvEcp6
oPi2DTLVs729ctjDT/Fy3Yq47kMoNaU6MiztkGx8I/EAiJUsZLrqXv6GJWZh2kav
7buhiHem0colsMpvrAL4KeRO5KKNkJFyje5B0t0RDe/xUF/BDdhLZd70x+OB4psD
asb+9pyfD5O+w2cjL2A7XsMAE9zqYFywPaO2+NoYkXIsjJrfOLD+CPF5vS/cSF9k
RzQ2kxCRn1faZebbgJXVBlVWDFab5SA+iBxpYwfIJI73Y/FaZlzeT2hNTyjTpkml
Vh2f7do8DCyoFhKEiuwmk3I5Z46UwEUnczaNQoQ1vE1M9f3+xZUFbIHSj0vRsty4
DUjqlsyid0j2nyFJm6JRJ5lmK2BV5q/ZanXPHCUMrdWEhQXUMYnK4h4bjBhbnJla
4shrf5VGWaSgFEs/vDK6hT2Wjd3SsCM6TGiSmXiMzafU0RSoNnM=
=vHab
-----END PGP SIGNATURE-----

--46FuJeeJmMb+X9KR--
