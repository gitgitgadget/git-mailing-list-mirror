Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A631C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 05:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiKQFpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 00:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKQFpn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 00:45:43 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DEB26D0
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 21:45:42 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9CBF53201B19;
        Thu, 17 Nov 2022 00:45:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 17 Nov 2022 00:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668663940; x=1668750340; bh=GJy6FS+1Qh
        6980bh/czrmy/3z7H1si+IY7izJj/VBug=; b=qQpAQwUbOfF+ugXbmKqlGGXMOX
        uwktFwvdRWle9ZnX+V9rqdHCBIPWGTDRNUSbuNItcE2EL/ZyUnna6pIhhS6z2GA3
        rZqa6xxNDbwDHYTVL/maxHutP5myl88kogvQPrkfBLUyOD5oMKVeSqeda04HT9qV
        ILnwIuK+H2D7PjOwFhVhOOtjNVaX7XPnzW9a9xT4VumGchUp+yC2tpFW5WEbDF8G
        WpZDZHhEpXdnWsWCpI3id7M4lX+23eddV9ENNJTMhanDtf7Pxn88cAad9Aq+g2RB
        fu5IqE+hbvPs8qtEAUpDaCZWw66I+ySp39Ho0PZ3gw0zadSqn8acf0hrF8fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668663940; x=1668750340; bh=GJy6FS+1Qh6980bh/czrmy/3z7H1
        si+IY7izJj/VBug=; b=UcD9IKpHZbgu+bYDDQmrF+lXOxEENmaOkvqtnAWPgM7k
        yBzzxh4giKnpl7HzYQl0RmW/T2k0SkqwSVn9RSvtzjzuj4lARdlZ15jqJ4iJugAI
        MgW5sdziEqtGsghY0qAUKGsPMpDiKMXe5Q1r8GGqpC+3CS5GRKDGKZt8LwutK71R
        GpghxOhd+F9P5h8vfPHYrb4oHtBI0n8gu5/CciF+iKM6cX6yXmTRkhi4aQTAQXUK
        Tt4ss3hAU/o7RYa8W7Cfef4HSEh9YbF6/7VHAdVSK1ZJeV9+NBTH1RLs/WA6sf4c
        r9jmOQaIzPRYSJkTMfMLjHDquhMiqr3zntxX0sTZ/Q==
X-ME-Sender: <xms:g8p1Y41Ygn19KnX253j6Opclafbmxm4SDcWv5hczJwVHm6VeFx5tMQ>
    <xme:g8p1YzF-ALxwI8GfylhfcvQKV3KZAsgwQ6D5tERbYVAeqo6JTAsGzcqWGuJbnFaXT
    q_m-_hw2eeKrJOKAA>
X-ME-Received: <xmr:g8p1Yw4ZIkiZvRJ0tTtKNNcA0SNAuCG2msba0KuJ2PSJLlh1xt2Lnwo9lqzMX_6BIR0A8ku_8OL5HUbzeVyxJ669iFB-3d_MlkPO1qbrVuzOy3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hMp1Yx2r0toIutQfAyI6eWXcQxZGR9tNLBitWX3xrgKK5rdOrwDgvQ>
    <xmx:hMp1Y7GtbpJ7VZJZ7rKY6zYoquuh-1DgKw7a0cTsoOD-B8MPdrhJag>
    <xmx:hMp1Y6-WP-d9c_jIg5OOz8x91e3a_Rc1-hAuDgec2M74wYkVH8YN6A>
    <xmx:hMp1YzCDvKtQUJ1NQIaXOz9SGMWFUvI36nQeoUXmL53BHXia78H3ZQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 00:45:38 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 41e36cd4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 05:45:22 +0000 (UTC)
Date:   Thu, 17 Nov 2022 06:45:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 0/7] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y3XKfrnmecgaHUU1@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
 <Y27KL0Yg7nzdQ+HC@nand.local>
 <Y3PLwW7krP0eJS6+@coredump.intra.peff.net>
 <Y3VUkKoKd8j7IW6T@nand.local>
 <Y3VeWvj6bTw1C3jP@coredump.intra.peff.net>
 <Y3VlKPFCLkFj188G@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MzXW+6jmwo+BLWTO"
Content-Disposition: inline
In-Reply-To: <Y3VlKPFCLkFj188G@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MzXW+6jmwo+BLWTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 05:33:12PM -0500, Taylor Blau wrote:
> On Wed, Nov 16, 2022 at 05:04:10PM -0500, Jeff King wrote:
> > > I haven't looked too deeply at what is going on here, but let's make
> > > sure to resolve this before graduating the topic down (which I would
> > > otherwise like to do in the next push-out, probably tomorrow or the n=
ext
> > > day).
> >
> > The issue is that some of the tests assume that hiding "refs/" should
> > produce no output from "--exclude-hidden=3Dreceive --all". But it will
> > also show HEAD, even if it points to a hidden ref (which I think is OK,
> > and matches what receive-pack would do).
> >
> > But because the setup uses "main" as one of the sample refs, HEAD may or
> > may not be valid, depending on what it points to (without setting
> > GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME it points to master, which is
> > unborn).
> >
> > So the fix is just:
> >
> > [...]
>=20
> Makes perfect sense, and thanks for looking into it.
>=20
> Patrick: it sounds like there was one typo in the earlier round which
> you may want to pick up also, assuming you reroll this.
>=20
> Thanks,
> Taylor

Thanks to both of you, I'll send out v6 in a bit.

Patrick

--MzXW+6jmwo+BLWTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmN1yn0ACgkQVbJhu7ck
PpQOKw/+P5aX3pBhcy0zWBEZ+H5UVBy6fQ+rdMutLzOGXda+HCq0y/1Dt4ZrtIzU
xmwln85+YW2GWL+P3Ri9wHc2cVniiywNvqKnVUHgZjojwUKOfXsgTEa5nOHJseDb
7vGUy/GEaKnkt0JVH0PxeQxYgXLRyczFktTS6azS49VtGMnh+kc08YgCO6mV/Wyo
BtGancumAkbg2snDn7EBoCcUoGK1kEBvIN5oOztbKGu4434lZl/0flC2Vez+2j5r
zMrTgPmv6/eXNPaWSraV9y+ymRIszwbP14S7vI2ljWhBDijfkEiMLBmDXOBkyhX1
WbpYPczW5Ta6elesB/xZe+AOMYTc7tk3Ga4LNoZqfVqY3wbPrW5qRFrn+k87l27v
j7XeLvYXJ1eMoEBNKDbM6AAKW1ebvif7jF9v0HPpF54qz81HqMf8DKI3SwSZ6obO
fFv60qkKX8dg4NPaQDQnrwkkTa1oAC/Wi9XD5pfYyequLPSCc7fNZnQg92hsXlGx
3WMc2Ehae9WsRhvQjgn+HTPSADdxwYr2MeCXT63oyBOfMhEG0H5wwuv6rrH49+Qa
5P2JeG+fiKQv8bbtupwtE0DK90NKVAEMYQtpacKeCXYyVmgjJr5sojz8w5rRs4OZ
HtmxtvwYIaSFwyebbTT2V2iCrCsTacuF2Cs33m3/AVUmIBxP998=
=hUiJ
-----END PGP SIGNATURE-----

--MzXW+6jmwo+BLWTO--
