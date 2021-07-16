Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A471C636CB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A75613D3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhGPSAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhGPSAr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 14:00:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE1BC061762
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:57:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a4-20020a25f5040000b029054df41d5cceso13520995ybe.18
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZWyC+DpkjnNI9cjDtVDtlTPmRTyubrAyHQLRNQfZBSU=;
        b=fMP4TahEH7L0/Pjf7sE9nwNre30/TLgWbFtUep42IF7F/GcLq+nSSZ3Wwv61q82gm6
         UD7UGWaTk5Z/8HDZ/VfYEn3unEr8LTbrEKgB97Zf3zN6+NWDtvkGBjSihqVHY33tzDVX
         AkgZH8GIT0+o46t9YvDyIdNaKi4W76DNDiigwe/KXVn+zLh69y7deAHv2a9ZQb6Dvojk
         LbYve9EfBBGxVfLWnIk1P1BtZAzeqA5cNAlbUHmqsoCqn5XwA2xk/DwNBcyf5r0cHcdL
         A63qHZFa9MD+E3hSlmtMMIcCFeFoJh8qwkBXH1akhnn0ZjWIPnUX+QzIW8oS6gvZ97f1
         n9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZWyC+DpkjnNI9cjDtVDtlTPmRTyubrAyHQLRNQfZBSU=;
        b=D2QauyhJhMIJiSG3qaGZMwnc0wKJjzEjn1nmsVY6XjpyCM4RjyhcC1b/sUrXMUj1QI
         O28G1YiMLP+DCCjuXikoy7J1fLUVn2cpMRkM7bPJ2ajSsMtc633jvrOsMFUMLkEGklyF
         OKzTpK/L+4g+W1gznKVxenJ/SkObhszRy0qSROhIR2ZxN/z55uPjuu+lqNV/lhL+wls1
         S+kdYY2z4G1NbnMgNEF0g0HpW+szLU+aGNNj3JwBsNX9aVVyJTfxElK+1Xt5kq7ngumG
         49veSnhAsduHiyQpIOvTUm2MjwgoZP4GL1DVKzZVcLZm3/qIvEbHjZqbzhtCAlJuvNG8
         52lg==
X-Gm-Message-State: AOAM533yfN5o/YaCIQsOuwVtII+4s9deh3TOqtniwb/LHe2Vc9c4gFG9
        lTDNp+gvUheMUp7tXJkzh77t9mrGwETDCTYtmbYAaQ1nLByobTwshzOjqepNRtMFcrPWOFg5uvt
        pvDjsFEIyc18KbaQmChXMDmrDTb73Y68IK/pMT3/Vpf6Uo8VCtD7hsw6FfZW9DQfWEAtzkeeehp
        MD
X-Google-Smtp-Source: ABdhPJyl0pfHN645BzaU9x+IJN4+M5r6LvQ9Dd8CdDW5EuAC9jqiomkeRg69VqdPOAKO4103vg4llwStV3TW4W3nP1jr
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:b98d:: with SMTP id
 r13mr14408494ybg.430.1626458269786; Fri, 16 Jul 2021 10:57:49 -0700 (PDT)
Date:   Fri, 16 Jul 2021 10:57:41 -0700
In-Reply-To: <cover.1626453569.git.jonathantanmy@google.com>
Message-Id: <1ec1c958eb2b8aa2581280d050836dd0e7f6edef.1626453569.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1623881977.git.jonathantanmy@google.com> <cover.1626453569.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [RFC PATCH v2 2/2] hook: remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, iankaz@google.com,
        sandals@crustytoothpaste.net, avarab@gmail.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the "git hook install all|<hook-name>" command, that can install
one or all remote-suggested hooks.

If a configuration option hook.promptRemoteSuggested is set, inform the
user of the aforementioned command:

 - when cloning, and refs/remotes/origin/suggested-hooks is present in
   the newly cloned repo
 - when fetching, and refs/remotes/origin/suggested-hooks is updated
 - when committing, there is a remote-suggested commit-msg hook, and
   there is currently no commit-msg hook configured

NEEDSWORK: Write a more detailed commit message once the design is
finalized.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c                   |  12 +++
 builtin/fetch.c                   |  17 ++++
 builtin/hook.c                    |  17 +++-
 hook.c                            | 151 +++++++++++++++++++++++++++++-
 hook.h                            |   3 +
 t/t1361-remote-suggested-hooks.sh | 105 +++++++++++++++++++++
 6 files changed, 300 insertions(+), 5 deletions(-)
 create mode 100755 t/t1361-remote-suggested-hooks.sh

diff --git a/builtin/clone.c b/builtin/clone.c
index 2a2a03bf76..c2c8596aa9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1393,6 +1393,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local);
 
+	if (hook_should_prompt_suggestions()) {
+		for (ref = mapped_refs; ref; ref = ref->next) {
+			if (ref->peer_ref &&
+			    !strcmp(ref->peer_ref->name,
+				    "refs/remotes/origin/suggested-hooks")) {
+				fprintf(stderr, _("The remote has suggested hooks in refs/remotes/origin/suggested-hooks.\n"
+						  "Run `git hook install all` to install them.\n"));
+				break;
+			}
+		}
+	}
+
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
 	/*
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 769af53ca4..e86c312473 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,6 +28,7 @@
 #include "promisor-remote.h"
 #include "commit-graph.h"
 #include "shallow.h"
+#include "hook.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -1313,6 +1314,22 @@ static int consume_refs(struct transport *transport, struct ref *ref_map)
 				 ref_map);
 	transport_unlock_pack(transport);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
+
+	if (hook_should_prompt_suggestions()) {
+		struct ref *ref;
+
+		for (ref = ref_map; ref; ref = ref->next) {
+			if (ref->peer_ref &&
+			    !strcmp(ref->peer_ref->name,
+				    "refs/remotes/origin/suggested-hooks") &&
+			    oidcmp(&ref->old_oid, &ref->peer_ref->old_oid)) {
+				fprintf(stderr, _("The remote has updated its suggested hooks.\n"));
+				fprintf(stderr, _("Run 'git hook install all' to update.\n"));
+				break;
+			}
+		}
+	}
+
 	return ret;
 }
 
diff --git a/builtin/hook.c b/builtin/hook.c
index c79a961e80..0334fee967 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -139,6 +139,17 @@ static int run(int argc, const char **argv, const char *prefix)
 	return rc;
 }
 
+static int install(int argc, const char **argv, const char *prefix)
+{
+	if (argc < 1)
+		die(_("You must specify a hook event to install."));
+	if (!strcmp(argv[1], "all"))
+		hook_update_suggested(NULL);
+	else
+		hook_update_suggested(argv[1]);
+	return 0;
+}
+
 int cmd_hook(int argc, const char **argv, const char *prefix)
 {
 	const char *run_hookdir = NULL;
@@ -152,10 +163,6 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, builtin_hook_options,
 			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN);
 
-	/* after the parse, we should have "<command> <hookname> <args...>" */
-	if (argc < 2)
-		usage_with_options(builtin_hook_usage, builtin_hook_options);
-
 	git_config(git_default_config, NULL);
 
 
@@ -185,6 +192,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 		return list(argc, argv, prefix);
 	if (!strcmp(argv[0], "run"))
 		return run(argc, argv, prefix);
+	if (!strcmp(argv[0], "install"))
+		return install(argc, argv, prefix);
 
 	usage_with_options(builtin_hook_usage, builtin_hook_options);
 }
diff --git a/hook.c b/hook.c
index 3ccacb72fa..32eee9abb6 100644
--- a/hook.c
+++ b/hook.c
@@ -4,6 +4,12 @@
 #include "config.h"
 #include "run-command.h"
 #include "prompt.h"
+#include "commit.h"
+#include "object.h"
+#include "refs.h"
+#include "tree-walk.h"
+#include "tree.h"
+#include "streaming.h"
 
 /*
  * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
@@ -476,6 +482,60 @@ static int notify_hook_finished(int result,
 	return 0;
 }
 
+static struct tree *remote_suggested_hook_tree(int *warning_printed)
+{
+	struct object_id oid;
+	struct object *obj;
+	struct tree *tree;
+
+	if (read_ref("refs/remotes/origin/suggested-hooks", &oid))
+		return NULL;
+
+	obj = parse_object(the_repository, &oid);
+	if (obj == NULL) {
+		warning(_("object pointed to by refs/remotes/origin/suggested-hooks '%s' does not exist"),
+			oid_to_hex(&oid));
+		if (warning_printed)
+			*warning_printed = 1;
+		return NULL;
+	}
+	if (obj->type != OBJ_COMMIT) {
+		warning(_("object pointed to by refs/remotes/origin/suggested-hooks '%s' is not a commit"),
+			oid_to_hex(&oid));
+		if (warning_printed)
+			*warning_printed = 1;
+		return NULL;
+	}
+
+	tree = get_commit_tree((struct commit *) obj);
+	if (parse_tree(tree)) {
+		warning(_("could not parse tree"));
+		if (warning_printed)
+			*warning_printed = 1;
+		return NULL;
+	}
+
+	return tree;
+}
+
+static int has_suggested_hook(const char *hookname)
+{
+	struct tree *tree;
+	struct tree_desc desc;
+	struct name_entry entry;
+
+	tree = remote_suggested_hook_tree(NULL);
+	if (!tree)
+		return 0;
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	while (tree_entry(&desc, &entry)) {
+		if (!strcmp(hookname, entry.path))
+			return 1;
+	}
+	return 0;
+}
+
 int run_hooks(const char *hookname, struct run_hooks_opt *options)
 {
 	struct list_head *to_run, *pos = NULL, *tmp = NULL;
@@ -497,8 +557,16 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 			    list_del(pos);
 	}
 
-	if (list_empty(to_run))
+	if (list_empty(to_run)) {
+		if (!strcmp("commit-msg", hookname)) {
+			if (has_suggested_hook(hookname) &&
+			    !hook_exists(hookname, HOOKDIR_USE_CONFIG)) {
+				fprintf(stderr, _("No commit-msg hook has been configured, but one is suggested by the remote.\n"));
+				fprintf(stderr, _("Run 'git hook install commit-msg' to install it.\n"));
+			}
+		}
 		return 0;
+	}
 
 	cb_data.head = to_run;
 	cb_data.run_me = list_entry(to_run->next, struct hook, list);
@@ -515,3 +583,84 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 
 	return cb_data.rc;
 }
+
+static int is_hook(const char *filename)
+{
+	int i;
+
+	for (i = 0; i < hook_name_count; i++) {
+		if (!strcmp(filename, hook_name[i]))
+			return 1;
+	}
+	return 0;
+}
+
+void hook_update_suggested(const char *hook_to_update)
+{
+	struct tree *tree;
+	int warning_printed = 0;
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct strbuf path = STRBUF_INIT;
+	int hook_found = 0;
+
+	tree = remote_suggested_hook_tree(&warning_printed);
+	if (!tree) {
+		if (!warning_printed)
+			warning(_("no such ref refs/remotes/origin/suggested-hooks, not updating hooks"));
+		return;
+	}
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	while (tree_entry(&desc, &entry)) {
+		int fd;
+
+		if (hook_to_update && strcmp(hook_to_update, entry.path))
+			/*
+			 * We only need to update one hook, and this is not the
+			 * hook we're looking for
+			 */
+			continue;
+
+		if (!hook_to_update && !is_hook(entry.path)) {
+			warning(_("file '%s' is not a hook; ignoring"),
+				entry.path);
+			continue;
+		}
+		hook_found = 1;
+		if (S_ISDIR(entry.mode) || S_ISGITLINK(entry.mode)) {
+			warning(_("file '%s' is not an ordinary file; ignoring"),
+				entry.path);
+			continue;
+		}
+
+		strbuf_reset(&path);
+		strbuf_git_path(&path, "hooks/%s", entry.path);
+		fd = open(path.buf, O_WRONLY | O_CREAT, 0755);
+		if (fd < 0) {
+			warning_errno(_("could not create file '%s'; skipping this hook"),
+				      path.buf);
+			continue;
+		}
+		if (stream_blob_to_fd(fd, &entry.oid, NULL, 1)) {
+			warning(_("could not write to file '%s'; skipping this hook"),
+				path.buf);
+			continue;
+		}
+		close(fd);
+	}
+	strbuf_release(&path);
+
+	if (hook_to_update && !hook_found)
+		warning(_("hook '%s' not found"), hook_to_update);
+
+	return;
+}
+
+int hook_should_prompt_suggestions(void)
+{
+	int dest = 0;
+
+	return !git_config_get_bool("hook.promptremotesuggested", &dest) &&
+	       dest;
+}
diff --git a/hook.h b/hook.h
index d902166408..438bf7122e 100644
--- a/hook.h
+++ b/hook.h
@@ -140,3 +140,6 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options);
 void free_hook(struct hook *ptr);
 /* Empties the list at 'head', calling 'free_hook()' on each entry */
 void clear_hook_list(struct list_head *head);
+
+void hook_update_suggested(const char *hook_to_update);
+int hook_should_prompt_suggestions(void);
diff --git a/t/t1361-remote-suggested-hooks.sh b/t/t1361-remote-suggested-hooks.sh
new file mode 100755
index 0000000000..223c65ac99
--- /dev/null
+++ b/t/t1361-remote-suggested-hooks.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+
+test_description='remote-suggested hooks'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+setup_server () {
+	git init server &&
+	test_when_finished "rm -rf server" &&
+	cat >server/commit-msg <<-'EOF' &&
+	echo "overwrite the commit message" >$1
+EOF
+	git -C server add commit-msg &&
+	test_commit -C server commit-with-hook &&
+	git -C server checkout -b suggested-hooks
+}
+
+add_hook_to_server () {
+	>server/pre-commit &&
+	git -C server add pre-commit &&
+	test_commit -C server additional-hook
+}
+
+test_expect_success 'suggestion upon clone' '
+	setup_server &&
+	test_when_finished "rm -rf client" &&
+	git -c hook.promptRemoteSuggested=1 clone server client 2>err &&
+	grep "The remote has suggested hooks" err
+'
+
+test_expect_success 'no suggestion upon clone if not configured' '
+	setup_server &&
+	test_when_finished "rm -rf client" &&
+	git clone server client 2>err &&
+	! grep "The remote has suggested hooks" err
+'
+
+test_expect_success 'suggestion upon fetch if server has updated hooks' '
+	setup_server &&
+	git clone server client &&
+	test_when_finished "rm -rf client" &&
+	add_hook_to_server &&
+
+	git -C client -c hook.promptRemoteSuggested=1 fetch 2>err &&
+	grep "The remote has updated its suggested hooks" err
+'
+
+test_expect_success 'no suggestion upon fetch if not configured' '
+	setup_server &&
+	git clone server client &&
+	test_when_finished "rm -rf client" &&
+	add_hook_to_server &&
+
+	git -C client fetch 2>err &&
+	! grep "The remote has updated its suggested hooks" err
+'
+
+test_expect_success 'no suggestion upon fetch if server has not updated hooks' '
+	setup_server &&
+	git clone server client &&
+	test_when_finished "rm -rf client" &&
+	git -C server checkout main &&
+	test_commit -C server not-a-hook-update &&
+
+	git -C client -c hook.promptRemoteSuggested=1 fetch 2>err &&
+	! grep "The remote has updated its suggested hooks" err
+'
+
+test_expect_success 'suggest commit-msg hook upon commit' '
+	setup_server &&
+	git clone server client &&
+	test_when_finished "rm -rf client" &&
+
+	test_commit -C client foo 2>err &&
+	grep "Run .git hook install commit-msg" err
+'
+
+test_expect_success 'install one suggested hook' '
+	setup_server &&
+	git clone server client &&
+	test_when_finished "rm -rf client" &&
+
+	git -C client hook install commit-msg &&
+
+	# Check that the hook was written by making a commit
+	test_commit -C client bar &&
+	git -C client show >commit &&
+	grep "overwrite the commit message" commit
+'
+
+test_expect_success 'install all suggested hooks' '
+	setup_server &&
+	add_hook_to_server &&
+	git clone server client &&
+	test_when_finished "rm -rf client" &&
+
+	git -C client hook install all &&
+	test -f client/.git/hooks/pre-commit &&
+	test -f client/.git/hooks/commit-msg
+'
+
+test_done
-- 
2.32.0.402.g57bb445576-goog

