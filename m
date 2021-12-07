Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7C2C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbhLGRI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbhLGRI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:08:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2329EC061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:04:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so59642978eds.10
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dwvwd8G1C6OXPrpkotY/kU4PqB1h76qRxiVFmKkNubU=;
        b=BIS7kwc1eqONv1z5OoMbFOo6hoH0j12Pvq/i2OH+4v1wJaUnJptzEiMx6ydsKOd/qC
         I8Au2u85fSu8beJkwQOAVQVwpBvGcTJ02+benffxJZxziBZLGbUhsYB/ST48jgPvkhaA
         IW6Fae/FgxG3NEszgdbOSYZ8AMlLAXBBbMKrJpiOS92a64cju9LfOd3Om8HhThQXGPcr
         7YQyCAMK4lDKMEiAgtqeb4MEHst3XekGWuloPLN1QfKOFsmM7sX2UTzU8VMlpk0WZCzP
         6S/p1hVTzK80Kl1EiuAgf+RdwxCDppb1iTx7mGi/nadoim3nD29bfwo19rEag6azueRi
         7Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dwvwd8G1C6OXPrpkotY/kU4PqB1h76qRxiVFmKkNubU=;
        b=oUTlDoEmZjyoiepRkJ1LVGL7yImW5zNvBg5d3yZL7AGZFGHO4svF8If7I0gGd5jV8a
         euhuEMgcg2Ttrfbd1TwWpN1xkjP45pa8gd3Zc1n0/OyLwquIMnQiojyY9uqZbhKji6/h
         u12ZXo2FezlThZ2oEBrkovJclVLFHBA9eNVoR1eq+hUlSX7C9jlJ7qWmHFhX91eB8cf3
         0kIffLWNZ9jd/doUDclMuHSqHdSyrawrkBdjhwbLgcEUdzUkot4GDP3OeixQBitkpWyW
         Da6dCvNRYRorGEnn7A4aLV+nTw/Vsfr3DuDguNzheDba3ECwrpeD7qtNwz/dnsntvxxn
         qYOA==
X-Gm-Message-State: AOAM5304AXdJlf5R6MILUIgKYn4l5dsBW1I7L4AAFYx4iDJkN7nDlVRm
        UYcOlE7MaUv3WvjA2nqo3RcqiWIz8RIOmosuAtbtCw0o
X-Google-Smtp-Source: ABdhPJwDFrSVonKjhaA/RG95/5VlIgY6e/gh5/3JslbfJo2ojDU7jzfev3cUVhNMFvRLQUP69ogVbob0AdKXix+Fq+M=
X-Received: by 2002:a17:907:75d3:: with SMTP id jl19mr705199ejc.520.1638896694420;
 Tue, 07 Dec 2021 09:04:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
 <a90687eb4c1ea6569250391cd2a8111a0e338316.1638648020.git.gitgitgadget@gmail.com>
 <bb738571-f90c-7df5-2e20-ff716ed8a4f0@github.com>
In-Reply-To: <bb738571-f90c-7df5-2e20-ff716ed8a4f0@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Dec 2021 09:04:42 -0800
Message-ID: <CABPp-BF-7DRmE+DPZOFuCYwSRdD8yk4pPsYpFN4=5fALEkqATg@mail.gmail.com>
Subject: Re: [PATCH 3/6] sparse-checkout: enable `set` to initialize
 sparse-checkout mode
To:     Victoria Dye <vdye@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 4, 2021 at 1:40 PM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > The previously suggested workflow:
> >   git sparse-checkout init ...
> >   git sparse-checkout set ...
> >
> > Suffered from three problems:
> >   1) It would delete nearly all files in the first step, then
> >      restore them in the second.  That was poor performance and
> >      forced unnecessary rebuilds.
> >   2) The two-step process resulted in two progress bars, which
> >      was suboptimal from a UI point of view for wrappers that
> >      invoked both of these commands but only exposed a single
> >      command to their end users.
> >   3) With cone mode, the first step would delete nearly all
> >      ignored files everywhere, because everything was considered
> >      to be outside of the specified sparsity paths.  (The user was
> >      not allowed to specify any sparsity paths in the `init` step.)
> >
> > Avoid these problems by teaching `set` to understand the extra
> > parameters that `init` takes and performing any necessary initialization
> > if not already in a sparse checkout.
> >
>
> I really like this change! It always seemed weird that `set` would
> implicitly `init`, but without any of the options in `init`.
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/sparse-checkout.c | 52 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index e252b82136e..cf6a6c6c3a7 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -682,17 +682,26 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
> >  }
> >
> >  static char const * const builtin_sparse_checkout_set_usage[] = {
> > -     N_("git sparse-checkout set (--stdin | <patterns>)"),
> > +     N_("git sparse-checkout set [--cone] [--[no-]sparse-index] (--stdin | <patterns>)"),
>
> Since `cone` is an `OPT_BOOL`, shouldn't it appear in the usage string as
> `--[no-]cone`? Without a `--no-cone` option, it's not clear how a user would
> disable cone mode (since `set` preserves the existing cone mode setting if
> `--cone` isn't given).

Yeah, fair point.  When copying from init I probably should have double checked.

Also, it makes me wonder if we should just make cone mode the default...

> >       NULL
> >  };
> >
> >  static struct sparse_checkout_set_opts {
> > +     int cone_mode;
> > +     int sparse_index;
> >       int use_stdin;
> >  } set_opts;
> >
> >  static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
> >  {
> > +     int mode, record_mode;
> > +     const char *default_patterns[] = {"/*", "!/*/"};
> > +
> >       static struct option builtin_sparse_checkout_set_options[] = {
> > +             OPT_BOOL(0, "cone", &set_opts.cone_mode,
> > +                      N_("initialize the sparse-checkout in cone mode")),
> > +             OPT_BOOL(0, "sparse-index", &set_opts.sparse_index,
> > +                      N_("toggle the use of a sparse index")),
> >               OPT_BOOL(0, "stdin", &set_opts.use_stdin,
> >                        N_("read patterns from standard in")),
>
> I know this isn't part of this patch, but is `stdin` really a bool (i.e.
> someone might specify `--no-stdin`)? If not, I think `OPT_SET_INT` might be
> more appropriate.

Good point.  OPT_SET_INT() wouldn't fix it, though; you need to use
OPT_BOOL_F or OPT_SET_INT_F and pass PARSE_OPT_NONEG as a flag.  I can
include that.

> >               OPT_END(),
> > @@ -700,11 +709,52 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
> >
> >       repo_read_index(the_repository);
> >
> > +     set_opts.cone_mode = -1;
> > +     set_opts.sparse_index = -1;
> > +
> >       argc = parse_options(argc, argv, prefix,
> >                            builtin_sparse_checkout_set_options,
> >                            builtin_sparse_checkout_set_usage,
> >                            PARSE_OPT_KEEP_UNKNOWN);
> >
> > +     /* Determine if we need to record the mode; ensure sparse checkout on */
> > +     record_mode = (set_opts.cone_mode != -1) || !core_apply_sparse_checkout;
> > +     core_apply_sparse_checkout = 1;
> > +
> > +     /* If not specified, use previous definition of cone mode */
> > +     if (set_opts.cone_mode == -1 && core_apply_sparse_checkout)
>
> I *think* this is supposed go before the `core_apply_sparse_checkout = 1;`
> above it (if the intention is to only use the pre-existing cone mode setting
> when already in a sparse checkout). If not, the `core_apply_sparse_checkout`
> part of the condition is redundant and can be removed entirely.

Eek.  I had it there originally, then moved it later while doing
various changes.  This definitely should be later; thanks for
catching.

> > +             set_opts.cone_mode = core_sparse_checkout_cone;
> > +
> > +     /* Set cone/non-cone mode appropriately */
> > +     if (set_opts.cone_mode == 1) {
> > +             mode = MODE_CONE_PATTERNS;
> > +             core_sparse_checkout_cone = 1;
> > +     } else {
> > +             mode = MODE_ALL_PATTERNS;
> > +     }
> > +     if (record_mode && set_config(mode))
> > +             return 1;
> > +
> > +     /* Set sparse-index/non-sparse-index mode if specified */
> > +     if (set_opts.sparse_index >= 0) {
> > +             if (set_sparse_index_config(the_repository, set_opts.sparse_index) < 0)
> > +                     die(_("failed to modify sparse-index config"));
> > +
> > +             /* force an index rewrite */
> > +             repo_read_index(the_repository);
> > +             the_repository->index->updated_workdir = 1;
> > +     }
> > +
> > +     /*
> > +      * Cone mode automatically specifies the toplevel directory.  For
> > +      * non-cone mode, if nothing is specified, manually select just the
> > +      * top-level directory (much as 'init' would do).
> > +      */
> > +     if (!core_sparse_checkout_cone && argc == 0) {
> > +             argv = default_patterns;
> > +             argc = 2;
> > +     }
> > +
> >       return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
> >  }
