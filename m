Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C134889A
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773714105; cv=none; b=WMWlLZtt+gzEjhvLRLAFO8pHsBWMr4CCQQR1+Hd2U44AzZd5W6+S6ISKvGYjvbQgrk+fUI/m9uFKA9eLqFDt0onFLu58kTpvftD5IPmKm1qvETSOi8gBJbZOAgeonmUHn7gecCpk91OT4nyiu5sCmn895giF65Lo9PUtSTnPUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773714105; c=relaxed/simple;
	bh=93gEWPA1amBXVn9z6J6XhIemZ8+isuJ3pAAdlInNI2g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O0YL5mjwItP7ybzbMdEZJC08G4otg+qk2nJsEOlLfthwtMnNusO1zZtUCcG/DD26NdOtHV+SlFMbwa5HTIbQFzpmOJO7yGp+jrebU2jr6cnRciA7mo5mWe9Ti1QU0sDx9EAN/4xRrdNjKdqNGO/lrPOspFhaQW+6O95GVX50/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHskj/MH; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHskj/MH"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1273349c56bso7818239c88.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773714101; x=1774318901; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLVna5wOShNfyqMfbWw13+09i3JT/nR6o4b9fN9akJY=;
        b=KHskj/MHPIoBv20y8evwxt9bUMBEjYoRCKCPo9RWOrrHZUM/ojgLv1GnJtZj0AKORr
         jghmGT90oQc/y/nAKUCt7ryYKp72BgZp4rYNq0OyXfN6Gkl3sTIGdss+YAzT6WJ3SeLV
         OKTiZc8eFpk443VkJyno6jDyS5d25RkO64lOD3UPNTkbskT6UZxn5bU/uYEUQBJ7+oqD
         ODemWhlrYN3Tt4dN/0Ty5MO7lnUOkMhqHExg58YMIGzl7/5hvdYyPgqlMGB/y2fpxm9U
         ruddQH4TXlWJ+PswIShS3ep2iyIveVKAG9l55O0PFVeLnj8iKku5ceVGbhQdgCZlv+bR
         hr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773714101; x=1774318901;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLVna5wOShNfyqMfbWw13+09i3JT/nR6o4b9fN9akJY=;
        b=dRhhZF63d30+O8qKCnswNdQgH3O/3eEWdGNG814ew04ogs/OtoKC4yMxrHyArAi90l
         iznroFbP5NR6bsHLHAYbeb5fE6OGX28xMCR+ewd7aKYL5ecPwZn9AybQ5Jh0p00zzT9Q
         pU5tEhbRUFvxhlqAcJKyZj8BzJLRRVL5fcY3TZ3Sw/DUpdbwZmYTiU8QFx5Nov6N/ji9
         5w0hKbBoHDdHYEzYKN8qAQViSKwb5w7AgEwJwxa80Unr9WeOEjTXHDnZ3wEd9fgCPyQb
         LIZrVz8Te36m2znKLKHayXZs+ka3nPYxtmR1MUn9DMAAskw+3d6i06mAs9ZMtgvpAT+I
         eYUQ==
X-Gm-Message-State: AOJu0Yx1GQQPn6lrq8ZppVl+EW4aEKW0ZaaIgMhlUMVJwJpn6METoMCe
	Qo3fezZVpkG0n5CuhUwQKgXtznsz3Ndgpyczc0YSawKNlBw6QNW1M6D4Oy/agZl6
X-Gm-Gg: ATEYQzyqsZxYMerTMZUmDO1zJIFLw0btzKdBJXpH83qihZmT2rkF8TXMceUjcoDbkkT
	gTG8CX+pvWkeMtxZYgxtVtHA9/kgJ6fEakw2oC1J4vmST4ZlhNXJuwVDFsAaULQXjZ5GrculUNE
	YVpvnPBmcsGEgu0rYe+w1v3mmsWExzi8nYhxs4K1ioZLX7pwv1tYEt/Hmc8iQtFCy/cw+drZc+G
	nhEU7nhHFzmBlMEJFrcdjBRBH718uKu4EfCF/TM0CnT7tRuc3hacTWNPeQN8HDQGTbSnOShN0Fj
	HHkq7B9cebAHUkmO45D/yVdCvcAejQAC2oHEWLM8WZvMFjm/rFqc8PkPRx4mCyG8xvyLcF1pTnw
	iUrjkVZd64vrlr8Svft8OoLFG6GLOqSzqUZboA19Grv30Io89bZOau0TZMWi62DpMrHqwLeK//+
	KY72vp2rYVRLw81jUGFzbMcds=
X-Received: by 2002:a05:7022:2529:b0:128:e693:b61c with SMTP id a92af1059eb24-128f3dd169bmr6517272c88.27.1773714099917;
        Mon, 16 Mar 2026 19:21:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.50.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f618f01csm14219937c88.0.2026.03.16.19.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 19:21:39 -0700 (PDT)
Message-Id: <4e2bc55082e79654ebf0d30fc00479a5eb29f750.1773714095.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.v2.git.1773714095.gitgitgadget@gmail.com>
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
	<pull.2065.v2.git.1773714095.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 02:21:33 +0000
Subject: [PATCH v2 2/4] line-log: route -L output through the standard diff
 pipeline
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

`git log -L` has always bypassed the standard diff pipeline.
`dump_diff_hacky()` in line-log.c hand-rolls its own diff headers and
hunk output, which means most diff formatting options are silently
ignored.  A NEEDSWORK comment has acknowledged this since the feature
was introduced:

    /*
     * NEEDSWORK: manually building a diff here is not the Right
     * Thing(tm).  log -L should be built into the diff pipeline.
     */

Remove `dump_diff_hacky()` and its helpers and route -L output through
`builtin_diff()` / `fn_out_consume()`, the same path used by `git diff`
and `git log -p`.  The mechanism is a pair of callback wrappers that sit
between `xdi_diff_outf()` and `fn_out_consume()`, filtering xdiff's
output to only the tracked line ranges.  To ensure xdiff emits all lines
within each range as context, the context length is inflated to span the
largest range.

Wire up the `-L` implies `--patch` default in revision setup rather
than forcing it at output time, so `line_log_print()` is just
`diffcore_std()` + `diff_flush()` with no format save/restore.
Rename detection is a no-op since pairs are already resolved during
the history walk in `queue_diffs()`, but running `diffcore_std()`
means `-S`/`-G` (pickaxe), `--orderfile`, and `--diff-filter` now
work with `-L`, and `diff_resolve_rename_copy()` sets pair statuses
correctly without manual assignment.

Switch `diff_filepair_dup()` from `xmalloc` to `xcalloc` so that new
fields (including `line_ranges`) are zero-initialized by default.

As a result, diff formatting options that were previously silently
ignored (e.g. --word-diff, --no-prefix, -w, --color-moved) now work
with -L, and output gains `index` lines, `new file mode` headers, and
funcname context in `@@` headers.  This is a user-visible output change:
tools that parse -L output may need to handle the additional header
lines.

The context-length inflation means xdiff may process more output than
needed for very wide line ranges, but benchmarks on files up to 7800
lines show no measurable regression.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c                                        | 279 +++++++++++++++++-
 diffcore.h                                    |  16 +
 line-log.c                                    | 174 ++---------
 line-log.h                                    |  14 +-
 revision.c                                    |   2 +
 t/t4211-line-log.sh                           |  12 +-
 t/t4211/sha1/expect.beginning-of-file         |   4 +
 t/t4211/sha1/expect.end-of-file               |  11 +-
 t/t4211/sha1/expect.move-support-f            |   5 +
 t/t4211/sha1/expect.multiple                  |  10 +-
 t/t4211/sha1/expect.multiple-overlapping      |   7 +
 t/t4211/sha1/expect.multiple-superset         |   7 +
 t/t4211/sha1/expect.no-assertion-error        |  12 +-
 t/t4211/sha1/expect.parallel-change-f-to-main |   7 +
 t/t4211/sha1/expect.simple-f                  |   4 +
 t/t4211/sha1/expect.simple-f-to-main          |   5 +
 t/t4211/sha1/expect.simple-main               |  11 +-
 t/t4211/sha1/expect.simple-main-to-end        |  11 +-
 t/t4211/sha1/expect.two-ranges                |  10 +-
 t/t4211/sha1/expect.vanishes-early            |  10 +-
 t/t4211/sha256/expect.beginning-of-file       |   4 +
 t/t4211/sha256/expect.end-of-file             |  11 +-
 t/t4211/sha256/expect.move-support-f          |   5 +
 t/t4211/sha256/expect.multiple                |  10 +-
 t/t4211/sha256/expect.multiple-overlapping    |   7 +
 t/t4211/sha256/expect.multiple-superset       |   7 +
 t/t4211/sha256/expect.no-assertion-error      |  12 +-
 .../sha256/expect.parallel-change-f-to-main   |   7 +
 t/t4211/sha256/expect.simple-f                |   4 +
 t/t4211/sha256/expect.simple-f-to-main        |   5 +
 t/t4211/sha256/expect.simple-main             |  11 +-
 t/t4211/sha256/expect.simple-main-to-end      |  11 +-
 t/t4211/sha256/expect.two-ranges              |  10 +-
 t/t4211/sha256/expect.vanishes-early          |  10 +-
 34 files changed, 512 insertions(+), 213 deletions(-)

diff --git a/diff.c b/diff.c
index 35b903a9a0..c8cbbbb1db 100644
--- a/diff.c
+++ b/diff.c
@@ -608,6 +608,52 @@ struct emit_callback {
 	struct strbuf *header;
 };
 
+/*
+ * State for the line-range callback wrappers that sit between
+ * xdi_diff_outf() and fn_out_consume().  xdiff produces a normal,
+ * unfiltered diff; the wrappers intercept each hunk header and line,
+ * track post-image position, and forward only lines that fall within
+ * the requested ranges.  Contiguous in-range lines are collected into
+ * range hunks and flushed with a synthetic @@ header so that
+ * fn_out_consume() sees well-formed unified-diff fragments.
+ *
+ * Removal lines ('-') cannot be classified by post-image position, so
+ * they are buffered in pending_rm until the next '+' or ' ' line
+ * reveals whether they precede an in-range line (flush into range hunk) or
+ * an out-of-range line (discard).
+ */
+struct line_range_callback {
+	xdiff_emit_line_fn orig_line_fn;
+	void *orig_cb_data;
+	const struct range_set *ranges;	/* 0-based [start, end) */
+	unsigned int cur_range;		/* index into the range_set */
+
+	/* Post/pre-image line counters (1-based, set from hunk headers) */
+	long lno_post;
+	long lno_pre;
+
+	/*
+	 * Function name from most recent xdiff hunk header;
+	 * size matches struct func_line.buf in xdiff/xemit.c.
+	 */
+	char func[80];
+	long funclen;
+
+	/* Range hunk being accumulated for the current range */
+	struct strbuf rhunk;
+	long rhunk_old_begin, rhunk_old_count;
+	long rhunk_new_begin, rhunk_new_count;
+	int rhunk_active;
+	int rhunk_has_changes;		/* any '+' or '-' lines? */
+
+	/* Removal lines not yet known to be in-range */
+	struct strbuf pending_rm;
+	int pending_rm_count;
+	long pending_rm_pre_begin;	/* pre-image line of first pending */
+
+	int ret;			/* latched error from orig_line_fn */
+};
+
 static int count_lines(const char *data, int size)
 {
 	int count, ch, completely_empty = 1, nl_just_seen = 0;
@@ -2486,6 +2532,188 @@ static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED
 	return 1;
 }
 
+static void discard_pending_rm(struct line_range_callback *s)
+{
+	strbuf_reset(&s->pending_rm);
+	s->pending_rm_count = 0;
+}
+
+static void flush_rhunk(struct line_range_callback *s)
+{
+	struct strbuf hdr = STRBUF_INIT;
+	const char *p, *end;
+
+	if (!s->rhunk_active || s->ret)
+		return;
+
+	/* Drain any pending removal lines into the range hunk */
+	if (s->pending_rm_count) {
+		strbuf_addbuf(&s->rhunk, &s->pending_rm);
+		s->rhunk_old_count += s->pending_rm_count;
+		s->rhunk_has_changes = 1;
+		discard_pending_rm(s);
+	}
+
+	/*
+	 * Suppress context-only hunks: they contain no actual changes
+	 * and would just be noise.  This can happen when the inflated
+	 * ctxlen causes xdiff to emit context covering a range that
+	 * has no changes in this commit.
+	 */
+	if (!s->rhunk_has_changes) {
+		s->rhunk_active = 0;
+		strbuf_reset(&s->rhunk);
+		return;
+	}
+
+	strbuf_addf(&hdr, "@@ -%ld,%ld +%ld,%ld @@",
+		    s->rhunk_old_begin, s->rhunk_old_count,
+		    s->rhunk_new_begin, s->rhunk_new_count);
+	if (s->funclen > 0) {
+		strbuf_addch(&hdr, ' ');
+		strbuf_add(&hdr, s->func, s->funclen);
+	}
+	strbuf_addch(&hdr, '\n');
+
+	s->ret = s->orig_line_fn(s->orig_cb_data, hdr.buf, hdr.len);
+	strbuf_release(&hdr);
+
+	/*
+	 * Replay buffered lines one at a time through fn_out_consume.
+	 * The cast discards const because xdiff_emit_line_fn takes
+	 * char *, though fn_out_consume does not modify the buffer.
+	 */
+	p = s->rhunk.buf;
+	end = p + s->rhunk.len;
+	while (!s->ret && p < end) {
+		const char *eol = memchr(p, '\n', end - p);
+		unsigned long line_len = eol ? (unsigned long)(eol - p + 1)
+					     : (unsigned long)(end - p);
+		s->ret = s->orig_line_fn(s->orig_cb_data, (char *)p, line_len);
+		p += line_len;
+	}
+
+	s->rhunk_active = 0;
+	strbuf_reset(&s->rhunk);
+}
+
+static void line_range_hunk_fn(void *data,
+			       long old_begin, long old_nr UNUSED,
+			       long new_begin, long new_nr UNUSED,
+			       const char *func, long funclen)
+{
+	struct line_range_callback *s = data;
+
+	/*
+	 * When count > 0, begin is 1-based.  When count == 0, begin is
+	 * adjusted down by 1 by xdl_emit_hunk_hdr(), but no lines of
+	 * that type will arrive, so the value is unused.
+	 *
+	 * Any pending removal lines from the previous xdiff hunk are
+	 * intentionally left in pending_rm: the line callback will
+	 * flush or discard them when the next content line reveals
+	 * whether the removals precede in-range content.
+	 */
+	s->lno_post = new_begin;
+	s->lno_pre = old_begin;
+
+	if (funclen > 0) {
+		if (funclen > (long)sizeof(s->func))
+			funclen = sizeof(s->func);
+		memcpy(s->func, func, funclen);
+	}
+	s->funclen = funclen;
+}
+
+static int line_range_line_fn(void *priv, char *line, unsigned long len)
+{
+	struct line_range_callback *s = priv;
+	const struct range *cur;
+	long lno_0, cur_pre;
+
+	if (s->ret)
+		return s->ret;
+
+	if (line[0] == '-') {
+		if (!s->pending_rm_count)
+			s->pending_rm_pre_begin = s->lno_pre;
+		s->lno_pre++;
+		strbuf_add(&s->pending_rm, line, len);
+		s->pending_rm_count++;
+		return s->ret;
+	}
+
+	if (line[0] == '\\') {
+		if (s->pending_rm_count)
+			strbuf_add(&s->pending_rm, line, len);
+		else if (s->rhunk_active)
+			strbuf_add(&s->rhunk, line, len);
+		/* otherwise outside tracked range; drop silently */
+		return s->ret;
+	}
+
+	if (line[0] != '+' && line[0] != ' ')
+		BUG("unexpected diff line type '%c'", line[0]);
+
+	lno_0 = s->lno_post - 1;
+	cur_pre = s->lno_pre;	/* save before advancing for context lines */
+	s->lno_post++;
+	if (line[0] == ' ')
+		s->lno_pre++;
+
+	/* Advance past ranges we've passed */
+	while (s->cur_range < s->ranges->nr &&
+	       lno_0 >= s->ranges->ranges[s->cur_range].end) {
+		if (s->rhunk_active)
+			flush_rhunk(s);
+		discard_pending_rm(s);
+		s->cur_range++;
+	}
+
+	/* Past all ranges */
+	if (s->cur_range >= s->ranges->nr) {
+		discard_pending_rm(s);
+		return s->ret;
+	}
+
+	cur = &s->ranges->ranges[s->cur_range];
+
+	/* Before current range */
+	if (lno_0 < cur->start) {
+		discard_pending_rm(s);
+		return s->ret;
+	}
+
+	/* In range so start a new range hunk if needed */
+	if (!s->rhunk_active) {
+		s->rhunk_active = 1;
+		s->rhunk_has_changes = 0;
+		s->rhunk_new_begin = lno_0 + 1;
+		s->rhunk_old_begin = s->pending_rm_count
+			? s->pending_rm_pre_begin : cur_pre;
+		s->rhunk_old_count = 0;
+		s->rhunk_new_count = 0;
+		strbuf_reset(&s->rhunk);
+	}
+
+	/* Flush pending removals into range hunk */
+	if (s->pending_rm_count) {
+		strbuf_addbuf(&s->rhunk, &s->pending_rm);
+		s->rhunk_old_count += s->pending_rm_count;
+		s->rhunk_has_changes = 1;
+		discard_pending_rm(s);
+	}
+
+	strbuf_add(&s->rhunk, line, len);
+	s->rhunk_new_count++;
+	if (line[0] == '+')
+		s->rhunk_has_changes = 1;
+	else
+		s->rhunk_old_count++;
+
+	return s->ret;
+}
+
 static void pprint_rename(struct strbuf *name, const char *a, const char *b)
 {
 	const char *old_name = a;
@@ -3589,7 +3817,8 @@ static void builtin_diff(const char *name_a,
 			 const char *xfrm_msg,
 			 int must_show_header,
 			 struct diff_options *o,
-			 int complete_rewrite)
+			 int complete_rewrite,
+			 const struct range_set *line_ranges)
 {
 	mmfile_t mf1, mf2;
 	const char *lbl[2];
@@ -3823,6 +4052,52 @@ static void builtin_diff(const char *name_a,
 			 */
 			xdi_diff_outf(&mf1, &mf2, NULL, quick_consume,
 				      &ecbdata, &xpp, &xecfg);
+		} else if (line_ranges) {
+			struct line_range_callback lr_state;
+			unsigned int i;
+			long max_span = 0;
+
+			memset(&lr_state, 0, sizeof(lr_state));
+			lr_state.orig_line_fn = fn_out_consume;
+			lr_state.orig_cb_data = &ecbdata;
+			lr_state.ranges = line_ranges;
+			strbuf_init(&lr_state.rhunk, 0);
+			strbuf_init(&lr_state.pending_rm, 0);
+
+			/*
+			 * Inflate ctxlen so that all changes within
+			 * any single range are merged into one xdiff
+			 * hunk and the inter-change context is emitted.
+			 * The callback clips back to range boundaries.
+			 *
+			 * The optimal ctxlen depends on where changes
+			 * fall within the range, which is only known
+			 * after xdiff runs; the max range span is the
+			 * upper bound that guarantees correctness in a
+			 * single pass.
+			 */
+			for (i = 0; i < line_ranges->nr; i++) {
+				long span = line_ranges->ranges[i].end -
+					    line_ranges->ranges[i].start;
+				if (span > max_span)
+					max_span = span;
+			}
+			if (max_span > xecfg.ctxlen)
+				xecfg.ctxlen = max_span;
+
+			if (xdi_diff_outf(&mf1, &mf2,
+					  line_range_hunk_fn,
+					  line_range_line_fn,
+					  &lr_state, &xpp, &xecfg))
+				die("unable to generate diff for %s",
+				    one->path);
+
+			flush_rhunk(&lr_state);
+			if (lr_state.ret)
+				die("unable to generate diff for %s",
+				    one->path);
+			strbuf_release(&lr_state.rhunk);
+			strbuf_release(&lr_state.pending_rm);
 		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
 					 &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
@@ -4660,7 +4935,7 @@ static void run_diff_cmd(const struct external_diff *pgm,
 
 		builtin_diff(name, other ? other : name,
 			     one, two, xfrm_msg, must_show_header,
-			     o, complete_rewrite);
+			     o, complete_rewrite, p->line_ranges);
 		if (p->status == DIFF_STATUS_COPIED ||
 		    p->status == DIFF_STATUS_RENAMED)
 			o->found_changes = 1;
diff --git a/diffcore.h b/diffcore.h
index 9c0a0e7aaf..d75038d1b3 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -19,6 +19,17 @@ struct userdiff_driver;
  * in anything else.
  */
 
+/* A range [start, end).  Lines are numbered starting at 0. */
+struct range {
+	long start, end;
+};
+
+/* A set of ranges.  The ranges must always be disjoint and sorted. */
+struct range_set {
+	unsigned int alloc, nr;
+	struct range *ranges;
+};
+
 /* We internally use unsigned short as the score value,
  * and rely on an int capable to hold 32-bits.  -B can take
  * -Bmerge_score/break_score format and the two scores are
@@ -106,6 +117,11 @@ int diff_filespec_is_binary(struct repository *, struct diff_filespec *);
 struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
+	/*
+	 * Tracked line ranges for -L filtering; borrowed from
+	 * line_log_data and must not be freed.
+	 */
+	const struct range_set *line_ranges;
 	unsigned short int score;
 	char status; /* M C R A D U etc. (see Documentation/diff-format.adoc or DIFF_STATUS_* in diff.h) */
 	unsigned broken_pair : 1;
diff --git a/line-log.c b/line-log.c
index 9d12ece181..858a899cd2 100644
--- a/line-log.c
+++ b/line-log.c
@@ -885,160 +885,6 @@ static void queue_diffs(struct line_log_data *range,
 	move_diff_queue(queue, &diff_queued_diff);
 }
 
-static char *get_nth_line(long line, unsigned long *ends, void *data)
-{
-	if (line == 0)
-		return (char *)data;
-	else
-		return (char *)data + ends[line] + 1;
-}
-
-static void print_line(const char *prefix, char first,
-		       long line, unsigned long *ends, void *data,
-		       const char *color, const char *reset, FILE *file)
-{
-	char *begin = get_nth_line(line, ends, data);
-	char *end = get_nth_line(line+1, ends, data);
-	int had_nl = 0;
-
-	if (end > begin && end[-1] == '\n') {
-		end--;
-		had_nl = 1;
-	}
-
-	fputs(prefix, file);
-	fputs(color, file);
-	putc(first, file);
-	fwrite(begin, 1, end-begin, file);
-	fputs(reset, file);
-	putc('\n', file);
-	if (!had_nl)
-		fputs("\\ No newline at end of file\n", file);
-}
-
-static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *range)
-{
-	unsigned int i, j = 0;
-	long p_lines, t_lines;
-	unsigned long *p_ends = NULL, *t_ends = NULL;
-	struct diff_filepair *pair = range->pair;
-	struct diff_ranges *diff = &range->diff;
-
-	struct diff_options *opt = &rev->diffopt;
-	const char *prefix = diff_line_prefix(opt);
-	const char *c_reset = diff_get_color(opt->use_color, DIFF_RESET);
-	const char *c_frag = diff_get_color(opt->use_color, DIFF_FRAGINFO);
-	const char *c_meta = diff_get_color(opt->use_color, DIFF_METAINFO);
-	const char *c_old = diff_get_color(opt->use_color, DIFF_FILE_OLD);
-	const char *c_new = diff_get_color(opt->use_color, DIFF_FILE_NEW);
-	const char *c_context = diff_get_color(opt->use_color, DIFF_CONTEXT);
-
-	if (!pair || !diff)
-		goto out;
-
-	if (pair->one->oid_valid)
-		fill_line_ends(rev->diffopt.repo, pair->one, &p_lines, &p_ends);
-	fill_line_ends(rev->diffopt.repo, pair->two, &t_lines, &t_ends);
-
-	fprintf(opt->file, "%s%sdiff --git a/%s b/%s%s\n", prefix, c_meta, pair->one->path, pair->two->path, c_reset);
-	fprintf(opt->file, "%s%s--- %s%s%s\n", prefix, c_meta,
-	       pair->one->oid_valid ? "a/" : "",
-	       pair->one->oid_valid ? pair->one->path : "/dev/null",
-	       c_reset);
-	fprintf(opt->file, "%s%s+++ b/%s%s\n", prefix, c_meta, pair->two->path, c_reset);
-	for (i = 0; i < range->ranges.nr; i++) {
-		long p_start, p_end;
-		long t_start = range->ranges.ranges[i].start;
-		long t_end = range->ranges.ranges[i].end;
-		long t_cur = t_start;
-		unsigned int j_last;
-
-		/*
-		 * If a diff range touches multiple line ranges, then all
-		 * those line ranges should be shown, so take a step back if
-		 * the current line range is still in the previous diff range
-		 * (even if only partially).
-		 */
-		if (j > 0 && diff->target.ranges[j-1].end > t_start)
-			j--;
-
-		while (j < diff->target.nr && diff->target.ranges[j].end < t_start)
-			j++;
-		if (j == diff->target.nr || diff->target.ranges[j].start >= t_end)
-			continue;
-
-		/* Scan ahead to determine the last diff that falls in this range */
-		j_last = j;
-		while (j_last < diff->target.nr && diff->target.ranges[j_last].start < t_end)
-			j_last++;
-		if (j_last > j)
-			j_last--;
-
-		/*
-		 * Compute parent hunk headers: we know that the diff
-		 * has the correct line numbers (but not all hunks).
-		 * So it suffices to shift the start/end according to
-		 * the line numbers of the first/last hunk(s) that
-		 * fall in this range.
-		 */
-		if (t_start < diff->target.ranges[j].start)
-			p_start = diff->parent.ranges[j].start - (diff->target.ranges[j].start-t_start);
-		else
-			p_start = diff->parent.ranges[j].start;
-		if (t_end > diff->target.ranges[j_last].end)
-			p_end = diff->parent.ranges[j_last].end + (t_end-diff->target.ranges[j_last].end);
-		else
-			p_end = diff->parent.ranges[j_last].end;
-
-		if (!p_start && !p_end) {
-			p_start = -1;
-			p_end = -1;
-		}
-
-		/* Now output a diff hunk for this range */
-		fprintf(opt->file, "%s%s@@ -%ld,%ld +%ld,%ld @@%s\n",
-		       prefix, c_frag,
-		       p_start+1, p_end-p_start, t_start+1, t_end-t_start,
-		       c_reset);
-		while (j < diff->target.nr && diff->target.ranges[j].start < t_end) {
-			int k;
-			for (; t_cur < diff->target.ranges[j].start; t_cur++)
-				print_line(prefix, ' ', t_cur, t_ends, pair->two->data,
-					   c_context, c_reset, opt->file);
-			for (k = diff->parent.ranges[j].start; k < diff->parent.ranges[j].end; k++)
-				print_line(prefix, '-', k, p_ends, pair->one->data,
-					   c_old, c_reset, opt->file);
-			for (; t_cur < diff->target.ranges[j].end && t_cur < t_end; t_cur++)
-				print_line(prefix, '+', t_cur, t_ends, pair->two->data,
-					   c_new, c_reset, opt->file);
-			j++;
-		}
-		for (; t_cur < t_end; t_cur++)
-			print_line(prefix, ' ', t_cur, t_ends, pair->two->data,
-				   c_context, c_reset, opt->file);
-	}
-
-out:
-	free(p_ends);
-	free(t_ends);
-}
-
-/*
- * NEEDSWORK: manually building a diff here is not the Right
- * Thing(tm).  log -L should be built into the diff pipeline.
- */
-static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *range)
-{
-	const char *prefix = diff_line_prefix(&rev->diffopt);
-
-	fprintf(rev->diffopt.file, "%s\n", prefix);
-
-	while (range) {
-		dump_diff_hacky_one(rev, range);
-		range = range->next;
-	}
-}
-
 /*
  * Unlike most other functions, this destructively operates on
  * 'range'.
@@ -1102,7 +948,7 @@ static int process_diff_filepair(struct rev_info *rev,
 
 static struct diff_filepair *diff_filepair_dup(struct diff_filepair *pair)
 {
-	struct diff_filepair *new_filepair = xmalloc(sizeof(struct diff_filepair));
+	struct diff_filepair *new_filepair = xcalloc(1, sizeof(struct diff_filepair));
 	new_filepair->one = pair->one;
 	new_filepair->two = pair->two;
 	new_filepair->one->count++;
@@ -1160,11 +1006,25 @@ static int process_all_files(struct line_log_data **range_out,
 
 int line_log_print(struct rev_info *rev, struct commit *commit)
 {
-
 	show_log(rev);
 	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT)) {
 		struct line_log_data *range = lookup_line_range(rev, commit);
-		dump_diff_hacky(rev, range);
+		struct line_log_data *r;
+		const char *prefix = diff_line_prefix(&rev->diffopt);
+
+		fprintf(rev->diffopt.file, "%s\n", prefix);
+
+		for (r = range; r; r = r->next) {
+			if (r->pair) {
+				struct diff_filepair *p =
+					diff_filepair_dup(r->pair);
+				p->line_ranges = &r->ranges;
+				diff_q(&diff_queued_diff, p);
+			}
+		}
+
+		diffcore_std(&rev->diffopt);
+		diff_flush(&rev->diffopt);
 	}
 	return 1;
 }
diff --git a/line-log.h b/line-log.h
index e9dadbc1a5..04a6ea64d3 100644
--- a/line-log.h
+++ b/line-log.h
@@ -1,22 +1,12 @@
 #ifndef LINE_LOG_H
 #define LINE_LOG_H
 
+#include "diffcore.h" /* struct range, struct range_set */
+
 struct rev_info;
 struct commit;
 struct string_list;
 
-/* A range [start,end].  Lines are numbered starting at 0, and the
- * ranges include start but exclude end. */
-struct range {
-	long start, end;
-};
-
-/* A set of ranges.  The ranges must always be disjoint and sorted. */
-struct range_set {
-	unsigned int alloc, nr;
-	struct range *ranges;
-};
-
 /* A diff, encoded as the set of pre- and post-image ranges where the
  * files differ. A pair of ranges corresponds to a hunk. */
 struct diff_ranges {
diff --git a/revision.c b/revision.c
index 047ff7e458..9f68bedf13 100644
--- a/revision.c
+++ b/revision.c
@@ -3111,6 +3111,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		if (want_ancestry(revs))
 			revs->limited = 1;
 		revs->topo_order = 1;
+		if (!revs->diffopt.output_format)
+			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
 
 	if (revs->topo_order && !generation_numbers_enabled(the_repository))
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 659a943aa1..6a307e911b 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -129,7 +129,7 @@ test_expect_success '-L with --output' '
 	git checkout parallel-change &&
 	git log --output=log -L :main:b.c >output &&
 	test_must_be_empty output &&
-	test_line_count = 70 log
+	test_line_count = 75 log
 '
 
 test_expect_success 'range_set_union' '
@@ -340,13 +340,19 @@ test_expect_success 'zero-width regex .* matches any function name' '
 '
 
 test_expect_success 'show line-log with graph' '
+	git checkout parent-oids &&
+	head_blob_old=$(git rev-parse --short HEAD^:file.c) &&
+	head_blob_new=$(git rev-parse --short HEAD:file.c) &&
+	root_blob=$(git rev-parse --short HEAD~4:file.c) &&
+	null_blob=$(test_oid zero | cut -c1-7) &&
 	qz_to_tab_space >expect <<-EOF &&
 	* $head_oid Modify func2() in file.c
 	|Z
 	| diff --git a/file.c b/file.c
+	| index $head_blob_old..$head_blob_new 100644
 	| --- a/file.c
 	| +++ b/file.c
-	| @@ -6,4 +6,4 @@
+	| @@ -6,4 +6,4 @@ int func1()
 	|  int func2()
 	|  {
 	| -    return F2;
@@ -355,6 +361,8 @@ test_expect_success 'show line-log with graph' '
 	* $root_oid Add func1() and func2() in file.c
 	ZZ
 	  diff --git a/file.c b/file.c
+	  new file mode 100644
+	  index $null_blob..$root_blob
 	  --- /dev/null
 	  +++ b/file.c
 	  @@ -0,0 +6,4 @@
diff --git a/t/t4211/sha1/expect.beginning-of-file b/t/t4211/sha1/expect.beginning-of-file
index 91b4054898..52c90afb3a 100644
--- a/t/t4211/sha1/expect.beginning-of-file
+++ b/t/t4211/sha1/expect.beginning-of-file
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:47:40 2013 +0100
     change at very beginning
 
 diff --git a/a.c b/a.c
+index bdb2bb1..5e709a1 100644
 --- a/a.c
 +++ b/a.c
 @@ -1,3 +1,4 @@
@@ -20,6 +21,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
 @@ -1,3 +1,3 @@
@@ -35,6 +37,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +1,3 @@
diff --git a/t/t4211/sha1/expect.end-of-file b/t/t4211/sha1/expect.end-of-file
index bd25bb2f59..c40036899a 100644
--- a/t/t4211/sha1/expect.end-of-file
+++ b/t/t4211/sha1/expect.end-of-file
@@ -5,9 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index 0b9cae5..5de3ea4 100644
 --- a/a.c
 +++ b/a.c
-@@ -20,3 +20,5 @@
+@@ -20,3 +20,5 @@ long f(long x)
  	printf("%ld\n", f(15));
  	return 0;
 -}
@@ -23,9 +24,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index 5e709a1..0b9cae5 100644
 --- a/a.c
 +++ b/a.c
-@@ -20,3 +20,3 @@
+@@ -20,3 +20,3 @@ int main ()
  	printf("%ld\n", f(15));
  	return 0;
 -}
@@ -39,9 +41,10 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
-@@ -19,3 +19,3 @@
+@@ -19,3 +19,3 @@ int f(int x)
 -	printf("%d\n", f(15));
 +	printf("%ld\n", f(15));
  	return 0;
@@ -54,6 +57,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +18,3 @@
diff --git a/t/t4211/sha1/expect.move-support-f b/t/t4211/sha1/expect.move-support-f
index c905e01bc2..ead6500d4d 100644
--- a/t/t4211/sha1/expect.move-support-f
+++ b/t/t4211/sha1/expect.move-support-f
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:49:50 2013 +0100
     another simple change
 
 diff --git a/b.c b/b.c
+index 5de3ea4..bf79c2f 100644
 --- a/b.c
 +++ b/b.c
 @@ -4,9 +4,9 @@
@@ -26,6 +27,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,9 +3,9 @@
@@ -47,6 +49,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,8 +3,9 @@
@@ -67,6 +70,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,8 @@
diff --git a/t/t4211/sha1/expect.multiple b/t/t4211/sha1/expect.multiple
index 1eee8a7801..a41851a51d 100644
--- a/t/t4211/sha1/expect.multiple
+++ b/t/t4211/sha1/expect.multiple
@@ -5,9 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index 0b9cae5..5de3ea4 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,7 @@
+@@ -18,5 +18,7 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -25,9 +26,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index 5e709a1..0b9cae5 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -43,6 +45,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,9 +3,9 @@
@@ -71,6 +74,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,8 +3,9 @@
@@ -91,6 +95,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,8 @@
diff --git a/t/t4211/sha1/expect.multiple-overlapping b/t/t4211/sha1/expect.multiple-overlapping
index d930b6eec4..0ec9990eab 100644
--- a/t/t4211/sha1/expect.multiple-overlapping
+++ b/t/t4211/sha1/expect.multiple-overlapping
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index 0b9cae5..5de3ea4 100644
 --- a/a.c
 +++ b/a.c
 @@ -4,19 +4,21 @@
@@ -39,6 +40,7 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index 5e709a1..0b9cae5 100644
 --- a/a.c
 +++ b/a.c
 @@ -4,19 +4,19 @@
@@ -71,6 +73,7 @@ Date:   Thu Feb 28 10:45:41 2013 +0100
     touch comment
 
 diff --git a/a.c b/a.c
+index e51de13..bdb2bb1 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,19 +3,19 @@
@@ -102,6 +105,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,19 +3,19 @@
@@ -134,6 +138,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,18 +3,19 @@
@@ -164,6 +169,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,18 @@
diff --git a/t/t4211/sha1/expect.multiple-superset b/t/t4211/sha1/expect.multiple-superset
index d930b6eec4..0ec9990eab 100644
--- a/t/t4211/sha1/expect.multiple-superset
+++ b/t/t4211/sha1/expect.multiple-superset
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index 0b9cae5..5de3ea4 100644
 --- a/a.c
 +++ b/a.c
 @@ -4,19 +4,21 @@
@@ -39,6 +40,7 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index 5e709a1..0b9cae5 100644
 --- a/a.c
 +++ b/a.c
 @@ -4,19 +4,19 @@
@@ -71,6 +73,7 @@ Date:   Thu Feb 28 10:45:41 2013 +0100
     touch comment
 
 diff --git a/a.c b/a.c
+index e51de13..bdb2bb1 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,19 +3,19 @@
@@ -102,6 +105,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,19 +3,19 @@
@@ -134,6 +138,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,18 +3,19 @@
@@ -164,6 +169,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,18 @@
diff --git a/t/t4211/sha1/expect.no-assertion-error b/t/t4211/sha1/expect.no-assertion-error
index 994c37db1e..54c568f273 100644
--- a/t/t4211/sha1/expect.no-assertion-error
+++ b/t/t4211/sha1/expect.no-assertion-error
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:50:24 2013 +0100
     move within the file
 
 diff --git a/b.c b/b.c
+index bf79c2f..27c829c 100644
 --- a/b.c
 +++ b/b.c
 @@ -25,0 +18,9 @@
@@ -25,9 +26,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index 0b9cae5..5de3ea4 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,7 @@
+@@ -18,5 +18,7 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -45,9 +47,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index 5e709a1..0b9cae5 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -63,9 +66,10 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
-@@ -17,5 +17,5 @@
+@@ -17,5 +17,5 @@ int f(int x)
  int main ()
  {
 -	printf("%d\n", f(15));
@@ -80,6 +84,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +16,5 @@
diff --git a/t/t4211/sha1/expect.parallel-change-f-to-main b/t/t4211/sha1/expect.parallel-change-f-to-main
index 052def8074..65a8cc673a 100644
--- a/t/t4211/sha1/expect.parallel-change-f-to-main
+++ b/t/t4211/sha1/expect.parallel-change-f-to-main
@@ -13,6 +13,7 @@ Date:   Thu Feb 28 10:49:50 2013 +0100
     another simple change
 
 diff --git a/b.c b/b.c
+index 5de3ea4..bf79c2f 100644
 --- a/b.c
 +++ b/b.c
 @@ -4,14 +4,14 @@
@@ -39,6 +40,7 @@ Date:   Fri Apr 12 16:15:57 2013 +0200
     change on another line of history while rename happens
 
 diff --git a/a.c b/a.c
+index 5de3ea4..01b5b65 100644
 --- a/a.c
 +++ b/a.c
 @@ -4,14 +4,14 @@
@@ -65,6 +67,7 @@ Date:   Thu Feb 28 10:45:41 2013 +0100
     touch comment
 
 diff --git a/a.c b/a.c
+index e51de13..bdb2bb1 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,14 +3,14 @@
@@ -91,6 +94,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,14 +3,14 @@
@@ -117,6 +121,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,13 +3,14 @@
@@ -142,6 +147,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,13 @@
diff --git a/t/t4211/sha1/expect.simple-f b/t/t4211/sha1/expect.simple-f
index a1f5bc49c8..b24ae40e03 100644
--- a/t/t4211/sha1/expect.simple-f
+++ b/t/t4211/sha1/expect.simple-f
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,9 +3,9 @@
@@ -26,6 +27,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,8 +3,9 @@
@@ -46,6 +48,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,8 @@
diff --git a/t/t4211/sha1/expect.simple-f-to-main b/t/t4211/sha1/expect.simple-f-to-main
index a475768710..cd92100dfc 100644
--- a/t/t4211/sha1/expect.simple-f-to-main
+++ b/t/t4211/sha1/expect.simple-f-to-main
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:45:41 2013 +0100
     touch comment
 
 diff --git a/a.c b/a.c
+index e51de13..bdb2bb1 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,14 +3,14 @@
@@ -31,6 +32,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,14 +3,14 @@
@@ -57,6 +59,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,13 +3,14 @@
@@ -82,6 +85,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,13 @@
diff --git a/t/t4211/sha1/expect.simple-main b/t/t4211/sha1/expect.simple-main
index 39ce39bebe..ff31291d34 100644
--- a/t/t4211/sha1/expect.simple-main
+++ b/t/t4211/sha1/expect.simple-main
@@ -5,9 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index 0b9cae5..5de3ea4 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -23,9 +24,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index 5e709a1..0b9cae5 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -41,9 +43,10 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
-@@ -17,5 +17,5 @@
+@@ -17,5 +17,5 @@ int f(int x)
  int main ()
  {
 -	printf("%d\n", f(15));
@@ -58,6 +61,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +16,5 @@
diff --git a/t/t4211/sha1/expect.simple-main-to-end b/t/t4211/sha1/expect.simple-main-to-end
index 8480bd9cc4..4bef21e657 100644
--- a/t/t4211/sha1/expect.simple-main-to-end
+++ b/t/t4211/sha1/expect.simple-main-to-end
@@ -5,9 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index 0b9cae5..5de3ea4 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,7 @@
+@@ -18,5 +18,7 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -25,9 +26,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index 5e709a1..0b9cae5 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -43,9 +45,10 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
-@@ -17,5 +17,5 @@
+@@ -17,5 +17,5 @@ int f(int x)
  int main ()
  {
 -	printf("%d\n", f(15));
@@ -60,6 +63,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +16,5 @@
diff --git a/t/t4211/sha1/expect.two-ranges b/t/t4211/sha1/expect.two-ranges
index c5164f3be3..aed01522e3 100644
--- a/t/t4211/sha1/expect.two-ranges
+++ b/t/t4211/sha1/expect.two-ranges
@@ -5,9 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index 0b9cae5..5de3ea4 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -23,9 +24,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index 5e709a1..0b9cae5 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -41,6 +43,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,9 +3,9 @@
@@ -69,6 +72,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,8 +3,9 @@
@@ -89,6 +93,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,8 @@
diff --git a/t/t4211/sha1/expect.vanishes-early b/t/t4211/sha1/expect.vanishes-early
index 1f7cd06941..a413ad3659 100644
--- a/t/t4211/sha1/expect.vanishes-early
+++ b/t/t4211/sha1/expect.vanishes-early
@@ -5,11 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index 0b9cae5..5de3ea4 100644
 --- a/a.c
 +++ b/a.c
-@@ -22,1 +24,1 @@
--}
-\ No newline at end of file
+@@ -23,0 +24,1 @@ int main ()
 +/* incomplete lines are bad! */
 
 commit 100b61a6f2f720f812620a9d10afb3a960ccb73c
@@ -19,9 +18,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index 5e709a1..0b9cae5 100644
 --- a/a.c
 +++ b/a.c
-@@ -22,1 +22,1 @@
+@@ -22,1 +22,1 @@ int main ()
 -}
 +}
 \ No newline at end of file
@@ -33,6 +33,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..444e415
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +20,1 @@
diff --git a/t/t4211/sha256/expect.beginning-of-file b/t/t4211/sha256/expect.beginning-of-file
index 5adfdfc1a1..e8d62328cf 100644
--- a/t/t4211/sha256/expect.beginning-of-file
+++ b/t/t4211/sha256/expect.beginning-of-file
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:47:40 2013 +0100
     change at very beginning
 
 diff --git a/a.c b/a.c
+index 3a78aaf..d325124 100644
 --- a/a.c
 +++ b/a.c
 @@ -1,3 +1,4 @@
@@ -20,6 +21,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
 @@ -1,3 +1,3 @@
@@ -35,6 +37,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +1,3 @@
diff --git a/t/t4211/sha256/expect.end-of-file b/t/t4211/sha256/expect.end-of-file
index 03ab5c1784..3b2e2384da 100644
--- a/t/t4211/sha256/expect.end-of-file
+++ b/t/t4211/sha256/expect.end-of-file
@@ -5,9 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index e4fa1d8..62c1fc2 100644
 --- a/a.c
 +++ b/a.c
-@@ -20,3 +20,5 @@
+@@ -20,3 +20,5 @@ long f(long x)
  	printf("%ld\n", f(15));
  	return 0;
 -}
@@ -23,9 +24,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index d325124..e4fa1d8 100644
 --- a/a.c
 +++ b/a.c
-@@ -20,3 +20,3 @@
+@@ -20,3 +20,3 @@ int main ()
  	printf("%ld\n", f(15));
  	return 0;
 -}
@@ -39,9 +41,10 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
-@@ -19,3 +19,3 @@
+@@ -19,3 +19,3 @@ int f(int x)
 -	printf("%d\n", f(15));
 +	printf("%ld\n", f(15));
  	return 0;
@@ -54,6 +57,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +18,3 @@
diff --git a/t/t4211/sha256/expect.move-support-f b/t/t4211/sha256/expect.move-support-f
index 223b4ed2a0..f49abcea3e 100644
--- a/t/t4211/sha256/expect.move-support-f
+++ b/t/t4211/sha256/expect.move-support-f
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:49:50 2013 +0100
     another simple change
 
 diff --git a/b.c b/b.c
+index 62c1fc2..69cb69c 100644
 --- a/b.c
 +++ b/b.c
 @@ -4,9 +4,9 @@
@@ -26,6 +27,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,9 +3,9 @@
@@ -47,6 +49,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,8 +3,9 @@
@@ -67,6 +70,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,8 @@
diff --git a/t/t4211/sha256/expect.multiple b/t/t4211/sha256/expect.multiple
index dbd987b74a..0dee50ffb7 100644
--- a/t/t4211/sha256/expect.multiple
+++ b/t/t4211/sha256/expect.multiple
@@ -5,9 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index e4fa1d8..62c1fc2 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,7 @@
+@@ -18,5 +18,7 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -25,9 +26,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index d325124..e4fa1d8 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -43,6 +45,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,9 +3,9 @@
@@ -71,6 +74,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,8 +3,9 @@
@@ -91,6 +95,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,8 @@
diff --git a/t/t4211/sha256/expect.multiple-overlapping b/t/t4211/sha256/expect.multiple-overlapping
index 9015a45a25..b8c260e8ae 100644
--- a/t/t4211/sha256/expect.multiple-overlapping
+++ b/t/t4211/sha256/expect.multiple-overlapping
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index e4fa1d8..62c1fc2 100644
 --- a/a.c
 +++ b/a.c
 @@ -4,19 +4,21 @@
@@ -39,6 +40,7 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index d325124..e4fa1d8 100644
 --- a/a.c
 +++ b/a.c
 @@ -4,19 +4,19 @@
@@ -71,6 +73,7 @@ Date:   Thu Feb 28 10:45:41 2013 +0100
     touch comment
 
 diff --git a/a.c b/a.c
+index 75c0119..3a78aaf 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,19 +3,19 @@
@@ -102,6 +105,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,19 +3,19 @@
@@ -134,6 +138,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,18 +3,19 @@
@@ -164,6 +169,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,18 @@
diff --git a/t/t4211/sha256/expect.multiple-superset b/t/t4211/sha256/expect.multiple-superset
index 9015a45a25..b8c260e8ae 100644
--- a/t/t4211/sha256/expect.multiple-superset
+++ b/t/t4211/sha256/expect.multiple-superset
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index e4fa1d8..62c1fc2 100644
 --- a/a.c
 +++ b/a.c
 @@ -4,19 +4,21 @@
@@ -39,6 +40,7 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index d325124..e4fa1d8 100644
 --- a/a.c
 +++ b/a.c
 @@ -4,19 +4,19 @@
@@ -71,6 +73,7 @@ Date:   Thu Feb 28 10:45:41 2013 +0100
     touch comment
 
 diff --git a/a.c b/a.c
+index 75c0119..3a78aaf 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,19 +3,19 @@
@@ -102,6 +105,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,19 +3,19 @@
@@ -134,6 +138,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,18 +3,19 @@
@@ -164,6 +169,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,18 @@
diff --git a/t/t4211/sha256/expect.no-assertion-error b/t/t4211/sha256/expect.no-assertion-error
index 36ed12aa9c..c25f2ce19c 100644
--- a/t/t4211/sha256/expect.no-assertion-error
+++ b/t/t4211/sha256/expect.no-assertion-error
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:50:24 2013 +0100
     move within the file
 
 diff --git a/b.c b/b.c
+index 69cb69c..a0d566e 100644
 --- a/b.c
 +++ b/b.c
 @@ -25,0 +18,9 @@
@@ -25,9 +26,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index e4fa1d8..62c1fc2 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,7 @@
+@@ -18,5 +18,7 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -45,9 +47,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index d325124..e4fa1d8 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -63,9 +66,10 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
-@@ -17,5 +17,5 @@
+@@ -17,5 +17,5 @@ int f(int x)
  int main ()
  {
 -	printf("%d\n", f(15));
@@ -80,6 +84,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +16,5 @@
diff --git a/t/t4211/sha256/expect.parallel-change-f-to-main b/t/t4211/sha256/expect.parallel-change-f-to-main
index e68f8928ea..3178989253 100644
--- a/t/t4211/sha256/expect.parallel-change-f-to-main
+++ b/t/t4211/sha256/expect.parallel-change-f-to-main
@@ -13,6 +13,7 @@ Date:   Thu Feb 28 10:49:50 2013 +0100
     another simple change
 
 diff --git a/b.c b/b.c
+index 62c1fc2..69cb69c 100644
 --- a/b.c
 +++ b/b.c
 @@ -4,14 +4,14 @@
@@ -39,6 +40,7 @@ Date:   Fri Apr 12 16:15:57 2013 +0200
     change on another line of history while rename happens
 
 diff --git a/a.c b/a.c
+index 62c1fc2..e1e8475 100644
 --- a/a.c
 +++ b/a.c
 @@ -4,14 +4,14 @@
@@ -65,6 +67,7 @@ Date:   Thu Feb 28 10:45:41 2013 +0100
     touch comment
 
 diff --git a/a.c b/a.c
+index 75c0119..3a78aaf 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,14 +3,14 @@
@@ -91,6 +94,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,14 +3,14 @@
@@ -117,6 +121,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,13 +3,14 @@
@@ -142,6 +147,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,13 @@
diff --git a/t/t4211/sha256/expect.simple-f b/t/t4211/sha256/expect.simple-f
index 65508d7c0b..983c711fe3 100644
--- a/t/t4211/sha256/expect.simple-f
+++ b/t/t4211/sha256/expect.simple-f
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,9 +3,9 @@
@@ -26,6 +27,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,8 +3,9 @@
@@ -46,6 +48,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,8 @@
diff --git a/t/t4211/sha256/expect.simple-f-to-main b/t/t4211/sha256/expect.simple-f-to-main
index 77b721c196..e67fa017a7 100644
--- a/t/t4211/sha256/expect.simple-f-to-main
+++ b/t/t4211/sha256/expect.simple-f-to-main
@@ -5,6 +5,7 @@ Date:   Thu Feb 28 10:45:41 2013 +0100
     touch comment
 
 diff --git a/a.c b/a.c
+index 75c0119..3a78aaf 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,14 +3,14 @@
@@ -31,6 +32,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,14 +3,14 @@
@@ -57,6 +59,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,13 +3,14 @@
@@ -82,6 +85,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,13 @@
diff --git a/t/t4211/sha256/expect.simple-main b/t/t4211/sha256/expect.simple-main
index d20708c9f9..0792b27cad 100644
--- a/t/t4211/sha256/expect.simple-main
+++ b/t/t4211/sha256/expect.simple-main
@@ -5,9 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index e4fa1d8..62c1fc2 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -23,9 +24,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index d325124..e4fa1d8 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -41,9 +43,10 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
-@@ -17,5 +17,5 @@
+@@ -17,5 +17,5 @@ int f(int x)
  int main ()
  {
 -	printf("%d\n", f(15));
@@ -58,6 +61,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +16,5 @@
diff --git a/t/t4211/sha256/expect.simple-main-to-end b/t/t4211/sha256/expect.simple-main-to-end
index 617cdf3481..d3bd7c7bc6 100644
--- a/t/t4211/sha256/expect.simple-main-to-end
+++ b/t/t4211/sha256/expect.simple-main-to-end
@@ -5,9 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index e4fa1d8..62c1fc2 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,7 @@
+@@ -18,5 +18,7 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -25,9 +26,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index d325124..e4fa1d8 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -43,9 +45,10 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
-@@ -17,5 +17,5 @@
+@@ -17,5 +17,5 @@ int f(int x)
  int main ()
  {
 -	printf("%d\n", f(15));
@@ -60,6 +63,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +16,5 @@
diff --git a/t/t4211/sha256/expect.two-ranges b/t/t4211/sha256/expect.two-ranges
index 6a94d3b9cb..7735b19723 100644
--- a/t/t4211/sha256/expect.two-ranges
+++ b/t/t4211/sha256/expect.two-ranges
@@ -5,9 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index e4fa1d8..62c1fc2 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -23,9 +24,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index d325124..e4fa1d8 100644
 --- a/a.c
 +++ b/a.c
-@@ -18,5 +18,5 @@
+@@ -18,5 +18,5 @@ long f(long x)
  int main ()
  {
  	printf("%ld\n", f(15));
@@ -41,6 +43,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
     touch both functions
 
 diff --git a/a.c b/a.c
+index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,9 +3,9 @@
@@ -69,6 +72,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
     change f()
 
 diff --git a/a.c b/a.c
+index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
 @@ -3,8 +3,9 @@
@@ -89,6 +93,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +3,8 @@
diff --git a/t/t4211/sha256/expect.vanishes-early b/t/t4211/sha256/expect.vanishes-early
index 11ec9bdecf..bc33b963dc 100644
--- a/t/t4211/sha256/expect.vanishes-early
+++ b/t/t4211/sha256/expect.vanishes-early
@@ -5,11 +5,10 @@ Date:   Thu Feb 28 10:48:43 2013 +0100
     change back to complete line
 
 diff --git a/a.c b/a.c
+index e4fa1d8..62c1fc2 100644
 --- a/a.c
 +++ b/a.c
-@@ -22,1 +24,1 @@
--}
-\ No newline at end of file
+@@ -23,0 +24,1 @@ int main ()
 +/* incomplete lines are bad! */
 
 commit 29f32ac3141c48b22803e5c4127b719917b67d0f8ca8c5248bebfa2a19f7da10
@@ -19,9 +18,10 @@ Date:   Thu Feb 28 10:48:10 2013 +0100
     change to an incomplete line at end
 
 diff --git a/a.c b/a.c
+index d325124..e4fa1d8 100644
 --- a/a.c
 +++ b/a.c
-@@ -22,1 +22,1 @@
+@@ -22,1 +22,1 @@ int main ()
 -}
 +}
 \ No newline at end of file
@@ -33,6 +33,8 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
     initial
 
 diff --git a/a.c b/a.c
+new file mode 100644
+index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
 @@ -0,0 +20,1 @@
-- 
gitgitgadget

