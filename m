Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42F1FE443
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983062; cv=none; b=LUU7H5pJ4jksq2TzvvwzgCQpi4z9Milp6weMP/kT25Ll88uJJVBGtuu0Ta8hJVImfUv7RyyHEloS98UBRY/qi/13QYmYCL2RHj6aWRcki2eQcUJ2siLftpIc2iJV/Xnb1CPmlCNp3dECCRxhGSMz0FU70NmyA5QWnELc8p+OM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983062; c=relaxed/simple;
	bh=isW44sI+hPQmmM/id5qyNHnGUjfiKjltOXrxxnn+FhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lA32thd1tiiTdyG/kP9W/8KLL7C+co7aZBJL87hGXJszgIpTXp+Khdl4Eif07XoAEtwOKFa9xK30ba1m3XBT1xD6TffOFkjhqH18cUb2E87mnumRWDGcYKOALyK6/FluGu+5v+OCljx+53zIA73tnSZjhkX/xZzmOYaBU2qKWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sWj2IDgj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G4N5mlhF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sWj2IDgj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G4N5mlhF"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58E701140201;
	Mon, 27 Jan 2025 08:04:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 08:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983059;
	 x=1738069459; bh=OX7TtIP6uvImCavOgAuwk2ZK66HkAEPH4PAUW1rGZn8=; b=
	sWj2IDgjCVd0X/hCPiLoEFrB87w1zHfUH2OazKsB96DABH1FH1pioeKT+lUY286X
	dEVUVi32vTUTH9ovCQ8+pDdHWGeU7HVYMeELdu6IZ5c2n/ob9ZT/8KecV8HlU9Dg
	VUke4j1o15MfHma3ordjUaOaCc2bFgBP5qO99VrRroqQSN8e62d052w4JzUVresB
	VLMVKGx5LpT8Ea8L1OKVz9/Gom6iWCSjnymqQx+vVrn+mxmYL7jjZTY+Azre+jsa
	Mpw26szsrF7z3VQTINMIjMROMfS1LYr+JUbRhKn2SgpG9Ruz0XbHAuZFI7FeTdyp
	/O1H/BE96qZUpW5QapTy6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983059; x=
	1738069459; bh=OX7TtIP6uvImCavOgAuwk2ZK66HkAEPH4PAUW1rGZn8=; b=G
	4N5mlhF0r9CNrjmUQElizTlNGds/wK7t37m/A7IvmseJNflGURu89nWtb61nH0MZ
	+dJ+ciIwN9iYAZqj4viPosT3XxgbgRwIfqXJfL8I8Oos0fJwkDZuIk0Z4KRqTd9e
	jtgDtiwX2RfS5GWxv2SX64hmX7gx36LCouwjC9SlsM8hOVvjaMlDN+drDYqiBBv2
	3ikTG6akayYfFofGX8YTckSIh96jD49o2bxJNkuXnD97BO+VtPOuknsGrosTGRdk
	FOCAeCX7J0lOwlcDKYnKtGY1e8d7Q9XVgTVS/9N6CP/zPoG+pL+YczRHKxtIw93+
	9I5nLx0e0kmT8WqUq6Gvw==
X-ME-Sender: <xms:U4SXZ_IfWnvebP3wJE4kpk-bLOeaNpnRGuBLoeKrasUdX2qohiqP7g>
    <xme:U4SXZzIiIRUC_ItLVBNArHe0lzaK5E1c40goIbsqf6A1mB5FGpEKckBoViDj4ISdu
    UY_Nz9WK4RvEH9LjA>
X-ME-Received: <xmr:U4SXZ3vTTJ1OeBvSnZqshT2Frnc5VtI-DBt5SaHMwPgzmXbFYgz83p2RV4OEQQqqqsXhSFLEs69dvIeLQXsN19okhLqgmZgJyJMu-kar4QWB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:U4SXZ4b5_eONcJMnEUNwvZaiMhpsEHde9oGB9zA3MXDRCeWlkZsQmw>
    <xmx:U4SXZ2ZmHblWMuBCtsJTiDfyv66SnjZI-FulShggEZDggwXRoXawGQ>
    <xmx:U4SXZ8DZcpbRKBY5aJOuzBtknmBHQlRCBwVrOZTtH8qWEMQlzB7uyA>
    <xmx:U4SXZ0bIJu6VfAAnmw3XKuiPcFedn9T8AVIknmdPP9g6t2wmGuFcug>
    <xmx:U4SXZ1ma7AK_L76I1Z_mkZEkBh-vvKnhreb1m5MgPNylb5Y9WxiLe0i_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 148524c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:12 +0100
Subject: [PATCH 04/19] reftable/record: stop using `COPY_ARRAY()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-4-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

Drop our use of `COPY_ARRAY()`, replacing it with an open-coded variant
thereof. This is done to reduce our dependency on the Git library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/reftable/record.c b/reftable/record.c
index 8919df8a4d..d1664c47ca 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -508,7 +508,8 @@ static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
 	if (!obj->offsets)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	obj->offset_len = src->offset_len;
-	COPY_ARRAY(obj->offsets, src->offsets, src->offset_len);
+	if (src->offset_len)
+		memcpy(obj->offsets, src->offsets, sizeof(*src->offsets) * src->offset_len);
 
 	return 0;
 }

-- 
2.48.1.362.g079036d154.dirty

