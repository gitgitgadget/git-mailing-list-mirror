Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11897C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbhK3Vm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbhK3Vmv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:42:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4D0C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:39:31 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so18505027pjb.4
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ol0nFiQoMwuH8zwgcTuPFB4X807VAVrUvWmtni+i2Q=;
        b=haAlSkod0zvp60SdZxlYZVwGvJG5cB/QdiYfAw6bcMUylIpX/gwiGZPufp4+oOG774
         jdPxptaXdBaEFDQznD4T7QuEorhwVd77aRWmDvB/ojXODCc6/zI3L7kaRM7HHZvBCpdO
         NqPKByUhk38YtUqdq4fCh7+q4m/EzyZ0eUFm2Y60cqCkJmeKMezvqRCNEtUA8gmeSjIE
         Lx0cKXCb2IvS5yk5auW3taLV+Ycj0n3SuKGSGxEsVC3eJ+olpvBC3a9/XKkD16CywL6M
         rYdv17XzkhH4n3Upq12K2oMSl32TD7s3GYGpipCcXCrZY+QBdb4GwWudPebiUJt4JG8h
         Uc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ol0nFiQoMwuH8zwgcTuPFB4X807VAVrUvWmtni+i2Q=;
        b=yLhnW0vUOHcgQaa7WrZI1AP8zYtNMOtYzWDR/hrXCPF3ItwfDACd4KoJxlxablLavB
         1vWh1aX+JHPBAIQLi2ZcTmXU+hIqXLRhzm9sT3D4H6lrnNW6MD/OiY29ADO5dTvH5pJ2
         NzLZcTADuyeQ60PI+kOzlQKoHVU1V/us5ellrn/sNfJgLsRzdKwjMMi+3XN+ENlL/cyE
         NpqWP5ZEDZNtooT5xqkIKUddTcHFUTIIYv5dIsoRdstD8gFHOIj5KC7o/DuGtM9B8eGs
         dPlT6KMDpW+NnQyXhwTIi3yDhhb0+cX260vfe1RF55KKF2WgcCDb2ehiD2PdRAIBhwYE
         uXHw==
X-Gm-Message-State: AOAM531+pS9koi/lYMKCKYzxV99ZvmiHDiA73wkAsVM/AMIUg/26gZe4
        lh/HOBYyk1FFdr4rk5YVgqTuPsKTCPLNnPXJnhxi/Q==
X-Google-Smtp-Source: ABdhPJz9DVdyVOVVwyOFjvVJdE7pfMQuY+pwYL92qz+CsAmy0iuXkek+sIGLgSsiTxMCCuyfabipogNfe0coQgsaa/Q=
X-Received: by 2002:a17:90a:2e16:: with SMTP id q22mr2062295pjd.156.1638308371122;
 Tue, 30 Nov 2021 13:39:31 -0800 (PST)
MIME-Version: 1.0
References: <CALa_nQ=Q1h9b_BZcg9AeJurLeRpGrpUFuyoMz-DYKB3bgFJj4Q@mail.gmail.com>
In-Reply-To: <CALa_nQ=Q1h9b_BZcg9AeJurLeRpGrpUFuyoMz-DYKB3bgFJj4Q@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 30 Nov 2021 13:39:20 -0800
Message-ID: <CAGyf7-Ea719UNEAQSTeeSYyCcsqMo5TWXR+dSr8sDqDfj+tLAA@mail.gmail.com>
Subject: Re: `git diff` after `git checkout from-branch -- files` reports nothing
To:     Noel Yap <noel.yap@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 12:49 PM Noel Yap <noel.yap@gmail.com> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> `git checkout -b to-branch; git checkout from-branch -- filenames; git
> status; git diff`

"git diff" as run here by default only shows _unstaged_ changes. Since
you ran "git checkout from-branch -- filenames", those changes were
_staged_. That means you'd need "git diff --cached" or "git diff
--staged" to see them.
>
> What did you expect to happen? (Expected behavior)
>
> `git status` expected to show updated files and `git diff` expected to
> show file changes.
>
> What happened instead? (Actual behavior)
>
> `git status` showed updated files but `git diff` showed no file changes.

"git status" compares the working copy to the index, so it will always
show the changes, but it has 2 different blocks, staged and unstaged
changes. If your changes appear in the staged block, you need "git
diff --cached" or "git diff --staged". If they're in the unstaged
block, they'll be visible in "git diff".

>
> What's different between what you expected and what actually happened?
>
> `git diff` was expected to show file changes but it showed nothing instead.
>
> Anything else you want to add:
>
> If I `git reset -q HEAD -- filenames`, `git diff` starts showing file changes.

This unstaged the changes, at which point they show in a plain "git
diff". They also would move from the staged block to the unstaged
block in your "git status" output.

As far as I can tell everything is working as intended.

Hope this helps,
Bryan Turner

>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.34.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.11.0-36-generic #40~20.04.1-Ubuntu SMP Sat Sep 18
> 02:14:19 UTC 2021 x86_64
> compiler info: gnuc: 9.3
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
> applypatch-msg
> commit-msg
> post-applypatch
> post-checkout
> post-commit
> post-merge
> post-receive
> post-rewrite
> post-update
> pre-applypatch
> pre-auto-gc
> pre-commit
> pre-merge-commit
> pre-push
> pre-rebase
> pre-receive
> prepare-commit-msg
> push-to-checkout
> sendemail-validate
> update
