Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A46FC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 07:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389529AbiEFH1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389530AbiEFH1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 03:27:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D8E674D7
        for <git@vger.kernel.org>; Fri,  6 May 2022 00:23:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id z2so11202491ejj.3
        for <git@vger.kernel.org>; Fri, 06 May 2022 00:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZcBlWagN5QiiqQVxzUe9B5r+tWF6kjoLrb/WxgPTKk=;
        b=E7o2OLIBu7dmgDrz1gsSP6XIa5UIPB1ZKMCe9L3wuFb55exfP7w7N0f/HnxtNZCjvT
         wsIZJZXHI8DuTOMmqijDjC5cQAjN/KInPgRziev5c57Td5Yb6S3Fm/pRZ0lYGHRlItoj
         GFMZs/P3v8vjR+ePKQUTbaTQI2cRsNOA+cVdCsNQIkpwgq4wz6N9e3dq0X1C7XoVFY6B
         Of+gGhxMoHbBGNS2+G82mitr8pq2zgxtbuM008zgmRg06sZ64KEPxmaigV3AxMQn+JIh
         wI8a2649ZTgNA7nX09Iq5emG9cQOcJVSR+19g1yaRhLhwaIM7UeqszULu4QoLIQphE1r
         79FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZcBlWagN5QiiqQVxzUe9B5r+tWF6kjoLrb/WxgPTKk=;
        b=eFE2dV2LFtQR9mw2T/N8v0JZiLBWKkLSIm21Su/V2N2EL9Fm4AgNCMMJK+j/DuIEjp
         AsgLl8TY0wCYhXn4OyFH6uJo4dyY9dkyflGkO9UtIYHsaIMwutoOhcTBiWYFLii3Cdxw
         nksabXvJzqUNZmumZ+j0QpaA78kzl0M36JgI0/o9fM7KFE3YiYb1Kph/ajk5pSlOZ6HK
         tzkbu+23MGIGpFKMMZW5ahzWC5ryRQks+UoqW1rRKbpli0pOXuVGgsPfdoEMQV1zrKKt
         PaMdzdDcZtmP4Uam8IuAOu3t4lkjO+D6l6VETr+a6LGkCFzGmBoVBx0IclHp8IGfcgyv
         TXnA==
X-Gm-Message-State: AOAM533D+5FbwbprSo2HyyOPJ26ET6sOHq4e14i+alkPGrLCSlGPdjPB
        L1Yc1RL1Bbgae0rY2uCzP6ejCHJeuupah0Caras=
X-Google-Smtp-Source: ABdhPJyClhwnxGIehaBXgyOEkeSy5xnMqavOPhKZdE+lrnrZsz03viRqJT11KlHzCGbk0r1eiW4FHgztgqYYpPqTjnQ=
X-Received: by 2002:a17:906:c145:b0:6f3:9ea7:1d41 with SMTP id
 dp5-20020a170906c14500b006f39ea71d41mr1752852ejc.269.1651821835261; Fri, 06
 May 2022 00:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
 <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com> <4537d473b937b182cd79b2f3c5673b75d92cab23.1651083378.git.gitgitgadget@gmail.com>
In-Reply-To: <4537d473b937b182cd79b2f3c5673b75d92cab23.1651083378.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 May 2022 00:23:43 -0700
Message-ID: <CABPp-BHcWjOeVhRD_XKTko0OH2pwYsuCt8PzH=C_0u_gUWe0GQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] merge-recursive: add merge function arg to 'merge_recursive_generic'
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 11:16 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Replace the hardcoded 'merge_recursive()' function used by the
> 'merge_recursive_generic()' with a caller-specific merge function. This will
> allow us to use 'merge_ort_recursive()' (and therefore avoid the index
> expansion of 'merge_recursive()') in commands that perform merges with
> 'merge_recursive_generic()', such as 'git stash pop'.
>
> Note that this patch is strictly a refactor; all callers still use
> 'merge_recursive()', and any changing to 'merge_ort_recursive()' will be
> done in a later commit.

I'm not sure if we can gut merge_recursive_generic(), but I don't
think stash should use it...

> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/am.c              | 2 +-
>  builtin/merge-recursive.c | 2 +-
>  builtin/stash.c           | 2 +-
>  merge-ort.c               | 3 ++-
>  merge-recursive.c         | 4 ++--
>  merge-recursive.h         | 9 ++++++++-
>  6 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 0f4111bafa0..6d01185d122 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1614,7 +1614,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
>         if (state->quiet)
>                 o.verbosity = 0;
>
> -       if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
> +       if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, merge_recursive, &result)) {
>                 repo_rerere(the_repository, state->allow_rerere_autoupdate);
>                 free(their_tree_name);
>                 return error(_("Failed to merge in the changes."));
> diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
> index b9acbf5d342..687ed1e527b 100644
> --- a/builtin/merge-recursive.c
> +++ b/builtin/merge-recursive.c
> @@ -81,7 +81,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
>         if (o.verbosity >= 3)
>                 printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
>
> -       failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, &result);
> +       failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, merge_recursive, &result);
>
>         free(better1);
>         free(better2);
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 1bfba532044..16171eb1dab 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -554,7 +554,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>         bases[0] = &info->b_tree;
>
>         ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
> -                                     &result);
> +                                     merge_recursive, &result);
>         if (ret) {
>                 rerere(0);
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 8545354dafd..4bccdfcf355 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4737,7 +4737,8 @@ void merge_incore_recursive(struct merge_options *opt,
>         trace2_region_enter("merge", "incore_recursive", opt->repo);
>
>         /* We set the ancestor label based on the merge_bases */
> -       assert(opt->ancestor == NULL);
> +       assert(opt->ancestor == NULL ||
> +              !strcmp(opt->ancestor, "constructed merge base"));

...and here's one of the reasons why.  The fact that
merge_recursive_generic() uses this string when exactly one merge base
is passed is something that is only correct for git-am; it is wrong
and actively misleading for git-stash since it has a real merge base
that is not internally constructed by the operation using the merge
machinery.  (The merge base it uses is something like $STASH^1, IIRC.)

In fact, this was half the coin around why merge_recursive_generic()
wasn't converted when merge-ort was written; see
https://lore.kernel.org/git/CABPp-BHW61zA+MefvWK47iVZKY97rxc2XZ-NjXzuJxEhgSLqUw@mail.gmail.com/
and https://lore.kernel.org/git/CABPp-BFr=1iVY739cfh-1Hp82x-Mny-k4y0f3zZ_YuP3PxiGfQ@mail.gmail.com/
for more details.

The use of merge_recursive_generic() by stash is also a bit weird;
most of the time, stash is going to have actual commits instead of
just trees.  But stash dereferences those commits to trees, passes
them to merge_recursive_generic(), and then merge_recursive_generic()
has to create fake commits containing those trees, because the merge
machinery wants commits.  It feels a bit like a Rube Goldberg machine.
Also, stash also always calls merge_recursive_generic() with exactly
one merge base, which together with having real commits both kind of
defeat the need for "generic".    I think stash should just use
merge_trees()/merge_incore_nonrecursive() directly (much as
sequencer.c does).  The only special case to worry about with stash is
when c_tree != HEAD^{tree}, i.e. when applying changes on top of
already present changes instead of just on top of HEAD.  But in that
case, I think stash should be the thing to create a fake commit rather
than invoking some wrapper that will create fake commits for all three
trees.

>         trace2_region_enter("merge", "merge_start", opt->repo);
>         merge_start(opt, result);
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1ee6364e8b1..2088f5c5fb3 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3806,6 +3806,7 @@ int merge_recursive_generic(struct merge_options *opt,
>                             const struct object_id *merge,
>                             int num_merge_bases,
>                             const struct object_id **merge_bases,
> +                           recursive_merge_fn_t merge_fn,
>                             struct commit **result)
>  {
>         int clean;
> @@ -3829,8 +3830,7 @@ int merge_recursive_generic(struct merge_options *opt,
>         }
>
>         repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
> -       clean = merge_recursive(opt, head_commit, next_commit, ca,
> -                               result);
> +       clean = merge_fn(opt, head_commit, next_commit, ca, result);
>         if (clean < 0) {
>                 rollback_lock_file(&lock);
>                 return clean;
> diff --git a/merge-recursive.h b/merge-recursive.h
> index b88000e3c25..6a21f2da538 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -53,6 +53,12 @@ struct merge_options {
>         struct merge_options_internal *priv;
>  };
>
> +typedef int (*recursive_merge_fn_t)(struct merge_options *opt,
> +                                   struct commit *h1,
> +                                   struct commit *h2,
> +                                   struct commit_list *merge_bases,
> +                                   struct commit **result);
> +
>  void init_merge_options(struct merge_options *opt, struct repository *repo);
>
>  /* parse the option in s and update the relevant field of opt */
> @@ -105,7 +111,7 @@ int merge_recursive(struct merge_options *opt,
>
>  /*
>   * merge_recursive_generic can operate on trees instead of commits, by
> - * wrapping the trees into virtual commits, and calling merge_recursive().
> + * wrapping the trees into virtual commits, and calling the provided merge_fn.
>   * It also writes out the in-memory index to disk if the merge is successful.
>   *
>   * Outputs:
> @@ -120,6 +126,7 @@ int merge_recursive_generic(struct merge_options *opt,
>                             const struct object_id *merge,
>                             int num_merge_bases,
>                             const struct object_id **merge_bases,
> +                           recursive_merge_fn_t merge_fn,
>                             struct commit **result);
>
>  #endif
> --
> gitgitgadget
