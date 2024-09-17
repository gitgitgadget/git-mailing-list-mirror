Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2616B75B
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567687; cv=none; b=IYbkLd+5BWoETXbTIFzj2PtPnR4OI9ZRhyDzjqubh3l87srZ8ixFYsNpLOEhrAZaCTXi9I938wjrzvPviy3jYlfz0BGnsQ8OpPYaNvMtavyyoQEAilyH56PzCT+lUmgaVSP2B7e90OaDhXf85Aceh7HcMOGD9lWLvgkBKxefqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567687; c=relaxed/simple;
	bh=Qqa0MDb2I/odSJVNaVgAiM7gDE+3Hs7eTIjNTW2hOXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClBVlytrvxPk+q7fvDIgEY0HZRCP+fpaM+FrSFAO7TodSLQbCSRkWI6X5BNF26mx/ZKzRTmc3QDjGhnz76yoCeWDrROgBU4Mk3WP1DsvaVwbOwqgHAqYP8VRg8IDVhSaeGg9rWXi/0nOt/6QYd1llWo5m8fR4eejIz0npfq4P9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=deXUgY5b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SlbzyL4X; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="deXUgY5b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SlbzyL4X"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55B0511403CD;
	Tue, 17 Sep 2024 06:08:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 17 Sep 2024 06:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726567685; x=1726654085; bh=daZxwuLsBN
	dL7vgsTytZZz5Tjf3oMLdZ+0zRrYeS66Y=; b=deXUgY5b4K8TBw+Kqxf4mqlT3u
	IUWrf33mN3zPyb1PY5aV744EjNa0/F5f3VZG1Uv5IvwHS8e8wqlc4HnKimJ9Br0M
	RsIyhgdHKt7x0D8BQ/8g9r7OHPeHJ9W9ainnc6Oo3GKJKgFdDsjfGgUt+JWP+nqW
	+rHgQbt3mHEbQMxxfALZf0pcMj+7FEbaCo/XeXJKfyrj9oe/8AAh4M31motynogN
	t0MG5DZmgV81V6JN0X3CFzlf7XnJlwHnPsATlRZKboxSxC6IC3t7BPA4/M6RS+8i
	n4OiEnKaf0hlozvM6sphw6tZ0Ajp8lqoaij2bNXlvIAHteLU/+I+P+w8sY3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726567685; x=1726654085; bh=daZxwuLsBNdL7vgsTytZZz5Tjf3o
	MLdZ+0zRrYeS66Y=; b=SlbzyL4XbHJQ958yZ+XGwTQaVZXv4RysXw385VBv+OeX
	uxWGuP3V/eVYtBu5una6zHtgGzkbNY2aX7ybjrYzPdfgzhh+jWL7fy3Lel/g+ubM
	Df6iL3XPAY3IBtkc6/ausu/COZz3mBahhaJec+6fd2mSgOtiNC7QK3S8upcQfSg7
	/+t0EV8UxQY+l6ZdNn1Xn71Q/RvLsjYfX+WF3y9RMY9lkSZ8C0JAzt6Zc6AWMnwp
	iodn5aCRn7o0+OrJasntz+8cJA/2wOP+LXTYwOwvPNNMVeu2gTYcozu8bon1O8d8
	HJHVAHHjFfByvr1AjcERbEfEEkVmKSDVdnvvw/TK0g==
X-ME-Sender: <xms:BVXpZiBzQRuIMi_znA-rEZbB8GBjnQsALqGZiJEPdtWQkEKF-mcNoA>
    <xme:BVXpZsjgwpFZgO8AdWdiGiZ8WP4GA1FJSHzxdQr3I3wdQfvIOtxewa9ITfiU8rwxL
    TIEFYdr5pCIr9Pt4g>
X-ME-Received: <xmr:BVXpZlm9rcUgjpWOGyuAYy_QgeVGbJBHQaWq6_fQ9FRxITTvMYHxWNh6Kynqyr8WYRl-fvWJ1roHFtD6j57UhKPYoBrcEerMbCoJfXeKC29r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homh
X-ME-Proxy: <xmx:BVXpZgwBB0R8iwlhAybn0BXM-amJlRQEnsnwuExH2e--h8ASOLkwtg>
    <xmx:BVXpZnT-P93OBf8md9r570r6nJb9QeTIZIBUYJNBnVRtcR3SyiGbdA>
    <xmx:BVXpZrYrsl4UrsG5vX23-cd0B_P9-fMnMImHrZzaUfjB6huLHCiBXg>
    <xmx:BVXpZgSyh_cLi_54LN3j8wt0mmGD5mr8TCdX_l46SBqiFQ8nniGzyw>
    <xmx:BVXpZifm2NNNIWcrcQeVm1IZZHymos4InM0dRb82mgVB7gDlTbShGKZC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 06:08:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 436c9d9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 10:07:45 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:08:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 4/6] apply: refactor code to drop `line_allocated`
Message-ID: <6ac37186f284f9a4fcc4c9e25a1eaf102317f38a.1726567217.git.ps@pks.im>
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

The `struct image` has two members `line` and `line_allocated`. The
former member is the one that should be used throughout the code,
whereas the latter one is used to track whether the lines have been
allocated or not.

In practice, the array of lines is always allocated. The reason why we
have `line_allocated` is that `remove_first_line()` will advance the
array pointer to drop the first entry, and thus it points into the array
instead of to the array header.

Refactor the function to use memmove(3P) instead, which allows us to get
rid of this double bookkeeping. This is less efficient, but I doubt that
this matters much in practice. If this judgement call is found to be
wrong at a later point in time we can likely refactor the surrounding
loop such that we first calculate the number of leading context lines to
remove and then remove them in a single call to memmove(3P).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/apply.c b/apply.c
index 76f7777d4c..985564ac76 100644
--- a/apply.c
+++ b/apply.c
@@ -281,7 +281,6 @@ struct image {
 	size_t len;
 	size_t nr;
 	size_t alloc;
-	struct line *line_allocated;
 	struct line *line;
 };
 #define IMAGE_INIT { 0 }
@@ -295,7 +294,7 @@ static void image_init(struct image *image)
 static void image_clear(struct image *image)
 {
 	free(image->buf);
-	free(image->line_allocated);
+	free(image->line);
 	image_init(image);
 }
 
@@ -313,10 +312,10 @@ static uint32_t hash_line(const char *cp, size_t len)
 
 static void image_add_line(struct image *img, const char *bol, size_t len, unsigned flag)
 {
-	ALLOC_GROW(img->line_allocated, img->nr + 1, img->alloc);
-	img->line_allocated[img->nr].len = len;
-	img->line_allocated[img->nr].hash = hash_line(bol, len);
-	img->line_allocated[img->nr].flag = flag;
+	ALLOC_GROW(img->line, img->nr + 1, img->alloc);
+	img->line[img->nr].len = len;
+	img->line[img->nr].hash = hash_line(bol, len);
+	img->line[img->nr].flag = flag;
 	img->nr++;
 }
 
@@ -348,15 +347,15 @@ static void image_prepare(struct image *image, char *buf, size_t len,
 		image_add_line(image, cp, next - cp, 0);
 		cp = next;
 	}
-	image->line = image->line_allocated;
 }
 
 static void image_remove_first_line(struct image *img)
 {
 	img->buf += img->line[0].len;
 	img->len -= img->line[0].len;
-	img->line++;
 	img->nr--;
+	if (img->nr)
+		MOVE_ARRAY(img->line, img->line + 1, img->nr);
 }
 
 static void image_remove_last_line(struct image *img)
@@ -2335,7 +2334,7 @@ static void update_pre_post_images(struct image *preimage,
 	       : fixed_preimage.nr <= preimage->nr);
 	for (i = 0; i < fixed_preimage.nr; i++)
 		fixed_preimage.line[i].flag = preimage->line[i].flag;
-	free(preimage->line_allocated);
+	free(preimage->line);
 	*preimage = fixed_preimage;
 
 	/*
@@ -2879,14 +2878,12 @@ static void update_image(struct apply_state *state,
 
 	/* Adjust the line table */
 	nr = img->nr + postimage->nr - preimage_limit;
-	if (preimage_limit < postimage->nr) {
+	if (preimage_limit < postimage->nr)
 		/*
 		 * NOTE: this knows that we never call image_remove_first_line()
 		 * on anything other than pre/post image.
 		 */
 		REALLOC_ARRAY(img->line, nr);
-		img->line_allocated = img->line;
-	}
 	if (preimage_limit != postimage->nr)
 		MOVE_ARRAY(img->line + applied_pos + postimage->nr,
 			   img->line + applied_pos + preimage_limit,
@@ -3027,8 +3024,8 @@ static int apply_one_fragment(struct apply_state *state,
 	    newlines.len > 0 && newlines.buf[newlines.len - 1] == '\n') {
 		old--;
 		strbuf_setlen(&newlines, newlines.len - 1);
-		preimage.line_allocated[preimage.nr - 1].len--;
-		postimage.line_allocated[postimage.nr - 1].len--;
+		preimage.line[preimage.nr - 1].len--;
+		postimage.line[postimage.nr - 1].len--;
 	}
 
 	leading = frag->leading;
@@ -3062,8 +3059,6 @@ static int apply_one_fragment(struct apply_state *state,
 	preimage.len = old - oldlines;
 	postimage.buf = newlines.buf;
 	postimage.len = newlines.len;
-	preimage.line = preimage.line_allocated;
-	postimage.line = postimage.line_allocated;
 
 	for (;;) {
 
@@ -3151,8 +3146,8 @@ static int apply_one_fragment(struct apply_state *state,
 out:
 	free(oldlines);
 	strbuf_release(&newlines);
-	free(preimage.line_allocated);
-	free(postimage.line_allocated);
+	free(preimage.line);
+	free(postimage.line);
 
 	return (applied_pos < 0);
 }
@@ -3752,7 +3747,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	patch->result = image.buf;
 	patch->resultsize = image.len;
 	add_to_fn_table(state, patch);
-	free(image.line_allocated);
+	free(image.line);
 
 	if (0 < patch->is_delete && patch->resultsize)
 		return error(_("removal patch leaves file contents"));
-- 
2.46.0.551.gc5ee8f2d1c.dirty

