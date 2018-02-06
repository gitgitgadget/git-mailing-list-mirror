Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93FEF1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeBFAbd (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:31:33 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46499 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeBFAb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:31:29 -0500
Received: by mail-pg0-f65.google.com with SMTP id s9so169085pgq.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IiXIyVoPzJLlSilr9b1z2nTYJoLI6y1l5WWlcG8w8pc=;
        b=k0zBBLwL6NXUsjohu9Fu8TUGXI6cWJfhktxRxzH3gHnA7xkcQzezbFygaAaOqfnybR
         leDqvDE4jRhlVwF//ft/3BBupDk+rc+MQIXswn87f3spEzoWtYYaEqF8vz2GtO5ltQnh
         Mmd2uEmWIz5x81HYQ6/iKzJVOnb9wm1B/J3nXdbSIeF+f/wtOSf4ae88QLoMuSt82s/O
         SOqNJodg8T6K7Ghiq5oUZPTMKOWvU7R7RqCHfJpg/gh5zptiHh0nQpmqYrQmF4FWNj68
         XBjBsglGuHTzVlEpsLMp7KC8jU8Ab3yvmOYxOYHtZpzn4zEMLV4v2BaSWGc+Tk4M3cob
         wvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IiXIyVoPzJLlSilr9b1z2nTYJoLI6y1l5WWlcG8w8pc=;
        b=bk8uKsX+dsNqqTKxLZroBRYYwFoipto7EaFRpDNf57+UC4Sgx0b9NzXSWUJYBJkVe+
         MZo4HXJkElSJe43D6Q6FctTL18xHxAzuRlmktGkzp9PnVwBIOSNZP+nlp5EwmS/BmTrg
         H1Oby6qDyZYypSGlDhBdb04t8asmhgGorPeUsTwfwGCmg3W7sff0fdfkpnaL3nrqclwQ
         Bnm7qFQiXZZeXXdPzfrUvo+xjv06XL9rngxhlzFt87XqWv+90B58H6Jbvvb34U3m3kt7
         8prhRSpYHjHmb/zsjJEXkebYHItGVP10zqIGxQBnqomuk2K6RzPEwZ+NwuDiW+o4FHia
         dM7g==
X-Gm-Message-State: APf1xPAR/2Bve9zUgASDGGBLZOVdhrGki6U4JFDMUchDR1c8U97svXSE
        Uyf3BSCAh15WZzZRCfHFxDO4f5oNj4U=
X-Google-Smtp-Source: AH8x224ZCssuoOLc+mH6vCIYdNLV3u0IAeqNe23XTsuBMAi6EfemTPyuPpBlcCKjv1njJO2yZp3Zzg==
X-Received: by 10.101.80.204 with SMTP id s12mr447891pgp.185.1517877087952;
        Mon, 05 Feb 2018 16:31:27 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id g27sm9079220pfa.25.2018.02.05.16.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:31:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 184/194] pretty: add repository argument to format_commit_message
Date:   Mon,  5 Feb 2018 16:17:39 -0800
Message-Id: <20180206001749.218943-86-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 archive.c                                  |  3 ++-
 builtin/commit.c                           | 17 +++++++++++------
 builtin/fmt-merge-msg.c                    |  2 +-
 builtin/notes.c                            |  3 ++-
 builtin/shortlog.c                         |  5 +++--
 contrib/coccinelle/submodule_reading.cocci | 10 ++++++++++
 log-tree.c                                 |  2 +-
 notes-cache.c                              |  2 +-
 pretty.c                                   |  5 +++--
 pretty.h                                   |  4 +++-
 sha1_name.c                                |  3 ++-
 submodule.c                                |  5 +++--
 t/helper/test-revision-walking.c           |  2 +-
 13 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/archive.c b/archive.c
index 6f38a5cf55..cb0b1d595c 100644
--- a/archive.c
+++ b/archive.c
@@ -56,7 +56,8 @@ static void format_subst(const struct commit *commit,
 		strbuf_add(&fmt, b + 8, c - b - 8);
 
 		strbuf_add(buf, src, b - src);
-		format_commit_message(commit, fmt.buf, buf, &ctx);
+		format_commit_message(the_repository, commit, fmt.buf, buf,
+				      &ctx);
 		len -= c + 1 - src;
 		src  = c + 1;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index c903893767..a6ddf6dd23 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -696,7 +696,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			if (!c)
 				die(_("could not lookup commit %s"), squash_message);
 			ctx.output_encoding = get_commit_output_encoding();
-			format_commit_message(c, "squash! %s\n\n", &sb,
+			format_commit_message(the_repository, c,
+					      "squash! %s\n\n", &sb,
 					      &ctx);
 		}
 	}
@@ -729,7 +730,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (!commit)
 			die(_("could not lookup commit %s"), fixup_message);
 		ctx.output_encoding = get_commit_output_encoding();
-		format_commit_message(commit, "fixup! %s\n\n",
+		format_commit_message(the_repository, commit, "fixup! %s\n\n",
 				      &sb, &ctx);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
@@ -1069,7 +1070,8 @@ static const char *find_author_by_nickname(const char *name)
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode.type = DATE_NORMAL;
 		strbuf_release(&buf);
-		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
+		format_commit_message(the_repository, commit, "%aN <%aE>",
+				      &buf, &ctx);
 		clear_mailmap(&mailmap);
 		return strbuf_detach(&buf, NULL);
 	}
@@ -1472,15 +1474,18 @@ static void print_summary(const char *prefix, const struct object_id *oid,
 
 	strbuf_addstr(&format, "format:%h] %s");
 
-	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx);
-	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx);
+	format_commit_message(the_repository, commit, "%an <%ae>",
+			      &author_ident, &pctx);
+	format_commit_message(the_repository, commit, "%cn <%ce>",
+			      &committer_ident, &pctx);
 	if (strbuf_cmp(&author_ident, &committer_ident)) {
 		strbuf_addstr(&format, "\n Author: ");
 		strbuf_addbuf_percentquote(&format, &author_ident);
 	}
 	if (author_date_is_interesting()) {
 		struct strbuf date = STRBUF_INIT;
-		format_commit_message(commit, "%ad", &date, &pctx);
+		format_commit_message(the_repository, commit, "%ad", &date,
+				      &pctx);
 		strbuf_addstr(&format, "\n Date: ");
 		strbuf_addbuf_percentquote(&format, &date);
 		strbuf_release(&date);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 6dedb92d61..591cf95346 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -374,7 +374,7 @@ static void shortlog(const char *name,
 		if (subjects.nr > limit)
 			continue;
 
-		format_commit_message(commit, "%s", &sb, &ctx);
+		format_commit_message(the_repository, commit, "%s", &sb, &ctx);
 		strbuf_ltrim(&sb);
 
 		if (!sb.len)
diff --git a/builtin/notes.c b/builtin/notes.c
index 9100ac5ce0..8633da1d5e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -736,7 +736,8 @@ static int merge_commit(struct notes_merge_options *o)
 
 	/* Reuse existing commit message in reflog message */
 	memset(&pretty_ctx, 0, sizeof(pretty_ctx));
-	format_commit_message(partial, "%s", &msg, &pretty_ctx);
+	format_commit_message(the_repository, partial, "%s", &msg,
+			      &pretty_ctx);
 	strbuf_trim(&msg);
 	strbuf_insert(&msg, 0, "notes: ", 7);
 	update_ref(msg.buf, o->local_ref, &oid,
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index e29875b843..61a8c9a6e9 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -169,12 +169,13 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		(log->email ? "%cN <%cE>" : "%cN") :
 		(log->email ? "%aN <%aE>" : "%aN");
 
-	format_commit_message(commit, fmt, &author, &ctx);
+	format_commit_message(the_repository, commit, fmt, &author, &ctx);
 	if (!log->summary) {
 		if (log->user_format)
 			pretty_print_commit(&ctx, commit, &oneline);
 		else
-			format_commit_message(commit, "%s", &oneline, &ctx);
+			format_commit_message(the_repository, commit, "%s",
+					      &oneline, &ctx);
 	}
 
 	insert_one_record(log, author.buf, oneline.len ? oneline.buf : "<none>");
diff --git a/contrib/coccinelle/submodule_reading.cocci b/contrib/coccinelle/submodule_reading.cocci
index b3e3d88626..30935ac21d 100644
--- a/contrib/coccinelle/submodule_reading.cocci
+++ b/contrib/coccinelle/submodule_reading.cocci
@@ -14,3 +14,13 @@ expression G;
  logmsg_reencode(
 +the_repository,
  E, F, G)
+
+@@
+expression E;
+expression F;
+expression G;
+expression H;
+@@
+ format_commit_message(
++the_repository,
+ E, F, G, H)
diff --git a/log-tree.c b/log-tree.c
index c6d2883190..e32a2fe71c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -341,7 +341,7 @@ void fmt_output_commit(struct strbuf *filename,
 	struct pretty_print_context ctx = {0};
 	struct strbuf subject = STRBUF_INIT;
 
-	format_commit_message(commit, "%f", &subject, &ctx);
+	format_commit_message(the_repository, commit, "%f", &subject, &ctx);
 	fmt_output_subject(filename, subject.buf, info);
 	strbuf_release(&subject);
 }
diff --git a/notes-cache.c b/notes-cache.c
index a4a6ccab97..89c2284192 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -21,7 +21,7 @@ static int notes_cache_match_validity(const char *ref, const char *validity)
 		return 0;
 
 	memset(&pretty_ctx, 0, sizeof(pretty_ctx));
-	format_commit_message(commit, "%s", &msg, &pretty_ctx);
+	format_commit_message(the_repository, commit, "%s", &msg, &pretty_ctx);
 	strbuf_trim(&msg);
 
 	ret = !strcmp(msg.buf, validity);
diff --git a/pretty.c b/pretty.c
index a0c95280f6..30d53369b5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1503,7 +1503,7 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 	strbuf_release(&dummy);
 }
 
-void format_commit_message(const struct commit *commit,
+void format_commit_message_the_repository(const struct commit *commit,
 			   const char *format, struct strbuf *sb,
 			   const struct pretty_print_context *pretty_ctx)
 {
@@ -1796,7 +1796,8 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	int need_8bit_cte = pp->need_8bit_cte;
 
 	if (pp->fmt == CMIT_FMT_USERFORMAT) {
-		format_commit_message(commit, user_format, sb, pp);
+		format_commit_message(the_repository, commit, user_format, sb,
+				      pp);
 		return;
 	}
 
diff --git a/pretty.h b/pretty.h
index 5c85d94e33..14af7df4e8 100644
--- a/pretty.h
+++ b/pretty.h
@@ -99,7 +99,9 @@ void pp_remainder(struct pretty_print_context *pp, const char **msg_p,
  * Put the result to "sb".
  * Please use this function for custom formats.
  */
-void format_commit_message(const struct commit *commit,
+#define format_commit_message(r, c, f, s, p) \
+	format_commit_message_##r(c, f, s, p)
+void format_commit_message_the_repository(const struct commit *commit,
 			const char *format, struct strbuf *sb,
 			const struct pretty_print_context *context);
 
diff --git a/sha1_name.c b/sha1_name.c
index ee889daead..d6c2cf969f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -378,7 +378,8 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
-			format_commit_message(commit, " %ad - %s", &desc, &pp);
+			format_commit_message(the_repository, commit,
+					      " %ad - %s", &desc, &pp);
 		}
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(the_repository, oid);
diff --git a/submodule.c b/submodule.c
index af4a1d2cea..b399cf46e4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -452,7 +452,8 @@ static void print_submodule_summary(struct rev_info *rev, struct diff_options *o
 		ctx.date_mode = rev->date_mode;
 		ctx.output_encoding = get_log_output_encoding();
 		strbuf_setlen(&sb, 0);
-		format_commit_message(commit, format, &sb, &ctx);
+		format_commit_message(the_repository, commit, format, &sb,
+				      &ctx);
 		strbuf_addch(&sb, '\n');
 		if (commit->object.flags & SYMMETRIC_LEFT)
 			diff_emit_submodule_del(o, sb.buf);
@@ -1786,7 +1787,7 @@ static void print_commit(struct commit *commit)
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	ctx.date_mode.type = DATE_NORMAL;
-	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
+	format_commit_message(the_repository, commit, " %h: %m %s", &sb, &ctx);
 	fprintf(stderr, "%s\n", sb.buf);
 	strbuf_release(&sb);
 }
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index b8e6fe1d00..59599410ce 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -18,7 +18,7 @@ static void print_commit(struct commit *commit)
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	ctx.date_mode.type = DATE_NORMAL;
-	format_commit_message(commit, " %m %s", &sb, &ctx);
+	format_commit_message(the_repository, commit, " %m %s", &sb, &ctx);
 	printf("%s\n", sb.buf);
 	strbuf_release(&sb);
 }
-- 
2.15.1.433.g936d1b9894.dirty

