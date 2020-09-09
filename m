Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F765C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61892216C4
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="utEvZEUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIIAu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbgIIAuH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 20:50:07 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE14C061786
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 17:50:06 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id t201so731315pfc.13
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 17:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AZ4HpHzxu4QorBGlB69peEQ909CDU/ErYSqOA8fe1rs=;
        b=utEvZEUXT9mD4jLVfYrrFjNGiyJAFHLp+z90D8qE4cai5xFrqTEtdbiLZuwH3zBRq2
         QhB8l5wF8t2dqRgN/wOjswCTaN9yWrudEdPOYnnalUR9hgECcYaT/m0vCGu9osn0XHaC
         LG9YB3LQ5pWW8xEwEPEgLHpxda0XZyxordFQqbUI5nS52pVUweiVvJFAs6pK0kCGOmDx
         ibNtb2F3pGlQvmSVCdcTXAs8Fk1yjuWBXc9SriXKpQnCi7hm5gz4nCgLtUUulXFLaSxA
         CSIlh56d2U1OghlKRAF++ve9rdsVy9zYj5sniyDajRq7EUPnkCEdJsr8b1MUTJEFB+vc
         p0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AZ4HpHzxu4QorBGlB69peEQ909CDU/ErYSqOA8fe1rs=;
        b=ZtVdvRBQZ3kIA5wic88qKZo9eKzEwYXh6rdNpvuiI1dDNc+5kJnDHC5crjolpKhRzA
         ccpks8M1/9Ym5LX0jnbLp57qVW8tgbOVPR5XowH65MHcIFhUZAMlzSkjlKDwiU3WTzAY
         Fvu0Nl9rJc87TIqfdJpP2xk8cC1M8HSwZMjWugCF2DmEctAe+jkSZgsjnjWjYMKVavV5
         KwHu+5mpuWpa01ZbzeWPd0nf95NxpQt7Hksbz5JXp7OgwtMUgA+QVmD56BKrSC+xeQ7n
         mhfFz7Qus1abjtJ9xblmu5+IK9O23Vwdmd4Y4wYJ/HFP8WrkNbiGoOv619n297ZID1YK
         6rfg==
X-Gm-Message-State: AOAM532xhOEy05FbbBL6AUjV0Ea3+T17pFRf+0TsuJBhYCQi6DsZfOpS
        3d5hwauk5Lub8ih+y6n+VUywYDXyrMLxsR1UVwxMpjkQNSpDiBBsKd4zS/PKfwUHVHV4uRfdMew
        rKcVD5lzLcNPTgnmzpJF5Tut8fZbc+1ONJiiOWOPP+L90klQBqpsPEbQBrOE95aHC41kveWqKxw
        ==
X-Google-Smtp-Source: ABdhPJwbSU/hHSvFVtw6mDo6zjOMYtFFAmW8cEYNjMtdqkQjZSbS49ePw6ZDbmuT/eowkc61ChUXwJ2JbNH81FL7ILI=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a62:be0b:0:b029:137:3e38:c5de with
 SMTP id l11-20020a62be0b0000b02901373e38c5demr1621590pff.0.1599612606187;
 Tue, 08 Sep 2020 17:50:06 -0700 (PDT)
Date:   Tue,  8 Sep 2020 17:49:39 -0700
In-Reply-To: <20200909004939.1942347-1-emilyshaffer@google.com>
Message-Id: <20200909004939.1942347-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200909004939.1942347-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v4 9/9] run_commit_hook: take strvec instead of varargs
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taking varargs in run_commit_hook() led to some bizarre patterns, like
callers using two string variables (which may or may not be filled) to
express different argument lists for the commit hooks. Because
run_commit_hook() no longer needs to call a variadic function for the
hook run itself, we can use strvec to make the calling code more
conventional.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/commit.c | 46 +++++++++++++++++++++++-----------------------
 builtin/merge.c  | 20 ++++++++++++++++----
 commit.c         | 13 ++-----------
 commit.h         |  5 +++--
 sequencer.c      | 15 ++++++++-------
 5 files changed, 52 insertions(+), 47 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a19c6478eb..f029d4f5ac 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -691,8 +691,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	struct strbuf committer_ident = STRBUF_INIT;
 	int committable;
 	struct strbuf sb = STRBUF_INIT;
-	const char *hook_arg1 = NULL;
-	const char *hook_arg2 = NULL;
+	struct strvec hook_args = STRVEC_INIT;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
 	int merge_contains_scissors = 0;
@@ -700,7 +699,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit",
+					  &hook_args))
 		return 0;
 
 	if (squash_message) {
@@ -722,27 +722,28 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		}
 	}
 
+	strvec_push(&hook_args, git_path_commit_editmsg());
+
 	if (have_option_m && !fixup_message) {
 		strbuf_addbuf(&sb, &message);
-		hook_arg1 = "message";
+		strvec_push(&hook_args, "message");
 	} else if (logfile && !strcmp(logfile, "-")) {
 		if (isatty(0))
 			fprintf(stderr, _("(reading log message from standard input)\n"));
 		if (strbuf_read(&sb, 0, 0) < 0)
 			die_errno(_("could not read log from standard input"));
-		hook_arg1 = "message";
+		strvec_push(&hook_args, "message");
 	} else if (logfile) {
 		if (strbuf_read_file(&sb, logfile, 0) < 0)
 			die_errno(_("could not read log file '%s'"),
 				  logfile);
-		hook_arg1 = "message";
+		strvec_push(&hook_args, "message");
 	} else if (use_message) {
 		char *buffer;
 		buffer = strstr(use_message_buffer, "\n\n");
 		if (buffer)
 			strbuf_addstr(&sb, skip_blank_lines(buffer + 2));
-		hook_arg1 = "commit";
-		hook_arg2 = use_message;
+		strvec_pushl(&hook_args, "commit", use_message, NULL);
 	} else if (fixup_message) {
 		struct pretty_print_context ctx = {0};
 		struct commit *commit;
@@ -754,7 +755,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				      &sb, &ctx);
 		if (have_option_m)
 			strbuf_addbuf(&sb, &message);
-		hook_arg1 = "message";
+		strvec_push(&hook_args, "message");
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
 		size_t merge_msg_start;
 
@@ -765,9 +766,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
 			if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
 				die_errno(_("could not read SQUASH_MSG"));
-			hook_arg1 = "squash";
+			strvec_push(&hook_args, "squash");
 		} else
-			hook_arg1 = "merge";
+			strvec_push(&hook_args, "merge");
 
 		merge_msg_start = sb.len;
 		if (strbuf_read_file(&sb, git_path_merge_msg(the_repository), 0) < 0)
@@ -781,11 +782,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	} else if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
-		hook_arg1 = "squash";
+		strvec_push(&hook_args, "squash");
 	} else if (template_file) {
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
 			die_errno(_("could not read '%s'"), template_file);
-		hook_arg1 = "template";
+		strvec_push(&hook_args, "template");
 		clean_message_contents = 0;
 	}
 
@@ -794,11 +795,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 * just set the argument(s) to the prepare-commit-msg hook.
 	 */
 	else if (whence == FROM_MERGE)
-		hook_arg1 = "merge";
-	else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) {
-		hook_arg1 = "commit";
-		hook_arg2 = "CHERRY_PICK_HEAD";
-	}
+		strvec_push(&hook_args, "merge");
+	else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK)
+		strvec_pushl(&hook_args, "commit", "CHERRY_PICK_HEAD", NULL);
 
 	if (squash_message) {
 		/*
@@ -806,8 +805,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		 * then we're possibly hijacking other commit log options.
 		 * Reset the hook args to tell the real story.
 		 */
-		hook_arg1 = "message";
-		hook_arg2 = "";
+		strvec_clear(&hook_args);
+		strvec_pushl(&hook_args, git_path_commit_editmsg(), "message", NULL);
 	}
 
 	s->fp = fopen_for_writing(git_path_commit_editmsg());
@@ -1001,8 +1000,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
-			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
+	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg", &hook_args))
 		return 0;
 
 	if (use_editor) {
@@ -1017,8 +1015,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strvec_clear(&env);
 	}
 
+	strvec_clear(&hook_args);
+	strvec_push(&hook_args, git_path_commit_editmsg());
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
+	    run_commit_hook(use_editor, index_file, "commit-msg", &hook_args)) {
 		return 0;
 	}
 
diff --git a/builtin/merge.c b/builtin/merge.c
index c1a9d0083d..863c9039a3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -821,10 +821,14 @@ static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
+	struct strvec hook_args = STRVEC_INIT;
+	struct strbuf hook_name = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
+	if (!no_verify && run_commit_hook(0 < option_edit, index_file,
+					  "pre-merge-commit", &hook_args))
 		abort_commit(remoteheads, NULL);
+
 	/*
 	 * Re-read the index as pre-merge-commit hook could have updated it,
 	 * and write it out as a tree.  We must do this before we invoke
@@ -832,6 +836,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	 */
 	if (hook_exists("pre-merge-commit"))
 		discard_cache();
+
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
 	if (squash)
@@ -851,17 +856,22 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
+
+	strvec_clear(&hook_args);
+	strvec_pushl(&hook_args, git_path_merge_msg(the_repository), "merge", NULL);
 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
-			    git_path_merge_msg(the_repository), "merge", NULL))
+			    &hook_args))
 		abort_commit(remoteheads, NULL);
+
 	if (0 < option_edit) {
 		if (launch_editor(git_path_merge_msg(the_repository), NULL, NULL))
 			abort_commit(remoteheads, NULL);
 	}
 
+	strvec_clear(&hook_args);
+	strvec_push(&hook_args, git_path_merge_msg(the_repository));
 	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
-					  "commit-msg",
-					  git_path_merge_msg(the_repository), NULL))
+					  "commit-msg", &hook_args))
 		abort_commit(remoteheads, NULL);
 
 	read_merge_msg(&msg);
@@ -871,6 +881,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	strbuf_release(&merge_msg);
 	strbuf_addbuf(&merge_msg, &msg);
 	strbuf_release(&msg);
+	strbuf_release(&hook_name);
+	strvec_clear(&hook_args);
 }
 
 static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
diff --git a/commit.c b/commit.c
index c7a243e848..726407152c 100644
--- a/commit.c
+++ b/commit.c
@@ -1629,12 +1629,9 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 }
 
 int run_commit_hook(int editor_is_used, const char *index_file,
-		    const char *name, ...)
+		    const char *name, struct strvec *args)
 {
 	struct strvec hook_env = STRVEC_INIT;
-	va_list args;
-	const char *arg;
-	struct strvec hook_args = STRVEC_INIT;
 	struct strbuf hook_name = STRBUF_INIT;
 	int ret;
 
@@ -1648,14 +1645,8 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 	if (!editor_is_used)
 		strvec_push(&hook_env, "GIT_EDITOR=:");
 
-	va_start(args, name);
-	while ((arg = va_arg(args, const char *)))
-		strvec_push(&hook_args, arg);
-	va_end(args);
-
-	ret = run_hooks(hook_env.v, &hook_name, &hook_args);
+	ret = run_hooks(hook_env.v, &hook_name, args);
 	strvec_clear(&hook_env);
-	strvec_clear(&hook_args);
 	strbuf_release(&hook_name);
 
 	return ret;
diff --git a/commit.h b/commit.h
index e901538909..978da3c3e0 100644
--- a/commit.h
+++ b/commit.h
@@ -9,6 +9,7 @@
 #include "string-list.h"
 #include "pretty.h"
 #include "commit-slab.h"
+#include "strvec.h"
 
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
 #define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
@@ -353,7 +354,7 @@ void verify_merge_signature(struct commit *commit, int verbose,
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
-LAST_ARG_MUST_BE_NULL
-int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
+int run_commit_hook(int editor_is_used, const char *index_file,
+		    const char *name, struct strvec *args);
 
 #endif /* COMMIT_H */
diff --git a/sequencer.c b/sequencer.c
index cc3f8fa88e..5dd4b134d6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1124,22 +1124,23 @@ static int run_prepare_commit_msg_hook(struct repository *r,
 				       const char *commit)
 {
 	int ret = 0;
-	const char *name, *arg1 = NULL, *arg2 = NULL;
+	struct strvec args = STRVEC_INIT;
+	const char *name = git_path_commit_editmsg();
 
-	name = git_path_commit_editmsg();
+	strvec_push(&args, name);
 	if (write_message(msg->buf, msg->len, name, 0))
 		return -1;
 
 	if (commit) {
-		arg1 = "commit";
-		arg2 = commit;
+		strvec_push(&args, "commit");
+		strvec_push(&args, commit);
 	} else {
-		arg1 = "message";
+		strvec_push(&args, "message");
 	}
-	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
-			    arg1, arg2, NULL))
+	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", &args))
 		ret = error(_("'prepare-commit-msg' hook failed"));
 
+	strvec_clear(&args);
 	return ret;
 }
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

