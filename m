Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37C4C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 18:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9FC2462E
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 18:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7z2S9G+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgKQSCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 13:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbgKQSCe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 13:02:34 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8FC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 10:02:33 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id w67so4748397vke.10
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 10:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RR+fXeVav7JRFq1q9gIJXDIaxmjSE1Z5tpLYBJPRKVw=;
        b=d7z2S9G+G02BVKNz6X6GngjCilBn0C4tN2hjCrxkNfiZomhGN0/3E4oas6tFzW38SB
         R2Q5LSP9EKsDatsSc5KAv/q9ue5VUhBq+ZPhhdLaT9H85S0Owp7gweesUg8m6SZWun3n
         vW0TrHEHBnb697jsUtQjDm71UrTn8fAu9iADTCu6ktLHXaXRElfAKaGrUzxPhjfUsirn
         mvnTb+8CdVvZWmN0cdcGRGPzcGj1nOcBrHln6ybm1/xwrn4CLPnAYz7Hm759ApdDddLT
         sm4lS1vDUHGY8kZAzM4CmGQyeL2hN6TkMYZJTk/H+pmrcGPtSt/f4rx2NCcDld8btmMI
         4L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RR+fXeVav7JRFq1q9gIJXDIaxmjSE1Z5tpLYBJPRKVw=;
        b=ByeQY2PYcEGazHr+ZFjPqLJu7JZVv0098iGB3YKmKbNxMRe39xcNU0i5WVclAxzBHx
         nYGKhlyxqYEC5y74JBNRCLCRCv3yZKuDQXxlh+qq+l+wRU+uqKI4j51TM/gD9+BZha5+
         2J1cV1dZDqWBoaf/jfCvR85Wzg4Hvm5e8URRBoGBetRmqKk0iYng4+2CoTaN/LRZq+81
         0sfyfVYG9FKyOmJkhHdObAZK4u5ktYckKad/JYWP/UbiejFEm47LgcNt5ro41AslM8Fh
         W2M4xJjHnUQm9GG6EbsQVI+EHCD0CEiPp0nVUlZ1tgYvPKcQ6VkH3M+srQIzZXekd8GK
         lkvQ==
X-Gm-Message-State: AOAM5313nZd2RndzP7wladpE+y3e57Qo2pB54oS4+cuARistk8q1A3S4
        lTs0k17jGdU8PTCVsI9EZ/H2ebHMUq3bS6N47Jy6k0C321BKQw==
X-Google-Smtp-Source: ABdhPJxptvoBGcoYBwB+VFB/1mq9L5mKRy8VkMQzihf6VKDS6QKCBfSa3wz/fslZx4XkPbYHlfYOJ2kgVhttmP8pQqM=
X-Received: by 2002:a1f:5587:: with SMTP id j129mr614481vkb.0.1605636153063;
 Tue, 17 Nov 2020 10:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20201114084327.14891-1-martin.agren@gmail.com> <20201117021318.GA30463@coredump.intra.peff.net>
In-Reply-To: <20201117021318.GA30463@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 17 Nov 2020 19:02:19 +0100
Message-ID: <CAN0heSoGnAKjTz2tiHpe2==Y-w7M03eiEpW2hU67FRbv=G+H8w@mail.gmail.com>
Subject: Re: [PATCH] list-objects-filter-options: fix function name in BUG
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Nov 2020 at 03:13, Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 14, 2020 at 09:43:26AM +0100, Martin =C3=85gren wrote:
>
> > Fix the function name we give in the BUG message. It's "config", not
> > "choice".
>
> Yep, obviously an improvement.
>
> But as a general rule, I don't think we even need to include function
> names here. The message would look like:
>
>   BUG: list-objects-filter-options.c:20: list_object_filter_choice_name: =
invalid argument '3'
>
> which already tells us where the code is[1]. Perhaps:
>
>   BUG("invalid filter choice enum: %d", c);
>
> would be shorter but equally informative (I don't overly care here,
> since the idea is that nobody sees it, but just making a point about the
> future).

Having the function name or something else making the string unique
across the codebase could be useful if the compiler doesn't support
variadic macros -- we'll fall back to using a function instead of a
macro, and can't use __FILE__ and __LINE__. (You obviously know all of
this, having written d8193743e0 ("usage.c: add BUG() function",
2017-05-12).)

Now, this here BUG shouldn't be a "freak" bug which happens to trigger
under very special circumstances, and where it's not even clear which of
25 equal BUG messages it is that we're seeing. If you add a new enum
value and forget to add a case in this function, you should hit this BUG
quite quickly and very reliably.

All of that said, "don't overly care" also matches my feeling pretty
well.

Martin
