Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D887C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 18:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiHJSpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 14:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiHJSpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 14:45:52 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FB360522
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 11:45:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E6E1A3200312;
        Wed, 10 Aug 2022 14:45:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Aug 2022 14:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660157148; x=1660243548; bh=SknYOyUODr
        LxytXnBMnBkcDI70g+pvbcAj5pS5Hv/80=; b=BYrsDOjlSLE8WdpWxlarJs3FDl
        dQWT3y+GtaF87UO7a2ltebaQWrJxq8ta59KhPkgHhI0IvIVSIkEORnPlaYC5CnU4
        QZhourRYWluxmpQbveJUWqbdHqPtXMSiMHkDWjSCqA06csulSQEl6SRMrRu7ecWh
        p1EvL2uTcdpg5VZBGvQeVzF+aV4Zj6vFeDHGliWqjuNwjxh2btSe7WJXhSTn09aV
        DOmW0FMmK0zvKffx97l1a/JLd/UAOFp9VHAYzVziiaynungduMwBDX9m7gA838l5
        tDQ8egAN5a6N8RBr30L2IJzxyaUABpdok4nB3KdKcIF6TMCfvvwtdUPE9D6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660157148; x=1660243548; bh=SknYOyUODrLxytXnBMnBkcDI70g+
        pvbcAj5pS5Hv/80=; b=IPYwPrgEVZdPOOmNwPycucK/W7s/rEYeAWJSRTrLZ7RK
        LFitBiSOjvGTjw0DcEstfNTMCXPxOAEUT0MQR/K3B06xN5fWkrzD7mXi5kT7dBwr
        XfFvTN5XEN+L5C+SnX4DUyyvJcULGpuGbplOakNKkgTnc/KqL16/MuFfXjAHGFle
        f2/IjqZyGpUh6deRVuq13k/+rUgCgutedD9DH32LOnv30uxbd6DH6VyPFcOF4A9s
        Lihc57BB9H5enwDvVrR31tRN+za6qAxEbKyR+G/lavgG2rQ5ohtQ9Rc4xRWyOiST
        riNeJ50GcAZmDKxVAm6+xC/h6e0GEFLx+PlRtkmMoA==
X-ME-Sender: <xms:3PzzYo_Uwjgpz4AM98v6do3a64h_q14X-o0UiMVx12hXa01nbZXucQ>
    <xme:3PzzYgsXt3NZqR-4Hw9b8ExwBUSk8Fyl4XtfI-D0r6rrE9Laj2CMlGntpP63DbJNQ
    wwThK0tbxSYeligbA>
X-ME-Received: <xmr:3PzzYuAJLYNOkZfFXbAuEjjCJxiLlacJfnhU4GIm7mkjbDcscmJ4IEWawTljpPZUoYHVn_dHU1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeffheevteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheev
    ledvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:3PzzYofgb_B3kUQsJx24U5K_AOxy-DBbV7UZjdZw8G40eLvOlkx6GQ>
    <xmx:3PzzYtOnEy5DZLRYwuGJQzZpXDCcWPmJyrMLxyIfWNyWkgMKG-VHiQ>
    <xmx:3PzzYimjkHjLgleYWdrNfjPpr3-ctSkujtQqqs5CAGBgfP54gy0PMw>
    <xmx:3PzzYvWCnZcgI2JtUC--n4gbjbjTb25tijklL_uF2a5aYv5kNxZ9KQ>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Aug 2022 14:45:47 -0400 (EDT)
Date:   Wed, 10 Aug 2022 20:45:42 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/7] mergetools: vimdiff: regression fixes and
 improvements
Message-ID: <YvP81vtZd7DlvQDa@zacax395.localdomain>
References: <20220810154618.307275-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220810154618.307275-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/10 10:46AM, Felipe Contreras wrote:
> Hello,
> 
> These patches make vimdiff3 actually work, along with many single window
> cases.
> 

Thanks Felipe. In this new v4 the code is even cleaner.

I also manually re-tested all the cases (with and without .vimrc) and verified
they work as expected.

Reviewed-by: Fernando Ramos <greenfoo@u92.eu>


PS to Junio: Is it OK to reply with "Reviewed-by" to the cover letter or (for
the next time) should I had individually replied to each of the patches in the
series? Thanks!


