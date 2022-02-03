Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EADBC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 23:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiBCXwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 18:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBCXwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 18:52:50 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03923C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 15:52:50 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id h7so13757760ejf.1
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 15:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oODYqwg1OVrXKLI2BtADSOjOyBfTkXDQc5xTn+ahhSk=;
        b=Eyk3XAmRtm2jmIQtz1/kUF7kn2wAxdXUSznde9uPf/ZQ10N3TIhN9qBtqWTYRMi29Q
         SLRCdnr/NoyNJRKEvnXRVuYlWmuoly6ZMYFCz1y1i0GeGdufkd497iKtd6EM6FnQo3ta
         443OPepJ7rN0LAlLIVjwOns15KifEg/qF/rztWPMwdLuAG2WHVMlfgCS39AhBJkLG0t0
         kGfnAeBvvP1mMvOnFxt8bwGM6ZgBWAHv2v8nux+AzWDw+QNgDu/zfnVi6LtRuZX+bJzT
         /q1pS0oSdM9vVpJ0da2251oeHnK7Lt9Wt/XwfyJ6JHDgCGzFoYNvWVS6keyjxbBIwkav
         4VZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oODYqwg1OVrXKLI2BtADSOjOyBfTkXDQc5xTn+ahhSk=;
        b=qjssJpTU+IUpzK+A6PCcpDIvztw/etYDW7bf5wEC16nkSRzFg30MF/k7w97AMDGYKh
         IivLSsxcz5lg79FxaTXCTpMvRNUBCHSahfZQkbu8O0vdQDSpPfLTI98X8B8YbKLXNPen
         30JrQcPQOMI3BlQw8bntmpw+HcSV0JrxwS99h5+K9HphNIMGTP09RxeB2+rmQtaj3cSY
         TVeGzsEefOWVbxLZQxNY9jCLfIr5Vg0yHAP6tqRpqMji3ckOQG24gvSK0qUZD9DBhxAQ
         7TwJZ9/IjA9MXhl8wkAptyxUqmbAShKNJ91OeiiuszahVQ206qvIsFyPlN3Hmw1Rmitp
         Rmpg==
X-Gm-Message-State: AOAM5308Mw0JIj55fgCT5MD9LqzBZtrmdTKUCVeCJSyf/hn0YIMCAzus
        GQIfl04UQA/lxVZsyjP95cOm7C4CXA28N7Gf7BE=
X-Google-Smtp-Source: ABdhPJy8b3t3omDnQOEUB6f8lJg4soa7o1lgheyYk7DbMTRjrcH2Cw/N6yAGL4kztsBcnbQadKSlZhmd5RA+OU/sBQk=
X-Received: by 2002:a17:907:7388:: with SMTP id er8mr235504ejc.269.1643932368272;
 Thu, 03 Feb 2022 15:52:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
 <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com> <a1c46c763fd4c832a6784e2a368199efedce17e9.1643921091.git.gitgitgadget@gmail.com>
In-Reply-To: <a1c46c763fd4c832a6784e2a368199efedce17e9.1643921091.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 15:52:37 -0800
Message-ID: <CABPp-BF0V7SomKSU4QYZGiwSOSpm_=pCrmyuUVGweCEKfV7RwQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] completion: address sparse-checkout issues
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

On Thu, Feb 3, 2022 at 12:44 PM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Correct multiple issues with tab completion of the git sparse-checkout
> command. These issues were:
>
> 1. git sparse-checkout <TAB> previously resulted in an incomplete list of
> subcommands (it was missing reapply and add).
> 2. Subcommand options were not tab-completable.
> 3. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> showed
> both file names and directory names. While this may be a less surprising
> behavior for non-cone mode, cone mode sparse checkouts should complete
> only directory names.
>
> Note that while the new strategy of just using git ls-tree to complete on
> directory names is simple and a step in the right direction, it does have
> some caveats. These are:
>
> 1. Likelihood of poor performance in large monorepos (as a result of
> recursively completing directory names).
> 2. Inability to handle paths containing unusual characters.
>
> These caveats will be fixed by subsequent commits in this series.
>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 16 ++---
>  t/t9902-completion.sh                  | 83 ++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c82ccaebcc7..2976f63747f 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2988,7 +2988,7 @@ _git_show_branch ()
>
>  _git_sparse_checkout ()
>  {
> -       local subcommands="list init set disable"
> +       local subcommands="list init set disable add reapply"
>         local subcommand="$(__git_find_on_cmdline "$subcommands")"
>         if [ -z "$subcommand" ]; then
>                 __gitcomp "$subcommands"
> @@ -2996,14 +2996,14 @@ _git_sparse_checkout ()
>         fi
>
>         case "$subcommand,$cur" in
> -       init,--*)
> -               __gitcomp "--cone"
> -               ;;
> -       set,--*)
> -               __gitcomp "--stdin"
> -               ;;
> -       *)
> +       *,--*)
> +               __gitcomp_builtin sparse-checkout_$subcommand "" "--"
>                 ;;
> +       set,*|add,*)
> +               if [ $(__git config core.sparseCheckoutCone) ] ||

Shouldn't this be

                 if [ "$(__git config core.sparseCheckoutCone)" == "true" ] ||

otherwise I think you'd trigger when it's manually set to false.

> +               [ "$(__git_find_on_cmdline --cone)" ]; then

This might read better as

                [ -n "$(__git_find_on_cmdline --cone)" ]; then

because otherwise you are relying on

     [ "--cone" ]

to evaluate as true which just seems slightly weird.

> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
> +               fi
>         esac
>  }
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 518203fbe07..f6eeb9aa035 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1447,6 +1447,89 @@ test_expect_success 'git checkout - with --detach, complete only references' '
>         EOF
>  '
>
> +test_expect_success 'setup sparse-checkout tests' '
> +       # set up sparse-checkout repo
> +       git init sparse-checkout &&
> +       (
> +               cd sparse-checkout &&
> +               mkdir -p folder1/0/1 folder2/0 folder3 &&
> +               touch folder1/0/1/t.txt &&
> +               touch folder2/0/t.txt &&
> +               touch folder3/t.txt &&
> +               git add . &&
> +               git commit -am "Initial commit"
> +       )
> +'
> +
> +test_expect_success 'sparse-checkout completes subcommands' '
> +       test_completion "git sparse-checkout " <<-\EOF
> +       list Z
> +       init Z
> +       set Z
> +       add Z
> +       reapply Z
> +       disable Z
> +       EOF
> +'
> +
> +test_expect_success 'cone mode sparse-checkout completes directory names' '
> +       # initialize sparse-checkout definitions
> +       git -C sparse-checkout sparse-checkout set --cone folder1/0 folder3 &&
> +
> +       # test tab completion
> +       (
> +               cd sparse-checkout &&
> +               test_completion "git sparse-checkout set f" <<-\EOF
> +               folder1 Z
> +               folder1/0 Z
> +               folder1/0/1 Z
> +               folder2 Z
> +               folder2/0 Z
> +               folder3 Z
> +               EOF
> +       ) &&
> +
> +       (
> +               cd sparse-checkout/folder1 &&
> +               test_completion "git sparse-checkout add " <<-\EOF
> +               ./ Z
> +               0 Z
> +               0/1 Z
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
> +       # reset sparse-checkout repo to non-cone mode
> +       git -C sparse-checkout sparse-checkout disable &&
> +       git -C sparse-checkout sparse-checkout set --no-cone &&
> +
> +       (
> +               cd sparse-checkout &&
> +               # expected to be empty since we have not configured
> +               # custom completion for non-cone mode
> +               test_completion "git sparse-checkout set f" <<-\EOF
> +
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'git sparse-checkout set --cone completes directory names' '
> +       git -C sparse-checkout sparse-checkout disable &&
> +
> +       (
> +               cd sparse-checkout &&
> +               test_completion "git sparse-checkout set --cone f" <<-\EOF
> +               folder1 Z
> +               folder1/0 Z
> +               folder1/0/1 Z
> +               folder2 Z
> +               folder2/0 Z
> +               folder3 Z
> +               EOF
> +       )
> +'
> +
>  test_expect_success 'git switch - with -d, complete all references' '
>         test_completion "git switch -d " <<-\EOF
>         HEAD Z

The rest looks good to me.
