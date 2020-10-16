Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A8C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 17:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E407A21527
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 17:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYp7hqSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbgJPR2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbgJPR2I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 13:28:08 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2CC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 10:28:08 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j7so3214138oie.12
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOl3j8uppZZaBqt4yzmITBqWFkciFXHujYyeLQnLmIM=;
        b=XYp7hqSdrHeYLt2e4usIvLM37RAzinL6Y9Erv38LM/udUFEyDMvAM1t3EkKAowOHVV
         G4b4oNvPM1XHweuFN4poE+w24WVM8hpPDJ/YRcRjBv6mAzkla6m7K6qmvXs4NcbJd3rL
         sjjZKa6T1tsVpYTzN5VyyVF/Gmnws8ZN/izZMFgXZfEh69GxaRH6RdJVxzXVkVEDNPim
         P/8oMKWdF7UwQPYx3G5/QqIfGW95LyigWaH2EanQGHj1EHXyXFm5j6K2NXhlZz0hEmxO
         qolVYKRthtewvOg7R3omslCfCmAdqjW1XM/k4V2n+Z3q1RVQEJlXw4WpCIl5hb3uWF7A
         v0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOl3j8uppZZaBqt4yzmITBqWFkciFXHujYyeLQnLmIM=;
        b=Q8rKkJKzxR6nELrKtBNcBjSHYZVfpiGCG2XiSRzTTeQqun0Dm85dfjXwgOvqnS69XR
         sM+hhgCOfWvqs0gzN5i3lWTpaNFcP+7s9BmzoGwKi9QSIy7hP2LK+k4SZlLfCcg9xs6t
         Uso70tNH75h2m0eHasijBQLsjZDpXIaO2hDXVYFvb+wVmiLqnH4cOC2dT08NmERk3l+X
         xrkbW1o1c8kh/m56dCaGkHV0bikzVaVQv/b4g7jy8N1LyEJm9CcRKMd7sqFYJkfB+x9O
         hHujIGQXf8oBMh639V6IgsSmQJZRNeP21e+jxFRapYJm+ISnKhPlVFrS9mODEOcfvUrO
         66Yg==
X-Gm-Message-State: AOAM531DCP6hRQjuvIrr8cHtzR9IqbVcF833wVOF/mZMiePrpE07vKXd
        /ZPMH4Zdi5hs/4kEoo/CgXdqPshBEm3qpB921fo=
X-Google-Smtp-Source: ABdhPJxarELIda9BdkJ7SJjmbbsDohBkKUgB+glJm3H5l/8erQhTr8Kjv8ed/NZN3258+8GAScbqj8oBKF0SwWNj20E=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr3077484oic.31.1602869287986;
 Fri, 16 Oct 2020 10:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com> <9c8b6a1a943261635fa09bed22ae36e368686f15.1602710025.git.gitgitgadget@gmail.com>
 <2b757512-793d-a6e0-0a50-368061e122dd@gmail.com>
In-Reply-To: <2b757512-793d-a6e0-0a50-368061e122dd@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Oct 2020 10:27:56 -0700
Message-ID: <CABPp-BHkykWh8L_FYhLR1BCCpPDmc_2q+Tccg_yZ7W8ZHZ4WsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] test-lib: allow selecting tests by substring/glob
 with --run
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, Oct 16, 2020 at 4:41 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 14/10/2020 22:13, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Many of our test scripts have several "setup" tests.  It's a lot easier
> > to say
> >
> >     ./t0050-filesystem.sh --run=setup,9
> >
> > in order to run all the setup tests as well as test #9, than it is to
> > track down what all the setup tests are and enter all their numbers in
> > the list.  Also, I often find myself wanting to run just one or a couple
> > tests from the test file, but I don't know the numbering of any of the
> > tests -- to get it I either have to first run the whole test file (or
> > start counting by hand or figure out some other clever but non-obvious
> > tricks).  It's really convenient to be able to just look at the test
> > description(s) and then run
> >
> >     ./t6416-recursive-corner-cases.sh --run=symlink
> >
> > or
> >
> >     ./t6402-merge-rename.sh --run='setup,unnecessary update'
>
> The beginning of match_test_selector_list() looks like
>
> match_test_selector_list () {
>         title="$1"
>         shift
>         arg="$1"
>         shift
>         test -z "$1" && return 0
>
>         # Both commas and whitespace are accepted as separators.
>         OLDIFS=$IFS
>         IFS='   ,'
>         set -- $1
>         IFS=$OLDIFS
>
>         # If the first selector is negative we include by default.
>         include=
>         case "$1" in
>                 !*) include=t ;;
>         esac
>
>         for selector
>         do
>
> If I'm reading it correctly the selectors are split on commas and
> whitespace which would mean we cannot match on "unnecessary update". I
> think we definitely want the ability to include whitespace in the
> selectors in order to be able to narrow down the tests that are run. I'm
> not sure that there is much value in splitting numbers on whitespace as
> it would mean the user has to quote them on the command line so we can
> probably just do 'IFS=,'. We'd also need to keep IFS as ',' in the case
> statement you add below as well rather than restoring it straight after
> the 'set' statement above.

Given that t/README explicitly shows examples of space-separated lists
of numbers, I'm worried we're breaking long-built expectations of
other developers by changing IFS here.  Perhaps I could instead add
the following paragraph to t/README:

Note: The argument to --run is split on commas and whitespace into
separate strings, numbers, and ranges, and picks all tests that match
any of individual selection criteria.  If the substring you want to
match from the description text includes a comma or space, use the
glob character '?' instead.  For example --run='unnecessary?update
timing' would match on all tests that match either the glob
*unnecessary?update* or the glob *timing*.

Does that address your concern?  The '?' will of course match on
characters other than a space or comma, but the odds that it actually
matches anything other than what you want is pretty slim, so I suspect
that is good enough.
