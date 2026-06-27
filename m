Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C6324B20
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581348; cv=none; b=dvdO0ZhNNKY8Ra7+rETnkhuMdR1Nb/hO8bnqXvX7lsnj9lgmU0/KCfnaObETpmv8fGDSKfAjr4gK9jwof7mBofDRR5j3xOx8qoZJ68RufW3V50ln8etjWQAge4OepMRmp/BJw507XKF5endpQulMW+FD71Kmu76mzHBzuh7sd9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581348; c=relaxed/simple;
	bh=5piq1zggfc4GXZAwPYt6M76GHejD4Bxj5ql89NWc2lY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CxAdQ19qlmAe1lfY8z7S5svsaaWl9vhfo1itkXNihHIDyGh2tTzcjqyUxvYOPGraZq/TCSPT4dbmZAeWZ5sLWvArQHwZZ04Lb0zfaECw8Q1ioonGwj7JNiTVMPAf2Mxr0FMC5CHF1yjiQcBR9iv2uo0YOSQV96zEtr2crmfji4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oKXAmIC0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKXAmIC0"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92b2c2ea7ebso112856985a.2
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581346; x=1783186146; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnjmKej3TG/YFymh9dwVH/ZAJH7FpV5ojkB4goPSZ2k=;
        b=oKXAmIC0K0jY8iXRlhwhp4z4Rysj3BCO39SCxDkqMC5D9qlqIVK3O0B26UWQvAOV3N
         sA5ssJDelVfqWKxO6GvAVoqGVqQzwC6oWjKqP621KS/EDkuz62Pb61ZiJOdOSebunxm5
         Gu6kxYICdoIAuw0fakg6nkmrM4dd93suxH4Tr0bu7Rw6EWHM8lj6hUGMYeV8ITKc/lNP
         mOoyAfT0UkLaP8ZCmef2OMwC2bEAIJ7B+SYs17Yoju3Dak31y6dzTnl/0jkWN9Dkrdrj
         WOjIBsId70CAyJGTGCAraFMflMp7o6hGt3VV7v5lbzjm+0VNEMKWDpS5wLy+QmY5X22A
         uwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581346; x=1783186146;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KnjmKej3TG/YFymh9dwVH/ZAJH7FpV5ojkB4goPSZ2k=;
        b=ayrQ9k79qWnzNaparpibyoi1L+hkGTOkwo/O75rh+6F7bZaddVOqFTPd9hl8GbQrS1
         oDkoQJosustiiF76XZVhBCxudDr3XNXYAuaD1sEISCqITdD/qLnvqON0GP9NbsP+jR7S
         waI+WIBH/GwSzrtpWADhyiagK2vGpjTq22aMfrvYEroGXoXGFYdmBjvkz+kmuUW4ITh7
         8fGhIQAy18mAbVX7oUt+keYZQR2v7XOsKmA9IxsmEBZ70DNfhW9vqcG00Vhhy7VoJzGw
         GCECYsdlNLMYJyVhVZQyngAnMDt4UrIqbCSjZfIpcKWndqw8Dau+zT1fnmQ9uGZQ7A6J
         lTLA==
X-Gm-Message-State: AOJu0YwzE+O5CEraTR3CmcMwNOPZwNekPZ6wiy1RpFc2VVPEspvsq8sC
	Hund5mEunY4yDTP0/2NgpNguul7YyDYUqmlFE6HQpnJKh3ZnfFTxQ3V+aYJJmw==
X-Gm-Gg: AfdE7ckUSYRxAs0PkcGkUAOWi/HkXJsX2pd48HiRSBTTww2CejvxyrrUyhpkRcYFMl1
	I7tLheeIEiCIsB76eazPIQkg0QcTudyL2hiBVqNox4hvSulsZCcqU5gh3VEWq5LoWrVz2mg8ySn
	R+CusZiM8AfqEWeZqYnkAO5Fq2ShvkGrE7OrE7qtaHqlHuqiAY7vrYE+ss3wpBZVLRbSPF3wt8o
	2Ejej6lRniqJyz8AGW/fKtXosFCJg7391W32BzRuahEqpzYER1lJLEmUCnotYqscavJRmNNHnSU
	VxxlBc2OSwQOUKhgNTuY/mn25XH6ZWJ/z2Mm1+Z3T2rZwc79YDtsudEMp6+kBLlHAxnwn/SACY3
	06yvDyU6h274VWJs2ckG3phSJv0DNGbCOMy4u/9tQ/2h1hjBNDtJAbDwiWM2OPRcmY66JPly1cf
	aAzEZBXvN8rxK52Xk=
X-Received: by 2002:a05:620a:280a:b0:91c:ac0a:690b with SMTP id af79cd13be357-9293b85ca25mr1704834285a.17.1782581345984;
        Sat, 27 Jun 2026 10:29:05 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92db08a13c1sm187163785a.37.2026.06.27.10.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:29:04 -0700 (PDT)
Message-Id: <6cfaccab923694fae4c1f607c459af52dce9a021.1782581342.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 17:28:55 +0000
Subject: [PATCH v2 1/7] diff: rename and group the line-range filter for
 clarity
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The line-range filter that mm/line-log-cleanup added uses names that
obscure its model.  The cursors lno_post/lno_pre and the index lno_0
share an lno_ prefix but conflate the pre/post-image axis with the
0-based/1-based axis, the hunk state is a flat set of rhunk_* fields,
and the filter-state pointer is just s.

The filter bridges two layers of diff.c, and its fields already used
each layer's vocabulary, but in cryptic abbreviations.  Spell them out
to the form the rest of the file uses, so that the patches that follow
can simplify and fix it with those clearer names in place:

  - lno_post/lno_pre -> lno_in_postimage/lno_in_preimage, the
    line-number cursors, matching the counters in struct emit_callback
  - lno_0 -> idx_in_postimage, the 0-based range index
  - the hunk-header geometry stays old/new (old_begin, new_begin, and
    counts) to match the xdiff_emit_hunk_fn callback and the
    "@@ -<old> +<new> @@" header it feeds, but moves from flat rhunk_*
    fields into a "hunk" sub-struct, so accesses read
    filter->hunk.old_begin
  - flush_rhunk -> flush_range_hunk
  - the filter-state pointer in each callback: s -> filter

Also rename the struct line_range_callback to line_range_filter: it is
a filter over xdiff output, not merely a callback.

No behavior change.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c | 192 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 97 insertions(+), 95 deletions(-)

diff --git a/diff.c b/diff.c
index 5a584fa1d5..1e043c959f 100644
--- a/diff.c
+++ b/diff.c
@@ -623,15 +623,15 @@ struct emit_callback {
  * reveals whether they precede an in-range line (flush into range hunk) or
  * an out-of-range line (discard).
  */
-struct line_range_callback {
+struct line_range_filter {
 	xdiff_emit_line_fn orig_line_fn;
 	void *orig_cb_data;
 	const struct range_set *ranges;	/* 0-based [start, end) */
 	unsigned int cur_range;		/* index into the range_set */
 
 	/* Post/pre-image line counters (1-based, set from hunk headers) */
-	long lno_post;
-	long lno_pre;
+	long lno_in_postimage;
+	long lno_in_preimage;
 
 	/*
 	 * Function name from most recent xdiff hunk header;
@@ -640,12 +640,14 @@ struct line_range_callback {
 	char func[80];
 	long funclen;
 
-	/* Range hunk being accumulated for the current range */
-	struct strbuf rhunk;
-	long rhunk_old_begin, rhunk_old_count;
-	long rhunk_new_begin, rhunk_new_count;
-	int rhunk_active;
-	int rhunk_has_changes;		/* any '+' or '-' lines? */
+	/* The range hunk being accumulated for the current range. */
+	struct {
+		struct strbuf lines;	/* buffered in-range diff lines */
+		long old_begin, old_count;
+		long new_begin, new_count;
+		int active;
+		int has_changes;	/* any '+' or '-' line? */
+	} hunk;
 
 	/* Removal lines not yet known to be in-range */
 	struct strbuf pending_rm;
@@ -2540,26 +2542,26 @@ static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED
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
 	const char *p, *end;
 
-	if (!s->rhunk_active || s->ret)
+	if (!filter->hunk.active || filter->ret)
 		return;
 
 	/* Drain any pending removal lines into the range hunk */
-	if (s->pending_rm_count) {
-		strbuf_addbuf(&s->rhunk, &s->pending_rm);
-		s->rhunk_old_count += s->pending_rm_count;
-		s->rhunk_has_changes = 1;
-		discard_pending_rm(s);
+	if (filter->pending_rm_count) {
+		strbuf_addbuf(&filter->hunk.lines, &filter->pending_rm);
+		filter->hunk.old_count += filter->pending_rm_count;
+		filter->hunk.has_changes = 1;
+		discard_pending_rm(filter);
 	}
 
 	/*
@@ -2568,22 +2570,22 @@ static void flush_rhunk(struct line_range_callback *s)
 	 * ctxlen causes xdiff to emit context covering a range that
 	 * has no changes in this commit.
 	 */
-	if (!s->rhunk_has_changes) {
-		s->rhunk_active = 0;
-		strbuf_reset(&s->rhunk);
+	if (!filter->hunk.has_changes) {
+		filter->hunk.active = 0;
+		strbuf_reset(&filter->hunk.lines);
 		return;
 	}
 
 	strbuf_addf(&hdr, "@@ -%ld,%ld +%ld,%ld @@",
-		    s->rhunk_old_begin, s->rhunk_old_count,
-		    s->rhunk_new_begin, s->rhunk_new_count);
-	if (s->funclen > 0) {
+		    filter->hunk.old_begin, filter->hunk.old_count,
+		    filter->hunk.new_begin, filter->hunk.new_count);
+	if (filter->funclen > 0) {
 		strbuf_addch(&hdr, ' ');
-		strbuf_add(&hdr, s->func, s->funclen);
+		strbuf_add(&hdr, filter->func, filter->funclen);
 	}
 	strbuf_addch(&hdr, '\n');
 
-	s->ret = s->orig_line_fn(s->orig_cb_data, hdr.buf, hdr.len);
+	filter->ret = filter->orig_line_fn(filter->orig_cb_data, hdr.buf, hdr.len);
 	strbuf_release(&hdr);
 
 	/*
@@ -2591,18 +2593,18 @@ static void flush_rhunk(struct line_range_callback *s)
 	 * The cast discards const because xdiff_emit_line_fn takes
 	 * char *, though fn_out_consume does not modify the buffer.
 	 */
-	p = s->rhunk.buf;
-	end = p + s->rhunk.len;
-	while (!s->ret && p < end) {
+	p = filter->hunk.lines.buf;
+	end = p + filter->hunk.lines.len;
+	while (!filter->ret && p < end) {
 		const char *eol = memchr(p, '\n', end - p);
 		unsigned long line_len = eol ? (unsigned long)(eol - p + 1)
 					     : (unsigned long)(end - p);
-		s->ret = s->orig_line_fn(s->orig_cb_data, (char *)p, line_len);
+		filter->ret = filter->orig_line_fn(filter->orig_cb_data, (char *)p, line_len);
 		p += line_len;
 	}
 
-	s->rhunk_active = 0;
-	strbuf_reset(&s->rhunk);
+	filter->hunk.active = 0;
+	strbuf_reset(&filter->hunk.lines);
 }
 
 static void line_range_hunk_fn(void *data,
@@ -2610,7 +2612,7 @@ static void line_range_hunk_fn(void *data,
 			       long new_begin, long new_nr UNUSED,
 			       const char *func, long funclen)
 {
-	struct line_range_callback *s = data;
+	struct line_range_filter *filter = data;
 
 	/*
 	 * When count > 0, begin is 1-based.  When count == 0, begin is
@@ -2622,104 +2624,104 @@ static void line_range_hunk_fn(void *data,
 	 * flush or discard them when the next content line reveals
 	 * whether the removals precede in-range content.
 	 */
-	s->lno_post = new_begin;
-	s->lno_pre = old_begin;
+	filter->lno_in_postimage = new_begin;
+	filter->lno_in_preimage = old_begin;
 
 	if (funclen > 0) {
-		if (funclen > (long)sizeof(s->func))
-			funclen = sizeof(s->func);
-		memcpy(s->func, func, funclen);
+		if (funclen > (long)sizeof(filter->func))
+			funclen = sizeof(filter->func);
+		memcpy(filter->func, func, funclen);
 	}
-	s->funclen = funclen;
+	filter->funclen = funclen;
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
+			filter->pending_rm_pre_begin = filter->lno_in_preimage;
+		filter->lno_in_preimage++;
+		strbuf_add(&filter->pending_rm, line, len);
+		filter->pending_rm_count++;
+		return filter->ret;
 	}
 
 	if (line[0] == '\\') {
-		if (s->pending_rm_count)
-			strbuf_add(&s->pending_rm, line, len);
-		else if (s->rhunk_active)
-			strbuf_add(&s->rhunk, line, len);
+		if (filter->pending_rm_count)
+			strbuf_add(&filter->pending_rm, line, len);
+		else if (filter->hunk.active)
+			strbuf_add(&filter->hunk.lines, line, len);
 		/* otherwise outside tracked range; drop silently */
-		return s->ret;
+		return filter->ret;
 	}
 
 	if (line[0] != '+' && line[0] != ' ')
 		BUG("unexpected diff line type '%c'", line[0]);
 
-	lno_0 = s->lno_post - 1;
-	cur_pre = s->lno_pre;	/* save before advancing for context lines */
-	s->lno_post++;
+	idx_in_postimage = filter->lno_in_postimage - 1;
+	cur_pre = filter->lno_in_preimage;	/* save before advancing for context lines */
+	filter->lno_in_postimage++;
 	if (line[0] == ' ')
-		s->lno_pre++;
+		filter->lno_in_preimage++;
 
 	/* Advance past ranges we've passed */
-	while (s->cur_range < s->ranges->nr &&
-	       lno_0 >= s->ranges->ranges[s->cur_range].end) {
-		if (s->rhunk_active)
-			flush_rhunk(s);
-		discard_pending_rm(s);
-		s->cur_range++;
+	while (filter->cur_range < filter->ranges->nr &&
+	       idx_in_postimage >= filter->ranges->ranges[filter->cur_range].end) {
+		if (filter->hunk.active)
+			flush_range_hunk(filter);
+		discard_pending_rm(filter);
+		filter->cur_range++;
 	}
 
 	/* Past all ranges */
-	if (s->cur_range >= s->ranges->nr) {
-		discard_pending_rm(s);
-		return s->ret;
+	if (filter->cur_range >= filter->ranges->nr) {
+		discard_pending_rm(filter);
+		return filter->ret;
 	}
 
-	cur = &s->ranges->ranges[s->cur_range];
+	cur = &filter->ranges->ranges[filter->cur_range];
 
 	/* Before current range */
-	if (lno_0 < cur->start) {
-		discard_pending_rm(s);
-		return s->ret;
+	if (idx_in_postimage < cur->start) {
+		discard_pending_rm(filter);
+		return filter->ret;
 	}
 
 	/* In range so start a new range hunk if needed */
-	if (!s->rhunk_active) {
-		s->rhunk_active = 1;
-		s->rhunk_has_changes = 0;
-		s->rhunk_new_begin = lno_0 + 1;
-		s->rhunk_old_begin = s->pending_rm_count
-			? s->pending_rm_pre_begin : cur_pre;
-		s->rhunk_old_count = 0;
-		s->rhunk_new_count = 0;
-		strbuf_reset(&s->rhunk);
+	if (!filter->hunk.active) {
+		filter->hunk.active = 1;
+		filter->hunk.has_changes = 0;
+		filter->hunk.new_begin = idx_in_postimage + 1;
+		filter->hunk.old_begin = filter->pending_rm_count
+			? filter->pending_rm_pre_begin : cur_pre;
+		filter->hunk.old_count = 0;
+		filter->hunk.new_count = 0;
+		strbuf_reset(&filter->hunk.lines);
 	}
 
 	/* Flush pending removals into range hunk */
-	if (s->pending_rm_count) {
-		strbuf_addbuf(&s->rhunk, &s->pending_rm);
-		s->rhunk_old_count += s->pending_rm_count;
-		s->rhunk_has_changes = 1;
-		discard_pending_rm(s);
+	if (filter->pending_rm_count) {
+		strbuf_addbuf(&filter->hunk.lines, &filter->pending_rm);
+		filter->hunk.old_count += filter->pending_rm_count;
+		filter->hunk.has_changes = 1;
+		discard_pending_rm(filter);
 	}
 
-	strbuf_add(&s->rhunk, line, len);
-	s->rhunk_new_count++;
+	strbuf_add(&filter->hunk.lines, line, len);
+	filter->hunk.new_count++;
 	if (line[0] == '+')
-		s->rhunk_has_changes = 1;
+		filter->hunk.has_changes = 1;
 	else
-		s->rhunk_old_count++;
+		filter->hunk.old_count++;
 
-	return s->ret;
+	return filter->ret;
 }
 
 static void pprint_rename(struct strbuf *name, const char *a, const char *b)
@@ -4086,7 +4088,7 @@ static void builtin_diff(const char *name_a,
 			xdi_diff_outf(&mf1, &mf2, NULL, quick_consume,
 				      &ecbdata, &xpp, &xecfg);
 		} else if (line_ranges) {
-			struct line_range_callback lr_state;
+			struct line_range_filter lr_state;
 			unsigned int i;
 			long max_span = 0;
 
@@ -4094,7 +4096,7 @@ static void builtin_diff(const char *name_a,
 			lr_state.orig_line_fn = fn_out_consume;
 			lr_state.orig_cb_data = &ecbdata;
 			lr_state.ranges = line_ranges;
-			strbuf_init(&lr_state.rhunk, 0);
+			strbuf_init(&lr_state.hunk.lines, 0);
 			strbuf_init(&lr_state.pending_rm, 0);
 
 			/*
@@ -4125,11 +4127,11 @@ static void builtin_diff(const char *name_a,
 				die("unable to generate diff for %s",
 				    one->path);
 
-			flush_rhunk(&lr_state);
+			flush_range_hunk(&lr_state);
 			if (lr_state.ret)
 				die("unable to generate diff for %s",
 				    one->path);
-			strbuf_release(&lr_state.rhunk);
+			strbuf_release(&lr_state.hunk.lines);
 			strbuf_release(&lr_state.pending_rm);
 		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
 					 &ecbdata, &xpp, &xecfg))
-- 
gitgitgadget

