Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34070211B9
	for <e@80x24.org>; Tue, 25 Dec 2018 13:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbeLYN4Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Dec 2018 08:56:25 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36472 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLYN4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Dec 2018 08:56:24 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so17821867itj.1
        for <git@vger.kernel.org>; Tue, 25 Dec 2018 05:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BV0PmdLoCBs8ZFd2/cIuPLmufbebmjFgE6Q/RFX2onQ=;
        b=pxXNuwt+yLxMnWXyN4rcjDfaF0pOGetQ89Eq6M99Fk0+IouGTu9Ynjx74XCJ1tXvT5
         3qHu+POdwj/0O6ghU3gun6zc5z5agr7NfdNTOfXSP0sVMrXt4AookX9eo/zxgxzkcM59
         yTMAn+WQatAQLoSA3cPhSI6eX3oz2QOq2sxbrW4fzSdJQoh6wk5/pIwUbWVH2mHmn76u
         i9FCWRozSRZpW0lAl2hgXxkkMRT9zlyJEWA3rISD/mEAqHul0eae/eqVbw1FxkX7dMkI
         KrfNbtyO+keLZqzt0gJsO4qen7RioAyhFlfy6iNcY/3JhEBo5V2Gil2BCTBzj8YgP5A9
         sClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BV0PmdLoCBs8ZFd2/cIuPLmufbebmjFgE6Q/RFX2onQ=;
        b=n/g2IlEQCKrwCj2oqLsopdqkTdgvyyeyz24fq2MHxB/CfSRRjfNxqbS4QSCXZ9qgso
         t6eKIouNHrjWxf/CleASFkNtkWZUPfDtIuXKCmlqhSRzeZHeJVSX2hlBzNXH2Ao8/pLe
         D7kDF8AujhAtsF9S+TS9qCik0k9ckE8aif/D68VHEQNCkxQ7ihC/llTgm1JN38Z2e7cB
         2ochs3s8wbvAYjyAyWkuepYy0aPhk/6hmiRVgHWHchC+C4GWbDtQwAwp4a1jG1S1SFeR
         sRaQVBYNUOx+N4r7P0uCY1d8PCoj573YMcx/LRhD3kmPSKMjy6fwKJl9flm+HsJfM7j8
         ZKDw==
X-Gm-Message-State: AA+aEWYeuTlq4nNk9ze24Db9ysekqYLwif3H3q1vvOq7hglqU1ZbohSK
        fcXxss+0Q3ScxtkXwbOK3pzcm/rC
X-Google-Smtp-Source: AFSGD/VqLPxTj5ClbXYpz21zA5zMpVm1Of/+0IvVjy32yzq0GGsk/DNOsHJvX7r1wHbirkLhTEy93Q==
X-Received: by 2002:a02:a484:: with SMTP id d4mr10475291jam.77.1545746182622;
        Tue, 25 Dec 2018 05:56:22 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [99.245.246.183])
        by smtp.gmail.com with ESMTPSA id 189sm11593699itw.33.2018.12.25.05.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Dec 2018 05:56:22 -0800 (PST)
Date:   Tue, 25 Dec 2018 08:56:20 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v5 4/4] merge: add scissors line on merge conflict
Message-ID: <a97b9f99baa9e2ed85972e2034f0676991f086f6.1545745331.git.liu.denton@gmail.com>
References: <cover.1542768902.git.liu.denton@gmail.com>
 <cover.1545745331.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545745331.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
index 22783651b6..c2a263ba74 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -30,7 +30,9 @@ set to `no` at the beginning of them.
 --cleanup=<mode>::
 	This option determines how the merge message will be cleaned up
 	before commiting or being passed on. See linkgit:git-commit[1] for more
-	details.
+	details. In addition, if the '<mode>' is given a value of `scissors`,
+	scissors will be prepended to MERGE_MSG before being passed on in the case
+	of a merge conflict.
 
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
diff --git a/builtin/commit.c b/builtin/commit.c
index 9eb745b7ce..7923282ebb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -665,6 +665,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
+	int merge_contains_scissors = 0;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -725,6 +726,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
+		size_t merge_msg_start;
+
 		/*
 		 * prepend SQUASH_MSG here if it exists and a
 		 * "merge --squash" was originally performed
@@ -735,8 +738,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -804,7 +813,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 
 		if (whence != FROM_COMMIT) {
-			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+				!merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 			    whence == FROM_MERGE
@@ -829,10 +839,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
index ab0db46ede..6514267efc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -912,6 +912,20 @@ static int suggest_conflicts(void)
 	filename = git_path_merge_msg(the_repository);
 	fp = xfopen(filename, "a");
 
+	/*
+	 * We can't use cleanup_mode because if we're not using the editor,
+	 * get_cleanup_mode will return COMMIT_MSG_CLEANUP_SPACE instead, even
+	 * though the message is meant to be processed later by git-commit.
+	 * Thus, we will get the cleanup mode is returned we _are_ using an
+	 * editor.
+	 */
+	if (get_cleanup_mode(cleanup_arg, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
+	    fputc('\n', fp);
+	    wt_status_add_cut_line(fp);
+	    /* comments out the newline from append_conflicts_hint */
+	    fputc(comment_line_char, fp);
+	}
+
 	append_conflicts_hint(&msgbuf);
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
2.20.1

