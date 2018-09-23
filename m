Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFDC31F453
	for <e@80x24.org>; Sun, 23 Sep 2018 17:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeIWXCx (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 19:02:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:47013 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeIWXCx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 19:02:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so16148969ljj.13
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnpD8aDBS5w8BUDwI3nnwt1gyFNlcPgFmBDxmb9ImGU=;
        b=eu1tovcYPvj7jCiOqoOBj04wSal7M/uEO1+/Aa4If9otQPQkS3K5fpV6cAV9sAjy11
         ZmdOM8LWSrdE9IDk2BgfG1SQmxHxhtf2uGtin4x9KTLUxSJHJl/HQdq0EVoY35u9qj5t
         3OT3g7uUWUYYE338JxJmRS3cwUtMkXHw6cM+4oQS3ISUeaLYSIlXu87L2uEqgy2C7ec2
         hAR0Ot6lEfOcSCOhIFbC4KD7wDicVdOj/O24hqC02OxbwU11UcB+XRlDbykgb4Wh9s87
         TQ9XS8VchXDMIE029nIBu8p4hjTQ3T4OOeFD2Db5nNh4AGAt92FJRnsyIdPM1WyfjkXJ
         WZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnpD8aDBS5w8BUDwI3nnwt1gyFNlcPgFmBDxmb9ImGU=;
        b=bwb1HmqhBBUm/Pza/5HtxfiYAPq+4Pk/F9iU0N3FTFhYBtTxcYvKlAPfn+Nw55q4Zn
         VQAZOL7vfuGh7fIbcoNNt02oujpdvjxZiwwPsxkrW3BNWLg0ALF/65oi8qhCieUWuS5E
         4WG5jJJrHTj//55DLNDaEo5cgAGIQapx//qnr14+cYNGHajLhUm2W2gu4y+npSYnWHa7
         yW+wR436an4I7slMP7yovQzdcvunnELAhWKm+okVXsJvrBILFJygjOdfxWA2sEvGfFOf
         AHL5NmHXV2hhH3AD8UWeurZnawucnAmMRmpyxtaJkCVbwxkMNoZwj8yVLRgkCXqRv5NZ
         x3ag==
X-Gm-Message-State: ABuFfoiAIz9G1LerDurOKWbEuTsbHaYvQ7Fqy4myzea7lpnfYBOuaYHY
        bPihw1SjipdiMaIvH29EKcRBSfoL
X-Google-Smtp-Source: ACcGV61evhwhjYXoE2WZabWT/duRwLHA4e6LcG3t3AWnETNd24niru6b4mhoVJBCPTDcsns7Cpn/+Q==
X-Received: by 2002:a2e:3e0d:: with SMTP id l13-v6mr8112818lja.151.1537722282458;
        Sun, 23 Sep 2018 10:04:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n26-v6sm6089554ljc.7.2018.09.23.10.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 10:04:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] worktree: add per-worktree config files
Date:   Sun, 23 Sep 2018 19:04:38 +0200
Message-Id: <20180923170438.23610-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.647.gb9a6049235
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 Documentation/config.txt               | 11 +++-
 Documentation/git-config.txt           | 26 +++++---
 Documentation/git-worktree.txt         | 37 ++++++++++++
 Documentation/gitrepository-layout.txt |  8 +++
 builtin/config.c                       | 16 ++++-
 cache.h                                |  2 +
 config.c                               |  7 +++
 environment.c                          |  1 +
 setup.c                                |  5 +-
 t/t2029-worktree-config.sh             | 82 ++++++++++++++++++++++++++
 worktree.c                             | 41 +++++++++++++
 worktree.h                             |  6 ++
 12 files changed, 231 insertions(+), 11 deletions(-)
 create mode 100755 t/t2029-worktree-config.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8d85d1a324..c24abf5871 100644
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
@@ -371,6 +372,12 @@ advice.*::
 		editor input from the user.
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
index 8e240435be..4870e00b89 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -45,13 +45,15 @@ unset an existing `--type` specifier with `--no-type`.
 
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
@@ -131,6 +133,11 @@ from all available files.
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
@@ -281,6 +288,10 @@ $XDG_CONFIG_HOME/git/config::
 $GIT_DIR/config::
 	Repository specific configuration file.
 
+$GIT_DIR/config.worktree::
+	This is optional and is only searched when
+	`extensions.worktreeConfig` is present in $GIT_DIR/config.
+
 If no further options are given, all reading options will read all of these
 files that are available. If the global or the system-wide configuration
 file are not available they will be ignored. If the repository configuration
@@ -299,9 +310,10 @@ configuration file. Note that this also affects options like `--replace-all`
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
index e2ee9fc21b..3f9112db56 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -204,6 +204,43 @@ working trees, it can be used to identify worktrees. For example if
 you only have two working trees, at "/abc/def/ghi" and "/abc/def/ggg",
 then "ghi" or "def/ghi" is enough to point to the former working tree.
 
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
+version 2.20.0 will refuse to access repositories with this extension.
+
+Note that in this file, the exception for `core.bare` and
+`core.worktree` is gone. If you have them before, you need to move
+them to the `config.worktree` of the main working directory. You may
+also take this opportunity to move other configuration that you do not
+want to share to all working directories:
+
+ - `core.worktree` and `core.bare` should never be shared
+
+ - `core.sparseCheckout` is recommended per working directory, unless
+   you are sure you always use sparse checkout for all working
+   directories.
+
+When `git config --worktree` is used to set a configuration variable
+in multiple working directory setup, `extensions.worktreeConfig` will
+be automatically set. The two variables `core.worktree` and
+`core.bare` if present will be moved to `config.worktree` of the main
+working tree.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index e85148f05e..36fcca8087 100644
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
@@ -275,6 +280,9 @@ worktrees/<id>/locked::
 	or manually by `git worktree prune`. The file may contain a string
 	explaining why the repository is locked.
 
+worktrees/<id>/config.worktree::
+	Working directory specific configuration file.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/builtin/config.c b/builtin/config.c
index 97b58c4aea..337db7b552 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "urlmatch.h"
 #include "quote.h"
+#include "worktree.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config [<options>]"),
@@ -24,6 +25,7 @@ static char key_delim = ' ';
 static char term = '\n';
 
 static int use_global_config, use_system_config, use_local_config;
+static int use_worktree_config;
 static struct git_config_source given_config_source;
 static int actions, type;
 static char *default_value;
@@ -123,6 +125,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
 	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
 	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
+	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config file")),
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
 	OPT_GROUP(N_("Action")),
@@ -602,6 +605,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (use_global_config + use_system_config + use_local_config +
+	    use_worktree_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
 		error(_("only one config file at a time"));
 		usage_builtin_config();
@@ -645,7 +649,17 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		given_config_source.file = git_etc_gitconfig();
 	else if (use_local_config)
 		given_config_source.file = git_pathdup("config");
-	else if (given_config_source.file) {
+	else if (use_worktree_config) {
+		struct worktree **worktrees = get_worktrees(0);
+		if (repository_format_worktree_config)
+			given_config_source.file = git_pathdup("config.worktree");
+		else if (worktrees[0] && worktrees[1]) {
+			migrate_worktree_config(the_repository);
+			given_config_source.file = git_pathdup("config.worktree");
+		} else
+			given_config_source.file = git_pathdup("config");
+		free_worktrees(worktrees);
+	} else if (given_config_source.file) {
 		if (!is_absolute_path(given_config_source.file) && prefix)
 			given_config_source.file =
 				prefix_filename(prefix, given_config_source.file);
diff --git a/cache.h b/cache.h
index d508f3d4f8..9e9b917e99 100644
--- a/cache.h
+++ b/cache.h
@@ -957,11 +957,13 @@ extern int grafts_replace_parents;
 extern int repository_format_precious_objects;
 extern char *repository_format_partial_clone;
 extern const char *core_partial_clone_filter_default;
+extern int repository_format_worktree_config;
 
 struct repository_format {
 	int version;
 	int precious_objects;
 	char *partial_clone; /* value of extensions.partialclone */
+	int worktree_config;
 	int is_bare;
 	int hash_algo;
 	char *work_tree;
diff --git a/config.c b/config.c
index 3461993f0a..24f68a5208 100644
--- a/config.c
+++ b/config.c
@@ -1695,6 +1695,13 @@ static int do_git_config_sequence(const struct config_options *opts,
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
index 3f3c8746c2..268310b3dc 100644
--- a/environment.c
+++ b/environment.c
@@ -33,6 +33,7 @@ int ref_paranoia = -1;
 int repository_format_precious_objects;
 char *repository_format_partial_clone;
 const char *core_partial_clone_filter_default;
+int repository_format_worktree_config;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 const char *apply_default_whitespace;
diff --git a/setup.c b/setup.c
index b24c811c1c..6169193946 100644
--- a/setup.c
+++ b/setup.c
@@ -423,7 +423,9 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			if (!value)
 				return config_error_nonbool(var);
 			data->partial_clone = xstrdup(value);
-		} else
+		} else if (!strcmp(ext, "worktreeconfig"))
+			data->worktree_config = git_config_bool(var, value);
+		else
 			string_list_append(&data->unknown_extensions, ext);
 	} else if (strcmp(var, "core.bare") == 0) {
 		data->is_bare = git_config_bool(var, value);
@@ -466,6 +468,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 
 	repository_format_precious_objects = candidate->precious_objects;
 	repository_format_partial_clone = candidate->partial_clone;
+	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
 	if (!has_common) {
 		if (candidate->is_bare != -1) {
diff --git a/t/t2029-worktree-config.sh b/t/t2029-worktree-config.sh
new file mode 100755
index 0000000000..4ebdf13cf9
--- /dev/null
+++ b/t/t2029-worktree-config.sh
@@ -0,0 +1,82 @@
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
+	git config --worktree per.worktree is-ok &&
+	cmp_config true extensions.worktreeConfig
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
+test_expect_success 'config --worktree migrate core.bare and core.worktree' '
+	git config core.bare true &&
+	git config --worktree foo.bar true &&
+	cmp_config true extensions.worktreeConfig &&
+	cmp_config true foo.bar &&
+	cmp_config true core.bare &&
+	! git -C wt1 config core.bare
+'
+
+test_done
diff --git a/worktree.c b/worktree.c
index b0d0b5426d..a239f99bdc 100644
--- a/worktree.c
+++ b/worktree.c
@@ -5,6 +5,7 @@
 #include "worktree.h"
 #include "dir.h"
 #include "wt-status.h"
+#include "config.h"
 
 void free_worktrees(struct worktree **worktrees)
 {
@@ -508,3 +509,43 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 	free_worktrees(worktrees);
 	return ret;
 }
+
+void migrate_worktree_config(struct repository *r)
+{
+	struct strbuf worktree_path = STRBUF_INIT;
+	struct strbuf main_path = STRBUF_INIT;
+	struct repository_format format;
+
+	assert(repository_format_worktree_config == 0);
+
+	strbuf_git_common_path(&worktree_path, r, "config.worktree");
+	strbuf_git_path(&main_path, "config");
+
+	read_repository_format(&format, main_path.buf);
+	assert(format.worktree_config == 0);
+
+	if (format.is_bare >= 0) {
+		git_config_set_in_file(worktree_path.buf,
+				       "core.bare", "true");
+		git_config_set_in_file(main_path.buf,
+				       "core.bare", NULL);
+	}
+	if (format.work_tree) {
+		git_config_set_in_file(worktree_path.buf,
+				       "core.worktree",
+				       format.work_tree);
+		git_config_set_in_file(main_path.buf,
+				       "core.worktree", NULL);
+	}
+
+	git_config_set_in_file(main_path.buf,
+			       "extensions.worktreeConfig", "true");
+	if (format.version == 0)
+		git_config_set_in_file(main_path.buf,
+				       "core.repositoryFormatVersion", "1");
+
+	repository_format_worktree_config = 1;
+
+	strbuf_release(&main_path);
+	strbuf_release(&worktree_path);
+}
diff --git a/worktree.h b/worktree.h
index df3fc30f73..b27b407d1b 100644
--- a/worktree.h
+++ b/worktree.h
@@ -108,4 +108,10 @@ extern const char *worktree_git_path(const struct worktree *wt,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
+/*
+ * Called to add extensions.worktreeConfig to $GIT_DIR/config and move
+ * main worktree specific config variables to $GIT_DIR/config.worktree.
+ */
+void migrate_worktree_config(struct repository *r);
+
 #endif
-- 
2.19.0.647.gb9a6049235

