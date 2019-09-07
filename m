Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9EF51F461
	for <e@80x24.org>; Sat,  7 Sep 2019 11:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391095AbfIGLvI (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 07:51:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33158 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfIGLvI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 07:51:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so5056867pgn.0
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cetIYzEz+ISG2YkKOOcl+yVO9zSOiVQw8f7VdxYyMzk=;
        b=uyH/j1qMo6fNwfhzUl83z9zJrcA8MlSlf74bn7w/rkxE+aZ/uvTd8yxr5Q28Exx4aI
         KAPtS8yoOk+1M/YGO1gO7H4Air98YqHJZ+/qLJJ2/kl5QZChV49sFPnJNoPiit96NQDB
         M+HaXhqNy/GZK86iqdhoJd1Wwb9Q0ZPxrfvBgLGnkb4MiSePQ+dpIO36qXhBvWtov3tm
         1OKp52qJKbXmm85met/JyfNJXDK9LL/dgaujGC2PadDmg/3NEMcD/NS96b2PsgfwupA1
         yoDRcxmhdQPTsJdyHX+V7vPZM6ufKRANFTO1YhL6FaSPrPlDiCp9Kxsc7Q8yfvknUXhB
         DT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cetIYzEz+ISG2YkKOOcl+yVO9zSOiVQw8f7VdxYyMzk=;
        b=L/nVNHWmoxvPnGyoQfqGW8qcWI/Na+zGBbeK3mUgCKSAPOCUlvy5/R13hvRisl9T8L
         a/gthcLbq9w9idNOHNj4OLIGLBmG2gU2MNAQaJDrTJ8x/nNX9P6GR0YGRlbDgglTfhW7
         cQ640YkgWBoaLVdJib7xRHuhO+wugqblFk+VfoD1QY/iAUmYVtHPrTE+liultG8szEH/
         LSdbflJnVcXZ6U6c4hAkzxR96RDArmWKR/jkTzi/u+gaDm/WTQbSVAaKduTC2VaCAJdx
         50smu39Xh/vjHy3Bj0tTck0KdjbU6/doo8R/Ea4V5DdY1lphm2OKHuhJ0MNYG4xt2cuL
         DBDA==
X-Gm-Message-State: APjAAAXdFtRu30tLQnDWj/tiXy3WAxR/kJNZx5K+Dwn8XjlJUxH3Ol4v
        4i2uXaghl8bqDI1G92TpjxY=
X-Google-Smtp-Source: APXvYqz9gxFCP/rbtuFJbubsxK12qJuf3Tq+dbT9JFJzc8EAGJzBFWZ7Yhusx1wOjA42jt/j09ZHXw==
X-Received: by 2002:a17:90b:8ca:: with SMTP id ds10mr14665341pjb.105.1567857067271;
        Sat, 07 Sep 2019 04:51:07 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.225])
        by smtp.gmail.com with ESMTPSA id a11sm18134792pfg.94.2019.09.07.04.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 04:51:06 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v4 3/6] rebase -i: support --committer-date-is-author-date
Date:   Sat,  7 Sep 2019 17:20:31 +0530
Message-Id: <20190907115034.14933-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rebase am already has this flag to "lie" about the committer date
by changing it to the author date. Let's add the same for
interactive machinery.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt            | 10 ++--
 builtin/rebase.c                        | 17 +++++--
 sequencer.c                             | 61 ++++++++++++++++++++++++-
 sequencer.h                             |  1 +
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3433-rebase-options-compatibility.sh | 37 +++++++++++++++
 6 files changed, 116 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 873eb5768c..e7c0eac18c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -386,9 +386,13 @@ unchanged for the sake of a three-way merge.
 See also INCOMPATIBLE OPTIONS below.
 
 --committer-date-is-author-date::
+	Instead of recording the time the rebased commits are
+	created as the committer date, reuse the author date
+	as the committer date. This implies --force-rebase.
+
 --ignore-date::
-	These flags are passed to 'git am' to easily change the dates
-	of the rebased commits (see linkgit:git-am[1]).
+	This flag is passed to 'git am' to change the author date
+	of each rebased commit (see linkgit:git-am[1]).
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -525,7 +529,6 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
- * --committer-date-is-author-date
  * --ignore-date
  * --whitespace
  * -C
@@ -551,6 +554,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --signoff
  * --preserve-merges and --rebase-merges
  * --preserve-merges and --ignore-whitespace
+ * --preserve-merges and --committer-date-is-author-date
  * --rebase-merges and --ignore-whitespace
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
diff --git a/builtin/rebase.c b/builtin/rebase.c
index f8a618d54c..656bc7d7e9 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -82,6 +82,7 @@ struct rebase_options {
 	int ignore_whitespace;
 	char *gpg_sign_opt;
 	int autostash;
+	int committer_date_is_author_date;
 	char *cmd;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
@@ -114,6 +115,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.allow_empty_message = opts->allow_empty_message;
 	replay.verbose = opts->flags & REBASE_VERBOSE;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
+	replay.committer_date_is_author_date =
+					opts->committer_date_is_author_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
 
@@ -976,6 +979,8 @@ static int run_am(struct rebase_options *opts)
 
 	if (opts->ignore_whitespace)
 		argv_array_push(&am.args, "--ignore-whitespace");
+	if (opts->committer_date_is_author_date)
+		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1419,9 +1424,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
-				  &options.git_am_opts, NULL,
-				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
+		OPT_BOOL(0, "committer-date-is-author-date",
+			 &options.committer_date_is_author_date,
+			 N_("make committer date match author date")),
 		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
@@ -1692,10 +1697,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    state_dir_base, cmd_live_rebase, buf.buf);
 	}
 
+	if (options.committer_date_is_author_date)
+		options.flags |= REBASE_FORCE;
+
 	for (i = 0; i < options.git_am_opts.argc; i++) {
 		const char *option = options.git_am_opts.argv[i], *p;
-		if (!strcmp(option, "--committer-date-is-author-date") ||
-		    !strcmp(option, "--ignore-date") ||
+		if (!strcmp(option, "--ignore-date") ||
 		    !strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
 			options.flags |= REBASE_FORCE;
diff --git a/sequencer.c b/sequencer.c
index adeff2561e..fd925f2d72 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -147,6 +147,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
  * command-line.
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
+static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
@@ -879,6 +880,17 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
+/* Returns a "date" string that needs to be free()'d by the caller */
+static char *read_author_date_or_null(void)
+{
+	char *date;
+
+	if (read_author_script(rebase_path_author_script(),
+			       NULL, NULL, &date, 0))
+		return NULL;
+	return date;
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -938,6 +950,24 @@ static int run_git_commit(struct repository *r,
 
 	cmd.git_cmd = 1;
 
+        if (opts->committer_date_is_author_date) {
+	        int res = -1;
+	        struct strbuf datebuf = STRBUF_INIT;
+	        char *date = read_author_date_or_null();
+
+	        if (!date)
+	                return -1;
+
+	        strbuf_addf(&datebuf, "@%s", date);
+	        res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
+
+		strbuf_release(&datebuf);
+	        free(date);
+
+	        if (res)
+	                return -1;
+        }
+
 	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
 		const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
@@ -1331,7 +1361,6 @@ static int try_to_commit(struct repository *r,
 
 	if (parse_head(r, &current_head))
 		return -1;
-
 	if (flags & AMEND_MSG) {
 		const char *exclude_gpgsig[] = { "gpgsig", NULL };
 		const char *out_enc = get_commit_output_encoding();
@@ -1359,6 +1388,26 @@ static int try_to_commit(struct repository *r,
 		commit_list_insert(current_head, &parents);
 	}
 
+	if (opts->committer_date_is_author_date) {
+		int len = strlen(author);
+		struct ident_split ident;
+		struct strbuf date = STRBUF_INIT;
+
+		if (split_ident_line(&ident, author, len) < 0)
+			return error(_("malformed ident line"));
+		if (!ident.date_begin)
+			return error(_("corrupted author without date information"));
+
+		strbuf_addf(&date, "@%.*s %.*s",
+			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
+			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
+		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
+		strbuf_release(&date);
+
+		if (res)
+			goto out;
+	}
+
 	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
 		res = error(_("git write-tree failed to write a tree"));
 		goto out;
@@ -2473,6 +2522,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->signoff = 1;
 		}
 
+		if (file_exists(rebase_path_cdate_is_adate())) {
+			opts->allow_ff = 0;
+			opts->committer_date_is_author_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2555,6 +2609,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
 	if (opts->signoff)
 		write_file(rebase_path_signoff(), "--signoff\n");
+	if (opts->committer_date_is_author_date)
+		write_file(rebase_path_cdate_is_adate(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3752,7 +3808,8 @@ static int pick_commits(struct repository *r,
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
-				opts->record_origin || opts->edit));
+				opts->record_origin || opts->edit ||
+				opts->committer_date_is_author_date));
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index 6704acbb9c..e3881e9275 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -43,6 +43,7 @@ struct replay_opts {
 	int verbose;
 	int quiet;
 	int reschedule_failed_exec;
+	int committer_date_is_author_date;
 
 	int mainline;
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 4342f79eea..7402f7e3da 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -61,7 +61,6 @@ test_rebase_am_only () {
 }
 
 test_rebase_am_only --whitespace=fix
-test_rebase_am_only --committer-date-is-author-date
 test_rebase_am_only -C4
 
 test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
index 2e16e00a9d..6c1fbab4d8 100755
--- a/t/t3433-rebase-options-compatibility.sh
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -7,6 +7,9 @@ test_description='tests to ensure compatibility between am and interactive backe
 
 . ./test-lib.sh
 
+GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
+export GIT_AUTHOR_DATE
+
 # This is a special case in which both am and interactive backends
 # provide the same output. It was done intentionally because
 # both the backends fall short of optimal behaviour.
@@ -26,8 +29,13 @@ test_expect_success 'setup' '
 	EOF
 	git commit -am "update file" &&
 	git tag side &&
+	test_commit commit1 foo foo1 &&
+	test_commit commit2 foo foo2 &&
+	test_commit commit3 foo foo3 &&
 
 	git checkout --orphan master &&
+	git rm --cached foo &&
+	rm foo &&
 	sed -e "s/^|//" >file <<-\EOF &&
 	|line 1
 	|        line 2
@@ -62,4 +70,33 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
 	test_cmp expect file
 '
 
+test_expect_success '--committer-date-is-author-date works with am backend' '
+	git commit --amend &&
+	git rebase --committer-date-is-author-date HEAD^ &&
+	git show HEAD --pretty="format:%ai" >authortime &&
+	git show HEAD --pretty="format:%ci" >committertime &&
+	test_cmp authortime committertime
+'
+
+test_expect_success '--committer-date-is-author-date works with interactive backend' '
+	git commit --amend &&
+	git rebase -i --committer-date-is-author-date HEAD^ &&
+	git show HEAD --pretty="format:%ai" >authortime &&
+	git show HEAD --pretty="format:%ci" >committertime &&
+	test_cmp authortime committertime
+'
+
+test_expect_success '--committer-date-is-author-date works with rebase -r' '
+	git checkout side &&
+	git merge commit3 &&
+	git rebase -r --root --committer-date-is-author-date &&
+	git rev-list HEAD >rev_list &&
+	while read HASH
+	do
+		git show $HASH --pretty="format:%ai" >authortime
+		git show $HASH --pretty="format:%ci" >committertime
+		test_cmp authortime committertime
+	done <rev_list
+'
+
 test_done
-- 
2.21.0

