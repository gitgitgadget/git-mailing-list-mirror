Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2563451B5
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411926; cv=none; b=sqOTmHCv1Foi9eZyvYPzdZNVpxI3lvmdqOLifkPFvTnvHjCkFmK4FriyGXIFn1RuzFhm/uk19HvGbCLIF/wlbbg/Bu2AQ+7iS13jJ6vdzN4lVVunoUx/+9CfmvgrR0OAnajrihvNfJiUNRbC/cABPJFndAvHpHy1MTrj5bsFJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411926; c=relaxed/simple;
	bh=klQnjGypMKG+prBgasotpESV84eE/qXCd2fgKZyLKeQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gaDlbi6Zi7+cvtIGz2/u8yuLlVDS+aTOz/Yuj3vXHFyKQGCKZ0goUHpUTlllQr+vz1zzsjF8L0kXTu4JXyCAgd4PKI2RYHzds5ChSv3U2mq9ftLtAQ4gubkAlQX2Ai87HkaK9gKr21B18daY1PvZhygWk29xeZ/tOut/LtWYP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqIkjuu8; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqIkjuu8"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93959320373so158041285a.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 22:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411923; x=1789016723; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ErShrBWE5KF2L0JlkT6EUDyKv7Updqt2iC2Gs8z+tx8=;
        b=EqIkjuu8y2INa91mltw7Vd+P/VxXubaCS3FPr02BROSc+X6kfoNpi2bNh6ZPC2tZMP
         jJ2u89C+dHxXTtk7Bp2C1PIYVmh+/N7JARjbCKhVL99FGN2ptwrZOPSCZ/LwI5/NGw37
         L88MYueiEqJBmJEP1MN1gm+rrDA035s2qPvCMQFUDOBP1Gh7a2U75K3h/K1qF4UEvRvL
         ZNYU4S5XX1zaWChFfg8XxRNpfjpTzHtuogrlAP0ESTMmharOvdUZHwaLwBZgjliRdNmN
         5kbh9dVwQvmbrXcwYr48aIULhbFrHbaNKPutq76w5u0mjPEmcl2xbmyuiYOMwEvnM31s
         Cp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411923; x=1789016723;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ErShrBWE5KF2L0JlkT6EUDyKv7Updqt2iC2Gs8z+tx8=;
        b=p+1O8Mp5EilH7P7AhMRCrc1Z7qFQ7/zJD0qnEUthXqBAaaWMvv7y7amU8w752tRndK
         o6OEJjINorhGfDp6WPSvDQyLwRKtGOY/wmeu5WSptC4eXYAIS1h1bTqmZfSrDHnsU7M/
         6Fc8c2j+WxPSMHKQVrL2h98jerXkIh9HC1HqGPtGLgMkj2qR9K9c4T0f+I463SqKsn3+
         FujakkZ+pc9FOLcP/dCyBssr/o4mrfIKeXNQBkAItyxlNNjE6C2Fmp++egMXzAx1Siyt
         9jmLWpHBmFOoH3Wozqa/n4EQktchNjxpOpO8XzJyUcp+oXl4G2gDeyZ2QdeUtRA4p2GV
         pxiQ==
X-Gm-Message-State: AFuF++kJIsvD2APyOOiyWzBayXqC3TDmogpcQpxUmlNePA3YcIN4dV4Q
	wt57VlO1LQcd0GpU2P0QGr7djy9LXFm1OhUKnU8r9+2WWxPOP7p4Tfg5jGlxzDLZ
X-Gm-Gg: AYBFou19nrHg6VXcNxFp0qE2tZ2Yw5S11WsU5qtLH5bxCGiH4tLltwQk/+RFgH9aVNT
	S9Zkkge3GUsSH+eRqbxDB5Sv+lebaepTvyJsjN9nxoro7yWkWDycEn72c60NQFbxO/ZACAb3gB1
	jKjDEITNUTNToqPv+oaJjEY6nxeP4TNPWZhdieN+W8Y3MMetQIg955mFmvhvABB6Swi4kz+6L0w
	P24LubAFr5u2Nnmv0BVFPPsiOTUSP2qRTrh9GF4TbI+ZW4xXAt4qhs0xMxnej+i8H8PP2fxZvPt
	UzaC2ppcgtVAm/g35MnR71FdyyJSW5q2ozsHFNUh1Ler0zuAsIX6/1FPZ9I5Lfwbe67IObB/fkc
	edIP7yurUNzjcuPtLO3ReU5IWU1HKbEJjWpPOdmsBiTZi2RjAFt0cXT+lpy+zglM/kp5xBo/QVQ
	aEEGYaj/6lZj1mcS1/s8gFT7OuYp8T94bR6kEK0dsvZi8n0Xjrfh7BZguSBmH0Ho6f
X-Received: by 2002:a05:620a:d87:b0:92e:603f:1f20 with SMTP id af79cd13be357-93960cd16c6mr1260555985a.2.1788411923117;
        Wed, 02 Sep 2026 22:05:23 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.140.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f35f029sm395185385a.31.2026.09.02.22.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 22:05:22 -0700 (PDT)
Message-Id: <331c6c92f3b54f7ee95ef5fe4db375b99b9be146.1788411919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 05:05:13 +0000
Subject: [PATCH v3 1/7] diff: rename line-range filter struct and clarify
 fields
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

diff's line-range filtering logic uses the line_range_callback
struct to represent filtering state. However, this name does not
clearly reflect the role it plays. This is especially relevant as
we expand diff's line-range filtering to work with more options,
including --stat and -G.

Also, line_range_callback's fields are terse, while the comment
explaining line_range_callback is verbose and out of place compared to
its surroundings.

Rename line_range_callback to line_range_filter, and replace the verbose
comment with a concise one, instead preferring descriptive field and
variable names that are self-explanatory over comments.

No logical behavior change. Some fields are grouped under a new struct
in the newly renamed line_range_filter. Everything else is just a
rename.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c | 270 ++++++++++++++++++++++++---------------------------------
 1 file changed, 114 insertions(+), 156 deletions(-)

diff --git a/diff.c b/diff.c
index 414532d09f..679a0e27d4 100644
--- a/diff.c
+++ b/diff.c
@@ -610,49 +610,31 @@ struct emit_callback {
 };
 
 /*
- * State for the line-range callback wrappers that sit between
- * xdi_diff_outf() and fn_out_consume().  xdiff produces a normal,
- * unfiltered diff; the wrappers intercept each hunk header and line,
- * track post-image position, and forward only lines that fall within
- * the requested ranges.  Contiguous in-range lines are collected into
- * range hunks and flushed with a synthetic @@ header so that
- * fn_out_consume() sees well-formed unified-diff fragments.
- *
- * Removal lines ('-') cannot be classified by post-image position, so
- * they are buffered in pending_rm until the next '+' or ' ' line
- * reveals whether they precede an in-range line (flush into range hunk) or
- * an out-of-range line (discard).
+ * Filter the line ranges that are emitted by diff.
  */
-struct line_range_callback {
+struct line_range_filter {
 	xdiff_emit_line_fn orig_line_fn;
 	void *orig_cb_data;
-	const struct range_set *ranges;	/* 0-based [start, end) */
-	unsigned int cur_range;		/* index into the range_set */
-
-	/* Post/pre-image line counters (1-based, set from hunk headers) */
-	long lno_post;
-	long lno_pre;
+	const struct range_set *range_sets_to_filter_by;
+	unsigned int range_set_idx;
+
+	struct {
+		char func_name[80];
+		long func_name_len;
+		long old_begin, old_count;
+		long new_begin, new_count;
+		long lno_in_preimage;
+		long lno_in_postimage;
+		struct strbuf lines;
+		int active;
+		int has_changes;
+	} accumulating_hunk;
 
-	/*
-	 * Function name from most recent xdiff hunk header;
-	 * size matches struct func_line.buf in xdiff/xemit.c.
-	 */
-	char func[80];
-	long funclen;
-
-	/* Range hunk being accumulated for the current range */
-	struct strbuf rhunk;
-	long rhunk_old_begin, rhunk_old_count;
-	long rhunk_new_begin, rhunk_new_count;
-	int rhunk_active;
-	int rhunk_has_changes;		/* any '+' or '-' lines? */
-
-	/* Removal lines not yet known to be in-range */
 	struct strbuf pending_rm;
 	int pending_rm_count;
-	long pending_rm_pre_begin;	/* pre-image line of first pending */
+	long pending_rm_pre_begin;
 
-	int ret;			/* latched error from orig_line_fn */
+	int ret;
 };
 
 static int count_lines(const char *data, int size)
@@ -2540,69 +2522,59 @@ static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED
 	return 1;
 }
 
-static void discard_pending_rm(struct line_range_callback *s)
+static void discard_pending_rm(struct line_range_filter *filter)
 {
-	strbuf_reset(&s->pending_rm);
-	s->pending_rm_count = 0;
+	strbuf_reset(&filter->pending_rm);
+	filter->pending_rm_count = 0;
 }
 
-static void flush_rhunk(struct line_range_callback *s)
+static void flush_range_hunk(struct line_range_filter *filter)
 {
 	struct strbuf hdr = STRBUF_INIT;
-	const char *p, *end;
+	const char *line_buf, *line_buf_end;
 
-	if (!s->rhunk_active || s->ret)
+	if (!filter->accumulating_hunk.active || filter->ret)
 		return;
 
-	/* Drain any pending removal lines into the range hunk */
-	if (s->pending_rm_count) {
-		strbuf_addbuf(&s->rhunk, &s->pending_rm);
-		s->rhunk_old_count += s->pending_rm_count;
-		s->rhunk_has_changes = 1;
-		discard_pending_rm(s);
+	if (filter->pending_rm_count) {
+		strbuf_addbuf(&filter->accumulating_hunk.lines, &filter->pending_rm);
+		filter->accumulating_hunk.old_count += filter->pending_rm_count;
+		filter->accumulating_hunk.has_changes = 1;
+		discard_pending_rm(filter);
 	}
 
-	/*
-	 * Suppress context-only hunks: they contain no actual changes
-	 * and would just be noise.  This can happen when the inflated
-	 * ctxlen causes xdiff to emit context covering a range that
-	 * has no changes in this commit.
-	 */
-	if (!s->rhunk_has_changes) {
-		s->rhunk_active = 0;
-		strbuf_reset(&s->rhunk);
+	if (!filter->accumulating_hunk.has_changes) {
+		filter->accumulating_hunk.active = 0;
+		strbuf_reset(&filter->accumulating_hunk.lines);
 		return;
 	}
 
 	strbuf_addf(&hdr, "@@ -%ld,%ld +%ld,%ld @@",
-		    s->rhunk_old_begin, s->rhunk_old_count,
-		    s->rhunk_new_begin, s->rhunk_new_count);
-	if (s->funclen > 0) {
+		    filter->accumulating_hunk.old_begin, filter->accumulating_hunk.old_count,
+		    filter->accumulating_hunk.new_begin, filter->accumulating_hunk.new_count);
+	if (filter->accumulating_hunk.func_name_len > 0) {
 		strbuf_addch(&hdr, ' ');
-		strbuf_add(&hdr, s->func, s->funclen);
+		strbuf_add(&hdr, filter->accumulating_hunk.func_name,
+	     filter->accumulating_hunk.func_name_len);
 	}
 	strbuf_addch(&hdr, '\n');
 
-	s->ret = s->orig_line_fn(s->orig_cb_data, hdr.buf, hdr.len);
+	filter->ret = filter->orig_line_fn(filter->orig_cb_data, hdr.buf, hdr.len);
 	strbuf_release(&hdr);
 
-	/*
-	 * Replay buffered lines one at a time through fn_out_consume.
-	 * The cast discards const because xdiff_emit_line_fn takes
-	 * char *, though fn_out_consume does not modify the buffer.
-	 */
-	p = s->rhunk.buf;
-	end = p + s->rhunk.len;
-	while (!s->ret && p < end) {
-		const char *eol = memchr(p, '\n', end - p);
-		unsigned long line_len = eol ? (unsigned long)(eol - p + 1)
-					     : (unsigned long)(end - p);
-		s->ret = s->orig_line_fn(s->orig_cb_data, (char *)p, line_len);
-		p += line_len;
+	line_buf = filter->accumulating_hunk.lines.buf;
+	line_buf_end = line_buf + filter->accumulating_hunk.lines.len;
+	while (!filter->ret && line_buf < line_buf_end) {
+		const char *eol = memchr(line_buf, '\n', line_buf_end - line_buf);
+		unsigned long line_len = eol ? (unsigned long)(eol - line_buf + 1)
+					     : (unsigned long)(line_buf_end - line_buf);
+		filter->ret = filter->orig_line_fn(filter->orig_cb_data,
+				     (char *)line_buf, line_len);
+		line_buf += line_len;
 	}
 
-	s->rhunk_active = 0;
-	strbuf_reset(&s->rhunk);
+	filter->accumulating_hunk.active = 0;
+	strbuf_reset(&filter->accumulating_hunk.lines);
 }
 
 static void line_range_hunk_fn(void *data,
@@ -2610,116 +2582,102 @@ static void line_range_hunk_fn(void *data,
 			       long new_begin, long new_nr UNUSED,
 			       const char *func, long funclen)
 {
-	struct line_range_callback *s = data;
+	struct line_range_filter *filter = data;
 
-	/*
-	 * When count > 0, begin is 1-based.  When count == 0, begin is
-	 * adjusted down by 1 by xdl_emit_hunk_hdr(), but no lines of
-	 * that type will arrive, so the value is unused.
-	 *
-	 * Any pending removal lines from the previous xdiff hunk are
-	 * intentionally left in pending_rm: the line callback will
-	 * flush or discard them when the next content line reveals
-	 * whether the removals precede in-range content.
-	 */
-	s->lno_post = new_begin;
-	s->lno_pre = old_begin;
+	filter->accumulating_hunk.lno_in_postimage = new_begin;
+	filter->accumulating_hunk.lno_in_preimage = old_begin;
 
 	if (funclen > 0) {
-		if (funclen > (long)sizeof(s->func))
-			funclen = sizeof(s->func);
-		memcpy(s->func, func, funclen);
+		if (funclen > (long)sizeof(filter->accumulating_hunk.func_name))
+			funclen = sizeof(filter->accumulating_hunk.func_name);
+		memcpy(filter->accumulating_hunk.func_name, func, funclen);
 	}
-	s->funclen = funclen;
+	filter->accumulating_hunk.func_name_len = funclen;
 }
 
 static int line_range_line_fn(void *priv, char *line, unsigned long len)
 {
-	struct line_range_callback *s = priv;
+	struct line_range_filter *filter = priv;
 	const struct range *cur;
-	long lno_0, cur_pre;
+	long idx_in_postimage, cur_pre;
 
-	if (s->ret)
-		return s->ret;
+	if (filter->ret)
+		return filter->ret;
 
 	if (line[0] == '-') {
-		if (!s->pending_rm_count)
-			s->pending_rm_pre_begin = s->lno_pre;
-		s->lno_pre++;
-		strbuf_add(&s->pending_rm, line, len);
-		s->pending_rm_count++;
-		return s->ret;
+		if (!filter->pending_rm_count)
+			filter->pending_rm_pre_begin =
+				filter->accumulating_hunk.lno_in_preimage;
+		filter->accumulating_hunk.lno_in_preimage++;
+		strbuf_add(&filter->pending_rm, line, len);
+		filter->pending_rm_count++;
+		return filter->ret;
 	}
 
 	if (line[0] == '\\') {
-		if (s->pending_rm_count)
-			strbuf_add(&s->pending_rm, line, len);
-		else if (s->rhunk_active)
-			strbuf_add(&s->rhunk, line, len);
-		/* otherwise outside tracked range; drop silently */
-		return s->ret;
+		if (filter->pending_rm_count)
+			strbuf_add(&filter->pending_rm, line, len);
+		else if (filter->accumulating_hunk.active)
+			strbuf_add(&filter->accumulating_hunk.lines, line, len);
+		return filter->ret;
 	}
 
 	if (line[0] != '+' && line[0] != ' ')
 		BUG("unexpected diff line type '%c'", line[0]);
 
-	lno_0 = s->lno_post - 1;
-	cur_pre = s->lno_pre;	/* save before advancing for context lines */
-	s->lno_post++;
+	idx_in_postimage = filter->accumulating_hunk.lno_in_postimage - 1;
+	cur_pre = filter->accumulating_hunk.lno_in_preimage;
+	filter->accumulating_hunk.lno_in_postimage++;
 	if (line[0] == ' ')
-		s->lno_pre++;
+		filter->accumulating_hunk.lno_in_preimage++;
 
-	/* Advance past ranges we've passed */
-	while (s->cur_range < s->ranges->nr &&
-	       lno_0 >= s->ranges->ranges[s->cur_range].end) {
-		if (s->rhunk_active)
-			flush_rhunk(s);
-		discard_pending_rm(s);
-		s->cur_range++;
+	while (filter->range_set_idx < filter->range_sets_to_filter_by->nr &&
+	       idx_in_postimage >=
+		filter->range_sets_to_filter_by->ranges[filter->range_set_idx].end) {
+		if (filter->accumulating_hunk.active)
+			flush_range_hunk(filter);
+		discard_pending_rm(filter);
+		filter->range_set_idx++;
 	}
 
-	/* Past all ranges */
-	if (s->cur_range >= s->ranges->nr) {
-		discard_pending_rm(s);
-		return s->ret;
+	if (filter->range_set_idx >= filter->range_sets_to_filter_by->nr) {
+		discard_pending_rm(filter);
+		return filter->ret;
 	}
 
-	cur = &s->ranges->ranges[s->cur_range];
+	cur = &filter->range_sets_to_filter_by->ranges[filter->range_set_idx];
 
-	/* Before current range */
-	if (lno_0 < cur->start) {
-		discard_pending_rm(s);
-		return s->ret;
+	if (idx_in_postimage < cur->start) {
+		discard_pending_rm(filter);
+		return filter->ret;
 	}
 
-	/* In range so start a new range hunk if needed */
-	if (!s->rhunk_active) {
-		s->rhunk_active = 1;
-		s->rhunk_has_changes = 0;
-		s->rhunk_new_begin = lno_0 + 1;
-		s->rhunk_old_begin = s->pending_rm_count
-			? s->pending_rm_pre_begin : cur_pre;
-		s->rhunk_old_count = 0;
-		s->rhunk_new_count = 0;
-		strbuf_reset(&s->rhunk);
+	if (!filter->accumulating_hunk.active) {
+		filter->accumulating_hunk.active = 1;
+		filter->accumulating_hunk.has_changes = 0;
+		filter->accumulating_hunk.new_begin = idx_in_postimage + 1;
+		filter->accumulating_hunk.old_begin = filter->pending_rm_count
+			? filter->pending_rm_pre_begin : cur_pre;
+		filter->accumulating_hunk.old_count = 0;
+		filter->accumulating_hunk.new_count = 0;
+		strbuf_reset(&filter->accumulating_hunk.lines);
 	}
 
-	/* Flush pending removals into range hunk */
-	if (s->pending_rm_count) {
-		strbuf_addbuf(&s->rhunk, &s->pending_rm);
-		s->rhunk_old_count += s->pending_rm_count;
-		s->rhunk_has_changes = 1;
-		discard_pending_rm(s);
+	if (filter->pending_rm_count) {
+		strbuf_addbuf(&filter->accumulating_hunk.lines, &filter->pending_rm);
+		filter->accumulating_hunk.old_count += filter->pending_rm_count;
+		filter->accumulating_hunk.has_changes = 1;
+		discard_pending_rm(filter);
 	}
 
-	strbuf_add(&s->rhunk, line, len);
-	s->rhunk_new_count++;
+	strbuf_add(&filter->accumulating_hunk.lines, line, len);
+	filter->accumulating_hunk.new_count++;
 	if (line[0] == '+')
-		s->rhunk_has_changes = 1;
+		filter->accumulating_hunk.has_changes = 1;
 	else
-		s->rhunk_old_count++;
+		filter->accumulating_hunk.old_count++;
 
-	return s->ret;
+	return filter->ret;
 }
 
 static void pprint_rename(struct strbuf *name, const char *a, const char *b)
@@ -4066,15 +4024,15 @@ static void builtin_diff(const char *name_a,
 			xdi_diff_outf(&mf1, &mf2, NULL, quick_consume,
 				      &ecbdata, &xpp, &xecfg);
 		} else if (line_ranges) {
-			struct line_range_callback lr_state;
+			struct line_range_filter lr_state;
 			unsigned int i;
 			long max_span = 0;
 
 			memset(&lr_state, 0, sizeof(lr_state));
 			lr_state.orig_line_fn = fn_out_consume;
 			lr_state.orig_cb_data = &ecbdata;
-			lr_state.ranges = line_ranges;
-			strbuf_init(&lr_state.rhunk, 0);
+			lr_state.range_sets_to_filter_by = line_ranges;
+			strbuf_init(&lr_state.accumulating_hunk.lines, 0);
 			strbuf_init(&lr_state.pending_rm, 0);
 
 			/*
@@ -4105,11 +4063,11 @@ static void builtin_diff(const char *name_a,
 				die("unable to generate diff for %s",
 				    one->path);
 
-			flush_rhunk(&lr_state);
+			flush_range_hunk(&lr_state);
 			if (lr_state.ret)
 				die("unable to generate diff for %s",
 				    one->path);
-			strbuf_release(&lr_state.rhunk);
+			strbuf_release(&lr_state.accumulating_hunk.lines);
 			strbuf_release(&lr_state.pending_rm);
 		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
 					 &ecbdata, &xpp, &xecfg))
-- 
gitgitgadget

