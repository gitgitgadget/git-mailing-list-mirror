Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F1C32771
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 21:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiIXVcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 17:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIXVcw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 17:32:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585474A839
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 14:32:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k10so5365558lfm.4
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ht+BYmUgL7R3fNVT1VgOhjnfEY/pXcdnKXxh1H2RaCw=;
        b=iIGnIsC3FHOvxctW225nY/norZrRia/kBFgqj0OACMXJvTquD34VABy6/EOcHkyyiV
         1/CfxK+FBkGkr27EKejMPNuaViCfpniRc/9MjwbHUSarlicP/e8KTEDQTTgWyaYy3Nca
         Kp7QZj64KE7a/2hmnWVAlG/VuGsPt74kdmXQKFXYvNcKUNFmDkbf2tNRmU8tCQtfT/ou
         2GpmgX5Hd2M4hNqz23x1vUjqM4kuqxxLoDMpx/lO8XzTgzxrdIbplYIXIILDOBvex5WB
         R73XPT8b1qsUh/44eK6EVGL2qIlqJmtCM+tIYo5iptNacEBY9V5YyV5Rjwhf2WQDj7+Q
         odSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ht+BYmUgL7R3fNVT1VgOhjnfEY/pXcdnKXxh1H2RaCw=;
        b=u2lNovXganJ9AzXs599ySoY6pD4LdTfXim2eyPcSUr2YqNVyIViqBg81OUzOPZwmLp
         0gKQBpTcZHdgLvBqI2c+GmVJoXUkHL/IXSdB+HeYQhAb6Agb9acWnapXdoMjVgRIyhyS
         RyFh1kNBiPRtUjAi/NbhMyLQiyx4inUDbHRIGmGAVmRXAjtXSDbeDN2/374uBtFIq99M
         tzXvImo59RAEyMPfHxhMWHi3EDk/QtN08v4hrwFmg89llmRCoIX6p4lQHqkGS4uE8Se7
         IWg/NgUC8bqWB8rigvAF/HkehpO1ttynYbKUONW3cICxBbEdMXVTpvaPI6buf7Nm23Lf
         Xkhw==
X-Gm-Message-State: ACrzQf21GlDLNR73G50EozSs6OwzcIWkaxgBoOGMgEPqvEG/Z4siWtIk
        6wvJ0lHr0LUXHpyQJEbXpkGxV3ScwVD6KvP69JY=
X-Google-Smtp-Source: AMsMyM76KoolgnWLQh+NTeOuaQt/QQEtdyaNDSjAXPyVtO8yqiLI7HYZmfSTSHyETn1uoLBNySc6McDvnvWYVMIxVVE=
X-Received: by 2002:a05:6512:3486:b0:49e:bc93:2f75 with SMTP id
 v6-20020a056512348600b0049ebc932f75mr6482810lfr.238.1664055168381; Sat, 24
 Sep 2022 14:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1368.git.1664036052741.gitgitgadget@gmail.com>
In-Reply-To: <pull.1368.git.1664036052741.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 24 Sep 2022 14:32:36 -0700
Message-ID: <CABPp-BE_VUd=kjMb=T0WDvj=kn8fgN92-DtS3HdX+cZPjmhS_w@mail.gmail.com>
Subject: Re: [PATCH] diff: introduce --restrict option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing,

Thanks for working on this!  I've long wanted these options for a few
commands, but just hadn't gotten back to it, in part because of
several lingering questions we never resolved.

I'm adding Matheus and Shaoxuan to cc, who both have had similar
patches (for grep) derailed because we never agreed on option names
and flags and defaults and whatnot.  (I'll post a big RFC I've been
working on this week later today so we can discuss that, but thought
Matheus and Shaoxuan should see this patch too.)

On Sat, Sep 24, 2022 at 9:14 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> When we use sparse-checkout, we often want the set of files
> that some commands operate on to be restricted to the
> sparse-checkout cone(s).

There are also non-cone users of sparse-checkout, so perhaps "cone(s)"
=> "specification"?

> So introduce the `--restrict` option to git diff, which can
> restrict diff filespec to the sparse-checkout cone(s).

"can"?  Is there times when it doesn't?

"diff filespec" might be okay, but I'd personally prefer talking about
the "diff output".

And again, there are `--no-cone` users of sparse checkouts so we need
to avoid "cone(s)" here.

Perhaps something like:

    To allow this, introduce a `--restrict` option to git diff, which
restricts the diff output to those files matching the sparsity
specification.

?

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     diff: introduce --restrict option
>
>     In [1], we discovered that users working on different sparse-checkout
>     cone(s) may download unnecessary blobs from each other's cone(s) in
>     collaboration. And in [2] Junio suggested that maybe we can restrict
>     some git command's filespec in sparse-checkout cone(s) to elegantly
>     solve this problem above.

But this doesn't solve that problem, because there's no way to get
pull to notify merge to pass this extra option to diff...right?  I
mean it's a step in that direction because you've added the new
capability, but you'd also need to add a config option which would
turn this option on by default, and suggest to partial clone +
sparse-checkout users that they set that config option.  Of course, if
we do that, we'd also need a `--no-restrict` option to git-diff to
override such a config option.

And if we add a config option, we may want to start the output with a
warning about the output being restricted.

>     So this patch is attempt to do this thing on git diff:
>
>     v1:
>
>      1. add --restrict option to git diff, which restrict diff filespec in
>         sparse-checkout cone(s).
>
>     [1]:
>     https://lore.kernel.org/git/CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com/
>     [2]: https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1368%2Fadlternative%2Fzh%2Fdiff-restrict-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1368/adlternative/zh/diff-restrict-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1368
>
>  Documentation/diff-options.txt           |  4 ++
>  diff.c                                   | 57 ++++++++++++++++++++++++
>  diff.h                                   |  1 +
>  t/t1092-sparse-checkout-compatibility.sh | 30 +++++++++++++
>  4 files changed, 92 insertions(+)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 3674ac48e92..8ee5b6b4603 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt

Note that diff-options.txt is included by not only git-diff.txt, but
also git-log.txt, git-show.txt, git-format-patch.txt, and a few
others.  It appears your changes are specific to git-diff, though.  I
think it'd be nice if they more generally applied to git-log.txt and
git-show.txt, but we'd have to be careful since they definitely should
not apply to git-format-patch.txt.

> @@ -631,6 +631,10 @@ Also, these upper-case letters can be downcased to exclude.  E.g.
>  Note that not all diffs can feature all types. For instance, copied and
>  renamed entries cannot appear if detection for those types is disabled.
>
> +--restrict::
> +       Restrict the diff filespec in the sparse-checkout cone(s).
> +       See linkgit:git-sparse-checkout[1] for more details.
> +

It would be nice to also provide a --no-restrict at the same time,
especially if we even think we might want to make --restrict the
default in the future[1] or if we want to add config option now or
soon to treat --restrict as the default when that config option is
set[2].

We need to get the name nailed down too.  I'm slightly leaning towards
the name you have used here, but we should note that we currently have
other commands using --sparse (which confusingly maps to
--no-restrict), some using --ignore-skip-worktree-bits (also as an
equivalent for --no-restrict), we have had people propose patches
using --ignore-sparsity (again as an equivalent for --no-restrict),
and we've seen a few other suggestions for names like
--full-tree/--sparse-tree, --dense, and maybe others.

There's another question surrounding the option name too -- whether
these options should be global for git (like --work-tree), or command
specific.  That is a bit muddled by the fact that different
subcommands should have different defaults (checkout definitely should
default to `--restrict` or else sparse checkouts would be essentially
worthless, but stash and apply need to default to `--no-restrict` or
we'll drop some of the user's changes.  And it gets worse because we
also have two variants of not-quite-restrict-but-close for different
command classes, and not by accident.).  It may also be affected by
the fact that we'd only want to control a subset of commands with a
config option (namely, the querying commands (log, diff against
history, grep against history, etc.) and perhaps the path-modifying
commands (add/rm/mv)), whereas the rest (like checkout or apply) we
would only want to allow control with an explicit command line flag
added by the user.

I'm slightly leaning towards command-specific, using --[no-]restrict,
and defaulting diff for now to --no-restrict...but we really should
get buy-in on all of this.  I've been working on a big RFC patch
creating a Documentation/technical/sparse-checkout.txt file so we can
hammer down these questions.

Sorry if that feels like it's derailing you.  It also derailed
Matheus' changes to grep that he worked on for nearly a year from
2020-2021[3], and derailed Shaoxuan's similar changes to grep just
recently[4], so I'm aware it's a big problem.  Hopefully the RFC will
let us resolve the questions and unblock these kinds of patches.

[1] https://lore.kernel.org/git/xmqqh719pcoo.fsf@gitster.g/
[2] https://lore.kernel.org/git/a86af661-cf58-a4e5-0214-a67d3a794d7e@github.com/
[3] https://lore.kernel.org/git/5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br/
-- see his comment section in particular
[4] https://lore.kernel.org/git/20220923041842.27817-1-shaoxuan.yuan02@gmail.com/

>  -S<string>::
>         Look for differences that change the number of occurrences of
>         the specified string (i.e. addition/deletion) in a file.
> diff --git a/diff.c b/diff.c
> index 648f6717a55..95e13607041 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4923,6 +4923,19 @@ static int diff_opt_diff_filter(const struct option *option,
>         return 0;
>  }
>
> +static int diff_opt_diff_restrict(const struct option *option,
> +                               const char *optarg, int unset)
> +{
> +       struct diff_options *opt = option->value;
> +
> +       BUG_ON_OPT_NEG(unset);
> +       CALLOC_ARRAY(opt->sparse_checkout_patterns, 1);
> +
> +       if (get_sparse_checkout_patterns(opt->sparse_checkout_patterns) < 0)
> +               FREE_AND_NULL(opt->sparse_checkout_patterns);
> +       return 0;

Should this be protected by "if (core_apply_sparse_checkout)"?
Digging into get_sparse_checkout_patterns(), it appears it will throw
a warning if ${GIT_DIR}/info/sparse-checkout doesn't exist, which
would be annoying for non-sparse-checkout users.

> +}
> +
>  static void enable_patch_output(int *fmt)
>  {
>         *fmt &= ~DIFF_FORMAT_NO_OUTPUT;
> @@ -5660,6 +5673,9 @@ static void prep_parse_options(struct diff_options *options)
>                 OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
>                                N_("select files by diff type"),
>                                PARSE_OPT_NONEG, diff_opt_diff_filter),
> +               OPT_CALLBACK_F(0, "restrict", options, NULL,
> +                              N_("restrict files in sparse-checkout patterns"),

I'd suggest at least replacing "in" with "to".  I'd also like to avoid
the word "patterns" since it hints at non-cone mode (in cone mode,
users specify directories, not patterns, even if patterns exist behind
the scenes).  Maybe we could change the phrase to something like
"restrict paths to those matching sparse-checkout specification" would
be better?

> +                              PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_diff_restrict),
>                 { OPTION_CALLBACK, 0, "output", options, N_("<file>"),
>                   N_("output to a specific file"),
>                   PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
> @@ -6601,6 +6617,24 @@ free_queue:
>         }
>  }
>
> +
> +static int match_sparse_checkout_patterns_by_spec(const struct diff_options *options, struct diff_filespec *spec) {
> +       int dtype = DT_REG;
> +
> +       if (!spec)
> +               return 0;
> +
> +       return path_matches_pattern_list(spec->path, strlen(spec->path),
> +                                        "", &dtype, options->sparse_checkout_patterns,
> +                                        the_repository->index) > 0;
> +}
> +
> +static int match_sparse_checkout_patterns(const struct diff_options *options, const struct diff_filepair *p)
> +{
> +       return match_sparse_checkout_patterns_by_spec(options, p->one) ||
> +              match_sparse_checkout_patterns_by_spec(options, p->two);

Most of the time, p->one will match p->two.  Do we want to optimize
that case to not make both of these calls but just one?

> +}
> +
>  static int match_filter(const struct diff_options *options, const struct diff_filepair *p)
>  {
>         return (((p->status == DIFF_STATUS_MODIFIED) &&
> @@ -6612,6 +6646,28 @@ static int match_filter(const struct diff_options *options, const struct diff_fi
>                  filter_bit_tst(p->status, options)));
>  }
>
> +static void diffcore_apply_restrict(struct diff_options *options)
> +{
> +       int i;
> +       struct diff_queue_struct *q = &diff_queued_diff;
> +       struct diff_queue_struct outq;
> +
> +       DIFF_QUEUE_CLEAR(&outq);
> +
> +       if (!options->sparse_checkout_patterns)
> +               return;
> +
> +       for (i = 0; i < q->nr; i++) {
> +               struct diff_filepair *p = q->queue[i];
> +               if (match_sparse_checkout_patterns(options, p))
> +                       diff_q(&outq, p);
> +               else
> +                       diff_free_filepair(p);
> +       }
> +       free(q->queue);
> +       *q = outq;
> +}

So you're post-processing the results.  I think it'd be better to
avoid even walking into the trees outside the sparsity paths, much
like paths listed on the command line do.  That'd also be more
reusable for log when we add a similar option for it.

> +
>  static void diffcore_apply_filter(struct diff_options *options)
>  {
>         int i;
> @@ -6827,6 +6883,7 @@ void diffcore_std(struct diff_options *options)
>                 /* See try_to_follow_renames() in tree-diff.c */
>                 diff_resolve_rename_copy();
>         diffcore_apply_filter(options);
> +       diffcore_apply_restrict(options);
>
>         if (diff_queued_diff.nr && !options->flags.diff_from_contents)
>                 options->flags.has_changes = 1;
> diff --git a/diff.h b/diff.h
> index 8ae18e5ab1e..f651216da13 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -396,6 +396,7 @@ struct diff_options {
>         struct repository *repo;
>         struct option *parseopts;
>         struct strmap *additional_path_headers;
> +       struct pattern_list *sparse_checkout_patterns;
>
>         int no_free;
>  };
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index b9350c075c2..4c416ef8e82 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh

The description of this file is
    test_description='compare full workdir to sparse workdir'
which seems like a misfit for the tests you are adding.  I'd suggest
placing them somewhere else.  t1090 might be a good candidate.

> @@ -504,6 +504,36 @@ test_expect_success 'diff --cached' '
>         test_all_match git diff --cached
>  '
>
> +test_expect_success 'diff --restrict' '
> +       init_repos &&
> +
> +       test_all_match mkdir modules &&
> +       test_all_match touch modules/a &&
> +       test_all_match touch deep/b &&
> +       test_all_match git rm deep/a &&
> +       test_all_match git add --sparse modules deep &&
> +       run_on_all git diff --restrict --staged --stat &&
> +       cat >expect <<-EOF &&
> +        deep/a | 1 -
> +        deep/b | 0
> +        2 files changed, 1 deletion(-)
> +       EOF
> +       test_cmp expect sparse-checkout-out &&
> +       cat >expect <<-EOF &&
> +        deep/a | 1 -
> +        deep/b | 0
> +        2 files changed, 1 deletion(-)
> +       EOF
> +       test_cmp expect sparse-index-out &&
> +       cat >expect <<-EOF &&
> +        deep/a    | 1 -
> +        deep/b    | 0
> +        modules/a | 0
> +        3 files changed, 1 deletion(-)
> +       EOF
> +       test_cmp expect full-checkout-out
> +'
> +
>  # NEEDSWORK: sparse-checkout behaves differently from full-checkout when
>  # running this test with 'df-conflict-2' after 'df-conflict-1'.

Just a guess, but is this NEEDSWORK perhaps reflecting the fact that
the test is in the wrong file?

The whole point of --restrict is to make the output you'd get within a
sparse-checkout NOT match what you'd get in a full checkout, because
you are restricting the output to a subset.  If you want to compare to
a full-checkout and make sure the output matches, you'd want to use
--no-restrict, right?
