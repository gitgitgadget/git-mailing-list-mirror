Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB221168C17
	for <git@vger.kernel.org>; Wed, 29 May 2024 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968881; cv=none; b=DldPvEGOqYfM3R6eQowQjf/czecbzHcxG1GqYrMxJgX1ecP1GEhmeIaTtWiUhlzAZHDqLzWewCq3ZHZZQFNfkGRNCueDmAfZTp5ghjX1LOlzRBlBgkDGDRsGtiJuprEQNak7WE4btYHrgu4GNsZRbqZtBBtUKBpmJ/bio6lqYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968881; c=relaxed/simple;
	bh=LqXSTRKf91bWIIpXgQyWJQ5ANH5xCnteU3zU/bcc10g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBl4mnK/AiQLCj2c9hII5qO+NtAhksS4/ZY8Dd/Dfudv9fQQ7UbRy20O5/rt1KuvK5O5KnH6aoP4kr5Aazn+txChZtZDjM2Qch9BL6Jyg+JNLNQMa9jbwllNJIv1axf7CxwBc78oPaGCOnpbeExfu0zaX6zp9ljsq+aRk0XyVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m+ZQkH30; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PEBdxQ8o; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m+ZQkH30";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PEBdxQ8o"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0C1DE1800131;
	Wed, 29 May 2024 03:47:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 May 2024 03:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716968878; x=1717055278; bh=j6cPVQYeX2
	+I6Zkk629g2ecgPT4Arg4Fe1+e99tPmfU=; b=m+ZQkH30odvMmh466D1E74Klue
	0xBSUxe3uEGn8FzjzSps2jjyKHcjs26tNzvlZoVvht45UaE9iAo7wBWRMHwUBYxY
	uhcFWUpGj+jJULJWj5Ltj/Vic6Nk2cCmK9aEhzlWST6Nh8f6UjX9VIQhS4Sl8Y3w
	6TOOoIyb4HEmJo2OsrtuXsFYhDOn1HzQsWNehamK/S0t4LDigrUgYar3YgX11V2w
	gc3tDfTWFHVA7NFfm6nlOg5QBP7B9gaQVCFLYKQAG/l1RcoVHho0XHFu0pQgN5oL
	8yykPR/xgJF71kIYeYO19Gbt0fcBdyoDNBhUHonjCt2E42FJflgNQrAIITXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716968878; x=1717055278; bh=j6cPVQYeX2+I6Zkk629g2ecgPT4A
	rg4Fe1+e99tPmfU=; b=PEBdxQ8oOLyTsgvlwEXBbOQItIu0GI8VL5PaMM/dYvGW
	uLZW5U2e+uJZXDvSJKrmfJLXn63RKZNpEwNLfUDwy86sfxLT9Kz7eAPFOz13kTAd
	jCtzHnWOTohrNFLEqvoqcaXCwVfIADqsth++FG6vum+hdXezwWZJvIOV+0SWxkHP
	1sgImOgqvw6CeMTFQEaDhzMbxM4rKXt7LY5pNx8Bep/eToFaASoqoHKnW8OlKA5D
	cpvTLQdTFrHJwjMoEJnXionqUY4VDVKuxG8aBjoK1w+v9C6xj+mLDIFMySoOx8WI
	wdyldlm7TuBMnyCJMBubVqCILCztlclL5C/3HYtsjw==
X-ME-Sender: <xms:rt1WZobUEB2uVskCw_PYn-5-NfpbS7JYNxOt9-TKtQrWN9lARhdqWg>
    <xme:rt1WZjb9mOa5NjyWODJaKre310LFXljCcRaIq3Ccmiq1C79RkEDYSA2_JGLDNmy--
    GFMYd4gWhluwnONBg>
X-ME-Received: <xmr:rt1WZi-sytvmKzTC2G_ONw_Xpu2yvQx4T9NoQRK9Twob0opnp1JA9gwN77BZJ4NSpRUV2oZinbPc8KXJHKu8nTEiLzS7C7NHDURQk0DNDgJkidDv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdektddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:rt1WZir2NG6RuS_lC4hxjqX-mfGKCeuCRGwY60FAU-r0rxOx-yBnhQ>
    <xmx:rt1WZjpQshilZ2lpCs5wd0XQ2ZsqNlogdEk8_OCkhOQk1S2lJWpC0Q>
    <xmx:rt1WZgThXnqTeXcFnf2OL_z26rakp5Xk4mC86VIfY2EQmirqOS_K7g>
    <xmx:rt1WZjr43LJDXn18ES-5UiXbwRktj8MIJGMTdIOR0nBa3x06lPWwZA>
    <xmx:rt1WZq1q_Unr7u8qXlDCoQWMBcIGmrKs3Tqdvo6UHS56TUf99rWrojZt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 03:47:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 56f84b96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 07:47:40 +0000 (UTC)
Date: Wed, 29 May 2024 09:47:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] midx-write.c: tolerate `--preferred-pack` without
 bitmaps
Message-ID: <ZlbdnkFIg1H_KQxS@tanuki>
References: <cover.1716482279.git.me@ttaylorr.com>
 <c753bc379b005ecaf131f8f1ae9c5b80b2712759.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aUg7pR21KhekfPsH"
Content-Disposition: inline
In-Reply-To: <c753bc379b005ecaf131f8f1ae9c5b80b2712759.1716482279.git.me@ttaylorr.com>


--aUg7pR21KhekfPsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:38:03PM -0400, Taylor Blau wrote:
> When passing a preferred pack to the MIDX write machinery, we ensure
> that the given preferred pack is non-empty since 5d3cd09a808 (midx:
> reject empty `--preferred-pack`'s, 2021-08-31).
>=20
> However packs are only loaded (via `write_midx_internal()`, though a
> subsequent patch will refactor this code out to its own function) when
> the `MIDX_WRITE_REV_INDEX` flag is set.
>=20
> So if a caller runs:
>=20
>     $ git multi-pack-index write --preferred-pack=3D...
>=20
> with both (a) an existing MIDX, and (b) specifies a pack from that MIDX
> as the preferred one, without passing `--bitmap`, then the check added
> in 5d3cd09a808 will result in a segfault.

The check you're talking about is the following one, right?

    if (ctx.preferred_pack_idx > -1) {
            struct packed_git *preferred =3D ctx.info[ctx.preferred_pack_id=
x].p;
            if (!preferred->num_objects) {
                    error(_("cannot select preferred pack %s with no object=
s"),
                          preferred->pack_name);
                    result =3D 1;
                    goto cleanup;
            }
    }

And the segfault is because the index wasn't populated, and thus
`ctx.info[ctx.preferred_pack_idx].p =3D=3D NULL`?

> Note that packs loaded from disk which don't appear in an existing MIDX
> do not trigger this issue, as those packs are loaded unconditionally. We
> conditionally load packs from a MIDX since we tolerate MIDXs whose
> packs do not resolve (i.e., via the MIDX write after removing
> unreferenced packs via 'git multi-pack-index expire').
>=20
> In practice, this isn't possible to trigger when running `git
> multi-pack-index write` from via `git repack`, as the latter always

s/from via/via/

> passes `--stdin-packs`, which prevents us from loading an existing MIDX,
> as it forces all packs to be read from disk.
>=20
> But a future commit in this series will change that behavior to
> unconditionally load an existing MIDX, even with `--stdin-packs`, making
> this behavior trigger-able from 'repack' much more easily.
>=20
> Prevent this from being an issue by removing the segfault altogether by

Removing segfaults is always good :)

> calling `prepare_midx_pack()` on packs loaded from an existing MIDX when
> either the `MIDX_WRITE_REV_INDEX` flag is set *or* we specified a
> `--preferred-pack`.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx-write.c                |  8 +++++++-
>  t/t5319-multi-pack-index.sh | 23 +++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/midx-write.c b/midx-write.c
> index 9d096d5a28..03e95ae821 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -930,11 +930,17 @@ static int write_midx_internal(const char *object_d=
ir,
>  		for (i =3D 0; i < ctx.m->num_packs; i++) {
>  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
> =20
> -			if (flags & MIDX_WRITE_REV_INDEX) {
> +			if (flags & MIDX_WRITE_REV_INDEX ||
> +			    preferred_pack_name) {
>  				/*
>  				 * If generating a reverse index, need to have
>  				 * packed_git's loaded to compare their
>  				 * mtimes and object count.
> +				 *
> +				 * If a preferred pack is specified,
> +				 * need to have packed_git's loaded to
> +				 * ensure the chosen preferred pack has
> +				 * a non-zero object count.
>  				 */
>  				if (prepare_midx_pack(the_repository, ctx.m, i)) {
>  					error(_("could not load pack"));

We now end up loading all packs, but in practice it should be sufficient
to only load the preferred pack, right? Is there a particular reason why
we now load all packs?

Patrick

--aUg7pR21KhekfPsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZW3acACgkQVbJhu7ck
PpR/3w//bJgSsu+ZevGyikPaAVGdiEVVCP69MzpkY7xpR3/+xOQ/QUJk6D35wJOo
vLoROaRHcbbAhDKqSetWzUlpwEOcSIjgcUeg/ScrQlIpQAz6XO8IWF0huqfxOlw1
zt8U2FwjzMgaplwzKD0P6xnJyIhIkMWPZ/MAJN5WsBOtME3w0bjAGZj21q0b2EMA
Hp/3LOMTjU0olEQg+tyuBwEzdV5SnEvFub3feH958HG1xAfZDT13fXEOReQRxu56
EThYyxyUeSyTtyFPsUB98UfmjvGCi6V+Hx8J6z77vkr738oMt5nDtcwgx+WWGRYt
25w/WcEl1+YCazAtav8EQG4417zR62pVAFNSGzHasMii1zJRWVFz3BBV2F6rGte9
l1dlbohq6Pqptl4rSWkVl3Mr3ZinnV8NlgbTuHm50kCpFlyofzijiSwXFhUsbjV0
HgjeOoP/ijuQB0GmXDOIKJo74kZ7B1VByRaYtm2zSHpLT9X4z2bHjxxWjud9iOam
RMyyJZ86Gnybp1PKPF2BBkatZfGmMPwzyd/ciOvxygI2SS1TYLKRZyrqBMvQTEFk
/SjUNVeQ7stRl3rpu3VPa+IZe9TUqitYThMeSSttKqf3PxbVtASqkGkhagWFKaSA
EwoSYa9+k2oMhNmJ1BLwtWTD+NOxAlOCz7/20x+plPfJL/px/Wk=
=sGus
-----END PGP SIGNATURE-----

--aUg7pR21KhekfPsH--
