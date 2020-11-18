Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478FEC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 06:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6673324655
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 06:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i0fsmXGb";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JLaqpb+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKRGso (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 01:48:44 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33161 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgKRGso (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Nov 2020 01:48:44 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 257D9D1A;
        Wed, 18 Nov 2020 01:48:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 18 Nov 2020 01:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=YpLbG9z7Hmy++pe2fa4PpwXGYzP
        U48pKAnwrCxS54MA=; b=i0fsmXGbNy7XpIRIcdC23pkymZ0pOwk0RxcDVIymeWJ
        KeRWrYR0BiG1CGFdkrRGcx4bosN1sJG5yOkSrTAr+2wDIn/npmkVrlZLwzcQUwb5
        IudrciT4hhSs0rFI9BhQmm4X6fcvGBx+9fUIh+f/xs4BwD2tyuboLV5zQDgI+evH
        RVfp8HEjD8FgiW+s/OmM/G34UVskJXX2FaoF2K8xmfqSwdLpUdTEyWW2ve8uimCV
        NbhYBoy1u+Cv+E4gOhhJN3v46dLsMQU19sGfOgY4uwt/UR0TILkevVjqnLemeM0z
        UIwYdO0cipMj6Z29iSXrDTNSQKqwqdfhwVumKX4d8pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YpLbG9
        z7Hmy++pe2fa4PpwXGYzPU48pKAnwrCxS54MA=; b=JLaqpb+WYKHWu61J4MX1RP
        dYzny1O4IcZtMyKDw1mZuSCzAzf3AmBzJl4ivWIYdykGfXeExiYgSioRP9l+bK7y
        AirCAfeZuCAqI6xs8U6zU9ddU+kt8B4DvLfE0HuA6wXa/YMTUAnK+PPGdc31Ab6G
        PZpavuc91FEPCrPe+PFPq15yOHT0EyXKeMXXiPqGsSHN9j4fyI07XLN1clTOAEIp
        D4ptWEgCvkuH7A8fmhQvkBWxTD1kEP9negexst/DR/9MRBz72C2BST6R/ZyytDIE
        sEFUYgpgyNujvBs4rXfQzeWdlGrdCoTGntficcbkee01NI3nF0DEbxwbqgvehuaw
        ==
X-ME-Sender: <xms:ysO0X9KpsbhoNjlHoJ5JgG65fvzFJE6edF-Yu69CUa6UEdZO8D3h9Q>
    <xme:ysO0X5IWxjP37x-A5RQM38V_pqcJUZQ64F1izqxUuYQ8fjk3cR7Xi2IXaxxRs1b5E
    zIDOIgo5TbITbl3Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefgedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdejrddvfeejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:ysO0X1sgl2XpH760_QTnXrFlqz_SI3Ttxt1M8U0yymSm27gpWCisZA>
    <xmx:ysO0X-b0MQvabBYh4nFvwK_ucUHJ8H1_BM4Qi4F7_gHySC03F5oKiQ>
    <xmx:ysO0X0aulxpCq17EC3NutvHdyKIx7isLJvLXCvA2L6xVW-i4xWVwwQ>
    <xmx:ysO0X_x2INN_-LDu6z4BBswA0XhrCBztA_aBw8mIPTeejPGXu0NJ9g>
Received: from vm-mail.pks.im (x4db707ed.dyn.telefonica.de [77.183.7.237])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9BD8E3064AAA;
        Wed, 18 Nov 2020 01:48:41 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2259bffc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 18 Nov 2020 06:48:37 +0000 (UTC)
Date:   Wed, 18 Nov 2020 07:48:36 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 1/4] t1400: avoid touching refs on filesystem
Message-ID: <X7TDxPFjrG4vruHx@ncase>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605254957.git.ps@pks.im>
 <617d48b00a13c8ef82749f0b610997625f6cf222.1605254957.git.ps@pks.im>
 <20201113204031.GA780435@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xb/TYaBvw429ANFy"
Content-Disposition: inline
In-Reply-To: <20201113204031.GA780435@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Xb/TYaBvw429ANFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 03:40:31PM -0500, Jeff King wrote:
> On Fri, Nov 13, 2020 at 09:12:31AM +0100, Patrick Steinhardt wrote:
>=20
> > The testcase t1400 exercises the git-update-ref(1) utility. To do so,
> > many tests directly read and write references via the filesystem,
> > assuming that we always use loose and/or packed references. While this
> > is true now, it'll change with the introduction of the reftable backend.
> >=20
> > Convert those tests to use git-update-ref(1) and git-show-ref(1) where
> > possible. Furthermore, two tests are converted to not delete HEAD
> > anymore, as this results in a broken repository. They've instead been
> > updated to create a non-mandatory symybolic reference and delete that
> > one instead.
>=20
> s/symybolic/symbolic/
>=20
> Other than, this whole series looks good to me. Thanks for taking the
> time to do the extra cleanup (which ended up being way more complicated
> than the original goal :) ).

Thanks!

Junio, shall I fix this typo with another version or will you fix this
up locally?

Patrick

--Xb/TYaBvw429ANFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+0w8MACgkQVbJhu7ck
PpSjMw//VOoNYiIKv3eXFHWOBWJhnv4L+/lUFe6wtBR1EMsXKU0Mo0RkUDCMYRKa
xPaohhS367hqEcEfoPIDzVIbQjtA4ynOlsQFrPdFe/NQJpTfogeBMnpR5w3d3qbM
RquhG1kd7YLT7OJmwnpgTAwq3jmvx6txc8kHBdNGJ1nvPTKN1xEWdPusC9fJvW4A
b9vLY3rAbmrMXNj88ghZcMc14eQAW24g+0t8QxnvgIF+qm2C5B14oGUkp0JyCGwj
zsHKw8xC1KadZuzo0Dq6duLh4pgyMjb1TRA3EayaOTnrZ/1N7Idqw0sLESq40pym
wklShPoj/sIx8DogNCAHQI7Wy5jgVdHWAYd63/zTWdYS+gSsDwQziFevp6nkMewT
LTxnc5xedAT68wT8ZrFMh1QuKKGiSF/pu2vLKF50QMZ9WFv3qhwckGH8fNoU/4Gu
jhV9nRybBtzdxhj9CIkfNpSR+KfldJlHukWdRgFRTmwL+Qu0U8fqHF2AgWhY6ugP
NMDBZK9N4Z272bzzd7O6vQi1ccC0t4jZjrc23G6FAYy8ypznt1szpENsL8oa04LY
KG0pAcag8I/qs7S6jyuIE4mwRfCOMe+i2KuEmvpilYK4O/pxj6WmUA0Xuu6+RnJt
GjqteMjt6ZJONGK2cu+wAhtOary5X/k9dPj93U/erwwtTK8kcDM=
=WfI8
-----END PGP SIGNATURE-----

--Xb/TYaBvw429ANFy--
