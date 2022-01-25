Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F6C5AC75
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 00:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiAZAEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiAZAEn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 19:04:43 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3AC06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:04:42 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m4so34603642ejb.9
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/MF14RV1DmuTvPEQUxyjPvx3j3FWyGkoSHdlDSkc+mk=;
        b=Zzjzt+wQxwA5E8iyxcFNwHvi0O2J4l/STApZT94YSnMjEHbDaP48jFe2N32NvAdBPt
         c7ApBJIEVGGIDOOPLzPOqfnIle2nkdMWWCR8oRYgIVjggmKv+or2zr8zP+L4eQI2clKh
         eUYoVNj5WuZ9e4NFsYocHx1LFC4mETsNJhw2V+hviqPnxtga3H/Q7XbWRlU8BHSFp/Cw
         JnhNR6OPFfhBRaOoK1ynkN4ZKTNr7MTfndNseSpAHRS7XSZ57WagsabHySNh0709ZPZ6
         a2oin0h4DifCHZRTIYafgmJIdrLHINwTRMX/gvnjpz1JqG0n9yy2iVtWNi7faf9FU5PD
         V+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/MF14RV1DmuTvPEQUxyjPvx3j3FWyGkoSHdlDSkc+mk=;
        b=34Ugwj5abbGaKciC3j3Yz/6GvKoWfzhok0MKV7wbb1+3gIO/VzAGp5UBUDtKF4T1zQ
         r+LgKnYcN13CFXaHmLksc+Lbu3/2ir9Oil/3VlxDhuu6xB75mromyjr9+4J7I4Z1nw/x
         u2hJoOx0lhuF3gA4y/gwyohNSgUHEfYotsJcL6dVMvXi86FKNWHAB+xe8lVImZSX7Doz
         5TKsPt5Glb00nBoj/4Gn5mKT8HFCgc+d0V83C4p72D3hpEth5gfuNVUFbeEripjhOaOJ
         4q4z7lS/ffgahASs77ww835ZbNdhdeE5hw+39hed1xJnhawe4wfaq2qJ8hklYc4ZLR7+
         EhbA==
X-Gm-Message-State: AOAM533UBKNksiJbu4fl3yV25Yqgzqzf59iRk2l7zVnFmGKUGjaJldTZ
        BLvrrWJq/7SDIpTepmuHzoXGETr9qZMP2Q==
X-Google-Smtp-Source: ABdhPJzap+iXp11OqyraIaTgCNzoWTDsIgRKMm9aXXC0pQFyAtSGNdyHkd1QJMUPGqpqL7ME1YsQtQ==
X-Received: by 2002:a17:907:3e96:: with SMTP id hs22mr9279050ejc.640.1643155480530;
        Tue, 25 Jan 2022 16:04:40 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id vr6sm6746245ejb.45.2022.01.25.16.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 16:04:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCVnj-0034Ow-IS;
        Wed, 26 Jan 2022 01:04:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 3/9] ci: make it easier to find failed tests' logs in
 the GitHub workflow
Date:   Wed, 26 Jan 2022 00:48:03 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <98891b0d3f7927086350cc9523736ae2eb7c1ee2.1643050574.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <98891b0d3f7927086350cc9523736ae2eb7c1ee2.1643050574.git.gitgitgadget@gmail.com>
Message-ID: <220126.86sftbfjl4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> You currently have to know a lot of implementation details when
> investigating test failures in the CI runs. The first step is easy: the
> failed job is marked quite clearly, but when opening it, the failed step
> is expanded, which in our case is the one running
> `ci/run-build-and-tests.sh`. This step, most notably, only offers a
> high-level view of what went wrong: it prints the output of `prove`
> which merely tells the reader which test script failed.
>
> The actually interesting part is in the detailed log of said failed
> test script. But that log is shown in the CI run's step that runs
> `ci/print-test-failures.sh`. And that step is _not_ expanded in the web
> UI by default.
>
> Let's help the reader by showing the failed tests' detailed logs in the
> step that is expanded automatically, i.e. directly after the test suite
> failed.
>
> This also helps the situation where the _build_ failed and the
> `print-test-failures` step was executed under the assumption that the
> _test suite_ failed, and consequently failed to find any failed tests.
>
> An alternative way to implement this patch would be to source
> `ci/print-test-failures.sh` in the `handle_test_failures` function to
> show these logs. However, over the course of the next few commits, we
> want to introduce some grouping which would be harder to achieve that
> way (for example, we do want a leaner, and colored, preamble for each
> failed test script, and it would be trickier to accommodate the lack of
> nested groupings in GitHub workflows' output).

Is it really better to have the first thing you see in a failing job be
this level of detail?

To take the "before" demo job from your CL, if you click on a failing
job you'll currently end up with ~1600 lines of "prove" setup and
output, culminating in (the browser auto-scrolls to the end):

    [...]
    Test Summary Report
    -------------------
    t1092-sparse-checkout-compatibility.sh           (Wstat: 256 Tests: 53 Failed: 1)
      Failed test:  49
      Non-zero exit status: 1
    t3701-add-interactive.sh                         (Wstat: 0 Tests: 71 Failed: 0)
      TODO passed:   45, 47
    Files=957, Tests=25489, 645 wallclock secs ( 5.74 usr  1.56 sys + 866.28 cusr 364.34 csys = 1237.92 CPU)
    Result: FAIL

Is it ideal? No. But I think that folding the ci/print-test-failures.sh
output into that step makes it much worse. Now I'll be sent to the very
bottom of ~16000 lines (yes, that's an extra zero at the end) of output,
ending in:

    [...]
    + test_cmp expect sparse-checkout-out
    + test 2 -ne 2
    + GIT_ALLOC_LIMIT=0 eval diff -u "$@"
    + diff -u expect sparse-checkout-out
    + test_cmp full-checkout-err sparse-checkout-err
    + test 2 -ne 2
    + GIT_ALLOC_LIMIT=0 eval diff -u "$@"
    + diff -u full-checkout-err sparse-checkout-err
    + test_cmp full-checkout-err sparse-index-err
    + test 2 -ne 2
    + GIT_ALLOC_LIMIT=0 eval diff -u "$@"
    + diff -u full-checkout-err sparse-index-err
    
    ok 53 - checkout behaves oddly with df-conflict-2
    # failed 1 among 53 test(s)
    1..53

Now you'll need to scroll up or search just to see what test failed.

Usually when these fail I might only look at the failing test name (at
that point already knowing why it failed). I think it's a feature that
we only expand the verbose output later.

I realize that:

1) This isn't the exact output you emit in the post-image here, since you're not
actually using ci/print-test-failures.sh, but from eyeballing the script
it seems to do basically the same thing, i.e. it'll emit the full *.out
file.

B.t.w. why isn't this using ci/print-test-failures.sh. Your "an
alternative way" paragraph doesn't really explain it. Sure, it'll be
further tweaked later, but in the meantime do we have to re-invent
ci/print-test-failures.sh? Anyway...

2) The end-state at the end of this series looks somewhat different, but I think
that end-state shares the UX problem noted above, and to some extent
makes it worse.

That one has 28 thousand lines of output!

Now I know it's elided so you're only supposed to see a few screenfulls
of it, but at least in my browser that end-state is *very slow*, much
slower than the version that shows me the full ~16 thousand lines at
once.

Presumably it's doing some very expensive JavaScript/CSS behind the
scenes.

I mean so slow that when I press page up and down I can see 3-8 lines of
that folded output appear at once, then the next 3-8 lines etc. The
current output meanwhile (and this more verbose one) is
near-instant. This is in Firefox 91.4, if it matters.
