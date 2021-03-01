Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1E8C433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1032964DE0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhCAIsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhCAIrh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 03:47:37 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1499AC0617AB
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 00:46:39 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q20so11002808pfu.8
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 00:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=rjgN7dEMQC5aY5MliYWkSP66M4/Ow+a2V2KayVbmRXE=;
        b=JwA5OHSUgR9WSEQ/UDIt28+PxtzfjZBKqV5QpP4dhFNExvR9QMGbUB1q0Aa9Efys/c
         ntoJgaa7PWGWosZYdQbePQ0Si/rceir5h+NSNPwXAQPss6nvjFkA4yntdPkGcgl+6zxn
         pnuKtngLV177LHWvUgAnlEp9t+DShC+zk5av/EZSDEZELffy5KD6naPAxqGjmhaLnLQu
         KX4PWnewiSFh8wTVr2/0MhAzbnh9LNTaTNG0Iq3+bPp+lNQ2EL8vZ3sQfAFbspF2eHs3
         cqQ+1JsSPeQ7dIXtrTOhGYLUw2HxflJr/Bxvu/zH+iiBQ86BgCIO7+zwbYdAyT+y/cqH
         VvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=rjgN7dEMQC5aY5MliYWkSP66M4/Ow+a2V2KayVbmRXE=;
        b=rMHUq129JDVRB5PEBN8CycT/mAkZ2vKTqeBYwlkKGOqmAUoHZXJGqxVMQtFBVhAu8F
         6oU1+3ncW9+JmTi5wqTdy8EhmdK4ZSWN/xKFFP3UF6b1PVdC3j0EIsbyJofilIeaKAa4
         1oKGv1oCmihtiWfcORzgoqfTQIqaLl8kT+PeAMNKbqCU1hgWty+bTMp+CFcS8uW3/RWj
         sq22DHpvRvuwxOBHF7FhIwFKtwBtFw2xx3mr23BrbsxAPSVKg4n6R+KAsCiXuB62GYSJ
         PAkXMzowe/FPPgDZb58rCeMM+tPLlQEAlYxlzNtFwNwAWKmNIOQEA/Gu6UB8A8nqyjUZ
         FhRg==
X-Gm-Message-State: AOAM531w70n7w3LDBP8BxukYOCm1me6jm/VwjQ30HtiGh9EA5YhqKFu/
        UtvuulcQwmidTwPUFOJXRXts6lrKeUXvCw==
X-Google-Smtp-Source: ABdhPJwjp1EL1bmBo7Dc9ATqDX3xPNj5bYX0EDGnReCbrvXH01OxLHUmriU5UflUXh0K8knqN6hOhw==
X-Received: by 2002:a63:fa07:: with SMTP id y7mr13012915pgh.213.1614588397452;
        Mon, 01 Mar 2021 00:46:37 -0800 (PST)
Received: from localhost.localdomain ([2405:204:302d:d8af:c047:a272:aff7:4de6])
        by smtp.googlemail.com with ESMTPSA id b34sm16781426pgl.63.2021.03.01.00.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 00:46:37 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 2/6] commit: add amend suboption to --fixup to create amend! commit
Date:   Mon,  1 Mar 2021 14:15:10 +0530
Message-Id: <20210301084512.27170-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
Reply-To: 20210217072904.16257-1-charvi077@gmail.com
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

In order to prevent rebase from creating commits with an empty
message we refuse to create an "amend!" commit if commit message
body is empty.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 builtin/commit.c | 97 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956..200ef83cc0 100644
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
+								 struct pretty_print_context *ctx) {
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
@@ -745,15 +761,33 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
+		/*
+		 * Only `-m` commit message option is checked here, as
+		 * it supports `--fixup` to append the commit message.
+		 *
+		 * The other commit message options `-c`/`-C`/`-F` are
+		 * incompatible with all the forms of `--fixup` and
+		 * have already errored out while parsing the `git commit`
+		 * options.
+		 */
+		if (have_option_m && !strcmp(fixup_prefix, "fixup"))
+			strbuf_addbuf(&sb, &message);
+
+		if (!strcmp(fixup_prefix, "amend")) {
+			if (have_option_m)
+				die(_("cannot combine -m with --fixup:%s"), fixup_message);
+			else
+				prepare_amend_commit(commit, &sb, &ctx);
+		}
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
 		size_t merge_msg_start;

@@ -1152,6 +1186,12 @@ static void finalize_deferred_config(struct wt_status *s)
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
@@ -1170,7 +1210,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die(_("Using both --reset-author and --author does not make sense"));

-	if (logfile || have_option_m || use_message || fixup_message)
+	if (logfile || have_option_m || use_message)
 		use_editor = 0;
 	if (0 <= edit_flag)
 		use_editor = edit_flag;
@@ -1227,6 +1267,28 @@ static int parse_and_validate_options(int argc, const char *argv[],

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
+			fixup_message[len++] = '\0';
+			fixup_commit = fixup_message + len;
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
@@ -1504,7 +1566,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('m', "message", &message, N_("message"), N_("commit message"), opt_parse_m),
 		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
 		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
-		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
+		/*
+		 * TRANSLATORS: Leave "[amend:]" as-is, and
+		 * only translate <commit>.
+		 */
+		OPT_STRING(0, "fixup", &fixup_message, N_("[amend:]commit"), N_("use autosquash formatted message to fixup or amend specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
@@ -1663,6 +1729,19 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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

