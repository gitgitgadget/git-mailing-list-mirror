Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4172C43603
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 05:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732E42070B
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 05:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmZLlHk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfLUFha (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 00:37:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45949 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLUFha (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 00:37:30 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so14657616otp.12
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 21:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuFICcbVn+zc3bnsnp9arX3LFCWrmwLuh1ec1JyK5Gs=;
        b=KmZLlHk1H0zqKyLkpNNADype+GHnb7BVwTxV9z2n7fdBnHYTowRYwocVmN9QSw2tTE
         +T6iBnB/qADRC65DEki09WNcwh9bDjhhLQjGzOxlG0CncOhXJhOznY14kMMPTLvriLhn
         8WNpB5Q9es82pKCeYHgEkC6zQiL9ufIizdMHTzADCkE2mkluRVN8HYEXqHE9JaZ3oqjn
         396IfXaH2ZmKpmjEKMbdMisJc8gclnLNgXK5yDcp7Z0PwiunxfxYkGLZXmR/pTbw7RA0
         qxnh88ayWBTtIDE/+J5ud33a99iqr023obgIlSB0UVi50kdsHbS5BEYK5kI6b6JtK9lD
         N3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuFICcbVn+zc3bnsnp9arX3LFCWrmwLuh1ec1JyK5Gs=;
        b=ACZnd2WwZ72542K3y2EqU6aQ8wveRGk/bk+ntTOARYRG55GVkkO0OjvQhGB2rvLHAM
         YLEHDOqMhkqW4R51iMLEmPW73+4grg4zunb8ADeX5ENNk2FmjfcfOdLwDWwpVzj0611I
         BSCIE3M5AG89Ewp/T3ws97hnblF+v/g73NdwhKtq/D1C4y39qfCV9zW1Egyz35RtqYF9
         PcG/v+rZFtbhkXm9RHHoEmJdNyHCbemiayBY8wrXumH8BqVHQx5HNH6E2W6xMsURiMFl
         idL6l0Ayr8WUJycasdS7/HLVR/KAckHJxS4tDTcq+8akypqH2TFmoe5X+CAjVjeBEHld
         NnJQ==
X-Gm-Message-State: APjAAAVNGJsKa4f7gGF9+qBDa3+TggZUQ+kN2u8UJG7G+U9ejcioDq1e
        N/8v74QZ7/lclbdwXNLq76E/t7WUA8l4AkZO/b4=
X-Google-Smtp-Source: APXvYqw58tkrr4Hi80zWkFOorNE9+9qHNCxO5Zz4uXWblw93+oUTb/APcUwqh6QiClNXjxO54RHVU2o2dAhLs/k6q9U=
X-Received: by 2002:a9d:7d81:: with SMTP id j1mr13791222otn.267.1576906649255;
 Fri, 20 Dec 2019 21:37:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.680.git.git.1576868036.gitgitgadget@gmail.com>
 <e1870f3fee8be6ebbecdd618ae1803afb878e67e.1576868036.git.gitgitgadget@gmail.com>
 <xmqqwoaq94ql.fsf@gitster-ct.c.googlers.com> <CABPp-BFYyF5RbZVuwo8LtDZZQ9KQ2od4FQqQYaeSqNCNKcZXPw@mail.gmail.com>
 <CABPp-BGvh-NvooVE-K-WYpv9RAs4BZ_d0=Mv=b5iEoGbNt5amA@mail.gmail.com> <xmqq1rsy8w3c.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rsy8w3c.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Dec 2019 21:37:17 -0800
Message-ID: <CABPp-BEReoD+YUZuniNqkDabYqdKrFvzPeNbWpRPexXUuX0XiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] am: pay attention to user-defined context size
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pavel Roskin <plroskin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 2:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > diff.context should NOT affect plumbing.  So if it's not plumbing by
> > that test, and it's not *UI* as per what you say, what exactly is it?
>
> I actually was saying that diff.context is UI thing, and should make
> no effect on how "am" interprets its input.
>
> Which the codepath in "am" are you trying to affect?  "am" is mainly
> a consumer of "diff" output, and not a producer, so ...

Okay, I can't seem to find a simple way to reproduce separate from the
testcase reported here:
    https://lore.kernel.org/git/CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com/

To summarize, when I run these exact steps:
  git clone --quiet https://github.com/proski/git-rebase-demo
  cd git-rebase-demo
  git checkout --quiet branch1
  git -c diff.context=5 rebase --quiet origin/branch2
  test $? -eq 0 && echo Successfully rebased

  echo Difference from expected:
  git diff --shortstat origin/merge-good

The rebase succeeds in both cases, but I get different output from the
shortstat depending on whether or not this git_am_config patch is
applied.

I can't seem to track down why this patch makes a difference when as
you say it shouldn't, nor can I seem to generate an am-only testcase.
I feel like it should be easy to get at least one of these given the
short steps to reproduce (the repo only has 1 file and three relevant
commits), but it seems to be stumping me nonetheless.
