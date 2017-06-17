Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85FAB20282
	for <e@80x24.org>; Sat, 17 Jun 2017 22:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbdFQWcT (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 18:32:19 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35336 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbdFQWcP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 18:32:15 -0400
Received: by mail-io0-f195.google.com with SMTP id f79so7970108ioi.2
        for <git@vger.kernel.org>; Sat, 17 Jun 2017 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eZsnGqijRyD1wyhDTiLW6WjeypoEcm1BCws3Z+0W3Sk=;
        b=Xz00MOWVjgdS/wWf/5do1z2MjZjxzxmKrHj96K4YKcQRf9vQO3CJnAqmaffqcpqMM1
         /cC8l+ZbIDgwOZi6Nja2GXbJZxBRIuCqYAqHbx82VBJBHRTSoqzMfWpczsZkIdA6fGqs
         7dVk2kl1A6WVUmWlC8HBBfaSbvPDxqgK7Wrpl+yFbja2OcTFWhIFCIdyt6oK1diCzV6z
         DRz+AV+lMoslYsZ+hoJcOAv+SKmfeCmwyLQNvcmBSTVZFN4CIqGB3K1RRP8i8j2MiNiG
         99q/XfBirJ+BfmCl4wWcSEFDrztR6M49Fkn7Swmolp8j5a0TN36dTithPcnGZF5+mPkI
         UJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eZsnGqijRyD1wyhDTiLW6WjeypoEcm1BCws3Z+0W3Sk=;
        b=cSXxRsvAQAqvwJBUsUGY0pKpWUM7ootDd/HwW5Dj4pa/18igb/Q4xK1pAtu+JZoa8G
         TCB8hC/xCvoW+U3dM9crfMIUUCJ/HDZHFSR2M7AhVlVIzW43MrHH598GReWnB5xPlpCy
         9aYTvM+fg9dxqDY1gZreG5X+nokbytOxZ1Kipg60duLd9MJg88ThPK5TIp03xoCXEMO9
         sq9j+V8kdlD5adzuQx319PH4pu3QvNJvRgugu3QyOvPuDcbSDjq+3KCcg3gyRMKKOw0v
         BhD7o5iGca7eKibVg7yHT8AfdiMLIuMF0AEbQCRX2mCBG2LOpj7gD4nbKRTu8ROeqJLe
         4bQQ==
X-Gm-Message-State: AKS2vOw7llDrfEolhsCwWqYzCTAyv8tpwMBYIWrt2PANxb9az6DehQ0N
        FQrD1kYMLrc8YR/2RH4=
X-Received: by 10.107.48.193 with SMTP id w184mr15306531iow.165.1497738719415;
        Sat, 17 Jun 2017 15:31:59 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id 33sm929589iog.26.2017.06.17.15.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jun 2017 15:31:58 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, houstonfortney@gmail.com, kostix+git@007spb.ru,
        peff@peff.net, sxlijin@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 0/3] add stash count information to git-status command
Date:   Sat, 17 Jun 2017 18:30:49 -0400
Message-Id: <20170617223052.6580-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170616043050.29192-1-liambeguin@gmail.com>
References: <20170616043050.29192-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed here [*1*], this allows `git status` to show the number of
entries currently stashed away.

I also tried to update the related parts of the documentation to use
'stash entry' instead of 'stash' as we agreed that it was a bit better.

*1* https://public-inbox.org/git/CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com/

Liam Beguin (3):
  stash: update documentation to use 'stash entry'
  status: add optional stash count information
  glossary: define 'stash entry'

 Documentation/config.txt           | 11 +++++--
 Documentation/git-pull.txt         |  2 +-
 Documentation/git-rebase.txt       |  2 +-
 Documentation/git-stash.txt        | 60 ++++++++++++++++++++------------------
 Documentation/git-status.txt       |  3 ++
 Documentation/gitcli.txt           |  2 +-
 Documentation/glossary-content.txt |  4 +++
 builtin/commit.c                   |  6 ++++
 git-stash.sh                       |  6 ++--
 t/t7508-status.sh                  | 32 ++++++++++++++++++++
 wt-status.c                        | 24 +++++++++++++++
 wt-status.h                        |  1 +
 12 files changed, 115 insertions(+), 38 deletions(-)


Base-commit: 97e2ff464302565877a00b8a9aa6a2d85bd1445e

Changes since v1:
 - update commit messages to be more consistent
 - improve Documentation based on feedback
 - move config lookup to `git_status_config()`
 - add '--show-stash' command line option to `git-status`
 - add tests for now option

Interdiff:
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 59979ad31dfe..00f95fee1faf 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -58,7 +58,7 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 +
 For quickly making a snapshot, you can omit "push".  In this mode,
 non-option arguments are not allowed to prevent a misspelled
-subcommand from making an unwanted entry.  The two exceptions to this
+subcommand from making an unwanted stash entry.  The two exceptions to this
 are `stash -p` which acts as alias for `stash push -p` and pathspecs,
 which are allowed after a double hyphen `--` for disambiguation.
 +
@@ -106,10 +106,11 @@ command to control what is shown and how. See linkgit:git-log[1].
 show [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
-	stashed entry and its original parent. When no `<stash>` is given, it
-	shows the latest one. By default, the command shows the diffstat, but
-	it will accept any format known to 'git diff' (e.g., `git stash show
-	-p stash@{1}` to view the second most recent entry in patch form).
+	stashed contents and the commit back when the stash entry was first
+	created. When no `<stash>` is given, it shows the latest one.
+	By default, the command shows the diffstat, but it will accept any
+	format known to 'git diff' (e.g., `git stash show -p stash@{1}`
+	to view the second most recent entry in patch form).
 	You can use stash.showStat and/or stash.showPatch config variables
 	to change the default behavior.
 
@@ -150,20 +151,20 @@ branch <branchname> [<stash>]::
 This is useful if the branch on which you ran `git stash save` has
 changed enough that `git stash apply` fails due to conflicts. Since
 the stash entry is applied on top of the commit that was HEAD at the
-time `git stash` was run, it restores the originally stashed entry
+time `git stash` was run, it restores the originally stashed state
 with no conflicts.
 
 clear::
-	Remove all the stashed entries. Note that those entries will then
+	Remove all the stash entries. Note that those entries will then
 	be subject to pruning, and may be impossible to recover (see
 	'Examples' below for a possible strategy).
 
 drop [-q|--quiet] [<stash>]::
 
-	Remove a single stashed entry from the stash list. When no `<stash>`
-	is given, it removes the latest one. i.e. `stash@{0}`, otherwise
-	`<stash>` must be a valid stash log reference of the form
-	`stash@{<revision>}`.
+	Remove a single stash entry from the list of stash entries.
+	When no `<stash>` is given, it removes the latest one.
+	i.e. `stash@{0}`, otherwise `<stash>` must be a valid stash
+	log reference of the form `stash@{<revision>}`.
 
 create::
 
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index d70abc6afe3a..d47f198f15cd 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -32,6 +32,9 @@ OPTIONS
 --branch::
 	Show the branch and tracking info even in short-format.
 
+--show-stash::
+	Show the number of entries currently stashed away.
+
 --porcelain[=<version>]::
 	Give the output in an easy-to-parse format for scripts.
 	This is similar to the short output, but will remain stable
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 026f66e7240a..b71b943b12ed 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -571,8 +571,8 @@ The most notable example is `HEAD`.
 	its history can be later deepened with linkgit:git-fetch[1].
 
 [[def_stash]]stash entry::
-	An <<def_object,object>> used to temporarily store the content of a
-	<<def_dirty,dirty>> working directory for futur reuse.
+	An <<def_object,object>> used to temporarily store the contents of a
+	<<def_dirty,dirty>> working directory and the index for future reuse.
 
 [[def_submodule]]submodule::
 	A <<def_repository,repository>> that holds the history of a
diff --git a/builtin/commit.c b/builtin/commit.c
index ef52457effc1..c089fb87e363 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1295,6 +1295,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		status_deferred_config.show_branch = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "status.showstash")) {
+		s->show_stash = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		s->use_color = git_config_colorbool(k, v);
 		return 0;
@@ -1343,6 +1347,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			    N_("show status concisely"), STATUS_FORMAT_SHORT),
 		OPT_BOOL('b', "branch", &s.show_branch,
 			 N_("show branch information")),
+		OPT_BOOL(0, "show-stash", &s.show_stash,
+			 N_("show stash information")),
 		{ OPTION_CALLBACK, 0, "porcelain", &status_format,
 		  N_("version"), N_("machine-readable output"),
 		  PARSE_OPT_OPTARG, opt_parse_porcelain },
diff --git a/git-stash.sh b/git-stash.sh
index 0dfa4785f361..68be4146bd2a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -481,7 +481,7 @@ parse_flags_and_rev()
 
 	case $# in
 		0)
-			have_stash || die "$(gettext "No stash entry found.")"
+			have_stash || die "$(gettext "No stash entries found.")"
 			set -- ${ref_stash}@{0}
 		;;
 		1)
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 79427840a4fa..7121a550c7ce 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1608,4 +1608,36 @@ test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success 'show stash info with "--show-stash"' '
+	git reset --hard &&
+	git stash clear &&
+	echo 1 >file &&
+	git add file &&
+	git stash &&
+	git status >expected_default &&
+	git status --show-stash >expected_with_stash &&
+	test_i18ngrep "^Your stash currently has 1 entry$" expected_with_stash
+'
+
+test_expect_success 'no stash info with "--show-stash --no-show-stash"' '
+	git status --show-stash --no-show-stash >expected_without_stash &&
+	test_cmp expected_default expected_without_stash
+'
+
+test_expect_success '"status.showStash=false" weaker than "--show-stash"' '
+	git -c status.showStash=false status --show-stash >actual &&
+	test_cmp expected_with_stash actual
+'
+
+test_expect_success '"status.showStash=true" weaker than "--no-show-stash"' '
+	git -c status.showStash=true status --no-show-stash >actual &&
+	test_cmp expected_without_stash actual
+'
+
+test_expect_success 'no additionnal info if no stash entries' '
+	git stash clear &&
+	git -c status.showStash=true status >actual &&
+	test_cmp expected_without_stash actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 7114eec123c8..7992a73902ae 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -137,6 +137,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->untracked.strdup_strings = 1;
 	s->ignored.strdup_strings = 1;
 	s->show_branch = -1;  /* unspecified */
+	s->show_stash = 0;
 	s->display_comment_prefix = 0;
 }
 
@@ -1558,7 +1559,6 @@ static void wt_longstatus_print(struct wt_status *s)
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
 	struct wt_status_state state;
-	int show_stash = 0;
 
 	memset(&state, 0, sizeof(state));
 	wt_status_get_state(&state,
@@ -1664,7 +1664,7 @@ static void wt_longstatus_print(struct wt_status *s)
 		} else
 			printf(_("nothing to commit, working tree clean\n"));
 	}
-	if (!git_config_get_bool("status.showStash", &show_stash) && show_stash)
+	if(s->show_stash)
 		wt_longstatus_print_stash_summary(s);
 }
 
diff --git a/wt-status.h b/wt-status.h
index 8a3864783b03..d8ae2e590daf 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -77,6 +77,7 @@ struct wt_status {
 	unsigned colopts;
 	int null_termination;
 	int show_branch;
+	int show_stash;
 	int hints;
 
 	enum wt_status_format status_format;
-- 
2.9.4

