Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439501F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfKDUEI (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:04:08 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:43070 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfKDUEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:04:08 -0500
Received: by mail-pl1-f172.google.com with SMTP id a18so6971273plm.10
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m64dMGD0H2LQcBzS72fInNckVioZa4/x7km99z8xRAs=;
        b=gYkgj6ci9j44q0h0MsqvfjPbOj1K36pTHIrv92x+1UJIoAWWe/PQ8GG+P3RBBooEzS
         rDJ63qKH9FZkmHvdpI67LqIgqUo9piO4CG39TP/0Ea9ix5tA/4wZk5dcOTSZ2zt6NUA9
         b8HBO0/qdXJEETEB0IH9muMcH/Ex9VvV0SOeK3bdNeHF/hhUw5dkhO1tm+ZWXWBlVT+O
         8w3lxN+8xuZQnic+D9RDyEx/gc0w6hT5iDytykcl4yECdbd9J9osZp69kRWUXmUQi+7k
         1cvMnO1efc/QOEIy64BhGwOyy1ZzXtTreyq8N/tt6qxD0XxCru6AdUuz2nvv3eLucGSS
         SB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m64dMGD0H2LQcBzS72fInNckVioZa4/x7km99z8xRAs=;
        b=gPVIpUcDLd1f7im6Kl0JZCyVdC6gIEKlMqrjCdohZ9mBG4BRPaRqUULAa794QIE4GF
         m52ItkKhpMPO7s2hdg77SFiGo18qni8SwL7ejuAUQ5LmcNVddNNfTvq6Ncz6bFYr/6XK
         8OscJ9Bo/3Uw8AJW46+DEr2+kXrnk3WZi/Bimy4Y0ug1mN4TlIvLQXS3+sGXgNLwoKNo
         ycLN3Y/mZZtcdsxkd3g7izcFEyKpncl3rCemNNc4sOQvP2gKOEckHEKwVkHAzDGGTII5
         D+Q5lxPml3r+CdbFNmh27Rx8Tl2WarQQLRjg+IgJySBUszg6l2/16XgPnDIDfa6fr1Sx
         8zcw==
X-Gm-Message-State: APjAAAWPp6QhrBQXVJty3gbM5SDRC20OPB7iUSH0o7lIjpmR/NZC2yYo
        91I8f4nYGaZPfOzws2dSzMMiEvXS
X-Google-Smtp-Source: APXvYqzgdKg3R9pcXcS0OQiCkFPgZjadqcrYH93i11sgczIG6V/hIPXnca436yW/Ru/PgM5Y4XDuQQ==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19mr1783351plo.217.1572897846925;
        Mon, 04 Nov 2019 12:04:06 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id 205sm14360294pge.56.2019.11.04.12.04.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:04:06 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:04:04 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 7/8] pretty: implement 'summary' format
Message-ID: <64b6f7c9d7434ba39929220c1aebcd9a1fd0ad6e.1572897736.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572897736.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The standard format for referencing other commits within some projects
(such as git.git) is the summary format. This is described in
Documentation/SubmittingPatches as

	If you want to reference a previous commit in the history of a stable
	branch, use the format "abbreviated sha1 (subject, date)",
	with the subject enclosed in a pair of double-quotes, like this:

	....
		Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
		noticed that ...
	....

Since this format is so commonly used, standardize it as a pretty
format.

This format is implemented as a separate flow that skips most of
pretty_print_commit() and instead calls format_commit_summary(). The
reason why this is done is because the other pretty formats expect
output to be generated in a specific order. Specifically, the header,
including the date, is always printed before the commit message,
including the subject. Reversing the order would be possible but would
involve butchering pretty_print_commit() so it is implemented as a
separate flow.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/pretty-formats.txt   |  9 ++++++
 Documentation/pretty-options.txt   |  2 +-
 Documentation/rev-list-options.txt |  2 +-
 builtin/log.c                      | 30 ++++++++++++++---
 log-tree.c                         | 11 +++++--
 pretty.c                           | 31 +++++++++++++++++-
 pretty.h                           |  1 +
 t/t4205-log-pretty-formats.sh      | 52 ++++++++++++++++++++++++++++++
 8 files changed, 127 insertions(+), 11 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 71eef684d0..5641903b93 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -63,6 +63,15 @@ This is designed to be as compact as possible.
 
 	       <full commit message>
 
+* 'summary'
+
+	  <abbrev hash> ("<title line>", <short author date>)
++
+This format is useful for referring to other commits when writing a new
+commit message. Although by default, '<abbrev sha1>' is used, this can
+be overridden with '--no-abbrev'. In addition, '<short author date>' can
+be overridden by with '--date='.
+
 * 'email'
 
 	  From <hash> <date>
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index e44fc8f738..0a5b206193 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -3,7 +3,7 @@
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
-	'full', 'fuller', 'email', 'raw', 'format:<string>'
+	'full', 'fuller', 'summary', 'email', 'raw', 'format:<string>'
 	and 'tformat:<string>'.  When '<format>' is none of the above,
 	and has '%placeholder' in it, it acts as if
 	'--pretty=tformat:<format>' were given.
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 90ff9e2bea..76df494ed6 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -289,7 +289,7 @@ depending on a few rules:
 4. Otherwise, show the index format.
 --
 +
-Under `--pretty=oneline`, the commit message is
+Under `--pretty=oneline` and `--pretty=summary`, the commit message is
 prefixed with this information on the same line.
 This option cannot be combined with `--reverse`.
 See also linkgit:git-reflog[1].
diff --git a/builtin/log.c b/builtin/log.c
index e4df16be79..ad96a746a3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -223,15 +223,35 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		read_mailmap(rev->mailmap, NULL);
 	}
 
-	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
+	if (rev->pretty_given) {
+		switch (rev->commit_format) {
+
 		/*
 		 * "log --pretty=raw" is special; ignore UI oriented
 		 * configuration variables such as decoration.
 		 */
-		if (!decoration_given)
-			decoration_style = 0;
-		if (!rev->abbrev_commit_explicit)
-			rev->abbrev_commit = 0;
+		case CMIT_FMT_RAW:
+			if (!decoration_given)
+				decoration_style = 0;
+			if (!rev->abbrev_commit_explicit)
+				rev->abbrev_commit = 0;
+			break;
+
+		/*
+		 * "log --pretty=summary" is special; ignore UI oriented
+		 * configuration variables such as decoration but keep
+		 * abbreviations.
+		 */
+		case CMIT_FMT_SUMMARY:
+			if (!decoration_given)
+				decoration_style = 0;
+			if (!rev->abbrev_commit_explicit)
+				rev->abbrev_commit = 1;
+			break;
+
+		default:
+			break;
+		}
 	}
 
 	if (decoration_style) {
diff --git a/log-tree.c b/log-tree.c
index 4a7d668af6..433adaf0f1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -627,7 +627,8 @@ void show_log(struct rev_info *opt)
 		ctx.print_email_subject = 1;
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), opt->diffopt.file);
-		if (opt->commit_format != CMIT_FMT_ONELINE)
+		if (opt->commit_format != CMIT_FMT_ONELINE &&
+		    opt->commit_format != CMIT_FMT_SUMMARY)
 			fputs("commit ", opt->diffopt.file);
 
 		if (!opt->graph)
@@ -644,7 +645,8 @@ void show_log(struct rev_info *opt)
 			       find_unique_abbrev(&parent->object.oid, abbrev_commit));
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), opt->diffopt.file);
 		show_decorations(opt, commit);
-		if (opt->commit_format == CMIT_FMT_ONELINE) {
+		if (opt->commit_format == CMIT_FMT_ONELINE ||
+		    opt->commit_format == CMIT_FMT_SUMMARY) {
 			putc(' ', opt->diffopt.file);
 		} else {
 			putc('\n', opt->diffopt.file);
@@ -658,12 +660,15 @@ void show_log(struct rev_info *opt)
 			 * graph info here.
 			 */
 			show_reflog_message(opt->reflog_info,
-					    opt->commit_format == CMIT_FMT_ONELINE,
+					    (opt->commit_format == CMIT_FMT_ONELINE ||
+					     opt->commit_format == CMIT_FMT_SUMMARY),
 					    &opt->date_mode,
 					    opt->date_mode_explicit);
 			if (opt->commit_format == CMIT_FMT_ONELINE) {
 				putc('\n', opt->diffopt.file);
 				return;
+			} else if (opt->commit_format == CMIT_FMT_SUMMARY) {
+				putc(' ', opt->diffopt.file);
 			}
 		}
 	}
diff --git a/pretty.c b/pretty.c
index a6e5fc115a..8efb2486a5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -97,7 +97,8 @@ static void setup_commit_formats(void)
 		{ "mboxrd",	CMIT_FMT_MBOXRD,	0,	0 },
 		{ "fuller",	CMIT_FMT_FULLER,	0,	8 },
 		{ "full",	CMIT_FMT_FULL,		0,	8 },
-		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 }
+		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 },
+		{ "summary",	CMIT_FMT_SUMMARY,	1,	0 },
 		/*
 		 * Please update $__git_log_pretty_formats in
 		 * git-completion.bash when you add new formats.
@@ -1672,6 +1673,26 @@ void repo_format_commit_message(struct repository *r,
 				   do_repo_format_commit_message, (void *)format);
 }
 
+static void do_repo_format_commit_summary(struct strbuf *sb,
+					  struct format_commit_context *context,
+					  void *additional_context)
+{
+	struct ident_split ident;
+
+	parse_commit_header(context);
+	parse_commit_message(context);
+
+	strbuf_addstr(sb, "(\"");
+	format_subject(sb, context->message + context->subject_off, " ");
+	if (!split_ident_line(&ident,
+			      context->message + context->author.off,
+			      context->author.len)) {
+		strbuf_addstr(sb, "\", ");
+		strbuf_addstr(sb, show_ident_date(&ident, &context->pretty_ctx->date_mode));
+	}
+	strbuf_addstr(sb, ")");
+}
+
 static void pp_header(struct pretty_print_context *pp,
 		      const char *encoding,
 		      const struct commit *commit,
@@ -1923,6 +1944,14 @@ void pretty_print_commit(struct pretty_print_context *pp,
 		format_commit_message(commit, user_format, sb, pp);
 		return;
 	}
+	if (pp->fmt == CMIT_FMT_SUMMARY) {
+		if (!pp->date_mode_explicit)
+			pp->date_mode = *DATE_MODE(SHORT);
+
+		repo_format_commit_generic(the_repository, commit, sb, pp,
+					   do_repo_format_commit_summary, NULL);
+		return;
+	}
 
 	encoding = get_log_output_encoding();
 	msg = reencoded = logmsg_reencode(commit, NULL, encoding);
diff --git a/pretty.h b/pretty.h
index 4ad1fc31ff..6d5b18a4f1 100644
--- a/pretty.h
+++ b/pretty.h
@@ -16,6 +16,7 @@ enum cmit_fmt {
 	CMIT_FMT_FULL,
 	CMIT_FMT_FULLER,
 	CMIT_FMT_ONELINE,
+	CMIT_FMT_SUMMARY,
 	CMIT_FMT_EMAIL,
 	CMIT_FMT_MBOXRD,
 	CMIT_FMT_USERFORMAT,
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f42a69faa2..09b1a33cf1 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -788,4 +788,56 @@ test_expect_success '%S in git log --format works with other placeholders (part
 	test_cmp expect actual
 '
 
+test_expect_success 'log --pretty=summary' '
+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
+	git log --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with log.date is overridden by short date' '
+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
+	test_config log.date rfc &&
+	git log --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with explicit date overrides short date' '
+	git log --date=rfc --pretty="tformat:%h (\"%s\", %ad)" >expect &&
+	git log --date=rfc --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with log.abbrevCommit is overidden' '
+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
+	test_config log.abbrevCommit false &&
+	git log --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with explicit --no-abbrev overrides abbreviated' '
+	git log --date=short --pretty="tformat:%H (\"%s\", %ad)" >expect &&
+	git log --no-abbrev --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with log.decorate is overridden' '
+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
+	test_config log.decorate short &&
+	git log --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with explicit decorate overrides no decoration' '
+	git log --date=short --pretty="tformat:%h%d (\"%s\", %ad)" >expect &&
+	git log --decorate=short --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with --walk-reflogs' '
+	test_config log.date short &&
+	git log --walk-reflogs --pretty="tformat:%h %gd: %gs (\"%s\", %ad)" >expect &&
+	git log --walk-reflogs --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.24.0.rc2.262.g2d07a97ef5

