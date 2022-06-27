Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6909DC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 06:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiF0GBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 02:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiF0GBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 02:01:09 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F6155A1
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 23:01:03 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2C81232002E8;
        Mon, 27 Jun 2022 02:01:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 27 Jun 2022 02:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1656309659; x=1656396059; bh=h4juDP8vTg
        m1a/laGtLB+V9jl5cIb10V5OWzNRkmXLY=; b=YkJZTOyWD+HM+BRTVaNAag71QW
        x0ICy2Cn/+5o3gXdJP9xIPEfNVjcJro7aQFer1VXqazCExTRNcikpzon0L7C3hMT
        3913s8AZt+sbS+LsB3SHAw7DelM+vfdiijnbgd9dlwX5GQOOStPmDkJcWxIa635t
        tFoOMT3eqmSIUF5OL4QFyx39I7bs9U7cpy0m1akJxxdgxAJG3///UH5g+SfpcKMO
        QEalYxSI3Es39i/LDBLChUrWdyKgBIWweZ/llL1DTfAnjktFYqwDEqjp3jsmbh0T
        8oOvvOE1MjXUqEHtiV46w7IWcD1nNo7qhl8me+ooP5PbCXtkYRKpPdPq50gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656309659; x=1656396059; bh=h4juDP8vTgm1a/laGtLB+V9jl5cI
        b10V5OWzNRkmXLY=; b=VZDibLAO5ZTwEDVnjdhqFMTGkSr4Wnx0Zz5G/9MHWKZb
        qGWpOTtSw1dWDiGPccz8jSMoVbUOLfCux8bhOUMi0lGH5TVzWe98Vym2KpvzWkTJ
        9QQ7+LBDP0okSP/5GfU7k3GOrJ/+ye/rFLdmDFVjO2aZ7NZ5fpmcejMqgVRZd7/3
        BxRdQ/0qRAcAwCEMXeHQ9lROwbr3UUSD1AhLJWJl1uVqd7OsPAV8M+WoPr02NV9z
        ZdkVcHdZfZg7pKjVjlUl6ELv1a3rUhYaO7AQQsZySzAyxX3JmWfJiCPWOic4R7pC
        hhzYI2RTlbcrjnmFeakxcVG3wwSrAI0VqoGzyOZgxw==
X-ME-Sender: <xms:m0e5YpIb_heGJrdVYYpdYYtKGv2xwegK6QbbPuGej8LBYaPtikCgQw>
    <xme:m0e5YlIFhdKsusdfwnYwb5blTk7BSJtEdcMyU56czOLQ0d3bBNaVj5f3wFq-JVDkn
    XKKShYp5F9mmxu74g>
X-ME-Received: <xmr:m0e5YhtIYyCzcJFPjcOtGc6P7aQ4g1ROyuq8cx5PJfJpX7ffouFw9jg-dbWpYLjK4kYK0NHCbGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeggedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtjeenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhf
    ohhosehuledvrdgvuheqnecuggftrfgrthhtvghrnhepffehveetfeejveeikeehueejie
    evgfeuvdeifeelueeigfdttdelleehveelvdejnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:m0e5YqZh1SRghILom4JvlKK2Ej2fo22sX8FgU2GU2YwB_fsGHHzePA>
    <xmx:m0e5YgZ84Zn7ICwd_Q3EY84A94wHRDwi_msuZhjepPbJQvjmK6xz6g>
    <xmx:m0e5YuDO3SQd3Rviu6fomZVmf1Ej3G1jGNjILtHVW1h7NXHys9zrsQ>
    <xmx:m0e5Yry7fJkI86XlfztB329_0V3rftBUXdn2mguZDTdJVpQCs6hykw>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 02:00:58 -0400 (EDT)
Date:   Mon, 27 Jun 2022 08:00:55 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.37.0-rc2
Message-ID: <YrlHjtyratGlxs/D@zacax395.localdomain>
References: <xmqqedzg4hqj.fsf@gitster.g>
 <Yrii4Wj+c0YuQy61@zacax395.localdomain>
 <YrjJkuX6diZiF/SM@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrjJkuX6diZiF/SM@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/06/26 05:03PM, Jeff King wrote:
> One thing I would suggest, though: many folks on the list use the
> presence of their email in the "to" or "cc" of a message to help
> prioritize (i.e., to see responses directly to them which may need a
> response, versus general list chatter).

You are completely right. I should have noticed this before sending the message
(I also use to/cc for priorization and my message obviously did not require a
reply from Junio). I'll pay more attention in the future. Thanks!
