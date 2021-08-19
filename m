Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9780BC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739F6610E6
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhHSUD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHSUD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:03:57 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE87AC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:03:20 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id bf25so9996763oib.10
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDLTEYKZohgANyzcMbOt8H8W8I57bJkc25g2JDRwSkw=;
        b=dUt1oMS55eD7JSI6wN2BnJuzBgLhDtxp4ojwgI/0DPvQ3R83fsAzqtJzwGL1DV/InZ
         mLMCya8kmvaHh8Ob0h28e9ukP1s6fsrwBMDu5t6ForYbohFmCSEt0UMeacVWK1Ma5NRZ
         q4fF1AAbSsa9Bns2ARI2pZiRxm1W8eD0poktaITe980KCdybknYtw6H+rxCg44DELTeb
         o+3bVOQ/QD76PMDorcDDUBW1R3DT5f6jO6PkbbXrEME3c7gURSqwWDN5uSTTExk9nAP1
         JjSZTDvRXvrlH2y2jR4iT0K0UwM2ssCe8N3aEeabnMtmtxH16PHFMGA69Aw1tEU1eAh6
         IFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDLTEYKZohgANyzcMbOt8H8W8I57bJkc25g2JDRwSkw=;
        b=eWikK46IzqD+tU6BHF364HpVQgEMH7Mb0NtDaua02ZgkjIL3wl50ygRwpbdvZw9y91
         MF64Q+E0mtRokJicP9H8eAokYKRvC4yuOpWn/JcBOBuV+K6oz/7aiG+4h3rjxSPAWlzN
         AU2W5PGeFPivMMaDx41uwcxbK6m+S4uMTTGysvf+Vcy+CsN+ge/XJrsJS5zG2hdLIqbB
         3ka/zR87ANL2Y1UGDth0ZEoMHqkkX7tj5q0vQof1/w3lOkyMQhOfJ95XWFrIwk1s/h4y
         mBXimILh7BoIFtgRywM8yk4+X4aAwUBOuag1jLbkNckzU7k//flDjvwrjagpQW6IjwG2
         Mcww==
X-Gm-Message-State: AOAM531SLwP4o2nSaAmGQ6VIsLY75WXXKgThbh5z562yOVLvuKBgUnXt
        rq+uHUHtvPSfHuoBwNrqd7/iOas93EKj9FfSPlhJC1j2/w0=
X-Google-Smtp-Source: ABdhPJyXXStsy8Z3gqo1FlL/u7TcuPToQRSrPGHhxKEh1AD2IMJ/Mb05SYGOI00DDWREA0k7A0BMLH18rq1S7SwKiwA=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr348302oiw.31.1629403399842;
 Thu, 19 Aug 2021 13:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com> <CAPig+cT2FfaYBbsRMy7vxXkvsxn4BcFTn4bGJjgvJKznXg1OYg@mail.gmail.com>
In-Reply-To: <CAPig+cT2FfaYBbsRMy7vxXkvsxn4BcFTn4bGJjgvJKznXg1OYg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Aug 2021 13:03:09 -0700
Message-ID: <CABPp-BFKEoHTgdSnUO86zSPYR0mLHv-vUB+Z-SoTtYQbUY4H=Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] test-lib-functions.sh: keep user's HOME, TERM and
 SHELL for 'test_pause' and 'debug'
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 11:10 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Aug 19, 2021 at 1:16 PM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > This series proposes two small quality-of-life improvements (in my opinion)
> > to the 'test_pause' and 'debug' test functions: using the original values of
> > HOME and TERM (before they are changed by the test framework) and using
> > SHELL instead of SHELL_PATH.
> >
> > The later might be too big of a change, but I think it makes sense. We could
> > add a new GIT_TEST_* to conditionnaly change the behaviour, but I kept it
> > simple for v1.
>
> I also find the test_pause() user-experience suboptimal and appreciate
> the idea of improving it. However, this approach seems fatally flawed.
> In particular, setting HOME to the user's real home directory could
> lead to undesirable results. When I'm using test_pause() to debug a
> problem with a test, I'm not just inspecting the test state, but I
> quite often interact with the state using the same Git commands as the
> test itself would use. Hence, it is very common for me to pause the
> test just before the suspect commands and then run those commands
> manually (instead of allowing the test script to do so). In such a
> scenario, HOME must be pointing at the test's home directory, not at
> my real home directory.

I agree, but I worry that it's not just HOME.  I'd think the point of
test_pause is to let you interact with the repository state while
getting the same results that the test framework would, and I think
some tests could be affected by TERM and SHELL too (e.g. perhaps the
recent issues with COLUMNS).  Granted, I suspect far fewer tests would
be affected by those, but I'm not sure I like the idea of inability to
reproduce the same issues.

Maybe we just need a different construct or special flags to test_pause?


> Perhaps there's some way to achieve your goal for at least certain
> shells by detecting the shell and taking advantage of special shell
> features which allow you to launch the shell and run some canned
> commands to set up the shell as desired before dropping into an
> interactive session[1] -- but it's just an idle thought.
>
> [1]: For Bash, for instance, a quick bit of Googling leads to:
> https://serverfault.com/a/586272
