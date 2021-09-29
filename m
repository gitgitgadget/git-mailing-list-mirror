Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1923AC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 18:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCDA6141B
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 18:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346213AbhI2Sd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345901AbhI2Sd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 14:33:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B5C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 11:32:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b26so12404820edt.0
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bHkpTad1nOFuoTHztCnWsc01C7fgB/F3Dm4ZFDwcPGY=;
        b=inDAV3yaIlIiNYyINme2rAsQgEoqPCXKk3vE3FHPg/p6sChnWsfsowCeF8EudVWO+9
         CowIl1wXiwxDFxQctCjIvlFsinVAyHjjySZGYEngaexrL7D7id2vlqAhDc3fJy5h/mFe
         yui8zO7V2Z38YYmujLnMvZEJbyXbOfH2uwUWMyrVD4SKmZU3Y7Pl0FaeTnP1wny70Zj0
         EfdrFaaqHHxG2BYt7z3M3Mp5BrQh1VxfpC1dV7J9NwFF6fw9w79Cz4155rmtjY1i/ao8
         PQn2TPgonqFquGCItvezTQ6j+YX0BdcvqI1z0BUYPImNA9Cvy8a73AVzNnR9pFovoJhp
         dhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bHkpTad1nOFuoTHztCnWsc01C7fgB/F3Dm4ZFDwcPGY=;
        b=R3Kxeg315qwqRhbt/ARfdWG+ir4QoWuhXlXa1V5jhqqq9AyGnxmTVMrQUgcTOmRR2D
         yCJ+KOyLkKdKIyB1XRXtsP+7+P5lEZZDOFGqx8oN6vKaO6F+mspzvGjGS65oqLicdcxV
         JnsVPWdhE9c0DujGoFlVYMdVE8jh8atzkNhMloFx/qrLQAoj5b+qFA8OyE44B0G0Naei
         fNIK7u/sGr4+y0TI/BuXv3u5AuTF0vykBglKjGKIzD/s0AQN01XdwsvJcGYNkT32N1Me
         9XfAUxT2W/kJEcEOqG6baRjh+2VqsdQA4S7RHSUeDoEdyLlWvjz59JynpinwPVIruc5u
         F5kw==
X-Gm-Message-State: AOAM532nCG/n+M9d4KwytfOGtN8N/EFKkbbtNbIVQ+yrgxWtl3xzr6Ab
        W55HMLzHN+70qQRRxjcgR6KrfZfgEeU=
X-Google-Smtp-Source: ABdhPJwTztyqASNhgGWRU9HUK/ozcRLzubrC/a6IPTSl/lEVrFLGpOoZPr8krqt6fn9U7POez8wu1A==
X-Received: by 2002:a17:906:7ac5:: with SMTP id k5mr1493019ejo.386.1632940335040;
        Wed, 29 Sep 2021 11:32:15 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p8sm398342ejo.2.2021.09.29.11.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:32:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 04/11] unpack-trees: introduce preserve_ignored to
 unpack_trees_options
Date:   Wed, 29 Sep 2021 20:30:08 +0200
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
 <f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com>
 <87ilyjviiy.fsf@evledraar.gmail.com>
 <CABPp-BEnGfxqKpqXGKopXFBBshY0tuimQLtwt58wKf9CJS8n5g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BEnGfxqKpqXGKopXFBBshY0tuimQLtwt58wKf9CJS8n5g@mail.gmail.com>
Message-ID: <87ee97utaq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 29 2021, Elijah Newren wrote:

> On Wed, Sep 29, 2021 at 2:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Mon, Sep 27 2021, Elijah Newren via GitGitGadget wrote:
>>
>> > From: Elijah Newren <newren@gmail.com>
>> >
>> > Currently, every caller of unpack_trees() that wants to ensure ignored
>> > files are overwritten by default needs to:
>> >    * allocate unpack_trees_options.dir
>> >    * flip the DIR_SHOW_IGNORED flag in unpack_trees_options.dir->flags
>> >    * call setup_standard_excludes
>> > AND then after the call to unpack_trees() needs to
>> >    * call dir_clear()
>> >    * deallocate unpack_trees_options.dir
>> > That's a fair amount of boilerplate, and every caller uses identical
>> > code.  Make this easier by instead introducing a new boolean value whe=
re
>> > the default value (0) does what we want so that new callers of
>> > unpack_trees() automatically get the appropriate behavior.  And move a=
ll
>> > the handling of unpack_trees_options.dir into unpack_trees() itself.
>> >
>> > While preserve_ignored =3D 0 is the behavior we feel is the appropriate
>> > default, we defer fixing commands to use the appropriate default until=
 a
>> > later commit.  So, this commit introduces several locations where we
>> > manually set preserve_ignored=3D1.  This makes it clear where code pat=
hs
>> > were previously preserving ignored files when they should not have bee=
n;
>> > a future commit will flip these to instead use a value of 0 to get the
>> > behavior we want.
>> >
>> > Signed-off-by: Elijah Newren <newren@gmail.com>
>> > ---
>> >  builtin/am.c        |  3 +++
>> >  builtin/checkout.c  | 11 ++---------
>> >  builtin/clone.c     |  2 ++
>> >  builtin/merge.c     |  2 ++
>> >  builtin/read-tree.c | 13 +++----------
>> >  builtin/reset.c     |  2 ++
>> >  builtin/stash.c     |  3 +++
>> >  merge-ort.c         |  8 +-------
>> >  merge-recursive.c   |  8 +-------
>> >  merge.c             |  8 +-------
>> >  reset.c             |  2 ++
>> >  sequencer.c         |  2 ++
>> >  unpack-trees.c      | 10 ++++++++++
>> >  unpack-trees.h      |  1 +
>> >  14 files changed, 35 insertions(+), 40 deletions(-)
>> >
>> > diff --git a/builtin/am.c b/builtin/am.c
>> > index e4a0ff9cd7c..1ee70692bc3 100644
>> > --- a/builtin/am.c
>> > +++ b/builtin/am.c
>> > @@ -1918,6 +1918,9 @@ static int fast_forward_to(struct tree *head, st=
ruct tree *remote, int reset)
>> >       opts.update =3D 1;
>> >       opts.merge =3D 1;
>> >       opts.reset =3D reset;
>> > +     if (!reset)
>> > +             /* FIXME: Default should be to remove ignored files */
>> > +             opts.preserve_ignored =3D 1;
>> >       opts.fn =3D twoway_merge;
>> >       init_tree_desc(&t[0], head->buffer, head->size);
>> >       init_tree_desc(&t[1], remote->buffer, remote->size);
>> > diff --git a/builtin/checkout.c b/builtin/checkout.c
>> > index 5335435d616..5e7957dd068 100644
>> > --- a/builtin/checkout.c
>> > +++ b/builtin/checkout.c
>> > @@ -648,6 +648,7 @@ static int reset_tree(struct tree *tree, const str=
uct checkout_opts *o,
>> >       opts.skip_unmerged =3D !worktree;
>> >       opts.reset =3D 1;
>> >       opts.merge =3D 1;
>> > +     opts.preserve_ignored =3D 0;
>> >       opts.fn =3D oneway_merge;
>> >       opts.verbose_update =3D o->show_progress;
>> >       opts.src_index =3D &the_index;
>> > @@ -746,11 +747,7 @@ static int merge_working_tree(const struct checko=
ut_opts *opts,
>> >                                      new_branch_info->commit ?
>> >                                      &new_branch_info->commit->object.=
oid :
>> >                                      &new_branch_info->oid, NULL);
>> > -             if (opts->overwrite_ignore) {
>> > -                     topts.dir =3D xcalloc(1, sizeof(*topts.dir));
>> > -                     topts.dir->flags |=3D DIR_SHOW_IGNORED;
>> > -                     setup_standard_excludes(topts.dir);
>> > -             }
>> > +             topts.preserve_ignored =3D !opts->overwrite_ignore;
>> >               tree =3D parse_tree_indirect(old_branch_info->commit ?
>> >                                          &old_branch_info->commit->obj=
ect.oid :
>> >                                          the_hash_algo->empty_tree);
>> > @@ -760,10 +757,6 @@ static int merge_working_tree(const struct checko=
ut_opts *opts,
>> >               init_tree_desc(&trees[1], tree->buffer, tree->size);
>> >
>> >               ret =3D unpack_trees(2, trees, &topts);
>> > -             if (topts.dir) {
>> > -                     dir_clear(topts.dir);
>> > -                     FREE_AND_NULL(topts.dir);
>> > -             }
>> >               clear_unpack_trees_porcelain(&topts);
>> >               if (ret =3D=3D -1) {
>> >                       /*
>> > diff --git a/builtin/clone.c b/builtin/clone.c
>> > index ff1d3d447a3..be1c3840d62 100644
>> > --- a/builtin/clone.c
>> > +++ b/builtin/clone.c
>> > @@ -687,6 +687,8 @@ static int checkout(int submodule_progress)
>> >       opts.update =3D 1;
>> >       opts.merge =3D 1;
>> >       opts.clone =3D 1;
>> > +     /* FIXME: Default should be to remove ignored files */
>> > +     opts.preserve_ignored =3D 1;
>> >       opts.fn =3D oneway_merge;
>> >       opts.verbose_update =3D (option_verbosity >=3D 0);
>> >       opts.src_index =3D &the_index;
>> > diff --git a/builtin/merge.c b/builtin/merge.c
>> > index 3fbdacc7db4..1e5fff095fc 100644
>> > --- a/builtin/merge.c
>> > +++ b/builtin/merge.c
>> > @@ -680,6 +680,8 @@ static int read_tree_trivial(struct object_id *com=
mon, struct object_id *head,
>> >       opts.verbose_update =3D 1;
>> >       opts.trivial_merges_only =3D 1;
>> >       opts.merge =3D 1;
>> > +     /* FIXME: Default should be to remove ignored files */
>> > +     opts.preserve_ignored =3D 1;
>> >       trees[nr_trees] =3D parse_tree_indirect(common);
>> >       if (!trees[nr_trees++])
>> >               return -1;
>> > diff --git a/builtin/read-tree.c b/builtin/read-tree.c
>> > index 73cb957a69b..443d206eca6 100644
>> > --- a/builtin/read-tree.c
>> > +++ b/builtin/read-tree.c
>> > @@ -201,11 +201,9 @@ int cmd_read_tree(int argc, const char **argv, co=
nst char *cmd_prefix)
>> >       if ((opts.update || opts.index_only) && !opts.merge)
>> >               die("%s is meaningless without -m, --reset, or --prefix",
>> >                   opts.update ? "-u" : "-i");
>> > -     if (opts.update && !opts.reset) {
>> > -             CALLOC_ARRAY(opts.dir, 1);
>> > -             opts.dir->flags |=3D DIR_SHOW_IGNORED;
>> > -             setup_standard_excludes(opts.dir);
>> > -     }
>> > +     if (opts.update && !opts.reset)
>> > +             opts.preserve_ignored =3D 0;
>> > +     /* otherwise, opts.preserve_ignored is irrelevant */
>> >       if (opts.merge && !opts.index_only)
>> >               setup_work_tree();
>> >
>> > @@ -245,11 +243,6 @@ int cmd_read_tree(int argc, const char **argv, co=
nst char *cmd_prefix)
>> >       if (unpack_trees(nr_trees, t, &opts))
>> >               return 128;
>> >
>> > -     if (opts.dir) {
>> > -             dir_clear(opts.dir);
>> > -             FREE_AND_NULL(opts.dir);
>> > -     }
>> > -
>> >       if (opts.debug_unpack || opts.dry_run)
>> >               return 0; /* do not write the index out */
>> >
>> > diff --git a/builtin/reset.c b/builtin/reset.c
>> > index 51c9e2f43ff..7f38656f018 100644
>> > --- a/builtin/reset.c
>> > +++ b/builtin/reset.c
>> > @@ -67,6 +67,8 @@ static int reset_index(const char *ref, const struct=
 object_id *oid, int reset_t
>> >       case KEEP:
>> >       case MERGE:
>> >               opts.update =3D 1;
>> > +             /* FIXME: Default should be to remove ignored files */
>> > +             opts.preserve_ignored =3D 1;
>> >               break;
>> >       case HARD:
>> >               opts.update =3D 1;
>> > diff --git a/builtin/stash.c b/builtin/stash.c
>> > index 8f42360ca91..88287b890d5 100644
>> > --- a/builtin/stash.c
>> > +++ b/builtin/stash.c
>> > @@ -258,6 +258,9 @@ static int reset_tree(struct object_id *i_tree, in=
t update, int reset)
>> >       opts.merge =3D 1;
>> >       opts.reset =3D reset;
>> >       opts.update =3D update;
>> > +     if (update && !reset)
>> > +             /* FIXME: Default should be to remove ignored files */
>> > +             opts.preserve_ignored =3D 1;
>> >       opts.fn =3D oneway_merge;
>> >
>> >       if (unpack_trees(nr_trees, t, &opts))
>> > diff --git a/merge-ort.c b/merge-ort.c
>> > index 35aa979c3a4..0d64ec716bd 100644
>> > --- a/merge-ort.c
>> > +++ b/merge-ort.c
>> > @@ -4045,11 +4045,7 @@ static int checkout(struct merge_options *opt,
>> >       unpack_opts.quiet =3D 0; /* FIXME: sequencer might want quiet? */
>> >       unpack_opts.verbose_update =3D (opt->verbosity > 2);
>> >       unpack_opts.fn =3D twoway_merge;
>> > -     if (1/* FIXME: opts->overwrite_ignore*/) {
>> > -             CALLOC_ARRAY(unpack_opts.dir, 1);
>> > -             unpack_opts.dir->flags |=3D DIR_SHOW_IGNORED;
>> > -             setup_standard_excludes(unpack_opts.dir);
>> > -     }
>> > +     unpack_opts.preserve_ignored =3D 0; /* FIXME: !opts->overwrite_i=
gnore*/
>> >       parse_tree(prev);
>> >       init_tree_desc(&trees[0], prev->buffer, prev->size);
>> >       parse_tree(next);
>> > @@ -4057,8 +4053,6 @@ static int checkout(struct merge_options *opt,
>> >
>> >       ret =3D unpack_trees(2, trees, &unpack_opts);
>> >       clear_unpack_trees_porcelain(&unpack_opts);
>> > -     dir_clear(unpack_opts.dir);
>> > -     FREE_AND_NULL(unpack_opts.dir);
>> >       return ret;
>> >  }
>> >
>> > diff --git a/merge-recursive.c b/merge-recursive.c
>> > index 233d9f686ad..2be3f5d4044 100644
>> > --- a/merge-recursive.c
>> > +++ b/merge-recursive.c
>> > @@ -411,9 +411,7 @@ static int unpack_trees_start(struct merge_options=
 *opt,
>> >       else {
>> >               opt->priv->unpack_opts.update =3D 1;
>> >               /* FIXME: should only do this if !overwrite_ignore */
>> > -             CALLOC_ARRAY(opt->priv->unpack_opts.dir, 1);
>> > -             opt->priv->unpack_opts.dir->flags |=3D DIR_SHOW_IGNORED;
>> > -             setup_standard_excludes(opt->priv->unpack_opts.dir);
>> > +             opt->priv->unpack_opts.preserve_ignored =3D 0;
>> >       }
>> >       opt->priv->unpack_opts.merge =3D 1;
>> >       opt->priv->unpack_opts.head_idx =3D 2;
>> > @@ -428,10 +426,6 @@ static int unpack_trees_start(struct merge_option=
s *opt,
>> >       init_tree_desc_from_tree(t+2, merge);
>> >
>> >       rc =3D unpack_trees(3, t, &opt->priv->unpack_opts);
>> > -     if (opt->priv->unpack_opts.dir) {
>> > -             dir_clear(opt->priv->unpack_opts.dir);
>> > -             FREE_AND_NULL(opt->priv->unpack_opts.dir);
>> > -     }
>> >       cache_tree_free(&opt->repo->index->cache_tree);
>> >
>> >       /*
>> > diff --git a/merge.c b/merge.c
>> > index 6e736881d90..2382ff66d35 100644
>> > --- a/merge.c
>> > +++ b/merge.c
>> > @@ -53,7 +53,6 @@ int checkout_fast_forward(struct repository *r,
>> >       struct unpack_trees_options opts;
>> >       struct tree_desc t[MAX_UNPACK_TREES];
>> >       int i, nr_trees =3D 0;
>> > -     struct dir_struct dir =3D DIR_INIT;
>> >       struct lock_file lock_file =3D LOCK_INIT;
>> >
>> >       refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
>> > @@ -80,11 +79,7 @@ int checkout_fast_forward(struct repository *r,
>> >       }
>> >
>> >       memset(&opts, 0, sizeof(opts));
>> > -     if (overwrite_ignore) {
>> > -             dir.flags |=3D DIR_SHOW_IGNORED;
>> > -             setup_standard_excludes(&dir);
>> > -             opts.dir =3D &dir;
>> > -     }
>> > +     opts.preserve_ignored =3D !overwrite_ignore;
>> >
>> >       opts.head_idx =3D 1;
>> >       opts.src_index =3D r->index;
>> > @@ -101,7 +96,6 @@ int checkout_fast_forward(struct repository *r,
>> >               clear_unpack_trees_porcelain(&opts);
>> >               return -1;
>> >       }
>> > -     dir_clear(&dir);
>> >       clear_unpack_trees_porcelain(&opts);
>> >
>> >       if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
>> > diff --git a/reset.c b/reset.c
>> > index 79310ae071b..41b3e2d88de 100644
>> > --- a/reset.c
>> > +++ b/reset.c
>> > @@ -56,6 +56,8 @@ int reset_head(struct repository *r, struct object_i=
d *oid, const char *action,
>> >       unpack_tree_opts.fn =3D reset_hard ? oneway_merge : twoway_merge;
>> >       unpack_tree_opts.update =3D 1;
>> >       unpack_tree_opts.merge =3D 1;
>> > +     /* FIXME: Default should be to remove ignored files */
>> > +     unpack_tree_opts.preserve_ignored =3D 1;
>> >       init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch,=
 oid, NULL);
>> >       if (!detach_head)
>> >               unpack_tree_opts.reset =3D 1;
>> > diff --git a/sequencer.c b/sequencer.c
>> > index 614d56f5e21..098566c68d9 100644
>> > --- a/sequencer.c
>> > +++ b/sequencer.c
>> > @@ -3699,6 +3699,8 @@ static int do_reset(struct repository *r,
>> >       unpack_tree_opts.fn =3D oneway_merge;
>> >       unpack_tree_opts.merge =3D 1;
>> >       unpack_tree_opts.update =3D 1;
>> > +     /* FIXME: Default should be to remove ignored files */
>> > +     unpack_tree_opts.preserve_ignored =3D 1;
>> >       init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
>> >
>> >       if (repo_read_index_unmerged(r)) {
>> > diff --git a/unpack-trees.c b/unpack-trees.c
>> > index 8ea0a542da8..1e4eae1dc7d 100644
>> > --- a/unpack-trees.c
>> > +++ b/unpack-trees.c
>> > @@ -1707,6 +1707,12 @@ int unpack_trees(unsigned len, struct tree_desc=
 *t, struct unpack_trees_options
>> >               ensure_full_index(o->dst_index);
>> >       }
>> >
>> > +     if (!o->preserve_ignored) {
>> > +             CALLOC_ARRAY(o->dir, 1);
>> > +             o->dir->flags |=3D DIR_SHOW_IGNORED;
>> > +             setup_standard_excludes(o->dir);
>> > +     }
>> > +
>> >       if (!core_apply_sparse_checkout || !o->update)
>> >               o->skip_sparse_checkout =3D 1;
>> >       if (!o->skip_sparse_checkout && !o->pl) {
>> > @@ -1868,6 +1874,10 @@ int unpack_trees(unsigned len, struct tree_desc=
 *t, struct unpack_trees_options
>> >  done:
>> >       if (free_pattern_list)
>> >               clear_pattern_list(&pl);
>> > +     if (o->dir) {
>> > +             dir_clear(o->dir);
>> > +             FREE_AND_NULL(o->dir);
>> > +     }
>> >       trace2_region_leave("unpack_trees", "unpack_trees", the_reposito=
ry);
>> >       trace_performance_leave("unpack_trees");
>> >       return ret;
>> > diff --git a/unpack-trees.h b/unpack-trees.h
>> > index 2d88b19dca7..f98cfd49d7b 100644
>> > --- a/unpack-trees.h
>> > +++ b/unpack-trees.h
>> > @@ -49,6 +49,7 @@ struct unpack_trees_options {
>> >       unsigned int reset,
>> >                    merge,
>> >                    update,
>> > +                  preserve_ignored,
>> >                    clone,
>> >                    index_only,
>> >                    nontrivial_merge,
>>
>> I think getting rid of the boilerplate makes sense, but it doesn't sound
>> from the commit message like you've considered just making that "struct
>> dir*" member a "struct dir" instead.
>>
>> That simplifies things a lot, i.e. we can just DIR_INIT it, and don't
>> need every caller to malloc/free it.
>
> See the next patch in the series.  :-)

Ah!

>> Sometimes a pointer makes sense, but in this case the "struct
>> unpack_trees_options" can just own it.
>
> I did make it internal to unpack_trees_options in the next patch, but
> kept it as a pointer just because that let me know whether it was used
> or not.  I guess I could have added a boolean as well.  But I don't
> actually allocate anything, because it's either a NULL pointer, or a
> pointer to something on the stack.  So, I do get to just use DIR_INIT.

I think I'm probably missing something. I just made it allocated on the
stack by the caller using "struct unpack_trees_options", but then you
end up having a dir* in the struct, but that's only filled in as a
pointer to the stack variable? Maybe there's some subtlety I'm missing
here...
