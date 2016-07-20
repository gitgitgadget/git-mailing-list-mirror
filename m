Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB142034E
	for <e@80x24.org>; Wed, 20 Jul 2016 17:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbcGTRZF (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 13:25:05 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34229 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbcGTRY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 13:24:56 -0400
Received: by mail-lf0-f66.google.com with SMTP id l69so3989750lfg.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 10:24:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39s+EF5OdPmRWcFeSU6E5B+Syyd87RZ5+1a7YZCPAf4=;
        b=k0Ojxu66GRy6c9x98ky8j5lTOkxYA1LLiIQYMiFIbGpxCVFsyKX3dyn4fffLkMUaWO
         F/ymFXS0bFLx+hRf/OmevjkGSUz5t3iMOQ525dNjcteM89c4QtWyfsz+srruH2CkW4aF
         FIgBHbijdbQVI2tjiHh/n0C/Bg6PPNSmxtRLk37l6900UtzYE5RbtJz+J06qoUutvQmz
         vdpJJYY+isubp2J6Q09tc6TX0jsKmKrXr7M5H3yDI9OMYr/OM+jJYeTzQ8QziNbAqDT8
         mnFBbFF9n41JYB7BuxSq65UkikbLYZwNUGhVQ2/FUPsKfEKi8uOh6LgMuI607kxxNJiC
         Wo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39s+EF5OdPmRWcFeSU6E5B+Syyd87RZ5+1a7YZCPAf4=;
        b=Ok27Sx8k2j3fWyP4O8bUn7Q5wWCog61aX+AsyS/Go1nH5NzmmZBpIW5I4QrTPOc/4j
         qlOObf6EDfjOJLdKTi+Y1MZzMeYh00X4QS1LF6TvN+Mf4daE29V7C2ay0THLeETJflYy
         Wd7tp8I2wKug5JdGioTdLbc5gs1VlHXTCRxkWj5AhuMGZU8hhDl/eWe0BFUj/LL1ZCrf
         GMQgZ0kPKdc0WELYj+5ZcbTunxT3jwicbtPRJMWqYFrBkL1Bhs/o9/hXlw77PNJioGQy
         +XtRYtyG6lnpQNnJTbean4scpNOvCKgfZxHaZLwqn0Zxx35UHVDjYH/NG3CvHMBkZWD/
         67Ow==
X-Gm-Message-State: ALyK8tIcH6t5CPjU8bXb2MgyxDKzromYNTMsFlJEsBMfebQg4yydfDuPEcYADx/CjrbFTA==
X-Received: by 10.25.22.97 with SMTP id m94mr6305406lfi.70.1469035494317;
        Wed, 20 Jul 2016 10:24:54 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g74sm777884ljg.24.2016.07.20.10.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jul 2016 10:24:53 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	max@max630.net, Junio C Hamano <gitster@pobox.com>,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	larsxschneider@gmail.com, sbeller@google.com, mhagger@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/4] worktree: add per-worktree config files
Date:	Wed, 20 Jul 2016 19:24:16 +0200
Message-Id: <20160720172419.25473-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <20160720172419.25473-1-pclouds@gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A new repo extension is added, worktreeConfig. When it is present:

 - Repository config reading by default includes $GIT_DIR/config _and_
   $GIT_DIR/config.worktree. "config" file remains shared in multiple
   worktree setup.

 - The special treatment for core.bare and core.worktree, to stay
   effective only in main worktree, is gone. These config files are
   supposed to be in config.worktree.

This extension is most useful in multiple worktree setup because you
now have an option to store per-worktree config (which is either
.git/config.worktree for main worktree, or
.git/worktrees/xx/config.worktree for linked ones).

This extension can be used in single worktree mode, even though it's
pretty much useless (but this can happen after you remove all linked
worktrees and move back to single worktree).

"git config" reads from both "config" and "config.worktree" by default
(i.e. without either --user, --file...) when this extension is
present. Default writes still go to "config", not "config.worktree". A
new option --worktree is added for that (*).

Since a new repo extension is introduced, existing git binaries should
refuse to access to the repo (both from main and linked worktrees). So
they will not misread the config file (i.e. skip the config.worktree
part). They may still accidentally write to the config file anyway if
they use with "git config --file <path>".

This design places a bet on the assumption that the majority of config
variables are shared so it is the default mode. A safer move would be
default writes go to per-worktree file, so that accidental changes are
isolated.

(*) "git config --worktree" points back to "config" file when this
    extension is not present so that it works in any setup.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt               | 11 ++++-
 Documentation/git-config.txt           | 26 ++++++++----
 Documentation/git-worktree.txt         | 31 ++++++++++++++
 Documentation/gitrepository-layout.txt |  8 ++++
 builtin/config.c                       | 18 +++++++-
 cache.h                                |  2 +
 config.c                               |  7 ++++
 environment.c                          |  1 +
 setup.c                                |  5 ++-
 t/t2028-worktree-config.sh (new +x)    | 77 ++++++++++++++++++++++++++++++++++
 10 files changed, 175 insertions(+), 11 deletions(-)
 create mode 100755 t/t2028-worktree-config.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 16dc22d..7d64da0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2,8 +2,9 @@ CONFIGURATION FILE
 ------------------
 
 The Git configuration file contains a number of variables that affect
-the Git commands' behavior. The `.git/config` file in each repository
-is used to store the configuration for that repository, and
+the Git commands' behavior. The files `.git/config` and optionally
+`config.worktree` (see `extensions.worktreeConfig` below) are each
+repository is used to store the configuration for that repository, and
 `$HOME/.gitconfig` is used to store a per-user configuration as
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
@@ -264,6 +265,12 @@ advice.*::
 		show directions on how to proceed from the current state.
 --
 
+extensions.worktreeConfig::
+	If set, by default "git config" reads from both "config" and
+	"config.worktree" file in that order. In multiple working
+	directory mode, "config" file is shared while
+	"config.worktree" is per-working directory.
+
 core.fileMode::
 	Tells Git if the executable bit of files in the working tree
 	is to be honored.
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index f163113..9dfdb6a 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -47,13 +47,15 @@ checks or transformations are performed on the value.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
-`--system`, `--global`, `--local` and `--file <filename>` can be
-used to tell the command to read from only that location (see <<FILES>>).
+`--system`, `--global`, `--local`, `--worktree` and
+`--file <filename>` can be used to tell the command to read from only
+that location (see <<FILES>>).
 
 When writing, the new value is written to the repository local
 configuration file by default, and options `--system`, `--global`,
-`--file <filename>` can be used to tell the command to write to
-that location (you can say `--local` but that is the default).
+`--worktree`, `--file <filename>` can be used to tell the command to
+write to that location (you can say `--local` but that is the
+default).
 
 This command will fail with non-zero status upon error.  Some exit
 codes are:
@@ -133,6 +135,11 @@ from all available files.
 +
 See also <<FILES>>.
 
+--worktree::
+	Similar to `--local` except that `.git/config.worktree` is
+	read from or written to if `extensions.worktreeConfig` is
+	present. If not it's the same as `--local`.
+
 -f config-file::
 --file config-file::
 	Use the given config file instead of the one specified by GIT_CONFIG.
@@ -253,6 +260,10 @@ $XDG_CONFIG_HOME/git/config::
 $GIT_DIR/config::
 	Repository specific configuration file.
 
+$GIT_DIR/config.worktree::
+	This is optional and is only searched when
+	`extensions.worktreeConfig` is present in $GIT_DIR/config.
+
 If no further options are given, all reading options will read all of these
 files that are available. If the global or the system-wide configuration
 file are not available they will be ignored. If the repository configuration
@@ -268,9 +279,10 @@ configuration file. Note that this also affects options like `--replace-all`
 and `--unset`. *'git config' will only ever change one file at a time*.
 
 You can override these rules either by command-line options or by environment
-variables. The `--global` and the `--system` options will limit the file used
-to the global or system-wide file respectively. The `GIT_CONFIG` environment
-variable has a similar effect, but you can specify any filename you want.
+variables. The `--global`, `--system` and `--worktree` options will limit
+the file used to the global, system-wide or per-worktree file respectively.
+The `GIT_CONFIG` environment variable has a similar effect, but you
+can specify any filename you want.
 
 
 ENVIRONMENT
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 7c4cfb0..41350db 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -111,6 +111,37 @@ OPTIONS
 --expire <time>::
 	With `prune`, only expire unused working trees older than <time>.
 
+CONFIGURATION FILE
+------------------
+By default, the repository "config" file is shared across all working
+directories. If the config variables `core.bare` or `core.worktree`
+are already present in the config file, they will be applied to the
+main working directory only.
+
+In order to have configuration specific to working directories, you
+can turn on "worktreeConfig" extension, e.g.:
+
+------------
+$ git config extensions.worktreeConfig true
+------------
+
+In this mode, specific configuration stays in the path pointed by `git
+rev-parse --git-path config.worktree`. You can add or update
+configuration in this file with `git config --worktree`. Git before
+version XXX will refuse to access repositories with this extension.
+
+Note that in this file, the exception for `core.bare` and
+core.worktree` is gone. If you have them before, you need to move them
+to the config.worktree of the main working directory. You may also
+take this opportunity to move other configuration that you do not want
+to share to all working directories:
+
+ - `core.worktree` and `core.bare` should never be shared
+
+ - `core.sparseCheckout` is recommended per working directory, unless
+   you are sure you always use sparse checkout for all working
+   directories.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 577ee84..6cfdb4c 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -143,6 +143,11 @@ config::
 	if $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/config" will be
 	used instead.
 
+config.worktree::
+	Working directory specific configuration file for the main
+	working directory in multiple working directory setup (see
+	linkgit:git-worktree[1]).
+
 branches::
 	A slightly deprecated way to store shorthands to be used
 	to specify a URL to 'git fetch', 'git pull' and 'git push'.
@@ -276,6 +281,9 @@ worktrees/<id>/link::
 	file. It is used to detect if the linked repository is
 	manually removed.
 
+worktrees/<id>/config.worktree::
+	Working directory specific configuration file.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/builtin/config.c b/builtin/config.c
index 1d7c6ef..535707c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -4,6 +4,7 @@
 #include "parse-options.h"
 #include "urlmatch.h"
 #include "quote.h"
+#include "worktree.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config [<options>]"),
@@ -23,6 +24,7 @@ static char key_delim = ' ';
 static char term = '\n';
 
 static int use_global_config, use_system_config, use_local_config;
+static int use_worktree_config;
 static struct git_config_source given_config_source;
 static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
@@ -57,6 +59,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
 	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
 	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
+	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config file")),
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
 	OPT_GROUP(N_("Action")),
@@ -491,6 +494,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (use_global_config + use_system_config + use_local_config +
+	    use_worktree_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
 		error("only one config file at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
@@ -525,7 +529,19 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		given_config_source.file = git_etc_gitconfig();
 	else if (use_local_config)
 		given_config_source.file = git_pathdup("config");
-	else if (given_config_source.file) {
+	else if (use_worktree_config) {
+		if (repository_format_worktree_config)
+			given_config_source.file = git_pathdup("config.worktree");
+		else {
+			struct worktree **worktrees = get_worktrees();
+			if (worktrees[0] && worktrees[1])
+				die(_("Per-worktree configuration requires extensions.worktreeConfig\n"
+				      "Please read section CONFIGURATION in `git help worktree` before\n"
+				      "enabling it."));
+			free_worktrees(worktrees);
+			given_config_source.file = git_pathdup("config");
+		}
+	} else if (given_config_source.file) {
 		if (!is_absolute_path(given_config_source.file) && prefix)
 			given_config_source.file =
 				xstrdup(prefix_filename(prefix,
diff --git a/cache.h b/cache.h
index f1dc289..606500e 100644
--- a/cache.h
+++ b/cache.h
@@ -757,10 +757,12 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
+extern int repository_format_worktree_config;
 
 struct repository_format {
 	int version;
 	int precious_objects;
+	int worktree_config;
 	int is_bare;
 	char *work_tree;
 	struct string_list unknown_extensions;
diff --git a/config.c b/config.c
index bea937e..99ff6be 100644
--- a/config.c
+++ b/config.c
@@ -1254,6 +1254,13 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
 	if (repo_config && !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file(fn, repo_config, data);
 
+	if (repository_format_worktree_config) {
+		char *path = git_pathdup("config.worktree");
+		if (!access_or_die(path, R_OK, 0))
+			ret += git_config_from_file(fn, path, data);
+		free(path);
+	}
+
 	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
 	if (git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
diff --git a/environment.c b/environment.c
index ca72464..b4d56ef 100644
--- a/environment.c
+++ b/environment.c
@@ -26,6 +26,7 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
+int repository_format_worktree_config;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 const char *apply_default_whitespace;
diff --git a/setup.c b/setup.c
index 6d0e0c9..75c784f 100644
--- a/setup.c
+++ b/setup.c
@@ -389,6 +389,8 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			data->precious_objects = git_config_bool(var, value);
+		else if (!strcmp(ext, "worktreeconfig"))
+			data->worktree_config = git_config_bool(var, value);
 		else
 			string_list_append(&data->unknown_extensions, ext);
 	} else if (strcmp(var, "core.bare") == 0) {
@@ -432,8 +434,9 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	}
 
 	repository_format_precious_objects = candidate.precious_objects;
+	repository_format_worktree_config = candidate.worktree_config;
 	string_list_clear(&candidate.unknown_extensions, 0);
-	if (!has_common) {
+	if (!has_common || repository_format_worktree_config) {
 		if (candidate.is_bare != -1) {
 			is_bare_repository_cfg = candidate.is_bare;
 			if (is_bare_repository_cfg == 1)
diff --git a/t/t2028-worktree-config.sh b/t/t2028-worktree-config.sh
new file mode 100755
index 0000000..34067df
--- /dev/null
+++ b/t/t2028-worktree-config.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+
+test_description="config file in multi worktree"
+
+. ./test-lib.sh
+
+cmp_config() {
+	if [ "$1" = "-C" ]; then
+		shift &&
+		GD="-C $1" &&
+		shift
+	else
+		GD=
+	fi &&
+	echo "$1" >expected &&
+	shift &&
+	git $GD config "$@" >actual &&
+	test_cmp expected actual
+}
+
+test_expect_success 'setup' '
+	test_commit start &&
+	git config --worktree per.worktree is-ok &&
+	git worktree add wt1 &&
+	git worktree add wt2 &&
+	test_must_fail git config --worktree per.worktree is-not-ok &&
+	git config extensions.worktreeConfig true
+'
+
+test_expect_success 'config is shared as before' '
+	git config this.is shared &&
+	cmp_config shared this.is &&
+	cmp_config -C wt1 shared this.is &&
+	cmp_config -C wt2 shared this.is
+'
+
+test_expect_success 'config is shared (set from another worktree)' '
+	git -C wt1 config that.is also-shared &&
+	cmp_config also-shared that.is &&
+	cmp_config -C wt1 also-shared that.is &&
+	cmp_config -C wt2 also-shared that.is
+'
+
+test_expect_success 'config private to main worktree' '
+	git config --worktree this.is for-main &&
+	cmp_config for-main this.is &&
+	cmp_config -C wt1 shared this.is &&
+	cmp_config -C wt2 shared this.is
+'
+
+test_expect_success 'config private to linked worktree' '
+	git -C wt1 config --worktree this.is for-wt1 &&
+	cmp_config for-main this.is &&
+	cmp_config -C wt1 for-wt1 this.is &&
+	cmp_config -C wt2 shared this.is
+'
+
+test_expect_success 'core.bare no longer for main only' '
+	git config core.bare true &&
+	cmp_config true core.bare &&
+	cmp_config -C wt1 true core.bare &&
+	cmp_config -C wt2 true core.bare &&
+	git config --unset core.bare
+'
+
+test_expect_success 'config.worktree no longer read without extension' '
+	git config --unset extensions.worktreeConfig &&
+	cmp_config shared this.is &&
+	cmp_config -C wt1 shared this.is &&
+	cmp_config -C wt2 shared this.is
+'
+
+test_expect_success 'config --worktree fails in multi worktree without extension' '
+	test_must_fail git config --worktree foo.bar true
+'
+
+test_done
-- 
2.9.1.566.gbd532d4

