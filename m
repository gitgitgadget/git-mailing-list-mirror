Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3153C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 22:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiGMW3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 18:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiGMW27 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 18:28:59 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496E8371B2
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 15:28:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7879632009C7;
        Wed, 13 Jul 2022 18:28:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 13 Jul 2022 18:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1657751336; x=1657837736; bh=4B9H78iwlb
        AJjUhYnby+vFdAuxmXNVvGzrE1ftGyAW8=; b=gVNkbagCgbJQH8nXHkuFEmXZsL
        vujNqtWLIDrgzCsUeZZT5ikec755A+myn8yuxEn/gg/XxB7PL0Ivh4XWdM/5xYTL
        zMELFWAGzoxwTwh0DVyz31VavGNknm/7R6Mqmh1wl+jRj65NX5nxb/MOxYJhE8Jn
        QcJy3IvtIvMP1dxOY53rJriok8wCD9So8N5v1zA/u91p2QerfJp3smqKrvYz/12/
        CLy1+9l3IyqEGJmel5YV3ptnCHt9Lyc3McpjkyBY36g8y0UrJiRf2WKji5o/uDqv
        SEqIBkTvPJ1DIDkU6zBdfEPs2mCmMWVlmZ8G1JDwgCw6ms9pM9N0r0kAOUiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657751336; x=1657837736; bh=4B9H78iwlbAJjUhYnby+vFdAuxmX
        NVvGzrE1ftGyAW8=; b=ozLMDG0kbHVPYKrJVJi9fmzO/kyN4JjJaSnlWawYzX1n
        nZefgGLKlqifDQe20Gt7Ts0qcBcaBb27B1SMS4SzhXKt+bQ4wlN8FIj+MxI7rwC8
        yH2XjvWfIAm5e298c2yWDiwaOsqOFa8UR6vCWdKquQ+XHwlcIh4qMWOIfUyIqpoR
        s/GDWsjAIek7kz0feEeq0Ph08TivoRQdzitOjHxANYmbst74exFlVOyRArucxQ65
        b+rBEU9irpWEV5oX0PrBS5jPOZ1L9S5hO8dLi2b5K7N+EE0DfSiPjUXnmyYQDnaP
        ao4lRKaKe2ib2rOUygAHfC7Zeni2Zv5fe+Wg78FFtQ==
X-ME-Sender: <xms:KEfPYngfJI8Qo4Mt0kV9f4bDrbb7of9kkLbi4Z248w2-dX9X7_z8rA>
    <xme:KEfPYkBSPcGAIaszyG5AyBzDOemdEXE6Pe0vzdlWV-e3RzNTwNbcx2aQQya9N9SYY
    5HwB5Cc2_q8TahUbw>
X-ME-Received: <xmr:KEfPYnHdYak3m_V5tDE5n6tejPB-A5h3YMo8Lrs5EK7tqODDY5fWyB7XbXf-ncWLgyBEyOrrDqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepffehveetfeejveeikeehueejieevgfeuvdeifeelueeigfdttdelleehveel
    vdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:KEfPYkQ7rnKXtAQ6QCKpTEbbjwOdHHyGla-4dojnUGRFvX9bxoQP6A>
    <xmx:KEfPYkwYYjRzL-21FtNgEp1hO9t5B2H5lX5vefTfm_1tkH_yrt7iVg>
    <xmx:KEfPYq48jz6fqVb6oDvbhd5manXI1CdtP_nlZKCDVRqWtJkwI8NYYA>
    <xmx:KEfPYv9igyFTVOJDc_vZMCUGBITuZteAp-DC7BXTekiSiKaWgjqSAQ>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Jul 2022 18:28:55 -0400 (EDT)
Date:   Thu, 14 Jul 2022 00:28:52 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mergetool(vimdiff): allow paths to contain spaces again
Message-ID: <Ys9HJFbvLh51GYuM@zacax395.localdomain>
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
 <xmqq7d4gbu10.fsf@gitster.g>
 <Ys86MnwhembiXRxj@zacax395.localdomain>
 <xmqqr12oadbk.fsf@gitster.g>
 <xmqqmtdcacr7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtdcacr7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/13 03:06PM, Junio C Hamano wrote:
>
> How confident are you with the "leftabove" stuff?  Is it solid
> enough that it is safe to assume that we can queue this fix on top
> of it?
> 
I would say yes. I have been testing it since without problems.

But it is also true that the "leftabove" patch fixes a corner case that can wait
until the next release.

I will keep testing it in any case and let you know if I find a case where it
doesn't work.


