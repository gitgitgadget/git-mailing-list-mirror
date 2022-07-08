Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C05C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 18:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiGHSO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 14:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiGHSOz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 14:14:55 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E695E7D1C9
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 11:14:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 316EA3200907;
        Fri,  8 Jul 2022 14:14:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 08 Jul 2022 14:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1657304093; x=1657390493; bh=mirSj0mzYs
        arS5dUMQM3Ouk7tmlDgjA3zCxnYQLAiog=; b=0IikfymkVBAF8iIdBGDJUXgln1
        /GpgR8QvLu1ZYa2bN6dtGewgxTV0JhUow3WA+HDrMljbuAI+67fgfiZccdWEKmRK
        ejx1rkx6mMg+b9BDmy7jK4krVX3RjdQztaU165NkSU58+W83tiktV05jxjtwE26s
        Das9AzYiyOy6HmWIcj+6mJmDqx6gIVVemmfIYOgQPCAQFqWmKBPDLNgDjso35I5T
        jiMk8FrvEdpmO4uBZHA15eZx/GrnkPmytMxWuB39TANKY3JScyuNZ9tAhTfb5JoT
        1oQhVsrzbT2X8N+DAwqaz40tyGfXEsJvfD+/LZp7uyZL5VIApqbHupEwK7SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657304093; x=1657390493; bh=mirSj0mzYsarS5dUMQM3Ouk7tmlD
        gjA3zCxnYQLAiog=; b=mKGAtmF/Wm4Cuk15FOwWuMK42Vsq7xckC+IKlESRzkBf
        iS7bV6AlfLbyrx4osHbOavqfAhH7I6vA0PJ/T5zRUV7wEs9KDWY+ELKl+1kMumzq
        bYVSa6GchTr0DZ7AoqJLDL//u98zuWO5G40axQzjSsrVleb+QOCF8m4FdmsaSAom
        KUOpAz7qT90uRWWEQk47jieJY6zdPErSkXiC/Yz+wTD84ga/I+L5Rww4Zs19cckR
        VutN7MzGIZNvNVG199rC/1mZRmPWylxOdILp3NIcXIck0r7Qs1ufzgr8Kce2r5Qg
        +RGKD772A1Gt7BfnB7u/dIoGknoYxAVsbGStH1hocA==
X-ME-Sender: <xms:HXTIYr9NmJbse2IAAb-Lwnwbe_f6QNpUzrFRw3-ggxp-QtX11IEphA>
    <xme:HXTIYnvQvIp7ufz4Rv75DD3gCkfO6Fogru1smBltUgxbVrIDSZ6ArSxaylzvLYkkR
    5J3wzSV-eHWMNhl-Q>
X-ME-Received: <xmr:HXTIYpCed4gyf5s5BG0Cu5ZqIXngb45oOCeXjY8oFBh0gg0bpQ43o4e_kXN32VWZkQuNgWfN5B8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeijedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtjeenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhf
    ohhosehuledvrdgvuheqnecuggftrfgrthhtvghrnhepffehveetfeejveeikeehueejie
    evgfeuvdeifeelueeigfdttdelleehveelvdejnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:HXTIYndPB-UfjPFvR3cJharB3ppRn5lczXxyGUI6mbKe8TVj0eZGVQ>
    <xmx:HXTIYgOEecXeq_n8zzwfNzVCJix5GTN4u2n8e2D7UoUr9RXsHKGH7w>
    <xmx:HXTIYpmDAg9eo2I1kxCrSsGXBG8tHvzVo7txkTpq72OKxZoU3Ioz3Q>
    <xmx:HXTIYq0y1pArFDugEX3C45I9eloaH-EUILyRCn3FjFvJPcxy3LrwiA>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Jul 2022 14:14:52 -0400 (EDT)
Date:   Fri, 8 Jul 2022 20:14:49 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, mklein994@gmail.com
Subject: Re: [PATCH] vimdiff: make layout engine more robust against user vim
 settings
Message-ID: <Ysh0GWhYiyAT21Nn@zacax395.localdomain>
References: <20220708181024.45839-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220708181024.45839-1-greenfoo@u92.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This bug was originally reported by Matthew. I have verified that the patch
above fixes the issue but if anyone else can also test it that would be great.


> Reported-by: Matthew Klein <mklein994@gmail.com>
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>

Matthew, I have added you to the "Reported-by" field. If you prefer to remain
anonymous, please let me know and I'll create a new patch without your name.

Thanks!
