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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1ECC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF35923122
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbhATSAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732855AbhATRzK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 12:55:10 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC97C0613D3
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:54:30 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id w8so4124273oie.2
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rK35WI3lwHt0t3iHoY3ZILP3qyDQT3TIJ/IcwzU9bag=;
        b=s+a6Fouq8IR6gpML4/QNpS7RsaF7drc7tDi9Avq+q3IcD3qCdjC6EYE5TJ09QolP6d
         MmRkKHxo7evMvmU+G61Fw+2n1I8V0KQvyoUDXlEpD7FiPa46tUOC6ZCUx+56qKJceUvU
         n6AX9a0N469R4m5baPws/m937OOHzvzBSy/xL3IJOLCF7XpE7xcimVFbq67cbU9n/DX4
         CC9LO+wCT2VQzO4VyoPBBrv5pNgPkT17bjtsG+jvv+1x68c+LJlrdfeZky19bB8mGS0B
         769aUUx6xWh9xWtuFrdsiLQX4psnH6aYBtfNEVl7/CE+34mbqt3O/yifYL1BvQOM5vT8
         kStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rK35WI3lwHt0t3iHoY3ZILP3qyDQT3TIJ/IcwzU9bag=;
        b=Dt8lgGraJN8htEgYDm3axG3wQzN1lbdo7pr1nPlI8f2XjVzNKRLWe3tjthnJXLQP2j
         KCq9zv20TlzPAgAFhtB0i2xS85Vpz4Hx3YJAtJuBIt1UBHRlOAR+hSA9JZGKf7tRiTbM
         xHC0puetQdPMpKt14T0y83vSjjM4fTx/i0e5F9siK8LnYPWw9cf5K4aYTFBexRCN26Jd
         fqDeHqVx5Oq7aVAqsHWrK9WucaCFkPB5f9QV0JVYvXi457zDHs9E9iwuoarjYvIMMrNY
         mJ45/USRlgpZ+BrBOtK/ROuhwk3XExTKu2zjHdxUua+e2tL1bPOJHPOBiUSmEloi2and
         Q/aQ==
X-Gm-Message-State: AOAM533m4zQWjEPyhqtQUph8MWKC6fS/rObFnX85Oo+iLRqJc/ubd7p0
        Ezs3Q1GD7lRGjeDZq0+rfT3cTnN4kOL7zh5HpP4bdFM7RBc=
X-Google-Smtp-Source: ABdhPJwEMWKuUtKMkugVDNNJJAUgc/4AQ1aPoeM8PgoLpX/H4g7ygKm7Tn0Veijsl0OVFJaECjoNJ7dwgIvAzo9EEYs=
X-Received: by 2002:a05:6808:83:: with SMTP id s3mr3666927oic.31.1611165269650;
 Wed, 20 Jan 2021 09:54:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com> <64358ec7ea2b3df4a8f1099452579a7568996921.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <64358ec7ea2b3df4a8f1099452579a7568996921.1611161639.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jan 2021 09:54:18 -0800
Message-ID: <CABPp-BHSssDCvyC3rGZasR8yWxJYN9Y09LZL2BBd2hyFgG08Vw@mail.gmail.com>
Subject: Re: [PATCH 6/9] sparse-checkout: load sparse-checkout patterns
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> A future feature will want to load the sparse-checkout patterns into a
> pattern_list, but the current mechanism to do so is a bit complicated.
> This is made difficult due to needing to find the sparse-checkout file
> in different ways throughout the codebase.
>
> The logic implemented in the new get_sparse_checkout_patterns() was
> duplicated in populate_from_existing_patterns() in unpack-trees.c. Use
> the new method instead, keeping the logic around handling the struct
> unpack_trees_options.
>
> The callers to get_sparse_checkout_filename() in
> builtin/sparse-checkout.c manipulate the sparse-checkout file directly,
> so it is not appropriate to replace logic in that file with
> get_sparse_checkout_patterns().
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c |  5 -----
>  dir.c                     | 17 +++++++++++++++++
>  dir.h                     |  2 ++
>  unpack-trees.c            |  6 +-----
>  4 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index e3140db2a0a..2306a9ad98e 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -22,11 +22,6 @@ static char const * const builtin_sparse_checkout_usage[] = {
>         NULL
>  };
>
> -static char *get_sparse_checkout_filename(void)
> -{
> -       return git_pathdup("info/sparse-checkout");
> -}
> -
>  static void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
>  {
>         int i;
> diff --git a/dir.c b/dir.c
> index d637461da5c..d153a63bbd1 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2998,6 +2998,23 @@ void setup_standard_excludes(struct dir_struct *dir)
>         }
>  }
>
> +char *get_sparse_checkout_filename(void)
> +{
> +       return git_pathdup("info/sparse-checkout");
> +}
> +
> +int get_sparse_checkout_patterns(struct pattern_list *pl)
> +{
> +       int res;
> +       char *sparse_filename = get_sparse_checkout_filename();
> +
> +       pl->use_cone_patterns = core_sparse_checkout_cone;
> +       res = add_patterns_from_file_to_list(sparse_filename, "", 0, pl, NULL);
> +
> +       free(sparse_filename);
> +       return res;
> +}
> +
>  int remove_path(const char *name)
>  {
>         char *slash;
> diff --git a/dir.h b/dir.h
> index a3c40dec516..facfae47402 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -448,6 +448,8 @@ int is_empty_dir(const char *dir);
>
>  void setup_standard_excludes(struct dir_struct *dir);
>
> +char *get_sparse_checkout_filename(void);
> +int get_sparse_checkout_patterns(struct pattern_list *pl);
>
>  /* Constants for remove_dir_recursively: */
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index af6e9b9c2fd..837b8bb42fb 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1549,14 +1549,10 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
>  static void populate_from_existing_patterns(struct unpack_trees_options *o,
>                                             struct pattern_list *pl)
>  {
> -       char *sparse = git_pathdup("info/sparse-checkout");
> -
> -       pl->use_cone_patterns = core_sparse_checkout_cone;
> -       if (add_patterns_from_file_to_list(sparse, "", 0, pl, NULL) < 0)
> +       if (get_sparse_checkout_patterns(pl) < 0)
>                 o->skip_sparse_checkout = 1;
>         else
>                 o->pl = pl;
> -       free(sparse);
>  }
>
>
> --
> gitgitgadget

Looks straightforward and well motivated to me.

But the cherry on top that really sells this patch is that more lines
of dir.c will blame to someone besides me.  Win-win!
