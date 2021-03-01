Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E4FC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 17:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A141C65215
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 17:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbhCARVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 12:21:48 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43137 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237643AbhCARTK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 12:19:10 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B101DA0D
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 12:18:03 -0500 (EST)
Received: from imap22 ([10.202.2.72])
  by compute3.internal (MEProxy); Mon, 01 Mar 2021 12:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barag.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm2; bh=AvBiOCxMHUfBbjYH8PfX83wRB6GG7tr
        90kPZO2/1F/Y=; b=ALV59mngcATQazslFgeGylGy1Xo+1zCQsybLjCzxRx2CGfB
        p3Wu8NN9IE+yYge73mPr7f8vIS3v3Q/oD25t9qsYao5u1MVPfebqS8xs2GP8o2/7
        vPZ03SsZ1JIj3p6tTZaZHd5CQ8jR5J5R9uisHWQPztDO4O13OmkWM7+NtsVst3IR
        DcSWZyr8PVWqThWAJRspRSR7/LEvHV3ZScLW0gOP5p/VpQ++hf7RpjHXCr/bIyu2
        6TGezrlyG0SjVw7rjn4beYOPkdbK6ouYRPQBLvm8zYyk4qJ11KqvdISQwhQLVUAA
        aUXzvPOG3eq32FsmnHDEYTlom9q1GwXxTIgwT1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=AvBiOC
        xMHUfBbjYH8PfX83wRB6GG7tr90kPZO2/1F/Y=; b=udNmVe6fQsyqAkqf6pUsox
        EQPyvMoRbB+cOpxPr1/Gb+fvWeB9mj4cM7mMu2hogUgOWpVjsX/BRohpNLb/S6Km
        4h5X9xteVdTmKOan8cKTxUQvnqoLJ1I0SFAEUlIpqAwfEOw6y0gvbpNu8wTxzaeA
        Up92n1eD4etWWt/NnKqImP/d1YQO/mAt0KNG90cahxa6X2MdTB+mi1j7Bzc115f7
        oLQU9iYueZqyy3FqfgVUIIbqYC0xF6C6V/grq55wsV4Jpnw7RAvZKJowrs/y8wY1
        mNNa/Z3I/Xv4p2D8NCeRt24nlRMrY0OrAnYhk8nABhUjDupWEirZyGwM81JVzK0A
        ==
X-ME-Sender: <xms:yiE9YJ9_KaI7zxZTFrR27fU7rdM8UsVkURkxA_bIpPJMsu2lmSpgJg>
    <xme:yiE9YNtM3iSWww8TZ4aAcYH2xJnJNlL1_qoLi_78DHKMmqN0rclEnR4cuGsLHubOd
    BUMjkDF8eLQmFo7oXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdfuvggrnhcuuegrrhgrghdfuceoshgvrghnsegsrghrrghg
    rdhorhhgqeenucggtffrrghtthgvrhhnpeettdehgedvudeuteffudegueeludfhfffgue
    ehvdejteekveejiedttdfgfffffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsvggrnhessggrrhgrghdrohhrgh
X-ME-Proxy: <xmx:yiE9YHDT9yZiOij69yA1AoshLaLIjhSou9LDFNxjShD5WgyqI5va-Q>
    <xmx:yiE9YNcSn49YrqFeFB9cq9yMVKX9KeKkw0OXyRrwomckThU3LDWU9A>
    <xmx:yiE9YOPzHx5CYNiKh2h31kyliQ_rGUvoYy3zzgd4wgRFajN8rCARzw>
    <xmx:yyE9YEaf6GyN2aTrnmoIV7IeOqlMBzObn_tc8RX1AzL0GDOMqhpmkg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D657D62C005F; Mon,  1 Mar 2021 12:18:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-206-g078a48fda5-fm-20210226.001-g078a48fd
Mime-Version: 1.0
Message-Id: <58d3b7ba-b65d-432f-872d-adea7fad1317@www.fastmail.com>
In-Reply-To: <2d58fe40-9e8c-4653-8170-5411fd3cf6f4@www.fastmail.com>
References: <2d58fe40-9e8c-4653-8170-5411fd3cf6f4@www.fastmail.com>
Date:   Mon, 01 Mar 2021 09:17:40 -0800
From:   "Sean Barag" <sean@barag.org>
To:     git@vger.kernel.org
Subject: Re: [BUG?] git submodule update --remote assumes 'origin' remote
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 01 2021, Sean Barag wrote:

> I've experimented with
> introducing fallbacks to `remote_for_branch` in `remote.c` [2] as an
> alternative:
> 
> 1. use remote tracking branch; or
> 2. if there's only one remote, use that; or
> 3. if config.defaultRemoteName is set, use that; or
> 4. fall back to "origin"
> 
> This seems to work (at the very least, no tests fail?), but leaves
> `cd ./some-sm; git remote add foo bar; git remote rename origin baz`
> open to the original behavior.

I forgot to mention that this approach requires `get_default_remote` in
`submodule--helper.c` to use the name of the remote returned by
`remote_get(NULL)`.  That was probably obvious to regular mailing list
readers :D
