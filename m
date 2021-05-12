Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA87C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB70061413
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbhELRnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245470AbhELQwr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 12:52:47 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A1C061244
        for <git@vger.kernel.org>; Wed, 12 May 2021 09:35:25 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso21095518otg.9
        for <git@vger.kernel.org>; Wed, 12 May 2021 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNFAk8AAS3/KlSHSK7qgY2NpPTRBPtYQ3T0vigMMwOY=;
        b=c8NJ6tR7gWiUPQZJCr9wz+2L7lYmDIdwUhnN785sDgkvkND3cxLD/8fQ2sDL0N211n
         HP9h4C7YTOj/xVOsdQteAofx9gNEATcFYCH0CgUF4MnqwJshZ1HedhaDq/Jb2AuzAN4c
         P/My8RHbGy5eVmP64Iu35/KX8JXqOHtrL6EXdtk3xp5AKxArPhB1VrZy4viUe2zeli4b
         XaJ7EJriNpjCRPZhB8cmweu1bDMdMisJA0+IsjFFgu5jt+OTLLL9auB8GZDtK1GOvCW4
         060mqiGgzBWCNb/b65QpgzQroLslNSaWJi7gRiV4WAQ9ZQucvcPldzKgtE2NkcWIxYW7
         +v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNFAk8AAS3/KlSHSK7qgY2NpPTRBPtYQ3T0vigMMwOY=;
        b=Q3BgvJsqXdIVCWjHAWW10LZICxfclcVikBaJgB6OZdPmzzokYBinhaEysqNNZzY+vx
         xWJAFit50yoUbTUdOhMLnk1aorpaTZraGIQaJwqpcRJa4goahfbg53NlZz88BWD44pbW
         XAULd4wF5ecFUDCnquCksi9XYCQ5LoARBjIUa9llAXj9x4AQP11ZsBFNdZ80tEdt1sFa
         TH58hxBKM2yQCJQMseOZzXbqDc9oTWuOnGKBit1XF8DMEvjuuZOBhkjpL2qBvUHOakxs
         rAFeRz4oBZTDorFmUHD//XmFjeFzurY00whgqVLjqp1++UaRTzA+CVQxAW0xFOxJbIet
         ovLA==
X-Gm-Message-State: AOAM532M94LDiGNpzBez9C/KcN2+kqsmClqX93E3uBRY8viQZ6f8Gf8G
        q7AkUFu/D0JqFrScghwVqKegQA6bUNEM6/Vc06ie5o4ALlk=
X-Google-Smtp-Source: ABdhPJzvAare2rOQ0RMm5Y0eHJYMUSQGiSe2e447CFQs6ZAEmpcQYFSFPyx0RaSt8Xu1HNLofBRoyHv2486iwqA5mo8=
X-Received: by 2002:a9d:6b8d:: with SMTP id b13mr8838804otq.316.1620837324445;
 Wed, 12 May 2021 09:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo8dgfl8l.fsf@gitster.g>
In-Reply-To: <xmqqo8dgfl8l.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 May 2021 09:35:13 -0700
Message-ID: <CABPp-BELhOx=Hi1i0GPDJoDGF_xY0UGmgn4w58v_9O=gkcb-kg@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2021, #02; Wed, 12)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 12:49 AM Junio C Hamano <gitster@pobox.com> wrote:

> * en/dir-traversal (2021-05-12) 8 commits
>  - dir: update stale description of treat_directory()
>  - dir: traverse into untracked directories if they may have ignored subfiles
>  - dir: avoid unnecessary traversal into ignored directory
>  - t3001, t7300: add testcase showcasing missed directory traversal
>  - t7300: add testcase showing unnecessary traversal into ignored directory
>  - ls-files: error out on -i unless -o or -c are specified
>  - dir: report number of visited directories and paths with trace2
>  - dir: convert trace calls to trace2 equivalents
>
>  "git clean" and "git ls-files -i" had confusion around working on
>  or showing ignored paths inside an ignored directory, which has
>  been corrected.
>
>  Will merge to 'next'?

Jeff had a couple small requests with the trace2 statistics, and I'll
add a patch to fix read_cached_dir() to skip '.' and '..' entries as
you suggested (and simplify various places in the code that do that
already by introducing a helper function).  So let me send out one
last reroll.
