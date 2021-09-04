Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC179C433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 09:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04F561051
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 09:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhIDJ7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 05:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhIDJ7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 05:59:16 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D2C061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 02:58:15 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b64so1695458qkg.0
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 02:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhLTZstOJKuoh52a0pNy+CJ8lEn09czs8vRbvCemj+k=;
        b=IjLZV6l+AjAZew+UbKFFk28nYXo8IZB/VYKXT8DDPOEqfwHDQqe9kzWMQ4UpwyraEm
         YWSbj3ieWPmWvrXFCVxOH6h8m0E0zbsKLnpZAGimXXJvQrA2TWIxzYYvrdiRypCRKRqb
         WQtA+5yKMdSBQVHgaKsTX+ml9ePDeTLkzex0wTsWCfQsmlz2Vo6jqz0x7lhhDOtMm10V
         oKdYQz0KQhLeuVy6xIxWejcmWvHvIX1Hw2SQwgZccOQFhkYQ9BqRlbVEe3im7eXiuHKt
         lQL+HZTffS4/+M5kDENCoKY/r8q6iJn7YByRNQK3wm5r8aaxeDiQsG//EZX7qhc+SmG2
         sbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhLTZstOJKuoh52a0pNy+CJ8lEn09czs8vRbvCemj+k=;
        b=m2mhXF6xH0NkQn987P1l/6Q+Ms/ajPJoHpeyACPdD5/Ad6F12WK5jboIV4YT5n+47b
         xdX65cJ2tQIGCEriz2gfav1Xr1rkReGfLPCXXpdGVegv181jiEG9rnBhvuh2ZMZUbyem
         lHB9lvzJaKEWUnKis9sMQ+eG1sWsEJ1u/C79Xgk944eC7yiYuz7COBxtJ7Bz6A74IP8k
         vP7Z5orZxqten7+qia3YuXfb5GGvfm2Xu7subzvtvSKpwhx8jkcNPTFOKd78xixqshVl
         9gkBDCjkTql48emGX/x1omw3QlKZXPlCURpOE/Q+HXDjQT5qfK0SxHiKuDQSnbfLMenW
         G0pA==
X-Gm-Message-State: AOAM530UWUQSADOjq0+0PlN8YzrYxM6K2QRsG0Cz0hcC5sDiiNQ11kNv
        rGugJk1X9MSwgJwReiVch12ovRfgC7spkhtvHSw=
X-Google-Smtp-Source: ABdhPJxIGpLF/Cklgw9+b9xBWZYaFAablDCee6NfuHixz0pgaZGhbXLtQPh1j2NEPfkwtEaKa7GS3eDAiG8w2tY54a4=
X-Received: by 2002:a05:620a:430f:: with SMTP id u15mr2649549qko.32.1630749494108;
 Sat, 04 Sep 2021 02:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com> <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
 <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net> <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
In-Reply-To: <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
From:   Fedor Biryukov <fedor.birjukov@gmail.com>
Date:   Sat, 4 Sep 2021 11:58:03 +0200
Message-ID: <CAG2t84WY35RvieOc5mhRJExwHdXuaiBafB4S4APkrnGiBM_t_g@mail.gmail.com>
Subject: Re: Aborting 'rebase main feat' removes unversioned files
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just tested it on my MacBook. To my surprise, the file got deleted by
'git rebase main feat':

550$ git --version
git version 2.33.0

551$ git init -b main
Initialized empty Git repository in
/Users/ted/workspace/git-abort-bug/test/.git/

552$ git commit -m 'init' --allow-empty
[main (root-commit) ede7bdf] init

553$ git checkout -b feat
Switched to a new branch 'feat'

554$ echo 123 > readme.txt

555$ git add readme.txt

556$ git commit -m 'txt=123'
[feat 29ac3de] txt=123
 1 file changed, 1 insertion(+)
 create mode 100644 readme.txt

557$ git checkout main
Switched to branch 'main'

558$ echo 012 > readme.txt

559$ git rebase main feat
Current branch feat is up to date.

560$ git rebase --abort
fatal: No rebase in progress?

On Sat, Sep 4, 2021 at 11:51 AM Fedor Biryukov <fedor.birjukov@gmail.com> wrote:
>
> There is no way this could be the intended behavior, but the good news
> is that I cannot reproduce it...
> Looks like it occurs only in one git version (2.31.0.windows.1, IIRC).
> And it does not occur in the latest git version: git version 2.33.0.windows.2.
>
> -Fedor
>
> On Sat, Sep 4, 2021 at 11:48 AM Jeff King <peff@peff.net> wrote:
> >
> > On Sat, Sep 04, 2021 at 01:57:11PM +0700, Bagas Sanjaya wrote:
> >
> > > On 04/09/21 03.33, Fedor Biryukov wrote:
> > > > Looks like a bug in git rebase main feat.
> > > >
> > > > To reproduce:
> > > > git init
> > > > git commit -m 'init' --allow-empty
> > > > git checkout -b feat
> > > > echo 123 > readme.txt
> > > > git add readme.txt
> > > > git commit -m 'txt=123'
> > > > git checkout main
> > > > echo 012 > readme.txt
> > > > git rebase main feat
> > > > git rebase --abort
> > > >
> > >
> > > Did you forget committing?
> >
> > I don't think so.
> >
> > The point is that "readme.txt" is not a tracked file on the main branch,
> > and thus Git should consider it precious.
> >
> > I don't think the "rebase --abort" is the problem here, though. It's the
> > command before:
> >
> >   git rebase main feat
> >
> > The "feat" branch is already ahead of "main" (which has no new commits),
> > and so it just says:
> >
> >   Current branch feat is up to date.
> >
> > and leaves us on the "feat" branch. But in doing so, it overwrites the
> > precious untracked content in the working tree.
> >
> > The "git rebase --abort" command then does nothing, because there's no
> > rebase in progress.
> >
> > -Peff
