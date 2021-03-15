Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04665C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA7EB64E12
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCOHzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 03:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhCOHzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 03:55:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A651C061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:55:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q5so7319478pgk.5
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwBVxpUwvcL62qOfTH4glOtE+OzR4pOw4Ib02EySWsM=;
        b=Fr22CnD4A1pA8njSkMovrbRDAapHtV0IjPxgtmiBDPQLn1IkzPW2fg5Uez4DpQ0DVJ
         27wNjDkgoQXeLcoCeO4rK8LLXfVpO38Ktk6bDYd2QR+jfg9Ss7I1+t34jjC2AxCV3/qs
         dF5WCWekOacSn6t6PXm8zTpOyxQWVFMoHi/cgF/gCMDEepTjoOfhR+pA6OTleuXlKphq
         PSXzzLstKWgyjdNBp0DkxiNOHAvFXerCwjy3dE+nR4uIZWsci6tpbKvYi9790pSuOz9W
         5lhz61ts1FTEX4SjS5U+Hw11xrDQ/qJPVwjeLs8r4wR3ZxEhE88AeiLCMBp3MwqqHydQ
         T2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwBVxpUwvcL62qOfTH4glOtE+OzR4pOw4Ib02EySWsM=;
        b=NFPNcXfxWn6kL8xQ3LO7k7q+jueaZwimdr/dcpDmwWeLyr5QEaxY/zduZkgRxLigdd
         a2aE5l6PJsD42Bq9fovUjzpYSpD4e74fef/B9TIuZ2t4AjYVCd8oBqhc7uMoESs8wkC7
         eAdvGq1NkZlIZ7sMaUgFeAcoo2looaMfyS/2YbwqLvMRde+bi/Ngm3iPElECnlBIxN1t
         sQie6S/j0ekVuIlDXwx6NOYOR80uAmdv6c746KsKsEniQ9Of0bPU7DIr68GP9J5IJ6lG
         V0uUNCQzgaatAxJckI2tl6uSR+3jV8bzzjjD20TlFRk/PQXm6wEBM370+WtWmL5j6mJn
         UxMA==
X-Gm-Message-State: AOAM533LHap9aENcFb0SVj2IQal+rkgPSsaeoLPre0izUckvvv+VhphP
        fRu2XFayzyMWltNnouWRHJKj+uBB+xLVgg==
X-Google-Smtp-Source: ABdhPJyhZVk+yAEwaQoH4sEAsvx4J8YJBQKSTW6IZkUXpFft5Zmh4F3Xoy+qUxIFnIYxxOuRVkKHig==
X-Received: by 2002:aa7:9471:0:b029:1f2:3e6c:69e3 with SMTP id t17-20020aa794710000b02901f23e6c69e3mr23106952pfq.69.1615794939544;
        Mon, 15 Mar 2021 00:55:39 -0700 (PDT)
Received: from localhost.localdomain ([223.233.99.139])
        by smtp.googlemail.com with ESMTPSA id fs9sm9350911pjb.40.2021.03.15.00.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 00:55:39 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v6 2/6] commit: add amend suboption to --fixup to create amend! commit
Date:   Mon, 15 Mar 2021 13:24:32 +0530
Message-Id: <20210315075435.18229-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
References: <20210310194306.32565-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git commit --fixup=amend:<commit>` will create an "amend!" commit.
The resulting commit message subject will be "amend! ..." where
"..." is the subject line of <commit> and the initial message
body will be <commit>'s message.

The "amend!" commit when rebased with --autosquash will fixup the
contents and replace the commit message of <commit> with the
"amend!" commit's message body.

In order to prevent rebase from creating commits with an empty
message we refuse to create an "amend!" commit if commit message
body is empty.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 builtin/commit.c | 103 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956..9697bba10b 100644
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
@@ -357,7 +358,8 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		die(_("--pathspec-file-nul requires --pathspec-from-file"));
 	}
 
-	if (!pathspec.nr && (also || (only && !amend && !allow_empty)))
+	if (!pathspec.nr && (also || (only && !allow_empty &&
+	    (!amend || (fixup_message && strcmp(fixup_prefix, "amend"))))))
 		die(_("No paths with --include/--only does not make sense."));
 
 	if (read_cache_preload(&pathspec) < 0)
@@ -681,6 +683,22 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	comment_line_char = *p;
 }
 
+static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
+				struct pretty_print_context *ctx)
+{
+	const char *buffer, *subject, *fmt;
+
+	buffer = get_commit_buffer(commit, NULL);
+	find_commit_subject(buffer, &subject);
+	/*
+	 * If we amend the 'amend!' commit then we don't want to
+	 * duplicate the subject line.
+	 */
+	fmt = starts_with(subject, "amend!") ? "%b" : "%B";
+	format_commit_message(commit, fmt, sb, ctx);
+	unuse_commit_buffer(commit, buffer);
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -745,15 +763,33 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	} else if (fixup_message) {
 		struct pretty_print_context ctx = {0};
 		struct commit *commit;
-		commit = lookup_commit_reference_by_name(fixup_message);
+		char *fmt;
+		commit = lookup_commit_reference_by_name(fixup_commit);
 		if (!commit)
-			die(_("could not lookup commit %s"), fixup_message);
+			die(_("could not lookup commit %s"), fixup_commit);
 		ctx.output_encoding = get_commit_output_encoding();
-		format_commit_message(commit, "fixup! %s\n\n",
-				      &sb, &ctx);
-		if (have_option_m)
-			strbuf_addbuf(&sb, &message);
+		fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
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
+			prepare_amend_commit(commit, &sb, &ctx);
+		}
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
 		size_t merge_msg_start;
 
@@ -1170,7 +1206,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die(_("Using both --reset-author and --author does not make sense"));
 
-	if (logfile || have_option_m || use_message || fixup_message)
+	if (logfile || have_option_m || use_message)
 		use_editor = 0;
 	if (0 <= edit_flag)
 		use_editor = edit_flag;
@@ -1227,6 +1263,36 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
+
+	if (fixup_message) {
+		/*
+		 * We limit --fixup's suboptions to only alpha characters.
+		 * If the first character after a run of alpha is colon,
+		 * then the part before the colon may be a known suboption
+		 * name `amend` or a misspelt suboption name. In this case,
+		 * we treat it as --fixup=<suboption>:<arg>.
+		 *
+		 * Otherwise, we are dealing with --fixup=<commit>.
+		 */
+		char *p = fixup_message;
+		while (isalpha(*p))
+			p++;
+		if (p > fixup_message && *p == ':') {
+			*p = '\0';
+			fixup_commit = p + 1;
+			if (!strcmp("amend", fixup_message)) {
+				fixup_prefix = "amend";
+				allow_empty = 1;
+			} else {
+				die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
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
@@ -1504,7 +1570,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1663,6 +1733,19 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}
 
+	if (fixup_message && starts_with(sb.buf, "amend! ") &&
+	    !allow_empty_message) {
+		struct strbuf body = STRBUF_INIT;
+		size_t len = commit_subject_length(sb.buf);
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

