Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792C230270
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870522; cv=none; b=KcEil4H39d9x4G82QkK2lFkeqGXdU2BXiu0FIxK7K0/OScIyXILsgL4qonX0MTXN20kB+CPzjahoZSH+QQFQMd/q6rxpnTSrk7USTX2L3mITv6LRW4QGq/7tz1iaG/KDKOBHlAM1/64C4fzjARpl1wVLDuOuV42rCsQQpa8VhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870522; c=relaxed/simple;
	bh=3BhrIJFmi0Chvhc4MDC2MnVyPQLoZEl7O3B7rNetH3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZsiyjqPnAZnxEsjiCsrRxOHGsuFFIXRWj0hLmaTL3JJ9DRvAtLBJKih7wOjLeqTmA4o/WAnDXpm94O+7mIQlKRERYb6UM+3qDi4MCBY1bW1Z/PMyvkf7LJowbXfwLvXrJx89cLD7Om147k9QgT3ywfKfA4C6+bJsqiXr1z2cik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gohZbJp4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H5Zay+VI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gohZbJp4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H5Zay+VI"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07B971140278;
	Tue, 18 Feb 2025 04:22:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 18 Feb 2025 04:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870520;
	 x=1739956920; bh=KwchYSptkJ8p41iI7ffiW+xLaALCvYacIMQyZn5B5fg=; b=
	gohZbJp43lFjjK3xddFkGLsIDZShZM+JUsLXoe9U+x+fz3dUhLV+bgvn837yV0cp
	JWKVLXPayJLLDzC6mNeIV/NDGxJgVrKa45VczGrPUCETPsJOVpfldxYKGfG4SpX/
	4dk93pKFyT0r/AsX4gED94koF4nowp539Mz5WVud8KUSSAI6JSUdMGPSVnOwsMtv
	o+zlZpFhLUSRem6wfUpjDjuOYyFSNCU5rDuzzfK4h6aQ8wK7jpBgo8b4ruejFFuF
	aOSJVzyNUspKR0pp4EDmPGItRZD5C6JMxwwTfTaTn+gZbjbxepEuAIZvkqJk+hZO
	pzrfYSGp8yZnMiU4PACdew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870520; x=
	1739956920; bh=KwchYSptkJ8p41iI7ffiW+xLaALCvYacIMQyZn5B5fg=; b=H
	5Zay+VIIJS8PhxW4m/z+LloYxgfzKFMCuospaMg7UV5V/9GthP95/MzQ9jvkuZki
	xm3EelC78Iuboum11Wad7PMwEb+1X+L1sHjfY1iOcKXjA8+jY+ykZq/m7NiZR6JP
	UR1p2NAYJECyn4fnnskaI1fTuKsSte2N/e9kRMFgzCy0958++liDd68mVtze+IQ/
	us1ks4CViyCH3RVU3qGBylpPMBTsLFezC7IrUbAIUumqeRXBh1ibvPUNKa6f8r48
	VEl0fjGX+uxbAudEV4FpRPvqaL5rOAsMHaqXs8T9l26Bgs/GX2SEnNgH8rg26vCA
	fWO0HvkUZs4iAYoubAzSw==
X-ME-Sender: <xms:N1G0Z8ij3c55sn3AgkoJqkI2wxh4IEUDOAUtFnPH0z_8Jm0TujwNLA>
    <xme:N1G0Z1CI2uklQ9ted_cJhD2PfZt9uW1qCZRdJ6Zt7gYDNViQD0eQ7j3Nevq35FzII
    8ww1njrwa87b0mH9g>
X-ME-Received: <xmr:N1G0Z0FCpOkIH2P4s5X-NZb9XUhhP910akp1i_ZTkz5cpTA1iWZvz2ShEnpIh7q7UXnijtlqAAKwzpyha0o3qlUMcvE9xBkPh8jRz6IXLozto5tu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:N1G0Z9QHRsWW0uid_5PXe6ssspGZDqdQmJCYabDO-AsNO-cplgsGyQ>
    <xmx:N1G0Z5yRjTXEZs099xmd1BY76Iv9PkXqe0AfmY_L_mQXwTkLMrv2Fw>
    <xmx:N1G0Z77DzwK_q-wC8RjsGsbzdDA8vK8XeZuiHILMlOxH2QDTY_yH4Q>
    <xmx:N1G0Z2ydGIbI-kpwNSbYSAKEhrq7Aeo6eIY2yXOBvdO49pE95fe04Q>
    <xmx:N1G0ZwmLmyOSCmTsxJuHTjGN2FNLQqijOyOmz48WHg966zu47BP2qQBb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:21:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a49901d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:21:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:40 +0100
Subject: [PATCH v6 04/18] reftable/record: stop using `COPY_ARRAY()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-4-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
index 8919df8a4d3..2c0cc32cbd3 100644
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
2.48.1.666.gff9fcf71b7.dirty

