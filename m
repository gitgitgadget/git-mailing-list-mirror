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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A564FC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA9E64EC8
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBAUXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 15:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhBAUXC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 15:23:02 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E82C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 12:22:22 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id n7so20210743oic.11
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 12:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KgxT4AxcZ0O5qo5iJl0Fptpax9MATyddmNUZT2KLhMQ=;
        b=nczGTKXbjTFxovP0KrNGrzlFc8JihNLB2ah7aGHt92AyRNBhZjqr22VE5CKqZ1rTca
         ulpouFSnuzWjbPKCXf0Me+Z9uATiWuQSAIA3Z0ULGB7iJIcLhwOkwrHdC6KpAElTs0n/
         JRqdgjoPkrh9yz+oi2vpS5lkstkfI2bErrcg4QPas2CYWx3R3RZkk2hAsiSI5ac5gRy+
         pAJFt56+8RxBSU6CXJk5cARXnqs1AuFzpoW4SGprBC2jy50ru0wZnnFsxcFLP0plex1Y
         XD84JjyUCbHczqW2drn2NNMwdQEfd5CcigCuY3bpt2OO/sDpQ8X3s5oDvmHaog8ULeP1
         Kt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KgxT4AxcZ0O5qo5iJl0Fptpax9MATyddmNUZT2KLhMQ=;
        b=i48Cv4nQV6i83YQzi1kzLUJVkKe1rvD/qvpSIe5aRjwbB3xt4ivL1A3u9mH0b9lpw+
         VLw4Q2yQtn5UZgPwhlZENbEweIWQViq+e0FX7m1mz7QIXJ1woopYQv/yB7fvHwfglFYl
         n4fXR8eElquWOet7qbOcBnmxxapaft7aTC0LQyLJq1U0lgtK1rpg2hwQSaK7oJPGaLXv
         ZJVMasGzUA3IxHZbQfZTdgx2WfH/RcL6I6k3oLM8cozxHz2XmoV/zkIwm560ySJtCpwR
         kaFXc4rEbpDQsS9WxhTqfntI0OwNs7KEo4AkTGzBkNK2PIwoL80SDlm+B1px3tcedN9w
         SfjQ==
X-Gm-Message-State: AOAM530BcgjCbuh24HLBOrJRsqQ8SDgR9MbvV1FlpL8coMkOcai2Pq88
        bvKCu2sUJSKlxdWE/MTb/XsIFvxeCf0wSN2vNFGYRNDGW2hykg==
X-Google-Smtp-Source: ABdhPJzPmY2mtX0iiRjGijeoYNeXQOsiQjbk2j1YgBK9bw3ELybQLQMRIW/hRKFObtNNmrOMgLC3qUKncYtEosa/YX8=
X-Received: by 2002:a54:4790:: with SMTP id o16mr418848oic.39.1612210941043;
 Mon, 01 Feb 2021 12:22:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <71b33bb2498d53e5818f3a597240b530976152fb.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <71b33bb2498d53e5818f3a597240b530976152fb.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Feb 2021 12:22:09 -0800
Message-ID: <CABPp-BHSnqPZckgk4oPQonA8YCBQ8jMpH+QzcnpEALr7yc9+rg@mail.gmail.com>
Subject: Re: [PATCH 15/27] [RFC-VERSION] *: ensure full index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> This giant patch is not intended for actual review. I have a branch that
> has these changes split out in a sane way with some commentary in each
> file that is modified.
>
> The idea here is to guard certain portions of the codebase that do not
> know how to handle sparse indexes by ensuring that the index is expanded
> to a full index before proceeding with the logic.
>
> This also provides a good mechanism for testing which code needs
> updating to enable the sparse index in a Git builtin. The builtin can
> set the_repository->settings.command_requires_full_index to zero and
> then we can debug the command with a breakpoint on ensure_full_index().
> That identifies the portion of code that needs adjusting before enabling
> sparse indexes for that command.
>
> Some index operations must be changed to operate on a non-const pointer,
> since ensuring a full index will modify the index itself.
>
> There are likely some gaps to these protections, which is why it will be
> important to carefully test each scenario as we relax the requirements.
> I expect that to be a long effort.

I think the idea makes sense; it provides a way for us to
incrementally build support for this new feature.

I skimmed over the code and noticed various interesting places that
had the ensure_full_index() call (e.g.
read_skip_worktree_file_from_index() -- whose existence comes from
sparsity; what irony...).  Better breakouts would be great, so I'll
defer commenting much until then.  But, just to verify I'm
understanding: the primary defence is the command_requires_full_index
setting, and you have added several ensure_full_index() calls
throughout the code in places you believe would need to be fixed up in
case someone switches the command_requires_full_index setting.  Is
that correct?  And your comment on the gaps is just that there may be
other places that are missing the secondary protection (as opposed to
my first reading of that paragraph as suggesting we aren't sure if we
have enough protections yet and need to add more before this moves out
of RFC); is that right?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  apply.c                   | 10 +++++++++-
>  blame.c                   |  7 ++++++-
>  builtin/checkout-index.c  |  5 ++++-
>  builtin/grep.c            |  2 ++
>  builtin/ls-files.c        |  9 ++++++++-
>  builtin/merge-index.c     |  2 ++
>  builtin/mv.c              |  2 ++
>  builtin/rm.c              |  2 ++
>  builtin/sparse-checkout.c |  1 +
>  builtin/update-index.c    |  2 ++
>  cache.h                   |  1 +
>  diff-lib.c                |  2 ++
>  diff.c                    |  2 ++
>  dir.c                     | 14 +++++++++++++-
>  entry.c                   |  2 ++
>  fsmonitor.c               | 11 ++++++++++-
>  merge-recursive.c         | 22 +++++++++++++++++++---
>  name-hash.c               |  6 ++++++
>  pathspec.c                |  5 +++--
>  pathspec.h                |  4 ++--
>  read-cache.c              | 19 +++++++++++++++++--
>  rerere.c                  |  2 ++
>  resolve-undo.c            |  6 ++++++
>  sha1-name.c               |  3 +++
>  split-index.c             |  2 ++
>  submodule.c               | 24 +++++++++++++++++++-----
>  submodule.h               |  6 +++---
>  tree.c                    |  2 ++
>  wt-status.c               |  7 +++++++
>  29 files changed, 159 insertions(+), 23 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 668b16e9893..5bfbd928b38 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3523,6 +3523,8 @@ static int load_current(struct apply_state *state,
>         if (!patch->is_new)
>                 BUG("patch to %s is not a creation", patch->old_name);
>
> +       ensure_full_index(state->repo->index);
> +
>         pos = index_name_pos(state->repo->index, name, strlen(name));
>         if (pos < 0)
>                 return error(_("%s: does not exist in index"), name);
> @@ -3692,7 +3694,11 @@ static int check_preimage(struct apply_state *state,
>         }
>
>         if (state->check_index && !previous) {
> -               int pos = index_name_pos(state->repo->index, old_name,
> +               int pos;
> +
> +               ensure_full_index(state->repo->index);
> +
> +               pos = index_name_pos(state->repo->index, old_name,
>                                          strlen(old_name));
>                 if (pos < 0) {
>                         if (patch->is_new < 0)
> @@ -3751,6 +3757,8 @@ static int check_to_create(struct apply_state *state,
>         if (state->check_index && (!ok_if_exists || !state->cached)) {
>                 int pos;
>
> +               ensure_full_index(state->repo->index);
> +
>                 pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
>                 if (pos >= 0) {
>                         struct cache_entry *ce = state->repo->index->cache[pos];
> diff --git a/blame.c b/blame.c
> index a5044fcfaa6..0aa368a35cf 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -108,6 +108,7 @@ static void verify_working_tree_path(struct repository *r,
>                         return;
>         }
>
> +       ensure_full_index(r->index);
>         pos = index_name_pos(r->index, path, strlen(path));
>         if (pos >= 0)
>                 ; /* path is in the index */
> @@ -277,7 +278,11 @@ static struct commit *fake_working_tree_commit(struct repository *r,
>
>         len = strlen(path);
>         if (!mode) {
> -               int pos = index_name_pos(r->index, path, len);
> +               int pos;
> +
> +               ensure_full_index(r->index);
> +
> +               pos = index_name_pos(r->index, path, len);
>                 if (0 <= pos)
>                         mode = r->index->cache[pos]->ce_mode;
>                 else
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 4bbfc92dce5..24c85b1c125 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -48,11 +48,14 @@ static void write_tempfile_record(const char *name, const char *prefix)
>  static int checkout_file(const char *name, const char *prefix)
>  {
>         int namelen = strlen(name);
> -       int pos = cache_name_pos(name, namelen);
> +       int pos;
>         int has_same_name = 0;
>         int did_checkout = 0;
>         int errs = 0;
>
> +       ensure_full_index(the_repository->index);
> +       pos = index_name_pos(the_repository->index, name, namelen);
> +
>         if (pos < 0)
>                 pos = -pos - 1;
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index ca259af4416..e53cf817204 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -506,6 +506,8 @@ static int grep_cache(struct grep_opt *opt,
>         if (repo_read_index(repo) < 0)
>                 die(_("index file corrupt"));
>
> +       ensure_full_index(repo->index);
> +
>         for (nr = 0; nr < repo->index->cache_nr; nr++) {
>                 const struct cache_entry *ce = repo->index->cache[nr];
>                 strbuf_setlen(&name, name_base_len);
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index c8eae899b82..933e259cdbe 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -150,7 +150,7 @@ static void show_other_files(const struct index_state *istate,
>         }
>  }
>
> -static void show_killed_files(const struct index_state *istate,
> +static void show_killed_files(struct index_state *istate,
>                               const struct dir_struct *dir)
>  {
>         int i;
> @@ -159,6 +159,8 @@ static void show_killed_files(const struct index_state *istate,
>                 char *cp, *sp;
>                 int pos, len, killed = 0;
>
> +               ensure_full_index(istate);
> +
>                 for (cp = ent->name; cp - ent->name < ent->len; cp = sp + 1) {
>                         sp = strchr(cp, '/');
>                         if (!sp) {
> @@ -313,6 +315,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>                         show_killed_files(repo->index, dir);
>         }
>         if (show_cached || show_stage) {
> +               ensure_full_index(repo->index);
>                 for (i = 0; i < repo->index->cache_nr; i++) {
>                         const struct cache_entry *ce = repo->index->cache[i];
>
> @@ -332,6 +335,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>                 }
>         }
>         if (show_deleted || show_modified) {
> +               ensure_full_index(repo->index);
>                 for (i = 0; i < repo->index->cache_nr; i++) {
>                         const struct cache_entry *ce = repo->index->cache[i];
>                         struct stat st;
> @@ -368,6 +372,7 @@ static void prune_index(struct index_state *istate,
>
>         if (!prefix || !istate->cache_nr)
>                 return;
> +       ensure_full_index(istate);
>         pos = index_name_pos(istate, prefix, prefixlen);
>         if (pos < 0)
>                 pos = -pos-1;
> @@ -428,6 +433,8 @@ void overlay_tree_on_index(struct index_state *istate,
>         if (!tree)
>                 die("bad tree-ish %s", tree_name);
>
> +       ensure_full_index(istate);
> +
>         /* Hoist the unmerged entries up to stage #3 to make room */
>         for (i = 0; i < istate->cache_nr; i++) {
>                 struct cache_entry *ce = istate->cache[i];
> diff --git a/builtin/merge-index.c b/builtin/merge-index.c
> index 38ea6ad6ca2..3e1ddabd650 100644
> --- a/builtin/merge-index.c
> +++ b/builtin/merge-index.c
> @@ -80,6 +80,8 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
>
>         read_cache();
>
> +       ensure_full_index(&the_index);
> +
>         i = 1;
>         if (!strcmp(argv[i], "-o")) {
>                 one_shot = 1;
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 7dac714af90..2ab6416fce9 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -145,6 +145,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>         if (read_cache() < 0)
>                 die(_("index file corrupt"));
>
> +       ensure_full_index(&the_index);
> +
>         source = internal_prefix_pathspec(prefix, argv, argc, 0);
>         modes = xcalloc(argc, sizeof(enum update_mode));
>         /*
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 4858631e0f0..2db4fcd22d9 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -291,6 +291,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>
>         refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &pathspec, NULL, NULL);
>
> +       ensure_full_index(&the_index);
> +
>         seen = xcalloc(pathspec.nr, 1);
>
>         for (i = 0; i < active_nr; i++) {
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index ca63e2c64e9..14022b5e182 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -123,6 +123,7 @@ static int update_working_directory(struct pattern_list *pl)
>         o.pl = pl;
>
>         setup_work_tree();
> +       ensure_full_index(r->index);
>
>         repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 79087bccea4..521a6c23c75 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1088,6 +1088,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>
>         the_index.updated_skipworktree = 1;
>
> +       ensure_full_index(&the_index);
> +
>         /*
>          * Custom copy of parse_options() because we want to handle
>          * filename arguments as they come.
> diff --git a/cache.h b/cache.h
> index dcf089b7006..306eab444b9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -346,6 +346,7 @@ void add_name_hash(struct index_state *istate, struct cache_entry *ce);
>  void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
>  void free_name_hash(struct index_state *istate);
>
> +void ensure_full_index(struct index_state *istate);
>
>  /* Cache entry creation and cleanup */
>
> diff --git a/diff-lib.c b/diff-lib.c
> index b73cc1859a4..3743e4463b4 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -96,6 +96,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>         uint64_t start = getnanotime();
>         struct index_state *istate = revs->diffopt.repo->index;
>
> +       ensure_full_index(istate);
> +
>         diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
>
>         refresh_fsmonitor(istate);
> diff --git a/diff.c b/diff.c
> index 2253ec88029..02fafee8587 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3901,6 +3901,8 @@ static int reuse_worktree_file(struct index_state *istate,
>         if (!want_file && would_convert_to_git(istate, name))
>                 return 0;
>
> +       ensure_full_index(istate);
> +
>         len = strlen(name);
>         pos = index_name_pos(istate, name, len);
>         if (pos < 0)
> diff --git a/dir.c b/dir.c
> index d153a63bbd1..ad6eb033cb1 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -892,13 +892,15 @@ void add_pattern(const char *string, const char *base,
>         add_pattern_to_hashsets(pl, pattern);
>  }
>
> -static int read_skip_worktree_file_from_index(const struct index_state *istate,
> +static int read_skip_worktree_file_from_index(struct index_state *istate,
>                                               const char *path,
>                                               size_t *size_out, char **data_out,
>                                               struct oid_stat *oid_stat)
>  {
>         int pos, len;
>
> +       ensure_full_index(istate);
> +
>         len = strlen(path);
>         pos = index_name_pos(istate, path, len);
>         if (pos < 0)
> @@ -1088,6 +1090,10 @@ static int add_patterns(const char *fname, const char *base, int baselen,
>                 close(fd);
>                 if (oid_stat) {
>                         int pos;
> +
> +                       if (istate)
> +                               ensure_full_index(istate);
> +
>                         if (oid_stat->valid &&
>                             !match_stat_data_racy(istate, &oid_stat->stat, &st))
>                                 ; /* no content change, oid_stat->oid still good */
> @@ -1696,6 +1702,8 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
>         if (ignore_case)
>                 return directory_exists_in_index_icase(istate, dirname, len);
>
> +       ensure_full_index(istate);
> +
>         pos = index_name_pos(istate, dirname, len);
>         if (pos < 0)
>                 pos = -pos-1;
> @@ -2050,6 +2058,8 @@ static int get_index_dtype(struct index_state *istate,
>         int pos;
>         const struct cache_entry *ce;
>
> +       ensure_full_index(istate);
> +
>         ce = index_file_exists(istate, path, len, 0);
>         if (ce) {
>                 if (!ce_uptodate(ce))
> @@ -3536,6 +3546,8 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
>         if (repo_read_index(&subrepo) < 0)
>                 die(_("index file corrupt in repo %s"), subrepo.gitdir);
>
> +       ensure_full_index(subrepo.index);
> +
>         for (i = 0; i < subrepo.index->cache_nr; i++) {
>                 const struct cache_entry *ce = subrepo.index->cache[i];
>
> diff --git a/entry.c b/entry.c
> index a0532f1f000..d505e6f2c6e 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -412,6 +412,8 @@ static void mark_colliding_entries(const struct checkout *state,
>
>         ce->ce_flags |= CE_MATCHED;
>
> +       ensure_full_index(state->istate);
> +
>         for (i = 0; i < state->istate->cache_nr; i++) {
>                 struct cache_entry *dup = state->istate->cache[i];
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index fe9e9d7baf4..7b8cd3975b9 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -97,6 +97,9 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
>  void fill_fsmonitor_bitmap(struct index_state *istate)
>  {
>         unsigned int i, skipped = 0;
> +
> +       ensure_full_index(istate);
> +
>         istate->fsmonitor_dirty = ewah_new();
>         for (i = 0; i < istate->cache_nr; i++) {
>                 if (istate->cache[i]->ce_flags & CE_REMOVE)
> @@ -158,7 +161,11 @@ static int query_fsmonitor(int version, const char *last_update, struct strbuf *
>
>  static void fsmonitor_refresh_callback(struct index_state *istate, const char *name)
>  {
> -       int pos = index_name_pos(istate, name, strlen(name));
> +       int pos;
> +
> +       ensure_full_index(istate);
> +
> +       pos = index_name_pos(istate, name, strlen(name));
>
>         if (pos >= 0) {
>                 struct cache_entry *ce = istate->cache[pos];
> @@ -330,6 +337,8 @@ void tweak_fsmonitor(struct index_state *istate)
>
>         if (istate->fsmonitor_dirty) {
>                 if (fsmonitor_enabled) {
> +                       ensure_full_index(istate);
> +
>                         /* Mark all entries valid */
>                         for (i = 0; i < istate->cache_nr; i++) {
>                                 istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
> diff --git a/merge-recursive.c b/merge-recursive.c
> index f736a0f6323..12109f37723 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -522,6 +522,8 @@ static struct string_list *get_unmerged(struct index_state *istate)
>
>         unmerged->strdup_strings = 1;
>
> +       ensure_full_index(istate);
> +
>         for (i = 0; i < istate->cache_nr; i++) {
>                 struct string_list_item *item;
>                 struct stage_data *e;
> @@ -762,6 +764,8 @@ static int dir_in_way(struct index_state *istate, const char *path,
>         strbuf_addstr(&dirpath, path);
>         strbuf_addch(&dirpath, '/');
>
> +       ensure_full_index(istate);
> +
>         pos = index_name_pos(istate, dirpath.buf, dirpath.len);
>
>         if (pos < 0)
> @@ -785,9 +789,13 @@ static int dir_in_way(struct index_state *istate, const char *path,
>  static int was_tracked_and_matches(struct merge_options *opt, const char *path,
>                                    const struct diff_filespec *blob)
>  {
> -       int pos = index_name_pos(&opt->priv->orig_index, path, strlen(path));
> +       int pos;
>         struct cache_entry *ce;
>
> +       ensure_full_index(&opt->priv->orig_index);
> +
> +       pos = index_name_pos(&opt->priv->orig_index, path, strlen(path));
> +
>         if (0 > pos)
>                 /* we were not tracking this path before the merge */
>                 return 0;
> @@ -802,7 +810,11 @@ static int was_tracked_and_matches(struct merge_options *opt, const char *path,
>   */
>  static int was_tracked(struct merge_options *opt, const char *path)
>  {
> -       int pos = index_name_pos(&opt->priv->orig_index, path, strlen(path));
> +       int pos;
> +
> +       ensure_full_index(&opt->priv->orig_index);
> +
> +       pos = index_name_pos(&opt->priv->orig_index, path, strlen(path));
>
>         if (0 <= pos)
>                 /* we were tracking this path before the merge */
> @@ -814,6 +826,9 @@ static int was_tracked(struct merge_options *opt, const char *path)
>  static int would_lose_untracked(struct merge_options *opt, const char *path)
>  {
>         struct index_state *istate = opt->repo->index;
> +       int pos;
> +
> +       ensure_full_index(istate);
>
>         /*
>          * This may look like it can be simplified to:
> @@ -832,7 +847,7 @@ static int would_lose_untracked(struct merge_options *opt, const char *path)
>          * update_file()/would_lose_untracked(); see every comment in this
>          * file which mentions "update_stages".
>          */
> -       int pos = index_name_pos(istate, path, strlen(path));
> +       pos = index_name_pos(istate, path, strlen(path));
>
>         if (pos < 0)
>                 pos = -1 - pos;
> @@ -3086,6 +3101,7 @@ static int handle_content_merge(struct merge_file_info *mfi,
>                  * flag to avoid making the file appear as if it were
>                  * deleted by the user.
>                  */
> +               ensure_full_index(&opt->priv->orig_index);
>                 pos = index_name_pos(&opt->priv->orig_index, path, strlen(path));
>                 ce = opt->priv->orig_index.cache[pos];
>                 if (ce_skip_worktree(ce)) {
> diff --git a/name-hash.c b/name-hash.c
> index 4e03fac9bb1..0f6d4fcca5a 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -679,6 +679,8 @@ int index_dir_exists(struct index_state *istate, const char *name, int namelen)
>  {
>         struct dir_entry *dir;
>
> +       ensure_full_index(istate);
> +
>         lazy_init_name_hash(istate);
>         dir = find_dir_entry(istate, name, namelen);
>         return dir && dir->nr;
> @@ -689,6 +691,8 @@ void adjust_dirname_case(struct index_state *istate, char *name)
>         const char *startPtr = name;
>         const char *ptr = startPtr;
>
> +       ensure_full_index( istate);
> +
>         lazy_init_name_hash(istate);
>         while (*ptr) {
>                 while (*ptr && *ptr != '/')
> @@ -712,6 +716,8 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
>         struct cache_entry *ce;
>         unsigned int hash = memihash(name, namelen);
>
> +       ensure_full_index(istate);
> +
>         lazy_init_name_hash(istate);
>
>         ce = hashmap_get_entry_from_hash(&istate->name_hash, hash, NULL,
> diff --git a/pathspec.c b/pathspec.c
> index 7a229d8d22f..9b105855483 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -20,7 +20,7 @@
>   * to use find_pathspecs_matching_against_index() instead.
>   */
>  void add_pathspec_matches_against_index(const struct pathspec *pathspec,
> -                                       const struct index_state *istate,
> +                                       struct index_state *istate,
>                                         char *seen)
>  {
>         int num_unmatched = 0, i;
> @@ -36,6 +36,7 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>                         num_unmatched++;
>         if (!num_unmatched)
>                 return;
> +       ensure_full_index(istate);
>         for (i = 0; i < istate->cache_nr; i++) {
>                 const struct cache_entry *ce = istate->cache[i];
>                 ce_path_match(istate, ce, pathspec, seen);
> @@ -51,7 +52,7 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>   * given pathspecs achieves against all items in the index.
>   */
>  char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
> -                                           const struct index_state *istate)
> +                                           struct index_state *istate)
>  {
>         char *seen = xcalloc(pathspec->nr, 1);
>         add_pathspec_matches_against_index(pathspec, istate, seen);
> diff --git a/pathspec.h b/pathspec.h
> index 454ce364fac..f19c5dcf022 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -150,10 +150,10 @@ static inline int ps_strcmp(const struct pathspec_item *item,
>  }
>
>  void add_pathspec_matches_against_index(const struct pathspec *pathspec,
> -                                       const struct index_state *istate,
> +                                       struct index_state *istate,
>                                         char *seen);
>  char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
> -                                           const struct index_state *istate);
> +                                           struct index_state *istate);
>  int match_pathspec_attrs(const struct index_state *istate,
>                          const char *name, int namelen,
>                          const struct pathspec_item *item);
> diff --git a/read-cache.c b/read-cache.c
> index 0522260416e..65679d70d7c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -622,7 +622,11 @@ void remove_marked_cache_entries(struct index_state *istate, int invalidate)
>
>  int remove_file_from_index(struct index_state *istate, const char *path)
>  {
> -       int pos = index_name_pos(istate, path, strlen(path));
> +       int pos;
> +
> +       ensure_full_index(istate);
> +
> +       pos = index_name_pos(istate, path, strlen(path));
>         if (pos < 0)
>                 pos = -pos-1;
>         cache_tree_invalidate_path(istate, path);
> @@ -640,9 +644,12 @@ static int compare_name(struct cache_entry *ce, const char *path, int namelen)
>  static int index_name_pos_also_unmerged(struct index_state *istate,
>         const char *path, int namelen)
>  {
> -       int pos = index_name_pos(istate, path, namelen);
> +       int pos;
>         struct cache_entry *ce;
>
> +       ensure_full_index(istate);
> +
> +       pos = index_name_pos(istate, path, namelen);
>         if (pos >= 0)
>                 return pos;
>
> @@ -717,6 +724,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>         int hash_flags = HASH_WRITE_OBJECT;
>         struct object_id oid;
>
> +       ensure_full_index(istate);
> +
>         if (flags & ADD_CACHE_RENORMALIZE)
>                 hash_flags |= HASH_RENORMALIZE;
>
> @@ -1095,6 +1104,8 @@ static int has_dir_name(struct index_state *istate,
>         size_t len_eq_last;
>         int cmp_last = 0;
>
> +       ensure_full_index(istate);
> +
>         /*
>          * We are frequently called during an iteration on a sorted
>          * list of pathnames and while building a new index.  Therefore,
> @@ -1338,6 +1349,8 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
>  {
>         int pos;
>
> +       ensure_full_index(istate);
> +
>         if (option & ADD_CACHE_JUST_APPEND)
>                 pos = istate->cache_nr;
>         else {
> @@ -1547,6 +1560,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>          * we only have to do the special cases that are left.
>          */
>         preload_index(istate, pathspec, 0);
> +
> +       ensure_full_index(istate);
>         for (i = 0; i < istate->cache_nr; i++) {
>                 struct cache_entry *ce, *new_entry;
>                 int cache_errno = 0;
> diff --git a/rerere.c b/rerere.c
> index 9281131a9f1..1836a6cfbcf 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -962,6 +962,8 @@ static int handle_cache(struct index_state *istate,
>         struct rerere_io_mem io;
>         int marker_size = ll_merge_marker_size(istate, path);
>
> +       ensure_full_index(istate);
> +
>         /*
>          * Reproduce the conflicted merge in-core
>          */
> diff --git a/resolve-undo.c b/resolve-undo.c
> index 236320f179c..a4265834977 100644
> --- a/resolve-undo.c
> +++ b/resolve-undo.c
> @@ -125,6 +125,8 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
>         if (!istate->resolve_undo)
>                 return pos;
>
> +       ensure_full_index(istate);
> +
>         ce = istate->cache[pos];
>         if (ce_stage(ce)) {
>                 /* already unmerged */
> @@ -172,6 +174,8 @@ void unmerge_marked_index(struct index_state *istate)
>         if (!istate->resolve_undo)
>                 return;
>
> +       ensure_full_index(istate);
> +
>         for (i = 0; i < istate->cache_nr; i++) {
>                 const struct cache_entry *ce = istate->cache[i];
>                 if (ce->ce_flags & CE_MATCHED)
> @@ -186,6 +190,8 @@ void unmerge_index(struct index_state *istate, const struct pathspec *pathspec)
>         if (!istate->resolve_undo)
>                 return;
>
> +       ensure_full_index(istate);
> +
>         for (i = 0; i < istate->cache_nr; i++) {
>                 const struct cache_entry *ce = istate->cache[i];
>                 if (!ce_path_match(istate, ce, pathspec, NULL))
> diff --git a/sha1-name.c b/sha1-name.c
> index 0b23b86ceb4..c2f17e526ab 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1734,6 +1734,8 @@ static void diagnose_invalid_index_path(struct repository *r,
>         if (!prefix)
>                 prefix = "";
>
> +       ensure_full_index(r->index);
> +
>         /* Wrong stage number? */
>         pos = index_name_pos(istate, filename, namelen);
>         if (pos < 0)
> @@ -1854,6 +1856,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
>
>                 if (!repo->index || !repo->index->cache)
>                         repo_read_index(repo);
> +               ensure_full_index(repo->index);
>                 pos = index_name_pos(repo->index, cp, namelen);
>                 if (pos < 0)
>                         pos = -pos - 1;
> diff --git a/split-index.c b/split-index.c
> index c0e8ad670d0..3150fa6476a 100644
> --- a/split-index.c
> +++ b/split-index.c
> @@ -4,6 +4,8 @@
>
>  struct split_index *init_split_index(struct index_state *istate)
>  {
> +       ensure_full_index(istate);
> +
>         if (!istate->split_index) {
>                 istate->split_index = xcalloc(1, sizeof(*istate->split_index));
>                 istate->split_index->refcount = 1;
> diff --git a/submodule.c b/submodule.c
> index b3bb59f0664..f80cfddbd52 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -33,9 +33,13 @@ static struct oid_array ref_tips_after_fetch;
>   * will be disabled because we can't guess what might be configured in
>   * .gitmodules unless the user resolves the conflict.
>   */
> -int is_gitmodules_unmerged(const struct index_state *istate)
> +int is_gitmodules_unmerged(struct index_state *istate)
>  {
> -       int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
> +       int pos;
> +
> +       ensure_full_index(istate);
> +
> +       pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
>         if (pos < 0) { /* .gitmodules not found or isn't merged */
>                 pos = -1 - pos;
>                 if (istate->cache_nr > pos) {  /* there is a .gitmodules */
> @@ -77,7 +81,11 @@ int is_writing_gitmodules_ok(void)
>   */
>  int is_staging_gitmodules_ok(struct index_state *istate)
>  {
> -       int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
> +       int pos;
> +
> +       ensure_full_index(istate);
> +
> +       pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
>
>         if ((pos >= 0) && (pos < istate->cache_nr)) {
>                 struct stat st;
> @@ -301,7 +309,7 @@ int is_submodule_populated_gently(const char *path, int *return_error_code)
>  /*
>   * Dies if the provided 'prefix' corresponds to an unpopulated submodule
>   */
> -void die_in_unpopulated_submodule(const struct index_state *istate,
> +void die_in_unpopulated_submodule(struct index_state *istate,
>                                   const char *prefix)
>  {
>         int i, prefixlen;
> @@ -311,6 +319,8 @@ void die_in_unpopulated_submodule(const struct index_state *istate,
>
>         prefixlen = strlen(prefix);
>
> +       ensure_full_index(istate);
> +
>         for (i = 0; i < istate->cache_nr; i++) {
>                 struct cache_entry *ce = istate->cache[i];
>                 int ce_len = ce_namelen(ce);
> @@ -331,11 +341,13 @@ void die_in_unpopulated_submodule(const struct index_state *istate,
>  /*
>   * Dies if any paths in the provided pathspec descends into a submodule
>   */
> -void die_path_inside_submodule(const struct index_state *istate,
> +void die_path_inside_submodule(struct index_state *istate,
>                                const struct pathspec *ps)
>  {
>         int i, j;
>
> +       ensure_full_index(istate);
> +
>         for (i = 0; i < istate->cache_nr; i++) {
>                 struct cache_entry *ce = istate->cache[i];
>                 int ce_len = ce_namelen(ce);
> @@ -1420,6 +1432,8 @@ static int get_next_submodule(struct child_process *cp,
>  {
>         struct submodule_parallel_fetch *spf = data;
>
> +       ensure_full_index(spf->r->index);
> +
>         for (; spf->count < spf->r->index->cache_nr; spf->count++) {
>                 const struct cache_entry *ce = spf->r->index->cache[spf->count];
>                 const char *default_argv;
> diff --git a/submodule.h b/submodule.h
> index 4ac6e31cf1f..84640c49c11 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -39,7 +39,7 @@ struct submodule_update_strategy {
>  };
>  #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
>
> -int is_gitmodules_unmerged(const struct index_state *istate);
> +int is_gitmodules_unmerged(struct index_state *istate);
>  int is_writing_gitmodules_ok(void);
>  int is_staging_gitmodules_ok(struct index_state *istate);
>  int update_path_in_gitmodules(const char *oldpath, const char *newpath);
> @@ -60,9 +60,9 @@ int is_submodule_active(struct repository *repo, const char *path);
>   * Otherwise the return error code is the same as of resolve_gitdir_gently.
>   */
>  int is_submodule_populated_gently(const char *path, int *return_error_code);
> -void die_in_unpopulated_submodule(const struct index_state *istate,
> +void die_in_unpopulated_submodule(struct index_state *istate,
>                                   const char *prefix);
> -void die_path_inside_submodule(const struct index_state *istate,
> +void die_path_inside_submodule(struct index_state *istate,
>                                const struct pathspec *ps);
>  enum submodule_update_type parse_submodule_update_type(const char *value);
>  int parse_submodule_update_strategy(const char *value,
> diff --git a/tree.c b/tree.c
> index e76517f6b18..60f575440c8 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -170,6 +170,8 @@ int read_tree(struct repository *r, struct tree *tree, int stage,
>          * to matter.
>          */
>
> +       ensure_full_index(istate);
> +
>         /*
>          * See if we have cache entry at the stage.  If so,
>          * do it the original slow way, otherwise, append and then
> diff --git a/wt-status.c b/wt-status.c
> index 7074bbdd53c..5366d336938 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -509,6 +509,8 @@ static int unmerged_mask(struct index_state *istate, const char *path)
>         int pos, mask;
>         const struct cache_entry *ce;
>
> +       ensure_full_index(istate);
> +
>         pos = index_name_pos(istate, path, strlen(path));
>         if (0 <= pos)
>                 return 0;
> @@ -657,6 +659,8 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
>         struct index_state *istate = s->repo->index;
>         int i;
>
> +       ensure_full_index(istate);
> +
>         for (i = 0; i < istate->cache_nr; i++) {
>                 struct string_list_item *it;
>                 struct wt_status_change_data *d;
> @@ -2295,6 +2299,9 @@ static void wt_porcelain_v2_print_unmerged_entry(
>          */
>         memset(stages, 0, sizeof(stages));
>         sum = 0;
> +
> +       ensure_full_index(istate);
> +
>         pos = index_name_pos(istate, it->string, strlen(it->string));
>         assert(pos < 0);
>         pos = -pos-1;
> --
> gitgitgadget
>
