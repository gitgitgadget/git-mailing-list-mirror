Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08563C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 08:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46F7207CB
	for <git@archiver.kernel.org>; Sun, 17 May 2020 08:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="bDRXXnr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgEQIcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgEQIcD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 04:32:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31F9C061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 01:32:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so8175523wrt.5
        for <git@vger.kernel.org>; Sun, 17 May 2020 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgFpIfguDYADNW191YMXlVeUPEoL2ZW4YyyGN+cH2Sc=;
        b=bDRXXnr48ODc6VEZ1XAm3wBlW0D4d1gCl+n5zqxJA1mPo2/BQnrZ4Cz4R4PelyYAiV
         AYQWbpiTrotpYlrNX4bOP4gHYHJtmSnx/DAI0z02lHpfmpUSPVeIWJDafVD8oQNgIyjb
         d7s8v8AdmsIygV42OvrdCf+tP18KyhlZE6h/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgFpIfguDYADNW191YMXlVeUPEoL2ZW4YyyGN+cH2Sc=;
        b=Rx6cjQOP/m4eYF3lrGDljMgaafFB0/rs98q/8RJU9fPwLFZTaZoe4AhzY3ASblbyqL
         srGLnOfkIYMC6hpNSsd2Eip9B1q7q7PdhZz9EzX0iIk5AlNUn+RQIMb53kG60KaZu5lB
         JoPeeGyn4XTxByD9aUiFkPjTQ9j+JmxJ40abBbJTpEmFv/MDJmyTWbjNqcmBNTgW4NYO
         K0TF95b8eenKcBf8kLxE4opKUQwcNngwq2Nu1puxYTUhJSgVr3w5Imzw68m6XGiYgY6P
         Ewsa3m5RQuy7oCe4S/PhUL1Vas/fCaWL70+SZ6sTx+YGDjuCCQzGxTanmapbD0qj2Ts/
         h3uA==
X-Gm-Message-State: AOAM532SagV4jDiPEaEJtSc23pDCrKJhjKvniPUxEHvKg7IKM2TRbDCs
        pfI/AcZ/55Aq7wOQDgTks/pv1slaf6o76oMd047LFQ==
X-Google-Smtp-Source: ABdhPJzJbbToRcpshrxAtMKU3x7jlRGgM6nzNb49h6JqbMwIBG6op7kEooXZDXs8kNa7HIe6PDh4y4OkB3GZLpUhqh8=
X-Received: by 2002:a5d:694d:: with SMTP id r13mr12779414wrw.238.1589704321129;
 Sun, 17 May 2020 01:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.775.git.git.1588352952840.gitgitgadget@gmail.com>
 <pull.775.v2.git.git.1589289359302.gitgitgadget@gmail.com> <xmqq1rnodimp.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rnodimp.fsf@gitster.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sun, 17 May 2020 09:31:50 +0100
Message-ID: <CAE5ih797YYxsR2H0TA65w9W-1jF4jQLayja_nGjQMGtc=PB6Jw@mail.gmail.com>
Subject: Re: [PATCH v2] git-p4.py: fix --prepare-p4-only error with multiple commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Ben Keene <seraphire@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 12 May 2020 at 21:05, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > ...
> > Be aware - this change will fix the existing test error in t9807.23
> > for --prepare-p4-only. However there is insufficent coverage for
> > this flag.  If more than 1 commit is pending submission to P4, the
> > method will properly prepare the P4 changelist, however it will
> > still exit the application with an exitcode of 1.
> >
> > The current documentation does not define what the exit code should be
> > in this condition.
> > (See: https://git-scm.com/docs/git-p4#Documentation/git-p4.txt---prepare-p4-only)
>
> Then some proposal to define what the behaviour should be is needed,
> the consensus implements and then documented.

It looks like it's always been slightly confusing (at least to me).

If prepare_p4_only is True, applyCommit() will only fail if the patch
could not be applied (which is what you would expect).

If that happens I would think it would make sense to bail out - I
would think most users will want to rebase and try again rather than
blithely carrying on.

The "i < last" logic in the original patch from 2012 seems to mean
that you only get the message "Processing only the first commit due to
option prepare-p4-only" if there is an error and you're not about to
drop out anyway.

I personally no longer use --prepare-p4-only, now that we have the
git-p4 shelve support. I would imagine this is true for a lot of
people.

The logic in Ben's change seems much more sensible.

Luke


>
> >
> > Signed-off-by: Ben Keene <seraphire@gmail.com>
> > ---
>
>
> >     git-p4.py: fix --prepare-p4-only error with multiple commits
> >
> >     When using git p4 submit with the --prepare-p4-only option, the program
> >     should prepare a single p4 changelist and notify the user that more
> >     commits are pending and then stop processing.
> >
> >     A bug has been introduced by the p4-changelist hook feature that causes
> >     the program to continue to try and process all pending changelists at
> >     the same time.
> >
> >     The function applyCommit should return True when applying the commit was
> >     successful and the program should continue. In the case of the
> >     --prepare-p4-only flag, the function should return False, alerting the
> >     caller that the program should not proceed with additional commits.
> >
> >     Change the return value from True to False in the applyCommit function
> >     when git-p4 is executed with --prepare-p4-only flag.
>
> This space below the three-dash-line is the best place to describe
> the difference between the previous version and this one.  It seems
> that the above text is not such a "here are what was bad/missing in
> v1 that got fixed/extended", or a copy of the log message (like many
> patches that come from GGG has).  I am a bit puzzled what it is, but
> for now let's pretend there wasn't any text below the three-dash-line
> and read on.
>
> >  git-p4.py | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/git-p4.py b/git-p4.py
> > index b8b2a1679e7..c4a4012bcc1 100755
> > --- a/git-p4.py
> > +++ b/git-p4.py
> > @@ -2537,11 +2537,12 @@ def run(self, args):
> >                  ok = self.applyCommit(commit)
> >              if ok:
> >                  applied.append(commit)
> > -            else:
> > -                if self.prepare_p4_only and i < last:
> > -                    print("Processing only the first commit due to option" \
> > -                          " --prepare-p4-only")
>
> So, it used to be that after failing to apply a commit, unless we
> are at the last step, we gave a message and left the loop under the
> prepare-p4-only mode.  We did not do anything special under the
> prepare-p4-only mode if applyCommit returned a success.
>
> > +                if self.prepare_p4_only:
> > +                    if i < last:
> > +                        print("Processing only the first commit due to option" \
> > +                                " --prepare-p4-only")
>
> Now, after successfully applying, we leave the loop under the
> prepare-p4-only mode.  We give the message only when we are not at
> the last step.
>
> >                      break
> > +            else:
>
> So..., what happens when the first step fails to apply and then the
> user tells us to skip the commit?  We'll go on to the next commit
> and then applyCommit() may say 'ok' this time around.  Does that
> count as "processed only the first commit and we are done"?
>
> >                  if i < last:
> >                      # prompt for what to do, or use the option/variable
> >                      if self.conflict_behavior == "ask":
> >
> > base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
