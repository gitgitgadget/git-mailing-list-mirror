Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D3C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 16:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7C922AED
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 16:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgLDQqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 11:46:35 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46671 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbgLDQqf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 4 Dec 2020 11:46:35 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F6F15C020D;
        Fri,  4 Dec 2020 11:45:29 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute1.internal (MEProxy); Fri, 04 Dec 2020 11:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sudoforge.com;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=+3XtfZ+D0LIjdd7h+doloiuKv2jE
        erqiIbUUtS48R/s=; b=X9gDdE31EXlAbZr3NUvTrsCn7++g8GHGLqEFcbUbbUAD
        g0zL/ZQIwSz59cuV/jrn+wyr95UwjIlNT9kWTceKoSd1u97mvzfnGENqep0Ua713
        77m+ffUXekOLvAVhd+oVKO5z4d64vq+useI/OBmdICak3DGfbaJbsYGxgU0OZOXy
        rIrKjZTfdfvYSHdTwCweAQJVECFf4ZJQ6v0ImhMiJgz2Z4H9H9kHv6it9zfQdrnM
        7fmAGspLXVfaDTEw/V2/DXSmNAxXkreIaI6ntPxevDmBzbIB0Ik/kowQ6N+PGWAP
        IRk3i/5uPSmR2osOhv6N7TLgEiGXFoVfFpdNZc9NBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+3XtfZ
        +D0LIjdd7h+doloiuKv2jEerqiIbUUtS48R/s=; b=aoVTBBXl8NzFbuqGY4NBaW
        4X7w/l43WgNK14fRmEcez9XhDFFDh9PNaiL6SD1Tj8NkctxXKI56i2/Ys4VUY5mN
        k1O1GnwZhuHD9ehsw414EkDW1NEdq3xPmW9AaqGvEaKLwhIYsAYc+03sEqELubxH
        QY7X9B/bh1WgjkYsB/yD1kjEOpI428Mpy0cZUbWZXFWhQF4W/H7oL7dV8+MEihUd
        wguG+WL76jPjuTTfcnHeRwkP5B66JT/IHpfbziIOFsA2TrSFAlqpv1Xg7lY/0GiS
        yCtMEPbIj4p4+P6LElUxoou04B5Z+tHu6YUKB21WCo9goj340lqPbY/x+I5bwzcg
        ==
X-ME-Sender: <xms:qGfKX2nEfe6PJdsL_kH3hXihW6hs41ox6pfSARlHH1KUoXDxEid2Ww>
    <xme:qGfKX90SxfDe8GIOezgWBscqztZnbvpMoARUg547V8sVHcFCEQzAxMW6wz_czNb4X
    ajgDmrzqH892YLZCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeikedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvffu
    tgesthdtredtreertdenucfhrhhomhepfdeuvghnucffvghnhhgrrhhtohhgfdcuoegsvg
    hnsehsuhguohhfohhrghgvrdgtohhmqeenucggtffrrghtthgvrhhnpeeiueelueevvefh
    jeekleelhfejiedtvdfgjeeuueffffektdfhhfeivdegueeugfenucffohhmrghinhepfi
    horhguphhrvghsshdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvnhesshhuughofhhorhhgvgdrtg
    homh
X-ME-Proxy: <xmx:qGfKX0ru95Mude3yoUfTZM1jZ0zibqnVDmhasZIfSkTe6WN5PpHmyg>
    <xmx:qGfKX6ldwt1oy9pt6BU1n380sz_kh3Zxao-h6EN9J3tpsFy28seyQw>
    <xmx:qGfKX0179y1Q1f4zCgO_pRP-jhHQ4j_v88YK0Us44flpxyMdBl3q3g>
    <xmx:qWfKX1jk09xOqmMHjDYp6W-Gj6O94VLX3hMxLMbIaW3vTn0D8vrFJg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D614AE00BF; Fri,  4 Dec 2020 11:45:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <601563bf-ed54-4795-917a-fce6e9343b79@www.fastmail.com>
In-Reply-To: <CAMP44s2=3GrXf69jqVJ23U=N9QcmGb-dHP_OEqyb6MVTY2z7Jg@mail.gmail.com>
References: <a4ae4e1a-b457-4b35-878c-2714ebfc415f@www.fastmail.com>
 <CAMP44s2=3GrXf69jqVJ23U=N9QcmGb-dHP_OEqyb6MVTY2z7Jg@mail.gmail.com>
Date:   Fri, 04 Dec 2020 09:44:59 -0700
From:   "Ben Denhartog" <ben@sudoforge.com>
To:     "Felipe Contreras" <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Unexpected behavior with branch.*.{remote,pushremote,merge}
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm just now hearing the terminology "triangular workflow" (I may live under a rock), but that aptly and succintly describes the workflow I was attempting to simplify with my initial configuration.

I read the article on your blog, and the solution you propose makes sense to me, at least in the context of triangular workflows. I don't see any public feedback on your patch; bummer to see. Is it something you've brought up since 2014?

-- 
  Ben Denhartog
  ben@sudoforge.com

On Thu, Dec 3, 2020, at 19:31, Felipe Contreras wrote:
> On Thu, Dec 3, 2020 at 7:29 PM Ben Denhartog <ben@sudoforge.com> wrote:
> >
> > I have a few repositories on my system that exist primarily as local copies of remote repositories, in that I normally just want to track and follow the upstream project (however, I periodically contribute back upstream so they are technically forks -- origin is my remote, upstream is theirs).
> 
> Otherwise known as a triangular workflow, for which in my opinion git
> doesn't have good support.
> 
> I wrote about it in my blog [1], and I wrote the patches to properly
> support that mode [2]. Unfortunately they were not merged.
> 
> Cheers.
> 
> [1] https://felipec.wordpress.com/2014/05/11/git-triangular-workflows/
> [2] 
> https://lore.kernel.org/git/1398023106-25958-1-git-send-email-felipe.contreras@gmail.com/
> 
> -- 
> Felipe Contreras
>
