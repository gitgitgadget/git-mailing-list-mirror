Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC36CC77B61
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 12:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjDPMrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 08:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjDPMr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 08:47:26 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DA01726
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 05:47:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A2EA5C0333;
        Sun, 16 Apr 2023 08:47:10 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sun, 16 Apr 2023 08:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1681649230; x=1681735630; bh=rlK2eXH4Bv1tjKzKkByfPaMbaal8wrFHbhz
        2dZTy004=; b=NAipD+B0nl2Wqhp5f/jo86XMSmM8YTwcqFv0rX4a1iOKPEo8hx/
        RuY03sC423bzr0mRJfzwvDLUlJhSTlajX0gHjKZtdfXK4M6CSmYTP/oGh71ew3re
        81DIsCcyLtitKd5TIV/1PJVTij50wqbon65ACLt6Ahas/BUCV7jOqtyOv4GTXMeq
        tSTWu4gUzAz+KLhcjZmubsOVLZHag/PVMtxR3lIETycGE7K57iOIUMP8PDzIPVD6
        3SKXKCCQWWfttL0HqDU9Diwuctrp/vaRCl427/zZdbvYyrsq5J9sosjm51QOmvqX
        mC4KTW0cNAhRHBvzCj4X97vOBseVmHxESjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681649230; x=1681735630; bh=rlK2eXH4Bv1tjKzKkByfPaMbaal8wrFHbhz
        2dZTy004=; b=Y5HPRA1D3P3oSFbL+vQqcty3rnSQ7T+bSXXLDfROE3Uesp452EP
        rbw7S4fnYRiWC8CfO7juwo94Pq8O6RyDbVUrZbyCvskgGoitAp2+6gww8PXu/GBh
        MEI1ICeBn4URz1Folo6wNviL8GaZI+1NLBuoq1pDgehFjK9Of+3nv6rylpXhsBgk
        ufdb5gUDEg1zYigDbBk3FjmCGum0TJZwHMYHMHHpHWKnGdXm3l4pJaa5RLZt+cN5
        iqoIywZDHkR75t1ePyYwjzNi31tpzWuSQG2ZJPeTb02XK4ubijRNSLB4RvEAxzWg
        OJAWLLsDWgu6lQj6IIZ65bZQymfFO6mOrfQ==
X-ME-Sender: <xms:Tu47ZF9DeWb99JcyZnaMpEsvNZOJkWUQ7-m5P8Ig0qVXAzc5Nq3a8JQ>
    <xme:Tu47ZJsls1l-sUT8o0RPhW3iz-23ljiCsySzowGDgKKWVwsRyze3-2m1-L41CemRg
    u3aZLKR_E935qvPGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelgedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeuieef
    teevfeejteeggeegtdeiudfhhfevffegveeiudekjeegleeihfdtffduleenucffohhmrg
    hinhepghhithhhuhgsrdgtohhmpdhsrghmsggrrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Tu47ZDCdVDE9kIoUaaW_r6yUG-Eb3FhAJE9OemsTTyOmDSUjdlW2oQ>
    <xmx:Tu47ZJd5Y9P5RFB5-RsWD2IUZbtmGrpxpFh26SfNBxBdSwwhrdjntA>
    <xmx:Tu47ZKMzEKbHnqqMl8OihqdwTOOPpDcjHJmDypfyZZUA82EQX_oQZw>
    <xmx:Tu47ZDbygujjdVC1f86SNQ8vIjn0zyajHDvn1OS_dWsKQGwolSGelQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2340715A008E; Sun, 16 Apr 2023 08:47:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <743b64a0-8731-46b8-a456-aaa51e310b9b@app.fastmail.com>
In-Reply-To: <20230416070906.GA3271@szeder.dev>
References: <CAKazavxTXwcZFtL2XyU3MpaUR=snWY8w8Lwpco+mkbqm2nWE=w@mail.gmail.com>
 <5b99135f-c1d4-434b-b508-35f5d66dd2bb@app.fastmail.com>
 <b5316855-971d-4b7b-89cd-e81ececc5124@app.fastmail.com>
 <CAKazavzS112w3wsxnA-2ibWH3xGrE_w7Av+VZg-DfgfH0aK72A@mail.gmail.com>
 <ZDSjBQhyDBGi9wBN@nand.local> <20230416070906.GA3271@szeder.dev>
Date:   Sun, 16 Apr 2023 14:46:49 +0200
From:   "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     "Rohit Ner" <rohitner1@gmail.com>,
        "Derrick Stolee" <derrickstolee@github.com>, git@vger.kernel.org,
        "Taylor Blau" <me@ttaylorr.com>
Subject: How to write to the commit graph on clone?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The commit-graph has been enabled by default in v2.24.0, released over
> three years ago.  I wonder why Rohit's and/or Kristoffer's repos
> didn't have it already?!

I might have done a fresh clone of Linux right before I replied to this
email thread, or else it might have just been lying around. (I don=E2=80=
=99t
work on Linux. ;)

I found out that I need to add this to my Git config in order for the
commit graph to be updated on `git fetch`, so I added it:

    [fetch]
            writeCommitGraph =3D true

I was wondering if this would help with cloning, so I did a fresh one:

    $ git clone https://github.com/torvalds/linux/ linux-github-2
    $ cd linux-github-2/
    $ time git log --oneline --graph | head -1
    *   3e7bb4f24617 Merge tag '6.3-rc6-smb311-client-negcontext-fix' of=
 git://git.samba.org/sfrench/cifs-2.6

    real	0m10.364s
    user	0m9.700s
    sys	0m0.666s

So no.

But doing a `git fetch origin` fixed it:

    $ git fetch origin
    Expanding reachable commits in commit graph: 1171056, done.
    Writing out commit graph in 5 passes: 100% (5855280/5855280), done.
    $ time git log --oneline --graph | head -1
    *   3e7bb4f24617 Merge tag '6.3-rc6-smb311-client-negcontext-fix' of=
 git://git.samba.org/sfrench/cifs-2.6

    real	0m0.017s
    user	0m0.007s
    sys	0m0.013s

Is there any config for writing to the commit graph on clone?

--=20
Kristoffer Haugsbakk
