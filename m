Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9610FC433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E70221D7F
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piZMVaaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgJNRuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgJNRuS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 13:50:18 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4F7C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:50:16 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id c13so77902oiy.6
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUuLPKeLe9Xgf5BWe9wVimKjHeeUF6WNxmiIEJbs6sE=;
        b=piZMVaaFjmLAb4nIttEE6XEmqkwmDqPsLhKK/ByOchp/Eq/klJJBxsiEDlobjBQmNu
         KihoQ/YUqarKsV/6ltw2T0kSHjEcPMGwJo+t1TEa2f/UHW0s5ILYpabyIp9JL7KtSSPJ
         2hBnmsWoa8gnfRoeaieTOgNOsQNmru2AEyfcP8+2K7EMjSHzaQLT3AThrRncEElgxKS3
         kXb8LbdkDgACda9DkhdvZenCUDu3Wxft6DoFpaKn+9sNFplPQiIflHMNE4gpxS4iwoiu
         Hf7lMw0uXm5+ALztiJ13hbtAxow3pETm7C89HZYUsp6dq5pDotJjiqYJOcIhr6nSqHAM
         kFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUuLPKeLe9Xgf5BWe9wVimKjHeeUF6WNxmiIEJbs6sE=;
        b=bnTR+Hz62fHKOAU95gHZRYu/vu5cB7ehn6ZvOuqEUm8b5ig+4aymIvhU4tY7esT/sQ
         GP1LISPMf5qsfc7Bttr60Fa0E8s89pcbHQYBnZK1tjGIjdJldiobF0FUb3avwzXSIfnr
         4alfu33TktxfqShYoLnvPx+J8tCxilA158X9EOMQp/9Ce2Sn9PuN5aTDGVhh7pEKDA8u
         iFL7+qQvpg4bkZUjJNZX0wr+Wp0y4pPgg5wtI/Ju00cxiUd9Ffy8TCM3D1DSddLhcW17
         /pqMVOjT9aufuVzkG5q4OXMSyeAaeHuuxHgVHKFhgfofwA2KWHkahAMKh6Pccsrqozt5
         NLww==
X-Gm-Message-State: AOAM530mFFMjwDfdqQv1lElZfTTTO0pf/ijqn98rwzZe9HTt98VMcHGW
        nYkz8Nxlj3YtZoGvU/QAVPY6GSChOobDW901BnIOSeefgrrQ/A==
X-Google-Smtp-Source: ABdhPJyNUt0feQEEsralinGhxD7JGB6pUtttulYtXwxS4JwgwNtlowFlePlrWb+SlCBZWfTmd9SfvmL2RsVq5fZuiIc=
X-Received: by 2002:aca:ec92:: with SMTP id k140mr333886oih.39.1602697815015;
 Wed, 14 Oct 2020 10:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com> <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net>
In-Reply-To: <20201014170413.GB21687@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Oct 2020 10:50:03 -0700
Message-ID: <CABPp-BEOrYhUBZ112Z7qFgwUYojmus6_Ra0G0Ts4y+n=-D5vMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by substring/regex
 with --run
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 10:04 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 07:19:44PM +0000, Elijah Newren via GitGitGadget wrote:
>
> > Many of our test scripts have several "setup" tests.  It's a lot easier
> > to say
> >
> >    ./t0050-filesystem.sh --run=setup,9
>
> I like this direction very well.
>
> There was a small discussion recently that we might be better off
> dropping test script numbers entirely, and allowing selection of script
> names by word-hierarchy or regex, too. That's mostly orthogonal to what
> you're doing here, but I think this is taking us in a good direction
> there.
>
> > @@ -819,9 +821,8 @@ match_test_selector_list () {
> >                       *)
> >                               if expr "z$selector" : "z[0-9]*[^0-9]" >/dev/null
> >                               then
> > -                                     echo "error: $title: invalid non-numeric in test" \
> > -                                             "selector: '$orig_selector'" >&2
> > -                                     exit 1
> > +                                     echo "$title" | grep -q "$selector" && return
> > +                                     continue
> >                               fi
>
> I like that you allow regexes. It's unfortunate that the skip-check
> costs us a process in every test. It may not be that big a deal since we
> only pay it if you use a non-numeric selector. But I wonder if there's
> any reason not to use "expr" here, as well.

I originally used [[ $title =~ "$selector" ]] in order to avoid the
sub-shell...but that was bash-specific.  I briefly looked to see if
there was a shell portable way to handle regexes, wasn't having much
luck, and decided that this is only likely to arise when people are
passing --run and thus only running a single script and they avoid all
the subprocesses that would have been invoked inside the test, so it's
still a big net win overall.  Does expr handle regexes, portably?  Or
are you suggesting dropping the regex handling and limit it to
substring matching?  In either case, does using expr save us anything
(isn't expr a shell command)?
