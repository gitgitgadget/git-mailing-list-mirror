Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124751DF259
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052904; cv=none; b=tfTOgniLXxcKqWjUpVYhdnldaXG4m1kKBoEsnEC91HIextg6Brv/1kGlQQxz9H8ZOxNHFeO313MkAw+3f5C9sbJSX3ZxlFy4XNnGs76TtOcWpHC1rVlzvbeZkp2h5p9aoK8JuAwE27LIFfHyWhb4uybslkNgRiwBwGY7xFRsLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052904; c=relaxed/simple;
	bh=Et2KRIpZ50Ti8K5L+Hq3oKjm7iR2mXqbWRq/2ZcQm8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFDFg3zhsp9Z8IK4wHec/SbpwmIRWKdfUIRpHPHee3ERRSBuCiYxYXTGukSoI1LN2x5V4YZmZ1rI1trVEo4JyXyPDmWqEKViNEl6cEMdeo5dljZmKIgU5BDvDugJWxoXPEqdRHJiRY+2G0s8gq7DBZ1GdaajUlqqDhAlKLi9xgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RPenCoMq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=enUuCbKi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RPenCoMq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="enUuCbKi"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 09B2111401CC;
	Tue, 28 Jan 2025 03:28:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 28 Jan 2025 03:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052901;
	 x=1738139301; bh=KrYZAgyOUV0fxo0mPxCdHkYI5Fum1vgO46A+ah3bT00=; b=
	RPenCoMqfOqtBZbo+E36NmryYIHuh/Ofm8Su92a3nG8zSqbfBqLTHY5G4hPRobgb
	KHJ0ZjzD6W/w6Vfj2W6lp6UXxAkPMc4C+9xMt6FyJQkjZnLSywSQo0l5h12k9B36
	7B+2Ul36cilLViGGxQy1zVvfCT95kJawzHwNcn0izo8IN/REBcfd7NIZORu/PhTY
	nts5TpItwAwTRaXrohqhMF00IueoHw/aS/IEGSQNfT+XHV7+VljL9M4NXPHyuVde
	aqWHlK7pglc2nuGb6pKVhDp+eVweUsmoWunLOPSxaqxNJrNRJdpuwRpquupc0BLt
	0dHOq04Ze6mriNGO188CVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052901; x=
	1738139301; bh=KrYZAgyOUV0fxo0mPxCdHkYI5Fum1vgO46A+ah3bT00=; b=e
	nUuCbKi6gKP7qBCcQUaNuz9yaPBIcB+phVi2jQIsxbBQWxidfA5/A3aV/kj5CkhE
	DlTC1GAw8mRaOYZ0g8vVZqOTlHxc4QGw/XK/n9RX8xmpwyV2qD3FdfmS9w2zaHAs
	xPRRIkqoEYqcLduWteSKUKS8yUwqmi8hKTWix6WFd9MffvoniyCYDjo1wkC7uHYU
	5Yj2Eh5lMSgk1ybwImoqUY39lDpYrWchZXBJN/BmuHXEUN8/i7JiRxnAI1Fsed1f
	fpJhl78Dbyw9xArZKlT8SuxtKPIvFCTw85OH15QUwIB9zzGcnCBqjW46sCGwub8K
	ugRjlJcyYTsj5ezvmkprA==
X-ME-Sender: <xms:JZWYZ_6Et3QHDF7zdys28ZxPx_nnT81HRUKwcUrkmv4tlex3CWNAZw>
    <xme:JZWYZ07wvblgZBi7M1sXzwsZIrBtd407et0hqVp6_oN1ZQjueCpb7ZYwhYmS6yeM2
    FyVs05MsqPqNFGSxA>
X-ME-Received: <xmr:JZWYZ2e9Dd9T4W-tgo3LLIiDkWxdWlaFpySr02M_OY54uQhfmVD_Xh6gVwkhOqeqOpz2tCBjQt4pYbzM8CDzZRRjop32xHfmQk7kpgahYKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:JZWYZwKb24KYd20ENkPAefY5uHYSodNa4HbolOyd33jSWa8G2IhODQ>
    <xmx:JZWYZzKQ4OJAWhLvq8mkQpYLF-JWYyGd5qw3H_d4pj8vtScgjbbkLQ>
    <xmx:JZWYZ5ztKCYIzsyT-Jau-VsyUNOwAbG0mtD-gaRQ56rStWMbvcSCRQ>
    <xmx:JZWYZ_LkVMudZBzPyF4z5XpP5nLO5zm-593tHcN1Pw7w12v8X-dkbA>
    <xmx:JZWYZwFgD6pz3ukC40g7KgCYtZ2GxgZrAJfMycJPneY9pGlhMtwhctsV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 51ec9d84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:09 +0100
Subject: [PATCH v2 08/20] reftable/basics: stop using `st_mult()` in array
 allocators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-8-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

