Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835A71F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeGHSBp (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:01:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40020 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbeGHSBo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 14:01:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so12009284pfe.7
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f8+cZYV2nU0nDXPGSUBUVGQEvSxII/fB4fyw4ixcZYs=;
        b=ZaBPVusHH/0sB2kYc4/Ymve/3a1KnuIg5r4GZZPkroeh3QL3fBz81cb+VCNmuWQRLm
         iPGIqKKui5hl6wIrk36HiWOdykoWfxC0guGiafp7f+LYFCIz0+YzKvBWR4Qg9uRWKLeh
         5JPVGegZBZQtpqU+1612cYpg3K1A7aqLiIYVTni4G6ThyZr5RJlnGp1rfaRI+TCclG67
         Ta7NrjhGeS29HW0Z0CFCGy9jujFeXCO00I0tC0eX94Hi0/U9jjZ44PVP0uoxskJeYO3g
         nTxzgy655oCSX4/jpiA+/Hk2MVoaRNo5OuPBaxWzuav1IvWS39Glr/b50P+BWUXUZFc8
         qJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f8+cZYV2nU0nDXPGSUBUVGQEvSxII/fB4fyw4ixcZYs=;
        b=iBxVNoccW8WBofNQbZZeOTAaLl9nUB9xxchvtmsAy01b0ylh7YDADVrDLzqeNY7Q19
         QUcHX6kNKg2XGSgtA7/MQSnh/a2HweXkdBIWu+jhhf3fXOQmKOf4t3SuE5yaJHLJpGKb
         xN1sxEa2GA0RCaCaHYVT6K/kiGBQWWiV9Zdh+Xuot41rMe+x2sbO+yowI/94QQY5Z0P8
         ggFvFImdiFx4c0nV121yESP8cIIOqkV2CeD4Wei2HSN/45i2MROsag5H+LMoJ4OkQNro
         7h5S9ZMX29a0zdv1poeLcs71thr9QpH1P40rqUUGAO4J2i1Y/lyU+c+273BX4sFsBsZl
         MbKQ==
X-Gm-Message-State: APt69E3hdaWqAsstxIcTIXOeca9IhTTY1UMVwvUMItTLqRymEX/MFxy2
        ZuFvHWjcGffReNwOz37xDpRXiMpV
X-Google-Smtp-Source: AAOMgpcp1HspDL7YAJVU9vPiDHtd62h33c/l2zpvSZnxtEi+jWeqg1hC45bH4PyzS2Rgs5TA0gfEZg==
X-Received: by 2002:a65:620b:: with SMTP id d11-v6mr16394815pgv.429.1531072903133;
        Sun, 08 Jul 2018 11:01:43 -0700 (PDT)
Received: from localhost.localdomain ([27.34.68.75])
        by smtp.gmail.com with ESMTPSA id u13-v6sm18019149pgr.36.2018.07.08.11.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 11:01:42 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     Pratik Karki <predatoramigo@gmail.com>, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com, gitster@pobox.com
Subject: [PATCH v4 4/4] builtin/rebase: support running "git rebase <upstream>"
Date:   Sun,  8 Jul 2018 23:46:04 +0545
Message-Id: <20180708180104.17921-5-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708180104.17921-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180708180104.17921-1-predatoramigo@gmail.com>
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
 builtin/rebase.c | 238 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 237 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index fab7fca37e..e38ea80874 100644
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
@@ -52,5 +194,99 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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

