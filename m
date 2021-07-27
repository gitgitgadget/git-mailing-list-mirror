Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F22C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 06:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E030560551
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 06:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhG0GLG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 02:11:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57051 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235390AbhG0GKy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Jul 2021 02:10:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3BAA15C01A0;
        Tue, 27 Jul 2021 02:10:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 27 Jul 2021 02:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=5DeaBupPNUZA3uA0+AVPn+Wu9V/
        rKpgDUYYygdzTG/g=; b=lDK02lWy6fWogN37N5eobJ3n7uEnjNN8S6sArxDFmm8
        t0j1Y5A5MYz+YopK+F9KkRqasncLGH+u7XyTuRRWhIrVhFUt5L1PY3eOzmbE20OG
        mhZ+jV2eaMlnMYvlxmPSvldM5mAUn40QgbUmI/uzResB1LJcNIjtOCfcFoVxB39d
        qVVExuAoAZi9o+C1Q7Deu9kxArTdIZ1OOZFNheblx7iM7SuYzwKoHo9OBbr3bTKT
        +bMVYOyOkL7DMZCP4ZBg+OLKu9qv8kfTzKNAvUNSgMchvmPBVvsmclm8lAjf++cI
        kBmaHLru91LA9bEowcpAM8wppmsHcWxfAJoWcCCKuNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5DeaBu
        pPNUZA3uA0+AVPn+Wu9V/rKpgDUYYygdzTG/g=; b=CruQAig1g/Ryao/5BJEaP4
        V5yVTN2lIosXDOM/5VPSzkKDiZquqRuqWuLAj9Ktzyk8BlKyL4TwpntagGYpy9zS
        wc8cvOeH266fHXJtH0LB/Reta3oQhJ6yPJ4rsqP2EFMiRcNSZ/nPNbaJEX2i47/R
        yuiFw/Qz4PdRYWFkUr+WlVow7isreFqGKSw/uyIxvzY2V37u+BqhBTgbIXoiDsui
        fehcTxMdzxmC7HwtFdLpxa5xd05sP++ZdA8QXs2AQL+8fg/JSF8pNFqAPWVbZmiU
        PY3fyzctB6b15Yf+FmkKBHIeZXIEw597DUicWkjH3AtsIXfUzhiLHGYhmZC8wwXQ
        ==
X-ME-Sender: <xms:baP_YCycHzh3l9jsjY_UMb1qtyDu-tKs9CQ6-5aRfMSdSoUYLgNHVg>
    <xme:baP_YOQiS7SgoJOL0iBKMHaFG6AFvtfaRIHIy4wfhU_OZ_VkXAItYx3ECWRotoGZz
    Bqeoencp_ZgUbGBoA>
X-ME-Received: <xmr:baP_YEUL5x7JoXZwrCjr4nJZLjzwHdHPeYbOBTqT6ikBM412X_lr_Z6CngEjaJZeNJ62jLr9dYp6pvc2C6UXPhziTKGhhID5EMRtAu8YYz3vQE_yiDdWBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeeigdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejjedtiefggeekgfejheevveejjeevuedvtd
    eikeffveelgeelhffggfejjeeffeenucffohhmrghinhepghhithhlrggsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:baP_YIg2_zoLUfMebPRLBBLipi7wB1pzhKcZ2LBrI7QloegEzPoI5w>
    <xmx:baP_YEAsTNveu8SzpkAD7SS7wOkk8ulcuqIxz6UwVkXhRrLFlz2dRw>
    <xmx:baP_YJLzFpuBwNnIN7AbvzLc1-Yrjawshm51-CV11X_NAADNCl7Pag>
    <xmx:b6P_YD5hf079oNskydkb3IliMQ_ndHgiSlVAiucJXu6mNz4qbY7nYw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jul 2021 02:10:52 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9a1daa05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 27 Jul 2021 06:10:48 +0000 (UTC)
Date:   Tue, 27 Jul 2021 08:10:47 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Patrick Steinhardt <psteinhardt@gitlab.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] revision: allow pseudo options after --end-of-options
Message-ID: <YP+jZ/slM0MzmLF4@ncase>
References: <20210708150316.10855-1-worldhello.net@gmail.com>
 <YOcvaFL7+6qcIOUa@camp.crustytoothpaste.net>
 <CANYiYbGYzbMoU_2wb4duppASoYUjGLsJsr692Xe3GaVBOXUsBA@mail.gmail.com>
 <YOoXCJV2ssef/KsN@camp.crustytoothpaste.net>
 <YOyByjmGu1oDXK4X@coredump.intra.peff.net>
 <CANYiYbF3dcOzZ5gqbYkstxv+WRxZwnoxoNP28A6px44YD98k1Q@mail.gmail.com>
 <YO4CBKuwCEL4Xdzg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yt/GU70P0fUxO874"
Content-Disposition: inline
In-Reply-To: <YO4CBKuwCEL4Xdzg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Yt/GU70P0fUxO874
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2021 at 05:13:40PM -0400, Jeff King wrote:
> On Tue, Jul 13, 2021 at 04:57:46PM +0800, Jiang Xin wrote:
>=20
> > > Though in my experience it is usually a static "--not --all" or "--not
> > > --branches --tags" or similar in such a function. I don't think I've
> > > ever seen a case quite like the code above in practice.
> >=20
> > Last week, I made a study on how gitlab wrap and execute a git
> > command. I saw the following code [1]:
> >=20
> >     if c.supportsEndOfOptions() {
> >         commandArgs =3D append(commandArgs, "--end-of-options")
> >     }
> >     if len(postSepArgs) > 0 {
> >         commandArgs =3D append(commandArgs, "--")
> >     }
> >=20
> > I was surprised to see the options "--end-of-options" and "--" used
> > next to each other, and the DashDash option ("--") is not mandatory.
>=20
> I think using --end-of-options there is pointless. The "--" will always
> signal the end of options (_and_ revisions). So if there is nothing
> between the two, then the former cannot be doing anything.

Indeed it is. I somehow missed your Cc (not used to receiving Git ML
mails on my work address), but by chance I fixed this last week because
I realized this was broken. We've now moved the `--end-of-options` flag
between positional arguments and flags like it should've been from the
beginning [1].

[snip]
> > But if I move the "--end-of-options" before the revisions like this:
> >=20
> >     git log --stat --pretty=3D"%m %s" --no-decorate \
> >         --end-of-options \
> >        topic1 --not main release \
> >         -- \
> >         src/hello.c doc
> >=20
> > The generated command failed to execute with error: unknown revision "-=
-not".
> >=20
> > It's reasonable for gitlab to construct git commands using mainly three=
 fields:
> > 1. Flags: for options like "--option", or "--key value".
> > 2. Args: for args like revisions.
> > 3. PostSepArgs: for pathspecs.
> >=20
> > And if the command supports these options, it's better to add
> > "--end-of-options" between 1 and 2, and add "--" between 2 and 3.
>=20
> Yeah, so the problem there is that the definition of "Args" is kind of
> fuzzy. Sometimes it is useful to include stuff like "--not", and
> sometimes it is dangerous or unexpected. Later you say:

Yeah, this is something that has been bothering me, too. It would be
nice to give special treatment to pseudo-revisions in git. That's why we
have now marked git-rev-list(1) to not support `--end-of-options` in
Gitaly, because we do pass pseudo-revisions to it in multiple places.

Patrick

[1]: https://gitlab.com/gitlab-org/gitaly/-/merge_requests/3676

--Yt/GU70P0fUxO874
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmD/o2YACgkQVbJhu7ck
PpR7GBAAgZBX7zJ5ZmqvH2cu+ws/zg2jFVVPQj3tiH77tI4E3QxnW5SoAVIHSEIf
l0FJZDM/GvfvD0D1LUUuvVVVVVBnep49J6wTfkQArQKloQj0/vv+lT/pRsgcCoU8
eoog3aEFbioXB10ibtUFQsZOJOfTl9CrMaX91Itmy5G/WrNcGX2B1n/ayf64CHGq
XbgOefSVCmbP6v7gw+aZXZkj0z7UorK1y2BnXdr3UKb+W8J0Tdcq6Hlj1gn8Pn6z
LoExf1PUG4Nyr1yH0faiUd9WiSjr8DOXIUhxfXfg/GHVgZ0of8IxDgeXDyZun4PA
RyybCA6SUc03lSLZtY/FwiQC5xa4FUXT8hfcXaoLlsEIWm7wM7SqnITUXcyz6+39
bncv4EpiAM7SBo3G2iH1pz9aJsEgLdx9IbLg7tAmh7BY6U+FEKyg6QTkEVDM2Rx5
LNvGLo7gym+yNNNru8LYwDLMiBtdFxwcO/aJQy7r9wIb2hjyjzTyPqlVtk45pvgT
mmOAtkpKdTytflgE7m8i84lnuVVCUvHWNz1TZMAbNsvGzK2rwVU/0Do8H7B6xYu+
4m9QGi5gknKtTKex8C4tmaft+N8rdTRo82MHFBq54L9N1AniCdEoj0CY5Oprpvmv
nnw8kLuCKJbn/kjC3T7OmGXiJNvS70bg1oeM8l4RJFEg/GLuEmQ=
=J3JE
-----END PGP SIGNATURE-----

--Yt/GU70P0fUxO874--
