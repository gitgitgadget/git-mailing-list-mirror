Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ACFC001DC
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 10:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjGaKLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 06:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjGaKLj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 06:11:39 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15026E57
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 03:11:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3D94632008FD;
        Mon, 31 Jul 2023 06:11:34 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 31 Jul 2023 06:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1690798293; x=1690884693; bh=j8R/uaiSge0jLwe+Gs3ugOmWB
        lf0XDj9sX/8YXLUxjQ=; b=u+iCCcewGBop2vbbp/ejuQkQuJjkKX2133lFQi3Yj
        ASPCR6xoe5oDpCf3zt3SvDepuA/o7ypUg1lUnaYD3h/xy8e7VLK4ZtG92lD5Q3jH
        vECqBKJ96ElkftGh7Mcxr6igvkBTXXCiCsEaOaOYxbOJ+RpjLvonUwv8st6JT+LT
        r2Vd5Z18I9E5kCpjbs7kXUCzCbHAwvKp64kkNQJgjraF7rP+7DUMlfYO9H/MfWjb
        9wg/GrIUEYo34Y7G3HKxcRQV0zpxTpPISBF5MbcWRujchTzxm4YSpk3AS0A1phKw
        yC504YgyD0tGED5jjyjwoJRTA+ZKW8OKd/ZXh6wsBiEFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690798293; x=1690884693; bh=j8R/uaiSge0jLwe+Gs3ugOmWBlf0XDj9sX/
        8YXLUxjQ=; b=yKIxxwP5vqhI8skpBep1Yb5L9vALWp/zmUiuJ2D0cH5gAykImDM
        VhbuV2rT/XpCWSKOp2cLhpKD2VFu5ncZ74klzI0xgBuGOXfAFvNqj/+DB7JitcD5
        e/psjtRTlCehDujWI+4Ee5slBFajUqk7q9n2uXhC9qWLE4h3ovRePlEHP6AMu8EH
        YAHiN7nR+MwdgWHPL+HjgvRkpHt5HTGY00zLCLMYWml73cAG3AI8QB2ZRLwNWQvy
        K2tLd8dgoUOXGX4j4kXfs7ljhJPYURL/J+jiIF2nrbQLJMsqoe3mA69ybSWeiDF9
        Q6LR4YXYz1zvIiQSNKyryJVtc41PNoRY/+g==
X-ME-Sender: <xms:1YjHZOy1CmGHGrwhivabtjYsSwCi55KYtom23F72QFHlyQFpev2XJGE>
    <xme:1YjHZKSZh5axIeEBcyshgRWqe-Vh7qzIBdVKyYvLCsBnbhkRn23dD4yd7FJ3F_mBi
    zMkjYKsyQ3Dz43f5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:1YjHZAUbVr5O90OzUm51bwSognhC9H4di4uAhjCE5M-2vLOWrT8mbw>
    <xmx:1YjHZEhrb-pR7uhfuowoNiHJnYthTxVhWOMWErdCCDdySt05-PeKkg>
    <xmx:1YjHZAAid34D6yFCGq237eva6X5XBgSKqc_FZGuP_JsQaxZN2SMohg>
    <xmx:1YjHZOScKrqx6G50UEPa8h9U4FvqF__BFSDY-iqkrFYxsG7Xqft4_Q>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2125915A0091; Mon, 31 Jul 2023 06:11:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <a5c359d6-6c21-489c-a4a3-a21219ab727a@app.fastmail.com>
In-Reply-To: <CAP8UFD1M3sRPEJ42v2=pQ_CQYY+PN64Swx70O7D_=VfbhSwKLg@mail.gmail.com>
References: <CAP8UFD1M3sRPEJ42v2=pQ_CQYY+PN64Swx70O7D_=VfbhSwKLg@mail.gmail.com>
Date:   Mon, 31 Jul 2023 12:10:41 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Christian Couder" <christian.couder@gmail.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Jakub Narebski" <jnareb@gmail.com>,
        "Markus Jansen" <mja@jansen-preisler.de>,
        "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
        "Taylor Blau" <me@ttaylorr.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Bruno Brito" <bruno@git-tower.com>,
        "Calvin Wan" <calvinwan@google.com>,
        "Elijah Newren" <newren@gmail.com>,
        "Phillip Wood" <phillip.wood@dunelm.org.uk>,
        Canpolat <eren.canpolat@gmail.com>,
        "Glen Choo" <chooglen@google.com>,
        "Linus Arver" <linusa@google.com>,
        "Victoria Dye" <vdye@github.com>,
        "Jeff Hostetler" <git@jeffhostetler.com>, git <git@vger.kernel.org>
Subject: Re: Draft of Git Rev News edition 101
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The Magic of Empty Git Commit by Pradumna Saraf on DEV.to - a simple
> description on how to create an empty commit, and why one would might
> want one.

The article does a poor job of motivating empty commits in my opinion.

> > Although seemingly counterintuitive, [empty commits] offer valuable
> benefits for documentation, triggering automation.
> [=E2=80=A6]
> Empty commits might seem unusual, but they offer significant advantages
> in managing version control. By documenting milestones, triggering
> automation processes, and maintaining codebase stability, empty commits
> can improve collaboration and project management.

So one use-case that is clear from the above is as a hack for triggering
builds or something that require a new commit (in other words: that can=E2=
=80=99t
simply be rerun). The rest=E2=80=94documenting milestones, maintaining c=
odebase
stability=E2=80=94is not obvious since you usually do that in a regular =
commit.

You can see from the comments that other people also don=E2=80=99t under=
stand what
the motivation is.

I use empty commits myself because I=E2=80=99ve seen use-cases for it de=
scribed on
this list. For example: storing the cover letter as the first (empty)
commit on the branch. Definitely useful for in-progress work.

The article, in contrast, just asserts that it is useful and then provid=
es
a one-liner as its technical content.

My opinion from the peanut gallery is that the article isn=E2=80=99t wor=
th the
inclusion.

--=20
Kristoffer Haugsbakk
