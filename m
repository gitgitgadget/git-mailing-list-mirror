Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E674EC4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C55A22211
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgLCUkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 15:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgLCUkH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 15:40:07 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0733C061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 12:39:26 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f16so3059631otl.11
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 12:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8deQO6p+z/KHISqHCaAcA9lIIk9zVd7JCwqCATLjClE=;
        b=iNp6Ag8st4uz2LpGrqPOuoA6B97PZrgjbBl7DKlYhhf5TivYkBY21DXtfA5RHEf2J3
         wf641wmmcn4lmG7J3BjNPtr0gUwYAsa2RRrwvPfUMVbKdL8u34df3gZ0e/9P6UPzYXSy
         Hwx3drdIS7bADrc7N0AO1m5QSbR/4yrPBGldasqScIHtNybgvfPlPQBlwqPwYhtTOeyt
         mMHLctLkp8m51Y74FL8QMHLkJh1O7HYmXzcg0LXjd5W2VlybKJmE0uDiVa7xgeb5yQgL
         Md1rM58x684CM4R4GG1XDYUDMLIbMaPPMVg4vTXxKOhYeBA7dauxo0KbTOPcx+dih/Le
         K/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8deQO6p+z/KHISqHCaAcA9lIIk9zVd7JCwqCATLjClE=;
        b=jrLEkFU1eDKPhXg+Azs+EWv5LSLIblDzr4wPDSOveVfsOwVo2Vka5CiXDUqUnuyRKe
         V/X+lNh9lh5P6CPT3Qhyk5mtoZycpDEptMtDMmjzmWgFgRBj09nbOOe/R29XLQuuf0lZ
         mqH3z/PANo3y4am4NMmT+4f4bVLObAgAAAKYYS3f4zQc9i6vZRZu9xPTxduj65Ld0lOJ
         FeeBNkredRkp+yKNXHdoVxa1HxsS/X2mD8w8zchSASlWTz6YphNUk+ughYB9t9NJqHww
         +PWLbJ+Z3oW2jXrpdA5ojBIL69XQv3F8+wJ4hKGH/iRmPOqHKHfDaWoRLlOVgvCi1tRj
         4lEQ==
X-Gm-Message-State: AOAM530/ycaRA5heTmw7QcuQMp7fDzhI0S0JNRxdC7J+WpJV9Rsh9Tze
        LE5N0/sJvBQ+ms7TrXjELOFS47DWg+uH7RiP4at1uFZtAk8=
X-Google-Smtp-Source: ABdhPJyyVpdRwpcmsRiiJK5o8w8hhJHf6FMNGmxWdwvgD+dFWsMF8SD6YMoPN5DHHfwGZDs9r/UzPpvpCwMxnc5lHA4=
X-Received: by 2002:a05:6830:12c2:: with SMTP id a2mr879103otq.162.1607027966179;
 Thu, 03 Dec 2020 12:39:26 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201108213838.4880-1-sorganov@gmail.com>
 <CABPp-BHdhvLRe4jCSsRtPrbh2=kwJxEQs0Dx+Ng1Vutx8Hdqqw@mail.gmail.com> <871rg6hdrk.fsf@osv.gnss.ru>
In-Reply-To: <871rg6hdrk.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Dec 2020 12:39:15 -0800
Message-ID: <CABPp-BGE4rA5=8NUaK5607moR13bE7PcyVKdbw6nDw5YBeq9bQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/27] git-log: implement new --diff-merge options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 11:48 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Sun, Nov 8, 2020 at 1:43 PM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> These patch series implement new set of options governing the diff output
> >> of merge commits, all under the umbrella of the single --diff-merges=<mode>
> >> option. Most of the new options being synonyms for -m/-c/--cc options,
> >> there is also additional functionality provided, allowing to get the format
> >> of "-p --first-parent" without change in history traversal that
> >> --first-parent option causes.
> >>
> >> The net result of these series are the following new options:
> >>
> >> --diff-merges=   |  old equivalent
> >> -----------------+----------------
> >> first-parent     | --first-parent (only format implications)
> >> separate         | -m
> >> combined         | -c
> >> dense-combined   | --cc
> >
> > Interesting.  I have some local patches implementing another choice,
> > with the new flag --remerge-diff.  This flag will cause `git show` or
> > `git log` to automatically remerge the two parents in a 2-parent merge
> > commit, and then diff the merge commit against that automatic merge,
> > showing the result.  Thus, the diff for a merge commit is likely to be
> > empty if the merge was clean, and is likely to show the removal of
> > conflict markers if the merge was not clean.
> >
> > I'm curious how it'd interact with this new option.  Would it also get
> > a name, e.g. --diff-merges=remerge-diff?  Feels like a mouthful, but I
> > can't come up with anything better.
>
> Maybe, --diff-merges=remerge?
>
> >
> > Also, I'm curious how it'd interact with another option I added, named
> > --remerge-diff-only.  This latter option modifies revision traversal
> > in that it skips octopus merges, root commits, and single parent
> > commits IF no cherry-pick or revert information can be found.  If it
> > finds a 2-parent merge commit, it behaves like --remerge-diff.  If it
> > finds a 1-parent commit with cherry-pick or revert information, it'll
> > do an in memory repeat of that cherry-pick (or revert) and then diff
> > the actual commit against what the automatic cherry-pick would
> > perform.  Again, that likely means an empty diff if the automatic
> > cherry-pick was clean, and showing any changes made by the user to
> > complete the original cherry-pick (such as deleting conflict markers
> > and picking which chunks from which side to keep) if the automatic
> > cherry-pick was not clean.  (I suspect --remerge-diff-only is much
> > more likely to be used with `git show` than with `git log`.)  Anyway,
> > your changes seem to suggest that anything relating to how diffs for
> > merges are handled should be documented in the same section, but
> > --remerge-diff-only doesn't fit.  And it'd seem odd to have
> > --remerge-diff and --remerge-diff-only not show up in adjacently but
> > be split into separate sections.  Any ideas?
>
> Sounds like commits limiting option to me. I think it could be named by
> its limiting behavior only, say, --remerges. Then it will imply
> --diff-merges=remerge, that'd allow user to re-define diff format if she
> needs to.

It is commit limiting, but the focus is more on the behavioral change
in how diffs are shown:
  * for 2-parent merges
  * for single-parent commits with cherry-pick or revert information
and acknowledging that since it has _altered_ the normal way of
showing diffs for a number of single-parent commits, that it'd be
confusing to show normal diffs of unaffected commits (how would you be
able to tell what type of diff you're looking at if both appear in the
log?).  Thus, it does commit limiting to only select commits which
will make use of the new diff type.

(I suspect it will be more common for folks to use the
--remerge-diff-only option, or whatever we end up calling it, with
`git show` where the commit limiting doesn't matter -- but I have used
it with log to go looking for "evil" reverts/cherry-picks that might
have occurred in history.)

> I mean, it looks very similar to --first-parent to me in the ways it
> could be defined/implemented. Recall that --first-parent now implies
> --diff-merges=first-parent.
>
> [...]
>
> >>
> >> Updates in v1:
> >
> > A minor point, but this should have been labelled v2.  The unlabelled
> > original submission is v1.
>
> Well, I did consider it when prepared v1, but given:
>
>   git format-patch --reroll-count=0
>
> produces [PATCH], it only sounds natural to follow with
>
>   git format-patch --reroll-count=1
>
> that produces [PATCH v1].

I didn't know about --reroll-count, I've always just seen people jump
from [PATCH] to [PATCH v2].  Interesting.
