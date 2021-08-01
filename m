Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797CFC4338F
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 00:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD5E61050
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 00:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhHAA12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 20:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhHAA11 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 20:27:27 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF80C06175F
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 17:27:19 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y18so19313285oiv.3
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 17:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/h9uVh0nLZKorvIp0FTRVCC56yBEf9N19EwXdTGd7O4=;
        b=kWwo5mgMNJd0N0uYtudnyl/xWI5QrQWm4y2mWt4nesyFKsRUhS/DRfvVHlh9fKoTdG
         gYuEd3Y58IJZIC4YADWTSAaBC9lYSgG7q0ggpDNne1qNDcrGzckPSx27e2aVJptjfeDB
         x0gyCJ0v7jJZJHDHy1LY1DPo9OCL4c+4wm0YG1icgxn/kKNDZAUaMbn2Mow1yi+V9UST
         1RC3K3+OykfCoGu3j9Gdks/cibjBjpJqg+eWbRiyrUvNIRLDxzFqnYv7ANC+pB965jTZ
         M/9as8MTfSHwSrDEMsY4XI3vuBkyub7TlVEMyEZkymcp7bWgiamB4fozNrfhi4yGHnPa
         xPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/h9uVh0nLZKorvIp0FTRVCC56yBEf9N19EwXdTGd7O4=;
        b=oUFfn7gq7jMDnSjm5Al4Vlz9/ChFgk9YO7CKp7sAw+i7ItXuZ+jVf2tUXK2YwfPbMj
         auMUCvFeh2waaMyEnZX3h7s6ba2XK+OS/WYHPavZW2Lpl2Rj09ncdWPrapRi5W3EtGw6
         RRs8k1PuJ00JLMZqWafL+/ezBWwUgTVTu1WQi5s8UBhrVbJstvcQub3LJm/pFSoFiOCi
         XcNVVPu0DZ6iWB9PV+JolxRzDzNJDn4jtNS3TuuvCAAjAL7vUG+k0YeT7B6bb6evYVHX
         Z7EOFPpiwoqrfqqDjbJhYgmoY+sr0T0KnjBywzymXmrzA9e35OdckdrIzVU7/7f53Lvx
         EMYw==
X-Gm-Message-State: AOAM5315oA9XRUu7eKw1KF+UmO8vD8PCbPzqvDQHOpCCIxC2aMQ+UTBf
        OKLks3GBPVvnafHZIvGxX+xJ2c62wMedxcf8dGg=
X-Google-Smtp-Source: ABdhPJwCvKC+FDUparIdvHMYMwxt/JvxCeMNhnB8zOrXOBEM+a5ccF0yn11kKTSz7HvIDFOM8eai5yjk/N9dALD+Fks=
X-Received: by 2002:aca:d644:: with SMTP id n65mr6260594oig.31.1627777639195;
 Sat, 31 Jul 2021 17:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <644619140.20210731114616@yandex.ru>
In-Reply-To: <644619140.20210731114616@yandex.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 31 Jul 2021 18:27:07 -0600
Message-ID: <CABPp-BHkhwKFb74fUMW3nOGrCD6waBPBjp-UY2fRhU6=WUxOow@mail.gmail.com>
Subject: Re: Ambigious messages
To:     Eugen Konkov <kes-kes@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eugen,

On Sat, Jul 31, 2021 at 2:56 AM Eugen Konkov <kes-kes@yandex.ru> wrote:
>
> $ git checkout 51c7d41b82b5b
> error: Your local changes to the following files would be overwritten by checkout:
>        lib/Mojo/IOLoop/Stream.pm
> Please commit your changes or stash them before you switch branches.
> Aborting

The error seems quite reasonable to me...but can I ask how you got
into this state?

There's two ways I know of:

1) Setting a sparse-checkout to only have certain paths, and then
recreating a file outside the sparsity paths anyway.
2) Trying to adjust your sparse-checkout to have a different set of
paths, then hit Ctrl-C while it is in the middle of running.

Did you do one of these?  If not, what'd you do?  If so, which one?

I've only had confused users come to me when they did the latter; they
apparently assumed Ctrl-C would abort the operation and return to the
previous state, but it does not -- whatever was successfully checked
out before they hit Ctrl-C remains written to the working copy, but
the .git/info/sparse-checkout file is updated last so the system
continues assuming the old checkout.  I wonder if we need to add some
special Ctrl-C handling inside sparse-checkout adjustments or
something.

> $ git checkout lib/Mojo/IOLoop/Stream.pm
> error: pathspec 'lib/Mojo/IOLoop/Stream.pm' did not match any file(s) known to git

This error message is clearly suboptimal and should be improved.
Alternatively, though, we could perhaps change the behavior so that
when in a sparse-checkout and the file(s) that match are SKIP_WORKTREE
but present anyway, we could just remove the file from the working
copy (i.e. make it match the index).

> $ git add lib/Mojo/IOLoop/Stream.pm
> The following pathspecs didn't match any eligible path, but they do match index
> entries outside the current sparse checkout:
> lib/Mojo/IOLoop/Stream.pm
> hint: Disable or modify the sparsity rules if you intend to update such entries.
> hint: Disable this message with "git config advice.updateSparsePath false"

The error message is correct, but this is the case Stolee was talking
about recently where it'd be good to add an override to "git add" to
allow adding it anyway and add information about using that option to
this error message.

> $ git --version
> git version 2.32.0
>
> Here I do not understand how to checkout to different commit
> or how to commit the subject file

I'll give you three different ways you should be able to do it:

1. Since you wanted to just restore the file to the version in the
index (as per your `git checkout lib/Mojo/IOLoop/Stream.pm` command),
you can simply delete the file (`rm lib/Mojo/IOLoop/Stream.pm`) and
everything would be fine.

2. You could change your sparsity paths to include this file so it
doesn't think it should be excluded from the working tree, e.g. `git
sparse-checkout add lib/Mojo/IOLoop` or even `git sparse-checkout add
lib/Mojo/IOLoop/Stream.pm`.  That'd be most useful if you made
important edits to the file or want to continue editing the file and
committing changes in it.

3. You could just disable the sparse-checkout entirely (`git
sparse-checkout disable`).  That'd make it so you don't have to worry
about this path or any other being simultaneously excluded and present
in the working tree.  You should be able to fix things up normally.
And, if you want, when you're done fixing things up, then set up a
sparse-checkout again.


> It would be nice to show hint about how to exlude this file from unindex

Yes, we need to improve some error messages here (and perhaps tweak
some behavior as well).  Thanks for the report.

Elijah
