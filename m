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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B61C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9FE64F14
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhBYKTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 05:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhBYKPu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 05:15:50 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9158FC061786
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:15:21 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id n10so3463092pgl.10
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QgXC+MSjg9bLRuLsvhJVEv/uCeJdXVaXTlChRpyPN/g=;
        b=LxqOfjoOY7Q1Wrb95q/ZoJQlB93PF6I8hvvojO2Yc9GXFcnShDsMhUfx6N59FPmJ7a
         1gVxu4ufRGZljqp+3e1tOHvieQVOZFRO8N3GTDpPgt4xceVg7wo5QHkF5ju77y/rwWpS
         nJBAe1LKQNVCWUrjhSXC1NZZ15wdyNHqOLBMIM6vBCBdpq5iMsQNHPzPZSK/8Vmjc0uD
         N/zxUnbIOnwgyKn5b/xn93J65BKqKsZSpd0pxyDn4FRyIRQtwBqfs79cy0Rj0Fjm7QTG
         7xgqnP7mdVUCyrcmyAnPjPIIvXkMCVYqffU5FCNEBzYAllQRfFaOPjYf9gf9Y9hZ6FlP
         lGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgXC+MSjg9bLRuLsvhJVEv/uCeJdXVaXTlChRpyPN/g=;
        b=si4ycXZu75ZhTcR5TQw/Y9spWxv2o3FYAWr3zRnGJam7jZs3ha3j2Sw7nAFYYir8mI
         wokUrO+276UyQjP0Swkv19eL7GG6GvsmMPFbbNypKlifkgHBs3Rx/wq4FCfbbtmJUO2l
         yDyjGJdwKgWnF0eTEeMPMUIxXjZxpLiABTNk/ywaJ338ZFo6/loDrhOIOv1mvxOmq9c3
         IBMqj8toqtYiAaToDDy3sPAlhYTz0H/nFJRq5XjT4wZFosO7YjtDhkL0wqW1HFPXL2pF
         PLbPzpPbxzOJS0hCbZidf6W/6J32hdeimS2vfFTAQdI5ksLsMxcsvXTLIYHbyIfGO5x7
         IJkQ==
X-Gm-Message-State: AOAM530HZmIFEuhjO8XWRA6FZzNL2ygwYqzRUEgVaHGupT4pxXQ8BCAy
        NkFhpmKJ3kVNK01Pc9XTBvVlfyJkiTj/Jw==
X-Google-Smtp-Source: ABdhPJzd4GGZ2XZFBkVtjaBGiHMLMhxU3SL78eRIoQytutW7aReWxWpgX9Tu5qxST/qyPNz00/LROA==
X-Received: by 2002:a62:8686:0:b029:1ed:7a8b:4933 with SMTP id x128-20020a6286860000b02901ed7a8b4933mr2678558pfd.9.1614248120840;
        Thu, 25 Feb 2021 02:15:20 -0800 (PST)
Received: from localhost.localdomain ([223.233.90.42])
        by smtp.googlemail.com with ESMTPSA id 67sm5941188pfb.43.2021.02.25.02.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:15:20 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/6] commit: add amend suboption to --fixup to create amend! commit
Date:   Thu, 25 Feb 2021 15:38:56 +0530
Message-Id: <20210225100855.25530-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217072904.16257-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
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

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 builtin/commit.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956..56ae15a762 100644
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
@@ -745,15 +761,24 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
-		if (have_option_m)
-			strbuf_addbuf(&sb, &message);
+		format_commit_message(commit, fmt, &sb, &ctx);
+		free(fmt);
 		hook_arg1 = "message";
+
+		if ((have_option_m) && !strcmp(fixup_prefix,"fixup"))
+			strbuf_addbuf(&sb, &message);
+
+		if (!strcmp(fixup_prefix,"amend")) {
+			if (have_option_m)
+				die(_("cannot combine -m with --fixup:%s"), fixup_message);
+			else
+				prepare_amend_commit(commit, &sb, &ctx);
+		}
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
 		size_t merge_msg_start;
 
@@ -1152,6 +1177,12 @@ static void finalize_deferred_config(struct wt_status *s)
 		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
 }
 
+/* returns the length of intial segment of alpha characters only */
+static size_t get_alpha_len(char *fixup_message) {
+	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
+	return strspn(fixup_message, alphas);
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const struct option *options,
 				      const char * const usage[],
@@ -1170,7 +1201,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die(_("Using both --reset-author and --author does not make sense"));
 
-	if (logfile || have_option_m || use_message || fixup_message)
+	if (logfile || have_option_m || use_message)
 		use_editor = 0;
 	if (0 <= edit_flag)
 		use_editor = edit_flag;
@@ -1227,6 +1258,28 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
+
+	if (fixup_message) {
+		/*
+		 * As `amend` suboption contains only alpha
+		 * character. So check if first non alpha
+		 * character in fixup_message is ':'.
+		 */
+		size_t len = get_alpha_len(fixup_message);
+		if (len && fixup_message[len] == ':') {
+			fixup_message[len] = '\0';
+			fixup_commit = fixup_message + ++len;
+			if (starts_with("amend", fixup_message))
+				fixup_prefix = "amend";
+			else
+				die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
+		} else {
+			fixup_commit = fixup_message;
+			fixup_prefix = "fixup";
+			use_editor = 0;
+		}
+	}
+
 	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
 
 	handle_untracked_files_arg(s);
@@ -1504,7 +1557,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1663,6 +1721,19 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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

