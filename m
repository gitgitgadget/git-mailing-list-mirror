Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E8AC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 21:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D636523A9C
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 21:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbhAHVv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbhAHVv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 16:51:26 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4FC061574
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 13:50:46 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id n127so2728017ooa.13
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Er3k7aJLiT8s8PNdbgQqsnUj4nof0MwGrAKI3V2ba7Q=;
        b=Yt2UwCyjZniTrjhBRhKyTjXGnWNhMavn3jZoJYjCUNU6oHo3iCiMmqvierr6q4p9k2
         E77v765IeQhGxoDA2ZCq6yTJqd4soDfmsdaMvGx4dqodcHy/+EF5pNHyggW+wjhmqQGY
         OsrjnPpQjwKB0RhX3CIK8EEvCNGiIK6nuIMwyKQaty6K9eGE9L/ogO9o9QLkAZ0nkFEM
         c53syVnqKvXlzCavphZN14GO1xCv4sUM0DOCWdM32X63xrOAShGBNtJkesfgn+j73QM7
         8ko0Rg/hBFhNY5lfGi5eD5uRe31tou2TDY2C8U8uAameLhS0thY/k4xXheAdWpAWwQMK
         kmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Er3k7aJLiT8s8PNdbgQqsnUj4nof0MwGrAKI3V2ba7Q=;
        b=eiQnQo6JodgLxrRpKw9hbpK65K0XKvefsBLh79Rlg+irfkNAscDtNZDGg5b+w1usT7
         G0gNKieZC/4ekQkcGJ6B0QqH6plctXhSz2M3LwJQ9SnCS+mPmoRb1RzNiueEcfSy9vvC
         PGp8n7wYadCpvtEqGHVxx9yHjDn1lGGhkX2cy+tKA0NtTGd0dhMHSl3l2mvmgfKo4KRt
         vvxtVfPYxDrJCq5hCUQXrs+LOTSUUgmB2WAc5rEGYgH/tCdsp9cWezOW44DqyiOTxGK5
         zS9EZAKDnM6ogac/As3kd5/uQ0A60ILsBs1wgrlHO1m7Lwhb9oIj1CgCMUliL4021Jw3
         /uqg==
X-Gm-Message-State: AOAM5312zGgfecwh9my40e7VXlEHQa9kiDPdp/QDrJrLNlJv8m7mhy+0
        gM/fkgScQKUrQmRajf1VyZp6EvEqdLWRkzVdmWXhFvlF
X-Google-Smtp-Source: ABdhPJzxdujZztZcYT5Lb223H9jrJeiLlREKmRWhaIqBTgFe3fqKrKpJRadCnBRQKZlDjQ93dTyy7nkXzFWCfNEdQfY=
X-Received: by 2002:a4a:3e42:: with SMTP id t63mr5673430oot.32.1610142645199;
 Fri, 08 Jan 2021 13:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20210108205111.2197944-1-newren@gmail.com> <20210108205111.2197944-2-newren@gmail.com>
 <X/jHpZlSxwAxoUyq@nand.local>
In-Reply-To: <X/jHpZlSxwAxoUyq@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 8 Jan 2021 13:50:34 -0800
Message-ID: <CABPp-BE4zyGa7=dOKifWhv-46__0YtfRZ39Q1JYT0JZ2HT0itA@mail.gmail.com>
Subject: Re: [PATCH 1/1] merge-ort: begin performance work; instrument with
 trace2_region_* calls
To:     Taylor Blau <ttaylorr@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 8, 2021 at 12:59 PM Taylor Blau <ttaylorr@github.com> wrote:
>
> On Fri, Jan 08, 2021 at 12:51:11PM -0800, Elijah Newren wrote:
> > Overall timings, using hyperfine (1 warmup run, 3 runs for mega-renames,
> > 10 runs for the other two cases):
>
> Ah, I love hyperfine. In case you don't already have this in your
> arsenal, the following `--prepare` step is useful for measuring
> cold-cache performance:
>
>     --prepare='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'

/proc/sys/vm/drop_caches is definitely useful for cold-cache
measurements and I've used it in other projects for that purpose.  I
think cold-cache testing makes sense for various I/O intensive areas
such as object lookup, but I ignored it here as I felt the merge code
is really about algorithmic performance.  So, I instead went the other
direction and ensured warm-cache testing by using a warmup run, in
order to ensure that I wasn't putting one of the tests at an unfair
disadvantage.  (Side note: My script that runs the tests actually does
more than the warmup run to ensure a fair playing field.  For example,
the script expires reflogs and runs a git prune before each hyperfine
invocation, to make sure that each hyperfine run starts with a fully
repacked repository with no loose objects.  Without the expire &
prune, enough perf testing of rebases in a short time period will
result in a mysterious and gradual slowdown of all the test runs even
without code changes...).

> > === Goals ===
> >
> > This patch is obviously just the beginning.  Here are some of my goals
> > that this measurement will help us achieve:
> >
> > * Drive the cost of rename detection down considerably for merges
> > * After the above has been achieved, see if there are other slowness
> >   factors (which would have previously been overshadowed by rename
> >   detection costs) which we can then focus on and also optimize.
> > * Ensure our rebase testcase that requires little rename detection
> >   is noticeably faster with merge-ort than with apply-based rebase.
>
> These are great, and I am looking forward to your work.
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> Thanks, this patch looks good to me.

As always, thanks for taking a look.
