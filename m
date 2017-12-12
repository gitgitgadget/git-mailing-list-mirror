Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D0D1F407
	for <e@80x24.org>; Tue, 12 Dec 2017 08:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbdLLIzi (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 03:55:38 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:58980
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751552AbdLLIzg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2017 03:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1513068935;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=+u5D07UDDqhnVe/0Lw7qKVB/dGvwSB9njXHlKlVfHGA=;
        b=UVpKhhQzDloeRxJxKX0b8mH5njJR2MTK0h54cC+cboD+cPGTGpiXxCTOfDtPrZuh
        5PbhNxGwbHJsIUxTXtRadSIA1OjRoPEwdZmo2RBKj2xxBv0/t7fB0kER8Yu9XxhqKt5
        bTKoXOFn/0XL6tX/R211dRluylWQQA7IF7ny6ZT4=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016049efb7b4-b8dc7cff-5ddf-4692-ba1c-3551720ec28d-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
Subject: [PATCH Outreachy v2 1/2] format: create pretty.h file
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Dec 2017 08:55:35 +0000
X-SES-Outgoing: 2017.12.12-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create header for pretty.c to make formatting interface more structured.
This is a middle point, this file would be merged further with other
files which contain formatting stuff.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/notes.c       |  2 +-
 builtin/reset.c       |  2 +-
 builtin/show-branch.c |  2 +-
 commit.h              | 81 +----------------------------------------------
 pretty.h              | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.h            |  2 +-
 6 files changed, 92 insertions(+), 84 deletions(-)
 create mode 100644 pretty.h

diff --git a/builtin/notes.c b/builtin/notes.c
index 1a2c7d92ad7e7..7c8176164561b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -12,7 +12,7 @@
 #include "builtin.h"
 #include "notes.h"
 #include "blob.h"
-#include "commit.h"
+#include "pretty.h"
 #include "refs.h"
 #include "exec_cmd.h"
 #include "run-command.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 906e541658230..e15f595799c40 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -12,7 +12,7 @@
 #include "lockfile.h"
 #include "tag.h"
 #include "object.h"
-#include "commit.h"
+#include "pretty.h"
 #include "run-command.h"
 #include "refs.h"
 #include "diff.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 2e24b5c330e8e..e8a4aa40cb4b6 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 #include "config.h"
-#include "commit.h"
+#include "pretty.h"
 #include "refs.h"
 #include "builtin.h"
 #include "color.h"
diff --git a/commit.h b/commit.h
index 99a3fea68d3f6..8c68ca1a5a187 100644
--- a/commit.h
+++ b/commit.h
@@ -7,6 +7,7 @@
 #include "decorate.h"
 #include "gpg-interface.h"
 #include "string-list.h"
+#include "pretty.h"
 
 struct commit_list {
 	struct commit *item;
@@ -121,93 +122,13 @@ struct commit_list *copy_commit_list(struct commit_list *list);
 
 void free_commit_list(struct commit_list *list);
 
-/* Commit formats */
-enum cmit_fmt {
-	CMIT_FMT_RAW,
-	CMIT_FMT_MEDIUM,
-	CMIT_FMT_DEFAULT = CMIT_FMT_MEDIUM,
-	CMIT_FMT_SHORT,
-	CMIT_FMT_FULL,
-	CMIT_FMT_FULLER,
-	CMIT_FMT_ONELINE,
-	CMIT_FMT_EMAIL,
-	CMIT_FMT_MBOXRD,
-	CMIT_FMT_USERFORMAT,
-
-	CMIT_FMT_UNSPECIFIED
-};
-
-static inline int cmit_fmt_is_mail(enum cmit_fmt fmt)
-{
-	return (fmt == CMIT_FMT_EMAIL || fmt == CMIT_FMT_MBOXRD);
-}
-
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
-struct pretty_print_context {
-	/*
-	 * Callers should tweak these to change the behavior of pp_* functions.
-	 */
-	enum cmit_fmt fmt;
-	int abbrev;
-	const char *after_subject;
-	int preserve_subject;
-	struct date_mode date_mode;
-	unsigned date_mode_explicit:1;
-	int print_email_subject;
-	int expand_tabs_in_log;
-	int need_8bit_cte;
-	char *notes_message;
-	struct reflog_walk_info *reflog_info;
-	struct rev_info *rev;
-	const char *output_encoding;
-	struct string_list *mailmap;
-	int color;
-	struct ident_split *from_ident;
-
-	/*
-	 * Fields below here are manipulated internally by pp_* functions and
-	 * should not be counted on by callers.
-	 */
-	struct string_list in_body_headers;
-	int graph_width;
-};
-
-struct userformat_want {
-	unsigned notes:1;
-};
-
 extern int has_non_ascii(const char *text);
 extern const char *logmsg_reencode(const struct commit *commit,
 				   char **commit_encoding,
 				   const char *output_encoding);
-extern void get_commit_format(const char *arg, struct rev_info *);
-extern const char *format_subject(struct strbuf *sb, const char *msg,
-				  const char *line_separator);
-extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
-extern int commit_format_is_empty(enum cmit_fmt);
 extern const char *skip_blank_lines(const char *msg);
-extern void format_commit_message(const struct commit *commit,
-				  const char *format, struct strbuf *sb,
-				  const struct pretty_print_context *context);
-extern void pretty_print_commit(struct pretty_print_context *pp,
-				const struct commit *commit,
-				struct strbuf *sb);
-extern void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
-			   struct strbuf *sb);
-void pp_user_info(struct pretty_print_context *pp,
-		  const char *what, struct strbuf *sb,
-		  const char *line, const char *encoding);
-void pp_title_line(struct pretty_print_context *pp,
-		   const char **msg_p,
-		   struct strbuf *sb,
-		   const char *encoding,
-		   int need_8bit_cte);
-void pp_remainder(struct pretty_print_context *pp,
-		  const char **msg_p,
-		  struct strbuf *sb,
-		  int indent);
-
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/pretty.h b/pretty.h
new file mode 100644
index 0000000000000..ef5167484fb64
--- /dev/null
+++ b/pretty.h
@@ -0,0 +1,87 @@
+#ifndef PRETTY_H
+#define PRETTY_H
+
+struct commit;
+
+/* Commit formats */
+enum cmit_fmt {
+	CMIT_FMT_RAW,
+	CMIT_FMT_MEDIUM,
+	CMIT_FMT_DEFAULT = CMIT_FMT_MEDIUM,
+	CMIT_FMT_SHORT,
+	CMIT_FMT_FULL,
+	CMIT_FMT_FULLER,
+	CMIT_FMT_ONELINE,
+	CMIT_FMT_EMAIL,
+	CMIT_FMT_MBOXRD,
+	CMIT_FMT_USERFORMAT,
+
+	CMIT_FMT_UNSPECIFIED
+};
+
+struct pretty_print_context {
+	/*
+	 * Callers should tweak these to change the behavior of pp_* functions.
+	 */
+	enum cmit_fmt fmt;
+	int abbrev;
+	const char *after_subject;
+	int preserve_subject;
+	struct date_mode date_mode;
+	unsigned date_mode_explicit:1;
+	int print_email_subject;
+	int expand_tabs_in_log;
+	int need_8bit_cte;
+	char *notes_message;
+	struct reflog_walk_info *reflog_info;
+	struct rev_info *rev;
+	const char *output_encoding;
+	struct string_list *mailmap;
+	int color;
+	struct ident_split *from_ident;
+
+	/*
+	 * Fields below here are manipulated internally by pp_* functions and
+	 * should not be counted on by callers.
+	 */
+	struct string_list in_body_headers;
+	int graph_width;
+};
+
+static inline int cmit_fmt_is_mail(enum cmit_fmt fmt)
+{
+	return (fmt == CMIT_FMT_EMAIL || fmt == CMIT_FMT_MBOXRD);
+}
+
+struct userformat_want {
+	unsigned notes:1;
+};
+
+void userformat_find_requirements(const char *fmt, struct userformat_want *w);
+void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
+			struct strbuf *sb);
+void pp_user_info(struct pretty_print_context *pp, const char *what,
+			struct strbuf *sb, const char *line,
+			const char *encoding);
+void pp_title_line(struct pretty_print_context *pp, const char **msg_p,
+			struct strbuf *sb, const char *encoding,
+			int need_8bit_cte);
+void pp_remainder(struct pretty_print_context *pp, const char **msg_p,
+			struct strbuf *sb, int indent);
+
+void format_commit_message(const struct commit *commit,
+			const char *format, struct strbuf *sb,
+			const struct pretty_print_context *context);
+
+void get_commit_format(const char *arg, struct rev_info *);
+
+void pretty_print_commit(struct pretty_print_context *pp,
+			const struct commit *commit,
+			struct strbuf *sb);
+
+const char *format_subject(struct strbuf *sb, const char *msg,
+			const char *line_separator);
+
+int commit_format_is_empty(enum cmit_fmt);
+
+#endif /* PRETTY_H */
diff --git a/revision.h b/revision.h
index 54761200adf2d..747bce8d8a184 100644
--- a/revision.h
+++ b/revision.h
@@ -4,7 +4,7 @@
 #include "parse-options.h"
 #include "grep.h"
 #include "notes.h"
-#include "commit.h"
+#include "pretty.h"
 #include "diff.h"
 
 /* Remember to update object flag allocation in object.h */

--
https://github.com/git/git/pull/439
