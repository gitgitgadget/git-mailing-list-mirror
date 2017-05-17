Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBCF02023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbdEQC7n (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:43 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:32940 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbdEQC7a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:30 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so89805624pfh.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OSwAvAGk8YyarLsXUb6ygfoJwsb42U4uF+BIwu5OKDE=;
        b=vraqjMbLRP7wxfecIZ+mqLfeDiml07w6pRL4KpnoSHsFEfrM99csOyuTB3xXlSsrsn
         FYJx8/wPgjRtPAhk5MJay4pV743epC1s8RheYEjMobD8NGzugFxe47hWCSVPwAUewUvJ
         QJUdKzZ+pfIUbZpc9dLPB7dZHq8O4sE+e/yjaR1oHQu0kxtDIZsapuSHADCqIOf26mI4
         sYiRWU5i1+cA+MHQz/IUEefMymij/TlT6oSB5r90GkgVXyG3BDrN07rJPiBq3SLk6TOf
         AuWnWr/B+B+aBZodxvSs00pn4sGmN8Qh/kFjZwGSiOUphVY0IRlpWlbYy+2LxKH7WvYX
         hw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OSwAvAGk8YyarLsXUb6ygfoJwsb42U4uF+BIwu5OKDE=;
        b=i/f2skMj/ChKfI2i2/oF8iyoDSX8eEu8o6snKxdhITm38vH5jKwCyQ/7C81oa0xKdl
         yw6DilGN+KPEdNd0k9QPc97zydBGIUo0HLwLdUiIThMNsx1iIYcy3cc4sRT+3Y8FnZhd
         aHaaMWegn86LB196GFYbYxCtTbsWgEGKDTfqnRv/O5pCiqbGBfxupOVQJiTcjVKjCkmW
         uXgERylPgmKB7JJ5SgW7OMjM6UGABrd7Dm/VFqaAylS3uv4wxpHvN0tKlC0NKojAYolA
         eymSLIVsMdP2mcz64AojfpHuIbA0R1Y9jeFjmGRjEkJo/537lFcGtoUttpHJmDnwx07y
         FAIg==
X-Gm-Message-State: AODbwcBAqyZXTWhObWJBg/JxjX2A3huHGzjmhJLuQLgNeis9qK6vsVyG
        xa+hoVEVq0Kg+5Ml
X-Received: by 10.99.114.72 with SMTP id c8mr1283418pgn.81.1494989968708;
        Tue, 16 May 2017 19:59:28 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id l67sm666261pfk.73.2017.05.16.19.59.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 20/20] diff.c: color moved lines differently
Date:   Tue, 16 May 2017 19:58:57 -0700
Message-Id: <20170517025857.32320-21-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there is a lot of code moved around such as in 11979b9 (2005-11-18,
"http.c: reorder to avoid compilation failure.") for example, the review
process is quite hard, as it is not mentally challenging.  It is a rather
tedious process, that gets boring quickly. However you still need to read
through all of the code to make sure the moved lines are there as supposed.

While it is trivial to color up a patch like the following

    $ git diff
    diff --git a/file2.c b/file2.c
    index 9163a0f..8e66dc0 100644
    --- a/file2.c
    +++ b/file2.c
    @@ -3,13 +3,6 @@ void *xmemdupz(const void *data, size_t len)
            return memcpy(xmallocz(len), data, len);
     }

    -int secure_foo(struct user *u)
    -{
    -       if (!u->is_allowed_foo)
    -               return;
    -       foo(u);
    -}
    -
     char *xstrndup(const char *str, size_t len)
     {
            char *p = memchr(str, '\0', len);
    diff --git a/test.c b/test.c
    index a95e6fe..81eb0eb 100644
    --- a/test.c
    +++ b/test.c
    @@ -18,6 +18,13 @@ ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
            return total;
     }

    +int secure_foo(struct user *u)
    +{
    +       if (!u->is_allowed_foo)
    +               return;
    +       foo(u);
    +}
    +
     int xdup(int fd)
     {
            int ret = dup(fd);

as in this patch all lines that add or remove lines
should be colored in the new color that indicates moved
lines.

However the intention of this patch is to aid reviewers
to spotting permutations in the moved code. So consider the
following malicious move:

    diff --git a/file2.c b/file2.c
    index 9163a0f..8e66dc0 100644
    --- a/file2.c
    +++ b/file2.c
    @@ -3,13 +3,6 @@ void *xmemdupz(const void *data, size_t len)
            return memcpy(xmallocz(len), data, len);
     }

    -int secure_foo(struct user *u)
    -{
    -       if (!u->is_allowed_foo)
    -               return;
    -       foo(u);
    -}
    -
     char *xstrndup(const char *str, size_t len)
     {
            char *p = memchr(str, '\0', len);
    diff --git a/test.c b/test.c
    index a95e6fe..a679c40 100644
    --- a/test.c
    +++ b/test.c
    @@ -18,6 +18,13 @@ ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
            return total;
     }

    +int secure_foo(struct user *u)
    +{
    +       foo(u);
    +       if (!u->is_allowed_foo)
    +               return;
    +}
    +
     int xdup(int fd)
     {
            int ret = dup(fd);

If the moved code is larger, it is easier to hide some permutation in the
code, which is why we would not want to color all lines as "moved" in this
case. So we do not just need to color lines differently that are added and
removed in the same diff, we need to tweak the algorithm a bit more.

As the reviewers attention should be brought to the places, where the
difference is introduced to the moved code, we cannot just have one new
color for all of moved code.

First I implemented an alternative design, which would show a moved hunk
in one color, and its boundaries in another color. This idea was error
prone as it inspected each line and its neighboring lines to determine
if the line was (a) moved and (b) if was deep inside a hunk by having
matching neighboring lines. This is unreliable as the we can construct
hunks which have equal neighbors that just exceed the number of lines
inspected. (Think of 'AXYZBXYZCXYZD..' with each letter as a line, that
is permutated to AXYZCXYZBXYZD..').

Instead this provides a dynamic programming greedy algorithm that finds
the largest moved hunk and then switches color to the alternative color
for the next hunk. By doing this any permutation is recognized and
displayed. That implies that there is no dedicated boundary or
inside-hunk color, but instead we'll have just two colors alternating
for hunks.

It would be a bit more UX friendly if the two corresponding hunks
(of added and deleted lines) for one move would get the same color id.
(Both get "regular moved" or "alternative moved"). This problem is
deferred to a later patch for now.

Algorithm-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt   |  14 ++-
 diff.c                     | 266 +++++++++++++++++++++++++++++++++++++++++++--
 diff.h                     |  11 +-
 t/t4015-diff-whitespace.sh | 229 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 507 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..902d017c3b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1051,14 +1051,24 @@ This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
 
+color.moved::
+	A boolean value, whether a diff should color moved lines
+	differently. The moved lines are searched for in the diff only.
+	Duplicated lines from somewhere in the project that are not
+	part of the diff are not colored as moved.
+	Defaults to false.
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
+	(highlighting whitespace errors), `oldMoved` (removed lines that
+	reappear), `newMoved` (added lines that were removed elsewhere),
+	`oldMovedAlternative` and `newMovedAlternative` (as a fallback to
+	cover adjacent blocks of moved code)
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
diff --git a/diff.c b/diff.c
index 1d8d1786fd..15cf322b50 100644
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
+	GIT_COLOR_BOLD_RED,	/* OLD_MOVED_A */
+	GIT_COLOR_BG_RED,	/* OLD_MOVED_B */
+	GIT_COLOR_BOLD_GREEN,	/* NEW_MOVED_A */
+	GIT_COLOR_BG_GREEN,	/* NEW_MOVED_B */
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
 
@@ -234,6 +247,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "color.moved")) {
+		diff_color_moved_default = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.context")) {
 		diff_context_default = git_config_int(var, value);
 		if (diff_context_default < 0)
@@ -354,6 +371,88 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+struct moved_entry {
+	struct hashmap_entry ent;
+	const struct buffered_patch_line *line;
+	struct moved_entry *next_line;
+};
+
+static void get_ws_cleaned_string(const struct buffered_patch_line *l,
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
+static int buffered_patch_line_cmp_no_ws(const struct buffered_patch_line *a,
+					 const struct buffered_patch_line *b,
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
+static int buffered_patch_line_cmp(const struct buffered_patch_line *a,
+				   const struct buffered_patch_line *b,
+				   const void *keydata)
+{
+	return a->len != b->len || strncmp(a->line, b->line, a->len);
+}
+
+static int moved_entry_cmp(const struct moved_entry *a,
+			   const struct moved_entry *b,
+			   const void *keydata)
+{
+	return buffered_patch_line_cmp(a->line, b->line, keydata);
+}
+
+static int moved_entry_cmp_no_ws(const struct moved_entry *a,
+				 const struct moved_entry *b,
+				 const void *keydata)
+{
+	return buffered_patch_line_cmp_no_ws(a->line, b->line, keydata);
+}
+
+static unsigned get_line_hash(struct buffered_patch_line *line, unsigned ignore_ws)
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
+	struct buffered_patch_line *l = &o->line_buffer[line_no];
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
@@ -516,6 +615,135 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
+static void add_lines_to_move_detection(struct diff_options *o)
+{
+	struct moved_entry *prev_line;
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
+			hm = o->added_lines;
+			break;
+		case '-':
+			sign = '-';
+			hm = o->deleted_lines;
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
+static void mark_color_as_moved(struct diff_options *o)
+{
+	struct moved_entry **pmb = NULL; /* potentially moved blocks */
+	int pmb_nr = 0, pmb_alloc = 0;
+	int alt_flag = 0;
+	int n;
+
+	for (n = 0; n < o->line_buffer_nr; n++) {
+		struct hashmap *hm = NULL;
+		struct moved_entry *key;
+		struct moved_entry *match = NULL;
+		struct buffered_patch_line *l = &o->line_buffer[n];
+		int i, lp, rp;
+
+		switch (l->sign) {
+		case '+':
+			hm = o->deleted_lines;
+			break;
+		case '-':
+			hm = o->added_lines;
+			break;
+		default:
+			alt_flag = 0; /* reset to standard, no-alt move color */
+			pmb_nr = 0; /* no running sets */
+			continue;
+		}
+
+		/* Check for any match to color it as a move. */
+		key = prepare_entry(o, n);
+		match = hashmap_get(hm, key, o);
+		free(key);
+		if (!match)
+			continue;
+
+		/* Check any potential block runs, advance each or nullify */
+		for (i = 0; i < pmb_nr; i++) {
+			struct moved_entry *p = pmb[i];
+			struct moved_entry *pnext = (p && p->next_line) ?
+					p->next_line : NULL;
+			if (pnext &&
+			    !buffered_patch_line_cmp(pnext->line, l, o)) {
+				pmb[i] = p->next_line;
+			} else {
+				pmb[i] = NULL;
+			}
+		}
+
+		/* Shrink the set to the remaining runs */
+		for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
+			while (lp < pmb_nr && pmb[lp])
+				lp ++;
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
+		if (rp > -1) {
+			/* Remember the number of running sets */
+			pmb_nr = rp + 1;
+		} else {
+			/* Toggle color */
+			alt_flag = (alt_flag + 1) % 2;
+
+			/* Build up a new set */
+			pmb_nr = 0;
+			for (; match; match = hashmap_get_next(hm, match)) {
+				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
+				pmb[pmb_nr++] = match;
+			}
+		}
+
+		switch (l->sign) {
+		case '+':
+			l->set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED + alt_flag);
+			break;
+		case '-':
+			l->set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED + alt_flag);
+			break;
+		default:
+			die("BUG: we should have continued earlier?");
+		}
+	}
+	free(pmb);
+}
+
 static void emit_buffered_patch_line(struct diff_options *o,
 				     struct buffered_patch_line *e)
 {
@@ -3514,6 +3742,8 @@ void diff_setup(struct diff_options *options)
 	options->line_buffer = NULL;
 	options->line_buffer_nr = 0;
 	options->line_buffer_alloc = 0;
+
+	options->color_moved = diff_color_moved_default;
 }
 
 void diff_setup_done(struct diff_options *options)
@@ -3623,6 +3853,9 @@ void diff_setup_done(struct diff_options *options)
 
 	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
 		die(_("--follow requires exactly one pathspec"));
+
+	if (!options->use_color || external_diff())
+		options->color_moved = 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -4047,6 +4280,10 @@ int diff_opt_parse(struct diff_options *options,
 	}
 	else if (!strcmp(arg, "--no-color"))
 		options->use_color = 0;
+	else if (!strcmp(arg, "--color-moved"))
+		options->color_moved = 1;
+	else if (!strcmp(arg, "--no-color-moved"))
+		options->color_moved = 0;
 	else if (!strcmp(arg, "--color-words")) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
@@ -4852,16 +5089,19 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	/*
-	 * For testing purposes we want to make sure the diff machinery
-	 * works completely with the buffer. If there is anything emitted
-	 * outside the emit_buffered_patch_line, then the order is screwed
-	 * up and the tests will fail.
-	 *
-	 * TODO (later in this series):
-	 * We'll unset this flag in a later patch.
-	 */
-	o->use_buffer = 1;
+
+	if (o->color_moved) {
+		unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
+		o->use_buffer = 1;
+		o->deleted_lines = xmallocz(sizeof(*o->deleted_lines));
+		o->added_lines = xmallocz(sizeof(*o->added_lines));
+		hashmap_init(o->deleted_lines, ignore_ws ?
+			(hashmap_cmp_fn)moved_entry_cmp_no_ws :
+			(hashmap_cmp_fn)moved_entry_cmp, 0);
+		hashmap_init(o->added_lines, ignore_ws ?
+			(hashmap_cmp_fn)moved_entry_cmp_no_ws :
+			(hashmap_cmp_fn)moved_entry_cmp, 0);
+	}
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -4870,6 +5110,11 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	}
 
 	if (o->use_buffer) {
+		if (o->color_moved) {
+			add_lines_to_move_detection(o);
+			mark_color_as_moved(o);
+		}
+
 		for (i = 0; i < o->line_buffer_nr; i++)
 			emit_buffered_patch_line(o, &o->line_buffer[i]);
 
@@ -4958,6 +5203,7 @@ void diff_flush(struct diff_options *options)
 		if (!options->file)
 			die_errno("Could not open /dev/null");
 		options->close_file = 1;
+		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
diff --git a/diff.h b/diff.h
index 64bc9bcd8c..b8b2a33ccc 100644
--- a/diff.h
+++ b/diff.h
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "pathspec.h"
 #include "object.h"
+#include "hashmap.h"
 
 struct rev_info;
 struct diff_options;
@@ -227,6 +228,10 @@ struct diff_options {
 
 	struct buffered_patch_line *line_buffer;
 	int line_buffer_nr, line_buffer_alloc;
+
+	int color_moved;
+	struct hashmap *deleted_lines;
+	struct hashmap *added_lines;
 };
 
 void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
@@ -243,7 +248,11 @@ enum color_diff {
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
index 289806d0c7..232d9ad55e 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -972,4 +972,233 @@ test_expect_success 'option overrides diff.wsErrorHighlight' '
 
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
+test_expect_success 'detect permutations inside moved code, ' '
+	# reusing the move example from last test:
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
+			foo(u);
+			if (!u->is_allowed_foo)
+				return;
+		}
+
+		int another_function()
+		{
+			bar();
+		}
+	EOF
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
+	<BOLD;RED>-if (!u->is_allowed_foo)<RESET>
+	<BOLD;RED>-return;<RESET>
+	<BRED>-foo(u);<RESET>
+	<BOLD;RED>-}<RESET>
+	<BOLD;RED>-<RESET>
+	 int main()<RESET>
+	 {<RESET>
+	 foo();<RESET>
+	<BOLD>diff --git a/test.c b/test.c<RESET>
+	<BOLD>index 1dc1d85..2bedec9 100644<RESET>
+	<BOLD>--- a/test.c<RESET>
+	<BOLD>+++ b/test.c<RESET>
+	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
+	 printf("Hello World, but different\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
+	<BGREEN>+<RESET><BGREEN>{<RESET>
+	<BOLD;GREEN>+<RESET><BOLD;GREEN>foo(u);<RESET>
+	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
+	<BGREEN>+<RESET><BGREEN>return;<RESET>
+	<BOLD;GREEN>+<RESET><BOLD;GREEN>}<RESET>
+	<BOLD;GREEN>+<RESET>
+	 int another_function()<RESET>
+	 {<RESET>
+	 bar();<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
-- 
2.13.0.18.g7d86cc8ba0

