Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBE1C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B74364E04
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhBQHkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 02:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhBQHjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 02:39:09 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368F7C061756
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:38:29 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y25so4597625pfp.5
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCeysdYFcKApsTs7i0G/8/tb7Y+2EXaW4/LSodJN3Uo=;
        b=ZAHSAj7sdrsbuSrtzRx0QhMGRIFiyJPi4xxOOunWAEEELcDBnyLZ/P0YhNRDSh//0w
         MhAlEtNC8JBoQN44LTRSdYu16caNUlA21tqv84IcqWQR1HbwKL+xVyLiEp/8dT+d95gZ
         pWQ3baaZ63K4nw+OIa+RovEjNMs6jZU+5k37ai3CLTxlYyq6SLAzxEuPWLrSMFmNZXDI
         Vq1uAZla/XQxvVEg89bvWDnpBKiCghjXwUf6fcN19+CDFfORL+LsCzldROJhd/xT+yQJ
         lVBQIIeeWXam3+qUjT1JbZ/KE/vCshnhPvc1HlQzXoLW9/fx/9798wn086vxJsbRQfw4
         LRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCeysdYFcKApsTs7i0G/8/tb7Y+2EXaW4/LSodJN3Uo=;
        b=q0IoABMCRjP+7Kp0LJGUP4zWZSZe99aiEaD72B7MEdXLnA5+W2ZwMpjD0IjsYCtjUA
         dg0EAJlMARjt8Bcr3jNGac8vtq10G8QEcjCr0nmmV+dWKXqgsdWPxi42HTDUeUUkp166
         SOmY/8hOUBYZyDZnJfZv0nQHjGfCOiprww8QKhUaPL4t06OQnjJfwLDe2+jo7h+HfVQb
         NSfmVb3zvAlbL42ziMejgPPIw5aPkdaSWoYd6c8BohaVaMRDh6gx2wy54bkMSJ6c7L1j
         2aIk+gLIW/cdf9KW3jLg0sJ6oHPatv7Vp8IXWkMGETi/MnR0OhSNBjQp/rJ4djPrlBfW
         HUlw==
X-Gm-Message-State: AOAM533iQLQfOvv/fDK/+6pABTUgSSS0N/d9moPsXhhRYzIoYTBr5+qF
        RRbtRsvtsHRSvdLSUZoByz4Md/A1yms+pQ==
X-Google-Smtp-Source: ABdhPJzBHHgpaI8dvgFvvxiSIvWbiU9Gh5yHnyh3BZVW29DoE7VrsIMiHPltGj7vaa4SJ9t0OP2Ptw==
X-Received: by 2002:a62:14cb:0:b029:1d1:f512:f686 with SMTP id 194-20020a6214cb0000b02901d1f512f686mr22873414pfu.11.1613547508513;
        Tue, 16 Feb 2021 23:38:28 -0800 (PST)
Received: from localhost.localdomain ([106.201.18.198])
        by smtp.googlemail.com with ESMTPSA id b3sm1352615pgd.48.2021.02.16.23.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 23:38:28 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/6] commit: add amend suboption to --fixup to create amend! commit
Date:   Wed, 17 Feb 2021 13:07:21 +0530
Message-Id: <20210217073725.16656-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217073725.16656-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
 <20210217073725.16656-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git commit --fixup=amend:<commit>` will create an "amend!" commit.
The resulting commit message subject will be "amend! ..." where
"..." is the subject line of <commit> and the initial message
body will be <commit>'s message. -m can be used to override the
message body.

The "amend!" commit when rebased with --autosquash will fixup the
contents and replace the commit message of <commit> with the
"amend!" commit's message body.

Inorder to prevent rebase from creating commits with an empty
message we refuse to create an "amend!" commit if commit message
body is empty.

Example usage:
$ git commit --fixup=amend:HEAD
$ git commit --fixup=amend:HEAD -m "clever commit message"

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 builtin/commit.c | 76 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956..f2c5ad2e62 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -105,7 +105,8 @@ static const char *template_file;
  */
 static const char *author_message, *author_message_buffer;
 static char *edit_message, *use_message;
-static char *fixup_message, *squash_message;
+static char *fixup_message, *fixup_commit, *squash_message;
+static const char *fixup_prefix;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
@@ -681,6 +682,21 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	comment_line_char = *p;
 }
 
+static int prepare_amend_commit(struct commit *commit, struct strbuf *sb,
+								struct pretty_print_context *ctx) {
+	/*
+	 * If we amend the 'amend!' commit then we don't want to
+	 * duplicate the subject line.
+	 */
+	const char *format = NULL;
+	if (starts_with(sb->buf, "amend! amend!"))
+		format = "%b";
+	else
+		format = "%B";
+	format_commit_message(commit, format, sb, ctx);
+	return 0;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -745,15 +761,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	} else if (fixup_message) {
 		struct pretty_print_context ctx = {0};
 		struct commit *commit;
-		commit = lookup_commit_reference_by_name(fixup_message);
+		char *fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
+		commit = lookup_commit_reference_by_name(fixup_commit);
 		if (!commit)
-			die(_("could not lookup commit %s"), fixup_message);
+			die(_("could not lookup commit %s"), fixup_commit);
 		ctx.output_encoding = get_commit_output_encoding();
-		format_commit_message(commit, "fixup! %s\n\n",
-				      &sb, &ctx);
+		format_commit_message(commit, fmt, &sb, &ctx);
+		free(fmt);
+		hook_arg1 = "message";
 		if (have_option_m)
 			strbuf_addbuf(&sb, &message);
-		hook_arg1 = "message";
+		else if (!strcmp(fixup_prefix,"amend"))
+			prepare_amend_commit(commit, &sb, &ctx);
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
 		size_t merge_msg_start;
 
@@ -1170,7 +1189,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die(_("Using both --reset-author and --author does not make sense"));
 
-	if (logfile || have_option_m || use_message || fixup_message)
+	if (logfile || have_option_m || use_message)
 		use_editor = 0;
 	if (0 <= edit_flag)
 		use_editor = edit_flag;
@@ -1227,6 +1246,29 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
+
+	if (fixup_message) {
+		/*
+		 * check if ':' occurs before '^' or '@', otherwise
+		 * fixup_message is a commit reference.
+		 */
+		fixup_commit = strpbrk(fixup_message, "^@:");
+		if (fixup_commit && *fixup_commit == ':' &&
+		    fixup_commit != fixup_message) {
+			*fixup_commit = '\0';
+			if (starts_with("amend", fixup_message)) {
+				fixup_prefix = "amend";
+				fixup_commit++;
+			} else {
+				die(_("only amend option can be used with --fixup"));
+			}
+		} else {
+			fixup_commit = fixup_message;
+			fixup_prefix = "fixup";
+			use_editor = 0;
+		}
+	}
+
 	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
 
 	handle_untracked_files_arg(s);
@@ -1504,7 +1546,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('m', "message", &message, N_("message"), N_("commit message"), opt_parse_m),
 		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
 		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
-		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
+		/*
+		 * TRANSLATORS: please do not translate [amend:]
+		 * Here "amend" is an option to the --fixup command
+		 * line flag, that creates amend! commit.
+		 */
+		OPT_STRING(0, "fixup", &fixup_message, N_("[amend:]commit"), N_("use autosquash formatted message to fixup or amend specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
@@ -1663,6 +1710,19 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}
 
+	if (fixup_message && starts_with(sb.buf, "amend! ") &&
+		!allow_empty_message) {
+		struct strbuf body = STRBUF_INIT;
+		size_t len = subject_length(sb.buf);
+		strbuf_addstr(&body, sb.buf + len);
+		if (message_is_empty(&body, cleanup_mode)) {
+			rollback_index_files();
+			fprintf(stderr, _("Aborting commit due to empty commit message body.\n"));
+			exit(1);
+		}
+		strbuf_release(&body);
+	}
+
 	if (amend) {
 		const char *exclude_gpgsig[3] = { "gpgsig", "gpgsig-sha256", NULL };
 		extra = read_commit_extra_headers(current_head, exclude_gpgsig);
-- 
2.29.0.rc1

