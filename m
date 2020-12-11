Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F730C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498D723108
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406150AbgLKN0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:26:01 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:41013 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404972AbgLKNZu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Dec 2020 08:25:50 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C4EFAA7C;
        Fri, 11 Dec 2020 08:24:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 11 Dec 2020 08:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=g3x8XHBxQDyiKHUAoo8b761ljNc
        RpznD5HNJb+szZZ4=; b=vn7QqlsrpuRTShRsktIS24H9ZXyPeVhFyjFWZ7/b7nR
        WH+hNhOnqjJzgbYIcmarzQNpzhSultK4K7+BP/q6vSxchzM4saDu0rEO6tq9krWK
        +VBCTHMj0PBOFETtB/tNuam7/PbFw/gpJZJCwaBQHDMzYMs19l0raVQ91sZymXhd
        9KceI7XxcGMUA85ZIUiTe+mf39v4FRCafG+nHRkNTJ7InU4G3otxol89rA2q5ypx
        XNRO2truOQTp7Wsjco/aY4xlQD08ZevIJW8ocQwOoO+TIxWKc751vO28894lhu1C
        w8iM8KNRaQ2mz3jb3rmzjxov4D9PGRyc7668UYG0nJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=g3x8XH
        BxQDyiKHUAoo8b761ljNcRpznD5HNJb+szZZ4=; b=mzpIFSwzxgZ45AU13oUgyx
        hol/x3uoi8yzREEpgi+w1L3gOVuOvym8ui+6pEx0rO/APWb+CIZBtIcuvSfPnE0P
        pDM1DzwP1MvQTZcNBqIGcKJbAciU4KyAmLsZ9qNWyPl8xWQXaerSeblFJIhfr0RV
        PGBjYyfjlA8bh/XW5Z1Prra8Or7fhnf6gHrreHUsHS/FvDZ5LGAI9c9XR8wFVi7r
        eikG+rMyDWhrE+X4AkV+Ax2pAorQF7+X2Kg1JRqu0gVxbo4CSg6KHz0eGk1W20nt
        aM8FquKVYJRE8mVsY/+lmL6qdyAK00PiNTmZcSIfkVSrLO1pDrlCOizd2tkxoSGg
        ==
X-ME-Sender: <xms:FXPTX1pP34BFX4RjU4kG2RCb5rihZrUllnQhh93i1iDC8n73bQqNGw>
    <xme:FXPTX3rBTfuzZPv3FoegwGNbK17i4XemFaO36eFI7yAuRcHXSyaisv-ykUR1Dwn_V
    Gk-13jD3erXRG-dJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekvddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucfkphepjeejrddukeefrdehvddruddvieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:FXPTXyNVx_tNINAY3l0OmeY0UI9QvBtfbWyJHDysLWDEPPlwikf4_w>
    <xmx:FXPTXw4ehGXWqQ9yDw7txDoPAKYskId7GjcbPMrChOx6jNv_zbMR_A>
    <xmx:FXPTX04kbQHyPS3z1qVCYwCaHlhhAz7H9gXxHE_m_4LXLx6GiiJkIg>
    <xmx:FnPTXym0KUD6YptbiCXqlBkXGSyWGesBcAQo1rAZC-VczYiAg1xtVg>
Received: from vm-mail (x4db7347e.dyn.telefonica.de [77.183.52.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id E88341080066;
        Fri, 11 Dec 2020 08:24:36 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id 80ffd84c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Dec 2020 13:24:36 +0000 (UTC)
Date:   Fri, 11 Dec 2020 14:24:35 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
Message-ID: <X9NzE5+LNYqG1s+o@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
 <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+2ESzqCL1nZplwan"
Content-Disposition: inline
In-Reply-To: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+2ESzqCL1nZplwan
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 11:10:04AM -0500, Jeff King wrote:
> On Wed, Dec 09, 2020 at 12:52:26PM +0100, Patrick Steinhardt wrote:
>=20
> > Co-authored-by: Jeff King <peff@peff.net>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>=20
> In case we want it, this is also:
>=20
>   Signed-off-by: Jeff King <peff@peff.net>
>=20
> > +--config-env=3D<name>=3D<envvar>::
> > +	Pass a configuration parameter to the command. The <envvar>
> > +	given will be replaced with the contents of the environment
> > +	variable of that name. In contrast to `-c`, an envvar must
> > +	always be given and exist in the environment. Passing an
> > +	environment variable with empty value will set <name> to the
> > +	empty string which `git config --type=3Dbool` will convert to
> > +	`false`.
>=20
> I agree with =C6var that we probably should keep an empty variable as the
> empty string. I think some options use an empty string to clear a list
> (e.g., push.pushOption), and I'm not sure how they'd react to a bool
> instead. It would be nice to also have a way to do the implicit-bool
> thing, but I don't think it's strictly necessary (it's always correct to
> put the string "true" into the variable instead).

I think this is just weirdly worded in the `-c` case, which I mostly
copied. We _do_ keep the empty string, which effectively means that `git
config --type=3Dbool` will return `false`.

Or do you mean that we should allow `--config-env=3Dfoo.bar=3D`?

> I think we should also document that <envvar> can't contain an "=3D" sign.
> Of course using strrchr() here doesn't help much with just this patch,
> because we flatten the string before stuffing it into
> $GIT_CONFIG_PARAMETERS, so the reading side would mis-parse it.

Makes sense.

Patrick

> But here's a fix for that. I built it on top of your whole series, since
> you touched some of the related functions, but it could easily be
> rebased onto just this part.
>=20
>   [1/3]: quote: make sq_dequote_step() a public function
>   [2/3]: config: parse more robust format in GIT_CONFIG_PARAMETERS
>   [3/3]: config: store "git -c" variables using more robust format
>=20
>  config.c          | 118 +++++++++++++++++++++++++++++++++++++---------
>  quote.c           |  15 ++++--
>  quote.h           |  18 ++++++-
>  t/t1300-config.sh |  60 +++++++++++++++++++++++
>  4 files changed, 183 insertions(+), 28 deletions(-)
>=20
> -Peff

--+2ESzqCL1nZplwan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/TcxIACgkQVbJhu7ck
PpTozw/8DuPIKeodo/hFxIzWVQgyO+qTfmdh1ahw6bW+ny4ZpD1awPVVhN19boLO
PGVO+q6MUciClbmz4BBo0LWxvF7EioUUD3Qwl9TW1W0dDvaoHGCor5bqSRjbC/iv
EMYj4YcQnM6stXxVlXT6qiwCNn017u+uGlyw2P7RmNpwslQ5uuROLOEpFUndo0Y2
FHG026OSuLELK8SuY4zOmOXHB1MD+KTfMX8xVnvHgrUcwEtSoBka67WN9uZp9HZn
WF39Z7WJzjLpOni8Pae/gxHfM+KkAGcV3qneggNj/uEBIut6hyRUTsh5wXk9lKPT
PBCRlhSbIPZw7J/ss/kKtc44RP53+6GrxtvW5fa7oJn3IfWiauqyv4wPQvfGq8U9
EQUCXupItXZu88Np6iBcJqrLX9vMt6WndKsQtQ1VHk3j96gTfMlSCzQV5Z2AkTtv
zpCYtplEH87cppkndVKAYUb4eAPKtRIMsSz9/GeNtG9Zq+Fzp8ux+WxiDTx2bnl8
NAbdELcP5OIbMZUaGLaV19fPCGGO6sOtV0QUHYuUXVaTeH7oZnLYZqKlRrN57KFj
ECip9J8JbGGllAy/Jfrot1CZlNOLwJaWNSsOo9vKD7CoXrJWurDr40N3DhKApbuE
sUVzooGyOvgA6/J+xunDTvt3tmEnZSBe5cJHgk30teRzoXfMJ8Q=
=pe29
-----END PGP SIGNATURE-----

--+2ESzqCL1nZplwan--
