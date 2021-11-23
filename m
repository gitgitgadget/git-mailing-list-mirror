Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA62C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 07:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhKWHuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 02:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhKWHuq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 02:50:46 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B283C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 23:47:38 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r11so88132839edd.9
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 23:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hfre9j6qT2AtLGXLQiHYCLRz7A8TKvAiGgnVMYoMN8I=;
        b=dG6tPifYf1gPOpi4SDIK3a4oW09c6bAjrA6HFh/WWxL/xiOd2TABVmtCyCWYEFBMlU
         WtXMIf2KyJ4F40fR5R7kEIfMX1wgcZxy4IyQJJ1MQzMTDy9msyqfT0vnBT1ei4DL2HHu
         58L1bOKym32Lt4TntjhFaeNRexxTlQGV3zZgFRSK2+zdiA6f9BNr9OMJht1eFHx2X3vR
         5KfO9kyCyJTQR9Tzuw823yN3H7731oY+QrONgNyuaOsJn+PqF/bADKh5ftyDkbeUQ7KS
         QXnTFD7VNuNYkfkHpytZyrB8eaN/32RSwfP3R7QWUFCqxBaNDH0tUyveL0O72Gb0CJRm
         iT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hfre9j6qT2AtLGXLQiHYCLRz7A8TKvAiGgnVMYoMN8I=;
        b=EMUQcTKTiITnOLmCt6osvo/MX/llz8LjAQIigP5Cgk6jHBRmGR+YRXRx3QZ6g0K7Wr
         QX0K3aWac7xg4Q79/kAsEaqLpfhE8PApAfgHkkdE/JH7lMTFMFRgqBFsz5oAIRTN4i2F
         jBGiA9TTDczJHtbzSYATBy5hM64JNriVB4lp4Fnl6YitcWLYUGpoNAApUGt1qAYZrRat
         IrM3P1PcLI5Qr51eGWbjFxPSiHQ2nZBAjoCLRHH4hO4karovJkQ8KJ2lJsIBPSgh6luo
         jPzfuXLcNnpImpw9tfOwldF3+JEW3XpuZI4pcMOZwfKAcC4/OHczQuAEUfJxpav3rJre
         S/cw==
X-Gm-Message-State: AOAM533n1k8Y/lufaSPN1BfYUFmfQMfILkueANY9+S5lVe5VICm97ONZ
        gZlq/Q19jGCX/kmhs9hj7rpsVJH15NfNFJSw18vdm42V3hY=
X-Google-Smtp-Source: ABdhPJylbffCtFWx5GlgmCeennv/FhhwY7ScvWm6Oe1PvjLWp2POLtJLixsgM9Hs4xwNtn8SKegGukroXQM+Gyj1mkY=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr6021310edx.244.1637653657166;
 Mon, 22 Nov 2021 23:47:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com> <273ee16b74ed4b36ffba5762fa892410317ea02b.1637620958.git.gitgitgadget@gmail.com>
In-Reply-To: <273ee16b74ed4b36ffba5762fa892410317ea02b.1637620958.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 23:47:25 -0800
Message-ID: <CABPp-BEurZH8RaLLB2vvw3aPCWy4Aq1Zs+PkTY9WFboq8OuZ2w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] diff: enable and test the sparse index
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 2:42 PM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Enable the sparse index within the 'git diff' command. Its implementation
> already safely integrates with the sparse index because it shares code
> with the 'git status' and 'git checkout' commands that were already
> integrated.  For more details see:
>
> d76723e (status: use sparse-index throughout, 2021-07-14)
> 1ba5f45 (checkout: stop expanding sparse indexes, 2021-06-29)

I preferred the references in your v3:

d76723ee53 (status: use sparse-index throughout, 2021-07-14)
1ba5f45132 (checkout: stop expanding sparse indexes, 2021-06-29)

because 7-character abbreviations aren't very future proof;
10-character seems better to me.

(Very micro nit.)

>
> The most interesting thing to do is to add tests that verify that 'git
> diff' behaves correctly when the sparse index is enabled. These cases are:
>
> 1. The index is not expanded for 'diff' and 'diff --staged'
> 2. 'diff' and 'diff --staged' behave the same in full checkout, sparse
> checkout, and sparse index repositories in the following partially-staged
> scenarios (i.e. the index, HEAD, and working directory differ at a given
> path):
>     1. Path is within sparse-checkout cone
>     2. Path is outside sparse-checkout cone
>     3. A merge conflict exists for paths outside sparse-checkout cone
>
> The `p2000` tests demonstrate a ~44% execution time reduction for 'git
> diff' and a ~86% execution time reduction for 'git diff --staged' using a
> sparse index:
>
> Test                                      before  after
> -------------------------------------------------------------
> 2000.30: git diff (full-v3)               0.33    0.34 +3.0%
> 2000.31: git diff (full-v4)               0.33    0.35 +6.1%
> 2000.32: git diff (sparse-v3)             0.53    0.31 -41.5%
> 2000.33: git diff (sparse-v4)             0.54    0.29 -46.3%
> 2000.34: git diff --cached (full-v3)      0.07    0.07 +0.0%
> 2000.35: git diff --cached (full-v4)      0.07    0.08 +14.3%
> 2000.36: git diff --cached (sparse-v3)    0.28    0.04 -85.7%
> 2000.37: git diff --cached (sparse-v4)    0.23    0.03 -87.0%
>
> Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  builtin/diff.c                           |  5 +++
>  t/perf/p2000-sparse-operations.sh        |  2 ++
>  t/t1092-sparse-checkout-compatibility.sh | 46 ++++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index dd8ce688ba7..fa4683377eb 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -437,6 +437,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>
>         prefix = setup_git_directory_gently(&nongit);
>
> +       if (!nongit) {
> +               prepare_repo_settings(the_repository);
> +               the_repository->settings.command_requires_full_index = 0;
> +       }
> +
>         if (!no_index) {
>                 /*
>                  * Treat git diff with at least one path outside of the
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index bfd332120c8..5cf94627383 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -113,5 +113,7 @@ test_perf_on_all git checkout -f -
>  test_perf_on_all git reset
>  test_perf_on_all git reset --hard
>  test_perf_on_all git reset -- does-not-exist
> +test_perf_on_all git diff
> +test_perf_on_all git diff --cached
>
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 44d5e11c762..53524660759 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -832,6 +832,52 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
>         )
>  '
>
> +test_expect_success 'sparse index is not expanded: diff' '
> +       init_repos &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF
> +
> +       # Add file within cone
> +       test_sparse_match git sparse-checkout set deep &&
> +       run_on_all ../edit-contents deep/testfile &&
> +       test_all_match git add deep/testfile &&
> +       run_on_all ../edit-contents deep/testfile &&
> +
> +       test_all_match git diff &&
> +       test_all_match git diff --staged &&
> +       ensure_not_expanded diff &&
> +       ensure_not_expanded diff --staged &&
> +
> +       # Add file outside cone
> +       test_all_match git reset --hard &&
> +       run_on_all mkdir newdirectory &&
> +       run_on_all ../edit-contents newdirectory/testfile &&
> +       test_sparse_match git sparse-checkout set newdirectory &&
> +       test_all_match git add newdirectory/testfile &&
> +       run_on_all ../edit-contents newdirectory/testfile &&
> +       test_sparse_match git sparse-checkout set &&
> +
> +       test_all_match git diff &&
> +       test_all_match git diff --staged &&
> +       ensure_not_expanded diff &&
> +       ensure_not_expanded diff --staged &&
> +
> +       # Merge conflict outside cone
> +       # The sparse checkout will report a warning that is not in the
> +       # full checkout, so we use `run_on_all` instead of
> +       # `test_all_match`
> +       run_on_all git reset --hard &&
> +       test_all_match git checkout merge-left &&
> +       test_all_match test_must_fail git merge merge-right &&
> +
> +       test_all_match git diff &&
> +       test_all_match git diff --staged &&
> +       ensure_not_expanded diff &&
> +       ensure_not_expanded diff --staged

You've changed some of the --staged to --cached, but based on Junio's
comments on the previous round, you probably want to convert the
others too.

> +'
> +
>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>  # in this scenario, but it shouldn't.
>  test_expect_success 'reset mixed and checkout orphan' '
> --
> gitgitgadget
>
