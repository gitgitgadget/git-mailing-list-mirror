Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A03AB1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754759AbdL1VEJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 16:04:09 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:44552 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754737AbdL1VED (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 16:04:03 -0500
Received: by mail-io0-f193.google.com with SMTP id w127so39466533iow.11
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lvusn6ItssfrADLe47KnhHbelFQNLDnIrcQoERLXATA=;
        b=ho2D6MzQoalWxwG6fp3/VCuZW4ENnanGIR8g8cM3B1sengxOaDGDti4VDvq9Dirqvm
         oKzTvVj0wm0elEC7iQV92W5RB0OflmpCyMDt47elL722uefBbs4VHE2J3dfsotNhieil
         0dPRqCCuzDLf7MXhxaTt+s3matCybocN3WdjSBxMcaHZ/MAU89SFdSRtXFfGYdVHaTdi
         PNU50Dxq9RXqG1KbqKmhAkopjcAunbk6lv/AOKWdZMcr2YTQslbSZTtynGiXPDD6lnQP
         cV87agEvehGHKf8zM/c5U7fGNmHdxkx51Cbdm1IHG+iBVc4yj1DuXyow0d/kOYuGCplN
         dSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lvusn6ItssfrADLe47KnhHbelFQNLDnIrcQoERLXATA=;
        b=TgmhzGuAVgLOVxSmYkAdVdbmkkrf7X6QkfDsjHnfzfgxK+XOeG6YVNRslm4wzat9u3
         IrOiMTOKlhzGgc7lkU5WiSm1k8LGZXlNCQL+LFROMJnDcY66Xvgw1cv1DxGmZ4q1Zi7R
         zv+OIrZj1BNUr5Qr5w47ldItEDYpqqIncBL6cyfR7/M3gKI7po39MEmujkA3houn102w
         kT6zlu3JWmLc2pxB10Gz8nZLTGwgNb/5L8hMkHeSfE/gnWf5I7buzEMDfonB0WkvyoNi
         KdURx/YsYyWcm2gRkROo21D8Qv6gjsZgbAypctLPH6dhGUNqCU2fSA9d3qbuXMOGwHiG
         NZWw==
X-Gm-Message-State: AKGB3mJyq1NOJ3stkujAdKniR3YLkubva1Je4b7ZL6FZZqWOzzspOTT4
        sakPvmXwCligsO2iNynkmFzyjEjC8+E=
X-Google-Smtp-Source: ACJfBoulw0gb53LMtv0/qXy7B7AY27RH8rccZasYn7hE3PORfDy37c4aPom5Ta/oYTQBVrT4cWf0sQ==
X-Received: by 10.107.24.198 with SMTP id 189mr42660336ioy.213.1514495041848;
        Thu, 28 Dec 2017 13:04:01 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k23sm12350670iti.22.2017.12.28.13.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 13:04:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] builtin/blame: add option to color metadata fields separately
Date:   Thu, 28 Dec 2017 13:03:44 -0800
Message-Id: <20171228210345.205300-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171228210345.205300-1-sbeller@google.com>
References: <20171228210345.205300-1-sbeller@google.com>
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
index 09afb4d3ea..39e8c0b222 100644
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
 	revs.diffopt.flags.follow_renames = 0;
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
2.15.1.620.gb9897f4670-goog

