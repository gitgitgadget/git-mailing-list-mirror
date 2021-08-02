Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CE3C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D12610A8
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhHBU2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 16:28:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:39867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhHBU2x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 16:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627936108;
        bh=9YgtkxgBvtveMrpgrUUG8WbAkMD/JsW55frgjj/+9wk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EX2fPYjkWdHnK4XoHaOeBZX10AL84SMHOe/EMYW3ytMO232YQUyP1vwbYi/4VNlWI
         /WOebrJJktkWC5UsyY1a2dHwrLtbX8Nh3F81ODOjR0Xw+wW1F3KZldr1kZdyLa1MXw
         z2LzYZ8Zg906Gm9wuRbcdyOH/hmRj9clorZcShy4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzyuS-1n7Y662Xck-00x5r0; Mon, 02
 Aug 2021 22:28:28 +0200
Date:   Mon, 2 Aug 2021 22:28:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] mingw: align symlinks-related rmdir() behavior with
 Linux
In-Reply-To: <CAPig+cR9rb+ydc5age+2FzLtTtXhg1t77p5NrA7bqN0iyU6Kyg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108022218120.55@tvgsbejvaqbjf.bet>
References: <pull.1008.git.1627586493659.gitgitgadget@gmail.com> <CAPig+cR9rb+ydc5age+2FzLtTtXhg1t77p5NrA7bqN0iyU6Kyg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1084132095-1627936108=:55"
X-Provags-ID: V03:K1:viAgT7vEtQwgVS9/WQrHoCWNCy8yWEfQdohB4ogdYDYNyVSQoLf
 Ex5LpISdWptqzwYqoxl+fDv8f34NmvpNld5QApFHPm4LkjKb+mgJPS9jewU1S5fFhFpls/2
 feOCpBYkE8nEBctyPb6y6EkzXZmVGHnVbBKRrtc60Vp9HGGRSPIjVOOoIKwjq2wWWfukyMG
 +YHCZS2JzJfSolnuG4ozw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/6qZRGGIzuM=:5wGlJCadWMSMxzDZqc0Uqz
 bTCJtfgNh2k1f1xzkLROpU0CD4NGYNZID6k3dKQTMOjtqZzafW7Ah+9zkP6GiZ67WqT5h4tFX
 +iyA6PSsw4nmZ+t+CeVkaDLRO5MM1tE+tQEEuA8evZndN3yXH1jHnCwRV9t9yvQr+9ZA10B2D
 oJXjzc8sFaOSzuqvLaHmVypdZu0ePFo4VPfRtpyMeqGFI4dzI4tRnmjh8Mzh/s6Sb6qwztI7a
 O+DH12JHvj1Lo8G9emG3UfjZWz7o3XL1JSaxYdC3yYmHqsoii0uTdWrE5PnPJD6pialK99kMP
 +zrSA81izxF6r+WKbveul6ZVLhF/4ztsfusyPUnGif6qH47E2Nu1Lbobhe+i5ci83BRCEiiBZ
 FGpMDt6x2KfxCqgG/sWiGASSwEnXIG1wdAizwmZZ3alYIJv09KbnXjBZD+eNdAVGW8oq+93Wi
 rwEg32vpOZ2nNUfVO2+gDIO8501AHqnVHtoMUcIUOl7sTlvoDqV2silakM6biexrSzU8CF5Mm
 tDl8a8fOLTae9K2BgW5QOXM9+AnRHisUEbr1QMfdzuZ/q4Ltqj6eMbwBHhZ0226cocDpbfJbH
 PqPBe/iJgxVKH5zHnv6fleey/dEjAT0glhy+BBqAKO32OIXLR0B/0LEsXTr9RSap0SQUpSKa7
 FGhn7nIDDM7uAq4eK8oBHYG2DVTlBIQ1KqkHjpGoX+zXYFe5QicoATW7hvRZzpBR1N3rgRF1U
 DqEy1RiA0z2COzJe0OqdMbB9nUNl2RbPppgRk9u1EAFh3/KMmdXuGzo1rH0UTvslRR6GgssuN
 bnWk/3CKggiN8Jire9GSrC8h5i274nly+PNL3gc7YfUTDQmB9Bnybb2RLl0ekfD9eT/EvK/Dq
 TNW/h39ALJEUHJQ9hnLBwjqbRyuofJQpcHLZPKIhSrAIylb5QBkpHdGL9rWspd+EBl5PCHibN
 xvvZqgySJZ18fQUdaR/b6MNFQVeoCY5Z+kTyRhtKvegPDV50f+Sy3jfw4HOYSGg+im0TuHk5k
 p7jrK1EV/Hn4hTV2wz91azgFW0gmArE36Vin/O8czZzeyZ7vN+ZfqdRTMa1h6hSumV8xBA/Gy
 rboYSvHSqxHP4rR17CkdUJLJ1od9gTs5ptepwu7PJJ3+0opL4tqq/s8cg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1084132095-1627936108=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Thu, 29 Jul 2021, Eric Sunshine wrote:

> On Thu, Jul 29, 2021 at 3:21 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > When performing a rebase, rmdir() is called on the folder .git/logs. O=
n
> > Unix rmdir() exits without deleting anything in case .git/logs is a
> > symbolic link but the equivalent functions on Windows (_rmdir, _wrmdir
> > and RemoveDirectoryW) do not behave the same and remove the folder if =
it
> > is symlinked even if it is not empty.
> >
> > This creates issues when folders in .git/ are symlinks which is
> > especially the case when git-repo[1] is used.
>
> "issues" is a rather nebulous word. It doesn't help the reader
> understand what actually goes wrong. Presumably some step later in the
> rebase fails? Or is the problem that subsequent interaction with
> git-repo fails because the link which git-repo (presumably) created
> disappears out from underneath it?

I added a few lines describing the problem that was observed, what the
code specifically does to cause the problem, and then documented also that
the regression test specifically verifies that the observed problem won't
reoccur.

> > This commit updates mingw_rmdir() so that its behavior is the same as
> > Linux rmdir() in case of symbolic links.
>
> Okay, makes sense so far as the above explanation goes. But it also
> feels like a band-aid fix to support a use-case which only works by
> accident on Unix, if I'm reading between the lines correctly. That is,
> presumably rmdir(".git/logs") is an intended cleanup action but the
> fact that the cleanup doesn't happen as intended when it is a symlink
> is not intentional behavior, thus git-repo's reliance upon that
> behavior is questionable.

It is the `remove_path()` function that tries to delete parent directories
recursively until things fail.

Whether git-repo's reliance upon that behavior questionable is outside the
purview of this patch. At this point in time, with so many Git versions
accommodating that behavior, I would not want to spend much time pondering
that question, though: we de facto supported that expectation for too long
to change the behavior on Git's side, and therefore adjusting the Windows
side to that expectation feels like the most pragmatic way forward.

> I guess this would also help tools which replace .git/worktrees with a
> symlink since git-worktree -- as a cleanup -- removes its
> .git/worktrees directory when the last worktree is removed...

Yes, indeed.

> > Signed-off-by: Thomas B=C3=A9tous <tomspycell@gmail.com>
> > ---
> >  compat/mingw.c    | 15 +++++++++++++++
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > @@ -341,6 +341,21 @@ int mingw_rmdir(const char *pathname)
> > +       /*
> > +       * Contrary to Linux rmdir(), Windows' _wrmdir() and _rmdir()
> > +       * will remove the directory at the path if it is a symbolic li=
nk
> > +       * which leads to issues when symlinks are used in the .git fol=
der
> > +       * (in the context of git-repo for instance). So before calling=
 _wrmdir()
> > +       * we first check if the path is a symbolic link. If it is, we =
exit
> > +       * and return the same error as Linux rmdir() in this case (ENO=
TDIR).
> > +       */
> > +       if (!mingw_lstat(pathname, &st) && S_ISLNK(st.st_mode)) {
> > +               errno =3D ENOTDIR;
> > +               return -1;
> > +       }
>
> Unfortunately, this code comment doesn't help future readers
> understand when/how this case can be triggered, which means that
> anyone working on this code in the future will have to consult the
> commit message anyhow in order to obtain the necessary understanding.
> This suggests that either the comment should be dropped altogether,
> thus forcing the person to consult the commit message (probably
> undesirable), or improved to give enough information to understand
> when/how it can be triggered.

Okay. I reworded the comment extensively, to address your concern.

Ciao,
Dscho

--8323328-1084132095-1627936108=:55--
