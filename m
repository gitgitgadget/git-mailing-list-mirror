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
	by dcvr.yhbt.net (Postfix) with ESMTP id 839041F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbfHFRkN (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:40:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40509 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbfHFRkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:40:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so41964638pgj.7
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mxn1HE8V70+VDlOWtpnx0J3ASMnBM5mhGutN0R4DyVU=;
        b=P5f+hqQt7YAR6FZppJ8c4yeY/qlFF4kkKdvHuv2Rww6hlFIWKZObtCh4MTWaJFckNH
         3vZh/tumDQIqeaj93PLlJ6te/QEZNbwl7KdqyWHNat6cumIShWH9ihvyoS6DfMcr7ZND
         VjpE5bA++faP+dr9IgoStF5Ihj2IjChukRwDjEpE4GY5+PGoC6gkrhuhr/h3R8ebKaCP
         cj5QFH2I2szUI9aA1TZk5bX2uKHwwdOi6UK5hxiSwkIiKGKPtUPckhCXJWxOFOqnCHOS
         h5Gl/52qMP8Ta4i4VCyStvvpsbxfqkN4ePVEsKsDjxS9fu6IxCB4H+Q3X0PG8xYM6KN6
         SssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mxn1HE8V70+VDlOWtpnx0J3ASMnBM5mhGutN0R4DyVU=;
        b=iHjtGZMwlpyRYf1+7bR6jDYYgHi0yiObZZWxp4ybAojw04D212QKfnPydsbheagFIE
         PCwZzkYPeBTU+vEeMJEkf9LRbk+trgsYvW9/p9FyVhgTUndwOsQO9x88mVYsgDnPEYes
         APGVXWkdI8vGhZf7+yYfoVXTBGQFEkmWWQb6jDKMzPN7QqpMHIsCb3HCpvDbrpcJyGJX
         UxLzCaGSsikzFmgoBa7KJThQBaIp8Zvats1i7RkCCIDKb6J4EitNSOg9kmpqsDE2viUo
         cNqLE1SLKVln/A9odjQ4H26Uj1HVIBNaAxJeHf09G+gxaLzBioWjIpHAbfMvu0IfBJT/
         Z3Zg==
X-Gm-Message-State: APjAAAVBKDO2bW9gFvlzTA5opbmuBK8N1UqL5tR+oR19a0aRiuPQ+0I+
        armmt5Lwn5kkFJ6U8unYrCo=
X-Google-Smtp-Source: APXvYqwJgVegqkq023Egl1usj9+zGMfa0sovd6LT4jrk9TiBj9ABmJXpz1zXAX1Y5roOKePlHNGrsg==
X-Received: by 2002:a63:3c5:: with SMTP id 188mr3947241pgd.394.1565113210224;
        Tue, 06 Aug 2019 10:40:10 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.217])
        by smtp.gmail.com with ESMTPSA id z20sm139757104pfk.72.2019.08.06.10.40.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:40:09 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCHl 5/6] rebase -i: support --ignore-date
Date:   Tue,  6 Aug 2019 23:06:37 +0530
Message-Id: <20190806173638.17510-6-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
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
 Documentation/git-rebase.txt            |  6 ++--
 builtin/rebase.c                        | 17 +++++----
 sequencer.c                             | 48 ++++++++++++++++++++++---
 sequencer.h                             |  1 +
 t/t3433-rebase-options-compatibility.sh | 16 +++++++++
 5 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 83c5bbe06c..a5cdf8518b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -388,8 +388,8 @@ See also INCOMPATIBLE OPTIONS below.
 	as the committer date. This implies --force-rebase.
 
 --ignore-date::
-	This flag is passed to 'git am' to change the author date
-	of the rebased commits (see linkgit:git-am[1]).
+	Lie about the author date by re-setting it to the value
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
index 41fe9ebff8..7f464fc9ba 100644
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
@@ -116,6 +117,7 @@ static struct replay_opts get_replay_opts(struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.committer_date_is_author_date =
 					opts->committer_date_is_author_date;
+	replay.ignore_date = opts->ignore_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
 
@@ -535,7 +537,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
-	if (opts.committer_date_is_author_date)
+	if (opts.committer_date_is_author_date ||
+	    opts.ignore_date)
 		opts.flags |= REBASE_FORCE;
 
 	return !!run_rebase_interactive(&opts, command);
@@ -978,6 +981,8 @@ static int run_am(struct rebase_options *opts)
 		argv_array_push(&am.args, "--ignore-whitespace");
 	if (opts->committer_date_is_author_date)
 		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
+	if (opts->ignore_date)
+		argv_array_push(&opts->git_am_opts, "--ignore-date");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1428,8 +1433,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1694,13 +1699,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
index d24a6fd585..c882dc5d5f 100644
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
@@ -928,6 +929,17 @@ static int setenv_committer_date_to_author_date(void)
 	return res;
 }
 
+static void ignore_author_date(const char **author)
+{
+	struct strbuf new_author = STRBUF_INIT;
+	char *idx = memchr(*author, '>', strlen(*author));
+
+	strbuf_add(&new_author, *author, idx - *author);
+	strbuf_addstr(&new_author, "> ");
+	datestamp(&new_author);
+	*author = strbuf_detach(&new_author, NULL);
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -985,7 +997,7 @@ static int run_git_commit(struct repository *r,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	if (opts->committer_date_is_author_date &&
+	if (opts->committer_date_is_author_date && !opts->ignore_date &&
 	    setenv_committer_date_to_author_date())
 		return 1;
 	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
@@ -1013,10 +1025,18 @@ static int run_git_commit(struct repository *r,
 
 		if (res <= 0)
 			res = error_errno(_("could not read '%s'"), defmsg);
-		else
+		else {
+			if (opts->ignore_date) {
+				if (!author)
+					BUG("ignore-date can only be used with "
+					    "rebase -i, which must set the "
+					    "author before committing the tree");
+				ignore_author_date(&author);
+			}
 			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
 					  NULL, &root_commit, author,
 					  opts->gpg_sign);
+		}
 
 		strbuf_release(&msg);
 		strbuf_release(&script);
@@ -1046,6 +1066,8 @@ static int run_git_commit(struct repository *r,
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
+	if (opts->ignore_date)
+		argv_array_pushf(&cmd.args, "--date=%ld", time(NULL));
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	else if (!(flags & EDIT_MSG))
@@ -1425,7 +1447,7 @@ static int try_to_commit(struct repository *r,
 	if (parse_head(r, &current_head))
 		return -1;
 	if (!(flags & AMEND_MSG) && opts->committer_date_is_author_date &&
-	    setenv_committer_date_to_author_date())
+	    !opts->ignore_date && setenv_committer_date_to_author_date())
 		return -1;
 	if (flags & AMEND_MSG) {
 		const char *exclude_gpgsig[] = { "gpgsig", NULL };
@@ -1447,7 +1469,7 @@ static int try_to_commit(struct repository *r,
 			res = error(_("unable to parse commit author"));
 			goto out;
 		}
-		if (opts->committer_date_is_author_date) {
+		if (opts->committer_date_is_author_date && !opts->ignore_date) {
 			char *date;
 			int len = strlen(author);
 			char *idx = memchr(author, '>', len);
@@ -1507,6 +1529,11 @@ static int try_to_commit(struct repository *r,
 
 	reset_ident_date();
 
+	if (opts->ignore_date) {
+		ignore_author_date(&author);
+		free(author_to_free);
+		author_to_free = (char *)author;
+	}
 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
 				 oid, author, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
@@ -2583,6 +2610,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->committer_date_is_author_date = 1;
 		}
 
+		if (file_exists(rebase_path_ignore_date())) {
+			opts->allow_ff = 0;
+			opts->ignore_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2667,6 +2699,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_signoff(), "--signoff\n");
 	if (opts->committer_date_is_author_date)
 		write_file(rebase_path_cdate_is_adate(), "%s", "");
+	if (opts->ignore_date)
+		write_file(rebase_path_ignore_date(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3484,6 +3518,9 @@ static int do_merge(struct repository *r,
 		argv_array_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
 			argv_array_push(&cmd.args, opts->gpg_sign);
+		if (opts->ignore_date)
+			argv_array_pushf(&cmd.args,
+					 "GIT_AUTHOR_DATE=%ld", time(NULL));
 
 		/* Add the tips to be merged */
 		for (j = to_merge; j; j = j->next)
@@ -3756,7 +3793,8 @@ static int pick_commits(struct repository *r,
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit ||
-				opts->committer_date_is_author_date));
+				opts->committer_date_is_author_date ||
+				opts->ignore_date));
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index e6cba468db..73d0515a3e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -44,6 +44,7 @@ struct replay_opts {
 	int quiet;
 	int reschedule_failed_exec;
 	int committer_date_is_author_date;
+	int ignore_date;
 
 	int mainline;
 
diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
index ceab48a831..95d99c4b7b 100755
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

