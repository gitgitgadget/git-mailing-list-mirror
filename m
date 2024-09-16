Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33DD2233B
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470616; cv=none; b=MFG9I7wCZ7A0stUSLH7aAJa/HCuF4eh9jsSKQKJ34kbwsZ11vCGecdAgKm4a7WjQryQHMnfqGjM95M1lTMZXy8ueb3ijK4iaQtMZS+SGfe3r4jZpIrM7wMW3CPt/SnL7UfTORvywKahHN8/68FHTc2xzdDVNJ6RDRyT7cOkmIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470616; c=relaxed/simple;
	bh=0T/wUPrIV5KTzOpnX0dmX+m3fGBWaIZJcygNsL+1Leg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9CxZxACfXiZlYzgjcSthEp5y4cHQyHcWiIOvNg5cn4ajN2v+5kgc4yWw9uzZ2hb8HGigDjm4DGc+jZwwO/rs9dmbXesPiKinRDod/PXse7w8hFcp+Jo3M5h0yKiheUIcMse2++HRGLODeDxqaGa5DAgImjsHdjwpADxVvqeNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZDBR8UZi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=piWsJdM/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZDBR8UZi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="piWsJdM/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F07DB1140209
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 16 Sep 2024 03:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726470612; x=1726557012; bh=M+lK5sxjxd
	ONLl5GR9C18RVgS9FCcy20/vbShim4hSo=; b=ZDBR8UZisLq5zU5FN+M0WhOvIw
	B/HTaO8eslRAAW1neFA+fGoOafw4W1COtZwjqCECNjrydLJfahTy6mMnwv/28oTb
	0x1lIuS/NJFAfFWT6AZcX98H9FJAIoPwPhXpdbL0cmjyj0AHfcblrxBlK0tUBzMA
	Aw/90Lc2S90SHNLTjLaYSIckehYuxLVQSPUIfhFBPofUeQaIbY22ikpoHZ1YlWJo
	Z69quq1huJi1w5HPNpPL5T2v8m9+FSPXDU2meLGZk6OCuV3nTcSll9oZGZpUjLIP
	nMDq5cbucPlpXe4XpMB6I7ghNFJegN4BmHfvL4R7//jmMwevkWbK1Mb2DsyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726470612; x=1726557012; bh=M+lK5sxjxdONLl5GR9C18RVgS9FC
	cy20/vbShim4hSo=; b=piWsJdM/6g+A2OiSrQbkl5iOBwmC4HF491J4nZLTiKbv
	mHFj/vUmq+VuxO7weI3vf7gUyoV7vm1gSWa2hrssROQGIfZR7PivrFYOYArJKSlO
	PfWzQ+Oz0U5x0w6oqq1SYY0jhcT0NXmhe9CAqIvsVKKPeb0FqrtkpJYPvN6XMPh5
	L09t+CN+yRFtuQmdipcEC1WlHPYUwbZCvVrM8PO5sNDjgFNhko6SalWZTk6JUjoD
	W10A+xud3+uSplhupOZFQiIw1sflo5Ek50zmxGIYCgchoo8nswXq3L+LJzCbb0Kb
	vxI8S3xSao99MFDSHvpig1D1PElohL+yE38CA+ysvA==
X-ME-Sender: <xms:1NnnZqpc3M2E1anWmnY_IF5eFg1WXTBd-Ybh_PtpqmmDMnuIMqeGVg>
    <xme:1NnnZopMwsJOKnLMm2TxE-1__n4tjac3vekhUtWbUMEULjrU7UtgThLx5nPx4k4Zf
    TNqZbBFi35ekHTw1Q>
X-ME-Received: <xmr:1NnnZvPqFrCQyjwtzJMAVHC6gtmOC0aNAShq5S79JXkOEJElsq6JdecwoijVg2jyop8fRH3X_NgFYAf5DbiOw36f3QjGzTRm53AckkTV2PMNTDsH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1NnnZp7Hvyfv127tQ_SOknuD3Mgkc3Nxz3eW_euubQazNc79ko6LBw>
    <xmx:1NnnZp62639nnlk5PVI1Fjq80Q54w3w8poreO1P6L66D0aEJyYaKwQ>
    <xmx:1NnnZphR_RtXC5QiHHXA838GF6I3rkcDyappZFsGsBANiB6cSqloPA>
    <xmx:1NnnZj7f5_yvpiEYfZml8OSaUPgzjZE-whqSYjjXx_AjqHrOwgN-JA>
    <xmx:1NnnZrTo4FPle7E7AErRKfByLZ0xZIQSI3v8NB6MqCMu1XVFB4gQs6hc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c0c46f1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 07:09:55 +0000 (UTC)
Date: Mon, 16 Sep 2024 09:10:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/6] apply: refactor code to drop `line_allocated`
Message-ID: <0427cb72507bba7ed62d13a5523fea351a0cb35f.1726470385.git.ps@pks.im>
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

The `struct image` has two members `line` and `line_allocated`. The
former member is the one that should be used throughougt the code,
whereas the latter one is used to track whether the lines have been
allocated or not.

In practice, the array of lines is always allocated. The reason why we
have `line_allocated` is that `remove_first_line()` will advance the
array pointer to drop the first entry, and thus it point into the array
instead of to the array header.

Refactor the function to use memmove(3P) instead, which allows us to get
rid of this double bookkeeping. We call this function at most once per
image anyway, so this shouldn't cause any performance regressions.

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

