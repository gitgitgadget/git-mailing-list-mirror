Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8E5C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651CE6115C
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbhITQGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 12:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhITQGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 12:06:47 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9480BC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 09:05:20 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w206so13757655oiw.4
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 09:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+V3QSUOG2icyoee3q4JgdvfwOa1lKNt0ZvValxZmXPk=;
        b=ga5p5r2SQehVgf2Vd0nwmI+h5nyNmibIa9h+kCGMM2YW9Yyfu+LkPLlyIhFg46VB2Q
         VlrMYOYzelzNa6TNN52OreoCzgyGivKuAumEad/KrVu13LUL9Myq8KyyQn0D2fCGVavk
         5cSY5G2tn4/10et2fiXpYTGJlolFty7t2KTKcSMaA3f6xfi1gWdpaMADoT7ziE+83BbA
         TTRF3s0NnnT2mnKGXImRxBwDPJo7PqOIyvC55rVLyZOuDXnFrd5GdKnMjaEexc8kvqjX
         NQVSI8BwAJcZJluOljAwsAlVXVzQFdr+TsZD1Z31gQvcJQfR2/9YXyEghk+NZS3fWqrG
         in+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+V3QSUOG2icyoee3q4JgdvfwOa1lKNt0ZvValxZmXPk=;
        b=Cp7P277nvNixKhA6cGhW+S0h7gk+5qQoWNU+E9Pl+28NDWFBJwDgmB4sSXlXh18Itb
         gOJHJLGEzPwEpHJ2i8G09rffeVdAcGIRcdZUCpJJJvu+tcXiWR5yvmNnn3lbQq0RtX3v
         qIKGr+iazXgmNSk7AuaMDB6BwXlZw5jVsOzNpSzCf7TWdLOTAaUlrek/N4DvEqgHaQRK
         JHx8PlpNDYK6ceUwgj/hPNeHmShA1s7qSvAD3ubBeQ9Yf9tJKoq/MAYafO1HLKrPOw2b
         UMIThUzABin9iE3K7/0TaIN+LIyYBEUGg0lJ0Vwrvp03B5WaqMtlssxYAcQZddUmeMVU
         /Kug==
X-Gm-Message-State: AOAM533rCgKibm0XwDLviGhyMKhBv8pLzj71CCUz8ZCB3ELMw/SVIrdc
        McWKvzYhrNMWpfOLpX5wCyk6svFtYEMKge/Nbz8=
X-Google-Smtp-Source: ABdhPJxw/UV5sHbsDsMUCu3gRcICRS080lY58QSiH0fvuI57ZbRgnR1jKeLmTsQ/xCHq2cMD0QGFww+rW24VgyScv4k=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr23635785oib.39.1632153919786;
 Mon, 20 Sep 2021 09:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <45bd05a945f034d03555f04a1ba85835482dc591.1632006923.git.gitgitgadget@gmail.com>
 <acef3628-9542-d777-2534-577de9707e15@gmail.com>
In-Reply-To: <acef3628-9542-d777-2534-577de9707e15@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Sep 2021 09:05:07 -0700
Message-ID: <CABPp-BGnWeFiJ11x8j1J+yjgVB9r858S47y40h8cFQYF4TR1HA@mail.gmail.com>
Subject: Re: [PATCH 2/6] Split unpack_trees 'reset' flag into two for
 untracked handling
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 3:19 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 19/09/2021 00:15, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Traditionally, unpack_trees_options->reset was used to signal that it
> > was okay to delete any untracked files in the way.  This was used by
> > `git read-tree --reset`, but then started appearing in other places as
> > well.  However, many of the other uses should not be deleting untracked
> > files in the way.  Split this into two separate fields:
> >     reset_nuke_untracked
> >     reset_keep_untracked
> > and, since many code paths in unpack_trees need to be followed for both
> > of these flags, introduce a third one for convenience:
> >     reset_either
> > which is simply an or-ing of the other two.
>
> See [1] for an alternative approach that used an enum instead of adding
> mutually exclusive flags.

Oh, interesting.  Any reason you didn't pursue that old series further?

> > Modify existing callers so that
> >     read-tree --reset
>
> it would be nice if read-tree callers could choose whether they want to
> remove untracked files or not - that could always be added later. This
> patch changes the behavior of 'git read-tree -m -u' (and other commands)
> so that they will overwrite ignored files - I'm in favor of that change
> but it would be good to spell out the change in the commit message.

Those commands made no distinction between untracked and ignored files
previously, and overwrote all of them.  This patch changes those
commands so that they stop overwriting untracked files, unless those
files are ignored.  So, there's no change in behavior for ignored
files, only for non-ignored untracked files.

Your suggestion to point out the behavior relative to ignored files in
the commit message, though, is probably a good idea.  I should mention
that ignored files will continue to be removed by these commands.

> >     reset --hard
> >     checkout --force
>
> I often use checkout --force to clear unwanted changes when I'm
> switching branches, I'd prefer it if it did not remove untracked files.

I originally started down that path to see what it looked like, but
Junio weighed in and explicitly called out checkout --force as being a
command that should remove untracked files in the way.  See
https://lore.kernel.org/git/xmqqr1e2ejs9.fsf@gitster.g/.  Seems you
also felt that way previously, at
https://lore.kernel.org/git/d4c36a24-b40c-a6ca-7a05-572ab93a0101@gmail.com/
-- any reason for your change of opinion?

> > continue using reset_nuke_untracked, but so that other callers,
> > including
> >     am
> >     checkout without --force
> >     stash  (though currently dead code; reset always had a value of 0)
> >     numerous callers from rebase/sequencer to reset_head()
> > will use the new reset_keep_untracked field.
>
> This is great. In the discussion around [1] there is a mention of 'git
> checkout <pathspec>' which also overwrites untracked files. It does not
> use unpack_trees() so is arguably outside the scope of what you're doing
> here but it might be worth mentioning.

Oh, that's interesting.  Yeah, that's worth mentioning and perhaps digging into.

>
> > [...]
> > diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> > index 485e7b04794..8b94e1aa261 100644
> > --- a/builtin/read-tree.c
> > +++ b/builtin/read-tree.c
> > @@ -133,7 +133,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
> >                        N_("3-way merge if no file level merging required")),
> >               OPT_BOOL(0, "aggressive", &opts.aggressive,
> >                        N_("3-way merge in presence of adds and removes")),
> > -             OPT_BOOL(0, "reset", &opts.reset,
> > +             OPT_BOOL(0, "reset", &opts.reset_keep_untracked,
> >                        N_("same as -m, but discard unmerged entries")),
> >               { OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
> >                 N_("read the tree into the index under <subdirectory>/"),
> > @@ -162,6 +162,11 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
> >       opts.head_idx = -1;
> >       opts.src_index = &the_index;
> >       opts.dst_index = &the_index;
> > +     if (opts.reset_keep_untracked) {
> > +             opts.dir = xcalloc(1, sizeof(*opts.dir));
> > +             opts.dir->flags |= DIR_SHOW_IGNORED;
> > +             setup_standard_excludes(opts.dir);
> > +     }
>
> Does this clobber any excludes added by --exclude-per-directory?

Oh, um...I've basically implemented a --exclude-standard and assumed
it was passed, ignoring whatever setting of opts.dir was already set
up by exclude-per-directory.  Oops.

> > diff --git a/builtin/reset.c b/builtin/reset.c
> > index 43e855cb887..ba39c4882a6 100644
> > --- a/builtin/reset.c
> > +++ b/builtin/reset.c
> > @@ -10,6 +10,7 @@
> >   #define USE_THE_INDEX_COMPATIBILITY_MACROS
> >   #include "builtin.h"
> >   #include "config.h"
> > +#include "dir.h"
> >   #include "lockfile.h"
> >   #include "tag.h"
> >   #include "object.h"
> > @@ -70,9 +71,19 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
> >               break;
> >       case HARD:
> >               opts.update = 1;
> > -             /* fallthrough */
> > +             opts.reset_nuke_untracked = 1;
> > +             break;
> > +     case MIXED:
> > +             opts.reset_keep_untracked = 1; /* but opts.update=0, so untracked left alone */
> > +             break;
> >       default:
> > -             opts.reset = 1;
> > +             BUG("invalid reset_type passed to reset_index");
>
> There is no case SOFT: but in that case we don't call reset_index() so
> we're OK.
>
> > diff --git a/reset.c b/reset.c
> > index 79310ae071b..0880c76aef9 100644
> > --- a/reset.c
> > +++ b/reset.c
> > @@ -1,5 +1,6 @@
> >   #include "git-compat-util.h"
> >   #include "cache-tree.h"
> > +#include "dir.h"
> >   #include "lockfile.h"
> >   #include "refs.h"
> >   #include "reset.h"
> > @@ -57,8 +58,12 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
> >       unpack_tree_opts.update = 1;
> >       unpack_tree_opts.merge = 1;
> >       init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
> > -     if (!detach_head)
> > -             unpack_tree_opts.reset = 1;
>
> Unrelated to this patch but this looks dodgy to me. For 'git rebase
> <upstream> <branch>' where <branch> is ahead of <upstream> we skip the
> rebase and use reset_head() to checkout <branch> without 'detach_head'
> set. I think this should be checking 'reset_hard' instead of 'detach_head'
>
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index 5786645f315..d952eebe96a 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -301,7 +301,7 @@ static int check_submodule_move_head(const struct cache_entry *ce,
> >       if (!sub)
> >               return 0;
> >
> > -     if (o->reset)
> > +     if (o->reset_nuke_untracked)
> >               flags |= SUBMODULE_MOVE_HEAD_FORCE;
> >
> >       if (submodule_move_head(ce->name, old_id, new_id, flags))
> > @@ -1696,6 +1696,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >       if (len > MAX_UNPACK_TREES)
> >               die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
> >
> > +     if (o->reset_nuke_untracked && o->reset_keep_untracked)
> > +             BUG("reset_nuke_untracked and reset_keep_untracked are incompatible");
> > +
> > +     o->reset_either = 0;
> > +     if (o->reset_nuke_untracked || o->reset_keep_untracked)
> > +             o->reset_either = 1;
>
> <bikeshed>
> o->reset_either = o->reset_nuke_untracked | o->reset_keep_untracked
> </bikeshed>

Goes away entirely if we adopt your enum suggestion.

> > diff --git a/unpack-trees.h b/unpack-trees.h
> > index 2d88b19dca7..c419bf8b1f9 100644
> > --- a/unpack-trees.h
> > +++ b/unpack-trees.h
> > @@ -46,7 +46,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
> >   void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
> >
> >   struct unpack_trees_options {
> > -     unsigned int reset,
> > +     unsigned int reset_nuke_untracked,
> > +                  reset_keep_untracked,
> > +                  reset_either, /* internal use only */
>
> I think I prefer the enum approach in [1] but I'm biased and I'm not
> sure it's worth getting excited about. Thanks for working on this it
> will be great to have git stop overwriting untracked files so often.

I think the enum approach makes sense; I'll try it out.
