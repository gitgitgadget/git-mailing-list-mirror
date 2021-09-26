Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C66C433EF
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 06:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E16060F9C
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 06:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhIZGwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 02:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhIZGwh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 02:52:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA1C061570
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 23:51:01 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so19628782otx.3
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLSHReWSnCN1jIxB6xsVvgy+dU075wBsoyE6EYXaRVQ=;
        b=Je9VCpSdiL2+NvU9ZHl2N+JRdZg7m6X24hHdg3UFAOXVOihyL75PhTbw5ovP7ColUP
         loEQ2thdsnbWDY6DeYlhSXsnKyVrP2Bw5RuR7IRQuQS6EercFnQpmO3urVdUJ8e/DMrH
         WAajatoY05EYkOVU+kmZb6SIPlzAXSUTQKF8kXMun2N8/uR7XTgk9y9j5AY0FYvs/SH3
         Vy/zvvhtjo4vGVrWmpdfdn18hjCMRjft1LAJ6EEGduQtV/Rh6wgrb9V4/Ixr8CnPZcNl
         jMvO10F7R5cZezOhfU7FvyW0EILEHsI2Ed9wUNPLhAEOGQVpLFVV07S46L80ZgjYENSH
         zMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLSHReWSnCN1jIxB6xsVvgy+dU075wBsoyE6EYXaRVQ=;
        b=ZPIME+vNzSOBmg2WTI53LOxfQbU61UFGIttaL0JnnDtsoeKv29cfqJiSa7RKkrx7do
         l1C8qexmX3B0OPe3aCqw90DTxs6c1Ir+3ILlCGTtIoUabMiwA3EsFDeLqLm+I26lGYHg
         MR59rG/NKCkKNE6r59UiOSUPPfmsb/uBP9ew3NIqzhBCzEVWCFvVdNgMzD7JDT5rPOpF
         rr7YwdsRtO2/V1rcETH24z8vtkY1/AtHBnY8qraO2ZdUW5E4UTShFUXeo0AoESwJ7l0R
         LORVku4CQDR2LjQqRi/xwt9BNQOLdx5d49TPYkbUJEfG2GzkX+l4Ar+hWIDRWiT03OF+
         3GTA==
X-Gm-Message-State: AOAM531wY6NqDVCDG/LymLMccBFOUoKvsDnvNijbR39FCPARpUTiCIWk
        +DkEkNTLNiTSx6Ix4jD7QAWW+pvx9bZVXgVIa8wtnYcasYeKxQ==
X-Google-Smtp-Source: ABdhPJwBNUzxxPvYDntl1M0OMj8KlK1h6R0u9tBlg8pm1SgNP3nZGwGQgI5KKTSHkZyRa4Z2n1ninKPBzvstszUmox8=
X-Received: by 2002:a05:6830:24ac:: with SMTP id v12mr11698622ots.174.1632639060384;
 Sat, 25 Sep 2021 23:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com> <b77692b8f49e6551de201104d0e3527f3379b017.1632465429.git.gitgitgadget@gmail.com>
 <xmqq7df5x4f1.fsf@gitster.g>
In-Reply-To: <xmqq7df5x4f1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 25 Sep 2021 23:50:48 -0700
Message-ID: <CABPp-BHQif-tRkG8tB7V8B41jFesVbnCK1tsrTZNXg0_WaOcbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] Change unpack_trees' 'reset' flag into an enum
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 10:35 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Also, note that 'git checkout <pathspec>' currently also allows
> > overwriting untracked files.  That case should also be fixed, ...
>
> I wasted a few minutes wondering about the example.  Please make it
> clear that you are checking out of a tree-ish that is different from
> HEAD, as there will by definition no "overwriting untracked" if you
> are checking out of the index.
>
> E.g. "git checkout <tree-ish> -- <pathspec>".
>
> With this command line:
>
>    $ git checkout HEAD~24 -- path
>
> where path used to be there as late as 24 revisions ago, but since
> then we removed, and the user wants to materialize the file out of
> the old version, path, be it tracked, untracked, or even a
> directory, should be made identical to the copy from the given
> version, no?  Where does the "should also be fixed" come from?

Sorry, I should have been more careful.  Phillip noted this other case
that overwrote untracked files and suggested mentioning it; see
https://lore.kernel.org/git/acef3628-9542-d777-2534-577de9707e15@gmail.com/
and the links from there.  Perhaps I would have been better off
mentioning that link and the other links in it.

> > diff --git a/builtin/am.c b/builtin/am.c
> > index c79e0167e98..b17baa67ad8 100644
> > --- a/builtin/am.c
> > +++ b/builtin/am.c
> > @@ -1918,8 +1918,14 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
> >       opts.dst_index = &the_index;
> >       opts.update = 1;
> >       opts.merge = 1;
> > -     opts.reset = reset;
> > +     opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
> >       opts.fn = twoway_merge;
> > +     if (opts.reset) {
> > +             /* Allow ignored files in the way to get overwritten */
> > +             opts.dir = xcalloc(1, sizeof(*opts.dir));
> > +             opts.dir->flags |= DIR_SHOW_IGNORED;
> > +             setup_standard_excludes(opts.dir);
>
> Do these three lines make a recurring pattern when opts.reset is set?
> I am wondering if this can be done more centrally by the unpack-trees
> machinery (i.e. "gee this one has o->reset set to X, so let's set up
> the o->dir before doing anything").

It's a very common pattern...but not universal due to some prevailing
weirdness and differences in how commands handle ignored files.  But,
it looks like that can be fixed up, and then this can be centralized.
I've got some patches doing this.

> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index b5d477919a7..52826e0d145 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -641,23 +641,37 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
> >  {
> >       struct unpack_trees_options opts;
> >       struct tree_desc tree_desc;
> > +     int unpack_trees_ret;
> >
> >       memset(&opts, 0, sizeof(opts));
> >       opts.head_idx = -1;
> >       opts.update = worktree;
> >       opts.skip_unmerged = !worktree;
> > -     opts.reset = 1;
> > +     opts.reset = o->force ? UNPACK_RESET_OVERWRITE_UNTRACKED :
> > +                             UNPACK_RESET_PROTECT_UNTRACKED;
> >       opts.merge = 1;
> >       opts.fn = oneway_merge;
> >       opts.verbose_update = o->show_progress;
> >       opts.src_index = &the_index;
> >       opts.dst_index = &the_index;
> > +     if (o->overwrite_ignore) {
> > +             opts.dir = xcalloc(1, sizeof(*opts.dir));
> > +             opts.dir->flags |= DIR_SHOW_IGNORED;
> > +             setup_standard_excludes(opts.dir);
> > +     }
>
> If our longer term goal is to decide classification of files not in
> the index (currently, "ignored" and "untracked", but we may want to
> add a new "precious" class) and (across various commands that build
> on the unpack-trees infrastructure) to protect the "untracked" and
> "precious" ones, with --[no-]overwrite-{ignore,untracked} options as
> escape hatches, uniformly, perhaps the --[no-]-overwrite-ignore
> option may be stolen from here and shifted to unpack_tree_options to
> help us going in that direction?  This is just an observation for
> longer term, not a suggestion to include the first step for such a
> move in this series.

I had thought about that, but I was already pretty deep down the
rabbit hole of trying to avoid removing the current working directory
as a side effect of other commands.  I noted in my cover letter the
--no-overwrite-ignore options and how they could be used building on
this series, and now you bring it up too.  And your previous comment
about the common pattern for unpack_trees_options.dir forces me to go
further down this hole a bit.  So, I've got patches that implement a
fair amount of this, but doesn't actually add the new
--no-overwrite-ignore options or plumb them through.  They do,
however, add a FIXME comment where a single boolean value could be set
in order to make such options work.

>
> >       init_checkout_metadata(&opts.meta, info->refname,
> >                              info->commit ? &info->commit->object.oid : null_oid(),
> >                              NULL);
> >       parse_tree(tree);
> >       init_tree_desc(&tree_desc, tree->buffer, tree->size);
> > -     switch (unpack_trees(1, &tree_desc, &opts)) {
> > +     unpack_trees_ret = unpack_trees(1, &tree_desc, &opts);
> > +
> > +     if (o->overwrite_ignore) {
> > +             dir_clear(opts.dir);
> > +             FREE_AND_NULL(opts.dir);
>
> This dir_clear() is also a recurring theme.  See below.
>
> > +     }
> > +
> > +     switch (unpack_trees_ret) {
> >       case -2:
> >               *writeout_error = 1;
> >               /*
> > diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> > index 485e7b04794..740fc0335af 100644
> > --- a/builtin/read-tree.c
> > +++ b/builtin/read-tree.c
> > @@ -174,6 +174,9 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
> >       if (1 < opts.merge + opts.reset + prefix_set)
> >               die("Which one? -m, --reset, or --prefix?");
> >
> > +     if (opts.reset)
> > +             opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
> > +
>
> We do not do anything about opts.dir here by default, which means we
> by default do not overwrite ignored, but that's OK, because this old
> command explicitly takes --exclude-per-directory to tell it what the
> command should consider "ignored" and with the option given we do
> prepare opts.dir just fine.
>
> > diff --git a/builtin/reset.c b/builtin/reset.c
> > index 43e855cb887..a12ee986e9f 100644
> > --- a/builtin/reset.c
> > +++ b/builtin/reset.c
> > @@ -10,6 +10,7 @@
> >  #define USE_THE_INDEX_COMPATIBILITY_MACROS
> >  #include "builtin.h"
> >  #include "config.h"
> > +#include "dir.h"
> >  #include "lockfile.h"
> >  #include "tag.h"
> >  #include "object.h"
> > @@ -70,9 +71,20 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
> >               break;
> >       case HARD:
> >               opts.update = 1;
> > -             /* fallthrough */
> > +             opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
> > +             break;
> > +     case MIXED:
> > +             opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
> > +             /* but opts.update=0, so working tree not updated */
> > +             break;
> >       default:
> > -             opts.reset = 1;
> > +             BUG("invalid reset_type passed to reset_index");
> > +     }
> > +     if (opts.reset == UNPACK_RESET_PROTECT_UNTRACKED) {
>
> Unlike the one in "am", this cares .reset being a particular value,
> not just being non-zero.  Puzzling.
>
> It is a bit counter-intuitive in that we do not allow overwrite
> ignored (which is currently a synonym for "expendable") when .reset
> is set to allow us to ovewrite untracked.

No, when opts.reset == UNPACK_RESET_NUKE_UNTRACKED, unpack_trees() has
no way to differentiate between untracked and ignored and thus just
deletes them all.  Setting up unpack_trees_options.dir so that we can
differentiate between untracked and ignored files when we are just
going to treat them the same (delete them both) is wasted effort.  So
the check for a certain type of reset value was merely an
optimization.  (And that optimization didn't apply in the am case,
since it doesn't use UNPACK_RESET_NUKE_UNTRACKED.)

However, consolidating the unpack_trees_options.dir handling into
unpack_trees() allows me to better document the optimization and only
worry about it in one place, which seems to make the code much
clearer.

>
> > +             /* Setup opts.dir so we can overwrite ignored files */
> > +             opts.dir = xcalloc(1, sizeof(*opts.dir));
> > +             opts.dir->flags |= DIR_SHOW_IGNORED;
> > +             setup_standard_excludes(opts.dir);
>
> > @@ -104,6 +116,10 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
> >       ret = 0;
> >
> >  out:
> > +     if (opts.reset == UNPACK_RESET_PROTECT_UNTRACKED) {
> > +             dir_clear(opts.dir);
> > +             FREE_AND_NULL(opts.dir);
>
> This dir_clear() is also a recurring theme.  See below.
>
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index 8f42360ca91..563f590afbd 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -237,6 +237,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
> >       struct tree_desc t[MAX_UNPACK_TREES];
> >       struct tree *tree;
> >       struct lock_file lock_file = LOCK_INIT;
> > +     int unpack_trees_ret;
> >
> >       read_cache_preload(NULL);
> >       if (refresh_cache(REFRESH_QUIET))
> > @@ -256,11 +257,23 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
> >       opts.src_index = &the_index;
> >       opts.dst_index = &the_index;
> >       opts.merge = 1;
> > -     opts.reset = reset;
> > +     opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
> > +     if (opts.reset) {
> > +             opts.dir = xcalloc(1, sizeof(*opts.dir));
> > +             opts.dir->flags |= DIR_SHOW_IGNORED;
> > +             setup_standard_excludes(opts.dir);
> > +     }
> >       opts.update = update;
> >       opts.fn = oneway_merge;
> >
> > -     if (unpack_trees(nr_trees, t, &opts))
> > +     unpack_trees_ret = unpack_trees(nr_trees, t, &opts);
> > +
> > +     if (opts.reset) {
> > +             dir_clear(opts.dir);
> > +             FREE_AND_NULL(opts.dir);
>
> This dir_clear() is also a recurring theme.  Why aren't their guards
> uniformly "if (opts.dir)"?  The logic to decide if we set up opts.dir
> or not may be far from here and may be different from code path to
> code path, but the need to clear opts.dir should not have to care
> why opts.dir was populated, no?

Yeah, you're right; I should have used "if (opts.dir)" for all these cases.

> > +     }
> > +
> > +     if (unpack_trees_ret)
> >               return -1;
> >
> >       if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> > diff --git a/reset.c b/reset.c
> > index 79310ae071b..1695f3828c5 100644
> > --- a/reset.c
> > +++ b/reset.c
> > @@ -1,5 +1,6 @@
> >  #include "git-compat-util.h"
> >  #include "cache-tree.h"
> > +#include "dir.h"
> >  #include "lockfile.h"
> >  #include "refs.h"
> >  #include "reset.h"
> > @@ -57,8 +58,12 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
> >       unpack_tree_opts.update = 1;
> >       unpack_tree_opts.merge = 1;
> >       init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
> > -     if (!detach_head)
> > -             unpack_tree_opts.reset = 1;
> > +     if (!detach_head) {
> > +             unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
> > +             unpack_tree_opts.dir = xcalloc(1, sizeof(*unpack_tree_opts.dir));
> > +             unpack_tree_opts.dir->flags |= DIR_SHOW_IGNORED;
> > +             setup_standard_excludes(unpack_tree_opts.dir);
> > +     }
> >
> >       if (repo_read_index_unmerged(r) < 0) {
> >               ret = error(_("could not read index"));
> > @@ -131,6 +136,10 @@ reset_head_refs:
> >                           oid_to_hex(oid), "1", NULL);
> >
> >  leave_reset_head:
> > +     if (unpack_tree_opts.dir) {
> > +             dir_clear(unpack_tree_opts.dir);
> > +             FREE_AND_NULL(unpack_tree_opts.dir);
>
> Yes, I think this is the right way to decide if we call dir_clear(),
> and all other hunks in this patch should do the same.

Will fix, though the consolidation ends up making it just one place anyway.
