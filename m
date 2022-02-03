Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C6C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 14:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351081AbiBCO1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiBCO05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 09:26:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F783C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 06:26:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k18so5353411wrg.11
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 06:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xM88lzAMxlZn0Dh9wt2SQEqjWpgaGm+FYVWXDP/biMQ=;
        b=NpVPGRcq6ji0ALiXfRR0lCKe3qpiT7HkySJnjUfstDx5VaZCPdCthHOzt95HgsK6fG
         2iQ4wB9KV7ioeP6FnF3fKplJtQMPSZYWSpx73l0OkWaPESGUCqjhkoUhEzmfgMekzg5Y
         tATE3UoUoUnuHvzZuGXvBnaj0xC78JLm/tMbEoP8tPicc8FG49QsLH2VInlAY21my8pm
         5Lb8WE+00uRy1q5JNWXI6Ge6gHeNhuID459Vl1Iy55eVfgxHxEeuLQCqpBK2Bmr9WzYs
         +KqwOD9e7pGEdSBeKpqBi7cEW7dyMwhTcp/CGVemXHgXOlWyI6Hp4n1ydVJNVN4Qb4qf
         hNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xM88lzAMxlZn0Dh9wt2SQEqjWpgaGm+FYVWXDP/biMQ=;
        b=Q9kZdKexnPkxatEJ1Km9VuyTmgm/1lVQb4eSnQnSsERNBBcL99SPUptHzjh0fIZFdb
         j1z78unCNoVJB9vULvD/M9gby3SC4AoivnP31blTqfx86id84J0Q4vV4JTohHGz1fuEA
         7jkKg2ETf8eh11n9DQZIXcZhd6WJlIE999FNhZ24snE4AxAFxTg5uKPm6dJNCZIAWrcT
         00DxmV3sO8E1RLi+IsZFbjr9D5zpL+kf3xFm26RW9BKBdlPZjwihE7UQG0EDbXgvvC1r
         0ZkzqZDw67qQQjLke6B7jAmfIHtnUUmbK/Ezpi8FqbVbKG31qHAXlFCkEqkqmfgNLwWt
         NjCw==
X-Gm-Message-State: AOAM533ZiG1g9hdc6jOQOUxYTklCHnCHJYJC9oAEz6dp6FffPW3JaHDp
        inaLPkMNFs+ACEpC8mKbNfwReGWEDg8=
X-Google-Smtp-Source: ABdhPJxBSuqI6nHj75gFk0edoVNeaT75LWNR/KPZp+Gb+IlQ5TWHnp4uVlwxgRMAAtY+4o5XjSxQbg==
X-Received: by 2002:a5d:430f:: with SMTP id h15mr8527210wrq.15.1643898414677;
        Thu, 03 Feb 2022 06:26:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm1034987wre.89.2022.02.03.06.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 06:26:54 -0800 (PST)
Message-Id: <pull.1210.v3.git.git.1643898412.gitgitgadget@gmail.com>
In-Reply-To: <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
References: <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 14:26:50 +0000
Subject: [PATCH v3 0/2] refs.h: make all flags arguments unsigned
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:

 * split off rename commit
 * base on seen (@fde6c449a)

Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Han-Wen Nienhuys (2):
  refs.h: make all flags arguments unsigned
  Uniformize flag argument naming to `flags` or `unused_flags`

 bisect.c                    |  4 +-
 builtin/bisect--helper.c    | 11 +++---
 builtin/branch.c            |  4 +-
 builtin/checkout.c          | 24 ++++++------
 builtin/describe.c          |  3 +-
 builtin/fetch.c             | 10 ++---
 builtin/fsck.c              |  4 +-
 builtin/gc.c                |  5 +--
 builtin/name-rev.c          |  3 +-
 builtin/pack-objects.c      | 11 +++---
 builtin/rebase.c            | 10 +++--
 builtin/receive-pack.c      | 13 ++++---
 builtin/reflog.c            |  5 ++-
 builtin/remote.c            | 23 +++++++-----
 builtin/repack.c            |  2 +-
 builtin/replace.c           |  2 +-
 builtin/rev-parse.c         |  6 ++-
 builtin/show-branch.c       | 12 +++---
 builtin/show-ref.c          |  4 +-
 builtin/stash.c             |  2 +-
 builtin/submodule--helper.c |  4 +-
 builtin/symbolic-ref.c      |  6 +--
 bundle.c                    |  8 ++--
 commit-graph.c              |  5 +--
 config.c                    |  2 +-
 delta-islands.c             |  2 +-
 fetch-pack.c                |  7 ++--
 help.c                      |  2 +-
 http-backend.c              |  6 +--
 log-tree.c                  |  4 +-
 ls-refs.c                   | 18 ++++-----
 midx.c                      |  7 ++--
 negotiator/default.c        |  2 +-
 negotiator/skipping.c       |  2 +-
 notes.c                     |  5 ++-
 object-name.c               |  2 +-
 reachable.c                 |  4 +-
 ref-filter.c                |  9 +++--
 refs.c                      | 75 ++++++++++++++++++-------------------
 refs.h                      | 46 +++++++++++------------
 refs/files-backend.c        | 56 ++++++++++++++-------------
 remote.c                    | 30 +++++++--------
 replace-object.c            |  5 +--
 revision.c                  |  6 +--
 server-info.c               |  2 +-
 shallow.c                   |  4 +-
 submodule.c                 |  4 +-
 t/helper/test-ref-store.c   |  4 +-
 transport-helper.c          | 12 +++---
 transport.c                 | 10 ++---
 upload-pack.c               | 14 +++----
 walker.c                    |  2 +-
 worktree.c                  | 13 +++----
 53 files changed, 272 insertions(+), 264 deletions(-)


base-commit: fde6c449af7cc83f7d357653f1b8ee055f6cad3b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1210%2Fhanwen%2Funsigned-flags-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1210/hanwen/unsigned-flags-v3
Pull-Request: https://github.com/git/git/pull/1210

Range-diff vs v2:

 1:  216006057b7 ! 1:  54dfe8d6a86 refs.h: make all flags arguments unsigned
     @@ Commit message
          want to treat the sign bit specially, so make all flags in refs.h
          unsigned.
      
     -    For uniformity, rename all variables to `flags` or `unused_flags`,
     -    from `flag`. In a couple of shadowing cases, use `ref_flags` for
     -    clarity.
     -
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## bisect.c ##
     @@ bisect.c: void find_bisection(struct commit_list **commit_list, int *reaches,
       
       static int register_ref(const char *refname, const struct object_id *oid,
      -			int flags, void *cb_data)
     -+			unsigned int unused_flags, void *cb_data)
     ++			unsigned int flags, void *cb_data)
       {
       	struct strbuf good_prefix = STRBUF_INIT;
       	strbuf_addstr(&good_prefix, term_good);
     @@ bisect.c: int estimate_bisect_steps(int all)
       
       static int mark_for_removal(const char *refname, const struct object_id *oid,
      -			    int flag, void *cb_data)
     -+			    unsigned int unused_flags, void *cb_data)
     ++			    unsigned int flag, void *cb_data)
       {
       	struct string_list *refs = cb_data;
       	char *ref = xstrfmt("refs/bisect%s", refname);
     @@ builtin/bisect--helper.c: static int check_and_set_terms(struct bisect_terms *te
       
       static int mark_good(const char *refname, const struct object_id *oid,
      -		     int flag, void *cb_data)
     -+		     unsigned int unused_flags, void *cb_data)
     ++		     unsigned int flag, void *cb_data)
       {
       	int *m_good = (int *)cb_data;
       	*m_good = 0;
     @@ builtin/bisect--helper.c: finish:
       
       static int add_bisect_ref(const char *refname, const struct object_id *oid,
      -			  int flags, void *cb)
     -+			  unsigned int unused_flags, void *cb)
     ++			  unsigned int flags, void *cb)
       {
       	struct add_bisect_ref_data *data = cb;
       
     @@ builtin/bisect--helper.c: static enum bisect_error bisect_start(struct bisect_te
       	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
      -	int flags, pathspec_pos;
      +	int pathspec_pos;
     -+	unsigned int unused_flags;
     ++	unsigned int flags;
       	enum bisect_error res = BISECT_OK;
       	struct string_list revs = STRING_LIST_INIT_DUP;
       	struct string_list states = STRING_LIST_INIT_DUP;
     -@@ builtin/bisect--helper.c: static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
     - 	/*
     - 	 * Verify HEAD
     - 	 */
     --	head = resolve_ref_unsafe("HEAD", 0, &head_oid, &flags);
     -+	head = resolve_ref_unsafe("HEAD", 0, &head_oid, &unused_flags);
     - 	if (!head)
     - 		if (get_oid("HEAD", &head_oid))
     - 			return error(_("bad HEAD - I need a HEAD"));
      
       ## builtin/branch.c ##
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     @@ builtin/checkout.c: static void update_refs_for_switch(const struct checkout_opt
       static int add_pending_uninteresting_ref(const char *refname,
       					 const struct object_id *oid,
      -					 int flags, void *cb_data)
     -+					 unsigned int unused_flags,
     -+					 void *cb_data)
     ++					 unsigned int flags, void *cb_data)
       {
       	add_pending_oid(cb_data, refname, oid, UNINTERESTING);
       	return 0;
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	struct object_id rev;
      -	int flag, writeout_error = 0;
      +	int writeout_error = 0;
     -+	unsigned int flags;
     ++	unsigned int flag;
       	int do_merge = 1;
       
       	trace2_cmd_mode("branch");
     - 
     - 	memset(&old_branch_info, 0, sizeof(old_branch_info));
     --	old_branch_info.path = resolve_refdup("HEAD", 0, &rev, &flag);
     -+	old_branch_info.path = resolve_refdup("HEAD", 0, &rev, &flags);
     - 	if (old_branch_info.path)
     - 		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
     --	if (!(flag & REF_ISSYMREF))
     -+	if (!(flags & REF_ISSYMREF))
     - 		FREE_AND_NULL(old_branch_info.path);
     - 
     - 	if (old_branch_info.path) {
      @@ builtin/checkout.c: static int checkout_branch(struct checkout_opts *opts,
       
       	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
       	    !opts->ignore_other_worktrees) {
      -		int flag;
     --		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
     --		if (head_ref &&
     --		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
     -+		unsigned int flags;
     -+		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flags);
     -+		if (head_ref && (!(flags & REF_ISSYMREF) ||
     -+				 strcmp(head_ref, new_branch_info->path)))
     - 			die_if_checked_out(new_branch_info->path, 1);
     - 		free(head_ref);
     - 	}
     ++		unsigned int flag;
     + 		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
     + 		if (head_ref &&
     + 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
     +@@ builtin/checkout.c: static int checkout_branch(struct checkout_opts *opts,
       
       	if (!new_branch_info->commit && opts->new_branch) {
       		struct object_id rev;
      -		int flag;
     -+		unsigned int flags;
     ++		unsigned int flag;
       
     --		if (!read_ref_full("HEAD", 0, &rev, &flag) &&
     --		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
     -+		if (!read_ref_full("HEAD", 0, &rev, &flags) &&
     -+		    (flags & REF_ISSYMREF) && is_null_oid(&rev))
     - 			return switch_unborn_to_new_branch(opts);
     - 	}
     - 	return switch_branches(opts, new_branch_info);
     + 		if (!read_ref_full("HEAD", 0, &rev, &flag) &&
     + 		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
      
       ## builtin/describe.c ##
      @@ builtin/describe.c: static void add_to_known_names(const char *path,
     @@ builtin/describe.c: static void add_to_known_names(const char *path,
       
      -static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
      +static int get_name(const char *path, const struct object_id *oid,
     -+		    unsigned int unused_flags, void *cb_data)
     ++		    unsigned int flag, void *cb_data)
       {
       	int is_tag = 0;
       	struct object_id peeled;
     @@ builtin/fetch.c: static struct refname_hash_entry *refname_hash_add(struct hashm
      -			   const struct object_id *oid,
      -			   int flag, void *cbdata)
      +static int add_one_refname(const char *refname, const struct object_id *oid,
     -+			   unsigned int unused_flags, void *cbdata)
     ++			   unsigned int flag, void *cbdata)
       {
       	struct hashmap *refname_map = cbdata;
       
     @@ builtin/fetch.c: static void set_option(struct transport *transport, const char
      -static int add_oid(const char *refname, const struct object_id *oid, int flags,
      -		   void *cb_data)
      +static int add_oid(const char *refname, const struct object_id *oid,
     -+		   unsigned int unused_flags, void *cb_data)
     ++		   unsigned int flags, void *cb_data)
       {
       	struct oid_array *oids = cb_data;
       
     @@ builtin/fsck.c: static int fsck_handle_reflog_ent(struct object_id *ooid, struct
       
       static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
      -			      int flag, void *cb_data)
     -+			      unsigned int unused_flags, void *cb_data)
     ++			      unsigned int flag, void *cb_data)
       {
       	struct strbuf refname = STRBUF_INIT;
       
     @@ builtin/fsck.c: static int fsck_handle_reflog(const char *logname, const struct
       
       static int fsck_handle_ref(const char *refname, const struct object_id *oid,
      -			   int flag, void *cb_data)
     -+			   unsigned int unused_flags, void *cb_data)
     ++			   unsigned int flag, void *cb_data)
       {
       	struct object *obj;
       
     @@ builtin/gc.c: struct cg_auto_data {
      -		      const struct object_id *oid, int flags,
      -		      void *cb_data)
      +static int dfs_on_ref(const char *refname, const struct object_id *oid,
     -+		      unsigned int unused_flags, void *cb_data)
     ++		      unsigned int flags, void *cb_data)
       {
       	struct cg_auto_data *data = (struct cg_auto_data *)cb_data;
       	int result = 0;
     @@ builtin/name-rev.c: static int cmp_by_tag_and_age(const void *a_, const void *b_
       
      -static int name_ref(const char *path, const struct object_id *oid, int flags, void *cb_data)
      +static int name_ref(const char *path, const struct object_id *oid,
     -+		    unsigned int unused_flags, void *cb_data)
     ++		    unsigned int flags, void *cb_data)
       {
       	struct object *o = parse_object(the_repository, oid);
       	struct name_ref_data *data = cb_data;
     @@ builtin/pack-objects.c: static enum write_one_status write_one(struct hashfile *
      -static int mark_tagged(const char *path, const struct object_id *oid, int flag,
      -		       void *cb_data)
      +static int mark_tagged(const char *path, const struct object_id *oid,
     -+		       unsigned int unused_flags, void *cb_data)
     ++		       unsigned int flag, void *cb_data)
       {
       	struct object_id peeled;
       	struct object_entry *entry = packlist_find(&to_pack, oid);
     @@ builtin/pack-objects.c: static void add_tag_chain(const struct object_id *oid)
       
      -static int add_ref_tag(const char *tag, const struct object_id *oid, int flag, void *cb_data)
      +static int add_ref_tag(const char *tag, const struct object_id *oid,
     -+		       unsigned int unused_flags, void *cb_data)
     ++		       unsigned int flag, void *cb_data)
       {
       	struct object_id peeled;
       
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       	const char *branch_name;
      -	int ret, flags, total_argc, in_progress = 0;
      +	int ret, total_argc, in_progress = 0;
     ++	unsigned int flags;
       	int keep_base = 0;
       	int ok_to_skip_pre_rebase = 0;
       	struct strbuf msg = STRBUF_INIT;
     -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 		}
     - 	} else if (argc == 0) {
     - 		/* Do not need to switch branches, we are already on it. */
     -+		unsigned int flags;
     - 		options.head_name =
     - 			xstrdup_or_null(resolve_ref_unsafe("HEAD", 0, NULL,
     - 					 &flags));
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
       		    &options.orig_head, &merge_base) &&
       	    allow_preemptive_ff) {
      -		int flag;
     -+		unsigned int unused_flags;
     ++		unsigned int flag;
       
       		if (!(options.flags & REBASE_FORCE)) {
       			/* Lazily switch to the target branch if needed... */
     -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 			if (!(options.flags & REBASE_NO_QUIET))
     - 				; /* be quiet */
     - 			else if (!strcmp(branch_name, "HEAD") &&
     --				 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
     -+				 resolve_ref_unsafe("HEAD", 0, NULL,
     -+						    &unused_flags))
     - 				puts(_("HEAD is up to date."));
     - 			else
     - 				printf(_("Current branch %s is up to date.\n"),
     -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 		} else if (!(options.flags & REBASE_NO_QUIET))
     - 			; /* be quiet */
     - 		else if (!strcmp(branch_name, "HEAD") &&
     --			 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
     -+			 resolve_ref_unsafe("HEAD", 0, NULL, &unused_flags))
     - 			puts(_("HEAD is up to date, rebase forced."));
     - 		else
     - 			printf(_("Current branch %s is up to date, rebase "
      
       ## builtin/receive-pack.c ##
      @@ builtin/receive-pack.c: static void show_ref(const char *path, const struct object_id *oid)
     @@ builtin/receive-pack.c: static void show_ref(const char *path, const struct obje
       
       static int show_ref_cb(const char *path_full, const struct object_id *oid,
      -		       int flag, void *data)
     -+		       unsigned int unused_flags, void *data)
     ++		       unsigned int flag, void *data)
       {
       	struct oidset *seen = data;
       	const char *path = strip_namespace(path_full);
     -@@ builtin/receive-pack.c: static void run_update_post_hook(struct command *commands)
     - 
     - static void check_aliased_update_internal(struct command *cmd,
     - 					  struct string_list *list,
     --					  const char *dst_name, int flag)
     -+					  const char *dst_name,
     -+					  unsigned int flags)
     - {
     - 	struct string_list_item *item;
     - 	struct command *dst_cmd;
     - 
     --	if (!(flag & REF_ISSYMREF))
     -+	if (!(flags & REF_ISSYMREF))
     - 		return;
     - 
     - 	if (!dst_name) {
      @@ builtin/receive-pack.c: static void check_aliased_update(struct command *cmd, struct string_list *list)
       {
       	struct strbuf buf = STRBUF_INIT;
       	const char *dst_name;
      -	int flag;
     -+	unsigned int flags;
     ++	unsigned int flag;
       
       	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
     --	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flag);
     --	check_aliased_update_internal(cmd, list, dst_name, flag);
     -+	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flags);
     -+	check_aliased_update_internal(cmd, list, dst_name, flags);
     - 	strbuf_release(&buf);
     - }
     - 
     + 	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flag);
      
       ## builtin/reflog.c ##
      @@ builtin/reflog.c: static int should_expire_reflog_ent_verbose(struct object_id *ooid,
     @@ builtin/reflog.c: static void reflog_expiry_cleanup(void *cb_data)
       
      -static int collect_reflog(const char *ref, const struct object_id *oid, int unused, void *cb_data)
      +static int collect_reflog(const char *ref, const struct object_id *oid,
     -+			  unsigned int unused_flags, void *cb_data)
     ++			  unsigned int unused, void *cb_data)
       {
       	struct worktree_reflogs *cb = cb_data;
       	struct worktree *worktree = cb->worktree;
     @@ builtin/remote.c: struct branches_for_remote {
       static int add_branch_for_removal(const char *refname,
      -	const struct object_id *oid, int flags, void *cb_data)
      +				  const struct object_id *oid,
     -+				  unsigned int unused_flags, void *cb_data)
     ++				  unsigned int flags, void *cb_data)
       {
       	struct branches_for_remote *branches = cb_data;
       	struct refspec_item refspec;
     @@ builtin/remote.c: struct rename_info {
       
       static int read_remote_branches(const char *refname,
      -	const struct object_id *oid, int flags, void *cb_data)
     -+				const struct object_id *oid,
     -+				unsigned int unused_flags, void *cb_data)
     ++				const struct object_id *oid, unsigned int flags,
     ++				void *cb_data)
       {
       	struct rename_info *rename = cb_data;
       	struct strbuf buf = STRBUF_INIT;
       	struct string_list_item *item;
      -	int flag;
     ++	unsigned int flag;
       	const char *symref;
       
       	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
     - 	if (starts_with(refname, buf.buf)) {
     -+		unsigned int flags;
     - 		item = string_list_append(rename->remote_branches, refname);
     --		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
     --					    NULL, &flag);
     --		if (symref && (flag & REF_ISSYMREF))
     -+		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING, NULL,
     -+					    &flags);
     -+		if (symref && (flags & REF_ISSYMREF))
     - 			item->util = xstrdup(symref);
     - 		else
     - 			item->util = NULL;
      @@ builtin/remote.c: static int mv(int argc, const char **argv)
       	for_each_ref(read_remote_branches, &rename);
       	for (i = 0; i < remote_branches.nr; i++) {
       		struct string_list_item *item = remote_branches.items + i;
      -		int flag = 0;
     -+		unsigned int flags = 0;
     ++		unsigned int flag = 0;
       
     --		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flag);
     --		if (!(flag & REF_ISSYMREF))
     -+		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flags);
     -+		if (!(flags & REF_ISSYMREF))
     - 			continue;
     - 		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
     - 			die(_("deleting '%s' failed"), item->string);
     + 		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flag);
     + 		if (!(flag & REF_ISSYMREF))
      @@ builtin/remote.c: static void free_remote_ref_states(struct ref_states *states)
       }
       
     @@ builtin/remote.c: static void free_remote_ref_states(struct ref_states *states)
      
       ## builtin/repack.c ##
      @@ builtin/repack.c: struct midx_snapshot_ref_data {
     + };
       
       static int midx_snapshot_ref_one(const char *refname,
     - 				 const struct object_id *oid,
     +-				 const struct object_id *oid,
      -				 int flag, void *_data)
     -+				 unsigned int unused_flag, void *_data)
     ++				 const struct object_id *oid, unsigned int flag,
     ++				 void *_data)
       {
       	struct midx_snapshot_ref_data *data = _data;
       	struct object_id peeled;
      
       ## builtin/replace.c ##
      @@ builtin/replace.c: struct show_data {
     + };
       
       static int show_reference(struct repository *r, const char *refname,
     - 			  const struct object_id *oid,
     +-			  const struct object_id *oid,
      -			  int flag, void *cb_data)
     -+			  unsigned int unused_flags, void *cb_data)
     ++			  const struct object_id *oid, unsigned int flag,
     ++			  void *cb_data)
       {
       	struct show_data *data = cb_data;
       
     @@ builtin/rev-parse.c: static int show_default(void)
       
      -static int show_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
      +static int show_reference(const char *refname, const struct object_id *oid,
     -+			  unsigned int unused_flags, void *cb_data)
     ++			  unsigned int flag, void *cb_data)
       {
       	if (ref_excluded(ref_excludes, refname))
       		return 0;
     @@ builtin/rev-parse.c: static int show_reference(const char *refname, const struct
       
      -static int anti_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
      +static int anti_reference(const char *refname, const struct object_id *oid,
     -+			  unsigned int unused_flags, void *cb_data)
     ++			  unsigned int flag, void *cb_data)
       {
       	show_rev(REVERSED, oid, refname);
       	return 0;
     @@ builtin/show-branch.c: static int append_ref(const char *refname, const struct o
       
       static int append_head_ref(const char *refname, const struct object_id *oid,
      -			   int flag, void *cb_data)
     -+			   unsigned int unused_flags, void *cb_data)
     ++			   unsigned int flag, void *cb_data)
       {
       	struct object_id tmp;
       	int ofs = 11;
     @@ builtin/show-branch.c: static int append_head_ref(const char *refname, const str
       
       static int append_remote_ref(const char *refname, const struct object_id *oid,
      -			     int flag, void *cb_data)
     -+			     unsigned int unused_flags, void *cb_data)
     ++			     unsigned int flag, void *cb_data)
       {
       	struct object_id tmp;
       	int ofs = 13;
     -@@ builtin/show-branch.c: static int append_remote_ref(const char *refname, const struct object_id *oid,
     - }
     - 
     - static int append_tag_ref(const char *refname, const struct object_id *oid,
     --			  int flag, void *cb_data)
     -+			  int unused_flags, void *cb_data)
     - {
     - 	if (!starts_with(refname, "refs/tags/"))
     - 		return 0;
      @@ builtin/show-branch.c: static const char *match_ref_pattern = NULL;
       static int match_ref_slash = 0;
       
       static int append_matching_ref(const char *refname, const struct object_id *oid,
      -			       int flag, void *cb_data)
     -+			       unsigned int flags, void *cb_data)
     ++			       unsigned int flag, void *cb_data)
       {
       	/* we want to allow pattern hold/<asterisk> to show all
       	 * branches under refs/heads/hold/, and v0.99.9? to show
     -@@ builtin/show-branch.c: static int append_matching_ref(const char *refname, const struct object_id *oid,
     - 	if (wildmatch(match_ref_pattern, tail, 0))
     - 		return 0;
     - 	if (starts_with(refname, "refs/heads/"))
     --		return append_head_ref(refname, oid, flag, cb_data);
     -+		return append_head_ref(refname, oid, flags, cb_data);
     - 	if (starts_with(refname, "refs/tags/"))
     --		return append_tag_ref(refname, oid, flag, cb_data);
     -+		return append_tag_ref(refname, oid, flags, cb_data);
     - 	return append_ref(refname, oid, 0);
     - }
     - 
      
       ## builtin/show-ref.c ##
      @@ builtin/show-ref.c: static void show_one(const char *refname, const struct object_id *oid)
     @@ builtin/show-ref.c: match:
       
       static int add_existing(const char *refname, const struct object_id *oid,
      -			int flag, void *cbdata)
     -+			unsigned int unused_flags, void *cbdata)
     ++			unsigned int flag, void *cbdata)
       {
       	struct string_list *list = (struct string_list *)cbdata;
       	string_list_insert(list, refname);
     @@ builtin/submodule--helper.c: static void print_status(unsigned int flags, char s
      -				     const struct object_id *oid, int flags,
      -				     void *cb_data)
      +				     const struct object_id *oid,
     -+				     unsigned int unused_flags, void *cb_data)
     ++				     unsigned int flags, void *cb_data)
       {
       	struct object_id *output = cb_data;
       	if (oid)
     @@ builtin/symbolic-ref.c: static const char * const git_symbolic_ref_usage[] = {
       static int check_symref(const char *HEAD, int quiet, int shorten, int print)
       {
      -	int flag;
     --	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flag);
     -+	unsigned int flags;
     -+	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flags);
     ++	unsigned int flag;
     + 	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flag);
       
       	if (!refname)
     - 		die("No such ref: %s", HEAD);
     --	else if (!(flag & REF_ISSYMREF)) {
     -+	else if (!(flags & REF_ISSYMREF)) {
     - 		if (!quiet)
     - 			die("ref %s is not a symbolic ref", HEAD);
     - 		else
      
       ## bundle.c ##
      @@ bundle.c: static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
     @@ bundle.c: static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
       		char *ref;
       		const char *display_ref;
      -		int flag;
     -+		unsigned int flags;
     ++		unsigned int flag;
       
       		if (e->item->flags & UNINTERESTING)
       			continue;
     - 		if (dwim_ref(e->name, strlen(e->name), &oid, &ref, 0) != 1)
     - 			goto skip_write_ref;
     --		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flag))
     --			flag = 0;
     --		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
     -+		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flags))
     -+			flags = 0;
     -+		display_ref = (flags & REF_ISSYMREF) ? e->name : ref;
     - 
     - 		if (e->item->type == OBJ_TAG &&
     - 				!is_tag_in_date_range(e->item, revs)) {
      
       ## commit-graph.c ##
      @@ commit-graph.c: struct refs_cb_data {
     @@ delta-islands.c: static void add_ref_to_island(const char *island_name, const st
       
       static int find_island_for_ref(const char *refname, const struct object_id *oid,
      -			       int flags, void *data)
     -+			       unsigned int unused_flags, void *data)
     ++			       unsigned int flags, void *data)
       {
       	/*
       	 * We should advertise 'ARRAY_SIZE(matches) - 2' as the max,
     @@ fetch-pack.c: static int rev_list_insert_ref(struct fetch_negotiator *negotiator
      -				   int flag, void *cb_data)
      +static int rev_list_insert_ref_oid(const char *refname,
      +				   const struct object_id *oid,
     -+				   unsigned int unused_flags, void *cb_data)
     ++				   unsigned int flag, void *cb_data)
       {
       	return rev_list_insert_ref(cb_data, oid);
       }
     @@ fetch-pack.c: static int mark_complete(const struct object_id *oid)
       
       static int mark_complete_oid(const char *refname, const struct object_id *oid,
      -			     int flag, void *cb_data)
     -+			     unsigned int unused_flags, void *cb_data)
     ++			     unsigned int flag, void *cb_data)
       {
       	return mark_complete(oid);
       }
     @@ http-backend.c: static void get_info_refs(struct strbuf *hdr, char *arg)
       
       static int show_head_ref(const char *refname, const struct object_id *oid,
      -			 int flag, void *cb_data)
     -+			 unsigned int flags, void *cb_data)
     ++			 unsigned int flag, void *cb_data)
       {
       	struct strbuf *buf = cb_data;
       
     --	if (flag & REF_ISSYMREF) {
     -+	if (flags & REF_ISSYMREF) {
     - 		const char *target = resolve_ref_unsafe(refname,
     - 							RESOLVE_REF_READING,
     - 							NULL, NULL);
      
       ## log-tree.c ##
      @@ log-tree.c: static int ref_filter_match(const char *refname,
     @@ log-tree.c: static int ref_filter_match(const char *refname,
       
       static int add_ref_decoration(const char *refname, const struct object_id *oid,
      -			      int flags, void *cb_data)
     -+			      unsigned int unused_flags, void *cb_data)
     ++			      unsigned int flags, void *cb_data)
       {
       	struct object *obj;
       	enum object_type objtype;
     @@ ls-refs.c: struct ls_refs_data {
       
       static int send_ref(const char *refname, const struct object_id *oid,
      -		    int flag, void *cb_data)
     -+		    unsigned int flags, void *cb_data)
     ++		    unsigned int flag, void *cb_data)
       {
       	struct ls_refs_data *data = cb_data;
       	const char *refname_nons = strip_namespace(refname);
     -@@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
     - 		strbuf_addf(&data->buf, "%s %s", oid_to_hex(oid), refname_nons);
     - 	else
     - 		strbuf_addf(&data->buf, "unborn %s", refname_nons);
     --	if (data->symrefs && flag & REF_ISSYMREF) {
     -+	if (data->symrefs && flags & REF_ISSYMREF) {
     - 		struct object_id unused;
     --		const char *symref_target = resolve_ref_unsafe(refname, 0,
     --							       &unused,
     --							       &flag);
     -+		const char *symref_target =
     -+			resolve_ref_unsafe(refname, 0, &unused, &flags);
     - 
     - 		if (!symref_target)
     - 			die("'%s' is a symref but it is not?", refname);
      @@ ls-refs.c: static void send_possibly_unborn_head(struct ls_refs_data *data)
       {
       	struct strbuf namespaced = STRBUF_INIT;
       	struct object_id oid;
      -	int flag;
     -+	unsigned int flags;
     ++	unsigned int flag;
       	int oid_is_null;
       
       	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
     --	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag))
     -+	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flags))
     - 		return; /* bad ref */
     - 	oid_is_null = is_null_oid(&oid);
     - 	if (!oid_is_null ||
     --	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
     --		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
     -+	    (data->unborn && data->symrefs && (flags & REF_ISSYMREF)))
     -+		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flags,
     -+			 data);
     - 	strbuf_release(&namespaced);
     - }
     - 
      
       ## midx.c ##
      @@ midx.c: static void prepare_midx_packing_data(struct packing_data *pdata,
     @@ midx.c: static void prepare_midx_packing_data(struct packing_data *pdata,
      -			      const struct object_id *oid,
      -			      int flag, void *cb_data)
      +static int add_ref_to_pending(const char *refname, const struct object_id *oid,
     -+			      unsigned int flags, void *cb_data)
     ++			      unsigned int flag, void *cb_data)
       {
       	struct rev_info *revs = (struct rev_info*)cb_data;
       	struct object *object;
     - 
     --	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
     -+	if ((flags & REF_ISSYMREF) && (flags & REF_ISBROKEN)) {
     - 		warning("symbolic ref is dangling: %s", refname);
     - 		return 0;
     - 	}
      
       ## negotiator/default.c ##
      @@ negotiator/default.c: static void rev_list_push(struct negotiation_state *ns,
     @@ negotiator/default.c: static void rev_list_push(struct negotiation_state *ns,
       
       static int clear_marks(const char *refname, const struct object_id *oid,
      -		       int flag, void *cb_data)
     -+		       unsigned int unused_flags, void *cb_data)
     ++		       unsigned int flag, void *cb_data)
       {
       	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
       
     @@ negotiator/skipping.c: static struct entry *rev_list_push(struct data *data, str
       
       static int clear_marks(const char *refname, const struct object_id *oid,
      -		       int flag, void *cb_data)
     -+		       unsigned int unused_flags, void *cb_data)
     ++		       unsigned int flag, void *cb_data)
       {
       	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
       
     @@ notes.c: out:
      -				   int flag, void *cb)
      +static int string_list_add_one_ref(const char *refname,
      +				   const struct object_id *oid,
     -+				   unsigned int unused_flags, void *cb)
     ++				   unsigned int flag, void *cb)
       {
       	struct string_list *refs = cb;
       	if (!unsorted_string_list_has_string(refs, refname))
     @@ object-name.c: struct handle_one_ref_cb {
       
       static int handle_one_ref(const char *path, const struct object_id *oid,
      -			  int flag, void *cb_data)
     -+			  unsigned int unused_flags, void *cb_data)
     ++			  unsigned int flag, void *cb_data)
       {
       	struct handle_one_ref_cb *cb = cb_data;
       	struct commit_list **list = cb->list;
     @@ reachable.c: static void update_progress(struct connectivity_progress *cp)
       
       static int add_one_ref(const char *path, const struct object_id *oid,
      -		       int flag, void *cb_data)
     -+		       unsigned int flags, void *cb_data)
     ++		       unsigned int flag, void *cb_data)
       {
       	struct rev_info *revs = (struct rev_info *)cb_data;
       	struct object *object;
     - 
     --	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
     -+	if ((flags & REF_ISSYMREF) && (flags & REF_ISBROKEN)) {
     - 		warning("symbolic ref is dangling: %s", path);
     - 		return 0;
     - 	}
      
       ## ref-filter.c ##
      @@ ref-filter.c: struct ref_filter_cbdata {
     @@ ref-filter.c: struct ref_filter_cbdata {
        */
      -static int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
      +static int ref_filter_handler(const char *refname, const struct object_id *oid,
     -+			      unsigned int flags, void *cb_data)
     ++			      unsigned int flag, void *cb_data)
       {
       	struct ref_filter_cbdata *ref_cbdata = cb_data;
       	struct ref_filter *filter = ref_cbdata->filter;
     -@@ ref-filter.c: static int ref_filter_handler(const char *refname, const struct object_id *oid,
     - 	struct commit *commit = NULL;
     - 	unsigned int kind;
     - 
     --	if (flag & REF_BAD_NAME) {
     -+	if (flags & REF_BAD_NAME) {
     - 		warning(_("ignoring ref with broken name %s"), refname);
     - 		return 0;
     - 	}
     - 
     --	if (flag & REF_ISBROKEN) {
     -+	if (flags & REF_ISBROKEN) {
     - 		warning(_("ignoring broken ref %s"), refname);
     - 		return 0;
     - 	}
     -@@ ref-filter.c: static int ref_filter_handler(const char *refname, const struct object_id *oid,
     - 	 */
     - 	ref = ref_array_push(ref_cbdata->array, refname, oid);
     - 	ref->commit = commit;
     --	ref->flag = flag;
     -+	ref->flag = flags;
     - 	ref->kind = kind;
     - 
     - 	return 0;
      
       ## refs.c ##
      @@ refs.c: static unsigned char refname_disposition[256] = {
     @@ refs.c: int ref_resolves_to_object(const char *refname,
      +			  unsigned int *flags)
       {
       	const char *result;
     - 	int ignore_errno;
     + 
      @@ refs.c: char *refs_resolve_refdup(struct ref_store *refs,
       	return xstrdup_or_null(result);
       }
     @@ refs.c: struct ref_filter {
      +int read_ref_full(const char *refname, unsigned int resolve_flags,
      +		  struct object_id *oid, unsigned int *flags)
       {
     - 	int ignore_errno;
       	struct ref_store *refs = get_main_ref_store(the_repository);
     + 
      @@ refs.c: int ref_exists(const char *refname)
       }
       
     @@ refs.c: int head_ref_namespaced(each_ref_fn fn, void *cb_data)
       	int ret = 0;
       	struct object_id oid;
      -	int flag;
     -+	unsigned int flags;
     ++	unsigned int flag;
       
       	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
     --	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flag))
     --		ret = fn(buf.buf, &oid, flag, cb_data);
     -+	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flags))
     -+		ret = fn(buf.buf, &oid, flags, cb_data);
     - 	strbuf_release(&buf);
     - 
     - 	return ret;
     + 	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flag))
      @@ refs.c: int expand_ref(struct repository *repo, const char *str, int len,
       	for (p = ref_rev_parse_rules; *p; p++) {
       		struct object_id oid_from_ref;
       		struct object_id *this_result;
      -		int flag;
     -+		unsigned int flags;
     ++		unsigned int flag;
       		struct ref_store *refs = get_main_ref_store(repo);
     - 		int ignore_errno;
       
     -@@ refs.c: int expand_ref(struct repository *repo, const char *str, int len,
     - 		strbuf_reset(&fullref);
     - 		strbuf_addf(&fullref, *p, len, str);
     - 		r = refs_resolve_ref_unsafe(refs, fullref.buf,
     --					    RESOLVE_REF_READING,
     --					    this_result, &flag,
     --					    &ignore_errno);
     -+					    RESOLVE_REF_READING, this_result,
     -+					    &flags, &ignore_errno);
     - 		if (r) {
     - 			if (!refs_found++)
     - 				*ref = xstrdup(r);
     - 			if (!warn_ambiguous_refs)
     - 				break;
     --		} else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
     -+		} else if ((flags & REF_ISSYMREF) &&
     -+			   strcmp(fullref.buf, "HEAD")) {
     - 			warning(_("ignoring dangling symref %s"), fullref.buf);
     --		} else if ((flag & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
     -+		} else if ((flags & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
     - 			warning(_("ignoring broken ref %s"), fullref.buf);
     - 		}
     - 	}
     + 		this_result = refs_found ? &oid_from_ref : oid;
      @@ refs.c: const char *find_descendant_ref(const char *dirname,
       int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
       {
       	struct object_id oid;
      -	int flag;
     -+	unsigned int flags;
     - 	int ignore_errno;
     - 
     --	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
     --				    &oid, &flag, &ignore_errno))
     --		return fn("HEAD", &oid, flag, cb_data);
     -+	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING, &oid,
     -+				    &flags, &ignore_errno))
     -+		return fn("HEAD", &oid, flags, cb_data);
     ++	unsigned int flag;
       
     - 	return 0;
     - }
     + 	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
     + 				    &oid, &flag))
      @@ refs.c: struct do_for_each_ref_help {
       	void *cb_data;
       };
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
      -				    const char *refname,
      -				    int resolve_flags,
      -				    struct object_id *oid,
     --				    int *flags, int *failure_errno)
     +-				    int *flags)
      +const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
      +				    unsigned int resolve_flags,
     -+				    struct object_id *oid, unsigned int *flags,
     -+				    int *failure_errno)
     ++				    struct object_id *oid, unsigned int *flags)
       {
       	static struct strbuf sb_refname = STRBUF_INIT;
       	struct object_id unused_oid;
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
      +	unsigned int unused_flags;
       	int symref_count;
       
     - 	assert(failure_errno);
     + 	if (!oid)
      @@ refs.c: int refs_init_db(struct strbuf *err)
       	return refs->be->init_db(refs, err);
       }
     @@ refs.c: int refs_init_db(struct strbuf *err)
      +const char *resolve_ref_unsafe(const char *refname, unsigned int resolve_flags,
      +			       struct object_id *oid, unsigned int *flags)
       {
     - 	int ignore_errno;
     - 
     + 	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refname,
     + 				       resolve_flags, oid, flags);
      @@ refs.c: int resolve_gitlink_ref(const char *submodule, const char *refname,
       			struct object_id *oid)
       {
       	struct ref_store *refs;
      -	int flags;
     -+	unsigned int unused_flags;
     - 	int ignore_errno;
     ++	unsigned int flags;
       
       	refs = get_submodule_ref_store(submodule);
     -@@ refs.c: int resolve_gitlink_ref(const char *submodule, const char *refname,
     - 	if (!refs)
     - 		return -1;
       
     --	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags,
     --				     &ignore_errno) || is_null_oid(oid))
     -+	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &unused_flags,
     -+				     &ignore_errno) ||
     -+	    is_null_oid(oid))
     - 		return -1;
     - 	return 0;
     - }
      
       ## refs.h ##
      @@ refs.h: struct worktree;
     @@ refs.h: struct worktree;
      -				    const char *refname,
      -				    int resolve_flags,
      -				    struct object_id *oid,
     --				    int *flags, int *failure_errno);
     +-				    int *flags);
      -
      -const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
      -			       struct object_id *oid, int *flags);
     @@ refs.h: struct worktree;
      -		  struct object_id *oid, int *flags);
      +const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
      +				    unsigned int resolve_flags,
     -+				    struct object_id *oid, unsigned int *flags,
     -+				    int *failure_errno);
     ++				    struct object_id *oid, unsigned int *flags);
      +
      +const char *resolve_ref_unsafe(const char *refname, unsigned int resolve_flags,
      +			       struct object_id *oid, unsigned int *flags);
     @@ refs/files-backend.c: static void loose_fill_ref_dir(struct ref_store *ref_store
       		struct object_id oid;
       		struct stat st;
      -		int flag;
     ++		unsigned int flag;
       
       		if (de->d_name[0] == '.')
       			continue;
     -@@ refs/files-backend.c: static void loose_fill_ref_dir(struct ref_store *ref_store,
     - 							  refname.len));
     - 		} else {
     - 			int ignore_errno;
     --			if (!refs_resolve_ref_unsafe(&refs->base,
     --						     refname.buf,
     --						     RESOLVE_REF_READING,
     --						     &oid, &flag, &ignore_errno)) {
     -+			unsigned int flags;
     -+			if (!refs_resolve_ref_unsafe(&refs->base, refname.buf,
     -+						     RESOLVE_REF_READING, &oid,
     -+						     &flags, &ignore_errno)) {
     - 				oidclr(&oid);
     --				flag |= REF_ISBROKEN;
     -+				flags |= REF_ISBROKEN;
     - 			} else if (is_null_oid(&oid)) {
     - 				/*
     - 				 * It is so astronomically unlikely
     -@@ refs/files-backend.c: static void loose_fill_ref_dir(struct ref_store *ref_store,
     - 				 * file to be repo corruption
     - 				 * (probably due to a software bug).
     - 				 */
     --				flag |= REF_ISBROKEN;
     -+				flags |= REF_ISBROKEN;
     - 			}
     - 
     - 			if (check_refname_format(refname.buf,
     -@@ refs/files-backend.c: static void loose_fill_ref_dir(struct ref_store *ref_store,
     - 				if (!refname_is_safe(refname.buf))
     - 					die("loose refname is dangerous: %s", refname.buf);
     - 				oidclr(&oid);
     --				flag |= REF_BAD_NAME | REF_ISBROKEN;
     -+				flags |= REF_BAD_NAME | REF_ISBROKEN;
     - 			}
     --			add_entry_to_dir(dir,
     --					 create_ref_entry(refname.buf, &oid, flag));
     -+			add_entry_to_dir(dir, create_ref_entry(refname.buf,
     -+							       &oid, flags));
     - 		}
     - 		strbuf_setlen(&refname, dirnamelen);
     - 		strbuf_setlen(&path, path_baselen);
      @@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_store,
       	struct files_ref_store *refs =
       		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
       	struct object_id orig_oid;
      -	int flag = 0, logmoved = 0;
      +	int logmoved = 0;
     -+	unsigned int flags = 0;
     ++	unsigned int flag = 0;
       	struct ref_lock *lock;
       	struct stat loginfo;
       	struct strbuf sb_oldref = STRBUF_INIT;
     -@@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_store,
     - 	}
     - 
     - 	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
     --				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
     --				     &orig_oid, &flag, &ignore_errno)) {
     -+				     RESOLVE_REF_READING |
     -+					     RESOLVE_REF_NO_RECURSE,
     -+				     &orig_oid, &flags, &ignore_errno)) {
     - 		ret = error("refname %s not found", oldrefname);
     - 		goto out;
     - 	}
     - 
     --	if (flag & REF_ISSYMREF) {
     -+	if (flags & REF_ISSYMREF) {
     - 		if (copy)
     - 			ret = error("refname %s is a symbolic ref, copying it is not supported",
     - 				    oldrefname);
     -@@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_store,
     - 		goto rollbacklog;
     - 	}
     - 
     --	flag = log_all_ref_updates;
     -+	flags = log_all_ref_updates;
     - 	log_all_ref_updates = LOG_REFS_NONE;
     - 	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
     - 	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
     - 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
     - 		strbuf_release(&err);
     - 	}
     --	log_all_ref_updates = flag;
     -+	log_all_ref_updates = flags;
     - 
     -  rollbacklog:
     - 	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
     -@@ refs/files-backend.c: static int log_ref_write_fd(int fd, const struct object_id *old_oid,
     - }
     - 
     - static int files_log_ref_write(struct files_ref_store *refs,
     --			       const char *refname, const struct object_id *old_oid,
     -+			       const char *refname,
     -+			       const struct object_id *old_oid,
     - 			       const struct object_id *new_oid, const char *msg,
     --			       int flags, struct strbuf *err)
     -+			       unsigned int flags, struct strbuf *err)
     - {
     - 	int logfd, result;
     - 
      @@ refs/files-backend.c: static int commit_ref_update(struct files_ref_store *refs,
       		 * check with HEAD only which should cover 99% of all usage
       		 * scenarios (even 100% of the default ones).
       		 */
      -		int head_flag;
     -+		unsigned int head_flags;
     ++		unsigned int head_flag;
       		const char *head_ref;
     - 		int ignore_errno;
       
       		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
     --						   RESOLVE_REF_READING,
     --						   NULL, &head_flag,
     --						   &ignore_errno);
     --		if (head_ref && (head_flag & REF_ISSYMREF) &&
     -+						   RESOLVE_REF_READING, NULL,
     -+						   &head_flags, &ignore_errno);
     -+		if (head_ref && (head_flags & REF_ISSYMREF) &&
     - 		    !strcmp(head_ref, lock->ref_name)) {
     - 			struct strbuf log_err = STRBUF_INIT;
     - 			if (files_log_ref_write(refs, "HEAD",
      @@ refs/files-backend.c: static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
     - 	int ignore_errno;
     + 	int ok;
       
       	while ((ok = dir_iterator_advance(diter)) == ITER_OK) {
      -		int flags;
     @@ refs/files-backend.c: static int files_transaction_abort(struct ref_store *ref_s
      -static int ref_present(const char *refname,
      -		       const struct object_id *oid, int flags, void *cb_data)
      +static int ref_present(const char *refname, const struct object_id *oid,
     -+		       unsigned int unused_flags, void *cb_data)
     ++		       unsigned int flags, void *cb_data)
       {
       	struct string_list *affected_refnames = cb_data;
       
      @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
     + 
       		if ((expire_flags & EXPIRE_REFLOGS_UPDATE_REF) &&
       		    !is_null_oid(&cb.last_kept_oid)) {
     - 			int ignore_errno;
      -			int type;
      +			unsigned int type;
       			const char *ref;
     @@ remote.c: static void alias_all_urls(struct remote_state *remote_state)
       static void read_config(struct repository *repo)
       {
      -	int flag;
     -+	unsigned int flags;
     ++	unsigned int flag;
       
       	if (repo->remote_state->initialized)
       		return;
     -@@ remote.c: static void read_config(struct repository *repo)
     - 	if (startup_info->have_repository) {
     - 		int ignore_errno;
     - 		const char *head_ref = refs_resolve_ref_unsafe(
     --			get_main_ref_store(repo), "HEAD", 0, NULL, &flag, &ignore_errno);
     --		if (head_ref && (flag & REF_ISSYMREF) &&
     -+			get_main_ref_store(repo), "HEAD", 0, NULL, &flags,
     -+			&ignore_errno);
     -+		if (head_ref && (flags & REF_ISSYMREF) &&
     - 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
     - 			repo->remote_state->current_branch = make_branch(
     - 				repo->remote_state, head_ref, strlen(head_ref));
      @@ remote.c: static int match_explicit(struct ref *src, struct ref *dst,
       		return -1;
       
       	if (!dst_value) {
      -		int flag;
     --
     --		dst_value = resolve_ref_unsafe(matched_src->name,
     --					       RESOLVE_REF_READING,
     --					       NULL, &flag);
     --		if (!dst_value ||
     --		    ((flag & REF_ISSYMREF) &&
     --		     !starts_with(dst_value, "refs/heads/")))
     -+		unsigned int flags;
     -+
     -+		dst_value = resolve_ref_unsafe(
     -+			matched_src->name, RESOLVE_REF_READING, NULL, &flags);
     -+		if (!dst_value || ((flags & REF_ISSYMREF) &&
     -+				   !starts_with(dst_value, "refs/heads/")))
     - 			die(_("%s cannot be resolved to branch"),
     - 			    matched_src->name);
     - 	}
     ++		unsigned int flag;
     + 
     + 		dst_value = resolve_ref_unsafe(matched_src->name,
     + 					       RESOLVE_REF_READING,
      @@ remote.c: const char *branch_get_push(struct branch *branch, struct strbuf *err)
       
       static int ignore_symref_update(const char *refname)
       {
      -	int flag;
     -+	unsigned int flags;
     ++	unsigned int flag;
       
     --	if (!resolve_ref_unsafe(refname, 0, NULL, &flag))
     -+	if (!resolve_ref_unsafe(refname, 0, NULL, &flags))
     + 	if (!resolve_ref_unsafe(refname, 0, NULL, &flag))
       		return 0; /* non-existing refs are OK */
     --	return (flag & REF_ISSYMREF);
     -+	return (flags & REF_ISSYMREF);
     - }
     - 
     - /*
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       }
       
     @@ replace-object.c
       
      -static int register_replace_ref(struct repository *r,
      -				const char *refname,
     -+static int register_replace_ref(struct repository *r, const char *refname,
     - 				const struct object_id *oid,
     +-				const struct object_id *oid,
      -				int flag, void *cb_data)
     -+				unsigned int unused_flags, void *cb_data)
     ++static int register_replace_ref(struct repository *r, const char *refname,
     ++				const struct object_id *oid, unsigned int flag,
     ++				void *cb_data)
       {
       	/* Get sha1 from refname */
       	const char *slash = strrchr(refname, '/');
     @@ revision.c: int ref_excluded(struct string_list *ref_excludes, const char *path)
       
       static int handle_one_ref(const char *path, const struct object_id *oid,
      -			  int flag, void *cb_data)
     -+			  unsigned int unused_flags, void *cb_data)
     ++			  unsigned int flag, void *cb_data)
       {
       	struct all_refs_cb *cb = cb_data;
       	struct object *object;
      @@ revision.c: static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
     + }
       
       static int handle_one_reflog(const char *refname_in_wt,
     - 			     const struct object_id *oid,
     +-			     const struct object_id *oid,
      -			     int flag, void *cb_data)
     -+			     unsigned int unused_flags, void *cb_data)
     ++			     const struct object_id *oid, unsigned int flag,
     ++			     void *cb_data)
       {
       	struct all_refs_cb *cb = cb_data;
       	struct strbuf refname = STRBUF_INIT;
     @@ server-info.c: out:
       
       static int add_info_ref(const char *path, const struct object_id *oid,
      -			int flag, void *cb_data)
     -+			unsigned int unused_flags, void *cb_data)
     ++			unsigned int flag, void *cb_data)
       {
       	struct update_info_ctx *uic = cb_data;
       	struct object *o = parse_object(the_repository, oid);
     @@ shallow.c: static void paint_down(struct paint_info *info, const struct object_i
       
       static int mark_uninteresting(const char *refname, const struct object_id *oid,
      -			      int flags, void *cb_data)
     -+			      unsigned int unused_flags, void *cb_data)
     ++			      unsigned int flags, void *cb_data)
       {
       	struct commit *commit = lookup_commit_reference_gently(the_repository,
       							       oid, 1);
     @@ shallow.c: struct commit_array {
       
       static int add_ref(const char *refname, const struct object_id *oid,
      -		   int flags, void *cb_data)
     -+		   unsigned int unused_flags, void *cb_data)
     ++		   unsigned int flags, void *cb_data)
       {
       	struct commit_array *ca = cb_data;
       	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
     @@ submodule.c: static void free_submodules_oids(struct string_list *submodules)
       
       static int has_remote(const char *refname, const struct object_id *oid,
      -		      int flags, void *cb_data)
     -+		      unsigned int unused_flags, void *cb_data)
     ++		      unsigned int flags, void *cb_data)
       {
       	return 1;
       }
     @@ submodule.c: int push_unpushed_submodules(struct repository *r,
       
       static int append_oid_to_array(const char *ref, const struct object_id *oid,
      -			       int flags, void *data)
     -+			       unsigned int unused_flags, void *data)
     ++			       unsigned int flags, void *data)
       {
       	struct oid_array *array = data;
       	oid_array_append(array, oid);
     @@ t/helper/test-ref-store.c: static int cmd_resolve_ref(struct ref_store *refs, co
      -	int flags;
      +	unsigned int flags;
       	const char *ref;
     - 	int ignore_errno;
       
     + 	ref = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
      
       ## transport-helper.c ##
      @@ transport-helper.c: static int push_refs_with_export(struct transport *transport,
     @@ transport-helper.c: static int push_refs_with_export(struct transport *transport
       				if (!ref->deletion) {
       					const char *name;
      -					int flag;
     -+					unsigned int ref_flags;
     ++					unsigned int flag;
       
       					/* Follow symbolic refs (mainly for HEAD). */
     --					name = resolve_ref_unsafe(ref->peer_ref->name,
     --								  RESOLVE_REF_READING,
     --								  &oid, &flag);
     --					if (!name || !(flag & REF_ISSYMREF))
     -+					name = resolve_ref_unsafe(
     -+						ref->peer_ref->name,
     -+						RESOLVE_REF_READING, &oid,
     -+						&ref_flags);
     -+					if (!name ||
     -+					    !(ref_flags & REF_ISSYMREF))
     - 						name = ref->peer_ref->name;
     - 
     - 					strbuf_addf(&buf, "%s:%s", name, ref->name);
     + 					name = resolve_ref_unsafe(ref->peer_ref->name,
      
       ## transport.c ##
      @@ transport.c: static void set_upstreams(struct transport *transport, struct ref *refs,
     @@ transport.c: static void set_upstreams(struct transport *transport, struct ref *
       		const char *tmp;
       		const char *remotename;
      -		int flag = 0;
     -+		unsigned int ref_flags = 0;
     ++		unsigned int flag = 0;
       		/*
       		 * Check suitability for tracking. Must be successful /
       		 * already up-to-date ref create/modify (not delete).
     -@@ transport.c: static void set_upstreams(struct transport *transport, struct ref *refs,
     - 		/* Follow symbolic refs (mainly for HEAD). */
     - 		localname = ref->peer_ref->name;
     - 		remotename = ref->name;
     --		tmp = resolve_ref_unsafe(localname, RESOLVE_REF_READING,
     --					 NULL, &flag);
     --		if (tmp && flag & REF_ISSYMREF &&
     --			starts_with(tmp, "refs/heads/"))
     -+		tmp = resolve_ref_unsafe(localname, RESOLVE_REF_READING, NULL,
     -+					 &ref_flags);
     -+		if (tmp && ref_flags & REF_ISSYMREF &&
     -+		    starts_with(tmp, "refs/heads/"))
     - 			localname = tmp;
     - 
     - 		/* Both source and destination must be local branches. */
      
       ## upload-pack.c ##
      @@ upload-pack.c: static void send_unshallow(struct upload_pack_data *data)
     @@ upload-pack.c: static int mark_our_ref(const char *refname, const char *refname_
       
       static int check_ref(const char *refname_full, const struct object_id *oid,
      -		     int flag, void *cb_data)
     -+		     unsigned int unused_flags, void *cb_data)
     ++		     unsigned int flag, void *cb_data)
       {
       	const char *refname = strip_namespace(refname_full);
       
     @@ upload-pack.c: static void format_session_id(struct strbuf *buf, struct upload_p
       
       static int send_ref(const char *refname, const struct object_id *oid,
      -		    int flag, void *cb_data)
     -+		    unsigned int unused_flags, void *cb_data)
     ++		    unsigned int flag, void *cb_data)
       {
       	static const char *capabilities = "multi_ack thin-pack side-band"
       		" side-band-64k ofs-delta shallow deepen-since deepen-not"
     @@ upload-pack.c: static int send_ref(const char *refname, const struct object_id *
       
       static int find_symref(const char *refname, const struct object_id *oid,
      -		       int flag, void *cb_data)
     -+		       unsigned int flags, void *cb_data)
     ++		       unsigned int flag, void *cb_data)
       {
       	const char *symref_target;
       	struct string_list_item *item;
     - 
     --	if ((flag & REF_ISSYMREF) == 0)
     -+	if ((flags & REF_ISSYMREF) == 0)
     - 		return 0;
     --	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flag);
     --	if (!symref_target || (flag & REF_ISSYMREF) == 0)
     -+	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flags);
     -+	if (!symref_target || (flags & REF_ISSYMREF) == 0)
     - 		die("'%s' is a symref but it is not?", refname);
     - 	item = string_list_append(cb_data, strip_namespace(refname));
     - 	item->util = xstrdup(strip_namespace(symref_target));
      
       ## walker.c ##
      @@ walker.c: static int interpret_target(struct walker *walker, char *target, struct object_i
     @@ walker.c: static int interpret_target(struct walker *walker, char *target, struc
       
       static int mark_complete(const char *path, const struct object_id *oid,
      -			 int flag, void *cb_data)
     -+			 unsigned int unused_flags, void *cb_data)
     ++			 unsigned int flag, void *cb_data)
       {
       	struct commit *commit = lookup_commit_reference_gently(the_repository,
       							       oid, 1);
     @@ worktree.c: void free_worktrees(struct worktree **worktrees)
      -	int flags;
      +	unsigned int flags;
       	const char *target;
     - 	int ignore_errno;
       
     + 	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
      @@ worktree.c: const struct worktree *find_shared_symref(struct worktree **worktrees,
       		struct worktree *wt = worktrees[i];
       		const char *symref_target;
       		struct ref_store *refs;
      -		int flags;
      +		unsigned int flags;
     - 		int ignore_errno;
       
       		if (wt->is_bare)
     + 			continue;
      @@ worktree.c: int other_head_refs(each_ref_fn fn, void *cb_data)
       	for (p = worktrees; *p; p++) {
       		struct worktree *wt = *p;
       		struct object_id oid;
      -		int flag;
     -+		unsigned int flags;
     - 		int ignore_errno;
     ++		unsigned int flag;
       
       		if (wt->is_current)
     -@@ worktree.c: int other_head_refs(each_ref_fn fn, void *cb_data)
     - 		strbuf_reset(&refname);
     - 		strbuf_worktree_ref(wt, &refname, "HEAD");
     - 		if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
     --					    refname.buf,
     --					    RESOLVE_REF_READING,
     --					    &oid, &flag, &ignore_errno))
     --			ret = fn(refname.buf, &oid, flag, cb_data);
     -+					    refname.buf, RESOLVE_REF_READING,
     -+					    &oid, &flags, &ignore_errno))
     -+			ret = fn(refname.buf, &oid, flags, cb_data);
     - 		if (ret)
     - 			break;
     - 	}
     + 			continue;
 -:  ----------- > 2:  e94a923a647 Uniformize flag argument naming to `flags` or `unused_flags`

-- 
gitgitgadget
