Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F716BE39
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567690; cv=none; b=N0ZQZrcZYlKvljGXuBHo7i6uUtDlc5W/y3XyVSx7aY0AWUUmFCBUtPeO/QTk5PTlneKIO1zmTFCi7JbL5Y6APGe0CFIRoxMkpNoaR+7kndpKr5EU19sX39R9oNyeMsHDJxWb3Z3IaULivhZ3SCWZnHDPtze7o3BQMKf0HnAnqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567690; c=relaxed/simple;
	bh=zl3qEpUGp2dofe8n3ud9QfDp9m2I02BK2cajY626yv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yci9u9ny7xWHgR89472v3Y7wq2MLlECDK8cQ7k6e4u8n1uPziXKWwHAoFCxZFgnXWKeuzwgfixEYytwlmmAqBl72GfAuyM5/8Oy5P4rrhs0Cj5x8Fe+8JlRrYBxv82d44QOn8V9nRPPJgR2kNwQy9sQt7BcsOSUZtMQrMfxbPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AyF4qSsQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFjlceTC; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AyF4qSsQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFjlceTC"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59A7B1140334;
	Tue, 17 Sep 2024 06:08:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 17 Sep 2024 06:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726567687; x=1726654087; bh=cjd08d0pc9
	RfIS0OMdFTEYqTdJr9RSmzVUcZ0Ji41xQ=; b=AyF4qSsQoPa1FVjRbNUL2F3m6t
	kepz9nTtLkHnOOTcFS1TKfwkJ9UVNIpKE3ToOqKkFmQPCMI8tfcluRJv7dsUQejF
	4ZLjuwfUU9tmopugkD34sfuRXI9GYcbBcxUOL3K4+070bKAGEoiPnk0KxSJLJbpI
	Py0iCEGcJ0fZUnx3+/tPbtAToZ7O7O2Sv42wfSdccVMSs1TUkSzj4vbcp79hRRpZ
	HHVNls/g6nbNGtb7NOpNZr+Qihf/DKvXodkyUQI9JLcHHqY4bUWHivp5yice5/ZJ
	vqpTEKs5dXDo2CHvHqQykuDNtYjaIZmYtoXvKBJScNsWLB8evILwtDXw9WpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726567687; x=1726654087; bh=cjd08d0pc9RfIS0OMdFTEYqTdJr9
	RSmzVUcZ0Ji41xQ=; b=TFjlceTC4guqJwqf5xpDnatp7b7lKkgPHLh7vZW+lLzx
	IAsVB0x1gBOP1Fsc5fxk3skNHsiMca/MsbDIn0LxzqGTb15w/NtU23r+3JpAb1o0
	E+auALgf5yprUN/dw1fPzXMXDxl60rfDR+LKnqmrJ6TyItvIbb4R+8v1Mr83A1Hw
	vQVo8Hp/+842ax0LAMMyk67knw420EumIBxKG6GlzH0B2n5Fax7+6VvRedK6FA+8
	TX0Kzv+wVUmlyjvGwLYT1v61C2ao0I6WTJUv9J+FDkRMgp6NSQNxN0SUumO4CeHd
	YSWiyaiATQxisL/VkjBfv6mr+wa4sfnylwU36pSk+Q==
X-ME-Sender: <xms:B1XpZmHmaVdG5wyEAYrPqExIkuG7EaS08oBak6oouZg2jxMKHULJ5w>
    <xme:B1XpZnVZdCR4YB2-nH-BxRAolOm5ku5ekarfyyP7amWfKuxh7d1HQzHY3TRMGlcSs
    jMkd-uRl4CoBebdaA>
X-ME-Received: <xmr:B1XpZgKNJfP6ZB7TDhr0A7r5l1qHWsNhD6BnV7d9rG2YOs8Nx-7-0Mp4_Ch2fBapRb3AU2PPEE-bGafNi6nAiOJR_ks5WEfsBQklMEQ-MBls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:B1XpZgFCaEJ3KCCjAKf7772vvVAS8QIMd6rgekRN-0r9GoQA5PFCqA>
    <xmx:B1XpZsXE4ORzi8w4zSFVfit2GKcqJJIM1KaDdSfRohYEkWpWPCp9BQ>
    <xmx:B1XpZjNi_yAq2rcm5duyWgkiXsBXKVXYSIbuwgcGgA0inYMNzG6lAg>
    <xmx:B1XpZj0zmLLt8Q1E5ZivWX-GA9yc6ckkiNcAvJvVHP0ywc9VWif0Sg>
    <xmx:B1XpZpjFc6PMgJPmC_RsbmsoKcbhjyfmPfcZQZGbSpAG4Q5pp0jJ67NP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 06:08:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 356ee540 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 10:07:47 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:08:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 5/6] apply: rename members that track line count and
 allocation length
Message-ID: <5497708428c5cf6c35c3ea8e17110ce01ec19845.1726567217.git.ps@pks.im>
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

