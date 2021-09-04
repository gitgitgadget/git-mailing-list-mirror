Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B73C433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 10:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB3460F91
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 10:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351014AbhIDKFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 06:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350928AbhIDKFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 06:05:02 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450BCC061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 03:04:01 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y144so1651399qkb.6
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 03:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crNX+QenNCnlCpkx6RFQLxf/Dd3DIXgneLhoLfp/+H8=;
        b=gS0dXTa3h7BpVyOOOmGKjOk0svyY1qkpwm7C6iC8DDwIL4AUctk7G6dlm7aEDVuYsE
         bsx24ENpj6XS3EQI+o0mf2b2vvbBU5T2V0o/4hWgny93kMskE9tiYaK6byaGkgbGj0MB
         23WtRwUlb3FO7P6EmJ+I6129GPCRGa9WAu+4NmbwX5a2Sn8xF/8WsEQgbscUf+o/cFUi
         imYs0c/ofe5lNkcBFi/+/OGzdyCX6tlCThGlNTyJsB250CxVymz8Qt0OulFWVKUSliQt
         zCAMSQE78aziAgxU9RczRGHCtXRhRQeh4l2ITfNXjfytA6ld3kiEfKxhNaZj3XMmVdsE
         YH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crNX+QenNCnlCpkx6RFQLxf/Dd3DIXgneLhoLfp/+H8=;
        b=K96oP9LugezS66WuKwgCFhIZ5fAU4dE0JSJ6G24O+EVzJjtUX+1r+vaDnLp1hL8IP/
         e9KC4CRRJYsNcSG8GCAigA3nMfXomIBk5OUeR5k4AzlmCptBg+ijkv/ZpQnUG+yjV2My
         KUelT5pxTQq10J8Kw5R6MyjNk8lYGEOvbFTzcWxV+Ka9W+hZu9FdEpiIdc4HH2/Pqrm2
         HV6gWiN7zmpYhtYBk3/lFy2Kf/2D/60Z6AIY4x20NsSxqhnFHiTw4Od3qi2kAYhY1+Ir
         XlBjYQRaxixyj3vB3D43porklVmFJFnhb4vlBy1Jy64jA30fkOiWXeQyRMX6nfLFMmVk
         /REw==
X-Gm-Message-State: AOAM531jhsn4wZk6Bhj/DbCQIU6NiGSYUFE6gVemcdDZSqXqL0FLU2eL
        OnxTcjsde+Zt+fgtETvfnMDYr6ShUXxawtXm9C4=
X-Google-Smtp-Source: ABdhPJx77uKsNoJBKbrTnpAEMFlMzNzWq5s9xNPfAejcPjPLMc22aZUegkmebdCghDIZ9r6DHaHVlErmMIFrBwOljfQ=
X-Received: by 2002:a05:620a:2008:: with SMTP id c8mr2557546qka.493.1630749840388;
 Sat, 04 Sep 2021 03:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com> <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
 <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net> <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
 <CAG2t84WY35RvieOc5mhRJExwHdXuaiBafB4S4APkrnGiBM_t_g@mail.gmail.com>
In-Reply-To: <CAG2t84WY35RvieOc5mhRJExwHdXuaiBafB4S4APkrnGiBM_t_g@mail.gmail.com>
From:   Fedor Biryukov <fedor.birjukov@gmail.com>
Date:   Sat, 4 Sep 2021 12:03:49 +0200
Message-ID: <CAG2t84Ud9AFfHhCxyKWvcqVUKTrkRufdMsQL93cdUUvVAyNpzA@mail.gmail.com>
Subject: Re: Aborting 'rebase main feat' removes unversioned files
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's the output from Windows, where everything works as expected.

PS> git --version
git version 2.33.0.windows.2
PS> rm -re -fo *
PS> git init -b main
Initialized empty Git repository in C:/Users/ted/test/.git/
PS> git commit -m 'init' --allow-empty
[main (root-commit) ea4422d] init
PS> git checkout -b feat
Switched to a new branch 'feat'
PS> echo 123 > readme.txt
PS> git add readme.txt
PS> git commit -m 'txt=123'
[feat 82fe34b] txt=123
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 readme.txt
PS> git checkout main
Switched to branch 'main'
PS> echo 012 > readme.txt
PS> git status
On branch main
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        readme.txt

nothing added to commit but untracked files present (use "git add" to track)
PS> git rebase main feat
error: The following untracked working tree files would be overwritten
by checkout:
        readme.txt
Please move or remove them before you switch branches.
Aborting
error: could not detach HEAD
PS> git rebase --abort
fatal: No rebase in progress?

On Sat, Sep 4, 2021 at 11:58 AM Fedor Biryukov <fedor.birjukov@gmail.com> wrote:
>
> Just tested it on my MacBook. To my surprise, the file got deleted by
> 'git rebase main feat':
>
> 550$ git --version
> git version 2.33.0
>
> 551$ git init -b main
> Initialized empty Git repository in
> /Users/ted/workspace/git-abort-bug/test/.git/
>
> 552$ git commit -m 'init' --allow-empty
> [main (root-commit) ede7bdf] init
>
> 553$ git checkout -b feat
> Switched to a new branch 'feat'
>
> 554$ echo 123 > readme.txt
>
> 555$ git add readme.txt
>
> 556$ git commit -m 'txt=123'
> [feat 29ac3de] txt=123
>  1 file changed, 1 insertion(+)
>  create mode 100644 readme.txt
>
> 557$ git checkout main
> Switched to branch 'main'
>
> 558$ echo 012 > readme.txt
>
> 559$ git rebase main feat
> Current branch feat is up to date.
>
> 560$ git rebase --abort
> fatal: No rebase in progress?
>
> On Sat, Sep 4, 2021 at 11:51 AM Fedor Biryukov <fedor.birjukov@gmail.com> wrote:
> >
> > There is no way this could be the intended behavior, but the good news
> > is that I cannot reproduce it...
> > Looks like it occurs only in one git version (2.31.0.windows.1, IIRC).
> > And it does not occur in the latest git version: git version 2.33.0.windows.2.
> >
> > -Fedor
> >
> > On Sat, Sep 4, 2021 at 11:48 AM Jeff King <peff@peff.net> wrote:
> > >
> > > On Sat, Sep 04, 2021 at 01:57:11PM +0700, Bagas Sanjaya wrote:
> > >
> > > > On 04/09/21 03.33, Fedor Biryukov wrote:
> > > > > Looks like a bug in git rebase main feat.
> > > > >
> > > > > To reproduce:
> > > > > git init
> > > > > git commit -m 'init' --allow-empty
> > > > > git checkout -b feat
> > > > > echo 123 > readme.txt
> > > > > git add readme.txt
> > > > > git commit -m 'txt=123'
> > > > > git checkout main
> > > > > echo 012 > readme.txt
> > > > > git rebase main feat
> > > > > git rebase --abort
> > > > >
> > > >
> > > > Did you forget committing?
> > >
> > > I don't think so.
> > >
> > > The point is that "readme.txt" is not a tracked file on the main branch,
> > > and thus Git should consider it precious.
> > >
> > > I don't think the "rebase --abort" is the problem here, though. It's the
> > > command before:
> > >
> > >   git rebase main feat
> > >
> > > The "feat" branch is already ahead of "main" (which has no new commits),
> > > and so it just says:
> > >
> > >   Current branch feat is up to date.
> > >
> > > and leaves us on the "feat" branch. But in doing so, it overwrites the
> > > precious untracked content in the working tree.
> > >
> > > The "git rebase --abort" command then does nothing, because there's no
> > > rebase in progress.
> > >
> > > -Peff
