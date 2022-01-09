Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9FAC433F5
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 01:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiAIBtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 20:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiAIBta (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 20:49:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2CC06173F
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 17:49:30 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u25so38425210edf.1
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 17:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhZXWLefaks4CJdQqoZVsYEqA66S2rLDIFsgIYl6nsE=;
        b=oLuYbIJbqhMUNCsZWXbdmVRBJH53FUNVmTZlnbrtBLv1TgVK4dzqt1lK0fJtlrAZgN
         eJIo9Jvwk3jpTlA1jDyb37nRUFAq/ibDhUoTM7IFBK5XaRT70MG5zqRQ+nTaJdgL52Rw
         IHjoWsFxOVS5V0AKGBNmSKoPsCN5Rsvptev3qDqFMpdtCFKtgyjT0YfNOmrW8N4RD7hI
         x8i/pKCJBmcCwJ8vhXyvMr4SmqxddSDw61LPwCDnyrCPdjB77kzyERfPSObz2TNxIXtP
         OFrnkZzWOhubR2iA97OEW1mdl2eEkaGEo4ECymU4FwAn6s1M0mq2ssyo1SnWaQeZQBzC
         G2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhZXWLefaks4CJdQqoZVsYEqA66S2rLDIFsgIYl6nsE=;
        b=hyq9/jPHxDV8SPazPgdpEnebkT/YhNN9pIGt0GlAKZTGh45hzMvbfUspF9Hkws4eti
         rvYQ36PaQsIGjga5kPqudL1oRerTFnCp27Qe9qruMXMxHN6apjuuGVZEkDUtXHdUESq8
         T2XUPuOWwInYaop9Z2PdQ8Rb/afVO0v6dOcqlnFTIxU8HyxBoZYitMssn/edYypwJyoe
         xPrvEIkJTx71FjBMTTgyT7TVx+U4u4bog4oLpmbuTkMmR4SBkm0KGMu252zmkRSYquWp
         mBOkhuOCMnLYqf16zLKJB+NkXueUQfRarBYRBBdbuU08ZvrWI1Odee21LFak4w57SGVu
         aY1Q==
X-Gm-Message-State: AOAM5300OpNlz6c+ZW26SQyxMuUgOKXtGdVd38t7uUpjvjXX5jNPQDb3
        mfMMsafpEKR5VM71GJCZazfcr573Eg3hMygXAF0=
X-Google-Smtp-Source: ABdhPJw14PvVqPMDrtDp+l/2pJemLA8vm3mK16SYLwjvv2cJKBKT1ld47tMadbu1Tp4gtRBcG2ARm6JQ16tM0CGYmaU=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr55823919ejc.476.1641692968190;
 Sat, 08 Jan 2022 17:49:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com> <c5b98e36516b8f832576816c202be7581f261909.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <c5b98e36516b8f832576816c202be7581f261909.1641317820.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 8 Jan 2022 17:49:16 -0800
Message-ID: <CABPp-BGmaKsvrO1Qxwuj+WgcvuE_NA4agY_HLQ8=csvddRafqw@mail.gmail.com>
Subject: Re: [PATCH 8/9] update-index: integrate with sparse index
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Enable usage of the sparse index with `update-index`. Most variations of
> `update-index` work without explicitly expanding the index or making any
> other updates in or outside of `update-index.c`.
>
> The one usage requiring additional changes is `--cacheinfo`; if a file
> inside a sparse directory was specified, the index would not be expanded
> until after the cache tree is invalidated, leading to a mismatch between the
> index and cache tree. This scenario is handled by rearranging
> `add_index_entry_with_check`, allowing `index_name_stage_pos` to expand the
> index *before* attempting to invalidate the relevant cache tree path,
> avoiding cache tree/index corruption.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/update-index.c                   |  3 +++
>  read-cache.c                             | 10 +++++++---
>  t/t1092-sparse-checkout-compatibility.sh | 12 ++++++++++++
>  3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 187203e8bb5..605cc693bbd 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1077,6 +1077,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>
>         git_config(git_default_config, NULL);
>
> +       prepare_repo_settings(r);
> +       the_repository->settings.command_requires_full_index = 0;
> +
>         /* we will diagnose later if it turns out that we need to update it */
>         newfd = hold_locked_index(&lock_file, 0);
>         if (newfd < 0)
> diff --git a/read-cache.c b/read-cache.c
> index cbe73f14e5e..b4600e954b6 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1339,9 +1339,6 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>         int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
>         int new_only = option & ADD_CACHE_NEW_ONLY;
>
> -       if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
> -               cache_tree_invalidate_path(istate, ce->name);
> -
>         /*
>          * If this entry's path sorts after the last entry in the index,
>          * we can avoid searching for it.
> @@ -1352,6 +1349,13 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>         else
>                 pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), EXPAND_SPARSE);
>
> +       /*
> +        * Cache tree path should be invalidated only after index_name_stage_pos,
> +        * in case it expands a sparse index.
> +        */
> +       if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
> +               cache_tree_invalidate_path(istate, ce->name);
> +
>         /* existing match? Just replace it. */
>         if (pos >= 0) {
>                 if (!new_only)
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 6804ab23a27..bc0741c970d 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1216,6 +1216,18 @@ test_expect_success 'sparse index is not expanded: blame' '
>         done
>  '
>
> +test_expect_success 'sparse index is not expanded: update-index' '
> +       init_repos &&
> +
> +       echo "test" >sparse-index/README.md &&
> +       echo "test2" >sparse-index/a &&
> +       rm -f sparse-index/deep/a &&
> +
> +       ensure_not_expanded update-index --add README.md &&
> +       ensure_not_expanded update-index a &&
> +       ensure_not_expanded update-index --remove deep/a
> +'

The commit message said this change was about --cacheinfo, but this
test doesn't use that option.  I'm confused; was this a bad patch
splitting by chance?

> +
>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>  # in this scenario, but it shouldn't.
>  test_expect_success 'reset mixed and checkout orphan' '
> --
> gitgitgadget
>
