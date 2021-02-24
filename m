Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E74C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 07:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05AA64EBA
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 07:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhBXHHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 02:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhBXHG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 02:06:26 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7DAC061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 23:05:45 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id l64so1435407oig.9
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 23:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScE4fyRo8PBGxbZhQg5vHFdk5dBmZlBJ9jUvkMX4iA8=;
        b=uXr/tixOQsYRSrvRZ7imYnJRF4bnMdDRMQwQT4cmuUlaHZXxkh0dfOywl0PMw7ff0J
         Ptt5JrKrPq/xsRfZAstiCLVeAX2E9IfjcLBxNjx4tETfJrGfeWQayCZxc7BwriEP6oQ7
         Ur+rj+c13t4U+LcGjAPzYoHFm/IYdhuMu5fKu797dhGVyq/5XSNG/ibyp/6q8gXXXQCN
         wykGFEvoSuz69g7I9CyAehRUmPc8EI+K9IuwLPYOZ/NhNYE3wn2J9crvxvaK/NLlEUi9
         ggvgKLRsWVYl9EclPtMqPYJVgmAHDLeNivz9Njm/ykgFPw/DXpWB535VQUrGDoihbJsM
         UQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScE4fyRo8PBGxbZhQg5vHFdk5dBmZlBJ9jUvkMX4iA8=;
        b=WFqSUzg6fl4vn7x6pMo+Pxx7ADlGTVsiEdpYIvuY0ajY9ggrENfXnqZGFl/9NmDksp
         lOyUKtB3D2mU6oiZ76SBX4SQQXbt4Ckkc+Yjwg/lMkZElTADxPDij+wlr6iZOlvxUnIX
         DA9DPGGZYEQToRRy4y++O6v7GuM1sk8Hi9TxxvclXNNWD/SkO92SMzthHbabfD3PTDQa
         beZXmzt0+5Godc/dkKPdvbH4YBZwuUxaVhekmdo3yHhsTk/mGJKjtb17Wjt9OCiu4wVC
         R+eyQF1DU2hK0BLQCHXXxdNdNu0UHgyU5ylpR95065/kcM8Fn3Urzm5fhAi1ahmck123
         xLPA==
X-Gm-Message-State: AOAM533mktHQuz6LNmVUBoHiinmU9PmB6MQoMAy7zwwZVs+4AibhJ7dq
        RAHVKeI+D6Q3sMVWzEm32850kN2sasKJ9Ma2DDQW8CD8aMI=
X-Google-Smtp-Source: ABdhPJwMkn5gHnTXIsxAUeXiXGDdhB4CLsItLhBIY1oCVnFVvq7oAo44nTAXzx3o432gIdQXETk280X+1kqT2h+LUvs=
X-Received: by 2002:aca:c48c:: with SMTP id u134mr1834024oif.31.1614150344753;
 Tue, 23 Feb 2021 23:05:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613593946.git.matheus.bernardino@usp.br> <cover.1614138107.git.matheus.bernardino@usp.br>
In-Reply-To: <cover.1614138107.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 23:05:33 -0800
Message-ID: <CABPp-BEKaNw9dU9mtYbCc1FFeNEtSdo=D246Gsy7rwZ4POZh-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] add/rm: honor sparse checkout and warn on sparse paths
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This time I'm responding a bit more promptly than the last few patch
series you sent out.  :-)

On Tue, Feb 23, 2021 at 8:05 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Make `rm` honor sparse checkouts, and make both `rm` and `add` warn
> about pathspecs that only match sparse entries.
>
> This is now based on mt/add-chmod-fixes.
>
> Main changes since RFC:

I've read through the series.  I'm obviously a fan of the overall
direction, and after reading it over I think the implementation also
looks pretty good.  I had a few minor comments here and there, and one
weird testcase that I came up with based on reading your code where
I'm not sure what the right behavior is (because the testcase is
convoluted); at worst, the current code just prints two warnings when
we maybe want one, but two warnings might be considered the correct
behavior.  Maybe you or someone else can look at it with a fresh set
of eyes and have a reason to prefer one behavior over the other for
that testcase.

>
> Ejected "add --chmod: don't update index when --dry-run is used", which
> is now part of mt/add-chmod-fixes.
>
> Patch 2:
> - Fixed style problems.
> - Fixed comment on setup_sparse_entry() about argument being passed to
>   printf.
> - Standardized on 'sparse entries' on test names.
> - Added test for 'git add .', and set up a .gitignore to run this and
>   the 'git add -A' test, to avoid smudging the index.
> - Added test for --dry-run.
> - Modified `git add --refresh` test to use `git ls-files --debug`
>   instead of diff-files.
>
> Added patch 5
>
> Patch 6:
> - Improved commit message.
> - Used the flag added in patch 5 instead of directly changing
>   refresh_index(), so that new users of seen[] can still have the
>   complete match array.
> - Added test for --ignore-missing.
> - Added test where the pathspec matches both sparse and dense entries.
> - Changed 'git add .' behavior where . only contains sparse entries. [1]
>
> Patch 7:
> - Moved rm-sparse-checkout tests to their own file. They need a repo
>   with a different setup than the one t3600 has, and the subshells (or
>   git -C ...) were making the tests too hard to read.
> - Added tests for -f, --dry-run and --ignore-unmatch.
> - Added test where the pathspec matches both sparse and dense entries.
> - Also test if the index entry is really not removed (besides testing
>   `git rm` exit code and stderr).
> - Passed "a" instead of "/a" to git sparse-checkout to avoid MSYS path
>   conversions on Windows that would make some of the new tests fail.
>
> [1]: Although the sparse entries warning is based on the ignored files
>      warning, they have some differences. One of them is that running
>      'git add dir' where 'dir/somefile' is ignored does not trigger a
>      warning, whereas if 'somefile' is a sparse entry, we warn. In
>      this sense, I think it's more coherent to also warn on 'git add .'
>      when . only has sparse entries. This is also consistent with what
>      'git rm -r .' does in the same scenario, after this series.
>
> Matheus Tavares (7):
>   add: include magic part of pathspec on --refresh error
>   t3705: add tests for `git add` in sparse checkouts
>   add: make --chmod and --renormalize honor sparse checkouts
>   pathspec: allow to ignore SKIP_WORKTREE entries on index matching
>   refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES flag
>   add: warn when pathspec only matches SKIP_WORKTREE entries
>   rm: honor sparse checkout patterns
>
>  Documentation/config/advice.txt  |   4 +
>  Documentation/git-rm.txt         |   4 +-
>  advice.c                         |  19 ++++
>  advice.h                         |   4 +
>  builtin/add.c                    |  75 ++++++++++++---
>  builtin/check-ignore.c           |   2 +-
>  builtin/rm.c                     |  35 ++++---
>  cache.h                          |  15 +--
>  pathspec.c                       |  25 ++++-
>  pathspec.h                       |  13 ++-
>  read-cache.c                     |   5 +-
>  t/t3602-rm-sparse-checkout.sh    |  76 +++++++++++++++
>  t/t3700-add.sh                   |   6 ++
>  t/t3705-add-sparse-checkout.sh   | 155 +++++++++++++++++++++++++++++++
>  t/t7011-skip-worktree-reading.sh |   5 -
>  t/t7012-skip-worktree-writing.sh |  19 ----
>  16 files changed, 398 insertions(+), 64 deletions(-)
>  create mode 100755 t/t3602-rm-sparse-checkout.sh
>  create mode 100755 t/t3705-add-sparse-checkout.sh
>
> Range-diff against v1:
> 1:  5612c57977 < -:  ---------- add --chmod: don't update index when --dry-run is used
> 2:  5a06223007 = 1:  2831fd5744 add: include magic part of pathspec on --refresh error
> 3:  4fc81a83b1 ! 2:  72b8787018 t3705: add tests for `git add` in sparse checkouts
>     @@ t/t3705-add-sparse-checkout.sh (new)
>      +
>      +SPARSE_ENTRY_BLOB=""
>      +
>     -+# Optionally take a string for the entry's contents
>     -+setup_sparse_entry()
>     -+{
>     -+  if test -f sparse_entry
>     -+  then
>     -+          rm sparse_entry
>     -+  fi &&
>     ++# Optionally take a printf format string to write to the sparse_entry file
>     ++setup_sparse_entry () {
>     ++  rm -f sparse_entry &&
>      +  git update-index --force-remove sparse_entry &&
>      +
>     -+  if test "$#" -eq 1
>     ++  if test $# -eq 1
>      +  then
>      +          printf "$1" >sparse_entry
>      +  else
>     -+          printf "" >sparse_entry
>     ++          >sparse_entry
>      +  fi &&
>      +  git add sparse_entry &&
>      +  git update-index --skip-worktree sparse_entry &&
>      +  SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
>      +}
>      +
>     -+test_sparse_entry_unchanged() {
>     ++test_sparse_entry_unchanged () {
>      +  echo "100644 $SPARSE_ENTRY_BLOB 0       sparse_entry" >expected &&
>      +  git ls-files --stage sparse_entry >actual &&
>      +  test_cmp expected actual
>      +}
>      +
>     -+test_expect_success "git add does not remove SKIP_WORKTREE entries" '
>     ++setup_gitignore () {
>     ++  test_when_finished rm -f .gitignore &&
>     ++  cat >.gitignore <<-EOF
>     ++  *
>     ++  !/sparse_entry
>     ++  EOF
>     ++}
>     ++
>     ++test_expect_success 'git add does not remove sparse entries' '
>      +  setup_sparse_entry &&
>      +  rm sparse_entry &&
>      +  git add sparse_entry &&
>      +  test_sparse_entry_unchanged
>      +'
>      +
>     -+test_expect_success "git add -A does not remove SKIP_WORKTREE entries" '
>     ++test_expect_success 'git add -A does not remove sparse entries' '
>      +  setup_sparse_entry &&
>      +  rm sparse_entry &&
>     ++  setup_gitignore &&
>      +  git add -A &&
>      +  test_sparse_entry_unchanged
>      +'
>      +
>     -+for opt in "" -f -u --ignore-removal
>     -+do
>     -+  if test -n "$opt"
>     -+  then
>     -+          opt=" $opt"
>     -+  fi
>     ++test_expect_success 'git add . does not remove sparse entries' '
>     ++  setup_sparse_entry &&
>     ++  rm sparse_entry &&
>     ++  setup_gitignore &&
>     ++  git add . &&
>     ++  test_sparse_entry_unchanged
>     ++'
>      +
>     -+  test_expect_success "git add$opt does not update SKIP_WORKTREE entries" '
>     ++for opt in "" -f -u --ignore-removal --dry-run
>     ++do
>     ++  test_expect_success "git add${opt:+ $opt} does not update sparse entries" '
>      +          setup_sparse_entry &&
>      +          echo modified >sparse_entry &&
>      +          git add $opt sparse_entry &&
>     @@ t/t3705-add-sparse-checkout.sh (new)
>      +  '
>      +done
>      +
>     -+test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
>     ++test_expect_success 'git add --refresh does not update sparse entries' '
>      +  setup_sparse_entry &&
>     ++  git ls-files --debug sparse_entry | grep mtime >before &&
>      +  test-tool chmtime -60 sparse_entry &&
>      +  git add --refresh sparse_entry &&
>     -+
>     -+  # We must unset the SKIP_WORKTREE bit, otherwise
>     -+  # git diff-files would skip examining the file
>     -+  git update-index --no-skip-worktree sparse_entry &&
>     -+
>     -+  echo sparse_entry >expected &&
>     -+  git diff-files --name-only sparse_entry >actual &&
>     -+  test_cmp actual expected
>     ++  git ls-files --debug sparse_entry | grep mtime >after &&
>     ++  test_cmp before after
>      +'
>      +
>     -+test_expect_failure 'git add --chmod does not update SKIP_WORKTREE entries' '
>     ++test_expect_failure 'git add --chmod does not update sparse entries' '
>      +  setup_sparse_entry &&
>      +  git add --chmod=+x sparse_entry &&
>     -+  test_sparse_entry_unchanged
>     ++  test_sparse_entry_unchanged &&
>     ++  ! test -x sparse_entry
>      +'
>      +
>     -+test_expect_failure 'git add --renormalize does not update SKIP_WORKTREE entries' '
>     ++test_expect_failure 'git add --renormalize does not update sparse entries' '
>      +  test_config core.autocrlf false &&
>      +  setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
>      +  echo "sparse_entry text=auto" >.gitattributes &&
> 4:  ccb05cc3d7 ! 3:  0f03adf241 add: make --chmod and --renormalize honor sparse checkouts
>     @@ Commit message
>          Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>
>       ## builtin/add.c ##
>     -@@ builtin/add.c: static void chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
>     -   for (i = 0; i < active_nr; i++) {
>     +@@ builtin/add.c: static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
>                 struct cache_entry *ce = active_cache[i];
>     +           int err;
>
>      +          if (ce_skip_worktree(ce))
>      +                  continue;
>     @@ builtin/add.c: static int renormalize_tracked_files(const struct pathspec *paths
>                 if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
>
>       ## t/t3705-add-sparse-checkout.sh ##
>     -@@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
>     -   test_cmp actual expected
>     +@@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --refresh does not update sparse entries' '
>     +   test_cmp before after
>       '
>
>     --test_expect_failure 'git add --chmod does not update SKIP_WORKTREE entries' '
>     -+test_expect_success 'git add --chmod does not update SKIP_WORKTREE entries' '
>     +-test_expect_failure 'git add --chmod does not update sparse entries' '
>     ++test_expect_success 'git add --chmod does not update sparse entries' '
>         setup_sparse_entry &&
>         git add --chmod=+x sparse_entry &&
>     -   test_sparse_entry_unchanged
>     +   test_sparse_entry_unchanged &&
>     +   ! test -x sparse_entry
>       '
>
>     --test_expect_failure 'git add --renormalize does not update SKIP_WORKTREE entries' '
>     -+test_expect_success 'git add --renormalize does not update SKIP_WORKTREE entries' '
>     +-test_expect_failure 'git add --renormalize does not update sparse entries' '
>     ++test_expect_success 'git add --renormalize does not update sparse entries' '
>         test_config core.autocrlf false &&
>         setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
>         echo "sparse_entry text=auto" >.gitattributes &&
> 5:  00786cba82 = 4:  a8a8af22a0 pathspec: allow to ignore SKIP_WORKTREE entries on index matching
> -:  ---------- > 5:  d65b214dd1 refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES flag
> 6:  ce74a60e0d ! 6:  24e889ca9b add: warn when pathspec only matches SKIP_WORKTREE entries
>     @@ Commit message
>          add: warn when pathspec only matches SKIP_WORKTREE entries
>
>          `git add` already refrains from updating SKIP_WORKTREE entries, but it
>     -    silently succeeds when a pathspec only matches these entries. Instead,
>     -    let's warn the user and display a hint on how to update these entries.
>     +    silently exits with zero code when a pathspec only matches these
>     +    entries. Instead, let's warn the user and display a hint on how to
>     +    update these entries.
>
>          Note that the warning is only shown if the pathspec matches no untracked
>          paths in the working tree and only matches index entries with the
>     -    SKIP_WORKTREE bit set. Performance-wise, this patch doesn't change the
>     -    number of ce_path_match() calls in the worst case scenario (because we
>     -    still need to check the sparse entries for the warning). But in the
>     -    general case, it avoids unnecessarily calling this function for each
>     -    SKIP_WORKTREE entry.
>     -
>     -    A warning message was chosen over erroring out right away to reproduce
>     -    the same behavior `add` already exhibits with ignored files. This also
>     -    allow users to continue their workflow without having to invoke `add`
>     -    again with only the matching pathspecs, as the matched files will have
>     -    already been added.
>     -
>     -    Note: refresh_index() was changed to only mark matches with
>     -    no-SKIP-WORKTREE entries in the `seen` output parameter. This is exactly
>     -    the behavior we want for `add`, and only `add` calls this function with
>     -    a non-NULL `seen` pointer. So the change brings no side effect on
>     -    other callers.
>     +    SKIP_WORKTREE bit set. A warning message was chosen over erroring out
>     +    right away to reproduce the same behavior `add` already exhibits with
>     +    ignored files. This also allow users to continue their workflow without
>     +    having to invoke `add` again with only the matching pathspecs, as the
>     +    matched files will have already been added.
>
>          Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>
>     @@ builtin/add.c: static char *prune_directory(struct dir_struct *dir, struct paths
>      +  int i, ret = 0;
>      +  char *skip_worktree_seen = NULL;
>      +  struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
>     ++  int flags = REFRESH_DONT_MARK_SPARSE_MATCHES |
>     ++              (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
>
>         seen = xcalloc(pathspec->nr, 1);
>     -   refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET,
>     -                 pathspec, seen, _("Unstaged changes after refreshing the index:"));
>     +-  refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET,
>     +-                pathspec, seen, _("Unstaged changes after refreshing the index:"));
>     ++  refresh_index(&the_index, flags, pathspec, seen,
>     ++                _("Unstaged changes after refreshing the index:"));
>         for (i = 0; i < pathspec->nr; i++) {
>      -          if (!seen[i])
>      -                  die(_("pathspec '%s' did not match any files"),
>     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
>      -                      ((pathspec.items[i].magic &
>      -                        (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
>      -                       !file_exists(path))) {
>     -+                  if (seen[i] || !path[0])
>     ++                  if (seen[i])
>      +                          continue;
>      +
>      +                  if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
>     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
>      +                          continue;
>      +                  }
>      +
>     ++                  /* Don't complain at 'git add .' inside empty repo. */
>     ++                  if (!path[0])
>     ++                          continue;
>     ++
>      +                  if ((pathspec.items[i].magic & (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
>      +                      !file_exists(path)) {
>                                 if (ignore_missing) {
>     @@ pathspec.h: void add_pathspec_matches_against_index(const struct pathspec *paths
>                          const char *name, int namelen,
>                          const struct pathspec_item *item);
>
>     - ## read-cache.c ##
>     -@@ read-cache.c: int refresh_index(struct index_state *istate, unsigned int flags,
>     -           if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
>     -                   continue;
>     -
>     --          if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
>     -+          if (pathspec && !ce_path_match(istate, ce, pathspec,
>     -+                                         ce_skip_worktree(ce) ? NULL : seen))
>     -                   filtered = 1;
>     -
>     -           if (ce_stage(ce)) {
>     -
>       ## t/t3705-add-sparse-checkout.sh ##
>     -@@ t/t3705-add-sparse-checkout.sh: test_sparse_entry_unchanged() {
>     -   test_cmp expected actual
>     +@@ t/t3705-add-sparse-checkout.sh: setup_gitignore () {
>     +   EOF
>       }
>
>     -+cat >sparse_entry_error <<-EOF
>     -+The following pathspecs only matched index entries outside the current
>     -+sparse checkout:
>     -+sparse_entry
>     -+EOF
>     ++test_expect_success 'setup' '
>     ++  cat >sparse_error_header <<-EOF &&
>     ++  The following pathspecs only matched index entries outside the current
>     ++  sparse checkout:
>     ++  EOF
>     ++
>     ++  cat >sparse_hint <<-EOF &&
>     ++  hint: Disable or modify the sparsity rules if you intend to update such entries.
>     ++  hint: Disable this message with "git config advice.updateSparsePath false"
>     ++  EOF
>      +
>     -+cat >error_and_hint sparse_entry_error - <<-EOF
>     -+hint: Disable or modify the sparsity rules if you intend to update such entries.
>     -+hint: Disable this message with "git config advice.updateSparsePath false"
>     -+EOF
>     ++  echo sparse_entry | cat sparse_error_header - >sparse_entry_error &&
>     ++  cat sparse_entry_error sparse_hint >error_and_hint
>     ++'
>      +
>     - test_expect_success "git add does not remove SKIP_WORKTREE entries" '
>     + test_expect_success 'git add does not remove sparse entries' '
>         setup_sparse_entry &&
>         rm sparse_entry &&
>      -  git add sparse_entry &&
>     @@ t/t3705-add-sparse-checkout.sh: test_sparse_entry_unchanged() {
>         test_sparse_entry_unchanged
>       '
>
>     +@@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add -A does not remove sparse entries' '
>     +   setup_sparse_entry &&
>     +   rm sparse_entry &&
>     +   setup_gitignore &&
>     +-  git add -A &&
>     ++  git add -A 2>stderr &&
>     ++  test_must_be_empty stderr &&
>     +   test_sparse_entry_unchanged
>     + '
>     +
>     +@@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add . does not remove sparse entries' '
>     +   setup_sparse_entry &&
>     +   rm sparse_entry &&
>     +   setup_gitignore &&
>     +-  git add . &&
>     ++  test_must_fail git add . 2>stderr &&
>     ++
>     ++  cat sparse_error_header >expect &&
>     ++  echo . >>expect &&
>     ++  cat sparse_hint >>expect &&
>     ++
>     ++  test_i18ncmp expect stderr &&
>     +   test_sparse_entry_unchanged
>     + '
>     +
>      @@ t/t3705-add-sparse-checkout.sh: do
>     -   test_expect_success "git add$opt does not update SKIP_WORKTREE entries" '
>     +   test_expect_success "git add${opt:+ $opt} does not update sparse entries" '
>                 setup_sparse_entry &&
>                 echo modified >sparse_entry &&
>      -          git add $opt sparse_entry &&
>     @@ t/t3705-add-sparse-checkout.sh: do
>                 test_sparse_entry_unchanged
>         '
>       done
>     -@@ t/t3705-add-sparse-checkout.sh: done
>     - test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
>     +@@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --refresh does not update sparse entries' '
>         setup_sparse_entry &&
>     +   git ls-files --debug sparse_entry | grep mtime >before &&
>         test-tool chmtime -60 sparse_entry &&
>      -  git add --refresh sparse_entry &&
>      +  test_must_fail git add --refresh sparse_entry 2>stderr &&
>      +  test_i18ncmp error_and_hint stderr &&
>     +   git ls-files --debug sparse_entry | grep mtime >after &&
>     +   test_cmp before after
>     + '
>
>     -   # We must unset the SKIP_WORKTREE bit, otherwise
>     -   # git diff-files would skip examining the file
>     -@@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
>     -
>     - test_expect_success 'git add --chmod does not update SKIP_WORKTREE entries' '
>     + test_expect_success 'git add --chmod does not update sparse entries' '
>         setup_sparse_entry &&
>      -  git add --chmod=+x sparse_entry &&
>      +  test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
>      +  test_i18ncmp error_and_hint stderr &&
>     -   test_sparse_entry_unchanged
>     +   test_sparse_entry_unchanged &&
>     +   ! test -x sparse_entry
>       '
>     -
>     -@@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --renormalize does not update SKIP_WORKTREE entries
>     +@@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --renormalize does not update sparse entries' '
>         test_config core.autocrlf false &&
>         setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
>         echo "sparse_entry text=auto" >.gitattributes &&
>     @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --renormalize does
>         test_sparse_entry_unchanged
>       '
>
>     ++test_expect_success 'git add --dry-run --ignore-missing warn on sparse path' '
>     ++  setup_sparse_entry &&
>     ++  rm sparse_entry &&
>     ++  test_must_fail git add --dry-run --ignore-missing sparse_entry 2>stderr &&
>     ++  test_i18ncmp error_and_hint stderr &&
>     ++  test_sparse_entry_unchanged
>     ++'
>     ++
>      +test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
>      +  setup_sparse_entry &&
>     -+  test_must_fail git add nonexistent sp 2>stderr &&
>     ++  test_must_fail git add nonexistent 2>stderr &&
>      +  test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
>      +  test_i18ngrep ! "The following pathspecs only matched index entries" stderr
>      +'
>      +
>     ++test_expect_success 'do not warn when pathspec matches dense entries' '
>     ++  setup_sparse_entry &&
>     ++  echo modified >sparse_entry &&
>     ++  >dense_entry &&
>     ++  git add "*_entry" 2>stderr &&
>     ++  test_must_be_empty stderr &&
>     ++  test_sparse_entry_unchanged &&
>     ++  git ls-files --error-unmatch dense_entry
>     ++'
>     ++
>      +test_expect_success 'add obeys advice.updateSparsePath' '
>      +  setup_sparse_entry &&
>      +  test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
> 7:  e76c7c6999 ! 7:  08f0c32bfc rm: honor sparse checkout patterns
>     @@ Commit message
>          rules, but `git rm` doesn't follow the same restrictions. This is
>          somewhat counter-intuitive and inconsistent. So make `rm` honor the
>          sparse checkout and advise on how to remove SKIP_WORKTREE entries, just
>     -    like `add` does. Also add a few tests for the new behavior.
>     +    like `add` does. Also add some tests for the new behavior.
>
>          Suggested-by: Elijah Newren <newren@gmail.com>
>          Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>     @@ builtin/rm.c: int cmd_rm(int argc, const char **argv, const char *prefix)
>      +  return ret;
>       }
>
>     - ## t/t3600-rm.sh ##
>     -@@ t/t3600-rm.sh: test_expect_success 'rm empty string should fail' '
>     -   test_must_fail git rm -rf ""
>     - '
>     -
>     -+test_expect_success 'setup repo for tests with sparse-checkout' '
>     -+  git init sparse &&
>     -+  (
>     -+          cd sparse &&
>     -+          mkdir -p sub/dir &&
>     -+          touch a b c sub/d sub/dir/e &&
>     -+          git add -A &&
>     -+          git commit -m files
>     -+  ) &&
>     + ## t/t3602-rm-sparse-checkout.sh (new) ##
>     +@@
>     ++#!/bin/sh
>     ++
>     ++test_description='git rm in sparse checked out working trees'
>     ++
>     ++. ./test-lib.sh
>     ++
>     ++test_expect_success 'setup' '
>     ++  mkdir -p sub/dir &&
>     ++  touch a b c sub/d sub/dir/e &&
>     ++  git add -A &&
>     ++  git commit -m files &&
>      +
>      +  cat >sparse_entry_b_error <<-EOF &&
>      +  The following pathspecs only matched index entries outside the current
>     @@ t/t3600-rm.sh: test_expect_success 'rm empty string should fail' '
>      +  EOF
>      +'
>      +
>     -+test_expect_success 'rm should respect sparse-checkout' '
>     -+  git -C sparse sparse-checkout set "/a" &&
>     -+  test_must_fail git -C sparse rm b 2>stderr &&
>     -+  test_i18ncmp b_error_and_hint stderr
>     ++for opt in "" -f --dry-run
>     ++do
>     ++  test_expect_success "rm${opt:+ $opt} does not remove sparse entries" '
>     ++          git sparse-checkout set a &&
>     ++          test_must_fail git rm $opt b 2>stderr &&
>     ++          test_i18ncmp b_error_and_hint stderr &&
>     ++          git ls-files --error-unmatch b
>     ++  '
>     ++done
>     ++
>     ++test_expect_success 'recursive rm does not remove sparse entries' '
>     ++  git reset --hard &&
>     ++  git sparse-checkout set sub/dir &&
>     ++  git rm -r sub &&
>     ++  git status --porcelain -uno >actual &&
>     ++  echo "D  sub/dir/e" >expected &&
>     ++  test_cmp expected actual
>      +'
>      +
>      +test_expect_success 'rm obeys advice.updateSparsePath' '
>     -+  git -C sparse reset --hard &&
>     -+  git -C sparse sparse-checkout set "/a" &&
>     -+  test_must_fail git -C sparse -c advice.updateSparsePath=false rm b 2>stderr &&
>     ++  git reset --hard &&
>     ++  git sparse-checkout set a &&
>     ++  test_must_fail git -c advice.updateSparsePath=false rm b 2>stderr &&
>      +  test_i18ncmp sparse_entry_b_error stderr
>     -+
>     -+'
>     -+
>     -+test_expect_success 'recursive rm should respect sparse-checkout' '
>     -+  (
>     -+          cd sparse &&
>     -+          git reset --hard &&
>     -+          git sparse-checkout set "sub/dir" &&
>     -+          git rm -r sub &&
>     -+          git status --porcelain -uno >../actual
>     -+  ) &&
>     -+  echo "D  sub/dir/e" >expected &&
>     -+  test_cmp expected actual
>      +'
>      +
>      +test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
>     -+  test_must_fail git -C sparse rm nonexistent 2>stderr &&
>     ++  git reset --hard &&
>     ++  git sparse-checkout set a &&
>     ++  test_must_fail git rm nonexistent 2>stderr &&
>      +  test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
>      +  test_i18ngrep ! "The following pathspecs only matched index entries" stderr
>      +'
>      +
>     - test_done
>     ++test_expect_success 'do not warn about sparse entries when pathspec matches dense entries' '
>     ++  git reset --hard &&
>     ++  git sparse-checkout set a &&
>     ++  git rm "[ba]" 2>stderr &&
>     ++  test_must_be_empty stderr &&
>     ++  git ls-files --error-unmatch b &&
>     ++  test_must_fail git ls-files --error-unmatch a
>     ++'
>     ++
>     ++test_expect_success 'do not warn about sparse entries with --ignore-unmatch' '
>     ++  git reset --hard &&
>     ++  git sparse-checkout set a &&
>     ++  git rm --ignore-unmatch b 2>stderr &&
>     ++  test_must_be_empty stderr &&
>     ++  git ls-files --error-unmatch b
>     ++'
>     ++
>     ++test_done
>
>       ## t/t7011-skip-worktree-reading.sh ##
>      @@ t/t7011-skip-worktree-reading.sh: test_expect_success 'diff-files does not examine skip-worktree dirty entries' '
> --
> 2.30.1
>
