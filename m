Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1B16A956
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567684; cv=none; b=A/7hV/FFVzE7vDSFAi377IEc5OeKb9gkL5f2ZJG7pVHoLtGMI6F7OdA3OlcrHg11gmroglxmGF8zQK9VI94Dn3n/yq9a5rg3uKHMPlemh1qW4STmhYExeS04RgTldRnz7WccbEo+dy20hxhuASjvT2HfFjOn740iquflzBZSEJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567684; c=relaxed/simple;
	bh=P6/WZzRUpHqVyTmHHVvg/1BNybXtO/jZMJbUeEjp2Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn87Gx1vgbqY0OhZF0kQHvPMJJBBMU4SbG6I7wc1RzDN6gz6uSMR5nSEnb3sZtAkj6lwdqOUJlF9NLqkWTLW2sWfucBF3kMVd1qGsWA+NkPGkwcNTUhqf2JPSZgvK60ZPJIofRN3+wzgQcEhOeeGNEqMDZAVCX7cO/FIluvNtEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B6/Ggmq4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EEb0oHZX; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B6/Ggmq4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEb0oHZX"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 5ACA9138046D;
	Tue, 17 Sep 2024 06:08:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 17 Sep 2024 06:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726567682; x=1726654082; bh=b0vFxtELB+
	fVXmBOP5X11HJ8ZqiNghtXOmQ3L+xFaxo=; b=B6/Ggmq4yCuX1Wid/qXsreKHY1
	Gzh6ttsl/qIRW+DT2gUgs6unq2jAVWjPDRPSiGykpGeug2S4I+SwWi2YV2VeCJiV
	bInNYpBnDpBpJpFnM3hCcqmI57aM3Pp7Ti+2V2JEL+WQFVvFv+9e3G/BecRiftDx
	T3VfVyw+b4W4LLpn1Zd8c/RIYXNq3Cd9HGqcQU/or7f2V7XXRED5xVcawE5A2Kgf
	OSWXGTfRQNIsLLZRQKKWlhPRabhpDHZ0ArBL3tM7xQkx8WWDDms6T0hQOR3OZBEy
	3THI6E5Cj7iqlZ5eJBOF8eupPVf1KwCUx0M6k4YvRnah8CmuN3ZV+cQ+2BqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726567682; x=1726654082; bh=b0vFxtELB+fVXmBOP5X11HJ8ZqiN
	ghtXOmQ3L+xFaxo=; b=EEb0oHZXQKUmXfrLER90Kt0DIG6jyC19newittgQFFpR
	UvaPEMabtyOZzDwnqafyGGnpIJ5nAQoR1vk8wjM/bwbdMyKvCN4hXu9CGNR/n00h
	gj6QDIkoCCtu8jmthyRfb4E9bqGIeRj56lMpBzE926Fd/KvYCWaRACxkYKJvujmR
	iOAV8t/n+SIsDkF4d0E0hE1wAqJJ/KJFEV2lHShkQ4UUUVX4bYnHZpWwoDOLpJ1w
	9C7+36sbdG0+0crW8gk4PiqHv6wP0AmRceleT+jmDMPaq4SbCdJYK/UZ8MS2nmSv
	yHpZu6xpUxCtv3JHdkI3KJ61Mt8gKwYH7aUWM1wgKw==
X-ME-Sender: <xms:AlXpZvHBgA9an0LNHZwiIzTc1RmUvGb7WOL_m5c9ujEtxKvtyRV9KQ>
    <xme:AlXpZsU1M1h1yDIPyRFGTao554Bexz-5pJDY0Uzxl5TQUYPz8bwDHyML6PI0MEk7_
    fHNfBHmVnEgyMDfmA>
X-ME-Received: <xmr:AlXpZhI7Ge9lF113VQTlg8NRcFHdEgNquazv5LznapI-sSWta7VizaxxZFbfu8e2tX1gEq-fBn0dXz_Kt8P9ZgK9eB5QcLDmtR9aWXDK8o60>
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
X-ME-Proxy: <xmx:AlXpZtG-S87Y56j1XYUJhEo3icy59FKE6EB5VRsTOmPqBFkHGmzHmQ>
    <xmx:AlXpZlXJn0YcP8wvcHQxMZu_GylAikdewykalkLK8XXf3obZE1X01A>
    <xmx:AlXpZoOzLXLpeSNAIGqbe57wXbXVn1s4br5Heu5Da2PrxRmI8qbvDA>
    <xmx:AlXpZk2yHjacewxH6ZikSWdCn-euiX6lu32d3T5mmCXgm1Qy4obBhg>
    <xmx:AlXpZijMuPnwPbWKZ5JipwJ3zxZgMhmA7XC0qTgq6RjaLPl5poABiy1N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 06:08:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 217f6c84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 10:07:42 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:08:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 3/6] apply: introduce macro and function to init images
Message-ID: <506c787d6828c028b3a4403a9a65468f1bbc030b.1726567217.git.ps@pks.im>
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

