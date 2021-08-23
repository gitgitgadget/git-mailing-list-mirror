Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473A1C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 19:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2494561374
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 19:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhHWTYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 15:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhHWTYS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 15:24:18 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A47BC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 12:23:35 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so39205343otk.9
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 12:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ft20cOBnjn5Pegi4/ETXJikmFyNOQeBV0p9D/vsgpxc=;
        b=MBnXrGAeglOLiXZhxGam+wbWSQ8RkMvPMd647ZVF0qnht8hw9LfjySt/ziYGcN+60k
         5ViDobbjZxNDyjtxa5U3cu9njUbLNOPJi7t0bhr4eKxfR+/GaN1B9zWk0e3ZXFtTRhmD
         CgCUjWXg6IRYUh4Pf0pIjk/pZ67IK1ToK4EYOWVLy5FFldlLU2As0ZA15ercxdFB5YPp
         sJsN6zrRNMGifH2JKSBX3ZrQEnx69WzthOdMr1YUt38cyk2ZOyu+3CWmLTgYhT6D0yqq
         wD/8Rv7XREY4SEVSvPagXSz79FFnpaC2zWimJQizDthETAyHWsxrm/O7mmlh5a310pJz
         w4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ft20cOBnjn5Pegi4/ETXJikmFyNOQeBV0p9D/vsgpxc=;
        b=F4zo/YQNLDOMc1VP6tclpP2gMk2DtwADLf5e9yGVx2E1mlbkSeEpXLvIWW80dtmQtn
         is82vauqeuts0qYpK+WZGGwYGyKzgCW1NjUYmBYlAWRR3CNy8c3y5ikA5rDPmf2L+zOR
         AZMx7A92BzSkV9+FOCsgh/Tw89JuPCA3SL20ikd4lqZYjDX4hUhG9nKtPi9MuJmMnBad
         dd4wc9AFPe5NvHq8L6TibuxaYA35bh0jTbSaq7HM4pXj555cyrQOws/2seypWAAqzknN
         u3BO8u5dZeDo2ztrOHSWsKBZMNwOnlAPnNxcN0H4/DNYVSdecDbPlgDFYwPriT6FVX9v
         SCuw==
X-Gm-Message-State: AOAM532Tvb/I+EPnjGMVp50HdIFxEHHk1H+AIKzLyYNO0/bJA/S0Bdqp
        YP+clyHNuV+68JXN7lxkleS9wqodp0xF4s/20AQNG6C1RPYzjQ==
X-Google-Smtp-Source: ABdhPJyC5NNi7GvuuvSODh023Cn/4ezm58AvlukouKP/LO26eFv7nT+tvbFPFeQDer91/Y913nx1EC6ZhhAhqjyNKdU=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr94370oib.39.1629746614985;
 Mon, 23 Aug 2021 12:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAMJzOtxMjEuAy2B3oJqOZEnipmC4OBWxhQLx_baXDHcQ1C7-+g@mail.gmail.com>
 <YSPuq/HmF3tnYHCA@coredump.intra.peff.net> <CAMJzOtz_h0iEL1VQCFvvLzw3XnL+qM=f+BvkmsTU=ps+0VA7RA@mail.gmail.com>
In-Reply-To: <CAMJzOtz_h0iEL1VQCFvvLzw3XnL+qM=f+BvkmsTU=ps+0VA7RA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Aug 2021 12:23:23 -0700
Message-ID: <CABPp-BHibnrJYAYe-uX_ib7DFR5kkd=G2Jh+nhANPkfbnoFOzw@mail.gmail.com>
Subject: Re: git read-tree doesn't accept tree-ish
To:     Nikita Bobko <nikitabobko@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Aug 23, 2021 at 12:09 PM Nikita Bobko <nikitabobko@gmail.com> wrote:
>
> Yes, now I see. Thanks!
>
> I was trying to read state of a particular directory/file from a
> particular revision into my index but so far didn't manage to do it
> reliably.

Please don't top-post on this list.

> I was using `git read-tree <hash>:<path>` and it doesn't work for
> files (because they are blobs not tree-ish as you elaborated it to me)
> and for directories, in my cases, it fails with not so helpful
> message:
> ```
> error: Entry '<path>/<subpath>' overlaps with '<path>/<subpath>'.  Cannot bind.
> ```
>
> `git checkout <hash> -- <path>` also doesn't work in my case because
> if any file is removed in `<hash>` but not in my HEAD then `git
> checkout` doesn't remove the file in my HEAD

Have you tried `git restore --source=<hash> -- <path>` ?
