Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CD5C4332B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 07:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463432076A
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 07:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDjSUN9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgCXHP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:15:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36511 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXHP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 03:15:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id k18so17593371oib.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2xlu5IES4kgbuLDI6f6RylrBI4RJ/RLkB72FXTLJ9A=;
        b=qDjSUN9Dzvj8GHib4lxHAkjRlu5kntT0BGWi7R8jXbs3Oqz2w0wNVbz9T1GO5TzK3M
         69PHcm+m+5pzw52qqA9dzoL5APPxliDKDN1Pg6QuhLJwx7pDOKD8lELpxsCSuWHVTAGk
         UAIhl4AmJ4qGZ1jPnSH/GfGA8VAXeWq3Xgd2upAt7TqtRkce7qMtYk3TSRmU5Gwb4Xge
         +Bv+qiYdTH9O9hMki+FH6B0RdnCIkkdmLXPe1WnA80ORUVQQpMC7kpxJ8CHK4BEBkssb
         kaTLCcJektTK8eW5/ZKWUvwP4ftpuJ0zM118vWUZqcui4H1Hyrq8nHk4q9RmFV+D826P
         DFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2xlu5IES4kgbuLDI6f6RylrBI4RJ/RLkB72FXTLJ9A=;
        b=sBamq80uTJ9pxv8P+xhCWICAVqBJJQdvaFlYt7KtPGTCGqD7gGgcbDsMJT+vfW0PCm
         N3HZno/4XEhxd9WV70OjgIqBK3SORjuY2EgP8Iclf0DIxmbgc6F4AScpj0VoChPaMO2g
         pouu+hhUhJVfEs+Sp5Sxtn+4ZMbqZr3xWN5TsD3WDVKHQ1EDxn7zaJkwZgZ/JqQ1cPQi
         k+85Ybeffg0QnhocYnKZDXojtrn8EhrjBW3wGeJzcLobQxzLMnDKZeI4I2WZeNwueBkw
         0c9X23oRATweQJKV5syhFdlhGf9ohPGF7VPqznB9ma+Aebr2l7GiQ543dHXRKxeK2EN/
         Y9YA==
X-Gm-Message-State: ANhLgQ0MweSw+F5dp6+Sj09qVovPNCPWF+zUkTBqjBVpOZH2d1FzzeO5
        pnrg3zELVZafD8raiDtVb+kcUNBrIbzooDx2VVg=
X-Google-Smtp-Source: ADFU+vtqV538RUzDMO4V2K07Wv8Cji/UtYV+gcWyMlkieURmwcHZQ+2/GKWUJQaiZR2ObuiA54+VZnvtAcJlBM63/Lw=
X-Received: by 2002:aca:4b84:: with SMTP id y126mr2326193oia.31.1585034125656;
 Tue, 24 Mar 2020 00:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br> <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
In-Reply-To: <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Mar 2020 00:15:14 -0700
Message-ID: <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] grep: honor sparse checkout patterns
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Mon, Mar 23, 2020 at 11:12 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> One of the main uses for a sparse checkout is to allow users to focus on
> the subset of files in a repository in which they are interested. But
> git-grep currently ignores the sparsity patterns and report all matches
> found outside this subset, which kind of goes in the oposity direction.
> Let's fix that, making it honor the sparsity boundaries for every
> grepping case:
>
> - git grep in worktree
> - git grep --cached
> - git grep $REVISION

Wahoo!  This is great.

> - git grep --untracked and git grep --no-index (which already respect
>   sparse checkout boundaries)
>
> This is also what some users reported[1] they would want as the default
> behavior.
>
> Note: for `git grep $REVISION`, we will choose to honor the sparsity
> patterns only when $REVISION is a commit-ish object. The reason is that,

Makes sense.

> for a tree, we don't know whether it represents the root of a
> repository or a subtree. So we wouldn't be able to correctly match it
> against the sparsity patterns. E.g. suppose we have a repository with
> these two sparsity rules: "/*" and "!/a"; and the following structure:
>
> /
> | - a (file)
> | - d (dir)
>     | - a (file)
>
> If `git grep $REVISION` were to honor the sparsity patterns for every
> object type, when grepping the /d tree, we would wrongly ignore the /d/a
> file. This happens because we wouldn't know it resides in /d and
> therefore it would wrongly match the pattern "!/a". Furthermore, for a
> search in a blob object, we wouldn't even have a path to check the
> patterns against. So, let's ignore the sparsity patterns when grepping
> non-commit-ish objects (tags to commits should be fine).
>
> Finally, the old behavior is still desirable for some use cases. So the
> next patch will add an option to allow restoring it when needed.
>
> [1]: https://lore.kernel.org/git/CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com/
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>
> Something I'm not entirely sure in this patch is how we implement the
> mechanism to honor sparsity for the `git grep <commit-ish>` case (which
> is treated in the grep_tree() function). Currently, the patch looks for
> an index entry that matches the path, and then checks its skip_worktree

As you discuss below, checking the index is both wrong _and_ costly.
You should use the sparsity patterns; Stolee did a lot of work to make
those correspond to simple hashes you could check to determine whether
to even walk into a subdirectory.  So, O(1).  Yeah, that's "only" cone
mode but the non-cone sparsity patterns were a performance nightmare
waiting to rear its ugly head.  We should just try to encourage
everyone to move to cone mode, or accept the slowness they get without
it.

> bit. But this operation is perfomed in O(log(N)); N being the number of
> index entries. If there are many entries (and no so many sparsity
> patterns), maybe a better approach would be to try matching the path
> directly against the sparsity patterns. This would be O(M) in the number
> of patterns, and it could be done, in builtin/grep.c, with a function
> like the following:
>
> static struct pattern_list sparsity_patterns;
> static int sparsity_patterns_initialized = 0;
> static enum pattern_match_result path_matches_sparsity_patterns(
>                                         const char *path, int pathlen,
>                                         const char *basename,
>                                         struct repository *repo)
> {
>         int dtype = DT_UNKNOWN;
>
>         if (!sparsity_patterns_initialized) {
>                 char *sparse_file = git_pathdup("info/sparse-checkout");
>                 int ret;
>
>                 memset(&sparsity_patterns, 0, sizeof(sparsity_patterns));
>                 sparsity_patterns.use_cone_patterns = core_sparse_checkout_cone;
>                 ret = add_patterns_from_file_to_list(sparse_file, "", 0,
>                                                      &sparsity_patterns, NULL);
>                 free(sparse_file);
>
>                 if (ret < 0)
>                         die(_("failed to load sparse-checkout patterns"));
>                 sparsity_patterns_initialized = 1;
>         }
>
>         return path_matches_pattern_list(path, pathlen, basename, &dtype,
>                                          &sparsity_patterns, repo->index);
> }
>
> Also, if I understand correctly, the index doesn't hold paths to dirs,
> right? So even if a complete dir is excluded from sparse checkout, we
> still have to check all its subentries, only to discover that they
> should all be skipped from the search. However, if we were to check
> against the sparsity patterns directly (e.g. with the function above),
> we could skip such directories together with all their entries.
>
> Oh, and there is also the case of a commit whose tree paths are not in
> the index (maybe manually created objects?). For such commits, with the
> index lookup approach, we would have to fall back on ignoring the
> sparsity rules. I'm not sure if that would be OK, though.
>
> Any thoughts on these two approaches (looking up the skip_worktree bit
> in the index or directly matching against sparsity patterns), will be
> highly appreciated. (Note that it only concerns the `git grep
> <commit-ish>` case. The other cases already iterate thought the index, so
> there is no O(log(N)) extra complexity).
>
>  builtin/grep.c                   | 29 ++++++++---
>  t/t7011-skip-worktree-reading.sh |  9 ----
>  t/t7817-grep-sparse-checkout.sh  | 88 ++++++++++++++++++++++++++++++++
>  3 files changed, 111 insertions(+), 15 deletions(-)
>  create mode 100755 t/t7817-grep-sparse-checkout.sh
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 99e2685090..52ec72a036 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -388,7 +388,7 @@ static int grep_cache(struct grep_opt *opt,
>                       const struct pathspec *pathspec, int cached);
>  static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>                      struct tree_desc *tree, struct strbuf *base, int tn_len,
> -                    int check_attr);
> +                    int from_commit);

I'm not familiar with grep.c and have to admit I don't know what
"check_attr" means.  Slightly surprised to see you replace it, but
maybe reading the rest will explain...

>
>  static int grep_submodule(struct grep_opt *opt,
>                           const struct pathspec *pathspec,
> @@ -486,6 +486,10 @@ static int grep_cache(struct grep_opt *opt,
>
>         for (nr = 0; nr < repo->index->cache_nr; nr++) {
>                 const struct cache_entry *ce = repo->index->cache[nr];
> +
> +               if (ce_skip_worktree(ce))
> +                       continue;
> +

Looks good for the case where we are grepping through what's cached.

>                 strbuf_setlen(&name, name_base_len);
>                 strbuf_addstr(&name, ce->name);
>
> @@ -498,8 +502,7 @@ static int grep_cache(struct grep_opt *opt,
>                          * cache entry are identical, even if worktree file has
>                          * been modified, so use cache version instead
>                          */
> -                       if (cached || (ce->ce_flags & CE_VALID) ||
> -                           ce_skip_worktree(ce)) {
> +                       if (cached || (ce->ce_flags & CE_VALID)) {

I had the same change when I was trying to hack something like this
patch into place but only handled the worktree case before realized it
was a bit bigger job.

>                                 if (ce_stage(ce) || ce_intent_to_add(ce))
>                                         continue;
>                                 hit |= grep_oid(opt, &ce->oid, name.buf,
> @@ -532,7 +535,7 @@ static int grep_cache(struct grep_opt *opt,
>
>  static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>                      struct tree_desc *tree, struct strbuf *base, int tn_len,
> -                    int check_attr)
> +                    int from_commit)
>  {
>         struct repository *repo = opt->repo;
>         int hit = 0;
> @@ -546,6 +549,9 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>                 name_base_len = name.len;
>         }
>
> +       if (from_commit && repo_read_index(repo) < 0)
> +               die(_("index file corrupt"));
> +

As above, I don't think we should need to read the index.  We should
compare to sparsity patterns, which in the important case (cone mode)
simplifies to a hash lookup as we walk directories.

>         while (tree_entry(tree, &entry)) {
>                 int te_len = tree_entry_len(&entry);
>
> @@ -564,9 +570,20 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>
>                 strbuf_add(base, entry.path, te_len);
>
> +               if (from_commit) {
> +                       int pos = index_name_pos(repo->index,
> +                                                base->buf + tn_len,
> +                                                base->len - tn_len);
> +                       if (pos >= 0 &&
> +                           ce_skip_worktree(repo->index->cache[pos])) {
> +                               strbuf_setlen(base, old_baselen);
> +                               continue;
> +                       }
> +               }
> +
>                 if (S_ISREG(entry.mode)) {
>                         hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
> -                                        check_attr ? base->buf + tn_len : NULL);
> +                                       from_commit ? base->buf + tn_len : NULL);

Sadly, this doesn't help me understand check_attr or from_commit.
Could you clue me in a bit?

>                 } else if (S_ISDIR(entry.mode)) {
>                         enum object_type type;
>                         struct tree_desc sub;
> @@ -581,7 +598,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>                         strbuf_addch(base, '/');
>                         init_tree_desc(&sub, data, size);
>                         hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
> -                                        check_attr);
> +                                        from_commit);

Same.

>                         free(data);
>                 } else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
>                         hit |= grep_submodule(opt, pathspec, &entry.oid,
> diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
> index 37525cae3a..26852586ac 100755
> --- a/t/t7011-skip-worktree-reading.sh
> +++ b/t/t7011-skip-worktree-reading.sh
> @@ -109,15 +109,6 @@ test_expect_success 'ls-files --modified' '
>         test -z "$(git ls-files -m)"
>  '
>
> -test_expect_success 'grep with skip-worktree file' '
> -       git update-index --no-skip-worktree 1 &&
> -       echo test > 1 &&
> -       git update-index 1 &&
> -       git update-index --skip-worktree 1 &&
> -       rm 1 &&
> -       test "$(git grep --no-ext-grep test)" = "1:test"
> -'
> -
>  echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A   1" > expected
>  test_expect_success 'diff-index does not examine skip-worktree absent entries' '
>         setup_absent &&
> diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> new file mode 100755
> index 0000000000..fccf44e829
> --- /dev/null
> +++ b/t/t7817-grep-sparse-checkout.sh
> @@ -0,0 +1,88 @@
> +#!/bin/sh
> +
> +test_description='grep in sparse checkout
> +
> +This test creates the following dir structure:
> +.
> +| - a
> +| - b
> +| - dir
> +    | - c
> +
> +Only "a" should be present due to the sparse checkout patterns:
> +"/*", "!/b" and "!/dir".
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       echo "text" >a &&
> +       echo "text" >b &&
> +       mkdir dir &&
> +       echo "text" >dir/c &&
> +       git add a b dir &&
> +       git commit -m "initial commit" &&
> +       git tag -am t-commit t-commit HEAD &&
> +       tree=$(git rev-parse HEAD^{tree}) &&
> +       git tag -am t-tree t-tree $tree &&
> +       cat >.git/info/sparse-checkout <<-EOF &&
> +       /*
> +       !/b
> +       !/dir
> +       EOF
> +       git sparse-checkout init &&

Using `git sparse-checkout init` but then manually writing to
.git/info/sparse-checkout?  Seems like it'd make more sense to use
`git sparse-checkout set` than writing the patterns directly yourself.
Also, would prefer to have the examples use cone mode (even if you
have to add subdirectories), as it makes the testcase a bit easier to
read and more performant, though neither is a big deal.

> +       test_path_is_missing b &&
> +       test_path_is_missing dir &&
> +       test_path_is_file a
> +'
> +
> +test_expect_success 'grep in working tree should honor sparse checkout' '
> +       cat >expect <<-EOF &&
> +       a:text
> +       EOF
> +       git grep "text" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'grep --cached should honor sparse checkout' '
> +       cat >expect <<-EOF &&
> +       a:text
> +       EOF
> +       git grep --cached "text" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'grep <commit-ish> should honor sparse checkout' '
> +       commit=$(git rev-parse HEAD) &&
> +       cat >expect_commit <<-EOF &&
> +       $commit:a:text
> +       EOF
> +       cat >expect_t-commit <<-EOF &&
> +       t-commit:a:text
> +       EOF
> +       git grep "text" $commit >actual_commit &&
> +       test_cmp expect_commit actual_commit &&
> +       git grep "text" t-commit >actual_t-commit &&
> +       test_cmp expect_t-commit actual_t-commit
> +'
> +
> +test_expect_success 'grep <tree-ish> should search outside sparse checkout' '

I think the test is fine but the title seems misleading.  "outside"
and "inside" aren't defined because <tree-ish> isn't known to be
rooted, meaning we have no way to apply the sparsity patterns.  So
perhaps just 'grep <tree-ish> should ignore sparsity patterns'?

> +       commit=$(git rev-parse HEAD) &&
> +       tree=$(git rev-parse HEAD^{tree}) &&
> +       cat >expect_tree <<-EOF &&
> +       $tree:a:text
> +       $tree:b:text
> +       $tree:dir/c:text
> +       EOF
> +       cat >expect_t-tree <<-EOF &&
> +       t-tree:a:text
> +       t-tree:b:text
> +       t-tree:dir/c:text
> +       EOF
> +       git grep "text" $tree >actual_tree &&
> +       test_cmp expect_tree actual_tree &&
> +       git grep "text" t-tree >actual_t-tree &&
> +       test_cmp expect_t-tree actual_t-tree
> +'
> +
> +test_done
> --
> 2.25.1
