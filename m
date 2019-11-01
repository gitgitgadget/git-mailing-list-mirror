Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45FA41F454
	for <e@80x24.org>; Fri,  1 Nov 2019 14:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfKAOBd (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 10:01:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34664 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfKAOBc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 10:01:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so4425961pll.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 07:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5XWT2Zm/zOb0FSTX+DhE+8L3DPspTopS02Llvi5Fu7o=;
        b=jmfJ7GUrjmM1TeAL55E11t6yxMOUQQsdQ31KGaPDKFZUZiLwCZoIOmX609XRtZ2s8y
         25pnkBWgULfDiGOgJsPOzrSx22I5i/jvWGGIVGIT57kUJqHMGPjWVylrczPcrwcSmiNc
         p5eeWIML7DI3rpdQ0fJbzu8fHQAk1cXOXlNsKJtqf/2Th2k/rjR+QGWrXnJz6lWp/DdR
         bTGixW81gDl/ZaayrWVI6AwU4IUcYLeGM8D4l0r72qYLqdjx3cuuQB+cZoCT4OgCC/LL
         JQAKQzt3JQ9kjFjqb5fmtgDrqQIkXiohm6jzis+g2dxQsILdp3maL/3KnnkmDqlmjCPA
         qPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5XWT2Zm/zOb0FSTX+DhE+8L3DPspTopS02Llvi5Fu7o=;
        b=YQ2SBCv/AEFnRo4ucn2MeavB9/Fm9k4NfFF/cfRpMeo+vaCT2mRSg0/82miu2toYTb
         bceGM6iJgmfNjHd32nmcUVXl8mV/c9ySqXj1klAN6E+R0V6ds4IWdufV+am6FxMOF/vV
         X1SdXsAPpt+FhUIMPnqklr8+iB6SX6HW3IQb45zm6uD2xrCptHLDA3Ko/4yBkAAPuvNn
         hRttpirm3WyKl7k4J56Ab6GkSkW/ctT4K5qKx+uB457doU7P30zMcKqdIiFEkNKAXfO8
         pDJlhyn98eMPxaXJY5xXcRtoPoUVwHgXNsG4TbB+7XfKTg5jP9rD2aty/K1JextRj6Z9
         ZMwg==
X-Gm-Message-State: APjAAAU61VhsAUOcmFOSnH4LdG1jFhrYPqf4sDq5gbG+0Eaa4ySz8lYc
        0EtfRVGECIUwVLxoptqnTTJg6VZIEEY=
X-Google-Smtp-Source: APXvYqwnz89VwcKz64zbwnqFSk3qUj0r/UvIeH0x/EUl7WQ6TZWEaTSMbjyVv283OAMydttvCFwCXg==
X-Received: by 2002:a17:902:6b06:: with SMTP id o6mr3854721plk.110.1572616891605;
        Fri, 01 Nov 2019 07:01:31 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.214])
        by smtp.gmail.com with ESMTPSA id z4sm7806816pjt.20.2019.11.01.07.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:01:30 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v5 5/6] rebase -i: support --ignore-date
Date:   Fri,  1 Nov 2019 19:30:02 +0530
Message-Id: <20191101140003.13960-6-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
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
 builtin/rebase.c                        | 14 +++---
 sequencer.c                             | 60 +++++++++++++++++++++++--
 sequencer.h                             |  1 +
 t/t3433-rebase-options-compatibility.sh | 29 ++++++++++++
 5 files changed, 99 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e948a24433..3580447f2f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -413,8 +413,8 @@ See also INCOMPATIBLE OPTIONS below.
 	as the committer date. This implies --force-rebase.
 
 --ignore-date::
-	This flag is passed to 'git am' to change the author date
-	of each rebased commit (see linkgit:git-am[1]).
+	Instead of using the given author date, reset it to the
+	current time. This implies --force-rebase.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -551,7 +551,6 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
- * --ignore-date
  * --whitespace
  * -C
 
@@ -577,6 +576,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --rebase-merges
  * --preserve-merges and --ignore-whitespace
  * --preserve-merges and --committer-date-is-author-date
+ * --preserve-merges and --ignore-date
  * --keep-base and --onto
  * --keep-base and --root
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 9227801ef6..7edae668f8 100644
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
 
@@ -982,6 +984,8 @@ static int run_am(struct rebase_options *opts)
 		argv_array_push(&am.args, "--ignore-whitespace");
 	if (opts->committer_date_is_author_date)
 		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
+	if (opts->ignore_date)
+		argv_array_push(&opts->git_am_opts, "--ignore-date");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1451,8 +1455,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1728,13 +1732,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    state_dir_base, cmd_live_rebase, buf.buf);
 	}
 
-	if (options.committer_date_is_author_date)
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
index 34e45246f7..a4c6a47bea 100644
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
@@ -890,6 +891,36 @@ static char *read_author_date_or_null(void)
 	return date;
 }
 
+/* Construct a free()able author string with current time as the author date */
+static char *ignore_author_date(const char *author)
+{
+	int len = strlen(author);
+	struct ident_split ident;
+	struct strbuf new_author = STRBUF_INIT;
+
+	if (split_ident_line(&ident, author, len) < 0) {
+		error(_("malformed ident line"));
+		return NULL;
+	}
+	len = ident.mail_end - ident.name_begin + 1;
+
+	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);
+	datestamp(&new_author);
+	return strbuf_detach(&new_author, NULL);
+}
+
+static void push_dates(struct child_process *child, int change_committer_date)
+{
+	time_t now = time(NULL);
+	struct strbuf date = STRBUF_INIT;
+
+	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
+	argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
+	if (change_committer_date)
+		argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
+	strbuf_release(&date);
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -958,7 +989,8 @@ static int run_git_commit(struct repository *r,
 	                return -1;
 
 	        strbuf_addf(&datebuf, "@%s", date);
-	        res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
+		res = setenv("GIT_COMMITTER_DATE",
+			     opts->ignore_date ? "" : datebuf.buf, 1);
 
 		strbuf_release(&datebuf);
 	        free(date);
@@ -982,6 +1014,8 @@ static int run_git_commit(struct repository *r,
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
+	if (opts->ignore_date)
+		push_dates(&cmd, opts->committer_date_is_author_date);
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	else if (!(flags & EDIT_MSG))
@@ -1404,7 +1438,8 @@ static int try_to_commit(struct repository *r,
 		strbuf_addf(&date, "@%.*s %.*s",
 			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
 			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
-		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
+		res = setenv("GIT_COMMITTER_DATE",
+			     opts->ignore_date ? "" : date.buf, 1);
 		strbuf_release(&date);
 
 		if (res)
@@ -1454,6 +1489,15 @@ static int try_to_commit(struct repository *r,
 
 	reset_ident_date();
 
+	if (opts->ignore_date) {
+		author = ignore_author_date(author);
+		if (!author) {
+			res = -1;
+			goto out;
+		}
+		free(author_to_free);
+		author_to_free = (char *)author;
+	}
 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
 				 oid, author, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
@@ -2538,6 +2582,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->committer_date_is_author_date = 1;
 		}
 
+		if (file_exists(rebase_path_ignore_date())) {
+			opts->allow_ff = 0;
+			opts->ignore_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2622,6 +2671,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_signoff(), "--signoff\n");
 	if (opts->committer_date_is_author_date)
 		write_file(rebase_path_cdate_is_adate(), "%s", "");
+	if (opts->ignore_date)
+		write_file(rebase_path_ignore_date(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3557,6 +3608,8 @@ static int do_merge(struct repository *r,
 		argv_array_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
 			argv_array_push(&cmd.args, opts->gpg_sign);
+		if (opts->ignore_date)
+			push_dates(&cmd, opts->committer_date_is_author_date);
 
 		/* Add the tips to be merged */
 		for (j = to_merge; j; j = j->next)
@@ -3830,7 +3883,8 @@ static int pick_commits(struct repository *r,
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit ||
-				opts->committer_date_is_author_date));
+				opts->committer_date_is_author_date ||
+				opts->ignore_date));
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index ffddf011cc..3e6275272a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -44,6 +44,7 @@ struct replay_opts {
 	int quiet;
 	int reschedule_failed_exec;
 	int committer_date_is_author_date;
+	int ignore_date;
 
 	int mainline;
 
diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
index a98cfe18b7..5166f158dd 100755
--- a/t/t3433-rebase-options-compatibility.sh
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -99,4 +99,33 @@ test_expect_success '--committer-date-is-author-date works with rebase -r' '
 	done <rev_list
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
+
+test_expect_success '--ignore-date works with rebase -r' '
+	git checkout side &&
+	git merge --no-ff commit3 &&
+	git rebase -r --root --ignore-date &&
+	git rev-list HEAD >rev_list &&
+	while read HASH
+	do
+		git show $HASH --pretty="format:%ai" >authortime
+		grep "+0000" authortime
+	done <rev_list
+'
+
 test_done
-- 
2.21.0

