Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650E5C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 23:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1156528A
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 23:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhCHX4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 18:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhCHXzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 18:55:38 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C188C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 15:55:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e19so23948180ejt.3
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 15:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MxhONtFiGDJX2XbJaFQjyOlSgx/m5fRSa6Ce23hSqCI=;
        b=NhKyd9jrd11Q+olBcla7QJUtOWNJjCsE/1/fcMB60D1Mw65Ah4cx7AQvPVnlvcTaCk
         ICyUREsak44PDwtQE3myq3HrtxYxh/YvbwVwZ9sqO5BjGNOUCYN8NXdlAvDnuXZNE1+y
         2sgfgsDOAYjStQahd9Mge1evbug80JLDmeAXT3CfqfY4yT3/oGVpj7ZfFeaOK55bd4OY
         qfctO72UfUl02AeAIQIATtBHW+/jgidTH05fF1vtOuUma+SFCMuLqMY/VHSEG2WltzRY
         b5Ty0LVm9iy69chGFxGEvUjb/wyOR1NFEhG/ySZ0LccIEjQkNDQRgM9x/Q61nuDG93qW
         0nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MxhONtFiGDJX2XbJaFQjyOlSgx/m5fRSa6Ce23hSqCI=;
        b=kbj1TvQXBhhW2ZLoxcJHkaKawA9bnF5HQuYPUeBZhmAZckYPRyIgJGarSusfe8Uhp7
         uCqUFi0G8fwYOPc7kM33JdBGyzmzYtIR6D8kGJwFqGoeu80jn9CuBiFBodhLn6zSKdaG
         tyjDQ1OCPE67DeM/ITnBh3gB67ZzI00pRKXwt5bEJgnR8TMT9FIwHpugLjnHLXiVGEmH
         6/LUpNrtNJFcqoEs3tNVoJRjMtcKv+UCJRDhv7cvjkXrUAKODtswGFbVWBAJnYBYXplW
         khDnugPvdpUGJeAE8xaZTc8A+VAIqVUlShzRAVAC3jBvTyjlPQMWz/SLy+qedArWc4LY
         1BMg==
X-Gm-Message-State: AOAM532PJLl7NC1vSCQdjqoKJB6RwDL//z1v+X3df0E98viFexZFxntS
        DOq4Fdm9+lk6hiq/Uj5YP5J3FhLxWf1ualm1gdm0gl0lUF+Z0A==
X-Google-Smtp-Source: ABdhPJzo7dJEFq1+TT/7lJ92eGXDLoZabDgQogBHcqafNy3E/mBDba8YiYVs2Ce7PXnYCKkPm/HQbC2BqL9OJ/psCi0=
X-Received: by 2002:a17:906:a2d3:: with SMTP id by19mr13037689ejb.98.1615247735614;
 Mon, 08 Mar 2021 15:55:35 -0800 (PST)
MIME-Version: 1.0
References: <17813b232e9.e48d03c3862272.7793967418558853913@monospace.sh>
 <CAGyf7-F6jbs-HQeCSMjf_y8Y=5ZfME=CjBagAfKUbnP_0vDXqA@mail.gmail.com> <178140c3b3b.c7a29306868075.2037370475662478386@monospace.sh>
In-Reply-To: <178140c3b3b.c7a29306868075.2037370475662478386@monospace.sh>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 8 Mar 2021 15:55:24 -0800
Message-ID: <CAGyf7-EO3EGgjO5H_8ZXodYraxweA0ez2nm2Zs1BJTGgK-ScKg@mail.gmail.com>
Subject: Re: Performance of "git gc..." is extremely bad in some cases
To:     Anthony Muller <anthony@monospace.sh>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-adding the list.

On Mon, Mar 8, 2021 at 2:54 PM Anthony Muller <anthony@monospace.sh> wrote:
>
>  ---- On Mon, 08 Mar 2021 22:29:16 +0000 Bryan Turner <bturner@atlassian.com> wrote ----
>  > On Mon, Mar 8, 2021 at 1:32 PM Anthony Muller <anthony@monospace.sh> wrote:
>  > >
>  > > What did you do before the bug happened? (Steps to reproduce your issue)
>  > >
>  > > git clone https://github.com/notracking/hosts-blocklists
>  > > cd hosts-blocklists
>  > > git reflog expire --all --expire=now && git gc --prune=now --aggressive
>  >
>  > --aggressive tells git gc to discard all of its existing delta chains
>  > and go find new ones, and to be fairly aggressive in how it looks for
>  > candidates. This is going to be the primary source of the resource
>  > usage you see, as well as the time.
>  >
>  > Aggressive GCs are something you do once in a (very great) while. If
>  > you try this without the --aggressive, how does it look?
>
> Hi Bryan,
>
> Without --aggressive it's fine and I do expect it to take longer using aggressive.
>
> I find it very odd that a repo ~8x in size and with probably 400x as many objects took 1/4 the time though. I would think size and object count would play a role in time and resources.

Looking at that blocklists repository, it looks like it's not many
files or commits, but the files are pretty large (10-25MB). For delta
compression, large files can cause a lot of pain.

If you set core.bigFileThreshold=5m (a reduction from 512m by default)
and pack.windowmemory=1g, for me locally, at least, "fixes" the
"problem" (which is to say it changes the behavior). The GC runs in
under 10 minutes:
$ /usr/bin/time -l git gc --prune=now --aggressive
Enumerating objects: 10777, done.
Counting objects: 100% (10777/10777), done.
Delta compression using up to 20 threads
Compressing objects: 100% (8672/8672), done.
Writing objects: 100% (10777/10777), done.
Reusing bitmaps: 101, done.
Selecting bitmap commits: 2146, done.
Building bitmaps: 100% (126/126), done.
Total 10777 (delta 3986), reused 6784 (delta 0)
      298.00 real       996.76 user        18.84 sys
          9284980736  maximum resident set size
                   0  average shared memory size
                   0  average unshared data size
                   0  average unshared stack size
             2861811  page reclaims
                   1  page faults
                   0  swaps
                   0  block input operations
                   0  block output operations
                   0  messages sent
                   0  messages received
                 296  signals received
                 172  voluntary context switches
              171245  involuntary context switches
            20586171  instructions retired
            28100595  cycles elapsed
              880640  peak memory footprint

Of course, that also takes the size of the repository from 367MB to
2.3GB--not exactly your desired outcome if you're trying to save
space.

From there I tried just reducing the threads from 20 to 8 and using
the 1g window memory limit, but leaving the bigFileThreshold at
default. That allows for delta compressing everything, and for me
completes in just under 12 minutes:
$ /usr/bin/time -l git gc --prune=now --aggressive
Enumerating objects: 10777, done.
Counting objects: 100% (10777/10777), done.
Delta compression using up to 8 threads
Compressing objects: 100% (10077/10077), done.
Writing objects: 100% (10777/10777), done.
Reusing bitmaps: 101, done.
Selecting bitmap commits: 2146, done.
Building bitmaps: 100% (126/126), done.
Total 10777 (delta 5387), reused 5383 (delta 0)
      713.98 real      3053.41 user        31.91 sys
         13408837632  maximum resident set size
                   0  average shared memory size
                   0  average unshared data size
                   0  average unshared stack size
             3804319  page reclaims
                   1  page faults
                   0  swaps
                   0  block input operations
                   0  block output operations
                   0  messages sent
                   0  messages received
                 712  signals received
                  57  voluntary context switches
             1011681  involuntary context switches
            20568579  instructions retired
            31734809  cycles elapsed
              872448  peak memory footprint

That also reduced the repository from 367MB to 320MB. (Technically
from 2.3GB to 320MB, since I this after the earlier attempt.)

Of course, there's a machine difference to consider here as well. I'm
guessing you're on a MacBook Pro, based on the specs part of the bug
report. My testing here is on a 10 core iMac Pro with 64GB of RAM, so
some of the difference may just be that I'm on a less constrained
system.

>
> What factors would make that happen? Is it a combination of more commits with fewer objects?

Big files are the biggest issue, in my experience. The total number of
objects (it's not really about object type too much, as far as I can
tell) certainly has an impact, but having big files (where "big" here
is anything larger than a normal source code file, which is typically
well under 1MB) is likely to balloon both time and resource
consumption.

>
> I've been using aggressive after cloning repos I use primarily for reference/offline/etc to recover a lot of wasted space.

To some extent I'm not sure there's an easy answer, for this. It may
come down to looking at the repositories before you do a local GC to
see what "shape" they have (starting size on disk, in-repository file
sizes, etc.) and deciding from there whether the savings is likely to
be worth the time investment.

>
>  >
>  > >
>  > >
>  > > What did you expect to happen? (Expected behavior)
>  > >
>  > > Running gc on a ~300 MB repo should not take 1 hour 55 minutes when
>  > > running gc on a 2.6 GB repo (LLVM) only takes 24 minutes.
>  > >
>  > >
>  > > What happened instead? (Actual behavior)
>  > >
>  > > Command took 1h 55m to complete on a ~300MB repo and used enough
>  > > resources that the machine is almost unusable.
>  > >
>  > >
>  > > What's different between what you expected and what actually happened?
>  > >
>  > > Compression stage uses the majority of the resources and time. Compression
>  > > itself, when compared to something like zlib or lzma, should not take very long.
>  > > While more may be happening as objects are compressed, the amount of time
>  > > gc takes to compress the objects and the resources it consumed are both
>  > > unreasonable.
>  >
>  > The compression happening here is delta compression, not simple
>  > compression like zip. Git searches across the repository for similar
>  > objects and stores them as chains with a base object and (essentially)
>  > instructions for converting that base object into another object.
>  > That's significantly more resource-intensive work than zipping some
>  > data.
>  >
>  > >
>  > > Memory: RSS = 3451152 KB (3.29 GB), VSZ = 29286272 KB (27.92 GB)
>  > > Time: 12902.83s user 8995.41s system 315% cpu 1:55:36.73 total
>  >
>  > Git offers several knobs that can be used to influence (though not
>  > necessarily control) its resource usage. On 64-bit Linux the defaults
>  > are 1 thread per logical CPU (so hyperthreaded CPUs use double) and
>  > _unlimited_ memory usage per thread. You might want to investigate
>  > some options like pack.threads and pack.windowmemory to apply some
>  > constraints.
>  >
>  > >
>  > > I've seen this issue with a number of repos and size of the repo does not
>  > > determine if this happens. LLVM @ 2.6 GB worked flawlessly, a 900 MB
>  > > repo never finished, this 300 MB repo takes forever, and if you test something
>  > > like chromium git will just crash.

I should add that for something like Chromium, and potentially
whatever 900MB repository you tested with, you're very likely to need
to do some explicit configuration for things like threads/window
memory unless you're on a _very_ beefy machine. The default unlimited
behavior is very likely to run afoul of the OOM killer (or something
similar).

>  > >
>  > >
>  > > [System Info]
>  > > hardware: 2.9Ghz Quad Core i7
>  > > git version:
>  > > git version 2.30.0
>  > > cpu: x86_64
>  > > no commit associated with this build
>  > > sizeof-long: 8
>  > > sizeof-size_t: 8
>  > > shell-path: /bin/sh
>  > > uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Jan 12 22:13:05 PST 2021; root:xnu-6153.141.16~1/RELEASE_X86_64 x86_64
>  > > compiler info: clang: 12.0.0 (clang-1200.0.32.28)
>  > > libc info: no libc information available
>  > > $SHELL (typically, interactive shell): /usr/local/bin/zsh
>  > >
>  >

Hope this helps!
-b
