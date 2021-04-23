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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860F3C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 00:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579A761155
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 00:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbhDWAQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 20:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbhDWAQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 20:16:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1876EC061574
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 17:15:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e8-20020a2587480000b02904e5857564e2so22176451ybn.16
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r2WdXyvX2k5bHYTrkSdxcltmP0lv9TVHv8Nf1zWnAD0=;
        b=s2O/80XB0GUllfW1ATLMt9N9n7Y3wCyKASNsNsNCWiDjrVMHzYA1uf1W023dvNz9it
         0xdiii5++k+0XM1IPou0I4fp6VuH/WWgGOJhjNdcfrkURL9cFamSKcRXhIRq0/scBMet
         XICedQMg0/F9A5mVZYkuameNQyOHGDr2Vm0m3j3KA7m4p5vSsYs3/PqcrZoZRfqvMz86
         k1vbQjscubJxJjZEFX/9PrSgf6Mn1Y9ZNeO9Eg9WMljnjKu7bMjbflQ0Vf4+s8+hZXlP
         HI5IbL6SvhSf9sXMQ+8ZUZYwNgDRj6hKd36pHavJDSL2XUDVMypLIDi+TPz83lzER09a
         RLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r2WdXyvX2k5bHYTrkSdxcltmP0lv9TVHv8Nf1zWnAD0=;
        b=t+4Jq4ESIXxl7zmocHpr2H00vVE+vd+9qJu4QetLqll82feBBp3xoyiT2HxMltjISF
         mADADqoCzarIHgQJK8ZqHk12Y1qA2wOOdre+cbSOHilGlzWsCRbZUVItRGHWyUTC31sJ
         kILWInRmxpUu7KQ+Nb0gfek48/Z5rOmvcklc5iJ/ks7WRN8Gqzh2QYM+eOjFGEvzI0mO
         Qa4vcO0LLKMCCJ637XGxlLkXUJEc8oxkcbcntVuoeb445r+lfMtZT2wZYMVFpbhQ50xt
         8M8tqhOP+tFF4l57gzIzj1wVt4RwTpQxfj06VCc1oJLplHPV3kRfi0O0iTULN+TyR4tC
         Oy6Q==
X-Gm-Message-State: AOAM533A5EoyrZXbrTO59mwfofHnRFHAZheKduIBNDZ3tEzkjIkTs+lg
        1jmI4+gNWPjmtOJTkMuuSS3yROyJxNhAUNeCDFTFTVm/9AVYo7OwdAjDYybp+Wt8TC27d8Thnmx
        QfdgHiBwXe3uo4Jg+LhlC/nLO900xRzRrI+JVUWJ5A1opVDBQ31uQGe5nOk9P9EwFS9GQyXMgQA
        ==
X-Google-Smtp-Source: ABdhPJyCdWPDS+7tBveAbiLLcIEGYjcmHiCUil5hNQ1QTbBVGzOV2ZuXso7HTfwkcDUgsn1OoGW8OdLYac6WGh7m5EA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:fe4e:1417:67a4:42aa])
 (user=emilyshaffer job=sendgmr) by 2002:a25:d0d1:: with SMTP id
 h200mr1759572ybg.110.1619136950210; Thu, 22 Apr 2021 17:15:50 -0700 (PDT)
Date:   Thu, 22 Apr 2021 17:15:39 -0700
In-Reply-To: <20210423001539.4059524-1-emilyshaffer@google.com>
Message-Id: <20210423001539.4059524-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210423001539.4059524-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [RFC PATCH v2 4/4] config: add 'config.superproject' file
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
 config.c                       |  24 +++++++
 config.h                       |   3 +
 submodule.c                    |  29 +++++++++
 submodule.h                    |   8 +++
 t/t1311-superproject-config.sh | 116 +++++++++++++++++++++++++++++++++
 7 files changed, 207 insertions(+), 3 deletions(-)
 create mode 100755 t/t1311-superproject-config.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 4b4cc5c5e8..a33136fb08 100644
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
index f71fa39b38..f38a6823c7 100644
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
 		given_config_source.file = git_etc_gitconfig();
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
index c8426ef3f3..3f62cd815b 100644
--- a/config.c
+++ b/config.c
@@ -21,6 +21,7 @@
 #include "dir.h"
 #include "color.h"
 #include "refs.h"
+#include "submodule.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1838,6 +1839,15 @@ const char *git_etc_gitconfig(void)
 	return system_wide;
 }
 
+void git_config_superproject(struct strbuf *sb, const char *gitdir)
+{
+	if (!get_superproject_gitdir(sb))
+		/* not a submodule */
+		strbuf_addstr(sb, gitdir);
+
+	strbuf_addstr(sb, "/config.superproject");
+}
+
 /*
  * Parse environment variable 'k' as a boolean (in various
  * possible spellings); if missing, use the default value 'def'.
@@ -1895,6 +1905,17 @@ static int do_git_config_sequence(const struct config_options *opts,
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
@@ -2013,6 +2034,7 @@ void read_very_early_config(config_fn_t cb, void *data)
 
 	opts.respect_includes = 1;
 	opts.ignore_repo = 1;
+	opts.ignore_superproject = 1;
 	opts.ignore_worktree = 1;
 	opts.ignore_cmdline = 1;
 	opts.system_gently = 1;
@@ -3501,6 +3523,8 @@ const char *config_scope_name(enum config_scope scope)
 		return "command";
 	case CONFIG_SCOPE_GITMODULES:
 		return "gitmodules";
+	case CONFIG_SCOPE_SUPERPROJECT:
+		return "superproject";
 	default:
 		return "unknown";
 	}
diff --git a/config.h b/config.h
index 535f5517b8..b42e1d13eb 100644
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
@@ -319,6 +321,7 @@ int git_config_rename_section_in_file(const char *, const char *, const char *);
 int git_config_copy_section(const char *, const char *);
 int git_config_copy_section_in_file(const char *, const char *, const char *);
 const char *git_etc_gitconfig(void);
+void git_config_superproject(struct strbuf *, const char *);
 int git_env_bool(const char *, int);
 unsigned long git_env_ulong(const char *, unsigned long);
 int git_config_system(void);
diff --git a/submodule.c b/submodule.c
index 9767ba9893..92b00f8697 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2178,6 +2178,35 @@ void absorb_git_dir_into_superproject(const char *path,
 	}
 }
 
+int get_superproject_gitdir(struct strbuf *buf)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int rc = 0;
+
+	/* NEEDSWORK: this call also calls out to a subprocess! */
+	rc = get_superproject_working_tree(&sb);
+	strbuf_release(&sb);
+
+	if (!rc)
+		return rc;
+
+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+
+	strvec_pushl(&cp.args, "-C", "..", "rev-parse", "--absolute-git-dir", NULL);
+	cp.git_cmd = 1;
+
+	rc = capture_command(&cp, buf, 0);
+	strbuf_trim_trailing_newline(buf);
+
+	/* leave buf empty if we didn't have a superproject gitdir */
+	if (rc)
+		strbuf_reset(buf);
+
+	/* rc reflects the exit code of the rev-parse; invert into a bool */
+	return !rc;
+}
+
 int get_superproject_working_tree(struct strbuf *buf)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
diff --git a/submodule.h b/submodule.h
index 4ac6e31cf1..cc89d5e3fa 100644
--- a/submodule.h
+++ b/submodule.h
@@ -149,6 +149,14 @@ void prepare_submodule_repo_env(struct strvec *out);
 void absorb_git_dir_into_superproject(const char *path,
 				      unsigned flags);
 
+/*
+ * Return the gitdir of the superproject, which this project is a submodule of.
+ * If this repository is a submodule, return 1 and fill buf with the absolute
+ * path to the superproject's gitdir. If this repository is not a submodule of
+ * another repository, return 0 and leave buf untouched.
+ */
+int get_superproject_gitdir(struct strbuf *buf);
+
 /*
  * Return the absolute path of the working tree of the superproject, which this
  * project is a submodule of. If this repository is not a submodule of
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
2.31.1.498.g6c1eba8ee3d-goog

