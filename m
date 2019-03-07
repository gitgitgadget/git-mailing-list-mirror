Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A10D202BB
	for <e@80x24.org>; Thu,  7 Mar 2019 09:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCGJ6h (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 04:58:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37720 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGJ6g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 04:58:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so10858809pgq.4
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 01:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJba8Btbf/3Hlw3cBkhB3yoOZK/emi0yb1oGy1US67Q=;
        b=fjdFDMUP3jX2BDDYPyJlPJ6LNWWEwIVi5HnJqxju83UGemD4XMl2vd9OkgMBdPHtU8
         LtJDYQElFlVv/hrwyNCsHwpTE0EN7tkMOcv5FSnFJ0Yy+S7BKWGExSnM6PD36t1sRmt2
         1/orwQ0x4QWVsZqYQmi+V0sD7V231Orgml0xUJfsfwqId5s6OapA5QmPxv9ZKq7UIx+h
         x7Xx6gg+CJ7vnXE5j6laWWkfIzGDh4+hZPmS6hcAw0bKhQHCvV1O5coIeh0WL+wrlwzY
         13ZW//E5b7oYQ2pKH192rIySe4c5lRnron9vohpkX2mZaI9K6qiqW98+sOpNSixcNa6m
         sizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJba8Btbf/3Hlw3cBkhB3yoOZK/emi0yb1oGy1US67Q=;
        b=t7/xwMjRzjuiT4hN3h6nwVmuP2UNmyDJ0CS8Kaxj9oJHhlMTE1GkwmTiaRp/WIqJ0Q
         rrzeal1np6h6yIvA8j/YZ/W1CwPnMXbJQ3AU0UQqXF5qLqsSsO6sKkk4E3+8LwDqzKqk
         aiyojDFmWXZU3byUOnSne5RMqayQ1ESmqsXC2TuN6DlcKSJ/BqsxncZCq7M6Fml45NiY
         d7PpvsBsfjN0kig6YkPB7wFNInwTOj005e+cdSdK7ICfwV4WSv4lfV7vmAaWhwu03EBG
         vHHx1yA3KS5it6cpb4TuAi6NbEB6mxJar94vbHtpDt9KnOvGpJCWws8QAigBO57xz9T3
         6FAg==
X-Gm-Message-State: APjAAAXT5OFOPWF+eag3mvdyBOj6KvyFZeYlUJGpe/fiqLs5wLNli1a3
        ECJpSYEAg2AQ56tWCJbpVSdsfxxn
X-Google-Smtp-Source: APXvYqzknkYF+Ou51oAv5XkVBa9FgGtOGEB1BdVAYQjX+ExILrqML1VBBnZ0LFSnYQ3oVlrSu4y5jg==
X-Received: by 2002:a62:4793:: with SMTP id p19mr12249866pfi.76.1551952715018;
        Thu, 07 Mar 2019 01:58:35 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id u184sm5507090pgd.13.2019.03.07.01.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 01:58:34 -0800 (PST)
Date:   Thu, 7 Mar 2019 01:58:32 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] cherry-pick/revert: add scissors line on merge
 conflict
Message-ID: <14672ce10c90c46b15b62c48d2eea6fe8d85ed86.1551951770.git.liu.denton@gmail.com>
References: <cover.1551940635.git.liu.denton@gmail.com>
 <cover.1551951770.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551951770.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
commit.cleanup = scissors.

Note that the removal of the if-else tower in git_sequencer_config may
appear to be a no-op refactor but it actually isn't. First of all, we
now accept "default". More importantly, though, if
commit.cleanup = scissors, the cleanup enum will be set to
COMMIT_MSG_CLEANUP_SCISSORS instead of COMMIT_MSG_CLEANUP_SPACE when we
are reverting or cherry-picking. This allows us to append scissors to
MERGE_MSG in the case of a conflict.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-cherry-pick.txt |  7 +++
 Documentation/git-revert.txt      |  7 +++
 builtin/merge.c                   | 13 ++---
 builtin/rebase--helper.c          |  2 +-
 builtin/revert.c                  |  5 ++
 sequencer.c                       | 32 +++++-------
 sequencer.h                       |  3 +-
 t/t3507-cherry-pick-conflict.sh   | 86 +++++++++++++++++++++++++++++++
 8 files changed, 125 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d35d771fc8..92235bd1c4 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -57,6 +57,13 @@ OPTIONS
 	With this option, 'git cherry-pick' will let you edit the commit
 	message prior to committing.
 
+--cleanup=<mode>::
+	This option determines how the commit message will be cleaned up before
+	being passed on. See linkgit:git-commit[1] for more details. In
+	addition, if the '<mode>' is given a value of `scissors`, scissors will
+	be appended to MERGE_MSG before being passed on in the case of a
+	conflict.
+
 -x::
 	When recording the commit, append a line that says
 	"(cherry picked from commit ...)" to the original commit
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 837707a8fd..bd4ad395a9 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -66,6 +66,13 @@ more details.
 	With this option, 'git revert' will not start the commit
 	message editor.
 
+--cleanup=<mode>::
+	This option determines how the commit message will be cleaned up before
+	being passed on. See linkgit:git-commit[1] for more details. In
+	addition, if the '<mode>' is given a value of `scissors`, scissors will
+	be appended to MERGE_MSG before being passed on in the case of a
+	conflict.
+
 -n::
 --no-commit::
 	Usually the command automatically creates some commits with
diff --git a/builtin/merge.c b/builtin/merge.c
index 92efc3d8fa..d4217ebcf5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -913,17 +913,10 @@ static int suggest_conflicts(void)
 	 * We can't use cleanup_mode because if we're not using the editor,
 	 * get_cleanup_mode will return COMMIT_MSG_CLEANUP_SPACE instead, even
 	 * though the message is meant to be processed later by git-commit.
-	 * Thus, we will get the cleanup mode is returned we _are_ using an
-	 * editor.
+	 * Thus, we will get the cleanup mode which is returned when we _are_ using
+	 * an editor.
 	 */
-	if (get_cleanup_mode(cleanup_arg, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
-	    fputc('\n', fp);
-	    wt_status_add_cut_line(fp);
-	    /* comments out the newline from append_conflicts_hint */
-	    fputc(comment_line_char, fp);
-	}
-
-	append_conflicts_hint(&msgbuf);
+	append_conflicts_hint(&msgbuf, get_cleanup_mode(cleanup_arg, 1));
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index f7c2a5fdc8..5f1bc9d383 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -48,10 +48,10 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	opts.action = REPLAY_INTERACTIVE_REBASE;
 	sequencer_init_config(&opts);
 	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
 
-	opts.action = REPLAY_INTERACTIVE_REBASE;
 	opts.allow_ff = 1;
 	opts.allow_empty = 1;
 
diff --git a/builtin/revert.c b/builtin/revert.c
index 9a66720cfc..fe18036be7 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -95,11 +95,13 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
+	const char *cleanup_arg = NULL;
 	int cmd = 0;
 	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
+		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
@@ -136,6 +138,9 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
 
+	if (cleanup_arg)
+		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
+
 	/* Check for incompatible command line arguments */
 	if (cmd) {
 		char *this_operation;
diff --git a/sequencer.c b/sequencer.c
index 707e72fb39..5c04bae7ac 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -153,6 +153,11 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
 static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
 
+static inline int is_rebase_i(const struct replay_opts *opts)
+{
+	return opts->action == REPLAY_INTERACTIVE_REBASE;
+}
+
 static int git_sequencer_config(const char *k, const char *v, void *cb)
 {
 	struct replay_opts *opts = cb;
@@ -165,17 +170,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 		if (status)
 			return status;
 
-		if (!strcmp(s, "verbatim"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
-		else if (!strcmp(s, "whitespace"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
-		else if (!strcmp(s, "strip"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
-		else if (!strcmp(s, "scissors"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
-		else
-			warning(_("invalid commit message cleanup mode '%s'"),
-				  s);
+		opts->default_msg_cleanup = get_cleanup_mode(s, !is_rebase_i(opts));
 
 		free((char *)s);
 		return status;
@@ -199,11 +194,6 @@ void sequencer_init_config(struct replay_opts *opts)
 	git_config(git_sequencer_config, opts);
 }
 
-static inline int is_rebase_i(const struct replay_opts *opts)
-{
-	return opts->action == REPLAY_INTERACTIVE_REBASE;
-}
-
 static const char *get_dir(const struct replay_opts *opts)
 {
 	if (is_rebase_i(opts))
@@ -516,10 +506,16 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 }
 
-void append_conflicts_hint(struct strbuf *msgbuf)
+void append_conflicts_hint(struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode)
 {
 	int i;
 
+	if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
+		strbuf_addch(msgbuf, '\n');
+		wt_status_append_cut_line(msgbuf);
+		strbuf_addch(msgbuf, comment_line_char);
+	}
+
 	strbuf_addch(msgbuf, '\n');
 	strbuf_commented_addf(msgbuf, "Conflicts:\n");
 	for (i = 0; i < active_nr;) {
@@ -586,7 +582,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 			_(action_name(opts)));
 
 	if (!clean)
-		append_conflicts_hint(msgbuf);
+		append_conflicts_hint(msgbuf, opts->default_msg_cleanup);
 
 	return !clean;
 }
diff --git a/sequencer.h b/sequencer.h
index 5690e0c27e..aa99503dd7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -91,7 +91,8 @@ int rearrange_squash(void);
 extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
-void append_conflicts_hint(struct strbuf *msgbuf);
+void append_conflicts_hint(struct strbuf *msgbuf,
+		enum commit_msg_cleanup_mode cleanup_mode);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	int use_editor);
 
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 74ff925526..c3894ca9d6 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -189,6 +189,46 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 	test_cmp expected actual
 '
 
+test_expect_success \
+	'cherry-pick conflict, ensure commit.cleanup = scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config commit.cleanup scissors &&
+	cat <<-EOF >expected &&
+		picked
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git cherry-pick picked &&
+
+	test_i18ncmp expected .git/MERGE_MSG
+'
+
+test_expect_success \
+	'cherry-pick conflict, ensure cleanup=scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config --unset commit.cleanup &&
+	cat <<-EOF >expected &&
+		picked
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git cherry-pick --cleanup=scissors picked &&
+
+	test_i18ncmp expected .git/MERGE_MSG
+'
+
 test_expect_success 'failed cherry-pick describes conflict in work tree' '
 	pristine_detach initial &&
 	cat <<-EOF >expected &&
@@ -335,6 +375,52 @@ test_expect_success 'revert conflict, diff3 -m style' '
 	test_cmp expected actual
 '
 
+test_expect_success \
+	'revert conflict, ensure commit.cleanup = scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config commit.cleanup scissors &&
+	cat >expected <<-EOF &&
+		Revert "picked"
+
+		This reverts commit OBJID.
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git revert picked &&
+
+	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success \
+	'revert conflict, ensure cleanup=scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config --unset commit.cleanup &&
+	cat >expected <<-EOF &&
+		Revert "picked"
+
+		This reverts commit OBJID.
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git revert --cleanup=scissors picked &&
+
+	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
+	test_i18ncmp expected actual
+'
+
 test_expect_success 'failed cherry-pick does not forget -s' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s picked &&
-- 
2.21.0.370.g4fdb13b891

