Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6E1C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 02:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1483F64E02
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 02:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhBXCbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 21:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhBXCbb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 21:31:31 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ABFC061786
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 18:30:51 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id b16so786704otq.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 18:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjR5cFUbT42JHcsvaCBopHiqx/YgZc0v6HFzyYFnXVM=;
        b=MJmaI4bz/fjXrX3Vw8w57SHtEBDnXB74U0K/8e4DGoioOjeRbKKYS04JnwyfMrVcXm
         YW+cRVkAX5CAGUyIJ7RciO6sUL1TvoDNxE6OUDZJ6o9IyCJdQ1Ydwx8VyMaee8Ud0ukf
         dTODk5sH1izO6jqayYV1+uXlWW7X0PS+yzKr9dmk/ZYGy5JlkIU0i1kJjA9+zT9INhLl
         alamK9n0yw2UOLBYE09kEVjWNdzAqU06xHfYOf84Pm92Wv9CsTRFQo+O4wfBbys8Y8rg
         BZtURMyHiFpaSanej1htR0bk3q3teZyv3HIoqmgrYzHEjdkUCcXXqYV9mTPNSGAVV+co
         yq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjR5cFUbT42JHcsvaCBopHiqx/YgZc0v6HFzyYFnXVM=;
        b=eQfGZ+X9vSYMzoNMEcsGKMf5migMOv7N8QsfZmCmSdcAW2FSGfEgT0fTo0GHJn6xVN
         OgLsFH2uCYVQYros87iLbWNZk++Bqlk1qgUnf9RUasBV8bkjAliRqDBmZhdw/f0vzv3W
         DqxcEayHRbUB+lS4wXpzBUaZQJdIxQHQBIkupDdl0olPZC57blhsofXlAWwPz120/GwS
         OXctmSc262JHztW9atiBGfc6/zIeaQ2SU/A/WkEnEdBog/JQoIUeYKjePzywUAiLFXgS
         Y70tMu1qrOqvvhjnBwRjfrx4aiPPYhvExCmKkTZQ//853mmCofdC8g1X2tcPJX6vJBZM
         MFRg==
X-Gm-Message-State: AOAM5338+e1RU/YS/eEQKHO/bcdYuZFSgpQLMXS+2SAJs0BDVoPOKDgE
        WMXSOX7b/dMBch2jpH+9lTDbJ0l4H71Dw5BOhx4=
X-Google-Smtp-Source: ABdhPJzajHEcKXeeW8AcYGLRTBWNtEeBTOYNTVxc8KNHLASjJpBoYjSX5VVVN3JoEh5sVGsdDKuWwm3WEgaj2LT6Ydg=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr13685163otk.162.1614133850612;
 Tue, 23 Feb 2021 18:30:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <a8c6322a3dbe1130dd2026b600a896e86d54a95d.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <a8c6322a3dbe1130dd2026b600a896e86d54a95d.1614111270.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 18:30:39 -0800
Message-ID: <CABPp-BGYP4OdVnUW0t_Veus-bzMPNH97MSNBdyH=e-iuN2b2jw@mail.gmail.com>
Subject: Re: [PATCH 02/20] t/perf: add performance test for sparse operations
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Create a test script that takes the default performance test (the Git
> codebase) and multiplies it by 256 using four layers of duplicated
> trees of width four. This results in nearly one million blob entries in
> the index. Then, we can clone this repository with sparse-checkout
> patterns that demonstrate four copies of the initial repository. Each
> clone will use a different index format or mode so peformance can be
> tested across the different options.
>
> Note that the initial repo is stripped of submodules before doing the
> copies. This preserves the expected data shape of the sparse index,
> because directories containing submodules are not collapsed to a sparse
> directory entry.
>
> Run a few Git commands on these clones, especially those that use the
> index (status, add, commit).
>
> Here are the results on my Linux machine:
>
> Test
> --------------------------------------------------------------
> 2000.2: git status (full-index-v3)             0.37(0.30+0.09)
> 2000.3: git status (full-index-v4)             0.39(0.32+0.10)
> 2000.4: git add -A (full-index-v3)             1.42(1.06+0.20)
> 2000.5: git add -A (full-index-v4)             1.26(0.98+0.16)
> 2000.6: git add . (full-index-v3)              1.40(1.04+0.18)
> 2000.7: git add . (full-index-v4)              1.26(0.98+0.17)
> 2000.8: git commit -a -m A (full-index-v3)     1.42(1.11+0.16)
> 2000.9: git commit -a -m A (full-index-v4)     1.33(1.08+0.16)
>
> It is perhaps noteworthy that there is an improvement when using index
> version 4. This is because the v3 index uses 108 MiB while the v4
> index uses 80 MiB. Since the repeated portions of the directories are
> very short (f3/f1/f2, for example) this ratio is less pronounced than in
> similarly-sized real repositories.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/perf/p2000-sparse-operations.sh | 87 +++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100755 t/perf/p2000-sparse-operations.sh
>
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> new file mode 100755
> index 000000000000..52597683376e
> --- /dev/null
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -0,0 +1,87 @@
> +#!/bin/sh
> +
> +test_description="test performance of Git operations using the index"
> +
> +. ./perf-lib.sh
> +
> +test_perf_default_repo
> +
> +SPARSE_CONE=f2/f4/f1
> +
> +test_expect_success 'setup repo and indexes' '
> +       git reset --hard HEAD &&
> +       # Remove submodules from the example repo, because our
> +       # duplication of the entire repo creates an unlikly data shape.
> +       git config --file .gitmodules --get-regexp "submodule.*.path" >modules &&
> +       rm -f .gitmodules &&
> +       git add .gitmodules &&

Why not `git rm [-f] .gitmodules` instead of these two commands?  Is
there something special about .gitmodules that requires this special
handling?

> +       for module in $(awk "{print \$2}" modules)
> +       do
> +               git rm $module || return 1
> +       done &&
> +       git add . &&

What does the `git add .` do?  I don't see any changes there weren't
already git-add'ed or git-rm'ed.

> +       git commit -m "remove submodules" &&
> +
> +       echo bogus >a &&
> +       cp a b &&
> +       git add a b &&
> +       git commit -m "level 0" &&
> +       BLOB=$(git rev-parse HEAD:a) &&
> +       OLD_COMMIT=$(git rev-parse HEAD) &&
> +       OLD_TREE=$(git rev-parse HEAD^{tree}) &&
> +
> +       for i in $(test_seq 1 4)
> +       do
> +               cat >in <<-EOF &&
> +                       100755 blob $BLOB       a
> +                       040000 tree $OLD_TREE   f1
> +                       040000 tree $OLD_TREE   f2
> +                       040000 tree $OLD_TREE   f3
> +                       040000 tree $OLD_TREE   f4
> +               EOF
> +               NEW_TREE=$(git mktree <in) &&
> +               NEW_COMMIT=$(git commit-tree $NEW_TREE -p $OLD_COMMIT -m "level $i") &&
> +               OLD_TREE=$NEW_TREE &&
> +               OLD_COMMIT=$NEW_COMMIT || return 1
> +       done &&
> +
> +       git sparse-checkout init --cone &&
> +       git branch -f wide $OLD_COMMIT &&
> +       git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v3 &&
> +       (
> +               cd full-index-v3 &&
> +               git sparse-checkout init --cone &&
> +               git sparse-checkout set $SPARSE_CONE &&
> +               git config index.version 3 &&
> +               git update-index --index-version=3
> +       ) &&
> +       git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v4 &&
> +       (
> +               cd full-index-v4 &&
> +               git sparse-checkout init --cone &&
> +               git sparse-checkout set $SPARSE_CONE &&
> +               git config index.version 4 &&
> +               git update-index --index-version=4
> +       )
> +'
> +
> +test_perf_on_all () {
> +       command="$@"
> +       for repo in full-index-v3 full-index-v4
> +       do
> +               test_perf "$command ($repo)" "
> +                       (
> +                               cd $repo &&
> +                               echo >>$SPARSE_CONE/a &&
> +                               $command
> +                       )
> +               "
> +       done
> +}
> +
> +test_perf_on_all git status
> +test_perf_on_all git add -A
> +test_perf_on_all git add .
> +test_perf_on_all git commit -a -m A
> +
> +test_done
> --
> gitgitgadget

Other than the two minor questions, the rest looks good to me.
