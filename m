Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E4D201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 23:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbdKJXN3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 18:13:29 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:43570 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbdKJXN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 18:13:27 -0500
Received: by mail-pf0-f173.google.com with SMTP id a84so2773398pfl.0
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 15:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5o3zsK/1Bkad8XIfJ7u8AfxsJ5NJJbiPNKffVVXaTOg=;
        b=hRdP/mTIiLk2aStvubVZhafHg+GNT1N3GPHCW3Ux+jhrKGQFEPNADcXBeFKY3+iJ1k
         JlsgNqXqD9L9nw4lG5in4b9vetYo1ZBsj3bt/Uqd4U3OnuUatzq8uY4tDqfGiYrNJV1e
         ni4xcWYt+lKIz+XH9Lc54CLeiSwJ4wTd0Fv5dHHT7MfRgoPxPB/b5RJpqRwVUoPha9Pr
         0UrPHLV61YfZJo//EVxUh+W8OmHu1HG8kK6dgfvouWoB8J+vpLg0U644HRwpyUHyenLF
         TFSCBAflEBjbJDJkmFJ3si+vCz4Oc6mRbe9eOFo6gfqo9ih6Y3X1hdvA+Y41BdsPFzHP
         ZDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5o3zsK/1Bkad8XIfJ7u8AfxsJ5NJJbiPNKffVVXaTOg=;
        b=JRluTEr9kOaaBLMHvf/F2LuSwBAENwCVsgakRFzoV7NfrCTisyqjk6/8WdCbgMmQYA
         dez9iUBilGvEa70PLzGm+NxCh4Iehds3wAZsJBborkfy+byI77jBAYpuAICzmUUPjj/5
         ZwYt+XVSIeXe1uxz1LiZzq/xBndqiZTG/oQqIv0h0gdwGyOWCkxwma74JLQNPMGE75M6
         +CnqSKRZ0YdTyopyo/0EnGnVK6ct/XCQvQcgg0NAs158KrhdUolW+5gUPjU+FDiUEbt8
         TMZAPN6u57FXJwbI7ovN7G3bdF1aByXveoE9Wb4Q2ZHIWmRm5BGwHwAanWSXMFwEYrCz
         gkig==
X-Gm-Message-State: AJaThX7wsWusKO8jxZDXDs/3P5sPqSpW9qBPf86g9ps/ZxELgVqU4Ly9
        +fLaFwcR8NiNdf6dGxK31q3jwz0=
X-Google-Smtp-Source: AGs4zMbzf0aTnXL9RNYZkxqjkqY9iZZiPfmi77pitsL1m/0h7G0XMxdkBgGinVMjGosMRhZNHOaFpw==
X-Received: by 10.159.230.13 with SMTP id u13mr1910346plq.226.1510355606518;
        Fri, 10 Nov 2017 15:13:26 -0800 (PST)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id f6sm16248063pgo.11.2017.11.10.15.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 15:13:26 -0800 (PST)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH 2/2] stash: implement builtin stash helper
Date:   Fri, 10 Nov 2017 15:13:14 -0800
Message-Id: <20171110231314.30711-3-joel@teichroeb.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171110231314.30711-1-joel@teichroeb.net>
References: <20171110231314.30711-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start moving stash functions over to builtin c code and call
them in the shell script, instead of converting it all at
once.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 Makefile                |   1 +
 builtin.h               |   1 +
 builtin/stash--helper.c | 516 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 134 +------------
 git.c                   |   1 +
 5 files changed, 526 insertions(+), 127 deletions(-)
 create mode 100644 builtin/stash--helper.c

diff --git a/Makefile b/Makefile
index ee9d5eb11..3a9bd4d57 100644
--- a/Makefile
+++ b/Makefile
@@ -1000,6 +1000,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/stash--helper.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
diff --git a/builtin.h b/builtin.h
index 42378f3aa..a14fd85b0 100644
--- a/builtin.h
+++ b/builtin.h
@@ -219,6 +219,7 @@ extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
+extern int cmd_stash__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
new file mode 100644
index 000000000..c8cb667fe
--- /dev/null
+++ b/builtin/stash--helper.c
@@ -0,0 +1,516 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+#include "refs.h"
+#include "lockfile.h"
+#include "cache-tree.h"
+#include "unpack-trees.h"
+#include "merge-recursive.h"
+#include "argv-array.h"
+#include "run-command.h"
+
+static const char * const git_stash_usage[] = {
+	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper branch <branchname> [<stash>]"),
+	N_("git stash--helper clear"),
+	NULL
+};
+
+static const char * const git_stash_drop_usage[] = {
+	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
+	NULL
+};
+
+static const char * const git_stash_pop_usage[] = {
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
+static const char * const git_stash_apply_usage[] = {
+	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
+static const char * const git_stash_branch_usage[] = {
+	N_("git stash--helper branch <branchname> [<stash>]"),
+	NULL
+};
+
+static const char * const git_stash_clear_usage[] = {
+	N_("git stash--helper clear"),
+	NULL
+};
+
+static const char *ref_stash = "refs/stash";
+static int quiet;
+static char stash_index_path[PATH_MAX];
+
+struct stash_info {
+	struct object_id w_commit;
+	struct object_id b_commit;
+	struct object_id i_commit;
+	struct object_id u_commit;
+	struct object_id w_tree;
+	struct object_id b_tree;
+	struct object_id i_tree;
+	struct object_id u_tree;
+	const char *message;
+	const char *revision;
+	int is_stash_ref;
+	int has_u;
+	const char *patch;
+};
+
+static int get_stash_info(struct stash_info *info, const char *commit)
+{
+	struct strbuf w_commit_rev = STRBUF_INIT;
+	struct strbuf b_commit_rev = STRBUF_INIT;
+	struct strbuf w_tree_rev = STRBUF_INIT;
+	struct strbuf b_tree_rev = STRBUF_INIT;
+	struct strbuf i_tree_rev = STRBUF_INIT;
+	struct strbuf u_tree_rev = STRBUF_INIT;
+	struct strbuf commit_buf = STRBUF_INIT;
+	struct strbuf symbolic = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	int ret;
+	const char *revision = commit;
+	char *end_of_rev;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	info->is_stash_ref = 0;
+
+	if (commit == NULL) {
+		strbuf_addf(&commit_buf, "%s@{0}", ref_stash);
+		revision = commit_buf.buf;
+	} else if (strspn(commit, "0123456789") == strlen(commit)) {
+		strbuf_addf(&commit_buf, "%s@{%s}", ref_stash, commit);
+		revision = commit_buf.buf;
+	}
+	info->revision = revision;
+
+	strbuf_addf(&w_commit_rev, "%s", revision);
+	strbuf_addf(&b_commit_rev, "%s^1", revision);
+	strbuf_addf(&w_tree_rev, "%s:", revision);
+	strbuf_addf(&b_tree_rev, "%s^1:", revision);
+	strbuf_addf(&i_tree_rev, "%s^2:", revision);
+
+	ret = !get_oid(w_commit_rev.buf, &info->w_commit) &&
+		!get_oid(b_commit_rev.buf, &info->b_commit) &&
+		!get_oid(w_tree_rev.buf, &info->w_tree) &&
+		!get_oid(b_tree_rev.buf, &info->b_tree) &&
+		!get_oid(i_tree_rev.buf, &info->i_tree);
+
+	strbuf_release(&w_commit_rev);
+	strbuf_release(&b_commit_rev);
+	strbuf_release(&w_tree_rev);
+	strbuf_release(&b_tree_rev);
+	strbuf_release(&i_tree_rev);
+
+	if (!ret)
+		return error(_("%s is not a valid reference"), revision);
+
+	strbuf_addf(&u_tree_rev, "%s^3:", revision);
+
+	info->has_u = !get_oid(u_tree_rev.buf, &info->u_tree);
+
+	strbuf_release(&u_tree_rev);
+
+	end_of_rev = strchrnul(revision, '@');
+	strbuf_add(&symbolic, revision, end_of_rev - revision);
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "rev-parse", "--symbolic-full-name", NULL);
+	argv_array_pushf(&cp.args, "%s", symbolic.buf);
+	strbuf_release(&symbolic);
+	pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
+
+	if (out.len - 1 == strlen(ref_stash))
+		info->is_stash_ref = !strncmp(out.buf, ref_stash, out.len - 1);
+	strbuf_release(&out);
+
+	return 0;
+}
+
+static int do_clear_stash(void)
+{
+	struct object_id obj;
+	if (get_oid(ref_stash, &obj))
+		return 0;
+
+	return delete_ref(NULL, ref_stash, &obj, 0);
+}
+
+static int clear_stash(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, git_stash_clear_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc != 0)
+		return error(_("git stash--helper clear with parameters is unimplemented"));
+
+	return do_clear_stash();
+}
+
+static int reset_tree(struct object_id i_tree, int update, int reset)
+{
+	struct unpack_trees_options opts;
+	int nr_trees = 1;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct tree *tree;
+	struct lock_file lock_file = LOCK_INIT;
+
+	read_cache_preload(NULL);
+	if (refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL))
+		return -1;
+
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+
+	memset(&opts, 0, sizeof(opts));
+
+	tree = parse_tree_indirect(&i_tree);
+	if (parse_tree(tree))
+		return -1;
+
+	init_tree_desc(t, tree->buffer, tree->size);
+
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.merge = 1;
+	opts.reset = reset;
+	opts.update = update;
+	opts.fn = oneway_merge;
+
+	if (unpack_trees(nr_trees, t, &opts))
+		return -1;
+
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK)) {
+		error(_("unable to write new index file"));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int do_apply_stash(const char *prefix, struct stash_info *info, int index)
+{
+	struct merge_options o;
+	struct object_id c_tree;
+	struct object_id index_tree;
+	const struct object_id *bases[1];
+	int bases_count = 1;
+	struct commit *result;
+	int ret;
+
+	read_cache_preload(NULL);
+	if (refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL))
+		return -1;
+
+	if (write_cache_as_tree(c_tree.hash, 0, NULL))
+		return -1;
+
+	if (reset_tree(c_tree, 0, 0))
+		return -1;
+
+	if (index) {
+		if (!hashcmp(info->b_tree.hash, info->i_tree.hash) || !hashcmp(c_tree.hash, info->i_tree.hash)) {
+			index = 0;
+		} else {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+			struct argv_array args = ARGV_ARRAY_INIT;
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
+			argv_array_pushf(&cp.args, "%s^2^..%s^2", sha1_to_hex(info->w_commit.hash), sha1_to_hex(info->w_commit.hash));
+			if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0))
+				return -1;
+
+			child_process_init(&cp);
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "apply", "--cached", NULL);
+			if (pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0))
+				return -1;
+
+			strbuf_release(&out);
+			discard_cache();
+			read_cache();
+			if (write_cache_as_tree(index_tree.hash, 0, NULL))
+				return -1;
+
+			argv_array_push(&args, "reset");
+			cmd_reset(args.argc, args.argv, prefix);
+		}
+	}
+
+	if (info->has_u) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		struct child_process cp = CHILD_PROCESS_INIT;
+		const char *index_file = get_index_file();
+
+		argv_array_push(&args, "read-tree");
+		argv_array_push(&args, sha1_to_hex(info->u_tree.hash));
+		argv_array_pushf(&args, "--index-output=%s", stash_index_path);
+
+		cp.git_cmd = 1;
+		argv_array_pushl(&cp.args, "checkout-index", "--all", NULL);
+		argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
+
+		if (cmd_read_tree(args.argc, args.argv, prefix) ||
+				run_command(&cp)) {
+			return error(_("Could not restore untracked files from stash"));
+		}
+		set_alternate_index_output(index_file);
+	}
+
+	init_merge_options(&o);
+
+	o.branch1 = "Updated upstream";
+	o.branch2 = "Stashed changes";
+
+	if (!hashcmp(info->b_tree.hash, c_tree.hash))
+		o.branch1 = "Version stash was based on";
+
+	if (quiet)
+		o.verbosity = 0;
+
+	if (o.verbosity >= 3)
+		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
+
+	bases[0] = &info->b_tree;
+
+	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, bases_count, bases, &result);
+	if (ret != 0) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		argv_array_push(&args, "rerere");
+		cmd_rerere(args.argc, args.argv, prefix);
+
+		if (index)
+			printf_ln(_("Index was not unstashed."));
+
+		return ret;
+	}
+
+	if (index) {
+		if (reset_tree(index_tree, 0, 0))
+			return -1;
+	} else {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf out = STRBUF_INIT;
+		cp.git_cmd = 1;
+		argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only", "--diff-filter=A", NULL);
+		argv_array_push(&cp.args, sha1_to_hex(c_tree.hash));
+		ret = pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
+		if (ret)
+			return -1;
+
+		if (reset_tree(c_tree, 0, 1))
+			return -1;
+
+		child_process_init(&cp);
+		cp.git_cmd = 1;
+		argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
+		ret = pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0);
+		if (ret)
+			return -1;
+
+		strbuf_release(&out);
+		discard_cache();
+		read_cache();
+	}
+
+	if (!quiet) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		argv_array_push(&args, "status");
+		cmd_status(args.argc, args.argv, prefix);
+	}
+
+	return 0;
+}
+
+static int apply_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *commit = NULL;
+	int index = 0;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			N_("attempt to ininstate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_apply_usage, 0);
+
+	if (argc == 1) {
+		commit = argv[0];
+	}
+
+	if (get_stash_info(&info, commit))
+		return -1;
+
+
+	return do_apply_stash(prefix, &info, index);
+}
+
+static int do_drop_stash(const char *prefix, struct stash_info *info)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	int ret;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	argv_array_pushl(&args, "reflog", "delete", "--updateref", "--rewrite", NULL);
+	argv_array_push(&args, info->revision);
+	ret = cmd_reflog(args.argc, args.argv, prefix);
+	if (!ret) {
+		if (!quiet) {
+			printf(_("Dropped %s (%s)\n"), info->revision, sha1_to_hex(info->w_commit.hash));
+		}
+	} else {
+		return error(_("%s: Could not drop stash entry"), info->revision);
+	}
+
+	cp.git_cmd = 1;
+	/* Even though --quiet is specified, rev-parse still outputs the hash */
+	cp.no_stdout = 1;
+	argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
+	argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
+	ret = run_command(&cp);
+
+	if (ret)
+		do_clear_stash();
+
+	return 0;
+}
+
+static int drop_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *commit = NULL;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_drop_usage, 0);
+
+	if (argc == 1)
+		commit = argv[0];
+
+	if (get_stash_info(&info, commit))
+		return -1;
+
+	if (!info.is_stash_ref)
+		return error(_("'%s' is not a stash reference"), commit);
+
+	return do_drop_stash(prefix, &info);
+}
+
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int index = 0;
+	const char *commit = NULL;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			N_("attempt to ininstate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_pop_usage, 0);
+
+	if (argc == 1)
+		commit = argv[0];
+
+	if (get_stash_info(&info, commit))
+		return -1;
+
+	if (!info.is_stash_ref)
+		return error(_("'%s' is not a stash reference"), commit);
+
+	if (do_apply_stash(prefix, &info, index))
+		return -1;
+
+	return do_drop_stash(prefix, &info);
+}
+
+static int branch_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *commit = NULL, *branch = NULL;
+	int ret;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct stash_info info;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_branch_usage, 0);
+
+	if (argc != 0) {
+		branch = argv[0];
+		if (argc == 2)
+			commit = argv[1];
+	}
+
+	if (get_stash_info(&info, commit))
+		return -1;
+
+	argv_array_pushl(&args, "checkout", "-b", NULL);
+	argv_array_push(&args, branch);
+	argv_array_push(&args, sha1_to_hex(info.b_commit.hash));
+	ret = cmd_checkout(args.argc, args.argv, prefix);
+	if (ret)
+		return -1;
+
+	ret = do_apply_stash(prefix, &info, 1);
+	if (!ret && info.is_stash_ref)
+		ret = do_drop_stash(prefix, &info);
+
+	return ret;
+}
+
+int cmd_stash__helper(int argc, const char **argv, const char *prefix)
+{
+	int result = 0;
+	pid_t pid = getpid();
+	const char *index_file;
+
+	struct option options[] = {
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
+		PARSE_OPT_KEEP_UNKNOWN|PARSE_OPT_KEEP_DASHDASH);
+
+	index_file = get_index_file();
+	xsnprintf(stash_index_path, PATH_MAX, "%s.stash.%d", index_file, pid);
+
+	if (argc < 1)
+		usage_with_options(git_stash_usage, options);
+	else if (!strcmp(argv[0], "apply"))
+		result = apply_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "clear"))
+		result = clear_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "drop"))
+		result = drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		result = pop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "branch"))
+		result = branch_stash(argc, argv, prefix);
+	else {
+		error(_("unknown subcommand: %s"), argv[0]);
+		usage_with_options(git_stash_usage, options);
+		result = 1;
+	}
+
+	return result;
+}
diff --git a/git-stash.sh b/git-stash.sh
index 4b7495144..ed2c57027 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -535,129 +535,6 @@ assert_stash_like() {
 	}
 }
 
-is_stash_ref() {
-	is_stash_like "$@" && test -n "$IS_STASH_REF"
-}
-
-assert_stash_ref() {
-	is_stash_ref "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash reference")"
-	}
-}
-
-apply_stash () {
-
-	assert_stash_like "$@"
-
-	git update-index -q --refresh || die "$(gettext "unable to refresh index")"
-
-	# current index state
-	c_tree=$(git write-tree) ||
-		die "$(gettext "Cannot apply a stash in the middle of a merge")"
-
-	unstashed_index_tree=
-	if test -n "$INDEX_OPTION" && test "$b_tree" != "$i_tree" &&
-			test "$c_tree" != "$i_tree"
-	then
-		git diff-tree --binary $s^2^..$s^2 | git apply --cached
-		test $? -ne 0 &&
-			die "$(gettext "Conflicts in index. Try without --index.")"
-		unstashed_index_tree=$(git write-tree) ||
-			die "$(gettext "Could not save index tree")"
-		git reset
-	fi
-
-	if test -n "$u_tree"
-	then
-		GIT_INDEX_FILE="$TMPindex" git read-tree "$u_tree" &&
-		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
-		rm -f "$TMPindex" ||
-		die "$(gettext "Could not restore untracked files from stash entry")"
-	fi
-
-	eval "
-		GITHEAD_$w_tree='Stashed changes' &&
-		GITHEAD_$c_tree='Updated upstream' &&
-		GITHEAD_$b_tree='Version stash was based on' &&
-		export GITHEAD_$w_tree GITHEAD_$c_tree GITHEAD_$b_tree
-	"
-
-	if test -n "$GIT_QUIET"
-	then
-		GIT_MERGE_VERBOSITY=0 && export GIT_MERGE_VERBOSITY
-	fi
-	if git merge-recursive $b_tree -- $c_tree $w_tree
-	then
-		# No conflict
-		if test -n "$unstashed_index_tree"
-		then
-			git read-tree "$unstashed_index_tree"
-		else
-			a="$TMP-added" &&
-			git diff-index --cached --name-only --diff-filter=A $c_tree >"$a" &&
-			git read-tree --reset $c_tree &&
-			git update-index --add --stdin <"$a" ||
-				die "$(gettext "Cannot unstage modified files")"
-			rm -f "$a"
-		fi
-		squelch=
-		if test -n "$GIT_QUIET"
-		then
-			squelch='>/dev/null 2>&1'
-		fi
-		(cd "$START_DIR" && eval "git status $squelch") || :
-	else
-		# Merge conflict; keep the exit status from merge-recursive
-		status=$?
-		git rerere
-		if test -n "$INDEX_OPTION"
-		then
-			gettextln "Index was not unstashed." >&2
-		fi
-		exit $status
-	fi
-}
-
-pop_stash() {
-	assert_stash_ref "$@"
-
-	if apply_stash "$@"
-	then
-		drop_stash "$@"
-	else
-		status=$?
-		say "$(gettext "The stash entry is kept in case you need it again.")"
-		exit $status
-	fi
-}
-
-drop_stash () {
-	assert_stash_ref "$@"
-
-	git reflog delete --updateref --rewrite "${REV}" &&
-		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
-		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
-
-	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
-	clear_stash
-}
-
-apply_to_branch () {
-	test -n "$1" || die "$(gettext "No branch name specified")"
-	branch=$1
-	shift 1
-
-	set -- --index "$@"
-	assert_stash_like "$@"
-
-	git checkout -b $branch $REV^ &&
-	apply_stash "$@" && {
-		test -z "$IS_STASH_REF" || drop_stash "$@"
-	}
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -694,7 +571,8 @@ push)
 	;;
 apply)
 	shift
-	apply_stash "$@"
+	cd "$START_DIR"
+	git stash--helper apply "$@"
 	;;
 clear)
 	shift
@@ -710,15 +588,17 @@ store)
 	;;
 drop)
 	shift
-	drop_stash "$@"
+	git stash--helper drop "$@"
 	;;
 pop)
 	shift
-	pop_stash "$@"
+	cd "$START_DIR"
+	git stash--helper pop "$@"
 	;;
 branch)
 	shift
-	apply_to_branch "$@"
+	cd "$START_DIR"
+	git stash--helper branch "$@"
 	;;
 *)
 	case $# in
diff --git a/git.c b/git.c
index 9e96dd409..868727dc3 100644
--- a/git.c
+++ b/git.c
@@ -466,6 +466,7 @@ static struct cmd_struct commands[] = {
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "stash--helper", cmd_stash__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
-- 
2.15.0

