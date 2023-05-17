Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A205C77B7D
	for <git@archiver.kernel.org>; Wed, 17 May 2023 18:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjEQSDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 14:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjEQSDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 14:03:17 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408EC83
        for <git@vger.kernel.org>; Wed, 17 May 2023 11:03:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 29BC25C0082;
        Wed, 17 May 2023 14:03:13 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 17 May 2023 14:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1684346593; x=
        1684432993; bh=HIxPjxSxMa/Ofk56ftnvlVbMm3E4BJIn1DI6BWoOrr4=; b=u
        4kC0P7C+i5idGCN1rR4cUxWj8f1Oku2xUkywNP59yndvjkx5K+4neEdB14zZswt0
        KN8U2LkMH6MdX3NMJlONUCHWAiudBF7u4Kfaq+71JTIK8AHFcTwFkTmNe2X/1QNQ
        b1hfANUg+7H/qtMQ9CxdgNaxS1FwHWOmAEiaBtVc5gHzG58dx5vy5u8tHyCzWIPM
        ZFWHk1T4aD+gL3kxBlkGvrC9kHCASP59Xk3rIUeMew0Zhv8Apq/9OiTiIw+HX4Vk
        MT741s6ilIKs+wHD+DZ271HBSQQ2Np42KqZz1MLVeINUt8SIj8y1GF9lHgX4RL/r
        krPABL5/boo7wj1bpa3+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684346593; x=1684432993; bh=HIxPjxSxMa/Of
        k56ftnvlVbMm3E4BJIn1DI6BWoOrr4=; b=Hjw/XX8Xw77PTEv+WRpOrbz9MHaGi
        TMr1pijZgaUe7fCwCfKDdor+TK7cGPL7fHxBuFBCeiGyEDwN2hpf+9Uq4mAL64ns
        R0MO7lT4blnh5Qx95ceB4Q/JmztZ/7s07svgQ2Gf/kvv6/U3LSnycnRn5gmB1VAa
        OqWM4D0RPU55uYZZRgVcBtrXBpFJeESkgmGsXxVLmmVMOP8ebfePQQuaMoi3UKTe
        l3JiR5FP+5BG3QHWHX7kFluGDccC1mH+jv6ieTn8zSHQ0CnLbWpEfzDmr3qjHq4j
        ii8XH9SAkwrbIPAGmBLw7J7BSwSsODW+/Irme2rtOPzrfhl8lJ38PHU3Q==
X-ME-Sender: <xms:4BZlZDrKhXBeaOrJs82uC2iWA2tYtg52j_fQBwFZUjJWgpiqFItyk3g>
    <xme:4BZlZNpSFR6XHgIiO_RHp7Ej7g2tz2Syq48R7jGTqosLTMOiDbVzBbQ8MdqP8XndU
    ufgQsZjrCItXT9iHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:4RZlZAN73FvUPijk4ummrNo9YGoio010jCrzAY68cTCL2e-v-cd_pw>
    <xmx:4RZlZG5-DHlzN4JXcO7B2R6BuhsWT8SmpKH7pLvep2642p41XiS8ug>
    <xmx:4RZlZC5tlPH9kEci0pnCFCGRsHdYcOF4ohyih3jPYmCcDkQ3iGpIvw>
    <xmx:4RZlZISpXxBN1pSp_di7EiSYB7mviR3J5A_yvoHmQ55JyMHouVxY5g>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DC13315A008E; Wed, 17 May 2023 14:03:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <096a2370-34e5-4cb5-944b-8c1141f5bc01@app.fastmail.com>
In-Reply-To: <CAPig+cSxbsqqQ1qDAw5Mo_yT5u6wzgoXSvPc51=RDVV-EBPhvg@mail.gmail.com>
References: <cover.1684067644.git.code@khaugsbakk.name>
 <20230517093214.GA527234@coredump.intra.peff.net>
 <xmqqo7mjq779.fsf@gitster.g>
 <20230517173709.GA535409@coredump.intra.peff.net>
 <CAPig+cSxbsqqQ1qDAw5Mo_yT5u6wzgoXSvPc51=RDVV-EBPhvg@mail.gmail.com>
Date:   Wed, 17 May 2023 20:02:52 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Eric Sunshine" <sunshine@sunshineco.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
        "Jeff King" <peff@peff.net>
Subject: Re: [PATCH 0/3] tag: keep the message file in case ref transaction fails
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023, at 19:52, Eric Sunshine wrote:
> If that route is taken, then making the advice worktree-friendly would
> probably be a good idea:
>
>     git tag -F $(git rev-parse --git-path TAG_EDITMSG) foo

The current advice works with worktrees since it just uses `path`.

-- 
Kristoffer Haugsbakk
