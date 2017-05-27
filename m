Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 468CB1FA14
	for <e@80x24.org>; Sat, 27 May 2017 01:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756742AbdE0BLz (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 21:11:55 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36488 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948878AbdE0ASZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 20:18:25 -0400
Received: by mail-pg0-f52.google.com with SMTP id x64so400552pgd.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fp3dAFnopl/dAgUYZhufyc2t1Z/R7XJo86se9V+LVaM=;
        b=hGwYYjWAyfuMmuNBZbtN6dpcaHzU+F/4MlzqBVEmnLwdsZk4tCvYBL36zBtR9Cp5Pa
         FeBji8+NJnOwReLlXF3sSWkCKyOg5BEWcHFj2xJS+0nYKga5uuz8qjLXI0lpT4+tuemt
         kcHa1YmgSccTXyiUAcnUrHY3FGz1bTfSNKScT40O+dJOICGOwntYao6x6A5u5pVJPGVo
         LznCy3o1Din0k8/LF/hBREGJjBesKRqAXRKElRV7BS7IqTT7ydMUbvlBeE0ReJ+57od7
         qXG10V4WIKj3jNyVy51TuHgsWdvSLhcbQhs7uiuvXO+OEPS9Xgs3WuoHHnwmjSAOiqzj
         tk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fp3dAFnopl/dAgUYZhufyc2t1Z/R7XJo86se9V+LVaM=;
        b=Z+F1etb1lpXMU1q2s5XgqBUhV71H8zQMNRgPs2u7oVDqnyNI73SmEy4iAdro2FJ4V1
         h6Lbdzfw6M++C4a4GNlr+f7UakYQTMfb7L8E7F/w3LcxPlSe+Xx9TCuZaYIa+KmZDzla
         2l5biPtVRy6bV51u8uuvRoTS9qcbDVjV3+SfmrOwpj4qaal5SJHka2lMp+XDaoaKL/I4
         5Sea6qm+hlNMWTUEAhPdlgLHxWPqbs1S91Zv82z4UIiOBwG2y3dy1AUEr4gJY+nmia47
         H9ynKSB117TzIBH+KEfZe12lw9/qoe4j6jgNbPFqKU+VJHIu9s8BwfQktJDBGnigZjDs
         OUmg==
X-Gm-Message-State: AODbwcAbbt2SfMs9a8JvyHm4LKGlUhul8JXQqqdlhiNndVi0jR6xXVep
        B9yrDOglZ25+ul5e
X-Received: by 10.84.218.7 with SMTP id q7mr59881563pli.80.1495844303899;
        Fri, 26 May 2017 17:18:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:818a:1f3a:57c6:8d29])
        by smtp.gmail.com with ESMTPSA id g75sm3382777pfd.83.2017.05.26.17.18.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 17:18:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        peff@peff.net, mhagger@alum.mit.edu, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/1] Diff machine: highlight moved lines.
Date:   Fri, 26 May 2017 17:18:19 -0700
Message-Id: <20170527001820.25214-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gab62347cd9
In-Reply-To: <CAGZ79kbD6QggYH9+M8FM0Khg7Cs0egJR6Jm+kMJkscaANV6UXA@mail.gmail.com>
References: <CAGZ79kbD6QggYH9+M8FM0Khg7Cs0egJR6Jm+kMJkscaANV6UXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a new version of the latest patch of sb/diff-color-move.

It seems as if different people prefer different settings for the
boundary/alternate coloring, so let's have all of them. (As the
block detection is rather simple we do not need a lot of overhead
to support multiple modes).

With more tests:
 * for each mode;
 * check that diff.colorMoved is respected
 
And it is documented as well.

Thanks,
Stefan

Stefan Beller (1):
  diff.c: color moved lines differently

 Documentation/config.txt       |  10 +-
 Documentation/diff-options.txt |  32 ++++
 color.h                        |   2 +
 diff.c                         | 342 +++++++++++++++++++++++++++++++++++--
 diff.h                         |  15 +-
 t/t4015-diff-whitespace.sh     | 373 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 760 insertions(+), 14 deletions(-)

Interdiff to what Junio has queued:
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 902d017c3b..73511a4603 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1051,12 +1051,9 @@ This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
 
-color.moved::
-	A boolean value, whether a diff should color moved lines
-	differently. The moved lines are searched for in the diff only.
-	Duplicated lines from somewhere in the project that are not
-	part of the diff are not colored as moved.
-	Defaults to false.
+diff.colorMoved::
+	If set moved lines in a diff are colored differently,
+	for details see '--color-moved' in linkgit:git-diff[1].
 
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
@@ -1065,10 +1062,9 @@ color.diff.<slot>::
 	`meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
 	`new` (added lines), `commit` (commit headers), `whitespace`
-	(highlighting whitespace errors), `oldMoved` (removed lines that
-	reappear), `newMoved` (added lines that were removed elsewhere),
-	`oldMovedAlternative` and `newMovedAlternative` (as a fallback to
-	cover adjacent blocks of moved code)
+	(highlighting whitespace errors), `oldMoved`, `newMoved`,
+	`oldMovedAlternative` and `newMovedAlternative` (See the '<mode>'
+	setting of '--color-moved' in linkgit:git-diff[1] for details).
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 89cc0f48de..25259dbbc3 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -231,6 +231,38 @@ ifdef::git-diff[]
 endif::git-diff[]
 	It is the same as `--color=never`.
 
+--color-moved[=<mode>]::
+	Moved lines of code are colored differently.
+ifdef::git-diff[]
+	It can be changed by the `diff.colorMoved` configuration setting.
+endif::git-diff[]
+	The <mode> defaults to 'no' if the option is not given
+	and to 'adjacentbounds' if the option with no mode is given.
+	The mode must be one of:
++
+--
+no::
+	Moved lines are not highlighted.
+nobounds::
+	Any line that is added in on location and was removed
+	in another location will be colored with 'color.diff.newmoved'.
+	Any line that is removed in on location and was added
+	in another location will be colored with 'color.diff.oldmoved'.
+allbounds::
+	Based on 'nobounds'. Additionally blocks of moved code are
+	detected and the first and last line of a block will be highlighted
+	using 'color.diff.newMovedAlternate' or
+	'color.diff.oldMovedAlternate'.
+adjacentbounds::
+	The same as 'allbounds' except that highlighting is only performed
+	at adjacent block boundaries of blocks that have the same sign.
+alternate::
+	Based on 'nobounds'. Additionally blocks of moved code are
+	detected. If moved blocks are adjacent mark one of them with the
+	alternative move color using 'color.diff.newMovedAlternate' or
+	'color.diff.oldMovedAlternate'.
+--
+
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
diff --git a/color.h b/color.h
index 90627650fc..04b3b87929 100644
--- a/color.h
+++ b/color.h
@@ -42,6 +42,8 @@ struct strbuf;
 #define GIT_COLOR_BG_BLUE	"\033[44m"
 #define GIT_COLOR_BG_MAGENTA	"\033[45m"
 #define GIT_COLOR_BG_CYAN	"\033[46m"
+#define GIT_COLOR_DI_IT_CYAN	"\033[2;3;36m"
+#define GIT_COLOR_DI_IT_MAGENTA	"\033[2;3;35m"
 
 /* A special value meaning "no color selected" */
 #define GIT_COLOR_NIL "NIL"
diff --git a/diff.c b/diff.c
index 40cccafb67..efd2530a89 100644
--- a/diff.c
+++ b/diff.c
@@ -56,10 +56,10 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
-	GIT_COLOR_BOLD_RED,	/* OLD_MOVED_A */
-	GIT_COLOR_BG_RED,	/* OLD_MOVED_B */
-	GIT_COLOR_BOLD_GREEN,	/* NEW_MOVED_A */
-	GIT_COLOR_BG_GREEN,	/* NEW_MOVED_B */
+	GIT_COLOR_DI_IT_MAGENTA,/* OLD_MOVED */
+	GIT_COLOR_BG_RED,	/* OLD_MOVED ALTERNATIVE */
+	GIT_COLOR_DI_IT_CYAN,	/* NEW_MOVED */
+	GIT_COLOR_BG_GREEN,	/* NEW_MOVED ALTERNATIVE */
 };
 
 static NORETURN void die_want_option(const char *option_name)
@@ -241,14 +241,33 @@ int git_diff_heuristic_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static int parse_color_moved(const char *arg)
+{
+	if (!strcmp(arg, "no"))
+		return MOVED_LINES_NO;
+	else if (!strcmp(arg, "nobounds"))
+		return MOVED_LINES_BOUNDARY_NO;
+	else if (!strcmp(arg, "allbounds"))
+		return MOVED_LINES_BOUNDARY_ALL;
+	else if (!strcmp(arg, "adjacentbounds"))
+		return MOVED_LINES_BOUNDARY_ADJACENT;
+	else if (!strcmp(arg, "alternate"))
+		return MOVED_LINES_ALTERNATE;
+	else
+		return -1;
+}
+
 int git_diff_ui_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		diff_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "color.moved")) {
-		diff_color_moved_default = git_config_bool(var, value);
+	if (!strcmp(var, "diff.colormoved")) {
+		int cm = parse_color_moved(value);
+		if (cm < 0)
+			return -1;
+		diff_color_moved_default = cm;
 		return 0;
 	}
 	if (!strcmp(var, "diff.context")) {
@@ -652,41 +671,69 @@ static void add_lines_to_move_detection(struct diff_options *o,
 	}
 }
 
+static void mark_color_as_moved_single_line(struct diff_options *o,
+					    struct diff_line *l, int alt_color)
+{
+	switch (l->sign) {
+	case '+':
+		l->set = diff_get_color_opt(o,
+			DIFF_FILE_NEW_MOVED + alt_color);
+		break;
+	case '-':
+		l->set = diff_get_color_opt(o,
+			DIFF_FILE_OLD_MOVED + alt_color);
+		break;
+	default:
+		die("BUG: we should have continued earlier?");
+	}
+}
+
 static void mark_color_as_moved(struct diff_options *o,
 				struct hashmap *add_lines,
 				struct hashmap *del_lines)
 {
 	struct moved_entry **pmb = NULL; /* potentially moved blocks */
+	struct diff_line *prev_line = NULL;
 	int pmb_nr = 0, pmb_alloc = 0;
-	int use_alt_color = 0;
-	int n;
+	int n, flipped_block = 0;
 
 	for (n = 0; n < o->line_buffer_nr; n++) {
 		struct hashmap *hm = NULL;
 		struct moved_entry *key;
 		struct moved_entry *match = NULL;
 		struct diff_line *l = &o->line_buffer[n];
-		int i, lp, rp;
+		int i, lp, rp, adjacent_blocks = 0;
 
+		/* Check for any match to color it as a move. */
 		switch (l->sign) {
 		case '+':
 			hm = del_lines;
+			key = prepare_entry(o, n);
+			match = hashmap_get(hm, key, o);
+			free(key);
 			break;
 		case '-':
 			hm = add_lines;
+			key = prepare_entry(o, n);
+			match = hashmap_get(hm, key, o);
+			free(key);
 			break;
-		default:
-			use_alt_color = 0;
-			pmb_nr = 0; /* no running sets */
+		default: ;
+		}
+
+		if (!match) {
+			pmb_nr = 0;
+			if (prev_line &&
+			    o->color_moved == MOVED_LINES_BOUNDARY_ALL)
+				mark_color_as_moved_single_line(o, prev_line, 1);
+			prev_line = NULL;
 			continue;
 		}
 
-		/* Check for any match to color it as a move. */
-		key = prepare_entry(o, n);
-		match = hashmap_get(hm, key, o);
-		free(key);
-		if (!match)
+		if (o->color_moved == MOVED_LINES_BOUNDARY_NO) {
+			mark_color_as_moved_single_line(o, l, 0);
 			continue;
+		}
 
 		/* Check any potential block runs, advance each or nullify */
 		for (i = 0; i < pmb_nr; i++) {
@@ -701,7 +748,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			}
 		}
 
-		/* Shrink the set to the remaining runs */
+		/* Shrink the set of potential block to the remaining running */
 		for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
 			while (lp < pmb_nr && pmb[lp])
 				lp++;
@@ -719,34 +766,44 @@ static void mark_color_as_moved(struct diff_options *o,
 			}
 		}
 
-		if (rp > -1) {
-			/* Remember the number of running sets */
-			pmb_nr = rp + 1;
-		} else {
-			/* Toggle color */
-			use_alt_color = (use_alt_color + 1) % 2;
+		/* Remember the number of running sets */
+		pmb_nr = rp + 1;
 
-			/* Build up a new set */
-			pmb_nr = 0;
+		if (pmb_nr == 0) {
+			/*
+			 * This line is the start of a new block.
+			 * Setup the set of potential blocks.
+			 */
 			for (; match; match = hashmap_get_next(hm, match)) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 				pmb[pmb_nr++] = match;
 			}
+
+			if (o->color_moved == MOVED_LINES_BOUNDARY_ALL) {
+				adjacent_blocks = 1;
+			} else {
+				/* Check if two blocks are adjacent */
+				adjacent_blocks = prev_line &&
+						  prev_line->sign == l->sign;
+			}
 		}
 
-		switch (l->sign) {
-		case '+':
-			l->set = diff_get_color_opt(o,
-				DIFF_FILE_NEW_MOVED + use_alt_color);
-			break;
-		case '-':
-			l->set = diff_get_color_opt(o,
-				DIFF_FILE_OLD_MOVED + use_alt_color);
-			break;
-		default:
-			die("BUG: we should have continued earlier?");
+		if (o->color_moved == MOVED_LINES_ALTERNATE) {
+			if (adjacent_blocks)
+				flipped_block = (flipped_block + 1) % 2;
+			mark_color_as_moved_single_line(o, l, flipped_block);
+		} else {
+			/* MOVED_LINES_BOUNDARY_{ADJACENT, ALL} */
+			mark_color_as_moved_single_line(o, l, adjacent_blocks);
+			if (adjacent_blocks && prev_line)
+				prev_line->set = l->set;
 		}
+
+		prev_line = l;
 	}
+	if (prev_line && o->color_moved == MOVED_LINES_BOUNDARY_ALL)
+		mark_color_as_moved_single_line(o, prev_line, 1);
+
 	free(pmb);
 }
 
@@ -4291,10 +4348,18 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--no-color"))
 		options->use_color = 0;
 	else if (!strcmp(arg, "--color-moved"))
-		options->color_moved = 1;
+		if (diff_color_moved_default)
+			options->color_moved = diff_color_moved_default;
+		else
+			options->color_moved = MOVED_LINES_BOUNDARY_ADJACENT;
 	else if (!strcmp(arg, "--no-color-moved"))
-		options->color_moved = 0;
-	else if (!strcmp(arg, "--color-words")) {
+		options->color_moved = MOVED_LINES_NO;
+	else if (skip_prefix(arg, "--color-moved=", &arg)) {
+		int cm = parse_color_moved(arg);
+		if (cm < 0)
+			die("bad --color-moved argument: %s", arg);
+		options->color_moved = cm;
+	} else if (!strcmp(arg, "--color-words")) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
 	}
diff --git a/diff.h b/diff.h
index c6d806c6b5..d9fbafd383 100644
--- a/diff.h
+++ b/diff.h
@@ -230,7 +230,13 @@ struct diff_options {
 	struct diff_line *line_buffer;
 	int line_buffer_nr, line_buffer_alloc;
 
-	int color_moved;
+	enum {
+		MOVED_LINES_NO = 0,
+		MOVED_LINES_BOUNDARY_NO = 1,
+		MOVED_LINES_BOUNDARY_ALL = 2,
+		MOVED_LINES_BOUNDARY_ADJACENT = 3,
+		MOVED_LINES_ALTERNATE = 4,
+	} color_moved;
 };
 
 /* Emit [line_prefix] [set] line [reset] */
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 0e92bf94bf..d4bd082af7 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -984,6 +984,8 @@ test_expect_success 'detect moved code, complete file' '
 	git add test.c &&
 	git commit -m "add main function" &&
 	git mv test.c main.c &&
+	test_config color.diff.oldMoved "normal red" &&
+	test_config color.diff.newMoved "normal green" &&
 	git diff HEAD --color-moved --no-renames | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
@@ -1081,6 +1083,10 @@ test_expect_success 'detect moved code, inside file' '
 			bar();
 		}
 	EOF
+	test_config color.diff.oldMoved "normal red" &&
+	test_config color.diff.newMoved "normal green" &&
+	test_config color.diff.oldMovedAlternative "bold red" &&
+	test_config color.diff.newMovedAlternative "bold green" &&
 	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
@@ -1125,79 +1131,179 @@ test_expect_success 'detect moved code, inside file' '
 '
 
 test_expect_success 'detect permutations inside moved code' '
-	# reusing the move example from last test:
-	cat <<-\EOF >main.c &&
-		#include<stdio.h>
-		int stuff()
-		{
-			printf("Hello ");
-			printf("World\n");
-		}
-
-		int main()
-		{
-			foo();
-		}
+	git reset --hard &&
+	cat <<-\EOF >lines.txt &&
+		line 1
+		line 2
+		line 3
+		line 4
+		line 5
+		line 6
+		line 7
+		line 8
+		line 9
+		line 10
+		line 11
+		line 12
+		line 13
+		line 14
+		line 15
+		line 16
 	EOF
-	cat <<-\EOF >test.c &&
-		#include<stdio.h>
-		int bar()
-		{
-			printf("Hello World, but different\n");
-		}
+	git add lines.txt &&
+	git commit -m "add poetry" &&
+	cat <<-\EOF >lines.txt &&
+		line 4
+		line 5
+		line 6
+		line 7
+		line 8
+		line 9
+		line 1
+		line 2
+		line 3
+		line 14
+		line 15
+		line 16
+		line 10
+		line 11
+		line 12
+		line 13
+	EOF
+	test_config color.diff.oldMoved "magenta" &&
+	test_config color.diff.newMoved "cyan" &&
+	test_config color.diff.oldMovedAlternative "blue" &&
+	test_config color.diff.newMovedAlternative "yellow" &&
 
-		int secure_foo(struct user *u)
-		{
-			foo(u);
-			if (!u->is_allowed_foo)
-				return;
-		}
 
-		int another_function()
-		{
-			bar();
-		}
+	git diff HEAD --no-renames --color-moved=nobounds| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+		<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+		<BOLD>index 47ea9c3..ba96a38 100644<RESET>
+		<BOLD>--- a/lines.txt<RESET>
+		<BOLD>+++ b/lines.txt<RESET>
+		<CYAN>@@ -1,16 +1,16 @@<RESET>
+		<MAGENTA>-line 1<RESET>
+		<MAGENTA>-line 2<RESET>
+		<MAGENTA>-line 3<RESET>
+		 line 4<RESET>
+		 line 5<RESET>
+		 line 6<RESET>
+		 line 7<RESET>
+		 line 8<RESET>
+		 line 9<RESET>
+		<CYAN>+<RESET><CYAN>line 1<RESET>
+		<CYAN>+<RESET><CYAN>line 2<RESET>
+		<CYAN>+<RESET><CYAN>line 3<RESET>
+		<CYAN>+<RESET><CYAN>line 14<RESET>
+		<CYAN>+<RESET><CYAN>line 15<RESET>
+		<CYAN>+<RESET><CYAN>line 16<RESET>
+		 line 10<RESET>
+		 line 11<RESET>
+		 line 12<RESET>
+		 line 13<RESET>
+		<MAGENTA>-line 14<RESET>
+		<MAGENTA>-line 15<RESET>
+		<MAGENTA>-line 16<RESET>
+	EOF
+	test_cmp expected actual &&
+
+	git diff HEAD --no-renames --color-moved=adjacentbounds| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>index 47ea9c3..ba96a38 100644<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,16 +1,16 @@<RESET>
+	<MAGENTA>-line 1<RESET>
+	<MAGENTA>-line 2<RESET>
+	<MAGENTA>-line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	 line 6<RESET>
+	 line 7<RESET>
+	 line 8<RESET>
+	 line 9<RESET>
+	<CYAN>+<RESET><CYAN>line 1<RESET>
+	<CYAN>+<RESET><CYAN>line 2<RESET>
+	<YELLOW>+<RESET><YELLOW>line 3<RESET>
+	<YELLOW>+<RESET><YELLOW>line 14<RESET>
+	<CYAN>+<RESET><CYAN>line 15<RESET>
+	<CYAN>+<RESET><CYAN>line 16<RESET>
+	 line 10<RESET>
+	 line 11<RESET>
+	 line 12<RESET>
+	 line 13<RESET>
+	<MAGENTA>-line 14<RESET>
+	<MAGENTA>-line 15<RESET>
+	<MAGENTA>-line 16<RESET>
 	EOF
+	test_cmp expected actual &&
+
+	test_config diff.colorMoved alternate &&
 	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
 	cat <<-\EOF >expected &&
-	<BOLD>diff --git a/main.c b/main.c<RESET>
-	<BOLD>index 27a619c..7cf9336 100644<RESET>
-	<BOLD>--- a/main.c<RESET>
-	<BOLD>+++ b/main.c<RESET>
-	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
-	 printf("World\n");<RESET>
-	 }<RESET>
-	 <RESET>
-	<BRED>-int secure_foo(struct user *u)<RESET>
-	<BRED>-{<RESET>
-	<BOLD;RED>-if (!u->is_allowed_foo)<RESET>
-	<BOLD;RED>-return;<RESET>
-	<BRED>-foo(u);<RESET>
-	<BOLD;RED>-}<RESET>
-	<BOLD;RED>-<RESET>
-	 int main()<RESET>
-	 {<RESET>
-	 foo();<RESET>
-	<BOLD>diff --git a/test.c b/test.c<RESET>
-	<BOLD>index 1dc1d85..2bedec9 100644<RESET>
-	<BOLD>--- a/test.c<RESET>
-	<BOLD>+++ b/test.c<RESET>
-	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
-	 printf("Hello World, but different\n");<RESET>
-	 }<RESET>
-	 <RESET>
-	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
-	<BGREEN>+<RESET><BGREEN>{<RESET>
-	<BOLD;GREEN>+<RESET><BOLD;GREEN>foo(u);<RESET>
-	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
-	<BGREEN>+<RESET><BGREEN>return;<RESET>
-	<BOLD;GREEN>+<RESET><BOLD;GREEN>}<RESET>
-	<BOLD;GREEN>+<RESET>
-	 int another_function()<RESET>
-	 {<RESET>
-	 bar();<RESET>
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>index 47ea9c3..ba96a38 100644<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,16 +1,16 @@<RESET>
+	<MAGENTA>-line 1<RESET>
+	<MAGENTA>-line 2<RESET>
+	<MAGENTA>-line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	 line 6<RESET>
+	 line 7<RESET>
+	 line 8<RESET>
+	 line 9<RESET>
+	<CYAN>+<RESET><CYAN>line 1<RESET>
+	<CYAN>+<RESET><CYAN>line 2<RESET>
+	<CYAN>+<RESET><CYAN>line 3<RESET>
+	<YELLOW>+<RESET><YELLOW>line 14<RESET>
+	<YELLOW>+<RESET><YELLOW>line 15<RESET>
+	<YELLOW>+<RESET><YELLOW>line 16<RESET>
+	 line 10<RESET>
+	 line 11<RESET>
+	 line 12<RESET>
+	 line 13<RESET>
+	<BLUE>-line 14<RESET>
+	<BLUE>-line 15<RESET>
+	<BLUE>-line 16<RESET>
 	EOF
+	test_cmp expected actual &&
 
+	test_config diff.colorMoved allbounds &&
+	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>index 47ea9c3..ba96a38 100644<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,16 +1,16 @@<RESET>
+	<BLUE>-line 1<RESET>
+	<MAGENTA>-line 2<RESET>
+	<BLUE>-line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	 line 6<RESET>
+	 line 7<RESET>
+	 line 8<RESET>
+	 line 9<RESET>
+	<YELLOW>+<RESET><YELLOW>line 1<RESET>
+	<CYAN>+<RESET><CYAN>line 2<RESET>
+	<YELLOW>+<RESET><YELLOW>line 3<RESET>
+	<YELLOW>+<RESET><YELLOW>line 14<RESET>
+	<CYAN>+<RESET><CYAN>line 15<RESET>
+	<YELLOW>+<RESET><YELLOW>line 16<RESET>
+	 line 10<RESET>
+	 line 11<RESET>
+	 line 12<RESET>
+	 line 13<RESET>
+	<BLUE>-line 14<RESET>
+	<MAGENTA>-line 15<RESET>
+	<BLUE>-line 16<RESET>
+	EOF
 	test_cmp expected actual
 '
 



-- 
2.13.0.17.gab62347cd9

