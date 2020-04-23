Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BE9C2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 04:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F082071C
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 04:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtMMpNuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgDWEeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 00:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725562AbgDWEeB (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 00:34:01 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF93C03C1AB
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 21:34:01 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g10so4401767uae.5
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 21:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfnqEM21ho/XFJplkj0toAmNkYnY+ltYvYnHkwUlowc=;
        b=CtMMpNukjPLEbpw5fORVpyJ1xDqp+V/ssJctGIP/eiofNFv1nJBLaEVaxyVAJ21LXw
         LARI9PsvFqb4dd8T/Y6Rp6HVI9JaITETVPLgme4JN3VhjRfchlKShS2T6el71aCHpGdD
         L2TV0T7eIQRkoTU7E4mLF1CfSLTJ5ylry2l5xR68Boi0eP9gCxIWf2uVAlgZ6YMR24Oy
         Ac982WeMcZevUBmmlRsRcQF/Q8GWjF+Eufc17tQgYoPQyY5f4DxyA7aN4wKzY23Gp7Cq
         FSSvubE/xXNePys19kKlWqZ2gfjY/hK4SiCSDJkUmOMmFXVfUQxBLDThL4sfG2K/cnxw
         PrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfnqEM21ho/XFJplkj0toAmNkYnY+ltYvYnHkwUlowc=;
        b=dmZ0NOvyhuDWVlzgkehww+tJ96FFJaffS/NAVmWHPd7/s2MXQjPQuNCsdisw8mCVRG
         6rN0sdwo7zxV4KbyWh6/inlXzVjJnNxGP2lqMvNoqTIk9C0DmrcLFmf9bV6HiGHyhf0J
         zI4WZGU4DGO2kLBuDSWZrstD837NUX+EzSPHhftRtIFuwlor4tcGDgc4yVJt6qbHJiez
         rX1trtbgdOviJDedPREBueQkt+/OFpS3kiNcmSNo5/eiQbf0n87DCJqg5BJhS/QdyyhR
         hePmCuBYgQR3Ri1yPvMwkhumxGcek/KE8mScVtaj5/Fykb3ztEKIRV4rOCkBVI4mEmRY
         mPIQ==
X-Gm-Message-State: AGi0PuawuZ2KvVdQIwXnVh1Xa2UiV8tGQeAzZ0fj8J5wdg5bl9hWRfC2
        z2b8rD623VCmJt1MtGQHWC1hbcT0LfkprR3SxhKtrYGr
X-Google-Smtp-Source: APiQypK+t0m6+XTRatNgIpB6vuyhT5eBLdqbwj4pfRkppc+VQBe1OBJ8XdR8A4vl/zrjQ/QgBJ6NCV3KvfieMpC99qc=
X-Received: by 2002:ab0:6949:: with SMTP id c9mr1514849uas.27.1587616440677;
 Wed, 22 Apr 2020 21:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200422201541.3766173-1-jacob.e.keller@intel.com> <20200423020344.GI140314@google.com>
In-Reply-To: <20200423020344.GI140314@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 22 Apr 2020 21:33:50 -0700
Message-ID: <CA+P7+xqTONc_WKxswhrTFy=W3R_7GM+ySCd+gQN=Yw4fbMSSEA@mail.gmail.com>
Subject: Re: [PATCH] completion: complete remote branches with switch --track
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 7:03 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Jacob Keller wrote:
>
> > If the --track option is supplied to git switch, then a new branch will
> > be created tracking the specified remote branch.
> >
> > Fix git completion support so that remote branches will be completed
> > when --track is enabled.
> >
> > Add a couple of simple test cases to help cover this new behavior. Note
> > that ideally completion for --track would only allow remote branches,
> > and would not complete all refs like HEAD, FETCH_HEAD, etc, so one of
> > the new tests is a test_expect_failure to capture this.
> >
> > Fixes: ae36fe694180 ("completion: support switch")
> > Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> > ---
> > I wasn't able to figure out how to get completion to ignore things like tags
> > and similar, but I think this is still an improvement.
> >
> >  contrib/completion/git-completion.bash |  8 +++++---
> >  t/t9902-completion.sh                  | 22 ++++++++++++++++++++++
> >  2 files changed, 27 insertions(+), 3 deletions(-)
>
> Thanks for writing it.
>
> One part I found a little confusing is that --track is being used in
> two ways.  On one hand, it's an option to __git_complete_refs, meaning
> to complete remote-tracking branches.  On the other hand, it's an option
> to git switch, meaning to create a branch set up to "git pull" from a
> remote-tracking branch.
>

Sure, I might actually just go and write a patch to switch --track to
--dwim and allow --track only for backwards compatibility with
external completions.

> Can the commit message give a motivating example to describe what
> improvement to the user's life this change brings?  ("So now you can
> type 'git ... ' and hit TAB and see ....)
>
> Some nitpicks:
>
> [...]
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -2235,12 +2235,14 @@ _git_switch ()
> >               if [ -n "$(__git_find_on_cmdline "--guess")" ]; then
> >                       track_opt='--track'
> >               fi
> > -             if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
> > -                     only_local_ref=y
> > -             else
> > +             if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
> >                       # --guess --detach is invalid combination, no
> >                       # dwim will be done when --detach is specified
> >                       track_opt=
> > +             elif [ -z "$(__git_find_on_cmdline "--track")" ]; then
> > +                     # if neither --detach or --track are specified then
>
> language nits:
>
> - s/or/nor/ (because the clause starts with "neither")
> - s/are/is/ (because "either" and "neither" are singular)
>
> English can be odd.
>

Sure. It's easy to get this wrong, can fix.

> > +                     # match only local refs.
> > +                     only_local_ref=y
> >               fi
>
> Let me check that I understand correctly:
>
> If --detach is passed, the <start-point> parameter is an arbitrary
> commit.  So we want all refs (or even all commits), not just commits
> that are eligible for "git switch --guess" (the default mode) dwimery.
>

Yes.

> If --track is passed, the <start-point> parameter should be an
> arbitrary remote-tracking branch, not just a remote-tracking branch
> without corresponding local branch that would be eligible for --guess.
> A few lines up we handle this by setting track_opt to empty.
>
> If neither --detach nor --track is passed, then..
>
> ... I'm not sure I understand the neither --detach nor --track passed
> case.  Wouldn't this be --guess mode, where "$track_opt" is set, so the
> value of "$only_local_ref" isn't used?  Or is this about the case
> where (1) --detach is not passed, (2) --track is not passed, and (3)
> --no-guess or GIT_COMPLETION_CHECKOUT_NO_GUESS is passed?
>
> Yes, it must be about that case.  In that case, only_local_ref is
> right.
>
> In any case, this is getting difficult to understand, so I wonder if
> some refactoring is in order.
>

I think so. There's also room for improvement, because currently with
this patch:

git switch --track <TAB>

completes all refs including stuff like FETCH_HEAD, etc.

I think the most obvious thing would be to complete remote branches
only. We could complete more points if both track and -c are present,
indicating the user wants to track with a known name. (Since --track's
automatic naming is based on extracting the origin.

I don't think the current functions we use can quite handle what we
want so maybe it's time I try to dig into the gitref code to see if we
can extract the right refs with new options..

> [...]
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -1760,6 +1760,28 @@ do
> >       '
> >  done
> >
> > +test_expect_success 'git switch - default local branches only' '
>
> nit: "default to local branches only" or "the default is local
> branches only".  In other words, this should be a sentence so the
> reader can understand what property we're testing for.
>

Yea makes sense.

> > +     test_completion "git switch m" <<-\EOF
> > +     master Z
> > +     master-in-other Z
> > +     mybranch Z
> > +     mytag Z
> > +     EOF
> > +'
> > +
> > +test_expect_failure 'git switch - --track remote branches' '
> > +     test_completion "git switch --track " <<-\EOF
> > +     other/branch-in-other Z
> > +     other/master-in-other Z
> > +     EOF
> > +'
>
> Can this have a short comment describing the issue?  If over time the
> behavior changes, we wouldn't have an easy place to see what the
> behavior was at the time this test was added.
>

Yes, I'll add a sentence.

> > +
> > +test_expect_success 'git switch - --track remote branches partial completion' '
>
> "git switch --track: partially typed remote-tracking branch is completed"
>
> > +     test_completion "git switch --track other/master-in" <<-\EOF
> > +     other/master-in-other Z
> > +     EOF
> > +'
> > +
> >  test_expect_success 'git config - section' '
> >       test_completion "git config br" <<-\EOF
> >       branch.Z
>
> Thanks and hope that helps,
> Jonathan

Thanks. I greatly appreciate the review!

Regards,
Jake
