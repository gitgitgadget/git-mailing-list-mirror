Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7DEC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E4261934
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhCSPVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 11:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhCSPVV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 11:21:21 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02231C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 08:21:21 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w70so5126680oie.0
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fm0i9eN4dhLW8r0CiFhUhetICwmRzrlpm5TWYcW9HrI=;
        b=Q+qwuaE3xUn1leX5Ov+XEv/RYB369zSTVnU/Be0byF7d+ZK1hLiyv+XE6paWmA2Shc
         46eJA00AFD726ChS0d8aJWb0XyfobWNTlyAO5xFGRPsjt2YEDpm92UwA3YOu8eoZy5d4
         EE0I4Fhekmd0Br8nFyFyadjPM3XeFrFNT7KjfLe4ZxiUrmRDwEnjHnNJYno70diMM3GC
         gufygp3XOp2FsO+bl8h3vArqwHMGIdoUQotPZIE0sNKYdknKRifTgHh8y2UzFqRFRawA
         FQ5YVTNrQlVsyrzqbTeYI/elBgVgHhTWijQoj4BtEdOWkvr2uM7PmMSn09uN/jgqApRL
         pa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fm0i9eN4dhLW8r0CiFhUhetICwmRzrlpm5TWYcW9HrI=;
        b=ozudpKwo0MSD0R02IiGC8LfdUa4uYYnMypMCmjEEZjX50K5x91xRwa1y6FEafBMTEl
         Vpt0RwzF+f18Hc0NBjaPBKyXlthjhw4+sJ2qr4uqnXrStIBUlZoOUhnbarvqRoMSEOUZ
         kQtEAzvNDLWlhiDJH0hGIZtUxE/TpHgp1c6xkCjEH97kRXLu9x6NXjoPYNtjkwXX2eDc
         YFx2jRPDwtIujviCzHJpJ3Q9znZOCCMZrhA0LQV9xzCsm5SKWnXi0JxGw0SaSoWho/n1
         PZozY2qMIjj7PLN3RvDho4RwtuucxiX1YMGshSZNBId+NzVVgTLDChDweh/xExpsPRbw
         eE9w==
X-Gm-Message-State: AOAM533F9lIYp+zAhuCYNNPxsf7BD8Tv+R2H0EyBx9h0Hrs5tZptIpv8
        0xaASD6R+pEM9BMpBIpsFsulYFOYDFIimSHxass=
X-Google-Smtp-Source: ABdhPJxZjwBwxIuGkLGEuS2HLFMKTU1BbGUNj6V9iI3u6i6hD3C+EQ7vPik8bw/Gr8vP5mnj1mSTxbliTRJJgDfXolI=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr1353612oij.167.1616167280306;
 Fri, 19 Mar 2021 08:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
 <pull.905.v2.git.1616016485.gitgitgadget@gmail.com> <d8536f56ab296171c09e667e5c9299e95078388e.1616016485.git.gitgitgadget@gmail.com>
 <6b619bd0-c924-274e-d8bb-3bb9c67a2625@gmail.com>
In-Reply-To: <6b619bd0-c924-274e-d8bb-3bb9c67a2625@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 19 Mar 2021 08:21:08 -0700
Message-ID: <CABPp-BFiTCVZhyS551vUit=7bw4cnbU2zdBH0DZ7UKAoieDFFA@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] Add testing with merge-ort merge strategy
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 19, 2021 at 6:05 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/17/2021 5:28 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > In preparation for switching from merge-recursive to merge-ort as the
> > default strategy, ensure that we are testing it.
>
> OK, so here we are testing it by default in CI, not just in that
> second round of optional environment variables. If that is what

Note quite; my patch adds testing of merge-ort with *-gcc variants on
each of the major platforms, but still includes merge-recursive
testing in the *-clang variants.

> you intended, then this is the diff I was expecting:
>
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index a66b5e8c75a..c013e9e646a 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -25,6 +25,7 @@ linux-gcc)
>         export GIT_TEST_ADD_I_USE_BUILTIN=1
>         export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
>         export GIT_TEST_WRITE_REV_INDEX=1
> +       export GIT_TEST_MERGE_STRATEGY=org

"ort", not "org".  :-)

>         make test
>         ;;
>  linux-clang)
>
> However, if we want to be aggressive in adopting the ort strategy
> very soon, then your approach of testing more frequently is
> valuable.

I don't think testing limited to linux-gcc is very valuable:

* I've got opt-in volunteers (~60 of them) using it for the last half
year for their daily work (on Mac & Linux)
* For these volunteers, `git log -p` _also_ remerges every 2-parent
merge automatically (there's a --remerge-diff capability)
* We also had a bug where an internal script ('sparsify') looked for
files changed in "local-only" commits via `git log --name-only HEAD
--not --remotes=origin`.
* At least one person renamed their default remote to something other
than "origin"

The upshot is we not only have many testers using it for daily work,
we had at least one guinea pig redoing every merge in his
repository...and found a platform specific bug in some commit from
years ago because of it.

In the last half year, I've only had three bug reports, none reported
by more than one person:

* Platform specific merge issue triggered only in a commit in a
certain repository from years ago (fixed by first patch of this
series, the STABLE_QSORT() one)
* Mis-handling of present-despite-SKIP_WORKTREE file that *also* was
involved in a merge conflict (see t6428 addition in this series; note
that merge-recursive still fails it)
* A bug in the --remerge-diff results

So, at this point, beyond avoiding regressions the primary value I
find in testing is in expanding it.  windows is my big hole so more
than anything I want ort testing there.

> Would it be worth setting GIT_TEST_MERGE_ALGORITHM=ort by default
> in test-lib.sh, too? That could help developers working on top of
> your topic avoid creating test failures that only show up in CI.

Actually, that sounds like a good idea, and we could just pick one or
two special CI jobs to test with GIT_TEST_MERGE_STRATEGY=recursive.
