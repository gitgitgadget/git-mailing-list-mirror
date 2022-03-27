Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F90C433EF
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 22:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbiC0WTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 18:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiC0WTg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 18:19:36 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38CA4EF53
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 15:17:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2699A3200C17;
        Sun, 27 Mar 2022 18:17:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 27 Mar 2022 18:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=GK2VbSHJlWgJvwISPqi8Ju/C/ZcGJkx51Q1Kqx
        Qdrrs=; b=nWF3h6v0wR5ZdPbcIxTj9U/8aO3dnjaMSjtO+aP0uPf6RN0M+LqT7T
        wk39fho8QPD885YMD3bYgSP+lS2uqFPQ5898G9+AZ9dMyja5DI06whNraZoeBSIB
        C/oNcCSA3D0KPSQ18/r3FTSE0vLVtKXmzLQSVIy+a1SjdekXVV/HS8zXjbPqv0rt
        UjDj2AV3YatLI62KiJO72A0CIjG6jP0EGM5Pqvlv5083+SRB+iKSrN20LJsu5BLr
        aoe/eQcHOHPU6VRRgw305V+xsP1x1ku4J1olF2rZbpfQgmlLrdSna8u0fsE70JgD
        BwwDPfU6FQUMAS+rdqe0ZE5c1MYAf1YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GK2VbSHJlWgJvwISP
        qi8Ju/C/ZcGJkx51Q1KqxQdrrs=; b=K5HrBaVMRkfLufrH248TCz+BHS2AYPegv
        vyx2sjRbpz2Aye3zSPEAHtIJLwoV3mXzZJeBd+CroMGcvcqX8yjgwKhjzIMHKbZ7
        ZOJL1Kw1t4Q3cvFoAkwTHGE2oZRQBh7JntjRN+OBGL1XEigIXRMfE5p3HMelCngL
        8cAeu85jr/1SqUQhH6XbDIXFnV5oefA1YO+rLg6KP1/DrlVB3om5aqXbKD87xxpq
        etQoiAL7/zAH/tR3pSYQM2JG+QVT1PBAHEzDdkM5k4YsljyFtzmylj2MoHLgc/RM
        kAQTz4+EzW84W9dldWGZ+zayf3A5RmZrmHdnYMiv0GQxgji2JT5+g==
X-ME-Sender: <xms:keJAYk6-0ktkH6BKsw2o61K9ZKBbZc9YfGrkOs9s9Y1dDj1je5S-Ig>
    <xme:keJAYl43k_tUEVNeGsiZnQFX52ec-cu3W4owS0T2NFGF0ki0dZyE4Dhlr46y1D3RB
    w9snT0jN3UHLZJ_-w>
X-ME-Received: <xmr:keJAYjdfdeeAz2LXV516nyuivrybOImta5Jxdfjqn74sfmvMEyXYtLBoRS73D3s6gbQU58gjbbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehiedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdortddttdejnecuhfhrohhmpefhvghrnhgr
    nhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtth
    gvrhhnpeetheevvdejfeevieetjeehtdeiueeujeefheekudfgueefkeelffetjeevleeu
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
    gvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:keJAYpJgHL4R9tjy5LtFm2BERtdhDvuod9bIAjxVhsiDsa9z8aEk8A>
    <xmx:keJAYoIOtE8UQNOjgSqu-tUz54ihmqOT0UkulUOXEtwdcn6PbSxRIA>
    <xmx:keJAYqyVcVGEv8El9HI-W6ZEQZ5xCZTPGW3dgZxcSSxBPX0ALkBqmQ>
    <xmx:keJAYiiNbHu_TGjahLcBZu3MvEA5oBWGTo9O1ap27UCEx7_Rgvrm5w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Mar 2022 18:17:51 -0400 (EDT)
Date:   Mon, 28 Mar 2022 00:17:49 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org
Subject: Re: [PATCH v6 3/3] vimdiff: add tool documentation
Message-ID: <YkDijfPgoiVObrFD@zacax395.localdomain>
References: <20220327112307.151044-1-greenfoo@u92.eu>
 <20220327112307.151044-4-greenfoo@u92.eu>
 <001d3ecd-e1bd-39f4-5123-4a8b1bd1b5a8@gmail.com>
 <YkDS3CJEPYpzRoVG@zacax395.localdomain>
 <xmqqmthb5aw8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmthb5aw8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Are you signalling the above part that it is (or isn't) included in
> git-mergetool.txt by defining
> 
> 	:git-mergetool: 1
> 
> before the piece gets included with
> 
> 	include::config/mergetool.txt
> 
> See for example how git-rev-list.txt tweaks what gets included from
> rev-list-description.txt by doing:
> 
>     'git rev-list' [<options>] <commit>... [[--] <path>...]
> 
>     DESCRIPTION
>     -----------
> 
>     :git-rev-list: 1
>     include::rev-list-description.txt[]
> 
>     'rev-list' is a very essential Git command, since it
> 

Thanks for the hint. It is now working as expected. I'll include the fix in v7
together with the other fixes that prevent `git apply` from executing cleanly.
