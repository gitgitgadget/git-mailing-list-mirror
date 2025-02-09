Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3387140E30
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739088830; cv=none; b=n51oxBwLBdpipIoyw7bOZCxqG5zjMXTBSEfYJt9+ixv0unEpWu/cgRbB7ThVP8u/G1ucxAsZMwqPAwkSDqrAGqjXNrxfcJkwU0kBd9Viq3TZPUkcEZ4JW036DJsw5ob0Ba2IMooFwuzqex6K8CPBJRrbPZnT3wL4UlTxUG4kDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739088830; c=relaxed/simple;
	bh=WXfvyp3Y4Idu9G7mzt+JtYJS0fnU7RyvD3pui1IemEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHJYia70U9gtUlsn8H/tEChrZkABY51S9dDZ9X1xKhyZf8WV/QTliv47nDmhcD4FM+GrBm+7hpazLkd1YTpHOglBIxazMFNQYc8MTiZCtGlku11LSFOOnDsuWftAQ7XRrFWrozZPELHy6I2YRlF88jVWZAWLWMKS5EoSQ05Eoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMdYy9cD; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMdYy9cD"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2fa345713a8so3384388a91.2
        for <git@vger.kernel.org>; Sun, 09 Feb 2025 00:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739088828; x=1739693628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8RQAuaZRQ5Mm3e+LwFomrAXkCycyaGq39vDIb/ueHI=;
        b=NMdYy9cDhNARBq49bq8b7BGCePUMw1DREZEjRRkFFwDe+d5s9AbeFXDJmO5zaiVrl9
         RJXK7UnUKO5DJ36HEkHpeNNwuszt1LIQbhkaRHkz7kJ76zxTv9100vMWG/g2MsH0aM7B
         2zGwdC5CCcPT33g3wnBFfWQRxOrRk6U3F5bElwW2uxgw6BAldlI1KyypsURtHcwtaNPI
         ldSAbxLBbBQtKpxbgt6+a/FdtFGI2gf19aODQl1o3hb72cQ6DuSJuSfl4WciAbqm2L3P
         FmhrnNfyLKKToOSXSdsF8C63FHogTKUBs5fBYRD78w59AiIqzBJf65KhQWH8ips4HcYL
         gCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739088828; x=1739693628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8RQAuaZRQ5Mm3e+LwFomrAXkCycyaGq39vDIb/ueHI=;
        b=UT1eOeyBwbdyg7E6ujlB10iAX4c3clWX/f+ZOG5OlLnInOPv/HUCwYzANa5mDrWQc4
         tnYWGBzb1g7suIl4UsJbbl/uzLBINiALmSiRhiCrGvOamd+xvsXKJoZx/64tderTPolq
         ZnKdyUl5A4L8Xbou2Pyzndr/jIgk1JY/e5t3xvrk+WpwzLnKRVxePW9hCD3VC0Ma2Jim
         YmlnVVipmiy9epLid/FSOBaOKFfH7vgstH0awWC656e7VP8oDf7Wa8IGRfZeUmKftybi
         L6QfDe+Mjc43kvsOGj1yVanvlMOBv+U9bsKLxl5hFMdopQf0qFs7CE7JbhU9aQBp0yMq
         keRA==
X-Gm-Message-State: AOJu0YwXrvn6UKIgOKJeWkoTZzOAh1GLJ+7b0SdDw8PYOanTO5hSxB2R
	kraWtfa8WpISYJsnwuYkUj4wqynD3zQrHEeOvIENyJGyLBIMd2Kp
X-Gm-Gg: ASbGncuub9y44o/CijLmOR3Ax3pIX7BYapat7Z/C5spsNuvdYpLWSPNz+YTRc30oVLe
	JIX9fV0J8jC9Jc5jeY+nhgWH3w3FeG+wn4pUaFHp8zIIgX9AE5hqaBOwv5sTvjRIafIoidJd8Rv
	dZAWGgAs4tb1Sl4pu1xp0G+sAiM24AOLjnPf7pItqSyXeDRenGysRT7Ep8+2Tcf9OUKWCPHYyVl
	SRGQa8GVOQhaJ9cpf1i2S1kenCUV/UcmKk/dnZiFjIRGzH3z1BiSGTp+wO3aVUfOybid/r2rvH5
	0THQxQP20rDe7JqMNjG7vsV7T4gw+dzYHeZj+LWiqlnsX4UmRYUUZQ==
X-Google-Smtp-Source: AGHT+IE4kgrUerKmXzKFHWryddI1DipvEb0nXpzj/s1y1R+ZR2OKmmwXrgStZ1DLtrwhstbXdBfzdw==
X-Received: by 2002:a05:6a00:2d05:b0:725:db34:6a8c with SMTP id d2e1a72fcca58-7305d481752mr15126814b3a.13.1739088827908;
        Sun, 09 Feb 2025 00:13:47 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. ([103.116.72.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730889e0c5fsm466308b3a.119.2025.02.09.00.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 00:13:47 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im
Subject: [GSOC][PATCH v2 5/6] apply: use `size_t` loop counters
Date: Sun,  9 Feb 2025 08:12:15 +0000
Message-ID: <20250209081216.241350-6-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209081216.241350-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250209081216.241350-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some `int` loop counters trigger -Wsign-comparison warnings.

Use `size_t` loop counters.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/apply.c b/apply.c
index 72464fb6c2..585f534732 100644
--- a/apply.c
+++ b/apply.c
@@ -1371,12 +1371,11 @@ int parse_git_diff_header(struct strbuf *root,
 			{ "index ", gitdiff_index },
 			{ "", gitdiff_unrecognized },
 		};
-		int i;
 
 		len = linelen(line, size);
 		if (!len || line[len-1] != '\n')
 			break;
-		for (i = 0; i < ARRAY_SIZE(optable); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(optable); i++) {
 			const struct opentry *p = optable + i;
 			int oplen = strlen(p->str);
 			int res;
@@ -2097,7 +2096,6 @@ static void add_name_limit(struct apply_state *state,
 static int use_patch(struct apply_state *state, struct patch *p)
 {
 	const char *pathname = p->new_name ? p->new_name : p->old_name;
-	int i;
 
 	/* Paths outside are not touched regardless of "--include" */
 	if (state->prefix && *state->prefix) {
@@ -2107,7 +2105,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	}
 
 	/* See if it matches any of exclude/include rule */
-	for (i = 0; i < state->limit_by_name.nr; i++) {
+	for (size_t i = 0; i < state->limit_by_name.nr; i++) {
 		struct string_list_item *it = &state->limit_by_name.items[i];
 		if (!wildmatch(it->string, pathname, 0))
 			return (it->util != NULL);
@@ -2183,8 +2181,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				"Files ",
 				NULL,
 			};
-			int i;
-			for (i = 0; binhdr[i]; i++) {
+			for (size_t i = 0; binhdr[i]; i++) {
 				size_t len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
@@ -2320,7 +2317,7 @@ static void update_pre_post_images(struct image *preimage,
 {
 	struct image fixed_preimage = IMAGE_INIT;
 	size_t insert_pos = 0;
-	int i, reduced;
+	int reduced;
 	size_t ctx;
 	const char *fixed;
 
@@ -2330,7 +2327,7 @@ static void update_pre_post_images(struct image *preimage,
 	 * free "oldlines".
 	 */
 	image_prepare(&fixed_preimage, buf, len, 1);
-	for (i = 0; i < fixed_preimage.line_nr; i++)
+	for (size_t i = 0; i < fixed_preimage.line_nr; i++)
 		fixed_preimage.line[i].flag = preimage->line[i].flag;
 	image_clear(preimage);
 	*preimage = fixed_preimage;
@@ -2339,7 +2336,7 @@ static void update_pre_post_images(struct image *preimage,
 	/*
 	 * Adjust the common context lines in postimage.
 	 */
-	for (i = reduced = ctx = 0; i < postimage->line_nr; i++) {
+	for (size_t i = reduced = ctx = 0; i < postimage->line_nr; i++) {
 		size_t l_len = postimage->line[i].len;
 
 		if (!(postimage->line[i].flag & LINE_COMMON)) {
@@ -2419,9 +2416,9 @@ static int line_by_line_fuzzy_match(struct image *img,
 				    struct image *postimage,
 				    unsigned long current,
 				    int current_lno,
-				    int preimage_limit)
+				    size_t preimage_limit)
 {
-	int i;
+	size_t i;
 	size_t imgoff = 0;
 	size_t preoff = 0;
 	size_t extra_chars;
@@ -2488,7 +2485,7 @@ static int match_fragment(struct apply_state *state,
 			  unsigned ws_rule,
 			  int match_beginning, int match_end)
 {
-	int i;
+	size_t i;
 	const char *orig, *target;
 	struct strbuf fixed = STRBUF_INIT;
 	char *fixed_buf;
@@ -2665,12 +2662,11 @@ static int match_fragment(struct apply_state *state,
 	for ( ; i < preimage->line_nr; i++) {
 		size_t fixstart = fixed.len; /* start of the fixed preimage */
 		size_t oldlen = preimage->line[i].len;
-		int j;
 
 		/* Try fixing the line in the preimage */
 		ws_fix_copy(&fixed, orig, oldlen, ws_rule, NULL);
 
-		for (j = fixstart; j < fixed.len; j++) {
+		for (size_t j = fixstart; j < fixed.len; j++) {
 			if (!isspace(fixed.buf[j])) {
 				ret = 0;
 				goto out;
@@ -2800,7 +2796,7 @@ static void update_image(struct apply_state *state,
 	 * remove the copy of preimage at offset in img
 	 * and replace it with postimage
 	 */
-	int i, nr;
+	int nr;
 	size_t remove_count, insert_count, applied_at = 0;
 	size_t result_alloc;
 	char *result;
@@ -2819,11 +2815,11 @@ static void update_image(struct apply_state *state,
 	if (preimage_limit > img->line_nr - applied_pos)
 		preimage_limit = img->line_nr - applied_pos;
 
-	for (i = 0; i < applied_pos; i++)
+	for (size_t i = 0; i < applied_pos; i++)
 		applied_at += img->line[i].len;
 
 	remove_count = 0;
-	for (i = 0; i < preimage_limit; i++)
+	for (size_t i = 0; i < preimage_limit; i++)
 		remove_count += img->line[applied_pos + i].len;
 	insert_count = postimage->buf.len;
 
@@ -2852,7 +2848,7 @@ static void update_image(struct apply_state *state,
 			   img->line_nr - (applied_pos + preimage_limit));
 	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->line_nr);
 	if (!state->allow_overlap)
-		for (i = 0; i < postimage->line_nr; i++)
+		for (size_t i = 0; i < postimage->line_nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
 	img->line_nr = nr;
 }
-- 
2.43.0

