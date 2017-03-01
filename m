Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20DE1F5FB
	for <e@80x24.org>; Wed,  1 Mar 2017 11:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbdCALoK (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 06:44:10 -0500
Received: from mout.web.de ([212.227.15.14]:54967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752206AbdCALn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 06:43:59 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQ8vL-1ceLbg1cV1-005FJV; Wed, 01
 Mar 2017 12:37:11 +0100
Subject: [PATCH 2/2] pretty: use fmt_output_email_subject()
To:     Jeff King <peff@peff.net>, Adrian Dudau <Adrian.Dudau@enea.com>
References: <1488297556.2955.11.camel@enea.com>
 <20170228181719.t67abnnnsdcx2xfd@sigill.intra.peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <58e05599-5dc4-9881-d8c0-89ad1f2e3838@web.de>
Date:   Wed, 1 Mar 2017 12:37:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170228181719.t67abnnnsdcx2xfd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ybfj3o8e1ZOuvt4EqPX9+1PYMMo13PaRaXrgm3JIGbdghrnHZoR
 Kb2E4RjpD+VDX1sQqsdNqYOyFcLlOLgmkv2OMGojqlBjSSnH4YOOVPdfnSdUBHExmFuLaK2
 MzWNazxaAWNokumtBvLztnlR3Fp6W+32pmdrhzjEmKnz8zVRZorrPHnnyYert+dYKePGxeL
 z7eJDHR/LGuVyb0WZR4BQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X18+1NQum6E=:b61Mi8yPgnddwwa9a9BtgI
 1ditK3RrQ520K5eju50ND+Y3J7ErsduMqFIpjWd7LvjPhJ5hYzv2v8NroW1RhTUoWf9yIx+xZ
 774fRiaxFD0zOHGVZVwHe48wcChBYqLJZI3fOFpe1PXl6BELfD6ce4GwnS8ThmhWNej3ei2mQ
 HG/DoDCSDhkAvH5unK1Nn2c50aT0JC6X/m+gtMMWM/DTlSoyhb/WR/pYjDjoYGIw3jiSxK+Y6
 WzUXmtL2ZidzLpRHa1VCUU/8pzl73QALnBViKiRZWSc1s15DPtd6rL+OGXjzl3CZA/Ub+cw1N
 zKN8CnUXOarakouU97SE3mhjmiHKgqeQ+u1PlhGtpnMZ867RtZoBW3145mEgW+SlFTZ6bShCh
 C9rRaKAazsaLgHZeF6zdvJ7Pelw42IuMWJcppiWvZLReeF5GeVxXf2RBQWrTGNDrQe3bhCe7A
 HhZc/JXv26UngbHledY0VfxHS6ECMltVSB4/NT1EBAnIggebUVqOzC3t7qDDbdMApA0QwP6sQ
 J5rk/bf3sIgVjrlINb+yyce9Jpn5UDQLjGBffaXES0yy9jbtrTEyf4drKVOvVz+1I0+nptpag
 yyC8nIthYUi4s1Rf36Hs7J+yntY9vRUzpHCvjKeJLFGUW/EEbAC2jow/1z1GYGIUWA11rByh4
 frUBRqA13JNx0UZUpYuAyjKewj283Jm3q/1ClqIjYiLBoKh3/iQbIfY1YJgQz9DhJpeGvieWF
 +JefuRtwX7FgdgqdL7hjVYtsEpyE+rgiK4W7DMe2DxU5lVK17E4SraLk9ZCIa6xe3GC1c2jGq
 TJCmtU5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the email-style subject prefix (e.g. "Subject: [PATCH] ") directly
when it's needed instead of letting log_write_email_headers() prepare
it in a static buffer in advance.  This simplifies storage ownership and
code flow.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This slows down the last three tests in p4000 by ca. 3% for some reason,
so we may want to only do the first part for now, which is performance
neutral on my machine.

 builtin/log.c      | 5 +++--
 builtin/shortlog.c | 2 +-
 commit.h           | 6 ++++--
 log-tree.c         | 9 +++------
 log-tree.h         | 1 -
 pretty.c           | 7 ++++---
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 55d20cc2d8..281af8c1ec 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -989,8 +989,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
 		return;
 
-	log_write_email_headers(rev, head, &pp.subject, &pp.after_subject,
-				&need_8bit_cte);
+	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte);
 
 	for (i = 0; !need_8bit_cte && i < nr; i++) {
 		const char *buf = get_commit_buffer(list[i], NULL);
@@ -1005,6 +1004,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	msg = body;
 	pp.fmt = CMIT_FMT_EMAIL;
 	pp.date_mode.type = DATE_RFC2822;
+	pp.rev = rev;
+	pp.print_email_subject = 1;
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
 	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
 	pp_remainder(&pp, &msg, &sb, 0);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index c9585d475d..f78bb4818d 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -148,7 +148,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
-	ctx.subject = "";
+	ctx.print_email_subject = 1;
 	ctx.after_subject = "";
 	ctx.date_mode.type = DATE_NORMAL;
 	ctx.output_encoding = get_log_output_encoding();
diff --git a/commit.h b/commit.h
index 9c12abb911..459daef94a 100644
--- a/commit.h
+++ b/commit.h
@@ -142,21 +142,24 @@ static inline int cmit_fmt_is_mail(enum cmit_fmt fmt)
 	return (fmt == CMIT_FMT_EMAIL || fmt == CMIT_FMT_MBOXRD);
 }
 
+struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
+
 struct pretty_print_context {
 	/*
 	 * Callers should tweak these to change the behavior of pp_* functions.
 	 */
 	enum cmit_fmt fmt;
 	int abbrev;
-	const char *subject;
 	const char *after_subject;
 	int preserve_subject;
 	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
+	unsigned print_email_subject:1;
 	int expand_tabs_in_log;
 	int need_8bit_cte;
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
+	struct rev_info *rev;
 	const char *output_encoding;
 	struct string_list *mailmap;
 	int color;
@@ -175,7 +178,6 @@ struct userformat_want {
 };
 
 extern int has_non_ascii(const char *text);
-struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern const char *logmsg_reencode(const struct commit *commit,
 				   char **commit_encoding,
 				   const char *output_encoding);
diff --git a/log-tree.c b/log-tree.c
index 44febb75ab..4618dd04ca 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -349,11 +349,9 @@ void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 }
 
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
-			     const char **subject_p,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p)
 {
-	static struct strbuf subject = STRBUF_INIT;
 	const char *extra_headers = opt->extra_headers;
 	const char *name = oid_to_hex(opt->zero_commit ?
 				      &null_oid : &commit->object.oid);
@@ -415,9 +413,6 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		opt->diffopt.stat_sep = buffer;
 		strbuf_release(&filename);
 	}
-	strbuf_reset(&subject);
-	fmt_output_email_subject(&subject, opt);
-	*subject_p = subject.buf;
 	*extra_headers_p = extra_headers;
 }
 
@@ -602,8 +597,10 @@ void show_log(struct rev_info *opt)
 	 */
 
 	if (cmit_fmt_is_mail(opt->commit_format)) {
-		log_write_email_headers(opt, commit, &ctx.subject, &extra_headers,
+		log_write_email_headers(opt, commit, &extra_headers,
 					&ctx.need_8bit_cte);
+		ctx.rev = opt;
+		ctx.print_email_subject = 1;
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), opt->diffopt.file);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
diff --git a/log-tree.h b/log-tree.h
index dd75dd7770..48f11fb740 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -22,7 +22,6 @@ void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
 			     format_decorations_extended((strbuf), (commit), (color), " (", ", ", ")")
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
-			     const char **subject_p,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p);
 void load_ref_decorations(int flags);
diff --git a/pretty.c b/pretty.c
index 5e683830d9..d0f86f5d85 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1607,8 +1607,9 @@ void pp_title_line(struct pretty_print_context *pp,
 				pp->preserve_subject ? "\n" : " ");
 
 	strbuf_grow(sb, title.len + 1024);
-	if (pp->subject) {
-		strbuf_addstr(sb, pp->subject);
+	if (pp->print_email_subject) {
+		if (pp->rev)
+			fmt_output_email_subject(sb, pp->rev);
 		if (needs_rfc2047_encoding(title.buf, title.len, RFC2047_SUBJECT))
 			add_rfc2047(sb, title.buf, title.len,
 						encoding, RFC2047_SUBJECT);
@@ -1818,7 +1819,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	}
 
 	pp_header(pp, encoding, commit, &msg, sb);
-	if (pp->fmt != CMIT_FMT_ONELINE && !pp->subject) {
+	if (pp->fmt != CMIT_FMT_ONELINE && !pp->print_email_subject) {
 		strbuf_addch(sb, '\n');
 	}
 
-- 
2.12.0

