Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB97C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 17:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbiGHRGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbiGHRGh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 13:06:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E76050E
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 10:06:36 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 941775C0060;
        Fri,  8 Jul 2022 13:06:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 08 Jul 2022 13:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1657299994; x=1657386394; bh=/Twyr7M5LY
        wgfytMuRdQkovL+TEI78g+RXzNtN5LpcM=; b=are+LvyY/eIP0PHldgtMK2UOik
        SqUMOu3ucUKD9sJYSADpbR00saPbI2f0R4P+AHUW600N0vtnjXzeGi9NUfcaXP19
        BWcLy18GFc25MwJxb+o1Fj2ngF/oJtYUbXDoRJ+zkNoPOgyW1X3ofUK9qPEWHT1O
        hixMRKNLQ3LANjPT0KEWQ2KJfiXZ9SA7J42iGjpBcw5aQ8SXPM6njZZdGKfv7Bfq
        OvkHYUbJfTDVetwdQlQFBRZQDRAVojpi43KhhYbq/DV0t6LTeRR+9o3ryHNmu8BG
        XDpZ1VhjwDZuI+1uGaAqy9gJYbq/NPSi/EO509kykUVbKufnRNyqkgoNloJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657299994; x=1657386394; bh=/Twyr7M5LYwgfytMuRdQkovL+TEI
        78g+RXzNtN5LpcM=; b=YvJsV3h8c1sBhSys0elnuRGkMJbKOyvehF9pWoQFwgDT
        pIKdoiImEl3enh/WsASKjWVw4r8wtEfLKq+pzvlgR7F1hwfcLlnkVbHMMo0Xg3np
        doiq8Y2VsB4i+GQPWsyoJy1fdXK6KBwmSZCoJLvklaQpuBvWuKCX6GnS00A5HEgM
        LI868RijMAOv0rocTccJ1xBqm9vT768FzUFcOv+eO8s8WHe+K2NfX+QZqiqWnvC2
        CpmhUjwxyCq2em5XVFrjcnLv1oT0f4MlllPiO7r7FkswM1k7HYeKsiMgnLf+picA
        Of/EJgjFHBiB48q9/E5FFoXJa0v/0KLtuY9l42fQ9A==
X-ME-Sender: <xms:GmTIYsTBgLjsasTRluT_slYgBMZqPWgXY9h2jiyKjxL0VMIfa6yy5A>
    <xme:GmTIYpy0jh30o55RvzpdVvlGz2B3r2EOCJIHgBytPDbLMWdYzQ7ar23FB3QnClIfe
    0jBk4PPlm_czY7E9A>
X-ME-Received: <xmr:GmTIYp1mN4sjmvfIJ-4KXxnAD49ZgZx0LqZeuIMRvu3cEsXiu05u-EbJBovQedNjir2kP7gofOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeijedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeffheevteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheev
    ledvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:GmTIYgArZxAvhMNlrnZleRN9Sn8gNWZsWFHwzp0npacauysykopIEw>
    <xmx:GmTIYlgT04y-DaGNUL8SbJ7GJGl83AQpPC33USP-E-b51TXdBNuZKw>
    <xmx:GmTIYsroRj_75M2h6o7bmiexLN4NYu8NYHLo2EbjBuODmdTk0fu6rA>
    <xmx:GmTIYoszvHBBNX1veKI5gBacwNARtRHNPnVh24S4gN9_FcJL3WgqOw>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Jul 2022 13:06:32 -0400 (EDT)
Date:   Fri, 8 Jul 2022 19:06:29 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>,
        Matthew Klein <mklein994@gmail.com>
Cc:     git@vger.kernel.org, Fernando Ramos <greenfoo@u92.eu>
Subject: Re: Bug with splits in new nvimdiff layout
Message-ID: <YshkFWZfBMbuN/tI@zacax395.localdomain>
References: <CACRpdvnuAYY0U1_3uD8zKgtq05+bgwjzXpZKomro6gqYDNrjGg@mail.gmail.com>
 <xmqqo7y0zrp3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7y0zrp3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/07 11:46AM, Junio C Hamano wrote:
> Matthew Klein <mklein994@gmail.com> writes:
> 
> > Hi,
> >
> > I encountered a bug when using the new vimdiff layout format.
> 
> Thanks for a report.
> 
> Fernando (the author of the layout engine)?  Can you take a look?
> 
No problem! 

The description from Matthew already includes a proposed solution (thanks!)
which should work.

Let me implement and test it this weekend and I'll get back to you.

