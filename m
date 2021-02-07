Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0468FC433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 06:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA41464DD9
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 06:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBGGFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 01:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGGFy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 01:05:54 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F61C06174A
        for <git@vger.kernel.org>; Sat,  6 Feb 2021 22:05:14 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id x23so2705266oop.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2021 22:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYES7wvbW6+1FHfNsS3XlLhLjqVM4Hbs2gHtA0xLRm8=;
        b=QXDTL+JBrE4D5cHIFiPguEzh9gTq5Q8P4/pa8wV4nyTrLc+kT1x2e+FhaIOe4TuCSv
         j2q/NsS0/M6sauZlCR5EMWKjKSngtwUGXtw37lYB5Ye2sZd0r6hoKpixgmF5bJ3iqr9C
         xgMe0Ucq24CXXlvKw4TcuT7v0RVJOu6NBN4Gsdrdw6boE6Z3L82rMoUTaukJYb6+qe1R
         t3qxN3hONdzvXhObfuGVc4dFYEgd3vXdxux0d08BQcLesGhms576jDt/TM3Stz0bL0G3
         S98RNcXl/4XYBNH9joubv5ZeXkv+gpGhexPWw6SCZdDm7p7ibS3OAnFyzNn9TKa/u8+h
         ERpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYES7wvbW6+1FHfNsS3XlLhLjqVM4Hbs2gHtA0xLRm8=;
        b=t2KKXDIRnoA96mtQsXUHx8u2BI59S96tImWQDhWQYE4e4VQ3cC/2w4lh1GgH1EjnNz
         IpMOtpwCAWXKIyHBOrvfEMZv/UTuKctMvGbgs39BHPe9xAL+ndvSRPNQqdsMiCjn05Ta
         3yKSd8fwvZO1Op1vHcv8eRhOAre7XHqAKMdIYM8Lwuc2JGVN4OOxskr7+29+a4axvSkW
         8xM63X5LyDmf2vc3xTQgpcCSImQXrsn175tBbL+kKcUyxcqwYTFRaAqGHteXO+wteacJ
         FH7ro/WpsaJTBpgn4md7GaVPyFNVYkc54ScLiB2Wm5SD2OV+kWC/UNck/k3sfGyDwEP9
         oN4g==
X-Gm-Message-State: AOAM532GG6cGRTDdWwOHDrAwTizQGvH8aVT89aR/eFtH7gACxS1lOVBl
        xXgxAeGsMR3rz6adY5PZCiCfGK1iPSQoYxAhn52HKQaluxQ=
X-Google-Smtp-Source: ABdhPJxQKs8Lx3kx+AX46m+irOpcmwWtLMCxPqIi2S5S18cwJTtWOFnBuzHeO+wuPq9oCx5CS7/PT+ycDm1z7WEG+Rg=
X-Received: by 2002:a4a:9d0e:: with SMTP id w14mr8614570ooj.7.1612677913396;
 Sat, 06 Feb 2021 22:05:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.git.1612651937.gitgitgadget@gmail.com> <xmqqtuqo8nfz.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtuqo8nfz.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 6 Feb 2021 22:05:02 -0800
Message-ID: <CABPp-BFyWETzOM4C44HjHctSzg6Mr5BEn+OEO5RT888QX71CTA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Optimization batch 7: use file basenames to guide
 rename detection
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 6, 2021 at 9:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This series depends on ort-perf-batch-6[1], which has not yet appeared in
> > seen despite being reviewed by both Junio and Stolee.
>
> It is because that one depends on something not in, but soon about
> to go in, 'master' and I didn't want to add to "this topic depends
> on top of that other topic" mess.

Ah, makes sense.
