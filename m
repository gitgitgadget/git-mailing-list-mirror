Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABF5C77B71
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjDUO6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 10:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjDUO6E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 10:58:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E9118EF
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:58:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2f55ffdbaedso1186074f8f.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682089079; x=1684681079;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOHV7xLXKCixg+Ul8Td3mK6ALffVlYyXoWTiaCQQRgc=;
        b=XfhQ8KxedBOE/f51VjZQdUloXUXJET+aN9fi043zJnNqWEne+xsrKYzFcF4r8h6Nbo
         SkRlkNKsCMkHTnn0diMPYtB5fSBRt8YkMACykERDs0Nww+cKeo2bB2if7iQgWXJrG11M
         l6qi8K8ax5hsX91D4DNtEoWO9kgyQbiB4KTN25ZJLRPS1iAG8Bv3MYgrlFWftfp1XVs+
         SxFrunxgAJidjy6NPbL8kU0HiQVbCLQ4Y6Gq7XkGjVbTKyj0jAkykAF+/Xi5R0VWgLlP
         XSxhP+E77xBnCi0XRy7M/lvZqsLLlKDTYuQN7MSBdSs3nIvBIMh1rZ+cxXx6niWmr204
         XQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089079; x=1684681079;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOHV7xLXKCixg+Ul8Td3mK6ALffVlYyXoWTiaCQQRgc=;
        b=lYmzd63wfZwklZxwQQTa2WVUeRj+AAEe3RZELM+1S/ijFCTzimG4uz0zincWCDqntt
         ZKK/jBX3fYr6aDIYjcnTdgGRUu++PSZvlbwyACqMDQImQ4bccRrMQBO+tKka6uVZFL52
         HLu3NJLR41SHW0UdF1kO5bpxdEteevQ1deBkWEcslNXofsbOV+60k5EdSDUs0OVvt+i9
         Ah1a1Bi0595f7xOioAZhU4NdzxJ/gJmiBw+MoLLDbT+dEnSPLqVyrNzSk0NG+bbGmXK0
         vq5/KapBbulnKEGqDyot+jrenBdp/Y6+5NlsCu5Qru5sjS2s7RyugPfXXjYf2ersy45K
         OR5w==
X-Gm-Message-State: AAQBX9fXW6l+x5k4ly595Dn1jEtf9OUHh8Nh8qJnq38McgmMQTC25fXC
        wlKcQa9d/maVcvlaFxzjkPpMg1Ei3+E=
X-Google-Smtp-Source: AKy350aHQse4Fm2i7kY+4mdUGKhwYD5OWUSPe8CPb49dh1SKXpQCTSIx3l9qyXiLDLt5ZYBtPOp1UQ==
X-Received: by 2002:a5d:4d06:0:b0:2e5:d4f4:c43b with SMTP id z6-20020a5d4d06000000b002e5d4f4c43bmr4655587wrt.55.1682089078801;
        Fri, 21 Apr 2023 07:57:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c181000b003f046ad52efsm8325963wmp.31.2023.04.21.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:57:58 -0700 (PDT)
Message-Id: <31bb644e769a085bd2db97cdb5aae78729efc52d.1682089075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 14:57:51 +0000
Subject: [PATCH v2 3/6] sequencer: factor out part of pick_commits()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This is simplifies a change in a later commit. If a pick fails we now
return the error at then end of the loop body rather than returning
early but there is no change in behavior.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 129 ++++++++++++++++++++++++++++------------------------
 1 file changed, 69 insertions(+), 60 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c4a548f2c98..2d463818dd1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4628,6 +4628,72 @@ N_("Could not execute the todo command\n"
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
@@ -4683,66 +4749,9 @@ static int pick_commits(struct repository *r,
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
-- 
gitgitgadget

