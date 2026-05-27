Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077930BB8C
	for <git@vger.kernel.org>; Wed, 27 May 2026 04:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779855858; cv=none; b=BWqe3Vddg1Fwz1VmdffSoTRNb+XCgqpjpN3iDz6H299mVJ/pxuqlgfvrEwWVjkp+huJ1B9cTBWp/GL6T0N3nV5lB9NDo4JgyAxCHgFdMg4WDtLA4/ggoY3f7h1l8fyngmuJzzq4toxxssy6sGaB0QooosEwX3lWOKNItsV7fD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779855858; c=relaxed/simple;
	bh=xGfIKtNgPPoyFwkTf4Y6cv8N3Yn/iWQ4mfYXz7kiPSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MnNCHMeCt2CIbJAMSI317Yr5+g375gZ9CHRGxHsK2t7Rjv8l4Ajy4AqAmx7c8dHn/hJuqqUiVcnnv4iFT724hc/tVIcKI/62Jz+ZhVdgpResh+HlDZAiIguDcit7kCgPkCdTF6P7cwhoc5J0hpcyIVUHzac82ZkXZdEl4LGUaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4bLPk34; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4bLPk34"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b9f8c2c950so8910815ad.2
        for <git@vger.kernel.org>; Tue, 26 May 2026 21:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779855856; x=1780460656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArQjGnSbVBiJSFMlaHOvu0O/6qPIup76BjYKkM6/ZeY=;
        b=H4bLPk34Wg9zltZN/KNfCZE7GGEqUGqSKecLxzteTrqOX6nFbxTXr1Pu8qTLmob5mh
         T5RN2ZbwWnvWLz0mLscDbWfWyj5AQnGvxz2RI4AmUrkr62FDxGycvVwripPMX44KkCn6
         BIgz2s7RnjZlSursypdpckm0q0sKsXaKyCcQqR6gSehp0RNwPaHRdJUnhbStTMCEl1Oy
         uMKrFuOsRLcUfEesLwlMuDBKhSTP/X/7+k1yldn59RsAOA6iwPVRvtruKI12PoNT/88h
         QKphOIw9YzGFDA8wwADzhN+Q5d2wkYpfrnw6nTSKKR3h7+cSysmwPCedWsnxvvLbPDBO
         SlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779855856; x=1780460656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArQjGnSbVBiJSFMlaHOvu0O/6qPIup76BjYKkM6/ZeY=;
        b=G+VmI0rbGVjhNLy4cG7mTuvAwOcKREZyd1pm81AQ7VjcPmChLUXxXrpRWtylGipw7x
         uEzwW5HyhsCWgJqLHcMKMUqabypRrsKa7RkkG6glPazAEPXF/9r4r3+BbdylE3V8trfd
         rodb4wtrGudzzKrl7hLmlI/ttw1GWC3d06pI8Lj3J8secARMusEMCKAAeeDBD0F6c30Z
         hzp4Y+oSTG+dToqr3FYFpbxAvUpwcj7cNXlDzmGqcJFlGL83HN8aJdnq6L7UabvILU0Z
         5vQ/j3rgRuhmJYYzZw2evar32XBK896k/4fSZeYP62Pc7OgpFERJKdEixq0uc3ybZ4Pz
         9uCw==
X-Gm-Message-State: AOJu0Yy8eJEK9WTTiz59EPHpaqyBFMwpDnnIMslPHJ43BgNav6YNUO1E
	Mk2BIXTYpVC/0v/mVLGpekUe5D8sZiV2QWRRxFTZsbqsuRRlriXYeHD1yXub8A==
X-Gm-Gg: Acq92OFIbMQcRe2x2AoaXLu6K4wOy78/U4JhPK4njZHC8SnkT57rJhECfXBP5Lqt34h
	Rzeg6Kpf20No8P0iapiiy8aiO9xmTkrzQSl1KDvUOfcKcZkT5xQ0u8L8mzN+FK56+eUXUk6kZec
	iPutqMpiEKeu/WM94NSM+gULWomn2wbBuXWwNRiVwB1TfbQH4z7fNVzYiX/Kv01HB5MhWH5c/Pc
	/NbNraUtffzN0Q4VGtXZaKABZMcW3TR3I4tnDjES0qndXJ+hGRZB+cgNboga9qPj7nuMb04PskP
	a70nz8tnWP9GZMzVwI3zxa9Mlao+c/2qj19+ftNP5zSIPRarG+Y8MzI+E7ds7UFeDxguFuyLSAV
	xSrQRgy9rUywd6fcbJjqboqLAMCsRrbO3/lSCeTE/8cSiWtKqDUC7DrWnS0/AYkPad99iUVNwsa
	PQeyrAIHoiIwBB8B9TiZw/O9qEX1Rxfw1wFUy7b7l68ODMJiK3Mg8s+oeQQE4DSzDwLjpvYKq/E
	ta2wKKdDZovCWNdsA8a8twXbWmI
X-Received: by 2002:a17:902:d581:b0:2b9:cd2d:6f16 with SMTP id d9443c01a7336-2beb0337073mr143282045ad.1.1779855856169;
        Tue, 26 May 2026 21:24:16 -0700 (PDT)
Received: from localhost.localdomain (122x211x77x66.ap122.ftth.ucom.ne.jp. [122.211.77.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm135625495ad.65.2026.05.26.21.24.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 21:24:15 -0700 (PDT)
From: Keita Oda <ainsophyao@gmail.com>
To: git@vger.kernel.org
Cc: Keita ODA <ainsophyao@gmail.com>
Subject: [RFC PATCH 2/3] diff: render word-diff-align pairs for RFC review
Date: Wed, 27 May 2026 13:24:01 +0900
Message-Id: <20260527042402.13607-3-ainsophyao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260527042402.13607-1-ainsophyao@gmail.com>
References: <20260527042402.13607-1-ainsophyao@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keita ODA <ainsophyao@gmail.com>

Teach the RFC prototype to render selected --word-diff-align pairs with
word-diff-like markers.

This renderer is deliberately small and local to the RFC.  It exists to make
the recovered line pairs inspectable in review output.  It is not meant to be
the final UI.  A production version should likely reuse the existing word-diff
machinery once the line-pairing question is settled.

The renderer computes a token LCS for the selected pair and marks the unmatched
spans with the familiar plain word-diff delimiters:

  [-old-]
  {+new+}

Moved selected pairs are also marked with DIFF_SYMBOL_MOVED_LINE so that the
current moved-line coloring can show that the pair came from a moved region.

---
 diff.c | 213 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 200 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index 6b8744920..8629d4670 100644
--- a/diff.c
+++ b/diff.c
@@ -1811,6 +1811,104 @@ static void word_diff_align_add_candidate(struct word_diff_align_candidate **can
 	candidate->line_shared = line_shared;
 }
 
+/*
+ * RFC-only formatter for exposing the selected line pairs.  The final
+ * presentation should reuse the normal word-diff machinery instead of this
+ * small debug renderer.
+ */
+struct word_diff_align_debug_token {
+	int start;
+	int end;
+};
+
+static void word_diff_align_debug_collect_tokens(const struct emitted_diff_symbol *line,
+						 struct word_diff_align_debug_token **tokens,
+						 int *tokens_nr, int *tokens_alloc)
+{
+	int len = word_diff_align_payload_len(line);
+	int pos = 0, start, end;
+
+	while (word_diff_align_next_token(line->line, len, &pos, &start, &end)) {
+		ALLOC_GROW(*tokens, *tokens_nr + 1, *tokens_alloc);
+		(*tokens)[*tokens_nr].start = start;
+		(*tokens)[*tokens_nr].end = end;
+		(*tokens_nr)++;
+	}
+}
+
+static void word_diff_align_debug_add_span(struct strbuf *out,
+					   const char *open,
+					   const char *line, int len,
+					   const char *close)
+{
+	if (!len)
+		return;
+	strbuf_addstr(out, open);
+	strbuf_add(out, line, len);
+	strbuf_addstr(out, close);
+}
+
+static int word_diff_align_debug_token_eq(const struct emitted_diff_symbol *a,
+					  const struct word_diff_align_debug_token *a_tok,
+					  const struct emitted_diff_symbol *b,
+					  const struct word_diff_align_debug_token *b_tok)
+{
+	int a_len = a_tok->end - a_tok->start;
+	int b_len = b_tok->end - b_tok->start;
+
+	return a_len == b_len &&
+		!memcmp(a->line + a_tok->start, b->line + b_tok->start, a_len);
+}
+
+static void word_diff_align_debug_rewrite_line(struct emitted_diff_symbol *line,
+					       struct word_diff_align_debug_token *tokens,
+					       int tokens_nr, int *match_to,
+					       const struct emitted_diff_symbol *other,
+					       struct word_diff_align_debug_token *other_tokens,
+					       const char *open, const char *close)
+{
+	struct strbuf out = STRBUF_INIT;
+	char *old_line = (char *)line->line;
+	int payload_len = word_diff_align_payload_len(line);
+	int other_pos = 0;
+	int other_payload_len = word_diff_align_payload_len(other);
+	int pos = 0, i;
+	size_t new_len;
+
+	for (i = 0; i < tokens_nr; i++) {
+		int other_i = match_to[i];
+		int gap_len, other_gap_len;
+
+		if (other_i < 0)
+			continue;
+		gap_len = tokens[i].start - pos;
+		other_gap_len = other_tokens[other_i].start - other_pos;
+		if (gap_len == other_gap_len &&
+		    !memcmp(line->line + pos, other->line + other_pos, gap_len))
+			strbuf_add(&out, line->line + pos, gap_len);
+		else
+			word_diff_align_debug_add_span(&out, open,
+						       line->line + pos,
+						       gap_len, close);
+		strbuf_add(&out, line->line + tokens[i].start,
+			   tokens[i].end - tokens[i].start);
+		pos = tokens[i].end;
+		other_pos = other_tokens[other_i].end;
+	}
+	if (payload_len - pos == other_payload_len - other_pos &&
+	    !memcmp(line->line + pos, other->line + other_pos,
+		    payload_len - pos))
+		strbuf_add(&out, line->line + pos, payload_len - pos);
+	else
+		word_diff_align_debug_add_span(&out, open, line->line + pos,
+					       payload_len - pos, close);
+	strbuf_add(&out, line->line + payload_len, line->len - payload_len);
+
+	line->line = strbuf_detach(&out, &new_len);
+	line->len = (int)new_len;
+	free(old_line);
+}
+
 static void word_diff_align_debug_append_comment(struct emitted_diff_symbol *line,
 						 const struct strbuf *suffix)
 {
@@ -1835,25 +1933,114 @@ static void word_diff_align_debug_mark_pair(struct emitted_diff_symbol *minus_li
 					    struct emitted_diff_symbol *plus_line,
 					    int minus_lineno, int plus_lineno,
 					    int changed, int moved,
-						    int window_score,
-						    int line_score,
-						    int pair_score)
-{
-	struct strbuf suffix = STRBUF_INIT;
+					    int window_score,
+					    int line_score,
+					    int pair_score)
+{
+	struct word_diff_align_debug_token *minus_tokens = NULL, *plus_tokens = NULL;
+	int minus_tokens_nr = 0, minus_tokens_alloc = 0;
+	int plus_tokens_nr = 0, plus_tokens_alloc = 0;
+	int *minus_match_to = NULL, *plus_match_to = NULL;
+	int *lcs = NULL;
+	struct emitted_diff_symbol minus_original = *minus_line;
+	struct emitted_diff_symbol plus_original = *plus_line;
+	int i, j, columns;
 
 	if (moved) {
 		minus_line->flags |= DIFF_SYMBOL_MOVED_LINE;
 		plus_line->flags |= DIFF_SYMBOL_MOVED_LINE;
 	}
 
-	strbuf_addf(&suffix,
-		    "        # aligned from %d to %d, %s, W=%d L=%d S=%d",
-		    minus_lineno, plus_lineno,
-		    changed ? "edited" : "unchanged",
-		    window_score, line_score, pair_score);
-	word_diff_align_debug_append_comment(minus_line, &suffix);
-	word_diff_align_debug_append_comment(plus_line, &suffix);
-	strbuf_release(&suffix);
+	minus_original.line = xmemdupz(minus_line->line, minus_line->len);
+	plus_original.line = xmemdupz(plus_line->line, plus_line->len);
+	if (!changed)
+		goto comment;
+
+	word_diff_align_debug_collect_tokens(minus_line, &minus_tokens,
+					     &minus_tokens_nr,
+					     &minus_tokens_alloc);
+	word_diff_align_debug_collect_tokens(plus_line, &plus_tokens,
+					     &plus_tokens_nr,
+					     &plus_tokens_alloc);
+	if (!minus_tokens_nr || !plus_tokens_nr)
+		goto comment;
+
+	columns = plus_tokens_nr + 1;
+	CALLOC_ARRAY(lcs, (minus_tokens_nr + 1) * columns);
+	ALLOC_ARRAY(minus_match_to, minus_tokens_nr);
+	ALLOC_ARRAY(plus_match_to, plus_tokens_nr);
+	for (i = 0; i < minus_tokens_nr; i++)
+		minus_match_to[i] = -1;
+	for (j = 0; j < plus_tokens_nr; j++)
+		plus_match_to[j] = -1;
+
+	for (i = 1; i <= minus_tokens_nr; i++) {
+		for (j = 1; j <= plus_tokens_nr; j++) {
+			if (word_diff_align_debug_token_eq(minus_line,
+							   &minus_tokens[i - 1],
+							   plus_line,
+							   &plus_tokens[j - 1]))
+				lcs[i * columns + j] =
+					lcs[(i - 1) * columns + j - 1] + 1;
+			else if (lcs[(i - 1) * columns + j] >
+				 lcs[i * columns + j - 1])
+				lcs[i * columns + j] = lcs[(i - 1) * columns + j];
+			else
+				lcs[i * columns + j] = lcs[i * columns + j - 1];
+		}
+	}
+
+	i = minus_tokens_nr;
+	j = plus_tokens_nr;
+	while (i > 0 && j > 0) {
+		if (lcs[i * columns + j] == lcs[i * columns + j - 1]) {
+			j--;
+		} else if (lcs[i * columns + j] ==
+			   lcs[(i - 1) * columns + j]) {
+			i--;
+		} else if (word_diff_align_debug_token_eq(minus_line,
+							  &minus_tokens[i - 1],
+							  plus_line,
+							  &plus_tokens[j - 1])) {
+			minus_match_to[i - 1] = j - 1;
+			plus_match_to[j - 1] = i - 1;
+			i--;
+			j--;
+		} else {
+			BUG("word-diff-align display LCS backtrack failed");
+		}
+	}
+
+	word_diff_align_debug_rewrite_line(minus_line, minus_tokens,
+					   minus_tokens_nr, minus_match_to,
+					   &plus_original, plus_tokens,
+					   "[-", "-]");
+	word_diff_align_debug_rewrite_line(plus_line, plus_tokens,
+					   plus_tokens_nr, plus_match_to,
+					   &minus_original, minus_tokens,
+					   "{+", "+}");
+
+comment:
+	{
+		struct strbuf suffix = STRBUF_INIT;
+
+		strbuf_addf(&suffix,
+			    "        # aligned from %d to %d, %s, W=%d L=%d S=%d",
+			    minus_lineno, plus_lineno,
+			    changed ? "edited" : "unchanged",
+			    window_score, line_score, pair_score);
+		word_diff_align_debug_append_comment(minus_line, &suffix);
+		word_diff_align_debug_append_comment(plus_line, &suffix);
+		strbuf_release(&suffix);
+	}
+
+	free((char *)minus_original.line);
+	free((char *)plus_original.line);
+	free(minus_tokens);
+	free(plus_tokens);
+	free(minus_match_to);
+	free(plus_match_to);
+	free(lcs);
 }
 
 static void word_diff_align_add_item(struct word_diff_align_item **items,
-- 
2.39.3 (Apple Git-146)
