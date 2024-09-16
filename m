Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472AD4F5FB
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470606; cv=none; b=SQ/RJ1VAiSohNQgJ9FVhTHTLIjUlkw8sTxhu1lGdU924O3JxcpBEd9WGtWldePSL7boy/BlyuBtA3XPfxdAuEhyIsLL/DrTbgijmVsRjMYzdgMZljrZkCLoErYS0oE3A9+++MlT3ZaWIiUGVCJ3RjDskJUTca9wUhg1GFWisZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470606; c=relaxed/simple;
	bh=gNdUOeS2b0oRdduoo2Vf04A4OhOAdHW7pIv5H+Sf/UE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMtai8oSI1SXkzANWueKRQeBJ6bh6q1Q3mjV4vGJ/+7hcK6VwEFIi9dY7frXEGg2QEFfwrDv162isnqoFF5B01/HC+O8TrhxQXKktUe7v7iwg9KYY0wy8hh/ZRSE5T07ZstHxYitsl+m9Q8JyEQAf0BRXrd/ni2/S3JDs66CmgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qp/ulIkV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uKC5se6a; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qp/ulIkV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uKC5se6a"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 594FD1380270
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 16 Sep 2024 03:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726470603; x=1726557003; bh=706Lz9rQKP
	uZ22EjS/DRTI8AmNCB8am0tgozCErRhIA=; b=qp/ulIkVGiQ17jpS7Cwk9tzEhl
	b5fQUeGZybwlFoy9yj2sDrO4i5CTknkSavmLZgfBcLLz64K/A865LxX8x2YM0JqO
	ck+yLXti+pm2DU6m4iCNeNZEVlEYcV26SgDLh8DjRvreJEKe2ABcFgoKSSV1xe+N
	ldOzQpLyfPuF7Ji/LsRDDtkSuNvP42oM9EnI7lDrhqgbcLXV8kGp7FY6GpqmPBP4
	hOv0gzqfLzDKhEW6pRbZ77/mXAIkxgPlRRlhn44iP7VfM7lCybnj2b3MK5brqw5m
	yHOQ9U2Xq6YpEBOm3mWSkFhC0ZZJPc5Xka7rrD+B5zw117kyRDoSGheYlbkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726470603; x=1726557003; bh=706Lz9rQKPuZ22EjS/DRTI8AmNCB
	8am0tgozCErRhIA=; b=uKC5se6aQdqgVfNyNSSK7bLC995KlEUYD/mIww9RMqYm
	PiUdxoVVDm+bsvjYoBU/87gbLto0qXwrea901+1cyUUt5NXIffOk9Pb6r54STfH+
	20qYhg1q6/a4XvlA8TtMExqSoanFwOeAg/woLimkxbFZ38HQalzA8KKuHTp0uBw1
	5fVmO2JbD0lndl0n2UQt1uJMewRPJrB9dFrBghpi+CpbDo8VjjK3Zh1+65kbghn7
	1JAQfMX1QC5bw40w/DC+8z9PsrabHcr6akPlP3kE5pGQ9CN2XqIjTXkLmjYmPOTf
	WL4i2qI843AubpwHmKboxhP+EqfUM0vfWFBE9VthQw==
X-ME-Sender: <xms:y9nnZvr9LWAm_K61omeny8KevQSkk-iJmabP8S0EDs4-0WLTltYxSA>
    <xme:y9nnZprbMXwMhW2IeEnAaMNXjANLOdaYpDSp0RqNcOkMF8o2amN3S8Qgb2wVGqy_A
    _H5EoSEEJ5yKnwVAQ>
X-ME-Received: <xmr:y9nnZsM036Ejw4t4Zqj4LIOMHdYEHb_WZspUDzx-jB6RhOMEAluh-q3gaJL2fMMsFytz20KTuoAcaeXXrhy5ePT2A9OjpyB6LpvFimkjkVm-1Wxn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:y9nnZi4VGHh9j7XCQXnFoKi5Oj1QfQublKkwKDmrxspxlC2kFyy9ag>
    <xmx:y9nnZu4c9GsFiIkxOLSVrJp7n0S6EmklTBePxh5n3x814GysXr91ug>
    <xmx:y9nnZqjBPNmx3Rw8zWGNruFXZRHzyeGc--rgDbcdOsf2FMgoKxZKEA>
    <xmx:y9nnZg72WL7XbtR9j9QaGUc-nmwRbfGIas8WsRnVAj5dehTCPa4Xmg>
    <xmx:y9nnZkRYPy1uodEh5zETt88OTzLRg6xHArI5xWVP1Xu7ZUKUBxHg1DZV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12fbbad5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 07:09:45 +0000 (UTC)
Date: Mon, 16 Sep 2024 09:10:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/6] apply: reorder functions to move image-related things
 together
Message-ID: <7b6903ecdd471b9bc0dbf2d64847d4db492b4f25.1726470385.git.ps@pks.im>
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

While most of the functions relating to `struct image` are relatively
close to one another, `fuzzy_matchlines()` sits in between those even
though it is rather unrelated.

Reorder functions such that `struct image`-related functions are next to
each other. While at it, move `clear_image()` to the top such that it is
close to the struct definition itself. This makes this lifecycle-related
thing easy to discover.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c | 106 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/apply.c b/apply.c
index 6e1060a952..9dd2f4d215 100644
--- a/apply.c
+++ b/apply.c
@@ -285,6 +285,13 @@ struct image {
 	struct line *line;
 };
 
+static void clear_image(struct image *image)
+{
+	free(image->buf);
+	free(image->line_allocated);
+	memset(image, 0, sizeof(*image));
+}
+
 static uint32_t hash_line(const char *cp, size_t len)
 {
 	size_t i;
@@ -297,42 +304,6 @@ static uint32_t hash_line(const char *cp, size_t len)
 	return h;
 }
 
-/*
- * Compare lines s1 of length n1 and s2 of length n2, ignoring
- * whitespace difference. Returns 1 if they match, 0 otherwise
- */
-static int fuzzy_matchlines(const char *s1, size_t n1,
-			    const char *s2, size_t n2)
-{
-	const char *end1 = s1 + n1;
-	const char *end2 = s2 + n2;
-
-	/* ignore line endings */
-	while (s1 < end1 && (end1[-1] == '\r' || end1[-1] == '\n'))
-		end1--;
-	while (s2 < end2 && (end2[-1] == '\r' || end2[-1] == '\n'))
-		end2--;
-
-	while (s1 < end1 && s2 < end2) {
-		if (isspace(*s1)) {
-			/*
-			 * Skip whitespace. We check on both buffers
-			 * because we don't want "a b" to match "ab".
-			 */
-			if (!isspace(*s2))
-				return 0;
-			while (s1 < end1 && isspace(*s1))
-				s1++;
-			while (s2 < end2 && isspace(*s2))
-				s2++;
-		} else if (*s1++ != *s2++)
-			return 0;
-	}
-
-	/* If we reached the end on one side only, lines don't match. */
-	return s1 == end1 && s2 == end2;
-}
-
 static void add_line_info(struct image *img, const char *bol, size_t len, unsigned flag)
 {
 	ALLOC_GROW(img->line_allocated, img->nr + 1, img->alloc);
@@ -373,11 +344,17 @@ static void prepare_image(struct image *image, char *buf, size_t len,
 	image->line = image->line_allocated;
 }
 
-static void clear_image(struct image *image)
+static void remove_first_line(struct image *img)
 {
-	free(image->buf);
-	free(image->line_allocated);
-	memset(image, 0, sizeof(*image));
+	img->buf += img->line[0].len;
+	img->len -= img->line[0].len;
+	img->line++;
+	img->nr--;
+}
+
+static void remove_last_line(struct image *img)
+{
+	img->len -= img->line[--img->nr].len;
 }
 
 /* fmt must contain _one_ %s and no other substitution */
@@ -2419,6 +2396,42 @@ static void update_pre_post_images(struct image *preimage,
 	postimage->nr -= reduced;
 }
 
+/*
+ * Compare lines s1 of length n1 and s2 of length n2, ignoring
+ * whitespace difference. Returns 1 if they match, 0 otherwise
+ */
+static int fuzzy_matchlines(const char *s1, size_t n1,
+			    const char *s2, size_t n2)
+{
+	const char *end1 = s1 + n1;
+	const char *end2 = s2 + n2;
+
+	/* ignore line endings */
+	while (s1 < end1 && (end1[-1] == '\r' || end1[-1] == '\n'))
+		end1--;
+	while (s2 < end2 && (end2[-1] == '\r' || end2[-1] == '\n'))
+		end2--;
+
+	while (s1 < end1 && s2 < end2) {
+		if (isspace(*s1)) {
+			/*
+			 * Skip whitespace. We check on both buffers
+			 * because we don't want "a b" to match "ab".
+			 */
+			if (!isspace(*s2))
+				return 0;
+			while (s1 < end1 && isspace(*s1))
+				s1++;
+			while (s2 < end2 && isspace(*s2))
+				s2++;
+		} else if (*s1++ != *s2++)
+			return 0;
+	}
+
+	/* If we reached the end on one side only, lines don't match. */
+	return s1 == end1 && s2 == end2;
+}
+
 static int line_by_line_fuzzy_match(struct image *img,
 				    struct image *preimage,
 				    struct image *postimage,
@@ -2804,19 +2817,6 @@ static int find_pos(struct apply_state *state,
 	return -1;
 }
 
-static void remove_first_line(struct image *img)
-{
-	img->buf += img->line[0].len;
-	img->len -= img->line[0].len;
-	img->line++;
-	img->nr--;
-}
-
-static void remove_last_line(struct image *img)
-{
-	img->len -= img->line[--img->nr].len;
-}
-
 /*
  * The change from "preimage" and "postimage" has been found to
  * apply at applied_pos (counts in line numbers) in "img".
-- 
2.46.0.551.gc5ee8f2d1c.dirty

