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
	by dcvr.yhbt.net (Postfix) with ESMTP id E82CA1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 19:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfHLTqW (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 15:46:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37769 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTqV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 15:46:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so17189325pgp.4
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHSzjq5ojUaVHvS1t0wGp+Dflz6QIcmHYlwvNrKbcYw=;
        b=cO7TWcYaswJAhyvf+lxzAQ+ypc+64zA5GWXR92G7Ndse5QFTjs64XBhz1pjxJ4MkkE
         IXWkATvOlmDu+4RmbpRyNUcTIVn8wVxgW57A+B9BdohcBYiFznZN0mTqzwDNjnKmZQkE
         Aox4o+ZjW8u1cj0dVNeHa/dU5LrF7zszgFR7+6xpRwNKRDo+sZVi+CcXvzFJ9rP26eb7
         ZG1OhX5T0jWHX/ZYjOxsRwBMO86J3sdyoX9w9T7DWYWqPuoZx5v89rPB4FgA2Rh/WOsi
         skPZ7acEZA2/P6g/ge8nJ+H22GxQqlZoBtvwq+rs9o7NdLgZChKl1TPfMiw5gL7KHqy0
         NC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHSzjq5ojUaVHvS1t0wGp+Dflz6QIcmHYlwvNrKbcYw=;
        b=sWmgOFnlDQDckb3M6DQk/JrrItLORneJ7CFKNh3yCL0oz3sVNLTnnaqr+SAvl/9QAc
         ooXbmMDf7msOYyuFH9U0O4FKzPdVtcXoU7N5eMzEzsMMLwxy9ZDi2TRt0haS24UVk7B0
         +c+kkh3ZKo3mR7Qn8xNK+74ZtvBG03mKVOldAIN30IhDgkETnADu/BTZMkKBfx17yWSJ
         04qkydM/2qNBIJPnI1T179r1CkrSvoSIfqXB8s2ChClTNmdv4IHj5mWUk/5eUlSDqU2F
         xE5VOhs4tY3lpT2se47DtZLEA551cG1CqkTvSOCCyxR4RXat06irePwBkqpJjAoExcrL
         OBng==
X-Gm-Message-State: APjAAAV6Ms+74+IDvqH/XMPSggwCoDxf3cg6fEQeQob6j4WzSKQdPmMy
        4JnqiprXKDrA13h3Acz8zQ0=
X-Google-Smtp-Source: APXvYqxlT3NW1PzbRWIcyNJKzlkBJneGj/qB7F3z/6UhgAu9Sgh56j5/2bCnzxycpaxrZFV6MjkKcA==
X-Received: by 2002:a17:90a:1202:: with SMTP id f2mr806412pja.39.1565639180684;
        Mon, 12 Aug 2019 12:46:20 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.228])
        by smtp.gmail.com with ESMTPSA id j187sm13275947pfg.178.2019.08.12.12.46.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:46:19 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 3/6] rebase -i: support --committer-date-is-author-date
Date:   Tue, 13 Aug 2019 01:12:57 +0530
Message-Id: <20190812194301.5655-4-rohit.ashiwal265@gmail.com>
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

rebase am already has this flag to "lie" about the committer date
by changing it to the author date. Let's add the same for
interactive machinery.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt            |  8 +++-
 builtin/rebase.c                        | 20 ++++++---
 sequencer.c                             | 57 ++++++++++++++++++++++++-
 sequencer.h                             |  1 +
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3433-rebase-options-compatibility.sh | 19 +++++++++
 6 files changed, 96 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 28e5e08a83..697ce8e6ff 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -383,8 +383,12 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 See also INCOMPATIBLE OPTIONS below.
 
 --committer-date-is-author-date::
+	Instead of recording the time the rebased commits are
+	created as the committer date, reuse the author date
+	as the committer date. This implies --force-rebase.
+
 --ignore-date::
-	These flags are passed to 'git am' to easily change the dates
+	This flag is passed to 'git am' to change the author date
 	of the rebased commits (see linkgit:git-am[1]).
 +
 See also INCOMPATIBLE OPTIONS below.
@@ -522,7 +526,6 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
- * --committer-date-is-author-date
  * --ignore-date
  * --whitespace
  * -C
@@ -548,6 +551,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --signoff
  * --preserve-merges and --rebase-merges
  * --preserve-merges and --ignore-whitespace
+ * --preserve-merges and --committer-date-is-author-date
  * --rebase-merges and --ignore-whitespace
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ab1bbb78ee..b1039f8db0 100644
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
 
@@ -533,6 +536,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
+	if (opts.committer_date_is_author_date)
+		opts.flags |= REBASE_FORCE;
+
 	return !!run_rebase_interactive(&opts, command);
 }
 
@@ -981,6 +987,8 @@ static int run_am(struct rebase_options *opts)
 
 	if (opts->ignore_whitespace)
 		argv_array_push(&am.args, "--ignore-whitespace");
+	if (opts->committer_date_is_author_date)
+		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1424,9 +1432,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1697,10 +1705,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
index 30d77c2682..fbc0ed0cad 100644
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
 /* Read author-script and return an ident line (author <email> timestamp) */
 static const char *read_author_ident(struct strbuf *buf)
 {
@@ -964,6 +976,25 @@ static int run_git_commit(struct repository *r,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
+	if (opts->committer_date_is_author_date) {
+		size_t len;
+		int res = -1;
+		struct strbuf datebuf = STRBUF_INIT;
+		char *date = read_author_date_or_null();
+
+		strbuf_addf(&datebuf, "@%s", date);
+		free(date);
+
+		date = strbuf_detach(&datebuf, &len);
+
+		if (len > 1)
+			res = setenv("GIT_COMMITTER_DATE", date, 1);
+
+		free(date);
+
+		if (res)
+			return -1;
+	}
 	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
 		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
 		const char *author = NULL;
@@ -1400,7 +1431,6 @@ static int try_to_commit(struct repository *r,
 
 	if (parse_head(r, &current_head))
 		return -1;
-
 	if (flags & AMEND_MSG) {
 		const char *exclude_gpgsig[] = { "gpgsig", NULL };
 		const char *out_enc = get_commit_output_encoding();
@@ -1427,6 +1457,21 @@ static int try_to_commit(struct repository *r,
 		commit_list_insert(current_head, &parents);
 	}
 
+	if (opts->committer_date_is_author_date) {
+		int len = strlen(author);
+		struct ident_split ident;
+		struct strbuf date = STRBUF_INIT;
+
+		split_ident_line(&ident, author, len);
+
+		if (!ident.date_begin)
+			return error(_("corrupted author without date information"));
+
+		strbuf_addf(&date, "@%s",ident.date_begin);
+		setenv("GIT_COMMITTER_DATE", date.buf, 1);
+		strbuf_release(&date);
+	}
+
 	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
 		res = error(_("git write-tree failed to write a tree"));
 		goto out;
@@ -2542,6 +2587,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->signoff = 1;
 		}
 
+		if (file_exists(rebase_path_cdate_is_adate())) {
+			opts->allow_ff = 0;
+			opts->committer_date_is_author_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2624,6 +2674,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
 	if (opts->signoff)
 		write_file(rebase_path_signoff(), "--signoff\n");
+	if (opts->committer_date_is_author_date)
+		write_file(rebase_path_cdate_is_adate(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3821,7 +3873,8 @@ static int pick_commits(struct repository *r,
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
index 2e16e00a9d..b2419a2b75 100755
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
@@ -62,4 +65,20 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
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
 test_done
-- 
2.21.0

