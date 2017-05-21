Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADC9C201CF
	for <e@80x24.org>; Sun, 21 May 2017 12:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754165AbdEUM12 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 08:27:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34900 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbdEUM10 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 08:27:26 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so14426893pfd.2
        for <git@vger.kernel.org>; Sun, 21 May 2017 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SN5NwhglLrerHDaD9FMMrBXBwf59bMla4xOtJG8UZOw=;
        b=u/5TSDIYGmorC76UGB2Uo8ciwC6fjheKh4Ia3HMD3XRXs8h0HE3jCQDJgY0Tol2rkN
         zNOh/fsAc2c/W/HgqYif9ydTmnGMYVLwscUzkZRJe74tSqL/6ztSxCVhFx7G5Dog/L8y
         EFhEIl0ND7MNX6vWBtLa+S7/zt80Yl6KkIIHPQhDeb8KC2AIvgGl86zV3kqJ2/nBr76d
         6Eg1LH8C6rGhe0DkRJ6HjcxU50ps6FgvTZ/C0vtly8/CJfKze6aoEGxbG73CSoOx5PH/
         JXz0QeI68Aa5B1NrHwY043At5HxyqN0tNvlKx4A4rwA9V0r7enCm3bdteo1EuisHyy8g
         Jg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SN5NwhglLrerHDaD9FMMrBXBwf59bMla4xOtJG8UZOw=;
        b=rjt9pmL+iCfzKOmhJKSn6RRbElAc8W2WoOeN4hhRz3aesh9O3kT1hHHw6unDyTM1uZ
         hbmILDShaPZ/CdJHwvVun98s1T+acLoppO4PBxL5xxJhFPkq45lI/oXa0CUDzK+jXWEr
         jk5hNG5+ErcOKEBhHW3WZfSdOYDdf4ClER+wVgLox8n9hk498ahwCB3YEYeyMa6L6/RR
         N18pwyGCM84KtbiRguSLvFIrgI5+GHYNbPq1cfnDKxTO5zRwKZnee30yVBI4H660a7M/
         pR/gnggCmIuNf2wnuRlUg3dPuLqAysJlIP8BiaqlVOH/lOUUHHEBP/+zJj6eek0Kroar
         kkFw==
X-Gm-Message-State: AODbwcBc4fJejsE2cKwk56QUAIB/+UbgA226ck6eQrUqbAlq/dAgPG88
        X4RPhXGl/Cl7fQ==
X-Received: by 10.84.214.23 with SMTP id h23mr22987545pli.127.1495369645989;
        Sun, 21 May 2017 05:27:25 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.73.225])
        by smtp.gmail.com with ESMTPSA id p3sm25420225pgd.36.2017.05.21.05.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 May 2017 05:27:25 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, peff@peff.net,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v1 2/2] submodule: port submodule subcommand status
Date:   Sun, 21 May 2017 17:57:11 +0530
Message-Id: <20170521122711.22021-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170521122711.22021-1-pc44800@gmail.com>
References: <20170521122711.22021-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to make git-submodule status a builtin. 'status' is ported
to submodule--helper, and submodule--helper is called from
git-submodule.sh.

For the purpose of porting cmd_status, the code is split up such that
one function obtains all the list of submodules, acting as the
front-end of git-submodule status. This function later calls the
second function for_each_submodule_list,it which basically loops
through the list of submodules and calls function fn, which in this
case is status_submodule. The third function, status submodule returns
the status of submodule and also takes care of the recursive flag.

The first function module_status parses the options present in argv,
and then with the help of module_list_compute, generates the list of
submodules present in the current working tree.

The second function for_each_submodule_list traverses through the list,
and calls function fn (which in the case of submodule subcommand
foreach is status_submodule) is called for each entry.

The third function status_foreach checks for the various conditions,
and prints the status of the submodule accordingly. Also, this
function takes care of the recursive flag by creating a separate
child_process and running it inside the submodule.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
A new function, get_submodule_displaypath is also introduced for getting
the displaypath of the submodule while taking care of its prefix and
superprefix.

 builtin/submodule--helper.c | 162 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  48 +------------
 2 files changed, 163 insertions(+), 47 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5f0ddd8ad..7c040a375 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -13,6 +13,8 @@
 #include "refs.h"
 #include "connect.h"
 
+typedef void (*submodule_list_func_t)(const struct cache_entry *list_item, void *cb_data);
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -219,6 +221,23 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+
+	if (prefix && super_prefix) {
+		BUG("cannot have prefix '%s' and superprefix '%s'",
+		    prefix, super_prefix);
+	} else if (prefix) {
+		struct strbuf sb = STRBUF_INIT;
+		return xstrdup(relative_path(path, prefix, &sb));
+	} else if (super_prefix) {
+		return xstrfmt("%s/%s", super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 enum describe_step {
 	step_bare = 0,
 	step_tags,
@@ -395,6 +414,13 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void for_each_submodule_list(const struct module_list list, submodule_list_func_t fn, void *cb_data)
+{
+	int i;
+	for (i = 0; i < list.nr; i++)
+		fn(list.entries[i], cb_data);
+}
+
 static void init_submodule(const char *path, const char *prefix, int quiet)
 {
 	const struct submodule *sub;
@@ -532,6 +558,141 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct cb_status {
+	const char *prefix;
+	unsigned int quiet: 1;
+	unsigned int cached: 1;
+	unsigned int recursive: 1;
+};
+#define CB_STATUS_INIT { NULL, 0, 0, 0 }
+
+static void status_submodule(const struct cache_entry *list_item, void *cb_data)
+{
+	struct cb_status *info = cb_data;
+	struct strbuf sub_sha1 = STRBUF_INIT;
+	char* displaypath = NULL;
+	struct argv_array diff_files_arg = ARGV_ARRAY_INIT;
+
+	argv_array_pushl(&diff_files_arg, "diff-files", "--ignore-submodules=dirty",
+			"--quiet", "--", list_item->name, NULL);
+
+	gitmodules_config();
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	if (!submodule_from_path(null_sha1, list_item->name))
+		die(_("no submodule mapping found in .gitmodules for path '%s'"), list_item->name);
+
+	strbuf_addstr(&sub_sha1, oid_to_hex(&list_item->oid));
+
+	if (list_item->ce_flags) {
+		printf(_("U%s %s\n"), sha1_to_hex(null_sha1), displaypath);
+		return;
+	}
+
+	if (!is_submodule_initialized(list_item->name)) {
+		printf(_("-%s %s\n"), sub_sha1.buf, displaypath);
+		return;
+	}
+
+	if (!cmd_diff_files(diff_files_arg.argc, diff_files_arg.argv , info->prefix)) {
+		struct argv_array name_rev_args = ARGV_ARRAY_INIT;
+		argv_array_pushl(&name_rev_args, "set-name-rev", list_item->name,
+				sub_sha1.buf, NULL);
+		printf(_(" %s %s"), sub_sha1.buf, displaypath);
+		set_name_rev(name_rev_args.argc, name_rev_args.argv, info->prefix);
+	} else {
+		struct argv_array name_rev_args = ARGV_ARRAY_INIT;
+
+		if (info->cached == 0) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			struct strbuf sb = STRBUF_INIT;
+
+			prepare_submodule_repo_env(&cp.env_array);
+			cp.dir = list_item->name;
+
+			argv_array_pushl(&cp.args, "git", "rev-parse", "--verify", "HEAD", NULL);
+
+			if (capture_command(&cp, &sb, 0))
+				die(_("Could not run 'git rev-parse --verify HEAD' in submodule %s"), list_item->name);
+
+			strbuf_strip_suffix(&sb, "\n");
+			argv_array_pushl(&name_rev_args, "set-name-rev", list_item->name,
+					sb.buf, NULL);
+
+			printf(_("+%s %s"), sb.buf, displaypath);
+			set_name_rev(name_rev_args.argc, name_rev_args.argv, info->prefix);
+
+			strbuf_release(&sb);
+		} else {
+
+			argv_array_pushl(&name_rev_args, "set-name-rev", list_item->name,
+					sub_sha1.buf, NULL);
+
+			printf(_("+%s %s"), sub_sha1.buf, displaypath);
+			set_name_rev(name_rev_args.argc, name_rev_args.argv, info->prefix);
+		}
+	}
+
+	if (info->recursive) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = list_item->name;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_pushl(&cpr.args, "--super-prefix", displaypath,
+				 "submodule--helper", "status", "--recursive", NULL);
+
+		if (info->cached)
+			argv_array_push(&cpr.args, "--cached");
+
+		if (info->quiet)
+			argv_array_push(&cpr.args, "--quiet");
+
+		if (run_command(&cpr))
+			die(_("Failed to recurse into submodule path %s"), list_item->name);
+	}
+
+}
+
+static int module_status(int argc, const char **argv, const char *prefix)
+{
+	struct cb_status info = CB_STATUS_INIT;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int cached = 0;
+	int recursive = 0;
+
+	struct option module_status_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
+		OPT_BOOL(0, "cached", &cached, N_("Use commit stored in the index instead of the one stored in the submodule HEAD")),
+		OPT_BOOL(0, "recursive", &recursive, N_("Recurse into nested submodules")),
+		OPT_END(),
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_status_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		return 1;
+
+	info.prefix = prefix;
+	info.quiet = !!quiet;
+	info.cached = !!cached;
+	info.recursive = !!recursive;
+
+	for_each_submodule_list(list, status_submodule, &info);
+
+	return 0;
+}
+
 static int module_name(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
@@ -1278,6 +1439,7 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"set-name-rev", set_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
+	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index b6eb5bcce..a142f9c04 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1004,54 +1004,8 @@ cmd_status()
 		shift
 	done
 
-	{
-		git submodule--helper list --prefix "$wt_prefix" "$@" ||
-		echo "#unmatched" $?
-	} |
-	while read -r mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode" "$sha1"
-		name=$(git submodule--helper name "$sm_path") || exit
-		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-		if test "$stage" = U
-		then
-			say "U$sha1 $displaypath"
-			continue
-		fi
-		if ! git submodule--helper is-active "$sm_path" ||
-		{
-			! test -d "$sm_path"/.git &&
-			! test -f "$sm_path"/.git
-		}
-		then
-			say "-$sha1 $displaypath"
-			continue;
-		fi
-		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
-		then
-			revname=$(git submodule--helper set-name-rev "$sm_path" "$sha1")
-			say " $sha1 $displaypath$revname"
-		else
-			if test -z "$cached"
-			then
-				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
-			fi
-			revname=$(git submodule--helper set-name-rev "$sm_path" "$sha1")
-			say "+$sha1 $displaypath$revname"
-		fi
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} "$@"
 
-		if test -n "$recursive"
-		then
-			(
-				prefix="$displaypath/"
-				sanitize_submodule_env
-				wt_prefix=
-				cd "$sm_path" &&
-				eval cmd_status
-			) ||
-			die "$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
-		fi
-	done
 }
 #
 # Sync remote urls for submodules
-- 
2.11.0

