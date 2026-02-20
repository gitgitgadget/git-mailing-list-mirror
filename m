Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4C2E6CCB
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575900; cv=none; b=p+n6/CULEfCkd3+hoLMXbwFG7RKPgb3+I2z04enWDIilw8hPdGR+omxp4Qo/dHVZNWvKvE7L6BVaGrnhz3zhNHQQ/NK4GuhsRCoqCuhNxxCwtjJfYE5ejy/kKGLH4pzvZORDuLrMOrDWCixgbwbyl19/9EEk0ED7gy7ZtQco1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575900; c=relaxed/simple;
	bh=4TVbzz5yZAQqcpXYhY2TbmDhlU9eCVfQdK9mfxZVCK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8JFGJRrGyoiO5N8BU81U/2XALUHgYPTMlr+V/ak3ihUFFx6OMWsXGWECdYRH7fVCLd76hzFnMyhKzJu1wjIzOctF+INk+Qhsy6QPco0yids+H56vq3/6kVfiqEJV84GI5SGFACHU1AbJeWUkYFU038HOK5b04KbNX+rPefizj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aLgw1892; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vBXEWO3O; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aLgw1892";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vBXEWO3O"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A52711D00011;
	Fri, 20 Feb 2026 03:24:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 03:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575894;
	 x=1771662294; bh=HmKGJGliViZv/XT0W5VhK9u9DGifb+FQBmoXYwqzj6o=; b=
	aLgw18926dL1lmeaXHKnE9TN3GkbMNABrAGWVd73nNKpSzi661HnJKmUQVpMkSgK
	CKgCMbf9hjFgWLW+25TklV/Nu2I5tYcHvBylgs0PLoL5tRyTYBVF7mzA1wXjZ8+w
	TislDfUZzS+V1CEACur3hRr5mbei687CvV8N2EajFtlv0iQcixahp0f4rF6cngEo
	ZU0dMtjQvKDAFZuV/W0MBFEmxBC9HZf0pW2TFic9fO2qKf7OqBiL+X3ir6ZJ55oe
	ZfvSGwAx1tCXs5OqBxwvZZAA1LjXdACnHja77qI2lkAy1LmAxV9u+6bIqdoN2mjo
	kKlht/aEnUDMKpk7tNxWKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575894; x=
	1771662294; bh=HmKGJGliViZv/XT0W5VhK9u9DGifb+FQBmoXYwqzj6o=; b=v
	BXEWO3Okc2aSIP3z9CiWA9/QaiBb+lizdATrfeZeiKvgJ6aM2dkvzpmt6m2lw7hW
	+XYDA+ACqBqrXOkrehMH+ANX1zSeqJiNI5TyDk1kZOZoAX5EZKMPspYCvkALVetT
	5JAxc77KID8WZCDHNhcEFNO+IyJnv6EkzXRDq7YWyPmQsyMGDCz/ml8PcPXWlVCI
	7lMKEXK3TRsAwhLsPIiAP16zEVxSgg1mWI1B37r173woNZ+srJ16B+8j0WCtEbDK
	G6BAqbfqRVhAlp9PMigvCz4n00P7fowDw7ThpcAUcjBWPV9NAIlQQYcdoHXLNRb+
	Uwt506Acq8dSvznqLBPBg==
X-ME-Sender: <xms:VhqYaTepbiMESpBAm8RPSGSZ90dW61_V_0ymOx_Da8ifqDnI9--m0w>
    <xme:VhqYafMVbQtW3_xB4hlL3DsLliVHx0JkTiSBgqamNX8jQpAe0i7sXiEjhnwvx5P_j
    356mBz4zNmhgOCCx5uSXbz9cUxp9K8LriyAzOniKFr1nL-12tpddQ>
X-ME-Received: <xmr:VhqYaaKgdwnVNrvN68WTlYG1aCVPimG1zPxpAahOZ0JQNUcpy3FtgvWtIRXF2FuIeccYzpLtOvrR_0Na9QzeJ0n8TBL0mIl_aKrX8U_ig1Hd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:VhqYaQE6czunM8EDZ768-189uuykZQcAqR8f4fW2sT4kXYFiBCGFVg>
    <xmx:VhqYaSQW3xYPUNEGDlmnYn0j6_aBfD0WXYc1ULUphMX1X4c1n0s_Nw>
    <xmx:VhqYacGwqGmRl66vEp9GQrnhvSaNE13eKrsmrLtJ3NveczkwfDHwPA>
    <xmx:VhqYae9aIbf2-m6RXjTEDAI6QGvOmp60HdyONoTMxTn0qDR8E2owEg>
    <xmx:VhqYaaMf05THPrk7KYcqY07QDIyIxqGbk7CDKtx28efg16SRP3IB3tUd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:24:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d1e206b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:14 +0100
Subject: [PATCH 10/17] refs: improve verification for-each-ref options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-10-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Improve verification of the passed-in for-each-ref options:

  - Require that the `refs` store must be given. It's arguably very
    surprising that we simply return successfully in case the ref store
    is a `NULL` pointer.

  - When expected to trim ref prefixes we will `BUG()` in case the
    refname would become empty or in case we're expected to trim a
    longer prefix than the refname is long. As such, this case is only
    guaranteed to _not_ `BUG()` in case the caller also specified a
    prefix. And furthermore, that prefix must end in a trailing slash,
    as otherwise it may produce an exact match that could lead us to
    trim to the empty string.

An audit shows that there are no callsites that rely on either of these
behaviours, so this should not result in a functional change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 20d34faeb5..3b676432b4 100644
--- a/refs.c
+++ b/refs.c
@@ -1855,7 +1855,18 @@ int refs_for_each_ref_ext(struct ref_store *refs,
 	int ret;
 
 	if (!refs)
-		return 0;
+		BUG("no refs passed");
+
+	if (opts->trim_prefix) {
+		size_t prefix_len;
+
+		if (!opts->prefix)
+			BUG("trimming only allowed with a prefix");
+
+		prefix_len = strlen(opts->prefix);
+		if (prefix_len == opts->trim_prefix && opts->prefix[prefix_len - 1] != '/')
+			BUG("ref pattern must end in a trailing slash when trimming");
+	}
 
 	if (opts->pattern) {
 		if (!opts->prefix && !starts_with(opts->pattern, "refs/"))

-- 
2.53.0.414.gf7e9f6c205.dirty

