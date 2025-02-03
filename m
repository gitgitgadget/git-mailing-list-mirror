Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BD01FBE8E
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569833; cv=none; b=uQIynxML7gl0JdEfOu1pwmCYKTSJWYL6KwWvzdFDQsMHX4rvTGkqeBpakroCU2NeDWteyGsB8CDdWncGQSOUNCWhCiqcnsL+GUVxDKZ7A/93JNhCupHd5ywZ0CHeLTXyv5CVeDGKHoYOmcNfZrPBk/clyrhYX+WOstds6BNRItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569833; c=relaxed/simple;
	bh=vlQaHsnaw3vPJmH4aUp4D6TNGEjA2wI+X4ays6RCDkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hVEe2J3Qm5kvIL5AtmCy+1SRQqx76Uqbpq6Yh0aYt+h+Ybc7zhgk2HNGyYe5GGSlXkIxNsHY1u+CeZhz8n4mMiHUOtPZEoD/Kxf33XnATYU3UhSnuiH9Mhj+cUM7J4zV6D1cEFbNQk4W2UYkPTpW2x8Phk0Ni1NNr68/YfvylHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GN2oVrZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nFtCn1vM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GN2oVrZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nFtCn1vM"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 71BC11380857;
	Mon,  3 Feb 2025 03:03:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 03:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569830;
	 x=1738656230; bh=IgXFXxSRUCrMI6HvenjjJQcBauVKMjBqSHCzrRELj1U=; b=
	GN2oVrZS7Akg9RwFK+N2TZTso/TCecgm8bjNq4jzQulwgr80bI20QX7H1l1xzMVK
	Op7nV6u4Fj/KK+PtaM8F5CwkL6Rkwc2QKr/gvHm8crQ6HFYwZeVjXeuInMPsoXE/
	8x8z+oaFGLOnbXqV6L//LChgf4ePNk6rMPniMIsRh28uxkwJJXL9wVrAE3253Kwj
	GHalb9mGAEwLbZGlaoeMbTWKS/b3imE3E6QUznqkHG+xLWpqJN1qbuXapd/ufxZu
	K7UtRNZ3myYP01ENTVXkhAjSEe3992nnl1IT2/4nogNxAFUs4mHjKyr+QhEUd1fI
	tjRgebA+Ac3DCOLQpSTo5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569830; x=
	1738656230; bh=IgXFXxSRUCrMI6HvenjjJQcBauVKMjBqSHCzrRELj1U=; b=n
	FtCn1vMMcqiBhvbrZHOZVwXmcXJ+8kg0FD6B1Wse3sCkpYhlPB9RZM2pt9sfM9a2
	/cnki27osG1qLYi69inSYPc7N/qs5l4mHSq6PaTODLAgS9AGYFtUHN94CeXJ0mVF
	KiC8BPxbYwkUr2tTNKR5gWME4vMFA4391d6P1AA68eK12HKlHih6QcO63VODwZwi
	YZOGiNWD6LaD7fMf53WR2DJUEdqWfqPSULc5+WhQPyp3AQp2Yt2VBNvHMXbGcZe1
	PXYIEOyNP/srTKlkFV1P5sz5rbHRa51Zyv856EsA9m1+jbrxpZqEIcNOd4HIIOXd
	Gh4W0B5V+ObFAFlK/3Qqg==
X-ME-Sender: <xms:ZnigZ-VRO7oMq0uieAKXk5m9s1rRif_JBZ8rB--Edz7bs75Dw5uFBg>
    <xme:ZnigZ6m45_OaR77MUrABoD7ulX_5Ef4QWWpVr0ymeejgs6Vp0zEIY0mlf836si2rH
    IfhcsWzJro83vETHw>
X-ME-Received: <xmr:ZnigZybOvcpjT1S55MkwcRh-R0n0iNJek3tJcli0ZbJMUqni14WsxEWqEIUH51GtYBT3ugctV7gE0AVqKPui_KH7F1CUFaCN0zNEuiWdSHBWDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvug
    ifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:ZnigZ1VW8h3dw3hHzJBv3DG7X2383gerrZ2GPUbYrU5a66jvEwQpfw>
    <xmx:ZnigZ4nkXgJk6fpVR1yBZnrOFFNpqnq1uDdPFo8CXSUM9xW967HeTA>
    <xmx:ZnigZ6cA7UBn80dheo6ilvkcg9gFAWN-9196xmW--5bHb1F-cHoPfg>
    <xmx:ZnigZ6HiEHKwvunMkFOAdKttZ-PuA8B3unuVtePwGd5ohBWTqtqpIA>
    <xmx:ZnigZ5DEJUYM_5I9PHwSYqv8R-PjIMIAkJvpCxQeWCoXH75sgtbOeZF3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 69c3d67b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:39 +0100
Subject: [PATCH v3 08/18] reftable/basics: stop using `st_mult()` in array
 allocators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-8-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
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
2.48.1.502.g6dc24dfdaf.dirty

