Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B60C433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A78A121D7F
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 13:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnMKflO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgJRN63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgJRN62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 09:58:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C24C061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 06:58:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so10104059wmj.5
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3Il/Tkm4GYtCrLtVo7UNkQiFp3XX11lB3gJsBYLT04=;
        b=SnMKflO3AFID9cXUU8c7HynwlEPrS8879yIypxljYDsmwEamyVZ4tytTOM5IVhAR/o
         eNl1pex1L/mQoqft/OziSTDAXOs/Pp5H63x+8I8H2KbGpmSR24W21N9UBBSYJSz393Jy
         qCMk6YgBoJ2wvRDx3+NEqC+yREyMZX3fy10RvXBfkjRZ77W/SYaA8x6iElT8jMECpww4
         L64RwjO4rz0ex4GTbVHi8G+apv/zEvF69NRTmZkSxqdgn+ngNSEbSu0JvK7AFhmZjkWf
         uekCWUMiXDgP9bW0FMpSR2/7DufwG1gND/dMafKRNjLcLAbpYXx9PcbG3VdkLsOG7b+h
         SNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3Il/Tkm4GYtCrLtVo7UNkQiFp3XX11lB3gJsBYLT04=;
        b=M/1urjUQ+G7vnBQRHtHTIYz5rFX5X1xzeXqxS5wo5/UI+hd616P5pWCZ1qWiJa4511
         BEDDzG/4VSU1hzJCKEcvdA+0urag+hSF1/UZwiZSdrZrO8FZ1p/POY4rSiRVd57Dl9JP
         eZ0Z2y6kuOe7nOeSD3t/dY+WSXuAGpgql7TpR4itZYGwjE0g8OhGIRz2IeycW6jHacnQ
         vCXxnVctN/8/+kphyySNx+IZyZG1FcNPGm1anZo0QPwNPClEiG/rh7cdrDVVgDx2wTqs
         81lAyYNlIMauTn2TNu3Wlv1vTKh13UjaWgzn+YT3wulUslL2uIpVTS4NtMQ5nw3slRi9
         k+kg==
X-Gm-Message-State: AOAM533Kha4ygJq0XVs+HLU3x9bTpaOb8SMHd1OUchZMXdwiqJp7j/JQ
        Kx2PdvQo+8xlWepHffMGQRc2yNJgTSYXukJ2U0U=
X-Google-Smtp-Source: ABdhPJyHD/qGYxNu+PjH4FF+MBSKzO95hu6lKCgOuXLiVK9D7i1Lp7Io4FAJnl0CTOWsqGUoZ2kVPnGXuQptk2hTvlQ=
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr12858172wmk.134.1603029507096;
 Sun, 18 Oct 2020 06:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
 <fc2da014a62c387009e2175435286afef64d6598.1602950552.git.gitgitgadget@gmail.com>
 <CAPig+cQnfcc9W3qE5XkyLiwNyK8Wm2SsAyjzatDWEVUi3s8APw@mail.gmail.com>
In-Reply-To: <CAPig+cQnfcc9W3qE5XkyLiwNyK8Wm2SsAyjzatDWEVUi3s8APw@mail.gmail.com>
From:   Amanda Shafack <shafack.likhene@gmail.com>
Date:   Sun, 18 Oct 2020 14:57:51 +0100
Message-ID: <CAGxm6oWT=LG7KczvKaa5ta=LBAkFsHHYsCXLB7tBfn==Z0g9DQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] t9832,t2200: avoid using pipes in git commands
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Amanda Shafack via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your feedback, I now have a better understanding. I have
made the changes you requested.


On Sun, Oct 18, 2020 at 7:11 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sat, Oct 17, 2020 at 12:02 PM Amanda Shafack via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > When the upstream of a pipe throws an error, the downstream still
> > executes normally. This happens because the exit code of the upstream
> > in a pipe is ignored. This behavior can make debugging very hard
> > incase a test fails.
>
> To be more precise, we're not worried about difficulty of debugging
> when a Git command is upstream in a pipe. What we are more concerned
> with is that an unexpected failure of the Git command will go
> unnoticed (unless it also happens to produce wrong output which is
> later caught somewhere downstream). By avoiding placing Git upstream
> in a pipe, we can actively catch a failure of the Git command. The
> commit message should focus on that reason instead.
>
> > Also, pipes are prone to deadlocks. If the
> > upstream gets full, the commands downstream will never start.
>
> I don't think this is ever an issue in Git tests, so talking about it
> here probably only muddies the waters, thus makes the commit message
> less precise and more hand-wavy. Dropping this sentence is
> recommended.
>
> > Commit c6f44e1da5 (t9813: avoid using pipes, 2017-01-04) noticed that
> > the exit code of upstream in the pipe is ignored, thus using pipes
> > should be avoided.
>
> There are a lot of commits in the project history which perform this
> sort of transformation, so it's not clear to the reader why this
> particular commit is called out as being important. If it's not, then
> I'd recommend dropping this sentence, as well.
>
> > diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> >  test_expect_success '"add -u non-existent" should fail' '
> >         test_must_fail git add -u non-existent &&
> > -       ! (git ls-files | grep "non-existent")
> > +       ! (
> > +               git ls-files >actual &&
> > +               grep "non-existent" actual
> > +       )
> >  '
>
> This transformation appears to be incorrect. See my review of patch
> [2/2] for details.
>
> > diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
> > @@ -68,7 +68,8 @@ EOF
> > -               git show refs/remotes/p4-unshelved/$change | grep -q "Further description" &&
> > +               git show refs/remotes/p4-unshelved/$change >actual &&
> > +               grep -q "Further description" actual &&
>
> This transformation looks fine.



-- 

Cheers!

Amanda  Shafack
