Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D9EC433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 11:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiB0LWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 06:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiB0LWU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 06:22:20 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961785D675
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 03:21:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p14so19422143ejf.11
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 03:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLB9IOlXh3DbzN8TqBQHMi0YlNu/YP/exut73hKauKQ=;
        b=e7MSAtrAGFANzTnT6onsII5oJKsbIzynPF+2PcNESyYcu//lRQbfwQtZxQhLAvXbZy
         I9d3dkmroDeFpry2sN3ZzfJCgst7dpOsp6GRU/yQdxVUJTOH1O88s6nLHjaAelukqzMj
         1/09FKNgUI0ibRvZ0W95xKn9dc8YBWe7Ss+4UHYQC7yzliRjHzUE9PAeUUQAKtRH9eUt
         1T+MhUSNvf8oheQNweNh20EwhIx9ixweOEX6KMmt3lmHMXbP5WdpoJeBb7oJj5UPyB3J
         hhG+uafDcV0RFB4yosNHkec5aF5wLX4lknzlgdfZ7Y0VZGG7x2P+I6c8zqYD7Wis1iKe
         B+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLB9IOlXh3DbzN8TqBQHMi0YlNu/YP/exut73hKauKQ=;
        b=xp0MuEqkGzqKzaSf9nplq0nL9BUmyLGaFG3IIIBb0OzqRz7KW35zsXaFlsHxXre3k6
         aSb7FqInPZTN/1OiU/l+RY2E+/2FUAXxzFKKJkgg/I4Te2iB5qhdPgTlLIogug0J6FLG
         fz4gx5Ew1R9QutpvQ7krolYojEvTwQteXl5qZcxMNFpae12tEVtzhlCjt+ruR1YxLbA6
         wtlEaT5aXStpOPxYLt+jiIc2HAkRRg5DTr7++0GHPZHWE9WKRsUnyFPIkByz7Pymg62w
         B8D1d6j6BSgAJMuaIxuBHVOGGf2Xyd0Bphe5P5bVNXDLvaXo72JvwnozlriN4eqTWjqy
         h63Q==
X-Gm-Message-State: AOAM531bIlxd3V5rpQf1ZdLiHxalvD3xeuNWF3xjjRzlNqOgm8zpj3Je
        acvc/TbfTSgRJRKIEn7dpAAfhQyy/dg3SnH8G8974/1tCfn1eg==
X-Google-Smtp-Source: ABdhPJxsUH9xAQES3pCvBnIDpqAsGI/qYEkdQFcTOxJrRJBJH6F+uUxOO6k5r5/7W3qD1SQZXm3LkHaxpOD8nMYbAVA=
X-Received: by 2002:a17:906:a210:b0:6d5:9fa:11ce with SMTP id
 r16-20020a170906a21000b006d509fa11cemr12176749ejy.172.1645960902004; Sun, 27
 Feb 2022 03:21:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.985.git.1624430668741.gitgitgadget@gmail.com>
 <pull.985.v2.git.1645811564461.gitgitgadget@gmail.com> <xmqqtucmag00.fsf@gitster.g>
In-Reply-To: <xmqqtucmag00.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 27 Feb 2022 12:21:30 +0100
Message-ID: <CAPMMpoixi3x1PHrSHJPV1GRBzMpuOQ4meMr-fipXuDvz-96MEA@mail.gmail.com>
Subject: Re: [PATCH v2] untracked-cache: support '--untracked-files=all' if configured
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 8:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > If the previously stored flags no longer match the current
> > configuration, but the currently-applicable flags do match the current
> > configuration, then the previously stored untracked cache data is
> > discarded.
> >
> > For most users there will be no change in behavior. Users who need
> > '--untracked-files=all' to perform well will have the option of
> > setting "status.showuntrackedfiles" to "all".
> >
> > Users who need '--untracked-files=all' to perform well for their
> > tooling AND prefer to avoid the verbosity of "all" when running
> > git status explicitly without options... are out of luck for now (no
> > change).
>
> So, in short, the root of the problem is that untracked cache can be
> used to serve only one mode (between normal and all) of operation,
> and the real solution to that problem must come in a different form,
> i.e. allowing a single unified untracked cache to be usable in both
> modes, perhaps by maintaining all the untracked ones in the cache,
> but filter out upon output when the 'normal' mode is asked for?

I wouldn't call this the root of the problem I was trying to solve with this
patch, but rather the root of the remaining problem, yes.

The challenge that I can't get my head around for this longer-term
approach or objective, is *when* the untracked-folder nested files
should be enumerated.

Currently, untracked folders are only recursed into if -uall is
specified or configured - and that's a significant characteristic:
It's perfectly plausible that some users sometimes have huge
deep untracked folder hierarchies that take a long time to explore,
but git never needs to because they never specify -uall.

If we decided to serve both modes with one single untracked
cache structure, then we would either need to always fully
recurse, or implement some sort of "just-in-time" filling in of the
recursive bits when someone specifies -uall for the first time.

Either way, I'm pretty sure it's beyond me to do that right. Hence
this very-pragmatic approach that makes it *possible* to get
good/normal performance with -uall.

>
> > Users who set "status.showuntrackedfiles" to "all" and yet most
> > frequently explicitly call 'git status --untracked-files=normal' (and
> > use the untracked cache) are the only ones who would be disadvantaged
> > by this change. It seems unlikely there are any such users.
>
> Given how widely used we are these days, I am afraid that the days
> we can safely say "users with such a strange use pattern would not
> exist at all" is long gone.
>
> > +static unsigned configured_default_dir_flags(struct index_state *istate)
> > +{
> > +     /* This logic is coordinated with the setting of these flags in
> > +      * wt-status.c#wt_status_collect_untracked(), and the evaluation
> > +      * of the config setting in commit.c#git_status_config()
> > +      */
>
> Good thing to note here.
>
> Style.
>
>   /*
>    * Our multi-line comments reads more like this, with
>    * slash-asterisk that opens, and asterisk-slash that closes,
>    * sitting on their own lines.
>    */

Thanks, sorry, I thought I'd corrected them all but clearly missed some.

>
> > +     char *status_untracked_files_config_value;
> > +     int config_outcome = repo_config_get_string(istate->repo,
> > +                                                             "status.showuntrackedfiles",
>
> The indentation looks a bit off.
>
> In this project, tab width is 8.  The beginning of the second
> parameter to the function call on the second line should align with
> the beginning of the first parameter that immediately follows the
> open parenthesis '('.
>

Fixed, thx.

> > +                                                             &status_untracked_files_config_value);
> > +     if (!config_outcome && !strcmp(status_untracked_files_config_value, "all")) {
> > +             return 0;
> > +     } else {
> > +             /*
> > +              * The default, if "all" is not set, is "normal" - leading us here.
> > +              * If the value is "none" then it really doesn't matter.
> > +              */
> > +             return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> > +     }
> > +}
>
> I didn't see the need to pass istate to this function, though.
> Shouldn't it take a repository instead?

Makes sense, fixed, thx.

>
> > -static void new_untracked_cache(struct index_state *istate)
> > +static void new_untracked_cache(struct index_state *istate, unsigned flags)
> >  {
> >       struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
> >       strbuf_init(&uc->ident, 100);
> >       uc->exclude_per_dir = ".gitignore";
> > -     /* should be the same flags used by git-status */
> > -     uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> > +     uc->dir_flags = flags;
>
> So we used to hardcode these two flags to match what is done in
> wt-status.c when show_untracked_files != SHOW_ALL_UNTRACKEDFILES;
> we allow a different set of flags to be given by the caller.
>
> > @@ -2761,11 +2781,13 @@ static void new_untracked_cache(struct index_state *istate)
> >  void add_untracked_cache(struct index_state *istate)
> >  {
> >       if (!istate->untracked) {
> > -             new_untracked_cache(istate);
> > +             new_untracked_cache(istate,
> > +                             configured_default_dir_flags(istate));
> >       } else {
> >               if (!ident_in_untracked(istate->untracked)) {
> >                       free_untracked_cache(istate->untracked);
> > -                     new_untracked_cache(istate);
> > +                     new_untracked_cache(istate,
> > +                                     configured_default_dir_flags(istate));
> >               }
> >       }
> >  }
>
> OK.  That's quite straight-forward to see how the tweak is made.
>
> > @@ -2781,10 +2803,12 @@ void remove_untracked_cache(struct index_state *istate)
> >
> >  static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
> >                                                     int base_len,
> > -                                                   const struct pathspec *pathspec)
> > +                                                   const struct pathspec *pathspec,
> > +                                                       struct index_state *istate)
> >  {
> >       struct untracked_cache_dir *root;
> >       static int untracked_cache_disabled = -1;
> > +     unsigned configured_dir_flags;
> >
> >       if (!dir->untracked)
> >               return NULL;
> > @@ -2812,17 +2836,9 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
> >       if (base_len || (pathspec && pathspec->nr))
> >               return NULL;
> >
> > -     /* Different set of flags may produce different results */
> > -     if (dir->flags != dir->untracked->dir_flags ||
>
> This is removed because we are making sure that dir->flags and
> dir->untracked->dir_flags match?
>
> > -         /*
> > -          * See treat_directory(), case index_nonexistent. Without
> > -          * this flag, we may need to also cache .git file content
> > -          * for the resolve_gitlink_ref() call, which we don't.
> > -          */
> > -         !(dir->flags & DIR_SHOW_OTHER_DIRECTORIES) ||
>
> This is removed because...?

Because we *do* now support using untracked cache with -uall...
As long as the config matches the runtime flags (new check later).

>
> > -         /* We don't support collecting ignore files */
> > -         (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
> > -                        DIR_COLLECT_IGNORED)))
>
> > +     /* We don't support collecting ignore files */
> > +     if (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
> > +                     DIR_COLLECT_IGNORED))
> >               return NULL;
> >
> >       /*
> > @@ -2845,6 +2861,40 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
> >               return NULL;
> >       }
> >
> > +     /* We don't support using or preparing the untracked cache if
> > +      * the current effective flags don't match the configured
> > +      * flags.
> > +      */
>
> Style (another one in large comment below).
>

Thx.

> > +     configured_dir_flags = configured_default_dir_flags(istate);
> > +     if (dir->flags != configured_dir_flags)
> > +             return NULL;
>
> Hmph.  If this weren't necessary, this function does not need to
> call configured_default_dir_flags(), and it can lose the
> configured_dir_flags variable, too.  Which means that
> new_untracked_cache() function does not need to take the flags word
> as a caller-supplied parameter.  Instead, it can make a call to
> configured_dir_flags() and assign the result to uc->dir_flags
> itself, which would have been much nicer.

I've tightened this up a little with an inline call to
configured_default_dir_flags(), getting rid of the variable, let's see
if that makes more sense / is cleaner.

Sending new version with these changes.

>
> > +     /* If the untracked structure we received does not have the same flags
> > +      * as configured, but the configured flags do match the effective flags,
> > +      * then we need to reset / create a new "untracked" structure to match
> > +      * the new config.
> > +      * Keeping the saved and used untracked cache in-line with the
> > +      * configuration provides an opportunity for frequent users of
> > +      * "git status -uall" to leverage the untracked cache by aligning their
> > +      * configuration (setting "status.showuntrackedfiles" to "all" or
> > +      * "normal" as appropriate), where previously this option was
> > +      * incompatible with untracked cache and *consistently* caused
> > +      * surprisingly bad performance (with fscache and fsmonitor enabled) on
> > +      * Windows.
> > +      *
> > +      * IMPROVEMENT OPPORTUNITY: If we reworked the untracked cache storage
> > +      * to not be as bound up with the desired output in a given run,
> > +      * and instead iterated through and stored enough information to
> > +      * correctly serve both "modes", then users could get peak performance
> > +      * with or without '-uall' regardless of their
> > +      * "status.showuntrackedfiles" config.
> > +      */
> > +     if (dir->flags != dir->untracked->dir_flags) {
> > +             free_untracked_cache(istate->untracked);
> > +             new_untracked_cache(istate, configured_dir_flags);
> > +             dir->untracked = istate->untracked;
> > +     }
>
>
> This compensates what we lost in the validate_untracked_cache()
> above by making them match.  Looking reasonable.
>
> >       if (!dir->untracked->root)
> >               FLEX_ALLOC_STR(dir->untracked->root, name, "");
> >
> > @@ -2916,7 +2966,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
> >               return dir->nr;
> >       }
> >
> > -     untracked = validate_untracked_cache(dir, len, pathspec);
> > +     untracked = validate_untracked_cache(dir, len, pathspec, istate);
> >       if (!untracked)
> >               /*
> >                * make sure untracked cache code path is disabled,
> >
> > base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
