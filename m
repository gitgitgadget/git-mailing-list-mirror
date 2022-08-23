Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C855C25B08
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 04:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbiHWEyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 00:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbiHWEyO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 00:54:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3737852E73
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 21:54:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e20so15069790wri.13
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 21:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=mbVWCJdl2OKLe6ap9z16xh57xMHr/d9B+10PQssQP9w=;
        b=fWAam03oNwhfc66V4eZuspy3ESddtBbWTDbZvDLz7JxfT5dDO09CZdjosW0CmSuKm3
         2p/FOC9y7yl2YTtXzD9Tj1G5fO5NwzJ8BhCt617X1CwmZFg4NsMqzqtUGrcBfXc/TMn5
         gQ7kLLJBSs+TKD9EtvF0bcOoIlxxEKjk1P+o+mVFq6W6B9N+74c245JprK9Srq37TosC
         ADjz2k7oKZbCMimNdRBLaAN/xJxoR+JX4XftbK+ibzz+t4a9P37FqZiuod8wTOcKrhrA
         ohG8nam9+zfrc9j4Yqa7KqKm0w9z5Nn9/eHvys5ZNpgIsIdDW1Iyua6Bo9/zUS0vc7kJ
         FmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=mbVWCJdl2OKLe6ap9z16xh57xMHr/d9B+10PQssQP9w=;
        b=4452erqFIbaC+KgtM605zoO58j1h7MHz9KdA8ChdyePAvZRZ56sBGNZZAVeHZk+r4I
         kq37iWt6+YXrK4uU/qGOnDi4vNEDFKcyLsrzgmgplo/4/2IyP9rmoiDB/KEKYX7ivbcJ
         q67k32oKUZxQUyXbK4LsYm0F9yCGbfXPyZ/Ka0FR9E0gQWzEvHSiZyF7pyGr2a6VUbVM
         Gaw0F0PJ47tGk5PpSuRVv5WycvqdX9uBpO1hQ3HcZg+SIX85AIU0UQ3QNVfuNQb0Mp1w
         JMbeuVu6qQVlOmjrPgOQqgmlsEPIkLJOAjOBf64fwddY+Hw8AMpFG/vhROVTEIuZdsba
         wmBg==
X-Gm-Message-State: ACgBeo3P6rUfwDzhxRdBGUDFYovIlElR88n9VVwGp/GX0uAo14eMtSbq
        O2S8++gwLDXziI07fY77QS2uwssPn3w9aHS1J6/F6HhQptw=
X-Google-Smtp-Source: AA6agR4TIHGkXcJooxZ7SiePTpSmZgPmzg7U16DKAdfPXADOuQM/2Bwj6l45NN4moYJ7tgqpr2HLtacy7cJQD+nxWTI=
X-Received: by 2002:a05:6000:69c:b0:225:3063:381 with SMTP id
 bo28-20020a056000069c00b0022530630381mr11794623wrb.648.1661230449513; Mon, 22
 Aug 2022 21:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAC7ZvybvykKQyMWcZoKXxFDu_amnkxZCDq2C6KHoyhmHN2tcKw@mail.gmail.com>
 <CAC7ZvyYGSa-sH1LZ8Lo=NRXbvJsujgFYGPOQR5ZwGHJHZgoDzA@mail.gmail.com> <orr5573q-7148-84ro-9rpq-nr7411s894r9@tzk.qr>
In-Reply-To: <orr5573q-7148-84ro-9rpq-nr7411s894r9@tzk.qr>
From:   Kache Hit <kache.hit@gmail.com>
Date:   Mon, 22 Aug 2022 21:53:33 -0700
Message-ID: <CAC7ZvyaQpYiVAszu_Oe5UoKgpe48dRJ8i1O8hLNOSo3UXfPVug@mail.gmail.com>
Subject: Re: BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've not been able to successfully repro this after managing to
recover from it by rebuilding the index:
https://stackoverflow.com/questions/73044253

I'm sorry I couldn't be more helpful.

On Fri, Jul 29, 2022 at 8:59 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Kache,
>
> On Tue, 19 Jul 2022, Kache Hit wrote:
>
> > A thought: the 179457 is reminiscent of something else I did just befor=
e this:
> >
> > I was doing some "code archeology" and was headlessly checking out
> > some old SHAs in this large monorepo.
> > During checkout, it said it was updating 174823 files in total.
>
> Do you think it would be possible to whittle this down a bit, and maybe
> attempt to come up with a reproducible example? Something like what is
> described in https://stackoverflow.com/help/mcve.
>
> If all else fails, and you _only_ manage to reproduce it in the original
> repository, could you at least try to figure out a reliable way to get th=
e
> Git index into the indicated state (if I were you, I would start off by
> switching to the pre-rebase revision, deleting `.git/index` and then
> running `git reset --hard` and then see whether the bug can be
> reproduced)?
>
> Ciao,
> Johannes
>
> >
> > On Tue, Jul 19, 2022 at 2:36 PM Kache Hit <kache.hit@gmail.com> wrote:
> > >
> > > Hi. Output of git bugreport:
> > >
> > > ---
> > >
> > > Thank you for filling out a Git bug report!
> > > Please answer the following questions to help us understand your issu=
e.
> > >
> > > What did you do before the bug happened? (Steps to reproduce your iss=
ue)
> > >
> > > Wanted to retain git tree structure when pulling latest and rebasing.
> > > First indication of error was the `rebase -r` of the merge commit
> > >
> > > What did you expect to happen? (Expected behavior)
> > >
> > > successful --rebase-merges rebase of my commits on top of master
> > >
> > > What happened instead? (Actual behavior)
> > >
> > > ```sh
> > > =E2=9D=AF git rebase -r master
> > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > > (179457 > 1040)
> > > zsh: abort      git rebase -r master
> > > ```
> > >
> > > What's different between what you expected and what actually happened=
?
> > >
> > > Anything else you want to add:
> > >
> > > I'm currently "stuck" in this state, not sure how to recover or repro=
:
> > >
> > > ```sh
> > > =E2=9D=AF git s
> > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > > (179457 > 1040)
> > > error: git died of signal 6
> > >
> > > =E2=9D=AF git log
> > >
> > > =E2=9D=AF git d head~
> > > error: git died of signal 6
> > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > > (179457 > 1040)
> > >
> > > =E2=9D=AF git log # works
> > >
> > > =E2=9D=AF git status
> > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > > (179457 > 1040)
> > > zsh: abort      git status
> > >
> > > =E2=9D=AF git commit --amend
> > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > > (179457 > 1040)
> > > zsh: abort      git commit --amend
> > >
> > > =E2=9D=AF git checkout head
> > > fatal: Unable to create '/Users/XXXXX/YYYYY/.git/index.lock': File ex=
ists.
> > >
> > > Another git process seems to be running in this repository, e.g.  #
> > > All of this was run while git bugreport was running
> > > an editor opened by 'git commit'. Please make sure all processes
> > > are terminated then try again. If it still fails, a git process
> > > may have crashed in this repository earlier:
> > > remove the file manually to continue.
> > >
> > > =E2=9D=AF rm /Users/XXXXX/YYYYY/.git/index.lock
> > >
> > > =E2=9D=AF git checkout head
> > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > > (179457 > 1040)
> > > zsh: abort      git checkout head
> > >
> > > =E2=9D=AF git checkout head
> > > fatal: Unable to create '/Users/XXXXX/YYYYY/.git/index.lock': File ex=
ists.
> > >
> > > Another git process seems to be running in this repository, e.g.
> > > an editor opened by 'git commit'. Please make sure all processes
> > > are terminated then try again. If it still fails, a git process
> > > may have crashed in this repository earlier:
> > > remove the file manually to continue.
> > > ```
> > >
> > >
> > > Please review the rest of the bug report below.
> > > You can delete any lines you don't wish to share.
> > >
> > >
> > > [System Info]
> > > git version:
> > > git version 2.37.1
> > > cpu: x86_64
> > > no commit associated with this build
> > > sizeof-long: 8
> > > sizeof-size_t: 8
> > > shell-path: /bin/sh
> > > feature: fsmonitor--daemon
> > > uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Tue Feb 22 21:10:4=
1
> > > PST 2022; root:xnu-7195.141.26~1/RELEASE_X86_64 x86_64
> > > compiler info: clang: 13.0.0 (clang-1300.0.29.30)
> > > libc info: no libc information available
> > > $SHELL (typically, interactive shell): /bin/zsh
> > >
> > >
> > > [Enabled Hooks]
> > > pre-commit
> > > pre-push
> >
