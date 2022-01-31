Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA1C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 20:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378368AbiAaUPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 15:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378334AbiAaUPl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 15:15:41 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA541C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 12:15:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v13so27615721wrv.10
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 12:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dhG/oQ63hi3cvxFm4ldbrNtiaFX7dLujP+dhHriF91U=;
        b=nm9lHtr6zEYaS6TsjDsicrEvwadhDcNtUCj/Jsrj2HapOUD9K8MuqBR1RuTxzVW5/p
         F1wyIxf33+QUaZrR1gpFDR8iYX5y82Q2uw4xaVb4bDTdp1nvDQ0ngdVHtiD/SfLpo2c+
         IzJRes04zmbfQVWYhVUOyKkpWMcjv1rM7ShRc6cqO7eLZHBHuAddnMkI9pzpLsSuQ6ST
         vTGe5Z/N3Gwk2dVxFbdexRxsnYh2wL16+1DOVfxlp6wDc4SOF7I5QLXrqYiOBi9bSXjD
         Ah3kit+lnK8VFMwNtZUUqXFlNu/M5iFxA4ditHIqODi+E9DFy/fFILR03djbBQQNw4v9
         vHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dhG/oQ63hi3cvxFm4ldbrNtiaFX7dLujP+dhHriF91U=;
        b=PxHV9gUafY0oln06PBdub2fL16r8ErTIDTJSMXl3iReZum69AUno0M9fJ5gj3IQhKz
         PqwuyTx6e8mMN19EYLyGfl2weZ+/DeKJ1TzPi/ZKnr8gY8gDOzBOqhDwN6zo553/yX5P
         M0zTmgTJnInp80UVYYJN1pGqwED53xFkj+s8/AVRwLleuyHcAQMxXXd0ajyceRzZaWgt
         M28YiFCins/28u6YDrwsDsMA2gZU07HsyZ+/CE7P3umGWbHz9k1gSI+hGhHI511oYCBK
         tmdTUKD5o619yc2AFHEyf1SA8IOjnimgHc+4ZOXl1Ho7u6cFOl7dneFtIoSp9rEr3TQq
         p5mQ==
X-Gm-Message-State: AOAM532zWu1+cbJZSs6VdLtAZWBbcwM7GghoFJA4H0vBFGGskBJF6cKG
        bYHxJbMwhqFVF7QpbYY4umlRUDU5JZ4=
X-Google-Smtp-Source: ABdhPJy7br2W4iYBbvYEYXLtRKrjyEaCscgt/aLE9kKuBEKKCyjdZdnCjq1xWrjHs/nNLtucr129yw==
X-Received: by 2002:a5d:48c9:: with SMTP id p9mr18168280wrs.1.1643660138379;
        Mon, 31 Jan 2022 12:15:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm15490753wry.102.2022.01.31.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:15:37 -0800 (PST)
Message-Id: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 20:15:35 +0000
Subject: [PATCH] refs.h: make all flags arguments unsigned
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

As discussed in
https://lore.kernel.org/git/xmqqbkzrkevo.fsf@gitster.g/ , we don't
want to treat the sign bit specially, so make all flags in refs.h
unsigned.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs.h: make all flags arguments unsigned
    
    As discussed in https://lore.kernel.org/git/xmqqbkzrkevo.fsf@gitster.g/
    , we don't want to treat the sign bit specially, so make all flags in
    refs.h unsigned.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1210%2Fhanwen%2Funsigned-flags-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1210/hanwen/unsigned-flags-v1
Pull-Request: https://github.com/git/git/pull/1210

 bisect.c                    |  4 +--
 builtin/bisect--helper.c    |  7 ++---
 builtin/branch.c            |  4 +--
 builtin/checkout.c          |  9 ++++---
 builtin/describe.c          |  3 ++-
 builtin/fetch.c             | 10 +++----
 builtin/fsck.c              |  4 +--
 builtin/gc.c                |  5 ++--
 builtin/name-rev.c          |  3 ++-
 builtin/pack-objects.c      | 11 ++++----
 builtin/rebase.c            |  5 ++--
 builtin/receive-pack.c      |  4 +--
 builtin/reflog.c            |  5 ++--
 builtin/remote.c            | 13 ++++++----
 builtin/repack.c            |  4 +--
 builtin/replace.c           |  4 +--
 builtin/rev-parse.c         |  6 +++--
 builtin/show-branch.c       |  6 ++---
 builtin/show-ref.c          |  4 +--
 builtin/stash.c             |  2 +-
 builtin/submodule--helper.c |  4 +--
 builtin/symbolic-ref.c      |  2 +-
 bundle.c                    |  2 +-
 commit-graph.c              |  5 ++--
 config.c                    |  2 +-
 delta-islands.c             |  2 +-
 fetch-pack.c                |  7 ++---
 help.c                      |  2 +-
 http-backend.c              |  4 +--
 log-tree.c                  |  4 +--
 ls-refs.c                   |  4 +--
 midx.c                      |  5 ++--
 negotiator/default.c        |  2 +-
 negotiator/skipping.c       |  2 +-
 notes.c                     |  5 ++--
 object-name.c               |  2 +-
 reachable.c                 |  2 +-
 ref-filter.c                |  3 ++-
 refs.c                      | 52 ++++++++++++++++++-------------------
 refs.h                      | 38 ++++++++++++---------------
 refs/files-backend.c        | 17 ++++++------
 remote.c                    | 10 +++----
 replace-object.c            |  7 +++--
 revision.c                  |  8 +++---
 server-info.c               |  2 +-
 shallow.c                   |  4 +--
 submodule.c                 |  4 +--
 t/helper/test-ref-store.c   |  4 +--
 transport-helper.c          |  2 +-
 transport.c                 |  2 +-
 upload-pack.c               |  8 +++---
 walker.c                    |  2 +-
 worktree.c                  |  6 ++---
 53 files changed, 171 insertions(+), 167 deletions(-)

diff --git a/bisect.c b/bisect.c
index 888949fba6b..264d60d8e3d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -441,7 +441,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 }
 
 static int register_ref(const char *refname, const struct object_id *oid,
-			int flags, void *cb_data)
+			unsigned int flags, void *cb_data)
 {
 	struct strbuf good_prefix = STRBUF_INIT;
 	strbuf_addstr(&good_prefix, term_good);
@@ -1146,7 +1146,7 @@ int estimate_bisect_steps(int all)
 }
 
 static int mark_for_removal(const char *refname, const struct object_id *oid,
-			    int flag, void *cb_data)
+			    unsigned int flag, void *cb_data)
 {
 	struct string_list *refs = cb_data;
 	char *ref = xstrfmt("refs/bisect%s", refname);
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..976196eb57c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -330,7 +330,7 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
 }
 
 static int mark_good(const char *refname, const struct object_id *oid,
-		     int flag, void *cb_data)
+		     unsigned int flag, void *cb_data)
 {
 	int *m_good = (int *)cb_data;
 	*m_good = 0;
@@ -477,7 +477,7 @@ finish:
 }
 
 static int add_bisect_ref(const char *refname, const struct object_id *oid,
-			  int flags, void *cb)
+			  unsigned int flags, void *cb)
 {
 	struct add_bisect_ref_data *data = cb;
 
@@ -617,7 +617,8 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 	int no_checkout = 0;
 	int first_parent_only = 0;
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
-	int flags, pathspec_pos;
+	int pathspec_pos;
+	unsigned int flags;
 	enum bisect_error res = BISECT_OK;
 	struct string_list revs = STRING_LIST_INIT_DUP;
 	struct string_list states = STRING_LIST_INIT_DUP;
diff --git a/builtin/branch.c b/builtin/branch.c
index 4ce2a247542..542eb2e4d50 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -234,7 +234,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
-		int flags = 0;
+		unsigned int flags = 0;
 
 		strbuf_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
@@ -469,7 +469,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 
 static void print_current_branch_name(void)
 {
-	int flags;
+	unsigned int flags;
 	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
 	const char *shortname;
 	if (!refname)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cc804ba8e1e..c6a2db4964d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -968,7 +968,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 static int add_pending_uninteresting_ref(const char *refname,
 					 const struct object_id *oid,
-					 int flags, void *cb_data)
+					 unsigned int flags, void *cb_data)
 {
 	add_pending_oid(cb_data, refname, oid, UNINTERESTING);
 	return 0;
@@ -1077,7 +1077,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	int ret = 0;
 	struct branch_info old_branch_info = { 0 };
 	struct object_id rev;
-	int flag, writeout_error = 0;
+	int writeout_error = 0;
+	unsigned int flag;
 	int do_merge = 1;
 
 	trace2_cmd_mode("branch");
@@ -1503,7 +1504,7 @@ static int checkout_branch(struct checkout_opts *opts,
 
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
-		int flag;
+		unsigned int flag;
 		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
 		if (head_ref &&
 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
@@ -1513,7 +1514,7 @@ static int checkout_branch(struct checkout_opts *opts,
 
 	if (!new_branch_info->commit && opts->new_branch) {
 		struct object_id rev;
-		int flag;
+		unsigned int flag;
 
 		if (!read_ref_full("HEAD", 0, &rev, &flag) &&
 		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
diff --git a/builtin/describe.c b/builtin/describe.c
index 42159cd26bd..5fa5b0bb424 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -140,7 +140,8 @@ static void add_to_known_names(const char *path,
 	}
 }
 
-static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
+static int get_name(const char *path, const struct object_id *oid,
+		    unsigned int flag, void *cb_data)
 {
 	int is_tag = 0;
 	struct object_id peeled;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e9..08a240f2d33 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -323,9 +323,8 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
 	return ent;
 }
 
-static int add_one_refname(const char *refname,
-			   const struct object_id *oid,
-			   int flag, void *cbdata)
+static int add_one_refname(const char *refname, const struct object_id *oid,
+			   unsigned int flag, void *cbdata)
 {
 	struct hashmap *refname_map = cbdata;
 
@@ -1429,9 +1428,8 @@ static void set_option(struct transport *transport, const char *name, const char
 			name, transport->url);
 }
 
-
-static int add_oid(const char *refname, const struct object_id *oid, int flags,
-		   void *cb_data)
+static int add_oid(const char *refname, const struct object_id *oid,
+		   unsigned int flags, void *cb_data)
 {
 	struct oid_array *oids = cb_data;
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9e54892311d..8e3f773e3dd 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -502,7 +502,7 @@ static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid
 }
 
 static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
-			      int flag, void *cb_data)
+			      unsigned int flag, void *cb_data)
 {
 	struct strbuf refname = STRBUF_INIT;
 
@@ -513,7 +513,7 @@ static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
 }
 
 static int fsck_handle_ref(const char *refname, const struct object_id *oid,
-			   int flag, void *cb_data)
+			   unsigned int flag, void *cb_data)
 {
 	struct object *obj;
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 8e60ef1eaba..2eae43a6bb1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -768,9 +768,8 @@ struct cg_auto_data {
 	int limit;
 };
 
-static int dfs_on_ref(const char *refname,
-		      const struct object_id *oid, int flags,
-		      void *cb_data)
+static int dfs_on_ref(const char *refname, const struct object_id *oid,
+		      unsigned int flags, void *cb_data)
 {
 	struct cg_auto_data *data = (struct cg_auto_data *)cb_data;
 	int result = 0;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 27f60153a6c..465652d5e37 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -305,7 +305,8 @@ static int cmp_by_tag_and_age(const void *a_, const void *b_)
 	return a->taggerdate != b->taggerdate;
 }
 
-static int name_ref(const char *path, const struct object_id *oid, int flags, void *cb_data)
+static int name_ref(const char *path, const struct object_id *oid,
+		    unsigned int flags, void *cb_data)
 {
 	struct object *o = parse_object(the_repository, oid);
 	struct name_ref_data *data = cb_data;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba2006f2212..16c47bb09ab 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -758,8 +758,8 @@ static enum write_one_status write_one(struct hashfile *f,
 	return WRITE_ONE_WRITTEN;
 }
 
-static int mark_tagged(const char *path, const struct object_id *oid, int flag,
-		       void *cb_data)
+static int mark_tagged(const char *path, const struct object_id *oid,
+		       unsigned int flag, void *cb_data)
 {
 	struct object_id peeled;
 	struct object_entry *entry = packlist_find(&to_pack, oid);
@@ -3012,7 +3012,8 @@ static void add_tag_chain(const struct object_id *oid)
 	}
 }
 
-static int add_ref_tag(const char *tag, const struct object_id *oid, int flag, void *cb_data)
+static int add_ref_tag(const char *tag, const struct object_id *oid,
+		       unsigned int flag, void *cb_data)
 {
 	struct object_id peeled;
 
@@ -3684,8 +3685,8 @@ static void record_recent_commit(struct commit *commit, void *data)
 }
 
 static int mark_bitmap_preferred_tip(const char *refname,
-				     const struct object_id *oid, int flags,
-				     void *_data)
+				     const struct object_id *oid,
+				     unsigned int flags, void *_data)
 {
 	struct object_id peeled;
 	struct object *object;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 36490d06c8a..d92bd3b7175 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -999,7 +999,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = REBASE_OPTIONS_INIT;
 	const char *branch_name;
-	int ret, flags, total_argc, in_progress = 0;
+	int ret, total_argc, in_progress = 0;
+	unsigned int flags;
 	int keep_base = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
@@ -1668,7 +1669,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
 		    &options.orig_head, &merge_base) &&
 	    allow_preemptive_ff) {
-		int flag;
+		unsigned int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
 			/* Lazily switch to the target branch if needed... */
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816cf..82e4aae8113 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -291,7 +291,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 }
 
 static int show_ref_cb(const char *path_full, const struct object_id *oid,
-		       int flag, void *data)
+		       unsigned int flag, void *data)
 {
 	struct oidset *seen = data;
 	const char *path = strip_namespace(path_full);
@@ -1701,7 +1701,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *dst_name;
-	int flag;
+	unsigned int flag;
 
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
 	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flag);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index a4b1dd27e13..47464a7a7b9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -343,7 +343,7 @@ static int should_expire_reflog_ent_verbose(struct object_id *ooid,
 }
 
 static int push_tip_to_list(const char *refname, const struct object_id *oid,
-			    int flags, void *cb_data)
+			    unsigned int flags, void *cb_data)
 {
 	struct commit_list **list = cb_data;
 	struct commit *tip_commit;
@@ -424,7 +424,8 @@ static void reflog_expiry_cleanup(void *cb_data)
 	}
 }
 
-static int collect_reflog(const char *ref, const struct object_id *oid, int unused, void *cb_data)
+static int collect_reflog(const char *ref, const struct object_id *oid,
+			  unsigned int unused, void *cb_data)
 {
 	struct worktree_reflogs *cb = cb_data;
 	struct worktree *worktree = cb->worktree;
diff --git a/builtin/remote.c b/builtin/remote.c
index 299c466116d..4881d58c336 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -533,7 +533,8 @@ struct branches_for_remote {
 };
 
 static int add_branch_for_removal(const char *refname,
-	const struct object_id *oid, int flags, void *cb_data)
+				  const struct object_id *oid,
+				  unsigned int flags, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec_item refspec;
@@ -574,12 +575,13 @@ struct rename_info {
 };
 
 static int read_remote_branches(const char *refname,
-	const struct object_id *oid, int flags, void *cb_data)
+				const struct object_id *oid, unsigned int flags,
+				void *cb_data)
 {
 	struct rename_info *rename = cb_data;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
-	int flag;
+	unsigned int flag;
 	const char *symref;
 
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
@@ -766,7 +768,7 @@ static int mv(int argc, const char **argv)
 	for_each_ref(read_remote_branches, &rename);
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
-		int flag = 0;
+		unsigned int flag = 0;
 
 		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flag);
 		if (!(flag & REF_ISSYMREF))
@@ -923,7 +925,8 @@ static void free_remote_ref_states(struct ref_states *states)
 }
 
 static int append_ref_to_tracked_list(const char *refname,
-	const struct object_id *oid, int flags, void *cb_data)
+				      const struct object_id *oid,
+				      unsigned int flags, void *cb_data)
 {
 	struct ref_states *states = cb_data;
 	struct refspec_item refspec;
diff --git a/builtin/repack.c b/builtin/repack.c
index da1e364a756..ff6ddc0f357 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -464,8 +464,8 @@ struct midx_snapshot_ref_data {
 };
 
 static int midx_snapshot_ref_one(const char *refname,
-				 const struct object_id *oid,
-				 int flag, void *_data)
+				 const struct object_id *oid, unsigned int flag,
+				 void *_data)
 {
 	struct midx_snapshot_ref_data *data = _data;
 	struct object_id peeled;
diff --git a/builtin/replace.c b/builtin/replace.c
index 6ff1734d587..2fa39e73f0e 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -40,8 +40,8 @@ struct show_data {
 };
 
 static int show_reference(struct repository *r, const char *refname,
-			  const struct object_id *oid,
-			  int flag, void *cb_data)
+			  const struct object_id *oid, unsigned int flag,
+			  void *cb_data)
 {
 	struct show_data *data = cb_data;
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8480a59f573..b842c958f20 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -195,7 +195,8 @@ static int show_default(void)
 	return 0;
 }
 
-static int show_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int show_reference(const char *refname, const struct object_id *oid,
+			  unsigned int flag, void *cb_data)
 {
 	if (ref_excluded(ref_excludes, refname))
 		return 0;
@@ -203,7 +204,8 @@ static int show_reference(const char *refname, const struct object_id *oid, int
 	return 0;
 }
 
-static int anti_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int anti_reference(const char *refname, const struct object_id *oid,
+			  unsigned int flag, void *cb_data)
 {
 	show_rev(REVERSED, oid, refname);
 	return 0;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e12c5e80e3e..625ba0c28ce 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -403,7 +403,7 @@ static int append_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_head_ref(const char *refname, const struct object_id *oid,
-			   int flag, void *cb_data)
+			   unsigned int flag, void *cb_data)
 {
 	struct object_id tmp;
 	int ofs = 11;
@@ -418,7 +418,7 @@ static int append_head_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_remote_ref(const char *refname, const struct object_id *oid,
-			     int flag, void *cb_data)
+			     unsigned int flag, void *cb_data)
 {
 	struct object_id tmp;
 	int ofs = 13;
@@ -444,7 +444,7 @@ static const char *match_ref_pattern = NULL;
 static int match_ref_slash = 0;
 
 static int append_matching_ref(const char *refname, const struct object_id *oid,
-			       int flag, void *cb_data)
+			       unsigned int flag, void *cb_data)
 {
 	/* we want to allow pattern hold/<asterisk> to show all
 	 * branches under refs/heads/hold/, and v0.99.9? to show
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 7f8a5332f83..09b708daf5b 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -47,7 +47,7 @@ static void show_one(const char *refname, const struct object_id *oid)
 }
 
 static int show_ref(const char *refname, const struct object_id *oid,
-		    int flag, void *cbdata)
+		    unsigned int flag, void *cbdata)
 {
 	if (show_head && !strcmp(refname, "HEAD"))
 		goto match;
@@ -86,7 +86,7 @@ match:
 }
 
 static int add_existing(const char *refname, const struct object_id *oid,
-			int flag, void *cbdata)
+			unsigned int flag, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
 	string_list_insert(list, refname);
diff --git a/builtin/stash.c b/builtin/stash.c
index 86cd0b456e7..c02e014acb7 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1296,7 +1296,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 			   int quiet)
 {
 	int ret = 0;
-	int flags = 0;
+	unsigned int flags = 0;
 	int untracked_commit_option = 0;
 	const char *head_short_sha1 = NULL;
 	const char *branch_ref = NULL;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5d3fc3817f..3ffee0699a6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -738,8 +738,8 @@ static void print_status(unsigned int flags, char state, const char *path,
 }
 
 static int handle_submodule_head_ref(const char *refname,
-				     const struct object_id *oid, int flags,
-				     void *cb_data)
+				     const struct object_id *oid,
+				     unsigned int flags, void *cb_data)
 {
 	struct object_id *output = cb_data;
 	if (oid)
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index e547a08d6c7..1ad2997e979 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -12,7 +12,7 @@ static const char * const git_symbolic_ref_usage[] = {
 
 static int check_symref(const char *HEAD, int quiet, int shorten, int print)
 {
-	int flag;
+	unsigned int flag;
 	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flag);
 
 	if (!refname)
diff --git a/bundle.c b/bundle.c
index a0bb687b0f4..da4442d4f1a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -371,7 +371,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		struct object_id oid;
 		char *ref;
 		const char *display_ref;
-		int flag;
+		unsigned int flag;
 
 		if (e->item->flags & UNINTERESTING)
 			continue;
diff --git a/commit-graph.c b/commit-graph.c
index 265c010122e..1a7d1bb154d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1636,9 +1636,8 @@ struct refs_cb_data {
 	struct progress *progress;
 };
 
-static int add_ref_to_set(const char *refname,
-			  const struct object_id *oid,
-			  int flags, void *cb_data)
+static int add_ref_to_set(const char *refname, const struct object_id *oid,
+			  unsigned int flags, void *cb_data)
 {
 	struct object_id peeled;
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
diff --git a/config.c b/config.c
index 2bffa8d4a01..a4f9cf339f7 100644
--- a/config.c
+++ b/config.c
@@ -276,7 +276,7 @@ done:
 
 static int include_by_branch(const char *cond, size_t cond_len)
 {
-	int flags;
+	unsigned int flags;
 	int ret;
 	struct strbuf pattern = STRBUF_INIT;
 	const char *refname = !the_repository->gitdir ?
diff --git a/delta-islands.c b/delta-islands.c
index aa98b2e5414..dba5454ba01 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -365,7 +365,7 @@ static void add_ref_to_island(const char *island_name, const struct object_id *o
 }
 
 static int find_island_for_ref(const char *refname, const struct object_id *oid,
-			       int flags, void *data)
+			       unsigned int flags, void *data)
 {
 	/*
 	 * We should advertise 'ARRAY_SIZE(matches) - 2' as the max,
diff --git a/fetch-pack.c b/fetch-pack.c
index dd6ec449f2d..3fb3e0cbd18 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -164,8 +164,9 @@ static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 	return 0;
 }
 
-static int rev_list_insert_ref_oid(const char *refname, const struct object_id *oid,
-				   int flag, void *cb_data)
+static int rev_list_insert_ref_oid(const char *refname,
+				   const struct object_id *oid,
+				   unsigned int flag, void *cb_data)
 {
 	return rev_list_insert_ref(cb_data, oid);
 }
@@ -548,7 +549,7 @@ static int mark_complete(const struct object_id *oid)
 }
 
 static int mark_complete_oid(const char *refname, const struct object_id *oid,
-			     int flag, void *cb_data)
+			     unsigned int flag, void *cb_data)
 {
 	return mark_complete(oid);
 }
diff --git a/help.c b/help.c
index 71444906ddf..38e3def7cb6 100644
--- a/help.c
+++ b/help.c
@@ -728,7 +728,7 @@ struct similar_ref_cb {
 };
 
 static int append_similar_ref(const char *refname, const struct object_id *oid,
-			      int flags, void *cb_data)
+			      unsigned int flags, void *cb_data)
 {
 	struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
 	char *branch = strrchr(refname, '/') + 1;
diff --git a/http-backend.c b/http-backend.c
index 807fb8839e7..c8757e601d1 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -504,7 +504,7 @@ static void run_service(const char **argv, int buffer_input)
 }
 
 static int show_text_ref(const char *name, const struct object_id *oid,
-			 int flag, void *cb_data)
+			 unsigned int flag, void *cb_data)
 {
 	const char *name_nons = strip_namespace(name);
 	struct strbuf *buf = cb_data;
@@ -559,7 +559,7 @@ static void get_info_refs(struct strbuf *hdr, char *arg)
 }
 
 static int show_head_ref(const char *refname, const struct object_id *oid,
-			 int flag, void *cb_data)
+			 unsigned int flag, void *cb_data)
 {
 	struct strbuf *buf = cb_data;
 
diff --git a/log-tree.c b/log-tree.c
index d3e7a40b648..189fff841de 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -131,7 +131,7 @@ static int ref_filter_match(const char *refname,
 }
 
 static int add_ref_decoration(const char *refname, const struct object_id *oid,
-			      int flags, void *cb_data)
+			      unsigned int flags, void *cb_data)
 {
 	struct object *obj;
 	enum object_type objtype;
@@ -241,7 +241,7 @@ static const struct name_decoration *current_pointed_by_HEAD(const struct name_d
 {
 	const struct name_decoration *list, *head = NULL;
 	const char *branch_name = NULL;
-	int rru_flags;
+	unsigned int rru_flags;
 
 	/* First find HEAD */
 	for (list = decoration; list; list = list->next)
diff --git a/ls-refs.c b/ls-refs.c
index 54078323dcb..eaa43748ba5 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -76,7 +76,7 @@ struct ls_refs_data {
 };
 
 static int send_ref(const char *refname, const struct object_id *oid,
-		    int flag, void *cb_data)
+		    unsigned int flag, void *cb_data)
 {
 	struct ls_refs_data *data = cb_data;
 	const char *refname_nons = strip_namespace(refname);
@@ -122,7 +122,7 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 {
 	struct strbuf namespaced = STRBUF_INIT;
 	struct object_id oid;
-	int flag;
+	unsigned int flag;
 	int oid_is_null;
 
 	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
diff --git a/midx.c b/midx.c
index 837b46b2af5..3d3136089f9 100644
--- a/midx.c
+++ b/midx.c
@@ -922,9 +922,8 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 	}
 }
 
-static int add_ref_to_pending(const char *refname,
-			      const struct object_id *oid,
-			      int flag, void *cb_data)
+static int add_ref_to_pending(const char *refname, const struct object_id *oid,
+			      unsigned int flag, void *cb_data)
 {
 	struct rev_info *revs = (struct rev_info*)cb_data;
 	struct object *object;
diff --git a/negotiator/default.c b/negotiator/default.c
index 434189ae5dc..3f911f6b633 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -36,7 +36,7 @@ static void rev_list_push(struct negotiation_state *ns,
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
-		       int flag, void *cb_data)
+		       unsigned int flag, void *cb_data)
 {
 	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
 
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 1236e792248..0e6f72987c1 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -72,7 +72,7 @@ static struct entry *rev_list_push(struct data *data, struct commit *commit, int
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
-		       int flag, void *cb_data)
+		       unsigned int flag, void *cb_data)
 {
 	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
 
diff --git a/notes.c b/notes.c
index f87dac40684..17b4d0edb83 100644
--- a/notes.c
+++ b/notes.c
@@ -924,8 +924,9 @@ out:
 	return ret;
 }
 
-static int string_list_add_one_ref(const char *refname, const struct object_id *oid,
-				   int flag, void *cb)
+static int string_list_add_one_ref(const char *refname,
+				   const struct object_id *oid,
+				   unsigned int flag, void *cb)
 {
 	struct string_list *refs = cb;
 	if (!unsorted_string_list_has_string(refs, refname))
diff --git a/object-name.c b/object-name.c
index fdff4601b2c..b14ec59cce8 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1208,7 +1208,7 @@ struct handle_one_ref_cb {
 };
 
 static int handle_one_ref(const char *path, const struct object_id *oid,
-			  int flag, void *cb_data)
+			  unsigned int flag, void *cb_data)
 {
 	struct handle_one_ref_cb *cb = cb_data;
 	struct commit_list **list = cb->list;
diff --git a/reachable.c b/reachable.c
index 84e3d0d75ed..74e8ee81bbe 100644
--- a/reachable.c
+++ b/reachable.c
@@ -27,7 +27,7 @@ static void update_progress(struct connectivity_progress *cp)
 }
 
 static int add_one_ref(const char *path, const struct object_id *oid,
-		       int flag, void *cb_data)
+		       unsigned int flag, void *cb_data)
 {
 	struct rev_info *revs = (struct rev_info *)cb_data;
 	struct object *object;
diff --git a/ref-filter.c b/ref-filter.c
index f7a2f17bfd9..f51779bd725 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2233,7 +2233,8 @@ struct ref_filter_cbdata {
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int ref_filter_handler(const char *refname, const struct object_id *oid,
+			      unsigned int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_filter *filter = ref_cbdata->filter;
diff --git a/refs.c b/refs.c
index addb26293b4..5f29775def1 100644
--- a/refs.c
+++ b/refs.c
@@ -74,7 +74,7 @@ static unsigned char refname_disposition[256] = {
  * as an error, try to come up with a usable replacement for the input
  * refname in it.
  */
-static int check_refname_component(const char *refname, int *flags,
+static int check_refname_component(const char *refname, unsigned int *flags,
 				   struct strbuf *sanitized)
 {
 	const char *cp;
@@ -158,7 +158,7 @@ out:
 	return cp - refname;
 }
 
-static int check_or_sanitize_refname(const char *refname, int flags,
+static int check_or_sanitize_refname(const char *refname, unsigned int flags,
 				     struct strbuf *sanitized)
 {
 	int component_len, component_count = 0;
@@ -202,7 +202,7 @@ static int check_or_sanitize_refname(const char *refname, int flags,
 	return 0;
 }
 
-int check_refname_format(const char *refname, int flags)
+int check_refname_format(const char *refname, unsigned int flags)
 {
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
@@ -264,9 +264,9 @@ int ref_resolves_to_object(const char *refname,
 	return 1;
 }
 
-char *refs_resolve_refdup(struct ref_store *refs,
-			  const char *refname, int resolve_flags,
-			  struct object_id *oid, int *flags)
+char *refs_resolve_refdup(struct ref_store *refs, const char *refname,
+			  int resolve_flags, struct object_id *oid,
+			  unsigned int *flags)
 {
 	const char *result;
 	int ignore_errno;
@@ -276,8 +276,8 @@ char *refs_resolve_refdup(struct ref_store *refs,
 	return xstrdup_or_null(result);
 }
 
-char *resolve_refdup(const char *refname, int resolve_flags,
-		     struct object_id *oid, int *flags)
+char *resolve_refdup(const char *refname, unsigned int resolve_flags,
+		     struct object_id *oid, unsigned int *flags)
 {
 	return refs_resolve_refdup(get_main_ref_store(the_repository),
 				   refname, resolve_flags,
@@ -292,7 +292,8 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid, int *flags)
+int read_ref_full(const char *refname, unsigned int resolve_flags,
+		  struct object_id *oid, unsigned int *flags)
 {
 	int ignore_errno;
 	struct ref_store *refs = get_main_ref_store(the_repository);
@@ -321,7 +322,7 @@ int ref_exists(const char *refname)
 }
 
 static int filter_refs(const char *refname, const struct object_id *oid,
-			   int flags, void *data)
+		       unsigned int flags, void *data)
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
 
@@ -360,8 +361,9 @@ struct warn_if_dangling_data {
 	const char *msg_fmt;
 };
 
-static int warn_if_dangling_symref(const char *refname, const struct object_id *oid,
-				   int flags, void *cb_data)
+static int warn_if_dangling_symref(const char *refname,
+				   const struct object_id *oid,
+				   unsigned int flags, void *cb_data)
 {
 	struct warn_if_dangling_data *d = cb_data;
 	const char *resolves_to;
@@ -439,7 +441,7 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
 	struct object_id oid;
-	int flag;
+	unsigned int flag;
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
 	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flag))
@@ -654,7 +656,7 @@ int expand_ref(struct repository *repo, const char *str, int len,
 	for (p = ref_rev_parse_rules; *p; p++) {
 		struct object_id oid_from_ref;
 		struct object_id *this_result;
-		int flag;
+		unsigned int flag;
 		struct ref_store *refs = get_main_ref_store(repo);
 		int ignore_errno;
 
@@ -1389,7 +1391,7 @@ const char *find_descendant_ref(const char *dirname,
 int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
-	int flag;
+	unsigned int flag;
 	int ignore_errno;
 
 	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
@@ -1467,11 +1469,9 @@ struct do_for_each_ref_help {
 	void *cb_data;
 };
 
-static int do_for_each_ref_helper(struct repository *r,
-				  const char *refname,
+static int do_for_each_ref_helper(struct repository *r, const char *refname,
 				  const struct object_id *oid,
-				  int flags,
-				  void *cb_data)
+				  unsigned int flags, void *cb_data)
 {
 	struct do_for_each_ref_help *hp = cb_data;
 
@@ -1678,15 +1678,13 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 					   type, failure_errno);
 }
 
-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    struct object_id *oid,
-				    int *flags, int *failure_errno)
+const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
+				    int resolve_flags, struct object_id *oid,
+				    unsigned int *flags, int *failure_errno)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
-	int unused_flags;
+	unsigned int unused_flags;
 	int symref_count;
 
 	assert(failure_errno);
@@ -1782,7 +1780,7 @@ int refs_init_db(struct strbuf *err)
 }
 
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       struct object_id *oid, int *flags)
+			       struct object_id *oid, unsigned int *flags)
 {
 	int ignore_errno;
 
@@ -1794,7 +1792,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 			struct object_id *oid)
 {
 	struct ref_store *refs;
-	int flags;
+	unsigned int flags;
 	int ignore_errno;
 
 	refs = get_submodule_ref_store(submodule);
diff --git a/refs.h b/refs.h
index 8f91a7f9ff2..c5462b75807 100644
--- a/refs.h
+++ b/refs.h
@@ -68,23 +68,21 @@ struct worktree;
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 
-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    struct object_id *oid,
-				    int *flags, int *failure_errno);
+const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
+				    int resolve_flags, struct object_id *oid,
+				    unsigned int *flags, int *failure_errno);
 
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       struct object_id *oid, int *flags);
+			       struct object_id *oid, unsigned int *flags);
 
-char *refs_resolve_refdup(struct ref_store *refs,
-			  const char *refname, int resolve_flags,
-			  struct object_id *oid, int *flags);
-char *resolve_refdup(const char *refname, int resolve_flags,
-		     struct object_id *oid, int *flags);
+char *refs_resolve_refdup(struct ref_store *refs, const char *refname,
+			  int resolve_flags, struct object_id *oid,
+			  unsigned int *flags);
+char *resolve_refdup(const char *refname, unsigned int resolve_flags,
+		     struct object_id *oid, unsigned int *flags);
 
-int read_ref_full(const char *refname, int resolve_flags,
-		  struct object_id *oid, int *flags);
+int read_ref_full(const char *refname, unsigned int resolve_flags,
+		  struct object_id *oid, unsigned int *flags);
 int read_ref(const char *refname, struct object_id *oid);
 
 /*
@@ -298,17 +296,15 @@ struct ref_transaction;
  * arguments is only guaranteed to be valid for the duration of a
  * single callback invocation.
  */
-typedef int each_ref_fn(const char *refname,
-			const struct object_id *oid, int flags, void *cb_data);
+typedef int each_ref_fn(const char *refname, const struct object_id *oid,
+			unsigned int flags, void *cb_data);
 
 /*
  * The same as each_ref_fn, but also with a repository argument that
  * contains the repository associated with the callback.
  */
-typedef int each_repo_ref_fn(struct repository *r,
-			     const char *refname,
-			     const struct object_id *oid,
-			     int flags,
+typedef int each_repo_ref_fn(struct repository *r, const char *refname,
+			     const struct object_id *oid, unsigned int flags,
 			     void *cb_data);
 
 /*
@@ -532,7 +528,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data);
  * allow a single "*" wildcard character in the refspec. No leading or
  * repeated slashes are accepted.
  */
-int check_refname_format(const char *refname, int flags);
+int check_refname_format(const char *refname, unsigned int flags);
 
 /*
  * Apply the rules from check_refname_format, but mutate the result until it
@@ -896,7 +892,7 @@ struct ref_store *get_main_ref_store(struct repository *r);
  *
  * ----
  * static int handle_remote_ref(const char *refname,
- * 		const unsigned char *sha1, int flags, void *cb_data)
+ * 		const unsigned char *sha1, unsigned int flags, void *cb_data)
  * {
  * 	struct strbuf *output = cb_data;
  * 	strbuf_addf(output, "%s\n", refname);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 43a3b882d7c..181998a65bf 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -261,7 +261,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	while ((de = readdir(d)) != NULL) {
 		struct object_id oid;
 		struct stat st;
-		int flag;
+		unsigned int flag;
 
 		if (de->d_name[0] == '.')
 			continue;
@@ -1391,7 +1391,8 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
 	struct object_id orig_oid;
-	int flag = 0, logmoved = 0;
+	int logmoved = 0;
+	unsigned int flag = 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
 	struct strbuf sb_oldref = STRBUF_INIT;
@@ -1826,7 +1827,7 @@ static int commit_ref_update(struct files_ref_store *refs,
 		 * check with HEAD only which should cover 99% of all usage
 		 * scenarios (even 100% of the default ones).
 		 */
-		int head_flag;
+		unsigned int head_flag;
 		const char *head_ref;
 		int ignore_errno;
 
@@ -2159,7 +2160,7 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	int ignore_errno;
 
 	while ((ok = dir_iterator_advance(diter)) == ITER_OK) {
-		int flags;
+		unsigned int flags;
 
 		if (!S_ISREG(diter->st.st_mode))
 			continue;
@@ -2669,7 +2670,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	char *head_ref = NULL;
-	int head_type;
+	unsigned int head_type;
 	struct files_transaction_backend_data *backend_data;
 	struct ref_transaction *packed_transaction = NULL;
 
@@ -2982,8 +2983,8 @@ static int files_transaction_abort(struct ref_store *ref_store,
 	return 0;
 }
 
-static int ref_present(const char *refname,
-		       const struct object_id *oid, int flags, void *cb_data)
+static int ref_present(const char *refname, const struct object_id *oid,
+		       unsigned int flags, void *cb_data)
 {
 	struct string_list *affected_refnames = cb_data;
 
@@ -3209,7 +3210,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		if ((expire_flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 		    !is_null_oid(&cb.last_kept_oid)) {
 			int ignore_errno;
-			int type;
+			unsigned int type;
 			const char *ref;
 
 			ref = refs_resolve_ref_unsafe(&refs->base, refname,
diff --git a/remote.c b/remote.c
index a6d8ec6c1ac..9fc370b7543 100644
--- a/remote.c
+++ b/remote.c
@@ -500,7 +500,7 @@ static void alias_all_urls(struct remote_state *remote_state)
 
 static void read_config(struct repository *repo)
 {
-	int flag;
+	unsigned int flag;
 
 	if (repo->remote_state->initialized)
 		return;
@@ -1272,7 +1272,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		return -1;
 
 	if (!dst_value) {
-		int flag;
+		unsigned int flag;
 
 		dst_value = resolve_ref_unsafe(matched_src->name,
 					       RESOLVE_REF_READING,
@@ -1948,7 +1948,7 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
 
 static int ignore_symref_update(const char *refname)
 {
-	int flag;
+	unsigned int flag;
 
 	if (!resolve_ref_unsafe(refname, 0, NULL, &flag))
 		return 0; /* non-existing refs are OK */
@@ -2288,7 +2288,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 }
 
 static int one_local_ref(const char *refname, const struct object_id *oid,
-			 int flag, void *cb_data)
+			 unsigned int flag, void *cb_data)
 {
 	struct ref ***local_tail = cb_data;
 	struct ref *ref;
@@ -2369,7 +2369,7 @@ struct stale_heads_info {
 };
 
 static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
-			      int flags, void *cb_data)
+			      unsigned int flags, void *cb_data)
 {
 	struct stale_heads_info *info = cb_data;
 	struct string_list matches = STRING_LIST_INIT_DUP;
diff --git a/replace-object.c b/replace-object.c
index 7bd9aba6ee6..1a9ed348661 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -6,10 +6,9 @@
 #include "repository.h"
 #include "commit.h"
 
-static int register_replace_ref(struct repository *r,
-				const char *refname,
-				const struct object_id *oid,
-				int flag, void *cb_data)
+static int register_replace_ref(struct repository *r, const char *refname,
+				const struct object_id *oid, unsigned int flag,
+				void *cb_data)
 {
 	/* Get sha1 from refname */
 	const char *slash = strrchr(refname, '/');
diff --git a/revision.c b/revision.c
index ad4286fbdde..37bdd43f9ee 100644
--- a/revision.c
+++ b/revision.c
@@ -1527,7 +1527,7 @@ int ref_excluded(struct string_list *ref_excludes, const char *path)
 }
 
 static int handle_one_ref(const char *path, const struct object_id *oid,
-			  int flag, void *cb_data)
+			  unsigned int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	struct object *object;
@@ -1611,8 +1611,8 @@ static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 static int handle_one_reflog(const char *refname_in_wt,
-			     const struct object_id *oid,
-			     int flag, void *cb_data)
+			     const struct object_id *oid, unsigned int flag,
+			     void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	struct strbuf refname = STRBUF_INIT;
@@ -2678,7 +2678,7 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 
 static void NORETURN diagnose_missing_default(const char *def)
 {
-	int flags;
+	unsigned int flags;
 	const char *refname;
 
 	refname = resolve_ref_unsafe(def, 0, NULL, &flags);
diff --git a/server-info.c b/server-info.c
index 7701d7c20a1..78119897d30 100644
--- a/server-info.c
+++ b/server-info.c
@@ -147,7 +147,7 @@ out:
 }
 
 static int add_info_ref(const char *path, const struct object_id *oid,
-			int flag, void *cb_data)
+			unsigned int flag, void *cb_data)
 {
 	struct update_info_ctx *uic = cb_data;
 	struct object *o = parse_object(the_repository, oid);
diff --git a/shallow.c b/shallow.c
index 9ed18eb8849..eebb66961a8 100644
--- a/shallow.c
+++ b/shallow.c
@@ -596,7 +596,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 }
 
 static int mark_uninteresting(const char *refname, const struct object_id *oid,
-			      int flags, void *cb_data)
+			      unsigned int flags, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
 							       oid, 1);
@@ -707,7 +707,7 @@ struct commit_array {
 };
 
 static int add_ref(const char *refname, const struct object_id *oid,
-		   int flags, void *cb_data)
+		   unsigned int flags, void *cb_data)
 {
 	struct commit_array *ca = cb_data;
 	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
diff --git a/submodule.c b/submodule.c
index c6890705241..47227b3cae4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -909,7 +909,7 @@ static void free_submodules_oids(struct string_list *submodules)
 }
 
 static int has_remote(const char *refname, const struct object_id *oid,
-		      int flags, void *cb_data)
+		      unsigned int flags, void *cb_data)
 {
 	return 1;
 }
@@ -1216,7 +1216,7 @@ int push_unpushed_submodules(struct repository *r,
 }
 
 static int append_oid_to_array(const char *ref, const struct object_id *oid,
-			       int flags, void *data)
+			       unsigned int flags, void *data)
 {
 	struct oid_array *array = data;
 	oid_array_append(array, oid);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 3e4ddaee705..5054600e3a9 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -160,7 +160,7 @@ static int cmd_rename_ref(struct ref_store *refs, const char **argv)
 }
 
 static int each_ref(const char *refname, const struct object_id *oid,
-		    int flags, void *cb_data)
+		    unsigned int flags, void *cb_data)
 {
 	printf("%s %s 0x%x\n", oid_to_hex(oid), refname, flags);
 	return 0;
@@ -178,7 +178,7 @@ static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 	struct object_id oid = *null_oid();
 	const char *refname = notnull(*argv++, "refname");
 	int resolve_flags = arg_flags(*argv++, "resolve-flags", empty_flags);
-	int flags;
+	unsigned int flags;
 	const char *ref;
 	int ignore_errno;
 
diff --git a/transport-helper.c b/transport-helper.c
index a0297b0986c..c207103aaff 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1090,7 +1090,7 @@ static int push_refs_with_export(struct transport *transport,
 			if (strcmp(ref->name, ref->peer_ref->name)) {
 				if (!ref->deletion) {
 					const char *name;
-					int flag;
+					unsigned int flag;
 
 					/* Follow symbolic refs (mainly for HEAD). */
 					name = resolve_ref_unsafe(ref->peer_ref->name,
diff --git a/transport.c b/transport.c
index 2a3e3241545..5b6d5d29388 100644
--- a/transport.c
+++ b/transport.c
@@ -80,7 +80,7 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		const char *localname;
 		const char *tmp;
 		const char *remotename;
-		int flag = 0;
+		unsigned int flag = 0;
 		/*
 		 * Check suitability for tracking. Must be successful /
 		 * already up-to-date ref create/modify (not delete).
diff --git a/upload-pack.c b/upload-pack.c
index 8acc98741bb..cb652db4f78 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -822,7 +822,7 @@ static void send_unshallow(struct upload_pack_data *data)
 }
 
 static int check_ref(const char *refname_full, const struct object_id *oid,
-		     int flag, void *cb_data);
+		     unsigned int flag, void *cb_data);
 static void deepen(struct upload_pack_data *data, int depth)
 {
 	if (depth == INFINITE_DEPTH && !is_repository_shallow(the_repository)) {
@@ -1169,7 +1169,7 @@ static int mark_our_ref(const char *refname, const char *refname_full,
 }
 
 static int check_ref(const char *refname_full, const struct object_id *oid,
-		     int flag, void *cb_data)
+		     unsigned int flag, void *cb_data)
 {
 	const char *refname = strip_namespace(refname_full);
 
@@ -1193,7 +1193,7 @@ static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
 }
 
 static int send_ref(const char *refname, const struct object_id *oid,
-		    int flag, void *cb_data)
+		    unsigned int flag, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
@@ -1236,7 +1236,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 }
 
 static int find_symref(const char *refname, const struct object_id *oid,
-		       int flag, void *cb_data)
+		       unsigned int flag, void *cb_data)
 {
 	const char *symref_target;
 	struct string_list_item *item;
diff --git a/walker.c b/walker.c
index c5e29219795..c1b82504f51 100644
--- a/walker.c
+++ b/walker.c
@@ -216,7 +216,7 @@ static int interpret_target(struct walker *walker, char *target, struct object_i
 }
 
 static int mark_complete(const char *path, const struct object_id *oid,
-			 int flag, void *cb_data)
+			 unsigned int flag, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
 							       oid, 1);
diff --git a/worktree.c b/worktree.c
index 6f598dcfcdf..0fecabed3b4 100644
--- a/worktree.c
+++ b/worktree.c
@@ -26,7 +26,7 @@ void free_worktrees(struct worktree **worktrees)
  */
 static void add_head_info(struct worktree *wt)
 {
-	int flags;
+	unsigned int flags;
 	const char *target;
 	int ignore_errno;
 
@@ -415,7 +415,7 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
 		struct worktree *wt = worktrees[i];
 		const char *symref_target;
 		struct ref_store *refs;
-		int flags;
+		unsigned int flags;
 		int ignore_errno;
 
 		if (wt->is_bare)
@@ -562,7 +562,7 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct object_id oid;
-		int flag;
+		unsigned int flag;
 		int ignore_errno;
 
 		if (wt->is_current)

base-commit: 5d01301f2b865aa8dba1654d3f447ce9d21db0b5
-- 
gitgitgadget
