Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D3DC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 05:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6856610CD
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 05:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhFQFGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 01:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQFGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 01:06:16 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D04C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 22:04:09 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so5163621oiv.1
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 22:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecu5hdNrt8xt/jdk7K82YuwBw9pEjkpYcIJwNUzOY2I=;
        b=JTAsTcnbq82XqOXZTo7VGQYOfHqYeDTWxNqMKBPNYFawElhROqnMgAT1UdS1oqQ7XN
         /gvPJO5b12cQ5NPUO2hcE/i4EOh2MDCwGTMLdpGz54HJN/OKF7ccaCL9VNyRNgnLE9QE
         uwtURRxmtWHkehqG42E/U89UuyHquJfk3K3KFxi87Pkr6IJmTl9TnyxPRRbmFECp/KJb
         IWacSdpeL/G+Sj8ihs2g64uzDI8x4822k1UJatRA3+2fhROhux28ruy9v9UgPTCLF+hn
         GAi44vYZBlBBsGuSj+QDbS8q9bUmzX/rNmtFJywUrQ9xua7ao8Mcz/1s6Jlqg8gfyN+k
         Sc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecu5hdNrt8xt/jdk7K82YuwBw9pEjkpYcIJwNUzOY2I=;
        b=sJ0FEKpiZptTHySWEvpoPS4fH++RoqJw/gBv6TdWv4uZHNXOt/jzmIdb0V/5e7EgzK
         c2o6u4A6CWPIg+R5uD9ezLtJl7i7uV1zIP/5cDCxzM7ri6i4qCngQG0lgsmSwFNPNrao
         LjWu8k+kEI0lZQMeMhWlEvRa+MfIlCbS3JdsOKnSEJAnVtCf5lCd7jDtHN1KDAoQHBTJ
         vx5N0f0dPTtc5YFeD9kozyT+IaK1lIyT7ojUXnYyQMRsMpAw8wXh5Rc6Wl8N9IQQdSCm
         iSRkpvn/gEDZ5EmOP/5Bv79mi/RnsMrixw+muEwtXJ4Eft7AplKBCm06wdUydK1QZq7l
         CQBQ==
X-Gm-Message-State: AOAM533Q/7rP/Xx5x5eLghyRQRm63D/Dc8KZOhVI6oYQ9ud03Yeo6+2g
        00H2SAJsIVodw0PDJgFfwz4hi550yxNP+ej964H4QTJpxds=
X-Google-Smtp-Source: ABdhPJwsL8VECU8B5P/GocDJ4FWnEQgVpNU70LPwdW0qxAYNw4zygqiu0p7OWFco+x0fG9rppY8xG/On1zHN6cg81y0=
X-Received: by 2002:aca:f482:: with SMTP id s124mr9152317oih.167.1623906248066;
 Wed, 16 Jun 2021 22:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <YMh2M8Ek/RUVjKkL@coredump.intra.peff.net> <CABPp-BE7-E03+x38EK-=AE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.com>
 <255df678-9a31-bba2-f023-c7d98e5ffc15@gmail.com>
In-Reply-To: <255df678-9a31-bba2-f023-c7d98e5ffc15@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Jun 2021 22:03:56 -0700
Message-ID: <CABPp-BG-vO6Kf8=oyGYOShvtyZE6AajcRuGf3pCMKkpr9X-eYA@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: implement new zdiff3 conflict style
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 1:57 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 15/06/2021 20:35, Elijah Newren wrote:
> > On Tue, Jun 15, 2021 at 2:43 AM Jeff King <peff@peff.net> wrote:
> >>
> >> On Tue, Jun 15, 2021 at 05:16:08AM +0000, Elijah Newren via GitGitGadget wrote:
> >>
> >>> Implement a zealous diff3, or "zdiff3". This new mode is identical to
> >>> ordinary diff3 except that it allows compaction of common lines between the
> >>> two sides of history, if those common lines occur at the beginning or end of
> >>> a conflict hunk.
> >>>
> >>> This is just RFC, because I need to add tests. Also, while I've remerged
> >>> every merge, revert, or duly marked cherry-pick from both git.git and
> >>> linux.git with this patch using the new zdiff3 mode, that only shows it
> >>> doesn't segfault. (Though I also reran 10% of the linux remerges with zdiff3
> >>> under valgrind without issues.) I looked through some differences between
> >>> --remerge-diff with diff3 and --remerge-diff with zdiff3, but those are
> >>> essentially diffs of a diff of a diff, which I found hard to read. I'd like
> >>> to look through more examples, and use it for a while before submitting the
> >>> patches without the RFC tag.
> >>
> >> I did something similar (but I wasn't smart enough to try your
> >> remerge-diff, and just re-ran a bunch of merges).
> >
> > What I did was great for testing if there were funny merges that might
> > cause segfaults or such with zdiff3, but not so clever for viewing the
> > direct output from zdiff3.  Using remerge-diff in this way does not
> > show the [z]diff3 output directly, but a diff of that output against
> > what was ultimately recorded in the merge, forcing me to attempt to
> > recreate the original in my head.
> >
> > (And, of course, I made it even worse by taking the remerge-diff
> > output with diff3, and the remerge-diff output with zdiff3, and then
> > diffing those, resulting in yet another layer of diffs that I'd have
> > to undo in my head to attempt to construct the original.)
> >
> >> Skimming over the results, I didn't see anything that looked incorrect.
> >> Many of them are pretty non-exciting, though. A common case seems to be
> >> ones like 01a2a03c56 (Merge branch 'jc/diff-filter-negation',
> >> 2013-09-09), where two sides both add functions in the same place, and
> >> the common lines are just the closing "}" followed by a blank line.
> >>
> >> Removing those shared lines actually makes things less readable, IMHO,
> >> but I don't think it's the wrong thing to do. The usual "merge" zealous
> >> minimization likewise produces the same unreadability. If we want to
> >> address that, I think the best way would be by teaching the minimization
> >> some heuristics about which lines are trivial.
> >>
> >> Here's another interesting one. In 0c52457b7c (Merge branch
> >> 'nd/daemon-informative-errors-typofix', 2014-01-10), the diff3 looks
> >> like:
> >>
> >>    <<<<<<< ours
> >>                    if (starts_with(arg, "--informative-errors")) {
> >>    ||||||| base
> >>                    if (!prefixcmp(arg, "--informative-errors")) {
> >>    =======
> >>                    if (!strcmp(arg, "--informative-errors")) {
> >>    >>>>>>> theirs
> >>                            informative_errors = 1;
> >>                            continue;
> >>                    }
> >>    <<<<<<< ours
> >>                    if (starts_with(arg, "--no-informative-errors")) {
> >>    ||||||| base
> >>                    if (!prefixcmp(arg, "--no-informative-errors")) {
> >>    =======
> >>                    if (!strcmp(arg, "--no-informative-errors")) {
> >>    >>>>>>> theirs
> >>
> >> A little clunky, but it's easy-ish to see what's going on. With zdiff3,
> >> the context between the two hunks is rolled into a single hunk:
> >>
> >>    <<<<<<< ours
> >>                    if (starts_with(arg, "--informative-errors")) {
> >>                            informative_errors = 1;
> >>                            continue;
> >>                    }
> >>                    if (starts_with(arg, "--no-informative-errors")) {
> >>    ||||||| base
> >>                    if (!prefixcmp(arg, "--informative-errors")) {
> >>    =======
> >>                    if (!strcmp(arg, "--informative-errors")) {
> >>                            informative_errors = 1;
> >>                            continue;
> >>                    }
> >>                    if (!strcmp(arg, "--no-informative-errors")) {
> >>    >>>>>>> theirs
> >>
> >> which seems worse. I haven't dug/thought carefully enough into your
> >> change yet to know if this is expected, or if there's a bug.
>
> XDL_MERGE_ZEALOUS coalesces adjacent conflicts that are separated by
> fewer than four lines. Unfortunately the existing code in
> xdl_merge_two_conflicts() only coalesces 'ours' and 'theirs', not
> 'base'. Applying
>
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index b1dc9df7ea..5f76957169 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -455,6 +455,7 @@ static int lines_contain_alnum(xdfenv_t *xe, int i,
> int chg)
>   static void xdl_merge_two_conflicts(xdmerge_t *m)
>   {
>          xdmerge_t *next_m = m->next;
> +       m->chg0 = next_m->i0 + next_m->chg0 - m->i0;
>          m->chg1 = next_m->i1 + next_m->chg1 - m->i1;
>          m->chg2 = next_m->i2 + next_m->chg2 - m->i2;
>          m->next = next_m->next;
>
> and running
>      git checkout 0c52457b7c^ &&
>      bin-wrappers/git -c merge.conflictstyle=zdiff3 merge 0c52457b7c^2
> gives
>
> <<<<<<< HEAD
>                 if (starts_with(arg, "--informative-errors")) {
>                         informative_errors = 1;
>                         continue;
>                 }
>                 if (starts_with(arg, "--no-informative-errors")) {
> ||||||| 2f93541d88
>                 if (!prefixcmp(arg, "--informative-errors")) {
>                         informative_errors = 1;
>                         continue;
>                 }
>                 if (!prefixcmp(arg, "--no-informative-errors")) {
> =======
>                 if (!strcmp(arg, "--informative-errors")) {
>                         informative_errors = 1;
>                         continue;
>                 }
>                 if (!strcmp(arg, "--no-informative-errors")) {
>  >>>>>>> 0c52457b7c^2
>
> Which I think is correct. Whether combining single line conflicts in
> this way is useful is a different question (and is independent of your
> patch). I can see that with larger conflicts it is worth it but here we
> end up with conflicts where 60% of the lines are from the base version.
> One the other hand there are fewer conflicts to resolve - I'm not sure
> which I prefer.

Oh, sweet, thanks for tracking this down!  I'll try to find some time
to play with it some more.
