Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A6BC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F14E60F5B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhH3UMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhH3UMd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:12:33 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EC2C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:11:39 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 6so21441782oiy.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwYpebgrGS+wZbriQAy3mCcJIygagAk/LqF9R33TdRE=;
        b=V6JYVjUmzfCAyc67mZbXC+fAgW4h5etTyxeSE4kcurLFbUjg5Q3LMYk85NWvxhWfz1
         uZanMoGKg9B1r0BznCGdDHBsUiT+wFnKM87Lihc8PtK+nxieRDa9y2AouLEYYw6cS87n
         s27doiBdLIbIm+4l3Wm5r0AmlONRtNPzQM4lHDjIsrmMXxk6+HnnH1UNRsW6eWm2blUl
         7tz5nmpsfWKAWy1kMySWkI7FL2zRn8HfAi4KtbM/GcKTOU76xf2SyNJz+2Uf9tjCZ36J
         /1/cVVxg8pjbHZjjWAeE7HOWsCUWlECVHdVcMp4MDcoNAwKcmV1g5fXy7jKSoih6eij3
         CprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwYpebgrGS+wZbriQAy3mCcJIygagAk/LqF9R33TdRE=;
        b=bcSrOl9DjHasE7y7sjtcplEEV2NwEJZE49XgocilB/R/5I1UHUqfjMtXiESjwJakRt
         NIy4QvTpCl6FoPY/8xAjQlnQ9s2/yCRcgZQddoTk/Ov3Mwf+nPUfWjsYgjPqbq35a1Yt
         7qbH68qtHC3CkrwS0CsX21x/B1EQjN7ckNNG+LaUxHb49O6XHlC6txgJ/4QuLlR0T3+y
         Do04PiavFLm8nR53HC5fPCSSq0R6dtaWC+TRQGV/ar5jQsVtKTccj9nqtRCU5lPLlpdL
         VACMBOhJ6QOMlwmOw/2lQDnm8RTtdlQjwrgZ+DEJYv9R6r9mNU6MfId7zA1JGritRx9B
         yjOw==
X-Gm-Message-State: AOAM5306u7uP2nj8IJbs7sxdFNg2HJMgLymKfSZDUNnrGZUnky39l8/Y
        TlOoh5/lxiAYiQ/qJL6A3zE94/JeZVso0N2lzi4=
X-Google-Smtp-Source: ABdhPJy7ldytSu1b3M/mBJFzGY/qj0CSIXiDEHnTMZxByZoQ2JdJxLJkKWCN4QOs9a+9hx7GXDgjedyyaj6SLZ+72oA=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr700705oiw.31.1630354299137;
 Mon, 30 Aug 2021 13:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com> <8d55a6ba2fdf64cee4eb51f3cb6f9808bd0b7505.1629841904.git.gitgitgadget@gmail.com>
 <CABPp-BGeJJBF0ZmS7ZHcqFmXwXmgVH1Uox_6gNHzcacG2vRjVw@mail.gmail.com> <d63d5d18-bdb3-e13b-ae36-e7e6cf10be39@gmail.com>
In-Reply-To: <d63d5d18-bdb3-e13b-ae36-e7e6cf10be39@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Aug 2021 13:11:28 -0700
Message-ID: <CABPp-BFT31Gj3WkhYQzaT2_efzr2c2viReLNq63_MAQiWAc4Fw@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] sparse-checkout: add config to disable deleting dirs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 6:30 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/27/2021 4:58 PM, Elijah Newren wrote:
> > On Tue, Aug 24, 2021 at 2:51 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> The clean_tracked_sparse_directories() method deletes the tracked
> >> directories that go out of scope when the sparse-checkout cone changes,
> >> at least in cone mode. This is new behavior, but is recommended based on
> >> our understanding of how users are interacting with the feature in most
> >> cases.
> >>
> >> It is possible that some users will object to the new behavior, so
> >> create a new configuration option 'index.deleteSparseDirectories' that
> >> can be set to 'false' to make clean_tracked_sparse_directories() do
> >> nothing. This will keep all untracked files in the working tree and
> >> cause performance problems with the sparse index, but those trade-offs
> >> are for the user to decide.
> >
> > I'm not sold that we need anything here, and it sounds like this is
> > all being added based on a theoretical concern.  I might not object
> > too much normally to trying to address theoretical conerns with new
> > features, but:
> >
> > * I'm a little concerned that we're adding a configuration option
> > (which live forever and are harder to work with
> > backward-compatibility-wise) rather than a command line flag.
>
> The issue with a command-line flag is that it would need to be added
> to all the commands that reapply the sparse-checkout definition.
> Maybe that's just the 'git sparse-checkout (init|set|add|reapply)'
> and 'git read-tree' commands, but are there other places where this
> logic might be applied in the future?
>
> Also, as more third-party tools integrate with sparse-checkout, I
> don't expect users to be directly involved in changing their cone,
> so any use of a command-line flag would need to be integrated into
> those tools. A config option applies this logic universally, when
> needed.
>
> > * It's not clear to me that the option name is what we want.  For
> > example, git checkout has a --[no-]overwrite-ignored for overwriting
> > ignored files (or not) when switching to a different branch.  git
> > merge has the same flags (though only the fast-forwarding backend
> > heeds it currently).  This behavior is quite similar to that flag, and
> > has the same default of treating ignored files as expendable.  Should
> > the naming be more similar?
>
> I'm open to changing the name to more closely match existing naming
> conventions, once we've decided if this should be included at all.
>
> > * It's not clear to me that the option has the right level of
> > implementation granularity.  If someone wants ignored files to be
> > treated as important, should they need to set a
> > merge.no_overwrite_ignored AND a checkout.no_overwrite_ignored AND a
> > index.deleteSparseDirectories AND other names, or have one high-level
> > option that sets all of these behaviors?
>
> These cases have different meanings for why an ignored file is
> important. For merge and checkout, the argument is saying "don't
> overwrite ignored files if they are to be replaced by a tracked
> file". For sparse-checkout, the config is saying "don't delete
> ignored files that are leaving the sparse-checkout scope". I think
> it is meaningful to say that files that match the .gitignore
> patterns but are still tracked are deleted, because sparse-checkout
> removes all tracked files.
>
> I'm less convinced that there needs to be a meta-setting that covers
> all of these cases simultaneously.
>
> ---
>
> As for moving forward, I'm fine skipping this patch if there is no
> support for it. I just wanted to demonstrate that it could be done.

That's fair, and you certainly achieved that.

> Perhaps we wait for the theoretical concern to be a real one, as
> requested by a user with a legitimate reason to care?

Sounds good to me.  Then we'll have a better frame of reference for
judging how the feature should be tailored as well.
