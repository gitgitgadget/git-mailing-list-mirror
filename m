Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037912CD8B
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470618; cv=none; b=T0OIgYU/5oalUqpg/hlIR0VvW4OA7oKFOPsqTqkfgZK7j4tZCe0fAjYzmi+Jrp1gaNL8QVBe76jno445xHu2BU74Tu3TNR7xebNYTIo7TijFZ1vJets7R2kiAXLbuzqwp8gzvhQ+ELdjQMMeKzXXrf34I/fFEn+tNK7LvEhp97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470618; c=relaxed/simple;
	bh=zl3qEpUGp2dofe8n3ud9QfDp9m2I02BK2cajY626yv8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCdPFP4Q7pess2Xb4SLvnwlRHIctz18U+d+ollEJT1/ggjjg87YM0MEKE3cx0pmBK4BUfEG9IUuo/FAX+gCGkPuAVofgaMdJuCMY4c+dCyXhtaknIWZVWzDlu/uWOnSxYUl0oMciwwl8hQ7KbsB9SXksEirdduOgN5QbemVsI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kWPq0Cg6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2G5FmEz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kWPq0Cg6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2G5FmEz"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id CD5AF1380295
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 03:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726470615; x=1726557015; bh=cjd08d0pc9
	RfIS0OMdFTEYqTdJr9RSmzVUcZ0Ji41xQ=; b=kWPq0Cg63diDJtrJKUOH5onP9A
	ModxUVNILXce9s/AS5N1578F7vygH/7ovwv0NlhbGFYhTiTm/2m0VPrvEuPbJjtV
	TVB/kTif2JwWAWi0kVMYi5ItLHQa6g+SPc4LjGAWUdHydrzSWf5iGe45kR+WN1HR
	bpZ3H3f74aoIfJUEAdiVa5MuWmAzKk+/KeUa3ZCHCaKGhBOyb6YnZf1EYSLQdvB5
	hiseH+v2VVfFGtDaIEfYx8HnE4yXQ81WQcgsIo2DeqXzM7VhR+d4Ox/2Qz7AlJDg
	MI/L75mwx3GeObtttoFsIVBOaB4vP+Bg1iuIXNz+aM9LBBPftszWGskPQeDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726470615; x=1726557015; bh=cjd08d0pc9RfIS0OMdFTEYqTdJr9
	RSmzVUcZ0Ji41xQ=; b=a2G5FmEzTA/5tnBzvzewMfL0E+Hw+mnEa9B2JmF8+nKY
	ORWjUC7sfvO4tDr7Mho0p2Gwt6aWR29xm9MfiGp2e/UQVoye+Zd8j+1ZBbxK3qvw
	3cP0CikdeWTqON/VHMt0/U2IyIFMpTcGwvwn5gDBhsQl/SeiAXWQvcMvAd5bgFdv
	DZ8lvNqZpcyxTLiOsa+1b1W2s0MenTyFtpaDtfw6FGYV5xRSZTDux4ATVteQyh8v
	cfC9NT7ahwq9pKvSCa3hF/jP774ruSvTzZU+DMtn2KUnwM9hoMnH6oih5vrIHXvC
	HCBQpXeQl2zyo+h/JBAa0qsh1eOug9GOT860w4HerQ==
X-ME-Sender: <xms:19nnZiI8_tBMeZ8WXZH5IdfgtCGycpWrzlQvXme6FOnq2pnpPknFYw>
    <xme:19nnZqJClJlLtHv5dC27YYjvEMRRlM3ZUyXYsn6ldVVJm9kv38BkzZt6eK0mD5AXY
    tuX2NT4Vya6o-zfPQ>
X-ME-Received: <xmr:19nnZitDtngGepM-1_IaWuko695XnJH9HRkKUgQrHLUI-QVHpnGbL1on0Z_3NYXoj9MtPzq1ojGTqfDkZXxCYEfUqoVa3cmGAkznwR6R8h-qLIVN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:19nnZnaneqBZZ_6mawA3pJn_97TVZ_UTBmbFMe8RI9kLvucsYbJ9rg>
    <xmx:19nnZpYVuXe76-Z_0Ix6s5zwcq7ADocINMZR16ykNmOBPeu800g5ww>
    <xmx:19nnZjCRYb5ss36W20PCYP8awhhpinbpagZkZYaFVn0oBzTb5hvSdA>
    <xmx:19nnZvaC2aIyvOZvgCG5YsmuXWV9_P_Qw7TtehEu-0gJGtK5eednlw>
    <xmx:19nnZozrNneoPfSIypP50jfMZlfT18wg2v3L9iRpvtU1SwZxOtBkGMz6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 006b596d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 07:09:58 +0000 (UTC)
Date: Mon, 16 Sep 2024 09:10:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/6] apply: rename members that track line count and
 allocation length
Message-ID: <e35816ed568633470b049f77ad639ddf0d39379e.1726470385.git.ps@pks.im>
References: <cover.1726470385.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726470385.git.ps@pks.im>

The `struct image` has two members `nr` and `alloc` that track the
number of lines as well as how large its array is. It is somewhat easy
to confuse these members with `len` though, which tracks the length of
the `buf` member.

Rename these members to `line_nr` and `line_alloc` respectively to avoid
confusion. This is in line with how we typically name variables that
track an array in this way.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c | 91 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 46 deletions(-)

diff --git a/apply.c b/apply.c
index 985564ac76..3340bb1fc0 100644
--- a/apply.c
+++ b/apply.c
@@ -279,9 +279,8 @@ struct line {
 struct image {
 	char *buf;
 	size_t len;
-	size_t nr;
-	size_t alloc;
 	struct line *line;
+	size_t line_nr, line_alloc;
 };
 #define IMAGE_INIT { 0 }
 
@@ -312,11 +311,11 @@ static uint32_t hash_line(const char *cp, size_t len)
 
 static void image_add_line(struct image *img, const char *bol, size_t len, unsigned flag)
 {
-	ALLOC_GROW(img->line, img->nr + 1, img->alloc);
-	img->line[img->nr].len = len;
-	img->line[img->nr].hash = hash_line(bol, len);
-	img->line[img->nr].flag = flag;
-	img->nr++;
+	ALLOC_GROW(img->line, img->line_nr + 1, img->line_alloc);
+	img->line[img->line_nr].len = len;
+	img->line[img->line_nr].hash = hash_line(bol, len);
+	img->line[img->line_nr].flag = flag;
+	img->line_nr++;
 }
 
 /*
@@ -353,14 +352,14 @@ static void image_remove_first_line(struct image *img)
 {
 	img->buf += img->line[0].len;
 	img->len -= img->line[0].len;
-	img->nr--;
-	if (img->nr)
-		MOVE_ARRAY(img->line, img->line + 1, img->nr);
+	img->line_nr--;
+	if (img->line_nr)
+		MOVE_ARRAY(img->line, img->line + 1, img->line_nr);
 }
 
 static void image_remove_last_line(struct image *img)
 {
-	img->len -= img->line[--img->nr].len;
+	img->len -= img->line[--img->line_nr].len;
 }
 
 /* fmt must contain _one_ %s and no other substitution */
@@ -2330,9 +2329,9 @@ static void update_pre_post_images(struct image *preimage,
 	 */
 	image_prepare(&fixed_preimage, buf, len, 1);
 	assert(postlen
-	       ? fixed_preimage.nr == preimage->nr
-	       : fixed_preimage.nr <= preimage->nr);
-	for (i = 0; i < fixed_preimage.nr; i++)
+	       ? fixed_preimage.line_nr == preimage->line_nr
+	       : fixed_preimage.line_nr <= preimage->line_nr);
+	for (i = 0; i < fixed_preimage.line_nr; i++)
 		fixed_preimage.line[i].flag = preimage->line[i].flag;
 	free(preimage->line);
 	*preimage = fixed_preimage;
@@ -2353,7 +2352,7 @@ static void update_pre_post_images(struct image *preimage,
 		new_buf = old_buf;
 	fixed = preimage->buf;
 
-	for (i = reduced = ctx = 0; i < postimage->nr; i++) {
+	for (i = reduced = ctx = 0; i < postimage->line_nr; i++) {
 		size_t l_len = postimage->line[i].len;
 		if (!(postimage->line[i].flag & LINE_COMMON)) {
 			/* an added line -- no counterparts in preimage */
@@ -2367,7 +2366,7 @@ static void update_pre_post_images(struct image *preimage,
 		old_buf += l_len;
 
 		/* and find the corresponding one in the fixed preimage */
-		while (ctx < preimage->nr &&
+		while (ctx < preimage->line_nr &&
 		       !(preimage->line[ctx].flag & LINE_COMMON)) {
 			fixed += preimage->line[ctx].len;
 			ctx++;
@@ -2377,7 +2376,7 @@ static void update_pre_post_images(struct image *preimage,
 		 * preimage is expected to run out, if the caller
 		 * fixed addition of trailing blank lines.
 		 */
-		if (preimage->nr <= ctx) {
+		if (preimage->line_nr <= ctx) {
 			reduced++;
 			continue;
 		}
@@ -2399,7 +2398,7 @@ static void update_pre_post_images(struct image *preimage,
 
 	/* Fix the length of the whole thing */
 	postimage->len = new_buf - postimage->buf;
-	postimage->nr -= reduced;
+	postimage->line_nr -= reduced;
 }
 
 /*
@@ -2482,7 +2481,7 @@ static int line_by_line_fuzzy_match(struct image *img,
 	 * we are removing blank lines at the end of the file.)
 	 */
 	buf = preimage_eof = preimage->buf + preoff;
-	for ( ; i < preimage->nr; i++)
+	for ( ; i < preimage->line_nr; i++)
 		preoff += preimage->line[i].len;
 	preimage_end = preimage->buf + preoff;
 	for ( ; buf < preimage_end; buf++)
@@ -2522,12 +2521,12 @@ static int match_fragment(struct apply_state *state,
 	int preimage_limit;
 	int ret;
 
-	if (preimage->nr + current_lno <= img->nr) {
+	if (preimage->line_nr + current_lno <= img->line_nr) {
 		/*
 		 * The hunk falls within the boundaries of img.
 		 */
-		preimage_limit = preimage->nr;
-		if (match_end && (preimage->nr + current_lno != img->nr)) {
+		preimage_limit = preimage->line_nr;
+		if (match_end && (preimage->line_nr + current_lno != img->line_nr)) {
 			ret = 0;
 			goto out;
 		}
@@ -2540,7 +2539,7 @@ static int match_fragment(struct apply_state *state,
 		 * match with img, and the remainder of the preimage
 		 * must be blank.
 		 */
-		preimage_limit = img->nr - current_lno;
+		preimage_limit = img->line_nr - current_lno;
 	} else {
 		/*
 		 * The hunk extends beyond the end of the img and
@@ -2565,7 +2564,7 @@ static int match_fragment(struct apply_state *state,
 		}
 	}
 
-	if (preimage_limit == preimage->nr) {
+	if (preimage_limit == preimage->line_nr) {
 		/*
 		 * Do we have an exact match?  If we were told to match
 		 * at the end, size must be exactly at current+fragsize,
@@ -2637,7 +2636,7 @@ static int match_fragment(struct apply_state *state,
 
 	/* First count added lines in postimage */
 	postlen = 0;
-	for (i = 0; i < postimage->nr; i++) {
+	for (i = 0; i < postimage->line_nr; i++) {
 		if (!(postimage->line[i].flag & LINE_COMMON))
 			postlen += postimage->line[i].len;
 	}
@@ -2699,7 +2698,7 @@ static int match_fragment(struct apply_state *state,
 	 * empty or only contain whitespace (if WS_BLANK_AT_EOL is
 	 * false).
 	 */
-	for ( ; i < preimage->nr; i++) {
+	for ( ; i < preimage->line_nr; i++) {
 		size_t fixstart = fixed.len; /* start of the fixed preimage */
 		size_t oldlen = preimage->line[i].len;
 		int j;
@@ -2754,7 +2753,7 @@ static int find_pos(struct apply_state *state,
 	 * than `match_beginning`.
 	 */
 	if (state->allow_overlap && match_beginning && match_end &&
-	    img->nr - preimage->nr != 0)
+	    img->line_nr - preimage->line_nr != 0)
 		match_beginning = 0;
 
 	/*
@@ -2765,15 +2764,15 @@ static int find_pos(struct apply_state *state,
 	if (match_beginning)
 		line = 0;
 	else if (match_end)
-		line = img->nr - preimage->nr;
+		line = img->line_nr - preimage->line_nr;
 
 	/*
 	 * Because the comparison is unsigned, the following test
 	 * will also take care of a negative line number that can
 	 * result when match_end and preimage is larger than the target.
 	 */
-	if ((size_t) line > img->nr)
-		line = img->nr;
+	if ((size_t) line > img->line_nr)
+		line = img->line_nr;
 
 	current = 0;
 	for (i = 0; i < line; i++)
@@ -2796,7 +2795,7 @@ static int find_pos(struct apply_state *state,
 			return current_lno;
 
 	again:
-		if (backwards_lno == 0 && forwards_lno == img->nr)
+		if (backwards_lno == 0 && forwards_lno == img->line_nr)
 			break;
 
 		if (i & 1) {
@@ -2809,7 +2808,7 @@ static int find_pos(struct apply_state *state,
 			current = backwards;
 			current_lno = backwards_lno;
 		} else {
-			if (forwards_lno == img->nr) {
+			if (forwards_lno == img->line_nr) {
 				i++;
 				goto again;
 			}
@@ -2852,9 +2851,9 @@ static void update_image(struct apply_state *state,
 	 * to the number of lines in the preimage that falls
 	 * within the boundaries.
 	 */
-	preimage_limit = preimage->nr;
-	if (preimage_limit > img->nr - applied_pos)
-		preimage_limit = img->nr - applied_pos;
+	preimage_limit = preimage->line_nr;
+	if (preimage_limit > img->line_nr - applied_pos)
+		preimage_limit = img->line_nr - applied_pos;
 
 	for (i = 0; i < applied_pos; i++)
 		applied_at += img->line[i].len;
@@ -2877,22 +2876,22 @@ static void update_image(struct apply_state *state,
 	result[img->len] = '\0';
 
 	/* Adjust the line table */
-	nr = img->nr + postimage->nr - preimage_limit;
-	if (preimage_limit < postimage->nr)
+	nr = img->line_nr + postimage->line_nr - preimage_limit;
+	if (preimage_limit < postimage->line_nr)
 		/*
 		 * NOTE: this knows that we never call image_remove_first_line()
 		 * on anything other than pre/post image.
 		 */
 		REALLOC_ARRAY(img->line, nr);
-	if (preimage_limit != postimage->nr)
-		MOVE_ARRAY(img->line + applied_pos + postimage->nr,
+	if (preimage_limit != postimage->line_nr)
+		MOVE_ARRAY(img->line + applied_pos + postimage->line_nr,
 			   img->line + applied_pos + preimage_limit,
-			   img->nr - (applied_pos + preimage_limit));
-	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->nr);
+			   img->line_nr - (applied_pos + preimage_limit));
+	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->line_nr);
 	if (!state->allow_overlap)
-		for (i = 0; i < postimage->nr; i++)
+		for (i = 0; i < postimage->line_nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
-	img->nr = nr;
+	img->line_nr = nr;
 }
 
 /*
@@ -3024,8 +3023,8 @@ static int apply_one_fragment(struct apply_state *state,
 	    newlines.len > 0 && newlines.buf[newlines.len - 1] == '\n') {
 		old--;
 		strbuf_setlen(&newlines, newlines.len - 1);
-		preimage.line[preimage.nr - 1].len--;
-		postimage.line[postimage.nr - 1].len--;
+		preimage.line[preimage.line_nr - 1].len--;
+		postimage.line[postimage.line_nr - 1].len--;
 	}
 
 	leading = frag->leading;
@@ -3096,7 +3095,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 	if (applied_pos >= 0) {
 		if (new_blank_lines_at_end &&
-		    preimage.nr + applied_pos >= img->nr &&
+		    preimage.line_nr + applied_pos >= img->line_nr &&
 		    (ws_rule & WS_BLANK_AT_EOF) &&
 		    state->ws_error_action != nowarn_ws_error) {
 			record_ws_error(state, WS_BLANK_AT_EOF, "+", 1,
-- 
2.46.0.551.gc5ee8f2d1c.dirty

