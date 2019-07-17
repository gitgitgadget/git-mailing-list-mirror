Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1B61F461
	for <e@80x24.org>; Wed, 17 Jul 2019 00:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfGQALz (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 20:11:55 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33172 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfGQALy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 20:11:54 -0400
Received: by mail-pf1-f202.google.com with SMTP id d190so13329702pfa.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 17:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=NF7GhKq2AJlxfGeqD8ogMQSq2CDDcmKTYNjXphe2oQ4=;
        b=LyOa+tn9BcMXz9Oiv/taMeaqM3FdG49exyI6FF2sjWEbCuUIp9eIBuOTccwPGyj98f
         ZSnJ0NNvAPOj0XRlht5cvGeiAz4sIQQdrl4HAEoyCPAy2SVujZar2yRMnRA58ihJ12Ob
         Y4V7H/9LqPKiaQPB0EmyqO7B30yTiWnzN4ZMtAgDK5mnPqJxI/t8etNMLWVSjosXRsUk
         LyfwE6ie/6kkMDYv5hGfZxZKt2GdLwR8KfCmmRdkCUxoOaakYk69H/GebP4LG7iTAiba
         iTFwhdYyOcRV0gYAzdipiv/BF2q07yh4s4jBn6BdieU0d3r+ZMjZIPJToUkkv0r4yos2
         v3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=NF7GhKq2AJlxfGeqD8ogMQSq2CDDcmKTYNjXphe2oQ4=;
        b=pNnChsmuIEVoUoV3iDBaoHw47I1GenVhcy+HHrSkTu5Vk3YATvMxM5fGM3TXl6mnob
         s/EG6Ro4/HVHBHQA6Ty/oAM6gd1u/X9JSwOsg1eZ6NeLsU8bFGcabW+8v7yO/ExbNdkx
         D2vWX2C0NgVlfS7+6TRmG2xkroGQ5gkCVVIwfLJLp8vHCwLuVBSlVj5REdTWBIOA5KwJ
         cp3B+/prX7G7zpKS8Tgtv+LESciJtN93UjYDJUy3LyjhS4BMY3W0veWUXHmzFZwpk9vf
         ZTOdssyVSUjlToo7WZxpLRaed4u18FVvY3Zvp7hze3RJmK1PyU+P1SdUUdUdL0lmkCtn
         y8xQ==
X-Gm-Message-State: APjAAAXAzOqrIjcWhc0sYk0tDLIHuUiT6XTYDW4x6zU7Zp19mB9UenG5
        J6sFxBKvgHiN6nTb+gWnEk3/Tm25ZJDfrKXla9eIvvg6bspFkQTwrkPpOvlP7YnoFxtDAhsTAnX
        i2hpDaYcvcicCM+IqOQRQDuHemjmfT3KAOLNdJfa/thgJNigyz/IB8Fkw8dVzHaQ=
X-Google-Smtp-Source: APXvYqyeF3PXYvL+hLHMcPV0JscpENeaBVrCj6QzL51sQ2zgmiJdeOk1gdKeGs6ltVx6TDNGYgzvXpgJGUPhuQ==
X-Received: by 2002:a63:6056:: with SMTP id u83mr33973019pgb.181.1563322313306;
 Tue, 16 Jul 2019 17:11:53 -0700 (PDT)
Date:   Tue, 16 Jul 2019 17:11:49 -0700
Message-Id: <52bf9d45b8e2b72ff32aa773f2415bf7b2b86da2.1563322192.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH] submodule: plumb --filter to cloned submodules
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning a repo with a --filter and with --recurse-submodules
enabled, the partial clone filter only applies to the top-level repo.
This can lead to unexpected bandwidth and disk usage for projects which
include large submodules.

Fix this by plumbing the --filter argument from git-clone through
git-submodule and git-submodule--helper.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/clone.c                    |  9 +++++++
 builtin/submodule--helper.c        | 41 +++++++++++++++++++++++++-----
 git-submodule.sh                   | 17 ++++++++++++-
 t/t5617-clone-submodules-remote.sh | 19 ++++++++++++++
 4 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a4fe72879d..2e7ecbd019 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -798,6 +798,15 @@ static int checkout(int submodule_progress)
 			argv_array_push(&args, "--no-fetch");
 		}
 
+		if (filter_options.choice) {
+			struct strbuf expanded_filter = STRBUF_INIT;
+			expand_list_objects_filter_spec(&filter_options,
+							&expanded_filter);
+			argv_array_pushf(&args, "--filter=%s",
+					 expanded_filter.buf);
+			strbuf_release(&expanded_filter);
+		}
+
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 909e77e802..1383a5ae74 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -19,6 +19,7 @@
 #include "diffcore.h"
 #include "diff.h"
 #include "object-store.h"
+#include "list-objects-filter-options.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -1222,7 +1223,8 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference, int dissociate,
-			   int quiet, int progress)
+			   int quiet, int progress,
+			   const struct list_objects_filter_options *filter_options)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
@@ -1244,6 +1246,12 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		argv_array_push(&cp.args, "--dissociate");
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
+	if (filter_options->choice) {
+		struct strbuf expanded_filter = STRBUF_INIT;
+		expand_list_objects_filter_spec(filter_options, &expanded_filter);
+		argv_array_pushf(&cp.args, "--filter=%s", expanded_filter.buf);
+		strbuf_release(&expanded_filter);
+	}
 
 	argv_array_push(&cp.args, "--");
 	argv_array_push(&cp.args, url);
@@ -1359,6 +1367,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	char *p, *path = NULL, *sm_gitdir;
 	struct strbuf sb = STRBUF_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
+	struct list_objects_filter_options filter_options;
 	int dissociate = 0;
 	char *sm_alternate = NULL, *error_strategy = NULL;
 
@@ -1386,16 +1395,18 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
 		OPT_BOOL(0, "progress", &progress,
 			   N_("force cloning progress")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
-		   "--url <url> --path <path>"),
+		   "[--filter <filter-spec>] --url <url> --path <path>"),
 		NULL
 	};
 
+	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
@@ -1420,7 +1431,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		prepare_possible_alternates(name, &reference);
 
 		if (clone_submodule(path, sm_gitdir, url, depth, &reference, dissociate,
-				    quiet, progress))
+				    quiet, progress, &filter_options))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
@@ -1454,6 +1465,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	free(sm_gitdir);
 	free(path);
 	free(p);
+	list_objects_filter_release(&filter_options);
 	return 0;
 }
 
@@ -1539,6 +1551,7 @@ struct submodule_update_clone {
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
+	const struct list_objects_filter_options *filter_options;
 
 	/* to be consumed by git-submodule.sh */
 	struct update_clone_data *update_clone;
@@ -1555,7 +1568,7 @@ struct submodule_update_clone {
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
-	NULL, NULL, NULL, \
+	NULL, NULL, NULL, NULL, \
 	NULL, 0, 0, 0, NULL, 0, 0, 1}
 
 
@@ -1681,6 +1694,12 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_pushl(&child->args, "--prefix", suc->prefix, NULL);
 	if (suc->recommend_shallow && sub->recommend_shallow == 1)
 		argv_array_push(&child->args, "--depth=1");
+	if (suc->filter_options->choice) {
+		struct strbuf expanded_filter = STRBUF_INIT;
+		expand_list_objects_filter_spec(suc->filter_options, &expanded_filter);
+		argv_array_pushf(&child->args, "--filter=%s", expanded_filter.buf);
+		strbuf_release(&expanded_filter);
+	}
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
 	argv_array_pushl(&child->args, "--url", url, NULL);
@@ -1844,6 +1863,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	const char *update = NULL;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
+	struct list_objects_filter_options filter_options;
+	int ret;
 
 	struct option module_update_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -1870,6 +1891,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
 		OPT_BOOL(0, "progress", &suc.progress,
 			    N_("force cloning progress")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
 
@@ -1882,6 +1904,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	update_clone_config_from_gitmodules(&suc.max_jobs);
 	git_config(git_update_clone_config, &suc.max_jobs);
 
+	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
 
@@ -1889,13 +1912,19 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		if (parse_submodule_update_strategy(update, &suc.update) < 0)
 			die(_("bad value for update parameter"));
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
+	suc.filter_options = &filter_options;
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0) {
+		list_objects_filter_release(&filter_options);
 		return 1;
+	}
 
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	return update_submodules(&suc);
+	ret = update_submodules(&suc);
+	list_objects_filter_release(&filter_options);
+	return ret;
 }
 
 static int resolve_relative_path(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index c7f58c5756..64c5bdaacc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,7 +10,7 @@ USAGE="[--quiet] [--cached]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
@@ -45,6 +45,7 @@ custom_name=
 depth=
 progress=
 dissociate=
+filter=
 
 die_if_unmatched ()
 {
@@ -520,6 +521,14 @@ cmd_update()
 		--jobs=*)
 			jobs=$1
 			;;
+		--filter)
+			case "$2" in '') usage ;; esac
+			filter="--filter=$2"
+			shift
+			;;
+		--filter=*)
+			filter=$1
+			;;
 		--)
 			shift
 			break
@@ -534,6 +543,11 @@ cmd_update()
 		shift
 	done
 
+	if test -n "$filter" && test "$init" != "1"
+	then
+		usage
+	fi
+
 	if test -n "$init"
 	then
 		cmd_init "--" "$@" || return
@@ -550,6 +564,7 @@ cmd_update()
 		${depth:+--depth "$depth"} \
 		$recommend_shallow \
 		$jobs \
+		$filter \
 		-- \
 		"$@" || echo "#unmatched" $?
 	} | {
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index 37fcce9c40..49448e5a88 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -24,6 +24,13 @@ test_expect_success 'setup' '
 	)
 '
 
+# bare clone giving "srv.bare" for use as our server.
+test_expect_success 'setup bare clone for server' '
+	git clone --bare "file://$(pwd)/." srv.bare &&
+	git -C srv.bare config --local uploadpack.allowfilter 1 &&
+	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
+'
+
 test_expect_success 'clone with --no-remote-submodules' '
 	test_when_finished "rm -rf super_clone" &&
 	git clone --recurse-submodules --no-remote-submodules "file://$pwd/." super_clone &&
@@ -51,4 +58,16 @@ test_expect_success 'check the default is --no-remote-submodules' '
 	)
 '
 
+# do basic partial clone from "srv.bare"
+# confirm partial clone was registered in the local config for super and sub.
+test_expect_success 'clone with --filter' '
+	git clone --recurse-submodules --filter blob:none "file://$pwd/srv.bare" super_clone &&
+	test "$(git -C super_clone config --local core.repositoryformatversion)" = "1" &&
+	test "$(git -C super_clone config --local extensions.partialclone)" = "origin" &&
+	test "$(git -C super_clone config --local core.partialclonefilter)" = "blob:none" &&
+	test "$(git -C super_clone/sub config --local core.repositoryformatversion)" = "1" &&
+	test "$(git -C super_clone/sub config --local extensions.partialclone)" = "origin" &&
+	test "$(git -C super_clone/sub config --local core.partialclonefilter)" = "blob:none"
+'
+
 test_done
-- 
2.22.0.657.g960e92d24f-goog

