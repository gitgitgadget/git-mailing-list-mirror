Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827941F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 03:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbeKUNp6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 08:45:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39333 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeKUNp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 08:45:58 -0500
Received: by mail-io1-f65.google.com with SMTP id j18-v6so3014775iog.6
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 19:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J0L4Fh46WfdS/0CHXUV8uP/y77IG+nIGfpEdGjHtaqM=;
        b=fLMolSLIO+sdaJQgt4srYMO1w68avKD644qAGOFKv2u4znG/yhyfTWuS9vrXs2qaLz
         SBTk/ctrKF6GmwXELMsLMbMhtTGpSs+PxLFfyUEv0sNYefKQiXplb+OSQLejRXhHDiSC
         vg43fQYITQnMouxVBgnN0RPoE2cssgYI91+BVPIc7FVlRRv01JwD4p5Lrytspz7e7rh6
         pW3CT4hNGnYXj9WmWL+B6cgzizMUrmgWis83FNqy4YeDInA5PMauTyOrOxNFJrT2/pnx
         kGAsRMd3tUqwruUmBFhKRmn5CPWfP+36z+tkLNYEnPQM7h/2Hs/XCRahaI0SL4S04t3K
         E3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J0L4Fh46WfdS/0CHXUV8uP/y77IG+nIGfpEdGjHtaqM=;
        b=PMCoOfuz20HhPCuDc1FI45jzmBHLX9WwWONoQ7fEnoX0tDzdVYD2mGsac2pyufo8y2
         zwiGdGCWT9rmt2WylFVM/BI9PNX/8INmIPMP3qEA3eHscgmeV3kGYrAZrxK2NzmpJv15
         mFEcQ8+bzJnBpWScAtx93hrcXiBMcE61g2mAICjCjxdAiBiGK1HuvhXpgR9vffKodoMq
         vs9f0+ztskKoa7vTC9QdDtpquealNIL2AS7tvNQNE714Bc/h+OlMdHxQbGPGd795adQX
         6Dl9EMXctYMmExpttyqkqaC/SNCfiSYgV+2KZtPsdK2l2u3BM72buT5VnEGgfZauuTpm
         1Vfw==
X-Gm-Message-State: AA+aEWZVLPVtSrXat8oD5G/QkhKg3f3wIyDyyr50Qejw2v8xk35QbA80
        htxLfJtG4Foe9TqvO2DJOGWvu/60
X-Google-Smtp-Source: AFSGD/WjbRvvS/mHQJVessLIwq4reQykN5tlxjkQrgd0k/QnSiygs+IzRPWkCYjGbMz4P9ruOhNkBg==
X-Received: by 2002:a6b:c042:: with SMTP id q63-v6mr3543268iof.6.1542770009254;
        Tue, 20 Nov 2018 19:13:29 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id r65-v6sm14449959ita.8.2018.11.20.19.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 19:13:28 -0800 (PST)
Date:   Tue, 20 Nov 2018 22:13:26 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v4 2/2] merge: add scissors line on merge conflict
Message-ID: <d20751672c238e2f2f54f20c27bf01faa9455445.1542768902.git.liu.denton@gmail.com>
References: <cover.1542496915.git.liu.denton@gmail.com>
 <cover.1542768902.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542768902.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
merge.cleanup = scissors.

Next, if commit.cleanup = scissors is specified, don't produce a
scissors line in commit if one already exists in the MERGE_MSG file.

Finally, we give pull the passthrough option of --cleanup so that it
can also take advantage of this change.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/merge-options.txt |  6 +++++
 builtin/commit.c                | 20 ++++++++++----
 builtin/merge.c                 | 16 ++++++++++++
 builtin/pull.c                  |  6 +++++
 t/t7600-merge.sh                | 46 +++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 63a3fc0954..115e0ca6f0 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -27,6 +27,12 @@ they run `git merge`. To make it easier to adjust such scripts to the
 updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
 set to `no` at the beginning of them.
 
+--cleanup=<mode>::
+	This option determines how the merge message will be cleaned up
+	before being passed on. Specifically, if the '<mode>' is given a
+	value of `scissors`, scissors will be prepended to the message in
+	the case of a merge conflict. See also linkgit:git-commit[1].
+
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
 	pointer, without creating a merge commit.  This is the default
diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29e..7902645bc9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -659,6 +659,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
+	int merge_contains_scissors = 0;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -719,6 +720,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
+		size_t merge_msg_start;
+
 		/*
 		 * prepend SQUASH_MSG here if it exists and a
 		 * "merge --squash" was originally performed
@@ -729,8 +732,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -798,7 +807,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 
 		if (whence != FROM_COMMIT) {
-			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+				!merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 			    whence == FROM_MERGE
@@ -823,10 +833,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
index 8f4a5065c2..23a6e6bb93 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -36,6 +36,7 @@
 #include "packfile.h"
 #include "tag.h"
 #include "alias.h"
+#include "wt-status.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -96,6 +97,9 @@ enum ff_type {
 
 static enum ff_type fast_forward = FF_ALLOW;
 
+static const char *cleanup_arg;
+static int put_scissors;
+
 static int option_parse_message(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -243,6 +247,7 @@ static struct option builtin_merge_options[] = {
 		N_("perform a commit if the merge succeeds (default)")),
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
+	OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
 	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
 	OPT_SET_INT_F(0, "ff-only", &fast_forward,
 		      N_("abort if fast-forward is not possible"),
@@ -606,6 +611,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
+	else if (!strcmp(k, "commit.cleanup"))
+		return git_config_string(&cleanup_arg, k, v);
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
 	else if (!strcmp(k, "merge.ff")) {
@@ -894,6 +901,13 @@ static int suggest_conflicts(void)
 	filename = git_path_merge_msg(the_repository);
 	fp = xfopen(filename, "a");
 
+	if (put_scissors) {
+	    fputc('\n', fp);
+	    wt_status_add_cut_line(fp);
+	    /* comments out the newline from append_conflicts_hint */
+	    fputc(comment_line_char, fp);
+	}
+
 	append_conflicts_hint(&msgbuf);
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
@@ -1402,6 +1416,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (option_edit < 0)
 		option_edit = default_edit_option();
 
+	put_scissors = cleanup_arg && !strcmp(cleanup_arg, "scissors");
+
 	if (!use_strategies) {
 		if (!remoteheads)
 			; /* already up-to-date */
diff --git a/builtin/pull.c b/builtin/pull.c
index 681c127a07..88245bce0e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -95,6 +95,7 @@ static char *opt_signoff;
 static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
+static char *opt_cleanup;
 static char *opt_ff;
 static char *opt_verify_signatures;
 static int opt_autostash = -1;
@@ -162,6 +163,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
 		N_("edit message before committing"),
 		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "cleanup", &opt_cleanup, NULL,
+		N_("how to strip spaces and #comments from message"),
+		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
 		N_("allow fast-forward"),
 		PARSE_OPT_NOARG),
@@ -625,6 +629,8 @@ static int run_merge(void)
 		argv_array_push(&args, opt_commit);
 	if (opt_edit)
 		argv_array_push(&args, opt_edit);
+	if (opt_cleanup)
+		argv_array_push(&args, opt_cleanup);
 	if (opt_ff)
 		argv_array_push(&args, opt_ff);
 	if (opt_verify_signatures)
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
2.19.1

