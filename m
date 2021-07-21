Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2EC07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B8A61106
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhGUADm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 20:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGUADh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 20:03:37 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30122C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:44:14 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id a17-20020a9d3e110000b02904ce97efee36so574930otd.7
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjhU5sQtQD/He8ToWvmL/0nME5zPrkxLsHhIWm0nZ2Q=;
        b=WeorCMC+c4fFnAYlFCwhsqllRps3Usel4x/lIK4DvKeIaJJhSUGkS7lkcqDUKSGy5U
         zfNYY4d8rA/JcQjIVoq+HHET7XVApjlOZUy8Eyo2bgT5RVMWBN8kjjWP85FK2qfk8R1D
         6Mv0EmCmX5F09QbZ/TTMtn3Pd1ekDvvcDo1ZcpEKcMwd4aWmD/x+9tpGV7btgiPL5cTb
         J08Mf7yRP66AkHI5LH/9oU1wRQgcRQ31MfZ1d4yLcCU3EGKzN0EnzLGma6UBuEyFILJQ
         48NP0F66U9XLD8mmRHdfOxKXtoEawBxAVTz9hk3MTap+4Q9N47GUU9TKoy3aY7nDnkvZ
         vjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjhU5sQtQD/He8ToWvmL/0nME5zPrkxLsHhIWm0nZ2Q=;
        b=t2ir7ivY6ye2dAPr8qlKBQ1s+HO/XYCEfve7CQ0cIGl2RJDkeUX2kpFjsIcnN02Kmh
         S9mDeLUNlo5rB13zyUngzWRmvbZOdlmhWDEiiLojDzv3s3GuukzDiSY2QmWrSmVeuCdO
         RXQy8AS/xqzr/xSv3wPVCS/VQfwlLh+MSPTUFMOR/525SdJYDAySJsCcvXUnSWDfcF7u
         eSeMcG8g1TL3rXF7nfrsN5LYCUjkj9x01HqdtQGfIRDBDESJaAB8xV2HwRiSxEN7VDnY
         hvezUe8YqE1xC462WPYiYr9fKGWhuJRsGoKssi61dyX5xjYAxT9nrI0lJhtGMrf4bAuO
         NUYQ==
X-Gm-Message-State: AOAM531ljM5hVJ3M9AvJes2utCP61ojYFFHxrqfLfLYJks6FQfuQ8h93
        pm0eD1eyROlcinibv6rP9S0KQk9Mnuvt8sN/12g=
X-Google-Smtp-Source: ABdhPJy0OeCXH3mgOypncWWH4OG4tmdjbLM9JOyGCSID6KJwUf7vhkG59LOLXchiX07TCLEMmbHDQo8O5SZ++/QNsrY=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr20811554ots.162.1626828253255;
 Tue, 20 Jul 2021 17:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <d1952f014f20d2770c74a311df27f956c8b95e21.1626536508.git.gitgitgadget@gmail.com>
 <xmqq5yx4frlc.fsf@gitster.g>
In-Reply-To: <xmqq5yx4frlc.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Jul 2021 17:44:02 -0700
Message-ID: <CABPp-BGkiNfy4s9uxFWPYfqVRLj3rT10pJuARW9e3tPrkDbS9w@mail.gmail.com>
Subject: Re: [PATCH 8/9] pull: update docs & code for option compatibility
 with rebasing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 5:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > git-pull.txt includes merge-options.txt, which is written assuming
> > merges will happen.  git-pull has allowed rebases for many years; update
> > the documentation to reflect that.
>
> Yes, as I might have said elsewhere recently, "pull --rebase" has
> been afterthought and the way how it interacts with many niche
> "features" of "git pull" has never been designed but started with
> whatever the code happened to do and then fixed/tweaked as people
> found it suboptimal.  Hopefully with this series we are covering
> these interactions and whipping them into a much better shape with
> coherent semantics.
>
> > diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> > index cad3f6bfcee..6e6e95a7595 100644
> > --- a/Documentation/git-pull.txt
> > +++ b/Documentation/git-pull.txt
> > @@ -125,6 +125,8 @@ When false, merge the current branch into the upstream branch.
> >  +
> >  When `interactive`, enable the interactive mode of rebase.
> >  +
> > +Note that `--ff-only` takes precedence over any `--rebase` flag.
> > ++
>
> "`ff-only` overrides any `--rebase` flag"?

Yeah, ignore that, I had already ripped it out after your comments on
patch 1 yesterday.  I've also got more changes to the pull
documentation to try to do more of what your sentence above says,
"covering these interactions and whipping them into a much better
shape."

> > @@ -58,6 +61,10 @@ could instead be resolved as a fast-forward.
> >  +
> >  With `--ff-only`, resolve the merge as a fast-forward when possible.
> >  When not possible, refuse to merge and exit with a non-zero status.
>
> This part may want to become conditional with git-pull[] to use a
> verb different than "merge"?

Yep, that's one of the other changes I'm adding and will send out soon.

> > +ifdef::git-pull[]
> > ++
> > +Note that `--no-ff` and `--ff` are ignored when rebasing is requested.
> > +endif::git-pull[]
>
> OK.
