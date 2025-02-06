Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8BE225416
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828347; cv=none; b=WI3j2pctPEPhRY1e8LAJvaCOeuL6bwGCQ4FTChrhqYeol6t4KtlYb7QZ4iQYy9dYvYGxbvJM3NA8yPQ7n+eND2uTBIydI2jxpcbmIB1xM6KmX5qNQw7n8wADRsqAfnae34i1xLU3tBNDAAoXkEGH61NdXQ14COs5yoz7sYAZyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828347; c=relaxed/simple;
	bh=knuekfm47Y4pJI1AsxWUejZz/ZFP7Z5CGrhY4gdlhmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=syqNuzbo2xX7AHAEJ/saaiX9CSGCj7FLG08TSwubzW48SsDP2YpV38XIb7nTAM6PZu3Yvulxo/rmnEubwOa5q24L2TtEL3kgdJV9utv/SIbxXaHd0HluWiNPkqpEv3FItPsShpJXjq258qbOFg/MMKm+3dmOn/6RVfxeq6xgfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GofK782N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HxeXEtmm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GofK782N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HxeXEtmm"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D7A05138022B;
	Thu,  6 Feb 2025 02:52:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 06 Feb 2025 02:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828344;
	 x=1738914744; bh=90cILya0hlcij7yaSMuAS2CDXIQCI9SHwbES56WXxsc=; b=
	GofK782NO5LfgnLZfP/Ny7NY88rdxsGbZrTyW3GYPdkZOXQCkiEsvcWhQFca3t4B
	KaL6eSvE72uH0loY9yUXTEHEX2vLGwI8hJA2V/O/jbLJUrg7EYGmdiWSl3XM6epn
	s891lk7pR0S2rbjYMFCX1//bvs800XUkQ4WQyq4eTrPe/xBS+ECKNLlhczSa7SnE
	wtyy60ZueHECb53Ic5+EB88kAYU/QXTg74oEIe4cGdMZfDvPX7oCJbLEheW9T+Q0
	uDoMGwhnwkf3tRcxpivOv3CZTtPMCHP6swuEH+wyvNlzc2EeW8kVpoCfsJqECiGI
	5FrDEp8UbmAu5lpCPo8LxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828344; x=
	1738914744; bh=90cILya0hlcij7yaSMuAS2CDXIQCI9SHwbES56WXxsc=; b=H
	xeXEtmmwAHs7gY3z7dvDPeh53CLj9rIeBJ9+pWTtbdaIKYVekzvidIxL8MRLZo39
	6TdXXSA+ZTxYWXS0Dc//28sR++W3Xk7F+Hi+RniO4c74BxFkZkX16SCcJ2ppG7Lv
	2kC/UJm0Zcx7AV3emIZrxMljOGX3eYJG5hk+HvGP7GGDU4o19o4jDkvI6ic5Jmlf
	yxMvXSaerFUH/4fwDvNOx10ynwawX3zRp3ECymYUT4ENjQGyy08i+Ix2eAAsAKN7
	BE9HSrHx5LBaxf/klUeCdMMnfO1ZPzf7OL5Hhq3qm0ispXHMRkMV+rz1rOM942da
	dNKJ2ydxf44ZXD16ahnHQ==
X-ME-Sender: <xms:OGqkZ77HB1hW6Dbey9Y3TcC2ouyASRPY3FvS63WDPPOzxg1EYeN4Aw>
    <xme:OGqkZw7c4qdqBx-ALc5duxa572eanZoRhqVVUI1MV6JO1jHH__uxXK8iaWnVf3Ax4
    3ZpRhhKDOphZeTD_w>
X-ME-Received: <xmr:OGqkZyeelEW11Tm9CZETRPRN65ySBIliaUVhoDtoydohgs5YM_b8K5vuc53_0Oq43j3XccqIRqn19gx8MpacR-jKc_25ATXhtzABIlgSmUr1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OGqkZ8LMNQnDOC5MxBkrSMJweorgEkzmmvs8HjW14xkS08w7XicmTA>
    <xmx:OGqkZ_I--nwr-KA7munj_cw6IBMR0R5a1Ok86yCVPvs83RhalgqBLA>
    <xmx:OGqkZ1zVGG8U8CVPRthbQRfhZC3XNE-6zpbX4VkllF4E_eh7ZOQXZw>
    <xmx:OGqkZ7IRsYjQjS_bQqnI7x9PUJHsX1oaGmRUCy_ZUkSdLdd892fAzg>
    <xmx:OGqkZ1hCsa3LovRzEdAJnnsH2PCaOmmK87VFjLM_tF1istyn8a2YmfGJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f82b9617 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:10 +0100
Subject: [PATCH v4 08/18] reftable/basics: stop using `st_mult()` in array
 allocators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-8-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
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
2.48.1.538.gc4cfc42d60.dirty

