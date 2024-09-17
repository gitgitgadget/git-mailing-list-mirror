Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7016D4EA
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567693; cv=none; b=qr5rA1yj4mI9DTUW2SCV2VNKGpQ0M1xTx5nHXJfswL1sZUcXa1/oecNvwMPEHwOpLcN2tSF3wxB5NTS+8tBu9CtTpelkhM3rV3za3xWjGO4ze5y7nkhgQhDtvAEKBi3mAR3Kxpbuh2Ux4iRBvsdUYZfyq+xx0YvJdxevarcu72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567693; c=relaxed/simple;
	bh=WCSNxxmb+F26r2o2UM1bGt6uxfUYC/4DWVJCnfiAFdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OD+QD0qq6j/pq+XRGH194LNnUlguPHK+Fk488dK2z7onFftIyLlW7osrQZDFB11oS6I8F+KSn2VQWQ+D0RlYytJDZTSnYlB1JaHL9XhrD1kxXQD1ZvpO/rSYS/riZLqUYvoNPzVHaMeZronMdOMxSAGOZE7DUCtxnUjPlQk87TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FJ/Z3Ner; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q1yP/sqM; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FJ/Z3Ner";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q1yP/sqM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 55404138024F;
	Tue, 17 Sep 2024 06:08:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 17 Sep 2024 06:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726567690; x=1726654090; bh=MHM4NLoLW0
	7W682Ly8U3cmbCaioN8lddi/1+mu1BqPw=; b=FJ/Z3Ner/AvMpWERsf8advxPl/
	85e9dXIMknMC1dhK9IQUFjvX6pGhj8YflpPw2zUNA/vj2w6gGVBP/r7DzV5w/YCx
	6ARD1AEXov9FNwNWwjkTA3r2bruAPAhoxNJrGhwqzCxrBgbEJ4sudDOtbKxWIB9l
	j4rp9hYvpt6EVi2ySW3dUPN0yJKcvUOapt5bayOb3Q42kbu+m02v2ibe0kcUBaQf
	lGAabG/gm9ESGzRuR2ArkaTRJGfwQ+xg326CcEThTJiLO5KhsyWgBX2s8pc76e69
	nY93p43eyDROW6HEx+P0cVbOp0bWOCmrlJjRtixxYdUePlpm3bT7Fjugn2uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726567690; x=1726654090; bh=MHM4NLoLW07W682Ly8U3cmbCaioN
	8lddi/1+mu1BqPw=; b=q1yP/sqMkljogv/x971zRAvA/RUXEBvBtwP5EaEg0rNz
	ltu8EWVNgkL/iIKa3RmRV7SQUi7k2kfHBg34ng4RqlnLdhAG+a7bYRMAlUPrQusF
	6qgdelD9biruuw0r1OsDjQBAkOxW4ePdzBYGbEyGzw08pNuElToKrpKAx3FtanaY
	Gg1tVXnMdUIo8GiT+IvGjcOQttL0wYhGt99PQKZHKS/7AYLuCnksl795BbKdRBUo
	NTj2V1THkX7AvZX7BxJKk1SfAebdEGiiqN2rto2nS7YFFw7q1jTIB6+bxTMubKcO
	yTUvtehBRVfWQKyiJB72qOZOBfw2dw4UqOgEGRHeoQ==
X-ME-Sender: <xms:ClXpZshpbPSKHAo0yO0fKKI21YUjkBXAGZCxDcoKQ8QqMBE7hH4f3Q>
    <xme:ClXpZlDWiLWUz0HcJW8HTQouYiFIQp8WH5FgCKFOXz97enmuiU-UqPaVUKeIpndB8
    IVU6kHeTTU9fP6kuA>
X-ME-Received: <xmr:ClXpZkF47yRv-4L6rlck3fXqewA8qtlwbSONhbfGrUXGwhZiPF9c81LHDh83MRsaaHX03Rv3zFfqlkdK49c6eNJTTHtpXyqIYPHkdwAeSY5F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homh
X-ME-Proxy: <xmx:ClXpZtQF0F4gJU7UI6rwvs-7G3tVTLnfDETl9g8jY47w-eT7B3dCBg>
    <xmx:ClXpZpy3grdd5syug7fa13TQaVxwHuLKCLH57A7pF0rt33feNT8nXg>
    <xmx:ClXpZr7xVKDpdvae77mDV_0ZzFa5uX2Nyfo2JcptuNsha-UItM85Aw>
    <xmx:ClXpZmwzIadZ-RRCc2_T-JcpG7_f_0TX1EbIIfLBg9DBveYa2-9dhw>
    <xmx:ClXpZk-cOgL3U9RMGYPo0j_CjW0-kqG64A5kP5q9Ih2ZHlGi_hfGmnio>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 06:08:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ddb4f892 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 10:07:50 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:08:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 6/6] apply: refactor `struct image` to use a `struct
 strbuf`
Message-ID: <42880dcf04a34833f22dd4a1c641f5476b77fda0.1726567217.git.ps@pks.im>
References: <cover.1726470385.git.ps@pks.im>
 <cover.1726567217.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726567217.git.ps@pks.im>

The `struct image` uses a character array to track the pre- or postimage
of a patch operation. This has multiple downsides:

  - It is somewhat hard to track memory ownership. In fact, we have
    several memory leaks in git-apply(1) because we do not (and cannot
    easily) free the buffer in all situations.

  - We have to reinvent the wheel and manually implement a lot of
    functionality that would already be provided by `struct strbuf`.

  - We have to carefully track whether `update_pre_post_images()` can do
    an in-place update of the postimage or whether it has to allocate a
    new buffer for it.

This is all rather cumbersome, and especially `update_pre_post_images()`
is really hard to understand as a consequence even though what it is
doing is rather trivial.

Refactor the code to use a `struct strbuf` instead, addressing all of
the above. Like this we can easily perform in-place updates in all
situations, the logic to perform those updates becomes way simpler and
the lifetime of the buffer becomes a ton easier to track.

This refactoring also plugs some leaking buffers as a side effect.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c                            | 194 +++++++++++------------------
 t/t3436-rebase-more-options.sh     |   1 +
 t/t4107-apply-ignore-whitespace.sh |   4 +-
 t/t4124-apply-ws-rule.sh           |   1 +
 t/t4125-apply-ws-fuzz.sh           |   1 +
 t/t4138-apply-ws-expansion.sh      |   1 +
 6 files changed, 79 insertions(+), 123 deletions(-)

diff --git a/apply.c b/apply.c
index 3340bb1fc0..06a75ea034 100644
--- a/apply.c
+++ b/apply.c
@@ -277,12 +277,13 @@ struct line {
  * This represents a "file", which is an array of "lines".
  */
 struct image {
-	char *buf;
-	size_t len;
+	struct strbuf buf;
 	struct line *line;
 	size_t line_nr, line_alloc;
 };
-#define IMAGE_INIT { 0 }
+#define IMAGE_INIT { \
+	.buf = STRBUF_INIT, \
+}
 
 static void image_init(struct image *image)
 {
@@ -292,7 +293,7 @@ static void image_init(struct image *image)
 
 static void image_clear(struct image *image)
 {
-	free(image->buf);
+	strbuf_release(&image->buf);
 	free(image->line);
 	image_init(image);
 }
@@ -329,14 +330,13 @@ static void image_prepare(struct image *image, char *buf, size_t len,
 	const char *cp, *ep;
 
 	image_clear(image);
-	image->buf = buf;
-	image->len = len;
+	strbuf_attach(&image->buf, buf, len, len + 1);
 
 	if (!prepare_linetable)
 		return;
 
-	ep = image->buf + image->len;
-	cp = image->buf;
+	ep = image->buf.buf + image->buf.len;
+	cp = image->buf.buf;
 	while (cp < ep) {
 		const char *next;
 		for (next = cp; next < ep && *next != '\n'; next++)
@@ -350,8 +350,7 @@ static void image_prepare(struct image *image, char *buf, size_t len,
 
 static void image_remove_first_line(struct image *img)
 {
-	img->buf += img->line[0].len;
-	img->len -= img->line[0].len;
+	strbuf_remove(&img->buf, 0, img->line[0].len);
 	img->line_nr--;
 	if (img->line_nr)
 		MOVE_ARRAY(img->line, img->line + 1, img->line_nr);
@@ -359,7 +358,9 @@ static void image_remove_first_line(struct image *img)
 
 static void image_remove_last_line(struct image *img)
 {
-	img->len -= img->line[--img->line_nr].len;
+	size_t last_line_len = img->line[img->line_nr - 1].len;
+	strbuf_setlen(&img->buf, img->buf.len - last_line_len);
+	img->line_nr--;
 }
 
 /* fmt must contain _one_ %s and no other substitution */
@@ -2308,19 +2309,16 @@ static int read_old_data(struct stat *st, struct patch *patch,
 
 /*
  * Update the preimage, and the common lines in postimage,
- * from buffer buf of length len. If postlen is 0 the postimage
- * is updated in place, otherwise it's updated on a new buffer
- * of length postlen
+ * from buffer buf of length len.
  */
-
 static void update_pre_post_images(struct image *preimage,
 				   struct image *postimage,
-				   char *buf,
-				   size_t len, size_t postlen)
+				   char *buf, size_t len)
 {
-	int i, ctx, reduced;
-	char *new_buf, *old_buf, *fixed;
 	struct image fixed_preimage = IMAGE_INIT;
+	size_t insert_pos = 0;
+	int i, ctx, reduced;
+	const char *fixed;
 
 	/*
 	 * Update the preimage with whitespace fixes.  Note that we
@@ -2328,43 +2326,24 @@ static void update_pre_post_images(struct image *preimage,
 	 * free "oldlines".
 	 */
 	image_prepare(&fixed_preimage, buf, len, 1);
-	assert(postlen
-	       ? fixed_preimage.line_nr == preimage->line_nr
-	       : fixed_preimage.line_nr <= preimage->line_nr);
 	for (i = 0; i < fixed_preimage.line_nr; i++)
 		fixed_preimage.line[i].flag = preimage->line[i].flag;
-	free(preimage->line);
+	image_clear(preimage);
 	*preimage = fixed_preimage;
+	fixed = preimage->buf.buf;
 
 	/*
-	 * Adjust the common context lines in postimage. This can be
-	 * done in-place when we are shrinking it with whitespace
-	 * fixing, but needs a new buffer when ignoring whitespace or
-	 * expanding leading tabs to spaces.
-	 *
-	 * We trust the caller to tell us if the update can be done
-	 * in place (postlen==0) or not.
+	 * Adjust the common context lines in postimage.
 	 */
-	old_buf = postimage->buf;
-	if (postlen)
-		new_buf = postimage->buf = xmalloc(postlen);
-	else
-		new_buf = old_buf;
-	fixed = preimage->buf;
-
 	for (i = reduced = ctx = 0; i < postimage->line_nr; i++) {
 		size_t l_len = postimage->line[i].len;
+
 		if (!(postimage->line[i].flag & LINE_COMMON)) {
 			/* an added line -- no counterparts in preimage */
-			memmove(new_buf, old_buf, l_len);
-			old_buf += l_len;
-			new_buf += l_len;
+			insert_pos += l_len;
 			continue;
 		}
 
-		/* a common context -- skip it in the original postimage */
-		old_buf += l_len;
-
 		/* and find the corresponding one in the fixed preimage */
 		while (ctx < preimage->line_nr &&
 		       !(preimage->line[ctx].flag & LINE_COMMON)) {
@@ -2383,21 +2362,15 @@ static void update_pre_post_images(struct image *preimage,
 
 		/* and copy it in, while fixing the line length */
 		l_len = preimage->line[ctx].len;
-		memcpy(new_buf, fixed, l_len);
-		new_buf += l_len;
+		strbuf_splice(&postimage->buf, insert_pos, postimage->line[i].len,
+			      fixed, l_len);
+		insert_pos += l_len;
 		fixed += l_len;
 		postimage->line[i].len = l_len;
 		ctx++;
 	}
 
-	if (postlen
-	    ? postlen < new_buf - postimage->buf
-	    : postimage->len < new_buf - postimage->buf)
-		BUG("caller miscounted postlen: asked %d, orig = %d, used = %d",
-		    (int)postlen, (int) postimage->len, (int)(new_buf - postimage->buf));
-
 	/* Fix the length of the whole thing */
-	postimage->len = new_buf - postimage->buf;
 	postimage->line_nr -= reduced;
 }
 
@@ -2447,7 +2420,6 @@ static int line_by_line_fuzzy_match(struct image *img,
 	int i;
 	size_t imgoff = 0;
 	size_t preoff = 0;
-	size_t postlen = postimage->len;
 	size_t extra_chars;
 	char *buf;
 	char *preimage_eof;
@@ -2460,11 +2432,9 @@ static int line_by_line_fuzzy_match(struct image *img,
 		size_t prelen = preimage->line[i].len;
 		size_t imglen = img->line[current_lno+i].len;
 
-		if (!fuzzy_matchlines(img->buf + current + imgoff, imglen,
-				      preimage->buf + preoff, prelen))
+		if (!fuzzy_matchlines(img->buf.buf + current + imgoff, imglen,
+				      preimage->buf.buf + preoff, prelen))
 			return 0;
-		if (preimage->line[i].flag & LINE_COMMON)
-			postlen += imglen - prelen;
 		imgoff += imglen;
 		preoff += prelen;
 	}
@@ -2480,10 +2450,10 @@ static int line_by_line_fuzzy_match(struct image *img,
 	 * are whitespace characters. (This can only happen if
 	 * we are removing blank lines at the end of the file.)
 	 */
-	buf = preimage_eof = preimage->buf + preoff;
+	buf = preimage_eof = preimage->buf.buf + preoff;
 	for ( ; i < preimage->line_nr; i++)
 		preoff += preimage->line[i].len;
-	preimage_end = preimage->buf + preoff;
+	preimage_end = preimage->buf.buf + preoff;
 	for ( ; buf < preimage_end; buf++)
 		if (!isspace(*buf))
 			return 0;
@@ -2497,11 +2467,11 @@ static int line_by_line_fuzzy_match(struct image *img,
 	 */
 	extra_chars = preimage_end - preimage_eof;
 	strbuf_init(&fixed, imgoff + extra_chars);
-	strbuf_add(&fixed, img->buf + current, imgoff);
+	strbuf_add(&fixed, img->buf.buf + current, imgoff);
 	strbuf_add(&fixed, preimage_eof, extra_chars);
 	fixed_buf = strbuf_detach(&fixed, &fixed_len);
 	update_pre_post_images(preimage, postimage,
-			       fixed_buf, fixed_len, postlen);
+			       fixed_buf, fixed_len);
 	return 1;
 }
 
@@ -2517,7 +2487,8 @@ static int match_fragment(struct apply_state *state,
 	int i;
 	const char *orig, *target;
 	struct strbuf fixed = STRBUF_INIT;
-	size_t postlen;
+	char *fixed_buf;
+	size_t fixed_len;
 	int preimage_limit;
 	int ret;
 
@@ -2573,9 +2544,9 @@ static int match_fragment(struct apply_state *state,
 		 * exactly.
 		 */
 		if ((match_end
-		     ? (current + preimage->len == img->len)
-		     : (current + preimage->len <= img->len)) &&
-		    !memcmp(img->buf + current, preimage->buf, preimage->len)) {
+		     ? (current + preimage->buf.len == img->buf.len)
+		     : (current + preimage->buf.len <= img->buf.len)) &&
+		    !memcmp(img->buf.buf + current, preimage->buf.buf, preimage->buf.len)) {
 			ret = 1;
 			goto out;
 		}
@@ -2589,7 +2560,7 @@ static int match_fragment(struct apply_state *state,
 		 */
 		const char *buf, *buf_end;
 
-		buf = preimage->buf;
+		buf = preimage->buf.buf;
 		buf_end = buf;
 		for (i = 0; i < preimage_limit; i++)
 			buf_end += preimage->line[i].len;
@@ -2634,21 +2605,14 @@ static int match_fragment(struct apply_state *state,
 	 * fixed.
 	 */
 
-	/* First count added lines in postimage */
-	postlen = 0;
-	for (i = 0; i < postimage->line_nr; i++) {
-		if (!(postimage->line[i].flag & LINE_COMMON))
-			postlen += postimage->line[i].len;
-	}
-
 	/*
 	 * The preimage may extend beyond the end of the file,
 	 * but in this loop we will only handle the part of the
 	 * preimage that falls within the file.
 	 */
-	strbuf_grow(&fixed, preimage->len + 1);
-	orig = preimage->buf;
-	target = img->buf + current;
+	strbuf_grow(&fixed, preimage->buf.len + 1);
+	orig = preimage->buf.buf;
+	target = img->buf.buf + current;
 	for (i = 0; i < preimage_limit; i++) {
 		size_t oldlen = preimage->line[i].len;
 		size_t tgtlen = img->line[current_lno + i].len;
@@ -2677,10 +2641,6 @@ static int match_fragment(struct apply_state *state,
 			 !memcmp(tgtfix.buf, fixed.buf + fixstart,
 					     fixed.len - fixstart));
 
-		/* Add the length if this is common with the postimage */
-		if (preimage->line[i].flag & LINE_COMMON)
-			postlen += tgtfix.len;
-
 		strbuf_release(&tgtfix);
 		if (!match) {
 			ret = 0;
@@ -2722,10 +2682,9 @@ static int match_fragment(struct apply_state *state,
 	 * has whitespace breakages unfixed, and fixing them makes the
 	 * hunk match.  Update the context lines in the postimage.
 	 */
-	if (postlen < postimage->len)
-		postlen = 0;
+	fixed_buf = strbuf_detach(&fixed, &fixed_len);
 	update_pre_post_images(preimage, postimage,
-			       fixed.buf, fixed.len, postlen);
+			       fixed_buf, fixed_len);
 
 	ret = 1;
 
@@ -2839,6 +2798,7 @@ static void update_image(struct apply_state *state,
 	 */
 	int i, nr;
 	size_t remove_count, insert_count, applied_at = 0;
+	size_t result_alloc;
 	char *result;
 	int preimage_limit;
 
@@ -2861,19 +2821,18 @@ static void update_image(struct apply_state *state,
 	remove_count = 0;
 	for (i = 0; i < preimage_limit; i++)
 		remove_count += img->line[applied_pos + i].len;
-	insert_count = postimage->len;
+	insert_count = postimage->buf.len;
 
 	/* Adjust the contents */
-	result = xmalloc(st_add3(st_sub(img->len, remove_count), insert_count, 1));
-	memcpy(result, img->buf, applied_at);
-	memcpy(result + applied_at, postimage->buf, postimage->len);
-	memcpy(result + applied_at + postimage->len,
-	       img->buf + (applied_at + remove_count),
-	       img->len - (applied_at + remove_count));
-	free(img->buf);
-	img->buf = result;
-	img->len += insert_count - remove_count;
-	result[img->len] = '\0';
+	result_alloc = st_add3(st_sub(img->buf.len, remove_count), insert_count, 1);
+	result = xmalloc(result_alloc);
+	memcpy(result, img->buf.buf, applied_at);
+	memcpy(result + applied_at, postimage->buf.buf, postimage->buf.len);
+	memcpy(result + applied_at + postimage->buf.len,
+	       img->buf.buf + (applied_at + remove_count),
+	       img->buf.len - (applied_at + remove_count));
+	strbuf_attach(&img->buf, result, postimage->buf.len + img->buf.len - remove_count,
+		      result_alloc);
 
 	/* Adjust the line table */
 	nr = img->line_nr + postimage->line_nr - preimage_limit;
@@ -3054,10 +3013,8 @@ static int apply_one_fragment(struct apply_state *state,
 	match_end = !state->unidiff_zero && !trailing;
 
 	pos = frag->newpos ? (frag->newpos - 1) : 0;
-	preimage.buf = oldlines;
-	preimage.len = old - oldlines;
-	postimage.buf = newlines.buf;
-	postimage.len = newlines.len;
+	strbuf_add(&preimage.buf, oldlines, old - oldlines);
+	strbuf_swap(&postimage.buf, &newlines);
 
 	for (;;) {
 
@@ -3145,8 +3102,8 @@ static int apply_one_fragment(struct apply_state *state,
 out:
 	free(oldlines);
 	strbuf_release(&newlines);
-	free(preimage.line);
-	free(postimage.line);
+	image_clear(&preimage);
+	image_clear(&postimage);
 
 	return (applied_pos < 0);
 }
@@ -3176,18 +3133,16 @@ static int apply_binary_fragment(struct apply_state *state,
 	}
 	switch (fragment->binary_patch_method) {
 	case BINARY_DELTA_DEFLATED:
-		dst = patch_delta(img->buf, img->len, fragment->patch,
+		dst = patch_delta(img->buf.buf, img->buf.len, fragment->patch,
 				  fragment->size, &len);
 		if (!dst)
 			return -1;
 		image_clear(img);
-		img->buf = dst;
-		img->len = len;
+		strbuf_attach(&img->buf, dst, len, len + 1);
 		return 0;
 	case BINARY_LITERAL_DEFLATED:
 		image_clear(img);
-		img->len = fragment->size;
-		img->buf = xmemdupz(fragment->patch, img->len);
+		strbuf_add(&img->buf, fragment->patch, fragment->size);
 		return 0;
 	}
 	return -1;
@@ -3223,8 +3178,8 @@ static int apply_binary(struct apply_state *state,
 		 * See if the old one matches what the patch
 		 * applies to.
 		 */
-		hash_object_file(the_hash_algo, img->buf, img->len, OBJ_BLOB,
-				 &oid);
+		hash_object_file(the_hash_algo, img->buf.buf, img->buf.len,
+				 OBJ_BLOB, &oid);
 		if (strcmp(oid_to_hex(&oid), patch->old_oid_prefix))
 			return error(_("the patch applies to '%s' (%s), "
 				       "which does not match the "
@@ -3233,7 +3188,7 @@ static int apply_binary(struct apply_state *state,
 	}
 	else {
 		/* Otherwise, the old one must be empty. */
-		if (img->len)
+		if (img->buf.len)
 			return error(_("the patch applies to an empty "
 				       "'%s' but it is not empty"), name);
 	}
@@ -3257,8 +3212,7 @@ static int apply_binary(struct apply_state *state,
 				       "'%s' cannot be read"),
 				     patch->new_oid_prefix, name);
 		image_clear(img);
-		img->buf = result;
-		img->len = size;
+		strbuf_attach(&img->buf, result, size, size + 1);
 	} else {
 		/*
 		 * We have verified buf matches the preimage;
@@ -3270,7 +3224,7 @@ static int apply_binary(struct apply_state *state,
 				     name);
 
 		/* verify that the result matches */
-		hash_object_file(the_hash_algo, img->buf, img->len, OBJ_BLOB,
+		hash_object_file(the_hash_algo, img->buf.buf, img->buf.len, OBJ_BLOB,
 				 &oid);
 		if (strcmp(oid_to_hex(&oid), patch->new_oid_prefix))
 			return error(_("binary patch to '%s' creates incorrect result (expecting %s, got %s)"),
@@ -3540,14 +3494,14 @@ static int resolve_to(struct image *image, const struct object_id *result_id)
 {
 	unsigned long size;
 	enum object_type type;
+	char *data;
 
 	image_clear(image);
 
-	image->buf = repo_read_object_file(the_repository, result_id, &type,
-					   &size);
-	if (!image->buf || type != OBJ_BLOB)
+	data = repo_read_object_file(the_repository, result_id, &type, &size);
+	if (!data || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(result_id));
-	image->len = size;
+	strbuf_attach(&image->buf, data, size, size + 1);
 
 	return 0;
 }
@@ -3589,8 +3543,7 @@ static int three_way_merge(struct apply_state *state,
 		return -1;
 	}
 	image_clear(image);
-	image->buf = result.ptr;
-	image->len = result.size;
+	strbuf_attach(&image->buf, result.ptr, result.size, result.size);
 
 	return status;
 }
@@ -3677,7 +3630,7 @@ static int try_threeway(struct apply_state *state,
 		return -1;
 	}
 	/* post_oid is theirs */
-	write_object_file(tmp_image.buf, tmp_image.len, OBJ_BLOB, &post_oid);
+	write_object_file(tmp_image.buf.buf, tmp_image.buf.len, OBJ_BLOB, &post_oid);
 	image_clear(&tmp_image);
 
 	/* our_oid is ours */
@@ -3690,7 +3643,7 @@ static int try_threeway(struct apply_state *state,
 			return error(_("cannot read the current contents of '%s'"),
 				     patch->old_name);
 	}
-	write_object_file(tmp_image.buf, tmp_image.len, OBJ_BLOB, &our_oid);
+	write_object_file(tmp_image.buf.buf, tmp_image.buf.len, OBJ_BLOB, &our_oid);
 	image_clear(&tmp_image);
 
 	/* in-core three-way merge between post and our using pre as base */
@@ -3743,8 +3696,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 			return -1;
 		}
 	}
-	patch->result = image.buf;
-	patch->resultsize = image.len;
+	patch->result = strbuf_detach(&image.buf, &patch->resultsize);
 	add_to_fn_table(state, patch);
 	free(image.line);
 
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 94671d3c46..4d9744e5fc 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -5,6 +5,7 @@
 
 test_description='tests to ensure compatibility between am and interactive backends'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t4107-apply-ignore-whitespace.sh b/t/t4107-apply-ignore-whitespace.sh
index ac72eeaf27..5e6e203aa5 100755
--- a/t/t4107-apply-ignore-whitespace.sh
+++ b/t/t4107-apply-ignore-whitespace.sh
@@ -3,9 +3,9 @@
 # Copyright (c) 2009 Giuseppe Bilotta
 #
 
-test_description='git-apply --ignore-whitespace.
+test_description='git-apply --ignore-whitespace.'
 
-'
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This primes main.c file that indents without using HT at all.
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 485c7d2d12..cdffee0273 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -2,6 +2,7 @@
 
 test_description='core.whitespace rules and git apply'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 prepare_test_file () {
diff --git a/t/t4125-apply-ws-fuzz.sh b/t/t4125-apply-ws-fuzz.sh
index 090987c89b..f248cc2a00 100755
--- a/t/t4125-apply-ws-fuzz.sh
+++ b/t/t4125-apply-ws-fuzz.sh
@@ -2,6 +2,7 @@
 
 test_description='applying patch that has broken whitespaces in context'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
index 8bbf8260fa..7981931b4e 100755
--- a/t/t4138-apply-ws-expansion.sh
+++ b/t/t4138-apply-ws-expansion.sh
@@ -5,6 +5,7 @@
 
 test_description='git apply test patches with whitespace expansion.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.46.0.551.gc5ee8f2d1c.dirty

