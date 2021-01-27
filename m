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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52BCC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 18:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8730064DA9
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 18:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhA0STa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 13:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhA0ST3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 13:19:29 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB4C061574
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 10:18:49 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id i20so2614649otl.7
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 10:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkr0c4p+o/cbAj8UKIxQkmf05d+eW2AGEUyRCNS8hLk=;
        b=HW1a06HUQVxNjN2HLpac0EH5g/lh3MQyr8aRPbxmW2k/y5dZY/vx2Ni6Iy/pK1fdNP
         P1gPvU6PpHXxPV45L02FyPMagENqufEi1AUPeDw+MIoEPHtXeHY3SYxexVJ1YMOwRlX8
         a0YaJ5orWmY3Tm3O+d4ATZYWBPETVOLYY/nDCs4gBbiLlxEtzhgIHOsMyw57/BaOepun
         EL4hUjo+pNeuzeqlsNJKL6fb8zkbHmhi/hkqB67FEaiU0FCzZbdjEfZpQlXh1+9KwLfg
         wrneelg1EDttU0ZSP1xogZvK3pwTx2S2CSXeRcwzNj1awm27fyfyN8XgJe+UuJizCAho
         ybAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkr0c4p+o/cbAj8UKIxQkmf05d+eW2AGEUyRCNS8hLk=;
        b=E5lBpy3MJuoElOuP10Wh3cLt5oLuat4K2KaU+tGTDG6e828phIHdyaGVxf66fzedyP
         TKzF8Kn/GIjwjYzEngApAs/oku7Ne8ER4gb87iVhNvNntI/TUV8C49aAgrF0RMqRy2nu
         ytCyQpOQctCKNUkc6AwspoTFrFXDnbfCefsrHGIDaP+LUPjQvbd8kjD/p9xhw6leVyik
         DsBhjZgR1FtvmClfCMQV85Ol32F1BTIQodYZ6Gpyn/gFi5fX6wJvqftcUPSqKnAWdoGq
         iGXvTcBNiRfnxcokwjkxuqBZ0zOaqGmD7llqIlDqaHjvkLHDqNXmNkMMPqHhMHR2eXg9
         V5FQ==
X-Gm-Message-State: AOAM533JCHU8QICsNI4M9TqjRAlXfjC2tka0TDFxpgtrLi3I1dPakrG9
        9U1GThLpWS8dw+D192a3MO2Bg5bwuN1fc4LhJ2w=
X-Google-Smtp-Source: ABdhPJzO64AqiPAZbMHw9VDrP+QDu4iE6KrWxgnbNFRv51X0NHMZ4ZgcW6gBLG1n2S71XtFjVOHx16xHxrjHpMBwNls=
X-Received: by 2002:a9d:506:: with SMTP id 6mr8413113otw.162.1611771528080;
 Wed, 27 Jan 2021 10:18:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <54ca484b057b5caa9871cffe47a0a60617e0c5cf.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <54ca484b057b5caa9871cffe47a0a60617e0c5cf.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Jan 2021 10:18:36 -0800
Message-ID: <CABPp-BE1=UnFef2=CciL=2Hm53-2qXsMQ2UdMhaBheexR1Oteg@mail.gmail.com>
Subject: Re: [PATCH 14/27] sparse-checkout: toggle sparse index from builtin
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The sparse index extension is used to signal that index writes should be
> in sparse mode. This was only updated using GIT_TEST_SPARSE_INDEX=1.
>
> Add a '--[no-]sparse-index' option to 'git sparse-checkout init' that
> specifies if the sparse index should be used. It also updates the index
> to use the correct format, either way. Add a warning in the
> documentation that the use of a repository extension might reduce
> compatibility with third-party tools. 'git sparse-checkout init' already
> sets extension.worktreeConfig, which places most sparse-checkout users
> outside of the scope of most third-party tools.

Heh, looks like you're addressing my comments on the last patch about
jgit.  If I would have just read on...

One side question, though -- I thought I remembered seeing that we
record index versions or extension information directly in the index,
so that third party tools have a way of noting that the index has
something they won't understand, rather than just reading values that
appear to be corrupt to them.  Perhaps I missed it, but have you done
anything like that with this series?

>
> Update t1092-sparse-checkout-compatibility.sh to use this CLI instead of
> GIT_TEST_SPARSE_INDEX=1.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt    | 14 +++++++++
>  builtin/sparse-checkout.c                | 17 ++++++++++-
>  sparse-index.c                           | 38 ++++++++++++++++--------
>  sparse-index.h                           |  3 ++
>  t/t1092-sparse-checkout-compatibility.sh | 33 ++++++++++----------
>  5 files changed, 75 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index a0eeaeb02ee..b51b8450cfd 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -45,6 +45,20 @@ To avoid interfering with other worktrees, it first enables the
>  When `--cone` is provided, the `core.sparseCheckoutCone` setting is
>  also set, allowing for better performance with a limited set of
>  patterns (see 'CONE PATTERN SET' below).
> ++
> +Use the `--[no-]sparse-index` option to toggle the use of the sparse
> +index format. This reduces the size of the index to be more closely
> +aligned with your sparse-checkout definition. This can have significant
> +performance advantages for commands such as `git status` or `git add`.
> +This feature is still experimental. Some commands might be slower with
> +a sparse index until they are properly integrated with the feature.
> ++
> +**WARNING:** Using a sparse index requires modifying the index in a way
> +that is not completely understood by other tools. Enabling sparse index
> +enables the `extensions.spareseIndex` config value, which might cause

extensions.sparseIndex; you have an extra 'e' in there.

> +other tools to stop working with your repository. If you have trouble with
> +this compatibility, then run `git sparse-checkout sparse-index disable` to
> +remove this config and rewrite your index to not be sparse.
>
>  'set'::
>         Write a set of patterns to the sparse-checkout file, as given as
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index e00b82af727..ca63e2c64e9 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -14,6 +14,7 @@
>  #include "unpack-trees.h"
>  #include "wt-status.h"
>  #include "quote.h"
> +#include "sparse-index.h"
>
>  static const char *empty_base = "";
>
> @@ -283,12 +284,13 @@ static int set_config(enum sparse_checkout_mode mode)
>  }
>
>  static char const * const builtin_sparse_checkout_init_usage[] = {
> -       N_("git sparse-checkout init [--cone]"),
> +       N_("git sparse-checkout init [--cone] [--[no-]sparse-index]"),

This all makes sense, but between partial clones, sparse-checkouts and
sparse-indexes, I wonder if we're overloading users with terms and
conditions.  Perhaps that's inevitable in the short-term due to the
various caveats that exist, but I'd just like to put out a fuzzy
high-level goal of allowing users in the future to just specify "I
want a sparse clone of this stuff" with as few special knobs and flags
as possible.  I don't want them to have to specify all of the
individual things that means, such as they want (a) the history to be
sparse (i.e. partial clone), (b) the checkout to be sparse, (c) the
index to be sparse, (d) several commands to operate in a sparse
manner, limiting their output based on the sparsity paths (hopefully
they aren't required to list each one), and (e) several other commands
shouldn't be limited by the sparsity paths.  I guess it might be nice
to _allow_ them to specify all the things it means for users who want
control, but it'd be nice to avoid requiring it of all users.

>         NULL
>  };
>
>  static struct sparse_checkout_init_opts {
>         int cone_mode;
> +       int sparse_index;
>  } init_opts;
>
>  static int sparse_checkout_init(int argc, const char **argv)
> @@ -303,11 +305,15 @@ static int sparse_checkout_init(int argc, const char **argv)
>         static struct option builtin_sparse_checkout_init_options[] = {
>                 OPT_BOOL(0, "cone", &init_opts.cone_mode,
>                          N_("initialize the sparse-checkout in cone mode")),
> +               OPT_BOOL(0, "sparse-index", &init_opts.sparse_index,
> +                        N_("toggle the use of a sparse index")),
>                 OPT_END(),
>         };
>
>         repo_read_index(the_repository);
>
> +       init_opts.sparse_index = -1;
> +
>         argc = parse_options(argc, argv, NULL,
>                              builtin_sparse_checkout_init_options,
>                              builtin_sparse_checkout_init_usage, 0);
> @@ -326,6 +332,15 @@ static int sparse_checkout_init(int argc, const char **argv)
>         sparse_filename = get_sparse_checkout_filename();
>         res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
>
> +       if (init_opts.sparse_index >= 0) {
> +               if (set_sparse_index_config(the_repository, init_opts.sparse_index) < 0)
> +                       die(_("failed to modify sparse-index config"));
> +
> +               /* force an index rewrite */
> +               repo_read_index(the_repository);
> +               the_repository->index->updated_workdir = 1;
> +       }
> +
>         /* If we already have a sparse-checkout file, use it. */
>         if (res >= 0) {
>                 free(sparse_filename);
> diff --git a/sparse-index.c b/sparse-index.c
> index 71544095267..3552f88fb03 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -104,23 +104,38 @@ static int convert_to_sparse_rec(struct index_state *istate,
>
>  static int enable_sparse_index(struct repository *repo)
>  {
> -       const char *config_path = repo_git_path(repo, "config.worktree");
> +       int res;
>
>         if (upgrade_repository_format(1) < 0) {
>                 warning(_("unable to upgrade repository format to enable sparse-index"));
>                 return -1;
>         }
> -       git_config_set_in_file_gently(config_path,
> -                                     "extensions.sparseIndex",
> -                                     "true");
> +       res = git_config_set_gently("extensions.sparseindex", "true");
>
>         prepare_repo_settings(repo);
>         repo->settings.sparse_index = 1;
> -       return 0;
> +       return res;
> +}
> +
> +int set_sparse_index_config(struct repository *repo, int enable)
> +{
> +       int res;
> +
> +       if (enable)
> +               return enable_sparse_index(repo);
> +
> +       /* Don't downgrade repository format, just remove the extension. */
> +       res = git_config_set_multivar_gently("extensions.sparseindex", NULL, "",
> +                                            CONFIG_FLAGS_MULTI_REPLACE);
> +
> +       prepare_repo_settings(repo);
> +       repo->settings.sparse_index = 0;
> +       return res;
>  }
>
>  int convert_to_sparse(struct index_state *istate)
>  {
> +       int test_env;
>         if (istate->split_index || istate->sparse_index ||
>             !core_apply_sparse_checkout || !core_sparse_checkout_cone)
>                 return 0;
> @@ -129,14 +144,13 @@ int convert_to_sparse(struct index_state *istate)
>                 istate->repo = the_repository;
>
>         /*
> -        * The GIT_TEST_SPARSE_INDEX environment variable triggers the
> -        * extensions.sparseIndex config variable to be on.
> +        * If GIT_TEST_SPARSE_INDEX=1, then trigger extensions.sparseIndex
> +        * to be fully enabled. If GIT_TEST_SPARSE_INDEX=0 (set explicitly),
> +        * then purposefully disable the setting.
>          */
> -       if (git_env_bool("GIT_TEST_SPARSE_INDEX", 0)) {
> -               int err = enable_sparse_index(istate->repo);
> -               if (err < 0)
> -                       return err;
> -       }
> +       test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
> +       if (test_env >= 0)
> +               set_sparse_index_config(istate->repo, test_env);
>
>         /*
>          * Only convert to sparse if extensions.sparseIndex is set.
> diff --git a/sparse-index.h b/sparse-index.h
> index a2777dcac59..ca936e95d11 100644
> --- a/sparse-index.h
> +++ b/sparse-index.h
> @@ -5,4 +5,7 @@ struct index_state;
>  void ensure_full_index(struct index_state *istate);
>  int convert_to_sparse(struct index_state *istate);
>
> +struct repository;
> +int set_sparse_index_config(struct repository *repo, int enable);
> +
>  #endif
> \ No newline at end of file
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index a22def89e37..c6b7e8b8891 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -4,6 +4,7 @@ test_description='compare full workdir to sparse workdir'
>
>  GIT_TEST_CHECK_CACHE_TREE=0
>  GIT_TEST_SPLIT_INDEX=0
> +GIT_TEST_SPARSE_INDEX=
>
>  . ./test-lib.sh
>
> @@ -98,8 +99,9 @@ init_repos () {
>         # initialize sparse-checkout definitions
>         git -C sparse-checkout sparse-checkout init --cone &&
>         git -C sparse-checkout sparse-checkout set deep &&
> -       GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout init --cone &&
> -       GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set deep
> +       git -C sparse-index sparse-checkout init --cone --sparse-index &&
> +       test_cmp_config -C sparse-index true extensions.sparseindex &&
> +       git -C sparse-index sparse-checkout set deep
>  }
>
>  run_on_sparse () {
> @@ -109,7 +111,7 @@ run_on_sparse () {
>         ) &&
>         (
>                 cd sparse-index &&
> -               GIT_TEST_SPARSE_INDEX=1 $* >../sparse-index-out 2>../sparse-index-err
> +               $* >../sparse-index-out 2>../sparse-index-err
>         )
>  }
>
> @@ -146,7 +148,7 @@ test_expect_success 'sparse-index contents' '
>                         || return 1
>         done &&
>
> -       GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set folder1 &&
> +       git -C sparse-index sparse-checkout set folder1 &&
>
>         test-tool -C sparse-index read-cache --table --no-stat >cache &&
>         for dir in deep folder2 x
> @@ -156,7 +158,7 @@ test_expect_success 'sparse-index contents' '
>                         || return 1
>         done &&
>
> -       GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set deep/deeper1 &&
> +       git -C sparse-index sparse-checkout set deep/deeper1 &&
>
>         test-tool -C sparse-index read-cache --table --no-stat >cache &&
>         for dir in deep/deeper2 folder1 folder2 x
> @@ -377,18 +379,15 @@ test_expect_success 'clean' '
>  test_expect_success 'sparse-index is expanded and converted back' '
>         init_repos &&
>
> -       (
> -               (GIT_TEST_SPARSE_INDEX=1 && export GIT_TEST_SPARSE_INDEX) &&
> -               GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> -                       git -C sparse-index -c core.fsmonitor="" reset --hard &&
> -               test_region index convert_to_sparse trace2.txt &&
> -               test_region index ensure_full_index trace2.txt &&
> -
> -               rm trace2.txt &&
> -               GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> -                       git -C sparse-index -c core.fsmonitor="" status -uno &&
> -               test_region index ensure_full_index trace2.txt
> -       )
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git -C sparse-index -c core.fsmonitor="" reset --hard &&
> +       test_region index convert_to_sparse trace2.txt &&
> +       test_region index ensure_full_index trace2.txt &&
> +
> +       rm trace2.txt &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git -C sparse-index -c core.fsmonitor="" status -uno &&
> +       test_region index ensure_full_index trace2.txt
>  '
>
>  test_done
> --
> gitgitgadget

I need to take a break from reviewing again at this point and work on
some other tasks.  I'll resume reviewing the series later, perhaps
tomorrow afternoon.
