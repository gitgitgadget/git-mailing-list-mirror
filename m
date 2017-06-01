Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6E220D12
	for <e@80x24.org>; Thu,  1 Jun 2017 00:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbdFAAYi (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 20:24:38 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32810 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdFAAYg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 20:24:36 -0400
Received: by mail-pf0-f173.google.com with SMTP id e193so21514164pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 17:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4mMw3iYpyfH1ugvMYddP+uflH8jpVnuOcHsbF9/xDXI=;
        b=hyot+MO3CAiSMTjMmWeBsTTilxtS2c1dwS4yEpJ/aTap/3Gzzxo5Th3MkDUf0pXo/e
         7PKNHRxwh8rS65C1bdGxLgCqDqZM55B7LsuH0e7bG7l7cS7o8H6ZNwK51LxYz6eTPZ6w
         ygTzvJoRf6GkL4rlYr5vx3hjJ1aIR5ELG0IEbS/O0Qm+0DAIQJTiN+zMGB0SeYDQD8FK
         JNhvL2uVzEGt/QFjEuqZBYcKQhik7QOiMybdQqBY8Sdqlj9iUDPFT9VvIFwf8fbHsfx9
         Q/kVOYFv3+ihlrllMJQr6yaqny7f5ennBhjaGUkJv37wXHB05hfRCuVktCZrJBuT+FI4
         aUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4mMw3iYpyfH1ugvMYddP+uflH8jpVnuOcHsbF9/xDXI=;
        b=OdVNioj7IbgjtS1dZrASkm2+kRGbD06a7sTbd7YAo3HHcvdfvyaaQWTFlrLBJMopYJ
         huyDYqBgtokgs56bjKuJJTIkoVIXAaPZrcgKzlbLvf8fOJNO8/pVL+JFDpKUErph+4SV
         WI9is7hT/XDk65/EyBDS/2FSgmT6QfmtpvNXpG4JbYqwybzbGnFKvIrDrAnCLYuBaRVT
         hWubcpbKOS9jvhb5p5+Tqf3OhIMXdwazqsx7uZV0dzRjUqto7rJPCZJYsnJWn3AJtuuh
         I1vkrv7NaQHJF3Vpr8HX531A3wpKRBykZ8DBa40s4UYxqk4RuZoAndjcytcAUHIWmwaH
         0wnw==
X-Gm-Message-State: AODbwcBnIWpyQIErYCpI7qcy/P+1/bz6JQyL39pj9/p0h3zvPOz/rKiz
        I9jXfC4CmXTX8m7h
X-Received: by 10.84.231.194 with SMTP id g2mr47487315pln.44.1496276675492;
        Wed, 31 May 2017 17:24:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7872:b8ac:87ee:2203])
        by smtp.gmail.com with ESMTPSA id w10sm34702094pge.48.2017.05.31.17.24.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 17:24:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH] diff.c: color moved lines differently
Date:   Wed, 31 May 2017 17:24:29 -0700
Message-Id: <20170601002429.3470-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gab62347cd9
In-Reply-To: <CAGZ79kbq3XiP8W_01FV133aMjZP9_GvpEg86N=XC2rTy24ZZGQ@mail.gmail.com>
References: <CAGZ79kbq3XiP8W_01FV133aMjZP9_GvpEg86N=XC2rTy24ZZGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a patch consists mostly of moving blocks of code around, it can
be quite tedious to ensure that the blocks are moved verbatim, and not
undesirably modified in the move. To that end, color blocks that are
moved within the same patch differently. For example (OM, del, add,
and NM are different colors):

    [OM]  -void sensitive_stuff(void)
    [OM]  -{
    [OM]  -        if (!is_authorized_user())
    [OM]  -                die("unauthorized");
    [OM]  -        sensitive_stuff(spanning,
    [OM]  -                        multiple,
    [OM]  -                        lines);
    [OM]  -}

           void another_function()
           {
    [del] -        printf("foo");
    [add] +        printf("bar");
           }

    [NM]  +void sensitive_stuff(void)
    [NM]  +{
    [NM]  +        if (!is_authorized_user())
    [NM]  +                die("unauthorized");
    [NM]  +        sensitive_stuff(spanning,
    [NM]  +                        multiple,
    [NM]  +                        lines);
    [NM]  +}

However adjacent blocks may be problematic. For example, in this
potentially malicious patch, the swapping of blocks can be spotted:

    [OM]  -void sensitive_stuff(void)
    [OM]  -{
    [OMA] -        if (!is_authorized_user())
    [OMA] -                die("unauthorized");
    [OM]  -        sensitive_stuff(spanning,
    [OM]  -                        multiple,
    [OM]  -                        lines);
    [OMA] -}

           void another_function()
           {
    [del] -        printf("foo");
    [add] +        printf("bar");
           }

    [NM]  +void sensitive_stuff(void)
    [NM]  +{
    [NMA] +        sensitive_stuff(spanning,
    [NMA] +                        multiple,
    [NMA] +                        lines);
    [NM]  +        if (!is_authorized_user())
    [NM]  +                die("unauthorized");
    [NMA] +}

If the moved code is larger, it is easier to hide some permutation in the
code, which is why some alternative coloring is needed.

As the reviewers attention should be brought to the places, where the
difference is introduced to the moved code, we cannot just have one new
color for all of moved code.

First I implemented an alternative design, which would try to fingerprint
a line by its neighbors to detect if we are in a block or at the boundary.
This idea iss error prone as it inspected each line and its neighboring
lines to determine if the line was (a) moved and (b) if was deep inside
a hunk by having matching neighboring lines. This is unreliable as the
we can construct hunks which have equal neighbors that just exceed the
number of lines inspected. (Think of 'AXYZBXYZCXYZD..' with each letter
as a line, that is permutated to AXYZCXYZBXYZD..').

Instead this provides a dynamic programming greedy algorithm that finds
the largest moved hunk and then has several modes on highlighting bounds.

A note on the options '--submodule=diff' and '--color-words/--word-diff':
In the conversion to use emit_line in the prior patches both submodules
as well as word diff output carefully chose to call emit_line with sign=0.
All output with sign=0 is ignored for move detection purposes in this
patch, such that no weird looking output will be generated for these
cases. This leads to another thought: We could pass on '--color-moved' to
submodules such that they color up moved lines for themselves. If we'd do
so only line moves within a repository boundary are marked up.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Replacing the top commit in origin/sb/diff-color-move, 
 this has the spelling fixes by Philip.
 
 Also a minor fix for the 'alternate' mode, to go back to the default
 after empty lines. Thanks to Jacob.
 
 Thanks,
 Stefan

 Documentation/config.txt       |  10 +-
 Documentation/diff-options.txt |  32 ++++
 color.h                        |   2 +
 diff.c                         | 343 +++++++++++++++++++++++++++++++++++--
 diff.h                         |  15 +-
 t/t4015-diff-whitespace.sh     | 373 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 761 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..73511a4603 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1051,14 +1051,20 @@ This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
 
+diff.colorMoved::
+	If set moved lines in a diff are colored differently,
+	for details see '--color-moved' in linkgit:git-diff[1].
+
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
 	of `context` (context text - `plain` is a historical synonym),
 	`meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
-	`new` (added lines), `commit` (commit headers), or `whitespace`
-	(highlighting whitespace errors).
+	`new` (added lines), `commit` (commit headers), `whitespace`
+	(highlighting whitespace errors), `oldMoved`, `newMoved`,
+	`oldMovedAlternative` and `newMovedAlternative` (See the '<mode>'
+	setting of '--color-moved' in linkgit:git-diff[1] for details).
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 89cc0f48de..69bf061c5c 100644
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
+	Any line that is added in one location and was removed
+	in another location will be colored with 'color.diff.newmoved'.
+	Similarly 'color.diff.oldmoved' will be used for removed lines
+	that are added somewhere else in the diff.
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
index a3c16ef827..a1f919ba57 100644
--- a/diff.c
+++ b/diff.c
@@ -31,6 +31,7 @@ static int diff_indent_heuristic; /* experimental */
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
+static int diff_color_moved_default;
 static int diff_context_default = 3;
 static int diff_interhunk_context_default;
 static const char *diff_word_regex_cfg;
@@ -55,6 +56,10 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
+	GIT_COLOR_DI_IT_MAGENTA,/* OLD_MOVED */
+	GIT_COLOR_BG_RED,	/* OLD_MOVED ALTERNATIVE */
+	GIT_COLOR_DI_IT_CYAN,	/* NEW_MOVED */
+	GIT_COLOR_BG_GREEN,	/* NEW_MOVED ALTERNATIVE */
 };
 
 static NORETURN void die_want_option(const char *option_name)
@@ -80,6 +85,14 @@ static int parse_diff_color_slot(const char *var)
 		return DIFF_WHITESPACE;
 	if (!strcasecmp(var, "func"))
 		return DIFF_FUNCINFO;
+	if (!strcasecmp(var, "oldmoved"))
+		return DIFF_FILE_OLD_MOVED;
+	if (!strcasecmp(var, "oldmovedalternative"))
+		return DIFF_FILE_OLD_MOVED_ALT;
+	if (!strcasecmp(var, "newmoved"))
+		return DIFF_FILE_NEW_MOVED;
+	if (!strcasecmp(var, "newmovedalternative"))
+		return DIFF_FILE_NEW_MOVED_ALT;
 	return -1;
 }
 
@@ -228,12 +241,35 @@ int git_diff_heuristic_config(const char *var, const char *value, void *cb)
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
+	if (!strcmp(var, "diff.colormoved")) {
+		int cm = parse_color_moved(value);
+		if (cm < 0)
+			return -1;
+		diff_color_moved_default = cm;
+		return 0;
+	}
 	if (!strcmp(var, "diff.context")) {
 		diff_context_default = git_config_int(var, value);
 		if (diff_context_default < 0)
@@ -354,6 +390,88 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+struct moved_entry {
+	struct hashmap_entry ent;
+	const struct diff_line *line;
+	struct moved_entry *next_line;
+};
+
+static void get_ws_cleaned_string(const struct diff_line *l,
+				  struct strbuf *out)
+{
+	int i;
+	for (i = 0; i < l->len; i++) {
+		if (isspace(l->line[i]))
+			continue;
+		strbuf_addch(out, l->line[i]);
+	}
+}
+
+static int diff_line_cmp_no_ws(const struct diff_line *a,
+					 const struct diff_line *b,
+					 const void *keydata)
+{
+	int ret;
+	struct strbuf sba = STRBUF_INIT;
+	struct strbuf sbb = STRBUF_INIT;
+
+	get_ws_cleaned_string(a, &sba);
+	get_ws_cleaned_string(b, &sbb);
+	ret = sba.len != sbb.len || strncmp(sba.buf, sbb.buf, sba.len);
+
+	strbuf_release(&sba);
+	strbuf_release(&sbb);
+	return ret;
+}
+
+static int diff_line_cmp(const struct diff_line *a,
+				   const struct diff_line *b,
+				   const void *keydata)
+{
+	return a->len != b->len || strncmp(a->line, b->line, a->len);
+}
+
+static int moved_entry_cmp(const struct moved_entry *a,
+			   const struct moved_entry *b,
+			   const void *keydata)
+{
+	return diff_line_cmp(a->line, b->line, keydata);
+}
+
+static int moved_entry_cmp_no_ws(const struct moved_entry *a,
+				 const struct moved_entry *b,
+				 const void *keydata)
+{
+	return diff_line_cmp_no_ws(a->line, b->line, keydata);
+}
+
+static unsigned get_line_hash(struct diff_line *line, unsigned ignore_ws)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	if (ignore_ws) {
+		strbuf_reset(&sb);
+		get_ws_cleaned_string(line, &sb);
+		return memhash(sb.buf, sb.len);
+	} else {
+		return memhash(line->line, line->len);
+	}
+}
+
+static struct moved_entry *prepare_entry(struct diff_options *o,
+					 int line_no)
+{
+	struct moved_entry *ret = xmalloc(sizeof(*ret));
+	unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
+	struct diff_line *l = &o->line_buffer[line_no];
+
+	ret->ent.hash = get_line_hash(l, ignore_ws);
+	ret->line = l;
+	ret->next_line = NULL;
+
+	return ret;
+}
+
 static char *quote_two(const char *one, const char *two)
 {
 	int need_one = quote_c_style(one, NULL, NULL, 1);
@@ -516,6 +634,180 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
+static void add_lines_to_move_detection(struct diff_options *o,
+					struct hashmap *add_lines,
+					struct hashmap *del_lines)
+{
+	struct moved_entry *prev_line = NULL;
+
+	int n;
+	for (n = 0; n < o->line_buffer_nr; n++) {
+		int sign = 0;
+		struct hashmap *hm;
+		struct moved_entry *key;
+
+		switch (o->line_buffer[n].sign) {
+		case '+':
+			sign = '+';
+			hm = add_lines;
+			break;
+		case '-':
+			sign = '-';
+			hm = del_lines;
+			break;
+		case ' ':
+		default:
+			prev_line = NULL;
+			continue;
+		}
+
+		key = prepare_entry(o, n);
+		if (prev_line &&
+		    prev_line->line->sign == sign)
+			prev_line->next_line = key;
+
+		hashmap_add(hm, key);
+		prev_line = key;
+	}
+}
+
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
+static void mark_color_as_moved(struct diff_options *o,
+				struct hashmap *add_lines,
+				struct hashmap *del_lines)
+{
+	struct moved_entry **pmb = NULL; /* potentially moved blocks */
+	struct diff_line *prev_line = NULL;
+	int pmb_nr = 0, pmb_alloc = 0;
+	int n, flipped_block = 0;
+
+	for (n = 0; n < o->line_buffer_nr; n++) {
+		struct hashmap *hm = NULL;
+		struct moved_entry *key;
+		struct moved_entry *match = NULL;
+		struct diff_line *l = &o->line_buffer[n];
+		int i, lp, rp, adjacent_blocks = 0;
+
+		/* Check for any match to color it as a move. */
+		switch (l->sign) {
+		case '+':
+			hm = del_lines;
+			key = prepare_entry(o, n);
+			match = hashmap_get(hm, key, o);
+			free(key);
+			break;
+		case '-':
+			hm = add_lines;
+			key = prepare_entry(o, n);
+			match = hashmap_get(hm, key, o);
+			free(key);
+			break;
+		default: ;
+			flipped_block = 0;
+		}
+
+		if (!match) {
+			pmb_nr = 0;
+			if (prev_line &&
+			    o->color_moved == MOVED_LINES_BOUNDARY_ALL)
+				mark_color_as_moved_single_line(o, prev_line, 1);
+			prev_line = NULL;
+			continue;
+		}
+
+		if (o->color_moved == MOVED_LINES_BOUNDARY_NO) {
+			mark_color_as_moved_single_line(o, l, 0);
+			continue;
+		}
+
+		/* Check any potential block runs, advance each or nullify */
+		for (i = 0; i < pmb_nr; i++) {
+			struct moved_entry *p = pmb[i];
+			struct moved_entry *pnext = (p && p->next_line) ?
+					p->next_line : NULL;
+			if (pnext &&
+			    !diff_line_cmp(pnext->line, l, o)) {
+				pmb[i] = p->next_line;
+			} else {
+				pmb[i] = NULL;
+			}
+		}
+
+		/* Shrink the set of potential block to the remaining running */
+		for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
+			while (lp < pmb_nr && pmb[lp])
+				lp++;
+			/* lp points at the first NULL now */
+
+			while (rp > -1 && !pmb[rp])
+				rp--;
+			/* rp points at the last non-NULL */
+
+			if (lp < pmb_nr && rp > -1 && lp < rp) {
+				pmb[lp] = pmb[rp];
+				pmb[rp] = NULL;
+				rp--;
+				lp++;
+			}
+		}
+
+		/* Remember the number of running sets */
+		pmb_nr = rp + 1;
+
+		if (pmb_nr == 0) {
+			/*
+			 * This line is the start of a new block.
+			 * Setup the set of potential blocks.
+			 */
+			for (; match; match = hashmap_get_next(hm, match)) {
+				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
+				pmb[pmb_nr++] = match;
+			}
+
+			if (o->color_moved == MOVED_LINES_BOUNDARY_ALL) {
+				adjacent_blocks = 1;
+			} else {
+				/* Check if two blocks are adjacent */
+				adjacent_blocks = prev_line &&
+						  prev_line->sign == l->sign;
+			}
+		}
+
+		if (o->color_moved == MOVED_LINES_ALTERNATE) {
+			if (adjacent_blocks)
+				flipped_block = (flipped_block + 1) % 2;
+			mark_color_as_moved_single_line(o, l, flipped_block);
+		} else {
+			/* MOVED_LINES_BOUNDARY_{ADJACENT, ALL} */
+			mark_color_as_moved_single_line(o, l, adjacent_blocks);
+			if (adjacent_blocks && prev_line)
+				prev_line->set = l->set;
+		}
+
+		prev_line = l;
+	}
+	if (prev_line && o->color_moved == MOVED_LINES_BOUNDARY_ALL)
+		mark_color_as_moved_single_line(o, prev_line, 1);
+
+	free(pmb);
+}
+
 static void emit_diff_line(struct diff_options *o,
 			   struct diff_line *e)
 {
@@ -3518,6 +3810,8 @@ void diff_setup(struct diff_options *options)
 	options->line_buffer = NULL;
 	options->line_buffer_nr = 0;
 	options->line_buffer_alloc = 0;
+
+	options->color_moved = diff_color_moved_default;
 }
 
 void diff_setup_done(struct diff_options *options)
@@ -3627,6 +3921,9 @@ void diff_setup_done(struct diff_options *options)
 
 	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
 		die(_("--follow requires exactly one pathspec"));
+
+	if (!options->use_color || external_diff())
+		options->color_moved = 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -4051,7 +4348,19 @@ int diff_opt_parse(struct diff_options *options,
 	}
 	else if (!strcmp(arg, "--no-color"))
 		options->use_color = 0;
-	else if (!strcmp(arg, "--color-words")) {
+	else if (!strcmp(arg, "--color-moved"))
+		if (diff_color_moved_default)
+			options->color_moved = diff_color_moved_default;
+		else
+			options->color_moved = MOVED_LINES_BOUNDARY_ADJACENT;
+	else if (!strcmp(arg, "--no-color-moved"))
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
@@ -4856,16 +5165,9 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	/*
-	 * For testing purposes we want to make sure the diff machinery
-	 * works completely with the buffer. If there is anything emitted
-	 * outside the emit_diff_line, then the order is screwed
-	 * up and the tests will fail.
-	 *
-	 * TODO (later in this series):
-	 * We'll unset this flag in a later patch.
-	 */
-	o->use_buffer = 1;
+
+	if (o->color_moved)
+		o->use_buffer = 1;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -4874,6 +5176,24 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	}
 
 	if (o->use_buffer) {
+		if (o->color_moved) {
+			struct hashmap add_lines, del_lines;
+			unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
+
+			hashmap_init(&del_lines, ignore_ws ?
+				(hashmap_cmp_fn)moved_entry_cmp_no_ws :
+				(hashmap_cmp_fn)moved_entry_cmp, 0);
+			hashmap_init(&add_lines, ignore_ws ?
+				(hashmap_cmp_fn)moved_entry_cmp_no_ws :
+				(hashmap_cmp_fn)moved_entry_cmp, 0);
+
+			add_lines_to_move_detection(o, &add_lines, &del_lines);
+			mark_color_as_moved(o, &add_lines, &del_lines);
+
+			hashmap_free(&add_lines, 0);
+			hashmap_free(&del_lines, 0);
+		}
+
 		for (i = 0; i < o->line_buffer_nr; i++)
 			emit_diff_line(o, &o->line_buffer[i]);
 
@@ -4962,6 +5282,7 @@ void diff_flush(struct diff_options *options)
 		if (!options->file)
 			die_errno("Could not open /dev/null");
 		options->close_file = 1;
+		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
diff --git a/diff.h b/diff.h
index be51e8f867..d9fbafd383 100644
--- a/diff.h
+++ b/diff.h
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "pathspec.h"
 #include "object.h"
+#include "hashmap.h"
 
 struct rev_info;
 struct diff_options;
@@ -228,6 +229,14 @@ struct diff_options {
 
 	struct diff_line *line_buffer;
 	int line_buffer_nr, line_buffer_alloc;
+
+	enum {
+		MOVED_LINES_NO = 0,
+		MOVED_LINES_BOUNDARY_NO = 1,
+		MOVED_LINES_BOUNDARY_ALL = 2,
+		MOVED_LINES_BOUNDARY_ADJACENT = 3,
+		MOVED_LINES_ALTERNATE = 4,
+	} color_moved;
 };
 
 /* Emit [line_prefix] [set] line [reset] */
@@ -243,7 +252,11 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
 	DIFF_WHITESPACE = 7,
-	DIFF_FUNCINFO = 8
+	DIFF_FUNCINFO = 8,
+	DIFF_FILE_OLD_MOVED = 9,
+	DIFF_FILE_OLD_MOVED_ALT = 10,
+	DIFF_FILE_NEW_MOVED = 11,
+	DIFF_FILE_NEW_MOVED_ALT = 12
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 289806d0c7..e7b821be0a 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -972,4 +972,377 @@ test_expect_success 'option overrides diff.wsErrorHighlight' '
 
 '
 
+test_expect_success 'detect moved code, complete file' '
+	git reset --hard &&
+	cat <<-\EOF >test.c &&
+	#include<stdio.h>
+	main()
+	{
+	printf("Hello World");
+	}
+	EOF
+	git add test.c &&
+	git commit -m "add main function" &&
+	git mv test.c main.c &&
+	test_config color.diff.oldMoved "normal red" &&
+	test_config color.diff.newMoved "normal green" &&
+	git diff HEAD --color-moved --no-renames | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/main.c b/main.c<RESET>
+	<BOLD>new file mode 100644<RESET>
+	<BOLD>index 0000000..a986c57<RESET>
+	<BOLD>--- /dev/null<RESET>
+	<BOLD>+++ b/main.c<RESET>
+	<CYAN>@@ -0,0 +1,5 @@<RESET>
+	<BGREEN>+<RESET><BGREEN>#include<stdio.h><RESET>
+	<BGREEN>+<RESET><BGREEN>main()<RESET>
+	<BGREEN>+<RESET><BGREEN>{<RESET>
+	<BGREEN>+<RESET><BGREEN>printf("Hello World");<RESET>
+	<BGREEN>+<RESET><BGREEN>}<RESET>
+	<BOLD>diff --git a/test.c b/test.c<RESET>
+	<BOLD>deleted file mode 100644<RESET>
+	<BOLD>index a986c57..0000000<RESET>
+	<BOLD>--- a/test.c<RESET>
+	<BOLD>+++ /dev/null<RESET>
+	<CYAN>@@ -1,5 +0,0 @@<RESET>
+	<BRED>-#include<stdio.h><RESET>
+	<BRED>-main()<RESET>
+	<BRED>-{<RESET>
+	<BRED>-printf("Hello World");<RESET>
+	<BRED>-}<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
+test_expect_success 'detect moved code, inside file' '
+	git reset --hard &&
+	cat <<-\EOF >main.c &&
+		#include<stdio.h>
+		int stuff()
+		{
+			printf("Hello ");
+			printf("World\n");
+		}
+
+		int secure_foo(struct user *u)
+		{
+			if (!u->is_allowed_foo)
+				return;
+			foo(u);
+		}
+
+		int main()
+		{
+			foo();
+		}
+	EOF
+	cat <<-\EOF >test.c &&
+		#include<stdio.h>
+		int bar()
+		{
+			printf("Hello World, but different\n");
+		}
+
+		int another_function()
+		{
+			bar();
+		}
+	EOF
+	git add main.c test.c &&
+	git commit -m "add main and test file" &&
+	cat <<-\EOF >main.c &&
+		#include<stdio.h>
+		int stuff()
+		{
+			printf("Hello ");
+			printf("World\n");
+		}
+
+		int main()
+		{
+			foo();
+		}
+	EOF
+	cat <<-\EOF >test.c &&
+		#include<stdio.h>
+		int bar()
+		{
+			printf("Hello World, but different\n");
+		}
+
+		int secure_foo(struct user *u)
+		{
+			if (!u->is_allowed_foo)
+				return;
+			foo(u);
+		}
+
+		int another_function()
+		{
+			bar();
+		}
+	EOF
+	test_config color.diff.oldMoved "normal red" &&
+	test_config color.diff.newMoved "normal green" &&
+	test_config color.diff.oldMovedAlternative "bold red" &&
+	test_config color.diff.newMovedAlternative "bold green" &&
+	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/main.c b/main.c<RESET>
+	<BOLD>index 27a619c..7cf9336 100644<RESET>
+	<BOLD>--- a/main.c<RESET>
+	<BOLD>+++ b/main.c<RESET>
+	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
+	 printf("World\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<BRED>-int secure_foo(struct user *u)<RESET>
+	<BRED>-{<RESET>
+	<BRED>-if (!u->is_allowed_foo)<RESET>
+	<BRED>-return;<RESET>
+	<BRED>-foo(u);<RESET>
+	<BRED>-}<RESET>
+	<BRED>-<RESET>
+	 int main()<RESET>
+	 {<RESET>
+	 foo();<RESET>
+	<BOLD>diff --git a/test.c b/test.c<RESET>
+	<BOLD>index 1dc1d85..e34eb69 100644<RESET>
+	<BOLD>--- a/test.c<RESET>
+	<BOLD>+++ b/test.c<RESET>
+	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
+	 printf("Hello World, but different\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
+	<BGREEN>+<RESET><BGREEN>{<RESET>
+	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
+	<BGREEN>+<RESET><BGREEN>return;<RESET>
+	<BGREEN>+<RESET><BGREEN>foo(u);<RESET>
+	<BGREEN>+<RESET><BGREEN>}<RESET>
+	<BGREEN>+<RESET>
+	 int another_function()<RESET>
+	 {<RESET>
+	 bar();<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
+test_expect_success 'detect permutations inside moved code' '
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
+	EOF
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
+
+
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
+	EOF
+	test_cmp expected actual &&
+
+	test_config diff.colorMoved alternate &&
+	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
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
+	<CYAN>+<RESET><CYAN>line 3<RESET>
+	<YELLOW>+<RESET><YELLOW>line 14<RESET>
+	<YELLOW>+<RESET><YELLOW>line 15<RESET>
+	<YELLOW>+<RESET><YELLOW>line 16<RESET>
+	 line 10<RESET>
+	 line 11<RESET>
+	 line 12<RESET>
+	 line 13<RESET>
+	<MAGENTA>-line 14<RESET>
+	<MAGENTA>-line 15<RESET>
+	<MAGENTA>-line 16<RESET>
+	EOF
+	test_cmp expected actual &&
+
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
+	test_cmp expected actual
+'
+
+test_expect_success 'move detection does not mess up colored words' '
+	cat <<-\EOF >text.txt &&
+	Lorem Ipsum is simply dummy text of the printing and typesetting industry.
+	EOF
+	git add text.txt &&
+	git commit -a -m "clean state" &&
+	cat <<-\EOF >text.txt &&
+	simply Lorem Ipsum dummy is text of the typesetting and printing industry.
+	EOF
+	git diff --color-moved --word-diff >actual &&
+	git diff --word-diff >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'move detection with submodules' '
+	test_create_repo bananas &&
+	echo ripe >bananas/recipe &&
+	git -C bananas add recipe &&
+	test_commit fruit &&
+	test_commit -C bananas recipe &&
+	git submodule add ./bananas &&
+	git add bananas &&
+	git commit -a -m "bananas are like a heavy library?" &&
+	echo foul >bananas/recipe &&
+	echo ripe >fruit.t &&
+
+	git diff --submodule=diff --color-moved >actual &&
+
+	# no move detection as the moved line is across repository boundaries.
+	test_decode_color <actual >decoded_actual &&
+	! grep BGREEN decoded_actual &&
+	! grep BRED decoded_actual &&
+
+	# nor did we mess with it another way
+	git diff --submodule=diff | test_decode_color >expect &&
+	test_cmp expect decoded_actual
+'
+
 test_done
-- 
2.13.0.17.gab62347cd9

