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
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9001F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbfHFRkD (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:40:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43171 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387741AbfHFRkC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:40:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id r26so6007365pgl.10
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgB6MsXKT+SH6xHAN60J3vnU2y7VzRJxVNq4MP45VbA=;
        b=CKMYUTn99p/A+J5eKxDGc4dzoL83sUCLOuklO7acfhtLuH3bKTFXcSUK6pY15QBGGY
         FpQqt5r4Jo7zCRQQ1qQtKV53aINjWjb7z4W0BlAstDvUkYh3Pp9t4OKrPEms/2pMv82y
         FxSeVS3fbQTpVmKubrNK0VhaMov2EdW8wHAhS/+HzZ+/XdQ5mtJzdmdWkDsLwti5TMMs
         EP4PARGTGxEcQVuz0i1XtYnEO+jlMessRcFS9hgvQXnGvjLNw2NQJkIgFvZ1ptFJzlDB
         9KeNg0+7xs7dabrA/Y3Oir7uVSLsHJdY3CVgDs3sP/SZ5q4Bo9ccJGcAMXRmRgFsg8sv
         q4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgB6MsXKT+SH6xHAN60J3vnU2y7VzRJxVNq4MP45VbA=;
        b=gjwBCHuxMFkF8CHpcUdouUnA3UmFfE3//Z4qAXTdD9ITldLSy05jz96vPZEcI3p1EI
         WvwuWj233KIXNNaKi0CU9+9URR85QcexBAkxojBreL8+fiTJolQ7pOSgTrEeQNIWJjCk
         htDQWDqPOx+zAkQhQYkO7HxTfm+PS5Pe6u92mPuvXN08D8hoa0QiFxj6wxqbw+xEqpYB
         +e8ZD7Z5zqrphga/YEL2bQhcDJNZno9ssjNZ7tmQZU4nCOTReUdYkrT6d+dscohSvFVC
         bdDxNpnnpksh/b7IxRIPWZopQM9c7c4bcU9Y8XgSyFL5zGx8gPcKoCxQQoYVdXtR00D0
         1oXA==
X-Gm-Message-State: APjAAAU3Nfdfrd1K6cjQbtWuxGya1XpIevWdnyEOvBCA00k9aoLLe4PH
        4V06Vy6pQlb2rnqCPaFyGBo=
X-Google-Smtp-Source: APXvYqyXKxoziltqpOlHTte75BKi2s62yT7e42FjbhndCsG0yTNug8hw86+9Fnd4hdbIGL/FFPtdow==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr3979793pgh.369.1565113201332;
        Tue, 06 Aug 2019 10:40:01 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.217])
        by smtp.gmail.com with ESMTPSA id z20sm139757104pfk.72.2019.08.06.10.39.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:40:00 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCHl 3/6] rebase -i: support --committer-date-is-author-date
Date:   Tue,  6 Aug 2019 23:06:35 +0530
Message-Id: <20190806173638.17510-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
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
 builtin/rebase.c                        | 20 +++++++---
 sequencer.c                             | 52 ++++++++++++++++++++++++-
 sequencer.h                             |  1 +
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3433-rebase-options-compatibility.sh | 19 +++++++++
 6 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 85404fea52..83c5bbe06c 100644
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
index 3c195ddc73..41fe9ebff8 100644
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
@@ -113,6 +114,8 @@ static struct replay_opts get_replay_opts(struct rebase_options *opts)
 	replay.allow_empty_message = opts->allow_empty_message;
 	replay.verbose = opts->flags & REBASE_VERBOSE;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
+	replay.committer_date_is_author_date =
+					opts->committer_date_is_author_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
 
@@ -532,6 +535,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
+	if (opts.committer_date_is_author_date)
+		opts.flags |= REBASE_FORCE;
+
 	return !!run_rebase_interactive(&opts, command);
 }
 
@@ -970,6 +976,8 @@ static int run_am(struct rebase_options *opts)
 
 	if (opts->ignore_whitespace)
 		argv_array_push(&am.args, "--ignore-whitespace");
+	if (opts->committer_date_is_author_date)
+		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1417,9 +1425,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1686,10 +1694,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
index a2d7b0925e..65adf79222 100644
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
@@ -876,6 +877,17 @@ static char *get_author(const char *message)
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
@@ -904,6 +916,18 @@ static const char *read_author_ident(struct strbuf *buf)
 	return buf->buf;
 }
 
+static int setenv_committer_date_to_author_date(void)
+{
+	int res = 1;
+	char *date = read_author_date_or_null();
+
+	if (date)
+		res = setenv("GIT_COMMITTER_DATE", date, 1);
+
+	free(date);
+	return res;
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -961,6 +985,9 @@ static int run_git_commit(struct repository *r,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
+	if (opts->committer_date_is_author_date &&
+	    setenv_committer_date_to_author_date())
+		return 1;
 	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
 		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
 		const char *author = NULL;
@@ -1397,7 +1424,9 @@ static int try_to_commit(struct repository *r,
 
 	if (parse_head(r, &current_head))
 		return -1;
-
+	if (!(flags & AMEND_MSG) && opts->committer_date_is_author_date &&
+	    setenv_committer_date_to_author_date())
+		return -1;
 	if (flags & AMEND_MSG) {
 		const char *exclude_gpgsig[] = { "gpgsig", NULL };
 		const char *out_enc = get_commit_output_encoding();
@@ -1418,6 +1447,17 @@ static int try_to_commit(struct repository *r,
 			res = error(_("unable to parse commit author"));
 			goto out;
 		}
+		if (opts->committer_date_is_author_date) {
+			char *date;
+			int len = strlen(author);
+			char *idx = memchr(author, '>', len);
+
+			++idx;
+			date = malloc(author + len - idx);
+			memcpy(date, idx, author + len - idx);
+			setenv("GIT_COMMITTER_DATE", date, 1);
+			free(date);
+		}
 		parents = copy_commit_list(current_head->parents);
 		extra = read_commit_extra_headers(current_head, exclude_gpgsig);
 	} else if (current_head) {
@@ -2538,6 +2578,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->signoff = 1;
 		}
 
+		if (file_exists(rebase_path_cdate_is_adate())) {
+			opts->allow_ff = 0;
+			opts->committer_date_is_author_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2620,6 +2665,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
 	if (opts->signoff)
 		write_file(rebase_path_signoff(), "--signoff\n");
+	if (opts->committer_date_is_author_date)
+		write_file(rebase_path_cdate_is_adate(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3708,7 +3755,8 @@ static int pick_commits(struct repository *r,
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
-				opts->record_origin || opts->edit));
+				opts->record_origin || opts->edit ||
+				opts->committer_date_is_author_date));
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index 0c494b83d4..e6cba468db 100644
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
index e617d3150e..ceab48a831 100755
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
+	git rebase -f HEAD^ &&
+	git rebase --committer-date-is-author-date HEAD^ &&
+	git show HEAD --pretty="format:%at" >authortime &&
+	git show HEAD --pretty="format:%ct" >committertime &&
+	test_cmp authortime committertime
+'
+
+test_expect_success '--committer-date-is-author-date works with interactive backend' '
+	git rebase -f HEAD^ &&
+	git rebase -i --committer-date-is-author-date HEAD^ &&
+	git show HEAD --pretty="format:%at" >authortime &&
+	git show HEAD --pretty="format:%ct" >committertime &&
+	test_cmp authortime committertime
+'
+
 test_done
-- 
2.21.0

