Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31570C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 12:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbiBAMrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 07:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbiBAMrC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 07:47:02 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A7C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 04:47:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e2so31881813wra.2
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 04:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g+zyNLqTzeA5N60mOePFW7X3EX3gkVPd0mPsLE9hJW8=;
        b=Z6sS4SwHfmzZK3TCKO0gFncoNB3Ll9wbyn0flIcdHyQR8/sQphkaM6AzZO+W7IiRf9
         B321nlTJN7CPoXyX23xHUPWK2uYB/AkLogEkp5eT2ynn095Sy7oMMSbQZYRwg2FAIPiA
         vpHINqaVXnjfHBRN91ag7iTMjgUF4/D4jiNDCFyQnVoILz1fu5Fz2PG5+AoORa0WM6zV
         0STerss3nGq+0+YTP4Bk3pInMN1gfttseRfvoSQvcNZNA9CPoYG2f7tLieVU6DTtgG66
         WqXvFYU7oi7/fNymqMhcZhq2z4rMfd+AhI+lL2gU4hfy3gWIY7aAxKRmC3s33umZ7UtB
         8K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g+zyNLqTzeA5N60mOePFW7X3EX3gkVPd0mPsLE9hJW8=;
        b=TH1d5wV4BluXWduWV8QSyrjlTvI3RoY5w/tPkLiOlhCWkn3/2N5CTHZwYEcyT5LMY3
         zcrHzE3T0n2QBRYJbqH0cBEuSxlB3lXZJ6RB5rqAHXbl/Fot5y2XsFsJolLfeNb1rBbw
         wSms3TO6gaJB92fH412x/2goIAr0auevlRKvoOO6PmXjhBVTzdx6WWT3uVZFuEOuCIa9
         wWZOdXHiawujYEag+HEnFZaWu9Xw00TypVPfyiZlYsF2cRTVz1m8e9hHE3DiLvcop7aH
         G2xHpWL1z9LxQilno07SVZi6LxsrmtcsOy43xt4fIC92xd34Yz9UVPT5FjXFZld1rTWE
         3Rzg==
X-Gm-Message-State: AOAM531aijOMkgutBZ4dMqNhOl7kPbAw23eFgOh9IDb9RPuZtYiBBByS
        7O9DTDR8L8b5eWSfpzR7oOOTVn6FPjY=
X-Google-Smtp-Source: ABdhPJzxXxCmWA81UweeUF0GhLv+BlTjWHOZ+pS4FfthUAgMrqfc9bXCJCveD/yoBk8kcLkvlXPHhQ==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr21245449wri.29.1643719618391;
        Tue, 01 Feb 2022 04:46:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a24sm1930193wmm.31.2022.02.01.04.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 04:46:57 -0800 (PST)
Message-Id: <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
In-Reply-To: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 12:46:56 +0000
Subject: [PATCH v2] refs.h: make all flags arguments unsigned
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

As discussed in
https://lore.kernel.org/git/xmqqbkzrkevo.fsf@gitster.g/ , we don't
want to treat the sign bit specially, so make all flags in refs.h
unsigned.

For uniformity, rename all variables to `flags` or `unused_flags`,
from `flag`. In a couple of shadowing cases, use `ref_flags` for
clarity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs.h: make all flags arguments unsigned
    
    v2:
    
     * vet call sites.
     * uniform naming.
     * make resolve_flags unsigned too
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1210%2Fhanwen%2Funsigned-flags-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1210/hanwen/unsigned-flags-v2
Pull-Request: https://github.com/git/git/pull/1210

Range-diff vs v1:

 1:  c1dc792bd0d ! 1:  216006057b7 refs.h: make all flags arguments unsigned
     @@ Commit message
          want to treat the sign bit specially, so make all flags in refs.h
          unsigned.
      
     +    For uniformity, rename all variables to `flags` or `unused_flags`,
     +    from `flag`. In a couple of shadowing cases, use `ref_flags` for
     +    clarity.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## bisect.c ##
     @@ bisect.c: void find_bisection(struct commit_list **commit_list, int *reaches,
       
       static int register_ref(const char *refname, const struct object_id *oid,
      -			int flags, void *cb_data)
     -+			unsigned int flags, void *cb_data)
     ++			unsigned int unused_flags, void *cb_data)
       {
       	struct strbuf good_prefix = STRBUF_INIT;
       	strbuf_addstr(&good_prefix, term_good);
     @@ bisect.c: int estimate_bisect_steps(int all)
       
       static int mark_for_removal(const char *refname, const struct object_id *oid,
      -			    int flag, void *cb_data)
     -+			    unsigned int flag, void *cb_data)
     ++			    unsigned int unused_flags, void *cb_data)
       {
       	struct string_list *refs = cb_data;
       	char *ref = xstrfmt("refs/bisect%s", refname);
     @@ builtin/bisect--helper.c: static int check_and_set_terms(struct bisect_terms *te
       
       static int mark_good(const char *refname, const struct object_id *oid,
      -		     int flag, void *cb_data)
     -+		     unsigned int flag, void *cb_data)
     ++		     unsigned int unused_flags, void *cb_data)
       {
       	int *m_good = (int *)cb_data;
       	*m_good = 0;
     @@ builtin/bisect--helper.c: finish:
       
       static int add_bisect_ref(const char *refname, const struct object_id *oid,
      -			  int flags, void *cb)
     -+			  unsigned int flags, void *cb)
     ++			  unsigned int unused_flags, void *cb)
       {
       	struct add_bisect_ref_data *data = cb;
       
     @@ builtin/bisect--helper.c: static enum bisect_error bisect_start(struct bisect_te
       	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
      -	int flags, pathspec_pos;
      +	int pathspec_pos;
     -+	unsigned int flags;
     ++	unsigned int unused_flags;
       	enum bisect_error res = BISECT_OK;
       	struct string_list revs = STRING_LIST_INIT_DUP;
       	struct string_list states = STRING_LIST_INIT_DUP;
     +@@ builtin/bisect--helper.c: static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
     + 	/*
     + 	 * Verify HEAD
     + 	 */
     +-	head = resolve_ref_unsafe("HEAD", 0, &head_oid, &flags);
     ++	head = resolve_ref_unsafe("HEAD", 0, &head_oid, &unused_flags);
     + 	if (!head)
     + 		if (get_oid("HEAD", &head_oid))
     + 			return error(_("bad HEAD - I need a HEAD"));
      
       ## builtin/branch.c ##
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     @@ builtin/checkout.c: static void update_refs_for_switch(const struct checkout_opt
       static int add_pending_uninteresting_ref(const char *refname,
       					 const struct object_id *oid,
      -					 int flags, void *cb_data)
     -+					 unsigned int flags, void *cb_data)
     ++					 unsigned int unused_flags,
     ++					 void *cb_data)
       {
       	add_pending_oid(cb_data, refname, oid, UNINTERESTING);
       	return 0;
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	struct object_id rev;
      -	int flag, writeout_error = 0;
      +	int writeout_error = 0;
     -+	unsigned int flag;
     ++	unsigned int flags;
       	int do_merge = 1;
       
       	trace2_cmd_mode("branch");
     + 
     + 	memset(&old_branch_info, 0, sizeof(old_branch_info));
     +-	old_branch_info.path = resolve_refdup("HEAD", 0, &rev, &flag);
     ++	old_branch_info.path = resolve_refdup("HEAD", 0, &rev, &flags);
     + 	if (old_branch_info.path)
     + 		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
     +-	if (!(flag & REF_ISSYMREF))
     ++	if (!(flags & REF_ISSYMREF))
     + 		FREE_AND_NULL(old_branch_info.path);
     + 
     + 	if (old_branch_info.path) {
      @@ builtin/checkout.c: static int checkout_branch(struct checkout_opts *opts,
       
       	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
       	    !opts->ignore_other_worktrees) {
      -		int flag;
     -+		unsigned int flag;
     - 		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
     - 		if (head_ref &&
     - 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
     -@@ builtin/checkout.c: static int checkout_branch(struct checkout_opts *opts,
     +-		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
     +-		if (head_ref &&
     +-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
     ++		unsigned int flags;
     ++		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flags);
     ++		if (head_ref && (!(flags & REF_ISSYMREF) ||
     ++				 strcmp(head_ref, new_branch_info->path)))
     + 			die_if_checked_out(new_branch_info->path, 1);
     + 		free(head_ref);
     + 	}
       
       	if (!new_branch_info->commit && opts->new_branch) {
       		struct object_id rev;
      -		int flag;
     -+		unsigned int flag;
     ++		unsigned int flags;
       
     - 		if (!read_ref_full("HEAD", 0, &rev, &flag) &&
     - 		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
     +-		if (!read_ref_full("HEAD", 0, &rev, &flag) &&
     +-		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
     ++		if (!read_ref_full("HEAD", 0, &rev, &flags) &&
     ++		    (flags & REF_ISSYMREF) && is_null_oid(&rev))
     + 			return switch_unborn_to_new_branch(opts);
     + 	}
     + 	return switch_branches(opts, new_branch_info);
      
       ## builtin/describe.c ##
      @@ builtin/describe.c: static void add_to_known_names(const char *path,
     @@ builtin/describe.c: static void add_to_known_names(const char *path,
       
      -static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
      +static int get_name(const char *path, const struct object_id *oid,
     -+		    unsigned int flag, void *cb_data)
     ++		    unsigned int unused_flags, void *cb_data)
       {
       	int is_tag = 0;
       	struct object_id peeled;
     @@ builtin/fetch.c: static struct refname_hash_entry *refname_hash_add(struct hashm
      -			   const struct object_id *oid,
      -			   int flag, void *cbdata)
      +static int add_one_refname(const char *refname, const struct object_id *oid,
     -+			   unsigned int flag, void *cbdata)
     ++			   unsigned int unused_flags, void *cbdata)
       {
       	struct hashmap *refname_map = cbdata;
       
     @@ builtin/fetch.c: static void set_option(struct transport *transport, const char
      -static int add_oid(const char *refname, const struct object_id *oid, int flags,
      -		   void *cb_data)
      +static int add_oid(const char *refname, const struct object_id *oid,
     -+		   unsigned int flags, void *cb_data)
     ++		   unsigned int unused_flags, void *cb_data)
       {
       	struct oid_array *oids = cb_data;
       
     @@ builtin/fsck.c: static int fsck_handle_reflog_ent(struct object_id *ooid, struct
       
       static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
      -			      int flag, void *cb_data)
     -+			      unsigned int flag, void *cb_data)
     ++			      unsigned int unused_flags, void *cb_data)
       {
       	struct strbuf refname = STRBUF_INIT;
       
     @@ builtin/fsck.c: static int fsck_handle_reflog(const char *logname, const struct
       
       static int fsck_handle_ref(const char *refname, const struct object_id *oid,
      -			   int flag, void *cb_data)
     -+			   unsigned int flag, void *cb_data)
     ++			   unsigned int unused_flags, void *cb_data)
       {
       	struct object *obj;
       
     @@ builtin/gc.c: struct cg_auto_data {
      -		      const struct object_id *oid, int flags,
      -		      void *cb_data)
      +static int dfs_on_ref(const char *refname, const struct object_id *oid,
     -+		      unsigned int flags, void *cb_data)
     ++		      unsigned int unused_flags, void *cb_data)
       {
       	struct cg_auto_data *data = (struct cg_auto_data *)cb_data;
       	int result = 0;
     @@ builtin/name-rev.c: static int cmp_by_tag_and_age(const void *a_, const void *b_
       
      -static int name_ref(const char *path, const struct object_id *oid, int flags, void *cb_data)
      +static int name_ref(const char *path, const struct object_id *oid,
     -+		    unsigned int flags, void *cb_data)
     ++		    unsigned int unused_flags, void *cb_data)
       {
       	struct object *o = parse_object(the_repository, oid);
       	struct name_ref_data *data = cb_data;
     @@ builtin/pack-objects.c: static enum write_one_status write_one(struct hashfile *
      -static int mark_tagged(const char *path, const struct object_id *oid, int flag,
      -		       void *cb_data)
      +static int mark_tagged(const char *path, const struct object_id *oid,
     -+		       unsigned int flag, void *cb_data)
     ++		       unsigned int unused_flags, void *cb_data)
       {
       	struct object_id peeled;
       	struct object_entry *entry = packlist_find(&to_pack, oid);
     @@ builtin/pack-objects.c: static void add_tag_chain(const struct object_id *oid)
       
      -static int add_ref_tag(const char *tag, const struct object_id *oid, int flag, void *cb_data)
      +static int add_ref_tag(const char *tag, const struct object_id *oid,
     -+		       unsigned int flag, void *cb_data)
     ++		       unsigned int unused_flags, void *cb_data)
       {
       	struct object_id peeled;
       
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       	const char *branch_name;
      -	int ret, flags, total_argc, in_progress = 0;
      +	int ret, total_argc, in_progress = 0;
     -+	unsigned int flags;
       	int keep_base = 0;
       	int ok_to_skip_pre_rebase = 0;
       	struct strbuf msg = STRBUF_INIT;
     +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 		}
     + 	} else if (argc == 0) {
     + 		/* Do not need to switch branches, we are already on it. */
     ++		unsigned int flags;
     + 		options.head_name =
     + 			xstrdup_or_null(resolve_ref_unsafe("HEAD", 0, NULL,
     + 					 &flags));
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
       		    &options.orig_head, &merge_base) &&
       	    allow_preemptive_ff) {
      -		int flag;
     -+		unsigned int flag;
     ++		unsigned int unused_flags;
       
       		if (!(options.flags & REBASE_FORCE)) {
       			/* Lazily switch to the target branch if needed... */
     +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 			if (!(options.flags & REBASE_NO_QUIET))
     + 				; /* be quiet */
     + 			else if (!strcmp(branch_name, "HEAD") &&
     +-				 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
     ++				 resolve_ref_unsafe("HEAD", 0, NULL,
     ++						    &unused_flags))
     + 				puts(_("HEAD is up to date."));
     + 			else
     + 				printf(_("Current branch %s is up to date.\n"),
     +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 		} else if (!(options.flags & REBASE_NO_QUIET))
     + 			; /* be quiet */
     + 		else if (!strcmp(branch_name, "HEAD") &&
     +-			 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
     ++			 resolve_ref_unsafe("HEAD", 0, NULL, &unused_flags))
     + 			puts(_("HEAD is up to date, rebase forced."));
     + 		else
     + 			printf(_("Current branch %s is up to date, rebase "
      
       ## builtin/receive-pack.c ##
      @@ builtin/receive-pack.c: static void show_ref(const char *path, const struct object_id *oid)
     @@ builtin/receive-pack.c: static void show_ref(const char *path, const struct obje
       
       static int show_ref_cb(const char *path_full, const struct object_id *oid,
      -		       int flag, void *data)
     -+		       unsigned int flag, void *data)
     ++		       unsigned int unused_flags, void *data)
       {
       	struct oidset *seen = data;
       	const char *path = strip_namespace(path_full);
     +@@ builtin/receive-pack.c: static void run_update_post_hook(struct command *commands)
     + 
     + static void check_aliased_update_internal(struct command *cmd,
     + 					  struct string_list *list,
     +-					  const char *dst_name, int flag)
     ++					  const char *dst_name,
     ++					  unsigned int flags)
     + {
     + 	struct string_list_item *item;
     + 	struct command *dst_cmd;
     + 
     +-	if (!(flag & REF_ISSYMREF))
     ++	if (!(flags & REF_ISSYMREF))
     + 		return;
     + 
     + 	if (!dst_name) {
      @@ builtin/receive-pack.c: static void check_aliased_update(struct command *cmd, struct string_list *list)
       {
       	struct strbuf buf = STRBUF_INIT;
       	const char *dst_name;
      -	int flag;
     -+	unsigned int flag;
     ++	unsigned int flags;
       
       	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
     - 	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flag);
     +-	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flag);
     +-	check_aliased_update_internal(cmd, list, dst_name, flag);
     ++	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flags);
     ++	check_aliased_update_internal(cmd, list, dst_name, flags);
     + 	strbuf_release(&buf);
     + }
     + 
      
       ## builtin/reflog.c ##
      @@ builtin/reflog.c: static int should_expire_reflog_ent_verbose(struct object_id *ooid,
     @@ builtin/reflog.c: static void reflog_expiry_cleanup(void *cb_data)
       
      -static int collect_reflog(const char *ref, const struct object_id *oid, int unused, void *cb_data)
      +static int collect_reflog(const char *ref, const struct object_id *oid,
     -+			  unsigned int unused, void *cb_data)
     ++			  unsigned int unused_flags, void *cb_data)
       {
       	struct worktree_reflogs *cb = cb_data;
       	struct worktree *worktree = cb->worktree;
     @@ builtin/remote.c: struct branches_for_remote {
       static int add_branch_for_removal(const char *refname,
      -	const struct object_id *oid, int flags, void *cb_data)
      +				  const struct object_id *oid,
     -+				  unsigned int flags, void *cb_data)
     ++				  unsigned int unused_flags, void *cb_data)
       {
       	struct branches_for_remote *branches = cb_data;
       	struct refspec_item refspec;
     @@ builtin/remote.c: struct rename_info {
       
       static int read_remote_branches(const char *refname,
      -	const struct object_id *oid, int flags, void *cb_data)
     -+				const struct object_id *oid, unsigned int flags,
     -+				void *cb_data)
     ++				const struct object_id *oid,
     ++				unsigned int unused_flags, void *cb_data)
       {
       	struct rename_info *rename = cb_data;
       	struct strbuf buf = STRBUF_INIT;
       	struct string_list_item *item;
      -	int flag;
     -+	unsigned int flag;
       	const char *symref;
       
       	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
     + 	if (starts_with(refname, buf.buf)) {
     ++		unsigned int flags;
     + 		item = string_list_append(rename->remote_branches, refname);
     +-		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
     +-					    NULL, &flag);
     +-		if (symref && (flag & REF_ISSYMREF))
     ++		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING, NULL,
     ++					    &flags);
     ++		if (symref && (flags & REF_ISSYMREF))
     + 			item->util = xstrdup(symref);
     + 		else
     + 			item->util = NULL;
      @@ builtin/remote.c: static int mv(int argc, const char **argv)
       	for_each_ref(read_remote_branches, &rename);
       	for (i = 0; i < remote_branches.nr; i++) {
       		struct string_list_item *item = remote_branches.items + i;
      -		int flag = 0;
     -+		unsigned int flag = 0;
     ++		unsigned int flags = 0;
       
     - 		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flag);
     - 		if (!(flag & REF_ISSYMREF))
     +-		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flag);
     +-		if (!(flag & REF_ISSYMREF))
     ++		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flags);
     ++		if (!(flags & REF_ISSYMREF))
     + 			continue;
     + 		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
     + 			die(_("deleting '%s' failed"), item->string);
      @@ builtin/remote.c: static void free_remote_ref_states(struct ref_states *states)
       }
       
     @@ builtin/remote.c: static void free_remote_ref_states(struct ref_states *states)
      
       ## builtin/repack.c ##
      @@ builtin/repack.c: struct midx_snapshot_ref_data {
     - };
       
       static int midx_snapshot_ref_one(const char *refname,
     --				 const struct object_id *oid,
     + 				 const struct object_id *oid,
      -				 int flag, void *_data)
     -+				 const struct object_id *oid, unsigned int flag,
     -+				 void *_data)
     ++				 unsigned int unused_flag, void *_data)
       {
       	struct midx_snapshot_ref_data *data = _data;
       	struct object_id peeled;
      
       ## builtin/replace.c ##
      @@ builtin/replace.c: struct show_data {
     - };
       
       static int show_reference(struct repository *r, const char *refname,
     --			  const struct object_id *oid,
     + 			  const struct object_id *oid,
      -			  int flag, void *cb_data)
     -+			  const struct object_id *oid, unsigned int flag,
     -+			  void *cb_data)
     ++			  unsigned int unused_flags, void *cb_data)
       {
       	struct show_data *data = cb_data;
       
     @@ builtin/rev-parse.c: static int show_default(void)
       
      -static int show_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
      +static int show_reference(const char *refname, const struct object_id *oid,
     -+			  unsigned int flag, void *cb_data)
     ++			  unsigned int unused_flags, void *cb_data)
       {
       	if (ref_excluded(ref_excludes, refname))
       		return 0;
     @@ builtin/rev-parse.c: static int show_reference(const char *refname, const struct
       
      -static int anti_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
      +static int anti_reference(const char *refname, const struct object_id *oid,
     -+			  unsigned int flag, void *cb_data)
     ++			  unsigned int unused_flags, void *cb_data)
       {
       	show_rev(REVERSED, oid, refname);
       	return 0;
     @@ builtin/show-branch.c: static int append_ref(const char *refname, const struct o
       
       static int append_head_ref(const char *refname, const struct object_id *oid,
      -			   int flag, void *cb_data)
     -+			   unsigned int flag, void *cb_data)
     ++			   unsigned int unused_flags, void *cb_data)
       {
       	struct object_id tmp;
       	int ofs = 11;
     @@ builtin/show-branch.c: static int append_head_ref(const char *refname, const str
       
       static int append_remote_ref(const char *refname, const struct object_id *oid,
      -			     int flag, void *cb_data)
     -+			     unsigned int flag, void *cb_data)
     ++			     unsigned int unused_flags, void *cb_data)
       {
       	struct object_id tmp;
       	int ofs = 13;
     +@@ builtin/show-branch.c: static int append_remote_ref(const char *refname, const struct object_id *oid,
     + }
     + 
     + static int append_tag_ref(const char *refname, const struct object_id *oid,
     +-			  int flag, void *cb_data)
     ++			  int unused_flags, void *cb_data)
     + {
     + 	if (!starts_with(refname, "refs/tags/"))
     + 		return 0;
      @@ builtin/show-branch.c: static const char *match_ref_pattern = NULL;
       static int match_ref_slash = 0;
       
       static int append_matching_ref(const char *refname, const struct object_id *oid,
      -			       int flag, void *cb_data)
     -+			       unsigned int flag, void *cb_data)
     ++			       unsigned int flags, void *cb_data)
       {
       	/* we want to allow pattern hold/<asterisk> to show all
       	 * branches under refs/heads/hold/, and v0.99.9? to show
     +@@ builtin/show-branch.c: static int append_matching_ref(const char *refname, const struct object_id *oid,
     + 	if (wildmatch(match_ref_pattern, tail, 0))
     + 		return 0;
     + 	if (starts_with(refname, "refs/heads/"))
     +-		return append_head_ref(refname, oid, flag, cb_data);
     ++		return append_head_ref(refname, oid, flags, cb_data);
     + 	if (starts_with(refname, "refs/tags/"))
     +-		return append_tag_ref(refname, oid, flag, cb_data);
     ++		return append_tag_ref(refname, oid, flags, cb_data);
     + 	return append_ref(refname, oid, 0);
     + }
     + 
      
       ## builtin/show-ref.c ##
      @@ builtin/show-ref.c: static void show_one(const char *refname, const struct object_id *oid)
     @@ builtin/show-ref.c: match:
       
       static int add_existing(const char *refname, const struct object_id *oid,
      -			int flag, void *cbdata)
     -+			unsigned int flag, void *cbdata)
     ++			unsigned int unused_flags, void *cbdata)
       {
       	struct string_list *list = (struct string_list *)cbdata;
       	string_list_insert(list, refname);
     @@ builtin/submodule--helper.c: static void print_status(unsigned int flags, char s
      -				     const struct object_id *oid, int flags,
      -				     void *cb_data)
      +				     const struct object_id *oid,
     -+				     unsigned int flags, void *cb_data)
     ++				     unsigned int unused_flags, void *cb_data)
       {
       	struct object_id *output = cb_data;
       	if (oid)
     @@ builtin/symbolic-ref.c: static const char * const git_symbolic_ref_usage[] = {
       static int check_symref(const char *HEAD, int quiet, int shorten, int print)
       {
      -	int flag;
     -+	unsigned int flag;
     - 	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flag);
     +-	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flag);
     ++	unsigned int flags;
     ++	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flags);
       
       	if (!refname)
     + 		die("No such ref: %s", HEAD);
     +-	else if (!(flag & REF_ISSYMREF)) {
     ++	else if (!(flags & REF_ISSYMREF)) {
     + 		if (!quiet)
     + 			die("ref %s is not a symbolic ref", HEAD);
     + 		else
      
       ## bundle.c ##
      @@ bundle.c: static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
     @@ bundle.c: static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
       		char *ref;
       		const char *display_ref;
      -		int flag;
     -+		unsigned int flag;
     ++		unsigned int flags;
       
       		if (e->item->flags & UNINTERESTING)
       			continue;
     + 		if (dwim_ref(e->name, strlen(e->name), &oid, &ref, 0) != 1)
     + 			goto skip_write_ref;
     +-		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flag))
     +-			flag = 0;
     +-		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
     ++		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flags))
     ++			flags = 0;
     ++		display_ref = (flags & REF_ISSYMREF) ? e->name : ref;
     + 
     + 		if (e->item->type == OBJ_TAG &&
     + 				!is_tag_in_date_range(e->item, revs)) {
      
       ## commit-graph.c ##
      @@ commit-graph.c: struct refs_cb_data {
     @@ delta-islands.c: static void add_ref_to_island(const char *island_name, const st
       
       static int find_island_for_ref(const char *refname, const struct object_id *oid,
      -			       int flags, void *data)
     -+			       unsigned int flags, void *data)
     ++			       unsigned int unused_flags, void *data)
       {
       	/*
       	 * We should advertise 'ARRAY_SIZE(matches) - 2' as the max,
     @@ fetch-pack.c: static int rev_list_insert_ref(struct fetch_negotiator *negotiator
      -				   int flag, void *cb_data)
      +static int rev_list_insert_ref_oid(const char *refname,
      +				   const struct object_id *oid,
     -+				   unsigned int flag, void *cb_data)
     ++				   unsigned int unused_flags, void *cb_data)
       {
       	return rev_list_insert_ref(cb_data, oid);
       }
     @@ fetch-pack.c: static int mark_complete(const struct object_id *oid)
       
       static int mark_complete_oid(const char *refname, const struct object_id *oid,
      -			     int flag, void *cb_data)
     -+			     unsigned int flag, void *cb_data)
     ++			     unsigned int unused_flags, void *cb_data)
       {
       	return mark_complete(oid);
       }
     @@ http-backend.c: static void get_info_refs(struct strbuf *hdr, char *arg)
       
       static int show_head_ref(const char *refname, const struct object_id *oid,
      -			 int flag, void *cb_data)
     -+			 unsigned int flag, void *cb_data)
     ++			 unsigned int flags, void *cb_data)
       {
       	struct strbuf *buf = cb_data;
       
     +-	if (flag & REF_ISSYMREF) {
     ++	if (flags & REF_ISSYMREF) {
     + 		const char *target = resolve_ref_unsafe(refname,
     + 							RESOLVE_REF_READING,
     + 							NULL, NULL);
      
       ## log-tree.c ##
      @@ log-tree.c: static int ref_filter_match(const char *refname,
     @@ log-tree.c: static int ref_filter_match(const char *refname,
       
       static int add_ref_decoration(const char *refname, const struct object_id *oid,
      -			      int flags, void *cb_data)
     -+			      unsigned int flags, void *cb_data)
     ++			      unsigned int unused_flags, void *cb_data)
       {
       	struct object *obj;
       	enum object_type objtype;
     @@ ls-refs.c: struct ls_refs_data {
       
       static int send_ref(const char *refname, const struct object_id *oid,
      -		    int flag, void *cb_data)
     -+		    unsigned int flag, void *cb_data)
     ++		    unsigned int flags, void *cb_data)
       {
       	struct ls_refs_data *data = cb_data;
       	const char *refname_nons = strip_namespace(refname);
     +@@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
     + 		strbuf_addf(&data->buf, "%s %s", oid_to_hex(oid), refname_nons);
     + 	else
     + 		strbuf_addf(&data->buf, "unborn %s", refname_nons);
     +-	if (data->symrefs && flag & REF_ISSYMREF) {
     ++	if (data->symrefs && flags & REF_ISSYMREF) {
     + 		struct object_id unused;
     +-		const char *symref_target = resolve_ref_unsafe(refname, 0,
     +-							       &unused,
     +-							       &flag);
     ++		const char *symref_target =
     ++			resolve_ref_unsafe(refname, 0, &unused, &flags);
     + 
     + 		if (!symref_target)
     + 			die("'%s' is a symref but it is not?", refname);
      @@ ls-refs.c: static void send_possibly_unborn_head(struct ls_refs_data *data)
       {
       	struct strbuf namespaced = STRBUF_INIT;
       	struct object_id oid;
      -	int flag;
     -+	unsigned int flag;
     ++	unsigned int flags;
       	int oid_is_null;
       
       	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
     +-	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag))
     ++	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flags))
     + 		return; /* bad ref */
     + 	oid_is_null = is_null_oid(&oid);
     + 	if (!oid_is_null ||
     +-	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
     +-		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
     ++	    (data->unborn && data->symrefs && (flags & REF_ISSYMREF)))
     ++		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flags,
     ++			 data);
     + 	strbuf_release(&namespaced);
     + }
     + 
      
       ## midx.c ##
      @@ midx.c: static void prepare_midx_packing_data(struct packing_data *pdata,
     @@ midx.c: static void prepare_midx_packing_data(struct packing_data *pdata,
      -			      const struct object_id *oid,
      -			      int flag, void *cb_data)
      +static int add_ref_to_pending(const char *refname, const struct object_id *oid,
     -+			      unsigned int flag, void *cb_data)
     ++			      unsigned int flags, void *cb_data)
       {
       	struct rev_info *revs = (struct rev_info*)cb_data;
       	struct object *object;
     + 
     +-	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
     ++	if ((flags & REF_ISSYMREF) && (flags & REF_ISBROKEN)) {
     + 		warning("symbolic ref is dangling: %s", refname);
     + 		return 0;
     + 	}
      
       ## negotiator/default.c ##
      @@ negotiator/default.c: static void rev_list_push(struct negotiation_state *ns,
     @@ negotiator/default.c: static void rev_list_push(struct negotiation_state *ns,
       
       static int clear_marks(const char *refname, const struct object_id *oid,
      -		       int flag, void *cb_data)
     -+		       unsigned int flag, void *cb_data)
     ++		       unsigned int unused_flags, void *cb_data)
       {
       	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
       
     @@ negotiator/skipping.c: static struct entry *rev_list_push(struct data *data, str
       
       static int clear_marks(const char *refname, const struct object_id *oid,
      -		       int flag, void *cb_data)
     -+		       unsigned int flag, void *cb_data)
     ++		       unsigned int unused_flags, void *cb_data)
       {
       	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
       
     @@ notes.c: out:
      -				   int flag, void *cb)
      +static int string_list_add_one_ref(const char *refname,
      +				   const struct object_id *oid,
     -+				   unsigned int flag, void *cb)
     ++				   unsigned int unused_flags, void *cb)
       {
       	struct string_list *refs = cb;
       	if (!unsorted_string_list_has_string(refs, refname))
     @@ object-name.c: struct handle_one_ref_cb {
       
       static int handle_one_ref(const char *path, const struct object_id *oid,
      -			  int flag, void *cb_data)
     -+			  unsigned int flag, void *cb_data)
     ++			  unsigned int unused_flags, void *cb_data)
       {
       	struct handle_one_ref_cb *cb = cb_data;
       	struct commit_list **list = cb->list;
     @@ reachable.c: static void update_progress(struct connectivity_progress *cp)
       
       static int add_one_ref(const char *path, const struct object_id *oid,
      -		       int flag, void *cb_data)
     -+		       unsigned int flag, void *cb_data)
     ++		       unsigned int flags, void *cb_data)
       {
       	struct rev_info *revs = (struct rev_info *)cb_data;
       	struct object *object;
     + 
     +-	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
     ++	if ((flags & REF_ISSYMREF) && (flags & REF_ISBROKEN)) {
     + 		warning("symbolic ref is dangling: %s", path);
     + 		return 0;
     + 	}
      
       ## ref-filter.c ##
      @@ ref-filter.c: struct ref_filter_cbdata {
     @@ ref-filter.c: struct ref_filter_cbdata {
        */
      -static int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
      +static int ref_filter_handler(const char *refname, const struct object_id *oid,
     -+			      unsigned int flag, void *cb_data)
     ++			      unsigned int flags, void *cb_data)
       {
       	struct ref_filter_cbdata *ref_cbdata = cb_data;
       	struct ref_filter *filter = ref_cbdata->filter;
     +@@ ref-filter.c: static int ref_filter_handler(const char *refname, const struct object_id *oid,
     + 	struct commit *commit = NULL;
     + 	unsigned int kind;
     + 
     +-	if (flag & REF_BAD_NAME) {
     ++	if (flags & REF_BAD_NAME) {
     + 		warning(_("ignoring ref with broken name %s"), refname);
     + 		return 0;
     + 	}
     + 
     +-	if (flag & REF_ISBROKEN) {
     ++	if (flags & REF_ISBROKEN) {
     + 		warning(_("ignoring broken ref %s"), refname);
     + 		return 0;
     + 	}
     +@@ ref-filter.c: static int ref_filter_handler(const char *refname, const struct object_id *oid,
     + 	 */
     + 	ref = ref_array_push(ref_cbdata->array, refname, oid);
     + 	ref->commit = commit;
     +-	ref->flag = flag;
     ++	ref->flag = flags;
     + 	ref->kind = kind;
     + 
     + 	return 0;
      
       ## refs.c ##
      @@ refs.c: static unsigned char refname_disposition[256] = {
     @@ refs.c: int ref_resolves_to_object(const char *refname,
      -			  const char *refname, int resolve_flags,
      -			  struct object_id *oid, int *flags)
      +char *refs_resolve_refdup(struct ref_store *refs, const char *refname,
     -+			  int resolve_flags, struct object_id *oid,
     ++			  unsigned int resolve_flags, struct object_id *oid,
      +			  unsigned int *flags)
       {
       	const char *result;
     @@ refs.c: int head_ref_namespaced(each_ref_fn fn, void *cb_data)
       	int ret = 0;
       	struct object_id oid;
      -	int flag;
     -+	unsigned int flag;
     ++	unsigned int flags;
       
       	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
     - 	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flag))
     +-	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flag))
     +-		ret = fn(buf.buf, &oid, flag, cb_data);
     ++	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flags))
     ++		ret = fn(buf.buf, &oid, flags, cb_data);
     + 	strbuf_release(&buf);
     + 
     + 	return ret;
      @@ refs.c: int expand_ref(struct repository *repo, const char *str, int len,
       	for (p = ref_rev_parse_rules; *p; p++) {
       		struct object_id oid_from_ref;
       		struct object_id *this_result;
      -		int flag;
     -+		unsigned int flag;
     ++		unsigned int flags;
       		struct ref_store *refs = get_main_ref_store(repo);
       		int ignore_errno;
       
     +@@ refs.c: int expand_ref(struct repository *repo, const char *str, int len,
     + 		strbuf_reset(&fullref);
     + 		strbuf_addf(&fullref, *p, len, str);
     + 		r = refs_resolve_ref_unsafe(refs, fullref.buf,
     +-					    RESOLVE_REF_READING,
     +-					    this_result, &flag,
     +-					    &ignore_errno);
     ++					    RESOLVE_REF_READING, this_result,
     ++					    &flags, &ignore_errno);
     + 		if (r) {
     + 			if (!refs_found++)
     + 				*ref = xstrdup(r);
     + 			if (!warn_ambiguous_refs)
     + 				break;
     +-		} else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
     ++		} else if ((flags & REF_ISSYMREF) &&
     ++			   strcmp(fullref.buf, "HEAD")) {
     + 			warning(_("ignoring dangling symref %s"), fullref.buf);
     +-		} else if ((flag & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
     ++		} else if ((flags & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
     + 			warning(_("ignoring broken ref %s"), fullref.buf);
     + 		}
     + 	}
      @@ refs.c: const char *find_descendant_ref(const char *dirname,
       int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
       {
       	struct object_id oid;
      -	int flag;
     -+	unsigned int flag;
     ++	unsigned int flags;
       	int ignore_errno;
       
     - 	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
     +-	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
     +-				    &oid, &flag, &ignore_errno))
     +-		return fn("HEAD", &oid, flag, cb_data);
     ++	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING, &oid,
     ++				    &flags, &ignore_errno))
     ++		return fn("HEAD", &oid, flags, cb_data);
     + 
     + 	return 0;
     + }
      @@ refs.c: struct do_for_each_ref_help {
       	void *cb_data;
       };
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
      -				    struct object_id *oid,
      -				    int *flags, int *failure_errno)
      +const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
     -+				    int resolve_flags, struct object_id *oid,
     -+				    unsigned int *flags, int *failure_errno)
     ++				    unsigned int resolve_flags,
     ++				    struct object_id *oid, unsigned int *flags,
     ++				    int *failure_errno)
       {
       	static struct strbuf sb_refname = STRBUF_INIT;
       	struct object_id unused_oid;
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
       
       	assert(failure_errno);
      @@ refs.c: int refs_init_db(struct strbuf *err)
     + 	return refs->be->init_db(refs, err);
       }
       
     - const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
     +-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
      -			       struct object_id *oid, int *flags)
     ++const char *resolve_ref_unsafe(const char *refname, unsigned int resolve_flags,
      +			       struct object_id *oid, unsigned int *flags)
       {
       	int ignore_errno;
     @@ refs.c: int resolve_gitlink_ref(const char *submodule, const char *refname,
       {
       	struct ref_store *refs;
      -	int flags;
     -+	unsigned int flags;
     ++	unsigned int unused_flags;
       	int ignore_errno;
       
       	refs = get_submodule_ref_store(submodule);
     +@@ refs.c: int resolve_gitlink_ref(const char *submodule, const char *refname,
     + 	if (!refs)
     + 		return -1;
     + 
     +-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags,
     +-				     &ignore_errno) || is_null_oid(oid))
     ++	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &unused_flags,
     ++				     &ignore_errno) ||
     ++	    is_null_oid(oid))
     + 		return -1;
     + 	return 0;
     + }
      
       ## refs.h ##
      @@ refs.h: struct worktree;
     @@ refs.h: struct worktree;
      -				    int resolve_flags,
      -				    struct object_id *oid,
      -				    int *flags, int *failure_errno);
     -+const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
     -+				    int resolve_flags, struct object_id *oid,
     -+				    unsigned int *flags, int *failure_errno);
     - 
     - const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
     +-
     +-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
      -			       struct object_id *oid, int *flags);
     -+			       struct object_id *oid, unsigned int *flags);
     - 
     +-
      -char *refs_resolve_refdup(struct ref_store *refs,
      -			  const char *refname, int resolve_flags,
      -			  struct object_id *oid, int *flags);
      -char *resolve_refdup(const char *refname, int resolve_flags,
      -		     struct object_id *oid, int *flags);
     +-
     +-int read_ref_full(const char *refname, int resolve_flags,
     +-		  struct object_id *oid, int *flags);
     ++const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
     ++				    unsigned int resolve_flags,
     ++				    struct object_id *oid, unsigned int *flags,
     ++				    int *failure_errno);
     ++
     ++const char *resolve_ref_unsafe(const char *refname, unsigned int resolve_flags,
     ++			       struct object_id *oid, unsigned int *flags);
     ++
      +char *refs_resolve_refdup(struct ref_store *refs, const char *refname,
     -+			  int resolve_flags, struct object_id *oid,
     ++			  unsigned int resolve_flags, struct object_id *oid,
      +			  unsigned int *flags);
      +char *resolve_refdup(const char *refname, unsigned int resolve_flags,
      +		     struct object_id *oid, unsigned int *flags);
     - 
     --int read_ref_full(const char *refname, int resolve_flags,
     --		  struct object_id *oid, int *flags);
     ++
      +int read_ref_full(const char *refname, unsigned int resolve_flags,
      +		  struct object_id *oid, unsigned int *flags);
       int read_ref(const char *refname, struct object_id *oid);
     @@ refs/files-backend.c: static void loose_fill_ref_dir(struct ref_store *ref_store
       		struct object_id oid;
       		struct stat st;
      -		int flag;
     -+		unsigned int flag;
       
       		if (de->d_name[0] == '.')
       			continue;
     +@@ refs/files-backend.c: static void loose_fill_ref_dir(struct ref_store *ref_store,
     + 							  refname.len));
     + 		} else {
     + 			int ignore_errno;
     +-			if (!refs_resolve_ref_unsafe(&refs->base,
     +-						     refname.buf,
     +-						     RESOLVE_REF_READING,
     +-						     &oid, &flag, &ignore_errno)) {
     ++			unsigned int flags;
     ++			if (!refs_resolve_ref_unsafe(&refs->base, refname.buf,
     ++						     RESOLVE_REF_READING, &oid,
     ++						     &flags, &ignore_errno)) {
     + 				oidclr(&oid);
     +-				flag |= REF_ISBROKEN;
     ++				flags |= REF_ISBROKEN;
     + 			} else if (is_null_oid(&oid)) {
     + 				/*
     + 				 * It is so astronomically unlikely
     +@@ refs/files-backend.c: static void loose_fill_ref_dir(struct ref_store *ref_store,
     + 				 * file to be repo corruption
     + 				 * (probably due to a software bug).
     + 				 */
     +-				flag |= REF_ISBROKEN;
     ++				flags |= REF_ISBROKEN;
     + 			}
     + 
     + 			if (check_refname_format(refname.buf,
     +@@ refs/files-backend.c: static void loose_fill_ref_dir(struct ref_store *ref_store,
     + 				if (!refname_is_safe(refname.buf))
     + 					die("loose refname is dangerous: %s", refname.buf);
     + 				oidclr(&oid);
     +-				flag |= REF_BAD_NAME | REF_ISBROKEN;
     ++				flags |= REF_BAD_NAME | REF_ISBROKEN;
     + 			}
     +-			add_entry_to_dir(dir,
     +-					 create_ref_entry(refname.buf, &oid, flag));
     ++			add_entry_to_dir(dir, create_ref_entry(refname.buf,
     ++							       &oid, flags));
     + 		}
     + 		strbuf_setlen(&refname, dirnamelen);
     + 		strbuf_setlen(&path, path_baselen);
      @@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_store,
       	struct files_ref_store *refs =
       		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
       	struct object_id orig_oid;
      -	int flag = 0, logmoved = 0;
      +	int logmoved = 0;
     -+	unsigned int flag = 0;
     ++	unsigned int flags = 0;
       	struct ref_lock *lock;
       	struct stat loginfo;
       	struct strbuf sb_oldref = STRBUF_INIT;
     +@@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_store,
     + 	}
     + 
     + 	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
     +-				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
     +-				     &orig_oid, &flag, &ignore_errno)) {
     ++				     RESOLVE_REF_READING |
     ++					     RESOLVE_REF_NO_RECURSE,
     ++				     &orig_oid, &flags, &ignore_errno)) {
     + 		ret = error("refname %s not found", oldrefname);
     + 		goto out;
     + 	}
     + 
     +-	if (flag & REF_ISSYMREF) {
     ++	if (flags & REF_ISSYMREF) {
     + 		if (copy)
     + 			ret = error("refname %s is a symbolic ref, copying it is not supported",
     + 				    oldrefname);
     +@@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_store,
     + 		goto rollbacklog;
     + 	}
     + 
     +-	flag = log_all_ref_updates;
     ++	flags = log_all_ref_updates;
     + 	log_all_ref_updates = LOG_REFS_NONE;
     + 	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
     + 	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
     + 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
     + 		strbuf_release(&err);
     + 	}
     +-	log_all_ref_updates = flag;
     ++	log_all_ref_updates = flags;
     + 
     +  rollbacklog:
     + 	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
     +@@ refs/files-backend.c: static int log_ref_write_fd(int fd, const struct object_id *old_oid,
     + }
     + 
     + static int files_log_ref_write(struct files_ref_store *refs,
     +-			       const char *refname, const struct object_id *old_oid,
     ++			       const char *refname,
     ++			       const struct object_id *old_oid,
     + 			       const struct object_id *new_oid, const char *msg,
     +-			       int flags, struct strbuf *err)
     ++			       unsigned int flags, struct strbuf *err)
     + {
     + 	int logfd, result;
     + 
      @@ refs/files-backend.c: static int commit_ref_update(struct files_ref_store *refs,
       		 * check with HEAD only which should cover 99% of all usage
       		 * scenarios (even 100% of the default ones).
       		 */
      -		int head_flag;
     -+		unsigned int head_flag;
     ++		unsigned int head_flags;
       		const char *head_ref;
       		int ignore_errno;
       
     + 		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
     +-						   RESOLVE_REF_READING,
     +-						   NULL, &head_flag,
     +-						   &ignore_errno);
     +-		if (head_ref && (head_flag & REF_ISSYMREF) &&
     ++						   RESOLVE_REF_READING, NULL,
     ++						   &head_flags, &ignore_errno);
     ++		if (head_ref && (head_flags & REF_ISSYMREF) &&
     + 		    !strcmp(head_ref, lock->ref_name)) {
     + 			struct strbuf log_err = STRBUF_INIT;
     + 			if (files_log_ref_write(refs, "HEAD",
      @@ refs/files-backend.c: static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
       	int ignore_errno;
       
     @@ refs/files-backend.c: static int files_transaction_abort(struct ref_store *ref_s
      -static int ref_present(const char *refname,
      -		       const struct object_id *oid, int flags, void *cb_data)
      +static int ref_present(const char *refname, const struct object_id *oid,
     -+		       unsigned int flags, void *cb_data)
     ++		       unsigned int unused_flags, void *cb_data)
       {
       	struct string_list *affected_refnames = cb_data;
       
     @@ remote.c: static void alias_all_urls(struct remote_state *remote_state)
       static void read_config(struct repository *repo)
       {
      -	int flag;
     -+	unsigned int flag;
     ++	unsigned int flags;
       
       	if (repo->remote_state->initialized)
       		return;
     +@@ remote.c: static void read_config(struct repository *repo)
     + 	if (startup_info->have_repository) {
     + 		int ignore_errno;
     + 		const char *head_ref = refs_resolve_ref_unsafe(
     +-			get_main_ref_store(repo), "HEAD", 0, NULL, &flag, &ignore_errno);
     +-		if (head_ref && (flag & REF_ISSYMREF) &&
     ++			get_main_ref_store(repo), "HEAD", 0, NULL, &flags,
     ++			&ignore_errno);
     ++		if (head_ref && (flags & REF_ISSYMREF) &&
     + 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
     + 			repo->remote_state->current_branch = make_branch(
     + 				repo->remote_state, head_ref, strlen(head_ref));
      @@ remote.c: static int match_explicit(struct ref *src, struct ref *dst,
       		return -1;
       
       	if (!dst_value) {
      -		int flag;
     -+		unsigned int flag;
     - 
     - 		dst_value = resolve_ref_unsafe(matched_src->name,
     - 					       RESOLVE_REF_READING,
     +-
     +-		dst_value = resolve_ref_unsafe(matched_src->name,
     +-					       RESOLVE_REF_READING,
     +-					       NULL, &flag);
     +-		if (!dst_value ||
     +-		    ((flag & REF_ISSYMREF) &&
     +-		     !starts_with(dst_value, "refs/heads/")))
     ++		unsigned int flags;
     ++
     ++		dst_value = resolve_ref_unsafe(
     ++			matched_src->name, RESOLVE_REF_READING, NULL, &flags);
     ++		if (!dst_value || ((flags & REF_ISSYMREF) &&
     ++				   !starts_with(dst_value, "refs/heads/")))
     + 			die(_("%s cannot be resolved to branch"),
     + 			    matched_src->name);
     + 	}
      @@ remote.c: const char *branch_get_push(struct branch *branch, struct strbuf *err)
       
       static int ignore_symref_update(const char *refname)
       {
      -	int flag;
     -+	unsigned int flag;
     ++	unsigned int flags;
       
     - 	if (!resolve_ref_unsafe(refname, 0, NULL, &flag))
     +-	if (!resolve_ref_unsafe(refname, 0, NULL, &flag))
     ++	if (!resolve_ref_unsafe(refname, 0, NULL, &flags))
       		return 0; /* non-existing refs are OK */
     +-	return (flag & REF_ISSYMREF);
     ++	return (flags & REF_ISSYMREF);
     + }
     + 
     + /*
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       }
       
     @@ replace-object.c
       
      -static int register_replace_ref(struct repository *r,
      -				const char *refname,
     --				const struct object_id *oid,
     --				int flag, void *cb_data)
      +static int register_replace_ref(struct repository *r, const char *refname,
     -+				const struct object_id *oid, unsigned int flag,
     -+				void *cb_data)
     + 				const struct object_id *oid,
     +-				int flag, void *cb_data)
     ++				unsigned int unused_flags, void *cb_data)
       {
       	/* Get sha1 from refname */
       	const char *slash = strrchr(refname, '/');
     @@ revision.c: int ref_excluded(struct string_list *ref_excludes, const char *path)
       
       static int handle_one_ref(const char *path, const struct object_id *oid,
      -			  int flag, void *cb_data)
     -+			  unsigned int flag, void *cb_data)
     ++			  unsigned int unused_flags, void *cb_data)
       {
       	struct all_refs_cb *cb = cb_data;
       	struct object *object;
      @@ revision.c: static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
     - }
       
       static int handle_one_reflog(const char *refname_in_wt,
     --			     const struct object_id *oid,
     + 			     const struct object_id *oid,
      -			     int flag, void *cb_data)
     -+			     const struct object_id *oid, unsigned int flag,
     -+			     void *cb_data)
     ++			     unsigned int unused_flags, void *cb_data)
       {
       	struct all_refs_cb *cb = cb_data;
       	struct strbuf refname = STRBUF_INIT;
     @@ server-info.c: out:
       
       static int add_info_ref(const char *path, const struct object_id *oid,
      -			int flag, void *cb_data)
     -+			unsigned int flag, void *cb_data)
     ++			unsigned int unused_flags, void *cb_data)
       {
       	struct update_info_ctx *uic = cb_data;
       	struct object *o = parse_object(the_repository, oid);
     @@ shallow.c: static void paint_down(struct paint_info *info, const struct object_i
       
       static int mark_uninteresting(const char *refname, const struct object_id *oid,
      -			      int flags, void *cb_data)
     -+			      unsigned int flags, void *cb_data)
     ++			      unsigned int unused_flags, void *cb_data)
       {
       	struct commit *commit = lookup_commit_reference_gently(the_repository,
       							       oid, 1);
     @@ shallow.c: struct commit_array {
       
       static int add_ref(const char *refname, const struct object_id *oid,
      -		   int flags, void *cb_data)
     -+		   unsigned int flags, void *cb_data)
     ++		   unsigned int unused_flags, void *cb_data)
       {
       	struct commit_array *ca = cb_data;
       	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
     @@ submodule.c: static void free_submodules_oids(struct string_list *submodules)
       
       static int has_remote(const char *refname, const struct object_id *oid,
      -		      int flags, void *cb_data)
     -+		      unsigned int flags, void *cb_data)
     ++		      unsigned int unused_flags, void *cb_data)
       {
       	return 1;
       }
     @@ submodule.c: int push_unpushed_submodules(struct repository *r,
       
       static int append_oid_to_array(const char *ref, const struct object_id *oid,
      -			       int flags, void *data)
     -+			       unsigned int flags, void *data)
     ++			       unsigned int unused_flags, void *data)
       {
       	struct oid_array *array = data;
       	oid_array_append(array, oid);
     @@ transport-helper.c: static int push_refs_with_export(struct transport *transport
       				if (!ref->deletion) {
       					const char *name;
      -					int flag;
     -+					unsigned int flag;
     ++					unsigned int ref_flags;
       
       					/* Follow symbolic refs (mainly for HEAD). */
     - 					name = resolve_ref_unsafe(ref->peer_ref->name,
     +-					name = resolve_ref_unsafe(ref->peer_ref->name,
     +-								  RESOLVE_REF_READING,
     +-								  &oid, &flag);
     +-					if (!name || !(flag & REF_ISSYMREF))
     ++					name = resolve_ref_unsafe(
     ++						ref->peer_ref->name,
     ++						RESOLVE_REF_READING, &oid,
     ++						&ref_flags);
     ++					if (!name ||
     ++					    !(ref_flags & REF_ISSYMREF))
     + 						name = ref->peer_ref->name;
     + 
     + 					strbuf_addf(&buf, "%s:%s", name, ref->name);
      
       ## transport.c ##
      @@ transport.c: static void set_upstreams(struct transport *transport, struct ref *refs,
     @@ transport.c: static void set_upstreams(struct transport *transport, struct ref *
       		const char *tmp;
       		const char *remotename;
      -		int flag = 0;
     -+		unsigned int flag = 0;
     ++		unsigned int ref_flags = 0;
       		/*
       		 * Check suitability for tracking. Must be successful /
       		 * already up-to-date ref create/modify (not delete).
     +@@ transport.c: static void set_upstreams(struct transport *transport, struct ref *refs,
     + 		/* Follow symbolic refs (mainly for HEAD). */
     + 		localname = ref->peer_ref->name;
     + 		remotename = ref->name;
     +-		tmp = resolve_ref_unsafe(localname, RESOLVE_REF_READING,
     +-					 NULL, &flag);
     +-		if (tmp && flag & REF_ISSYMREF &&
     +-			starts_with(tmp, "refs/heads/"))
     ++		tmp = resolve_ref_unsafe(localname, RESOLVE_REF_READING, NULL,
     ++					 &ref_flags);
     ++		if (tmp && ref_flags & REF_ISSYMREF &&
     ++		    starts_with(tmp, "refs/heads/"))
     + 			localname = tmp;
     + 
     + 		/* Both source and destination must be local branches. */
      
       ## upload-pack.c ##
      @@ upload-pack.c: static void send_unshallow(struct upload_pack_data *data)
     @@ upload-pack.c: static int mark_our_ref(const char *refname, const char *refname_
       
       static int check_ref(const char *refname_full, const struct object_id *oid,
      -		     int flag, void *cb_data)
     -+		     unsigned int flag, void *cb_data)
     ++		     unsigned int unused_flags, void *cb_data)
       {
       	const char *refname = strip_namespace(refname_full);
       
     @@ upload-pack.c: static void format_session_id(struct strbuf *buf, struct upload_p
       
       static int send_ref(const char *refname, const struct object_id *oid,
      -		    int flag, void *cb_data)
     -+		    unsigned int flag, void *cb_data)
     ++		    unsigned int unused_flags, void *cb_data)
       {
       	static const char *capabilities = "multi_ack thin-pack side-band"
       		" side-band-64k ofs-delta shallow deepen-since deepen-not"
     @@ upload-pack.c: static int send_ref(const char *refname, const struct object_id *
       
       static int find_symref(const char *refname, const struct object_id *oid,
      -		       int flag, void *cb_data)
     -+		       unsigned int flag, void *cb_data)
     ++		       unsigned int flags, void *cb_data)
       {
       	const char *symref_target;
       	struct string_list_item *item;
     + 
     +-	if ((flag & REF_ISSYMREF) == 0)
     ++	if ((flags & REF_ISSYMREF) == 0)
     + 		return 0;
     +-	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flag);
     +-	if (!symref_target || (flag & REF_ISSYMREF) == 0)
     ++	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flags);
     ++	if (!symref_target || (flags & REF_ISSYMREF) == 0)
     + 		die("'%s' is a symref but it is not?", refname);
     + 	item = string_list_append(cb_data, strip_namespace(refname));
     + 	item->util = xstrdup(strip_namespace(symref_target));
      
       ## walker.c ##
      @@ walker.c: static int interpret_target(struct walker *walker, char *target, struct object_i
     @@ walker.c: static int interpret_target(struct walker *walker, char *target, struc
       
       static int mark_complete(const char *path, const struct object_id *oid,
      -			 int flag, void *cb_data)
     -+			 unsigned int flag, void *cb_data)
     ++			 unsigned int unused_flags, void *cb_data)
       {
       	struct commit *commit = lookup_commit_reference_gently(the_repository,
       							       oid, 1);
     @@ worktree.c: int other_head_refs(each_ref_fn fn, void *cb_data)
       		struct worktree *wt = *p;
       		struct object_id oid;
      -		int flag;
     -+		unsigned int flag;
     ++		unsigned int flags;
       		int ignore_errno;
       
       		if (wt->is_current)
     +@@ worktree.c: int other_head_refs(each_ref_fn fn, void *cb_data)
     + 		strbuf_reset(&refname);
     + 		strbuf_worktree_ref(wt, &refname, "HEAD");
     + 		if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
     +-					    refname.buf,
     +-					    RESOLVE_REF_READING,
     +-					    &oid, &flag, &ignore_errno))
     +-			ret = fn(refname.buf, &oid, flag, cb_data);
     ++					    refname.buf, RESOLVE_REF_READING,
     ++					    &oid, &flags, &ignore_errno))
     ++			ret = fn(refname.buf, &oid, flags, cb_data);
     + 		if (ret)
     + 			break;
     + 	}


 bisect.c                    |  4 +-
 builtin/bisect--helper.c    |  9 +++--
 builtin/branch.c            |  4 +-
 builtin/checkout.c          | 24 ++++++-----
 builtin/describe.c          |  3 +-
 builtin/fetch.c             | 10 ++---
 builtin/fsck.c              |  4 +-
 builtin/gc.c                |  5 +--
 builtin/name-rev.c          |  3 +-
 builtin/pack-objects.c      | 11 ++---
 builtin/rebase.c            | 10 +++--
 builtin/receive-pack.c      | 13 +++---
 builtin/reflog.c            |  5 ++-
 builtin/remote.c            | 23 ++++++-----
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
 refs.c                      | 80 ++++++++++++++++++-------------------
 refs.h                      | 47 ++++++++++------------
 refs/files-backend.c        | 57 +++++++++++++-------------
 remote.c                    | 31 +++++++-------
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
 worktree.c                  | 13 +++---
 53 files changed, 276 insertions(+), 266 deletions(-)

diff --git a/bisect.c b/bisect.c
index 888949fba6b..64807d2996b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -441,7 +441,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 }
 
 static int register_ref(const char *refname, const struct object_id *oid,
-			int flags, void *cb_data)
+			unsigned int unused_flags, void *cb_data)
 {
 	struct strbuf good_prefix = STRBUF_INIT;
 	strbuf_addstr(&good_prefix, term_good);
@@ -1146,7 +1146,7 @@ int estimate_bisect_steps(int all)
 }
 
 static int mark_for_removal(const char *refname, const struct object_id *oid,
-			    int flag, void *cb_data)
+			    unsigned int unused_flags, void *cb_data)
 {
 	struct string_list *refs = cb_data;
 	char *ref = xstrfmt("refs/bisect%s", refname);
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..ec460308bee 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -330,7 +330,7 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
 }
 
 static int mark_good(const char *refname, const struct object_id *oid,
-		     int flag, void *cb_data)
+		     unsigned int unused_flags, void *cb_data)
 {
 	int *m_good = (int *)cb_data;
 	*m_good = 0;
@@ -477,7 +477,7 @@ finish:
 }
 
 static int add_bisect_ref(const char *refname, const struct object_id *oid,
-			  int flags, void *cb)
+			  unsigned int unused_flags, void *cb)
 {
 	struct add_bisect_ref_data *data = cb;
 
@@ -617,7 +617,8 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 	int no_checkout = 0;
 	int first_parent_only = 0;
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
-	int flags, pathspec_pos;
+	int pathspec_pos;
+	unsigned int unused_flags;
 	enum bisect_error res = BISECT_OK;
 	struct string_list revs = STRING_LIST_INIT_DUP;
 	struct string_list states = STRING_LIST_INIT_DUP;
@@ -707,7 +708,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 	/*
 	 * Verify HEAD
 	 */
-	head = resolve_ref_unsafe("HEAD", 0, &head_oid, &flags);
+	head = resolve_ref_unsafe("HEAD", 0, &head_oid, &unused_flags);
 	if (!head)
 		if (get_oid("HEAD", &head_oid))
 			return error(_("bad HEAD - I need a HEAD"));
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
index cc804ba8e1e..c964154fb4d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -968,7 +968,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 static int add_pending_uninteresting_ref(const char *refname,
 					 const struct object_id *oid,
-					 int flags, void *cb_data)
+					 unsigned int unused_flags,
+					 void *cb_data)
 {
 	add_pending_oid(cb_data, refname, oid, UNINTERESTING);
 	return 0;
@@ -1077,16 +1078,17 @@ static int switch_branches(const struct checkout_opts *opts,
 	int ret = 0;
 	struct branch_info old_branch_info = { 0 };
 	struct object_id rev;
-	int flag, writeout_error = 0;
+	int writeout_error = 0;
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
@@ -1503,20 +1505,20 @@ static int checkout_branch(struct checkout_opts *opts,
 
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
-		int flag;
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
-		int flag;
+		unsigned int flags;
 
-		if (!read_ref_full("HEAD", 0, &rev, &flag) &&
-		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
+		if (!read_ref_full("HEAD", 0, &rev, &flags) &&
+		    (flags & REF_ISSYMREF) && is_null_oid(&rev))
 			return switch_unborn_to_new_branch(opts);
 	}
 	return switch_branches(opts, new_branch_info);
diff --git a/builtin/describe.c b/builtin/describe.c
index 42159cd26bd..c7b24390ca6 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -140,7 +140,8 @@ static void add_to_known_names(const char *path,
 	}
 }
 
-static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
+static int get_name(const char *path, const struct object_id *oid,
+		    unsigned int unused_flags, void *cb_data)
 {
 	int is_tag = 0;
 	struct object_id peeled;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e9..56b53ba3fff 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -323,9 +323,8 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
 	return ent;
 }
 
-static int add_one_refname(const char *refname,
-			   const struct object_id *oid,
-			   int flag, void *cbdata)
+static int add_one_refname(const char *refname, const struct object_id *oid,
+			   unsigned int unused_flags, void *cbdata)
 {
 	struct hashmap *refname_map = cbdata;
 
@@ -1429,9 +1428,8 @@ static void set_option(struct transport *transport, const char *name, const char
 			name, transport->url);
 }
 
-
-static int add_oid(const char *refname, const struct object_id *oid, int flags,
-		   void *cb_data)
+static int add_oid(const char *refname, const struct object_id *oid,
+		   unsigned int unused_flags, void *cb_data)
 {
 	struct oid_array *oids = cb_data;
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9e54892311d..c52bd1843d1 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -502,7 +502,7 @@ static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid
 }
 
 static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
-			      int flag, void *cb_data)
+			      unsigned int unused_flags, void *cb_data)
 {
 	struct strbuf refname = STRBUF_INIT;
 
@@ -513,7 +513,7 @@ static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
 }
 
 static int fsck_handle_ref(const char *refname, const struct object_id *oid,
-			   int flag, void *cb_data)
+			   unsigned int unused_flags, void *cb_data)
 {
 	struct object *obj;
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 8e60ef1eaba..983196dae26 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -768,9 +768,8 @@ struct cg_auto_data {
 	int limit;
 };
 
-static int dfs_on_ref(const char *refname,
-		      const struct object_id *oid, int flags,
-		      void *cb_data)
+static int dfs_on_ref(const char *refname, const struct object_id *oid,
+		      unsigned int unused_flags, void *cb_data)
 {
 	struct cg_auto_data *data = (struct cg_auto_data *)cb_data;
 	int result = 0;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 27f60153a6c..3a89589645a 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -305,7 +305,8 @@ static int cmp_by_tag_and_age(const void *a_, const void *b_)
 	return a->taggerdate != b->taggerdate;
 }
 
-static int name_ref(const char *path, const struct object_id *oid, int flags, void *cb_data)
+static int name_ref(const char *path, const struct object_id *oid,
+		    unsigned int unused_flags, void *cb_data)
 {
 	struct object *o = parse_object(the_repository, oid);
 	struct name_ref_data *data = cb_data;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba2006f2212..86bc62e68ed 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -758,8 +758,8 @@ static enum write_one_status write_one(struct hashfile *f,
 	return WRITE_ONE_WRITTEN;
 }
 
-static int mark_tagged(const char *path, const struct object_id *oid, int flag,
-		       void *cb_data)
+static int mark_tagged(const char *path, const struct object_id *oid,
+		       unsigned int unused_flags, void *cb_data)
 {
 	struct object_id peeled;
 	struct object_entry *entry = packlist_find(&to_pack, oid);
@@ -3012,7 +3012,8 @@ static void add_tag_chain(const struct object_id *oid)
 	}
 }
 
-static int add_ref_tag(const char *tag, const struct object_id *oid, int flag, void *cb_data)
+static int add_ref_tag(const char *tag, const struct object_id *oid,
+		       unsigned int unused_flags, void *cb_data)
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
index 36490d06c8a..01021d6e1a8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -999,7 +999,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = REBASE_OPTIONS_INIT;
 	const char *branch_name;
-	int ret, flags, total_argc, in_progress = 0;
+	int ret, total_argc, in_progress = 0;
 	int keep_base = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
@@ -1611,6 +1611,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	} else if (argc == 0) {
 		/* Do not need to switch branches, we are already on it. */
+		unsigned int flags;
 		options.head_name =
 			xstrdup_or_null(resolve_ref_unsafe("HEAD", 0, NULL,
 					 &flags));
@@ -1668,7 +1669,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
 		    &options.orig_head, &merge_base) &&
 	    allow_preemptive_ff) {
-		int flag;
+		unsigned int unused_flags;
 
 		if (!(options.flags & REBASE_FORCE)) {
 			/* Lazily switch to the target branch if needed... */
@@ -1693,7 +1694,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (!(options.flags & REBASE_NO_QUIET))
 				; /* be quiet */
 			else if (!strcmp(branch_name, "HEAD") &&
-				 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
+				 resolve_ref_unsafe("HEAD", 0, NULL,
+						    &unused_flags))
 				puts(_("HEAD is up to date."));
 			else
 				printf(_("Current branch %s is up to date.\n"),
@@ -1703,7 +1705,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		} else if (!(options.flags & REBASE_NO_QUIET))
 			; /* be quiet */
 		else if (!strcmp(branch_name, "HEAD") &&
-			 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
+			 resolve_ref_unsafe("HEAD", 0, NULL, &unused_flags))
 			puts(_("HEAD is up to date, rebase forced."));
 		else
 			printf(_("Current branch %s is up to date, rebase "
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816cf..aa000ada17f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -291,7 +291,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 }
 
 static int show_ref_cb(const char *path_full, const struct object_id *oid,
-		       int flag, void *data)
+		       unsigned int unused_flags, void *data)
 {
 	struct oidset *seen = data;
 	const char *path = strip_namespace(path_full);
@@ -1655,12 +1655,13 @@ static void run_update_post_hook(struct command *commands)
 
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
@@ -1701,11 +1702,11 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *dst_name;
-	int flag;
+	unsigned int flags;
 
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
-	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flag);
-	check_aliased_update_internal(cmd, list, dst_name, flag);
+	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flags);
+	check_aliased_update_internal(cmd, list, dst_name, flags);
 	strbuf_release(&buf);
 }
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index a4b1dd27e13..ddb5b6fb788 100644
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
+			  unsigned int unused_flags, void *cb_data)
 {
 	struct worktree_reflogs *cb = cb_data;
 	struct worktree *worktree = cb->worktree;
diff --git a/builtin/remote.c b/builtin/remote.c
index 299c466116d..6e509e276cd 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -533,7 +533,8 @@ struct branches_for_remote {
 };
 
 static int add_branch_for_removal(const char *refname,
-	const struct object_id *oid, int flags, void *cb_data)
+				  const struct object_id *oid,
+				  unsigned int unused_flags, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec_item refspec;
@@ -574,20 +575,21 @@ struct rename_info {
 };
 
 static int read_remote_branches(const char *refname,
-	const struct object_id *oid, int flags, void *cb_data)
+				const struct object_id *oid,
+				unsigned int unused_flags, void *cb_data)
 {
 	struct rename_info *rename = cb_data;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
-	int flag;
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
@@ -766,10 +768,10 @@ static int mv(int argc, const char **argv)
 	for_each_ref(read_remote_branches, &rename);
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
-		int flag = 0;
+		unsigned int flags = 0;
 
-		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flag);
-		if (!(flag & REF_ISSYMREF))
+		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flags);
+		if (!(flags & REF_ISSYMREF))
 			continue;
 		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
 			die(_("deleting '%s' failed"), item->string);
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
index da1e364a756..f995f829970 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -465,7 +465,7 @@ struct midx_snapshot_ref_data {
 
 static int midx_snapshot_ref_one(const char *refname,
 				 const struct object_id *oid,
-				 int flag, void *_data)
+				 unsigned int unused_flag, void *_data)
 {
 	struct midx_snapshot_ref_data *data = _data;
 	struct object_id peeled;
diff --git a/builtin/replace.c b/builtin/replace.c
index 6ff1734d587..af35b9f27ad 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -41,7 +41,7 @@ struct show_data {
 
 static int show_reference(struct repository *r, const char *refname,
 			  const struct object_id *oid,
-			  int flag, void *cb_data)
+			  unsigned int unused_flags, void *cb_data)
 {
 	struct show_data *data = cb_data;
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8480a59f573..46f09c25db6 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -195,7 +195,8 @@ static int show_default(void)
 	return 0;
 }
 
-static int show_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int show_reference(const char *refname, const struct object_id *oid,
+			  unsigned int unused_flags, void *cb_data)
 {
 	if (ref_excluded(ref_excludes, refname))
 		return 0;
@@ -203,7 +204,8 @@ static int show_reference(const char *refname, const struct object_id *oid, int
 	return 0;
 }
 
-static int anti_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int anti_reference(const char *refname, const struct object_id *oid,
+			  unsigned int unused_flags, void *cb_data)
 {
 	show_rev(REVERSED, oid, refname);
 	return 0;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e12c5e80e3e..8c392afcd74 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -403,7 +403,7 @@ static int append_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_head_ref(const char *refname, const struct object_id *oid,
-			   int flag, void *cb_data)
+			   unsigned int unused_flags, void *cb_data)
 {
 	struct object_id tmp;
 	int ofs = 11;
@@ -418,7 +418,7 @@ static int append_head_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_remote_ref(const char *refname, const struct object_id *oid,
-			     int flag, void *cb_data)
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
-			       int flag, void *cb_data)
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
index 7f8a5332f83..ff017b1202a 100644
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
+			unsigned int unused_flags, void *cbdata)
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
index c5d3fc3817f..0a2755c8eee 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -738,8 +738,8 @@ static void print_status(unsigned int flags, char state, const char *path,
 }
 
 static int handle_submodule_head_ref(const char *refname,
-				     const struct object_id *oid, int flags,
-				     void *cb_data)
+				     const struct object_id *oid,
+				     unsigned int unused_flags, void *cb_data)
 {
 	struct object_id *output = cb_data;
 	if (oid)
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index e547a08d6c7..478ae36b4da 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -12,12 +12,12 @@ static const char * const git_symbolic_ref_usage[] = {
 
 static int check_symref(const char *HEAD, int quiet, int shorten, int print)
 {
-	int flag;
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
index a0bb687b0f4..a6658dab789 100644
--- a/bundle.c
+++ b/bundle.c
@@ -371,15 +371,15 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		struct object_id oid;
 		char *ref;
 		const char *display_ref;
-		int flag;
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
index aa98b2e5414..b53b8dc7f4a 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -365,7 +365,7 @@ static void add_ref_to_island(const char *island_name, const struct object_id *o
 }
 
 static int find_island_for_ref(const char *refname, const struct object_id *oid,
-			       int flags, void *data)
+			       unsigned int unused_flags, void *data)
 {
 	/*
 	 * We should advertise 'ARRAY_SIZE(matches) - 2' as the max,
diff --git a/fetch-pack.c b/fetch-pack.c
index dd6ec449f2d..1f3dce5860f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -164,8 +164,9 @@ static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 	return 0;
 }
 
-static int rev_list_insert_ref_oid(const char *refname, const struct object_id *oid,
-				   int flag, void *cb_data)
+static int rev_list_insert_ref_oid(const char *refname,
+				   const struct object_id *oid,
+				   unsigned int unused_flags, void *cb_data)
 {
 	return rev_list_insert_ref(cb_data, oid);
 }
@@ -548,7 +549,7 @@ static int mark_complete(const struct object_id *oid)
 }
 
 static int mark_complete_oid(const char *refname, const struct object_id *oid,
-			     int flag, void *cb_data)
+			     unsigned int unused_flags, void *cb_data)
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
index 807fb8839e7..351a124333b 100644
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
@@ -559,11 +559,11 @@ static void get_info_refs(struct strbuf *hdr, char *arg)
 }
 
 static int show_head_ref(const char *refname, const struct object_id *oid,
-			 int flag, void *cb_data)
+			 unsigned int flags, void *cb_data)
 {
 	struct strbuf *buf = cb_data;
 
-	if (flag & REF_ISSYMREF) {
+	if (flags & REF_ISSYMREF) {
 		const char *target = resolve_ref_unsafe(refname,
 							RESOLVE_REF_READING,
 							NULL, NULL);
diff --git a/log-tree.c b/log-tree.c
index d3e7a40b648..4d2b74cf754 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -131,7 +131,7 @@ static int ref_filter_match(const char *refname,
 }
 
 static int add_ref_decoration(const char *refname, const struct object_id *oid,
-			      int flags, void *cb_data)
+			      unsigned int unused_flags, void *cb_data)
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
index 54078323dcb..3abdccb9394 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -76,7 +76,7 @@ struct ls_refs_data {
 };
 
 static int send_ref(const char *refname, const struct object_id *oid,
-		    int flag, void *cb_data)
+		    unsigned int flags, void *cb_data)
 {
 	struct ls_refs_data *data = cb_data;
 	const char *refname_nons = strip_namespace(refname);
@@ -93,11 +93,10 @@ static int send_ref(const char *refname, const struct object_id *oid,
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
@@ -122,16 +121,17 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 {
 	struct strbuf namespaced = STRBUF_INIT;
 	struct object_id oid;
-	int flag;
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
index 837b46b2af5..003bcce7633 100644
--- a/midx.c
+++ b/midx.c
@@ -922,14 +922,13 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 	}
 }
 
-static int add_ref_to_pending(const char *refname,
-			      const struct object_id *oid,
-			      int flag, void *cb_data)
+static int add_ref_to_pending(const char *refname, const struct object_id *oid,
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
index 434189ae5dc..7ddc40e480b 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -36,7 +36,7 @@ static void rev_list_push(struct negotiation_state *ns,
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
-		       int flag, void *cb_data)
+		       unsigned int unused_flags, void *cb_data)
 {
 	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
 
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 1236e792248..6ac6310b247 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -72,7 +72,7 @@ static struct entry *rev_list_push(struct data *data, struct commit *commit, int
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
-		       int flag, void *cb_data)
+		       unsigned int unused_flags, void *cb_data)
 {
 	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
 
diff --git a/notes.c b/notes.c
index f87dac40684..df41b004f49 100644
--- a/notes.c
+++ b/notes.c
@@ -924,8 +924,9 @@ out:
 	return ret;
 }
 
-static int string_list_add_one_ref(const char *refname, const struct object_id *oid,
-				   int flag, void *cb)
+static int string_list_add_one_ref(const char *refname,
+				   const struct object_id *oid,
+				   unsigned int unused_flags, void *cb)
 {
 	struct string_list *refs = cb;
 	if (!unsorted_string_list_has_string(refs, refname))
diff --git a/object-name.c b/object-name.c
index fdff4601b2c..d89b4ed9f3e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1208,7 +1208,7 @@ struct handle_one_ref_cb {
 };
 
 static int handle_one_ref(const char *path, const struct object_id *oid,
-			  int flag, void *cb_data)
+			  unsigned int unused_flags, void *cb_data)
 {
 	struct handle_one_ref_cb *cb = cb_data;
 	struct commit_list **list = cb->list;
diff --git a/reachable.c b/reachable.c
index 84e3d0d75ed..fc04a57cbf6 100644
--- a/reachable.c
+++ b/reachable.c
@@ -27,12 +27,12 @@ static void update_progress(struct connectivity_progress *cp)
 }
 
 static int add_one_ref(const char *path, const struct object_id *oid,
-		       int flag, void *cb_data)
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
index f7a2f17bfd9..addb7a237a4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2233,7 +2233,8 @@ struct ref_filter_cbdata {
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int ref_filter_handler(const char *refname, const struct object_id *oid,
+			      unsigned int flags, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_filter *filter = ref_cbdata->filter;
@@ -2241,12 +2242,12 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
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
@@ -2289,7 +2290,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 */
 	ref = ref_array_push(ref_cbdata->array, refname, oid);
 	ref->commit = commit;
-	ref->flag = flag;
+	ref->flag = flags;
 	ref->kind = kind;
 
 	return 0;
diff --git a/refs.c b/refs.c
index addb26293b4..3178a0cbdef 100644
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
+			  unsigned int resolve_flags, struct object_id *oid,
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
@@ -439,11 +441,11 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
 	struct object_id oid;
-	int flag;
+	unsigned int flags;
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flag))
-		ret = fn(buf.buf, &oid, flag, cb_data);
+	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flags))
+		ret = fn(buf.buf, &oid, flags, cb_data);
 	strbuf_release(&buf);
 
 	return ret;
@@ -654,7 +656,7 @@ int expand_ref(struct repository *repo, const char *str, int len,
 	for (p = ref_rev_parse_rules; *p; p++) {
 		struct object_id oid_from_ref;
 		struct object_id *this_result;
-		int flag;
+		unsigned int flags;
 		struct ref_store *refs = get_main_ref_store(repo);
 		int ignore_errno;
 
@@ -662,17 +664,17 @@ int expand_ref(struct repository *repo, const char *str, int len,
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
 		r = refs_resolve_ref_unsafe(refs, fullref.buf,
-					    RESOLVE_REF_READING,
-					    this_result, &flag,
-					    &ignore_errno);
+					    RESOLVE_REF_READING, this_result,
+					    &flags, &ignore_errno);
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
@@ -1389,12 +1391,12 @@ const char *find_descendant_ref(const char *dirname,
 int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
-	int flag;
+	unsigned int flags;
 	int ignore_errno;
 
-	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
-				    &oid, &flag, &ignore_errno))
-		return fn("HEAD", &oid, flag, cb_data);
+	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING, &oid,
+				    &flags, &ignore_errno))
+		return fn("HEAD", &oid, flags, cb_data);
 
 	return 0;
 }
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
 
@@ -1678,15 +1678,14 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 					   type, failure_errno);
 }
 
-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    struct object_id *oid,
-				    int *flags, int *failure_errno)
+const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
+				    unsigned int resolve_flags,
+				    struct object_id *oid, unsigned int *flags,
+				    int *failure_errno)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
-	int unused_flags;
+	unsigned int unused_flags;
 	int symref_count;
 
 	assert(failure_errno);
@@ -1781,8 +1780,8 @@ int refs_init_db(struct strbuf *err)
 	return refs->be->init_db(refs, err);
 }
 
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       struct object_id *oid, int *flags)
+const char *resolve_ref_unsafe(const char *refname, unsigned int resolve_flags,
+			       struct object_id *oid, unsigned int *flags)
 {
 	int ignore_errno;
 
@@ -1794,7 +1793,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 			struct object_id *oid)
 {
 	struct ref_store *refs;
-	int flags;
+	unsigned int unused_flags;
 	int ignore_errno;
 
 	refs = get_submodule_ref_store(submodule);
@@ -1802,8 +1801,9 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	if (!refs)
 		return -1;
 
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags,
-				     &ignore_errno) || is_null_oid(oid))
+	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &unused_flags,
+				     &ignore_errno) ||
+	    is_null_oid(oid))
 		return -1;
 	return 0;
 }
diff --git a/refs.h b/refs.h
index 8f91a7f9ff2..6a4ef87b99e 100644
--- a/refs.h
+++ b/refs.h
@@ -68,23 +68,22 @@ struct worktree;
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 
-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    struct object_id *oid,
-				    int *flags, int *failure_errno);
-
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       struct object_id *oid, int *flags);
-
-char *refs_resolve_refdup(struct ref_store *refs,
-			  const char *refname, int resolve_flags,
-			  struct object_id *oid, int *flags);
-char *resolve_refdup(const char *refname, int resolve_flags,
-		     struct object_id *oid, int *flags);
-
-int read_ref_full(const char *refname, int resolve_flags,
-		  struct object_id *oid, int *flags);
+const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
+				    unsigned int resolve_flags,
+				    struct object_id *oid, unsigned int *flags,
+				    int *failure_errno);
+
+const char *resolve_ref_unsafe(const char *refname, unsigned int resolve_flags,
+			       struct object_id *oid, unsigned int *flags);
+
+char *refs_resolve_refdup(struct ref_store *refs, const char *refname,
+			  unsigned int resolve_flags, struct object_id *oid,
+			  unsigned int *flags);
+char *resolve_refdup(const char *refname, unsigned int resolve_flags,
+		     struct object_id *oid, unsigned int *flags);
+
+int read_ref_full(const char *refname, unsigned int resolve_flags,
+		  struct object_id *oid, unsigned int *flags);
 int read_ref(const char *refname, struct object_id *oid);
 
 /*
@@ -298,17 +297,15 @@ struct ref_transaction;
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
@@ -532,7 +529,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data);
  * allow a single "*" wildcard character in the refspec. No leading or
  * repeated slashes are accepted.
  */
-int check_refname_format(const char *refname, int flags);
+int check_refname_format(const char *refname, unsigned int flags);
 
 /*
  * Apply the rules from check_refname_format, but mutate the result until it
@@ -896,7 +893,7 @@ struct ref_store *get_main_ref_store(struct repository *r);
  *
  * ----
  * static int handle_remote_ref(const char *refname,
- * 		const unsigned char *sha1, int flags, void *cb_data)
+ * 		const unsigned char *sha1, unsigned int flags, void *cb_data)
  * {
  * 	struct strbuf *output = cb_data;
  * 	strbuf_addf(output, "%s\n", refname);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 43a3b882d7c..8890e2f684c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -261,7 +261,6 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	while ((de = readdir(d)) != NULL) {
 		struct object_id oid;
 		struct stat st;
-		int flag;
 
 		if (de->d_name[0] == '.')
 			continue;
@@ -278,12 +277,12 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 							  refname.len));
 		} else {
 			int ignore_errno;
-			if (!refs_resolve_ref_unsafe(&refs->base,
-						     refname.buf,
-						     RESOLVE_REF_READING,
-						     &oid, &flag, &ignore_errno)) {
+			unsigned int flags;
+			if (!refs_resolve_ref_unsafe(&refs->base, refname.buf,
+						     RESOLVE_REF_READING, &oid,
+						     &flags, &ignore_errno)) {
 				oidclr(&oid);
-				flag |= REF_ISBROKEN;
+				flags |= REF_ISBROKEN;
 			} else if (is_null_oid(&oid)) {
 				/*
 				 * It is so astronomically unlikely
@@ -293,7 +292,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 				 * file to be repo corruption
 				 * (probably due to a software bug).
 				 */
-				flag |= REF_ISBROKEN;
+				flags |= REF_ISBROKEN;
 			}
 
 			if (check_refname_format(refname.buf,
@@ -301,10 +300,10 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
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
@@ -1391,7 +1390,8 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
 	struct object_id orig_oid;
-	int flag = 0, logmoved = 0;
+	int logmoved = 0;
+	unsigned int flags = 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
 	struct strbuf sb_oldref = STRBUF_INIT;
@@ -1412,13 +1412,14 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 
 	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
-				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				     &orig_oid, &flag, &ignore_errno)) {
+				     RESOLVE_REF_READING |
+					     RESOLVE_REF_NO_RECURSE,
+				     &orig_oid, &flags, &ignore_errno)) {
 		ret = error("refname %s not found", oldrefname);
 		goto out;
 	}
 
-	if (flag & REF_ISSYMREF) {
+	if (flags & REF_ISSYMREF) {
 		if (copy)
 			ret = error("refname %s is a symbolic ref, copying it is not supported",
 				    oldrefname);
@@ -1514,14 +1515,14 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
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
@@ -1702,9 +1703,10 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
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
 
@@ -1826,15 +1828,14 @@ static int commit_ref_update(struct files_ref_store *refs,
 		 * check with HEAD only which should cover 99% of all usage
 		 * scenarios (even 100% of the default ones).
 		 */
-		int head_flag;
+		unsigned int head_flags;
 		const char *head_ref;
 		int ignore_errno;
 
 		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
-						   RESOLVE_REF_READING,
-						   NULL, &head_flag,
-						   &ignore_errno);
-		if (head_ref && (head_flag & REF_ISSYMREF) &&
+						   RESOLVE_REF_READING, NULL,
+						   &head_flags, &ignore_errno);
+		if (head_ref && (head_flags & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
 			if (files_log_ref_write(refs, "HEAD",
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
+		       unsigned int unused_flags, void *cb_data)
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
index a6d8ec6c1ac..d889241ce0a 100644
--- a/remote.c
+++ b/remote.c
@@ -500,7 +500,7 @@ static void alias_all_urls(struct remote_state *remote_state)
 
 static void read_config(struct repository *repo)
 {
-	int flag;
+	unsigned int flags;
 
 	if (repo->remote_state->initialized)
 		return;
@@ -510,8 +510,9 @@ static void read_config(struct repository *repo)
 	if (startup_info->have_repository) {
 		int ignore_errno;
 		const char *head_ref = refs_resolve_ref_unsafe(
-			get_main_ref_store(repo), "HEAD", 0, NULL, &flag, &ignore_errno);
-		if (head_ref && (flag & REF_ISSYMREF) &&
+			get_main_ref_store(repo), "HEAD", 0, NULL, &flags,
+			&ignore_errno);
+		if (head_ref && (flags & REF_ISSYMREF) &&
 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
 			repo->remote_state->current_branch = make_branch(
 				repo->remote_state, head_ref, strlen(head_ref));
@@ -1272,14 +1273,12 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		return -1;
 
 	if (!dst_value) {
-		int flag;
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
@@ -1948,11 +1947,11 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
 
 static int ignore_symref_update(const char *refname)
 {
-	int flag;
+	unsigned int flags;
 
-	if (!resolve_ref_unsafe(refname, 0, NULL, &flag))
+	if (!resolve_ref_unsafe(refname, 0, NULL, &flags))
 		return 0; /* non-existing refs are OK */
-	return (flag & REF_ISSYMREF);
+	return (flags & REF_ISSYMREF);
 }
 
 /*
@@ -2288,7 +2287,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 }
 
 static int one_local_ref(const char *refname, const struct object_id *oid,
-			 int flag, void *cb_data)
+			 unsigned int flag, void *cb_data)
 {
 	struct ref ***local_tail = cb_data;
 	struct ref *ref;
@@ -2369,7 +2368,7 @@ struct stale_heads_info {
 };
 
 static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
-			      int flags, void *cb_data)
+			      unsigned int flags, void *cb_data)
 {
 	struct stale_heads_info *info = cb_data;
 	struct string_list matches = STRING_LIST_INIT_DUP;
diff --git a/replace-object.c b/replace-object.c
index 7bd9aba6ee6..d00486305a5 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -6,10 +6,9 @@
 #include "repository.h"
 #include "commit.h"
 
-static int register_replace_ref(struct repository *r,
-				const char *refname,
+static int register_replace_ref(struct repository *r, const char *refname,
 				const struct object_id *oid,
-				int flag, void *cb_data)
+				unsigned int unused_flags, void *cb_data)
 {
 	/* Get sha1 from refname */
 	const char *slash = strrchr(refname, '/');
diff --git a/revision.c b/revision.c
index ad4286fbdde..4b6f7f112a8 100644
--- a/revision.c
+++ b/revision.c
@@ -1527,7 +1527,7 @@ int ref_excluded(struct string_list *ref_excludes, const char *path)
 }
 
 static int handle_one_ref(const char *path, const struct object_id *oid,
-			  int flag, void *cb_data)
+			  unsigned int unused_flags, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	struct object *object;
@@ -1612,7 +1612,7 @@ static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 
 static int handle_one_reflog(const char *refname_in_wt,
 			     const struct object_id *oid,
-			     int flag, void *cb_data)
+			     unsigned int unused_flags, void *cb_data)
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
index 7701d7c20a1..06e3eb388ea 100644
--- a/server-info.c
+++ b/server-info.c
@@ -147,7 +147,7 @@ out:
 }
 
 static int add_info_ref(const char *path, const struct object_id *oid,
-			int flag, void *cb_data)
+			unsigned int unused_flags, void *cb_data)
 {
 	struct update_info_ctx *uic = cb_data;
 	struct object *o = parse_object(the_repository, oid);
diff --git a/shallow.c b/shallow.c
index 9ed18eb8849..709e265dde7 100644
--- a/shallow.c
+++ b/shallow.c
@@ -596,7 +596,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 }
 
 static int mark_uninteresting(const char *refname, const struct object_id *oid,
-			      int flags, void *cb_data)
+			      unsigned int unused_flags, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
 							       oid, 1);
@@ -707,7 +707,7 @@ struct commit_array {
 };
 
 static int add_ref(const char *refname, const struct object_id *oid,
-		   int flags, void *cb_data)
+		   unsigned int unused_flags, void *cb_data)
 {
 	struct commit_array *ca = cb_data;
 	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
diff --git a/submodule.c b/submodule.c
index c6890705241..325cfc7cd4b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -909,7 +909,7 @@ static void free_submodules_oids(struct string_list *submodules)
 }
 
 static int has_remote(const char *refname, const struct object_id *oid,
-		      int flags, void *cb_data)
+		      unsigned int unused_flags, void *cb_data)
 {
 	return 1;
 }
@@ -1216,7 +1216,7 @@ int push_unpushed_submodules(struct repository *r,
 }
 
 static int append_oid_to_array(const char *ref, const struct object_id *oid,
-			       int flags, void *data)
+			       unsigned int unused_flags, void *data)
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
index a0297b0986c..b31c1198b8e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1090,13 +1090,15 @@ static int push_refs_with_export(struct transport *transport,
 			if (strcmp(ref->name, ref->peer_ref->name)) {
 				if (!ref->deletion) {
 					const char *name;
-					int flag;
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
index 2a3e3241545..00f4906e12b 100644
--- a/transport.c
+++ b/transport.c
@@ -80,7 +80,7 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		const char *localname;
 		const char *tmp;
 		const char *remotename;
-		int flag = 0;
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
index 8acc98741bb..6300af75f20 100644
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
+		     unsigned int unused_flags, void *cb_data)
 {
 	const char *refname = strip_namespace(refname_full);
 
@@ -1193,7 +1193,7 @@ static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
 }
 
 static int send_ref(const char *refname, const struct object_id *oid,
-		    int flag, void *cb_data)
+		    unsigned int unused_flags, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
@@ -1236,15 +1236,15 @@ static int send_ref(const char *refname, const struct object_id *oid,
 }
 
 static int find_symref(const char *refname, const struct object_id *oid,
-		       int flag, void *cb_data)
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
index c5e29219795..af8ce53a15b 100644
--- a/walker.c
+++ b/walker.c
@@ -216,7 +216,7 @@ static int interpret_target(struct walker *walker, char *target, struct object_i
 }
 
 static int mark_complete(const char *path, const struct object_id *oid,
-			 int flag, void *cb_data)
+			 unsigned int unused_flags, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
 							       oid, 1);
diff --git a/worktree.c b/worktree.c
index 6f598dcfcdf..1c92993952a 100644
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
+		unsigned int flags;
 		int ignore_errno;
 
 		if (wt->is_current)
@@ -571,10 +571,9 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 		strbuf_reset(&refname);
 		strbuf_worktree_ref(wt, &refname, "HEAD");
 		if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-					    refname.buf,
-					    RESOLVE_REF_READING,
-					    &oid, &flag, &ignore_errno))
-			ret = fn(refname.buf, &oid, flag, cb_data);
+					    refname.buf, RESOLVE_REF_READING,
+					    &oid, &flags, &ignore_errno))
+			ret = fn(refname.buf, &oid, flags, cb_data);
 		if (ret)
 			break;
 	}

base-commit: 5d01301f2b865aa8dba1654d3f447ce9d21db0b5
-- 
gitgitgadget
