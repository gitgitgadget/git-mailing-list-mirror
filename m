Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB573358B0
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575869; cv=none; b=jlcTTR4gD6jAjPmuLlqAMbXCBUf3EHtZUfBeEZ0KnZ5NOB/gJmUc3VQx39PPSDjsrO4SEAVLKUk7NJ86oGWnrp9j+UnY1TPIuFObKC/dxwXwNREk7D+u4kYBikKqpunrTIAie2/gTWwmhRstJvoKDna6nHaKrcC//eHceIvwKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575869; c=relaxed/simple;
	bh=sRBNDcAr9ek2fId1fxxuXpuOW2zSkIIz8kYnidY6pXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uSdqpdRUhO+BAyo+iei6fw3rLTmfU4326iMru7jH95pTqTvvGit7fggAnGy7OY2LwzWsTA44ZyJsgICqtbJ3GCssbRzGfD+8O1ZRrtiQylQ+4aY1y6byOHkiOnirA4NXUno9HbnHU9eQ0allr72vQu++8mxnY7S0E3T1kQp24wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d0xXpk0m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVW6F2+W; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d0xXpk0m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVW6F2+W"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 738131D00091;
	Fri, 20 Feb 2026 03:24:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 20 Feb 2026 03:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575867;
	 x=1771662267; bh=4D9E2O48fbOMWxAJcF0+mKduWC06Jv/Ohm3DrOQ2+5I=; b=
	d0xXpk0mcQASZA9zZdBd9oS1pWMDKG3y7vNdQkIBRbULlndF0iuJ8Lnn3AGv+CMk
	/QDT98OC5sRtnP74vMW/ChivpnEH1v6sUWf/SBWf33+yJ5I6qn+ZJRwjYW0t5u14
	TT+bi5SiVZFjnNXVcpoGlaKFn4GUyLkI4aB1t3CCfCQDEvfDKAAdz9oBA0XnQ2/E
	gRFub1Fses7Nrf0/vdgjQIABXrDyt1bh7HGLJreC1HTRb9Q1QbohVwtERYzbl4oF
	NQz6cofk230NHfrtwpEjE1rq47/5wATvN9PpkiifABjlm1knMAA0ZkBFuZebfDVU
	h6u2oswXd+puVl9G3t6Mgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575867; x=
	1771662267; bh=4D9E2O48fbOMWxAJcF0+mKduWC06Jv/Ohm3DrOQ2+5I=; b=i
	VW6F2+W2fT2xR7QJJD3HapM5kGLl/3YJ6bakPyjxPBPMVtGThlRbRNu9EGBBIpG7
	xwsjngiGiT9uoGdUoofIiAB/dj7gy6XOR2QBJ1wmOLUEO1tDmRpWjSfwR+dW9z+l
	R2YmfifTt45bqDzAhy2UXYQ6cjpuJGxHJ2sFdcdL/Tf55qOsaX9CiPW9STqEaYYW
	I7kOfz4h4BWLxBG0ZgHR2lH+tFNb1cPVCjwLhht3a8c8vI+nlL8xK+Qq88zgj58f
	SiaLJHtPg1Ckx3S1qnhO00mUmYyjaTFxbVZCd3Eu2PfEzX7+L0RpLdAJe/HaFhfA
	1udOwkFHa/WozEjFpW+Bg==
X-ME-Sender: <xms:OxqYaVwds9UT_L44TfAopweuO0SdX9u071KECt1XWuPFODpedHGH_w>
    <xme:OxqYabTHB5sbCZ18xJZkTI6Q_gdDvE4xBVMv8iEbjkdcJnpIG2VcNPUjiVmX7qS-s
    r1AHNDs-Taq3riDmGZqm5MzVc4kE3NbnEov2Ptn9Xhl2m3lXrg4>
X-ME-Received: <xmr:OxqYac-19GWqt_n59N1mOhVFOSze3bGLTpFetWd9y1YZqEeKflhiYwJtBXwRSwB9DnwbfbHpGg4DkJJvc2yhlo9TAjgqWkhcnZac-YMgtLqi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OxqYaSqsN4nhFM6wlx7Xzj2V2NzMhT-kA7lw5tigICbrK9Ra5l98OQ>
    <xmx:OxqYaZmH4H1JD9wq-gkPRwZDbiVbCFdXwZ3RmTrrJ05ANsb8mtznjw>
    <xmx:OxqYaZIdEZ_0LGUQU6kV2bsrwZW_hcZ2PpEwUeoSzALvpAh2lZvy8g>
    <xmx:OxqYaex1B9WEJL8q7SNXr0HHyWrNSyTgpAjYX3eDS7sY8ERPSAvWjw>
    <xmx:OxqYaRiO82aIzcoWhvv362w7WQvjDCAw8sOJSaZgSIN1yTcQwh_sQrh3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:24:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e6ee94a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:05 +0100
Subject: [PATCH 01/17] refs: move `refs_head_ref_namespaced()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-1-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `refs_head_ref_namespaced()` is somewhat special when
compared to most of the other functions that take a callback function:
while `refs_for_each_*()` functions yield multiple refs, we only yield
at most the HEAD ref of the current function. As such, the function is
related to `refs_head_ref()` and not to the for-each functions.

Move the function to be located next to `refs_head_ref()` to clarify.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.h b/refs.h
index f16b1b697b..62e8ef61e7 100644
--- a/refs.h
+++ b/refs.h
@@ -413,6 +413,9 @@ typedef int each_ref_fn(const struct reference *ref, void *cb_data);
  */
 int refs_head_ref(struct ref_store *refs,
 		  each_ref_fn fn, void *cb_data);
+int refs_head_ref_namespaced(struct ref_store *refs,
+			     each_ref_fn fn, void *cb_data);
+
 int refs_for_each_ref(struct ref_store *refs,
 		      each_ref_fn fn, void *cb_data);
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
@@ -456,8 +459,6 @@ int refs_for_each_glob_ref(struct ref_store *refs, each_ref_fn fn,
 int refs_for_each_glob_ref_in(struct ref_store *refs, each_ref_fn fn,
 			      const char *pattern, const char *prefix, void *cb_data);
 
-int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, void *cb_data);
-
 /*
  * references matching any pattern in "exclude_patterns" are omitted from the
  * result set on a best-effort basis.

-- 
2.53.0.414.gf7e9f6c205.dirty

