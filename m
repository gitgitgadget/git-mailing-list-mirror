Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF40C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 19:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70B720801
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 19:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fup81J/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgBQTNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:13:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41984 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgBQTNC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 14:13:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id j132so17685971oih.9
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 11:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXDsVTWilNbwlMWyghsFCk6RR/rVMVJ8bdJitYEYkbE=;
        b=Fup81J/tPEpV1mSIvJhJHiy1jaH5P1wD+HsFfbSeEjApCtMYgnpXw/MKAS2jbBp3yo
         3WHa7RAQB/szzL8NzO8/nxhWkAG0tqY/TgtHs9kR50A7yhPqY7U23NbkN4MACdRwyeXL
         spNyhrV140kGJrR+q1Y7lHnMn2yKMFKA83VsMD/thTCuHthjrbcc4uiXMnFB4IRSnMsj
         eqb1Qd6Wk+xV9Sg0aYUzCniT6K+3s3H/QWRq7khsF355n2J72Oj/6Ewv3Mm9ugd2Dmye
         pH4u9baZgyMa6sEF9A77VnxobOiFashpfSsS2jk3R9fS6QS817Ffk5zLmF2DcLqJyKvd
         klkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXDsVTWilNbwlMWyghsFCk6RR/rVMVJ8bdJitYEYkbE=;
        b=jX24JtcqoeqaPebaR1XMdXx59oH8sNmb5y/Et+lCfAGW57bk/N8LwDnwAWwgYp8RkR
         rLBvTNEvKMzHRQelrNqNzNpBgf49SvALfXOsu2wzUYo1ZdLQBdD3lhBHd+4jbIsSvyFN
         KkVCmotNUwqvM833CTETCqpur7sVgeUusBx/hPgLB5UMGw0dGFzOGrdR0EMarbXxeCoG
         /Uz6kTaJWSe3b3PvlY5sTy6loLke5azoRyU0+UnLWTsRE9jWxus5FBZnRphZBvAWCGhq
         Re5spdhk2Y2iKGpDkuB3mnkUTExX/NzrK4lN26LScppXM3L7S3i114T48MCmiwJIIMHT
         y2Fg==
X-Gm-Message-State: APjAAAVatR28BcRYpbmxuPMtMmz/MnwNAlbTAdnrfSdqMPueeKiI3rIW
        WHcTT7Sl7kk+wJjGMtAhP50NmXelLchDEQJ+Llqcww==
X-Google-Smtp-Source: APXvYqwphbLww6OcBoGiEnL7OaY/CdTS5D5V/weCeJ+tvXNuQOrjTWItdM0vLEuA1SZPcDsU9zeSvhXR1Hh7vP0gfiA=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr323939oib.6.1581966781287;
 Mon, 17 Feb 2020 11:13:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
In-Reply-To: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Feb 2020 11:12:50 -0800
Message-ID: <CABPp-BEtnmzDp0E4=0y9eEMKQ89FcrsK9h-1Mqcd2FDV_EBohw@mail.gmail.com>
Subject: Re: [PATCH] t3424: new rebase testcase documenting a stat-dirty-like failure
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I forgot to add some cc's in GitGitGadget before submitting; adding now...

On Mon, Feb 17, 2020 at 9:15 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> A user discovered a case where they had a stack of 20 simple commits to
> rebase, and the rebase would succeed in picking the first commit and
> then error out with a pair of "Could not execute the todo command" and
> "Your local changes to the following files would be overwritten by
> merge" messages.
>
> Their steps actually made use of the -i flag, but I switched it over to
> -m to make it simpler to trigger the bug.  With that flag, it bisects
> back to commit 68aa495b590d (rebase: implement --merge via the
> interactive machinery, 2018-12-11), but that's misleading.  If you
> change the -m flag to --keep-empty, then the problem persists and will
> bisect back to 356ee4659bb5 (sequencer: try to commit without forking
> 'git commit', 2017-11-24)
>
> After playing with the testcase for a bit, I discovered that added
> --exec "sleep 1" to the command line makes the rebase succeed, making me
> suspect there is some kind of discard and reloading of caches that lead
> us to believe that something is stat dirty, but I didn't succeed in
> digging any further than that.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     t3424: new rebase testcase documenting a stat-dirty-like failure
>
>     A user discovered a case where they had a stack of 20 simple commits to
>     rebase, and the rebase would succeed in picking the first commit and
>     then error out with a pair of "Could not execute the todo command" and
>     "Your local changes to the following files would be overwritten by
>     merge" messages.
>
>     Their steps actually made use of the -i flag, but I switched it over to
>     -m to make it simpler to trigger the bug. With that flag, it bisects
>     back to commit 68aa495b590d (rebase: implement --merge via the
>     interactive machinery, 2018-12-11), but that's misleading. If you change
>     the -m flag to --keep-empty, then the problem persists and will bisect
>     back to 356ee4659bb5 (sequencer: try to commit without forking 'git
>     commit', 2017-11-24)
>
>     After playing with the testcase for a bit, I discovered that added
>     --exec "sleep 1" to the command line makes the rebase succeed, making me
>     suspect there is some kind of discard and reloading of caches that lead
>     us to believe that something is stat dirty, but I didn't succeed in
>     digging any further than that.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-712%2Fnewren%2Fdocument-rebase-failure-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-712/newren/document-rebase-failure-v1
> Pull-Request: https://github.com/git/git/pull/712
>
>  t/t3424-rebase-across-mode-change.sh | 52 ++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100755 t/t3424-rebase-across-mode-change.sh
>
> diff --git a/t/t3424-rebase-across-mode-change.sh b/t/t3424-rebase-across-mode-change.sh
> new file mode 100755
> index 00000000000..4d2eb1dd7c6
> --- /dev/null
> +++ b/t/t3424-rebase-across-mode-change.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +
> +test_description='git rebase across mode change'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       rm -rf ../stupid &&
> +       git init ../stupid &&
> +       cd ../stupid &&
> +       mkdir DS &&
> +       >DS/whatever &&
> +       git add DS &&
> +       git commit -m base &&
> +
> +       git branch side1 &&
> +       git branch side2 &&
> +
> +       git checkout side1 &&
> +       git rm -rf DS &&
> +       ln -s unrelated DS &&
> +       git add DS &&
> +       git commit -m side1 &&
> +
> +       git checkout side2 &&
> +       >unrelated &&
> +       git add unrelated &&
> +       git commit -m commit1 &&
> +
> +       echo >>unrelated &&
> +       git commit -am commit2
> +'
> +
> +test_expect_success 'rebase changes with the apply backend' '
> +       test_when_finished "git rebase --abort || true" &&
> +       git checkout -b apply-backend side2 &&
> +       git rebase side1
> +'
> +
> +test_expect_failure 'rebase changes with the merge backend' '
> +       test_when_finished "git rebase --abort || true" &&
> +       git checkout -b merge-backend side2 &&
> +       git rebase -m side1
> +'
> +
> +test_expect_success 'rebase changes with the merge backend with a delay' '
> +       test_when_finished "git rebase --abort || true" &&
> +       git checkout -b merge-delay-backend side2 &&
> +       git rebase -m --exec "sleep 1" side1
> +'
> +
> +test_done
>
> base-commit: e68e29171cc2d6968902e0654b5687fbe1ccb903
> --
> gitgitgadget
