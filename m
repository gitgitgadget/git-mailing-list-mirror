Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22412DD88
	for <git@vger.kernel.org>; Fri, 10 May 2024 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715320455; cv=none; b=p8zBwaz3NARZOOAPhKHPBkz/cPoVftAPcmcm7//L4qwyjIYNtooRgAjmgW2y+ypARwq9pTQU5Wtn2C0Z/Y4E7zx+s22PeC/9y2A6Y+NywSeT6fFDAlh+WwiqlRuGpUUPoZDKrhOqNHAm4E4r2BHJ/lvDedea/jyoRojZnKJNRro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715320455; c=relaxed/simple;
	bh=3JSEE1bt8MpSDrx3fLvkmGrxdrbFR2ES3xVmxolMXF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTta2Mn7+CJbC7rXX7Qze6LPCGrc7vJFX+FZQAY5fq317b/nbE7qN3h7PjJ1lcz9V3ZcEcYQRW4+tmH8I1uDb1TEqTUGxaxoE8jTfdSZbZOgMx+CPJSMPxBdnme+S+JLKBClOBOot/+DGLmUSrAWQjjYOS45jw/sZ5MXgegpnp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p9FaU9lk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MzSeWxOS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p9FaU9lk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MzSeWxOS"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4EFAD13803A1;
	Fri, 10 May 2024 01:54:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 01:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715320450; x=1715406850; bh=l/Zvc1th9C
	/jyJXb2HB5esN1lMmxHoS8WcCUmAIbIfk=; b=p9FaU9lk/il/REyWFPoeYsyN6T
	wjy//Fy/gxUXajxi5oBG4/VLyVLmIIyS3arv9kiItkrcTUYNaxmWDvYHCzLe4mNJ
	b0wEza5kSnSwxibTpG18W9wu0hsoZz2lNKEeL0oA38rj746qK/EwCmEA+ZRKj0Iz
	B+/c2hiPFAV88hrGe04uYc3xlMUfYlu8uoBYgpaw4avWGLMFwJPd8Db1v/JfSCKZ
	VDlRPXMRtd3UXAx5xwl6qegyaKnT4tVN2CiOmOF8usEeInXoi2FZTA2kuGSYTzQ0
	4Qnb4ucdMmzNI1IoQDwwCus5hlh8KBntDB0Rjw7VWi+pS2xN0Zvx6OF99w9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715320450; x=1715406850; bh=l/Zvc1th9C/jyJXb2HB5esN1lMmx
	HoS8WcCUmAIbIfk=; b=MzSeWxOS/Q6ucEPfNRrMjTnkapWo5nnkZf0f1CUti2EE
	66a1x6/QGi2FGlLPP2Zt9xfB5Ase5XGvYT1HygUW2n0PZQpTSNLOgWLXAQHjwvVC
	4QgmXlNUiklOwF8gE2W5/N5d4G23C4TvmHXzvjn0QiIAg5IP0WSO9QyOsfGHDZDf
	FRFsyLJJ21w13n4JsFqfbMbbTX2zylupxO29IREIJJxxAO2V4kaqLURtub1N/xtT
	uIT6/linc9hhELw9PZoKzUfnhR6l1ZZYNIYD1Up/Llw61XT1+xBie7gK30FSLzJB
	9vAOtypLuUcBJ9LqUywKlfT08k5DbGgXldjB1V9zAg==
X-ME-Sender: <xms:grY9ZpEsXDLldsAhF1i-nT8qP2ViAznb_-RmRpT3ACgBtdAe_0wisw>
    <xme:grY9ZuVb61ynALJutrHfK9snG0S0oo6c6BllV2Nd75o0EWlRR80FEIZWcpcSq1epN
    rop2KIZXh6xBPFopg>
X-ME-Received: <xmr:grY9ZrI2Qkmax4RSox77I2Yg3r5KKtcqIwE3NfFvDqw8Dtd7ndFtbwVVUIqpDoUomkw9oVYpA2_cNCyetO9iqlw3OK0drrWbyJ_41VNpR4KdIuW3Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefiedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:grY9ZvGhULsuS-oP5dkQDwWUgzmD-_rgw-AnDOC3ddymIJl6x9HooQ>
    <xmx:grY9ZvU9Q7eKbWTQ_B8ZRZYg3pp3f5ILCKCAxCaPNwTUEmCfbPrA4Q>
    <xmx:grY9ZqMbDoYktgY4I7HGPFwn8hbj45bsC-z63dKmRl-FztflH_ZbIA>
    <xmx:grY9Zu3HtweGjnGRfg6ej1IVEw5CE1Zw03LzP3EGRYMvSVA3fo8szA>
    <xmx:grY9ZqQyMyz1EMpEjlXlCAUYUevn6cwHTdTVAajlBL-zx6zqfV2A1rZ4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 01:54:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 42a6bd2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 05:53:53 +0000 (UTC)
Date: Fri, 10 May 2024 07:54:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
Message-ID: <Zj22elrDIDvI9tdA@tanuki>
References: <cover.1714717057.git.ps@pks.im>
 <xmqqikzu95cf.fsf@gitster.g>
 <20240503173553.GC3631237@coredump.intra.peff.net>
 <xmqq7cga7nzo.fsf@gitster.g>
 <Zjh8XWwJKp_I1dwE@tanuki>
 <20240509165557.GD1708095@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pc3y3PHCeQGWJn+c"
Content-Disposition: inline
In-Reply-To: <20240509165557.GD1708095@coredump.intra.peff.net>


--Pc3y3PHCeQGWJn+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 12:55:57PM -0400, Jeff King wrote:
> On Mon, May 06, 2024 at 08:44:45AM +0200, Patrick Steinhardt wrote:
>=20
> > On Fri, May 03, 2024 at 11:24:11AM -0700, Junio C Hamano wrote:
> > > Jeff King <peff@peff.net> writes:
> > >=20
> > > > Though maybe an even more radical proposal: now that read_ref_full(=
),
> > > > etc, are gone, and we have only refs_read_ref_full(), could/should =
we
> > > > shorten the latter to drop the "refs_" prefix?
> > >=20
> > > I view it as a good longer-term goal.  But I also view it as an
> > > orthogonal issue to the transition.
> >=20
> > Personally, I'd prefer to keep the `refs_` prefix. This may be personal
> > preference, but I find it way easier to reason about code when there are
> > prefixes for our functions that clearly indicate the subsystem they
> > belong to.
> >=20
> > It's also in line with how other subsystems behave. Everything relating
> > to strbufs has a `strbuf_` prefix, attr-related code has `attr_` or
> > `git_attr_`, mem-pool has `mem_pool_`. So ref-related code having a
> > `ref_` prefix just feels natural to me.
>=20
> I'd find that more compelling if all of the ref-related code had such a
> prefix. But try reading refs.h sometime. ;)
>=20
> That said, if we want to move in that direction I am OK with it.

Oh yeah, it's still quite a mixed bag. I will follow up this patch
series to get rid of `the_repository` in "refs.c" completely. While at
it I'll adapt some of the functions to gain the `refs_` prefix.

Patrick

--Pc3y3PHCeQGWJn+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY9tnkACgkQVbJhu7ck
PpTbTA/+JwQ3sJd4k4vZ1rDBrGYjKRKMziBvyY176WzWdzi6A4GVaWsIESrlmaHp
Juq2F7k3a0S0I+DyaPCcsaQcjK0jUcnXk3Ee50k6f49QLyf7ndfcCfZ2ZfNLzT1n
TdLczK/9kQlA2mUEXCxJULNSFjzZPnLGl51mhOXBp76SgCxbHh72l6w0s1nPQKu0
QF0JGR1LPaONxdFwofDyCx97ZrTEdKwglMBss2PXFA+32EIAXjI1k+zmQo/iCeoz
A+lYlHap3Wvi4ipDUPH2O4kERZSmWK6k5EJHqX3VCMf7ukX03z/RoIRimEuEILHw
8j9T8hoRS8EnYrUy07v35FVv5M5X7Hiun3Boh3Mw27B7Otii/oaflfawoZimj8Kh
g57E5sfn12rd2IWLiokmCAnf0eGI6jbJjbPZDegwNfVeaU3cVwc8dfu/ng1wpO/g
dWpJ8HG9TOSa/x8fEJyU/RoObck+eF23RoXUpYr5nY7pZsqM3nZ/gVw58UDov/If
oUcC3FfLF8vX/GA2dx8WAXBN0UgzjjTPtj/olzin9kU81B39MPZ002bRC6ALqkcm
q6UOroXSId9E3ALqTgwmdon4P7FcCt2ZeJrtFudJFK9N0novkOhaycqiRw6WsJlI
iPMr4ixWOBUb0E7CIwBeIVEKOhLErqvdY3prsam1UvoL/XiL+jI=
=0jxG
-----END PGP SIGNATURE-----

--Pc3y3PHCeQGWJn+c--
