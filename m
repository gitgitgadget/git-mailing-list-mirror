Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6AA1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 16:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGEQ4t (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 12:56:49 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41323 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfGEQ4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 12:56:49 -0400
Received: by mail-ua1-f67.google.com with SMTP id 34so2426327uar.8
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVTakQsd/wqA3ZxRB0nFxqFyxkGz1a7sQL8PcgPcHiQ=;
        b=bfIDa+xW0bwZSfzSFHSsKAyeGj08No3ZskEtRHNJanOFihnz/X7oJD+lVHk+wiaXHw
         h2yzskrGp8xVERAx77mNXe72RVBnspdeWfiXSnAkErwrkYzjvtdox7T5a9ZSG9SEyJOS
         HWU2rE+7ayR4NEeJ1pexncW3y8nnaIl7crdGvbDNSPeLFLsCq2MUURnh4JFL11dIUu08
         Qb0jpacDNTCUFUuoZGTb10J56NMHZqGeEmixHHjl6iSirHByyJC0SG24PhRDPI+OU/rY
         Pgu44D0mHkpj4W7HIt4IzY7oPmuGszMocfDpeZKN1JidazGs+M4ETgjlwX3ko4LQzPj/
         A2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVTakQsd/wqA3ZxRB0nFxqFyxkGz1a7sQL8PcgPcHiQ=;
        b=YN4KaGdX7klNYSPxHuKQz9EzdbnhTeRlrUtWWUdWcZ5A5CQ8qA/Rnr5kVLw3S/3BIA
         NOFa9RoAmaXeVyJKWDC3qV/f7FH6xwedRCAYaObwUmQIk1S603OVTM05H5900x2Jwqfe
         tSmacpcXVu/HYiJYNlVeeQdArXaP0hJgDVZjAZZXzYqr55U7/NMnbCgoeGQ3mo3sGfKO
         s/0IrVViS4ZpdOzFvC8KYZ7mzpFYlCJGjiyARU+0jXrNOEmv/jS0TxkMp1O5UafOTnTa
         EMdIG40iR37APxIQSFaDknmk8dGpt7GX/JVCZFtfgVr3BhzSDx/L66y7g5Ta2et9CEnj
         eHag==
X-Gm-Message-State: APjAAAWuY555H9nla26/CDUpj7MfD5mfZQNiFLG+vzAeDFLwuSXtvCwO
        CCheNnxfzc8bszzSFIyih6wdTCvWQO0=
X-Google-Smtp-Source: APXvYqx1sbFKw4tEWQ/XZQ0iLWgn7LxL5ylIA+evh811RUDnwvvIHwgxP7d3GjBCzJj4gt8+EAq97A==
X-Received: by 2002:ab0:73d9:: with SMTP id m25mr2663728uaq.115.1562345807642;
        Fri, 05 Jul 2019 09:56:47 -0700 (PDT)
Received: from linuxerio.hitronhub.home ([186.32.195.224])
        by smtp.gmail.com with ESMTPSA id n187sm5460798vkd.9.2019.07.05.09.56.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:56:47 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [RFC/PATCH v1] merge - make squash a 1-step operation
Date:   Fri,  5 Jul 2019 10:56:24 -0600
Message-Id: <20190705165624.22243-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/merge.c | 63 +++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6e99aead46..d5745a7888 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -64,6 +64,7 @@ static int option_edit = -1;
 static int allow_trivial = 1, have_message, verify_signatures;
 static int overwrite_ignore = 1;
 static struct strbuf merge_msg = STRBUF_INIT;
+static struct strbuf squash_msg = STRBUF_INIT;
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char **xopts;
@@ -390,12 +391,9 @@ static void finish_up_to_date(const char *msg)
 static void squash_message(struct commit *commit, struct commit_list *remoteheads)
 {
 	struct rev_info rev;
-	struct strbuf out = STRBUF_INIT;
 	struct commit_list *j;
 	struct pretty_print_context ctx = {0};
 
-	printf(_("Squash commit -- not updating HEAD\n"));
-
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.ignore_merges = 1;
 	rev.commit_format = CMIT_FMT_MEDIUM;
@@ -414,15 +412,13 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 	ctx.date_mode = rev.date_mode;
 	ctx.fmt = rev.commit_format;
 
-	strbuf_addstr(&out, "Squashed commit of the following:\n");
+	strbuf_addstr(&squash_msg, "Squashed commit of the following:\n");
 	while ((commit = get_revision(&rev)) != NULL) {
-		strbuf_addch(&out, '\n');
-		strbuf_addf(&out, "commit %s\n",
+		strbuf_addch(&squash_msg, '\n');
+		strbuf_addf(&squash_msg, "commit %s\n",
 			oid_to_hex(&commit->object.oid));
-		pretty_print_commit(&ctx, commit, &out);
+		pretty_print_commit(&ctx, commit, &squash_msg);
 	}
-	write_file_buf(git_path_squash_msg(the_repository), out.buf, out.len);
-	strbuf_release(&out);
 }
 
 static void finish(struct commit *head_commit,
@@ -440,8 +436,12 @@ static void finish(struct commit *head_commit,
 		strbuf_addf(&reflog_message, "%s: %s",
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
-	if (squash) {
+	if (squash && !squash_msg.len) {
+		// message hasn't been calculated, that means we are stopping the squash process so the user can finish it
 		squash_message(head_commit, remoteheads);
+		write_file_buf(git_path_squash_msg(the_repository), squash_msg.buf, squash_msg.len);
+		if (option_commit > 0)
+			printf(_("Squash conflicts -- not updating HEAD\n"));
 	} else {
 		if (verbosity >= 0 && !merge_msg.len)
 			printf(_("No merge message -- not updating HEAD\n"));
@@ -893,13 +893,21 @@ static int finish_automerge(struct commit *head,
 	struct object_id result_commit;
 
 	free_commit_list(common);
-	parents = remoteheads;
-	if (!head_subsumed || fast_forward == FF_NO)
-		commit_list_insert(head, &parents);
-	prepare_to_commit(remoteheads);
-	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
-			&result_commit, NULL, sign_commit))
-		die(_("failed to write commit object"));
+	if (squash) {
+		squash_message(head, remoteheads);
+		parents = commit_list_insert(head, &parents);
+		if (commit_tree(squash_msg.buf, squash_msg.len, result_tree, parents,
+				&result_commit, NULL, sign_commit))
+			die(_("failed to write commit object on squash"));
+	} else {
+		parents = remoteheads;
+		if (!head_subsumed || fast_forward == FF_NO)
+			commit_list_insert(head, &parents);
+		prepare_to_commit(remoteheads);
+		if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
+				&result_commit, NULL, sign_commit))
+			die(_("failed to write commit object"));
+	}
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, remoteheads, &result_commit, buf.buf);
 	strbuf_release(&buf);
@@ -1342,18 +1350,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (verbosity < 0)
 		show_diffstat = 0;
 
-	if (squash) {
-		if (fast_forward == FF_NO)
-			die(_("You cannot combine --squash with --no-ff."));
-		if (option_commit > 0)
-			die(_("You cannot combine --squash with --commit."));
-		/*
-		 * squash can now silently disable option_commit - this is not
-		 * a problem as it is only overriding the default, not a user
-		 * supplied option.
-		 */
-		option_commit = 0;
-	}
+	if (squash && fast_forward == FF_NO)
+		die(_("You cannot combine --squash with --no-ff."));
 
 	if (option_commit < 0)
 		option_commit = 1;
@@ -1682,8 +1680,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		write_merge_state(remoteheads);
 
 	if (merge_was_ok)
-		fprintf(stderr, _("Automatic merge went well; "
-			"stopped before committing as requested\n"));
+		if (!option_commit)
+			fprintf(stderr, _("Automatic merge went well; "
+				"stopped before committing as requested\n"));
+		else
+			;
 	else
 		ret = suggest_conflicts();
 
-- 
2.22.0.214.g8dca754b1e.dirty

