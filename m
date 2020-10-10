Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF7BC43457
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383262075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgJJW4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:03 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39369 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730330AbgJJSv2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Oct 2020 14:51:28 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BA06C102C
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 14:38:48 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute1.internal (MEProxy); Sat, 10 Oct 2020 14:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sudoforge.com;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type:content-transfer-encoding; s=fm2; bh=Nou3B
        off7NnsJnJhNOAguTxZnaDsSL2IxnYttUXkZEw=; b=grHGh29zckoAWhonctZuX
        NwT6JWzWiZlThSqB7vi2S93vvhqfmK1QTF7M2ZXvaPGwHYbyDp7L1u4YisJj4Qeq
        xGQSSPoloPfVf8eS5KFgTZ7rKxswsTZebeWs9j+PO9smPSXaBdGPEwW9RaeCSTl6
        FBIkWamxakr+Wft5yEh7P1k10Fl4XcZ0g6S2QDmiHoTqAM+yFqS3ckzm6NHv6cZE
        8kIqoXisb9Rvkj9ylJAmUcjcJAOiirhoMZUjt2N0BszbPcA4NvTz48lZGWaLRXQl
        5ZklWL0LU1m+vKS0dLzwtVdEZ0mVPuPH/KGmydlTm1h6t+fW0xaPO3fAdZZmUFtN
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Nou3Boff7NnsJnJhNOAguTxZnaDsSL2IxnYttUXkZ
        Ew=; b=foN2R7ecZ7KuJ4XbscaVaOHeKmMhkctaiWe0Itg4Ic7917RwUuclcjtzt
        LKI+yU8zzvTADF8jmxg7EcZMuopvREcQ3IBJp9sM/4P7A6oQSGOQzbXxNYeJg0av
        Qf0PlNy2/2UMt8uP9PcE1x6AFJecpSiGX9qqWEegYhGhSFllPjiV/kpz4dsht/Uc
        6QrzgiFY9bRcJCZWJ9Y52z6T4RQKIfhWLDDjI+HphszPaPDGEW7xSDpwas8m6Dyy
        jdrAagdw6o1rDRd1+yObAlfW4tbeElDhbp4ywSQXFbEWAo8iE5ZPhFG+mzLtitIc
        wCQ6FGfK68DOAAFe/+0v3r2K7MmNA==
X-ME-Sender: <xms:uP-BX0lRJT3ZhRElWNc1lFSOOAEZOQJN2OIQGoBId5EmU52TRyEing>
    <xme:uP-BXz1OLRWIuVqvtDyi_G6f9HkmMtM0N1jT6Sof7EzM6ejL5OqoF-VTsI3TvRzwY
    w8H8z-4e0HXAh5ubA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheefgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtgfesth
    hqredtreerjeenucfhrhhomhepfdeuvghnucffvghnhhgrrhhtohhgfdcuoegsvghnsehs
    uhguohhfohhrghgvrdgtohhmqeenucggtffrrghtthgvrhhnpeefteetudegheffteevtd
    ethfeghedvvdejkeekgefgjeefheevieduteeuteelkeenucffohhmrghinhepfhhoohdr
    tghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghnsehsuhguohhfohhrghgvrdgtohhm
X-ME-Proxy: <xmx:uP-BXyp2MbbLzJPNbjyqniyDbnpO5dTdv2PgcCe6R6bcEg_psKmJuw>
    <xmx:uP-BXwl41KJYpAgZNUdz9dnxiZoUX_-_zHX1bHGxkxMSl5ft6QLu4A>
    <xmx:uP-BXy323uo7DPYlAci01SgvXwpftWEUyrOtlYMijxz6zGVKjgSD7A>
    <xmx:uP-BXzA8KbK5clCYB96Ey2iQu_Dj7-lOYzO7Ony4N8MDwnOp5ZD2PA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C2507E00D8; Sat, 10 Oct 2020 14:38:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-407-g461656c-fm-20201004.001-g461656c6
Mime-Version: 1.0
Message-Id: <77a13a76-89b2-4fd7-91d8-1b9e47a5bc37@www.fastmail.com>
In-Reply-To: <dab3f28e-1a4b-4756-9a50-a5804b438804@www.fastmail.com>
References: <dab3f28e-1a4b-4756-9a50-a5804b438804@www.fastmail.com>
Date:   Sat, 10 Oct 2020 12:38:25 -0600
From:   "Ben Denhartog" <ben@sudoforge.com>
To:     git@vger.kernel.org
Subject: Re: Unexpected behavior with branch.*.{remote,pushremote,merge}
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a small typo that I didn't catch here -- `branch.main.merge` sho=
uld be `refs/heads/main` in this example. Rest assured this is not the s=
ource of my issue (the actual repository I used for this still uses `mas=
ter` as `HEAD`)

--=20
  Ben Denhartog
  ben@sudoforge.com

On Sat, Oct 10, 2020, at 12:27, Ben Denhartog wrote:
> I have a few repositories on my system that exist primarily as local=20=

> copies of remote repositories, in that I normally just want to track=20=

> and follow the upstream project (however, I periodically contribute=20=

> back upstream so they are technically forks -- origin is my remote,=20=

> upstream is theirs).
>=20
> In these repositories, I set the following configuration:
>=20
> ```
> [remote "origin"]
>   url =3D https://git.foo.com/me/bar.git
>   fetch =3D +refs/heads/*:refs/remotes/origin/*
> [remote "upstream"]
>   url =3D https://git.foo.com/them/bar.git
>   fetch =3D +refs/heads/main:refs/remotes/upstream/main
>   tagopt =3D --no-tags
> [branch "main"]
>   remote =3D upstream
>   pushRemote =3D origin
>   merge =3D refs/heads/master
>   rebase =3D true
> ```
>=20
> Based on my understanding, this should effectively force my local=20
> `main` branch to track against `upstream/main`, but push to=20
> `origin/main`. I notice some odd behavior when fetching, primarily tha=
t=20
> FETCH_HEAD doesn't resolve to `upstream/main` as I would expect:
>=20
> ```
> =E2=9E=9C git fetch --all
> Fetching origin
> Fetching upstream
> remote: Enumerating objects: 23, done.
> remote: Counting objects: 100% (23/23), done.
> remote: Total 32 (delta 23), reused 23 (delta 23), pack-reused 9
> Unpacking objects: 100% (32/32), 12.97 KiB | 949.00 KiB/s, done.
> From https://git.foo.com/them/bar
>    63f7159..e65b80e  main     -> upstream/main
>=20
>=20
> =E2=9E=9C git status -sbu
> ## main...upstream/main [behind 9]
>=20
>=20
> =E2=9E=9C git rev-parse HEAD upstream/main origin/main FETCH_HEAD
> 63f71597979edb16cb9f80d0431115e22dcb716d
> e65b80edd2a2162f67120a98e84bb489f15fcf97
> 23e6881719f661c37336d9fcf7a9005a7dfce0cf
> 23e6881719f661c37336d9fcf7a9005a7dfce0cf
> ```
>=20
> As we see from the output, `FETCH_HEAD` is resolving to the same commi=
t=20
> as `origin/main`, when I would instead expect it to resolve to the sam=
e=20
> commit as `upstream/main`. Here are the contents of `.git/FETCH_HEAD`=20=

> in its entirety:
>=20
> ```
> =E2=9E=9C cat .git/FETCH_HEAD
> 23e6881719f661c37336d9fcf7a9005a7dfce0cf        not-for-merge   branch=
=20
> 'main' of https://git.foo.com/me/foo
> e65b80edd2a2162f67120a98e84bb489f15fcf97                branch 'main'=20=

> of https://git.foo.com/them/foo
> ```
>=20
> Curiously, `git rebase FETCH_HEAD` seems to think the local branch is=20=

> up to date (erroneously), however `git-pull --rebase=3Dtrue` and=20
> `git-merge FETCH_HEAD` both work as expected and merge/rebase with=20
> `upstream/main`.
>=20
> Am I going about this incorrectly? The main purpose behind configuring=
=20
> my "mostly just a fork" repository is that it simplifies tracking=20
> against an upstream remote for projects which I do not work on=20
> actively. Of course, you might argue that I don't need to keep my=20
> remote around for this purpose and can just use a straightforward=20
> `git-clone` here -- but I'd rather not, and would prefer responses=20
> addressing the perceived bug rather than suggesting this particular=20=

> alternative workflow.
>=20
> --=20
>   Ben Denhartog
>   ben@sudoforge.com
