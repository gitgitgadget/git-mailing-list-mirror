Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75569C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 22:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjD0Wdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344235AbjD0Wdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 18:33:32 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A123C01
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:33:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F0205C00DD;
        Thu, 27 Apr 2023 18:33:29 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Thu, 27 Apr 2023 18:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1682634809; x=1682721209; bh=MLkrdLbcM6D7i5/XK7TtZPg6R
        zHLSvMjJ9zeYY7Rl8k=; b=f6ZNTYiG/Gh0MV3mnFo5Dq8e2mn52wM0iwxqhaWKi
        duc2U1S4yueJgjdacX/H19kBX4eig04TmmhDAjnuHwCOChC95GQ4uuWFfWvpLO/R
        Io3Mfc7F04ugfDkQFwNDPEYmVm/qd733khhQEzZrcbptHAC21o+9TZt95+2nZVuV
        DMISV3QQeWjD7W2kuLoti7cL4v7bRhTF/yraLqkyUWUyWixhqOXQMfnH2UJOV5Tw
        +JXUaL0XhTCxuBKIpwAG1ruKhvuINEPrEXk86LizDk9ZsDHTlqSJiN2Dk57A1lTa
        6CltUoKG0C8ODBlzBoSc33R3HpnufmCqwHYHUGrAC7Fpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682634809; x=1682721209; bh=MLkrdLbcM6D7i5/XK7TtZPg6RzHLSvMjJ9z
        eYY7Rl8k=; b=AdtlEI7yirXUHAIFO/VxspFyAa33wZOROTCUrfnwS0aLF0hamxn
        zbNoTRbftlCbPcUHM2ToXmNSZ4AzG5W6Y4b1WPbNnOSnIg1E46lNW8Sy062pPZTo
        RB1T5MJldzuWlVNcibJKcpcfZa5sSTsxIiy9v1LQleCe72fyR/R/vK0tEutDRFN2
        YMPyXF/XSwUTAqc5fVIKrQ/vqkbipIC+oyl8V01xsxg9G8dxKtF//AbqGhg7aR6o
        pR+uQWMjNgdXO9gyvIxlbcpLPUeCwQEaLxf1NFf1jCouPent8M32CV60keWF5okK
        DemlqLnOZUMsSxoeVB1DTTTX5bptWurUhcg==
X-ME-Sender: <xms:OPhKZDA9Bm8XExOMEG4HZZ51lzLoc1NQO4GSdSGvOp0mjF9Vf7y7MWY>
    <xme:OPhKZJhJ1zAf4RX1ufH2U2EYJeVhSbpiVuXKW3NE2uEan4gdmT71NYPlqUmrSTxkG
    v0smj5-G5KgoSrPyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedujedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedviedtvdetleetvdetvdeiveehgfei
    ffeujedtudfhtdeigeejheehteehfeehveenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:OPhKZOk9SdeywbSyktqkImhUQBSJT60P9r5uHpRPupoNxVvQ5zSFJA>
    <xmx:OPhKZFweft32CVDHwxpwngtg_Emr23HFdCvVby9cqI6uPh2p1MOZKw>
    <xmx:OPhKZIRZDZ8LeoZrxDWvDnt4Zn8KDWkioZyDq7om94TGckrnr7qVBg>
    <xmx:OfhKZB7P3g8jIgqy9fZkPW32tXDmkkHFzc5-d83JMt_iTDKyYLwXSA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8727715A008E; Thu, 27 Apr 2023 18:33:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <95a158c9-6359-4da9-8302-d54a0fd9b2e4@app.fastmail.com>
In-Reply-To: <20230417074136.GB39931@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <141f0f6b-ef5e-4470-b86f-7ebd6c2be3ab@app.fastmail.com>
 <20230417054032.GA26997@coredump.intra.peff.net>
 <b517d7ca-4b8f-487b-8836-8966a2a9d9ee@app.fastmail.com>
 <20230417074136.GB39931@coredump.intra.peff.net>
Date:   Fri, 28 Apr 2023 00:32:11 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org, "Thomas Bock" <bockthom@cs.uni-saarland.de>
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order': Commits
 from 2011 are treated to be before 1980
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023, at 09:41, Jeff King wrote:
> Ah, OK. Carry on, then. ;)

The result (see readme): https://github.com/LemmingAvalanche/libreoffice=
-repaired

The problem went away.

> But if you want to try, I suspect you could do it with
> git-filter-repo's --commit-callback option.

I couldn=E2=80=99t use that. The metadata was too mangled and `git-filte=
r-repo`
just errored out. :P

But `git commit-tree` + `git replace` + `git filter-repo --force` worked.

--=20
Kristoffer Haugsbakk
