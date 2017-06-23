Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769AD2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 01:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbdFWB3b (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:31 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34568 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbdFWB33 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:29 -0400
Received: by mail-pf0-f169.google.com with SMTP id s66so16550391pfs.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nx17AlmbXKpHyt6WdtkPAhAe+H252oVvoxLgOmj2cqE=;
        b=AKK7JP9Kf8jK1gBCTkZSSgRZonn1phN/qMCHJzf7jj+97BuV32MvegV8g9PtMTlmp7
         cB0OTZIA4aDiVpmyTW7jRuZvvtwWvI/naPBGyIcZSqXBqoShp1AreTymGvrIB0KZdvFl
         Pn1PlIbdjFvG8X2xR92uKH0ung6ZfqLypunz8cBxUB3uVU72nYNsO7bCK0KIgIh1c+3d
         K/epaDUMeiF3qudm41SbZaJZ7CtZwIvcDG+27pfBdJKTP9nNUDD3yKkN/QzqIa2SJE0l
         Uk0E+xzz7w6n3N3Z5KLynqLnEySSNmDKD7HAwQppjyiKVx7dn5d5PiU3XabePr9c8lir
         olXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nx17AlmbXKpHyt6WdtkPAhAe+H252oVvoxLgOmj2cqE=;
        b=fSnAMDs7Am9JQpscA6AoauNV0js2Nmrf7W+1QSt+kVthNH2m8+8sYpB7XtYIDFEq1w
         PfdHc3AP2Hk3FiwxBPKN9wZ8YBO7Zyc3V5JzA/88Id5unYp11+TD2TBd6a3S0IV2ZZK3
         zrKfaeOMeFhOE+UMK2yeGCJ3LZ4BP9bwcbRwYBdRgRlIwHWsKvFsgI7m1MNRMsxxZF1x
         I9N1pXqFqNYYJNj6jIP1GNs5Dvp6ht+WejVuximZYao3Slg0eS3lShiXsW0WSAYNz2ru
         KapGoLRuIq9g8xfKGJ9SpdV8aL2Q/SigGMRNyynWdGXkPlHKgxeQojbwICNSWaZX9c+T
         9hgQ==
X-Gm-Message-State: AKS2vOwHwyH8KoelX9dGXlW7YTY/GLYCjN7omzfAIToUJoLOvxV5JUdy
        rSVwztfrBY5FXOQX
X-Received: by 10.84.177.195 with SMTP id x61mr5969506plb.44.1498181368919;
        Thu, 22 Jun 2017 18:29:28 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id g78sm6066851pfb.122.2017.06.22.18.29.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 00/25] reroll of sb/diff-color-moved
Date:   Thu, 22 Jun 2017 18:28:54 -0700
Message-Id: <20170623012919.28693-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* addressed all issues raised
* last patch dropped (WIP/RFC: diff.c: have a "machine parseable" move coloring)
* interdiff below

v1:
This is a complete rewrite of the series. Highlights:
* instead of buffering partial lines, we'll pretend all diff output
  follows a well defined grammar, and we emit symbols thereof.
  (The difference is mostly mental, though by this trick we reduce
  the memory footprint for storing one of these symbols from 7 variables
  (3 pointers, 3 ints, one state (also int) down to 4 variables
  (one pointer, 2 ints, one state).
* The algorithm for color painting was detangled:
  -> different functions for block detection and dimming
  -> The last patch (not to be applied) is an RFC that shows
     how we would approach non-colored, but machine parseable highlighting
     of moved lines.

Thanks,
Stefan

Stefan Beller (25):
  diff.c: readability fix
  diff.c: move line ending check into emit_hunk_header
  diff.c: factor out diff_flush_patch_all_file_pairs
  diff.c: introduce emit_diff_symbol
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
  diff.c: migrate emit_line_checked to use emit_diff_symbol
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
  diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
  submodule.c: migrate diff output to use emit_diff_symbol
  diff.c: convert emit_binary_diff_body to use emit_diff_symbol
  diff.c: convert show_stats to use emit_diff_symbol
  diff.c: convert word diffing to use emit_diff_symbol
  diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
  diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
  diff.c: buffer all output if asked to
  diff.c: color moved lines differently
  diff.c: color moved lines differently, plain mode
  diff.c: add dimming to moved line detection
  diff: document the new --color-moved setting

 Documentation/config.txt       |   12 +-
 Documentation/diff-options.txt |   27 +
 cache.h                        |    2 +
 color.h                        |    2 +
 diff.c                         | 1270 ++++++++++++++++++++++++++++++++--------
 diff.h                         |   37 +-
 submodule.c                    |   85 ++-
 submodule.h                    |   13 +-
 t/t4015-diff-whitespace.sh     |  369 ++++++++++++
 9 files changed, 1501 insertions(+), 316 deletions(-)

diff to what is currently queued:
diff --git a/cache.h b/cache.h
index 4d63c44f07..d2204bf6d1 100644
--- a/cache.h
+++ b/cache.h
@@ -2168,6 +2168,7 @@ void shift_tree_by(const struct object_id *, const struct object_id *, struct ob
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
 #define WS_TAB_WIDTH_MASK        077
+/* All WS_* -- when extended, adapt diff.c emit_symbol */
 #define WS_RULE_MASK           07777
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
diff --git a/color.h b/color.h
index 0e091b0cf5..fd2b688dfb 100644
--- a/color.h
+++ b/color.h
@@ -42,8 +42,8 @@ struct strbuf;
 #define GIT_COLOR_BG_BLUE	"\033[44m"
 #define GIT_COLOR_BG_MAGENTA	"\033[45m"
 #define GIT_COLOR_BG_CYAN	"\033[46m"
-#define GIT_COLOR_DI		"\033[2m"
-#define GIT_COLOR_DI_IT		"\033[2;3m"
+#define GIT_COLOR_FAINT		"\033[2m"
+#define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
 
 /* A special value meaning "no color selected" */
 #define GIT_COLOR_NIL "NIL"
diff --git a/diff.c b/diff.c
index 7756f7610c..82ace48c38 100644
--- a/diff.c
+++ b/diff.c
@@ -59,12 +59,12 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
 	GIT_COLOR_BOLD_MAGENTA,	/* OLD_MOVED */
 	GIT_COLOR_BOLD_BLUE,	/* OLD_MOVED ALTERNATIVE */
-	GIT_COLOR_DI,		/* OLD_MOVED_DIM */
-	GIT_COLOR_DI_IT,	/* OLD_MOVED_ALTERNATIVE_DIM */
+	GIT_COLOR_FAINT,	/* OLD_MOVED_DIM */
+	GIT_COLOR_FAINT_ITALIC,	/* OLD_MOVED_ALTERNATIVE_DIM */
 	GIT_COLOR_BOLD_CYAN,	/* NEW_MOVED */
 	GIT_COLOR_BOLD_YELLOW,	/* NEW_MOVED ALTERNATIVE */
-	GIT_COLOR_DI,		/* NEW_MOVED_DIM */
-	GIT_COLOR_DI_IT,	/* NEW_MOVED_ALTERNATIVE_DIM */
+	GIT_COLOR_FAINT,	/* NEW_MOVED_DIM */
+	GIT_COLOR_FAINT_ITALIC,	/* NEW_MOVED_ALTERNATIVE_DIM */
 };
 
 static NORETURN void die_want_option(const char *option_name)
@@ -607,32 +607,11 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
-	DIFF_SYMBOL_SEPARATOR,
-	DIFF_SYMBOL_CONTEXT_MARKER,
-	DIFF_SYMBOL_CONTEXT_FRAGINFO,
-	DIFF_SYMBOL_NO_LF_EOF,
-	DIFF_SYMBOL_CONTEXT,
-	DIFF_SYMBOL_CONTEXT_INCOMPLETE,
-	DIFF_SYMBOL_PLUS,
-	DIFF_SYMBOL_MINUS,
-	DIFF_SYMBOL_WORDS_PORCELAIN,
-	DIFF_SYMBOL_WORDS,
-	DIFF_SYMBOL_FILEPAIR,
-	DIFF_SYMBOL_HEADER,
-	DIFF_SYMBOL_BINARY_FILES,
 	DIFF_SYMBOL_BINARY_DIFF_HEADER,
 	DIFF_SYMBOL_BINARY_DIFF_HEADER_DELTA,
 	DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL,
 	DIFF_SYMBOL_BINARY_DIFF_BODY,
 	DIFF_SYMBOL_BINARY_DIFF_FOOTER,
-	DIFF_SYMBOL_REWRITE_DIFF,
-	DIFF_SYMBOL_SUBMODULE_ADD,
-	DIFF_SYMBOL_SUBMODULE_DEL,
-	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
-	DIFF_SYMBOL_SUBMODULE_MODIFIED,
-	DIFF_SYMBOL_SUBMODULE_HEADER,
-	DIFF_SYMBOL_SUBMODULE_ERROR,
-	DIFF_SYMBOL_SUBMODULE_PIPETHROUGH,
 	DIFF_SYMBOL_STATS_SUMMARY_NO_FILES,
 	DIFF_SYMBOL_STATS_SUMMARY_ABBREV,
 	DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
@@ -640,6 +619,28 @@ enum diff_symbol {
 	DIFF_SYMBOL_WORD_DIFF,
 	DIFF_SYMBOL_STAT_SEP,
 	DIFF_SYMBOL_SUMMARY,
+	DIFF_SYMBOL_SUBMODULE_ADD,
+	DIFF_SYMBOL_SUBMODULE_DEL,
+	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
+	DIFF_SYMBOL_SUBMODULE_MODIFIED,
+	DIFF_SYMBOL_SUBMODULE_HEADER,
+	DIFF_SYMBOL_SUBMODULE_ERROR,
+	DIFF_SYMBOL_SUBMODULE_PIPETHROUGH,
+	DIFF_SYMBOL_REWRITE_DIFF,
+	DIFF_SYMBOL_BINARY_FILES,
+	DIFF_SYMBOL_HEADER,
+	DIFF_SYMBOL_FILEPAIR_PLUS,
+	DIFF_SYMBOL_FILEPAIR_MINUS,
+	DIFF_SYMBOL_WORDS_PORCELAIN,
+	DIFF_SYMBOL_WORDS,
+	DIFF_SYMBOL_CONTEXT,
+	DIFF_SYMBOL_CONTEXT_INCOMPLETE,
+	DIFF_SYMBOL_PLUS,
+	DIFF_SYMBOL_MINUS,
+	DIFF_SYMBOL_NO_LF_EOF,
+	DIFF_SYMBOL_CONTEXT_FRAGINFO,
+	DIFF_SYMBOL_CONTEXT_MARKER,
+	DIFF_SYMBOL_SEPARATOR
 };
 /*
  * Flags for content lines:
@@ -649,7 +650,7 @@ enum diff_symbol {
  */
 #define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<16)
 #define DIFF_SYMBOL_MOVED_LINE			(1<<17)
-#define DIFF_SYMBOL_MOVED_LINE_ZEBRA		(1<<18)
+#define DIFF_SYMBOL_MOVED_LINE_ALT		(1<<18)
 #define DIFF_SYMBOL_MOVED_LINE_UNINTERESTING	(1<<19)
 #define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
 
@@ -898,14 +899,14 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		if (flipped_block)
-			l->flags |= DIFF_SYMBOL_MOVED_LINE_ZEBRA;
+			l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
 	}
 
 	free(pmb);
 }
 
 #define DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK \
-  (DIFF_SYMBOL_MOVED_LINE | DIFF_SYMBOL_MOVED_LINE_ZEBRA)
+  (DIFF_SYMBOL_MOVED_LINE | DIFF_SYMBOL_MOVED_LINE_ALT)
 static void dim_moved_lines(struct diff_options *o)
 {
 	int n;
@@ -949,12 +950,12 @@ static void dim_moved_lines(struct diff_options *o)
 
 		/* Check if we are at an interesting bound: */
 		if (prev && (prev->flags & DIFF_SYMBOL_MOVED_LINE) &&
-		    (prev->flags & DIFF_SYMBOL_MOVED_LINE_ZEBRA) !=
-		       (l->flags & DIFF_SYMBOL_MOVED_LINE_ZEBRA))
+		    (prev->flags & DIFF_SYMBOL_MOVED_LINE_ALT) !=
+		       (l->flags & DIFF_SYMBOL_MOVED_LINE_ALT))
 			continue;
 		if (next && (next->flags & DIFF_SYMBOL_MOVED_LINE) &&
-		    (next->flags & DIFF_SYMBOL_MOVED_LINE_ZEBRA) !=
-		       (l->flags & DIFF_SYMBOL_MOVED_LINE_ZEBRA))
+		    (next->flags & DIFF_SYMBOL_MOVED_LINE_ALT) !=
+		       (l->flags & DIFF_SYMBOL_MOVED_LINE_ALT))
 			continue;
 
 		/*
@@ -1004,25 +1005,33 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	unsigned flags = eds->flags;
 
 	switch (s) {
-	case DIFF_SYMBOL_SEPARATOR:
-		fprintf(o->file, "%s%c",
-			diff_line_prefix(o),
-			o->line_termination);
-		break;
-	case DIFF_SYMBOL_CONTEXT_MARKER:
+	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		emit_line(o, context, reset, line, len);
+		putc('\n', o->file);
+		emit_line_0(o, context, reset, '\\',
+			    nneof, strlen(nneof));
 		break;
+	case DIFF_SYMBOL_SUBMODULE_HEADER:
+	case DIFF_SYMBOL_SUBMODULE_ERROR:
+	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
+	case DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES:
+	case DIFF_SYMBOL_SUMMARY:
+	case DIFF_SYMBOL_STATS_LINE:
+	case DIFF_SYMBOL_BINARY_DIFF_BODY:
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
 		emit_line(o, "", "", line, len);
 		break;
-	case DIFF_SYMBOL_NO_LF_EOF:
+	case DIFF_SYMBOL_CONTEXT_INCOMPLETE:
+	case DIFF_SYMBOL_CONTEXT_MARKER:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		putc('\n', o->file);
-		emit_line_0(o, context, reset, '\\',
-			    nneof, strlen(nneof));
+		emit_line(o, context, reset, line, len);
+		break;
+	case DIFF_SYMBOL_SEPARATOR:
+		fprintf(o->file, "%s%c",
+			diff_line_prefix(o),
+			o->line_termination);
 		break;
 	case DIFF_SYMBOL_CONTEXT:
 		set = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -1030,22 +1039,17 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		emit_line_ws_markup(o, set, reset, line, len, ' ',
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
-	case DIFF_SYMBOL_CONTEXT_INCOMPLETE:
-		context = diff_get_color_opt(o, DIFF_CONTEXT);
-		reset = diff_get_color_opt(o, DIFF_RESET);
-		emit_line(o, context, reset, line, len);
-		break;
 	case DIFF_SYMBOL_PLUS:
 		switch (flags & (DIFF_SYMBOL_MOVED_LINE |
-				 DIFF_SYMBOL_MOVED_LINE_ZEBRA |
+				 DIFF_SYMBOL_MOVED_LINE_ALT |
 				 DIFF_SYMBOL_MOVED_LINE_UNINTERESTING)) {
 		case DIFF_SYMBOL_MOVED_LINE |
-		     DIFF_SYMBOL_MOVED_LINE_ZEBRA |
+		     DIFF_SYMBOL_MOVED_LINE_ALT |
 		     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
 			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED_ALT_DIM);
 			break;
 		case DIFF_SYMBOL_MOVED_LINE |
-		     DIFF_SYMBOL_MOVED_LINE_ZEBRA:
+		     DIFF_SYMBOL_MOVED_LINE_ALT:
 			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED_ALT);
 			break;
 		case DIFF_SYMBOL_MOVED_LINE |
@@ -1065,15 +1069,15 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		break;
 	case DIFF_SYMBOL_MINUS:
 		switch (flags & (DIFF_SYMBOL_MOVED_LINE |
-				 DIFF_SYMBOL_MOVED_LINE_ZEBRA |
+				 DIFF_SYMBOL_MOVED_LINE_ALT |
 				 DIFF_SYMBOL_MOVED_LINE_UNINTERESTING)) {
 		case DIFF_SYMBOL_MOVED_LINE |
-		     DIFF_SYMBOL_MOVED_LINE_ZEBRA |
+		     DIFF_SYMBOL_MOVED_LINE_ALT |
 		     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
 			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_ALT_DIM);
 			break;
 		case DIFF_SYMBOL_MOVED_LINE |
-		     DIFF_SYMBOL_MOVED_LINE_ZEBRA:
+		     DIFF_SYMBOL_MOVED_LINE_ALT:
 			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_ALT);
 			break;
 		case DIFF_SYMBOL_MOVED_LINE |
@@ -1110,20 +1114,23 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		}
 		emit_line(o, context, reset, line, len);
 		break;
-	case DIFF_SYMBOL_FILEPAIR:
+	case DIFF_SYMBOL_FILEPAIR_PLUS:
 		meta = diff_get_color_opt(o, DIFF_METAINFO);
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		fprintf(o->file, "%s%s%s%s%s%s\n", diff_line_prefix(o), meta,
-			flags ? "+++ " : "--- ",
+		fprintf(o->file, "%s%s+++ %s%s%s\n", diff_line_prefix(o), meta,
 			line, reset,
 			strchr(line, ' ') ? "\t" : "");
 		break;
-	case DIFF_SYMBOL_HEADER:
-		fprintf(o->file, "%s", line);
+	case DIFF_SYMBOL_FILEPAIR_MINUS:
+		meta = diff_get_color_opt(o, DIFF_METAINFO);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		fprintf(o->file, "%s%s--- %s%s%s\n", diff_line_prefix(o), meta,
+			line, reset,
+			strchr(line, ' ') ? "\t" : "");
 		break;
 	case DIFF_SYMBOL_BINARY_FILES:
-		fprintf(o->file, "%sBinary files %s differ\n",
-			diff_line_prefix(o), line);
+	case DIFF_SYMBOL_HEADER:
+		fprintf(o->file, "%s", line);
 		break;
 	case DIFF_SYMBOL_BINARY_DIFF_HEADER:
 		fprintf(o->file, "%sGIT binary patch\n", diff_line_prefix(o));
@@ -1134,9 +1141,6 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	case DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL:
 		fprintf(o->file, "%sliteral %s\n", diff_line_prefix(o), line);
 		break;
-	case DIFF_SYMBOL_BINARY_DIFF_BODY:
-		emit_line(o, "", "", line, len);
-		break;
 	case DIFF_SYMBOL_BINARY_DIFF_FOOTER:
 		fputs(diff_line_prefix(o), o->file);
 		fputc('\n', o->file);
@@ -1164,36 +1168,19 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		fprintf(o->file, "%sSubmodule %s contains modified content\n",
 			diff_line_prefix(o), line);
 		break;
-	case DIFF_SYMBOL_SUBMODULE_HEADER:
-		fprintf(o->file, "%s%s", diff_line_prefix(o), line);
-		break;
-	case DIFF_SYMBOL_SUBMODULE_ERROR:
-		emit_line(o, "", "", line, len);
-		break;
-	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
-		emit_line(o, "", "", line, len);
-		break;
 	case DIFF_SYMBOL_STATS_SUMMARY_NO_FILES:
-		fprintf(o->file, " 0 files changed\n");
+		emit_line(o, "", "", " 0 files changed\n",
+			  strlen(" 0 files changed\n"));
 		break;
 	case DIFF_SYMBOL_STATS_SUMMARY_ABBREV:
 		emit_line(o, "", "", " ...\n", strlen(" ...\n"));
 		break;
-	case DIFF_SYMBOL_STATS_LINE:
-		emit_line(o, "", "", line, len);
-		break;
-	case DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES:
-		emit_line(o, "", "", line, len);
-		break;
 	case DIFF_SYMBOL_WORD_DIFF:
 		fprintf(o->file, "%.*s", len, line);
 		break;
 	case DIFF_SYMBOL_STAT_SEP:
 		fputs(o->stat_sep, o->file);
 		break;
-	case DIFF_SYMBOL_SUMMARY:
-		emit_line(o, "", "", line, len);
-		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -1460,8 +1447,10 @@ static void emit_rewrite_diff(const char *name_a,
 	lc_a = count_lines(data_one, size_one);
 	lc_b = count_lines(data_two, size_two);
 
-	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR, a_name.buf, a_name.len, 0);
-	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR, b_name.buf, b_name.len, 1);
+	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_MINUS,
+			 a_name.buf, a_name.len, 0);
+	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_PLUS,
+			 b_name.buf, b_name.len, 0);
 
 	strbuf_addstr(&out, "@@ -");
 	if (!o->irreversible_delete)
@@ -1983,12 +1972,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 
 	if (ecbdata->label_path[0]) {
-		emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR,
+		emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_MINUS,
 				 ecbdata->label_path[0],
 				 strlen(ecbdata->label_path[0]), 0);
-		emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR,
+		emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_PLUS,
 				 ecbdata->label_path[1],
-				 strlen(ecbdata->label_path[1]), 1);
+				 strlen(ecbdata->label_path[1]), 0);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
@@ -3159,7 +3148,8 @@ static void builtin_diff(const char *name_a,
 			}
 			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
 					 header.buf, header.len, 0);
-			strbuf_addf(&sb, "%s and %s", lbl[0], lbl[1]);
+			strbuf_addf(&sb, "%sBinary files %s and %s differ\n",
+				    diff_line_prefix(o), lbl[0], lbl[1]);
 			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
 					 sb.buf, sb.len, 0);
 			strbuf_release(&sb);
@@ -3180,7 +3170,8 @@ static void builtin_diff(const char *name_a,
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o, &mf1, &mf2);
 		else {
-			strbuf_addf(&sb, "%s and %s", lbl[0], lbl[1]);
+			strbuf_addf(&sb, "%sBinary files %s and %s differ\n",
+				    diff_line_prefix(o), lbl[0], lbl[1]);
 			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
 					 sb.buf, sb.len, 0);
 			strbuf_release(&sb);
@@ -5475,6 +5466,9 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	static struct emitted_diff_symbols esm = EMITTED_DIFF_SYMBOLS_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
+	if (WSEH_NEW & WS_RULE_MASK)
+		die("BUG: WS rules bit mask overlaps with diff symbol flags");
+
 	if (o->color_moved)
 		o->emitted_symbols = &esm;
 


-- 
2.12.2.575.gb14f27f917

