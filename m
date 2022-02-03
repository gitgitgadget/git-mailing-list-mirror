Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7368C433FE
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 14:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbiBCO1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238689AbiBCO07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 09:26:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83401C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 06:26:58 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f80-20020a1c1f53000000b0035399b8bedcso6992104wmf.0
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 06:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QxpzSqpbeqXFSbk2Mj3s3IVmarmjKXoj6iihbrVQS+M=;
        b=R+GMl3aEC2Wu7Dz1tfiwLObC6T+8oMDX85ub39n+WRHpZ8rflMnM57E675cttdFeMo
         VJo/07cvzMEMjcXREioU6xjImwy8cMAhqk2u+JzcxFBUV0MvY1d97r+XLpFRcz2P6yu3
         t6KmKCwT8n5MT7toxZgUgg3WEeFDe/Y+GXY/cFhWvd8+Jhp47rQHxY/NWwy2YcnUT0Ql
         RNH87SEoA3gLLQPtha34GA1DlNlvoSQfkd8ZxvaTuuoO2XMtIbyuI2bdnUG72g/welIJ
         tVq0dhReYhWYKSKWMguC7NJAf4AnQwkt7PPejOVOF0xBCLfBPaOl3Q2uOd2jPR/zJ9io
         aKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QxpzSqpbeqXFSbk2Mj3s3IVmarmjKXoj6iihbrVQS+M=;
        b=gqyeDiQS0fvs+Z0PaxgBFi6gIMD9Zpc1vOsKahSD1vccmr6uRLLAgFojytoeapnTTs
         snvsq1nb+L+pB4fbeevWawFQWHLsok2JNveXTtjMmKunvu4jS2lcodhxokxb0kqKyhrd
         qsNC1c2jhPIaVwhWqAIW/lgxQaKwEmLXBWDqODppaWqCX3M+6OcSL6CnnmC0nPj3psxk
         96wehiklN9ik9uJScosjNv6G+UZmKDdflKHVeE/0E1w2YACFDVH/ie1lNanEUreBXv5r
         31TIO81ZTeFkq4qxHk9jY+OpXNr+zATPCZOufruHzMtDtFSnDbUqHKV+8+IV0NyG16+X
         agFQ==
X-Gm-Message-State: AOAM530POqTBM06ULY/xaO0fL3L0/6iGD631tWVSrlGzFInx6eoKlWpf
        OC6QX52fBtNeUJ5AddrfIeBY/lFwSh0=
X-Google-Smtp-Source: ABdhPJxB1rvrM1V6Ju3VCka99i89JwO437pt2onjnZPF43fFlQ/rLSnFeE6vJPGV/CulTijEkg32VQ==
X-Received: by 2002:a7b:c944:: with SMTP id i4mr10568078wml.174.1643898416341;
        Thu, 03 Feb 2022 06:26:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6sm14248377wrd.29.2022.02.03.06.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 06:26:55 -0800 (PST)
Message-Id: <e94a923a6475f72395c84f9c3bf12b2c18f40ae0.1643898413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1210.v3.git.git.1643898412.gitgitgadget@gmail.com>
References: <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
        <pull.1210.v3.git.git.1643898412.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 14:26:52 +0000
Subject: [PATCH v3 2/2] Uniformize flag argument naming to `flags` or
 `unused_flags`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

In a couple of shadowing cases, use `ref_flags` for
clarity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 bisect.c                    |  4 ++--
 builtin/bisect--helper.c    | 10 ++++----
 builtin/checkout.c          | 23 +++++++++---------
 builtin/describe.c          |  2 +-
 builtin/fetch.c             |  4 ++--
 builtin/fsck.c              |  4 ++--
 builtin/gc.c                |  2 +-
 builtin/name-rev.c          |  2 +-
 builtin/pack-objects.c      |  4 ++--
 builtin/rebase.c            |  9 +++----
 builtin/receive-pack.c      | 13 +++++-----
 builtin/reflog.c            |  2 +-
 builtin/remote.c            | 20 ++++++++--------
 builtin/repack.c            |  4 ++--
 builtin/replace.c           |  4 ++--
 builtin/rev-parse.c         |  4 ++--
 builtin/show-branch.c       | 12 +++++-----
 builtin/show-ref.c          |  2 +-
 builtin/submodule--helper.c |  2 +-
 builtin/symbolic-ref.c      |  6 ++---
 bundle.c                    |  8 +++----
 delta-islands.c             |  2 +-
 fetch-pack.c                |  4 ++--
 http-backend.c              |  4 ++--
 log-tree.c                  |  2 +-
 ls-refs.c                   | 18 +++++++-------
 midx.c                      |  4 ++--
 negotiator/default.c        |  2 +-
 negotiator/skipping.c       |  2 +-
 notes.c                     |  2 +-
 object-name.c               |  2 +-
 reachable.c                 |  4 ++--
 ref-filter.c                |  8 +++----
 refs.c                      | 29 ++++++++++++-----------
 refs/files-backend.c        | 47 +++++++++++++++++++------------------
 remote.c                    | 26 ++++++++++----------
 replace-object.c            |  4 ++--
 revision.c                  |  6 ++---
 server-info.c               |  2 +-
 shallow.c                   |  4 ++--
 submodule.c                 |  4 ++--
 transport-helper.c          | 12 ++++++----
 transport.c                 | 10 ++++----
 upload-pack.c               | 12 +++++-----
 walker.c                    |  2 +-
 worktree.c                  |  9 ++++---
 46 files changed, 183 insertions(+), 179 deletions(-)

diff --git a/bisect.c b/bisect.c
index 44af2081987..c062209c439 100644
--- a/bisect.c
+++ b/bisect.c
@@ -441,7 +441,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 }
 
 static int register_ref(const char *refname, const struct object_id *oid,
-			unsigned int flags, void *cb_data)
+			unsigned int unused_flags, void *cb_data)
 {
 	struct strbuf good_prefix = STRBUF_INIT;
 	strbuf_addstr(&good_prefix, term_good);
@@ -1147,7 +1147,7 @@ int estimate_bisect_steps(int all)
 }
 
 static int mark_for_removal(const char *refname, const struct object_id *oid,
-			    unsigned int flag, void *cb_data)
+			    unsigned int unused_flags, void *cb_data)
 {
 	struct string_list *refs = cb_data;
 	char *ref = xstrfmt("refs/bisect%s", refname);
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e8b0c049f34..8eb4b8cc303 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -330,7 +330,7 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
 }
 
 static int mark_good(const char *refname, const struct object_id *oid,
-		     unsigned int flag, void *cb_data)
+		     unsigned int unused_flags, void *cb_data)
 {
 	int *m_good = (int *)cb_data;
 	*m_good = 0;
@@ -477,7 +477,7 @@ finish:
 }
 
 static int add_bisect_ref(const char *refname, const struct object_id *oid,
-			  unsigned int flags, void *cb)
+			  unsigned int unused_flags, void *cb)
 {
 	struct add_bisect_ref_data *data = cb;
 
@@ -618,7 +618,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 	int first_parent_only = 0;
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
 	int pathspec_pos;
-	unsigned int flags;
+	unsigned int unused_flags;
 	enum bisect_error res = BISECT_OK;
 	struct string_list revs = STRING_LIST_INIT_DUP;
 	struct string_list states = STRING_LIST_INIT_DUP;
@@ -708,7 +708,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 	/*
 	 * Verify HEAD
 	 */
-	head = resolve_ref_unsafe("HEAD", 0, &head_oid, &flags);
+	head = resolve_ref_unsafe("HEAD", 0, &head_oid, &unused_flags);
 	if (!head)
 		if (get_oid("HEAD", &head_oid))
 			return error(_("bad HEAD - I need a HEAD"));
@@ -1091,7 +1091,7 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
 }
 
 static int get_first_good(const char *refname, const struct object_id *oid,
-			  int flag, void *cb_data)
+			  unsigned int flag, void *cb_data)
 {
 	oidcpy(cb_data, oid);
 	return 1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 742c4ac2ab7..761f9ac9483 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -974,7 +974,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 static int add_pending_uninteresting_ref(const char *refname,
 					 const struct object_id *oid,
-					 unsigned int flags, void *cb_data)
+					 unsigned int unused_flags,
+					 void *cb_data)
 {
 	add_pending_oid(cb_data, refname, oid, UNINTERESTING);
 	return 0;
@@ -1084,16 +1085,16 @@ static int switch_branches(const struct checkout_opts *opts,
 	struct branch_info old_branch_info = { 0 };
 	struct object_id rev;
 	int writeout_error = 0;
-	unsigned int flag;
+	unsigned int flags;
 	int do_merge = 1;
 
 	trace2_cmd_mode("branch");
 
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
-	old_branch_info.path = resolve_refdup("HEAD", 0, &rev, &flag);
+	old_branch_info.path = resolve_refdup("HEAD", 0, &rev, &flags);
 	if (old_branch_info.path)
 		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
-	if (!(flag & REF_ISSYMREF))
+	if (!(flags & REF_ISSYMREF))
 		FREE_AND_NULL(old_branch_info.path);
 
 	if (old_branch_info.path) {
@@ -1510,20 +1511,20 @@ static int checkout_branch(struct checkout_opts *opts,
 
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
-		unsigned int flag;
-		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
-		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
+		unsigned int flags;
+		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flags);
+		if (head_ref && (!(flags & REF_ISSYMREF) ||
+				 strcmp(head_ref, new_branch_info->path)))
 			die_if_checked_out(new_branch_info->path, 1);
 		free(head_ref);
 	}
 
 	if (!new_branch_info->commit && opts->new_branch) {
 		struct object_id rev;
-		unsigned int flag;
+		unsigned int flags;
 
-		if (!read_ref_full("HEAD", 0, &rev, &flag) &&
-		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
+		if (!read_ref_full("HEAD", 0, &rev, &flags) &&
+		    (flags & REF_ISSYMREF) && is_null_oid(&rev))
 			return switch_unborn_to_new_branch(opts);
 	}
 	return switch_branches(opts, new_branch_info);
diff --git a/builtin/describe.c b/builtin/describe.c
index 5fa5b0bb424..c7b24390ca6 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -141,7 +141,7 @@ static void add_to_known_names(const char *path,
 }
 
 static int get_name(const char *path, const struct object_id *oid,
-		    unsigned int flag, void *cb_data)
+		    unsigned int unused_flags, void *cb_data)
 {
 	int is_tag = 0;
 	struct object_id peeled;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0d2eab174c4..2f341aef13a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -325,7 +325,7 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
 }
 
 static int add_one_refname(const char *refname, const struct object_id *oid,
-			   unsigned int flag, void *cbdata)
+			   unsigned int unused_flags, void *cbdata)
 {
 	struct hashmap *refname_map = cbdata;
 
@@ -1430,7 +1430,7 @@ static void set_option(struct transport *transport, const char *name, const char
 }
 
 static int add_oid(const char *refname, const struct object_id *oid,
-		   unsigned int flags, void *cb_data)
+		   unsigned int unused_flags, void *cb_data)
 {
 	struct oid_array *oids = cb_data;
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8e3f773e3dd..c52bd1843d1 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -502,7 +502,7 @@ static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid
 }
 
 static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
-			      unsigned int flag, void *cb_data)
+			      unsigned int unused_flags, void *cb_data)
 {
 	struct strbuf refname = STRBUF_INIT;
 
@@ -513,7 +513,7 @@ static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
 }
 
 static int fsck_handle_ref(const char *refname, const struct object_id *oid,
-			   unsigned int flag, void *cb_data)
+			   unsigned int unused_flags, void *cb_data)
 {
 	struct object *obj;
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 1c045962766..544aae1a7e8 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -770,7 +770,7 @@ struct cg_auto_data {
 };
 
 static int dfs_on_ref(const char *refname, const struct object_id *oid,
-		      unsigned int flags, void *cb_data)
+		      unsigned int unused_flags, void *cb_data)
 {
 	struct cg_auto_data *data = (struct cg_auto_data *)cb_data;
 	int result = 0;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 93f622331fb..a9dd2fbb22e 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -306,7 +306,7 @@ static int cmp_by_tag_and_age(const void *a_, const void *b_)
 }
 
 static int name_ref(const char *path, const struct object_id *oid,
-		    unsigned int flags, void *cb_data)
+		    unsigned int unused_flags, void *cb_data)
 {
 	struct object *o = parse_object(the_repository, oid);
 	struct name_ref_data *data = cb_data;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7af3cbf9688..a8a4907588a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -759,7 +759,7 @@ static enum write_one_status write_one(struct hashfile *f,
 }
 
 static int mark_tagged(const char *path, const struct object_id *oid,
-		       unsigned int flag, void *cb_data)
+		       unsigned int unused_flags, void *cb_data)
 {
 	struct object_id peeled;
 	struct object_entry *entry = packlist_find(&to_pack, oid);
@@ -3013,7 +3013,7 @@ static void add_tag_chain(const struct object_id *oid)
 }
 
 static int add_ref_tag(const char *tag, const struct object_id *oid,
-		       unsigned int flag, void *cb_data)
+		       unsigned int unused_flags, void *cb_data)
 {
 	struct object_id peeled;
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d4015b72610..ec131afa2cc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1025,7 +1025,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct rebase_options options = REBASE_OPTIONS_INIT;
 	const char *branch_name;
 	int ret, total_argc, in_progress = 0;
-	unsigned int flags;
 	int keep_base = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
@@ -1639,6 +1638,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	} else if (argc == 0) {
 		/* Do not need to switch branches, we are already on it. */
+		unsigned int flags;
 		options.head_name =
 			xstrdup_or_null(resolve_ref_unsafe("HEAD", 0, NULL,
 					 &flags));
@@ -1696,7 +1696,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
 		    &options.orig_head, &merge_base) &&
 	    allow_preemptive_ff) {
-		unsigned int flag;
+		unsigned int unused_flags;
 
 		if (!(options.flags & REBASE_FORCE)) {
 			/* Lazily switch to the target branch if needed... */
@@ -1709,7 +1709,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (!(options.flags & REBASE_NO_QUIET))
 				; /* be quiet */
 			else if (!strcmp(branch_name, "HEAD") &&
-				 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
+				 resolve_ref_unsafe("HEAD", 0, NULL,
+						    &unused_flags))
 				puts(_("HEAD is up to date."));
 			else
 				printf(_("Current branch %s is up to date.\n"),
@@ -1719,7 +1720,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		} else if (!(options.flags & REBASE_NO_QUIET))
 			; /* be quiet */
 		else if (!strcmp(branch_name, "HEAD") &&
-			 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
+			 resolve_ref_unsafe("HEAD", 0, NULL, &unused_flags))
 			puts(_("HEAD is up to date, rebase forced."));
 		else
 			printf(_("Current branch %s is up to date, rebase "
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b189487a17b..9ba14922352 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -291,7 +291,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 }
 
 static int show_ref_cb(const char *path_full, const struct object_id *oid,
-		       unsigned int flag, void *data)
+		       unsigned int unused_flags, void *data)
 {
 	struct oidset *seen = data;
 	const char *path = strip_namespace(path_full);
@@ -1645,12 +1645,13 @@ static void run_update_post_hook(struct command *commands)
 
 static void check_aliased_update_internal(struct command *cmd,
 					  struct string_list *list,
-					  const char *dst_name, int flag)
+					  const char *dst_name,
+					  unsigned int flags)
 {
 	struct string_list_item *item;
 	struct command *dst_cmd;
 
-	if (!(flag & REF_ISSYMREF))
+	if (!(flags & REF_ISSYMREF))
 		return;
 
 	if (!dst_name) {
@@ -1691,11 +1692,11 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *dst_name;
-	unsigned int flag;
+	unsigned int flags;
 
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
-	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flag);
-	check_aliased_update_internal(cmd, list, dst_name, flag);
+	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flags);
+	check_aliased_update_internal(cmd, list, dst_name, flags);
 	strbuf_release(&buf);
 }
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 278e895cc57..87d09c941a7 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -417,7 +417,7 @@ static void reflog_expiry_cleanup(void *cb_data)
 }
 
 static int collect_reflog(const char *ref, const struct object_id *oid,
-			  unsigned int unused, void *cb_data)
+			  unsigned int unused_flags, void *cb_data)
 {
 	struct worktree_reflogs *cb = cb_data;
 	struct worktree *worktree = cb->worktree;
diff --git a/builtin/remote.c b/builtin/remote.c
index 92ac729aeab..b95c5aa2fdf 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -534,7 +534,7 @@ struct branches_for_remote {
 
 static int add_branch_for_removal(const char *refname,
 				  const struct object_id *oid,
-				  unsigned int flags, void *cb_data)
+				  unsigned int unused_flags, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec_item refspec;
@@ -575,21 +575,21 @@ struct rename_info {
 };
 
 static int read_remote_branches(const char *refname,
-				const struct object_id *oid, unsigned int flags,
-				void *cb_data)
+				const struct object_id *oid,
+				unsigned int unused_flags, void *cb_data)
 {
 	struct rename_info *rename = cb_data;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
-	unsigned int flag;
 	const char *symref;
 
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
 	if (starts_with(refname, buf.buf)) {
+		unsigned int flags;
 		item = string_list_append(rename->remote_branches, refname);
-		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
-					    NULL, &flag);
-		if (symref && (flag & REF_ISSYMREF))
+		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING, NULL,
+					    &flags);
+		if (symref && (flags & REF_ISSYMREF))
 			item->util = xstrdup(symref);
 		else
 			item->util = NULL;
@@ -768,10 +768,10 @@ static int mv(int argc, const char **argv)
 	for_each_ref(read_remote_branches, &rename);
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
-		unsigned int flag = 0;
+		unsigned int flags = 0;
 
-		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flag);
-		if (!(flag & REF_ISSYMREF))
+		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flags);
+		if (!(flags & REF_ISSYMREF))
 			continue;
 		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
 			die(_("deleting '%s' failed"), item->string);
diff --git a/builtin/repack.c b/builtin/repack.c
index ff6ddc0f357..f995f829970 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -464,8 +464,8 @@ struct midx_snapshot_ref_data {
 };
 
 static int midx_snapshot_ref_one(const char *refname,
-				 const struct object_id *oid, unsigned int flag,
-				 void *_data)
+				 const struct object_id *oid,
+				 unsigned int unused_flag, void *_data)
 {
 	struct midx_snapshot_ref_data *data = _data;
 	struct object_id peeled;
diff --git a/builtin/replace.c b/builtin/replace.c
index 26bc9daba35..55677f4df45 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -40,8 +40,8 @@ struct show_data {
 };
 
 static int show_reference(struct repository *r, const char *refname,
-			  const struct object_id *oid, unsigned int flag,
-			  void *cb_data)
+			  const struct object_id *oid,
+			  unsigned int unused_flags, void *cb_data)
 {
 	struct show_data *data = cb_data;
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index b842c958f20..46f09c25db6 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -196,7 +196,7 @@ static int show_default(void)
 }
 
 static int show_reference(const char *refname, const struct object_id *oid,
-			  unsigned int flag, void *cb_data)
+			  unsigned int unused_flags, void *cb_data)
 {
 	if (ref_excluded(ref_excludes, refname))
 		return 0;
@@ -205,7 +205,7 @@ static int show_reference(const char *refname, const struct object_id *oid,
 }
 
 static int anti_reference(const char *refname, const struct object_id *oid,
-			  unsigned int flag, void *cb_data)
+			  unsigned int unused_flags, void *cb_data)
 {
 	show_rev(REVERSED, oid, refname);
 	return 0;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 625ba0c28ce..8c392afcd74 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -403,7 +403,7 @@ static int append_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_head_ref(const char *refname, const struct object_id *oid,
-			   unsigned int flag, void *cb_data)
+			   unsigned int unused_flags, void *cb_data)
 {
 	struct object_id tmp;
 	int ofs = 11;
@@ -418,7 +418,7 @@ static int append_head_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_remote_ref(const char *refname, const struct object_id *oid,
-			     unsigned int flag, void *cb_data)
+			     unsigned int unused_flags, void *cb_data)
 {
 	struct object_id tmp;
 	int ofs = 13;
@@ -433,7 +433,7 @@ static int append_remote_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_tag_ref(const char *refname, const struct object_id *oid,
-			  int flag, void *cb_data)
+			  int unused_flags, void *cb_data)
 {
 	if (!starts_with(refname, "refs/tags/"))
 		return 0;
@@ -444,7 +444,7 @@ static const char *match_ref_pattern = NULL;
 static int match_ref_slash = 0;
 
 static int append_matching_ref(const char *refname, const struct object_id *oid,
-			       unsigned int flag, void *cb_data)
+			       unsigned int flags, void *cb_data)
 {
 	/* we want to allow pattern hold/<asterisk> to show all
 	 * branches under refs/heads/hold/, and v0.99.9? to show
@@ -460,9 +460,9 @@ static int append_matching_ref(const char *refname, const struct object_id *oid,
 	if (wildmatch(match_ref_pattern, tail, 0))
 		return 0;
 	if (starts_with(refname, "refs/heads/"))
-		return append_head_ref(refname, oid, flag, cb_data);
+		return append_head_ref(refname, oid, flags, cb_data);
 	if (starts_with(refname, "refs/tags/"))
-		return append_tag_ref(refname, oid, flag, cb_data);
+		return append_tag_ref(refname, oid, flags, cb_data);
 	return append_ref(refname, oid, 0);
 }
 
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 09b708daf5b..ff017b1202a 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -86,7 +86,7 @@ match:
 }
 
 static int add_existing(const char *refname, const struct object_id *oid,
-			unsigned int flag, void *cbdata)
+			unsigned int unused_flags, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
 	string_list_insert(list, refname);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 320ecd04117..bbced5a3ef7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -741,7 +741,7 @@ static void print_status(unsigned int flags, char state, const char *path,
 
 static int handle_submodule_head_ref(const char *refname,
 				     const struct object_id *oid,
-				     unsigned int flags, void *cb_data)
+				     unsigned int unused_flags, void *cb_data)
 {
 	struct object_id *output = cb_data;
 	if (oid)
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 1ad2997e979..478ae36b4da 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -12,12 +12,12 @@ static const char * const git_symbolic_ref_usage[] = {
 
 static int check_symref(const char *HEAD, int quiet, int shorten, int print)
 {
-	unsigned int flag;
-	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flag);
+	unsigned int flags;
+	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flags);
 
 	if (!refname)
 		die("No such ref: %s", HEAD);
-	else if (!(flag & REF_ISSYMREF)) {
+	else if (!(flags & REF_ISSYMREF)) {
 		if (!quiet)
 			die("ref %s is not a symbolic ref", HEAD);
 		else
diff --git a/bundle.c b/bundle.c
index da4442d4f1a..a6658dab789 100644
--- a/bundle.c
+++ b/bundle.c
@@ -371,15 +371,15 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		struct object_id oid;
 		char *ref;
 		const char *display_ref;
-		unsigned int flag;
+		unsigned int flags;
 
 		if (e->item->flags & UNINTERESTING)
 			continue;
 		if (dwim_ref(e->name, strlen(e->name), &oid, &ref, 0) != 1)
 			goto skip_write_ref;
-		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flag))
-			flag = 0;
-		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
+		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flags))
+			flags = 0;
+		display_ref = (flags & REF_ISSYMREF) ? e->name : ref;
 
 		if (e->item->type == OBJ_TAG &&
 				!is_tag_in_date_range(e->item, revs)) {
diff --git a/delta-islands.c b/delta-islands.c
index dba5454ba01..b53b8dc7f4a 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -365,7 +365,7 @@ static void add_ref_to_island(const char *island_name, const struct object_id *o
 }
 
 static int find_island_for_ref(const char *refname, const struct object_id *oid,
-			       unsigned int flags, void *data)
+			       unsigned int unused_flags, void *data)
 {
 	/*
 	 * We should advertise 'ARRAY_SIZE(matches) - 2' as the max,
diff --git a/fetch-pack.c b/fetch-pack.c
index 19671a30089..43a74beeb10 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -166,7 +166,7 @@ static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 
 static int rev_list_insert_ref_oid(const char *refname,
 				   const struct object_id *oid,
-				   unsigned int flag, void *cb_data)
+				   unsigned int unused_flags, void *cb_data)
 {
 	return rev_list_insert_ref(cb_data, oid);
 }
@@ -549,7 +549,7 @@ static int mark_complete(const struct object_id *oid)
 }
 
 static int mark_complete_oid(const char *refname, const struct object_id *oid,
-			     unsigned int flag, void *cb_data)
+			     unsigned int unused_flags, void *cb_data)
 {
 	return mark_complete(oid);
 }
diff --git a/http-backend.c b/http-backend.c
index c8757e601d1..351a124333b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -559,11 +559,11 @@ static void get_info_refs(struct strbuf *hdr, char *arg)
 }
 
 static int show_head_ref(const char *refname, const struct object_id *oid,
-			 unsigned int flag, void *cb_data)
+			 unsigned int flags, void *cb_data)
 {
 	struct strbuf *buf = cb_data;
 
-	if (flag & REF_ISSYMREF) {
+	if (flags & REF_ISSYMREF) {
 		const char *target = resolve_ref_unsafe(refname,
 							RESOLVE_REF_READING,
 							NULL, NULL);
diff --git a/log-tree.c b/log-tree.c
index 555a08b45c0..0e5452b0505 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -135,7 +135,7 @@ static int ref_filter_match(const char *refname,
 }
 
 static int add_ref_decoration(const char *refname, const struct object_id *oid,
-			      unsigned int flags, void *cb_data)
+			      unsigned int unused_flags, void *cb_data)
 {
 	struct object *obj;
 	enum object_type objtype;
diff --git a/ls-refs.c b/ls-refs.c
index 42ba85b371b..26bfd49556d 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -77,7 +77,7 @@ struct ls_refs_data {
 };
 
 static int send_ref(const char *refname, const struct object_id *oid,
-		    unsigned int flag, void *cb_data)
+		    unsigned int flags, void *cb_data)
 {
 	struct ls_refs_data *data = cb_data;
 	const char *refname_nons = strip_namespace(refname);
@@ -94,11 +94,10 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		strbuf_addf(&data->buf, "%s %s", oid_to_hex(oid), refname_nons);
 	else
 		strbuf_addf(&data->buf, "unborn %s", refname_nons);
-	if (data->symrefs && flag & REF_ISSYMREF) {
+	if (data->symrefs && flags & REF_ISSYMREF) {
 		struct object_id unused;
-		const char *symref_target = resolve_ref_unsafe(refname, 0,
-							       &unused,
-							       &flag);
+		const char *symref_target =
+			resolve_ref_unsafe(refname, 0, &unused, &flags);
 
 		if (!symref_target)
 			die("'%s' is a symref but it is not?", refname);
@@ -123,16 +122,17 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 {
 	struct strbuf namespaced = STRBUF_INIT;
 	struct object_id oid;
-	unsigned int flag;
+	unsigned int flags;
 	int oid_is_null;
 
 	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
-	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag))
+	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flags))
 		return; /* bad ref */
 	oid_is_null = is_null_oid(&oid);
 	if (!oid_is_null ||
-	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
-		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
+	    (data->unborn && data->symrefs && (flags & REF_ISSYMREF)))
+		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flags,
+			 data);
 	strbuf_release(&namespaced);
 }
 
diff --git a/midx.c b/midx.c
index 41cad25e099..0adb5b0c228 100644
--- a/midx.c
+++ b/midx.c
@@ -939,12 +939,12 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 }
 
 static int add_ref_to_pending(const char *refname, const struct object_id *oid,
-			      unsigned int flag, void *cb_data)
+			      unsigned int flags, void *cb_data)
 {
 	struct rev_info *revs = (struct rev_info*)cb_data;
 	struct object *object;
 
-	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
+	if ((flags & REF_ISSYMREF) && (flags & REF_ISBROKEN)) {
 		warning("symbolic ref is dangling: %s", refname);
 		return 0;
 	}
diff --git a/negotiator/default.c b/negotiator/default.c
index 3f911f6b633..7ddc40e480b 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -36,7 +36,7 @@ static void rev_list_push(struct negotiation_state *ns,
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
-		       unsigned int flag, void *cb_data)
+		       unsigned int unused_flags, void *cb_data)
 {
 	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
 
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 0e6f72987c1..6ac6310b247 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -72,7 +72,7 @@ static struct entry *rev_list_push(struct data *data, struct commit *commit, int
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
-		       unsigned int flag, void *cb_data)
+		       unsigned int unused_flags, void *cb_data)
 {
 	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
 
diff --git a/notes.c b/notes.c
index e9638a40f0e..1b6f747baf9 100644
--- a/notes.c
+++ b/notes.c
@@ -926,7 +926,7 @@ out:
 
 static int string_list_add_one_ref(const char *refname,
 				   const struct object_id *oid,
-				   unsigned int flag, void *cb)
+				   unsigned int unused_flags, void *cb)
 {
 	struct string_list *refs = cb;
 	if (!unsorted_string_list_has_string(refs, refname))
diff --git a/object-name.c b/object-name.c
index 5561365c9a1..36820a58275 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1305,7 +1305,7 @@ struct handle_one_ref_cb {
 };
 
 static int handle_one_ref(const char *path, const struct object_id *oid,
-			  unsigned int flag, void *cb_data)
+			  unsigned int unused_flags, void *cb_data)
 {
 	struct handle_one_ref_cb *cb = cb_data;
 	struct commit_list **list = cb->list;
diff --git a/reachable.c b/reachable.c
index 74e8ee81bbe..fc04a57cbf6 100644
--- a/reachable.c
+++ b/reachable.c
@@ -27,12 +27,12 @@ static void update_progress(struct connectivity_progress *cp)
 }
 
 static int add_one_ref(const char *path, const struct object_id *oid,
-		       unsigned int flag, void *cb_data)
+		       unsigned int flags, void *cb_data)
 {
 	struct rev_info *revs = (struct rev_info *)cb_data;
 	struct object *object;
 
-	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
+	if ((flags & REF_ISSYMREF) && (flags & REF_ISBROKEN)) {
 		warning("symbolic ref is dangling: %s", path);
 		return 0;
 	}
diff --git a/ref-filter.c b/ref-filter.c
index f51779bd725..addb7a237a4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2234,7 +2234,7 @@ struct ref_filter_cbdata {
  * later object processing.
  */
 static int ref_filter_handler(const char *refname, const struct object_id *oid,
-			      unsigned int flag, void *cb_data)
+			      unsigned int flags, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_filter *filter = ref_cbdata->filter;
@@ -2242,12 +2242,12 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	struct commit *commit = NULL;
 	unsigned int kind;
 
-	if (flag & REF_BAD_NAME) {
+	if (flags & REF_BAD_NAME) {
 		warning(_("ignoring ref with broken name %s"), refname);
 		return 0;
 	}
 
-	if (flag & REF_ISBROKEN) {
+	if (flags & REF_ISBROKEN) {
 		warning(_("ignoring broken ref %s"), refname);
 		return 0;
 	}
@@ -2290,7 +2290,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 */
 	ref = ref_array_push(ref_cbdata->array, refname, oid);
 	ref->commit = commit;
-	ref->flag = flag;
+	ref->flag = flags;
 	ref->kind = kind;
 
 	return 0;
diff --git a/refs.c b/refs.c
index 2ca398b8527..a8f60fe73cb 100644
--- a/refs.c
+++ b/refs.c
@@ -438,11 +438,11 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
 	struct object_id oid;
-	unsigned int flag;
+	unsigned int flags;
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flag))
-		ret = fn(buf.buf, &oid, flag, cb_data);
+	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flags))
+		ret = fn(buf.buf, &oid, flags, cb_data);
 	strbuf_release(&buf);
 
 	return ret;
@@ -653,23 +653,24 @@ int expand_ref(struct repository *repo, const char *str, int len,
 	for (p = ref_rev_parse_rules; *p; p++) {
 		struct object_id oid_from_ref;
 		struct object_id *this_result;
-		unsigned int flag;
+		unsigned int flags;
 		struct ref_store *refs = get_main_ref_store(repo);
 
 		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
 		r = refs_resolve_ref_unsafe(refs, fullref.buf,
-					    RESOLVE_REF_READING,
-					    this_result, &flag);
+					    RESOLVE_REF_READING, this_result,
+					    &flags);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
 			if (!warn_ambiguous_refs)
 				break;
-		} else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
+		} else if ((flags & REF_ISSYMREF) &&
+			   strcmp(fullref.buf, "HEAD")) {
 			warning(_("ignoring dangling symref %s"), fullref.buf);
-		} else if ((flag & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
+		} else if ((flags & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
 			warning(_("ignoring broken ref %s"), fullref.buf);
 		}
 	}
@@ -1386,11 +1387,11 @@ const char *find_descendant_ref(const char *dirname,
 int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
-	unsigned int flag;
+	unsigned int flags;
 
-	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
-				    &oid, &flag))
-		return fn("HEAD", &oid, flag, cb_data);
+	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING, &oid,
+				    &flags))
+		return fn("HEAD", &oid, flags, cb_data);
 
 	return 0;
 }
@@ -1778,14 +1779,14 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 			struct object_id *oid)
 {
 	struct ref_store *refs;
-	unsigned int flags;
+	unsigned int unused_flags;
 
 	refs = get_submodule_ref_store(submodule);
 
 	if (!refs)
 		return -1;
 
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
+	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &unused_flags) ||
 	    is_null_oid(oid))
 		return -1;
 	return 0;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b3149ca493b..fe2e1a43e00 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -261,7 +261,6 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	while ((de = readdir(d)) != NULL) {
 		struct object_id oid;
 		struct stat st;
-		unsigned int flag;
 
 		if (de->d_name[0] == '.')
 			continue;
@@ -277,12 +276,12 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 					 create_dir_entry(dir->cache, refname.buf,
 							  refname.len));
 		} else {
-			if (!refs_resolve_ref_unsafe(&refs->base,
-						     refname.buf,
-						     RESOLVE_REF_READING,
-						     &oid, &flag)) {
+			unsigned int flags;
+			if (!refs_resolve_ref_unsafe(&refs->base, refname.buf,
+						     RESOLVE_REF_READING, &oid,
+						     &flags)) {
 				oidclr(&oid);
-				flag |= REF_ISBROKEN;
+				flags |= REF_ISBROKEN;
 			} else if (is_null_oid(&oid)) {
 				/*
 				 * It is so astronomically unlikely
@@ -292,7 +291,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 				 * file to be repo corruption
 				 * (probably due to a software bug).
 				 */
-				flag |= REF_ISBROKEN;
+				flags |= REF_ISBROKEN;
 			}
 
 			if (check_refname_format(refname.buf,
@@ -300,10 +299,10 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 				if (!refname_is_safe(refname.buf))
 					die("loose refname is dangerous: %s", refname.buf);
 				oidclr(&oid);
-				flag |= REF_BAD_NAME | REF_ISBROKEN;
+				flags |= REF_BAD_NAME | REF_ISBROKEN;
 			}
-			add_entry_to_dir(dir,
-					 create_ref_entry(refname.buf, &oid, flag));
+			add_entry_to_dir(dir, create_ref_entry(refname.buf,
+							       &oid, flags));
 		}
 		strbuf_setlen(&refname, dirnamelen);
 		strbuf_setlen(&path, path_baselen);
@@ -1400,7 +1399,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
 	struct object_id orig_oid;
 	int logmoved = 0;
-	unsigned int flag = 0;
+	unsigned int flags = 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
 	struct strbuf sb_oldref = STRBUF_INIT;
@@ -1420,13 +1419,14 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 
 	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
-				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				     &orig_oid, &flag)) {
+				     RESOLVE_REF_READING |
+					     RESOLVE_REF_NO_RECURSE,
+				     &orig_oid, &flags)) {
 		ret = error("refname %s not found", oldrefname);
 		goto out;
 	}
 
-	if (flag & REF_ISSYMREF) {
+	if (flags & REF_ISSYMREF) {
 		if (copy)
 			ret = error("refname %s is a symbolic ref, copying it is not supported",
 				    oldrefname);
@@ -1522,14 +1522,14 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto rollbacklog;
 	}
 
-	flag = log_all_ref_updates;
+	flags = log_all_ref_updates;
 	log_all_ref_updates = LOG_REFS_NONE;
 	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
 	}
-	log_all_ref_updates = flag;
+	log_all_ref_updates = flags;
 
  rollbacklog:
 	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
@@ -1710,9 +1710,10 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
 }
 
 static int files_log_ref_write(struct files_ref_store *refs,
-			       const char *refname, const struct object_id *old_oid,
+			       const char *refname,
+			       const struct object_id *old_oid,
 			       const struct object_id *new_oid, const char *msg,
-			       int flags, struct strbuf *err)
+			       unsigned int flags, struct strbuf *err)
 {
 	int logfd, result;
 
@@ -1834,13 +1835,13 @@ static int commit_ref_update(struct files_ref_store *refs,
 		 * check with HEAD only which should cover 99% of all usage
 		 * scenarios (even 100% of the default ones).
 		 */
-		unsigned int head_flag;
+		unsigned int head_flags;
 		const char *head_ref;
 
 		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
-						   RESOLVE_REF_READING,
-						   NULL, &head_flag);
-		if (head_ref && (head_flag & REF_ISSYMREF) &&
+						   RESOLVE_REF_READING, NULL,
+						   &head_flags);
+		if (head_ref && (head_flags & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
 			if (files_log_ref_write(refs, "HEAD",
@@ -2984,7 +2985,7 @@ static int files_transaction_abort(struct ref_store *ref_store,
 }
 
 static int ref_present(const char *refname, const struct object_id *oid,
-		       unsigned int flags, void *cb_data)
+		       unsigned int unused_flags, void *cb_data)
 {
 	struct string_list *affected_refnames = cb_data;
 
diff --git a/remote.c b/remote.c
index ff21b77f643..402ec7d9472 100644
--- a/remote.c
+++ b/remote.c
@@ -500,7 +500,7 @@ static void alias_all_urls(struct remote_state *remote_state)
 
 static void read_config(struct repository *repo)
 {
-	unsigned int flag;
+	unsigned int flags;
 
 	if (repo->remote_state->initialized)
 		return;
@@ -509,8 +509,8 @@ static void read_config(struct repository *repo)
 	repo->remote_state->current_branch = NULL;
 	if (startup_info->have_repository) {
 		const char *head_ref = refs_resolve_ref_unsafe(
-			get_main_ref_store(repo), "HEAD", 0, NULL, &flag);
-		if (head_ref && (flag & REF_ISSYMREF) &&
+			get_main_ref_store(repo), "HEAD", 0, NULL, &flags);
+		if (head_ref && (flags & REF_ISSYMREF) &&
 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
 			repo->remote_state->current_branch = make_branch(
 				repo->remote_state, head_ref, strlen(head_ref));
@@ -1271,14 +1271,12 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		return -1;
 
 	if (!dst_value) {
-		unsigned int flag;
-
-		dst_value = resolve_ref_unsafe(matched_src->name,
-					       RESOLVE_REF_READING,
-					       NULL, &flag);
-		if (!dst_value ||
-		    ((flag & REF_ISSYMREF) &&
-		     !starts_with(dst_value, "refs/heads/")))
+		unsigned int flags;
+
+		dst_value = resolve_ref_unsafe(
+			matched_src->name, RESOLVE_REF_READING, NULL, &flags);
+		if (!dst_value || ((flags & REF_ISSYMREF) &&
+				   !starts_with(dst_value, "refs/heads/")))
 			die(_("%s cannot be resolved to branch"),
 			    matched_src->name);
 	}
@@ -1947,11 +1945,11 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
 
 static int ignore_symref_update(const char *refname)
 {
-	unsigned int flag;
+	unsigned int flags;
 
-	if (!resolve_ref_unsafe(refname, 0, NULL, &flag))
+	if (!resolve_ref_unsafe(refname, 0, NULL, &flags))
 		return 0; /* non-existing refs are OK */
-	return (flag & REF_ISSYMREF);
+	return (flags & REF_ISSYMREF);
 }
 
 /*
diff --git a/replace-object.c b/replace-object.c
index 1a9ed348661..d00486305a5 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -7,8 +7,8 @@
 #include "commit.h"
 
 static int register_replace_ref(struct repository *r, const char *refname,
-				const struct object_id *oid, unsigned int flag,
-				void *cb_data)
+				const struct object_id *oid,
+				unsigned int unused_flags, void *cb_data)
 {
 	/* Get sha1 from refname */
 	const char *slash = strrchr(refname, '/');
diff --git a/revision.c b/revision.c
index ccdb069af1a..80984f583de 100644
--- a/revision.c
+++ b/revision.c
@@ -1535,7 +1535,7 @@ int ref_excluded(struct string_list *ref_excludes, const char *path)
 }
 
 static int handle_one_ref(const char *path, const struct object_id *oid,
-			  unsigned int flag, void *cb_data)
+			  unsigned int unused_flags, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	struct object *object;
@@ -1619,8 +1619,8 @@ static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 static int handle_one_reflog(const char *refname_in_wt,
-			     const struct object_id *oid, unsigned int flag,
-			     void *cb_data)
+			     const struct object_id *oid,
+			     unsigned int unused_flags, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	struct strbuf refname = STRBUF_INIT;
diff --git a/server-info.c b/server-info.c
index 78119897d30..06e3eb388ea 100644
--- a/server-info.c
+++ b/server-info.c
@@ -147,7 +147,7 @@ out:
 }
 
 static int add_info_ref(const char *path, const struct object_id *oid,
-			unsigned int flag, void *cb_data)
+			unsigned int unused_flags, void *cb_data)
 {
 	struct update_info_ctx *uic = cb_data;
 	struct object *o = parse_object(the_repository, oid);
diff --git a/shallow.c b/shallow.c
index da9f1e28e93..189cfa4d90a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -596,7 +596,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 }
 
 static int mark_uninteresting(const char *refname, const struct object_id *oid,
-			      unsigned int flags, void *cb_data)
+			      unsigned int unused_flags, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
 							       oid, 1);
@@ -707,7 +707,7 @@ struct commit_array {
 };
 
 static int add_ref(const char *refname, const struct object_id *oid,
-		   unsigned int flags, void *cb_data)
+		   unsigned int unused_flags, void *cb_data)
 {
 	struct commit_array *ca = cb_data;
 	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
diff --git a/submodule.c b/submodule.c
index e5c5d9aa6be..fac2bee0bec 100644
--- a/submodule.c
+++ b/submodule.c
@@ -916,7 +916,7 @@ static void free_submodules_oids(struct string_list *submodules)
 }
 
 static int has_remote(const char *refname, const struct object_id *oid,
-		      unsigned int flags, void *cb_data)
+		      unsigned int unused_flags, void *cb_data)
 {
 	return 1;
 }
@@ -1223,7 +1223,7 @@ int push_unpushed_submodules(struct repository *r,
 }
 
 static int append_oid_to_array(const char *ref, const struct object_id *oid,
-			       unsigned int flags, void *data)
+			       unsigned int unused_flags, void *data)
 {
 	struct oid_array *array = data;
 	oid_array_append(array, oid);
diff --git a/transport-helper.c b/transport-helper.c
index c207103aaff..b31c1198b8e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1090,13 +1090,15 @@ static int push_refs_with_export(struct transport *transport,
 			if (strcmp(ref->name, ref->peer_ref->name)) {
 				if (!ref->deletion) {
 					const char *name;
-					unsigned int flag;
+					unsigned int ref_flags;
 
 					/* Follow symbolic refs (mainly for HEAD). */
-					name = resolve_ref_unsafe(ref->peer_ref->name,
-								  RESOLVE_REF_READING,
-								  &oid, &flag);
-					if (!name || !(flag & REF_ISSYMREF))
+					name = resolve_ref_unsafe(
+						ref->peer_ref->name,
+						RESOLVE_REF_READING, &oid,
+						&ref_flags);
+					if (!name ||
+					    !(ref_flags & REF_ISSYMREF))
 						name = ref->peer_ref->name;
 
 					strbuf_addf(&buf, "%s:%s", name, ref->name);
diff --git a/transport.c b/transport.c
index 5b6d5d29388..00f4906e12b 100644
--- a/transport.c
+++ b/transport.c
@@ -80,7 +80,7 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		const char *localname;
 		const char *tmp;
 		const char *remotename;
-		unsigned int flag = 0;
+		unsigned int ref_flags = 0;
 		/*
 		 * Check suitability for tracking. Must be successful /
 		 * already up-to-date ref create/modify (not delete).
@@ -96,10 +96,10 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		/* Follow symbolic refs (mainly for HEAD). */
 		localname = ref->peer_ref->name;
 		remotename = ref->name;
-		tmp = resolve_ref_unsafe(localname, RESOLVE_REF_READING,
-					 NULL, &flag);
-		if (tmp && flag & REF_ISSYMREF &&
-			starts_with(tmp, "refs/heads/"))
+		tmp = resolve_ref_unsafe(localname, RESOLVE_REF_READING, NULL,
+					 &ref_flags);
+		if (tmp && ref_flags & REF_ISSYMREF &&
+		    starts_with(tmp, "refs/heads/"))
 			localname = tmp;
 
 		/* Both source and destination must be local branches. */
diff --git a/upload-pack.c b/upload-pack.c
index cb652db4f78..6300af75f20 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1169,7 +1169,7 @@ static int mark_our_ref(const char *refname, const char *refname_full,
 }
 
 static int check_ref(const char *refname_full, const struct object_id *oid,
-		     unsigned int flag, void *cb_data)
+		     unsigned int unused_flags, void *cb_data)
 {
 	const char *refname = strip_namespace(refname_full);
 
@@ -1193,7 +1193,7 @@ static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
 }
 
 static int send_ref(const char *refname, const struct object_id *oid,
-		    unsigned int flag, void *cb_data)
+		    unsigned int unused_flags, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
@@ -1236,15 +1236,15 @@ static int send_ref(const char *refname, const struct object_id *oid,
 }
 
 static int find_symref(const char *refname, const struct object_id *oid,
-		       unsigned int flag, void *cb_data)
+		       unsigned int flags, void *cb_data)
 {
 	const char *symref_target;
 	struct string_list_item *item;
 
-	if ((flag & REF_ISSYMREF) == 0)
+	if ((flags & REF_ISSYMREF) == 0)
 		return 0;
-	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flag);
-	if (!symref_target || (flag & REF_ISSYMREF) == 0)
+	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flags);
+	if (!symref_target || (flags & REF_ISSYMREF) == 0)
 		die("'%s' is a symref but it is not?", refname);
 	item = string_list_append(cb_data, strip_namespace(refname));
 	item->util = xstrdup(strip_namespace(symref_target));
diff --git a/walker.c b/walker.c
index c1b82504f51..af8ce53a15b 100644
--- a/walker.c
+++ b/walker.c
@@ -216,7 +216,7 @@ static int interpret_target(struct walker *walker, char *target, struct object_i
 }
 
 static int mark_complete(const char *path, const struct object_id *oid,
-			 unsigned int flag, void *cb_data)
+			 unsigned int unused_flags, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
 							       oid, 1);
diff --git a/worktree.c b/worktree.c
index 58c958e055a..69291ce4985 100644
--- a/worktree.c
+++ b/worktree.c
@@ -559,7 +559,7 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct object_id oid;
-		unsigned int flag;
+		unsigned int flags;
 
 		if (wt->is_current)
 			continue;
@@ -567,10 +567,9 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 		strbuf_reset(&refname);
 		strbuf_worktree_ref(wt, &refname, "HEAD");
 		if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-					    refname.buf,
-					    RESOLVE_REF_READING,
-					    &oid, &flag))
-			ret = fn(refname.buf, &oid, flag, cb_data);
+					    refname.buf, RESOLVE_REF_READING,
+					    &oid, &flags))
+			ret = fn(refname.buf, &oid, flags, cb_data);
 		if (ret)
 			break;
 	}
-- 
gitgitgadget
