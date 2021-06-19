Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446AEC49EA2
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 00:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCF161284
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 00:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhFSAdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 20:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbhFSAdh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 20:33:37 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933AEC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 17:31:26 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d7-20020ac811870000b02901e65f85117bso8109636qtj.18
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 17:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gTUPgHq61NYjCw+4W63jfvptOiuvIZJ+A0ayZyVMXeI=;
        b=dTB1sp4tG3KGzqOKhsmKc9Gc5RcgvFAG/RftG5+LauIrxytwAc++sW96RvwWDun+jc
         oP8+RgoQeRbNOIqHUuINjk1fqBjiLyNBK3rqmGjQQBIc9zcxcexPE6FtYcIii9cilG3l
         XtfDoxUqZJKbnsnSOPpwD1TXS9uml787rruGyHzAZ0h06rpHJRDkyvwIwAX3ldJZkTcI
         w2PadsVfyG/0rxVjUb8IXFvTAX4Jixc5DpqD17hA+QbK+5PL22ugjbE7UPmqr5QNFZXA
         X6raOhenT70XQhXcMyIoBtds/x491pER46mX1PGNHsV5gfAyabmxmgAtV08ylfqo35Y5
         DL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gTUPgHq61NYjCw+4W63jfvptOiuvIZJ+A0ayZyVMXeI=;
        b=VMkEZrKyBvyQ5VdT9gsta+rAxrtV12fOJ3W+6xxTHPxYo6YvMJFKlGRDMuKqdae5aH
         QBYrKDEtTTL+2uuATVR7/FaIk/+ogc2ZzKimfRCZ6pl/cVpP95A9FbVfSg4MXo77gYTA
         rfAI7JH8ydmZFCh8KFaHqRsje+dSrsSCDWFjKTN67uaHolNdTbeiOmj4o316151kWi7M
         /ucQZBk5Psk4WEvLpDycnFaJ6SIPIJ5ttvPJUscHUmnHl9HSp+djlpfANxyk4fpPxr4U
         UOsEqpIgthz3jtR5+5JxiVx310B1qjACQDDEf1sdhWIR73G4YTpoj4Nr/EgTGnE+Ysc+
         ys+w==
X-Gm-Message-State: AOAM531/av21Eu2C1wwxpV5SxkihJCOl84PAXizZ2PtRYR6Lvcl6r9PK
        FECbgdWaaFi7kkxBjZNUSiNcXCfAhn3uUsFZpYq8InfKY4XUE7/nBSGfR/sp00WeoKrJA3U1xkR
        u86vy1XoLvbO9pWXXPYLtf8/8Lj65/Mfo0pWxRZnswnbBqEbBB7gSttkXL+xOCIFzJggduDJyWQ
        ==
X-Google-Smtp-Source: ABdhPJz4B5HNZU+Ylr7krMPmWTGxI/gXu7ANSuXhu5q8NQYG+YSz6xlQ+jIz+JagfS1neL8EYCe+Gyrc5X7NUSjAN+Q=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:551d:e7ea:4a2f:6667])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:446b:: with SMTP id
 s11mr8293344qvt.51.1624062685643; Fri, 18 Jun 2021 17:31:25 -0700 (PDT)
Date:   Fri, 18 Jun 2021 17:31:17 -0700
In-Reply-To: <20210619003118.1352300-1-emilyshaffer@google.com>
Message-Id: <20210619003118.1352300-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210619003118.1352300-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v3 2/2] config: add 'config.superproject' file
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some configs, such as wrapper directives like gerrit.createChangeId, or
forthcoming hook configs, should apply to a superproject as well as all
its submodules. It may not be appropriate to apply them globally - for
example, if the user also contributes to many projects which do not use
the configs necessary for one project-with-submodules - and it may be
burdensome to apply them locally to the superproject and each of its
submodules. Even if the user runs 'git submodule foreach "git config
--local foo.bar', if a new submodule is added later on, that config is
not applied to the new submodule.

It is also inappropriate to share the entire superproject config, since
some items - like remote URLs or partial-clone filters - would not apply
to a submodule.

To make life easier for projects with many submodules, then, create a
new "config.superproject" config scope, which is included in the config
parse for the superproject as well as for all the submodules of that
superproject.

For the superproject, this new config file is equally local to the local
config; for the submodule, the new config file is less local than the
local config. So let's include it directly before the local config
during the config parse.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Since v1:
    
    - Used test_when_finished liberally in tests instead of bare cleanup steps
    - Fixed some nits regarding xstrdup instead of strbuf_detach.
    
    One thing that I thought about but did not implement: rather than finding the
    path to the superproject's gitdir, you could imagine gathering the config by
    making a call out to 'git -C ../ config' - but on second thought, it seems like
    that will make it harder to edit. However, if we don't want to be able to edit
    superproject config from a submodule, that might be okay... (This approach could
    make 'git config --show-origin' harder to implement, though, I think.) So I did
    not make any changes about that.

 Documentation/git-config.txt   |  21 +++++-
 builtin/config.c               |   9 ++-
 config.c                       |  28 ++++++++
 config.h                       |   3 +
 t/t1311-superproject-config.sh | 116 +++++++++++++++++++++++++++++++++
 5 files changed, 174 insertions(+), 3 deletions(-)
 create mode 100755 t/t1311-superproject-config.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 5cddadafd2..312deea21d 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -48,7 +48,7 @@ unset an existing `--type` specifier with `--no-type`.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
-`--system`, `--global`, `--local`, `--worktree` and
+`--system`, `--global`, `--superproject`, `--local`, `--worktree` and
 `--file <filename>` can be used to tell the command to read from only
 that location (see <<FILES>>).
 
@@ -127,6 +127,17 @@ rather than from all available files.
 +
 See also <<FILES>>.
 
+--superproject::
+	For writing options: write to the superproject's
+	`.git/config.superproject` file, even if run from a submodule of that
+	superproject.
++
+For reading options: read only from the superproject's
+`.git/config.superproject` file, even if run from a submodule of that
+superproject, rather than from all available files.
++
+See also <<FILES>>.
+
 --local::
 	For writing options: write to the repository `.git/config` file.
 	This is the default behavior.
@@ -283,7 +294,7 @@ The default is to use a pager.
 FILES
 -----
 
-If not set explicitly with `--file`, there are four files where
+If not set explicitly with `--file`, there are five files where
 'git config' will search for configuration options:
 
 $(prefix)/etc/gitconfig::
@@ -301,6 +312,12 @@ $XDG_CONFIG_HOME/git/config::
 	User-specific configuration file. Also called "global"
 	configuration file.
 
+$GIT_DIR/config.superproject::
+	When `git config` is run from a project which is a submodule of another
+	project, that superproject's $GIT_DIR will be used. Use this config file
+	to set configurations which need to be the same across a superproject
+	and all its submodules.
+
 $GIT_DIR/config::
 	Repository specific configuration file.
 
diff --git a/builtin/config.c b/builtin/config.c
index 865fddd6ce..83376e0916 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -26,7 +26,7 @@ static char key_delim = ' ';
 static char term = '\n';
 
 static int use_global_config, use_system_config, use_local_config;
-static int use_worktree_config;
+static int use_worktree_config, use_superproject_config;
 static struct git_config_source given_config_source;
 static int actions, type;
 static char *default_value;
@@ -130,6 +130,8 @@ static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
 	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
+	OPT_BOOL(0, "superproject",
+		 &use_superproject_config, N_("use superproject config file")),
 	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
 	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config file")),
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
@@ -697,6 +699,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (use_system_config) {
 		given_config_source.file = git_system_config();
 		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
+	} else if (use_superproject_config) {
+		struct strbuf superproject_cfg = STRBUF_INIT;
+		git_config_superproject(&superproject_cfg, get_git_dir());
+		given_config_source.file = strbuf_detach(&superproject_cfg, NULL);
+		given_config_source.scope = CONFIG_SCOPE_SUPERPROJECT;
 	} else if (use_local_config) {
 		given_config_source.file = git_pathdup("config");
 		given_config_source.scope = CONFIG_SCOPE_LOCAL;
diff --git a/config.c b/config.c
index a5fc4cacd5..97d63a825c 100644
--- a/config.c
+++ b/config.c
@@ -21,6 +21,7 @@
 #include "dir.h"
 #include "color.h"
 #include "refs.h"
+#include "submodule.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1852,6 +1853,19 @@ void git_global_config(char **user_out, char **xdg_out)
 	*xdg_out = xdg_config;
 }
 
+void git_config_superproject(struct strbuf *sb, const char *gitdir)
+{
+	const char *sp_gitdir;
+	if (git_config_get_string_tmp("submodule.superprojectGitDir", &sp_gitdir))
+		/* probably not a submodule */
+		strbuf_addstr(sb, gitdir);
+	else
+		/* definitely a submodule */
+		strbuf_addstr(sb, sp_gitdir);
+
+	strbuf_addstr(sb, "/config.superproject");
+}
+
 /*
  * Parse environment variable 'k' as a boolean (in various
  * possible spellings); if missing, use the default value 'def'.
@@ -1911,6 +1925,17 @@ static int do_git_config_sequence(const struct config_options *opts,
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file(fn, user_config, data);
 
+	current_parsing_scope = CONFIG_SCOPE_SUPERPROJECT;
+	if (opts->git_dir && !opts->ignore_superproject) {
+
+		struct strbuf superproject_gitdir = STRBUF_INIT;
+		git_config_superproject(&superproject_gitdir, opts->git_dir);
+		if (!access_or_die(superproject_gitdir.buf, R_OK, 0))
+			ret += git_config_from_file(fn, superproject_gitdir.buf, data);
+
+		strbuf_release(&superproject_gitdir);
+	}
+
 	current_parsing_scope = CONFIG_SCOPE_LOCAL;
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
@@ -2030,6 +2055,7 @@ void read_very_early_config(config_fn_t cb, void *data)
 
 	opts.respect_includes = 1;
 	opts.ignore_repo = 1;
+	opts.ignore_superproject = 1;
 	opts.ignore_worktree = 1;
 	opts.ignore_cmdline = 1;
 	opts.system_gently = 1;
@@ -3518,6 +3544,8 @@ const char *config_scope_name(enum config_scope scope)
 		return "command";
 	case CONFIG_SCOPE_GITMODULES:
 		return "gitmodules";
+	case CONFIG_SCOPE_SUPERPROJECT:
+		return "superproject";
 	default:
 		return "unknown";
 	}
diff --git a/config.h b/config.h
index 5faa72f3f5..69d7e4cb72 100644
--- a/config.h
+++ b/config.h
@@ -43,6 +43,7 @@ enum config_scope {
 	CONFIG_SCOPE_WORKTREE,
 	CONFIG_SCOPE_COMMAND,
 	CONFIG_SCOPE_GITMODULES,
+	CONFIG_SCOPE_SUPERPROJECT,
 };
 const char *config_scope_name(enum config_scope scope);
 
@@ -84,6 +85,7 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 struct config_options {
 	unsigned int respect_includes : 1;
 	unsigned int ignore_repo : 1;
+	unsigned int ignore_superproject : 1;
 	unsigned int ignore_worktree : 1;
 	unsigned int ignore_cmdline : 1;
 	unsigned int system_gently : 1;
@@ -318,6 +320,7 @@ int git_config_rename_section(const char *, const char *);
 int git_config_rename_section_in_file(const char *, const char *, const char *);
 int git_config_copy_section(const char *, const char *);
 int git_config_copy_section_in_file(const char *, const char *, const char *);
+void git_config_superproject(struct strbuf *, const char *);
 int git_env_bool(const char *, int);
 unsigned long git_env_ulong(const char *, unsigned long);
 int git_config_system(void);
diff --git a/t/t1311-superproject-config.sh b/t/t1311-superproject-config.sh
new file mode 100755
index 0000000000..74b6ca2cac
--- /dev/null
+++ b/t/t1311-superproject-config.sh
@@ -0,0 +1,116 @@
+#!/bin/sh
+
+test_description='Test git config --superproject in different settings'
+
+. ./test-lib.sh
+
+# follow t7400's example and use the trash dir repo as a submodule to add
+submodurl=$(pwd -P)
+
+# since only the configs are modified, set up the repo structure only once
+test_expect_success 'setup repo structure' '
+	test_commit "base" &&
+	git submodule add "${submodurl}" sub/ &&
+	git commit -m "add a submodule"
+'
+
+test_expect_success 'superproject config applies to super and submodule' '
+	cat >.git/config.superproject <<-EOF &&
+	[foo]
+		bar = baz
+	EOF
+	test_when_finished rm .git/config.superproject &&
+
+	git config --get foo.bar &&
+	git -C sub config --get foo.bar
+
+'
+
+test_expect_success 'can add from super or sub' '
+	git config --superproject apple.species honeycrisp &&
+	git -C sub config --superproject banana.species cavendish &&
+	test_when_finished rm .git/config.superproject &&
+
+	cat >expect <<-EOF &&
+	apple.species=honeycrisp
+	banana.species=cavendish
+	EOF
+
+	git config --list >actual &&
+	grep -Ff expect actual &&
+
+	git -C sub config --list >actual &&
+	grep -Ff expect actual
+'
+
+test_expect_success 'can --unset from super or sub' '
+	git config --superproject apple.species honeycrisp &&
+	git -C sub config --superproject banana.species cavendish &&
+	test_when_finished rm .git/config.superproject &&
+
+	git config --unset --superproject banana.species &&
+	git -C sub config --unset --superproject apple.species
+'
+
+test_expect_success 'can --edit superproject config' '
+	test_config core.editor "echo [foo]bar=baz >" &&
+	git config --edit --superproject &&
+	test_when_finished rm .git/config.superproject &&
+
+	git config --get foo.bar
+'
+
+test_expect_success 'can --show-origin the superproject config' '
+	git config --superproject --add foo.bar baz &&
+	test_when_finished rm .git/config.superproject &&
+
+	git config --list --show-origin >actual &&
+	grep -F "config.superproject" actual
+'
+
+test_expect_success 'can --show-scope the superproject config' '
+	git config --superproject --add foo.bar baz &&
+	test_when_finished rm .git/config.superproject &&
+
+	git config --list --show-scope >actual &&
+	grep "superproject" actual
+'
+
+test_expect_success 'pre-existing config applies to new submodule' '
+	git config --superproject --add foo.bar baz &&
+	test_when_finished rm .git/config.superproject &&
+
+	git submodule add "${submodurl}" sub2/ &&
+	test_when_finished rm -fr sub2 &&
+	git commit -m "add a second submodule" &&
+	test_when_finished git reset HEAD^ &&
+
+	git -C sub2 config --get foo.bar
+'
+
+# NEEDSWORK: submodule.c:get_superproject_working_tree doesn't support worktree
+test_expect_failure 'worktrees can still access config.superproject' '
+	git config --superproject --add foo.bar baz &&
+	test_when_finished rm .git/config.superproject &&
+
+	git worktree add wt &&
+	test_when_finished git worktree remove wt &&
+	(
+		cd wt &&
+		git config --get foo.bar
+	)
+'
+
+# This test deletes the submodule! Keep it at the end of the test suite.
+test_expect_success 'config.superproject works even with no submodules' '
+	# get rid of the submodule
+	git reset HEAD^ &&
+	rm -fr sub &&
+
+	git config --superproject --add foo.bar baz &&
+	test_when_finished rm .git/config.superproject &&
+
+	git config --get foo.bar
+'
+
+test_done
-- 
2.32.0.288.g62a8d224e6-goog

