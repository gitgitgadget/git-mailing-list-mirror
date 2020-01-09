Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94DEC282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 18:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBFE2067D
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 18:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azLN+vlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbgAISGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:06:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40221 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbgAISGE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 13:06:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id w21so8157205otj.7
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 10:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySVlPvTGKxA/NC/6N9UZVWEPgwhTbXDdChMz2wKhSLk=;
        b=azLN+vlWaVZ6SPxBWvhWfydHyY2uXI7LbLIXQLpjsdjWfuSgqbLy0ZXIIWOBHnWSpF
         /ddIAsOZwXYAn2SOztecFWKxG38UfaNc3I/wgvXjmDU6V7mYlwm9IC9D6Qx+ejrwBQQ2
         nYapPcRXAFgVuh0xbqAwsoU2l2HNpL+6jZcZo7CualqSdzZycCN1ys8lshA1pSOLyNwK
         5LN9KoEU2qVwP66grRw0+g3jHfAg66oEFc1ld4BYiV5Oydw6rA8iATfvy8B4pnYF3YIG
         yzxPRICi8Q71QUgtBZllRWwXytRNUTbVdv6Zf7Zg36JAYlPbdDGvQvAEAC1KTL/4PugU
         qO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySVlPvTGKxA/NC/6N9UZVWEPgwhTbXDdChMz2wKhSLk=;
        b=qVj4yVoiU8PocSAYdZNBpCsd1bBkC9trayh9jKDfdubSzZpv8YBYOClIiJyo0OIx56
         dqc54fPmQ7UBaFooab0HR+lkpPmLviMAK4ZJiv6AjSCYRozfiKeHc6ICrK9gg02IjSfT
         22QUYudwu3lf7uLOq8Sz9vEOjL7M0VbruBOSPKDqexXqndj0eShd9cAaChozsS1Fvrdu
         WUUn2aKVAU0cUIw6iGooygVTE2cV+sl1lz9ef4WPIYKyqgvBMOFVWK3sGb6AttQjV64V
         aXu4QvhwC/Dqis7jwbZmwgHg9HKHCxWNcmrw7XO/lKseq4TtwW+Gg1QJ2VxxRO0C7mFE
         Qq9w==
X-Gm-Message-State: APjAAAVTHtHfoJjbJB6Tgk5ifDlyhjMlkHCEbUN/r3xCHEusouO6uEoo
        PVnGtX7QAYwXmc2vHldP08uLkPrbYgHgF0wz/WY=
X-Google-Smtp-Source: APXvYqx07fJs8BK+RgSJ4o7u8CQ+AIOHYn0/P+uvzMRLRyJ1IhSidHCk7TjiNNErBG0WElSDq7Yj4AL7qT9I2AgYOBM=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr9274705otq.112.1578593163369;
 Thu, 09 Jan 2020 10:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20200108214349.GA17624@lxhi-065.adit-jv.com> <CABPp-BHsyMOz+hi7EYoAnAWfzms7FRfwqCoarnu8H+vyDoN6SQ@mail.gmail.com>
 <20200109105307.GA1349@lxhi-065.adit-jv.com>
In-Reply-To: <20200109105307.GA1349@lxhi-065.adit-jv.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Jan 2020 10:05:52 -0800
Message-ID: <CABPp-BFiDNb18m8geTCxKLXg0fOd0DS1dWRVWCfnTG0suwGRHg@mail.gmail.com>
Subject: Re: Unreliable 'git rebase --onto'
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 9, 2020 at 2:53 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
>
> Hi Elijah, hi Szeder,
>
> On Wed, Jan 08, 2020 at 02:06:22PM -0800, Elijah Newren wrote:
> > This looks like a known bug in rebase, in particular in the am-backend that
> > rebase uses by default.  If I'm correct that it's just a context region
> > issue, then this is the same bug that was recently discussed at
> > https://lore.kernel.org/git/CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com/.
> > The current plan is to switch the default over to the merge backend (the
> > same machinery that cherry-pick uses), which doesn't suffer from the same
> > shortcomings (you can see the current work being done in this area at
> > https://lore.kernel.org/git/pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com/
> > ).
>
> Thank you for your feedback and references, here and in [*].
>
> Once hit by this or similar issues, I think there is high chance for
> people to go through the same feelings as described by Pavel in [**]:
>
>   ---
>   That's so scary that I'm going to stop using "git rebase" for now.
>   ---

Yep, I understand; that kind of feeling is why I wanted to jump in and
try to help fix it.  I want merge/rebase/cherry-pick to be reliable.

> Some years ago I was hit by 'git merge' producing slightly different
> results compared to 'git rebase --onto' and 'git cherry-pick A..B'
> (maybe I can come up with a reproduction scenario for that too).

If you can, I'd be interested to see it and take a look.  I'd normally
assume it was just some case where A..B included "evil" merge commits
(merge commits that made additional changes not part of the actual
merging) since rebasing or cherry-picking such a range would exclude
the merge commits and thus drop those changes -- but you identified a
real bug with the default rebase backend so I'm interested to see if
you happen to have more bugs I should know about.

>
> Since then, I usually contrast the outcomes of merging, cherry-picking
> and rebasing, to make sure they match, but that's painful and
> time-consuming.
>
> > In the mean time, you can pass the -m flag to rebase to avoid these types
> > of problems.  In fact, if you could retry with -m you may be able to
> > confirm whether it's the same issue.
>
> Indeed, neither `git rebase -m` nor `git rebase -i` exhibit the problem.

That's good news.

Unfortunately, you should note that git-2.25 is going to have the same
bug you reported; there are still some loose ends with my series to
make -m the default, and the 2.25 release is expected within a few
days, so my change of default won't happen until 2.26.  (That series
would have needed to be completed several weeks ago for it to go into
2.25).
