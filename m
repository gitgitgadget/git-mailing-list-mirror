Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74112CD8B
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470610; cv=none; b=nsdPKVS1uKdqDNqQDUFaVpRl2VDcqnrsQ2i2sm01isMwpj4W6HoYYg+SgdaHieQnc4/vZ1QIXWxUZyiVCYu4oADVJTNjYkRpfGMubZGUMOUNcesY6DgYUIBv2hFiVHgqFbqNg9ADTfIsc9eIkeZT2aSYjwBYrVGI+rr7TFDXbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470610; c=relaxed/simple;
	bh=P6/WZzRUpHqVyTmHHVvg/1BNybXtO/jZMJbUeEjp2Bk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9D0/6LBlliWUGWT50v34aEs7fvASxnUdXB26U/aJCHWYhnyvYRc6+5uJbsuOmj3JdkG7ezMz2KLYsjzXp0U1J5apy7cMXjkjojXAsLRnsew0TYLAjho3HyBzXX/8GY2CKcjYd4YGnJe1nr9PMLq9ezqBpS3B8tCiIV8Ru8t9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q+kBdOPP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CrMboahb; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q+kBdOPP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CrMboahb"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1EA241140209
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Sep 2024 03:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726470608; x=1726557008; bh=b0vFxtELB+
	fVXmBOP5X11HJ8ZqiNghtXOmQ3L+xFaxo=; b=q+kBdOPPAtkAZRN8m1w+F9zsMr
	IzUIQmNB+nB4Zh4G4fAZGIB7jUn0yR348l+4ppn7/LznhJ3ex2NUhFVEX3X9E1UQ
	8O3qsfsPVXk9E111Ov0zej9gOf0l6n0MnEQm0WR/520ThUAOiYWt3QTjXSsDdXz/
	xIC5S0i4ouGs0osNpNpAVFXsTC3pV2FxRiiGVH6WlEH58/LdaD8rHqs14sxmeVP/
	cxzD/OPkwF07/GtgYt2mJPllcWzPdxJ1fxZ7U0zGhxn4gdnUGXuze3MKLJ7V8b4C
	hvUuR0rU40+QbvrKLZCE3HeDil7a7b17Ms7YWINfXl3VPMekkRtPX1+CZG3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726470608; x=1726557008; bh=b0vFxtELB+fVXmBOP5X11HJ8ZqiN
	ghtXOmQ3L+xFaxo=; b=CrMboahban6G0khhx9Az2Juu+LxcSYsV+kumA8yK1/zd
	sJIb17hxgHqsqXd0jAjrFaWbpn1kfEcLqJxIJpEh7sFqyMAZl6UFFx4/9eD6wz+H
	I3Pc1shZAuIhPfh/aW4104L3fyL3HzQykZ/x1cS8W7l+Foce5vkqc5HmELhUClvD
	eMi7b6pKAv5HVJOE7fTsnEKS52ckMfTISW2Imf3+QWismf2/tEwfm/+niVclAjAy
	IuMsT789Ni+IpjDKPfqAv+VGtk4rT7GFBkVOLXwBO0rRCqe0zEo5mwzloMlCmYsd
	yEnuct0BKORu6P5PrPITYEo0i1aqy0KT6KtHI4NtSA==
X-ME-Sender: <xms:z9nnZhzJLC0mL3JZr6VAe7dxnxt-LXSCO5RrPCe84nPN5lcErfnJCg>
    <xme:z9nnZhTlhm6UqIfdPkik8zMyeXRFfAVVRabWOfO4_AYYTpLGrhnAsRMT398qcYRtQ
    qkvxGrjCEsJhmYQ_A>
X-ME-Received: <xmr:z9nnZrXZD7-GQ8BUaPMAWdYk0BNb_E-MUQqCxRmhWaV2lRLJvnOZQHnINia2p0CrDyhOPnoOgy7HcVjtxdFTfJCKJi1yochH1NqsspMaFjd9gaxz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:z9nnZji8F4UMWGclyhs6PWOGlyWl1OL_Pw2jpiwIRJzr4Nk4bByR2g>
    <xmx:z9nnZjA4GU4d2-I9j0EJ2w656ojEC43B46kHVGu_iVOI9byIa21qvw>
    <xmx:z9nnZsKoXtawGdR5TWe7B8r4AJoTlfb0vcp7aEAfjYyyZ4lTjTZZGw>
    <xmx:z9nnZiC4YZMKvcrIg0lYbvp8F1GVpskfmSv5SLm-EohNtpH6jaF0hQ>
    <xmx:0NnnZo4WZf3xah7ptOA-Rm0sbjNckbeu4kv9B28A9HkByGEceosuVGYV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b41239b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 07:09:51 +0000 (UTC)
Date: Mon, 16 Sep 2024 09:10:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/6] apply: introduce macro and function to init images
Message-ID: <1b49e39bcdcf43318682d8520e6bc3d1f40bd618.1726470385.git.ps@pks.im>
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

We're about to convert the `struct image` to gain a `struct strbuf`
member, which requires more careful initialization than just memsetting
it to zeros. Introduce the `IMAGE_INIT` macro and `image_init()`
function to prepare for this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index ac21c21297..76f7777d4c 100644
--- a/apply.c
+++ b/apply.c
@@ -284,11 +284,19 @@ struct image {
 	struct line *line_allocated;
 	struct line *line;
 };
+#define IMAGE_INIT { 0 }
+
+static void image_init(struct image *image)
+{
+	struct image empty = IMAGE_INIT;
+	memcpy(image, &empty, sizeof(*image));
+}
 
 static void image_clear(struct image *image)
 {
 	free(image->buf);
 	free(image->line_allocated);
+	image_init(image);
 }
 
 static uint32_t hash_line(const char *cp, size_t len)
@@ -322,7 +330,7 @@ static void image_prepare(struct image *image, char *buf, size_t len,
 {
 	const char *cp, *ep;
 
-	memset(image, 0, sizeof(*image));
+	image_clear(image);
 	image->buf = buf;
 	image->len = len;
 
@@ -2314,7 +2322,7 @@ static void update_pre_post_images(struct image *preimage,
 {
 	int i, ctx, reduced;
 	char *new_buf, *old_buf, *fixed;
-	struct image fixed_preimage;
+	struct image fixed_preimage = IMAGE_INIT;
 
 	/*
 	 * Update the preimage with whitespace fixes.  Note that we
@@ -2910,11 +2918,9 @@ static int apply_one_fragment(struct apply_state *state,
 	int hunk_linenr = frag->linenr;
 	unsigned long leading, trailing;
 	int pos, applied_pos;
-	struct image preimage;
-	struct image postimage;
+	struct image preimage = IMAGE_INIT;
+	struct image postimage = IMAGE_INIT;
 
-	memset(&preimage, 0, sizeof(preimage));
-	memset(&postimage, 0, sizeof(postimage));
 	oldlines = xmalloc(size);
 	strbuf_init(&newlines, size);
 
@@ -3650,7 +3656,7 @@ static int try_threeway(struct apply_state *state,
 	size_t len;
 	int status;
 	char *img;
-	struct image tmp_image;
+	struct image tmp_image = IMAGE_INIT;
 
 	/* No point falling back to 3-way merge in these cases */
 	if (patch->is_delete ||
@@ -3727,7 +3733,7 @@ static int try_threeway(struct apply_state *state,
 static int apply_data(struct apply_state *state, struct patch *patch,
 		      struct stat *st, const struct cache_entry *ce)
 {
-	struct image image;
+	struct image image = IMAGE_INIT;
 
 	if (load_preimage(state, &image, patch, st, ce) < 0)
 		return -1;
-- 
2.46.0.551.gc5ee8f2d1c.dirty

