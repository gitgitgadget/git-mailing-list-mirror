Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03D5C1B0E3
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB63522EBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgLESTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbgLERuG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 12:50:06 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B26C0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 09:49:26 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id s2so755778oij.2
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 09:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AoeC3NvUc1NmKeKiC1d2FWjr/iYYQT2qpVLk2oVWl7s=;
        b=vGOyY3abfZ2R2WiYlZ+1lMYdqbWFYQ0uaxGxkG4tNm+E/Hv7bbMCqA1zdlGHLuyXIH
         Uok/8OJZAX9npPesMM9EpslPwmiW6dwRFqnDxKu1UQGd6K1eJ434sxLlRjVL344qHbon
         knXLCyD2ZUhSgjLlcY45uL0+JEZXsh1W9wYA5MG+P/tARRlqsqotvzKhHXfNkuixBYGA
         6NbLifz8A3S/oQaPpLusuf5ol5Uz5WNu2hqVSQbEdkoyArd/OBp+abikj9RWpPbxOhcC
         gA8FwrS4imtynR/lvCwkIMUMTDHXix9OfWpOirZ2SH4G5hGJjAMShSOPYX3n4WaoKmbv
         UhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AoeC3NvUc1NmKeKiC1d2FWjr/iYYQT2qpVLk2oVWl7s=;
        b=Rb4kpLUMiDG4TowXlKcDLgPIUeEDu5Pi/th4r4f1VEGQ/0XFGT2eQ3kVOIMY10IxME
         sN9BgjYjtp/F//qmL6M0ZTdZVWfysz0rsrTs8CaNVMnn04ySWiAgGUlkJ9JPs+sHzndX
         tAcYrYBj87k90/4PJZdERWgt/+v+qCKRdC371iJW5oV9c5ssmLIugD/IE7CY5RpuYQ9Q
         3V1wqiioYSgxYmhNXt8i78m2DYDVcM+9cwd/PH9ZJ3lj9Dw7NS0cc5tviNhIyg5VIHy6
         yxwFKLS6qfYgV/J0xjieNz5snPpbG2UaHubPHwNfdQeiJtedk9RQ9APVER7joThfipw/
         N2YQ==
X-Gm-Message-State: AOAM533O33yfLBJ11/2QAycV3cH8IlnHFBag4HJva4JOiRDkCiLuhXWy
        0+5Fw4JABsHItFGSpCZoPooe4CySOUNxxI4GZxg=
X-Google-Smtp-Source: ABdhPJwm6aVhwFa5cKjLwC3bGCkUdUOLIPVl/nMlTsmuHIzoCqhwbJDm2Pe96JeC+y7LkETahOkCnQ0vMbK1DlcIk6k=
X-Received: by 2002:aca:49d5:: with SMTP id w204mr6985360oia.167.1607190565349;
 Sat, 05 Dec 2020 09:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201108213838.4880-1-sorganov@gmail.com>
 <CABPp-BHdhvLRe4jCSsRtPrbh2=kwJxEQs0Dx+Ng1Vutx8Hdqqw@mail.gmail.com>
 <871rg6hdrk.fsf@osv.gnss.ru> <CABPp-BGE4rA5=8NUaK5607moR13bE7PcyVKdbw6nDw5YBeq9bQ@mail.gmail.com>
 <87sg8lnzor.fsf@osv.gnss.ru>
In-Reply-To: <87sg8lnzor.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Dec 2020 09:49:14 -0800
Message-ID: <CABPp-BFB9aaJV1uvYk1QQ6E8zQ=_Jv6KhHb1grA5+Bh+qsTG8g@mail.gmail.com>
Subject: Re: [PATCH v1 00/27] git-log: implement new --diff-merge options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 11:23 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Dec 3, 2020 at 11:48 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > On Sun, Nov 8, 2020 at 1:43 PM Sergey Organov <sorganov@gmail.com> wrote:
> >> >>
> >> >> These patch series implement new set of options governing the diff output
> >> >> of merge commits, all under the umbrella of the single
> >> >> --diff-merges=<mode>
> >> >> option. Most of the new options being synonyms for -m/-c/--cc options,
> >> >> there is also additional functionality provided, allowing to get
> >> >> the format
> >> >> of "-p --first-parent" without change in history traversal that
> >> >> --first-parent option causes.
> >> >>
> >> >> The net result of these series are the following new options:
> >> >>
> >> >> --diff-merges=   |  old equivalent
> >> >> -----------------+----------------
> >> >> first-parent     | --first-parent (only format implications)
> >> >> separate         | -m
> >> >> combined         | -c
> >> >> dense-combined   | --cc
> >> >
> >> > Interesting.  I have some local patches implementing another choice,
> >> > with the new flag --remerge-diff.  This flag will cause `git show` or
> >> > `git log` to automatically remerge the two parents in a 2-parent merge
> >> > commit, and then diff the merge commit against that automatic merge,
> >> > showing the result.  Thus, the diff for a merge commit is likely to be
> >> > empty if the merge was clean, and is likely to show the removal of
> >> > conflict markers if the merge was not clean.
> >> >
> >> > I'm curious how it'd interact with this new option.  Would it also get
> >> > a name, e.g. --diff-merges=remerge-diff?  Feels like a mouthful, but I
> >> > can't come up with anything better.
> >>
> >> Maybe, --diff-merges=remerge?
> >>
> >> >
> >> > Also, I'm curious how it'd interact with another option I added, named
> >> > --remerge-diff-only.  This latter option modifies revision traversal
> >> > in that it skips octopus merges, root commits, and single parent
> >> > commits IF no cherry-pick or revert information can be found.  If it
> >> > finds a 2-parent merge commit, it behaves like --remerge-diff.  If it
> >> > finds a 1-parent commit with cherry-pick or revert information, it'll
> >> > do an in memory repeat of that cherry-pick (or revert) and then diff
> >> > the actual commit against what the automatic cherry-pick would
> >> > perform.  Again, that likely means an empty diff if the automatic
> >> > cherry-pick was clean, and showing any changes made by the user to
> >> > complete the original cherry-pick (such as deleting conflict markers
> >> > and picking which chunks from which side to keep) if the automatic
> >> > cherry-pick was not clean.  (I suspect --remerge-diff-only is much
> >> > more likely to be used with `git show` than with `git log`.)  Anyway,
> >> > your changes seem to suggest that anything relating to how diffs for
> >> > merges are handled should be documented in the same section, but
> >> > --remerge-diff-only doesn't fit.  And it'd seem odd to have
> >> > --remerge-diff and --remerge-diff-only not show up in adjacently but
> >> > be split into separate sections.  Any ideas?
> >>
> >> Sounds like commits limiting option to me. I think it could be named by
> >> its limiting behavior only, say, --remerges. Then it will imply
> >> --diff-merges=remerge, that'd allow user to re-define diff format if she
> >> needs to.
> >
> > It is commit limiting, but the focus is more on the behavioral change
> > in how diffs are shown:
> >   * for 2-parent merges
> >   * for single-parent commits with cherry-pick or revert information
> > and acknowledging that since it has _altered_ the normal way of
> > showing diffs for a number of single-parent commits, that it'd be
> > confusing to show normal diffs of unaffected commits (how would you be
> > able to tell what type of diff you're looking at if both appear in the
> > log?).  Thus, it does commit limiting to only select commits which
> > will make use of the new diff type.
>
> That's how you currently look at it.
>
> For me it looks like pure commit limiting with these criteria might be
> useful by itself, and with my suggestion one could then achieve it
> using, say:
>
> --remerge-diff-only --diff-merges=off

I see what you're saying, and I think there's some value in it.  But I
think there's something still missing.  For example, you suggest
getting the commit limiting I mention with

    --remerge-diff-only --diff-merges=off

But --diff-merges is only supposed to control _merge_ commits, which I
flagged as the big impedance mismatch for my new option.  Why would it
turn off diffs for non-merge commits like cherry-picks and rebases?

> >
> > (I suspect it will be more common for folks to use the
> > --remerge-diff-only option, or whatever we end up calling it, with
> > `git show` where the commit limiting doesn't matter -- but I have used
> > it with log to go looking for "evil" reverts/cherry-picks that might
> > have occurred in history.)
>
> What you describe is complex enough to doubt it could be entirely
> described by option name, so shorter --evils might be better choice
> in this case.
>
> Overall, if you add --diff-merges=remerge as a new diff format, and then
> --evils that implies the former, then it seems like all possible
> use-cases will be covered, and you have short option name for the most
> useful case.

Since you want things to have orthogonal subcomponents that can be
built up, let's assume we did make --remerge-diff-only be solely about
commit limiting.  In that case, --evils could be gotten by specifying
a combination of flags, and --evils would just be a shorthand.  What
are the flags that you would need to specify, though?  In particular,
you've only named two options above and they don't cover the necessary
behavior; a third is needed:

   --remerge-diff-only --diff-merges=remerge
--${DIFF_OPTION_NAME_FOR_CHERRY_PICKS_AND_REVERTS}=remerge

The first two aren't enough because --diff_merges only changes how
diffs for _merge_ commits are shown, and we need a flag for changing
how the single-parent cherry-pick and reverts are shown.
