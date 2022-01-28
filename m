Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6146AC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 01:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345023AbiA1BWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbiA1BWA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 20:22:00 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCFCC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 17:22:00 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id j2so10547715ejk.6
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 17:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vn1UJNKaOmbxjFBhJXoIfut/NOZGv0bkxLKIXjURo78=;
        b=SfrkqhSWAPC18TFpK0U2DIl7DMWnGA8xSuDO4+/TiC+XpVHe0OIc/P/zsEHCFhDwqi
         hoVMzSXoEaHKjpADOH9YmDSbgZM3SORRYf54E2e00zg9FmzyUHjFb+tQZohKKZhnPrWX
         NPgpMYAOtDdv2EIOOu2SA5jm1RZrpyR2u5YjQfj6KaDZQAryzs30JSUZcHHtGcBm0tLS
         FEY2Ubl9tgKSTBLxH96Tjg7tiFV2udBwyqZ2QuSbJNnbFqGig+BvM40lR22ow/4bDj7r
         1gj+K9er+hzXh7DpxUi1eqm+nSZthbfWKxFlonGSD2bIcp/jzjvOtvY/mxwX6xFFa1im
         F9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vn1UJNKaOmbxjFBhJXoIfut/NOZGv0bkxLKIXjURo78=;
        b=M5NxHRPg/5kyagztB6ixDpXyN2tBpSOlfIwAmjaflTzY8gATy3Jm9A2Rcz74yiSUD9
         ec/C8volNhwENms8wyOg2gKEzXGMEF8BgflvWEmoCV7AowKxAsYsGlyFTwnobyQJfFm7
         UzEEbMKKxQbz+q20Mnuw9aLr/y/2ulVWRNJtp4QuX+PEgXlZfLTbqGP7qBoaKpMOyqc0
         XzkdzJdWB+ovYMMHxll25hB1zZvW5bc8gOphD2heHepZZBGkrcmc8IvhXCva2IwK7Ff/
         HQz5L7pPyUGp8ET6qA5xUlxN0FS3HUXNWVeB8befXmgnD6ubcPpJB5CyNWBMtkgzeqmh
         udlQ==
X-Gm-Message-State: AOAM532IsXu1qgBaNMAom75cqJF11JH1FM4S3t5QWPZOI1vo45mZ3/mT
        W++PFwTNvD4I9QXrf9dTeUb94P/ygxyG+o9yN6Q=
X-Google-Smtp-Source: ABdhPJzOeo/xgdpsKa+/wccCGVvU1ApxnyaS6DhF7ZQHbArQyW+TKGCtDiXn7vooyvaUYPsHwoKOv4a+hYczE0sjnvo=
X-Received: by 2002:a17:907:7d88:: with SMTP id oz8mr5134312ejc.328.1643332918865;
 Thu, 27 Jan 2022 17:21:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com> <7d70beb2a6b3967c51d1d7feb34bfb9368066cdb.1643318514.git.gitgitgadget@gmail.com>
In-Reply-To: <7d70beb2a6b3967c51d1d7feb34bfb9368066cdb.1643318514.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 Jan 2022 17:21:47 -0800
Message-ID: <CABPp-BFG6fD3hDTrG_HZP9qv0qYaHBFxV3idik6YHE53cnFt6Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] completion: sparse-checkout updates
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 1:21 PM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Fix custom tab completion for the sparse-checkout command. This will
> ensure:
>
> 1. The full list of subcommands is provided when users enter git
> sparse-checkout <TAB>.
> 2. Subcommand options are tab-completable.
> 3. A list of directories (but not files) is provided when users enter git
> sparse-checkout add <TAB> or git sparse-checkout set <TAB> in cone mode
> only. In non-cone mode, these commands will continue to complete both
> directory and file names.
>
> Failing tests that were added in the previous commit to verify these
> scenarios are now passing with these updates.
>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 15 ++++++++-------
>  t/t9902-completion.sh                  |  4 ++--
>  2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c82ccaebcc7..a920cdab201 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2988,21 +2988,22 @@ _git_show_branch ()
>
>  _git_sparse_checkout ()
>  {
> -       local subcommands="list init set disable"
> +       local subcommands="list init set disable add reapply"
>         local subcommand="$(__git_find_on_cmdline "$subcommands")"
> +
>         if [ -z "$subcommand" ]; then
>                 __gitcomp "$subcommands"
>                 return
>         fi
>
>         case "$subcommand,$cur" in
> -       init,--*)
> -               __gitcomp "--cone"
> -               ;;
> -       set,--*)
> -               __gitcomp "--stdin"
> +               *,--*)
> +                       __gitcomp_builtin sparse-checkout_$subcommand "" "--"
>                 ;;
> -       *)
> +               set,*|add,*)
> +                       if [ $(__git config core.sparseCheckoutCone) ]; then
> +                               __git_complete_index_file "--directory"
> +                       fi

--directory only affects how untracked files are presented in `git
ls-files` (which _git_complete_index_file uses), and you're not asking
for untracked paths at all here.  So you've got a useless flag.

Testing this commit out, I can verify that it completes on all tracked
paths in the index.  Perhaps that was an intended intermediate step,
but if so the commit message needs to be changed since it claims this
commit is doing something else.

There's also a problem in that `git sparse-checkout --cone path<TAB>`
is not using this codepath.  If the user specifies --cone, then we
should give them cone-mode-style completion the same as if they
already have the config setting set.  Or, we at least need to mention
in the commit message that we don't yet correctly check for the
`--cone` option to get the right style of completion and are leaving
it for future work.

>                 ;;
>         esac
>  }
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 6004d854102..f56ba3f64c9 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1447,7 +1447,7 @@ test_expect_success 'git checkout - with --detach, complete only references' '
>         EOF
>  '
>
> -test_expect_failure 'sparse-checkout completes subcommands' '
> +test_expect_success 'sparse-checkout completes subcommands' '
>         test_completion "git sparse-checkout " <<-\EOF
>         list Z
>         init Z
> @@ -1458,7 +1458,7 @@ test_expect_failure 'sparse-checkout completes subcommands' '
>         EOF
>  '
>
> -test_expect_failure 'cone mode sparse-checkout completes directory names' '
> +test_expect_success 'cone mode sparse-checkout completes directory names' '
>         # set up sparse-checkout repo
>         git init sparse-checkout &&
>         (
> --
> gitgitgadget
>
