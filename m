Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914F0C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 12:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiGAMHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 08:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiGAMHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 08:07:16 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF883F00
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 05:07:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3A1613200313;
        Fri,  1 Jul 2022 08:07:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 01 Jul 2022 08:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656677231; x=1656763631; bh=SLywCdTw5e
        PT6Y0jCRRcb/YT4t1BFS6cn7AlQKEPtQw=; b=OucIhLDs6ZQNA9g8tIRGaecDRW
        c3VRsxcb7/l5B5NJRlxL6uzjj3mM2S4QqfWUt81ep66URddW/ie19qOKmMdFKVvQ
        WTXBfTa2c1ZzHuRG4dTUXCTdbfrLJokn9wUzsLz0+/cO5V41mTycznBfL/McUEp4
        aWt1wvjQvCRURoesCCD3E4SXAVRGF92EZ3NdoTFnQrjmX1DGU/z9CRA/M0mUqCPM
        CBIZozuT98Z8UaCjyDWhGoImeaqvXSE1d/r9lLAYkgE/IcVBllbcvWQNr8HMv4FI
        Tga3PBUMrmM4VOUNsiZE7+W3Xq/jQAunCnh899aYzCjX4PcAIwaSwO0V2Hmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656677231; x=1656763631; bh=SLywCdTw5ePT6Y0jCRRcb/YT4t1B
        FS6cn7AlQKEPtQw=; b=pJJq5deT0Gh5ag3FcqB8JXo4Ptfwu5+sDUbKq2KKO7p7
        qHjO8Q7mFJjcw4r1kFXHX0oXEb4CYCwsqic1ZYecezaejryYknDruJimCWztUkUm
        hqJEbCNtdSJOwK/haaSybSjWIa7VwvoDyuUejh3NCef3jgXVqJzzFZGZ/3njuLfg
        PGvBZvbgXd4Ej2JOhWjjiSkc2xFerO2PMPn5Ih3bybb+W18OxaB8VV7PdSXAmdab
        NxeEoDFoJ+hdEU5lGnbEShgL1eU9UKdPfj8nrpwKmiXSlYprUNfedXdXGfLd28p4
        5lH4CHh8x2dXfhs7dACSv7toEMqEmcQmklnmJQjq1w==
X-ME-Sender: <xms:b-O-YhD_VcuBPlZA7VlB57Jl4w7mqBqAeLRYHw4y-LIrvtxTLTgHvw>
    <xme:b-O-YvgVfCFBJaz2tXqfsEAs8_eMXtPahcXDUIllYcz30D76UObiKmDPXL9VwW54Z
    TdKAXBI0P9AJv6QIw>
X-ME-Received: <xmr:b-O-YsmCkgVG-iF5Z8fQtE-uqJ3glMFQDR9xZ4MulGz_NR2i11g6QsaTRd9l6v-DxX_knZCf2oxEbkYxX-8Plp4I3UCgePXmKrmE8xU9V9IPVoWXgR6H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepiedvieevueegjeelhfejffdtgefgudehueeuheekueeiheeggfelgeehgefghefg
    necuffhomhgrihhnpehpvghffhdrnhgvthdpphhusghlihgtqdhinhgsohigrdhorhhgpd
    hgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:b-O-YryxESXimbSgjwTuxUCHi6ZhOMOaeJGFgNvUIDCAaApJDOfqCQ>
    <xmx:b-O-YmRZy8uO4DtxybgzhKbn5S0ho9GRJrHX8VakeZbsh3ZFjUW7dw>
    <xmx:b-O-YuaD-xjC0j9gtbmbSz-7HlUraIoAOjVAl_lgRQ2UtXEH-eePjA>
    <xmx:b-O-YpK4LlSv0QDRJsHFX3aQ8JO4lmIzfGQ4-tk5FjrwQvfnmKwA3A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 08:07:10 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3b510531 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 1 Jul 2022 12:07:03 +0000 (UTC)
Date:   Fri, 1 Jul 2022 14:06:59 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: commit-graph overflow generation chicken and egg
Message-ID: <Yr7jY6GjUkOzHNh6@ncase>
References: <YqD5dgalb9EPnz85@coredump.intra.peff.net>
 <581c7ef2-3de4-eb8a-bfbb-d4bca3522a2d@github.com>
 <YqEuE2iAmMVLlUSu@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c7wiZxghA6kfCQvO"
Content-Disposition: inline
In-Reply-To: <YqEuE2iAmMVLlUSu@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--c7wiZxghA6kfCQvO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2022 at 07:17:39PM -0400, Jeff King wrote:
> On Wed, Jun 08, 2022 at 04:08:03PM -0400, Derrick Stolee wrote:
>=20
> > I'd love to see the full binary, but for the sake of sharing on the
> > list, could you give the following output?
> >=20
> > 	xxd .git/objects/info/commit-graph | head
> >=20
> > or any other command that shows the first few hex bytes along with
> > their ASCII equivalents. Here is one that used Git 2.34.0:
> > [...]
>=20
> Interesting. My earlier email was a bit misleading. I do in fact have a
> GDA2 chunk. And looking at the timestamp on the commit-graph file, it's
> from May 24th. I hadn't been keeping the repo up to date regularly, but
> I did occasionally pull and rebuild. So I think it was a much more
> recent version of Git that built the problematic file, though it's
> possible it was carrying forward bad data.
>=20
> So 6dbf4b8172ef may be a bit of a red herring, if the file has a GDA2
> section that was simply ignored before that commit.
>=20
> Looking at my reflog, my best guess for the version of Git that produced
> the file is e46751e96fa.
>=20
> > However, the lack of the large offset chunk could be due to the bug fix=
ed by
> > 75979d9460 (commit-graph: fix ordering bug in generation numbers,
> > 2022-03-01). Perhaps that was the thing that was missing from your vers=
ion?
>=20
> So I _think_ I would have had that, though there's a good chance that an
> older version of the commit-graph file was written using a version of
> Git without it.
>=20
> > But otherwise, I'm stumped. I'd be very interested to see a repro from a
> > fresh repository. That is: what situation do we need to be in to write =
such
> > an offset without including the large offset chunk?
>=20
> Not exactly a fresh reproduction, but you can grab my broken file from:
>=20
>   https://peff.net/tmp/broken-commit-graph
>=20
> Dropping it into a fresh clone of git.git shows the problem.
>=20
> I tried a few obvious from-scratch reproductions like building a file
> with 75979d9460^ (so with the generation number bug), and then jumping
> forward to e46751e96fa (so bug fixed, but now we write GDA2), but
> couldn't get it to trigger.
>=20
> It may not be worth spending too much time on, if this is a weird
> one-off caused by a mix of buggy unreleased versions of Git. If real
> users aren't seeing it, and we know the nuclear option is "rm
> commit-graph", then that may be enough.
>=20
> -Peff

I have also repeatedly run into the same problem. I had already
discussed this with Derrick in the past in [1], but back then we also
declared bancruptcy and said that this seems to only be caused by some
weird in-between states of Git versions.

I have experienced the issue again in git.git now, again without having
a clue how I arrived at that state. The funny thing is that I explicitly
tried to reproduce the error in that repo a few days ago, without any
success at all, by writing commit-graphs with different Git versions.
Only today when I got back to it completely unsuspecting did Git start
to complain.

But more imporantly, we started to see the issue in one of our repos in
our staging systems as well [2], where we're currently running with a
mixture of Git v2.35.1 and v2.36.1 with a small set of patches on top of
them. None of the patches are related to commit-graphs though. The repo
in question is a pooled repository (like last time I reported the bug),
where the pool itself has a single commit-graph with GDAT chunks and the
pool member has a single commit-graph with GDA2 chunks.

I spent a lot of time today to try and come up with a reproducer to get
to this state from a clean repo, but again with no success so far. Also,
staring at the code for extended periods of time didn't result in any
insights.

This issue continues to puzzle me.

Patrick

[1]: http://public-inbox.org/git/Yh3rZX6cJpkHmRZc@ncase/
[2]: https://gitlab.com/gitlab-org/gitlab/-/issues/365903

--c7wiZxghA6kfCQvO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmK+42IACgkQVbJhu7ck
PpT2cA/9GBd0GcyWnP2prN84QJNp3fgVd9S2/pbcFTFKfVwuVy4PD94c3GcNeZYw
0R/irIxV4HB08ZjFqwqVwaPqpRfDMWZ1mOZUMMGGxUXdaUMoqBcOJDsffw5ZSMJH
NdREIwq0GzHA5vTHlqQej37BVJg/2/2grmQiCV7KvPA8tuPG/HS8kdnhryKNJKaT
TZ1OhbF5twLJ9dVle06ZXCAtEtE5bOHiHp4m471fLzr4j5PxHepixdm/1hLOImAk
d00Q+Y3tFwS0/NggCN5N68zadBZoYuZoO3IRQ8RTfdfewbNNetWMxq8sQKuDsyiI
gvfAQZUVFtjJgEZRJO2JcvK8gOpCiTvdpN7YRc6HGnJzV4QTSlIV2MfgZMdQqtCo
ZbmcF0oF9iETR8k48vN+n63oHkGZrNNHI+q89vwqQCrNu3Vc/Do7eYAQtj7RJoLL
mgCJc5wRyq8inwNA1/jBS8WGB8APZ2nrblgD6dPKhixQpeofA15N9tnEME4zWcnY
cPY5E5XwrtKkbELKJN+NzbJaXVjXWGWgwDNLlCbQorjPefT3sUPH4dl8QItWIMYU
xOSplwtBYF2XVf7rSfavT+H4RZQnn+YZbptZ/keQ+ccM/cSexreFFezIFDrZbpqS
/4QYascgH5e2d8ESz0lTK7ksJusHws12UV8k0b4Rebt+DJFvkbI=
=fndp
-----END PGP SIGNATURE-----

--c7wiZxghA6kfCQvO--
