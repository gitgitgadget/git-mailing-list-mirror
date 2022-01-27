Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B0FC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 07:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiA0HJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiA0HJu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 02:09:50 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7308C06173B
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 23:09:49 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ah7so3722830ejc.4
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 23:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1iGJ3y2X1n/fKTvktPA7aT9H9/MWZEPs6lrNwI7SLU=;
        b=lbVKT/e4U42XexyxMhPRXY/DX45rsoSnjwO3BFTsgiFsRRIr2nYozqDJb0C9eMNtO7
         5+8KYG8XDNqh9T5V3qU0hNNLCDi69mP1p7YktZL5vYcKAFWF7MgvSsNOBNY3x64M6GKz
         wBdyDp5Gx+vTyacez0XXhHdunG5jEj4YTH+qJydz1P6sdCLemxHjl1S1tVE2Q5xAotW2
         rzFo8y+pQz+mEPWM766i+Rf8/3A9cqTkNN3Ln/RFdbRnBZXXT0Rp3mHHHkwEW+0QN0Ju
         +qmVH4MI1Ic7j6r7+pnhFRTk0VMYV9JOgA8qwVtUaOHIH+SsFtZTURLvMQPYsPJkAkTF
         1uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1iGJ3y2X1n/fKTvktPA7aT9H9/MWZEPs6lrNwI7SLU=;
        b=a60VQ1OeW+UWYKaLYBnGHBhuiu7z+w416ky+fE3xYvw1ZJbVkE0Zz5g+R+WDIPwQXR
         yuXBjdnWiHs5uA2bJAHUfUqpLM0miW/L2BmrAScdPqeZa/R9X4wsWi0BPfcs13FDKpgd
         x8QswgeLkG0d9NLC/60MQPokUkbXOPk+q5V88fPOAJRa6jwPCey4h5G3tTp69P3MDnzj
         SW+ng4Cabzjlcq45N0WdSgMZip0o9jEvMKCWTCq06gR3jS9U13UPn4b5j1hE2Iah3Hym
         9+pe+KVghQNeS7ofWIAqAT6OWZ3+0CnU33xxMWDMokH4inzt5Qo243TBezj8c82k9suI
         xHvQ==
X-Gm-Message-State: AOAM533ITG2O0WkMm++GTQIjbDtHFyBmTcQYEngxGEOizTCcblhfX7wQ
        HEftj2arV2FqBnBhVWGgkf2vlD330mu7BpDhUzA=
X-Google-Smtp-Source: ABdhPJwfE6Tnf8fdUHVGW5Hi2FlmAEH104O3/PJucJ8Ew5XJf21bM2LDL+mpwrQZflGOdsbVpD4t4xmfgUYWhPC/jCA=
X-Received: by 2002:a17:907:60d5:: with SMTP id hv21mr1957219ejc.476.1643267388266;
 Wed, 26 Jan 2022 23:09:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com> <bb9e550ff3d6c1432aa1d1d07d747e7e085216e8.1643136134.git.gitgitgadget@gmail.com>
In-Reply-To: <bb9e550ff3d6c1432aa1d1d07d747e7e085216e8.1643136134.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 Jan 2022 23:09:36 -0800
Message-ID: <CABPp-BHog9yoqC+M=L6y3uBfmfPOTdhy=hErwBozhbqL_yQ+-g@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] worktree: copy sparse-checkout patterns and config
 on add
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 10:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When adding a new worktree, it is reasonable to expect that we want to
> use the current set of sparse-checkout settings for that new worktree.
> This is particularly important for repositories where the worktree would
> become too large to be useful. This is even more important when using
> partial clone as well, since we want to avoid downloading the missing
> blobs for files that should not be written to the new worktree.
>
> The only way to create such a worktree without this intermediate step of
> expanding the full worktree is to copy the sparse-checkout patterns and
> config settings during 'git worktree add'. Each worktree has its own
> sparse-checkout patterns, and the default behavior when the
> sparse-checkout file is missing is to include all paths at HEAD. Thus,
> we need to have patterns from somewhere, they might as well be the
> current worktree's patterns. These are then modified independently in
> the future.
>
> In addition to the sparse-checkout file, copy the worktree config file
> if worktree config is enabled and the file exists. This will copy over
> any important settings to ensure the new worktree behaves the same as
> the current one. The only exception we must continue to make is that
> core.bare and core.worktree should become unset in the worktree's config
> file.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/worktree.c                 | 60 ++++++++++++++++++++++++++++++
>  t/t1091-sparse-checkout-builtin.sh | 31 +++++++++++----
>  t/t2400-worktree-add.sh            | 46 ++++++++++++++++++++++-
>  3 files changed, 127 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 2838254f7f2..dc9cd6decc8 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -335,6 +335,66 @@ static int add_worktree(const char *path, const char *refname,
>         strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>         write_file(sb.buf, "../..");
>
> +       /*
> +        * If the current worktree has sparse-checkout enabled, then copy
> +        * the sparse-checkout patterns from the current worktree.
> +        */
> +       if (core_apply_sparse_checkout) {
> +               char *from_file = git_pathdup("info/sparse-checkout");
> +               char *to_file = xstrfmt("%s/worktrees/%s/info/sparse-checkout",
> +                                       realpath.buf, name);
> +
> +               if (file_exists(from_file)) {
> +                       if (safe_create_leading_directories(to_file) ||
> +                           copy_file(to_file, from_file, 0666))
> +                               error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
> +                                     from_file, to_file);
> +               }
> +
> +               free(from_file);
> +               free(to_file);
> +       }
> +
> +       /*
> +        * If we are using worktree config, then copy all current config
> +        * values from the current worktree into the new one, that way the
> +        * new worktree behaves the same as this one.
> +        */
> +       if (repository_format_worktree_config) {
> +               char *from_file = git_pathdup("config.worktree");
> +               char *to_file = xstrfmt("%s/worktrees/%s/config.worktree",
> +                                       realpath.buf, name);
> +
> +               if (file_exists(from_file)) {
> +                       struct config_set cs = { { 0 }};
> +                       const char *str_value;
> +                       int bool_value;
> +
> +                       if (safe_create_leading_directories(to_file) ||
> +                           copy_file(to_file, from_file, 0666))
> +                               die(_("failed to copy worktree config from '%s' to '%s'"),
> +                                   from_file, to_file);
> +
> +                       git_configset_init(&cs);
> +                       git_configset_add_file(&cs, from_file);
> +
> +                       if (!git_configset_get_bool(&cs, "core.bare", &bool_value) &&
> +                           bool_value &&
> +                           git_config_set_multivar_in_file_gently(
> +                                       to_file, "core.bare", NULL, "true", 0))
> +                               error(_("failed to unset 'core.bare' in '%s'"), to_file);
> +                       if (!git_configset_get_value(&cs, "core.worktree", &str_value) &&
> +                           git_config_set_in_file_gently(to_file,
> +                                                         "core.worktree", NULL))
> +                               error(_("failed to unset 'core.worktree' in '%s'"), to_file);
> +
> +                       git_configset_clear(&cs);
> +               }
> +
> +               free(from_file);
> +               free(to_file);
> +       }
> +
>         strvec_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
>         strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
>         cp.git_cmd = 1;
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index be6ea4ffe33..d929772be96 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -146,9 +146,9 @@ test_expect_success 'interaction with clone --no-checkout (unborn index)' '
>  '
>
>  test_expect_success 'set enables config' '
> -       git init empty-config &&
> +       git init worktree-config &&
>         (
> -               cd empty-config &&
> +               cd worktree-config &&
>                 test_commit test file &&
>                 test_path_is_missing .git/config.worktree &&
>                 git sparse-checkout set nothing &&
> @@ -201,6 +201,21 @@ test_expect_success 'add to sparse-checkout' '
>         check_files repo "a folder1 folder2"
>  '
>
> +test_expect_success 'worktree: add copies sparse-checkout patterns' '
> +       cat repo/.git/info/sparse-checkout >old &&
> +       test_when_finished cp old repo/.git/info/sparse-checkout &&
> +       test_when_finished git -C repo worktree remove ../worktree &&
> +       git -C repo sparse-checkout set "/*" &&

Could we add --no-cone to tests using that mode in anticipation of
switching the default?

> +       git -C repo worktree add --quiet ../worktree 2>err &&
> +       test_must_be_empty err &&
> +       new=repo/.git/worktrees/worktree/info/sparse-checkout &&
> +       test_path_is_file $new &&
> +       test_cmp repo/.git/info/sparse-checkout $new &&
> +       git -C worktree sparse-checkout set --cone &&
> +       test_cmp_config -C worktree true core.sparseCheckoutCone &&
> +       test_must_fail git -C repo core.sparseCheckoutCone
> +'
> +
>  test_expect_success 'cone mode: match patterns' '
>         git -C repo config --worktree core.sparseCheckoutCone true &&
>         rm -rf repo/a repo/folder1 repo/folder2 &&
> @@ -520,13 +535,13 @@ test_expect_success 'interaction with submodules' '
>  '
>
>  test_expect_success 'different sparse-checkouts with worktrees' '
> +       git -C repo sparse-checkout set --cone deep folder1 &&
>         git -C repo worktree add --detach ../worktree &&
> -       check_files worktree "a deep folder1 folder2" &&
> -       git -C worktree sparse-checkout init --cone &&
> -       git -C repo sparse-checkout set folder1 &&
> -       git -C worktree sparse-checkout set deep/deeper1 &&
> -       check_files repo a folder1 &&
> -       check_files worktree a deep
> +       check_files worktree "a deep folder1" &&
> +       git -C repo sparse-checkout set --cone folder1 &&
> +       git -C worktree sparse-checkout set --cone deep/deeper1 &&
> +       check_files repo "a folder1" &&
> +       check_files worktree "a deep"
>  '
>
>  test_expect_success 'set using filename keeps file on-disk' '
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 37ad79470fb..3fb5b21b943 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -165,8 +165,50 @@ test_expect_success '"add" default branch of a bare repo' '
>         (
>                 git clone --bare . bare2 &&
>                 cd bare2 &&
> -               git worktree add ../there3 main
> -       )
> +               git worktree add ../there3 main &&
> +               cd ../there3 &&
> +               git status
> +       ) &&
> +       cat >expect <<-EOF &&
> +       init.t
> +       EOF
> +       ls there3 >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success '"add" to bare repo with worktree config' '
> +       (
> +               git clone --bare . bare3 &&
> +               cd bare3 &&
> +               git config extensions.worktreeconfig true &&
> +               git config --worktree core.bare true &&
> +               git config --worktree core.worktree "$(pwd)" &&
> +               git config --worktree bogus.key value &&
> +               git config --unset core.bare &&
> +               git worktree add ../there4 main &&
> +               cd ../there4 &&
> +               git status &&
> +               git worktree add --detach ../there5 &&
> +               cd ../there5 &&
> +               git status
> +       ) &&
> +
> +       # the worktree has the arbitrary value copied.
> +       test_cmp_config -C there4 value bogus.key &&
> +       test_cmp_config -C there5 value bogus.key &&
> +
> +       # however, core.bare and core.worktree were removed.
> +       test_must_fail git -C there4 config core.bare &&
> +       test_must_fail git -C there4 config core.worktree &&
> +
> +       cat >expect <<-EOF &&
> +       init.t
> +       EOF
> +
> +       ls there4 >actual &&
> +       test_cmp expect actual &&
> +       ls there5 >actual &&
> +       test_cmp expect actual
>  '
>
>  test_expect_success 'checkout with grafts' '
> --
> gitgitgadget

This patch is so awesome.  Totally looking forward to seeing it
included.  I was only able to spot one micro nit.
