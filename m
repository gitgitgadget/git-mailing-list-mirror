Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B291C433DF
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D7620795
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgJJWLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:11:53 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38233 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729698AbgJJSnZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Oct 2020 14:43:25 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 42AC9FE3
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 14:27:54 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute1.internal (MEProxy); Sat, 10 Oct 2020 14:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sudoforge.com;
         h=mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=fm2; bh=zvrc8cNlOd5XrFwV/LXLvtZ9Gt
        xGx7u3O/wlEUgYIOo=; b=Ioz8b0onXSWCe4yN2k461frrEw9cYtfbnCdukzBIEt
        7IpM6Gh88UT1GiJrbJXkTsjHvkSDSJIYki918jJa3GKUuU3j05qZTfJ9Q3We9fa/
        b9ffzUkKBH2Zrz7kDPEauaN5bX7pmtWmgDwYbB8CgllDlapddX0g/dpL8TWt2rIT
        EBUt4KML9k2pa9P5x8202pj36OnLeBSLw6BK0oGnKbcrZ7s/G6BQVABIQgyGQu7R
        1kMW6fd0LWlql7rWtD1EbG5506d6I9tY37QVG57CUkPV42gs8ij0HylgfYS1p65/
        CM+VWEsen0Ew0yOixw+Fdnv+hw/foHfdmwyumHVizc4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zvrc8c
        NlOd5XrFwV/LXLvtZ9GtxGx7u3O/wlEUgYIOo=; b=knu+JipwNx0HViJwfThkqb
        WyiEpWQdGPtSDX3VLnd2g8zIlNNcO72Kq702OQeX3QAPuzWa4awBkI1AuO88fhQg
        fZsy9nn9vULQeR8Lx1IhiJvIO1tb2519a4uQoxGgSzQMjyTeQMN/P/l76ODdv5zV
        ujDCgwDQy28aoCJ5MZxp46LTGpZv/3APcZCo4tJOm8/fWSlMXPxuwu+f4684HXI7
        veYCnblRiTAeIMWiw4Q4Kq7wqyxAscb8sUH6O9krvwDITAUgvxUxrbIYvDoTclYN
        tanbrjk1ylPieETG1QB4hKM9IxSGNEtbzateccQiK7SB1qms8vlddc2Y7q9IjD8g
        ==
X-ME-Sender: <xms:Kf2BXw2Ijcy3FJdvv7DepWV6mqf-x-NIYfXMy86r00OuoBpYgiIzkQ>
    <xme:Kf2BX7G3cDrsEei1_cZtSr-djz3H_5qfq6-Ml_gcI4bB3R7CprTI65I53mk5dVjYB
    c9ataqHZ2iDQELrhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheefgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdeuvghnucffvghnhhgrrhhtohhgfdcuoegsvghnsehsuhgu
    ohhfohhrghgvrdgtohhmqeenucggtffrrghtthgvrhhnpeekudduveehueeftdeijefgfe
    ehgeffvedvudefffekgfevgeffgfelieekheefffenucffohhmrghinhepfhhoohdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvg
    hnsehsuhguohhfohhrghgvrdgtohhm
X-ME-Proxy: <xmx:Kf2BX46Uk_MyVFudH5Ai9DWqwDBRG_UZuzcaWfSFriq9xnrnoo0CMA>
    <xmx:Kf2BX51AGaklFVIPPi4W7ujFQWVSeuYPpQccujeyl6-aqaKJH76-Qg>
    <xmx:Kf2BXzFVzaJfEp-gTf2qHROoS7b2iCoODVEQBHcAgXqGFAlcaYV2ew>
    <xmx:Kf2BX3QH8I6ycxdj3XGqIjVneg9zb4TYY1TNX2e98wzaUVo7O--7uA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2FD1CE00D8; Sat, 10 Oct 2020 14:27:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-407-g461656c-fm-20201004.001-g461656c6
Mime-Version: 1.0
Message-Id: <dab3f28e-1a4b-4756-9a50-a5804b438804@www.fastmail.com>
Date:   Sat, 10 Oct 2020 12:27:32 -0600
From:   "Ben Denhartog" <ben@sudoforge.com>
To:     git@vger.kernel.org
Subject: Unexpected behavior with branch.*.{remote,pushremote,merge}
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a few repositories on my system that exist primarily as local cop=
ies of remote repositories, in that I normally just want to track and fo=
llow the upstream project (however, I periodically contribute back upstr=
eam so they are technically forks -- origin is my remote, upstream is th=
eirs).

In these repositories, I set the following configuration:

```
[remote "origin"]
  url =3D https://git.foo.com/me/bar.git
  fetch =3D +refs/heads/*:refs/remotes/origin/*
[remote "upstream"]
  url =3D https://git.foo.com/them/bar.git
  fetch =3D +refs/heads/main:refs/remotes/upstream/main
  tagopt =3D --no-tags
[branch "main"]
  remote =3D upstream
  pushRemote =3D origin
  merge =3D refs/heads/master
  rebase =3D true
```

Based on my understanding, this should effectively force my local `main`=
 branch to track against `upstream/main`, but push to `origin/main`. I n=
otice some odd behavior when fetching, primarily that FETCH_HEAD doesn't=
 resolve to `upstream/main` as I would expect:

```
=E2=9E=9C git fetch --all
Fetching origin
Fetching upstream
remote: Enumerating objects: 23, done.
remote: Counting objects: 100% (23/23), done.
remote: Total 32 (delta 23), reused 23 (delta 23), pack-reused 9
Unpacking objects: 100% (32/32), 12.97 KiB | 949.00 KiB/s, done.
From https://git.foo.com/them/bar
   63f7159..e65b80e  main     -> upstream/main


=E2=9E=9C git status -sbu
## main...upstream/main [behind 9]


=E2=9E=9C git rev-parse HEAD upstream/main origin/main FETCH_HEAD
63f71597979edb16cb9f80d0431115e22dcb716d
e65b80edd2a2162f67120a98e84bb489f15fcf97
23e6881719f661c37336d9fcf7a9005a7dfce0cf
23e6881719f661c37336d9fcf7a9005a7dfce0cf
```

As we see from the output, `FETCH_HEAD` is resolving to the same commit =
as `origin/main`, when I would instead expect it to resolve to the same =
commit as `upstream/main`. Here are the contents of `.git/FETCH_HEAD` in=
 its entirety:

```
=E2=9E=9C cat .git/FETCH_HEAD
23e6881719f661c37336d9fcf7a9005a7dfce0cf        not-for-merge   branch '=
main' of https://git.foo.com/me/foo
e65b80edd2a2162f67120a98e84bb489f15fcf97                branch 'main' of=
 https://git.foo.com/them/foo
```

Curiously, `git rebase FETCH_HEAD` seems to think the local branch is up=
 to date (erroneously), however `git-pull --rebase=3Dtrue` and `git-merg=
e FETCH_HEAD` both work as expected and merge/rebase with `upstream/main=
`.

Am I going about this incorrectly? The main purpose behind configuring m=
y "mostly just a fork" repository is that it simplifies tracking against=
 an upstream remote for projects which I do not work on actively. Of cou=
rse, you might argue that I don't need to keep my remote around for this=
 purpose and can just use a straightforward `git-clone` here -- but I'd =
rather not, and would prefer responses addressing the perceived bug rath=
er than suggesting this particular alternative workflow.

--=20
  Ben Denhartog
  ben@sudoforge.com
