Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E26C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 06:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiHBGj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 02:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiHBGjy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 02:39:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91E433422
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 23:39:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a11so6743602wmq.3
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 23:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=gIFHaLoIy/k0iJ4xjG+RTWfqNAmigXV7ZHYAcEWmcPk=;
        b=h92yaBwCQ8xT1CBBrGm5BDewPCnqmDi9FTI0qPujDOSEXQJJKAL9AzqUWowVNJW1hB
         B00Y7gpd7EY/JjMNtUfc0Q1eFBvQ2zt5DH6IgGqgOKr1mCcd4M1WjUP0eRk/CCoVB5UI
         uiR1CV3Z3ij60ZwnoQj5ZfGYkJCzeSyxMBZgM/dOWucnBz2+lYXBzIb4VBr/h7SqE6G1
         WFpp8oVzktuSRXFUyvnM7XEKr6uu0qbOz9RIIzqA6vuDjoMjF4j5CqaIi2Lot3DJRDsb
         IDaDA2dNn7ssj2ROjIFrtxQv2zVso2vnsYz0G/mgU619yqAiPVVin/q+MYd6KfCQMSG/
         Wxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=gIFHaLoIy/k0iJ4xjG+RTWfqNAmigXV7ZHYAcEWmcPk=;
        b=UgFtrjTiQoB136wp3APOUNy8ASbENwYT2Dfs66u8Ah3Zt3K1rf32UKmcVwhmblQTYy
         dYao7X9gIdGxq3UH4YFeIUYO/V+pEIbsgLDuFkq9jDaPj2wjO913BQXOT+XIy6Co+By3
         oqp1EehcRpyvIe2dKtlb13JzfqZ6M2DbLLF0526YOqhTPHmb+PpxJXpv6fO2dueEV4Fj
         mqRPH4N4Qlguhk1Ar5gXKyacdYTHuaH525VvkRDW6SnSRAkcP3h/zvGxib1Bq7U0hDHA
         JM92553zjQe5tFm7kXycBIdApGo7/il009Aa0CtuHTcSdjbJqjxhYRQ+6XbiymwNxquy
         3NtQ==
X-Gm-Message-State: AJIora+Ll+RMRAQvulROzT9V64nBCfrKxft0bpmYCJFKE7QyUD8I25OV
        wy6ScMTNgowlnCflFTqLhCAoPP0Z0uA=
X-Google-Smtp-Source: AGRyM1tiNSf4NrcY5VKfY6xXrz4QEvn3F4R4qntOAVltqVytXqy5QMr4CJ7aIoNOedHl5oqCspMcdQ==
X-Received: by 2002:a05:600c:19d2:b0:3a3:3aca:a83d with SMTP id u18-20020a05600c19d200b003a33acaa83dmr13468008wmq.88.1659422391030;
        Mon, 01 Aug 2022 23:39:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000050b00b002205a6aec0asm4297072wrf.86.2022.08.01.23.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 23:39:50 -0700 (PDT)
Message-Id: <pull.1228.git.git.1659422389830.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Th=C3=A9o?= MAILLART via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 06:39:49 +0000
Subject: [PATCH] rebase: introduce allow-inline-reword option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Th=C3=A9o?= MAILLART <tmaillart@gmail.com>,
        =?UTF-8?q?Th=C3=A9o=20Maillart?= <tmaillart@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Th=C3=A9o=20Maillart?= <tmaillart@gmail.com>

This new option (false by default) for interactive rebase allows users
to modify the subject of a commit directly in the todo list, when they
select the "reword" action.
If the option is enabled, "reword" is selected and the subject has not
changed, then the default behaviour is used.
It also introduces a test for this specific option, and a related
function (set_inline_reword_editor) in the lib-rebase.sh to use a
simpler custom fake editor to be able to modify the message part of the
lines in a todo list (in the most simple cases).

Signed-off-by: Théo Maillart <tmaillart@gmail.com>
---
    [RFC] rebase: reword: new feature change the subject in the todo list
    
    If the user only wants to modify the subject of a commit during
    interactive rebase, now he can choose the "reword" command and change
    the subject directly in the todo list. If "reword" is selected and the
    subject has not changed, then we use the default behavior. Here is a
    demo https://asciinema.org/a/T9tEmUjjl4dyDuaXalPzXNzo1
    
    This is probably not the correct way to implement this new feature, or
    perhaps it is not desirable, so I would like some feedback. Thank you

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1228%2Ftmaillart%2Ftm%2Freword-inline-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1228/tmaillart/tm/reword-inline-v1
Pull-Request: https://github.com/git/git/pull/1228

 Documentation/git-rebase.txt  |  7 +++++
 builtin/rebase.c              | 11 ++++++++
 sequencer.c                   | 49 ++++++++++++++++++++++++++++++++---
 sequencer.h                   |  6 +++++
 t/lib-rebase.sh               | 29 +++++++++++++++++++++
 t/t3404-rebase-interactive.sh | 11 ++++++++
 6 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 080658c8710..dcfd65d0bc1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -332,6 +332,13 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--allow-inline-reword::
+	When performing an interactive rebase, this flag allows you to change
+	the subject of a specific commit directly in the todo list (only when
+	reword command is selected) without asking you to edit the commit
+	messages sequencially. If you select reword without changing the
+	commit's subject then you will get the default reword behaviour.
+
 --skip::
 	Restart the rebasing process by skipping the current patch.
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 56e4214b441..cfb86f15a69 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -103,6 +103,7 @@ struct rebase_options {
 	int reapply_cherry_picks;
 	int fork_point;
 	int update_refs;
+	int allow_inline_reword;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
@@ -130,6 +131,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
 	replay.allow_empty = 1;
 	replay.allow_empty_message = opts->allow_empty_message;
+	replay.allow_inline_reword = opts->allow_inline_reword;
 	replay.drop_redundant_commits = (opts->empty == EMPTY_DROP);
 	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
 	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
@@ -821,6 +823,11 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return git_config_string(&opts->default_backend, var, value);
 	}
 
+	if (!strcmp(var, "rebase.allowinlinereword")) {
+		opts->allow_inline_reword = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, data);
 }
 
@@ -1164,6 +1171,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("automatically re-schedule any `exec` that fails")),
 		OPT_BOOL(0, "reapply-cherry-picks", &options.reapply_cherry_picks,
 			 N_("apply all changes, even those already present upstream")),
+		OPT_BOOL_F(0, "allow-inline-reword",
+			   &options.allow_inline_reword,
+			   N_("allow changing commit's subject directly in the todo list"),
+			   PARSE_OPT_HIDDEN),
 		OPT_END(),
 	};
 	int i;
diff --git a/sequencer.c b/sequencer.c
index 5f22b7cd377..8623296f428 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -999,6 +999,7 @@ N_("you have staged changes in your working tree\n"
 #define VERIFY_MSG  (1<<4)
 #define CREATE_ROOT_COMMIT (1<<5)
 #define VERBATIM_MSG (1<<6)
+#define INLINE_MSG   (1<<7)
 
 static int run_command_silent_on_success(struct child_process *cmd)
 {
@@ -1076,6 +1077,24 @@ static int run_git_commit(const char *defmsg,
 		strvec_push(&cmd.args, "--cleanup=strip");
 	if ((flags & VERBATIM_MSG))
 		strvec_push(&cmd.args, "--cleanup=verbatim");
+	if ((flags & EDIT_MSG) && (flags & INLINE_MSG)) {
+		int ret;
+
+		strvec_push(&cmd.args, "-F");
+		strvec_push(&cmd.args, "-");
+		cmd.in = -1;
+		ret = start_command(&cmd);
+		if (ret)
+			return ret;
+		if (write(cmd.in, opts->subject, opts->subject_len) !=
+		    opts->subject_len)
+			return error(_("subject write error to child process"));
+		if (write(cmd.in, opts->content, opts->content_len) !=
+		    opts->content_len)
+			return error(_("content write error to child process"));
+		close(cmd.in);
+		return finish_command(&cmd);
+	}
 	if ((flags & EDIT_MSG))
 		strvec_push(&cmd.args, "-e");
 	else if (!(flags & CLEANUP_MSG) &&
@@ -2118,6 +2137,7 @@ static void refer_to_commit(struct replay_opts *opts,
 }
 
 static int do_pick_commit(struct repository *r,
+			  struct todo_list *todo_list,
 			  struct todo_item *item,
 			  struct replay_opts *opts,
 			  int final_fixup, int *check_todo)
@@ -2375,9 +2395,29 @@ static int do_pick_commit(struct repository *r,
 		*check_todo = !!(flags & EDIT_MSG);
 		if (!res && reword) {
 fast_forward_edit:
+			if (opts->allow_inline_reword && item->arg_len > 0 &&
+			    (strlen(msg.subject) != item->arg_len ||
+			     strncmp(msg.subject, todo_item_get_arg(todo_list,
+				     item),item->arg_len) != 0)) {
+				const char *commit_buf, *subject;
+				int subject_len;
+				unsigned long commit_buf_len;
+
+				flags |= INLINE_MSG;
+				opts->subject = todo_item_get_arg(todo_list,
+					item);
+				opts->subject_len = item->arg_len;
+				commit_buf = get_commit_buffer(commit,
+					&commit_buf_len);
+				subject_len = find_commit_subject(commit_buf,
+					&subject);
+				opts->content = subject + subject_len;
+				opts->content_len = commit_buf +
+					commit_buf_len - opts->content;
+			}
 			res = run_git_commit(NULL, opts, EDIT_MSG |
 					     VERIFY_MSG | AMEND_MSG |
-					     (flags & ALLOW_EMPTY));
+					     (flags & (ALLOW_EMPTY | INLINE_MSG)));
 			*check_todo = 1;
 		}
 	}
@@ -4621,7 +4661,7 @@ static int pick_commits(struct repository *r,
 				setenv(GIT_REFLOG_ACTION, reflog_message(opts,
 					command_to_string(item->command), NULL),
 					1);
-			res = do_pick_commit(r, item, opts,
+			res = do_pick_commit(r, todo_list, item, opts,
 					     is_final_fixup(todo_list),
 					     &check_todo);
 			if (is_rebase_i(opts))
@@ -5101,6 +5141,7 @@ release_todo_list:
 }
 
 static int single_pick(struct repository *r,
+		       struct todo_list *todo_list,
 		       struct commit *cmit,
 		       struct replay_opts *opts)
 {
@@ -5112,7 +5153,7 @@ static int single_pick(struct repository *r,
 	item.commit = cmit;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	return do_pick_commit(r, &item, opts, 0, &check_todo);
+	return do_pick_commit(r, todo_list, &item, opts, 0, &check_todo);
 }
 
 int sequencer_pick_revisions(struct repository *r,
@@ -5165,7 +5206,7 @@ int sequencer_pick_revisions(struct repository *r,
 			return error(_("empty commit set passed"));
 		if (get_revision(opts->revs))
 			BUG("unexpected extra commit from walk");
-		return single_pick(r, cmit, opts);
+		return single_pick(r, &todo_list, cmit, opts);
 	}
 
 	/*
diff --git a/sequencer.h b/sequencer.h
index 563fe599334..26e3e43ce99 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -42,6 +42,7 @@ struct replay_opts {
 	int allow_rerere_auto;
 	int allow_empty;
 	int allow_empty_message;
+	int allow_inline_reword;
 	int drop_redundant_commits;
 	int keep_redundant_commits;
 	int verbose;
@@ -57,6 +58,11 @@ struct replay_opts {
 	enum commit_msg_cleanup_mode default_msg_cleanup;
 	int explicit_cleanup;
 
+	const char *content;
+	int content_len;
+	const char *subject;
+	int subject_len;
+
 	/* Merge strategy */
 	char *default_strategy;  /* from config options */
 	char *strategy;
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index b57541356bd..8c9dacdad9a 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -222,3 +222,32 @@ set_replace_editor () {
 	sed -e "s/FILENAME/$1/g" <script | write_script fake-editor.sh &&
 	test_set_editor "$(pwd)/fake-editor.sh"
 }
+
+set_inline_reword_editor () {
+	write_script fake-editor.sh <<-\EOF
+	grep -v '^#' < "$1" > "$1".tmp
+	rm -f "$1"
+	echo 'rebase -i script before editing:'
+	cat "$1".tmp
+	action=\\2
+	hash=\\3
+	subject=\\4
+	for line in $FAKE_LINES; do
+		case $line in
+		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
+			subject=\\4
+			action="$line";;
+		reword_*)
+			action=reword
+			subject=$(echo "$line" | sed 's,reword_\(.*\),\1,');;
+		*)
+			sed -n "${line}s,^\(\([a-z][a-z]*\)[[:space:]]*\([a-f0-9][a-f0-9]*\)[[:space:]]*\(.*\)\),${action} ${hash} ${subject},p" < "$1".tmp >> "$1"
+			action=\\2;;
+		esac
+	done
+	echo 'rebase -i script after editing:'
+	cat "$1"
+	EOF
+
+	test_set_editor "$(pwd)/fake-editor.sh"
+}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 688b01e3eb6..4c27d5f1c91 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -951,6 +951,17 @@ test_expect_success 'rebase -ix with --autosquash' '
 	test_cmp expected actual
 '
 
+test_expect_success 'rebase -i with --allow-inline-reword' '
+	git checkout -b reword-inline primary &&
+	(
+		set_inline_reword_editor &&
+		FAKE_LINES="reword_Bchanged 1 2 reword_Dchanged 3 4" \
+			git rebase --allow-inline-reword -i HEAD~4
+	) &&
+	test Bchanged = $(git show -s --format=%s HEAD~3) &&
+	test Dchanged = $(git show -s --format=%s HEAD~)
+'
+
 test_expect_success 'rebase --exec works without -i ' '
 	git reset --hard execute &&
 	rm -rf exec_output &&

base-commit: 350dc9f0e8974b6fcbdeb3808186c5a79c3e7386
-- 
gitgitgadget
