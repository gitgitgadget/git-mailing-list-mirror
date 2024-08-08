Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65E18C93B
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121932; cv=none; b=PEcJlre6aazKcuGDPZmxy/Mq7h1CVldRWu3+7hFpThBiZahKlez9CpTNEHe39jde0ftnFnG/WnkGjO7+ohbwQkPaXIow8WH8PCn1UXg36ObLFWLVYPGANgV/ng5hBj7nwsWlP6TxPu+FNw/bbjyQsfdY+FBzKr/TGPnY0GfXulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121932; c=relaxed/simple;
	bh=88an2VUOY5IrC5cYpw+AVV3NKo/hK9dezu4YWYYTrTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTd1YVDK1fTpR3tlVq1Ow/ioJG1HMTJVbCKZ2sAcO8wuA6FaGBct8Awf8Q6YEI/Ed7dyAk2CKI/Rwh4+eeziLV+x8gC24R3WsRcx2HfZiCyKD7pKKT2wpTuBWUP+JC1BFjTQ+gaOAu0Jm+xvwisLP0ByWwX5UtDf/VTeThzAQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mnFmAg9G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lm0dUvzv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mnFmAg9G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lm0dUvzv"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8E48C138FCA3;
	Thu,  8 Aug 2024 08:58:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 08:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723121929; x=1723208329; bh=cfwwF13aqK
	/F4i/XC6l2LLmBz5DI0efm4CGViDOSaJU=; b=mnFmAg9GXdBslqpUrVGtCWkr+q
	mr7ke7OSShe/YwdDpuMXDyF5WDHpEdd6pWNxBf67uq14+X3eAD+XkxI4EPuK1po5
	hhundFK5fMffkJnCYyPFme1asgDj56IyA0a92Pn08VcthBJUp5SOe/GA4oqdyFKu
	BvkqtuR08jRR0lYT16OdN5AdZg2jx1oss/9ABVF77o0Bg0fW0Fv6BEbnF28w0tUj
	BfOHNxQ+aS/Xy+wtzzF1ZgF9+hopuFlzZSO9KwObytTbWrXxSd2xSmGOnOt75BKE
	ASi7gUt5WjKB6YKgTJWzx3+ROcVaegQqCAp0oJsOkZy8WB2zKFXnfhMFmV7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723121929; x=1723208329; bh=cfwwF13aqK/F4i/XC6l2LLmBz5DI
	0efm4CGViDOSaJU=; b=lm0dUvzvnaZunhVogK6bWeqFb4NGRl/ih/59mtr3Ogk5
	q34VSo1+gGiuGMC1bSO3elDo5fh0fGZ8vvntgrcH6Dq2W9M3MbQHQco8Ra+Xx9i7
	rvCyIyFDxt7PYHeBaXdeRhW0z+rfnWEPa1tvrdNTPVXPJCXo9uiujjAr1lMkP4rQ
	kmlXTWP1k+954peWRcrJqAf2JXFQzpASMD3e/rEnPmPe2sqfzeSG7TSkEXVhtQj6
	7SNOyEYKcwFhRDqJzYk7EAWKLR9/+ShbpTyuzw9+8Lhf7gajyWQ4XK3beNtcCAym
	iJ1d1yyj73iIm3V2TEmPz3TndokSoGmoK4gEq3AHTQ==
X-ME-Sender: <xms:CcG0ZnCqSSsZt4cNA9XPIPIkNXfWqJVPDKAFKMgivzRNJd4rOyxWcw>
    <xme:CcG0ZthNtCT68HUiEMQuGwawCXuftBdLbveLjf65CWdP3G14ONClTHUKDTDtgL3a6
    6KMXR14zwj2yuTweQ>
X-ME-Received: <xmr:CcG0ZimNNal6WdWKfHDFvlso6Pk6Ia74v61u3ZioeitcHEU09j4kj2amZcdrExZshI3QbWsWr9aa317Pp9orKj5waBd1Sgf9spP_MBIZzN_HQIQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CcG0ZpxcTx3vpoxd5K_aJ4B2Z47H9BXXWhFvR1Ifg3f379ufgf1S1g>
    <xmx:CcG0ZsRaEqw0wApMxSXQDtt7lY-V09fTzwBX0-7e9u9xEUBgQpMPuQ>
    <xmx:CcG0ZsZZ8-buJhw0Pq-C7kjcq7cPzjrhXE0yYUzyrRpLC_rYnoA2mg>
    <xmx:CcG0ZtSuauFTQVkmNh-ZA3J0Tw6YMxOhcuUyk2V38QQF1PZSyb_VDg>
    <xmx:CcG0ZifyZsNhS6iDV2rgVo8mvE3oyd_c4Td6TG-xy_YxN8O440LVDv9z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 08:58:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e8521b9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 12:58:39 +0000 (UTC)
Date: Thu, 8 Aug 2024 14:58:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>
Subject: Re: [PATCH 09/22] builtin/rebase: fix leaking `commit.gpgsign` value
Message-ID: <ZrTBBJAr4XoIJENz@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <05290fc1f14cae8229c42f2d0aafe6619c069e3a.1722933642.git.ps@pks.im>
 <b5abb3f5-c74c-444d-8006-22bdde2e9cd8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6zoUkHg9y0qkhz5f"
Content-Disposition: inline
In-Reply-To: <b5abb3f5-c74c-444d-8006-22bdde2e9cd8@gmail.com>


--6zoUkHg9y0qkhz5f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 11:07:53AM +0100, Phillip Wood wrote:
> Hi Patrick
>=20
> On 06/08/2024 10:00, Patrick Steinhardt wrote:
> > @@ -186,7 +186,15 @@ static struct replay_opts get_replay_opts(const st=
ruct rebase_options *opts)
> >   	replay.committer_date_is_author_date =3D
> >   					opts->committer_date_is_author_date;
> >   	replay.ignore_date =3D opts->ignore_date;
> > +
> > +	/*
> > +	 * TODO: Is it really intentional that we unconditionally override
> > +	 * `replay.gpg_sign` even if it has already been initialized via the
> > +	 * configuration?
> > +	 */
> > +	free(replay.gpg_sign);
> >   	replay.gpg_sign =3D xstrdup_or_null(opts->gpg_sign_opt);
> > +
>=20
> The code that handles "-S" could certainly be clearer. The value returned
> from the config is either "" or NULL, not a key name. In cmd_main()
> options.gpg_sign_opt is initialized by rebase_config(), we set gpg_sign to
> "" if options.gpg_sign_opt is non-NULL, free options.gpg_sign_opt and then
> copy gpg_sign back into options.gpg_sign_opt after parsing the command li=
ne
> so we're not losing anything by unconditionally copying it here. The code
> changes look good, though I'm not sure we need to add the blank lines. It=
's
> always nice to see more tests marked as leak-free especially a big file l=
ike
> t3404.

Okay. In that case I'll just drop the comment. Thanks!

Patrick

--6zoUkHg9y0qkhz5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wQMACgkQVbJhu7ck
PpSqXxAApg9i1RT6I9Vi2uYGVfS0WGWyKG1jVLcUaxw8ehefjaOFAo47kk9cvTV+
zs3opegFMvE8DmGDskVdNiD/mw+OgLxxl0d/+v9rNA27DinePHMcMKa8P4qzIcS+
kp6I9hmTsntJ/1OzDmhSvjizo9aNYyK+W0P/lLxZnLUnA75w9eZSMGV4VM0/hhtr
Zr6tj9SgNgyrdaRDb9QNKueuUTtt46EOo9Xi25Yfl/lDQJbyr0ZlAku0LPgBXh66
JIkSyZ6WQBRw3TEFLOxKnpFxqCirJlyAqER9HIwmrLmy4DLq/Xxm4jjwAofgcfYv
evT/hFoAQLBabnxJj9NM8aa7Vjm4yXu7AM1tTaqjsnVhdZiewe9ngUsVGyunilO+
+BsopdHB6Za0nlnRdz2VmQZqjRS7qLFNM3R1fVpQNjI8Ep5P0wy4MMbrx5PkJklH
K3jwSdFsO5qHY2ioE8ESsietFz7K0cPED3ceiQsWUhV4cf3MIzBfHKH3Oy00rGfk
aWhjpa89P7XCJ1A4SNQlbvWYKZf0QFUvZyUO2GKiCtY34y1CTTmELpTyIQ5ccYqU
2EQkSiLOoQr+9uCmosiTJZ7lHPAcptxYbMhRSJZB40g7pSDX5t9GUWDdymi6Obwg
xe0sOm9MBYrfk2P4n8/IHUouTnCVXMvZb1tVAmWGDKGXQVtKMKE=
=rxtZ
-----END PGP SIGNATURE-----

--6zoUkHg9y0qkhz5f--
