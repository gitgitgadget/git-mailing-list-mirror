Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86612C54B
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470620; cv=none; b=ESGAP8ig3tIHpmkic5oF/CNNdufQOqD6BwDNF1AHjwdBrVbbA+EnijlPWhMqtNm7mHXmJboOU7Iapo+OuuzN0b/TMWDhdal7BEVIpUyZZWR5Gq9PyETeDcQ63adMMDqqJL8oMLsu2U4O48Wlw/dxPgDIGht+zMqdOTStDiwFtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470620; c=relaxed/simple;
	bh=nNIpBducBdRLDoDLY7yTgVcp+HNRWVTC91UuWs/axFw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM6MBG+/xYXpo2d9bXxZLIF3rPiPFYwfl0e0vRX0Fm+e81bq7aM1Z3cKohmWhXUn1td4yuXy6jrkjqg7oFTGiSWHFt637RRIXki+r2gz1gVUi55P9TGLz0LpZOlY6o+YIFFZd+F6UduvlecAMrJKZvvkh1eyRN/qu6rLyAfGSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=luC6EXS0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PSiEQ46B; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="luC6EXS0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PSiEQ46B"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id AAF26138029A
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 16 Sep 2024 03:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726470617; x=1726557017; bh=Et13r6Q9iu
	B9YvdefAksZ0GvXKvO3Oa2bTwxoGWREJU=; b=luC6EXS0x1lgdbVKX/rjNcBSYf
	1lJxMsKNY76XbAmfSHZVlDhQ3ypmO3sxhn5E95JF0AVZfnSbSq9b6vWBvOlkufWj
	sFEIQ4AWXmcGZq5eTUZkuWSyJv+EvgUfdG7sHKaPePenAml56R7JGyWLVKnF8VDx
	ny03BPVi6iyOb7abvnntpZ6mgElo3JoIFNvHrrK42/Z4lI597k4pN3tYEsCPNn37
	3/7b8kXBfitHz7x/PHKlfJmmzm2LfZtQLdhfljtgg0JLih3dUx56s0LbpYaAcBXB
	9yNhrhqyQgBt2dib9jLZq64dTNL1sXyEqt8QGvA0zdLrIzMU7Zyvppho4cew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726470617; x=1726557017; bh=Et13r6Q9iuB9YvdefAksZ0GvXKvO
	3Oa2bTwxoGWREJU=; b=PSiEQ46B+Wt1upaCN8CgOYL4tdd1oWedQKNRZ/rVqOVV
	l2rOnQSOEwcwhzIGr+MGYHDkJNBf82ebVinz1g3G/Ic3CnPN0w9ErqMfA19XklME
	UeoJHcuf+SVbcu4HXdCUqStrCfUVJrDSDVfj7wOt/P1coyOvO45bIqYLAoNtFSru
	/UbC8o9CCXa32J5HA1UJYbnFDymc4vxKBhoJA5DT4EUrR+8LtALhg9DgHxrM/f8L
	NK9dzp5uCCOL+3yUWucR1r6niFU8FBNwgoR2raz3ChnAK/Kehob0cMSmAE6FXZvh
	FqhoNtqGSTcS8eA8nVlwIAAS2tOjIEf9+qDxfkZeZw==
X-ME-Sender: <xms:2dnnZhJvJjmOjsYn2qd9WoiCtQAM4D0YpeAFsxorNB2FCQ35rkAKiw>
    <xme:2dnnZtKStSVQr_wlWN0dx0VWB60Br8Pcx4V8dwLjOWQQtTmfF1FR8Y43MTlNSvTsS
    JQzGk8i3gkIQCTO3A>
X-ME-Received: <xmr:2dnnZpuHMJ2NN6nRq9-P3_VHE4gUQB4EyYcj5gmB1erJ-Me8mvO4pWY4QBLVf0vcqJ4AlqPDs74fO0cRMyq4vU-xL84ZJ2ixbAiGB64IxZGz3ewi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2dnnZiZrRjktXYu8Z6OpdnCckOiI_NBvEWwUR1lV-x_KdN9Dke8W4Q>
    <xmx:2dnnZoaHi57zOk2Hs6T5_ysrSVnL97NX5UpEFH9S85jEMTXLaJ_NaQ>
    <xmx:2dnnZmC0mYGD5dKO7kqLWmNUppgBeqzBMRkqtomUgsJ8lwjrMGWjvQ>
    <xmx:2dnnZmaenUHV1uZnDTr9llvIMDLgF0D_sqBcZ8HG49Ev67HgFqhnLw>
    <xmx:2dnnZjx1dVD713G61edBNzAcBh9gqW6BTh4NuKusXoBenX6xsVvCAsiE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 942b121d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 07:10:00 +0000 (UTC)
Date: Mon, 16 Sep 2024 09:10:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/6] apply: refactor `struct image` to use a `struct strbuf`
Message-ID: <6cf45daf84af68f74d87a5b2ae7102d4cd8ceb57.1726470385.git.ps@pks.im>
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
 apply.c                            | 192 +++++++++++------------------
 t/t3436-rebase-more-options.sh     |   1 +
 t/t4107-apply-ignore-whitespace.sh |   4 +-
 t/t4124-apply-ws-rule.sh           |   1 +
 t/t4125-apply-ws-fuzz.sh           |   1 +
 t/t4138-apply-ws-expansion.sh      |   1 +
 6 files changed, 77 insertions(+), 123 deletions(-)

diff --git a/apply.c b/apply.c
index 3340bb1fc0..d283dd4f5e 100644
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
@@ -359,7 +358,7 @@ static void image_remove_first_line(struct image *img)
 
 static void image_remove_last_line(struct image *img)
 {
-	img->len -= img->line[--img->line_nr].len;
+	strbuf_setlen(&img->buf, img->buf.len - img->line[--img->line_nr].len);
 }
 
 /* fmt must contain _one_ %s and no other substitution */
@@ -2308,19 +2307,16 @@ static int read_old_data(struct stat *st, struct patch *patch,
 
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
@@ -2328,43 +2324,24 @@ static void update_pre_post_images(struct image *preimage,
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
@@ -2383,21 +2360,15 @@ static void update_pre_post_images(struct image *preimage,
 
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
 
@@ -2447,7 +2418,6 @@ static int line_by_line_fuzzy_match(struct image *img,
 	int i;
 	size_t imgoff = 0;
 	size_t preoff = 0;
-	size_t postlen = postimage->len;
 	size_t extra_chars;
 	char *buf;
 	char *preimage_eof;
@@ -2460,11 +2430,9 @@ static int line_by_line_fuzzy_match(struct image *img,
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
@@ -2480,10 +2448,10 @@ static int line_by_line_fuzzy_match(struct image *img,
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
@@ -2497,11 +2465,11 @@ static int line_by_line_fuzzy_match(struct image *img,
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
 
@@ -2517,7 +2485,8 @@ static int match_fragment(struct apply_state *state,
 	int i;
 	const char *orig, *target;
 	struct strbuf fixed = STRBUF_INIT;
-	size_t postlen;
+	char *fixed_buf;
+	size_t fixed_len;
 	int preimage_limit;
 	int ret;
 
@@ -2573,9 +2542,9 @@ static int match_fragment(struct apply_state *state,
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
@@ -2589,7 +2558,7 @@ static int match_fragment(struct apply_state *state,
 		 */
 		const char *buf, *buf_end;
 
-		buf = preimage->buf;
+		buf = preimage->buf.buf;
 		buf_end = buf;
 		for (i = 0; i < preimage_limit; i++)
 			buf_end += preimage->line[i].len;
@@ -2634,21 +2603,14 @@ static int match_fragment(struct apply_state *state,
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
@@ -2677,10 +2639,6 @@ static int match_fragment(struct apply_state *state,
 			 !memcmp(tgtfix.buf, fixed.buf + fixstart,
 					     fixed.len - fixstart));
 
-		/* Add the length if this is common with the postimage */
-		if (preimage->line[i].flag & LINE_COMMON)
-			postlen += tgtfix.len;
-
 		strbuf_release(&tgtfix);
 		if (!match) {
 			ret = 0;
@@ -2722,10 +2680,9 @@ static int match_fragment(struct apply_state *state,
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
 
@@ -2839,6 +2796,7 @@ static void update_image(struct apply_state *state,
 	 */
 	int i, nr;
 	size_t remove_count, insert_count, applied_at = 0;
+	size_t result_alloc;
 	char *result;
 	int preimage_limit;
 
@@ -2861,19 +2819,18 @@ static void update_image(struct apply_state *state,
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
@@ -3054,10 +3011,8 @@ static int apply_one_fragment(struct apply_state *state,
 	match_end = !state->unidiff_zero && !trailing;
 
 	pos = frag->newpos ? (frag->newpos - 1) : 0;
-	preimage.buf = oldlines;
-	preimage.len = old - oldlines;
-	postimage.buf = newlines.buf;
-	postimage.len = newlines.len;
+	strbuf_add(&preimage.buf, oldlines, old - oldlines);
+	strbuf_swap(&postimage.buf, &newlines);
 
 	for (;;) {
 
@@ -3145,8 +3100,8 @@ static int apply_one_fragment(struct apply_state *state,
 out:
 	free(oldlines);
 	strbuf_release(&newlines);
-	free(preimage.line);
-	free(postimage.line);
+	image_clear(&preimage);
+	image_clear(&postimage);
 
 	return (applied_pos < 0);
 }
@@ -3176,18 +3131,16 @@ static int apply_binary_fragment(struct apply_state *state,
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
@@ -3223,8 +3176,8 @@ static int apply_binary(struct apply_state *state,
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
@@ -3233,7 +3186,7 @@ static int apply_binary(struct apply_state *state,
 	}
 	else {
 		/* Otherwise, the old one must be empty. */
-		if (img->len)
+		if (img->buf.len)
 			return error(_("the patch applies to an empty "
 				       "'%s' but it is not empty"), name);
 	}
@@ -3257,8 +3210,7 @@ static int apply_binary(struct apply_state *state,
 				       "'%s' cannot be read"),
 				     patch->new_oid_prefix, name);
 		image_clear(img);
-		img->buf = result;
-		img->len = size;
+		strbuf_attach(&img->buf, result, size, size + 1);
 	} else {
 		/*
 		 * We have verified buf matches the preimage;
@@ -3270,7 +3222,7 @@ static int apply_binary(struct apply_state *state,
 				     name);
 
 		/* verify that the result matches */
-		hash_object_file(the_hash_algo, img->buf, img->len, OBJ_BLOB,
+		hash_object_file(the_hash_algo, img->buf.buf, img->buf.len, OBJ_BLOB,
 				 &oid);
 		if (strcmp(oid_to_hex(&oid), patch->new_oid_prefix))
 			return error(_("binary patch to '%s' creates incorrect result (expecting %s, got %s)"),
@@ -3540,14 +3492,14 @@ static int resolve_to(struct image *image, const struct object_id *result_id)
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
@@ -3589,8 +3541,7 @@ static int three_way_merge(struct apply_state *state,
 		return -1;
 	}
 	image_clear(image);
-	image->buf = result.ptr;
-	image->len = result.size;
+	strbuf_attach(&image->buf, result.ptr, result.size, result.size);
 
 	return status;
 }
@@ -3677,7 +3628,7 @@ static int try_threeway(struct apply_state *state,
 		return -1;
 	}
 	/* post_oid is theirs */
-	write_object_file(tmp_image.buf, tmp_image.len, OBJ_BLOB, &post_oid);
+	write_object_file(tmp_image.buf.buf, tmp_image.buf.len, OBJ_BLOB, &post_oid);
 	image_clear(&tmp_image);
 
 	/* our_oid is ours */
@@ -3690,7 +3641,7 @@ static int try_threeway(struct apply_state *state,
 			return error(_("cannot read the current contents of '%s'"),
 				     patch->old_name);
 	}
-	write_object_file(tmp_image.buf, tmp_image.len, OBJ_BLOB, &our_oid);
+	write_object_file(tmp_image.buf.buf, tmp_image.buf.len, OBJ_BLOB, &our_oid);
 	image_clear(&tmp_image);
 
 	/* in-core three-way merge between post and our using pre as base */
@@ -3743,8 +3694,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
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

