Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF74F1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 12:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932771AbeGFMJE (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 08:09:04 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36356 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeGFMJC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 08:09:02 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so2810251plp.3
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ACswbnCJKyYaHcWaYUgk6I5ik1tJJUs1Rvd0HRDl90=;
        b=FIlKZW69yPHNJNuFORe48mivYvpeI8NxvYlp6VtC1KWIlagm8Vjpy/4cOH5WDbPNE1
         j1VowTEdBQQ5uPtl0m2lp3w3v37ATVeFPd0/XWycVoQ/zEJdYUFaXIpcbsWp0Ge+kPuM
         7Uim0GFCMPTSHL6gXLUcfIWyIycr6UQgGLR4XK8X6SCTUPJW2RXY126PgU/XkUqbEo/i
         Sb468tEBMkn7d/YQEffaZa0KWVfWKyfO/N6sfOgnzmG/lnej5be4r0bBGK4s3oTYxUby
         jLEVn5Yj56Ir/5jFSP2sHtfhkg8EM+nqgpnTFRXCvgmmiiOHTNdEDdlMmJ4gQAK5D9+L
         01FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ACswbnCJKyYaHcWaYUgk6I5ik1tJJUs1Rvd0HRDl90=;
        b=lBGOTvGJ2yIz8136SXqjNF7m/s1u1/T4Xx/viPhy0dSjgUVKf3QEVbxZ5GWgPx6o9d
         qpzC2HGo1JfT2dTI3X48efUi+m+A3yRtBJdyEuooX/wmI9iSRckoCouXX1JV5QRB7/JI
         MM9TRfB85e5xuEjSL607SnSBLTr/8IvgLkWUoK9HGEsBihIriiVnwD0GvYtr/MDIk195
         PD3pye9GPiqdWG3r1mRIflkzvqqJUTbBLlvOtLPlgWZ7juiEJXgPfIrtpxn35C3g3Kia
         a5YtYxF55juUfTMOtzNg7EZcsNJUM/EpetdJau8kdmtR7PeFi/oddCUeeU9wcauw83pv
         5ctg==
X-Gm-Message-State: APt69E3DNyZ6b1nGjZLIgMrNFMPD3OGG1hKRnNMu0ihdzPGOa4VYhHx6
        alkDbtOn+ORMoFUHVl2J8EXp6BzySNE=
X-Google-Smtp-Source: AAOMgpcCXvbz/6NLvNkbMiaerMXYk+l3m/1cDQWbtVF0mVytDUQ1E53GU0mcZVfQbnu67GKC7iNYuQ==
X-Received: by 2002:a17:902:900b:: with SMTP id a11-v6mr10104293plp.143.1530878941178;
        Fri, 06 Jul 2018 05:09:01 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.186])
        by smtp.gmail.com with ESMTPSA id j23-v6sm13925519pfi.137.2018.07.06.05.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 05:09:00 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH v3 4/4] builtin/rebase: support running "git rebase <upstream>"
Date:   Fri,  6 Jul 2018 17:53:15 +0545
Message-Id: <20180706120815.17851-5-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706120815.17851-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180706120815.17851-1-predatoramigo@gmail.com>
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

The next commits will handle and support all the wonderful rebase
options.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 237 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 236 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index fab7fca37e..71f06f0789 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -9,6 +9,20 @@
 #include "exec-cmd.h"
 #include "argv-array.h"
 #include "dir.h"
+#include "packfile.h"
+#include "checkout.h"
+#include "refs.h"
+#include "quote.h"
+
+static GIT_PATH_FUNC(apply_dir, "rebase-apply");
+static GIT_PATH_FUNC(merge_dir, "rebase-merge");
+
+enum rebase_type {
+	REBASE_AM,
+	REBASE_MERGE,
+	REBASE_INTERACTIVE,
+	REBASE_PRESERVE_MERGES
+};
 
 static int use_builtin_rebase(void)
 {
@@ -28,8 +42,136 @@ static int use_builtin_rebase(void)
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
+	const char *root;
+};
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
+	obj = parse_object(&oid);
+	return (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
+}
+
+static void add_var(struct strbuf *buf, const char *name, const char *value)
+{
+	strbuf_addstr(buf, name);
+	strbuf_addstr(buf, "=");
+	sq_quote_buf(buf, value);
+	strbuf_addstr(buf, "; ");
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
+
+	add_var(&script_snippet, "upstream_name", opts->upstream_name);
+	add_var(&script_snippet, "upstream",
+				 oid_to_hex(&opts->upstream->object.oid));
+	add_var(&script_snippet, "head_name", opts->head_name);
+	add_var(&script_snippet, "orig_head", oid_to_hex(&opts->orig_head));
+	add_var(&script_snippet, "onto", oid_to_hex(&opts->onto->object.oid));
+	add_var(&script_snippet, "onto_name", opts->onto_name);
+	add_var(&script_snippet, "revisions", opts->revisions);
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
+		    ". git-rebase--common && . %s && %s",
+		    backend, backend_func);
+	argv[0] = script_snippet.buf;
+
+	status = run_command_v_opt(argv, RUN_USING_SHELL);
+	if (status == 0)
+		finish_rebase(opts);
+	else if (status == 2) {
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
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
+	struct rebase_options options = { -1 };
+	const char *branch_name;
+	int ret, flags, quiet = 0;
+	struct strbuf msg = STRBUF_INIT;
+	struct strbuf revisions = STRBUF_INIT;
+	const char *restrict_revision = NULL;
+
 	/*
 	 * NEEDSWORK: Once the builtin rebase has been tested enough
 	 * and git-legacy-rebase.sh is retired to contrib/, this preamble
@@ -52,5 +194,98 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
-	die("TODO");
+	options.type = REBASE_AM;
+
+	switch (options.type) {
+	case REBASE_AM:
+		options.state_dir = apply_dir();
+		break;
+	case REBASE_MERGE:
+	case REBASE_INTERACTIVE:
+	case REBASE_PRESERVE_MERGES:
+		options.state_dir = merge_dir();
+		break;
+	}
+	if (!options.root) {
+		if (argc != 2)
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
+	* If the branch to rebase is given, that is the branch we will rebase
+	* branch_name -- branch/commit being rebased, or HEAD (already detached)
+	* orig_head -- commit object name of tip of the branch before rebasing
+	* head_name -- refs/heads/<that-branch> or "detached HEAD"
+	*/
+	if (argc > 1)
+		 die ("TODO: handle switch_to");
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
+	/* Detach HEAD and reset the tree */
+	if (!quiet)
+		printf("First, rewinding head to replay your work on top of it...");
+
+	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
+	if (detach_head_to(&options.onto->object.oid, "checkout", msg.buf))
+		die(_("Could not detach HEAD"));
+	strbuf_release(&msg);
+	if (update_ref("rebase", "ORIG_HEAD", &options.orig_head, NULL, 0,
+		       UPDATE_REFS_MSG_ON_ERR) < 0)
+		die(_("Could not update ORIG_HEAD to '%s'"),
+		    oid_to_hex(&options.orig_head));
+
+	strbuf_addf(&revisions, "%s..%s",
+		!options.root ? oid_to_hex(&options.onto->object.oid) :
+		    (restrict_revision ? restrict_revision :
+			    oid_to_hex(&options.upstream->object.oid)),
+			    oid_to_hex(&options.orig_head));
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

