Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B94C63798
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 13:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F53B206F9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 13:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ONjWeIH5";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmaNj4D+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgKYNQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 08:16:44 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52305 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727338AbgKYNQo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Nov 2020 08:16:44 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 043575C0163;
        Wed, 25 Nov 2020 08:16:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 25 Nov 2020 08:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=0PUamQr59Gap2OXtdp2kfQ5qkhZ
        RU3DKgh8oVY4o9Mo=; b=ONjWeIH5IHXsIbSNUls6J7J5o0RWZffAPnlfA9xYrkL
        +S0cmi807++TwyeZpHZBIYAbCxNu8uVv/J4Dpd+5uC7+1H7suGL8Q9p9gfcf628z
        B35c9PGd1K7XmAJSmlWjNWCZ+y2X0LvDv+C4eSXU7AeqhKZRHMv0WpMI2TUyX63t
        SHXilwdaleHXAy3jdU5QX9TV56tKe/cNSqacR5hAKUE+2qWE8jc8p92rZRwXQSYE
        t5lhY2cL3aOH4Y8OxSzo65jcbBkPGgtDK3eDUtTseo0PZ0gyXsR14Ls21SQeRmM/
        ApFdRrypx3D8z6zH69W2ls1sKHw2tK9Uv4ynqJS9WOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0PUamQ
        r59Gap2OXtdp2kfQ5qkhZRU3DKgh8oVY4o9Mo=; b=mmaNj4D+xGopzr0L4jOb7O
        hw7iLRv7c5MQ+TfYzh/FfU7P/karSQgdro57YT1Qtx5bjfN09gGbiWEHfpSkIbiO
        y9t/KJYWyKgEejpKtX9DSFGqXBPfu/vhgpwfJvRq2bYVsfxey6zfLSsb49X+1IZY
        Da9jOCYW7bU7TQE/69DSJrLb0uCe9uBMr1UswG4kgnNjUcpmqMYwF92QhQAvm17s
        fabwtKNuPxQoFPOcqpxOb5Cu7oNSx+6qJbOtNG6YQ6lztEOd0ZngNl0FKgCvUtI/
        m57xCrWvdr0YaMwm3WVXIBvdtfCQV33qeFRuF+UMBKrv/8rzqMKa2JchSq7nv8rQ
        ==
X-ME-Sender: <xms:Olm-X6RgACZ1sVY0pLRGSl_YsKwUyJsel52le168SjOUkKTg5Hd7Lg>
    <xme:Olm-X_yZIhxJYxML4RtSlSLK6z5jVgOH186JrFlhWgb13b-yHFZafMJZTyCVnEY0A
    VPac4QPVeYPw4fFUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehtddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdefledrvdefheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Olm-X31QxITqPXZIcy78CBZNWxD-640Rv6YHAdmq5SQ0_tIBrpCGGw>
    <xmx:Olm-X2D_BcYriczRCiEJuVVM1VOnsGwnRpVg5bNn0Iq5qWsem3918Q>
    <xmx:Olm-XzjAwZxdxSm_1ulG3tDHIa33C0k-px9Me9V2K-wb_1Nvp1aPqQ>
    <xmx:O1m-XwvFQEUKlL8XvhIYlgmtsLFMpbqqk9Lrx2rE_wvpbW2Q_Yb-XA>
Received: from vm-mail.pks.im (x4dbf27eb.dyn.telefonica.de [77.191.39.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9A1F03064AAF;
        Wed, 25 Nov 2020 08:16:41 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 303ad5b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Nov 2020 13:16:40 +0000 (UTC)
Date:   Wed, 25 Nov 2020 14:16:38 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/2] config: allow specifying config entries via
 envvar pairs
Message-ID: <X75ZNv/8X5Z7Yfci@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <X740yqoYIhrqsNRE@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vIsSQZgn4cvq9u8R"
Content-Disposition: inline
In-Reply-To: <X740yqoYIhrqsNRE@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vIsSQZgn4cvq9u8R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2020 at 05:41:14AM -0500, Jeff King wrote:
> On Tue, Nov 24, 2020 at 11:50:46AM +0100, Patrick Steinhardt wrote:
>=20
> >     - I've changed priorities. The envvars are treated as command-level
> >       and as such override all values configured in files. But any
> >       explicit `git -c key=3Dvalue` will now override these envvars.
>=20
> That ordering makes sense. Those get passed through the environment,
> too, but at some point there is a process where your new ones are in the
> environment and the "-c" ones are on the command-line.
>=20
> I do still think that a "--config-env" option solves your problem in a
> much simpler way (especially in terms of interface we expose to users
> that we'll be locked into forever). I sketched out the solution below if
> it's of interest (and I'd be happy to polish it up, or hand it off to
> you if so). But if you're unconvinced, I'll stop mentioning it.

The thing I like more about using envvars only is that you only need to
modify a single part, while with `--config-env` there's two moving
parts. E.g. assume you have a script and want certain configuration to
apply to all git commands in that script. It's trivial in the envvar
case, while for `--config-env` you'll also have to modify each single
git call. You could get around that by using a wrapper, but it's still a
tad more involved. A second thing I briefly wondered about is the
maximum command line length, which may be easier to hit in case you want
to pass a lot of config entries.

None of these complaints apply to my original usecase, where
`--config-env` would work equally well. But I do think that for
scripting use, which is going to be most of all cases where my patch
series is useful, GIT_CONFIG_COUNT is easier to use.

There probably are good arguments for `--config-env`, for example that
it's easier to spot when executing a git command. I stil lean towards my
current implementation, but I'm obviously biased. So if there is
consensus that we should use `--config-env` instead, I'm not opposed.

Patrick

--vIsSQZgn4cvq9u8R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl++WTUACgkQVbJhu7ck
PpSS+A/5AQDRpIoz5XvqACZP3wm54WXjOTYo4ynE9D64Z49Ds55Xasy0p8jAQVKh
DcS00kY8lc29rddyAOUWSqMnYN1YKd9ANxTRtS/0g53JCO26rUxKmxbw9Dh0qhqh
c4/64bO415ykpHC9kklCdUdtuEZC0Rb7byrAjDrSTTF3w4D6niPn5XFkVql14Rn8
2lMUCPvln6Tp1eKUppmltAEBMc21X+JGfJ2hXrq4wm4EpULnHkbE1Rk4bIZa2mEl
98amfOuI153UcipZTX8tkLpntiJ3yi/LhDShdX6/G5WQ1K+EVLMTVzJWSvEEjdxX
hJcjfjOH1BzpMdmH8MPNZusaaelzF4Gp8dHek1NgglCPetRytMI640eBXyLEm4+b
ZvcAsQzzYofdlfIfcDYq/6DgZns+vrhEaYWODoJCr7mo78t9W0POe7buv0ehr89F
zpKiNWTQ0S6ljfM4EFnzPvGKp8UzACHGh7q2T5zUXeXuU6Ehy7cjfQpoXy9pL4GF
WbAXEKDfROp9P4s7T1Cw5g+PpNT6hiDYObSSpL+LPLlukLh7LZ02Ahswig+cMPIt
5/bNIZA8AxJK++ZYvjQU6PZs5pDEH7jQyZ5n0f88iybFSbZSQwQndugzW/VaamEk
cvZ78Yy54NzWZg4Z7DYJ43iD/QjFqBCWrp6oxumZfOTNalJbCzg=
=nc0Q
-----END PGP SIGNATURE-----

--vIsSQZgn4cvq9u8R--
