Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA15C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 01:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2EE224D1
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 01:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbgLDB1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 20:27:22 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53029 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726603AbgLDB1W (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Dec 2020 20:27:22 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A73D3D25
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 20:26:36 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute1.internal (MEProxy); Thu, 03 Dec 2020 20:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sudoforge.com;
         h=mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=fm2; bh=UcR6T2WjqgJuHi/FXCxOhFawAC
        GpM5ogoRnlU/iXEyI=; b=Iua9zSuL0XfZXOXfka+hjz65HeCHYM8CauBMM5U+8b
        D0x46KE7KkrLzy3q4H1Bniv0bT5WiKYnV/JQPhBV6NLsxLHPzuLRJpuVRm/WqsQQ
        qZCr8YXf0spnH/4Zd+GG8FJZNW15WDrJGM0IW+82YFoCUFdiWGs54Dt0lKPGCz9e
        IKjwewAEJoJ+yTgqWCEC47vF3HdMrbPn6e08q7ohDbKrNTQk2ZkSrUv/SN4SBuz8
        nTvFwCIzLNgjW1UlSAgcP+T3jOUYwBmsi/+hbCSL2bfiL3piitmMYEoj7eCNUPqs
        96Lx0vPmREueFzo33ZJY54RsfP2KOsSfMQqRuFsf6DNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UcR6T2
        WjqgJuHi/FXCxOhFawACGpM5ogoRnlU/iXEyI=; b=nvSo1yqCrXVtO6RPH37Lcj
        0Wr5p8FDl2Rm/3RogUgol8I8Xxonlv3V2MHotrW8Ow8r/lsPLXAD9e4q3uxP1pCB
        z2HP59G+hz/0e1Dce8D2uh7NJZoOCLpe6fue1iF1RCkw5+4cOnuxlhB1481aPmJi
        q1REsh8RfhwcMXhI3SRByKi+lknRK6pgOrdIGwHmp3se/1W69ltguPRPTl1u9oQi
        lvfMD53OqXs65uiHVaLE9gy5oPBSfSiqH2u5G3Y3ovFTXLkUn0/W7RDONcC2KZvs
        5pXfVqaGUTLI/LhnxDWcViIyaVsujKR59MCuj4/41ld/Kbskl2o9/nu/jc32ootg
        ==
X-ME-Sender: <xms:TJDJX88Lt8dOvLnuQqyvabK-5-M4cV7y_tOIAMkVzIFhmL9ZUhNiiQ>
    <xme:TJDJX0sdVioav2PEQf91F3NYAsFnyY3SpIVozOLCuFR3XKG7WbWe6RuMYfzKkVb-9
    TA9i5qOMfILW5t8Ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeijedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdeuvghnucffvghnhhgrrhhtohhgfdcuoegsvghnsehsuhgu
    ohhfohhrghgvrdgtohhmqeenucggtffrrghtthgvrhhnpeekudduveehueeftdeijefgfe
    ehgeffvedvudefffekgfevgeffgfelieekheefffenucffohhmrghinhepfhhoohdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvg
    hnsehsuhguohhfohhrghgvrdgtohhm
X-ME-Proxy: <xmx:TJDJXyAzgGdUc7KivhIFH91HlYyVBjsh115CmnQw__v46wk4gVNi7Q>
    <xmx:TJDJX8fw52UBKszwCEFQrgAgQkes-0-zCGt8SWWxxXKvCa_CZzF8eQ>
    <xmx:TJDJXxMTzItDQiCTZ7vvIuLzEFaIdAYtPVYREMyR9RgPG5yUgG-Z4A>
    <xmx:TJDJX3aBKUF0fQOW3rTSkNotR2nRkuXz-z2jrV7Np9dfj-PvLC6YIg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2326BE00A6; Thu,  3 Dec 2020 20:26:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <a4ae4e1a-b457-4b35-878c-2714ebfc415f@www.fastmail.com>
Date:   Thu, 03 Dec 2020 18:26:15 -0700
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

Based on my understanding of the branch configuration options, this shou=
ld effectively force my local `main` branch to track against `upstream/m=
ain`, but push to `origin/main`. I notice what I believe to be odd behav=
ior when fetching: that FETCH_HEAD doesn't resolve to `upstream/main` as=
 I would expect:

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
