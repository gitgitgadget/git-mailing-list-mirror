Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95D4F208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 19:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbeHFVmP (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 17:42:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39941 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733255AbeHFVmO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 17:42:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so5722365edq.7
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shHAaM8WBnbtIQwssKN9GYKku4hoHluu1PfnpKRG/YM=;
        b=nmHQkb8xGuzjJIvjVf/0qdm90ymsFceKxRCr1FS6voResL6yKdvYoyf/i5livsKzq/
         FBH5ExE3103n0NRZm4UWLAK2O/10QbeiD6sOp/ab1B/jaklgIUBvb30ad6lh0hR8m/mx
         /DHy42vZnloJURRgSR1tJic21MDUg+NI4A8hvwLAWZUtPmBE9fQn8Ei8YaaEpSYhpvfI
         31jCpighXhBMNJN6DD28O6GrIhtzmO+0DepLoSKRRGzUfPYukmuOI3r1OAJwfdWj7MA7
         UQ0zZ015yPkUqRxodN1iEwJrEcy3Yl27mYgkCejeubWtKStTfrvBp4cgdIzM+SnJNEfs
         +4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shHAaM8WBnbtIQwssKN9GYKku4hoHluu1PfnpKRG/YM=;
        b=W5sIOBb91lh7H+OB8ym2ldKxFmJvgus8cwTeUu5hOO8pT3GHb7ngx3mImRw6yBMaKE
         9nIW1IV7kYxQYE5lAGEzsrZRwaOmYq60FLI/O631MUtC+AfGVVN3cgfDimrahx/1w23P
         4CU+lJRHA5T7l/EBgW9dyA6bQyyLQTmyip8HdY7ngtA1AsOV7NU3ZWMGQT+ZNtRQgl0e
         ZX6Fx7WPren5Rs+s0RrINKYVfjuAZyCVX4Ub8dox6hmx9Jwm1dfS2uWf2tg0IoJQH3MG
         M5H6VkUoCjLPRI8/gHG7lG3NsTweHQnoABkZq8T98/zEKsUW6fwt+nKirRzK8RM6OTlc
         /1dw==
X-Gm-Message-State: AOUpUlFQGmA+CEzBwSu8T2ta2gdo/9JUNQDv6Fhh6pBVATmGfB3SS8kU
        yhxvO6KjLsm90fIszA3B7YbCMtdy
X-Google-Smtp-Source: AAOMgpeHCFXBgUZr2GEhiIpr7m4P7N/Qjuj3JU1QhQd6Yq+hfzr2sV1BfwK5SvZIns9u1ddCs2LlFQ==
X-Received: by 2002:a50:99db:: with SMTP id n27-v6mr19487727edb.111.1533583898503;
        Mon, 06 Aug 2018 12:31:38 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.100])
        by smtp.gmail.com with ESMTPSA id x13-v6sm15485811edx.17.2018.08.06.12.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 12:31:37 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH v6 3/3] builtin/rebase: support running "git rebase <upstream>"
Date:   Tue,  7 Aug 2018 01:16:11 +0545
Message-Id: <20180806193111.12229-4-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806193111.12229-1-predatoramigo@gmail.com>
References: <20180730162920.20318-1-predatoramigo@gmail.com>
 <20180806193111.12229-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch gives life to the skeleton added in the previous patches:
With this change, we can perform a elementary rebase (without any
options).

It can be tested thusly by:

git -c rebase.usebuiltin=true rebase HEAD~2

The rebase backends (i.e. the shell script functions defined in
`git-rebase--<backend>`) are still at work here and the "builtin
rebase"'s purpose is simply to parse the options and set
everything up so that those rebase backends can do their work.

Note: We take an alternative approach here which is *not* to set the
environment variables via `run_command_v_opt_cd_env()` because those
variables would then be visible by processes spawned from the rebase
backends. Instead, we work hard to set them in the shell script snippet.
On Windows, some of the tests fail merely due to core.fileMode not
being heeded that's why the core.*config variables is parsed here.

The `reset_head()` function is currently only used to detach the HEAD
to onto by way of starting the rebase, but it offers additional
functionality that subsequent patches will need like moving to the
original branch (possibly updating it) and also to do the equivalent of
`git reset --hard`.

The next commits will handle and support all the wonderful rebase
options.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 365 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 364 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c44addb2a4..e695d8a430 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -9,6 +9,24 @@
 #include "exec-cmd.h"
 #include "argv-array.h"
 #include "dir.h"
+#include "packfile.h"
+#include "refs.h"
+#include "quote.h"
+#include "config.h"
+#include "cache-tree.h"
+#include "unpack-trees.h"
+#include "lockfile.h"
+
+static GIT_PATH_FUNC(apply_dir, "rebase-apply")
+static GIT_PATH_FUNC(merge_dir, "rebase-merge")
+
+enum rebase_type {
+	REBASE_UNSPECIFIED = -1,
+	REBASE_AM,
+	REBASE_MERGE,
+	REBASE_INTERACTIVE,
+	REBASE_PRESERVE_MERGES
+};
 
 static int use_builtin_rebase(void)
 {
@@ -30,8 +48,260 @@ static int use_builtin_rebase(void)
 	return ret;
 }
 
+static int apply_autostash(void)
+{
+	warning("TODO");
+	return 0;
+}
+
+struct rebase_options {
+	enum rebase_type type;
+	const char *state_dir;
+	struct commit *upstream;
+	const char *upstream_name;
+	char *head_name;
+	struct object_id orig_head;
+	struct commit *onto;
+	const char *onto_name;
+	const char *revisions;
+	int root;
+	struct commit *restrict_revision;
+	int dont_finish_rebase;
+};
+
+/* Returns the filename prefixed by the state_dir */
+static const char *state_dir_path(const char *filename, struct rebase_options *opts)
+{
+	static struct strbuf path = STRBUF_INIT;
+	static size_t prefix_len;
+
+	if (!prefix_len) {
+		strbuf_addf(&path, "%s/", opts->state_dir);
+		prefix_len = path.len;
+	}
+
+	strbuf_setlen(&path, prefix_len);
+	strbuf_addstr(&path, filename);
+	return path.buf;
+}
+
+static int finish_rebase(struct rebase_options *opts)
+{
+	struct strbuf dir = STRBUF_INIT;
+	const char *argv_gc_auto[] = { "gc", "--auto", NULL };
+
+	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+	apply_autostash();
+	close_all_packs(the_repository->objects);
+	/*
+	 * We ignore errors in 'gc --auto', since the
+	 * user should see them.
+	 */
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	strbuf_addstr(&dir, opts->state_dir);
+	remove_dir_recursively(&dir, 0);
+	strbuf_release(&dir);
+
+	return 0;
+}
+
+static struct commit *peel_committish(const char *name)
+{
+	struct object *obj;
+	struct object_id oid;
+
+	if (get_oid(name, &oid))
+		return NULL;
+	obj = parse_object(the_repository, &oid);
+	return (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
+}
+
+static void add_var(struct strbuf *buf, const char *name, const char *value)
+{
+	if (!value)
+		strbuf_addf(buf, "unset %s; ", name);
+	else {
+		strbuf_addf(buf, "%s=", name);
+		sq_quote_buf(buf, value);
+		strbuf_addstr(buf, "; ");
+	}
+}
+
+static int run_specific_rebase(struct rebase_options *opts)
+{
+	const char *argv[] = { NULL, NULL };
+	struct strbuf script_snippet = STRBUF_INIT;
+	int status;
+	const char *backend, *backend_func;
+
+	add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
+	add_var(&script_snippet, "state_dir", opts->state_dir);
+
+	add_var(&script_snippet, "upstream_name", opts->upstream_name);
+	add_var(&script_snippet, "upstream",
+				 oid_to_hex(&opts->upstream->object.oid));
+	add_var(&script_snippet, "head_name", opts->head_name);
+	add_var(&script_snippet, "orig_head", oid_to_hex(&opts->orig_head));
+	add_var(&script_snippet, "onto", oid_to_hex(&opts->onto->object.oid));
+	add_var(&script_snippet, "onto_name", opts->onto_name);
+	add_var(&script_snippet, "revisions", opts->revisions);
+	add_var(&script_snippet, "restrict_revision", opts->restrict_revision ?
+		oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
+
+	switch (opts->type) {
+	case REBASE_AM:
+		backend = "git-rebase--am";
+		backend_func = "git_rebase__am";
+		break;
+	case REBASE_INTERACTIVE:
+		backend = "git-rebase--interactive";
+		backend_func = "git_rebase__interactive";
+		break;
+	case REBASE_MERGE:
+		backend = "git-rebase--merge";
+		backend_func = "git_rebase__merge";
+		break;
+	case REBASE_PRESERVE_MERGES:
+		backend = "git-rebase--preserve-merges";
+		backend_func = "git_rebase__preserve_merges";
+		break;
+	default:
+		BUG("Unhandled rebase type %d", opts->type);
+		break;
+	}
+
+	strbuf_addf(&script_snippet,
+		    ". git-sh-setup && . git-rebase--common &&"
+		    " . %s && %s", backend, backend_func);
+	argv[0] = script_snippet.buf;
+
+	status = run_command_v_opt(argv, RUN_USING_SHELL);
+	if (opts->dont_finish_rebase)
+		; /* do nothing */
+	else if (status == 0) {
+		if (!file_exists(state_dir_path("stopped-sha", opts)))
+			finish_rebase(opts);
+	} else if (status == 2) {
+		struct strbuf dir = STRBUF_INIT;
+
+		apply_autostash();
+		strbuf_addstr(&dir, opts->state_dir);
+		remove_dir_recursively(&dir, 0);
+		strbuf_release(&dir);
+		die("Nothing to do");
+	}
+
+	strbuf_release(&script_snippet);
+
+	return status ? -1 : 0;
+}
+
+#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
+
+static int reset_head(struct object_id *oid, const char *action,
+		      const char *switch_to_branch, int detach_head)
+{
+	struct object_id head_oid;
+	struct tree_desc desc;
+	struct lock_file lock = LOCK_INIT;
+	struct unpack_trees_options unpack_tree_opts;
+	struct tree *tree;
+	const char *reflog_action;
+	struct strbuf msg = STRBUF_INIT;
+	size_t prefix_len;
+	struct object_id *orig = NULL, oid_orig,
+		*old_orig = NULL, oid_old_orig;
+	int ret = 0;
+
+	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
+		return -1;
+
+	if (!oid) {
+		if (get_oid("HEAD", &head_oid)) {
+			rollback_lock_file(&lock);
+			return error(_("could not determine HEAD revision"));
+		}
+		oid = &head_oid;
+	}
+
+	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
+	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
+	unpack_tree_opts.head_idx = 1;
+	unpack_tree_opts.src_index = the_repository->index;
+	unpack_tree_opts.dst_index = the_repository->index;
+	unpack_tree_opts.fn = oneway_merge;
+	unpack_tree_opts.update = 1;
+	unpack_tree_opts.merge = 1;
+	if (!detach_head)
+		unpack_tree_opts.reset = 1;
+
+	if (read_index_unmerged(the_repository->index) < 0) {
+		rollback_lock_file(&lock);
+		return error(_("could not read index"));
+	}
+
+	if (!fill_tree_descriptor(&desc, oid)) {
+		error(_("failed to find tree of %s"), oid_to_hex(oid));
+		rollback_lock_file(&lock);
+		free((void *)desc.buffer);
+		return -1;
+	}
+
+	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
+		rollback_lock_file(&lock);
+		free((void *)desc.buffer);
+		return -1;
+	}
+
+	tree = parse_tree_indirect(oid);
+	prime_cache_tree(the_repository->index, tree);
+
+	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0)
+		ret = error(_("could not write index"));
+	free((void *)desc.buffer);
+
+	if (ret)
+		return ret;
+
+	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
+	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
+	prefix_len = msg.len;
+
+	if (!get_oid("ORIG_HEAD", &oid_old_orig))
+		old_orig = &oid_old_orig;
+	if (!get_oid("HEAD", &oid_orig)) {
+		orig = &oid_orig;
+		strbuf_addstr(&msg, "updating ORIG_HEAD");
+		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
+			   UPDATE_REFS_MSG_ON_ERR);
+	} else if (old_orig)
+		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+	strbuf_setlen(&msg, prefix_len);
+	strbuf_addstr(&msg, "updating HEAD");
+	if (!switch_to_branch)
+		ret = update_ref(msg.buf, "HEAD", oid, orig, REF_NO_DEREF,
+				 UPDATE_REFS_MSG_ON_ERR);
+	else {
+		ret = create_symref("HEAD", switch_to_branch, msg.buf);
+		if (!ret)
+			ret = update_ref(msg.buf, "HEAD", oid, NULL, 0,
+					 UPDATE_REFS_MSG_ON_ERR);
+	}
+
+	strbuf_release(&msg);
+	return ret;
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
+	struct rebase_options options = {
+		.type = REBASE_UNSPECIFIED,
+	};
+	const char *branch_name;
+	int ret, flags;
+	struct strbuf msg = STRBUF_INIT;
+	struct strbuf revisions = STRBUF_INIT;
+
 	/*
 	 * NEEDSWORK: Once the builtin rebase has been tested enough
 	 * and git-legacy-rebase.sh is retired to contrib/, this preamble
@@ -54,5 +324,98 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
-	die("TODO");
+	git_config(git_default_config, NULL);
+
+	switch (options.type) {
+	case REBASE_MERGE:
+	case REBASE_INTERACTIVE:
+	case REBASE_PRESERVE_MERGES:
+		options.state_dir = merge_dir();
+		break;
+	case REBASE_AM:
+		options.state_dir = apply_dir();
+		break;
+	default:
+		/* the default rebase backend is `--am` */
+		options.type = REBASE_AM;
+		options.state_dir = apply_dir();
+		break;
+	}
+
+	if (!options.root) {
+		if (argc < 2)
+			die("TODO: handle @{upstream}");
+		else {
+			options.upstream_name = argv[1];
+			argc--;
+			argv++;
+			if (!strcmp(options.upstream_name, "-"))
+				options.upstream_name = "@{-1}";
+		}
+		options.upstream = peel_committish(options.upstream_name);
+		if (!options.upstream)
+			die(_("invalid upstream '%s'"), options.upstream_name);
+	} else
+		die("TODO: upstream for --root");
+
+	/* Make sure the branch to rebase onto is valid. */
+	if (!options.onto_name)
+		options.onto_name = options.upstream_name;
+	if (strstr(options.onto_name, "...")) {
+		die("TODO");
+	} else {
+		options.onto = peel_committish(options.onto_name);
+		if (!options.onto)
+			die(_("Does not point to a valid commit '%s'"),
+				options.onto_name);
+	}
+
+	/*
+	 * If the branch to rebase is given, that is the branch we will rebase
+	 * branch_name -- branch/commit being rebased, or
+	 * 		  HEAD (already detached)
+	 * orig_head -- commit object name of tip of the branch before rebasing
+	 * head_name -- refs/heads/<that-branch> or "detached HEAD"
+	 */
+	if (argc > 1)
+		 die("TODO: handle switch_to");
+	else {
+		/* Do not need to switch branches, we are already on it. */
+		options.head_name =
+			xstrdup_or_null(resolve_ref_unsafe("HEAD", 0, NULL,
+					 &flags));
+		if (!options.head_name)
+			die(_("No such ref: %s"), "HEAD");
+		if (flags & REF_ISSYMREF) {
+			if (!skip_prefix(options.head_name,
+					 "refs/heads/", &branch_name))
+				branch_name = options.head_name;
+
+		} else {
+			options.head_name = xstrdup("detached HEAD");
+			branch_name = "HEAD";
+		}
+		if (get_oid("HEAD", &options.orig_head))
+			die(_("Could not resolve HEAD to a revision"));
+	}
+
+	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
+	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1))
+		die(_("Could not detach HEAD"));
+	strbuf_release(&msg);
+
+	strbuf_addf(&revisions, "%s..%s",
+		    options.root ? oid_to_hex(&options.onto->object.oid) :
+		    (options.restrict_revision ?
+		     oid_to_hex(&options.restrict_revision->object.oid) :
+		     oid_to_hex(&options.upstream->object.oid)),
+		    oid_to_hex(&options.orig_head));
+
+	options.revisions = revisions.buf;
+
+	ret = !!run_specific_rebase(&options);
+
+	strbuf_release(&revisions);
+	free(options.head_name);
+	return ret;
 }
-- 
2.18.0

