Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C4DC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C0520BED
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRO0YZNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754815AbgJWSc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754796AbgJWSc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 14:32:56 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF2BC0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 11:32:55 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w17so2311796ilg.8
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itdmXz/cNUmtLK7eIfuAAD3ljM3q81FuAVHl0wLHWm8=;
        b=CRO0YZNnHbRIqEj3erSbOT/n10Dr1mowjNzUVpQVx0plhR/yQfEO7Ue7eO6doBKlG5
         p+hxq3B9ZPAINmQefLb6CA+NMUZbmDJZ2K/Mu/Cl4exczLy5N15p93e2W5aA+DVphIFE
         7p4R3blgWjPsHN5EkSKIF6wXqdfyTr5WmkZgeUNC58Z1EmRMmooHkYuRkY3TmAo02+eL
         xK0azZg7Tbmwe7phg6j8ttZZRerwmwsEydAEckiuEeGocsUny/N78vq2uK7ip8tzq6p6
         d1ZnugsD3acga2PcYf6cFmD2JYSlJT/QPAx7Bw8CBIkH4bmOzvEf/DM0OTbV89TBytBO
         /8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itdmXz/cNUmtLK7eIfuAAD3ljM3q81FuAVHl0wLHWm8=;
        b=k2Gd3r+3x9/EuS26UPdFI4stbsW1HqfiZHB11setnnpyYgzxEGWATuscpCTk8rXtRA
         3y3AYl6ApiasBuXIcAKg5oAWT0xX/Fh47mjCv99anE1jveMiDZUXsLYAuJ4L6VvPWLo1
         1iRovA58uKKPpEK5vjI79YBXOOq+BNdSF57qa35kpnpNRuAngIznRAXCZ0pwj2obQMbk
         ASkevwnI3pxElTpEBsLr3+uN6AL6zdKIwtm9xYZjuQ56w3egRKmq1gHh7LY21MTM7ve3
         vCV5MYv98bQml1YZ3bSLsl/f1jr5qQZ75f4kjmkjD5j2uJ1uyzDrXyC1Fcw13Mw9fHJ7
         46Lw==
X-Gm-Message-State: AOAM530l2YnAjbhkCmB+xPXNXv6y1vKOQkiNzLBZhlocMD7vCTynx/iq
        I/lWc9FAz4hFl3ZDFGlGmRfROVIauerQbmhwB5Et+0eFxvM=
X-Google-Smtp-Source: ABdhPJxFV+s4s7/P7DWIgYFMSn6TOzQM29xgk2bGtRRRQjDrA3y+h67ZcOWJv01c5TsBRaGSnE6kDg31FBo4yXMdoNU=
X-Received: by 2002:a05:6e02:1305:: with SMTP id g5mr2828967ilr.237.1603477975269;
 Fri, 23 Oct 2020 11:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <20201023111711.38739-1-sangunb09@gmail.com> <xmqq7drhhr5o.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7drhhr5o.fsf@gitster.c.googlers.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Sat, 24 Oct 2020 00:02:44 +0530
Message-ID: <CAHjREB5Uye1b=bVZsAc1WPcrWrqxnrMZxBtLT345CrpU7gTpVg@mail.gmail.com>
Subject: Re: [PATCH v4] diff: do not show submodule with untracked files as "-dirty"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> What happened to the first/introductory paragraph that was
> excellently written in the previous round?
>
> The usaul way to compose a log message is to
>
>  - Give an observation on how the current system work in the present
>    tense (so no need to say "Currently X is Y", just "X is Y"), and
>    discuss what you perceive as a problem in it.
>
>  - Propose a solution (optional---often, problem description
>    trivially leads to an obvious solution in reader's minds).
>
>  - Give commands to the codebase to "become like so".
>
> The first paragraph you had in the previous round was a good example
> of the "observation".  What we see above is only the "commands"
> part.  To those who have been intimately following the discussion,
> it often is understandable without both, but we are not writing for
> those who review the patches.  We are writing for future readers who
> are not aware of these exchanges we are having, so we should give
> something to prepare them by setting the stage and stating the
> objective.

Oh okay, it makes sense. I thought you told to replace that all with
this. Would change it in the next patch.

>
> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > index ca04fac417..98e46ad1ae 100755
> > --- a/t/t3701-add-interactive.sh
> > +++ b/t/t3701-add-interactive.sh
> > @@ -761,7 +761,7 @@ test_expect_success 'setup different kinds of dirty submodules' '
> >               echo dirty >>initial &&
> >               : >untracked
> >       ) &&
> > -     git -C for-submodules diff-files --name-only >actual &&
> > +     git -C for-submodules diff-files --name-only --ignore-submodules=none >actual &&
> >       cat >expected <<-\EOF &&
> >       dirty-both-ways
> >       dirty-head
>
> Hmph, it seems that you chose to give options that are no longer the
> default to command invocations, so that the expected output from the
> previous world order before this patch can be reused, but is that a
> sensible way to go?  If we are changing the default behaviour, shouldn't
> we rather be testing that new behaviour, I wonder?
>

I have tested the new behavior too. I have added tests for both the
behavior, when ignore-submodules is none and when no argument is being
passed.

>
> By the way, in builtin/describe.c there is an invocation of
> "diff-index" without any --ignore-submodules=<what> option.
>
>         /* diff-index command arguments to check if working tree is dirty. */
>         static const char *diff_index_args[] = {
>                 "diff-index", "--quiet", "HEAD", "--", NULL
>         };
>
> Would the behaviour of diff-index invocation in "git describe --dirty"
> affected by the change of the default in any way?

I don't think so because describe was already behaving in the way that
we won't. We changed the behavior of git diff to match it with that.
So it doesn't make sense to add anything to that. Tell me if I am
missing something.

Thanks for reviewing.
