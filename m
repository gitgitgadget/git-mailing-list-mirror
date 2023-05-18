Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2855AC77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 13:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjERN4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 09:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjERN4r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 09:56:47 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DD110D1
        for <git@vger.kernel.org>; Thu, 18 May 2023 06:56:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 44E94320025E;
        Thu, 18 May 2023 09:56:45 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Thu, 18 May 2023 09:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684418204; x=1684504604; bh=Gk3/QCeM6BALfYICLv4HnV79g
        uN/jCzafy7QfYvvTvM=; b=dalLNeRm3T57L7nj0GYiwfhpLKDa3JgW0GMYn8DDr
        FQrCfKFxKxdZEcfY2Rm0SaHtrHLH+6Ltb0EcEj34r8nUjlOg5JkuM58pTsIMt4qD
        jTRNrCUjFtLD0vqILLUW5V0vmbcLsXWPPmUaBHa+vhlBVKrOQngpSlE1bGzTLh5G
        PEr7X3DJ4MxvQBfbi7tPHZBP40OjHmMQ6BxCugmYwP1XIqxFo39jTYaaAqjLuWc9
        iSapldPMICxvHDjbLHxeCWdmvROWLZDgegBMVWmoRPaY7OVkmfHwaFw9nwQ5tOcZ
        GEKzknCTk/LLXSBQQVayh9Dad4TJpzXsVeqfZBy3KU0jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684418204; x=1684504604; bh=Gk3/QCeM6BALfYICLv4HnV79guN/jCzafy7
        QfYvvTvM=; b=aSjhkM/5Ol4fDUt9Vd9mwBherRM1S9Q4gXyxn1yfMCVuRPidPZV
        ROu1G2gWhotCu7ktqgakGiekiIWJ63ZWX6TomxE0B9q9BBlarxLTs+DpL4AXNjV/
        t3hP/ZISUyUk2POUtg7EXAHJSmDPvYj1nnsIo+rfscUiLBJhyvwjTZF3nkO6U/kc
        w4lNEoQjf5r70n0N0i6504JoKuM3o2mbAz4k0Daql+aDwFMsAbJmpLk+BfOWHfjT
        HNuxAXZVcwcnJZRZV67cSwsI7Rkfx+Q9LfYP2u7eef4BBs714Uabktkhl3dl9FTp
        3dMXaWnEW/WcvORdA0mmWb7ovUwXkf5kTLA==
X-ME-Sender: <xms:nC5mZIX1P69GPVgTt9S6rPfSp82Wnf71xjlGhwX_PdtXESjO1_oCL8Q>
    <xme:nC5mZMkjYwnrTbONqgZwW9u9MMNtc6Ih5ggECIop6Fp3gdT5wNzq6H17v5O-LamRW
    X9dMWgPV8hjQYxsNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeifedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:nC5mZMYqCVQUfvNPwBvX62ZMQ1X9Wja7dteZ73w9DHITjcuzu0dqwg>
    <xmx:nC5mZHWGwGskVREwOIRmgAV5c8x4x2nqnBvZwOMsAtuZ8LiLCm1mng>
    <xmx:nC5mZCki5n_iJGsP-_P-ICnanAfHCvUcaP6o7sE-ZBxS-ezOQc0v6w>
    <xmx:nC5mZEi1aRsvk8n6ZtdpKOfE-h1CoO-o4bB8sMApRUp3X034UKIDoA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 66A4415A008E; Thu, 18 May 2023 09:56:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <3f86a553-246a-4626-b1bd-bacd8148318a@app.fastmail.com>
In-Reply-To: <cover.1684411136.git.dyroneteng@gmail.com>
References: <cover.1682671758.git.dyroneteng@gmail.com>
 <cover.1684411136.git.dyroneteng@gmail.com>
Date:   Thu, 18 May 2023 15:56:23 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Teng Long" <dyroneteng@gmail.com>
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        "Junio C Hamano" <gitster@pobox.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 0/6] notes.c: introduce "--separator" option
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2023, at 14:02, Teng Long wrote:
> From: Teng Long <dyroneteng@gmail.com>
>
> Diff since v9:
>
> 1. [4/6] support `--no-separator` which means not to add any paragraph=
-breaks.

Nice to see. :) I think this will be useful. Specifically:

Johan Herland wrote (2010):[1]
> BTW, since I started talking about git notes, people on this list have=
 found
> more and more interesting use cases for them:
>
> [=E2=80=A6]
>
> - Help in bug tracking with header-like lines such as:
>     - Causes-Bug: #12345
>     - Fixes-Bug: #54321
>
> - Store after-the-fact "Acked-By", "Reviewed-By", etc. annotations

This switch is nice for that since you you don=E2=80=99t really want
blank lines for those kinds of format.

Cheers

[1]: https://lore.kernel.org/git/201001201148.11701.johan@herland.net/

--=20
Kristoffer Haugsbakk
