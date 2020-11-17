Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF45C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 06:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965AF2467B
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 06:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MRpcsB8j";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3jO63Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKQGhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 01:37:40 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58665 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgKQGhk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Nov 2020 01:37:40 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DDC765C01A9;
        Tue, 17 Nov 2020 01:37:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 17 Nov 2020 01:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=+c+LP3VApLXTu9K4Dml09tGb1WT
        bv3ayRnDfrYjOOOg=; b=MRpcsB8jkRBSLZL+UpUCHAIYShMc5pHnGuuxdFWXj92
        JQ1Ka1FeUQKtjn8PpWELNBdzN1wb8vDLLzTom3Bvtoi/+JszNGI0jw7mR04N9Vhp
        RRe32xA7a0JExoa3H0kmQzyu/br3hvWAnwbx5ux+AR7WHQfUHIuub/bz4jdNtVLq
        SajcbwxLqbXMB4Tq0vI6sYFf9AEndBDuGEK8+e3jCoTMw1lls7VvnWgPoSQzgmhY
        KaeYhiA/vl6U0OQr45R53qR11JsBdA0McYRm+n7KNmRJKbrceWcmD3/GPhnFgRVF
        QYDsIcfMD9XeMlxCh0XnIxZqDlFAYL9ddgXGDMn6AzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+c+LP3
        VApLXTu9K4Dml09tGb1WTbv3ayRnDfrYjOOOg=; b=b3jO63Fbg6bqmErIiPu586
        FfQZkZy4nZ1+CoGQ9gY91BQJ0cULaxTqJU95jfoiyvuUWkGbj1jfEGEjTZ6yBrU1
        g67iFxDf0lobSqbi9X2S+DMFcDPBpfqyxoWkawEx373D43pFoLTIOQtVNtQ5Vu4q
        /3t7T6A32KvlZxoAZRwkDV8iw1fudXMQcjEfhWY2XhfAQa2+ZtonLgQ/1OZwqPQJ
        aMCi7V38ftYtzyLaTQNrgfrHCAFmWumt70eZVXWBysLjqBcvAGMmdgbzrA5m0Y7E
        kBI1G0CFhm8qfLNQE2PZl0mlJqIasG5Xna2E4KlgmvqZ1g7+Gl5+P/SatcP7uNkw
        ==
X-ME-Sender: <xms:sm-zX_TUkkEz4iDxFDegRwQdPRK5tJWfBADZoEv0MoIzND7hJGCjmg>
    <xme:sm-zXwwAvgdYS02e4Z-D9ST3w2x3qaCJs7Jo-GH_Xmwi1K3A4thCNc1RmmIlm-I5E
    rwMNvXA1A2gyXoSBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefvddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledrudegrdefuddrfeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:sm-zX00lYWr__FyR-Y6IHtq8cVLXidQcRx4jsgOdUvVPQAVu-YxWgQ>
    <xmx:sm-zX_B7vwCe34xpv1peeej20c500NRrrlJ8CnaxPL7WDitclGY0Kg>
    <xmx:sm-zX4gpZfhxVg33K6kNSeDgRw0QmmJAxMAGrcm1iEiWoOFm-gA1qQ>
    <xmx:sm-zX0YVsBuC_D9Vd2IadKuOojXfcyKuYOOT6taNn3VeCvRHLPurfA>
Received: from vm-mail.pks.im (dynamic-089-014-031-035.89.14.pool.telefonica.de [89.14.31.35])
        by mail.messagingengine.com (Postfix) with ESMTPA id 95F5D328005E;
        Tue, 17 Nov 2020 01:37:37 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f60fabb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 17 Nov 2020 06:37:35 +0000 (UTC)
Date:   Tue, 17 Nov 2020 07:37:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <X7NvrmisOs4g036W@ncase>
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
 <20201117023454.GA34754@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9jUQOTv9+z76IqdJ"
Content-Disposition: inline
In-Reply-To: <20201117023454.GA34754@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9jUQOTv9+z76IqdJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2020 at 09:34:54PM -0500, Jeff King wrote:
> On Mon, Nov 16, 2020 at 11:39:35AM -0800, Junio C Hamano wrote:
>=20
> > >> While not document, it is currently possible to specify config entri=
es
> > >> [in GIT_CONFIG_PARAMETERS]
> > [...]
> >
> > "While not documented" yes, for sure, but we do not document it for
> > a good reason---it is a pure implementation detail between Git
> > process that runs another one as its internal implementation detail.
>=20
> I have actually been quite tempted to document and promise that it will
> continue to work. Because it really is useful in some instances. The
> thing that has held me back is that the documentation would reveal how
> unforgiving the parser is. ;)
>=20
> It insists that key/value pairs are shell-quoted as a whole. I think if
> we made it accept a some reasonable inputs:
>=20
>   - do not require quoting for values that do not need it
>=20
>   - allow any amount of shell-style single-quoting (whole parameters,
>     just values, etc).
>=20
>   - do not bother allowing other quoting, like double-quotes with
>     backslashes. However, document backslash and double-quote as
>     meta-characters that must not appear outside of single-quotes, to
>     allow for future expansion.
>=20
> then I'd feel comfortable making it a public-facing feature. And for
> most cases it would be pretty pleasant to use (and for the unpleasant
> ones, I'm not sure that a little quoting is any worse than the paired
> environment variables found here).

I tend to disagree there. As long as you control keys and values
yourself it's not too hard, that's true. But as soon as you start
processing untrusted keys or values, then it's getting a lot harder.

E.g. suppose you create a fetch mirror for a user, where the source is
protected by a password. We don't want to write the password into the
gitconfig of the mirror repository. Passing it via `-C` will show up in
ps(1). Using GIT_CONFIG_PARAMETERS requires you to quote the value,
which contains arbitrary data, and if you fail to do that correctly you
now have an avenue for arbitrary config injection.

That scenario is roughly why I came up with the _KEY/_VALUE schema. It
requires no quoting, is trivial to set up (at least for its target
audience, which is mostly scripts or programs) and wouldn't show up in
ps(1).

> > I especially do not think we want to read from unbounded number of
> > GIT_CONFIG_KEY_<N> variables like this patch does.  How would a
> > script cleanse its environment to protect itself from stray such
> > environment variable pair?  Count up from 1 to forever?  Run "env"
> > and grep for "GIT_CONFIG_KEY_[0-9]*=3D" (the answer is No.  What if
> > some environment variables have newline in its values?)
>=20
> Yeah, scripts can currently assume that:
>=20
>   unset $(git rev-parse --local-env-vars)
>=20
> will drop any config from the environment. In some cases, having
> rev-parse enumerate the GIT_CONFIG_KEY_* variables that are set would be
> sufficient. But that implies that rev-parse is seeing the same
> environment we're planning to clear. As it is now, a script is free to
> use rev-parse to generate that list, hold on to it, and then use it
> later.

Good point. Adjusting it would be trivial, though: unset all consecutive
GIT_CONFIG_KEY_$n keys and potentially also GIT_CONFIG_VALUE_$n until we
hit a gap. The parser would stop on the first gap anyway.

Patrick

> -Peff

--9jUQOTv9+z76IqdJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+zb64ACgkQVbJhu7ck
PpSCPA/+JzQ7XH34aSRcG5AsvjE7594RPUyw4yQ1CES6S+n4vhuFvDSOXAt6pp/C
8JZlGGOQddfuUpSXo2LQl+Xp8kffRX86Z21+QpXphXnGsbCN3++ol50pFK1j1Qbb
tFVvE2Gc8JTpj9gVCjQtPQ+aQgfZzgKMTO/JY1shqb/32yKhvHam88Shw4Na/mZj
lGZyzyXdoAtGr+KA7TLuBb0Sus9GYCaLvwaTMycsaZAtAi85jyVQGXV0F0Vo4J9y
W/FGxWE22Xl9LM7tlv2ML87lnuLLyo2HrNbUTkmVNzmJjJE3k3ExRjmbZjBH/fjg
BHfduOkiLs9mLTSYuCvEY04i/uS2x3lHZyvfHxKSjhif4mOf7e2DISksSUk5WzP/
AVHt7QVL2v2CtMUnrwuVEs0M0CKr1wC0DXcBuumWWOxDRd7rgz1DF3LyjP0F05+6
c1wdTeuds6HbEXlqJR++amL5nfkft4YVUxg9Dd9dF+r2OFGV4aHKKl8ZcY/h5VAE
M36ftSB//sSHngrQ4XUi02EfjO7Igt6H8sc+zSH16xmDky0eXh8iTMl5H4FxQjVt
spzJAzpcD3d1IPMc1HdMh0MRQKzh2u3v0H0yg/W5y1CnTCKjfZB3tOhBU4/i8caC
RrB//r1zBCQOJoe5GMSwNJxge0Uytsof8tLDjMIrODqZv8zZBsQ=
=jHlu
-----END PGP SIGNATURE-----

--9jUQOTv9+z76IqdJ--
