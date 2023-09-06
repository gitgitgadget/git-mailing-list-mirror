Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22627EE14A9
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 15:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbjIFPXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242555AbjIFPXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 11:23:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F511982
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 08:22:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c6cd238e0so754710f8f.0
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694013778; x=1694618578; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkessOCLYjU6qRajBC6xLircpgIT+YOR+Z1at6dbBNU=;
        b=CxI6MJN8kgpLO6LkMKvA7JFFFu2rqwZB8D3s6ChixPK+TKtpy2ONLmLGg2l+VqHub9
         LsgWydN+FuD8ZGyBEm0vYEq6JHidj6/CqQfejp8f9uWX6nbCy+6KbaTgVyNVAQWF+nz6
         OEEgk3estbQQTn5ajuzXeQyjhqoUxNi03cc77i9PSPH76cu4VFSEJV+sNqY8R5uQ3rJ7
         qytNGbKt3S2V0ply8v8qF9Nv1xGoMfnoTZvswXSmvgQwJmBVKppJywR20coBGW3dDjY7
         7xEmXeVwOtkyI1sCgEfqX2AIH9OHcP3y3XNBHMDAYA6srcPAgrH9al5JpqvcaVNhVYcs
         5lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694013778; x=1694618578;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkessOCLYjU6qRajBC6xLircpgIT+YOR+Z1at6dbBNU=;
        b=cUmUY1P+L2mNGMAEhUnLuAZPWRWZUlgK+owpK6WSNhiKyeq8YWfRlsbWEwC/TCeXSx
         Ba5PO7CXf6n75RUxrhh2iH2fC5jvRMNgo+lK9CiF7gEBBIPF/gKaQGDxz+SVF12WNV3k
         NeI1/q8IdG4iWNpJWOZ6MGW9L+yYbqVS5XaIAIK1vBQ8TvsLct0F3lvu7aR6TGBLB6XT
         UNALuOlnZ1mT1R9KiD7X3Jjlo82hcZrDfvC/BAqL8Luqu9ngwHOlTaCqoOjNpq3lwc/v
         i0kKbUhKhgTKgkETQUMYhHLJWdzPHgQs7ONDpYkpWqseyMPAX1qTqXSrN5vYC4pem9KK
         og0w==
X-Gm-Message-State: AOJu0YwdDhkadDw46N3UzI+BtllAX6J+uCqpAJLPHWQUplSYzifr0r+w
        hHxLoqZ66nOl5OVYqhPYPPMpEyGvfXY=
X-Google-Smtp-Source: AGHT+IFdAoZv2MhDkvebpznCJn+/CEoTeg9VaubDw7aZmSW+RPxsQY+rM86M5165IkVoBtxDk/Sz6w==
X-Received: by 2002:adf:f50b:0:b0:316:f9f1:bb0f with SMTP id q11-20020adff50b000000b00316f9f1bb0fmr2770619wro.34.1694013777753;
        Wed, 06 Sep 2023 08:22:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1-20020adfa401000000b0031980294e9fsm17320959wra.116.2023.09.06.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:22:57 -0700 (PDT)
Message-ID: <bd67765a864ab13b87e4ac9732b8c23c06b254eb.1694013772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
References: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Sep 2023 15:22:48 +0000
Subject: [PATCH v4 4/7] sequencer: factor out part of pick_commits()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This simplifies the next commit. If a pick fails we now return the error
at the end of the loop body rather than returning early, a successful
"edit" command continues to return early. There are three things to
check to ensure that removing the early return for an error does not
change the behavior of the code:

(1) We could enter the block guarded by "if (reschedule)". This block
    is not entered because "reschedlue" is always zero when picking a
    commit.

(2) We could enter the block guarded by
    "else if (is_rebase_i(opts) &&  check_todo && !res)". This block is
    not entered when returning an error because "res" is non-zero in
    that case.

(3) todo_list->current could be incremented before returning. That is
    avoided by moving the increment which is of course a potential
    change in behavior itself. The move is safe because none of the
    callers look at todo_list after this function returns. Moving the
    increment makes it clear we only want to advance the current item
    if the command was successful.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 132 ++++++++++++++++++++++++++++------------------------
 1 file changed, 71 insertions(+), 61 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 83be8bf2b6d..b434c5a2570 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4645,6 +4645,72 @@ N_("Could not execute the todo command\n"
 "    git rebase --edit-todo\n"
 "    git rebase --continue\n");
 
+static int pick_one_commit(struct repository *r,
+			   struct todo_list *todo_list,
+			   struct replay_opts *opts,
+			   int *check_todo)
+{
+	int res;
+	struct todo_item *item = todo_list->items + todo_list->current;
+	const char *arg = todo_item_get_arg(todo_list, item);
+	if (is_rebase_i(opts))
+		opts->reflog_message = reflog_message(
+			opts, command_to_string(item->command), NULL);
+
+	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
+			     check_todo);
+	if (is_rebase_i(opts) && res < 0) {
+		/* Reschedule */
+		advise(_(rescheduled_advice),
+		       get_item_line_length(todo_list, todo_list->current),
+		       get_item_line(todo_list, todo_list->current));
+		todo_list->current--;
+		if (save_todo(todo_list, opts))
+			return -1;
+	}
+	if (item->command == TODO_EDIT) {
+		struct commit *commit = item->commit;
+		if (!res) {
+			if (!opts->verbose)
+				term_clear_line();
+			fprintf(stderr, _("Stopped at %s...  %.*s\n"),
+				short_commit_name(commit), item->arg_len, arg);
+		}
+		return error_with_patch(r, commit,
+					arg, item->arg_len, opts, res, !res);
+	}
+	if (is_rebase_i(opts) && !res)
+		record_in_rewritten(&item->commit->object.oid,
+				    peek_command(todo_list, 1));
+	if (res && is_fixup(item->command)) {
+		if (res == 1)
+			intend_to_amend();
+		return error_failed_squash(r, item->commit, opts,
+					   item->arg_len, arg);
+	} else if (res && is_rebase_i(opts) && item->commit) {
+		int to_amend = 0;
+		struct object_id oid;
+
+		/*
+		 * If we are rewording and have either
+		 * fast-forwarded already, or are about to
+		 * create a new root commit, we want to amend,
+		 * otherwise we do not.
+		 */
+		if (item->command == TODO_REWORD &&
+		    !repo_get_oid(r, "HEAD", &oid) &&
+		    (oideq(&item->commit->object.oid, &oid) ||
+		     (opts->have_squash_onto &&
+		      oideq(&opts->squash_onto, &oid))))
+			to_amend = 1;
+
+		return res | error_with_patch(r, item->commit,
+					      arg, item->arg_len, opts,
+					      res, to_amend);
+	}
+	return res;
+}
+
 static int pick_commits(struct repository *r,
 			struct todo_list *todo_list,
 			struct replay_opts *opts)
@@ -4700,66 +4766,9 @@ static int pick_commits(struct repository *r,
 			}
 		}
 		if (item->command <= TODO_SQUASH) {
-			if (is_rebase_i(opts))
-				opts->reflog_message = reflog_message(opts,
-				      command_to_string(item->command), NULL);
-
-			res = do_pick_commit(r, item, opts,
-					     is_final_fixup(todo_list),
-					     &check_todo);
-			if (is_rebase_i(opts) && res < 0) {
-				/* Reschedule */
-				advise(_(rescheduled_advice),
-				       get_item_line_length(todo_list,
-							    todo_list->current),
-				       get_item_line(todo_list,
-						     todo_list->current));
-				todo_list->current--;
-				if (save_todo(todo_list, opts))
-					return -1;
-			}
-			if (item->command == TODO_EDIT) {
-				struct commit *commit = item->commit;
-				if (!res) {
-					if (!opts->verbose)
-						term_clear_line();
-					fprintf(stderr,
-						_("Stopped at %s...  %.*s\n"),
-						short_commit_name(commit),
-						item->arg_len, arg);
-				}
-				return error_with_patch(r, commit,
-					arg, item->arg_len, opts, res, !res);
-			}
-			if (is_rebase_i(opts) && !res)
-				record_in_rewritten(&item->commit->object.oid,
-					peek_command(todo_list, 1));
-			if (res && is_fixup(item->command)) {
-				if (res == 1)
-					intend_to_amend();
-				return error_failed_squash(r, item->commit, opts,
-					item->arg_len, arg);
-			} else if (res && is_rebase_i(opts) && item->commit) {
-				int to_amend = 0;
-				struct object_id oid;
-
-				/*
-				 * If we are rewording and have either
-				 * fast-forwarded already, or are about to
-				 * create a new root commit, we want to amend,
-				 * otherwise we do not.
-				 */
-				if (item->command == TODO_REWORD &&
-				    !repo_get_oid(r, "HEAD", &oid) &&
-				    (oideq(&item->commit->object.oid, &oid) ||
-				     (opts->have_squash_onto &&
-				      oideq(&opts->squash_onto, &oid))))
-					to_amend = 1;
-
-				return res | error_with_patch(r, item->commit,
-						arg, item->arg_len, opts,
-						res, to_amend);
-			}
+			res = pick_one_commit(r, todo_list, opts, &check_todo);
+			if (!res && item->command == TODO_EDIT)
+				return 0;
 		} else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(arg + item->arg_len);
 			int saved = *end_of_arg;
@@ -4820,9 +4829,10 @@ static int pick_commits(struct repository *r,
 			return -1;
 		}
 
-		todo_list->current++;
 		if (res)
 			return res;
+
+		todo_list->current++;
 	}
 
 	if (is_rebase_i(opts)) {
-- 
gitgitgadget

