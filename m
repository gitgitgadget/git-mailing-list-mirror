Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C954420248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfCKDmr (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:42:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43307 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCKDmr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:42:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so2677158pfh.10
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 20:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kwq4bRCS12E0pwS24n4DF6fH8vCgV1gHSX9jQZdeS6s=;
        b=YrbNdNeLt89h1Yz6weE66wRvwrbhZnMRAn68ewwrifOj1feyzsk/YlDHDI6Ex6naVz
         xIMFKs402OahErhm2bM4YqI9qB2/q9FYWuIRU5Shtn+DJ2/JC16wtlovwkPB2F4vJZa8
         FgBt5heeMox6b6gxBTNYk6wGkvlQuFnQqV6uB/m6TqucRJ2ujnmvTzuUpgH0/zRcDemy
         o687zwA37dObz1H6vqFgNdclpYp1FSCT7eWPvn1OJRFcMNEMLnnkvs4sC51M2ENWVYGr
         mICHSwZTdAhdO+TjtSjBOcF91gkBE0FZ3pp4f3N9LQnEHkL0Mc7lU/o9TIcyD36cTkHY
         lixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwq4bRCS12E0pwS24n4DF6fH8vCgV1gHSX9jQZdeS6s=;
        b=dtEfwBFDo5bDeQm0JhEO59xw/T31fyKZWoJlL0HSv1IKfHhQLkQhdWo2LyGmAhKGBG
         8AVw1ZfoIL3zs6SV+0sz693aJTOZ8eNs/j3YyaLjw5PtZapPWHi6/QpTdN/cjeItG/VP
         SjO3wgS9lNOUHIeLC1A/+gHVlp4kOz/dTAvziS7IdkyZNwnXwEYM2gsDJLONqEA5BBan
         w15xlHA4eQVusFJ00depK1c2ZoAZAm0c1O+KGEqS09zI3AMK5C6CHX35i/PIpEVgROkP
         Av2R7Vm4vXIvlzxgTgX13XbRZnybopZbp7eeJQOOl6+sANZMwDLeDTR3NHM9VNq0s85o
         p3wQ==
X-Gm-Message-State: APjAAAVN3UF33TYqkRMIlgQ9+2NBBdn3DHlwNX7dobnK2mjNg67J+cdS
        o8x8/tgg6DCbfrmsbdsBb/+6887B
X-Google-Smtp-Source: APXvYqyxjivgvv73zW96VtSZxI22yvnDHc7cCN4ASChPKXooXyPhPA/WIc/rEhioFDy7noCqRiA47w==
X-Received: by 2002:a62:1752:: with SMTP id 79mr30867645pfx.127.1552275765952;
        Sun, 10 Mar 2019 20:42:45 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id v7sm6371764pga.50.2019.03.10.20.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 20:42:45 -0700 (PDT)
Date:   Sun, 10 Mar 2019 20:42:43 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 6/8] merge: add scissors line on merge conflict
Message-ID: <b6aca21639eb96b65f201f4a3526d8d4a4180c59.1552275703.git.liu.denton@gmail.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
 <cover.1552275703.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552275703.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
commit.cleanup = scissors.

Next, if commit.cleanup = scissors is specified, don't produce a
scissors line in commit if one already exists in the MERGE_MSG file.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/merge-options.txt |  4 ++-
 builtin/commit.c                | 20 ++++++++++----
 builtin/merge.c                 | 14 ++++++++++
 t/t7600-merge.sh                | 46 +++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 646100ea9a..c7b889d6f5 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -35,7 +35,9 @@ set to `no` at the beginning of them.
 --cleanup=<mode>::
 	This option determines how the merge message will be cleaned up
 	before commiting or being passed on. See linkgit:git-commit[1] for more
-	details.
+	details. In addition, if the '<mode>' is given a value of `scissors`,
+	scissors will be appended to MERGE_MSG before being passed on in the
+	case of a merge conflict.
 
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
diff --git a/builtin/commit.c b/builtin/commit.c
index 81e3bd21ca..d8c4626a68 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -668,6 +668,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
+	int merge_contains_scissors = 0;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -728,6 +729,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
+		size_t merge_msg_start;
+
 		/*
 		 * prepend SQUASH_MSG here if it exists and a
 		 * "merge --squash" was originally performed
@@ -738,8 +741,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			hook_arg1 = "squash";
 		} else
 			hook_arg1 = "merge";
+
+		merge_msg_start = sb.len;
 		if (strbuf_read_file(&sb, git_path_merge_msg(the_repository), 0) < 0)
 			die_errno(_("could not read MERGE_MSG"));
+
+		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+		    wt_status_locate_end(sb.buf + merge_msg_start, sb.len - merge_msg_start) < sb.len - merge_msg_start)
+			merge_contains_scissors = 1;
 	} else if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
@@ -807,7 +816,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 
 		if (whence != FROM_COMMIT) {
-			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+				!merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 			    whence == FROM_MERGE
@@ -832,10 +842,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				_("Please enter the commit message for your changes."
 				  " Lines starting\nwith '%c' will be ignored, and an empty"
 				  " message aborts the commit.\n"), comment_line_char);
-		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
-			 whence == FROM_COMMIT)
-			wt_status_add_cut_line(s->fp);
-		else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
+		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
+			if (whence == FROM_COMMIT && !merge_contains_scissors)
+				wt_status_add_cut_line(s->fp);
+		} else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL,
 				_("Please enter the commit message for your changes."
 				  " Lines starting\n"
diff --git a/builtin/merge.c b/builtin/merge.c
index 4f5fcf5ce9..b620d4bfcb 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -916,6 +916,20 @@ static int suggest_conflicts(void)
 	filename = git_path_merge_msg(the_repository);
 	fp = xfopen(filename, "a");
 
+	/*
+	 * We can't use cleanup_mode because if we're not using the editor,
+	 * get_cleanup_mode will return COMMIT_MSG_CLEANUP_SPACE instead, even
+	 * though the message is meant to be processed later by git-commit.
+	 * Thus, we will get the cleanup mode which is returned when we _are_ using
+	 * an editor.
+	 */
+	if (get_cleanup_mode(cleanup_arg, 1, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
+	    fputc('\n', fp);
+	    wt_status_add_cut_line(fp);
+	    /* comments out the newline from append_conflicts_hint */
+	    fputc(comment_line_char, fp);
+	}
+
 	append_conflicts_hint(&the_index, &msgbuf);
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index d879efd330..2cb57e5878 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -246,6 +246,52 @@ test_expect_success 'merge --squash c3 with c7' '
 	test_cmp expect actual
 '
 
+test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
+	git config commit.cleanup scissors &&
+	git reset --hard c3 &&
+	test_must_fail git merge c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	cat >expect <<-EOF &&
+		Merge tag '"'"'c7'"'"'
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	file
+		EOF
+	git cat-file commit HEAD >tmp &&
+	sed -e '1,/^$/d' <tmp >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
+	git config commit.cleanup scissors &&
+	git reset --hard c3 &&
+	test_must_fail git merge --squash c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	cat >expect <<-EOF &&
+		Squashed commit of the following:
+
+		$(git show -s c7)
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	file
+		EOF
+	git cat-file commit HEAD >tmp &&
+	sed -e '1,/^$/d' <tmp >actual &&
+	test_i18ncmp expect actual
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 and c3' '
-- 
2.21.0.370.g4fdb13b891

