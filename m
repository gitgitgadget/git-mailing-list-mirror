Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1006CDBF
	for <git@vger.kernel.org>; Mon,  6 May 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981880; cv=none; b=rGz7bbZcOrWIQma57l4sEWp7zjZpBYC7iWxRzT1E88N6rXVkghnUj0oDhhYvgivMYb3a2Ls+QhBL6ZYnTDE3DiARKdcoPokDba+ktSq/okJ75gHVGvAkYSJP7yLGa/e/V+NxPXWD12BUIXJ+HE5YaPNV4w1Eze4NFXcWJsLDcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981880; c=relaxed/simple;
	bh=/Jw9HydUdwdqtiKc2OkekR89OutJFTntC2HNSS2Ru9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0BhjV/v9HcdujZshjxwDBbu30NgUqTZgmunjMxcxkGFVCI02sA9S8FAzk/fxxbFqPInb2Bl8clCNu1t0RHcKqKP/3Fi25I4PdN98lyukblas/7ZNKSzveSElobeWnfRP2Sd80zSNjvA1UieAxmrpv9N0HATDRrThqsUcGEOlHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cghk4J8C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cG58udZK; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cghk4J8C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cG58udZK"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 024B81800071;
	Mon,  6 May 2024 03:51:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 May 2024 03:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714981876; x=1715068276; bh=UKvx2SfoLT
	jXV54TxeqwPg0OpBWNUCMNewyROM1T624=; b=Cghk4J8Cgq9JHpUALv3bgvku+F
	+9rZ+2GmbL1gQ+pMEQCmTNUHLAVrNpN2zZFzn2/W+su5bSsZGoF/WVj7QrK4jFdI
	eNb8N9aLJc5yl4YHsCnEcc7ZLGtH8rxCmEW4nlXB3imZ+qDtEw1JZd8OfvLLnknM
	GG0CMFBHojgA6Zr0SLf4itnWu5Is4Dy5v3slNtskyFjmrzDPFYQAWkVjdrYKsqtb
	UhOadam6IFDM+6A/lOz07VTgZAr5vvbHKj8BFV3v3iK7P4Mk6IcMnmSVb5F6huuV
	b5yr8Kt0eJg5tTqOVjk0X5zniZGBkddxlsacUSiCgo1S3agt9zMbuRlbs4JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714981876; x=1715068276; bh=UKvx2SfoLTjXV54TxeqwPg0OpBWN
	UCMNewyROM1T624=; b=cG58udZKjwsMhHvV1ibpdNnz5zfH9mo2GtN0tIOY1vel
	uWLRtwMdh9sfc+co+N9OBxT0jKxRdkSMNLXup5AI4P0NtYCytOiDiSFrv/yRZtNZ
	jyDH4VrFdnuu8jKGrwH1C9XsQMm+Sj/1xroNKcYymbmwRo9UEUNp0f5sqYdOm5tH
	3G25cvGLFe9U4pHWMAvcadnGyjPMYUWNcpBJY1o0WXlWNFSQQ5r3WHp7MZZeWpjD
	embXPScXTzTgEmdf1nXoHJrB4K9lOPn3N3raFhgTVNdw7e7h/EjUR0rYxJi7HOcE
	rjs57jKDIqByIE2bKCnUlosQXoBl6hJkqbaoqub5jw==
X-ME-Sender: <xms:9Is4Ziv6OpFPv39L-9ImEqcStvJsgezPFgoBA5eGgGIWQwq2ctUTQg>
    <xme:9Is4ZndCeQR0tX3ezT8AdhldLgUj41ogquwXUNO-q_NqvSym3VYhq80nSnliC7m-3
    3dezFZaT4umiScTnw>
X-ME-Received: <xmr:9Is4ZtyObEjeLIDVSLwpDVNU7GIrFD6zVtGe-H-5YIoKwEyCYXdz2SL8qiu_OnLCy_IXIT5pO4obfSjKDoWFXlsMxTYnbuMU8PTIsbxd3k5oimA2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedvteevuefgjeekudeujedvhfetkeefuefhvedugfeifeeuledtvdetfedvfeeu
    ueenucffohhmrghinhepthhhvghrvggrrhgvphhrohgsrggslhihohhthhgvrhhithgvmh
    hsrdhinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhm
X-ME-Proxy: <xmx:9Is4ZtPnRR60Osvse09ZfIleXOaTzG3DvTBU7xldkOsqYpzCgVTjWw>
    <xmx:9Is4Zi8L055Q5kD1rZ8f-aM3xU5zP5QarbgPs_6tynM-3BfWf-5K2w>
    <xmx:9Is4ZlWZIs4Cgb1haB4clnr21whi1z-95zfglHVi6_LFa26vrK7-pg>
    <xmx:9Is4Zrc4d12ei3qVc-VbjWcqkDXynXxYu1PAs7fYb7ParAXhqU6KXA>
    <xmx:9Is4ZmTmDLBfhzogxLAyZbJOqAfQtmXbRTUWNzkMSVPpNgrSt8Y5lRGx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 03:51:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ca5fb783 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 07:51:07 +0000 (UTC)
Date: Mon, 6 May 2024 09:51:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, 'Karthik Nayak' <karthik.188@gmail.com>,
	git@vger.kernel.org, 'Kristoffer Haugsbakk' <code@khaugsbakk.name>,
	'Taylor Blau' <me@ttaylorr.com>,
	=?iso-8859-1?Q?'Jean-No=EBl?= AVILA' <jn.avila@free.fr>,
	'Eric Sunshine' <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 07/14] builtin/config: introduce "list" subcommand
Message-ID: <ZjiL7vu5kCVwpsLd@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
 <b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im>
 <CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>
 <015b01da9d5b$bbe59120$33b0b360$@nexbridge.com>
 <xmqqjzkaanr1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n27qHoGGBZ1ig8wA"
Content-Disposition: inline
In-Reply-To: <xmqqjzkaanr1.fsf@gitster.g>


--n27qHoGGBZ1ig8wA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 09:01:06AM -0700, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
>=20
> >>> +DEPRECATED MODES
> >>> +----------------
> >>> +
> >>> +The following modes have been deprecated in favor of subcommands. It
> >>> +is recommended to migrate to the new syntax.
> >>> +
> >>> +-l::
> >>> +--list::
> >>> +	Replaced by `git config list`.
>=20
> Can you trim quotes in your response that has no relevance to what
> you are responding to?
>=20
> > Removing the --list option is going to break backward
> > compatibility for users who script the use of config for things
> > like setup, clone automation, etc.
>=20
> Yes, that is why this is merely a deprecation.

I will probably send a follow-up patch series that converts other tests
to use the new syntax and that does some more cleanups. I was pondering
whether we want to introduce a document as part of that patch series
that starts to keep track of upcoming removals for a potential Git 3.0
release.

There are multiple items that could be added:

  - Removal of the old syntax of git-config(1).

  - Removal of the dumb HTTP transport.

  - Removal of `info/grafts`.

There are probably other items.

In any case, the old actions are here to stay for the foreseeable future
until we commit to a breaking major release.

> > Adding list as a sub-command could (but should not) cause
> > ambiguities between a list and configuration value.
>=20
> Because there is no sectionless variable, there exists no ambiguity.
>=20
> In other words,
>=20
>     $ git config list
>=20
> cannot be asking for the value of the variable "list", because such
> a variable cannot exist.  When you start your command with
>=20
>     $ git config list ...
>=20
> whatever other tokens follow that token "list" on the command line,
> it is a "--list" subcommand.  A traditional and lazy "get a single
> variable" without an explicit subcommand would look like
>=20
>     $ git config section.variable
>=20
> that is a short-hand to
>=20
>     $ git config --get section.variable
>=20
> and would become
>=20
>     $ git config get section.variable
>=20
> in the new world order.

Thanks for the thorough explanation, I have nothing to add!

Patrick

--n27qHoGGBZ1ig8wA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4i+0ACgkQVbJhu7ck
PpQweA//aeod0tJ6krDtqYzZtn+M6i+UF9wyhYYFXT46Pdn+Sfv5WsQu37p8awMl
6HChwiJS3ELiVU4+awi8tk6JZuaMielx/79XzNNLtIKxq4NgtuW1PB1Uxu3wvWD2
CixoXIx+hs/+XJGrwZ+VHjsFR5YZCVICem7yK/jdu5l+dthH4wBkZrv10MkFviV/
laptW+B1iJ484xhloLGeB3GnrHJ6HprkF8Q+HxBmPnK1LwbYXjxU+Lfz+8AGoUgo
MfGCM+WIdgNRxabsb77G8IStCNIdlpqMtzzfk28fzRPua/5n00xYTj1G4Dh9SIfh
2FES2sOJ/VZuutJFP7Gwl3Np0q08aaXJy15yH9hhQAB5SqhcbQumEw62rMzZPmmE
3romhzHh+dVwn8sTO6Euvnl2hniNyh21v8BKo5WtWCkk74duEmJpi5vn/j+oBCiC
wg3eQENaA3W0tku7cJCsM68d0bvQpIeseCiSB62UqJHFVRAO0XHbD+wy0FreJ+pQ
HgN6/aSASFyGS6Ktz/bHWIbC5REZ5rS9pYOaEFOuMS9YBhMF8lpQbn/Aq6gOIEZg
tLRjfr/ubZ1ksEdjixUgWlXuNER3NmRXi/e21xyX/qwIQZjLabge/U+00Gf7N4kB
de2xRIBgD1PcnHSV0oyLJZAiu4neDfalURwEQpv9pagGq4+vIEk=
=Hfyq
-----END PGP SIGNATURE-----

--n27qHoGGBZ1ig8wA--
