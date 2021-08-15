Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B8FC4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 12:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A937E610FE
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 12:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbhHOMtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 08:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbhHOMti (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 08:49:38 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28148C061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 05:49:06 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a13so19404478iol.5
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 05:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2tjM2StS3RXCthAU62ywk1YG/vqf5l/L8OvZl+HMWdw=;
        b=lETNxvlvDvganjnv0TFX69Qa71ar6BlOqJZZIjCli8KtFP198YZ3rumycDyIHC9YQ5
         y91oHqeV83YE4Vc/inYDVidmVAnIr2BETXg8h89G7kORkwtTd8Y7AIOCUHPuGV47iHFl
         cv9jtqZ1qU6lEshmLDADgURzH9DsDf/at4cNxvsf4ZZ8eEIDetM0Pm4MscchdFeKOURa
         Z7OrfSNyUs/fQOQYPMJEMUIZBGZ7L+RH/EBnh10tU23qQSz6EEjWmWKIbuLq6TBaAslH
         9EXilAtctYcadgXGKtHyYupGlU/CvER1Caxd9BvNSPuumQ1bNjdq3R6S/cmn39FAYDWt
         aqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2tjM2StS3RXCthAU62ywk1YG/vqf5l/L8OvZl+HMWdw=;
        b=Z0Y04N+4bGHh4H0NJVaKs/sd/rpEtaBNIcf6lEn+Fc4oLHE7p1lUb/j3o7kDOz87yi
         /H1mvQ38D1FE+10Hc32eprB8anuaXu40PdRr1+vwj2jYbzJ2EHQTRSEGXjWF44WN2wAN
         wnfTasP5KqonKrXIAo3cGKeqvxD1hoE/9IT9y5ickYrSdnoN6LUTzIEFK3qsGXbiuOC5
         uhhjBEnHIgxobM4lCSdnx6wpTd3kCd+Op40c2atQel1n6EpaiA2IqVwQ687vorSz1TP3
         3i6A2mvlMUa3GBzgjbRbRwB8Jhf/m0Kh9ldwzOZ8TJbJ6FfvbhbSH6GtzGjx5uuh/5AX
         620A==
X-Gm-Message-State: AOAM532Weq+A+bOuEdzXenuLUpR87H9h3TDRcq71uUcN2itYujRMyq8T
        9e7AXjhcQ2phHUbeJYiW+AyC6wJIjcTQBu+p6cQ=
X-Google-Smtp-Source: ABdhPJz8Dn9RpKewrEqrrYXYOB4wquqTIV8VmtgojOS9PtQVlew+jUXpRnI60PWXvnOVXDqvtvz1XRd1bL5bGx/1ys4=
X-Received: by 2002:a02:cd89:: with SMTP id l9mr9966436jap.29.1629031745553;
 Sun, 15 Aug 2021 05:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com>
 <pull.1010.v4.git.1628936863733.gitgitgadget@gmail.com> <xmqqa6lju5qd.fsf@gitster.g>
In-Reply-To: <xmqqa6lju5qd.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 15 Aug 2021 20:48:54 +0800
Message-ID: <CAOLTT8S6yOLuLh88wc6T1Wr2zJe=Wo2cYw=2ahOwAeN=e43Smw@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC] cherry-pick: use better advice message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8815=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=884:33=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > In the past, git cherry-pick would print such advice when
> > there was a conflict:
> > hint: after resolving the conflicts, mark the corrected paths
> > hint: with 'git add <paths>' or 'git rm <paths>'
> > hint: and commit the result with 'git commit'
>
> In our log messages, we desciribe the current state in the present
> tense.
>
> It may be worth mentioning that this is because the program
> originally was about picking only one commit and the hint was
> inherited from those days.  Or it may not.  I dunno.
>

Yes, may look at the time, the design is correct.

> > But in fact, when we want to cherry-pick multiple commits,
> > we should not use "git commit" after resolving conflicts, which
> > will make Git generate some errors. We should recommend users to
> > use `git cherry-pick --continue`, `git cherry-pick --abort`, just
> > like git rebase does.
>
> I am not sure "should not" is the right phrase.  Also it does not
> help readers to have a vague "generate some errors" than not saying
> anything---it leaves readers puzzled with "what errors???"
>

yes, this error is specifically that if we want pick a series of commits,
after resolving conflicts and use git commit, `.git/sequencer` still exists=
,
but git cherry-pick has ended (the next step cherry-pick is not performed).
This may be a very strange critical state.

> Whether picking a single commit or a series of commits, after
> resolving conflicts in the current step, wouldn't
>
>     $ git commit ;# to conclude the resolution
>     $ git cherry-pick --continue
>
> do the right thing?
>

I think you mean that git commit is used to end a single cherry-pick.
But in the face of a series of commits, errors will occur.

> > This is the improved advice:
>
> It may be an improved advice, but just omit it and say something
> like:
>
>         Suggest use of "git cherry-pick --contiue", so that it would
>         also apply to cases where multiple commits are being picked.
>
> The actual message does not have to be reproduced here, as it is in
> the source, and it can be seen in the test ;-)
>

Yes, maybe the commit message should be shorter and more concise.

> That would make the proposed log message conform to our norm,
> i.e. brief description of what happens with the current system,
> followed by description of the perceived problem, followed by
> an order to the codebase to become different in a specific way
> that solves the problem.
>
> Taken together, perhaps
>
>         "git cherry-pick", upon seeing a conflict, says:
>
>             hint: ...
>
>         as if running "git commit" to conclude the resolution of
>         this single step were the end of the story.  This stems from
>         the fact that the command originally was to pick a single
>         commit and not a range of commits, and the message was
>         written back then and has not been adjusted.
>
>         When picking a range of commits and the command stops with a
>         conflict in the middle of the range, however, after
>         resolving the conflict and (optionally) recording the result
>         with "git commit", the user has to run "git cherry-pick
>         --continue" to have the rest of the range dealt with,
>         "--skip" to drop the current commit, or "--abort" to discard
>         the series.
>

Ok, I understand now, git commit just stopped git cherry-pick by
delete CHERRY_PICK_HEAD in sequencer_post_commit_cleanup().
we can still resume the process with git cherry-pick --continue.

>         Suggest use of "git cherry-pick --continue/--skip/--abort"
>         so that the message also covers the case where a range of
>         commits are being picked.
>
>
> > Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > Hepled-by: Junio C Hamano <gitster@pobox.com>
>
> It seems that unlike other people I keep hepling you, whatever that
> verb means ;-).
>

Ehhh, I seem to have forgotten the correction here.

> Thanks.
>

Thanks.
--
ZheNing Hu
