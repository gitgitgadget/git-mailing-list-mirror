Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA38FC04FE0
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 15:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbjHAPXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 11:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjHAPXr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 11:23:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32942139
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 08:23:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe110de46dso36925535e9.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690903418; x=1691508218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOQ278Iqnpfoka+KcTOYBzz1IL5UZGsGFqgUJ1y9rYk=;
        b=dCNVru/v3kTXrJdHRShK3wAlYtGgWL4srzImkozqHRP5GbaXeDhUBhLy4m7uV2ZeZt
         hbc44FanhQ4LFRx0u1IgvhB5DnGMN2fpbpbX0Mw1XVqg1CDBZcbyg0F2goi5u8j+gvdq
         XzTqVg1IiKNyfL3loIP6kQp8jcBWlLFqipxa6S2nsiOWMnW2VnIN97tgzsHvV1x5A3wH
         kntr4pGxML7M+1FTnJ+u7WUvXvrs3LP/VG7Z6t5hyfWCLxNZCGh6ZCh001OJE1TSG2PW
         Sqmvg0KCmTpsbrnuNQRcd16AEHo48S/hxhOZqE2iFvGfOevdD3pCu7O+2hSuzgyHay6o
         jJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690903418; x=1691508218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOQ278Iqnpfoka+KcTOYBzz1IL5UZGsGFqgUJ1y9rYk=;
        b=KGi5iLkxNr4u2520YJu/3wyEOnaz1QdGGFIxutVPAtDqgI16UwBpKeD0GXMVeo+Qo+
         PjEqMBCQpGFOkUSeaXtMqDmTN6K49WsoEIVBVULK8TUIRTRsxaAyjgHyKXuN9gkJDbd+
         aEjgh2eLfMxtz0l4dXCkACCKG60Sm8KVmG+Fgte0W25pi476uEf4vwQjYdNjNTM82JHb
         UCROdNT5F6kPxnBo7LdGU7cYkDKLH+uiCZngvH/nfm8wHBvcqaoEjqp4TWOrxPGyTcIx
         rRMNSdGYDGIobnelJPaHJ2pqjB0gIZHNecY+pdUsT9VPs2tOHoi12Ti5T/moROxvJq0y
         aBPw==
X-Gm-Message-State: ABy/qLZh+3cxG1+pAGkX9MmVZ5kz8/asIdt+dlCYZErDSKF3SqjUyYMU
        XZTqUnj244NLBnvhhOzTMw4QQ8W3aJg=
X-Google-Smtp-Source: APBJJlEQRs2X8XnNxkJEVmSAU9E/JmtuV2tHW/Jwf6iGVG4h7hF0Fbuq6S6pQQX1KJSxHw/yPlGmVw==
X-Received: by 2002:a1c:cc08:0:b0:3fb:c9f4:150e with SMTP id h8-20020a1ccc08000000b003fbc9f4150emr2604370wmb.14.1690903417784;
        Tue, 01 Aug 2023 08:23:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f25-20020a1c6a19000000b003fe24da493dsm3979005wmc.41.2023.08.01.08.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:23:37 -0700 (PDT)
Message-ID: <a1fad70f4b920252d84b5b5578b1b9b0a7bba7ca.1690903412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Aug 2023 15:23:29 +0000
Subject: [PATCH v3 4/7] sequencer: factor out part of pick_commits()
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
index dbddd19b2c2..62277e7bcc1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4642,6 +4642,72 @@ N_("Could not execute the todo command\n"
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
@@ -4697,66 +4763,9 @@ static int pick_commits(struct repository *r,
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
@@ -4817,9 +4826,10 @@ static int pick_commits(struct repository *r,
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

