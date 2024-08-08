Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF82F50
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723093500; cv=none; b=sWNEvUFoYfcB0UXA6plDGInX7C/pkU4DfmYONpvgL78TMsS02eSKe5IjeRwtj+6qNUSx/vqhkIpmvCviXd4ZfZdDoJYyoSY0XTBBn5c/RM34iKAzrKoMSxChTM30WzZr5mhMrUcsqSiqtKjmUyzHzZbPiWTg57QbTzOl2BLheaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723093500; c=relaxed/simple;
	bh=0Te6Xb0nxkQr1RYnv6KhIWuNZfN3mY4W+ea69pfNxkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmM+Yws5aMgdmzJhQ+BMUsEcb/H9BYieP2ZjHzMHSdlqrUFvj9H6HYsJd++W0OXyXfzoQSjhq9ee+M4S/bl5OgT5tK6hoKgZrBeISAFMpvfZroiEVcQ37mH3Xi+s2TVU8XxnxUZxSpW2FyeNRypRbNGpffdI3Fv/WlHJFMG9je0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RK7+AUP0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n9Jy06jF; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RK7+AUP0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n9Jy06jF"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7AA3C138FD8A;
	Thu,  8 Aug 2024 01:04:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 01:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723093497; x=1723179897; bh=MN92Q2UKJf
	LLsiXZ4GJ7kmR2xQFrQvawv/Hhrto4h0w=; b=RK7+AUP0IknsHzUsLNsJuy91qX
	RaJdazPMOw8UwWivDqOrasKFyHXJHKaea/X1QpLJwPvGp8XNalUkyPorvfoVPpzv
	6vrXxjeRpodPMRWfoB1tENy5yGII2tmJzk5/p0HAq1uLAM6ocNAMHjH6OIHsTuZP
	oNGosxhdQD502+TBm8AZP1y+K+iq/zXRPtkOsnpi5g9w133UHpwRDKsbSG++cyQr
	7lGbQtNJGSSfRe7pPHYbKsxycW/66OArnkT6YT2+i6aD8m385E0NaHZ9mSg8bvoD
	PovDV9QL54RdiHXbN3KUgh5ZtwdR4ZXpX5/00bITY85F4JviVfgYJYqKdF6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723093497; x=1723179897; bh=MN92Q2UKJfLLsiXZ4GJ7kmR2xQFr
	Qvawv/Hhrto4h0w=; b=n9Jy06jFGsYzWjiVjrv6c9ptHYxdyJSMr8ugiuqXGQYu
	V4x5xlbqQncfLuUM99/huQZAEquX6vsy7oBvgrrVOSm2UImA/699UazbHUl64/1k
	M3KPl6PdsK5TDsrt8M0PWhQEtzIak4GZrlb8vGrNzL4heJEHOgp5l+plFsFmL/Rt
	mgCRJ0po76dvSBsPyZwNR0q59M0KWg40UjSz0ZAOpWmLGMWreTTEnPPVGrK6gmsI
	LNcEtULgwptjVdt15+5O3mnhlsmTqj3v6ALi5Mm0N9kAL7XcKhV++PEFb9NXtAAP
	48uXTyzXd2fULi9S2trQYAWjkquWxhDojY+ph1ihXw==
X-ME-Sender: <xms:-VG0ZsXXrL7rPO-PxzcIy5_t2xSEVld7uCLx-7NBFUJOeki4yTEaSg>
    <xme:-VG0Zgn5BIFCg4WfqNldAole0zsPO6sCQu1sJD5EMYxCVei7u05XKMPCWrmB7G-Z5
    G5Q32AdPEaogYR1Ig>
X-ME-Received: <xmr:-VG0ZgZ3iMDZX9RAcFlp-0f4Rff2f-Ue4KjMa0SAg17ny6sYakSHQu0q6Qh_nQfrmxszkX4bWuB3DIWDbOxCUO3UlOFJzXN_e6-aJcn6hJoTtzWi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:-VG0ZrV9dceyFVE2cf3Pl4Z_IP0rKGrGKc7WNVCCRNwTLNEoZ74Slg>
    <xmx:-VG0ZmnoFpGPTOEXFUmGcng3v-AfTXQlE1iJbdRgw0eSv_03x5AmMg>
    <xmx:-VG0ZgfnQSvwlkMcHUSBoKabb5ny2OvDLWysFopkwjjXi9f_Pdgu9g>
    <xmx:-VG0ZoE5sR-C0SkUzeXbevyWp01g0OdIUXhzI1ybO1ElJqGTD9FtKg>
    <xmx:-VG0Zrw5RXncNE-nwOUOjdt3dO1f-HsdNdyVx8PGJ6AZMVaN-AJEvW56>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:04:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 45745eda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:04:50 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:04:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/22] config: fix leaking comment character config
Message-ID: <ZrRR9mwyQQrw4Dg5@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <a34c90a5527cb45ec89a0ad44dbca1d61705a0ea.1722933642.git.ps@pks.im>
 <D39HQCFQ2DCW.1KFGPLVU1EVQD@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HrOCby444CTZTg/r"
Content-Disposition: inline
In-Reply-To: <D39HQCFQ2DCW.1KFGPLVU1EVQD@jamesliu.io>


--HrOCby444CTZTg/r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 05:11:28PM +1000, James Liu wrote:
> On Tue Aug 6, 2024 at 7:00 PM AEST, Patrick Steinhardt wrote:
> > Refactor the code so that we initialize the value with another array.
> > This allows us to free the value in case the string is not pointing to
> > that constant array anymore.
> >
> > diff --git a/environment.c b/environment.c
> > index 5cea2c9f54..8297c6e37b 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -113,7 +113,8 @@ int protect_ntfs =3D PROTECT_NTFS_DEFAULT;
> >   * The character that begins a commented line in user-editable file
> >   * that is subject to stripspace.
> >   */
> > -const char *comment_line_str =3D "#";
> > +const char comment_line_str_default[] =3D "#";
> > +const char *comment_line_str =3D comment_line_str_default;
> >  int auto_comment_line_char;
> > =20
> >  /* Parallel index stat data preload? */
>=20
> Is my understanding correct that `comment_line_str` is now just a
> pointer to the `comment_line_str_default` array, and thus can be freed
> once we're done with it?

Not quite. By default, `comment_line_str` also points to
comment_line_str_default`, which is a string constant and thus neither
of these variables can be free'd. But what this split allows us to do is
to check whether `comment_line_str` has changed from the default, and
thus we can conditionall free it when it does not point to the default
value anymore.

Now that I revisit this commit I'm not quite happy with it anymore. We
still need to have the cast, which is somewhat awkward. I think the
better solution is to instead have a `comment_line_str_allocated`
variable that is non-constant. I'll adapt the code accordingly.

An even better solution would be to have `struct strbuf` provide an
initializer that populates it with a string constant. But that feels
like a larger undertaking, so I'll leave that for the future.

Patrick

--HrOCby444CTZTg/r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0UfUACgkQVbJhu7ck
PpSiURAAmbNtbUnEg1s2ElyBcPu8q2UWVnjhbP/GmQE2LnFXTF2bxZM2YCVOFwTz
u4Y/O7r3RBdBbJ24HJKwIZlwkUaeHeaN75LnCdYhl57olhuByyoVW6VDD0P++0Jn
18xx3C4Y/4BNjxtxryWZnkifJXbsBl/+2asbk7WrQSLL0k/BPrNuXAGTwVo0Vwz1
8ymjeQJLo5Nv4oyMXOj6AWKfXFQ5jK7CNhC7CWpLlGx5SQsnzNP7EZGxGo8TPlt+
lHXNeB70gyzwa+4jsp4h+BkqoIadBVA1QHZHz+3su3Gbn2TMjB6lIL2nDicp2aCd
yL1Ib5Jf4t06db4pPoft2y7nssRCAxu0GQAKilFYVGPJ2GwjzWMxLJQ8o9fWbqpM
/o7y8MZ5DEBWJMzLlFe90QWr5ImtAbBparBWU2/dELlNNg1Q3jLGmRUgcUYdq7UW
Ho4tqNByhnp7BKKCRmPR38CifJhPgGSIgYd4gqyhhIxl3F3exF5FGZiBCD2AOrNW
nEFS2azMF6HLQhJYaX5iFiaMGqj9T7kchjXrFBkMDdCo2w2xJvIow/YjPAF9ja0V
SDsmVW1CEzuWrKGTo9i031g7fLzt43PvDOWJobTo+ibhCkU0hJrwEvKEI//2IxQ5
eepjZFqy4e5ccEq+YsCbO62XaGAuDyS4GtK/Ec9uCUjndZ5zpsc=
=Xdy6
-----END PGP SIGNATURE-----

--HrOCby444CTZTg/r--
