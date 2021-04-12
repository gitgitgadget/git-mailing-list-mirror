Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56D3C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 16:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC33601FD
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 16:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbhDLQI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbhDLQI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 12:08:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B749C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 09:08:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r12so21194208ejr.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formlabs.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kkvZjjlpARR+wbV/lT8ectU9LpnSQbmp+H8IZTNXimM=;
        b=HcA9hXtJq5W0KdvEqZ/4env7DvQzm2bmGbPWlxZbnI1vXmxoRWU+in5kDhUcJ1nPYf
         ZuHWBHSBMIuaZpWCLGbWMi+eq5X0RhnyqF4BWwVIGKD+6gnwGKL2gn8+GswIqCGEphqN
         rzHQmt+hWdPgTRA+Qd+kgtxBIJODB5K1R5sxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kkvZjjlpARR+wbV/lT8ectU9LpnSQbmp+H8IZTNXimM=;
        b=jY9NOc7u9AyoV87ttFF5yUHvuKltTdvAcEe46ZJ4wxLuIPA2zTSro1aa+bq9+34bH2
         bcrDUegP0Focn+tyq5pvCUIpelBPfoxtiC4Bc1jhM/SXgsEaITEvzaEJudTR8RbZSzvK
         UeyIgVSERHEoQHg5dDtKwpOtREXimFZbXD/H4AFluAtTynwTgj+QkyrLARKXFtk4SbYm
         JBwHozR0kXymMKfgvTF5PI3phU4uYBnA89KOucHvgT2zA9b1nQOtRmAx0xhedjyeJ2/t
         ptuF6+47JZjz7JmPtNV4rKkPB3yGtnjM+kfUWLZnTyVXXe70BwpBLp4w0LdYai1sTl0o
         WnKA==
X-Gm-Message-State: AOAM533TN10C3i/oejCL37aeLXs9T8LhIscVsbZoQcXallUApL71onuG
        hJvtic/BR9Ql8EWMbs6rxOsanuBnJ28AHHmzNAUYrGK/HOIJ+JTi
X-Google-Smtp-Source: ABdhPJzYxI8OvQIc7GfH3ftiB1ez1VVfNXUxLhXJu5ys0R0hvV4Cv8W/t0OAkQJJL66+U1kLWh4yKLNLc3v/VQspKa4=
X-Received: by 2002:a17:906:3684:: with SMTP id a4mr26245770ejc.316.1618243713981;
 Mon, 12 Apr 2021 09:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAKJ37DfivxL-2Sy0qa+M_1Pw0c9-CWsCJO5=VqP1UOB5zTSP_Q@mail.gmail.com>
 <CABPp-BEOnrnQKov1YDdHXkb6CCNxudE9bUdntOeq3k0wOODc1A@mail.gmail.com>
In-Reply-To: <CABPp-BEOnrnQKov1YDdHXkb6CCNxudE9bUdntOeq3k0wOODc1A@mail.gmail.com>
From:   Tamas Peregi <tamas.peregi@formlabs.com>
Date:   Mon, 12 Apr 2021 18:07:57 +0200
Message-ID: <CAKJ37Dc5-rOeN_=vq5P3=z=_1bqGFRuFhuWde6cS0vGg3mkLnQ@mail.gmail.com>
Subject: Re: Unexpected conflict during cherry-pick after moving submodule
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

thanks for the quick reply and the useful information about the ort strateg=
y!

Do I understand correctly that the problem is in the recursive
strategy, i.e. inside the cherry-pick step, not the submodule
movement? That sounds a bit unfortunate in my case, as I'm the one
moving the submodule (then merging it back to master), and others in
my company want to cherry-pick over it, so I'm breaking their
workflows if I go ahead with moving. (Unless I tell all of them to use
the experimental ort strategy instead, which may introduce its own set
of problems.) Is there any way of moving the submodule that doesn't
break cherry-picking with the default (recursive) strategy? I'm
willing to do some extra work to spare confusion by others down the
line.

Also: up until now, I thought cherry-pick simply exports the source
commit as a patch, then applies it to the target commit, but
"recursive" is a merge strategy, correct? So is cherry-pick doing
something vastly more complex than I thought, involving merging in the
background?

Thanks in advance: Tam=C3=A1s


On Mon, Apr 12, 2021 at 5:29 PM Elijah Newren <newren@gmail.com> wrote:
>
> Hi,
>
> On Mon, Apr 12, 2021 at 7:59 AM Tamas Peregi <tamas.peregi@formlabs.com> =
wrote:
> >
> > Hi all,
> >
> > I ran into something that seems like a bug to me. I'm fairly new to
> > git, especially git submodules, so it's possible this is expected
> > behaviour, but if it is, please explain where I went wrong.
> >
> > Thanks in advance: Tam=C3=A1s
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - I modified a file on one branch
> > - Then switched to another
> > - Moved a submodule to another directory
> > - Tried to cherry-pick my modification from the other branch
> >
> > This script can be used to reproduce my steps (any submodule works, I
> > chose gsl-lite because I like it):
> >     git init
> >
> >     echo hello > hello.txt
> >     git add hello.txt
> >     git commit -m "Add hello.txt"
> >
> >     git submodule add https://github.com/gsl-lite/gsl-lite/ vendor/gsl
> >     git commit -a -m "Add submodule"
> >
> >     git branch world
> >     git branch move
> >
> >     git checkout world
> >     echo world >> hello.txt
> >     git commit -a -m "Expand hello.txt"
> >
> >     git checkout move
> >     mkdir thirdparty
> >     git mv vendor/gsl thirdparty/gsl
> >     git commit -a -m "Move submodule"
> >
> >     git cherry-pick world
> >
> >
> > What did you expect to happen? (Expected behavior)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > I expected the cherry-pick to happen without conflicts.
> >
> >
> > What happened instead? (Actual behavior)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > I ran into a conflict during the cherry-pick:
> >     Adding as thirdparty/gsl~HEAD instead
> >     error: could not apply 516d94f... Expand hello.txt
> >     hint: after resolving the conflicts, mark the corrected paths
> >     hint: with 'git add <paths>' or 'git rm <paths>'
> >     hint: and commit the result with 'git commit'
> >
> >
> > What's different between what you expected and what actually happened?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > As hello.txt has nothing to do with the submodule, I assumed the
> > cherry-pick would go through smoothly.
> >
> >
> > Anything else you want to add:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> > - "git add thirdparty/gsl && git cherry-pick --continue" resolves the
> > issue as expected.
> > - If I change which commit in the submodule the superproject points
> > to, the problem disappears, but I don't necessarily want to do that.
> > - I'm using "Git for Windows", but the issue was reproduced by my
> > Mac-based colleagues too with the exact same results.
> >
> > [System Info]
> > git version:
> > git version 2.31.1.windows.1
> > cpu: x86_64
> > built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
> > sizeof-long: 4
> > sizeof-size_t: 8
> > shell-path: /bin/sh
> > feature: fsmonitor--daemon
> > uname: Windows 10.0 19042
> > compiler info: gnuc: 10.2
> > libc info: no libc information available
> > $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bas=
h.exe
>
> Thanks for the report.
>
> We can change the final command to
>     git cherry-pick --strategy recursive world
>
> to be more explicit, though that doesn't change things and still
> triggers the bug.  However, if we change the above to
>     git cherry-pick --strategy ort world
>
> then that fixes the bug, including even in git-2.31.1.  The version of
> the 'ort' merge backend in 2.31.1 isn't ready for general usage (it
> can't handle file renormalization, or subtree merges, or
> sparse-checkouts with conflicts in files outside of the requested
> sparsity paths, and also has a platform specific bug where it'll die
> on corner case rename/rename conflicts due to assumptions about libc
> qsort() stability), but the version in 2.32 will be.  And 'ort' is
> going to replace 'recursive' once the project is comfortable enough
> with the new backend.
>
> All this is to say that the fix is on the way, even if it doesn't help
> you quite yet.
