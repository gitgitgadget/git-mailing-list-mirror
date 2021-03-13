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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF68C433E9
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A36664F2A
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhCMNm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 08:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhCMNmj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 08:42:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDF2C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:42:39 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z5so13230104plg.3
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PFZzSEdAg6o6avaa4hhE0KnRAVtknGkBUOoGd8V24E=;
        b=Hmb9ML2kQsmRfqjvgu1i2sDIS0OwVoiF8WwTZa66QMJVmYlrZqT1V3WNKkyr8yBq75
         q6LQfw5wWGqfIFdK1UU2XECpi2m8NOdIkrQXdopFxg6sNtRiPbHc1l9czCHAJWqd6vZ8
         BAo4a/NwraoYFhslA8EBGUN/mT/nszQ1Khd+13J2Qd/Xd8wBOoKCofdF4Wa7YGzuHcto
         BdAqcw2oYhaMqHodMrLrBcTi+9SMd1qyLv5r1fIev89sPZVlB7nPJ2rfM829ZWb3IKj/
         DKPojdXCk3Hh7qJa6stkSjB2csNlYGgypvjgfI+5B5gDhGUFxBDe7pJNLYAjmA7b6OHo
         VWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PFZzSEdAg6o6avaa4hhE0KnRAVtknGkBUOoGd8V24E=;
        b=N6mtj00FvQVeyTeuJMovFK2DN+U/chM2rncOfdBybl7s0LTgA9kd2uvkueOxNa5uaV
         j+0eDeJGQKJz6Hh6p7UBRZol3mf5EoSnUsZ/qVUwCTnxTjEbmRswTjAzl0lHSmaoOxQq
         ATyPscpeakApRNlMY7sah5PbBPB5iLtNrxL3yi21c2MeRbLg0zolmvlMrvucFBPLo2M9
         FuYJXKBYRTbgyRj1EBHiZw1ghzPSswetVJ7hejaBe9tLz/jG86beKssXtDHkjtuRsbuE
         h5N3h2N7HlzVhtLIBUpfeAIC69vLGSvVFpXjwlijEq1kQxC7DDi0ek+JYtmd6nFJYoWo
         fUqA==
X-Gm-Message-State: AOAM530a8ERl+spzqqUxfw2SUcJ6z81WLjsC4dRjAm3XGgiw0tXBWIXK
        ZlxVlhP0qYK40LAsoCiJLPI2vSuCr1uayA==
X-Google-Smtp-Source: ABdhPJxkX/6ukN3b+/wKUG3hmNRHhvrASBann7kiTGR0af69UgRTTJOVVxAhcmwYqgge914TIzN6TQ==
X-Received: by 2002:a17:902:9a0c:b029:e5:fedb:92c6 with SMTP id v12-20020a1709029a0cb02900e5fedb92c6mr3311673plp.59.1615642958370;
        Sat, 13 Mar 2021 05:42:38 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d98:f55e:3466:3377:eaba:8d02])
        by smtp.googlemail.com with ESMTPSA id y20sm8657809pfo.210.2021.03.13.05.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 05:42:38 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, sunshine@sunshineco.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 2/6] commit: add amend suboption to --fixup to create amend! commit
Date:   Sat, 13 Mar 2021 19:10:09 +0530
Message-Id: <20210313134012.20658-3-charvi077@gmail.com>
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
 builtin/commit.c | 107 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 97 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956..55712fdc7b 100644
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
 
@@ -1152,6 +1188,12 @@ static void finalize_deferred_config(struct wt_status *s)
 		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
 }
 
+/* returns the length of intial segment of alpha characters only */
+static size_t skip_suboption(char *fixup_message) {
+	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
+	return strspn(fixup_message, alphas);
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const struct option *options,
 				      const char * const usage[],
@@ -1170,7 +1212,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die(_("Using both --reset-author and --author does not make sense"));
 
-	if (logfile || have_option_m || use_message || fixup_message)
+	if (logfile || have_option_m || use_message)
 		use_editor = 0;
 	if (0 <= edit_flag)
 		use_editor = edit_flag;
@@ -1227,6 +1269,34 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
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
+		size_t len = skip_suboption(fixup_message);
+		if (len && fixup_message[len] == ':') {
+			fixup_message[len++] = '\0';
+			fixup_commit = fixup_message + len;
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
@@ -1504,7 +1574,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1663,6 +1737,19 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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

