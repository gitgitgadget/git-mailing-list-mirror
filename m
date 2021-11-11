Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DFEC433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 11:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9D961261
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 11:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhKKLux (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 06:50:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45935 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230358AbhKKLuw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Nov 2021 06:50:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 90CE55C0083;
        Thu, 11 Nov 2021 06:48:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Nov 2021 06:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=fB0G0RR5UNWjm9CMgjyFHK1EsPd
        7PhCMS3hX6HSJfvc=; b=NlabyCBY672RNXrjHASjJrNmT9x1b+b4L2WM6+0DfSS
        M9sNh+teYuQIpaCnD+aLA8YmCx7zg4jZrnIfk6bWg/vLOfNKEdO9blYomaXowPxb
        plvAOtd/LcH4FDuyhzVKO4QAoLrRlZMKkRy5uVSENSvb3J6Y7bZfQr6+ihyXCll5
        Ixz2QmfT3MVkCwQqobz/5rRzLw22eZDdpHCfYli9u0/NHnET+hLgnTHpJqrR3nI4
        6c+yiqrBQN0G4qSxqzbUs4UdKuSQT6lktuqFb/7NE8QsDNyU125biCiME2jOaNjo
        oG0Ro5Iq3fZsrXV/3sBORe6rwKxuKtD1nno8qxlZrvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fB0G0R
        R5UNWjm9CMgjyFHK1EsPd7PhCMS3hX6HSJfvc=; b=a1fF/l0LKKBcXixx5crO0P
        ZTE7q2tqrxDz2Ibgf32RhxXt16SCiyMfE71UMm+BfOUJv3feQ/gakhmsW6pzbF3b
        QyGiaJB0+ZhOJVo5sssp6o2C4FH6EcgURPF9WkaXbHbQ73129l1Bbvivtu9lHKqX
        WiLLzSjkKR/aBloKkNg67p1j4jLtrl/4E0N8NjuZauvkygrYeIGapYIyldKpqFDL
        ulN5k/c4QOUWTfb78yfmhd7t4QIWBb4oqqMxkjfI+Geg8YTGoPQvmNUzVOvukqYs
        lPgynAcJYxl5wJy1tAqnHApIx9Yh2q1/LoLVGj5gMbXLR8Wf8Fsq7Czk81oMc0og
        ==
X-ME-Sender: <xms:8gKNYRjIowKiZtQveIOICAGZGLwr1wkBo_RofhBry2rxfhWg3en0yw>
    <xme:8gKNYWDel9PTJ7Gl3gWHRlvUQyh2CZLURhRBsmIZfbg8YeodatbUB1GD3vGk67n4g
    EbYch6TgzFybHoqSA>
X-ME-Received: <xmr:8gKNYRFHVMH6N6XCqy08uJ9A48Xpa9O5ye5vySmTYMoFDjvQgZ_VxqI7dhagrETtj7HR9ChWClNwadBrnSgbNfaTEx9-390qtlHyy6dAM8qBVEg1SSL_PLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvddugdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epueeugfefvdetffeuffeufffhtdeutddvgfelhfelueeiheffheethfetgeettedunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:8gKNYWT0So8YHDv8-5Wlph9sE1UZ-GKG5Rwvvs1tv-R1-jOkjqq1xQ>
    <xmx:8gKNYeyq75rKO-U8N_jx8R0ONT7cTiIYu7SnGe5Sa9MVPhNA29CWyA>
    <xmx:8gKNYc5qEgb9p6J66VQfdhKp0l_77VeggtX2w0mT_neLYOM55oGmEw>
    <xmx:8gKNYVp4YaP6SdVScqy9ewQPLUkYGAuVb2tRFqVy502Hs2wUi4q4RA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Nov 2021 06:48:00 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1115ee12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 11 Nov 2021 13:32:31 +0000 (UTC)
Date:   Thu, 11 Nov 2021 12:47:36 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/3] refs: sync loose refs to disk before committing
 them
Message-ID: <YY0C2ES1aGpSAW4v@ncase>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
 <YYwvVy6AWDjkWazn@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yXe3BaUZ96jagLSQ"
Content-Disposition: inline
In-Reply-To: <YYwvVy6AWDjkWazn@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yXe3BaUZ96jagLSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 03:45:11PM -0500, Jeff King wrote:
> On Wed, Nov 10, 2021 at 12:40:50PM +0100, Patrick Steinhardt wrote:
>=20
> > Please note that I didn't yet add any performance numbers or tests.
> > Performance tests didn't show any conclusive results on my machine given
> > that I couldn't observe any noticeable impact at all, and I didn't write
> > tests yet given that I first wanted to get some feedback on this series.
> > If we agree that this is the correct way to go forward I'll of course
> > put in some more time to add them.
>=20
> Here's a mild adjustment of the quick test I showed earlier in [1]. It
> uses your version for all cases, but swaps between the three config
> options, and it uses --atomic to put everything into a single
> transaction:
>=20
>   $ hyperfine -L v false,true,batch -p ./setup 'git -C dst.git config cor=
e.fsyncreffiles {v}; git.compile push --atomic dst.git refs/heads/*'
>   Benchmark 1: git -C dst.git config core.fsyncreffiles false; git.compil=
e push --atomic dst.git refs/heads/*
>     Time (mean =C2=B1 =CF=83):      10.5 ms =C2=B1   0.2 ms    [User: 7.8=
 ms, System: 3.9 ms]
>     Range (min =E2=80=A6 max):    10.1 ms =E2=80=A6  11.0 ms    108 runs
>   =20
>   Benchmark 2: git -C dst.git config core.fsyncreffiles true; git.compile=
 push --atomic dst.git refs/heads/*
>     Time (mean =C2=B1 =CF=83):     402.5 ms =C2=B1   6.2 ms    [User: 13.=
9 ms, System: 10.7 ms]
>     Range (min =E2=80=A6 max):   387.3 ms =E2=80=A6 408.9 ms    10 runs
>   =20
>   Benchmark 3: git -C dst.git config core.fsyncreffiles batch; git.compil=
e push --atomic dst.git refs/heads/*
>     Time (mean =C2=B1 =CF=83):      21.4 ms =C2=B1   0.6 ms    [User: 8.0=
 ms, System: 5.2 ms]
>     Range (min =E2=80=A6 max):    20.7 ms =E2=80=A6  24.9 ms    99 runs
>   =20
>   Summary
>     'git -C dst.git config core.fsyncreffiles false; git.compile push --a=
tomic dst.git refs/heads/*' ran
>       2.05 =C2=B1 0.07 times faster than 'git -C dst.git config core.fsyn=
creffiles batch; git.compile push --atomic dst.git refs/heads/*'
>      38.51 =C2=B1 1.06 times faster than 'git -C dst.git config core.fsyn=
creffiles true; git.compile push --atomic dst.git refs/heads/*'
>=20
> So yes, the "batch" case is much improved. It's still more expensive
> than skipping the fsync entirely, but it's within reason. The trick,
> though is the --atomic. If I drop that flag, then "batch" takes as long
> as "true". And of course that's the default.

Great, thanks for doing these tests.

> I wonder if that means we'd want an extra mode: do the WRITEOUT_ONLY
> flush, but _don't_ do a HARDWARE_FLUSH for each transaction. That
> doesn't give you durability, but it (in theory) solves the out-of-order
> journal problem without paying any performance cost.
>=20
> I say "in theory" because I'm just assuming that the WRITEOUT thing
> works as advertised. I don't have an easy way to test the outcome on a
> power failure at the right moment here.
>=20
> -Peff
>=20
> [1] https://lore.kernel.org/git/YYTaiIlEKxHRVdCy@coredump.intra.peff.net/

Yeah, it's also one of the things I'm currently wondering about. I just
piggy-backed on the preexisting patch series which claim that it at
least ought to work on macOS and Windows, but left out of the equation
were Linux filesystems. I'm hoping that we'll get an answer to this
question via <211111.86pmr7pk9o.gmgdl@evledraar.gmail.com>, where =C3=86var
put Linus and Christopher Hellwig on Cc.

In any case, if the outcome of a WRITEOUT_ONLY flush would be that we
may not see all renames, but that every refs' contents would be
well-defined, then this is a tradeoff we'd probably want to make at
GitLab.

Patrick

--yXe3BaUZ96jagLSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGNAtcACgkQVbJhu7ck
PpQOURAAp3LvbXRZnimF8VKTPCiaOyeeN/OuwqhkSOFDORHAPFiB4UC5HnqnqfTp
WhhlIgQvWIAtMsl5aNGQFa5/q693lAJkDVto9L9odG2OFUpNZcXFMJ9AiTxPA8OX
yFLbys+eUhfXQG2w5LRbh2tSmyNmeokqZO4sapShg+yIBsAWZjcvuqXancOFC5Jm
gUwDSstpA/dC8kNJv+H/kOdpIyuemcoln6YevNq5iiujTyO+IgWnKHlp1qjPHj4V
l028H3NlyNpHFIndjLvpOdAXSdnr5GhzFTiFF5kQVT5jz7eHmqfiFBfO3l8povyi
OZNi0nlG0m8bIazbCGL3SQFRGtNZAlVAZMxThzRxAX6Rxp3tYfPvm4udpSo5+4If
8pPtRhPiJHmE5z0N2AyXLk65UQISfYXCbM8IeaqDyvkTRptccXWQJCC9hdho8THQ
U06pG6YTIi9rLfy9AhqNrvxdm6eRLpjPnoAM0VJsQMbq2mpkvYnAbD7gGKRXMPQk
5inSNF37Rf7WQq6vxWSzmLm6Gm5uN6A8NB3mP1MkMvIPmn3uZADvb3BcIyK7XJYU
zNZ4xtIKoKikRRRvQfEI4vcu17ieiBwwvtM9wSkPgItJebFRsPHigkQMUgsfA021
/jPckXs8sicKVJcZ0D/fPGiovRvvZAFUiM4RpvPbrcHCKsxUEkg=
=+V9v
-----END PGP SIGNATURE-----

--yXe3BaUZ96jagLSQ--
