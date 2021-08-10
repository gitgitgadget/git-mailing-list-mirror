Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB63FC432BE
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 05:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A1060295
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 05:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbhHJF13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhHJF10 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 01:27:26 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83ECC0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 22:27:04 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id y65so1172591vsy.3
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 22:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qShXeIwe5ihSlXdBsi8CpxDG4Xi3jVTuvYvXdJ24ATI=;
        b=j8Lj/vzkLSt8NuhTWNo4H29V+K+6nHoti2Aq1Qh2geH3A2UTQF59h2tAgxJSrdePcM
         N6BznfZDjHirbELIozRC0cHcM+NZNdoyiSxgg8mfgxPvWkctG1P5rzb3ZSyKhe3OE4b4
         S1oLGgXWF+s2Ay0sr6Uayh3xnyGgvpH9WHPhWWEfXm8U3LYZwevZ7Hc7UOPpvZ15Dicm
         2lykPT7uFWpyQvRThAwd+cmmXMkkImGojKij8ptIZgrjd+dV5Hyw9FvrM/91sIc7LQez
         ReOkQ68lw60TA2Gapz02sguIMeno/o3C9sMeiS0TMa6tar3ingtWAQRqAunXqglo6biG
         tHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qShXeIwe5ihSlXdBsi8CpxDG4Xi3jVTuvYvXdJ24ATI=;
        b=ghf3+FBhIZg5jPykth03RXyYRE/szybsmoEtc1NDzvdGO5QY44p48oTJbaG1jOPNEf
         WZhR24GeKL5oZK82U7tGha7GigJmwZ1Im9X0StY4LxIiawGjvUMekdHPMIsg/T6tt11u
         Qc0NAlbcPzHyF7hXKliY//mJFZ7jVyC1gz25qRUjJBrmmU+uW61J6PtZ6Gd9W1MrZcRQ
         kWz/UYwUZvkzNJpsWBhhr9FoyJ6eEqUxsypes+2so6GxilM1hfwPLOF/eCkzQCP5pSB8
         SnHti/gxf2rREHwm5i4M0iD7GrEcxJBdrFWXXUsxasY49qDvyvwVYnrjt9J7zKVEvEjb
         GT2Q==
X-Gm-Message-State: AOAM530PDQnQZKod49SCRuw0R64PDBKIUbGI4z8wYr09MPL3u3pTMd1u
        atRuMQG1shCieowkppg6B7ZH/SoR6zjcXUrGLdvNxY1Vcv4=
X-Google-Smtp-Source: ABdhPJxxt2cMb9qJB5N7ZwxRVGhkNuHDPjnJZuKLIbM18j7nTHxCboem7wat8scg8eymHLQRZOIuWnMw52yAkBPdtMo=
X-Received: by 2002:a67:d017:: with SMTP id r23mr17179598vsi.5.1628573223676;
 Mon, 09 Aug 2021 22:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <YRHQAFDXs5xvyDND@coredump.intra.peff.net>
In-Reply-To: <YRHQAFDXs5xvyDND@coredump.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 9 Aug 2021 22:26:51 -0700
Message-ID: <CAPUEsphWN_-BWyfF9mnPhL56RSnmPZfmvh_QwhjoAb3xin8V-w@mail.gmail.com>
Subject: Re: [PATCH] apply: keep buffer/size pair in sync when parsing binary hunks
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Xingman Chen <xichixingman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 9, 2021 at 9:24 PM Jeff King <peff@peff.net> wrote:
> diff --git a/apply.c b/apply.c
> index 44bc31d6eb..4ed4b27169 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1917,6 +1917,7 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
>
>         state->linenr++;
>         buffer += llen;
> +       size -= llen;
>         while (1) {

Ironically, I was looking at this code because of your previous
patch[1] that you suggested was ugly
and because I was going to suggest moving from a for to a while loop
to avoid the overly long line.

It is interesting to note though, that having a for (and obviously
removing the last 2 lines from the loop) with a comma separated
increment instead would
have made this issue IMHO more obvious, and also why I decided against
that; would it be a good idea to fix that as well?

  for (; ; buffer += llen, size -= llen) {

Carlo

[1] https://lore.kernel.org/git/YRGwjgAIyLPb7g50@coredump.intra.peff.net/
