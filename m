Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696CDC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 05:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiHIF02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 01:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiHIF00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 01:26:26 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4196D1836B
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 22:26:25 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2BA2732008C0;
        Tue,  9 Aug 2022 01:26:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 Aug 2022 01:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660022780; x=1660109180; bh=iNDKha6UHr
        89JVYC8T0TWc1PxCua+wrKCUiKDRs3mc8=; b=QkhVyD4Y8+H4xH1E904mnG0pEm
        /7+thqulHjp+RwQyjJmksbrosMrxSIrRTSUduirDc9QDXN9sFPuOhZveub0hKTO0
        oed1QNvnw/TghTOd6LWXpu4Pn7oQosZrfVuaLt/zHhhFb6sVrrk24G2tMhEB0smi
        qrBjuuB5QcEKfDw2DildrVRRS0vyWCgkJNhtlSQQFSkUsl4GBJGUC5bq0t+d3G/h
        hK2od1CPIvGgLSYU2NuqRzy+dwG9EVsXAQNPxW5+vGYGNsNo3udlhejJlhkqnHG2
        fdNGIyAg/Gqr8teysvITjNSGuoC1iVaNufxX8QE2rdImLOGhJ/teB3VNt6BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660022780; x=1660109180; bh=iNDKha6UHr89JVYC8T0TWc1PxCua
        +wrKCUiKDRs3mc8=; b=fAuwoYHI+K5l3N21nkfSFWGA8KegT7EkNf5R5lu3JKvF
        jRa2865sXeDAkqKhXjXfjAN8yE5ZTrX1cm6MzlelEaK1zeqmZZolC0yFHwnpiOmG
        s8pbgl32Q0K8e7kWgieZnM7wBsaW8Nzfh8K7w3EmUfUpZXd62+pJrs7h4UUXoEGp
        MC58ZIOMVmbpUBjxJD0wWN/pGSow0Dnxz3xsrPv6g0YkarKAJ/4Sy513YpGh+f9i
        IGfkEDY0kmsF+Q/3s8TAnMGYKoTRZWyis4p52GL9xQ29CWNZ5ovCYn5CE6cTzs7m
        w8kZLJXaCDhPHzcbvxD7/VknBPqZVyOfb6tPwNnEdg==
X-ME-Sender: <xms:_O_xYrg0hs_ThydYJxkUydYkt1KgBAXxOILI8lyYh-W3qRvlM7Gq8Q>
    <xme:_O_xYoDeF2EdAvWRJ9YDGTweBa2kRbny7Mniaq-30uOz7ilCh8Ez1IL6sns5X5xx4
    2LgYGhUEZ3aXn6lew>
X-ME-Received: <xmr:_O_xYrEUcd7dSmz3gtiIvuOuEgY4O0XDDYpM5hcloKutRnxWp9A81eLVYizwxnnZFPlPzqTzBss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepffehveetfeejveeikeehueejieevgfeuvdeifeelueeigfdttdelleehveel
    vdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:_O_xYoRBzCS58kzZbA_1F2P6pocSspyiIRsIX0b-KXTrkAzK9nRd8g>
    <xmx:_O_xYoxByEfcstFrDGyYyxS1SjqavfYnhmMEs6Ekbe-DEPuTMIOZKA>
    <xmx:_O_xYu5MHtGR5c5hD6iKqkf9ONw5cMy4hDTDfV54cZJ9w7uax0sR6Q>
    <xmx:_O_xYua2T_1fSHoKEC2uDLBpJEcOfUwlaGn5zgWTvxp4K1auIJk6PQ>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 01:26:19 -0400 (EDT)
Date:   Tue, 9 Aug 2022 07:26:16 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] mergetools: vimdiff: restore selective diff mode
Message-ID: <YvHv+EcNyHXCNZhK@zacax395.localdomain>
References: <20220809004549.123020-1-felipe.contreras@gmail.com>
 <20220809004549.123020-8-felipe.contreras@gmail.com>
 <CAMP44s2RsvXnt8LtDcv+Ai_kCxmtURGWXmwfchO08dhjMxkGhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s2RsvXnt8LtDcv+Ai_kCxmtURGWXmwfchO08dhjMxkGhA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/08 08:08PM, Felipe Contreras wrote:
> 
> Notice that after reorganizing the tab handling my layout becomes really simple:
> 
>   set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | 4b
>

Thanks! I really like this new approach.

I also manually tested your new series (with and without .vimrc) and it works as
expected in all listed test cases.

This last series gets the best of both worlds:

  - Highglihting works in single window tabs even when there is just one tab
  
  - Single tab layouts are not treated differently

  - Generates shorter (easier to understand!) vim command strings (nice!)

  - Opens the gate for a future configuration option that lets you enable "all
    buffers diff mode" even if they are not visible in a given tab (maybe this
    could be a new syntax token, *, that "marks" a tab to work in this mode?)

So, definitely a great work. Thanks for the deeper look at the problem and this
brilliant solution :)

