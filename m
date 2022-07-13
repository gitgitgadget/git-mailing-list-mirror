Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC270C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 20:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiGMUwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 16:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiGMUwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 16:52:43 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733A031220
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 13:52:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2CCF132001FC;
        Wed, 13 Jul 2022 16:52:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 13 Jul 2022 16:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1657745557; x=1657831957; bh=4obUE1AIRu
        AE9jSofVoUt0P5KfSBCT91uviyyrwKGUY=; b=B2y1W64wXkQ3j+0H9/E1/h2sms
        2IoZYwnogfDqHTDQofMg3xDHhWe7PhMFd05vELSpunzZc2dvvarixToYeu8JvBL7
        I2MHv9XSMccmjElzBVcyr/9Lup4dyPm8m8dRDOaN+4WvNqvw3jZGx5DXP5lJXONu
        F0YUrOvmsJRH1njkaMQfHGKzI+VYBWW0460jsy0x7zd0jHmtSiBDYxve+kgXwOvT
        JSbAb1EYa+uxq6lXWLyL38le1NGJ1Y4bHWOghBOuBEGO4sl0l3Xp/tctTYZA7ddT
        h6XmRYgRRZOsnZqJ3gU9ZiAMTzYTCnbRxYVu3L9I25OEMbRpjBxQxan9ZKZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657745557; x=1657831957; bh=4obUE1AIRuAE9jSofVoUt0P5KfSB
        CT91uviyyrwKGUY=; b=AxO8oOOs2tNDTSX0tRZfzxzax1C6JECzFts+44OHRjp0
        UCdUD6E0E43vDmVdR3srr+Zds5Sj457SorK35w7+xgw13xr53+0sLGttok1BVnsU
        7vmNfsOrVnasqUA1r6cbFAfSE9GBBM4Kh+9dr/zSUjNIBpCZhBUA/MUj6GBYpmIW
        PTKqSAmJWFeo0jVvYxkUfx+Z4GWDO3V+FLv58GLiV/DJIu/aHGtbnC4uwPeGairU
        8apJGZBsO8B1gqDW4yt9ooVtxcQi7qGLCN8uhWrs88DMFVmzlA/bR6n5dT6XbIxV
        zBKYBM3ntI2ggJV9QzpwkyesZ1lHdGJf7Z2KjHPtTw==
X-ME-Sender: <xms:lTDPYmKPcZDjuu5r6l3tRg5PyRw2wyrO5w4WciBb2noD60ZVNOJMbg>
    <xme:lTDPYuI0evnvntbFV1CxZd7EIv4KHlKClqVTu6sjDHHqrratmunO4_Os6hrkYkco7
    cvoqA_I7VIulmYA1A>
X-ME-Received: <xmr:lTDPYmvoQ7i2lh7rRwepzHy_EJ0OdheLdPjXiU-cVWBGonw_4K5pJ2cubF9iFJeP5Gg3ZeHXTiU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejjedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeffheevteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheev
    ledvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:lTDPYraDQcm-zyZjQaPX3HVSXKf1t3tA_ypQ1DqWw9sxi2Uu79TCag>
    <xmx:lTDPYtZcRglEwbhJ9wl3HVFpBW5YQSm_mL2JEyKDJthZjZJyXAIHuw>
    <xmx:lTDPYnBnjNSrGl-qWwpy8e9CAJIXbUShJ4OFQVSxQD3F6vqOmk_pXA>
    <xmx:lTDPYsnuc_eV6K0mFI9zojOUtVJN5nr825JnaPDMP5oG0OsLKfJVPg>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Jul 2022 16:52:36 -0400 (EDT)
Date:   Wed, 13 Jul 2022 22:52:32 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mergetool(vimdiff): allow paths to contain spaces again
Message-ID: <Ys8wkC1f2qc+7IX8@zacax395.localdomain>
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
 <xmqqfsj5dlt7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfsj5dlt7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/13 09:22AM, Junio C Hamano wrote:
> Thanks for a clear description of the problem and the solution.
> 
> Fernando?  Ack?

Yes. 100% Ack'ed.

Thanks Johannes for the bug report and the patch!
