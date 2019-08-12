Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83DD1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 19:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfHLTq3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 15:46:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42004 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 15:46:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so1502321pfk.9
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UhLpEGIRCjRo5S/USg7dDLQ6jvMXCoTovmK+jdQGlKc=;
        b=iseZk09a/+HiI1dUFfyg9zlZ+/Grepdl6Y/oRVMB8iktGeA3jrtFju4O5gFe6/XMwh
         c4xllIegDSOalOkDy118UCYVUDwWoeU3KpWMQBbmtoLA4OoQ7JgEHd6v+/TNrme3DUZ1
         C5FsRo9h3y2VX5dD0XStNncT1JChVyQcKyEBR/0bHqytqvgZ1LL4DXiFZ3ggJQjQjveZ
         0oG8c+/INaZifu4imMB1MgpTuQZqjRZbbfgC2REJyoq5OQfyHzCPl8MiYTAtZQX4SalB
         0c9HTSFcUnobgNmcOn3g9yoHBipUbN2jJfBJpLOD97TrpEIBZRebjV4w2Oyu13jRHp55
         G+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhLpEGIRCjRo5S/USg7dDLQ6jvMXCoTovmK+jdQGlKc=;
        b=kH0RT1CQ1IxEEtY/hsN2GX5lY2c2ma3oHmlmhd6hH/b0GAPPwsCtf/1zkVp6L0fX3D
         u60tep09IldNBHWlKCE1FhMs3DC1rLvkb3Po8t+1S/1IUyQFhiVW83Bhck7u4xrZHhal
         56R4GDdWJ8fLs6EILQOsyjyGd57G/iRKYl3un1UtDEH92lDGTCEv7JKkRA2CFefXPFXo
         3LFBp4VU/5F56ZCTEO5IwxiOwp0Fech/6PYwWt+ZMr2aJN0E+TZ8/+WmVjyH0xFUjH0T
         cF4BnwUTwuz4+t4Bojd9ytp4EHZPEDCtDx3xk5ZR11chqoOIA3FkwWHVoImgOgPGg5B7
         nKpw==
X-Gm-Message-State: APjAAAX0ZFYSxiBBXj4H9DpXmWotDy995zVK8QcsMbS71jSbCv5OKD8i
        D2cthaa8PZcnuqZKaEngvDFtfhwZs9Q=
X-Google-Smtp-Source: APXvYqyb4RXGj8kfvEoij2CfOtoeia5BOJLf0NVHK3gR4nbS5vPixNGvJO3ilP0gm53zMXWcon77XA==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr31835188pgm.413.1565639187516;
        Mon, 12 Aug 2019 12:46:27 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.228])
        by smtp.gmail.com with ESMTPSA id j187sm13275947pfg.178.2019.08.12.12.46.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:46:26 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 5/6] rebase -i: support --ignore-date
Date:   Tue, 13 Aug 2019 01:12:59 +0530
Message-Id: <20190812194301.5655-6-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rebase am already has this flag to "lie" about the author date
by changing it to the committer (current) date. Let's add the same
for interactive machinery.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt            |  6 +--
 builtin/rebase.c                        | 21 +++++++---
 sequencer.c                             | 55 ++++++++++++++++++++++++-
 sequencer.h                             |  1 +
 t/t3433-rebase-options-compatibility.sh | 16 +++++++
 5 files changed, 88 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 697ce8e6ff..24ad2dda0b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -388,8 +388,8 @@ See also INCOMPATIBLE OPTIONS below.
 	as the committer date. This implies --force-rebase.
 
 --ignore-date::
-	This flag is passed to 'git am' to change the author date
-	of the rebased commits (see linkgit:git-am[1]).
+	Instead of using the given author date, re-set it to the value
+	same as committer (current) date. This implies --force-rebase.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -526,7 +526,6 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
- * --ignore-date
  * --whitespace
  * -C
 
@@ -552,6 +551,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --rebase-merges
  * --preserve-merges and --ignore-whitespace
  * --preserve-merges and --committer-date-is-author-date
+ * --preserve-merges and --ignore-date
  * --rebase-merges and --ignore-whitespace
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b1039f8db0..ed58ca8e5a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -83,6 +83,7 @@ struct rebase_options {
 	char *gpg_sign_opt;
 	int autostash;
 	int committer_date_is_author_date;
+	int ignore_date;
 	char *cmd;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
@@ -117,6 +118,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.committer_date_is_author_date =
 					opts->committer_date_is_author_date;
+	replay.ignore_date = opts->ignore_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
 
@@ -536,7 +538,10 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
-	if (opts.committer_date_is_author_date)
+	if (opts.ignore_date)
+		opts.committer_date_is_author_date = 0;
+	if (opts.committer_date_is_author_date ||
+	    opts.ignore_date)
 		opts.flags |= REBASE_FORCE;
 
 	return !!run_rebase_interactive(&opts, command);
@@ -989,6 +994,8 @@ static int run_am(struct rebase_options *opts)
 		argv_array_push(&am.args, "--ignore-whitespace");
 	if (opts->committer_date_is_author_date)
 		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
+	if (opts->ignore_date)
+		argv_array_push(&opts->git_am_opts, "--ignore-date");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1435,8 +1442,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
-		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
-				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
+		OPT_BOOL(0, "ignore-date", &options.ignore_date,
+			 "ignore author date and use current date"),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
 		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
@@ -1705,13 +1712,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    state_dir_base, cmd_live_rebase, buf.buf);
 	}
 
-	if (options.committer_date_is_author_date)
+	if (options.ignore_date)
+		options.committer_date_is_author_date = 0;
+	if (options.committer_date_is_author_date ||
+	    options.ignore_date)
 		options.flags |= REBASE_FORCE;
 
 	for (i = 0; i < options.git_am_opts.argc; i++) {
 		const char *option = options.git_am_opts.argv[i], *p;
-		if (!strcmp(option, "--ignore-date") ||
-		    !strcmp(option, "--whitespace=fix") ||
+		if (!strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
 			options.flags |= REBASE_FORCE;
 		else if (skip_prefix(option, "-C", &p)) {
diff --git a/sequencer.c b/sequencer.c
index e186136ccc..aecd9b4ad8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -148,6 +148,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
+static GIT_PATH_FUNC(rebase_path_ignore_date, "rebase-merge/ignore_date")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
@@ -919,6 +920,31 @@ static const char *read_author_ident(struct strbuf *buf)
 	return buf->buf;
 }
 
+static void ignore_author_date(const char **author)
+{
+	int len = strlen(*author);
+	struct ident_split ident;
+	struct strbuf new_author = STRBUF_INIT;
+
+	split_ident_line(&ident, *author, len);
+	len = ident.mail_end - ident.name_begin + 1;
+
+	strbuf_addf(&new_author, "%.*s", len, *author);
+	datestamp(&new_author);
+	*author = strbuf_detach(&new_author, NULL);
+}
+
+static void push_dates(struct child_process *child)
+{
+	time_t now = time(NULL);
+	struct strbuf date = STRBUF_INIT;
+
+	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
+	argv_array_pushf(&child->args, "--date=%s", date.buf);
+	argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
+	strbuf_release(&date);
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -1020,10 +1046,18 @@ static int run_git_commit(struct repository *r,
 
 		if (res <= 0)
 			res = error_errno(_("could not read '%s'"), defmsg);
-		else
+		else {
+			if (opts->ignore_date) {
+				if (!author)
+					BUG("ignore-date can only be used with "
+					    "rebase, which must set the author "
+					    "before committing the tree");
+				ignore_author_date(&author);
+			}
 			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
 					  NULL, &root_commit, author,
 					  opts->gpg_sign);
+		}
 
 		strbuf_release(&msg);
 		strbuf_release(&script);
@@ -1053,6 +1087,8 @@ static int run_git_commit(struct repository *r,
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
+	if (opts->ignore_date)
+		push_dates(&cmd);
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	else if (!(flags & EDIT_MSG))
@@ -1515,6 +1551,11 @@ static int try_to_commit(struct repository *r,
 
 	reset_ident_date();
 
+	if (opts->ignore_date) {
+		ignore_author_date(&author);
+		free(author_to_free);
+		author_to_free = (char *)author;
+	}
 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
 				 oid, author, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
@@ -2592,6 +2633,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->committer_date_is_author_date = 1;
 		}
 
+		if (file_exists(rebase_path_ignore_date())) {
+			opts->allow_ff = 0;
+			opts->ignore_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2676,6 +2722,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_signoff(), "--signoff\n");
 	if (opts->committer_date_is_author_date)
 		write_file(rebase_path_cdate_is_adate(), "%s", "");
+	if (opts->ignore_date)
+		write_file(rebase_path_ignore_date(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3601,6 +3649,8 @@ static int do_merge(struct repository *r,
 		argv_array_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
 			argv_array_push(&cmd.args, opts->gpg_sign);
+		if (opts->ignore_date)
+			push_dates(&cmd);
 
 		/* Add the tips to be merged */
 		for (j = to_merge; j; j = j->next)
@@ -3874,7 +3924,8 @@ static int pick_commits(struct repository *r,
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit ||
-				opts->committer_date_is_author_date));
+				opts->committer_date_is_author_date ||
+				opts->ignore_date));
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index e3881e9275..bf5a79afdb 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -44,6 +44,7 @@ struct replay_opts {
 	int quiet;
 	int reschedule_failed_exec;
 	int committer_date_is_author_date;
+	int ignore_date;
 
 	int mainline;
 
diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
index b2419a2b75..c060fcd10b 100755
--- a/t/t3433-rebase-options-compatibility.sh
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -81,4 +81,20 @@ test_expect_success '--committer-date-is-author-date works with interactive back
 	test_cmp authortime committertime
 '
 
+# Checking for +0000 in author time is enough since default
+# timezone is UTC, but the timezone used while committing
+# sets to +0530.
+test_expect_success '--ignore-date works with am backend' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --ignore-date HEAD^ &&
+	git show HEAD --pretty="format:%ai" >authortime &&
+	grep "+0000" authortime
+'
+
+test_expect_success '--ignore-date works with interactive backend' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --ignore-date -i HEAD^ &&
+	git show HEAD --pretty="format:%ai" >authortime &&
+	grep "+0000" authortime
+'
 test_done
-- 
2.21.0

