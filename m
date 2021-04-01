Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12D9C43460
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2856023F
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhDABua (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhDABuG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32551C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v11so182307wro.7
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=51kps56fbg2+KoQaGGJ21jlOszXaX2bxe4l2Kwg4vbc=;
        b=J/wxIVQcuZ7+MXOUlPssz1MPZONlOEVqQWvqUiFze8y7z5HHHIo3AWEzrZ7qgYk0Yt
         CWcrwOdF+g2a7oAbHrhg5b8rNCK1N3i8cwjZ43i27y1HRuQWSbC1mXqa/HTBp6VRcGBA
         maVrYsPEqVB2LQi8WEpUcxJAwfmietylSOs7ivz3p7YXOkrH/zP9Oiltjvb4s06KbIk5
         2O+0lVf2pe/DDxA2HFtyUYtqarCMye7e/BK4JQtnf9NfmCJtkKbpaQZ4IDrbgLNiH4Ha
         q1mmz4oV2qa6U46rcXL2TdtBM2wfHb0bWEk+wFn2Evc51W6wwX8kukTcO/oGmHFazk+6
         pFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=51kps56fbg2+KoQaGGJ21jlOszXaX2bxe4l2Kwg4vbc=;
        b=SqBtZd9Y/hqZo7UrQPGIGzYVcgtnSdb/nXQ8/VjKduVcsTze70DNdXbNBmucz6k/8c
         gcnUWBmbuzy4n4zxK4VFWHwzF0NV954m+7KiSD2tYcpKm3IUGblQI8NJt8I0gg1A9LAq
         myDNXHja8gG1p35jQHL6Jr4KxGwK+PfzmTRPNuCe+YvIJJvOCjnsTdseayHg7UU1mvLn
         d9swofswP6ZBusti0KBtz+GeOgm4fcxl6UdoNE89dtPfXwQxiqdmKCEI1rW2xTcucH1h
         A9wRna/69VHhtfAsqVshb29FiujBiE2O+SMyakY1GpO+zJlLcB+WTymqIJzTd/C9NCp4
         aSmw==
X-Gm-Message-State: AOAM533laA65NC1HAyfxOnV9shQ1gJKsziWksLR/Aln4484gePhnMMsz
        e5wqZSpboN1p9dozDbRZML+gCdlMaIk=
X-Google-Smtp-Source: ABdhPJxKLtwF0yjYDahmzPDbgTvDdFD6rjdsPu5zdzhD5Xo+TqaYS5tZT8i61uKo74TUH7srb4+BdQ==
X-Received: by 2002:a5d:550b:: with SMTP id b11mr6718123wrv.313.1617241804789;
        Wed, 31 Mar 2021 18:50:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k24sm5920924wmr.48.2021.03.31.18.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:04 -0700 (PDT)
Message-Id: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:37 +0000
Subject: [PATCH v2 00/25] Sparse Index: API protections
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the second patch series submission coming out of the sparse-index
RFC [1].

[1]
https://lore.kernel.org/git/pull.847.git.1611596533.gitgitgadget@gmail.com/

This is based on v3 of the format series [2].

[2]
https://lore.kernel.org/git/pull.883.v3.git.1615912983.gitgitgadget@gmail.com/

The point of this series is to insert protections for the consumers of the
in-memory index to avoid unintended behavior change when using a sparse
index versus a full one.

We mark certain regions of code as needing a full index, so we call
ensure_full_index() to expand a sparse index to a full one, if necessary.
These protections are inserted file-by-file in every loop over all cache
entries. Well, "most" loops, because some are going to be handled in the
very next series so I leave them out.

Many callers use index_name_pos() to find a path by name. In these cases, we
can check if that position resolves to a sparse directory instance. In those
cases, we just expand to a full index and run the search again.

The last few patches deal with the name-hash hashtable for doing O(1)
lookups.

These protections don't do much right now, since the previous series created
the_repository->settings.command_requires_full_index to guard all index
reads and writes to ensure the in-memory copy is full for commands that have
not been tested with the sparse index yet.

However, after this series is complete, we now have a straight-forward plan
for making commands "sparse aware" one-by-one:

 1. Disable settings.command_requires_full_index to allow an in-memory
    sparse-index.
 2. Run versions of that command under a debugger, breaking on
    ensure_full_index().
 3. Examine the call stack to determine the context of that expansion, then
    implement the proper behavior in those locations.
 4. Add tests to ensure we are checking this logic in the presence of sparse
    directory entries.

I will admit that mostly it is the writing of the test cases that takes the
most time in the conversions I've done so far.


Updates in v2
=============

 * Rebased onto v5 of ds/sparse-index
 * Updated the technical doc to describe how these protections are guards to
   keep behavior consistent between a sparse-index and a full index. Whether
   or not that behavior is "correct" can be interrogated later.
 * Calls to ensure_full_index() are marked with a TODO comment saying these
   calls should be audited later (with tests).
 * Fixed an incorrectly squashed commit message.
 * Dropped the diff-lib.c commit because it was erroneously included in v2.
 * Dropped the merge-ort.c commit because of conflicts with work in flight
   and a quick audit that it is not needed.
 * I reviewed the merge of this topic with mt/add-rm-in-sparse-checkout and
   found it equivalent to what I would have done.

Thanks, -Stolee

Derrick Stolee (25):
  sparse-index: API protection strategy
  *: remove 'const' qualifier for struct index_state
  read-cache: expand on query into sparse-directory entry
  cache: move ensure_full_index() to cache.h
  add: ensure full index
  checkout-index: ensure full index
  checkout: ensure full index
  commit: ensure full index
  difftool: ensure full index
  fsck: ensure full index
  grep: ensure full index
  ls-files: ensure full index
  merge-index: ensure full index
  rm: ensure full index
  stash: ensure full index
  update-index: ensure full index
  dir: ensure full index
  entry: ensure full index
  merge-recursive: ensure full index
  pathspec: ensure full index
  read-cache: ensure full index
  resolve-undo: ensure full index
  revision: ensure full index
  sparse-index: expand_to_path()
  name-hash: use expand_to_path()

 Documentation/technical/sparse-index.txt | 37 +++++++++++-
 attr.c                                   | 14 ++---
 attr.h                                   |  4 +-
 builtin/add.c                            |  2 +
 builtin/checkout-index.c                 |  2 +
 builtin/checkout.c                       |  5 ++
 builtin/commit.c                         |  4 ++
 builtin/difftool.c                       |  3 +
 builtin/fsck.c                           |  2 +
 builtin/grep.c                           |  2 +
 builtin/ls-files.c                       | 14 +++--
 builtin/merge-index.c                    |  5 ++
 builtin/rm.c                             |  2 +
 builtin/stash.c                          |  2 +
 builtin/update-index.c                   |  2 +
 cache.h                                  |  7 ++-
 convert.c                                | 26 ++++-----
 convert.h                                | 20 +++----
 dir.c                                    | 14 +++--
 dir.h                                    |  8 +--
 entry.c                                  |  2 +
 merge-recursive.c                        |  4 +-
 name-hash.c                              | 10 ++++
 pathspec.c                               |  8 ++-
 pathspec.h                               |  6 +-
 read-cache.c                             | 35 ++++++++++--
 resolve-undo.c                           |  4 ++
 revision.c                               |  2 +
 sparse-index.c                           | 72 ++++++++++++++++++++++++
 sparse-index.h                           | 14 ++++-
 submodule.c                              |  6 +-
 submodule.h                              |  6 +-
 32 files changed, 273 insertions(+), 71 deletions(-)


base-commit: 66602733cc95d9a53594520cd8b28d3338e258ea
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-906%2Fderrickstolee%2Fsparse-index%2Fprotections-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-906/derrickstolee/sparse-index/protections-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/906

Range-diff vs v1:

  3:  bbf19f8a2be5 !  1:  7484e085e342 sparse-index: API protection strategy
     @@ Commit message
          Looking for non-zero stage:
          * builtin/add.c:chmod_pathspec()
          * builtin/merge.c:count_unmerged_entries()
     +    * merge-ort.c:record_conflicted_index_entries()
          * read-cache.c:unmerged_index()
          * rerere.c:check_one_conflict(), find_conflict(), rerere_remaining()
          * revision.c:prepare_show_merge()
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/technical/sparse-index.txt ##
     -@@ Documentation/technical/sparse-index.txt: also introduce other features that have been considered for improving the
     - index, as well.
     +@@ Documentation/technical/sparse-index.txt: index, as well.
       
       Next, consumers of the index will be guarded against operating on a
     --sparse-index by inserting calls to `ensure_full_index()` or
     + sparse-index by inserting calls to `ensure_full_index()` or
      -`expand_index_to_path()`. After these guards are in place, we can begin
      -leaving sparse-directory entries in the in-memory index structure.
     -+sparse-index by inserting calls to `ensure_full_index()` before iterating
     -+over all cache entries. If a specific path is requested, then those will
     ++`expand_index_to_path()`. If a specific path is requested, then those will
      +be protected from within the `index_file_exists()` and `index_name_pos()`
     -+API calls: they will call `ensure_full_index()` if necessary.
     ++API calls: they will call `ensure_full_index()` if necessary. The
     ++intention here is to preserve existing behavior when interacting with a
     ++sparse-checkout. We don't want a change to happen by accident, without
     ++tests. Many of these locations may not need any change before removing the
     ++guards, but we should not do so without tests to ensure the expected
     ++behavior happens.
     ++
     ++It may be desirable to _change_ the behavior of some commands in the
     ++presence of a sparse index or more generally in any sparse-checkout
     ++scenario. In such cases, these should be carefully communicated and
     ++tested. No such behavior changes are intended during this phase.
      +
      +During a scan of the codebase, not every iteration of the cache entries
      +needs an `ensure_full_index()` check. The basic reasons include:
     @@ Documentation/technical/sparse-index.txt: also introduce other features that hav
      +
      +6. The sparse-index is disabled at this point when using the split-index
      +   feature, so no effort is made to protect the split-index API.
     -+
     -+After these guards are in place, we can begin leaving sparse-directory
     -+entries in the in-memory index structure.
       
       Even after inserting these guards, we will keep expanding sparse-indexes
       for most Git commands using the `command_requires_full_index` repository
  1:  628e16dd3fc7 =  2:  098b2c9ef352 *: remove 'const' qualifier for struct index_state
  2:  8e11e8917019 =  3:  737d27e18d64 read-cache: expand on query into sparse-directory entry
  4:  7e4079c48eb2 =  4:  db5c100f3e2b cache: move ensure_full_index() to cache.h
  5:  142df1ab8e3e !  5:  4a5fc2eb5a9f add: ensure full index
     @@ builtin/add.c: static int renormalize_tracked_files(const struct pathspec *paths
       {
       	int i, retval = 0;
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(&the_index);
       	for (i = 0; i < active_nr; i++) {
       		struct cache_entry *ce = active_cache[i];
  6:  bfa0164cc3c1 !  6:  11c38f7277c5 checkout-index: ensure full index
     @@ builtin/checkout-index.c: static void checkout_all(const char *prefix, int prefi
       	int i, errs = 0;
       	struct cache_entry *last_ce = NULL;
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(&the_index);
       	for (i = 0; i < active_nr ; i++) {
       		struct cache_entry *ce = active_cache[i];
  7:  1bb7b6117e41 !  7:  fd04adbb3f79 checkout: ensure full index
     @@ builtin/checkout.c: static int checkout_worktree(const struct checkout_opts *opt
       			       NULL);
       
       	enable_delayed_checkout(&state);
     ++
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(&the_index);
       	for (pos = 0; pos < active_nr; pos++) {
       		struct cache_entry *ce = active_cache[pos];
     @@ builtin/checkout.c: static int checkout_paths(const struct checkout_opts *opts,
       	 * Make sure all pathspecs participated in locating the paths
       	 * to be checked out.
       	 */
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(&the_index);
       	for (pos = 0; pos < active_nr; pos++)
       		if (opts->overlay_mode)
  8:  a59e45c4ae8f !  8:  65704f39edc9 commit: ensure full index
     @@ builtin/commit.c: static int list_paths(struct string_list *list, const char *wi
       		free(max_prefix);
       	}
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(&the_index);
       	for (i = 0; i < active_nr; i++) {
       		const struct cache_entry *ce = active_cache[i];
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
       		if (get_oid(parent, &oid)) {
       			int i, ita_nr = 0;
       
     ++			/* TODO: audit for interaction with sparse-index. */
      +			ensure_full_index(&the_index);
       			for (i = 0; i < active_nr; i++)
       				if (ce_intent_to_add(active_cache[i]))
  9:  83040e7558f3 !  9:  739f3fe9edf2 difftool: ensure full index
     @@ builtin/difftool.c: static int run_dir_diff(const char *extcmd, int symlinks, co
       		setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
       	rc = run_command_v_opt(helper_argv, flags);
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(&wtindex);
      +
       	/*
 10:  988f7bd2d736 ! 10:  779a86ad1ec4 fsck: ensure full index
     @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char *prefix)
       		verify_index_checksum = 1;
       		verify_ce_order = 1;
       		read_cache();
     ++		/* TODO: audit for interaction with sparse-index. */
      +		ensure_full_index(&the_index);
       		for (i = 0; i < active_nr; i++) {
       			unsigned int mode;
 11:  abe189051a0c ! 11:  8c0d377054fa grep: ensure full index
     @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
       	if (repo_read_index(repo) < 0)
       		die(_("index file corrupt"));
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(repo->index);
       	for (nr = 0; nr < repo->index->cache_nr; nr++) {
       		const struct cache_entry *ce = repo->index->cache[nr];
 12:  00c8a7e1d119 ! 12:  beaa1467cabb ls-files: ensure full index
     @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_s
       
       	if (!(show_cached || show_stage || show_deleted || show_modified))
       		return;
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(repo->index);
       	for (i = 0; i < repo->index->cache_nr; i++) {
       		const struct cache_entry *ce = repo->index->cache[i];
     @@ builtin/ls-files.c: void overlay_tree_on_index(struct index_state *istate,
       		die("bad tree-ish %s", tree_name);
       
       	/* Hoist the unmerged entries up to stage #3 to make room */
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(istate);
       	for (i = 0; i < istate->cache_nr; i++) {
       		struct cache_entry *ce = istate->cache[i];
 13:  1288f02177d2 ! 13:  73684141fcff merge-index: ensure full index
     @@ builtin/merge-index.c: static void merge_one_path(const char *path)
       static void merge_all(void)
       {
       	int i;
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(&the_index);
       	for (i = 0; i < active_nr; i++) {
       		const struct cache_entry *ce = active_cache[i];
     @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const ch
       
       	read_cache();
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(&the_index);
      +
       	i = 1;
 14:  d6816560b32f ! 14:  6ea81a49c6b5 rm: ensure full index
     @@ builtin/rm.c: int cmd_rm(int argc, const char **argv, const char *prefix)
       
       	seen = xcalloc(pathspec.nr, 1);
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(&the_index);
       	for (i = 0; i < active_nr; i++) {
       		const struct cache_entry *ce = active_cache[i];
 15:  92ccd31dd343 ! 15:  49ca5ed05c8d sparse-checkout: ensure full index
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    sparse-checkout: ensure full index
     +    stash: ensure full index
      
     -    When adjusting the sparse-checkout definition, ensure that a sparse
     -    index is expanded to a full one to avoid unexpected behavior. This is a
     -    top candidate for later integration with the sparse-index, but requires
     -    careful testing.
     +    Before iterating over all cache entries, ensure that a sparse index is
     +    expanded to a full index to avoid unexpected behavior.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char
       		int i;
       		char *ps_matched = xcalloc(ps->nr, 1);
       
     ++		/* TODO: audit for interaction with sparse-index. */
      +		ensure_full_index(&the_index);
       		for (i = 0; i < active_nr; i++)
       			ce_path_match(&the_index, active_cache[i], ps,
 16:  796449758a08 ! 16:  9c4bb187c15d update-index: ensure full index
     @@ builtin/update-index.c: static int do_reupdate(int ac, const char **av,
       		 */
       		has_head = 0;
        redo:
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(&the_index);
       	for (pos = 0; pos < active_nr; pos++) {
       		const struct cache_entry *ce = active_cache[pos];
 17:  45bbed6150a2 <  -:  ------------ diff-lib: ensure full index
 18:  8ce1f80985a4 ! 17:  fae4c078c3ef dir: ensure full index
     @@ dir.c: static void connect_wt_gitdir_in_nested(const char *sub_worktree,
       	if (repo_read_index(&subrepo) < 0)
       		die(_("index file corrupt in repo %s"), subrepo.gitdir);
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(subrepo.index);
       	for (i = 0; i < subrepo.index->cache_nr; i++) {
       		const struct cache_entry *ce = subrepo.index->cache[i];
 19:  6e0b452f44c1 ! 18:  2b9180ee77d3 entry: ensure full index
     @@ entry.c: static void mark_colliding_entries(const struct checkout *state,
       
       	ce->ce_flags |= CE_MATCHED;
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(state->istate);
       	for (i = 0; i < state->istate->cache_nr; i++) {
       		struct cache_entry *dup = state->istate->cache[i];
 20:  fb4c7038b746 <  -:  ------------ merge-ort: ensure full index
 21:  57d59825627f ! 19:  1e3f6085a405 merge-recursive: ensure full index
     @@ merge-recursive.c: static struct string_list *get_unmerged(struct index_state *i
       
       	unmerged->strdup_strings = 1;
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(istate);
       	for (i = 0; i < istate->cache_nr; i++) {
       		struct string_list_item *item;
 22:  f4c470686b27 ! 20:  e62a597a9725 pathspec: ensure full index
     @@ pathspec.c: void add_pathspec_matches_against_index(const struct pathspec *paths
       			num_unmatched++;
       	if (!num_unmatched)
       		return;
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(istate);
       	for (i = 0; i < istate->cache_nr; i++) {
       		const struct cache_entry *ce = istate->cache[i];
 23:  81519782d4b2 ! 21:  ebfffdbdd6ad read-cache: ensure full index
     @@ read-cache.c: int refresh_index(struct index_state *istate, unsigned int flags,
       	 */
       	preload_index(istate, pathspec, 0);
       	trace2_region_enter("index", "refresh", NULL);
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(istate);
       	for (i = 0; i < istate->cache_nr; i++) {
       		struct cache_entry *ce, *new_entry;
     @@ read-cache.c: int repo_index_has_changes(struct repository *repo,
       		diff_flush(&opt);
       		return opt.flags.has_changes != 0;
       	} else {
     ++		/* TODO: audit for interaction with sparse-index. */
      +		ensure_full_index(istate);
       		for (i = 0; sb && i < istate->cache_nr; i++) {
       			if (i)
 24:  39e8bea0c1ca ! 22:  495b07a87973 resolve-undo: ensure full index
     @@ resolve-undo.c: void unmerge_marked_index(struct index_state *istate)
       	if (!istate->resolve_undo)
       		return;
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(istate);
       	for (i = 0; i < istate->cache_nr; i++) {
       		const struct cache_entry *ce = istate->cache[i];
     @@ resolve-undo.c: void unmerge_index(struct index_state *istate, const struct path
       	if (!istate->resolve_undo)
       		return;
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(istate);
       	for (i = 0; i < istate->cache_nr; i++) {
       		const struct cache_entry *ce = istate->cache[i];
 25:  6abb1813ae10 ! 23:  3144114d1a75 revision: ensure full index
     @@ revision.c: static void do_add_index_objects_to_pending(struct rev_info *revs,
       {
       	int i;
       
     ++	/* TODO: audit for interaction with sparse-index. */
      +	ensure_full_index(istate);
       	for (i = 0; i < istate->cache_nr; i++) {
       		struct cache_entry *ce = istate->cache[i];
 26:  1690d33c11e0 = 24:  d52c72b4a7b9 sparse-index: expand_to_path()
 27:  40cfc59f695a = 25:  7e2d3fae9a2a name-hash: use expand_to_path()

-- 
gitgitgadget
