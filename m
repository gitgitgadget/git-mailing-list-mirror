Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBECBC433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 05:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKAFS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 01:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAFSv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 01:18:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F3140ED
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 22:18:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u11so19408342ljk.6
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 22:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vrJ2C51JvssqyXAFhghWQ2tNQNRUTSl8KT5Y9TqiN9E=;
        b=qfqy8mR+hbLAEBPm8/qhXjmeEBJGHCrGwGilBbhBEzkMgJj4Ackq2hnbizQNXMkO2a
         v4NnbFurUzNc4nswOyh3Ze6RS2kqvCfGEYHui58hh5wGKyeqnGd+d1CijKlsxPtCNL7W
         BTvvur9pqcdrfFR//QJPOlHAtrTEVSwjJPi1KG15TnwGCnp5p2F3vfiFMeeJi9h6W8rH
         4XK0uJi+iLJGJmGmjNVcUYz2W38iOaGEAF2/4a6UxIASaqZ3O6eKGWmfWQmo9/5rH7Bl
         GeMlo9b3azhDHtfNLf8/uAmtSzf54uhyjjjFjQxZUxbt0rX5gPoFHM/FnKBEo4i/pSf8
         lt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrJ2C51JvssqyXAFhghWQ2tNQNRUTSl8KT5Y9TqiN9E=;
        b=zlA99HZuq9iH4nxmCQDr+sAHM1bem7CbPsUksMqMh7FPT0GnDcYkXRZFFm3cBcRf9O
         v4MMilqvRCGXd+MhalY+ywFseh1lH+U1MtG6XhADq2fl8X+WqN9lc2RMRI7MiW6i+kXb
         RbU3mY7oEf5raLg/jYep8mR6okkQiX3rqyN35XZYcNiRpR5b9VxuLybzeGUMrGv2uEK7
         YUpnonWbePjbNiK9iwoUKX8d8aBcpFImbT3RMdGE09Aefdyb+XOvJD2SpqqEsFI/ea6W
         wCIUexlau40z2Xn44PhF3qy40gGATL6HDkT7V3ce0Wq2iEYD6PVtcyMrN5a2rsC3jCnn
         iKgg==
X-Gm-Message-State: ACrzQf0llM5kJWb+Ksr5U0tGXUxcwN19hw0H0vT9IYdOEiidmM6LJm71
        JMdQjpqD8I4+1jq/dx+XVLreWJa3WFVXbyZ6pjk=
X-Google-Smtp-Source: AMsMyM5Hc/+tIzssTNOOEd4AxvBZ49tMIaHN2XWAOIIyWSaJ7fPnTGzCo15Ixc2H9Oxti8IHZzzUbMgAe2oRpkBpkWs=
X-Received: by 2002:a2e:9e01:0:b0:277:611:c26e with SMTP id
 e1-20020a2e9e01000000b002770611c26emr7124319ljk.167.1667279927446; Mon, 31
 Oct 2022 22:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1398.git.1667189512579.gitgitgadget@gmail.com>
In-Reply-To: <pull.1398.git.1667189512579.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 31 Oct 2022 22:18:00 -0700
Message-ID: <CABPp-BGUXKk-LSJtHP2jSDSVYNpQgzOeferx6xJ36ntDgrBNCw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] diff: introduce scope option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Oct 30, 2022 at 9:11 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> When we use sparse-checkout, we often want the set of files
> that some commands operate on to be restricted to the
> sparse-checkout specification.

It seems a bit premature to send this, when the guideline document[*]
detailing how these options should work is still in the "Needs Review"
state.  I know, it's been waiting for a while, but it's a _long_
document.

[*] https://lore.kernel.org/git/pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com/

> So introduce the `--scope` option to git diff, which have two
> value: "sparse" and "all". "sparse" mean that diff is performed
> restrict to paths which matching sparse-checkout specification,
> "all" mean that diff is performed regardless of whether the path
> meets the sparse-checkout specification.

The wording probably needs some care to reflect the fact that it only
affects cases where either --cached or revisions are passed.  In
particular, your wording for "all" suggests behavior very different
from today, whereas "all" is probably best thought of as today's
current behavior.  For example, a plain `git diff` without --cached or
revisions, should be unaffected by either of these flags.

> `--no-scope` is the default
> option for now.

What does --no-scope even mean?  You didn't explain it, and I don't
see how it could make sense.  We explicitly avoided a `--no-` prefix
by allowing the --scope option to take a value.  I don't think there
should be a --no-scope option.

> Add `diff.scope={sparse, all}` config, which can also have the same
> capabilities as `--scope`, and it will be covered by `--scope` option.

This is not what we want.  The high level usecases should not need to
be configured per-command.  There should be a config option which
reflects the high level use cases (e.g. sparse.scope) and then all
relevant commands (diff, log, grep, etc.) can key off it.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [RFC] diff: introduce scope option
>
>     In [1], we discovered that users working on different sparse-checkout
>     specification may download unnecessary blobs from each other's
>     specification in collaboration. In [2] Junio suggested that maybe we can
>     restrict some git command's filespec in sparse-checkout specification to
>     elegantly solve this problem above. In [3]: Newren and Derrick Stolee
>     prefer to name the option --scope={sparse, all}.
>
>     So this patch is attempt to do this thing on git diff:
>
>     v1:
>
>      1. add --restrict option to git diff, which restrict diff filespec in
>         sparse-checkout specification. [4] v2.
>      2. rename --restrict to --scope={sparse, all}, support --no-scope.
>      3. add config: diff.scope={sparse,all}.
>
>     Unresolved work:
>
>      1. how to properly pass this --scope={sparse, all} to other commands
>         like git log, git format-patch, etc.

log & grep should accept a similar flag.  format-patch should not, and
should ignore any config in this area.

>      2. how to set the default value of scope for different diff commands.

I don't understand this.

>     [1]:
>     https://lore.kernel.org/git/CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com/
>     [2]: https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/ [3]:
>     https://lore.kernel.org/git/07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com/
>     [4]:
>     https://lore.kernel.org/git/pull.1368.git.1664036052741.gitgitgadget@gmail.com/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1398%2Fadlternative%2Fzh%2Fdiff-scope-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1398/adlternative/zh/diff-scope-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1398
>
>  Documentation/config/diff.txt         |  12 +
>  Documentation/diff-options.txt        |  18 +
>  builtin/diff.c                        |   4 +
>  diff-lib.c                            |  36 +-
>  diff-no-index.c                       |   4 +
>  diff.c                                |  39 +++
>  diff.h                                |  11 +
>  t/t4070-diff-sparse-checkout-scope.sh | 469 ++++++++++++++++++++++++++
>  tree-diff.c                           |   5 +
>  9 files changed, 597 insertions(+), 1 deletion(-)
>  create mode 100644 t/t4070-diff-sparse-checkout-scope.sh
>
> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
> index 35a7bf86d77..52707e1b2d6 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -201,6 +201,18 @@ diff.algorithm::
>  --
>  +
>
> +diff.scope::
> +       Choose diff scope. The variants are as follows:
> ++
> +--
> +`sparse`;;
> +       Restrict diff paths to those matching sparse-checkout specification.
> +`all`;;
> +       Without restriction, diff is performed regardless of whether the path
> +       meets the sparse-checkout specification.

As noted above, this is the wrong level to specify things.  The
description for "all" is misleading as well and suggests something
other than "behavior B" from the direction document.

>  diff.wsErrorHighlight::
>         Highlight whitespace errors in the `context`, `old` or `new`
>         lines of the diff.  Multiple values are separated by comma,
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 3674ac48e92..04bf83e8be1 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -195,6 +195,24 @@ For instance, if you configured the `diff.algorithm` variable to a
>  non-default value and want to use the default one, then you
>  have to use `--diff-algorithm=default` option.
>
> +ifndef::git-format-patch[]
> +ifndef::git-log[]
> +
> +--scope={sparse|all}::
> +       Choose diff scope. The variants are as follows:
> ++
> +--
> +`--sparse`;;
> +       Restrict diff paths to those matching sparse-checkout specification.
> +`--all`;;
> +       Without restriction, diff is performed regardless of whether the path
> +       meets the sparse-checkout specification.
> +--
> ++
> +
> +endif::git-log[]
> +endif::git-format-patch[]

What about diff-files, diff-index, diff-tree, and show?

> +
>  --stat[=<width>[,<name-width>[,<count>]]]::
>         Generate a diffstat. By default, as much space as necessary
>         will be used for the filename part, and the rest for the graph
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 854d2c5a5c4..6b450f7184c 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -54,6 +54,10 @@ static void stuff_change(struct diff_options *opt,
>             oideq(old_oid, new_oid) && (old_mode == new_mode))
>                 return;
>
> +       if (opt->scope == DIFF_SCOPE_SPARSE &&
> +           !diff_paths_in_sparse_checkout(old_path, new_path))
> +               return;

This can't be right.
   git diff c231e0f26fe9b2ea9ec46aa68ff95ba984ce592e
72d42bd856228c15f702fa3c353432f4f1defe03
(to directly diff two known blobs) will go through this function, with
old_path == c231e0f26fe9b2ea9ec46aa68ff95ba984ce592e and new_path ==
72d42bd856228c15f702fa3c353432f4f1defe03.  But those aren't real
paths, and sparse-checkout should not restrict what is shown in those
cases.

> +
>         if (opt->flags.reverse_diff) {
>                 SWAP(old_mode, new_mode);
>                 SWAP(old_oid, new_oid);
> diff --git a/diff-lib.c b/diff-lib.c
> index 2edea41a234..a3381f2e0ff 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -88,6 +88,22 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
>         return changed;
>  }
>
> +int diff_path_in_sparse_checkout(const char *path) {
> +       if (core_sparse_checkout_cone)
> +               return path_in_cone_mode_sparse_checkout(path, the_repository->index);
> +       else
> +               return path_in_sparse_checkout(path, the_repository->index);
> +}

This says we are including the path if it matches the sparsity
patterns.  Thus, we have to be careful when we use this function,
because the relevant paths are ones that match the sparsity
specification.  The sparsity specification will always match the
sparsity patterns when diffing two commits, but when either the index
or the working tree is part of the diff, the sparsity specification
*might* be temporarily expanded.

> +int diff_paths_in_sparse_checkout(const char *one, const char*two) {
> +       if (one == two || !strcmp(one, two))
> +               return diff_path_in_sparse_checkout(one);
> +       else
> +               return diff_path_in_sparse_checkout(one) &&
> +                      diff_path_in_sparse_checkout(two);

Why && rather than || ?

> +}
> +
> +
>  int run_diff_files(struct rev_info *revs, unsigned int option)
>  {
>         int entries, i;
> @@ -113,6 +129,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>
>                 if (diff_can_quit_early(&revs->diffopt))
>                         break;
> +               if (revs->diffopt.scope == DIFF_SCOPE_SPARSE &&
> +                   !diff_path_in_sparse_checkout(ce->name))
> +                       continue;

Here you've cut off the possibility of showing diffs for anything
outside the sparsity patterns, which is a mistake.  We need to handle
a temporarily expanded sparse specification too.

>                 if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
>                         continue;
> @@ -202,7 +221,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>                                 continue;
>                 }
>
> -               if (ce_uptodate(ce) || ce_skip_worktree(ce))
> +               if (ce_uptodate(ce) ||
> +                   (revs->diffopt.scope != DIFF_SCOPE_ALL && ce_skip_worktree(ce)))
>                         continue;

Here you make --scope=all show files even if they are skip-worktree,
making them appear to have been deleted.  I called out your
description earlier as potentially misleading, because it could imply
this behavior.  It looks like you were consistent with the description
and implementation, it just doesn't match what we want.

>                 /*
> @@ -439,6 +459,20 @@ static void do_oneway_diff(struct unpack_trees_options *o,

do_oneway_diff is for cases where we are diffing against the index...

>                         return; /* nothing to diff.. */
>         }
>
> +       if (revs->diffopt.scope == DIFF_SCOPE_SPARSE) {
> +               if (idx && tree) {
> +                       if (!diff_paths_in_sparse_checkout(idx->name, tree->name))
> +                               return;
> +               } else if (idx) {
> +                       if (!diff_path_in_sparse_checkout(idx->name))
> +                               return;
> +               } else if (tree) {
> +                       if (!diff_path_in_sparse_checkout(tree->name))
> +                               return;
> +               } else
> +                       return;
> +       }

...and you again mistakenly only compare to the sparsity patterns
instead of the sparse specification.

> +
>         /* if the entry is not checked out, don't examine work tree */
>         cached = o->index_only ||
>                 (idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));



> diff --git a/diff-no-index.c b/diff-no-index.c
> index 18edbdf4b59..ea94a104ea4 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -281,6 +281,10 @@ int diff_no_index(struct rev_info *revs,
>
>         fixup_paths(paths, &replacement);
>
> +       if (revs->diffopt.scope == DIFF_SCOPE_SPARSE &&
> +           !diff_paths_in_sparse_checkout(paths[0], paths[1]))
> +               goto out;

--no-index means we're diffing two files that are not tracked, or at
least treating them as not tracked.  sparse-checkout should not affect
such files.

> +
>         revs->diffopt.skip_stat_unmatch = 1;
>         if (!revs->diffopt.output_format)
>                 revs->diffopt.output_format = DIFF_FORMAT_PATCH;
> diff --git a/diff.c b/diff.c
> index 285d6e2d575..9de4044ae05 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -48,6 +48,7 @@ static int diff_interhunk_context_default;
>  static const char *diff_word_regex_cfg;
>  static const char *external_diff_cmd_cfg;
>  static const char *diff_order_file_cfg;
> +static const char *external_diff_scope_cfg;
>  int diff_auto_refresh_index = 1;
>  static int diff_mnemonic_prefix;
>  static int diff_no_prefix;
> @@ -57,6 +58,7 @@ static int diff_dirstat_permille_default = 30;
>  static struct diff_options default_diff_options;
>  static long diff_algorithm;
>  static unsigned ws_error_highlight_default = WSEH_NEW;
> +static enum diff_scope external_diff_scope;

Why is this called "external"?

>  static char diff_colors[][COLOR_MAXLEN] = {
>         GIT_COLOR_RESET,
> @@ -423,6 +425,16 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>                 return 0;
>         }
>
> +       if (!strcmp(var, "diff.scope")) {
> +               git_config_string(&external_diff_scope_cfg, var, value);
> +               if (!strcmp(value, "all"))
> +                       external_diff_scope = DIFF_SCOPE_ALL;
> +               else if (!strcmp(value, "sparse"))
> +                       external_diff_scope = DIFF_SCOPE_SPARSE;
> +               else
> +                       return -1;
> +       }
> +
>         if (git_color_config(var, value, cb) < 0)
>                 return -1;
>
> @@ -4663,6 +4675,7 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
>
>         options->color_moved = diff_color_moved_default;
>         options->color_moved_ws_handling = diff_color_moved_ws_default;
> +       options->scope = external_diff_scope;
>
>         prep_parse_options(options);
>  }
> @@ -4914,6 +4927,29 @@ static int parse_dirstat_opt(struct diff_options *options, const char *params)
>         return 1;
>  }
>
> +static int diff_opt_diff_scope(const struct option *option,
> +                               const char *optarg, int unset)
> +{
> +       struct diff_options *opt = option->value;
> +
> +       if (unset) {
> +               opt->scope = DIFF_SCOPE_NONE;

I think we should instead have a
    BUG_ON_OPT_NEG(unset)
or, even better, a
    BUG_ON_OPT_NEG_NOARG(unset, optarg)
at the beginning of this function...

> +       } else if (optarg) {

...which would also allow you to drop this if and dedent the rest of
the function.

> +               if (!strcmp(optarg, "all")) {
> +                       if (core_apply_sparse_checkout) {
> +                               opt->scope = DIFF_SCOPE_ALL;
> +                       }
> +               } else if (!strcmp(optarg, "sparse")) {
> +                       if (core_apply_sparse_checkout) {
> +                               opt->scope = DIFF_SCOPE_SPARSE;
> +                       }

If core_apply_sparse_checkout is false, should we perhaps throw an
error instead of just silently ignoring the option the user passed?

> +               } else
> +                       return error(_("invalid --scope value: %s"), optarg);
> +       }

As written with no follow-on else clause here, wouldn't this silently
accept "--scope" without an "=<something>" argument without an error
and without properly initializing opt->scope?

> +
> +       return 0;
> +}
> +
>  static int diff_opt_diff_filter(const struct option *option,
>                                 const char *optarg, int unset)
>  {
> @@ -5683,6 +5719,9 @@ static void prep_parse_options(struct diff_options *options)
>                 OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
>                                N_("select files by diff type"),
>                                PARSE_OPT_NONEG, diff_opt_diff_filter),
> +               OPT_CALLBACK_F(0, "scope", options, N_("[sparse|all]"),
> +                              N_("choose diff scope"),

maybe "choose diff scope in sparse checkouts"?

> +                              PARSE_OPT_OPTARG, diff_opt_diff_scope),
>                 { OPTION_CALLBACK, 0, "output", options, N_("<file>"),
>                   N_("output to a specific file"),
>                   PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
> diff --git a/diff.h b/diff.h
> index 8ae18e5ab1e..90f7512034c 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -230,6 +230,12 @@ enum diff_submodule_format {
>         DIFF_SUBMODULE_INLINE_DIFF
>  };
>
> +enum diff_scope {
> +       DIFF_SCOPE_NONE = 0,
> +       DIFF_SCOPE_ALL,
> +       DIFF_SCOPE_SPARSE,
> +};
> +
>  /**
>   * the set of options the calling program wants to affect the operation of
>   * diffcore library with.
> @@ -285,6 +291,9 @@ struct diff_options {
>         /* diff-filter bits */
>         unsigned int filter, filter_not;
>
> +       /* diff sparse-checkout scope */
> +       enum diff_scope scope;
> +
>         int use_color;
>
>         /* Number of context lines to generate in patch output. */
> @@ -696,4 +705,6 @@ void print_stat_summary(FILE *fp, int files,
>                         int insertions, int deletions);
>  void setup_diff_pager(struct diff_options *);
>
> +int diff_path_in_sparse_checkout(const char *path);
> +int diff_paths_in_sparse_checkout(const char *one, const char *two);
>  #endif /* DIFF_H */
> diff --git a/t/t4070-diff-sparse-checkout-scope.sh b/t/t4070-diff-sparse-checkout-scope.sh
> new file mode 100644

This needs to be fixed.

> index 00000000000..dca75a3308b
> --- /dev/null
> +++ b/t/t4070-diff-sparse-checkout-scope.sh
> @@ -0,0 +1,469 @@
> +#!/bin/sh
> +
> +test_description='diff sparse-checkout scope'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +
> +test_expect_success 'setup' '
> +       git init temp &&
> +       (
> +               cd temp &&
> +               mkdir sub1 &&
> +               mkdir sub2 &&
> +               echo sub1/file1 >sub1/file1 &&
> +               echo sub2/file2 >sub2/file2 &&
> +               echo file1 >file1 &&
> +               echo file2 >file2 &&
> +               git add --all &&
> +               git commit -m init &&
> +               echo sub1/file1 >>sub1/file1 &&
> +               echo sub1/file2 >>sub1/file2 &&
> +               echo sub2/file1 >>sub2/file1 &&
> +               echo sub2/file2 >>sub2/file2 &&
> +               echo file1 >>file1 &&
> +               echo file2 >>file2 &&
> +               git add --all &&
> +               git commit -m change1 &&
> +               echo sub1/file1 >>sub1/file1 &&
> +               echo sub1/file2 >>sub1/file2 &&
> +               echo sub2/file1 >>sub2/file1 &&
> +               echo sub2/file2 >>sub2/file2 &&
> +               echo file1 >>file1 &&
> +               echo file2 >>file2 &&
> +               git add --all &&
> +               git commit -m change2
> +       )
> +'
> +
> +reset_repo () {
> +       rm -rf repo &&
> +       git clone --no-checkout temp repo

Why --no-checkout rather than say --sparse?

> +}
> +
> +reset_with_sparse_checkout() {
> +       reset_repo &&
> +       git -C repo sparse-checkout set $1 sub1 &&
> +       git -C repo checkout

Fixing the above would let us get rid of this really weird extra
checkout command too.

> +}
> +
> +change_worktree_and_index() {
> +       (
> +               cd repo &&
> +               mkdir sub2 sub3 &&
> +               echo sub1/file3 >sub1/file3 &&
> +               echo sub2/file3 >sub2/file3 &&
> +               echo sub3/file3 >sub3/file3 &&
> +               echo file3 >file3 &&
> +               git add --all --sparse &&
> +               echo sub1/file3 >>sub1/file3 &&
> +               echo sub2/file3 >>sub2/file3 &&
> +               echo sub3/file3 >>sub3/file3 &&
> +               echo file3 >>file3
> +       )
> +}

It would be nice to modify different paths in the working tree and
index, to see if we can handle cases where the sparse specification
does not match the sparsity patterns better.  (So, modify files inside
and outside the sparsity patterns, stage those changes, and then do a
`git sparse-checkout reapply` to make the files outside the sparsity
patterns disappear from the working tree...then modify different files
in the working tree both inside and outside the sparsity patterns.
And also remove some file that matches the sparsity patterns and
manually mark it as SKIP_WORKTREE.)  That'd give us much better
coverage.

> +
> +diff_scope() {
> +       title=$1
> +       need_change_worktree_and_index=$2
> +       sparse_checkout_option=$3
> +       scope_option=$4
> +       expect=$5
> +       shift 5
> +       args=("$@")
> +
> +       test_expect_success "$title $sparse_checkout_option $scope_option" "
> +               reset_with_sparse_checkout $sparse_checkout_option &&
> +               if test \"$need_change_worktree_and_index\" = \"true\" ; then
> +                       change_worktree_and_index
> +               fi &&
> +               git -C repo diff $scope_option ${args[*]} >actual &&
> +               if test -z \"$expect\" ; then
> +                       >expect
> +               else
> +                       cat > expect <<-EOF
> +$expect
> +                       EOF
> +               fi &&
> +               test_cmp expect actual
> +       "
> +}
> +
> +args=("--name-only" "HEAD" "HEAD~")
> +diff_scope builtin_diff_tree false "--no-cone" "--scope=sparse" \
> +"sub1/file1
> +sub1/file2" "${args[@]}"
> +
> +diff_scope builtin_diff_tree false "--no-cone" "--scope=all" \
> +"file1
> +file2
> +sub1/file1
> +sub1/file2
> +sub2/file1
> +sub2/file2" "${args[@]}"
> +
> +diff_scope builtin_diff_tree false "--no-cone" "--no-scope" \
> +"file1
> +file2
> +sub1/file1
> +sub1/file2
> +sub2/file1
> +sub2/file2" "${args[@]}"
> +
> +diff_scope builtin_diff_tree false "--cone" "--scope=sparse" \
> +"file1
> +file2
> +sub1/file1
> +sub1/file2" "${args[@]}"
> +
> +diff_scope builtin_diff_tree false "--cone" "--scope=all" \
> +"file1
> +file2
> +sub1/file1
> +sub1/file2
> +sub2/file1
> +sub2/file2" "${args[@]}"
> +
> +diff_scope builtin_diff_tree false "--cone" "--no-scope" \
> +"file1
> +file2
> +sub1/file1
> +sub1/file2
> +sub2/file1
> +sub2/file2" "${args[@]}"
> +
> +args=("--name-only" "HEAD~")
> +diff_scope builtin_diff_index true "--no-cone" "--scope=sparse" \
> +"sub1/file1
> +sub1/file2
> +sub1/file3" "${args[@]}"

Here's a good example where the testcase is doing the wrong thing.
The expected answer here would also include file3, sub2/file3, and
sub3/file3.

> +
> +diff_scope builtin_diff_index true "--no-cone" "--scope=all" \
> +"file1
> +file2
> +file3
> +sub1/file1
> +sub1/file2
> +sub1/file3
> +sub2/file1
> +sub2/file2
> +sub2/file3
> +sub3/file3" "${args[@]}"
> +
> +diff_scope builtin_diff_index true "--no-cone" "--no-scope" \
> +"file1
> +file2
> +file3
> +sub1/file1
> +sub1/file2
> +sub1/file3
> +sub2/file1
> +sub2/file2
> +sub2/file3
> +sub3/file3" "${args[@]}"
> +
> +diff_scope builtin_diff_index true "--cone" "--scope=sparse" \
> +"file1
> +file2
> +file3
> +sub1/file1
> +sub1/file2
> +sub1/file3" "${args[@]}"

This is also wrong; it's missing sub2/file3 and sub3/file3.

> +
> +diff_scope builtin_diff_index true "--cone" "--scope=all" \
> +"file1
> +file2
> +file3
> +sub1/file1
> +sub1/file2
> +sub1/file3
> +sub2/file1
> +sub2/file2
> +sub2/file3
> +sub3/file3" "${args[@]}"
> +
> +diff_scope builtin_diff_index true "--cone" "--no-scope" \
> +"file1
> +file2
> +file3
> +sub1/file1
> +sub1/file2
> +sub1/file3
> +sub2/file1
> +sub2/file2
> +sub2/file3
> +sub3/file3" "${args[@]}"
> +
> +args=("--name-only" "file3" "sub1/" "sub2/")
> +
> +diff_scope builtin_diff_files true "--no-cone" "--scope=sparse" \
> +"sub1/file3" "${args[@]}"

This should also include file3, sub2/file3, and sub3/file3.
`--scope=` should not affect diff output at all if neither --cached
nor revision arguments are supplied.

> +
> +diff_scope builtin_diff_files true "--no-cone" "--scope=all" \
> +"file3
> +sub1/file3
> +sub2/file1
> +sub2/file2
> +sub2/file3" "${args[@]}"

This is wrong due to including too much; it should not include
sub2/file1 or sub2/file2 (it is only including those because it is
showing them as deleted, when they are not deleted but are
SKIP_WORKTREE).

I think I'm going to stop reviewing here.  I'm probably just going to
keep repeating the same issues I identified earlier if I continue.
