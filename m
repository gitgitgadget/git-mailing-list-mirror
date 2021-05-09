Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FC0C433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 06:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E6D61001
	for <git@archiver.kernel.org>; Sun,  9 May 2021 06:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhEIGWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 02:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhEIGWm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 02:22:42 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A011C061573
        for <git@vger.kernel.org>; Sat,  8 May 2021 23:21:40 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t7so9772263qtn.3
        for <git@vger.kernel.org>; Sat, 08 May 2021 23:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyITIgPWP+Xz7XB5nnsM2v7rbtg/DHs9xfZEJvh0GcM=;
        b=jtKbkgg33B/0AQuXd4y0H3EjuVzGmXGjaXPz6DMdTOLbgEZ3QUGeqlFqU0t1R1D+Nm
         KAYTM8gjibGTHr8QN5F5FlB8rUzt7nkF2Yv5g65V4jYkHiycB1ZG2cRvf/K/7Y5KAWow
         68qDZ20FWhYstZv8ZukdV0gtXJ10LWFAyluzPumv+XzQKarm65WYe+O37sY5Q6mchOFz
         NTt//e0ysdfNyul5DXMwjuZOwNvOCQ77Ty3q4Q3X3Bi3GX7FdNkg4+2dWp5oJcpFJvYv
         j1JjHkbBwA0DukBJBhSZtbmSdoAaM5mOZx7LYPf/YEK7IFlmqj4fNJV64qt3EtTdWs5X
         gSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyITIgPWP+Xz7XB5nnsM2v7rbtg/DHs9xfZEJvh0GcM=;
        b=gQA6wKkBKdQr0WZOm+8LpV05HJReiCykQNWHFY4AlJfNA2C+7Lu7w/0HTpZFeVqVcd
         hBSrJlrXLC9t9LzG3fKTw7kvs4gD3S4DJSrvv2DUOyFM4AVMrtIdT9YZoVqkEM54F0c0
         gfpMc0gsOfq8EPtJTd2+hiy/3SkjTaXASeBjSs6z21BVBUl4CVdanklSJQ+FPWjjH5Iz
         pr9gNIlOGs4Hqwm8EwNmrwbk0KGn7XFYLUNX221brfCKzJaf4QdaWJPfV0OPoqmWuKOm
         1baVIp1VYAXTJxC/Z+Mw3iJj3unLdoBlsAAX2ngVMtAJrUjP3kV0pDmDKpVcplOEVn8q
         vZkw==
X-Gm-Message-State: AOAM530j9peCAigCi5vqjxSCvV4hrdedg7QU/6w0/IGr7yw2NLTIoOlP
        J1oZKbmWpoYqql6S4+W7SAy3urcvy7TILEfq6Gem25KCO5kt7w==
X-Google-Smtp-Source: ABdhPJzO4MYFviJvzbimtHmEW5mMZWq2y5mhdoZOLt0oyIrEfKaBr3zhNjC7uK9c1kfISIieLSR2AK3naDZvLjAoYYA=
X-Received: by 2002:ac8:1093:: with SMTP id a19mr17182890qtj.365.1620541299393;
 Sat, 08 May 2021 23:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <e4c3d482-03b4-141c-e47b-cb3e175da3ab@iee.email> <789bcc9cd074cb94f706b9d432e29b52bf6a33c3.1620134775.git.matheus.bernardino@usp.br>
In-Reply-To: <789bcc9cd074cb94f706b9d432e29b52bf6a33c3.1620134775.git.matheus.bernardino@usp.br>
From:   Paul Jackson <mailnew4ster@gmail.com>
Date:   Sun, 9 May 2021 09:21:28 +0300
Message-ID: <CAGKR6vLqXpdSr_boKR_V5SMqkACt9BSBa2UA6rW46GvcymjXtg@mail.gmail.com>
Subject: Re: gitignore + commit with excludes = bug
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     philipoakley@iee.email, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I hope it gets merged at some point.

On Tue, May 4, 2021 at 5:07 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Hi, Paul and Philip
>
> On Tue, May 4, 2021 at 9:55 AM Philip Oakley <philipoakley@iee.email> wrote:
> >
> > Hi Paul,
> >
> > On 01/05/2021 19:37, Paul Jackson wrote:
> > > Hello,
> > >
> > > I stumbled upon what I believe is a bug in git.
> > > See the following reproduction steps:
> > >
> > > mkdir test
> > > cd test
> > > git init
> > > echo 1 > ignored
> > > echo 1 > not-ignored
> > > echo ignored > .gitignore
> > > git add -A -- ':!ignored' || echo 'ERROR!!!'
> > >
> > > In these steps, I ignore the "ignored" file twice - first time in
> > > .gitignore, and second time in the "git add" command. I didn't expect
> > > this to be a problem, but I'm getting the following error message:
> > >
> > > The following paths are ignored by one of your .gitignore files:
> > > ignored
> > >
> > > It looks as if git thinks I wanted to include, not exclude "ignored"
> > > in "git add".
> > I was intrigued by this. The man pages can be hard to decipher, and it
> > may be an 'as designed' feature, but still not intuitive
> >
> > It took a while to find the relevant parts of the man pages.
> >
> > The `-A` option of `add` is under
> > https://git-scm.com/docs/git-add#Documentation/git-add.txt---no-ignore-removal
> > which has caveats for whether a pathspec is given.
> >
> > The `exclude` magic pathspec is under
> > https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-exclude
> > and again has caveats and a double negative regarding whether the
> > `exclude` pathspec counts as a path spec.
> >
> > I _think_ that it is saying that the `exclude` pathspec is ignored for
> > the purpose of the `-A` (all) condition for git add.
>
> Hmm, I think the issue is not really related to `-A`. In fact, if we
> reproduce Paul's original example without `-A`, we still get the
> warning.
>
> The problem seems to be at `dir.c:exclude_matches_pathspec()`, which
> creates the list of ignored files that is later used by `git add` to
> presented the "The following paths are ignored..." warning.
>
> This function ignores the `exclude` magic, so a path 'x' incorrectly
> matches both ':x' and ':!x'. And thus, we end up warning the user about
> 'x' being ignored even when the user had ran `git add ':!x'`.
>
> I think something like this, might solve the problem:
>
> diff --git a/dir.c b/dir.c
> index 3474e67e8f..165ca6a543 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2042,6 +2042,25 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
>                 const struct pathspec_item *item = &pathspec->items[i];
>                 int len = item->nowildcard_len;
>
> +               if (!(item->magic & PATHSPEC_EXCLUDE))
> +                       continue;
> +
> +               if (len == pathlen &&
> +                   !ps_strncmp(item, item->match, path, pathlen))
> +                       return 0;
> +               if (len > pathlen &&
> +                   item->match[pathlen] == '/' &&
> +                   !ps_strncmp(item, item->match, path, pathlen))
> +                       return 0;
> +       }
> +
> +       for (i = 0; i < pathspec->nr; i++) {
> +               const struct pathspec_item *item = &pathspec->items[i];
> +               int len = item->nowildcard_len;
> +
> +               if (item->magic & PATHSPEC_EXCLUDE)
> +                       continue;
> +
>                 if (len == pathlen &&
>                     !ps_strncmp(item, item->match, path, pathlen))
>                         return 1;
> ---
>
> I had to split the original loop into two and handle the `exclude`
> pathspecs first because we cannot let the original loop return early
> when one of the `non-exclude` pathspecs matches the path. Otherwise, we
> would still incorrectly warn the user on executions like
> `git add ignored ':!ignored'`.
>
> (We might also want to extract the matching part to its own function to
> avoid repeating this code on the two loops.)
