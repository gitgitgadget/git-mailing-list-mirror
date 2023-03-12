Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D756AC6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjCLU6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjCLU6H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:58:07 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A870BD504
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:58:05 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so5821240otv.0
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678654685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnGlX7YUvxaHz5QYYz6wxYCld3cWssMfmhxgzCS6Jj8=;
        b=fmqxal5uPZCVLYwm8l7Uj1frYLH0JqcHRN3vxSlbha0bfmxOv4wUUOj0Mws+xasb22
         gljD7C6Ksnz/8d+bZGUhkriyqmMbpZYXQuNlWLe/jZ9CcOXvdNATMpX3DOT3ZcDRkLhN
         eggcAWhLKU8QRx+mn9QRAsqXi2oBYmsBQKNBtx5Sc+LdfqF59MRKZAgLmgguRvV78Zk3
         /zG9Z5FxvkCmzEqN6O7hl8jzJbVFNbFc870KFz1Bh+28W4OeaOhYgoAb3PCipUDpGD9W
         NqyaHQpshTwz5RWInrkwZxAEw+DRjOdjGSpAwsNSjHEnS++NtX4LR0cy+k1+Q4pE9t9+
         qSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678654685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnGlX7YUvxaHz5QYYz6wxYCld3cWssMfmhxgzCS6Jj8=;
        b=jiPpLurBa/qzPX1O0Os1kXV40pLKZfAY018lLN1wGc5g9lnD+P4xiqpzULp8YClDxb
         uVI+SGbkCPicKuLdWj5vSOPKy2TopSetqeLOGyOMyx7lfPk8/ISCa0WZSrdLMKgng86h
         YNuT80rE8CKashO6doJpd1lyLAUDMh26T2GMCQ3Fb6CrrRQ4rqsBZKtxXJCaEEPegIfT
         uPA9taWBwAyhjLpaYA5uxRndBE2I4abdHdjQasgOdI6C0I2Q8Rcq5MIZXsKJpGjphOHt
         ui+bP181ed3RPofkd5YtTx2Co55Tp7cbJiYUdWPiPNmqCS7AzqJU783a4mZGQYB9FMQP
         uzyw==
X-Gm-Message-State: AO0yUKWhm0veXnBPviDY1I70/o2p6UgM/7JVJVDCPMhJps5ofCUO4vH7
        ENO5xBU8bKC+0mGoC5hwg1PZ4SjA4cCjIrS1pqo=
X-Google-Smtp-Source: AK7set/g1OqW0DfvMDor2n/s8dv9n0N9kZPkVqDnH9/hldY2aFGwlQ0szs92XefzwdWiz2AbNXzjFT+3aZtUY0TU0Xs=
X-Received: by 2002:a05:6830:33f1:b0:68b:dd51:8b5 with SMTP id
 i17-20020a05683033f100b0068bdd5108b5mr10771890otu.2.1678654684902; Sun, 12
 Mar 2023 13:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com> <20230225180325.796624-4-alexhenrie24@gmail.com>
 <1021e6d0-0cd0-d92c-4cb3-45dbf2f6626e@dunelm.org.uk> <CAMMLpeRfD+81fsEtvKFvVepPpwYm0_-AD=QHMwhoc+LtiXpavw@mail.gmail.com>
 <5551d67b-3021-8cfc-53b5-318f223ded6d@dunelm.org.uk>
In-Reply-To: <5551d67b-3021-8cfc-53b5-318f223ded6d@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 12 Mar 2023 14:57:28 -0600
Message-ID: <CAMMLpeTUbG+b89acan-GXGS4H=J7aQupbK8zdxwNg__U_We2dw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] rebase: add a config option for --rebase-merges
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2023 at 9:23=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:

> On 04/03/2023 23:24, Alex Henrie wrote:
> > On Thu, Mar 2, 2023 at 2:37=E2=80=AFAM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> >
> >> On 25/02/2023 18:03, Alex Henrie wrote:
> >
> >>> +rebase.merges::
> >>> +     Whether and how to set the `--rebase-merges` option by default.=
 Can
> >>> +     be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting=
 to
> >>> +     true is equivalent to `--rebase-merges` without an argument, se=
tting to
> >>> +     `rebase-cousins` or `no-rebase-cousins` is equivalent to
> >>> +     `--rebase-merges` with that value as its argument, and setting =
to false
> >>> +     is equivalent to `--no-rebase-merges`. Passing `--rebase-merges=
` on the
> >>> +     command line without an argument overrides a `rebase.merges=3Df=
alse`
> >>> +     configuration but does not override other values of `rebase.mer=
ge`.
> >>
> >> I'm still not clear why the commandline doesn't override the config in
> >> all cases as is our usual practice. After all if the user has set
> >> rebase.merges then they don't need to pass --rebase-merges unless they
> >> want to override the config.
> >
> > Given the current push to turn rebase-merges on by default, it seems
> > likely that rebase-cousins will also be turned on by default at some
> > point after that.
>
> It is good to try and future proof things but this seems rather
> hypothetical. I don't really see how the choice of whether
> --rebase-merges is turned on by default is related to the choice of
> whether or not to rebase cousins by default. It is worth noting that the
> default was changed to from rebase-cousins to no-rebase-cousins early in
> the development of --rebase-merges[1] as it was felt to be less surprisin=
g.

> [1]
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.1801292251240.35@ZVAVAG-6OX=
H6DA.rhebcr.pbec.zvpebfbsg.pbz/

Thank you for sharing that link. Even though I got the tests right, I
got confused and started thinking that rebase-cousins was a more
thorough version of rebase-merges. In fact, they do opposite things:
rebase-merges tries to preserve the graph and rebase-cousins
intentionally restructures the graph. In my opinion using the word
"rebase" in the names of both options was another unfortunate UI
decision, but I understand the difference now.

> > There will be a warning about the default changing,
> > and we'll want to let users suppress that warning by setting
> > rebase.rebaseMerges=3Drebase-cousins. It would then be very confusing i=
f
> > a --rebase-merges from some old alias continued to mean
> > --rebase-merges=3Dno-rebase-cousins when the user expects it to start
> > behaving as though the default has already changed.
>
> But aren't you breaking those aliases now when
> rebase.rebaseMerges=3Drebase-cousins? That's what I'm objecting to. It
> seems like we're breaking things now to avoid a hypothetical future
> change breaking them which does not seem like the right trade off to me.
>
> It also does not fit with the way other optional arguments interact with
> their associated config setting. For example "git branch/checkout/switch
> --track" and branch.autoSetupMerge. If the optional argument to --track
> is omitted it defaults to "direct" irrespective of the config.

What I really don't want is to paint ourselves into a corner. You're
right that it's unlikely that the default will ever change from
no-rebase-cousins to rebase-cousins; I was mistaken. However, Glen
thinks that in the future we might have some kind of
rebase-evil-merges mode as well, and that that might become the
default. If we don't let the rebase.rebaseMerges config value control
the default behavior of --rebase-merges without an argument on the
command line, we would have to introduce a separate config option for
the transition, which would be ugly.

More voices would be helpful here. Does anyone else have an opinion on
how likely it is that the default rebase-merges mode will change in
the future? Or on whether rebase.rebaseMerges should be allowed to
affect --rebase-merges in order to facilitate such a change?

> >>> +test_expect_success '--rebase-merges overrides rebase.merges=3Dfalse=
' '
> >>> +     test_config rebase.merges false &&
> >>> +     git checkout -b override-config-merges-false E &&
> >>> +     before=3D"$(git rev-parse --verify HEAD)" &&
> >>> +     test_tick &&
> >>> +     git rebase --rebase-merges C &&
> >>> +     test_cmp_rev HEAD $before
> >>
> >> This test passes if the rebase does nothing, maybe pass --force and
> >> check the graph?
> >
> > The rebase is supposed to do nothing here.
>
> It's not doing nothing though - it is rebasing the branch, it just
> happens that everything fast-forwards so HEAD ends up unchanged. My
> point is that this test should verify the branch has been rebased. Maybe
> you could check the reflog message for HEAD@{0} is
>
>         rebase (finish): returning to refs/heads/override-config-merges-f=
alse
>
> > Checking that the commit
> > hash is the same is just a quick way to check that the entire graph is
> > the same. What more would be checked by checking the graph instead of
> > the hash?
>
> By using --force and checking the graph you check that the rebase
> actually happened.

I got the impression that people like that not checking the graph
itself (or the reflog) makes the tests more concise, but I don't care
much either way. For what it's worth, the way I did it matches the
existing tests in the file. If you can find at least one other person
who thinks that it ought to change for this patch series to be
accepted, and no one else objects, I'll change it.

> Thanks for working on this

You're welcome; hopefully we can get the remaining details ironed out quick=
ly.

-Alex
