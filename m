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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F35FC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 23:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E8E6128C
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 23:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhFPXeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbhFPXeE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 19:34:04 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D87C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 16:31:58 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id qe2-20020a17090b4f82b029016e19bf8ac1so2488383pjb.4
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 16:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eHD+sxdNWpRq9JMaqeSvGSEsgw8HfjXrVPo4aOudjDc=;
        b=bGZV+3Sff8xhKzy830JylJpwD0Wl3SooGRwAfkiSIsVDjGC+TggBZ9NX60SPaRVW5o
         7TI17uBjpKVk0VUOgehlBcyPydqnwcY7zj8222z4EIm+X/VFKGs2XMJ3SeSp2bRIaaFG
         Cbis2XoWqCqMTbXNH3DLOIFd4RWbbMVHTAELD68hzza9dJlsSUmXos3EpjaSFqbc6/mc
         T8JqnbjGe/qXdH6sxFQ2Lm0SLoJY68ZY3VziVKXz7Z4qnDv471CdIVz/0UvWx0BIdPdL
         aXUEpB/s6jfjSVtLE4LnLwStGoVlyksfVUOtDjJrqlBBc0gUjjWqKBRk4umeJvLproHH
         NhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eHD+sxdNWpRq9JMaqeSvGSEsgw8HfjXrVPo4aOudjDc=;
        b=nFCh/2ST6lkC1JapO5XmKhahLmCOx/YjTqtaFZn5o3fruQKhyVthcEoDpvJLdW/GNk
         IC9AEGLcCi9Bg3md12gmu/3NKWbGBFQXg8Y6IXSXz2tihS8GNgS5V+bnp2oIsInpRLMI
         vw/ExRL+eHEAL8P9wStHfBWuwBElAgm8VQzC7XpeuAPE1Q/c9DfAHhsRWuMSGeX8+7ze
         YySe3Gt1gAGzxkIbw3e/B1+1YeloGsLqN58EDdivojX2aHCjt6NpAw8rVuq7kC6piRsA
         rqQU9KdNJHDz3YIn/mh/Hs6TBOkMLS58SFvG3IVhcwCiewQBltC9tEI15SdJ8Y5D3CJj
         5nqg==
X-Gm-Message-State: AOAM531OZnp/kz+2aSQDX1fcE4S2qodX+yyyBvtOk1QWBiuhHCm5tiEj
        8GvUsb+6zRWnuVf48glC7kk7iQoburkKw7otGwuRLjkO1vu4q0QNYu1KwBvEUyn6JszAYJslOMp
        OWNVRSBRel46ubhNU8BCMYkGdd0qiJFviqxbG5vTvGiwRIWSS8YOdTydrNnFiYFvGn7te/+2fIC
        4t
X-Google-Smtp-Source: ABdhPJwgZ9W4syak5VxxFFXj1D3K9P8amyx47t3dFM9imArZh/4najr3GOZb24MRA1sAl1XwcWSiV/Nu1uulOJLtFBMq
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:1b84:0:b029:2f7:2101:2088 with
 SMTP id b126-20020a621b840000b02902f721012088mr2354176pfb.23.1623886317412;
 Wed, 16 Jun 2021 16:31:57 -0700 (PDT)
Date:   Wed, 16 Jun 2021 16:31:49 -0700
In-Reply-To: <cover.1623881977.git.jonathantanmy@google.com>
Message-Id: <0f03e956c183d827c186b6fb85b92bfd31d2dc47.1623881977.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1623881977.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [RFC PATCH 2/2] clone,fetch: remote-suggested auto-updating hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Upon cloning, if a ref refs/remotes/origin/suggested-hooks is present,
Git will inform the user that they can run a command to install those
hooks and keep them auto-updated upon eacn fetch. If that command is
run, hooks will be installed (overriding existing ones) and every fetch
will check if that ref would be updated, and if yes, reinstall the hooks
from the new commit that the ref points to.

NEEDSWORK: Write a more detailed commit message once the design is
finalized.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c  | 10 ++++++
 builtin/fetch.c  | 21 ++++++++++++
 builtin/hook.c   | 13 +++++---
 hook.c           | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
 hook.h           |  2 ++
 t/t5601-clone.sh | 36 +++++++++++++++++++++
 6 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 2a2a03bf76..0ab4494bcd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1393,6 +1393,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local);
 
+	for (ref = mapped_refs; ref; ref = ref->next) {
+		if (ref->peer_ref &&
+		    !strcmp(ref->peer_ref->name,
+			    "refs/remotes/origin/suggested-hooks")) {
+			fprintf(stderr, _("The remote has suggested hooks in refs/remotes/origin/suggested-hooks.\n"
+					  "Run `git hook autoupdate` to download them, install them, and turn on automatic update of hooks.\n"));
+			break;
+		}
+	}
+
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
 	/*
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 769af53ca4..0618d1f091 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,6 +28,7 @@
 #include "promisor-remote.h"
 #include "commit-graph.h"
 #include "shallow.h"
+#include "hook.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -84,6 +85,7 @@ static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 static int fetch_write_commit_graph = -1;
 static int stdin_refspecs = 0;
 static int negotiate_only;
+static int hook_autoupdate;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -123,6 +125,11 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "hook.autoupdate")) {
+		hook_autoupdate = git_config_bool(k, v);
+		return 0;
+	}
+
 	return git_default_config(k, v, cb);
 }
 
@@ -1313,6 +1320,20 @@ static int consume_refs(struct transport *transport, struct ref *ref_map)
 				 ref_map);
 	transport_unlock_pack(transport);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
+
+	if (hook_autoupdate) {
+		struct ref *ref;
+
+		for (ref = ref_map; ref; ref = ref->next) {
+			if (ref->peer_ref &&
+			    !strcmp(ref->peer_ref->name,
+				    "refs/remotes/origin/suggested-hooks")) {
+				hook_update_suggested();
+				break;
+			}
+		}
+	}
+
 	return ret;
 }
 
diff --git a/builtin/hook.c b/builtin/hook.c
index c79a961e80..26d657a48a 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -139,6 +139,13 @@ static int run(int argc, const char **argv, const char *prefix)
 	return rc;
 }
 
+static int autoupdate(int argc, const char **argv, const char *prefix)
+{
+	git_config_set("hook.autoupdate", "true");
+	hook_update_suggested();
+	return 0;
+}
+
 int cmd_hook(int argc, const char **argv, const char *prefix)
 {
 	const char *run_hookdir = NULL;
@@ -152,10 +159,6 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, builtin_hook_options,
 			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN);
 
-	/* after the parse, we should have "<command> <hookname> <args...>" */
-	if (argc < 2)
-		usage_with_options(builtin_hook_usage, builtin_hook_options);
-
 	git_config(git_default_config, NULL);
 
 
@@ -185,6 +188,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 		return list(argc, argv, prefix);
 	if (!strcmp(argv[0], "run"))
 		return run(argc, argv, prefix);
+	if (!strcmp(argv[0], "autoupdate"))
+		return autoupdate(argc, argv, prefix);
 
 	usage_with_options(builtin_hook_usage, builtin_hook_options);
 }
diff --git a/hook.c b/hook.c
index 3ccacb72fa..5730e6e501 100644
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
@@ -515,3 +521,81 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 
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
+void hook_update_suggested(void)
+{
+	struct object_id oid;
+	struct object *obj;
+	struct tree *tree;
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct strbuf path = STRBUF_INIT;
+
+	if (read_ref("refs/remotes/origin/suggested-hooks", &oid)) {
+		warning(_("no such ref refs/remotes/origin/suggested-hooks, not updating hooks"));
+		return;
+	}
+
+	obj = parse_object(the_repository, &oid);
+	if (obj == NULL) {
+		warning(_("object pointed to by refs/remotes/origin/suggested-hooks '%s' does not exist"),
+			oid_to_hex(&oid));
+		return;
+	}
+	if (obj->type != OBJ_COMMIT) {
+		warning(_("object pointed to by refs/remotes/origin/suggested-hooks '%s' is not a commit"),
+			oid_to_hex(&oid));
+		return;
+	}
+
+	tree = get_commit_tree((struct commit *) obj);
+	if (parse_tree(tree)) {
+		warning(_("could not parse tree"));
+		return;
+	}
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	while (tree_entry(&desc, &entry)) {
+		int fd;
+
+		if (!is_hook(entry.path)) {
+			warning(_("file '%s' is not a hook; ignoring"),
+				entry.path);
+			continue;
+		}
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
+	return;
+}
diff --git a/hook.h b/hook.h
index d902166408..b0bfd3719b 100644
--- a/hook.h
+++ b/hook.h
@@ -140,3 +140,5 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options);
 void free_hook(struct hook *ptr);
 /* Empties the list at 'head', calling 'free_hook()' on each entry */
 void clear_hook_list(struct list_head *head);
+
+void hook_update_suggested(void);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index c0688467e7..21b96a4999 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -752,6 +752,42 @@ test_expect_success 'batch missing blob request does not inadvertently try to fe
 	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
 '
 
+test_expect_success 'detect suggested hook branch during clone' '
+	rm -rf server client &&
+
+	test_create_repo server &&
+	echo "echo foo" >server/pre-commit &&
+	git -C server add pre-commit &&
+	test_commit -C server hook-and-not-hook &&
+	git -C server checkout -b suggested-hooks &&
+	git clone server client 2>err &&
+	test_i18ngrep "The remote has suggested hooks" err
+'
+
+test_expect_success 'autoupdate' '
+	git -C client hook autoupdate &&
+
+	# Check correct config written
+	git -C client config --local hook.autoupdate >actual &&
+	echo "true" >expect &&
+	test_cmp expect actual &&
+
+	# Check hook written
+	cat client/.git/hooks/pre-commit >actual &&
+	echo "echo foo" >expect &&
+	test_cmp expect actual &&
+
+	# Install new hook and fetch it
+	echo "echo bar" >server/pre-commit &&
+	git -C server commit -am "new hook" &&
+	git -C client fetch &&
+
+	# Check new hook written
+	cat client/.git/hooks/pre-commit >actual &&
+	echo "echo bar" >expect &&
+	test_cmp expect actual
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.32.0.272.g935e593368-goog

