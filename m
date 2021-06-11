Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA50C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 04:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592AF61278
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 04:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFKEpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 00:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhFKEpy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 00:45:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA90C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 21:43:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p17so6649871lfc.6
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 21:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5AQW4YCjzAa0wTPtw6VU02iJ2A5pIj/HrO+vLH43doo=;
        b=uMNVGt2KBG7Ja224VsMQ2Bisj+2kDqZ/oVovt1c9KATixviMMlVc9S16CZtkZsdytI
         VrRHUXO1BNzx1MBA+oX4roVBtswzacNrnTZTOyWSj5pekaXtAI9qUBoNimNxliU1lXKz
         jsTSLixp75FmM4QIoJp5JhusOQT8ToE/IWvOKniz/rkRLZkR82y1bLWXJsT6HAKOZIP3
         Gpmo8b6+DYc9+PszWZhPvvz9/5D6EbLnptgXIG+CY21MAOypV/3PwCOLvfFb0z15GT+h
         im7siIgPD9mrvCZ5kiq2pEcQDlwgVSfZoQFU3l8Hkn/Cw5gLLhUyFXU/pyYMWCGGrFb1
         EWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AQW4YCjzAa0wTPtw6VU02iJ2A5pIj/HrO+vLH43doo=;
        b=dI4P+DKY4AQMGpXHV1sHTRMxm9j4W3VRi62vCajVTiwCzyNRTm2EY5kIsIBJaHaxIJ
         VedD6fyCgd2ETa1FS04UZY8MrfRbryI8SR6cRCByyvmgjc8+DUbN/EyiowLSi1L/jbIH
         dsYVLIEsz229LuXM4co5VBRLJ15S9N0VqGzbBF1ngU6eFsgSqiKv7O0s7souzfJd1neN
         i05Dhq+1U5KTSTCRTDLMGcBTDqLDZGy9XXTh4NPbUvXjpIfVsnP+D3cCOeiGG7Z56uyo
         wU8X1DxU7OIdxJzWv8Mxph0nneMKns7Pf1mBXThDxV+e1xCjb7ETRiesxfRMaKBQxmWI
         pjAw==
X-Gm-Message-State: AOAM531g4DrHn97VvyVCwT4ybzgzvrklf+LffegF3ezrEHQy/xcBYLzs
        jLbOqjrn4mOPkxVEb2r3JxpDeKyua297dOl1iCo=
X-Google-Smtp-Source: ABdhPJzIWh5V4TfpF5Zp/RsroOlEhriE0UZZMb6tZCaTPSoQ9C5Oj1vLh1LAWOzIAIVCPZtLqo6cbl6gBilqwmftw3Y=
X-Received: by 2002:a19:f504:: with SMTP id j4mr1523175lfb.242.1623386619005;
 Thu, 10 Jun 2021 21:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com> <cd1e1f6985c77d21ec869e53dc5eb79673caf491.1623343713.git.gitgitgadget@gmail.com>
In-Reply-To: <cd1e1f6985c77d21ec869e53dc5eb79673caf491.1623343713.git.gitgitgadget@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 10 Jun 2021 21:43:27 -0700
Message-ID: <CAPx1GvfF7NZD4RMWWZCfny2gQOt1GY=TUm1HxvC+kwwDsc4Rgw@mail.gmail.com>
Subject: Re: [PATCH 3/3] builtin/checkout--worker: memset struct to avoid MSAN complaints
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 9:49 AM Andrzej Hunt via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [snip] Therefore we add a
> memset to convince MSAN that this memory is safe to read - but only
> when building with MSAN to avoid this cost in normal usage.

It does not seem likely to be that expensive, and would definitely
be shorter without all the `#if` testing:

> diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
> index 289a9b8f89d0..02fa5285988f 100644
> --- a/builtin/checkout--worker.c
> +++ b/builtin/checkout--worker.c
> @@ -56,6 +56,17 @@ static void report_result(struct parallel_checkout_item *pc_item)
>         struct pc_item_result res;

This could just have `= { 0 }` added.

In any case, this and all the others in this series look good to me.

Chris
