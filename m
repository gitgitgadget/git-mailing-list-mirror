Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A29C433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 14:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiB0OkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 09:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiB0OkM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 09:40:12 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90845AED9
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 06:39:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z22so14059371edd.1
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyOS9XjUaOCAmrVcvk8K0UHdr1O1M2fvhNzODeLL3hs=;
        b=yrlA1kIUPG4ydAwbC89DDRuwtzc8kAwJgva+kn7qI2wKXsj0giyu1SOdiqHEOS8Roe
         ohSQcgZpfqCEtk7yutHnaeiCxpF/0dq+ehKPfn8crT0opwvfP7W4IqRTHv3EO753bA+P
         w4CtadzrD9J2LXitnge06f6qPQ2/7tWzwQ97VTZMcTxQpGqNNfhSpwSLPM9rojyZIORZ
         oRsavebTrPIocGTdOnHK6DPRkhrirGKxHGlfy0zkMqZQ0a8DvnluG+9R4hpITz0Qbj1Q
         YdnVGfozsYB0q5F84o5NG416z+o42CKecjmuDRvgpjMHtyFBtQHtDoA/6mNA9TkcOHAC
         m5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyOS9XjUaOCAmrVcvk8K0UHdr1O1M2fvhNzODeLL3hs=;
        b=upyr85oj1Oqka0kaXTklh+FjhG7H6RELXW59jvuA4vZtwYsdSJxDiqILk/ifIYxcOa
         KPwIRYM8yG2GVJgrA5q0IFc9zG4HbvsOam0H5hyhIxU8s4GuMKNejQdxXy+a6MaFCFYa
         R4gpA9XXVeIa/DUhJF9MtU2l5kNEJcd00+J4lboloSwbjSHiD2Gy0lp2qGX/yiiE7ToF
         x/4LhxaInzAQFgJ0bOJGTtvPacw5TAit2q3JyLRQqgzNtHpXgk7kw5nDQzCXEXRah2ZE
         jwRA2mbezm04D665LA1iLcktonaPPjeHWUeV3cbLRwMGOurNhOl5cN4GpBjjTzoMQKo7
         UhAw==
X-Gm-Message-State: AOAM532OmOwNuBkFFkaxQFzxmbttdeEn+jLIfSqRnlaWgsCaeczQuWps
        0/gMxF6Jd+QAyYCevJQFg/sPNVz9K5aN6axA81Z//w==
X-Google-Smtp-Source: ABdhPJwNCQDFPy6UCL2jtnh08yMBtWsheyh1fEgOM47O40z1jRI23YosYZLn8YYbjKE5exmG9N0UgrOKbCCXm90ueng=
X-Received: by 2002:a05:6402:168a:b0:3fb:600e:4cc3 with SMTP id
 a10-20020a056402168a00b003fb600e4cc3mr15359429edv.32.1645972771922; Sun, 27
 Feb 2022 06:39:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.985.v2.git.1645811564461.gitgitgadget@gmail.com> <pull.985.v3.git.1645960973798.gitgitgadget@gmail.com>
In-Reply-To: <pull.985.v3.git.1645960973798.gitgitgadget@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 27 Feb 2022 15:39:20 +0100
Message-ID: <CAPMMpojQa05yq6ePuK0T8GKhsULPzv-kdjC6DUDpaED9gU17_g@mail.gmail.com>
Subject: Re: [PATCH v3] untracked-cache: support '--untracked-files=all' if configured
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bad submission, my apologies - commit message is right but code
changes are missing. New one coming soon.

On Sun, Feb 27, 2022 at 12:22 PM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tao Klerks <tao@klerks.biz>
>
> Untracked cache was originally designed to only work with
> '-untracked-files=normal', but this causes performance issues for UI
> tooling that wants to see "all" on a frequent basis. On the other hand,
> the conditions that prevented applicability to the "all" mode no
> longer seem to apply.
>
> The disqualification of untracked cache has a particularly significant
> impact on Windows with the defaulted fscache, where the introduction
> of fsmonitor can make the first and costly directory-iteration happen
> in untracked file detection, single-threaded, rather than in
> preload-index on multiple threads. Improving the performance of a
> "normal" 'git status' run with fsmonitor can make
> 'git status --untracked-files=all' perform much worse.
>
> To partially address this, align the supported directory flags for the
> stored untracked cache data with the git config. If a user specifies
> an '--untracked-files=' commandline parameter that does not align with
> their 'status.showuntrackedfiles' config value, then the untracked
> cache will be ignored - as it is for other unsupported situations like
> when a pathspec is specified.
>
> If the previously stored flags no longer match the current
> configuration, but the currently-applicable flags do match the current
> configuration, then discard the previously stored untracked cache
> data.
>
> For most users there will be no change in behavior. Users who need
> '--untracked-files=all' to perform well will now have the option of
> setting "status.showuntrackedfiles" to "all" for better / more
> consistent performance.
>
> Users who need '--untracked-files=all' to perform well for their
> tooling AND prefer to avoid the verbosity of "all" when running
> git status explicitly without options... are out of luck for now (no
> change).
>
> Users who have the "status.showuntrackedfiles" config set to "all"
> and yet frequently explicitly call
> 'git status --untracked-files=normal' (and use the untracked cache)
> are the only ones who will be disadvantaged by this change. Their
> "--untracked-files=normal" calls will, after this change, no longer
> use the untracked cache.
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>     Support untracked cache with '--untracked-files=all' if configured
>
>     Resending this patch from a few months ago (with better standards
>     compliance) - it hasn't seen any comments yet, I would dearly love some
>     eyes on this as the change can make a big difference to hundreds of
>     windows users in my environment (and I'd really rather not start
>     distributing customized git builds!)
>
>     This patch aims to make it possible for users of the -uall flag to git
>     status, either by preference or by need (eg UI tooling), to benefit from
>     the untracked cache when they set their 'status.showuntrackedfiles'
>     config setting to 'all'. This is very important for large repos in
>     Windows.
>
>     More detail on the change and context in the commit message, I assume
>     repeating a verbose message here is discouraged.
>
>     These changes result from a couple of conversations,
>     81153d02-8e7a-be59-e709-e90cd5906f3a@jeffhostetler.com and
>     CABPp-BFiwzzUgiTj_zu+vF5x20L0=1cf25cHwk7KZQj2YkVzXw@mail.gmail.com>.
>
>     The test suite passes, but as a n00b I do have questions:
>
>      * Is there any additional validation that could/should be done to
>        confirm that "-uall" untracked data can be cached safely?
>        * It looks safe from following the code
>        * It seems from discussing briefly with Elijah Newren in the thread
>          above that thare are no obvious red flags
>        * Manual testing, explicitly and implicitly through months of use,
>          yields no issues
>      * Is it OK to check the repo configuration in the body of processing?
>        It seems to be a rare pattern
>      * Can anyone think of a way to test this change?
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-985%2FTaoK%2Ftaok-untracked-cache-with-uall-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-985/TaoK/taok-untracked-cache-with-uall-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/985
>
> Range-diff vs v2:
>
>  1:  e2f1ad26c78 ! 1:  49cf90bfab5 untracked-cache: support '--untracked-files=all' if configured
>      @@ Commit message
>           untracked-cache: support '--untracked-files=all' if configured
>
>           Untracked cache was originally designed to only work with
>      -    '-untracked-files=normal', but this is a concern for UI tooling that
>      -    wants to see "all" on a frequent basis, and the conditions that
>      -    prevented applicability to the "all" mode no longer seem to apply.
>      +    '-untracked-files=normal', but this causes performance issues for UI
>      +    tooling that wants to see "all" on a frequent basis. On the other hand,
>      +    the conditions that prevented applicability to the "all" mode no
>      +    longer seem to apply.
>
>      -    The disqualification of untracked cache is a particular problem on
>      -    Windows with the defaulted fscache, where the introduction of
>      -    fsmonitor can make the first and costly directory-iteration happen
>      +    The disqualification of untracked cache has a particularly significant
>      +    impact on Windows with the defaulted fscache, where the introduction
>      +    of fsmonitor can make the first and costly directory-iteration happen
>           in untracked file detection, single-threaded, rather than in
>           preload-index on multiple threads. Improving the performance of a
>           "normal" 'git status' run with fsmonitor can make
>           'git status --untracked-files=all' perform much worse.
>
>      -    In this change, align the supported directory flags for the stored
>      -    untracked cache data with the git config. If a user specifies an
>      -    '--untracked-files=' commandline parameter that does not align with
>      +    To partially address this, align the supported directory flags for the
>      +    stored untracked cache data with the git config. If a user specifies
>      +    an '--untracked-files=' commandline parameter that does not align with
>           their 'status.showuntrackedfiles' config value, then the untracked
>           cache will be ignored - as it is for other unsupported situations like
>           when a pathspec is specified.
>
>           If the previously stored flags no longer match the current
>           configuration, but the currently-applicable flags do match the current
>      -    configuration, then the previously stored untracked cache data is
>      -    discarded.
>      +    configuration, then discard the previously stored untracked cache
>      +    data.
>
>           For most users there will be no change in behavior. Users who need
>      -    '--untracked-files=all' to perform well will have the option of
>      -    setting "status.showuntrackedfiles" to "all".
>      +    '--untracked-files=all' to perform well will now have the option of
>      +    setting "status.showuntrackedfiles" to "all" for better / more
>      +    consistent performance.
>
>           Users who need '--untracked-files=all' to perform well for their
>           tooling AND prefer to avoid the verbosity of "all" when running
>           git status explicitly without options... are out of luck for now (no
>           change).
>
>      -    Users who set "status.showuntrackedfiles" to "all" and yet most
>      -    frequently explicitly call 'git status --untracked-files=normal' (and
>      -    use the untracked cache) are the only ones who would be disadvantaged
>      -    by this change. It seems unlikely there are any such users.
>      +    Users who have the "status.showuntrackedfiles" config set to "all"
>      +    and yet frequently explicitly call
>      +    'git status --untracked-files=normal' (and use the untracked cache)
>      +    are the only ones who will be disadvantaged by this change. Their
>      +    "--untracked-files=normal" calls will, after this change, no longer
>      +    use the untracked cache.
>
>           Signed-off-by: Tao Klerks <tao@klerks.biz>
>
>
>
>  dir.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 68 insertions(+), 18 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index d91295f2bcd..e35331d3f71 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2746,13 +2746,33 @@ static void set_untracked_ident(struct untracked_cache *uc)
>         strbuf_addch(&uc->ident, 0);
>  }
>
> -static void new_untracked_cache(struct index_state *istate)
> +static unsigned configured_default_dir_flags(struct index_state *istate)
> +{
> +       /* This logic is coordinated with the setting of these flags in
> +        * wt-status.c#wt_status_collect_untracked(), and the evaluation
> +        * of the config setting in commit.c#git_status_config()
> +        */
> +       char *status_untracked_files_config_value;
> +       int config_outcome = repo_config_get_string(istate->repo,
> +                                                               "status.showuntrackedfiles",
> +                                                               &status_untracked_files_config_value);
> +       if (!config_outcome && !strcmp(status_untracked_files_config_value, "all")) {
> +               return 0;
> +       } else {
> +               /*
> +                * The default, if "all" is not set, is "normal" - leading us here.
> +                * If the value is "none" then it really doesn't matter.
> +                */
> +               return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> +       }
> +}
> +
> +static void new_untracked_cache(struct index_state *istate, unsigned flags)
>  {
>         struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
>         strbuf_init(&uc->ident, 100);
>         uc->exclude_per_dir = ".gitignore";
> -       /* should be the same flags used by git-status */
> -       uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> +       uc->dir_flags = flags;
>         set_untracked_ident(uc);
>         istate->untracked = uc;
>         istate->cache_changed |= UNTRACKED_CHANGED;
> @@ -2761,11 +2781,13 @@ static void new_untracked_cache(struct index_state *istate)
>  void add_untracked_cache(struct index_state *istate)
>  {
>         if (!istate->untracked) {
> -               new_untracked_cache(istate);
> +               new_untracked_cache(istate,
> +                               configured_default_dir_flags(istate));
>         } else {
>                 if (!ident_in_untracked(istate->untracked)) {
>                         free_untracked_cache(istate->untracked);
> -                       new_untracked_cache(istate);
> +                       new_untracked_cache(istate,
> +                                       configured_default_dir_flags(istate));
>                 }
>         }
>  }
> @@ -2781,10 +2803,12 @@ void remove_untracked_cache(struct index_state *istate)
>
>  static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
>                                                       int base_len,
> -                                                     const struct pathspec *pathspec)
> +                                                     const struct pathspec *pathspec,
> +                                                         struct index_state *istate)
>  {
>         struct untracked_cache_dir *root;
>         static int untracked_cache_disabled = -1;
> +       unsigned configured_dir_flags;
>
>         if (!dir->untracked)
>                 return NULL;
> @@ -2812,17 +2836,9 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>         if (base_len || (pathspec && pathspec->nr))
>                 return NULL;
>
> -       /* Different set of flags may produce different results */
> -       if (dir->flags != dir->untracked->dir_flags ||
> -           /*
> -            * See treat_directory(), case index_nonexistent. Without
> -            * this flag, we may need to also cache .git file content
> -            * for the resolve_gitlink_ref() call, which we don't.
> -            */
> -           !(dir->flags & DIR_SHOW_OTHER_DIRECTORIES) ||
> -           /* We don't support collecting ignore files */
> -           (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
> -                          DIR_COLLECT_IGNORED)))
> +       /* We don't support collecting ignore files */
> +       if (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
> +                       DIR_COLLECT_IGNORED))
>                 return NULL;
>
>         /*
> @@ -2845,6 +2861,40 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>                 return NULL;
>         }
>
> +       /* We don't support using or preparing the untracked cache if
> +        * the current effective flags don't match the configured
> +        * flags.
> +        */
> +       configured_dir_flags = configured_default_dir_flags(istate);
> +       if (dir->flags != configured_dir_flags)
> +               return NULL;
> +
> +       /* If the untracked structure we received does not have the same flags
> +        * as configured, but the configured flags do match the effective flags,
> +        * then we need to reset / create a new "untracked" structure to match
> +        * the new config.
> +        * Keeping the saved and used untracked cache in-line with the
> +        * configuration provides an opportunity for frequent users of
> +        * "git status -uall" to leverage the untracked cache by aligning their
> +        * configuration (setting "status.showuntrackedfiles" to "all" or
> +        * "normal" as appropriate), where previously this option was
> +        * incompatible with untracked cache and *consistently* caused
> +        * surprisingly bad performance (with fscache and fsmonitor enabled) on
> +        * Windows.
> +        *
> +        * IMPROVEMENT OPPORTUNITY: If we reworked the untracked cache storage
> +        * to not be as bound up with the desired output in a given run,
> +        * and instead iterated through and stored enough information to
> +        * correctly serve both "modes", then users could get peak performance
> +        * with or without '-uall' regardless of their
> +        * "status.showuntrackedfiles" config.
> +        */
> +       if (dir->flags != dir->untracked->dir_flags) {
> +               free_untracked_cache(istate->untracked);
> +               new_untracked_cache(istate, configured_dir_flags);
> +               dir->untracked = istate->untracked;
> +       }
> +
>         if (!dir->untracked->root)
>                 FLEX_ALLOC_STR(dir->untracked->root, name, "");
>
> @@ -2916,7 +2966,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>                 return dir->nr;
>         }
>
> -       untracked = validate_untracked_cache(dir, len, pathspec);
> +       untracked = validate_untracked_cache(dir, len, pathspec, istate);
>         if (!untracked)
>                 /*
>                  * make sure untracked cache code path is disabled,
>
> base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
> --
> gitgitgadget
