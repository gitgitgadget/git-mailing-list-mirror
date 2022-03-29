Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39F4C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 22:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiC2Wlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbiC2Wla (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 18:41:30 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC3E231AE3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:39:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E43333201DCC;
        Tue, 29 Mar 2022 18:39:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 29 Mar 2022 18:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=Mcc9UCmJP5AhJ176jfaTM8gKd7nJTcOKirII8e
        myzhk=; b=VjmJjUrNOag6I4tCbhPed7GrNkgpSgBVFjtN3SqzTBVeB0skix1dpj
        yK1IiHpV4Cc4Z2TK7ekHUYUKjhEe7/4Hieg/sgi+RyFiFFA5PDSYNTBjknQJEkN0
        wloSRWaMTzi8qAnFAn/hQrdjDrR5fJF53CFSWxseeMeaTuH5SgBVA2medJCaRxDn
        ze1XYq4WUpRRKQG1mARS6fjmMZQ/QgBCojhnIY20eTZqLm5iChwbUyP5dHS0Gbl0
        T2/RRMNKK6yURy+wlCUmWKHKBcj6LBEH/L9y6ogKy+Wg+M68ZN5vop9YXG3ieRac
        /dchu/w7s6sQSZIxEDankiO8EPQFv8Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Mcc9UCmJP5AhJ176j
        faTM8gKd7nJTcOKirII8emyzhk=; b=mFuiTn35jnxnwlld+m+DBIBw6Ozon1Aox
        7k6/wNagSfUpy6PzuFKO4b1315XHW8xsuoZVQ36BSfG89cqmgs0eYSia0wdln4ri
        iB4BjwPQgoXNH4ODDYGGxRbTyIjdcqaWuEQOpHYKWfQCwZP/mPtYctoGA+JWJ2xk
        DroHhbFVCBvz/TbqEEsEOrKFCdgZ8sArpoLYGiadr89lzbG2y1NO+mOjtS+i0G8T
        zHdp7J07iN6AF9E6FDzuSIAZsAuZeNGQ+lXQHeJpuFNIrsAvP3mEs/l6iUNj1IEE
        2QsEVk7ZElC0Y4js3Ls70VqB6JjHBaFiG+UR50U0HJNTvQV0H0Icg==
X-ME-Sender: <xms:sYpDYpmeserAopCGgVrNQIvccDnXoCXjvi6dSTXyFda4NuVwQJpuyQ>
    <xme:sYpDYk0ZIK3w2xxwReZOXsZQG62569pV55ACJXsI3W7f4nf7pHyHl3eLTghMd7fn3
    k-zK11H460f5iqerw>
X-ME-Received: <xmr:sYpDYvpLwp1VJS8SWs83MN72MVMtLLbH-kEIlkfxjsNcRydz4VyzeYiOqFPg6WNhpIyT5_-K1fM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdortddttdejnecuhfhrohhmpefhvghrnhgr
    nhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtth
    gvrhhnpeetheevvdejfeevieetjeehtdeiueeujeefheekudfgueefkeelffetjeevleeu
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
    gvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:sYpDYplhWNfAQTMeBgNn8VCtqbg1wHirus7oDHvBg7zGqvbacQYshA>
    <xmx:sYpDYn3IoPvRS_WS_v1fwmHu6-_IsEsHp_ad2hnPMzez4Z39c9nSYg>
    <xmx:sYpDYotHuFGGp-1vKFSRBWHwx8K8CmfY-MZsiB5dA09BhCiYnvm5Fw>
    <xmx:sYpDYhrcF-OUxngETEZX1N3eFQhtcLc7JTriNWoS2NN7oa1jdq-ouA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Mar 2022 18:39:43 -0400 (EDT)
Date:   Wed, 30 Mar 2022 00:39:40 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: Re: [PATCH v7 4/4] vimdiff: add description to already existing
 diff/merge tools
Message-ID: <YkOKrNMpOgfxTTWa@zacax395.localdomain>
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220328223019.271270-5-greenfoo@u92.eu>
 <xmqqh77gww6c.fsf@gitster.g>
 <f56a7a0b-8525-c4cc-7bc7-5ac4bba59206@gmail.com>
 <xmqqmth8twxr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmth8twxr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll prepare v8 with all the previously discussed changes so that we can
continue the discussion there :)

