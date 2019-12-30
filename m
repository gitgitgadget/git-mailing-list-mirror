Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE76C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3810920718
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j010DDb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfL3RSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:18:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33028 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfL3RSd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 12:18:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id v140so11227135oie.0
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 09:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GClPg+tjo/WifOJbywzzuzUqHNJe06Y2fDvk7vXQ6as=;
        b=j010DDb1ZH7od5deUUiDlDRhV21dSndyeY105IyOd9skbIdgE66m/JEQSVZObb+WP/
         nJCR8NloTsXegQEuRimaqm5tMFcFKyT2MIV+HMeKuz8cNv4btn48Fux1dquZL8MYS1mA
         T45+Y4YsWzh/whmdorTznWi1IBP6hXnQrX/WD3NWv345yzP/fTh4hBRzBS1j9xH3Nkv6
         Sm1AlOQKNMTnSTh96Zk6LUMstjThykQ9FOPlu5SwuF+tkI7WIX6ViTKk+zHUb562VelA
         Hxzzxtgsaiq5jk2Pw4nDI1FJdzdZejNHO19oLNKqpUfAjVsjPwBXqbwCJmnHr2h+yqUL
         DKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GClPg+tjo/WifOJbywzzuzUqHNJe06Y2fDvk7vXQ6as=;
        b=qO+FOTXCNslzE37Ou/+69iSP6+mgMzvbBNywx9Gh5Y/I8/qw9r1NxgeQ7BLBzDPgTT
         EH1nWY5ILD3YPTV6qTQym5yH/R0s3bJZ/Kcelez8BVz/EBuz6QQGXx6Vh4YJHf73CP97
         9gjSkbqC4aO8xJ1YdBNgqL252VoEYf1GVP9zklZFPl37IyLhRPLKfwkrOZRgoIlDeh9Y
         je7MW/3s/OtbDk6ZLno5WVLmYfFIpsRmdxSC7/rSyZfehYIW7MuzK37nEY4zwhumMytj
         I1gdNHsJxlHLp9vmMm8kL+sYHCISv+ekyhC7AErtBu9sPDUdAGWWD6GsZIVk2Qh9LVXZ
         7hoA==
X-Gm-Message-State: APjAAAUBCN5bgJOQ2O611Qx5dCNp0198Z07W/pmPzM/JjqJqBCMMtOe4
        PVDntDj0SKG32IuE3AxZAmHQnVsVQX6pVtqRjZA=
X-Google-Smtp-Source: APXvYqxZzckbrCd5lsLt65A14+IChL/xEI+erNtBLicl1XC6gWosb5yg3P9GzpH0MeyN9EPpYWMIFc5ou5w3hc3m6Xk=
X-Received: by 2002:aca:5588:: with SMTP id j130mr54377oib.122.1577726312073;
 Mon, 30 Dec 2019 09:18:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.500.v2.git.1577472469.gitgitgadget@gmail.com> <pull.500.v3.git.1577719993.gitgitgadget@gmail.com>
In-Reply-To: <pull.500.v3.git.1577719993.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Dec 2019 09:18:22 -0800
Message-ID: <CABPp-BGxMJjLCq9S54qqxKq3eFfNiRjVNvKgebRXgxzp=CoFpA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] sparse-checkout: list directories in cone mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        jon@jonsimons.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the fixups.  Just two small comments.

On Mon, Dec 30, 2019 at 7:33 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> When in cone mode, "git sparse-checkout set" takes a list of folders and
> constructs an ordered list of patterns for the sparse-checkout file. The
> "git sparse-checkout list" subcommand outputs the contents of the
> sparse-checkout file in a very basic way.
>
> This patch changes the behavior of "git sparse-checkout list" when
> core.sparseCheckoutCone=true. It will output the folders that were used in
> "git sparse-checkout set" to create the patterns, instead of the patterns
> themselves.
>
> I believe this was requested in the initial review, but I cannot find that
> message now.

This sentence isn't still true, is it?

> I was going to include this as part of a longer follow-up series, but I
> think this may be worth considering for the 2.25.0 release. Hence, it is
> included by itself.
>
> Update in V2:
>
>  * Fixed typos/word choice in commit message.
>
>
>  * Added a second commit including clarification on interactions with
>    submodules.
>
>
>
> Thanks, -Stolee
>
> Derrick Stolee (2):
>   sparse-checkout: list directories in cone mode
>   sparse-checkout: document interactions with submodules
>
>  Documentation/git-sparse-checkout.txt | 21 ++++++++++++++-
>  builtin/sparse-checkout.c             | 21 +++++++++++++++
>  t/t1091-sparse-checkout-builtin.sh    | 39 +++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+), 1 deletion(-)
>
>
> base-commit: 761e3d26bbe44c51f83c4f1ad198461f57029ebd
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-500%2Fderrickstolee%2Fsparse-checkout-list-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-500/derrickstolee/sparse-checkout-list-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/500
>
> Range-diff vs v2:
>
>  1:  d6f4f40486 ! 1:  7d4295bd06 sparse-checkout: list folders in cone mode
>      @@ -1,17 +1,17 @@
>       Author: Derrick Stolee <dstolee@microsoft.com>
>
>      -    sparse-checkout: list folders in cone mode
>      +    sparse-checkout: list directories in cone mode
>
>           When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
>      -    command takes a list of folders as input, then creates an ordered
>      -    list of sparse-checkout patterns such that those folders are
>      -    recursively included and all sibling entries along the parent folders
>      +    command takes a list of directories as input, then creates an ordered
>      +    list of sparse-checkout patterns such that those directories are
>      +    recursively included and all sibling entries along the parent directories
>           are also included. Listing the patterns is less user-friendly than the
>      -    folders themselves.
>      +    directories themselves.
>
>           In cone mode, and as long as the patterns match the expected cone-mode
>           pattern types, change the output of 'git sparse-checkout list' to only
>      -    show the folders that created the patterns.
>      +    show the directories that created the patterns.
>
>           With this change, the following piped commands would not change the
>           working directory:
>      @@ -41,8 +41,8 @@
>        based algorithms to compute inclusion in the sparse-checkout.
>
>       +In the cone mode case, the `git sparse-checkout list` subcommand will list the
>      -+folders that define the recursive patterns. For the example sparse-checkout file
>      -+above, the output is as follows:
>      ++directories that define the recursive patterns. For the example sparse-checkout
>      ++file above, the output is as follows:
>       +
>       +--------------------------
>       +$ git sparse-checkout list
>  2:  331bb7d6fb ! 2:  74bbd0f84d sparse-checkout: document interactions with submodules
>      @@ -2,11 +2,6 @@
>
>           sparse-checkout: document interactions with submodules
>
>      -    Junio asked what the behavior is between the sparse-checkout feature
>      -    and the submodule feature. The sparse-checkout builtin has not changed
>      -    the way these features interact, but we may as well document it in
>      -    the builtin docs.
>      -

I actually liked the second sentence of this paragraph and thought it
provided useful information for future readers; I only thought the
first sentence should be removed.

>           Using 'git submodule (init|deinit)' a user can select a subset of
>           submodules to populate. This behaves very similar to the sparse-checkout
>           feature, but those directories contain their own .git directory
>      @@ -61,14 +56,14 @@
>       +         git sparse-checkout set folder1
>       + ) &&
>       + list_files super >dir &&
>      -+ cat >expect <<-EOF &&
>      ++ cat >expect <<-\EOF &&
>       +         a
>       +         folder1
>       +         modules
>       + EOF
>       + test_cmp expect dir &&
>       + list_files super/modules/child >dir &&
>      -+ cat >expect <<-EOF &&
>      ++ cat >expect <<-\EOF &&
>       +         a
>       +         deep
>       +         folder1
>
> --
> gitgitgadget
