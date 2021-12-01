Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4DDC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 18:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352435AbhLASxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:53:17 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43721 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244640AbhLASxQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Dec 2021 13:53:16 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4BF7B5C01A1;
        Wed,  1 Dec 2021 13:49:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 Dec 2021 13:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=yN25uhzGLH5N2AUT5gnEqxStWUw
        Fbk9SuPDZHpRoa1w=; b=MMdykqIDP8ZJ17XVCtRO2zvcw6bL7c0BltQS8507DIH
        2utRqxOJcCoAFLxH8ogE51proaGT2VFGBBYdAoxS2AO4SmuITSt6L/V9M2GWSt0t
        JNXxW+lLnlBXf93+rXL4pBL20tuPeJOy9Rc8Oo97lT43UBhLGZJE8JtCX+XZi0/w
        FZNtXEjTj6ky73vpMdkj5yn2crrvmNleAOpmWS24NXEytOJbBU2cHagcj2+Fnbgd
        o2xZMRuWA9ijy8l5iJMzCQ5Iddrq+Xx7uY02Udrz6Z1rUKsY4rTYTCyGvZf1unaE
        f2kZO/aIDCWL2B5ZF3L9R8cay10Ybe0nnhHvpU8KpNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yN25uh
        zGLH5N2AUT5gnEqxStWUwFbk9SuPDZHpRoa1w=; b=NyZpBrDIjWZbMk5yj7A7M5
        clJPIP0Dyh7hFbub4YxrZyOX8dJRBHf85mLDMyl0gTg5TET+qkuNSaLQRsoAMwsV
        LvzibYChsDrMahVJSO74iZQgtSVGYa0arPUHJumSo0pQSParcc3I5Yg0jzLgduRn
        KZFy1F19ULpeIZNh0SkKbz/orkhU0K6eBhNaoY1PjFIDUkt4BtECbJal8mPXaxT3
        HZ5x63kaSrf45gu+Ey69Y0abGNP1X7MYtZ+1/ppSM5eulL1VEX3T7KGHm73YWLf8
        b5nyPzQMRsYscoyNTygS9F9M1dc/1XJYnoj0AZqY7vVmOtNwo6Oiwj47mJZPhNrA
        ==
X-ME-Sender: <xms:0cOnYaVHzcHANkYc2jJY44CPNE_fNLPnuTn47AR-Sx5_63CUBwJjWw>
    <xme:0cOnYWnb11xm4wDbXXtnd3uW0p4cA0gtfo6VRgKxh2Do2UJo9OkpoI-LNTRTXADwu
    esmkZ2RwbI25eHSDQ>
X-ME-Received: <xmr:0cOnYeYZNcEjbED928lRwjr6tBb03vh8pjc05xChUX8-aMNHAyhOBIy8ofzNOZC-NcS67zCF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieefgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdortddttdejnecuhfhrohhmpefhvghrnhgr
    nhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtth
    gvrhhnpeetheevvdejfeevieetjeehtdeiueeujeefheekudfgueefkeelffetjeevleeu
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
    gvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:0cOnYRUXzJEcAOiBDArUNuxBKvNgx1BeM-OotqPZXaBYKtuZUYxbjw>
    <xmx:0cOnYUl2Qir61QA_7rr7113l5IMOvi0iMNQQ2vqnRlvkwN7GpTA90A>
    <xmx:0cOnYWePxI7rdovkF2-qEnfTxpGHklhUYW-KkhH-aWEHcMfwDcHPmQ>
    <xmx:0sOnYTvsAFnu9fcim2ulbS8ue5OyI-VY9-71OVQ6v2N77x-ZdzY9sg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Dec 2021 13:49:51 -0500 (EST)
Date:   Wed, 1 Dec 2021 19:49:48 +0100
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        rogi@skylittlesystem.org
Subject: Re: [PATCH v3 0/3] vimdiff: new implementation with layout support
Message-ID: <YafDzJmSHoiJFmKT@zacax395.localdomain>
References: <20211130204333.174967-1-greenfoo@u92.eu>
 <CAPig+cQg=P1BNCwfmNAE3oHZHh4CPJ5QNQh-vgfOQDGGwenMow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQg=P1BNCwfmNAE3oHZHh4CPJ5QNQh-vgfOQDGGwenMow@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/12/01 12:03AM, Eric Sunshine wrote:
> Just a side note: I understand that [1] recommended adding the "$"
> inside arithmetic expressions, but by chance I happened to be browsing
> the history of CodingGuidelines and ran across 32b5fe7f0e
> (CodingGuidelines: drop arithmetic expansion advice to use "$x",
> 2020-05-04) which dropped[2] the recommendation to use "$" inside the
> expression. Anyhow, certainly not worth a re-roll.

I don't mind preparing a v4 with this change. I also think it makes the code
cleaner. I'll do that :)


> By the way, since you've removed Bashisms, do you still need the
> `#!/bin/bash` at the top of the script?

Good catch. Will do.

I'll wait a few more days for extra comments and prepare a v4 with these
changes. Thanks for the suggestions.

