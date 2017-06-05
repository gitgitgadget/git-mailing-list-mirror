Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35BF20D11
	for <e@80x24.org>; Mon,  5 Jun 2017 20:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbdFEU0Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 16:26:25 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34590 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEU0W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 16:26:22 -0400
Received: by mail-pg0-f68.google.com with SMTP id v14so7111321pgn.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BeTv3JzNg+ExL2CmoZ4aPHWWWIQ808bZASCuAaFKRyY=;
        b=Al+Q6WGbklA9Cigd95pH9rk35LyowVSZ2rqTmfAQTQftALR7sDGoNQXae0d43kV7nE
         Mmi+yFhVMh6AmntsXAoS9kitYs9nPxMDW2CYPpUymY/8cnwCqjAGt1nrtkI2pQHCIMt1
         FIgfKYHRUrrtVHbyQmgGEZ6zFtLn3APkz1w0URpFwSuLIUOOlMTVp/IIEoL7ZhubRJr/
         DFXoZdUcJnKVJgvEF5RwJPdkV1LgSzlFl+2LSSANFWQOUPZ+j9i0m+Iezmeh+BlcezHp
         3i2OY8koKzHUZqy8HZ0jOTum4SqgwutXgjhUzgBc5ItRqpGzbax7VdFgp/BOvPH4S6gW
         SALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BeTv3JzNg+ExL2CmoZ4aPHWWWIQ808bZASCuAaFKRyY=;
        b=J6qRKaRwRGxDIwsH4RT9+KngCdLp5iONdbf4jCniDphkkJbft1WeBOrpw/w+obie+A
         FiyDX4Qu+zvOYe+yvWtL1o0uI1KXduooLhkg33cMKvE6RV/PjXQEIORTICkk4fv0EJii
         rVO6FjoUdofFDcNt7G+3tbM6MYANmt0b90Idr4qe7qUtSeOPMQDtWf0v/EyFikYoun+Z
         VtC8amCFV8wARnUXwNyVbcsq2Ewg4TGqiiFYVhDGcOwKM7o+N/oMdoVcFQqJiCWoh0xB
         +GfKFXxtm6Useiwo2jyurwnSkRL5eIonJjtnsmFcISlNkrpB3MbvDTzqU8gAQE0TWwhJ
         5Ohg==
X-Gm-Message-State: AODbwcD1XMsZ3WQ1tJKbg9mYd/V85aOWMayZRINMolFmFxtknQ843Eq5
        2v/4MoNNfgpEMQ==
X-Received: by 10.84.194.226 with SMTP id h89mr3540502pld.58.1496694381483;
        Mon, 05 Jun 2017 13:26:21 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id s10sm29840633pfi.16.2017.06.05.13.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 13:26:20 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v2 2/2] submodule: port submodule subcommand status
Date:   Tue,  6 Jun 2017 01:55:29 +0530
Message-Id: <20170605202529.22959-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170605202529.22959-1-pc44800@gmail.com>
References: <CAGZ79kYeJoVGRFyeGsXevo2JmDMoxf=tJubWcy5Qt==3QK=Hjg@mail.gmail.com>
 <20170605202529.22959-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to make git-submodule subcommand status a builtin. Here
'status' is ported to submodule--helper, and submodule--helper is
called from git-submodule.sh.

For the purpose of porting cmd_status, the code is split up such that
one function obtains all the list of submodules, acting as the front-end
of git-submodule status. This function later calls the second function
for_each_submodule_list,it which basically loops through the list of
submodules and calls function fn, which in this case is status_submodule.
The third function, status submodule returns the status of submodule and
also takes care of the recursive flag.

The first function module_status parses the options present in argv,
and then with the help of module_list_compute, generates the list of
submodules present in the current working tree.

The second function for_each_submodule_list traverses through the list,
and calls function fn (which in the case of submodule subcommand status
is status_submodule) is called for each entry.

The third function status_submodule checks for the various conditions,
and prints the status of the submodule accordingly. Also, this function
takes care of the recursive flag by creating a separate child_process
and running it inside the submodule. The function print_status handles the
printing of submodule's status.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
In this new version of patch, function print_status is introduced.

The functions for_each_submodule_list and get_submodule_displaypath
are found to be the same as those in the ported submodule subcommand
foreach's patches. The reason for doing so is to keep both the patches
independant and on separate branches. Also this patch is build on
the branch gitster/jk/bug-to-abort for utilizing its BUG() macro.
 
Complete build report is available at:
https://travis-ci.org/pratham-pc/git/builds/
Branch: submodule-status-new
Build #91

 builtin/submodule--helper.c | 181 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  49 +-----------
 2 files changed, 182 insertions(+), 48 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3022118d1..85da05550 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -13,6 +13,9 @@
 #include "refs.h"
 #include "connect.h"
 
+typedef void (*submodule_list_func_t)(const struct cache_entry *list_item,
+				      void *cb_data);
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -219,6 +222,25 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
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
+		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
+		strbuf_release(&sb);
+		return displaypath;
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
@@ -397,6 +419,13 @@ static int module_list(int argc, const char **argv, const char *prefix)
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
@@ -534,6 +563,157 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct status_cb {
+	const char *prefix;
+	unsigned int quiet: 1;
+	unsigned int recursive: 1;
+	unsigned int cached: 1;
+};
+#define STATUS_CB_INIT { NULL, 0, 0, 0 }
+
+static void print_status(struct status_cb *info, char state, const char *path,
+			 char *sub_sha1, char *displaypath)
+{
+	if (info->quiet)
+		return;
+
+	printf("%c%s %s", state, sub_sha1, displaypath);
+
+	if (state == ' ' || state == '+') {
+		struct argv_array name_rev_args = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&name_rev_args, "print-name-rev",
+				 path, sub_sha1, NULL);
+		print_name_rev(name_rev_args.argc, name_rev_args.argv,
+			       info->prefix);
+	} else {
+		printf("\n");
+	}
+}
+
+static void status_submodule(const struct cache_entry *list_item, void *cb_data)
+{
+	struct status_cb *info = cb_data;
+	char *sub_sha1 = xstrdup(oid_to_hex(&list_item->oid));
+	char *displaypath;
+	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
+
+	if (!submodule_from_path(null_sha1, list_item->name))
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		      list_item->name);
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	if (list_item->ce_flags) {
+		print_status(info, 'U', list_item->name,
+			     sha1_to_hex(null_sha1), displaypath);
+		goto cleanup;
+	}
+
+	if (!is_submodule_initialized(list_item->name)) {
+		print_status(info, '-', list_item->name, sub_sha1, displaypath);
+		goto cleanup;
+	}
+
+	argv_array_pushl(&diff_files_args, "diff-files",
+			 "--ignore-submodules=dirty", "--quiet", "--",
+			 list_item->name, NULL);
+
+	if (!cmd_diff_files(diff_files_args.argc, diff_files_args.argv,
+			    info->prefix)) {
+		print_status(info, ' ', list_item->name, sub_sha1, displaypath);
+	} else {
+		if (!info->cached) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			struct strbuf sb = STRBUF_INIT;
+
+			prepare_submodule_repo_env(&cp.env_array);
+			cp.git_cmd = 1;
+			cp.dir = list_item->name;
+
+			argv_array_pushl(&cp.args, "rev-parse",
+					 "--verify", "HEAD", NULL);
+
+			if (capture_command(&cp, &sb, 0))
+				die(_("could not run 'git rev-parse --verify"
+				      "HEAD' in submodule %s"),
+				      list_item->name);
+
+			strbuf_strip_suffix(&sb, "\n");
+			print_status(info, '+', list_item->name, sb.buf,
+				     displaypath);
+			strbuf_release(&sb);
+		} else {
+			print_status(info, '+', list_item->name, sub_sha1,
+				     displaypath);
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
+				 "submodule--helper", "status", "--recursive",
+				 NULL);
+
+		if (info->cached)
+			argv_array_push(&cpr.args, "--cached");
+
+		if (info->quiet)
+			argv_array_push(&cpr.args, "--quiet");
+
+		if (run_command(&cpr))
+			die(_("failed to recurse into submodule '%s'"),
+			      list_item->name);
+	}
+
+cleanup:
+	free(displaypath);
+	free(sub_sha1);
+}
+
+static int module_status(int argc, const char **argv, const char *prefix)
+{
+	struct status_cb info = STATUS_CB_INIT;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int cached = 0;
+	int recursive = 0;
+
+	struct option module_status_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress submodule status output")),
+		OPT_BOOL(0, "cached", &cached, N_("Use commit stored in the index instead of the one stored in the submodule HEAD")),
+		OPT_BOOL(0, "recursive", &recursive, N_("Recurse into nested submodules")),
+		OPT_END()
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
+	info.recursive = !!recursive;
+	info.cached = !!cached;
+
+	gitmodules_config();
+	for_each_submodule_list(list, status_submodule, &info);
+
+	return 0;
+}
+
 static int module_name(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
@@ -1280,6 +1460,7 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"print-name-rev", print_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
+	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 091051891..a24b1b91b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1004,54 +1004,7 @@ cmd_status()
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
-			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
-			say " $sha1 $displaypath$revname"
-		else
-			if test -z "$cached"
-			then
-				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
-			fi
-			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
-			say "+$sha1 $displaypath$revname"
-		fi
-
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
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} "$@"
 }
 #
 # Sync remote urls for submodules
-- 
2.13.0

