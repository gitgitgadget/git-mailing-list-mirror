Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC782023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbdEQC7H (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:07 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35805 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdEQC7F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:05 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so84853995pfb.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9iEyRTguK7JwSRsovQQW0K95NyRyxfs1RHeh//Z7YAY=;
        b=jnC1NxyjO90ecw991+UIa/xolwWqzRgjwmh8h8TDAsx/EOuk6itJxFZSCx603MwU9v
         oLoWQZ7fO0Wd7ZBmMwW/3Hx67u453tE1eTuoGuxRiE/kGRczJIee65gOmDDl/8OT2NSy
         5lKoYSCrWlp8ALiuEUqJfAr7AuXYhOIXpV6o4Las5a1T0Wq6rYHkvviejOtxD9MVwrjQ
         f+P/3u/5CTjXXvPYO/RILPwbTxP1HVZSU7vRxVk0/8WR+QfljeRWvBgKXwwNCBxvZyQI
         Ta4Cbj4xwzKThzUQjp6s3nC1mUO/Jy6egbbFaNIotv4JxwXyemRY76eIOFrdaEjNtwXz
         CSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9iEyRTguK7JwSRsovQQW0K95NyRyxfs1RHeh//Z7YAY=;
        b=ccZYqMeD8SXSuubzhUjdEJi4bnqa1gvqMne4WKLTjrDY7slGTHm80u7n5Hi1++RaWp
         l31ShCH5bLrL+BpZXOALaqk5GptRWUvGLtnER8GbtOJe6YxGX13n8aMHFo3vEzMY+oTm
         53QdlorWE/WEJ65GcYoAhkzX8ONvYc8tDpjmDPI6evIksV141g5qf7OO7ZKJNEfKQALh
         jnrOQdaz2cOjAnvwcPtSo1q17W08RHIN4QAvvd4HwbpjuI9LgAWih9l6tBOuHIrocYCy
         LAZ3S7Gk0hFdQW+cRzgAqk42YdUkdIjehlZAOOx8C+yChxqclJSNgehUmAstpTQJUPTq
         NVqw==
X-Gm-Message-State: AODbwcC2M63P+V+/MZF8LSFcI7Hlqh9V3bFxC61IGnoU3xryfFLsG6Ur
        Qreh5TYte/2mpiTF
X-Received: by 10.98.236.28 with SMTP id k28mr1345733pfh.3.1494989944102;
        Tue, 16 May 2017 19:59:04 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id c85sm634007pfb.124.2017.05.16.19.59.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 00/20] Diff machine: highlight moved lines.
Date:   Tue, 16 May 2017 19:58:37 -0700
Message-Id: <20170517025857.32320-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* emit_line now takes an argument that indicates if we want it
  to emit the line prefix as well. This should allow for a more faithful
  refactoring in the beginning. (Thanks Jonathan!)
* fixed memleaks (Thanks Brandon!)
* "git -c color.moved=true log -p" works now! (Thanks Jeff)
* interdiff below, though it is large.
* less intrusive than v1 (Thanks Jonathan!)

v1:

For details on *why* see the commit message of the last commit.

The first five patches are slight refactorings to get into good
shape, the next patches are funneling all output through emit_line_*.

The second last patch introduces an option to buffer up all output
before printing, and then the last patch can color up moved lines
of code.

Any feedback welcome.

Thanks,
Stefan

Stefan Beller (20):
  diff: readability fix
  diff: move line ending check into emit_hunk_header
  diff.c: factor out diff_flush_patch_all_file_pairs
  diff.c: teach emit_line_0 to accept sign parameter
  diff.c: emit_line_0 can handle no color setting
  diff.c: emit_line_0 takes parameter whether to output line prefix
  diff.c: inline emit_line_0 into emit_line
  diff.c: convert fn_out_consume to use emit_line
  diff.c: convert builtin_diff to use emit_line_*
  diff.c: convert emit_rewrite_diff to use emit_line_*
  diff.c: convert emit_rewrite_lines to use emit_line_*
  submodule.c: convert show_submodule_summary to use emit_line_fmt
  diff.c: convert emit_binary_diff_body to use emit_line_*
  diff.c: convert show_stats to use emit_line_*
  diff.c: convert word diffing to use emit_line_*
  diff.c: convert diff_flush to use emit_line_*
  diff.c: convert diff_summary to use emit_line_*
  diff.c: emit_line includes whitespace highlighting
  diff: buffer all output if asked to
  diff.c: color moved lines differently

 Documentation/config.txt   |  14 +-
 diff.c                     | 845 +++++++++++++++++++++++++++++++++------------
 diff.h                     |  61 +++-
 submodule.c                |  78 ++---
 submodule.h                |   9 +-
 t/t4015-diff-whitespace.sh | 229 ++++++++++++
 6 files changed, 960 insertions(+), 276 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 90403c06e3..902d017c3b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1065,8 +1065,10 @@ color.diff.<slot>::
 	`meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
 	`new` (added lines), `commit` (commit headers), `whitespace`
-	(highlighting whitespace errors), `movedFrom` (removed lines that
-	reappear), `movedTo` (added lines that were removed elsewhere).
+	(highlighting whitespace errors), `oldMoved` (removed lines that
+	reappear), `newMoved` (added lines that were removed elsewhere),
+	`oldMovedAlternative` and `newMovedAlternative` (as a fallback to
+	cover adjacent blocks of moved code)
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
diff --git a/diff.c b/diff.c
index 5dfd582084..15cf322b50 100644
--- a/diff.c
+++ b/diff.c
@@ -392,11 +392,17 @@ static int buffered_patch_line_cmp_no_ws(const struct buffered_patch_line *a,
 					 const struct buffered_patch_line *b,
 					 const void *keydata)
 {
+	int ret;
 	struct strbuf sba = STRBUF_INIT;
 	struct strbuf sbb = STRBUF_INIT;
+
 	get_ws_cleaned_string(a, &sba);
 	get_ws_cleaned_string(b, &sbb);
-	return sba.len != sbb.len || strncmp(sba.buf, sbb.buf, sba.len);
+	ret = sba.len != sbb.len || strncmp(sba.buf, sbb.buf, sba.len);
+
+	strbuf_release(&sba);
+	strbuf_release(&sbb);
+	return ret;
 }
 
 static int buffered_patch_line_cmp(const struct buffered_patch_line *a,
@@ -428,8 +434,9 @@ static unsigned get_line_hash(struct buffered_patch_line *line, unsigned ignore_
 		strbuf_reset(&sb);
 		get_ws_cleaned_string(line, &sb);
 		return memhash(sb.buf, sb.len);
-	} else
+	} else {
 		return memhash(line->line, line->len);
+	}
 }
 
 static struct moved_entry *prepare_entry(struct diff_options *o,
@@ -608,159 +615,185 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void mark_color_as_moved(struct diff_options *o, int line_no)
+static void add_lines_to_move_detection(struct diff_options *o)
 {
-	struct hashmap *hm = NULL;
-	struct moved_entry *key = prepare_entry(o, line_no);
-	struct moved_entry *match = NULL;
-	struct buffered_patch_line *l = &o->line_buffer[line_no];
-	int alt_flag;
-	int i, lp, rp;
+	struct moved_entry *prev_line;
 
-	switch (l->sign) {
-	case '+':
-		hm = o->deleted_lines;
-		break;
-	case '-':
-		hm = o->added_lines;
-		break;
-	default:
-		/* reset to standard, on-alt move color */
-		o->color_moved = 1;
-		break;
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
 	}
+}
 
-	/* Check for any match to color it as a move. */
-	if (!hm)
-		return;
-	match = hashmap_get(hm, key, o);
-	free(key);
-	if (!match)
-		return;
+static void mark_color_as_moved(struct diff_options *o)
+{
+	struct moved_entry **pmb = NULL; /* potentially moved blocks */
+	int pmb_nr = 0, pmb_alloc = 0;
+	int alt_flag = 0;
+	int n;
 
-	/* Check any potential block runs, advance each or nullify */
-	for (i = 0; i < o->pmb_nr; i++) {
-		struct moved_entry *p = o->pmb[i];
-		if (p && p->next_line &&
-		    !buffered_patch_line_cmp(p->next_line->line, l, o)) {
-			o->pmb[i] = p->next_line;
-		} else {
-			o->pmb[i] = NULL;
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
 		}
-	}
 
-	/* Shrink the set to the remaining runs */
-	for (lp = 0, rp = o->pmb_nr - 1; lp <= rp;) {
-		while (lp < o->pmb_nr && o->pmb[lp])
-			lp ++;
-		/* lp points at the first NULL now */
+		/* Check for any match to color it as a move. */
+		key = prepare_entry(o, n);
+		match = hashmap_get(hm, key, o);
+		free(key);
+		if (!match)
+			continue;
 
-		while (rp > -1 && !o->pmb[rp])
-			rp--;
-		/* rp points at the last non-NULL */
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
 
-		if (lp < o->pmb_nr && rp > -1 && lp < rp) {
-			o->pmb[lp] = o->pmb[rp];
-			o->pmb[rp] = NULL;
-			rp--;
-			lp++;
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
 		}
-	}
 
-	if (rp > -1) {
-		/* Remember the number of running sets */
-		o->pmb_nr = rp + 1;
-	} else {
-		/* Toggle color */
-		o->color_moved = o->color_moved == 2 ? 1 : 2;
-
-		/* Build up a new set */
-		i = 0;
-		for (; match; match = hashmap_get_next(hm, match)) {
-			ALLOC_GROW(o->pmb, i + 1, o->pmb_alloc);
-			o->pmb[i] = match;
-			i++;
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
 		}
-		o->pmb_nr = i;
-	}
 
-	alt_flag = o->color_moved - 1;
-	switch (l->sign) {
-	case '+':
-		l->set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED + alt_flag);
-		break;
-	case '-':
-		l->set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED + alt_flag);
-		break;
-	default:
-		/* reset to standard, on-alt move color */
-		o->color_moved = 1;
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
 	}
+	free(pmb);
 }
 
 static void emit_buffered_patch_line(struct diff_options *o,
-				     struct buffered_patch_line *e,
-				     int pass)
+				     struct buffered_patch_line *e)
 {
-	int has_trailing_newline, has_trailing_carriage_return, len = e->len;
+	const char *ws;
+	int has_trailing_newline, has_trailing_carriage_return;
+	int len = e->len;
 	FILE *file = o->file;
 
-	fputs(diff_line_prefix(o), file);
-
-	has_trailing_newline = (len > 0 && e->line[len-1] == '\n');
-	if (has_trailing_newline)
-		len--;
-	has_trailing_carriage_return = (len > 0 && e->line[len-1] == '\r');
-	if (has_trailing_carriage_return)
-		len--;
+	if (e->add_line_prefix)
+		fputs(diff_line_prefix(o), file);
 
-	if (len || e->sign) {
+	switch (e->state) {
+	case BPL_EMIT_LINE_WS:
+		ws = diff_get_color(o->use_color, DIFF_WHITESPACE);
 		if (e->set)
 			fputs(e->set, file);
 		if (e->sign)
 			fputc(e->sign, file);
-		fwrite(e->line, len, 1, file);
 		if (e->reset)
 			fputs(e->reset, file);
-	}
-	if (has_trailing_carriage_return)
-		fputc('\r', file);
-	if (has_trailing_newline)
-		fputc('\n', file);
-}
-
-static void emit_buffered_patch_line_ws(struct diff_options *o,
-					struct buffered_patch_line *e,
-					const char *ws, unsigned ws_rule,
-					int pass)
-{
-	struct buffered_patch_line s = {e->set, e->reset, "", 0, e->sign};
-	emit_buffered_patch_line(o, &s, 0);
-	ws_check_emit(e->line, e->len, ws_rule,
-		      o->file, e->set, e->reset, ws);
-}
-
-static void process_next_buffered_patch_line(struct diff_options *o, int line_no)
-{
-	struct buffered_patch_line *e = &o->line_buffer[line_no];
-
-	const char *ws = o->current_filepair->ws;
-	unsigned ws_rule = o->current_filepair->ws_rule;
-
-	mark_color_as_moved(o, line_no);
+		ws_check_emit(e->line, e->len, o->ws_rule,
+			      file, e->set, e->reset, ws);
+		return;
+	case BPL_EMIT_LINE_ASIS:
+		has_trailing_newline = (len > 0 && e->line[len-1] == '\n');
+		if (has_trailing_newline)
+			len--;
+		has_trailing_carriage_return = (len > 0 && e->line[len-1] == '\r');
+		if (has_trailing_carriage_return)
+			len--;
 
-	switch (e->state) {
-		case BPL_EMIT_LINE_ASIS:
-			emit_buffered_patch_line(o, e, 1);
-			break;
-		case BPL_EMIT_LINE_WS:
-			emit_buffered_patch_line_ws(o, e, ws, ws_rule, 1);
-			break;
-		case BPL_HANDOVER:
-			o->current_filepair++;
-			break;
-		default:
-			die("BUG: malformatted buffered patch line: '%d'", e->state);
+		if (len || e->sign) {
+			if (e->set)
+				fputs(e->set, file);
+			if (e->sign)
+				fputc(e->sign, file);
+			fwrite(e->line, len, 1, file);
+			if (e->reset)
+				fputs(e->reset, file);
+		}
+		if (has_trailing_carriage_return)
+			fputc('\r', file);
+		if (has_trailing_newline)
+			fputc('\n', file);
+		return;
+	case BPL_HANDOVER:
+		o->ws_rule = whitespace_rule(e->line); /*read from file, stored in line?*/
+		return;
+	default:
+		die("BUG: malformatted buffered patch line: '%d'", e->state);
 	}
 }
 
@@ -771,46 +804,30 @@ static void append_buffered_patch_line(struct diff_options *o,
 	ALLOC_GROW(o->line_buffer,
 		   o->line_buffer_nr + 1,
 		   o->line_buffer_alloc);
-	f = &o->line_buffer[o->line_buffer_nr];
-	o->line_buffer_nr++;
+	f = &o->line_buffer[o->line_buffer_nr++];
 
 	memcpy(f, e, sizeof(struct buffered_patch_line));
 	f->line = e->line ? xmemdupz(e->line, e->len) : NULL;
 }
 
-static void emit_line_0(struct diff_options *o,
-			const char *set, const char *reset,
-			int sign, const char *line, int len)
+void emit_line(struct diff_options *o,
+	       const char *set, const char *reset,
+	       int add_line_prefix, int markup_ws,
+	       int sign, const char *line, int len)
 {
-	struct buffered_patch_line e = {set, reset, line, len, sign, BPL_EMIT_LINE_ASIS};
+	struct buffered_patch_line e = {set, reset, line,
+		len, sign, add_line_prefix,
+		markup_ws ? BPL_EMIT_LINE_WS : BPL_EMIT_LINE_ASIS};
 
 	if (o->use_buffer)
 		append_buffered_patch_line(o, &e);
 	else
-		emit_buffered_patch_line(o, &e, 0);
-}
-
-void emit_line(struct diff_options *o, const char *set, const char *reset,
-	       const char *line, int len)
-{
-	emit_line_0(o, set, reset, 0, line, len);
-}
-
-static void emit_line_ws(struct diff_options *o,
-			 const char *set, const char *reset, int sign,
-			 const char *line, int len,
-			 const char *ws, unsigned ws_rule)
-{
-	struct buffered_patch_line e = {set, reset, line, len, sign, BPL_EMIT_LINE_WS};
-
-	if (o->use_buffer)
-		append_buffered_patch_line(o, &e);
-	else
-		emit_buffered_patch_line_ws(o, &e, ws, ws_rule, 0);
+		emit_buffered_patch_line(o, &e);
 }
 
 void emit_line_fmt(struct diff_options *o,
 		   const char *set, const char *reset,
+		   int add_line_prefix,
 		   const char *fmt, ...)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -819,7 +836,7 @@ void emit_line_fmt(struct diff_options *o,
 	strbuf_vaddf(&sb, fmt, ap);
 	va_end(ap);
 
-	emit_line(o, set, reset, sb.buf, sb.len);
+	emit_line(o, set, reset, add_line_prefix, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
@@ -851,44 +868,15 @@ static void emit_line_checked(const char *reset,
 	}
 
 	if (!ws)
-		emit_line_0(ecbdata->opt, set, reset, sign, line, len);
+		emit_line(ecbdata->opt, set, reset, 1, 0, sign, line, len);
 	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
-	else
+		emit_line(ecbdata->opt, ws, reset, 1, 1, sign, line, len);
+	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_ws(ecbdata->opt, set, reset, sign, line, len,
-			     ws, ecbdata->ws_rule);
-}
-
-static void add_line_to_move_detection(struct diff_options *o, int line_idx)
-{
-	int sign = 0;
-	struct hashmap *hm;
-	struct moved_entry *key;
-
-	switch (o->line_buffer[line_idx].sign) {
-	case '+':
-		sign = '+';
-		hm = o->added_lines;
-		break;
-	case '-':
-		sign = '-';
-		hm = o->deleted_lines;
-		break;
-	case ' ':
-	default:
-		o->prev_line = NULL;
-		return;
+		emit_line(ecbdata->opt, set, reset, 1, 1, sign, line, len);
 	}
 
-	key = prepare_entry(o, line_idx);
-	if (o->prev_line &&
-	    o->prev_line->line->sign == sign)
-		o->prev_line->next_line = key;
-
-	hashmap_add(hm, key);
-	o->prev_line = key;
 }
 
 static void emit_add_line(const char *reset,
@@ -935,7 +923,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->opt, context, reset, line, len);
+		emit_line(ecbdata->opt, context, reset, 1, 0, 0, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
@@ -971,7 +959,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
 
-	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
+	emit_line(ecbdata->opt, "", "", 1, 0, 0, msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
 
@@ -1011,15 +999,25 @@ static void add_line_count(struct strbuf *out, int count)
 static void emit_rewrite_lines(struct emit_callback *ecb,
 			       int prefix, const char *data, int size)
 {
-	const char *endp = NULL;
-	static const char *nneof = " No newline at end of file\n";
 	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
+	struct strbuf sb = STRBUF_INIT;
 
 	while (0 < size) {
 		int len;
 
-		endp = memchr(data, '\n', size);
-		len = endp ? (endp - data + 1) : size;
+		const char *endp = memchr(data, '\n', size);
+		if (endp)
+			len = endp - data + 1;
+		else {
+			while (0 < size) {
+				strbuf_addch(&sb, *data);
+				size -= len;
+				data += len;
+			}
+			strbuf_addch(&sb, '\n');
+			data = sb.buf;
+			len = sb.len;
+		}
 		if (prefix != '+') {
 			ecb->lno_in_preimage++;
 			emit_del_line(reset, ecb, data, len);
@@ -1030,12 +1028,13 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		size -= len;
 		data += len;
 	}
-	if (!endp) {
+	if (sb.len) {
+		static const char *nneof = "\\ No newline at end of file\n";
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
-		emit_line(ecb->opt, NULL, NULL, "\n", 1);
-		emit_line_0(ecb->opt, context, reset, '\\',
+		emit_line(ecb->opt, context, reset, 1, 0, 0,
 			    nneof, strlen(nneof));
+		strbuf_release(&sb);
 	}
 }
 
@@ -1095,8 +1094,8 @@ static void emit_rewrite_diff(const char *name_a,
 	ecbdata.lno_in_preimage = 1;
 	ecbdata.lno_in_postimage = 1;
 
-	emit_line_fmt(o, metainfo, reset, "--- %s%s\n", a_name.buf, name_a_tab);
-	emit_line_fmt(o, metainfo, reset, "+++ %s%s\n", b_name.buf, name_b_tab);
+	emit_line_fmt(o, metainfo, reset, 1, "--- %s%s\n", a_name.buf, name_a_tab);
+	emit_line_fmt(o, metainfo, reset, 1, "+++ %s%s\n", b_name.buf, name_b_tab);
 
 	lc_a = count_lines(data_one, size_one);
 	lc_b = count_lines(data_two, size_two);
@@ -1109,7 +1108,7 @@ static void emit_rewrite_diff(const char *name_a,
 	strbuf_addstr(&out, " +");
 	add_line_count(&out, lc_b);
 	strbuf_addstr(&out, " @@\n");
-	emit_line(o, fraginfo, reset, out.buf, out.len);
+	emit_line(o, fraginfo, reset, 1, 0, 0, out.buf, out.len);
 	strbuf_release(&out);
 
 	if (lc_a && !o->irreversible_delete)
@@ -1174,34 +1173,38 @@ struct diff_words_data {
 static int fn_out_diff_words_write_helper(struct diff_options *o,
 					  struct diff_words_style_elem *st_el,
 					  const char *newline,
-					  size_t count, const char *buf,
-					  const char *line_prefix)
+					  size_t count, const char *buf)
 {
+	int print = 0;
 	struct strbuf sb = STRBUF_INIT;
 
 	while (count) {
 		char *p = memchr(buf, '\n', count);
+		if (print)
+			emit_line(o, NULL, NULL, 1, 0, 0, "", 0);
 
 		if (p != buf) {
-			if (st_el->color)
-				strbuf_addstr(&sb, st_el->color);
+			const char *reset = st_el->color && *st_el->color ?
+					    GIT_COLOR_RESET : NULL;
 			strbuf_addstr(&sb, st_el->prefix);
 			strbuf_add(&sb, buf, p ? p - buf : count);
 			strbuf_addstr(&sb, st_el->suffix);
-			if (st_el->color && *st_el->color)
-			    strbuf_addstr(&sb, GIT_COLOR_RESET);
+			emit_line(o, st_el->color, reset,
+				  0, 0, 0, sb.buf, sb.len);
+			strbuf_reset(&sb);
 		}
 		if (!p)
 			goto out;
+
 		strbuf_addstr(&sb, newline);
-		emit_line(o, NULL, NULL, sb.buf, sb.len);
+		emit_line(o, NULL, NULL, 0, 0, 0, sb.buf, sb.len);
 		strbuf_reset(&sb);
 		count -= p + 1 - buf;
 		buf = p + 1;
+		print = 1;
 	}
+
 out:
-	if (sb.len)
-		emit_line(o, NULL, NULL, sb.buf, sb.len);
 	strbuf_release(&sb);
 	return 0;
 }
@@ -1256,14 +1259,12 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	int minus_first, minus_len, plus_first, plus_len;
 	const char *minus_begin, *minus_end, *plus_begin, *plus_end;
 	struct diff_options *opt = diff_words->opt;
-	const char *line_prefix;
 
 	if (line[0] != '@' || parse_hunk_header(line, len,
 			&minus_first, &minus_len, &plus_first, &plus_len))
 		return;
 
 	assert(opt);
-	line_prefix = diff_line_prefix(opt);
 
 	/* POSIX requires that first be decremented by one if len == 0... */
 	if (minus_len) {
@@ -1280,28 +1281,21 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	} else
 		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
 
-	if (color_words_output_graph_prefix(diff_words))
-		emit_line(diff_words->opt, NULL, NULL, "", 0);
-
 	if (diff_words->current_plus != plus_begin) {
 		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->ctx, style->newline,
 				plus_begin - diff_words->current_plus,
-				diff_words->current_plus, line_prefix);
-		if (*(plus_begin - 1) == '\n')
-			emit_line(diff_words->opt, NULL, NULL, "", 0);
+				diff_words->current_plus);
 	}
 	if (minus_begin != minus_end) {
 		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->old, style->newline,
-				minus_end - minus_begin, minus_begin,
-				line_prefix);
+				minus_end - minus_begin, minus_begin);
 	}
 	if (plus_begin != plus_end) {
 		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->new, style->newline,
-				plus_end - plus_begin, plus_begin,
-				line_prefix);
+				plus_end - plus_begin, plus_begin);
 	}
 
 	diff_words->current_plus = plus_end;
@@ -1388,17 +1382,14 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	struct diff_words_style *style = diff_words->style;
 
 	struct diff_options *opt = diff_words->opt;
-	const char *line_prefix;
-
 	assert(opt);
-	line_prefix = diff_line_prefix(opt);
 
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
 		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->old, style->newline,
 			diff_words->minus.text.size,
-			diff_words->minus.text.ptr, line_prefix);
+			diff_words->minus.text.ptr);
 		diff_words->minus.text.size = 0;
 		return;
 	}
@@ -1421,12 +1412,11 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
 			diff_words->plus.text.size) {
 		if (color_words_output_graph_prefix(diff_words))
-			emit_line(diff_words->opt, NULL, NULL, "", 0);
+			emit_line(diff_words->opt, NULL, NULL, 1, 0, 0, "", 0);
 		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->ctx, style->newline,
 			diff_words->plus.text.ptr + diff_words->plus.text.size
-			- diff_words->current_plus, diff_words->current_plus,
-			line_prefix);
+			- diff_words->current_plus, diff_words->current_plus);
 	}
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
 }
@@ -1444,8 +1434,10 @@ static void diff_words_flush(struct emit_callback *ecbdata)
 			append_buffered_patch_line(ecbdata->opt,
 				&ecbdata->diff_words->opt->line_buffer[i]);
 
+		for (i = 0; i < ecbdata->diff_words->opt->line_buffer_nr; i++)
+			free((void*) ecbdata->diff_words->opt->line_buffer[i].line);
+
 		ecbdata->diff_words->opt->line_buffer_nr = 0;
-		/* TODO: free memory as well */
 	}
 }
 
@@ -1521,6 +1513,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words) {
 		diff_words_flush(ecbdata);
+		free (ecbdata->diff_words->opt->line_buffer);
 		free (ecbdata->diff_words->opt);
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->minus.orig);
@@ -1596,7 +1589,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	o->found_changes = 1;
 
 	if (ecbdata->header) {
-		emit_line(o, NULL, NULL,
+		emit_line(o, NULL, NULL, 0, 0, 0,
 			  ecbdata->header->buf, ecbdata->header->len);
 		strbuf_release(ecbdata->header);
 		ecbdata->header = NULL;
@@ -1606,9 +1599,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		const char *name_a_tab, *name_b_tab;
 		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
-		emit_line_fmt(o, meta, reset, "--- %s%s\n",
+		emit_line_fmt(o, meta, reset, 1, "--- %s%s\n",
 			      ecbdata->label_path[0], name_a_tab);
-		emit_line_fmt(o, meta, reset, "+++ %s%s\n",
+		emit_line_fmt(o, meta, reset, 1, "+++ %s%s\n",
 			      ecbdata->label_path[1], name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
@@ -1649,8 +1642,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		}
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
-			emit_line(o, context, reset, line, len);
-			emit_line(o, NULL, NULL, "~\n", 2);
+			emit_line(o, context, reset, 1, 0, 0, line, len);
+			emit_line(o, NULL, NULL, 0, 0, 0, "~\n", 2);
 		} else {
 			/*
 			 * Skip the prefix character, if any.  With
@@ -1661,7 +1654,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			      line++;
 			      len--;
 			}
-			emit_line(o, context, reset, line, len);
+			emit_line(o, context, reset, 1, 0, 0, line, len);
 		}
 		return;
 	}
@@ -1684,7 +1677,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
 		emit_line(o, diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
-			  reset, line, len);
+			  reset, 1, 0, 0, line, len);
 		break;
 	}
 }
@@ -1873,7 +1866,7 @@ void print_stat_summary_0(struct diff_options *options, int files,
 	if (!files) {
 		assert(insertions == 0 && deletions == 0);
 		strbuf_addstr(&sb, " 0 files changed");
-		emit_line(options, NULL, NULL, sb.buf, sb.len);
+		emit_line(options, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 		return;
 	}
 
@@ -1901,7 +1894,7 @@ void print_stat_summary_0(struct diff_options *options, int files,
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
-	emit_line(options, NULL, NULL, sb.buf, sb.len);
+	emit_line(options, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
@@ -2085,7 +2078,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			strbuf_addf(&out, " %*s", number_width, "Bin");
 			if (!added && !deleted) {
 				strbuf_addch(&out, '\n');
-				emit_line(options, NULL, NULL, out.buf, out.len);
+				emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 				strbuf_reset(&out);
 				continue;
 			}
@@ -2095,14 +2088,14 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			strbuf_addf(&out, "%s%"PRIuMAX"%s",
 				add_c, added, reset);
 			strbuf_addstr(&out, " bytes\n");
-			emit_line(options, NULL, NULL, out.buf, out.len);
+			emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 			strbuf_reset(&out);
 			continue;
 		}
 		else if (file->is_unmerged) {
 			show_name(&out, prefix, name, len);
 			strbuf_addstr(&out, " Unmerged\n");
-			emit_line(options, NULL, NULL, out.buf, out.len);
+			emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 			strbuf_reset(&out);
 			continue;
 		}
@@ -2133,7 +2126,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		show_graph(&out, '+', add, add_c, reset);
 		show_graph(&out, '-', del, del_c, reset);
 		strbuf_addch(&out, '\n');
-		emit_line(options, NULL, NULL, out.buf, out.len);
+		emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 		strbuf_reset(&out);
 	}
 
@@ -2155,7 +2148,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (i < count)
 			continue;
 		if (!extra_shown)
-			emit_line(options, NULL, NULL,
+			emit_line(options, NULL, NULL, 1, 0, 0,
 				  " ...\n", strlen(" ...\n"));
 		extra_shown = 1;
 	}
@@ -2509,7 +2502,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		fprintf(data->o->file, "%s%s:%d: %s.\n",
 			line_prefix, data->filename, data->lineno, err);
 		free(err);
-		emit_line(data->o, set, reset, line, 1);
+		emit_line(data->o, set, reset, 1, 0, 0, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
 			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ') {
@@ -2576,12 +2569,12 @@ static void emit_binary_diff_body(struct diff_options *o,
 	}
 
 	if (delta && delta_size < deflate_size) {
-		emit_line_fmt(o, NULL, NULL, "delta %lu\n", orig_size);
+		emit_line_fmt(o, NULL, NULL, 1, "delta %lu\n", orig_size);
 		free(deflated);
 		data = delta;
 		data_size = delta_size;
 	} else {
-		emit_line_fmt(o, NULL, NULL, "literal %lu\n", two->size);
+		emit_line_fmt(o, NULL, NULL, 1, "literal %lu\n", two->size);
 		free(delta);
 		data = deflated;
 		data_size = deflate_size;
@@ -2605,9 +2598,9 @@ static void emit_binary_diff_body(struct diff_options *o,
 		line[len++] = '\n';
 		line[len] = '\0';
 
-		emit_line(o, NULL, NULL, line, len);
+		emit_line(o, NULL, NULL, 1, 0, 0, line, len);
 	}
-	emit_line(o, NULL, NULL, "\n", 1);
+	emit_line(o, NULL, NULL, 1, 0, 0, "\n", 1);
 	free(data);
 }
 
@@ -2616,7 +2609,7 @@ static void emit_binary_diff(struct diff_options *o,
 {
 	const char *s = "GIT binary patch\n";
 	const int len = strlen(s);
-	emit_line(o, NULL, NULL, s, len);
+	emit_line(o, NULL, NULL, 1, 0, 0, s, len);
 	emit_binary_diff_body(o, one, two);
 	emit_binary_diff_body(o, two, one);
 }
@@ -2727,7 +2720,7 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	strbuf_addf(&header, "%sdiff --git %s %s%s\n", meta, a_one, b_two, reset);
+	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
 		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, meta, two->mode, reset);
@@ -2759,7 +2752,7 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
-			emit_line(o, NULL, NULL, header.buf, header.len);
+			emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
@@ -2769,8 +2762,7 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->irreversible_delete && lbl[1][0] == '/') {
-		if (header.len)
-			emit_line(o, NULL, NULL, header.buf, header.len);
+		emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
@@ -2780,15 +2772,15 @@ static void builtin_diff(const char *name_a,
 		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
 		    !DIFF_OPT_TST(o, BINARY)) {
 			if (!oidcmp(&one->oid, &two->oid)) {
-				if (must_show_header && header.len)
-					emit_line(o, NULL, NULL,
+				if (must_show_header)
+					emit_line(o, NULL, NULL, 0, 0, 0,
 						  header.buf, header.len);
 				goto free_ab_and_return;
 			}
-			if (header.len)
-				emit_line(o, NULL, NULL,
-					  header.buf, header.len);
-			emit_line_fmt(o, 0, 0, "Binary files %s and %s differ\n",
+			emit_line(o, NULL, NULL, 0, 0, 0,
+				  header.buf, header.len);
+			emit_line_fmt(o, NULL, NULL, 1,
+				      "Binary files %s and %s differ\n",
 				      lbl[0], lbl[1]);
 			goto free_ab_and_return;
 		}
@@ -2797,19 +2789,18 @@ static void builtin_diff(const char *name_a,
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
-			if (must_show_header && header.len)
-				emit_line(o, NULL, NULL,
+			if (must_show_header)
+				emit_line(o, NULL, NULL, 0, 0, 0,
 					  header.buf, header.len);
 			goto free_ab_and_return;
 		}
-		if (header.len)
-			emit_line(o, NULL, NULL,
-				  header.buf, header.len);
+		emit_line(o, NULL, NULL, 0, 0, 0,
+			  header.buf, header.len);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o, &mf1, &mf2);
 		else
-			emit_line_fmt(o, NULL, NULL,
+			emit_line_fmt(o, NULL, NULL, 1,
 				      "Binary files %s and %s differ\n",
 				      lbl[0], lbl[1]);
 		o->found_changes = 1;
@@ -2822,8 +2813,8 @@ static void builtin_diff(const char *name_a,
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
-		if (must_show_header && header.len) {
-			emit_line(o, NULL, NULL, header.buf, header.len);
+		if (must_show_header) {
+			emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 		}
 
@@ -2840,6 +2831,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = want_color(o->use_color);
 		ecbdata.ws_rule = whitespace_rule(name_b);
+		o->ws_rule = ecbdata.ws_rule;
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.opt = o;
@@ -2861,24 +2853,15 @@ static void builtin_diff(const char *name_a,
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
 		if (o->use_buffer) {
-			ALLOC_GROW(o->filepair_buffer,
-				   o->filepair_buffer_nr + 1,
-				   o->filepair_buffer_alloc);
-			o->current_filepair =
-				&o->filepair_buffer[o->filepair_buffer_nr++];
-
-			o->current_filepair->ws_rule = ecbdata.ws_rule;
-			o->current_filepair->ws =
-				diff_get_color(ecbdata.color_diff, DIFF_WHITESPACE);
+			struct buffered_patch_line e = BUFFERED_PATCH_LINE_INIT;
+			e.state = BPL_HANDOVER;
+			e.line = name_b;
+			e.len = strlen(name_b);
+			append_buffered_patch_line(o, &e);
 		}
 		if (xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
 				  &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
-		if (o->use_buffer) {
-			struct buffered_patch_line e = BUFFERED_PATCH_LINE_INIT;
-			e.state = BPL_HANDOVER; /* handover to next file pair */
-			append_buffered_patch_line(o, &e);
-		}
 		if (o->word_diff)
 			free_diff_words_data(&ecbdata);
 		if (textconv_one)
@@ -3755,6 +3738,12 @@ void diff_setup(struct diff_options *options)
 		options->a_prefix = "a/";
 		options->b_prefix = "b/";
 	}
+
+	options->line_buffer = NULL;
+	options->line_buffer_nr = 0;
+	options->line_buffer_alloc = 0;
+
+	options->color_moved = diff_color_moved_default;
 }
 
 void diff_setup_done(struct diff_options *options)
@@ -4837,11 +4826,10 @@ static void show_file_mode_name(struct diff_options *opt, const char *newdelete,
 
 	quote_c_style(fs->path, &sb, NULL, 0);
 	strbuf_addch(&sb, '\n');
-	emit_line(opt, NULL, NULL, sb.buf, sb.len);
+	emit_line(opt, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
-
 static void show_mode_change(struct diff_options *opt, struct diff_filepair *p,
 		int show_name)
 {
@@ -4851,7 +4839,7 @@ static void show_mode_change(struct diff_options *opt, struct diff_filepair *p,
 			strbuf_addch(&sb, ' ');
 			quote_c_style(p->two->path, &sb, NULL, 0);
 		}
-		emit_line_fmt(opt, NULL, NULL,
+		emit_line_fmt(opt, NULL, NULL, 1,
 			      " mode change %06o => %06o%s\n",
 			      p->one->mode, p->two->mode,
 			      show_name ? sb.buf : "");
@@ -4863,7 +4851,8 @@ static void show_rename_copy(struct diff_options *opt, const char *renamecopy,
 		struct diff_filepair *p)
 {
 	char *names = pprint_rename(p->one->path, p->two->path);
-	emit_line_fmt(opt, NULL, NULL, " %s %s (%d%%)\n", renamecopy, names, similarity_index(p));
+	emit_line_fmt(opt, NULL, NULL, 1, " %s %s (%d%%)\n",
+		      renamecopy, names, similarity_index(p));
 	free(names);
 	show_mode_change(opt, p, 0);
 }
@@ -4889,7 +4878,7 @@ static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 			strbuf_addstr(&sb, " rewrite ");
 			quote_c_style(p->two->path, &sb, NULL, 0);
 			strbuf_addf(&sb, " (%d%%)\n", similarity_index(p));
-			emit_line(opt, NULL, NULL, sb.buf, sb.len);
+			emit_line(opt, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 		}
 		show_mode_change(opt, p, !p->score);
 		break;
@@ -5114,12 +5103,6 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 			(hashmap_cmp_fn)moved_entry_cmp, 0);
 	}
 
-	if (o->use_buffer) {
-		ALLOC_GROW(o->filepair_buffer,
-			   o->filepair_buffer_nr + 1,
-			   o->filepair_buffer_alloc);
-		o->current_filepair = &o->filepair_buffer[o->filepair_buffer_nr];
-	}
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
@@ -5127,23 +5110,22 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	}
 
 	if (o->use_buffer) {
-		o->current_filepair = &o->filepair_buffer[0];
-		for (i = 0; i < o->line_buffer_nr; i++)
-			add_line_to_move_detection(o, i);
+		if (o->color_moved) {
+			add_lines_to_move_detection(o);
+			mark_color_as_moved(o);
+		}
 
-		o->current_filepair = &o->filepair_buffer[0];
 		for (i = 0; i < o->line_buffer_nr; i++)
-			process_next_buffered_patch_line(o, i);
+			emit_buffered_patch_line(o, &o->line_buffer[i]);
 
-		for (i = 0; i < o->line_buffer_nr; i++);
+		for (i = 0; i < o->line_buffer_nr; i++)
 			free((void*)o->line_buffer[i].line);
 
+		free(o->line_buffer);
+
 		o->line_buffer = NULL;
 		o->line_buffer_nr = 0;
-		free(o->line_buffer);
-		o->filepair_buffer = NULL;
-		o->filepair_buffer_nr = 0;
-		free(o->filepair_buffer);
+		o->line_buffer_alloc = 0;
 	}
 }
 
@@ -5237,11 +5219,10 @@ void diff_flush(struct diff_options *options)
 			term[0] = options->line_termination;
 			term[1] = '\0';
 
-			emit_line(options, NULL, NULL,
-				  term, 1);
+			emit_line(options, NULL, NULL, 1, 0, 0, term, !!term[0]);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
-				emit_line(options, NULL, NULL,
+				emit_line(options, NULL, NULL, 0, 0, 0,
 					  options->stat_sep,
 					  strlen(options->stat_sep));
 			}
diff --git a/diff.h b/diff.h
index b83d6fefcc..b8b2a33ccc 100644
--- a/diff.h
+++ b/diff.h
@@ -133,21 +133,24 @@ struct buffered_patch_line {
 	const char *line;
 	int len;
 	int sign;
+	int add_line_prefix;
 	enum {
+		/*
+		 * Emits [lineprefix][set][sign][reset] and then calls
+		 * ws_check_emit which will output "line", marked up
+		 * according to ws_rule.
+		 */
 		BPL_EMIT_LINE_WS,
+
+		/* Emits [lineprefix][set][sign] line [reset] */
 		BPL_EMIT_LINE_ASIS,
+
+		/* Reloads the ws_rule; line contains the file name */
 		BPL_HANDOVER
 	} state;
 };
 #define BUFFERED_PATCH_LINE_INIT {NULL, NULL, NULL, 0, 0, 0}
 
-struct buffered_filepair {
-	const char *ws;
-	unsigned ws_rule;
-};
-
-struct moved_entry;
-
 struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
@@ -220,32 +223,21 @@ struct diff_options {
 
 	int diff_path_counter;
 
-	/* Determines color moved code. Flipped between 1, 2 for alt. color. */
-	int color_moved;
+	unsigned ws_rule;
 	int use_buffer;
 
 	struct buffered_patch_line *line_buffer;
 	int line_buffer_nr, line_buffer_alloc;
 
-	struct buffered_filepair *filepair_buffer;
-	int filepair_buffer_nr, filepair_buffer_alloc;
-	struct buffered_filepair *current_filepair;
-
-	/* built up in the first pass: */
+	int color_moved;
 	struct hashmap *deleted_lines;
 	struct hashmap *added_lines;
-	/* needed for building up */
-	struct moved_entry *prev_line;
-
-	/* state in the second pass */
-	struct moved_entry **pmb; /* potentially moved blocks */
-	int pmb_nr, pmb_alloc;
 };
 
 void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
-		   const char *fmt, ...);
+		   int add_line_prefix, const char *fmt, ...);
 void emit_line(struct diff_options *o, const char *set, const char *reset,
-	       const char *line, int len);
+	       int add_line_prefix, int markup_ws, int sign, const char *line, int len);
 
 enum color_diff {
 	DIFF_RESET = 0,
diff --git a/submodule.c b/submodule.c
index cfad469a2f..868f913971 100644
--- a/submodule.c
+++ b/submodule.c
@@ -378,9 +378,9 @@ static void print_submodule_summary(struct rev_info *rev,
 		format_commit_message(commit, format, &sb, &ctx);
 		strbuf_addch(&sb, '\n');
 		if (commit->object.flags & SYMMETRIC_LEFT)
-			emit_line(o, del, reset, sb.buf, sb.len);
+			emit_line(o, del, reset, 1, 0, 0, sb.buf, sb.len);
 		else if (add)
-			emit_line(o, add, reset, sb.buf, sb.len);
+			emit_line(o, add, reset, 1, 0, 0, sb.buf, sb.len);
 	}
 	strbuf_release(&sb);
 }
@@ -419,10 +419,10 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	int fast_forward = 0, fast_backward = 0;
 
 	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-		emit_line_fmt(o, NULL, NULL,
+		emit_line_fmt(o, NULL, NULL, 1,
 			      "Submodule %s contains untracked content\n", path);
 	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-		emit_line_fmt(o, NULL, NULL,
+		emit_line_fmt(o, NULL, NULL, 1,
 			      "Submodule %s contains modified content\n", path);
 
 	if (is_null_oid(one))
@@ -473,7 +473,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 		strbuf_addf(&sb, " %s\n", message);
 	else
 		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");
-	emit_line(o, meta, reset, sb.buf, sb.len);
+	emit_line(o, meta, reset, 1, 0, 0, sb.buf, sb.len);
 
 	strbuf_release(&sb);
 }
@@ -501,7 +501,7 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 	/* Treat revision walker failure the same as missing commits */
 	if (prepare_submodule_summary(&rev, path, left, right, merge_bases)) {
 		const char *error = "(revision walker failed)\n";
-		emit_line(o, NULL, NULL, error, strlen(error));
+		emit_line(o, NULL, NULL, 1, 0, 0, error, strlen(error));
 		goto out;
 	}
 
@@ -570,15 +570,15 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	prepare_submodule_repo_env(&cp.env_array);
 	if (start_command(&cp)) {
 		const char *error = "(diff failed)\n";
-		emit_line(o, NULL, NULL, error, strlen(error));
+		emit_line(o, NULL, NULL, 1, 0, 0, error, strlen(error));
 	}
 
 	while (strbuf_getwholeline_fd(&sb, cp.out, '\n') != EOF)
-		emit_line(o, NULL, NULL, sb.buf, sb.len);
+		emit_line(o, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 
 	if (finish_command(&cp)) {
 		const char *error = "(diff failed)\n";
-		emit_line(o, NULL, NULL, error, strlen(error));
+		emit_line(o, NULL, NULL, 1, 0, 0, error, strlen(error));
 	}
 
 done:


-- 
2.13.0.18.g7d86cc8ba0

