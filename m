Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B2C433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 00:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446FB23A7C
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 00:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbhAIAxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 19:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbhAIAxa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 19:53:30 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061F7C061574
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 16:52:50 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id d189so13388924oig.11
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 16:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Twtk8jwjL/RZiSWCaqvfQkLBkKRs2MFJhWeLHLMmg8s=;
        b=NIw7X7CcCXbIswLnsie2vxsd9blMow8277lh+cfXAKHcjPdxPjHI7b/Z399QpRGAtE
         dc/2qm9linVndjwL/g3l1v2SdU4vYQkxqCmjXV5+W4CXgTrmhNsZ2hv7qYTQLAWkhONN
         HhRSzO++tj4H/n+xCHYhskGtmQBspVl/R4Z6MGR6JYDRxZFHzdagw3Zu8y+uPr4Am5b2
         9lLQuh7fusL6A3F8Q5bm6F8nLiY3HRI9cm5ocoUfC6DuagZ8tWKCU5tj+0pNFqtR4nil
         VJdTIEl463yzl3LsgMMiqVd5MDB77f1TQ2a3ztKw7J3dHmEZAKYPTqGSWoZrc6ZH6IFW
         eaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Twtk8jwjL/RZiSWCaqvfQkLBkKRs2MFJhWeLHLMmg8s=;
        b=Ex9lZYiGookHwXzZXtj4+Qa+aopuKh47Lk0NIw6zSZDAQqzxvu/iFjmdbY684Wlf5a
         avtBztSrUATx+kHWJ+QkuUAXg7QL89HBnRWgv5e8nht3J+IvTIUpR7k+QVLTDni+KKq4
         MNIDJhoBXKH2srzInt2UZrzkPJxEplKLFvzTqT/XX68eKTbz8SShffUOmNeUvMIryqoO
         Z0iE4ReO6fTwO4plaBkbV9QqtK4wj9Y1m/Jy5birWx/C/BtySmX9xBACpnmBOBfkcudJ
         Nqxp4bZp4LsErLKRHlNuninf44jl7vcNeMEb2dbvCjphkMJGdzPJE4XjoaWiXm3RgIYi
         77bw==
X-Gm-Message-State: AOAM530bqPKjJQIoKFfulv7ABUST12lOW0bznNxwvV6Ja2ZxdgpPnNch
        37TwNZOJembzQYqK+edwQyWJEKKbxExlIWvPxd9ClSJb
X-Google-Smtp-Source: ABdhPJyw+HlDlr2+XBTh2fxgmO5QJNxnsjBRjV76l73/JhOAJxKSeq+YzzxN3baORkgH02pQEgLty99d+t3Ixb+A4Ts=
X-Received: by 2002:a54:4185:: with SMTP id 5mr3949862oiy.31.1610153569407;
 Fri, 08 Jan 2021 16:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20210108205111.2197944-1-newren@gmail.com> <20210108205111.2197944-2-newren@gmail.com>
 <X/jHpZlSxwAxoUyq@nand.local> <CABPp-BE4zyGa7=dOKifWhv-46__0YtfRZ39Q1JYT0JZ2HT0itA@mail.gmail.com>
 <X/jUykDe8hfPDqv4@nand.local>
In-Reply-To: <X/jUykDe8hfPDqv4@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 8 Jan 2021 16:52:37 -0800
Message-ID: <CABPp-BG0QTdbdnNp-4XDfVCS+59t8p6L7oszN1TUJ_L6LM3tpA@mail.gmail.com>
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

On Fri, Jan 8, 2021 at 1:55 PM Taylor Blau <ttaylorr@github.com> wrote:
>
> On Fri, Jan 08, 2021 at 01:50:34PM -0800, Elijah Newren wrote:
> > On Fri, Jan 8, 2021 at 12:59 PM Taylor Blau <ttaylorr@github.com> wrote:
> > >
> > > On Fri, Jan 08, 2021 at 12:51:11PM -0800, Elijah Newren wrote:
> > > > Overall timings, using hyperfine (1 warmup run, 3 runs for mega-renames,
> > > > 10 runs for the other two cases):
> > >
> > > Ah, I love hyperfine. In case you don't already have this in your
> > > arsenal, the following `--prepare` step is useful for measuring
> > > cold-cache performance:
> > >
> > >     --prepare='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'
> >
> > /proc/sys/vm/drop_caches is definitely useful for cold-cache
> > measurements and I've used it in other projects for that purpose.  I
> > think cold-cache testing makes sense for various I/O intensive areas
> > such as object lookup, but I ignored it here as I felt the merge code
> > is really about algorithmic performance.
>
> Yes, I agree that the interesting thing here is algorithmic performance
> moreso than I/O.
>
> > So, I instead went the other direction and ensured warm-cache testing
> > by using a warmup run, in order to ensure that I wasn't putting one of
> > the tests at an unfair disadvantage.
>
> I often use it for both. Combining that `--prepare` step with at least
> one `--warmup` invocation is useful to make sure that your I/O cache is
> warmed only with the things it might want to read during your timing
> tests. (Probably one `--warmup` without dumping the cache is fine, since
> you will likely end up evicting things out of your cache that you don't
> care about, but I digress..)

Ah, that hadn't occurred to me, but it makes sense.  Thanks for the
tip; I may give it a try at some point.  I worry slightly that it
might increase the run-to-run noise instead of decreasing it since I'm
committing sins by not running the performance tests on a quiet server
but on my laptop with a full GUI running -- a few year old,
nearly-bottom-of-the-line Dell refurbished grade B laptop with spinny
disks.  Dropping disk caches would lower the risk of needing to spend
time evicting other things from the warm cache, but would increase the
risk that some background GUI thing or system daemon needs to read
from the hard disk when it wouldn't have needed to otherwise, and if
the timing of that disk read is unfortunately placed, then it could
slow down I/O I care about.  I guess there's only one way to find out
if it'd help or hurt though...
