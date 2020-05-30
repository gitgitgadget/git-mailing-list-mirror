Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B1C433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 15:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB74C20722
	for <git@archiver.kernel.org>; Sat, 30 May 2020 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiVDSsLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgE3Psn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 11:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3Psn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 11:48:43 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6976C03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 08:48:42 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id q188so131917ooq.4
        for <git@vger.kernel.org>; Sat, 30 May 2020 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpRX5KjB3xvGN5eU3bWJDFI4m6ObiO2josN+gLSrHzw=;
        b=TiVDSsLGNfXG599bVbsp8qTlR/TSKns/gvDdbrPyhVHli+esMY8an3mbyySUqnlz+a
         gSKsD2jSLu9WUTFgVJsrBI/t2B8O3S8f2v4OOtYT4UuMIA/C9IonZdZ2zWou2e32U+c6
         WBHn7QU32psOMy8RDco5+fYbzLHqqcx8s1ObI2q8dyKapnv5qlA1qXyBVM09r+BGg9eM
         uKIEWtU+gcGXj6yIAUN/vGX8tWa0T9I37LFFahSWWkPCqzu6UPsolPkcPg+7HpOMySVx
         xKELxa6LCS1wAi3H7WO7lJ3NfTcairQWD/9//bPO4lBMiSczSV1qNGzRsHmRyK1goHKq
         EVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpRX5KjB3xvGN5eU3bWJDFI4m6ObiO2josN+gLSrHzw=;
        b=SBn6hx4VW+daejUJxv+doxC8i92bDRmFwWqY/yJAFLJvNThFNomNpfqb9Lv9PpA2l+
         17L/S6ocWsMeOygeWrUH4X3hbJsoU4OCXmYUS1UGErW/kg+MXflZjihMBzIryBQhl5m/
         M2QhyFK3nn1RmAl2KhQk7aqidN5bH0NI4MRL8dfwmGzYLBDuOjRTSb71QRRpUKKpF4lR
         rZEoPDRpQkyxn5zasytbjiTYMLPjhuJsIYLdJshsRfWxnMiYALGrn1CMBSJ7AJbAP3rQ
         SmjrYWWINSYdtLMcPxe8pUzFuhE9cvFyu+YCgBJxw9E3WJoFWuc/uxcO6U0Fsw7Os+uL
         hCfg==
X-Gm-Message-State: AOAM533M1H9c/tuvt+SHS8eUPJUIrFe8I4b0A8P+KxEAVPD/IZDnxYtL
        3ME0yNLmT71X+ydb8MvBu+Wuug7cjkxUg3F6nR0=
X-Google-Smtp-Source: ABdhPJyJP3ZC8c5doxOMiFzNaZphopr4+/1rccDR7C8Mu6l9dAVcop+Q58ih9ZqNPuMROo/feq5PstxlhETO+Z72yo0=
X-Received: by 2002:a4a:91c2:: with SMTP id e2mr11012647ooh.45.1590853721517;
 Sat, 30 May 2020 08:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br> <5ddac818185d316cd5ad9576105f0e4e695b9456.1590627264.git.matheus.bernardino@usp.br>
In-Reply-To: <5ddac818185d316cd5ad9576105f0e4e695b9456.1590627264.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 May 2020 08:48:29 -0700
Message-ID: <CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] grep: honor sparse checkout patterns
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 6:13 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> One of the main uses for a sparse checkout is to allow users to focus on
> the subset of files in a repository in which they are interested. But
> git-grep currently ignores the sparsity patterns and report all matches
> found outside this subset, which kind of goes in the opposite direction.
> Let's fix that, making it honor the sparsity boundaries for every
> grepping case where this is relevant:
>
> - git grep in worktree
> - git grep --cached
> - git grep $REVISION
>
> For the worktree case, we will not grep paths that have the
> SKIP_WORKTREE bit set, even if they are present for some reason (e.g.
> manually created after `git sparse-checkout init`).

This seems worded to rise alarm bells and make users suspect
implementation difficulties or regrets rather than desired behavior.
It would be much better to word this simply as something like:

    For the worktree and cached cases, we iterate over paths without
the SKIP_WORKTREE bit set, and limit our searches to these paths.

> But the next patch
> will add an option to do so. (See 'Note' below.)

Because this was in the same paragraph as the previous sentence, it
made it sound like you were going to provide a special worktree-only
option to search outside the SKIP_WORKTREE bits.  Very confusing.  I
think I'd combine this sentence into the very first paragraph of the
commit message and massage the wording a little.  Perhaps something
like:  ...goes in the opposite direction.  There are some usecases for
ignoring the sparsity patterns and the next commit will add an option
to obtain this behavior, but here we start by making grep honor the
sparsity boundaries for every...

> For `git grep $REVISION`, we will choose to honor the sparsity patterns
> only when $REVISION is a commit-ish object. The reason is that, for a
> tree, we don't know whether it represents the root of a repository or a
> subtree. So we wouldn't be able to correctly match it against the
> sparsity patterns. E.g. suppose we have a repository with these two
> sparsity rules: "/*" and "!/a"; and the following structure:
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
> non-commit-ish objects.

This doesn't actually make it clear how you handle $REVISION which is
a commit object; you focus so much on when $REVISION is just a tree
and contrasting that case that you omit the behavior for the case of
interest.  Also, $REVISION to my mind implies "commit"; if you want to
imply that a commit or tree could be used, you'd use $TREE or
$TREE_ISH or something else.  I think it'd make sense to cover all
three relevant cases into a single paragraph (thus combining with the
previous paragraph), and then add a second paragraph about the $TREE
case that streamlines the last two pargraphs above.  So, perhaps we
can your paragraphs from "For the worktree case, we will not grep
paths..." all the way to "So, let's ignore the sparsity patterns when
grepping non-commit-ish objects" (after first moving the comment about
adding an option in the next commit to some other area of the commit
message, as dicussed above) with something like the following:


    For the worktree and cached cases, we iterate over paths without
the SKIP_WORKTREE bit set, and limit our searches to these paths.  For
the $REVISION case, we limit the paths we search to those that match
the sparsity patterns.  (We do not check the SKIP_WORKTREE bit for the
$REVISION case, because $REVISION may contain paths that do not exist
in HEAD and thus for which we have no SKIP_WORKTREE bit to consult.
The sparsity patterns tell us how the SKIP_WORKTREE bit would be set
if we were to check out $REVISION, so we consult those.  Also, we
don't use the sparsity paths with the worktree or cached cases, both
because we have a bit we can check directly and more efficiently, and
because unmerged entries from a merge or a rebase could cause more
files to temporarily be present than the sparsity patterns would
normally select.)

    Note that there is a special case here: `git grep $TREE`.  In this
case we cannot know whether $TREE corresponds to the root of the
repository or some sub-tree, and thus there is no way for us to know
which sparsity patterns, if any, apply.  So the $TREE case will not
use sparsity patterns or any SKIP_WORKTREE bits and will instead
always search all files within the $TREE.

>
> Note: The behavior introduced in this patch is what some users have
> reported[1] that they would like by default. But the old behavior is
> still desirable for some use cases. Therefore, the next patch will add
> an option to allow restoring it when needed.

This paragraph duplicates information you already stated previously.
It's much clearer than what you stated before, but if you just reword
the previous comments and combine them into the first paragraph, then
we can drop this final note.


> [1]: https://lore.kernel.org/git/CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com/
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  builtin/grep.c                   | 125 ++++++++++++++++++++--
>  t/t7011-skip-worktree-reading.sh |   9 --
>  t/t7817-grep-sparse-checkout.sh  | 174 +++++++++++++++++++++++++++++++
>  3 files changed, 291 insertions(+), 17 deletions(-)
>  create mode 100755 t/t7817-grep-sparse-checkout.sh
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index a5056f395a..11e33b8aee 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -410,7 +410,7 @@ static int grep_cache(struct grep_opt *opt,
>                       const struct pathspec *pathspec, int cached);
>  static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>                      struct tree_desc *tree, struct strbuf *base, int tn_len,
> -                    int check_attr);
> +                    int is_root_tree);

So you modified the forward declaration of grep_tree()...

>
>  static int grep_submodule(struct grep_opt *opt,
>                           const struct pathspec *pathspec,
> @@ -508,6 +508,10 @@ static int grep_cache(struct grep_opt *opt,
>
>         for (nr = 0; nr < repo->index->cache_nr; nr++) {
>                 const struct cache_entry *ce = repo->index->cache[nr];
> +
> +               if (ce_skip_worktree(ce))
> +                       continue;
> +
>                 strbuf_setlen(&name, name_base_len);
>                 strbuf_addstr(&name, ce->name);
>
> @@ -520,8 +524,7 @@ static int grep_cache(struct grep_opt *opt,
>                          * cache entry are identical, even if worktree file has
>                          * been modified, so use cache version instead
>                          */
> -                       if (cached || (ce->ce_flags & CE_VALID) ||
> -                           ce_skip_worktree(ce)) {
> +                       if (cached || (ce->ce_flags & CE_VALID)) {
>                                 if (ce_stage(ce) || ce_intent_to_add(ce))
>                                         continue;
>                                 hit |= grep_oid(opt, &ce->oid, name.buf,
> @@ -552,9 +555,76 @@ static int grep_cache(struct grep_opt *opt,
>         return hit;
>  }
>
> -static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> -                    struct tree_desc *tree, struct strbuf *base, int tn_len,
> -                    int check_attr)

Here the patch splits your handling of grep_tree()...

> +static struct pattern_list *get_sparsity_patterns(struct repository *repo)
> +{
> +       struct pattern_list *patterns;
> +       char *sparse_file;
> +       int sparse_config, cone_config;
> +
> +       if (repo_config_get_bool(repo, "core.sparsecheckout", &sparse_config) ||
> +           !sparse_config) {
> +               return NULL;
> +       }

Is core_apply_sparse_checkout not initialized for some reason?

> +
> +       sparse_file = repo_git_path(repo, "info/sparse-checkout");
> +       patterns = xcalloc(1, sizeof(*patterns));
> +
> +       if (repo_config_get_bool(repo, "core.sparsecheckoutcone", &cone_config))
> +               cone_config = 0;
> +       patterns->use_cone_patterns = cone_config;

Similarly, is core_sparse_checkout_cone not intialized?

> +
> +       if (add_patterns_from_file_to_list(sparse_file, "", 0, patterns, NULL)) {
> +               if (file_exists(sparse_file)) {
> +                       warning(_("failed to load sparse-checkout file: '%s'"),
> +                               sparse_file);
> +               }
> +               free(sparse_file);
> +               free(patterns);
> +               return NULL;
> +       }
> +
> +       free(sparse_file);
> +       return patterns;
> +}
> +
> +static int in_sparse_checkout(struct strbuf *path, int prefix_len,

This function name in_sparse_checkout() makes me think "Does the
working tree represent a sparse checkout?"  Perhaps we could rename it
to path_matches_sparsity_patterns() ?

Also, is there a reason we can't use dir.c's
path_matches_pattern_list() here?  How does this new function differ
in behavior from that function?

> +                             unsigned int entry_mode,
> +                             struct index_state *istate,
> +                             struct pattern_list *sparsity,
> +                             enum pattern_match_result parent_match,
> +                             enum pattern_match_result *match)
> +{
> +       int dtype = DT_UNKNOWN;
> +       int is_dir = S_ISDIR(entry_mode);
> +
> +       if (parent_match == MATCHED_RECURSIVE) {
> +               *match = parent_match;
> +               return 1;
> +       }
> +
> +       if (is_dir && !is_dir_sep(path->buf[path->len - 1]))
> +               strbuf_addch(path, '/');
> +
> +       *match = path_matches_pattern_list(path->buf, path->len,
> +                                          path->buf + prefix_len, &dtype,
> +                                          sparsity, istate);
> +       if (*match == UNDECIDED)
> +               *match = parent_match;
> +
> +       if (is_dir)
> +               strbuf_trim_trailing_dir_sep(path);
> +
> +       if (*match == NOT_MATCHED &&
> +               (!is_dir || (is_dir && sparsity->use_cone_patterns)))
> +            return 0;
> +
> +       return 1;
> +}
> +
> +static int do_grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,

I thought this meant you were renaming grep_tree() to do_grep_tree()
but it's a new function that happens to have most of the logic from
the old grep_tree() and which the new grep_tree() will call to do most
its work.

> +                       struct tree_desc *tree, struct strbuf *base, int tn_len,
> +                       int check_attr, struct pattern_list *sparsity,
> +                       enum pattern_match_result default_sparsity_match)
>  {
>         struct repository *repo = opt->repo;
>         int hit = 0;
> @@ -570,6 +640,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>
>         while (tree_entry(tree, &entry)) {
>                 int te_len = tree_entry_len(&entry);
> +               enum pattern_match_result sparsity_match = 0;
>
>                 if (match != all_entries_interesting) {
>                         strbuf_addstr(&name, base->buf + tn_len);
> @@ -586,6 +657,19 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>
>                 strbuf_add(base, entry.path, te_len);
>
> +               if (sparsity) {
> +                       struct strbuf path = STRBUF_INIT;
> +                       strbuf_addstr(&path, base->buf + tn_len);
> +
> +                       if (!in_sparse_checkout(&path, old_baselen - tn_len,
> +                                               entry.mode, repo->index,
> +                                               sparsity, default_sparsity_match,
> +                                               &sparsity_match)) {
> +                               strbuf_setlen(base, old_baselen);
> +                               continue;
> +                       }
> +               }
> +
>                 if (S_ISREG(entry.mode)) {
>                         hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
>                                          check_attr ? base->buf + tn_len : NULL);
> @@ -602,8 +686,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>
>                         strbuf_addch(base, '/');
>                         init_tree_desc(&sub, data, size);
> -                       hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
> -                                        check_attr);
> +                       hit |= do_grep_tree(opt, pathspec, &sub, base, tn_len,
> +                                           check_attr, sparsity, sparsity_match);
>                         free(data);
>                 } else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
>                         hit |= grep_submodule(opt, pathspec, &entry.oid,
> @@ -621,6 +705,31 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>         return hit;
>  }
>
> +/*
> + * Note: sparsity patterns and paths' attributes will only be considered if
> + * is_root_tree has true value. (Otherwise, we cannot properly perform pattern
> + * matching on paths.)
> + */
> +static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> +                    struct tree_desc *tree, struct strbuf *base, int tn_len,
> +                    int is_root_tree)
> +{
> +       struct pattern_list *patterns = NULL;
> +       int ret;
> +
> +       if (is_root_tree)
> +               patterns = get_sparsity_patterns(opt->repo);
> +
> +       ret = do_grep_tree(opt, pathspec, tree, base, tn_len, is_root_tree,
> +                          patterns, 0);
> +
> +       if (patterns) {
> +               clear_pattern_list(patterns);
> +               free(patterns);
> +       }
> +       return ret;
> +}

Once I figured out grep_tree() was just becoming a wrapper around
do_grep_tree(), the patch made more sense; I should have scrolled to
the end quicker.  ;-)

> +
>  static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
>                        struct object *obj, const char *name, const char *path)
>  {
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

Yaay!

> -
>  echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A   1" > expected
>  test_expect_success 'diff-index does not examine skip-worktree absent entries' '
>         setup_absent &&
> diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> new file mode 100755
> index 0000000000..ce080cf572
> --- /dev/null
> +++ b/t/t7817-grep-sparse-checkout.sh
> @@ -0,0 +1,174 @@
> +#!/bin/sh
> +
> +test_description='grep in sparse checkout
> +
> +This test creates a repo with the following structure:
> +
> +.
> +|-- a
> +|-- b
> +|-- dir
> +|   `-- c
> +|-- sub
> +|   |-- A
> +|   |   `-- a
> +|   `-- B
> +|       `-- b
> +`-- sub2
> +    `-- a
> +
> +Where . has non-cone mode sparsity patterns, sub is a submodule with cone mode

Maybe "Where the outer repository has non-code mode..."?  The use of
'.' threw me for a bit.

> +sparsity patterns and sub2 is a submodule that is excluded by the superproject
> +sparsity patterns. The resulting sparse checkout should leave the following
> +structure on the working tree:

s/on the/in the/?

> +
> +.
> +|-- a
> +|-- sub
> +|   `-- B
> +|       `-- b
> +`-- sub2
> +    `-- a
> +
> +But note that sub2 should have the SKIP_WORKTREE bit set.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       echo "text" >a &&
> +       echo "text" >b &&
> +       mkdir dir &&
> +       echo "text" >dir/c &&
> +
> +       git init sub &&
> +       (
> +               cd sub &&
> +               mkdir A B &&
> +               echo "text" >A/a &&
> +               echo "text" >B/b &&
> +               git add A B &&
> +               git commit -m sub &&
> +               git sparse-checkout init --cone &&
> +               git sparse-checkout set B
> +       ) &&
> +
> +       git init sub2 &&
> +       (
> +               cd sub2 &&
> +               echo "text" >a &&
> +               git add a &&
> +               git commit -m sub2
> +       ) &&
> +
> +       git submodule add ./sub &&
> +       git submodule add ./sub2 &&
> +       git add a b dir &&
> +       git commit -m super &&
> +       git sparse-checkout init --no-cone &&
> +       git sparse-checkout set "/*" "!b" "!/*/" "sub" &&
> +
> +       git tag -am tag-to-commit tag-to-commit HEAD &&
> +       tree=$(git rev-parse HEAD^{tree}) &&
> +       git tag -am tag-to-tree tag-to-tree $tree &&
> +
> +       test_path_is_missing b &&
> +       test_path_is_missing dir &&
> +       test_path_is_missing sub/A &&
> +       test_path_is_file a &&
> +       test_path_is_file sub/B/b &&
> +       test_path_is_file sub2/a
> +'
> +
> +# The test bellow checks a special case: the sparsity patterns exclude '/b'

s/bellow/below/

> +# and sparse checkout is enable, but the path exists on the working tree (e.g.

s/enable/enabled/, s/on/in/

> +# manually created after `git sparse-checkout init`). In this case, grep should
> +# skip it.
> +test_expect_success 'grep in working tree should honor sparse checkout' '
> +       cat >expect <<-EOF &&
> +       a:text
> +       EOF
> +       echo "new-text" >b &&
> +       test_when_finished "rm b" &&
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
> +       cat >expect_tag-to-commit <<-EOF &&
> +       tag-to-commit:a:text
> +       EOF
> +       git grep "text" $commit >actual_commit &&
> +       test_cmp expect_commit actual_commit &&
> +       git grep "text" tag-to-commit >actual_tag-to-commit &&
> +       test_cmp expect_tag-to-commit actual_tag-to-commit
> +'
> +
> +test_expect_success 'grep <tree-ish> should ignore sparsity patterns' '
> +       commit=$(git rev-parse HEAD) &&
> +       tree=$(git rev-parse HEAD^{tree}) &&
> +       cat >expect_tree <<-EOF &&
> +       $tree:a:text
> +       $tree:b:text
> +       $tree:dir/c:text
> +       EOF
> +       cat >expect_tag-to-tree <<-EOF &&
> +       tag-to-tree:a:text
> +       tag-to-tree:b:text
> +       tag-to-tree:dir/c:text
> +       EOF
> +       git grep "text" $tree >actual_tree &&
> +       test_cmp expect_tree actual_tree &&
> +       git grep "text" tag-to-tree >actual_tag-to-tree &&
> +       test_cmp expect_tag-to-tree actual_tag-to-tree
> +'
> +
> +# Note that sub2/ is present in the worktree but it is excluded by the sparsity
> +# patterns, so grep should not recurse into it.
> +test_expect_success 'grep --recurse-submodules should honor sparse checkout in submodule' '
> +       cat >expect <<-EOF &&
> +       a:text
> +       sub/B/b:text
> +       EOF
> +       git grep --recurse-submodules "text" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'grep --recurse-submodules --cached should honor sparse checkout in submodule' '
> +       cat >expect <<-EOF &&
> +       a:text
> +       sub/B/b:text
> +       EOF
> +       git grep --recurse-submodules --cached "text" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'grep --recurse-submodules <commit-ish> should honor sparse checkout in submodule' '
> +       commit=$(git rev-parse HEAD) &&
> +       cat >expect_commit <<-EOF &&
> +       $commit:a:text
> +       $commit:sub/B/b:text
> +       EOF
> +       cat >expect_tag-to-commit <<-EOF &&
> +       tag-to-commit:a:text
> +       tag-to-commit:sub/B/b:text
> +       EOF
> +       git grep --recurse-submodules "text" $commit >actual_commit &&
> +       test_cmp expect_commit actual_commit &&
> +       git grep --recurse-submodules "text" tag-to-commit >actual_tag-to-commit &&
> +       test_cmp expect_tag-to-commit actual_tag-to-commit
> +'
> +
> +test_done
> --
> 2.26.2

Looks good.  Do we want to add a testcase where a file is unmerged and
present in the working copy despite not matching the sparsity patterns
(i.e. to emulate being in the middle of a merge/rebase/cherry-pick)?
