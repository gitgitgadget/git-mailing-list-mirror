Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975F1547E9
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828346; cv=none; b=oiZfjBU/lyHdpwXPPWhefb5VtSTqgNWmPQBbh5y0l62bBfDXBnerfQ01gUZKU5krq4Mdde22xq+jnAJ8Xf9xSndqIFFJQ6wdtSjFUB9FKxavLT7YTzz0RaWwda2dKTKoP0lQ9eeU0Ok02c3p6N/wJbKXZYoOnvTgg2LMl2AE6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828346; c=relaxed/simple;
	bh=+sfDFJ9ndI2wqkFzPAkNIaU0EeKHSdWxl33c5nvqNz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGhK5quyhgVvlsggPP7FBB1lSeZpZWmA5UJkJrTliFCzgXuUURpSH0lafYe7woqERBFexQ2olWNIK2f42PJ0kIm7sPscDPY6qlRyaFD/72a3EI8SXHqtPIc1vpypv1Jw9k7I7mIKfCVY0SjwIIe5KC+XK6Ch688g7qqZpAY9I4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=og8N06lD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ct6oNdpS; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="og8N06lD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ct6oNdpS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 398E11380221;
	Thu,  6 Feb 2025 02:52:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 06 Feb 2025 02:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828343;
	 x=1738914743; bh=C7QV0kCJ4r1t8KXYpuFP34bogFrxND3jDhV8HS9ZL3s=; b=
	og8N06lDR8OGXZxgXOxC14gxu12HCDxnj65iFLUir3l3cmr4/VXgJig0pIy4hC8E
	7TUkwGBsB09up0D0PRyDTGApydP3RN7lr0UeSIriUdg16vjt74IPcQNglGqFohkn
	9H0il4jkvclVRtht8vVyQN0Y7P9v8JY4X9VmUPMDiAdH5TlfzNuYgxFiQ6LN/gCm
	6GIddoPTebN1jRYM5BVpKDnL+/PDbl8+B4TiMeQVatQqm4Ac3oQ7/6hRDQYE6icA
	PdsrATinNJk0uP1Km35d2umd3gjshzG66vwOehA7R/dyTHwzdd714lrUc2ge1OYY
	HU1mRsTAFHQjuAewngq3+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828343; x=
	1738914743; bh=C7QV0kCJ4r1t8KXYpuFP34bogFrxND3jDhV8HS9ZL3s=; b=c
	t6oNdpSfTvvb+qBSw3OO0wwsPAw+pVSQY4pSBkrWCQAl/Ewb+S6w4GkKQW0EhDOy
	diHDrTkjBH+wDI4Qm4vgcWmM74fP1Eiw5m4dLuKeQplsIY7LRJlDHxdrFNMayocB
	Dmhel8eNPSLetgsHonaVjOCOFuXPOkPlABL91xgszD3B8734r49HmowKvytvmuFJ
	06IF1M/UPefw1NhXHT+nBsrQjHI3b2a0AYpW4ot5TAuOpE6PptXO/N2ZMpCciXYx
	s9VQd4XWX19oktEf/LokG2qnIhEN16iGWYwijoYPH9HO03RFK8bXXfcotgLBm160
	xUPVM1ngV9xdgtAqkpJoQ==
X-ME-Sender: <xms:N2qkZ1d0Uofxx8ap6Q2kfnpyfLUeOn9Ub324cMcVswMqecMoDL0V-g>
    <xme:N2qkZzPPy6wPugXgEznrX5U2P0iHfy7R2pRvDz3A6e5v3XzSSgb0SyEMOODqS5IFT
    glI7MejauU79sZx_A>
X-ME-Received: <xmr:N2qkZ-hiU-NgmyIbQnFxgElLrYI_HPbxI7uZfu-x-vgvz-WWED564cKwUrw-9WV_Q8KvlaT7aTxJSPcoGi6_JlJur_l1s5lBFTrvBVRgFF0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:N2qkZ-_4IFjqxeuPHlO6f1qCfUljPvYYfOh4nkQ6IPsIO1RCzKlCZg>
    <xmx:N2qkZxt8SCB5HpyQkE03iD4vclpyX8MFhFRzZRJGajLRF7NL1z5reA>
    <xmx:N2qkZ9G1JzKDrU5jnNkbvFaBpFuSzCWeKc4uL1H4P5muNb3MPHD89w>
    <xmx:N2qkZ4PBi1Wsz16lwLkVefFXPJYV2tIt5wvkR33SfL4XAkQvXZAntQ>
    <xmx:N2qkZ_VGcV5qAb87hni1l0UopFVdm7ktenpiycAY5crFZxDXMfOtCVYO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 682c871a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:06 +0100
Subject: [PATCH v4 04/18] reftable/record: stop using `COPY_ARRAY()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-4-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Drop our use of `COPY_ARRAY()`, replacing it with an open-coded variant
thereof. This is done to reduce our dependency on the Git library.

While at it, guard the whole array copy logic so that we only copy it in
case there actually is anything to be copied. Otherwise, we may end up
trying to allocate a zero-sized array, which will return a NULL pointer
and thus cause us to return an `REFTABLE_OUT_OF_MEMORY_ERROR`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 8919df8a4d..2c0cc32cbd 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -504,11 +504,17 @@ static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
 	if (src->hash_prefix_len)
 		memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
 
-	REFTABLE_ALLOC_ARRAY(obj->offsets, src->offset_len);
-	if (!obj->offsets)
-		return REFTABLE_OUT_OF_MEMORY_ERROR;
-	obj->offset_len = src->offset_len;
-	COPY_ARRAY(obj->offsets, src->offsets, src->offset_len);
+	if (src->offset_len) {
+		if (sizeof(*src->offsets) > SIZE_MAX / src->offset_len)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
+
+		REFTABLE_ALLOC_ARRAY(obj->offsets, src->offset_len);
+		if (!obj->offsets)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
+
+		memcpy(obj->offsets, src->offsets, sizeof(*src->offsets) * src->offset_len);
+		obj->offset_len = src->offset_len;
+	}
 
 	return 0;
 }

-- 
2.48.1.538.gc4cfc42d60.dirty

