Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57128C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B5F2051A
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP0X0eR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbgCPRCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:02:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33091 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731703AbgCPRCk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 13:02:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id r7so18601414oij.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PipT9+YOEkMWBDg7DFZ6tmbxPuigA397H+9Xf/VAJ2Q=;
        b=fP0X0eR/2KQr/poSX/vQ1E+2Y8pTH7hrMPjMHFdYoJWIgrJ7dy2PpyGD+I3jMXuoeY
         Sa2MFG0DXASMk6c+QoYrqhKw19klTPu9pLaXtl7jvvhKM29uDfOmNidaz2x+RtaCP63z
         MD6lMPV+I0Va4QtOGCug3wHp2wMbGP+l2I2OyCN9SP0hr3eflsE3FdJvEpAjmQvfzmQE
         11KdXdtV0ui0uGMyjeZX6GrBF/I5e09tS/rnBJ7XH2n0CpxvGwaM7zUpgIPqHPhT6NrB
         qEmyVyavPncRankcmacF6yO9NO31Oudt4MYqr5xy6WBNPo18eHAWe5ynDQugwDtzHuDj
         /Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PipT9+YOEkMWBDg7DFZ6tmbxPuigA397H+9Xf/VAJ2Q=;
        b=abmMhodmCS5n7mrOxjuVbtdVI9OSwzSLDqK7YjMM3LMAq1GAed2NGnwUYueiA7o1yU
         LSXSr8LUCb1Asx5/+dmfdR6gcur0/TPhEb9p33SCq8kGfKWDvM7trPT24C80Av7g2z8v
         +EJZehpDuoMNTwmzQm+ypIxjMKZG5hhKZ9+wpLJ6XrWeYyNIyg4oeJgSrrFVIO/qAZPr
         MO8lLLQoKRylAblRfMTZ5ddg0R8udxO+KghyPDGcaVrBs/U0DKm7wcVwbgzOzlfD/biM
         +k0E4me9XknXsMW3aWilGCsUNTS+tdD06Uqqo+qBSn2Pb325yiGsb+qvpctHu8PCzjyl
         cpgg==
X-Gm-Message-State: ANhLgQ1g6FWMiEPd/tXORP0+b/xoGjkvIJxGE9Jtb6OjAeMGb2cbEK/a
        48GxIzZnWMuqGcW4AERuYBhzW7bQK07D+RF2ODpZ5g==
X-Google-Smtp-Source: ADFU+vvURymVIpcoVp6VnwrZKvgdX0JGXWqbdQDaHdGzrn2zYkJ6vrhyyxYa1GGkIfj9LsM1zfaPaFcAZfexeKQ9ZI0=
X-Received: by 2002:aca:d9c1:: with SMTP id q184mr393113oig.6.1584378158147;
 Mon, 16 Mar 2020 10:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <892933752c638a9ed938e046e466dd1e927058a6.1584169893.git.gitgitgadget@gmail.com>
 <1c83fb68-519a-88f2-77b9-ab443ed6b4cf@gmail.com>
In-Reply-To: <1c83fb68-519a-88f2-77b9-ab443ed6b4cf@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Mar 2020 10:02:26 -0700
Message-ID: <CABPp-BEPCpN=gW=LC7JBbJNmqhYxEhQJi6ycV21zhmuFAta3gw@mail.gmail.com>
Subject: Re: [PATCH 6/7] sparse-checkout: use new update_sparsity() function
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 15, 2020 at 9:19 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/14/2020 3:11 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Remove the equivalent of 'git read-tree -mu HEAD' in the sparse-checkout
> > codepaths for setting the SKIP_WORKTREE bits and instead use the new
> > update_sparsity() function.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/sparse-checkout.c          | 39 +++++++-----------------------
> >  t/t1091-sparse-checkout-builtin.sh | 32 +++++++++++++++++-------
> >  2 files changed, 32 insertions(+), 39 deletions(-)
> >
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index 740da4b6d54..5d3ec2e6be9 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -97,47 +97,32 @@ static int update_working_directory(struct pattern_list *pl)
> >       int result = 0;
> >       struct unpack_trees_options o;
> >       struct lock_file lock_file = LOCK_INIT;
> > -     struct object_id oid;
> > -     struct tree *tree;
> > -     struct tree_desc t;
> >       struct repository *r = the_repository;
> >
> > -     if (repo_read_index_unmerged(r))
> > -             die(_("you need to resolve your current index first"));
> > -
> > -     if (get_oid("HEAD", &oid))
> > -             return 0;
> > -
> > -     tree = parse_tree_indirect(&oid);
> > -     parse_tree(tree);
> > -     init_tree_desc(&t, tree->buffer, tree->size);
> > -
> >       memset(&o, 0, sizeof(o));
> >       o.verbose_update = isatty(2);
> > -     o.merge = 1;
> >       o.update = 1;
> > -     o.fn = oneway_merge;
>
> I'm glad this is getting much simpler.
>
> >       o.head_idx = -1;
> >       o.src_index = r->index;
> >       o.dst_index = r->index;
> >       o.skip_sparse_checkout = 0;
> >       o.pl = pl;
> > -     o.keep_pattern_list = !!pl;
>
> I'm making a mental note to see if this is necessary or not. I'm
> guessing that update_sparsity() expects a pattern list as input and
> will never free it, so this option is useless.

Yes, although your comment made me realize that I've got a memory leak
if we pass o->pl==NULL to update_sparsity(), which happens whenever we
pass NULL to update_working_directory().  I should fix that.

> > -     resolve_undo_clear_index(r->index);
> >       setup_work_tree();
> >
> > -     cache_tree_free(&r->index->cache_tree);
> > -
> >       repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
> >
> > -     core_apply_sparse_checkout = 1;
> > -     result = unpack_trees(1, &t, &o);
> > +     result = update_sparsity(&o);
> >
> > -     if (!result) {
> > -             prime_cache_tree(r, r->index, tree);
> > +     if (result == 1)
> I wonder if it is appropriate to return an enum in update_sparsity()
> so this statement is clearer out-of-context. For example, I'm looking
> at this patch before looking closely at the update_sparsity() patch
> so I know how it will be used before I check its implementation.

Yes, that'd be better.

> > +             /*
> > +              * We don't do any special handling of warnings from untracked
> > +              * files in the way or dirty entries that can't be removed.
> > +              */
> > +             result = 0;
> > +     if (!result)
> >               write_locked_index(r->index, &lock_file, COMMIT_LOCK);
> > -     } else
> > +     else
> >               rollback_lock_file(&lock_file);
> >
> >       return result;
> > @@ -304,8 +289,6 @@ static int sparse_checkout_init(int argc, const char **argv)
> >       };
> >
> >       repo_read_index(the_repository);
> > -     require_clean_work_tree(the_repository,
> > -                             N_("initialize sparse-checkout"), NULL, 1, 0);
> >
> >       argc = parse_options(argc, argv, NULL,
> >                            builtin_sparse_checkout_init_options,
> > @@ -560,8 +543,6 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
> >       };
> >
> >       repo_read_index(the_repository);
> > -     require_clean_work_tree(the_repository,
> > -                             N_("set sparse-checkout patterns"), NULL, 1, 0);
> >
> >       argc = parse_options(argc, argv, prefix,
> >                            builtin_sparse_checkout_set_options,
> > @@ -577,8 +558,6 @@ static int sparse_checkout_disable(int argc, const char **argv)
> >       struct strbuf match_all = STRBUF_INIT;
> >
> >       repo_read_index(the_repository);
> > -     require_clean_work_tree(the_repository,
> > -                             N_("disable sparse-checkout"), NULL, 1, 0);
>
> In the three hunks above, do we still need repo_read_index()?
>
> >       memset(&pl, 0, sizeof(pl));
> >       hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
> > diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> > index 8607a8e6d1a..0d93d3983e0 100755
> > --- a/t/t1091-sparse-checkout-builtin.sh
> > +++ b/t/t1091-sparse-checkout-builtin.sh
> > @@ -277,16 +277,23 @@ test_expect_success 'cone mode: add parent path' '
> >       check_files repo a deep folder1
> >  '
> >
> > -test_expect_success 'revert to old sparse-checkout on bad update' '
> > +test_expect_success 'not-up-to-date does not block rest of sparsification' '
> >       test_when_finished git -C repo sparse-checkout disable &&
> >       test_when_finished git -C repo reset --hard &&
> >       git -C repo sparse-checkout set deep &&
> > +
> >       echo update >repo/deep/deeper2/a &&
> >       cp repo/.git/info/sparse-checkout expect &&
> > -     test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
> > -     test_i18ngrep "cannot set sparse-checkout patterns" err &&
> > -     test_cmp repo/.git/info/sparse-checkout expect &&
> > -     check_files repo/deep a deeper1 deeper2
> > +     test_write_lines "!/deep/*/" "/deep/deeper1/" >>expect &&
> > +
> > +     git -C repo sparse-checkout set deep/deeper1 2>err &&
> > +
> > +     test_i18ngrep "Cannot update sparse checkout" err &&
> > +     test_cmp expect repo/.git/info/sparse-checkout &&
> > +     check_files repo/deep a deeper1 deeper2 &&
> > +     check_files repo/deep/deeper1 a deepest &&
> > +     check_files repo/deep/deeper1/deepest a &&
> > +     check_files repo/deep/deeper2 a
> >  '
> >
> >  test_expect_success 'revert to old sparse-checkout on empty update' '
> > @@ -316,12 +323,19 @@ test_expect_success '.gitignore should not warn about cone mode' '
> >       test_i18ngrep ! "disabling cone patterns" err
> >  '
> >
> > -test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status' '
> > +test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status' '
> >       git clone repo dirty &&
> >       echo dirty >dirty/folder1/a &&
> > -     test_must_fail git -C dirty sparse-checkout init &&
> > -     test_must_fail git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
> > -     test_must_fail git -C dirty sparse-checkout disable &&
> > +
> > +     git -C dirty sparse-checkout init 2>err &&
> > +     test_i18ngrep "warning.*Cannot update sparse checkout" err &&
> > +
> > +     git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
> > +     test_i18ngrep "warning.*Cannot update sparse checkout" err &&
> > +
> > +     git -C dirty sparse-checkout disable &&
> > +     test_i18ngrep "warning.*Cannot update sparse checkout" err &&
> > +
> >       git -C dirty reset --hard &&
> >       git -C dirty sparse-checkout init &&
> >       git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
>
> I like that the test changes here are limited to updating existing
> tests. You mentioned adding more tests, which I would also like, but
> those can come in a follow-up patch that is dedicated to all the fun
> situations we can get into, and how we should respond.
>
> Here are a few that I've tested manually:
>
> 1. Start: no sparse-checkout
>   a. Get into rebase conflict in a directory.
>   b. "git sparse-checkout init --cone"
>   c. See that the file is on-disk with conflict markers.
>   d. Resolve conflict and "git add"
>   e. "git sparse-checkout set <dir-without-conflict>"
>   f. Sparse-checkout is set as expected, file is not on disk, but still staged.
>   g. "git rebase --continue" succeeds.
>
> 2. Start: sparse-checkout set to "dir1"
>   a. Get into merge conflict in "dir2"
>   b. Resolve conflict, "git add"
>   c. "git sparse-checkout update" (available after next patch)
>   d. dir1 gone, dir1/file staged.
>   e. git merge --continue succeeds
>
> Those are the really big ones to me, but I'm sure we will find others.
> I'm really happy that this is working as we expect.

Thanks for taking a look.
