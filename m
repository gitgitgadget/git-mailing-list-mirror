Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C5F7200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeECPb0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:31:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:40997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751484AbeECPbE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:31:04 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M3i8r-1eNOWj3AFF-00rJW5; Thu, 03 May 2018 17:31:01 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/18] diff: add an internal option to dual-color diffs of diffs
Date:   Thu,  3 May 2018 17:30:59 +0200
Message-Id: <153425de2df882395e0f54d0a8fb58b7298e9e1b.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6PPi4ZRqheOcraFyIT6qzTJbNO8t+JCuLwHtoQyfVDd+ClXBm2n
 TzO8Ol3/Vn4c9IvaQhxmK9K+wiGTLLrOEwYKHcJsrTszjvPsz7Z6pHxyvuhTVpPhUKRHVHV
 4QYGnicE59x1JiKoffk0SglWMR3poZerpZyP953n4i2jTW5hIvCHH1E06knV9BZUHI+4Y7/
 FPjX6t1rtkvye8sZvDdSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KpInd2TNksE=:S0Iv/kVnMmHruDNCLKc10R
 meY0oQH7Kp4QCbkUxXzfCtb0oI+CWnsVjAjHKtP4OQAQcb3IuFBOFwAhy+4v8zvGU+ep5bUds
 kI0Diyde1jBJ4FLq4CE6pyq4HAJ6b55dok/9GaJh/HOIA8QsU7pfSx00eNP5O7pqshWueD7Ug
 hwoAQELGXl3/7KknmIUNe/y3WVQCVsM6a2Pe32ut2Mc1jlq7nyA7MwZmwOJfuYXYm1dbU/fXW
 VxRiBSr6O+YNh+boeVLgiFjXG7z7Pmbf75xSP1GyKNXYcHsi0kvQf77xhfIlEvOpD0V1TZMIl
 nbq9nhanHfOihLRJwusuZ1Hp/f5YYkMKnH4DE8Rr1ykAzdbfc6+XTslp3Zapg3sb54LVbnkPt
 lG1/zhL7rnPW4UsBoPp32LqGZgTPYqIJUXNSWGtsye+d5SRWCLsUuIV/fz7X9na5i3vOC3BjL
 txsBbzJcY3MFy7uk2IM+Ilqs3xI0TFl5pMgVCFKCJWr/+YcSsj8JapaJShVhs3Q4USqlARZHo
 eR4nvmeXS+2LFezQXDZ7uNyYBF9WTPMKcitp6TDYfPIjfBqJriVYRBSNmf9wjiRPul5mhnbhd
 9q4yRldXIl2EER9yhYN4MQQp+gjbI6F2/4TC891kYaEzU99Osb+1/JtIkY6F+nc5KqoH2FUfY
 ePjxO5hesJ6Wq6u0eArXIb9THR8hNVenGULDDjmL2qFdm9C3KfWWCYe0OS24qGk+RRX7geOck
 oTktVDQlf8zWvK4Oamz2imvAf6WYRxN1RFWrYCz3GCtvFIArbtSk4DCWz2gw1chgswRZCe1ix
 g59A5Mt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When diffing diffs, it can be quite daunting to figure out what the heck
is going on, as there are nested +/- signs.

Let's make this easier by adding a flag in diff_options that allows
color-coding the outer diff sign with inverted colors, so that the
preimage and postimage is colored like the diff it is.

Of course, this really only makes sense when the preimage and postimage
*are* diffs. So let's not expose this flag via a command-line option for
now.

This is a feature that was invented by git-tbdiff, and it will be used
in `branch-diff` in the next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 diff.h |  5 ++++-
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index f1bda0db3f5..98a41e88620 100644
--- a/diff.c
+++ b/diff.c
@@ -67,6 +67,8 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_BOLD_YELLOW,	/* NEW_MOVED ALTERNATIVE */
 	GIT_COLOR_FAINT,	/* NEW_MOVED_DIM */
 	GIT_COLOR_FAINT_ITALIC,	/* NEW_MOVED_ALTERNATIVE_DIM */
+	GIT_COLOR_INV_RED,	/* OLD_INV */
+	GIT_COLOR_INV_GREEN,	/* NEW_INV */
 };
 
 static NORETURN void die_want_option(const char *option_name)
@@ -108,6 +110,10 @@ static int parse_diff_color_slot(const char *var)
 		return DIFF_FILE_NEW_MOVED_DIM;
 	if (!strcasecmp(var, "newmovedalternativedimmed"))
 		return DIFF_FILE_NEW_MOVED_ALT_DIM;
+	if (!strcasecmp(var, "oldinv"))
+		return DIFF_FILE_OLD_INV;
+	if (!strcasecmp(var, "newinv"))
+		return DIFF_FILE_NEW_INV;
 	return -1;
 }
 
@@ -577,7 +583,10 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 	int nofirst;
 	FILE *file = o->file;
 
-	fputs(diff_line_prefix(o), file);
+	if (first)
+		fputs(diff_line_prefix(o), file);
+	else if (!len)
+		return;
 
 	if (len == 0) {
 		has_trailing_newline = (first == '\n');
@@ -596,7 +605,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 
 	if (len || !nofirst) {
 		fputs(set, file);
-		if (!nofirst)
+		if (first && !nofirst)
 			fputc(first, file);
 		fwrite(line, len, 1, file);
 		fputs(reset, file);
@@ -970,7 +979,8 @@ static void dim_moved_lines(struct diff_options *o)
 
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set, const char *reset,
-				const char *line, int len, char sign,
+				const char *line, int len,
+				const char *set_sign, char sign,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
@@ -981,14 +991,18 @@ static void emit_line_ws_markup(struct diff_options *o,
 			ws = NULL;
 	}
 
-	if (!ws)
+	if (!ws && set_sign == set)
 		emit_line_0(o, set, reset, sign, line, len);
-	else if (blank_at_eof)
+	else if (!ws) {
+		/* Emit just the prefix, then the rest. */
+		emit_line_0(o, set_sign, reset, sign, "", 0);
+		emit_line_0(o, set, reset, 0, line, len);
+	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
 		emit_line_0(o, ws, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set, reset, sign, "", 0);
+		emit_line_0(o, set_sign, reset, sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
 	}
@@ -998,7 +1012,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 					 struct emitted_diff_symbol *eds)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set, *meta, *fraginfo;
+	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
 	struct strbuf sb = STRBUF_INIT;
 
 	enum diff_symbol s = eds->s;
@@ -1038,7 +1052,16 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	case DIFF_SYMBOL_CONTEXT:
 		set = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		emit_line_ws_markup(o, set, reset, line, len, ' ',
+		set_sign = set;
+		if (o->flags.dual_color_diffed_diffs) {
+			char c = !len ? 0 : line[0];
+
+			if (c == '+')
+				set = diff_get_color_opt(o, DIFF_FILE_NEW);
+			else if (c == '-')
+				set = diff_get_color_opt(o, DIFF_FILE_OLD);
+		}
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, ' ',
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1065,7 +1088,18 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			set = diff_get_color_opt(o, DIFF_FILE_NEW);
 		}
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		emit_line_ws_markup(o, set, reset, line, len, '+',
+		if (!o->flags.dual_color_diffed_diffs)
+			set_sign = set;
+		else {
+			char c = !len ? 0 : line[0];
+
+			set_sign = diff_get_color_opt(o, DIFF_FILE_NEW_INV);
+			if (c == '-')
+				set = diff_get_color_opt(o, DIFF_FILE_OLD);
+			else if (c != '+')
+				set = diff_get_color_opt(o, DIFF_CONTEXT);
+		}
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1093,7 +1127,18 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		emit_line_ws_markup(o, set, reset, line, len, '-',
+		if (!o->flags.dual_color_diffed_diffs)
+			set_sign = set;
+		else {
+			char c = !len ? 0 : line[0];
+
+			set_sign = diff_get_color_opt(o, DIFF_FILE_OLD_INV);
+			if (c == '+')
+				set = diff_get_color_opt(o, DIFF_FILE_NEW);
+			else if (c != '-')
+				set = diff_get_color_opt(o, DIFF_CONTEXT);
+		}
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, '-',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
diff --git a/diff.h b/diff.h
index 0dd6a71af60..c3e5d27967c 100644
--- a/diff.h
+++ b/diff.h
@@ -95,6 +95,7 @@ struct diff_flags {
 	unsigned default_follow_renames:1;
 	unsigned stat_with_summary:1;
 	unsigned suppress_diff_headers:1;
+	unsigned dual_color_diffed_diffs:1;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
@@ -242,7 +243,9 @@ enum color_diff {
 	DIFF_FILE_NEW_MOVED = 13,
 	DIFF_FILE_NEW_MOVED_ALT = 14,
 	DIFF_FILE_NEW_MOVED_DIM = 15,
-	DIFF_FILE_NEW_MOVED_ALT_DIM = 16
+	DIFF_FILE_NEW_MOVED_ALT_DIM = 16,
+	DIFF_FILE_OLD_INV = 17,
+	DIFF_FILE_NEW_INV = 18
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
-- 
2.17.0.395.g6a618d6010f.dirty


