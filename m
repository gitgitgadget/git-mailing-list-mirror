Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7473C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CBC613EB
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhGOQ7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhGOQ7u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:59:50 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80604C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:56:55 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so6842572otq.11
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vfQQYqoghgj+ZVz4vQN/BrOv0HjgBggJ4wjbrcL9Go=;
        b=IvQhIFwR3ABMAJBGOwgZhMFBSWxv9/D90ErsZco+JSPB2jgwwEPg2+Qo79hlz5MbqU
         LwbLVGobUGlXP9Ssg+uk/zmY5+XOWhtmNXknA0jaPnmRzEW+sLeVGDpEdi4PCPd/QcD0
         aWImLdcZ8t52WraBXA7NnrJI1DhDkbSuOp6JCeXbb5zOFTXPtV6lngtly3xcyZiPS6bb
         unYZcjC1v6PcaRirJC7icxulgBFql3H5/+8GIXdRLOyptKKYd6n0a1RaPquUJchzybLf
         wqyQH0IrSGak6VKdJEmQW9GU0t8Kg3YdNpF/gfnWFvSDzVqpvsdkwueYY4P3aJrfFmAK
         QvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vfQQYqoghgj+ZVz4vQN/BrOv0HjgBggJ4wjbrcL9Go=;
        b=Q8lJ/Oj33yvvy4l9xh0dM/fYP6rdEPAcsH6svVPn3HgqAzFqLk6hSVIg+hPLqKLBof
         LAxRkDHPTxrbYpjJJgN+oHlUo0kBmhRQBsnOMvjRgZQc1Whtvcv5P9IwII7G2z2ZjDo/
         GTMp/PE1HbcHPct4xFbve9NvPbYgFS7P07+li0oanyPGfkQPU6duXMb/nU+/EagFgFmW
         RSwH53nGKNl6MKDXHDn0iXYGJ3aBuv8XqjLLyDSeA/KZeQt20xCRUuLB6FF9VjOCDL/Z
         p0WMpUcJ9XuqOuMG9aN2WmuzyWXdQckdicvUWuuLz6L+H0sd7zzjNvHcRqpS5msdPxip
         7z1w==
X-Gm-Message-State: AOAM532fWD56ubB3b65iefaLormV8BxlI4K0ekKXjVILiSZXryQ0amXm
        D9cz397nvW/yuFFddw+GpKUXLWC4vWL62zKWDC8=
X-Google-Smtp-Source: ABdhPJy9KQXbrG5jySSpgVC2ZbQWLnHdtSy0+ICyJPBS1qFnBPI9wfpnnMX5Uw1CmePGFCk+W9+2O9NvixlkFc9eeqY=
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr4476129oti.316.1626368214838;
 Thu, 15 Jul 2021 09:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <7e12c45fc9a94e7b56a6efdc085ebe081dd40afc.1626316849.git.gitgitgadget@gmail.com>
 <CAPig+cQUQYrkH7YsFio=JBZnaM3FRumti6OtvOTu6cUo4kWKtg@mail.gmail.com>
In-Reply-To: <CAPig+cQUQYrkH7YsFio=JBZnaM3FRumti6OtvOTu6cUo4kWKtg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Jul 2021 09:56:43 -0700
Message-ID: <CABPp-BGd8MVMwKHSg4Zx5t_cTQUhJL_XKO2f7pCCMQ8wXzPEQQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] pull: abort by default when fast-forwarding is not possible
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:19 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Jul 14, 2021 at 10:41 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > We have for some time shown a long warning when the user does not
> > specify how to reconcile divergent branches with git pull.  Make it an
> > error now.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> Teeny tiny nits below...
>
> > diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> > @@ -15,14 +15,16 @@ SYNOPSIS
> > -Incorporates changes from a remote repository into the current
> > -branch.  In its default mode, `git pull` is shorthand for
> > -`git fetch` followed by `git merge FETCH_HEAD`.
> > -
> > -More precisely, 'git pull' runs 'git fetch' with the given
> > -parameters and calls 'git merge' to merge the retrieved branch
> > -heads into the current branch.
> > -With `--rebase`, it runs 'git rebase' instead of 'git merge'.
>
> The original text has an odd mix of apostrophes and backticks...
>
> > +Incorporates changes from a remote repository into the current branch.
> > +If the current branch is behind the remote, then by default it will
> > +fast-forward the current branch to match the remote.  If the current
> > +branch and the remote have diverged, the user needs to specify how to
> > +reconcile the divergent branches with --no-ff or --rebase (or the
> > +corresponding configuration options in pull.ff or pull.rebase).
> > +
> > +More precisely, 'git pull' runs 'git fetch' with the given parameters
> > +and then depending on config options or command line flags, will call
> > +either 'git merge' or 'git rebase' to reconcile diverging branches.
>
> ... and the revised text adds "no quotes" to the selection. These
> days, we'd probably backtick all of these:
>
>     --no-ff
>     --rebase
>     pull.ff
>     pull.rebase
>     git pull
>     git fetch
>     git merge
>     git rebase
>
> The rest of this document is actually pretty good about using
> backticks, though there are some exceptions.
>
> There's also an odd mix of "configuration options" and "config
> options" in the revised text. Perhaps stick with "configuration
> options" to be a bit more formal?
>
> >  <repository> should be the name of a remote repository as
> >  passed to linkgit:git-fetch[1].  <refspec> can name an
>
> And, as an aside, we'd backtick <repository> and <refspec>, though
> your patch isn't touching that, so outside the scope of this change.

I'll try to fix these up, at least those in the nearby area I'm
modifying, if others agree with the general approach towards --ff-only
& --no-ff vs. --rebase.

> > diff --git a/builtin/pull.c b/builtin/pull.c
> > @@ -1074,9 +1074,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >                 if (opt_ff) {
> >                         if (!strcmp(opt_ff, "--ff-only"))
> >                                 die_ff_impossible();
> > -               } else {
> > -                       if (rebase_unspecified && opt_verbosity >= 0)
> > -                               show_advice_pull_non_ff();
> > +               } else if (rebase_unspecified) {
> > +                       die_pull_non_ff();
> >                 }
>
> When reading the previous patch, I was wondering why an `if else`
> wasn't used, and here I see that it does become an `if else`. I guess
> you didn't want to alter Alex's original patch?

Yep.  :-)
