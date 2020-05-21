Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0BCC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 07:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D322D2065F
	for <git@archiver.kernel.org>; Thu, 21 May 2020 07:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTAmG90j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgEUHgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 03:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgEUHgy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 03:36:54 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70345C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 00:36:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z3so4786890otp.9
        for <git@vger.kernel.org>; Thu, 21 May 2020 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5Rd6PptHNlUJqoXwX1maykzBbb133+6sKDQTGJCY7Y=;
        b=eTAmG90jdl7xT4xst+SuogVPOwYl9zTPG6r54hfomOokeEluYp2f2V59svkNhQB5pE
         h9YSHE5x0kpY3FzrLh7EELPsADiVPpR/DSSPRiRgsWfzuO3XBkys9AvKb8SvzGy12AQH
         2M1mWQFYBDldkfGBj2eFlAqPiLFaLHLuoK2bC6etFsPSSbXKdyCWZfYFJxeMWt2SWYSo
         6yvsBsJMAURaGFdldTQ44e7THLODvshSWJgSUUGytOsEcav4P2ybGG2ecMpFgdVWScCA
         QolN8R480Ub2C8i/aJZu4ZCI7xw2acW9qcFq/PZI19qM8uMv0+WInHPDbwWFNXzcgslt
         4XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5Rd6PptHNlUJqoXwX1maykzBbb133+6sKDQTGJCY7Y=;
        b=ClLMy9Yc0zF8c48N7UvSMe88plLXEiYzrPMvRQ93ZMznSlDEfgnquPyRCnRTBvJuO4
         GtsWacWWObPIAFZUlYd9jAJHWIukKRZnajtm3agA4EoARIDTka0yzupGjPgpaV6YlqS1
         FU+PQIKUkCUjEwXSis5S1/BwUjZrCsbV4+Nef6nVRGISp4upykZdM1LW4Hzd4HcYPUXV
         on2drjyKIx1ELIE+IEyK11zdZMNDcqPaiqGBT5Br0jfaDAGNHs6mXyKLHuHvODrca3IL
         1Yx57dIVwdGpeZvAK67krUnvum7r9FIRZCYF7ulMCg4XqDdIpuqzRZd5yqJn6NdoDKO4
         NTng==
X-Gm-Message-State: AOAM530cpLy5lNBhJbqiGiCFEdtuQwSNRm/n0UBpWbxw6XfyJ7liGgUs
        5RxsH7iPJI4WW3HezX5yPSF9YIoQ45F4tJqdzIw=
X-Google-Smtp-Source: ABdhPJykrl2tCZuOV5Qvd34enIWJ2w6/bhVxTVqFfCQn/yG241+S8LBvtKn89KIEsq3sl/MwHw1hghytsyksV8IaSFc=
X-Received: by 2002:a9d:24e5:: with SMTP id z92mr6297329ota.345.1590046612621;
 Thu, 21 May 2020 00:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589058209.git.matheus.bernardino@usp.br>
 <e00674c7278b032b826110f33e25a5dee176c7ba.1589058209.git.matheus.bernardino@usp.br>
 <xmqqh7wmqn7k.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7wmqn7k.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 May 2020 00:36:41 -0700
Message-ID: <CABPp-BFdb=5W7EfVsT9Nc52M=da5UE73wPNfvTEGLAbdfHnJFA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 11, 2020 at 12:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > One of the main uses for a sparse checkout is to allow users to focus on
> > the subset of files in a repository in which they are interested. But
> > git-grep currently ignores the sparsity patterns and report all matches
> > found outside this subset, which kind of goes in the opposite direction.
> > Let's fix that, making it honor the sparsity boundaries for every
> > grepping case:
> >
> > - git grep in worktree
> > - git grep --cached
> > - git grep $REVISION
>
> It makes sense for these to be limited within the "sparse" area.
>
> > - git grep --untracked and git grep --no-index (which already respect
> >   sparse checkout boundaries)
>
> I can understand the former; those untracked files are what _could_
> be brought into attention by "git add", so limiting to the same
> "sparse" area may make sense.
>
> I am not sure about the latter, though, as "--no-index" is an
> explicit request to pretend that we are dealing with a random
> collection of files, not managed in a git repository.  But perhaps
> there is a similar justification like how "--untracked" is
> unjustifiable.  I dunno.

I don't think it makes sense for sparsity patterns to affect either.
sparsity patterns are a way of splitting "tracked" files into two
subsets (those matching the sparsity paths and those that don't).
Therefore, flags that are about searching things that aren't tracked,
clearly don't have anything to do with sparsity patterns.

However, I think this was just a wording issue; in the subsequent
commit Matheus made it clear that he's not modifying the behavior of
grep --untracked or grep --no-index based on the presence or absence
of sparsity patterns.

> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index a5056f395a..91ee0b2734 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -410,7 +410,7 @@ static int grep_cache(struct grep_opt *opt,
> >                     const struct pathspec *pathspec, int cached);
> >  static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> >                    struct tree_desc *tree, struct strbuf *base, int tn_len,
> > -                  int check_attr);
> > +                  int is_root_tree);
> >
> >  static int grep_submodule(struct grep_opt *opt,
> >                         const struct pathspec *pathspec,
> > @@ -508,6 +508,10 @@ static int grep_cache(struct grep_opt *opt,
> >
> >       for (nr = 0; nr < repo->index->cache_nr; nr++) {
> >               const struct cache_entry *ce = repo->index->cache[nr];
> > +
> > +             if (ce_skip_worktree(ce) && !S_ISGITLINK(ce->ce_mode))
> > +                     continue;
>
> Hmph.  Why exclude gitlink from this rule?  If a submodule sits at a
> path that is excluded by the sparse pattern, should we still recurse
> into it?

That bothers me too.

> >               strbuf_setlen(&name, name_base_len);
> >               strbuf_addstr(&name, ce->name);
> >
> > @@ -520,8 +524,7 @@ static int grep_cache(struct grep_opt *opt,
> >                        * cache entry are identical, even if worktree file has
> >                        * been modified, so use cache version instead
> >                        */
> > -                     if (cached || (ce->ce_flags & CE_VALID) ||
> > -                         ce_skip_worktree(ce)) {
> > +                     if (cached || (ce->ce_flags & CE_VALID)) {
> >                               if (ce_stage(ce) || ce_intent_to_add(ce))
> >                                       continue;
> >                               hit |= grep_oid(opt, &ce->oid, name.buf,
> > @@ -552,9 +555,78 @@ static int grep_cache(struct grep_opt *opt,
> >       return hit;
> >  }
> >
> > -static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> > -                  struct tree_desc *tree, struct strbuf *base, int tn_len,
> > -                  int check_attr)
> > +static struct pattern_list *get_sparsity_patterns(struct repository *repo)
> > +{
> > +     struct pattern_list *patterns;
> > +     char *sparse_file;
> > +     int sparse_config, cone_config;
> > +
> > +     if (repo_config_get_bool(repo, "core.sparsecheckout", &sparse_config) ||
> > +         !sparse_config) {
> > +             return NULL;
> > +     }
> > +
> > +     sparse_file = repo_git_path(repo, "info/sparse-checkout");
> > +     patterns = xcalloc(1, sizeof(*patterns));
> > +
> > +     if (repo_config_get_bool(repo, "core.sparsecheckoutcone", &cone_config))
> > +             cone_config = 0;
> > +     patterns->use_cone_patterns = cone_config;
> > +
> > +     if (add_patterns_from_file_to_list(sparse_file, "", 0, patterns, NULL)) {
> > +             if (file_exists(sparse_file)) {
> > +                     warning(_("failed to load sparse-checkout file: '%s'"),
> > +                             sparse_file);
> > +             }
> > +             free(sparse_file);
> > +             free(patterns);
> > +             return NULL;
> > +     }
> > +
> > +     free(sparse_file);
> > +     return patterns;
> > +}
> > +
> > +static int in_sparse_checkout(struct strbuf *path, int prefix_len,
> > +                           unsigned int entry_mode,
> > +                           struct index_state *istate,
> > +                           struct pattern_list *sparsity,
> > +                           enum pattern_match_result parent_match,
> > +                           enum pattern_match_result *match)
> > +{
> > +     int dtype = DT_UNKNOWN;
> > +
> > +     if (S_ISGITLINK(entry_mode))
> > +             return 1;
>
> This is consistent with the "we do not care where a gitlink
> appears---submodules are always descended into, regardless of the
> sparse definition" decision we saw earlier, I think.  I am not sure
> if that is a good design in the first place, though.
>
> > +     if (parent_match == MATCHED_RECURSIVE) {
> > +             *match = parent_match;
> > +             return 1;
> > +     }
> > +
> > +     if (S_ISDIR(entry_mode) && !is_dir_sep(path->buf[path->len - 1]))
> > +             strbuf_addch(path, '/');
> > +
> > +     *match = path_matches_pattern_list(path->buf, path->len,
> > +                                        path->buf + prefix_len, &dtype,
> > +                                        sparsity, istate);
> > +     if (*match == UNDECIDED)
> > +             *match = parent_match;
> > +
> > +     if (S_ISDIR(entry_mode))
> > +             strbuf_trim_trailing_dir_sep(path);
> > +
> > +     if (*match == NOT_MATCHED && (S_ISREG(entry_mode) ||
> > +         (S_ISDIR(entry_mode) && sparsity->use_cone_patterns)))
> > +             return 0;
> > +
> > +     return 1;
> > +}
>
>
>
> > +static int do_grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> > +                     struct tree_desc *tree, struct strbuf *base, int tn_len,
> > +                     int check_attr, struct pattern_list *sparsity,
> > +                     enum pattern_match_result default_sparsity_match)
> >  {
> >       struct repository *repo = opt->repo;
> >       int hit = 0;
> > @@ -570,6 +642,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> >
> >       while (tree_entry(tree, &entry)) {
> >               int te_len = tree_entry_len(&entry);
> > +             enum pattern_match_result sparsity_match = 0;
> >
> >               if (match != all_entries_interesting) {
> >                       strbuf_addstr(&name, base->buf + tn_len);
> > @@ -586,6 +659,19 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> >
> >               strbuf_add(base, entry.path, te_len);
> >
> > +             if (sparsity) {
> > +                     struct strbuf path = STRBUF_INIT;
> > +                     strbuf_addstr(&path, base->buf + tn_len);
> > +
> > +                     if (!in_sparse_checkout(&path, old_baselen - tn_len,
> > +                                             entry.mode, repo->index,
> > +                                             sparsity, default_sparsity_match,
> > +                                             &sparsity_match)) {
> > +                             strbuf_setlen(base, old_baselen);
> > +                             continue;
> > +                     }
> > +             }
>
> OK.
>
> >               if (S_ISREG(entry.mode)) {
> >                       hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
> >                                        check_attr ? base->buf + tn_len : NULL);
> > @@ -602,8 +688,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> >
> >                       strbuf_addch(base, '/');
> >                       init_tree_desc(&sub, data, size);
> > -                     hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
> > -                                      check_attr);
> > +                     hit |= do_grep_tree(opt, pathspec, &sub, base, tn_len,
> > +                                         check_attr, sparsity, sparsity_match);
> >                       free(data);
> >               } else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
> >                       hit |= grep_submodule(opt, pathspec, &entry.oid,
> > @@ -621,6 +707,31 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> >       return hit;
> >  }
> >
> > +/*
> > + * Note: sparsity patterns and paths' attributes will only be considered if
> > + * is_root_tree has true value. (Otherwise, we cannot properly perform pattern
> > + * matching on paths.)
> > + */
> > +static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> > +                  struct tree_desc *tree, struct strbuf *base, int tn_len,
> > +                  int is_root_tree)
> > +{
> > +     struct pattern_list *patterns = NULL;
> > +     int ret;
> > +
> > +     if (is_root_tree)
> > +             patterns = get_sparsity_patterns(opt->repo);
> > +
> > +     ret = do_grep_tree(opt, pathspec, tree, base, tn_len, is_root_tree,
> > +                        patterns, 0);
> > +
> > +     if (patterns) {
> > +             clear_pattern_list(patterns);
> > +             free(patterns);
> > +     }
>
> OK, it is not like this codepath is driven by "git log" to grep from
> top-level tree objects of many commits, so it is OK to grab the
> sparsity patterns once before do_grep_tree() and discard it when we
> are done.
>
> > +     return ret;
> > +}
> > +
>
> >  static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
> >                      struct object *obj, const char *name, const char *path)
> >  {
> > diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
> > index 37525cae3a..26852586ac 100755
> > --- a/t/t7011-skip-worktree-reading.sh
> > +++ b/t/t7011-skip-worktree-reading.sh
> > @@ -109,15 +109,6 @@ test_expect_success 'ls-files --modified' '
> >       test -z "$(git ls-files -m)"
> >  '
> >
> > -test_expect_success 'grep with skip-worktree file' '
> > -     git update-index --no-skip-worktree 1 &&
> > -     echo test > 1 &&
> > -     git update-index 1 &&
> > -     git update-index --skip-worktree 1 &&
> > -     rm 1 &&
> > -     test "$(git grep --no-ext-grep test)" = "1:test"
> > -'
> > -
> >  echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A 1" > expected
> >  test_expect_success 'diff-index does not examine skip-worktree absent entries' '
> >       setup_absent &&
> > diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> > new file mode 100755
> > index 0000000000..3bd67082eb
> > --- /dev/null
> > +++ b/t/t7817-grep-sparse-checkout.sh
> > @@ -0,0 +1,140 @@
> > +#!/bin/sh
> > +
> > +test_description='grep in sparse checkout
> > +
> > +This test creates a repo with the following structure:
> > +
> > +.
> > +|-- a
> > +|-- b
> > +|-- dir
> > +|   `-- c
> > +`-- sub
> > +    |-- A
> > +    |   `-- a
> > +    `-- B
> > +     `-- b
> > +
> > +Where . has non-cone mode sparsity patterns and sub is a submodule with cone
> > +mode sparsity patterns. The resulting sparse-checkout should leave the following
> > +structure:
> > +
> > +.
> > +|-- a
> > +`-- sub
> > +    `-- B
> > +     `-- b
> > +'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
> > +     echo "text" >a &&
> > +     echo "text" >b &&
> > +     mkdir dir &&
> > +     echo "text" >dir/c &&
> > +
> > +     git init sub &&
> > +     (
> > +             cd sub &&
> > +             mkdir A B &&
> > +             echo "text" >A/a &&
> > +             echo "text" >B/b &&
> > +             git add A B &&
> > +             git commit -m sub &&
> > +             git sparse-checkout init --cone &&
> > +             git sparse-checkout set B
> > +     ) &&
> > +
> > +     git submodule add ./sub &&
> > +     git add a b dir &&
> > +     git commit -m super &&
> > +     git sparse-checkout init --no-cone &&
> > +     git sparse-checkout set "/*" "!b" "!/*/" &&
> > +
> > +     git tag -am t-commit t-commit HEAD &&
> > +     tree=$(git rev-parse HEAD^{tree}) &&
> > +     git tag -am t-tree t-tree $tree &&
> > +
> > +     test_path_is_missing b &&
> > +     test_path_is_missing dir &&
> > +     test_path_is_missing sub/A &&
> > +     test_path_is_file a &&
> > +     test_path_is_file sub/B/b
> > +'
> > +
> > +test_expect_success 'grep in working tree should honor sparse checkout' '
> > +     cat >expect <<-EOF &&
> > +     a:text
> > +     EOF
> > +     git grep "text" >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'grep --cached should honor sparse checkout' '
> > +     cat >expect <<-EOF &&
> > +     a:text
> > +     EOF
> > +     git grep --cached "text" >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'grep <commit-ish> should honor sparse checkout' '
> > +     commit=$(git rev-parse HEAD) &&
> > +     cat >expect_commit <<-EOF &&
> > +     $commit:a:text
> > +     EOF
> > +     cat >expect_t-commit <<-EOF &&
> > +     t-commit:a:text
> > +     EOF
> > +     git grep "text" $commit >actual_commit &&
> > +     test_cmp expect_commit actual_commit &&
> > +     git grep "text" t-commit >actual_t-commit &&
> > +     test_cmp expect_t-commit actual_t-commit
> > +'
> > +
> > +test_expect_success 'grep <tree-ish> should ignore sparsity patterns' '
> > +     commit=$(git rev-parse HEAD) &&
> > +     tree=$(git rev-parse HEAD^{tree}) &&
> > +     cat >expect_tree <<-EOF &&
> > +     $tree:a:text
> > +     $tree:b:text
> > +     $tree:dir/c:text
> > +     EOF
> > +     cat >expect_t-tree <<-EOF &&
> > +     t-tree:a:text
> > +     t-tree:b:text
> > +     t-tree:dir/c:text
> > +     EOF
> > +     git grep "text" $tree >actual_tree &&
> > +     test_cmp expect_tree actual_tree &&
> > +     git grep "text" t-tree >actual_t-tree &&
> > +     test_cmp expect_t-tree actual_t-tree
> > +'
> > +
> > +test_expect_success 'grep --recurse-submodules --cached should honor sparse checkout in submodule' '
> > +     cat >expect <<-EOF &&
> > +     a:text
> > +     sub/B/b:text
> > +     EOF
> > +     git grep --recurse-submodules --cached "text" >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'grep --recurse-submodules <commit-ish> should honor sparse checkout in submodule' '
> > +     commit=$(git rev-parse HEAD) &&
> > +     cat >expect_commit <<-EOF &&
> > +     $commit:a:text
> > +     $commit:sub/B/b:text
> > +     EOF
> > +     cat >expect_t-commit <<-EOF &&
> > +     t-commit:a:text
> > +     t-commit:sub/B/b:text
> > +     EOF
> > +     git grep --recurse-submodules "text" $commit >actual_commit &&
> > +     test_cmp expect_commit actual_commit &&
> > +     git grep --recurse-submodules "text" t-commit >actual_t-commit &&
> > +     test_cmp expect_t-commit actual_t-commit
> > +'
> > +
> > +test_done
