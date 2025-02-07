Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FC1DF267
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929137; cv=none; b=iXYmu3yRnwY5j34K6IyhYfbF7KLty2UT9eKKLYeOHA9gaQsw5KwlSYZI4YahZTAy2A17qmu/o9YoUFt0YRx1Ky43xMH7zwhjuaWKiEhV7bU6EsepyujWGOwnss8jK2bcs/kvi943GQeGZOTb74W8VfPZWtS8qWofqtMyHvd2qd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929137; c=relaxed/simple;
	bh=knuekfm47Y4pJI1AsxWUejZz/ZFP7Z5CGrhY4gdlhmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mB340IIVq6JnL9bF3slel9TKpuHVSUIUxFledAwgUkDVbgNkhHqf8zr4JbLoEjbEsLZ8WFbujun2eWiL/XJUcjgW6xj1qtQxYvNsEv4m6n6sASIF8NSYVf819pTDZTvj56Nw0ZG2o8Kut5R9i5oRrOajPDR7soF+PlTzcj9vcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KMX+FjDF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EKBqMH2A; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KMX+FjDF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EKBqMH2A"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9401611400FB;
	Fri,  7 Feb 2025 06:52:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 06:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929133;
	 x=1739015533; bh=90cILya0hlcij7yaSMuAS2CDXIQCI9SHwbES56WXxsc=; b=
	KMX+FjDFXec2Qx3KoKSTn2kYKRoGkfhWoSHE8+dsgRgOkZUw0dDJb0c4ksUtSrSz
	GNPPaziHAuLh6r8M9grJQ+rsqkpGvizisiaqM88SlHXAIp/i+osUnuq3XEYHwr4l
	bpgwRSbB6ORt/yC8FMkU8oiF9JpC4LPWcvLzfZdlydAKueA1PWnGchbM7YGM/C3A
	hClzdwOhjkOqcg6fm93IjhtwbwNa/pPupA2q8co+332mokdrE3bw+GMffMIxgo9c
	q+090xRXerznq1u5KyNBmfVWdXtJ47WmpHOqE21p/lMZx0usm6awmDoI+C6D6whB
	HXukWyE96BEgsizqorRFhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929133; x=
	1739015533; bh=90cILya0hlcij7yaSMuAS2CDXIQCI9SHwbES56WXxsc=; b=E
	KBqMH2AeZindykFQfrxe/J4c/tdSTk2kyoNcMAtJKtFXyWinHsakmerO5x6Rd72s
	22a0vVpWIJTbDwqwavAwjIJSDI13yQryvEKcoIwWk34TOxwEwv7HIW6bO6ihqzs9
	4aCRDf5MXegDP1Gkye++vi4bvnvHrhIrVZbqTspqif//ARgeDaK92prlJJXe6RLh
	tSqWthdhwcD+/GXXljn0PzLfcbQH87qof/z9FbarRFGf+8ElYGEHGCNnjLueZLL9
	pmfS8hJXC98a7fSPuLpFFW9bjHU6QTRbwFukb3CeVsqUwbbgR9HFU+J9IrIWQNmx
	SJmK/1UNG2wHBmck5g6OA==
X-ME-Sender: <xms:7fOlZwMZyI4LWbJx28IP7GJvn0leymeQ-nINN-55q1eaX2W99Y9gfw>
    <xme:7fOlZ290ZYJpdEt1QFktH6I4VskLPQUWagyHuAMJ5wIsnETpnn5pBd2OExlGxT3EQ
    D_0P23wdrz0XgXG4w>
X-ME-Received: <xmr:7fOlZ3SlgjuaeVd_nn64UWpedPZX7xpo7y8AWvg07mnUzt2lnZubS6rIfByIQXNekj9CMoJxYCL-D_lYu4yb-oTZIPF_saFW__yTrbaRNhvYgLA1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjiehtse
    hkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7fOlZ4sWGhvSBOVKKpXrMhp6p0hawAlVQpwCRwGaTNNScfn59yffnw>
    <xmx:7fOlZ4c_xIhsG_Nkle_QeI_zAzyCozB81rRX6wwxmISV8t0jRbFu9g>
    <xmx:7fOlZ83y_K8hEGE4vDXF1PMTgtZhB6VEcNX-79XTQ6WGcplgP8GGAA>
    <xmx:7fOlZ88gcT7CZ-mGSGa_jlovb0JN15ij6ERjSGdveTBE3Swid2rJiA>
    <xmx:7fOlZ9GxTrKfcUugO9MpUpMLGyutj2Rf9noPSIGtsdWKbO7gFklwwaSR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ff6c6bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:52:03 +0100
Subject: [PATCH v5 08/18] reftable/basics: stop using `st_mult()` in array
 allocators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-8-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
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

