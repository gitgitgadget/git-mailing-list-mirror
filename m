Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B4E81FA14
	for <e@80x24.org>; Fri, 26 May 2017 15:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947895AbdEZPZU (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 11:25:20 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35705 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947923AbdEZPY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 11:24:59 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so3490405pfd.2
        for <git@vger.kernel.org>; Fri, 26 May 2017 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MNNWR3fLyYlJiCS9HPsRJNZof95ydY20XlZZ7YyWhkI=;
        b=V69hYB8/vtSHjI9G1OFVXm7MZIQqnwD7bv4yDITWGnkizSDLgPZ67o2MeXyMooDhaD
         JfCtakkeMhYUXp8kTzCkOyjVLVWRoSik+oAiuApVhJtjpWgheKkPvSdbVPLTCwjeV5oJ
         8QTLfbEYJeHwdA7uqf4aySY3erGI3+A8niaijg/1iCDU4JR61JhX6HZoMr1VjvTbWtKw
         M8o6x/WO1hHZD9m0xCL4JoSksUVlGBm4oepvgrjX9pHah936E6hgBj2vwkZMvc6DBCnG
         l/JnKpi3Hcd3s/40NFz2uxxbz2DoLFxXUIgidiqc/k0Q8VDKW/Io2Exms+0Bq5JsaZAA
         csqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MNNWR3fLyYlJiCS9HPsRJNZof95ydY20XlZZ7YyWhkI=;
        b=kKzjVeuuEzhabYETcOpmkWUaNy9WYJtSd8MFkvgw29sxVqx5HNvRmAkc8Bh0FpWSU5
         gByRwhgI82fF7eq/ihB1EQmVHAOVcEHpVJ+aiQ+pUxTd7EfzzVY7qVK6PJSy1A1DYb/z
         YBQraoPJlCZ4AGt1CAf+JySgauKIU4ITV4P0Z2i01eA3uoAzYbPhOLZopwENZEo3tAM6
         GFhty2147MNHcDHLX3Wj8Nu37at0UiW2AHpzMvV8WNQ/wkeKoXSfHz9IBQPOIeMC2Vw8
         o/rVCUmM/hxHX26Atvc72rJePl5smh41YOvwqz87V9kJaBe3cySebFME/rWOzVSxylCt
         DlpQ==
X-Gm-Message-State: AODbwcDLcV2WubCj0SKW0nTgs4v7dOHZj0+vHM6n0XfKPzAqkfSik7qQ
        5JIvu2+rkMsC2eSgJ9M=
X-Received: by 10.98.28.202 with SMTP id c193mr3046257pfc.233.1495811853535;
        Fri, 26 May 2017 08:17:33 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.73.225])
        by smtp.gmail.com with ESMTPSA id e24sm3105198pgn.1.2017.05.26.08.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 May 2017 08:17:32 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, christian.couder@gmail.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v5 3/3] submodule: port subcommand foreach from shell to C
Date:   Fri, 26 May 2017 20:47:13 +0530
Message-Id: <20170526151713.10974-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170526151713.10974-1-pc44800@gmail.com>
References: <20170521125814.26255-2-pc44800@gmail.com>
 <20170526151713.10974-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to make git-submodule foreach a builtin. This is the very
first step taken in this direction. Hence, 'foreach' is ported to
submodule--helper, and submodule--helper is called from git-submodule.sh.
The code is split up to have one function to obtain all the list of
submodules. This function acts as the front-end of git-submodule foreach
subcommand. It calls the function for_each_submodule_list, which basically
loops through the list and calls function fn, which in this case is
runcommand_in_submodule. This third function is a calling function that
takes care of running the command in that submodule, and recursively
perform the same when --recursive is flagged.

The first function module_foreach first parses the options present in
argv, and then with the help of module_list_compute, generates the list of
submodules present in the current working tree.

The second function for_each_submodule_list traverses through the
list, and calls function fn (which in case of submodule subcommand
foreach is runcommand_in_submodule) is called for each entry.

The third function runcommand_in_submodule, generates a submodule struct sub
for $name, value and then later prepends name=sub->name; and other
value assignment to the env argv_array structure of a child_process.
Also the <command> of submodule-foreach is push to args argv_array
structure and finally, using run_command the commands are executed
using a shell.

The third function also takes care of the recursive flag, by creating
a separate child_process structure and prepending "--super-prefix displaypath",
to the args argv_array structure. Other required arguments and the
input <command> of submodule-foreach is also appended to this argv_array.

The commit 1c4fb136db (submodule foreach: skip eval for more than one
argument, 2013-09-27), which explains that why for the case when argc>1,
we do not use eval. But since in this patch, we are calling the
command in a separate shell itself for all values of argc, this case
is not considered separately.

Both env variable $path and $sm_path were added since both are used in
tests in t7407.

Helped-by: Brandon Williams <bmwill@google.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
These series of patches passes the complete test suite.
Its build report is available at:
https://travis-ci.org/pratham-pc/git/builds
Branch: submodule-foreach
Build #71

 builtin/submodule--helper.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  39 +-----------
 2 files changed, 149 insertions(+), 38 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 566a5b6a6..343b6269c 100644
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
@@ -219,6 +221,26 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
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
+		char *displaypath;
+		displaypath = xstrdup(relative_path(path, prefix, &sb));
+		strbuf_release(&sb);
+		return displaypath;
+	} else if (super_prefix) {
+		return xstrfmt("%s/%s", super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -331,6 +353,14 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void for_each_submodule_list(const struct module_list list,
+				    submodule_list_func_t fn, void *cb_data)
+{
+	int i;
+	for (i = 0; i < list.nr; i++)
+		fn(list.entries[i], cb_data);
+}
+
 static void init_submodule(const char *path, const char *prefix, int quiet)
 {
 	const struct submodule *sub;
@@ -487,6 +517,123 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct cb_foreach {
+	int argc;
+	const char **argv;
+	const char *prefix;
+	unsigned int quiet: 1;
+	unsigned int recursive: 1;
+};
+#define CB_FOREACH_INIT { 0, NULL, NULL, 0, 0 }
+
+static void runcommand_in_submodule(const struct cache_entry *list_item,
+				    void *cb_data)
+{
+	struct cb_foreach *info = cb_data;
+	char *toplevel = xgetcwd();
+	const struct submodule *sub;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char* displaypath = NULL;
+	int i;
+
+	/* Only loads from .gitmodules, no overlay with .git/config */
+	gitmodules_config();
+
+	sub = submodule_from_path(null_sha1, list_item->name);
+
+	if (!sub)
+		die(_("No url found for submodule path '%s' in .gitmodules"),
+		      displaypath);
+
+	if (!is_submodule_populated_gently(list_item->name, NULL))
+		return;
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.use_shell = 1;
+	cp.dir = list_item->name;
+
+	argv_array_pushf(&cp.env_array, "name=%s", sub->name);
+	argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
+	argv_array_pushf(&cp.env_array, "path=%s", list_item->name);
+	argv_array_pushf(&cp.env_array, "sha1=%s", oid_to_hex(&list_item->oid));
+	argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
+
+	for (i = 0; i < info->argc; i++)
+		argv_array_push(&cp.args, info->argv[i]);
+
+	if (!info->quiet)
+		printf(_("Entering '%s'\n"), displaypath);
+
+	if (info->argv[0] && run_command(&cp))
+		die(_("run_command returned non-zero status for %s\n."),
+		      displaypath);
+
+	if (info->recursive) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = list_item->name;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_pushl(&cpr.args, "--super-prefix", displaypath,
+				 "submodule--helper", "foreach", "--recursive",
+				 NULL);
+
+		if (info->quiet)
+			argv_array_push(&cpr.args, "--quiet");
+
+		for (i = 0; i < info->argc; i++)
+			argv_array_push(&cpr.args, info->argv[i]);
+
+		if (run_command(&cpr))
+			die(_("run_command returned non-zero status while"
+			      "recursing in the nested submodules of %s\n."),
+			      displaypath);
+	}
+
+	free(displaypath);
+	free(toplevel);
+}
+
+static int module_foreach(int argc, const char **argv, const char *prefix)
+{
+	struct cb_foreach info;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int recursive = 0;
+
+	struct option module_foreach_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output of entering each submodule command")),
+		OPT_BOOL(0, "recursive", &recursive,
+			 N_("Recurse into nested submodules")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper foreach [--quiet] [--recursive] <command>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_foreach_options,
+			     git_submodule_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
+		BUG("module_list_compute should not choke on empty pathspec");
+
+	info.argc = argc;
+	info.argv = argv;
+	info.prefix = prefix;
+	info.quiet = quiet;
+	info.recursive = recursive;
+
+	for_each_submodule_list(list, runcommand_in_submodule, &info);
+
+	return 0;
+}
+
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
 			   int quiet, int progress)
@@ -1212,6 +1359,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index ea6f56337..032fd2540 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -322,45 +322,8 @@ cmd_foreach()
 		shift
 	done
 
-	toplevel=$(pwd)
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
 
-	# dup stdin so that it can be restored when running the external
-	# command in the subshell (and a recursive call to this function)
-	exec 3<&0
-
-	{
-		git submodule--helper list --prefix "$wt_prefix" ||
-		echo "#unmatched" $?
-	} |
-	while read -r mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode" "$sha1"
-		if test -e "$sm_path"/.git
-		then
-			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-			say "$(eval_gettext "Entering '\$displaypath'")"
-			name=$(git submodule--helper name "$sm_path")
-			(
-				prefix="$prefix$sm_path/"
-				sanitize_submodule_env
-				cd "$sm_path" &&
-				# we make $path available to scripts ...
-				path=$sm_path &&
-				sm_path=$displaypath &&
-				if test $# -eq 1
-				then
-					eval "$1"
-				else
-					"$@"
-				fi &&
-				if test -n "$recursive"
-				then
-					cmd_foreach "--recursive" "$@"
-				fi
-			) <&3 3<&- ||
-			die "$(eval_gettext "Stopping at '\$displaypath'; script returned non-zero status.")"
-		fi
-	done
 }
 
 #
-- 
2.11.0

