Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80EF9201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 01:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755500AbdKJBKR (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 20:10:17 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:48614 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755324AbdKJBKO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 20:10:14 -0500
Received: by mail-io0-f193.google.com with SMTP id d66so11896400ioe.5
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 17:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H/E5+J31hG0LshUz9BvG/B4K4f1i8WLXN1qdg5Obr+A=;
        b=TENAox2aNchClRGrO4HvtE3uVuiUoJbxeKK2P9DSMHZVX2BWIpxzjwwLzqSPZ/iVk/
         fFSDkxVvTBwpd9MExytuFFd1aDTkGGULaosHw8mx/QIrZmcFTB0WqEbh4oWIdSkyYdOZ
         JtLVsshA1uv1jtIJbt+zWVbBhlg5zJxBd+7crsdIw7p7y9nvHGsrLum35pEKmsN/9oNN
         Ry68ym5rTCDfM2g3DrNvV9rfzg/5rarqC+LO3XhYaGmPgtB1tQOSyX2b4RdJoCEOce7n
         AJkFSQrokgATv4gBnxzn83PmVnPjyXu/VJ+Hy+4syKh1TM5523nKyhl7nSPeS+N4Hiy0
         dbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H/E5+J31hG0LshUz9BvG/B4K4f1i8WLXN1qdg5Obr+A=;
        b=d8NYoyxkUZuKgUCveOHrpmNumtLMx9sUrd+zFjOu9qpy9bXqrIwCiETVlePwA7Rhoa
         yp3zR/9/5qlW8lBjjz1uNU/CjOHJAh8PejgwS8AZNHfqDQGOmml10Gf89+5QKMg+Dzu0
         tb20zd2doqO3jNDDWCtPvC6foAEJ9Pd/FOYz9h078X5x+dN5RBtBLV0m6+vhAmYRwpIB
         QtG1Yo6KLDcx/WSdVPOslroy4nw5pX051EmHcHQOk4IcN1jKSsDA0Upyh8HIc1GmyVIs
         rP8Grb0Eve3w0VT8aUEESroEHobaYXdXHr7ulZvWCKk/X8fbWjWbkn3kulps832+f/Kk
         98mw==
X-Gm-Message-State: AJaThX6VRqU5obChnMOdcWbaPRTb2H6TcHKZb99eCp49vRyt1pc9p9BL
        dKz2khwdUXrOZFpPAloqv4DLMVArwrQ=
X-Google-Smtp-Source: ABhQp+Qq3VxbGok8MUD1vL8MaWQxtoSyuoNMqoPlub9gQHHGr9zHJKT1hf/xrqWds8ShnQRe3382Lg==
X-Received: by 10.107.182.68 with SMTP id g65mr2799200iof.299.1510276213399;
        Thu, 09 Nov 2017 17:10:13 -0800 (PST)
Received: from localhost ([2620:0:100e:422:3816:f49a:2bf0:e33c])
        by smtp.gmail.com with ESMTPSA id e81sm4030178ioi.15.2017.11.09.17.10.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Nov 2017 17:10:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] builtin/blame: add option to color metadata fields separately
Date:   Thu,  9 Nov 2017 17:10:01 -0800
Message-Id: <20171110011002.10179-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171110011002.10179-1-sbeller@google.com>
References: <20171110011002.10179-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike the previous commit, this dims colors for each
metadata field individually.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/blame.c         | 82 +++++++++++++++++++++++++++++++++++++++++++------
 t/t8012-blame-colors.sh | 38 +++++++++++++++++++++++
 2 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index d15e901357..9d460597a2 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -323,6 +323,7 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 #define OUTPUT_SHOW_EMAIL	0400
 #define OUTPUT_LINE_PORCELAIN 	01000
 #define OUTPUT_COLOR_LINE	02000
+#define OUTPUT_COLOR_FIELDS	04000
 
 static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
@@ -370,6 +371,33 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 		putchar('\n');
 }
 
+static int had_same_field_previously(int opt, int field,
+			  struct blame_entry *ent,
+			  struct blame_entry *prev)
+{
+	struct commit_info ci, prev_ci;
+
+	switch (field) {
+	case OUTPUT_SHOW_SCORE:
+		return ent->score == prev->score;
+	case OUTPUT_SHOW_NAME:
+		return prev->suspect &&
+			!strcmp(ent->suspect->path, prev->suspect->path);
+	case OUTPUT_SHOW_NUMBER:
+		return ent->s_lno == prev->s_lno + prev->num_lines - 1;
+
+	case OUTPUT_NO_AUTHOR:
+		get_commit_info(ent->suspect->commit, &ci, 1);
+		get_commit_info(prev->suspect->commit, &prev_ci, 1);
+		return ((opt & OUTPUT_SHOW_EMAIL) &&
+			!strcmp(ci.author_mail.buf, prev_ci.author_mail.buf)) ||
+			!strcmp(ci.author.buf, prev_ci.author.buf);
+	default:
+		BUG("unknown field");
+	}
+	return 0;
+}
+
 static inline void colors_unset(const char **use_color, const char **reset_color)
 {
 	*use_color = "";
@@ -382,17 +410,36 @@ static inline void colors_set(const char **use_color, const char **reset_color)
 	*reset_color = GIT_COLOR_RESET;
 }
 
+static void setup_field_color(int opt, int cnt, int field,
+			      struct blame_entry *ent,
+			      struct blame_entry *prev,
+			      const char **use_color,
+			      const char **reset_color)
+{
+	if (!(opt & OUTPUT_COLOR_FIELDS))
+		return;
+
+	if ((cnt > 0 ||
+	     (prev && had_same_field_previously(opt, field, ent, prev))))
+		colors_set(use_color, reset_color);
+	else
+		colors_unset(use_color, reset_color);
+}
+
 static void setup_line_color(int opt, int cnt,
 			     const char **use_color,
 			     const char **reset_color)
 {
 	colors_unset(use_color, reset_color);
 
-	if ((opt & OUTPUT_COLOR_LINE) && cnt > 0)
+	if ((opt & (OUTPUT_COLOR_LINE | OUTPUT_COLOR_FIELDS)) && cnt > 0)
 		colors_set(use_color, reset_color);
 }
 
-static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
+static void emit_other(struct blame_scoreboard *sb,
+		       struct blame_entry *ent,
+		       struct blame_entry *prev,
+		       int opt)
 {
 	int cnt;
 	const char *cp;
@@ -432,18 +479,27 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 					   show_raw_time),
 			       ent->lno + 1 + cnt);
 		} else {
-			if (opt & OUTPUT_SHOW_SCORE)
+			if (opt & OUTPUT_SHOW_SCORE) {
+				setup_field_color(opt, cnt, OUTPUT_SHOW_SCORE,
+						  ent, prev, &col, &rcol);
 				printf(" %s%*d %02d%s", col,
 				       max_score_digits, ent->score,
 				       ent->suspect->refcnt, rcol);
-			if (opt & OUTPUT_SHOW_NAME)
+			}
+			if (opt & OUTPUT_SHOW_NAME) {
+				setup_field_color(opt, cnt, OUTPUT_SHOW_NAME,
+						   ent, prev, &col, &rcol);
 				printf(" %s%-*.*s%s", col, longest_file,
 						      longest_file,
 						      suspect->path,
 						      rcol);
-			if (opt & OUTPUT_SHOW_NUMBER)
+			}
+			if (opt & OUTPUT_SHOW_NUMBER) {
+				setup_field_color(opt, cnt, OUTPUT_SHOW_NUMBER,
+						  ent, prev, &col, &rcol);
 				printf(" %s%*d%s", col, max_orig_digits,
 				       ent->s_lno + 1 + cnt, rcol);
+			}
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
 				const char *name;
 				int pad;
@@ -452,6 +508,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 				else
 					name = ci.author.buf;
 				pad = longest_author - utf8_strwidth(name);
+				setup_field_color(opt, cnt, OUTPUT_NO_AUTHOR,
+						  ent, prev, &col, &rcol);
 				printf(" %s(%s%*s %10s%s", col,
 				       name, pad, "",
 				       format_time(ci.author_time,
@@ -477,7 +535,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 
 static void output(struct blame_scoreboard *sb, int option)
 {
-	struct blame_entry *ent;
+	struct blame_entry *ent, *prev = NULL;
 
 	if (option & OUTPUT_PORCELAIN) {
 		for (ent = sb->ent; ent; ent = ent->next) {
@@ -499,7 +557,8 @@ static void output(struct blame_scoreboard *sb, int option)
 		if (option & OUTPUT_PORCELAIN)
 			emit_porcelain(sb, ent, option);
 		else {
-			emit_other(sb, ent, option);
+			emit_other(sb, ent, prev, option);
+			prev = ent;
 		}
 	}
 }
@@ -717,6 +776,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line"), OUTPUT_COLOR_LINE),
+		OPT_BIT(0, "color-fields", &output_option, N_("color redundant metadata fields from previous line"), OUTPUT_COLOR_FIELDS),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -775,6 +835,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
 	argc = parse_options_end(&ctx);
 
+	if ((output_option & OUTPUT_COLOR_LINE) &&
+	    (output_option & OUTPUT_COLOR_FIELDS))
+		die(_("cannot ask for colored lines and fields at the same time"));
+
 	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
 		if (show_progress > 0)
 			die(_("--progress can't be used with --incremental or porcelain formats"));
@@ -978,8 +1042,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	if (!(output_option & OUTPUT_PORCELAIN)) {
 		find_alignment(&sb, &output_option);
-		if ((output_option & OUTPUT_COLOR_LINE) &&
-		    !repeated_meta_color)
+		if (!repeated_meta_color &&
+		    (output_option & (OUTPUT_COLOR_LINE | OUTPUT_COLOR_FIELDS)))
 			repeated_meta_color = GIT_COLOR_DARK;
 	}
 
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index b2de03b777..be491bde9a 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -15,4 +15,42 @@ test_expect_success 'colored blame colors continuous lines' '
 	test_line_count = 3 H.expect
 '
 
+test_expect_success 'colored blame colors continuous fields' '
+
+	git mv hello.c world.c &&
+	git commit -a -m "moved file" &&
+	cat <<-EOF >> world.c &&
+	void world()
+	{
+		puts("world");
+	}
+	EOF
+	git add world.c &&
+	GIT_AUTHOR_NAME="F" GIT_AUTHOR_EMAIL="F@test.git" \
+		git commit -m "forgot to add changes to moved file" &&
+
+	git blame --abbrev=12 --color-fields world.c >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+
+	grep "<BOLD;BLACK>hello.c" actual > colored_hello.expect &&
+	grep "hello.c" actual > all_hello.expect &&
+	test_line_count = 9 colored_hello.expect &&
+	test_line_count = 10 all_hello.expect &&
+
+	grep "<BOLD;BLACK>world.c" actual > colored_world.expect &&
+	grep "world.c" actual > all_world.expect &&
+	test_line_count = 3 colored_world.expect &&
+	test_line_count = 4 all_world.expect &&
+
+	grep "(F" actual > all_F.expect &&
+	grep "<BOLD;BLACK>(F" actual > colored_F.expect &&
+	test_line_count = 8 all_F.expect &&
+	test_line_count = 5 colored_F.expect &&
+
+	grep "(H" actual > all_H.expect &&
+	grep "<BOLD;BLACK>(H" actual > colored_H.expect &&
+	test_line_count = 5 all_H.expect &&
+	test_line_count = 3 colored_H.expect
+'
+
 test_done
-- 
2.15.0.128.gcadd42da22

