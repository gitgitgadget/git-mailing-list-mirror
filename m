Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297F71FF7CB
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983064; cv=none; b=e+XNw4VkmWPnMvu020rAM9dpIY7mdHYoXpZMn4484bN8gBJ86GR3uUXbbySpwdzNhAW0/MUpAKv1stz7m+1KnhSxVvE5M4em9xRzYt1VFjO/hdtOA5rsLDDZ3fiNCpxyzeylKeDzy6faTj6YlxRCZBsJND1tOJgqhTVKrwqPQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983064; c=relaxed/simple;
	bh=Et2KRIpZ50Ti8K5L+Hq3oKjm7iR2mXqbWRq/2ZcQm8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdaN/tvriu/6U6q1hvq0DF6eOHZXfpjWvhP2H8MA240yUsOhfNNuNLAk7LwKFhNspXaXU3obDMYLdsMffzF+PB8qYtwGmM+n1eqQhIRUth/R6Qrqy47w3fy0lBi1CL3MsXxMTsgFN82kVpP7WG0a9TR7N/qGjNoaspoLyxa8IBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ecJ8ma9m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VahU9W7x; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ecJ8ma9m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VahU9W7x"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 39F5811401E4;
	Mon, 27 Jan 2025 08:04:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jan 2025 08:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983062;
	 x=1738069462; bh=KrYZAgyOUV0fxo0mPxCdHkYI5Fum1vgO46A+ah3bT00=; b=
	ecJ8ma9mBApaIDrAXqaWIlaI3ErJhQnu6PnTiwMjDRnx948TpdcG5jw+WBKX+cM4
	jblin6F1J66NyA7vGy5sX4RVB5VlpG0FDR8swLP1n5xWN9rTCS0tPxDo3nnYu/lf
	QtImNfnSIkABK82meJO00QNT6ER5DflqmrcdJJ152ssZpFZMTsLLP6Uj/YtOqgsw
	Nntq2Br/+jiXcyReHjdutyEqv202+4TxCwTR2wPJtZDVBDPZl+m6HGdG+eNl5W3g
	XMZdKcaDIhbH7JDNxEgSgE4muPDwW+izoNmxy5pnzq6o3nTrXYzlwZn5Mt+3w4K/
	rMHx6uvCU75gcfofNDKcAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983062; x=
	1738069462; bh=KrYZAgyOUV0fxo0mPxCdHkYI5Fum1vgO46A+ah3bT00=; b=V
	ahU9W7xLG7FTeUrowN8t/0rUofBY1XwKLjP250TT0QXPG/1SlJS8hzTZKJYrsr/e
	Bw19+eZM3gGa/yOMuFmRzA3LGiVYQ+Nlfku2Dcq+pdWFd6hhsrI8m9teER7pUglB
	GXyWft7ydWW9eNO82idJtN30Eb4HvUR+ONFg8Iss7st3GC7HYeTQQC8B2ZU08LQJ
	pQNM1/jE4x8mTuEyrX8YsUjRvwy8QI+D5fMMpBJ/BRPVO5B2QbIYRhj4WV+0EX7V
	rHpF3AP8MUo5Rmvi1WUYOpNwWE5FIHFlW47CZbqwSVc+NLxyzvJUOEBmYdngL9dZ
	BrgZ29H0//g/cTO/x7Aow==
X-ME-Sender: <xms:VoSXZ_NFKCuT4F5E2cOkNinNTM00X2B0JB3IdCuj-TUDJBjADv4Hlw>
    <xme:VoSXZ582-AxLR-9AjDWmifb_p4oeD5qNJxtsNCkb67KfGpgLBiFJHLcaeUN_MZOKK
    NzUyp3PtU_jQEGbmA>
X-ME-Received: <xmr:VoSXZ-RztrrtkY44H7Yssn1PcoC5ioS7pb0gyXtPZk9fG9xsJQb4d4ERVTOefdU_Wjfr9uAe7P5138Fb_7HFidSbbrUMUyZJANgrfHXTBbp3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VoSXZzuc4T7rbZ0mqzbwVTVMC9iEtIZtWkDHcRz1jELp6-ya12ORLg>
    <xmx:VoSXZ3dLFOULRfps5emVm8DQ7CAFCLwsOfCjOETe5lvRCidM73hBqA>
    <xmx:VoSXZ_2nCwruj6vwAxgO134NGOgm8-OI8dgFzk0_QarLB-ewL7MljA>
    <xmx:VoSXZz9mvXWU5LRJ-qgSLpMFI9CzsWJa4IYxhVKB_UqE3yfbvhNSbg>
    <xmx:VoSXZ4qwerCtShRZDPFHQ0cOqY7iBb0DK49kYY5re9SY3CckesJdI7Hn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82c974a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:16 +0100
Subject: [PATCH 08/19] reftable/basics: stop using `st_mult()` in array
 allocators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-8-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

We're using `st_mult()` as part of our macro helpers that allocate
arrays. This is bad due two two reasons:

  - `st_mult()` causes us to die in case the multiplication overflows.

  - `st_mult()` ties us to the Git codebase.

Refactor the code to instead detect overflows manually and return an
error in such cases.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index a2a010a0e1..646f8d67f2 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -117,18 +117,46 @@ void reftable_free(void *p);
 void *reftable_calloc(size_t nelem, size_t elsize);
 char *reftable_strdup(const char *str);
 
-#define REFTABLE_ALLOC_ARRAY(x, alloc) (x) = reftable_malloc(st_mult(sizeof(*(x)), (alloc)))
+static inline int reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
+{
+	if (nelem && elsize > SIZE_MAX / nelem)
+		return -1;
+	*out = nelem * elsize;
+	return 0;
+}
+
+#define REFTABLE_ALLOC_ARRAY(x, alloc) do { \
+		size_t alloc_size; \
+		if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < 0) { \
+			errno = ENOMEM; \
+			(x) = NULL; \
+		} else { \
+			(x) = reftable_malloc(alloc_size); \
+		} \
+	} while (0)
 #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
-#define REFTABLE_REALLOC_ARRAY(x, alloc) (x) = reftable_realloc((x), st_mult(sizeof(*(x)), (alloc)))
+#define REFTABLE_REALLOC_ARRAY(x, alloc) do { \
+		size_t alloc_size; \
+		if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < 0) { \
+			errno = ENOMEM; \
+			(x) = NULL; \
+		} else { \
+			(x) = reftable_realloc((x), alloc_size); \
+		} \
+	} while (0)
 
 static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
 					size_t *allocp)
 {
 	void *new_p;
-	size_t alloc = *allocp * 2 + 1;
+	size_t alloc = *allocp * 2 + 1, alloc_bytes;
 	if (alloc < nelem)
 		alloc = nelem;
-	new_p = reftable_realloc(p, st_mult(elsize, alloc));
+	if (reftable_alloc_size(elsize, alloc, &alloc_bytes) < 0) {
+		errno = ENOMEM;
+		return p;
+	}
+	new_p = reftable_realloc(p, alloc_bytes);
 	if (!new_p)
 		return p;
 	*allocp = alloc;

-- 
2.48.1.362.g079036d154.dirty

