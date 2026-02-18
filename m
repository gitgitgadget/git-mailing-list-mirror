Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A35132A3E1
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423759; cv=none; b=q1DhnKLOfNInB1dZL4JbfMufnPyy0LQDAmKocLvIf9PHlVRDA29+UVkb3OMazS6ETFMUl5b6YgiDDgajl+ZViccpDdf9a2YyUyaIIvd6//7ncW4gMmW7M/BN7nsspFZl4ekMlmxRU1ZdIsAuMHEHP2DpvZKZo3QRugYHocBhXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423759; c=relaxed/simple;
	bh=pRl01NYurgqIHzAv4kMIcSp3H0FlBnNMcNsX0Xo29jU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rBxPhv6E/8PaoyFHgZnCSKsMJtUC5SNANALTfEjDxuKAdlHpe1rqepzBmvsCEH6VFJwVirQsLPNL2egaalyGRTyS2Pil599a6/jnT5MVynh4lw5Jf/6OK4e/rROS4frjWESggxMDI7/PxwMWInGU0Ga7sii8ToqnSyi5OTqZG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndjAUhXG; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndjAUhXG"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12732e6a123so2067342c88.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771423757; x=1772028557; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLZNDWkTTA0heUrJ4eo8L2rJ+QzFCNvuQAcUnAZ964Q=;
        b=ndjAUhXGWR3tmi2ZimUsDIxlZiLud8YurD7AyMqBntWcOvZRHcogMxZFsskcdwqKC5
         TNMXNCZum4rJYk8olKBbVYtPzBddJYHyi3iWpmCNJtNSOsVYiSzr/1dBfrUrk48s+5ub
         agYNXH8m0auDXda+r6kKhXmcCoBFuDsnAYLtlXk+UV8Zpui33M4yu1zf2r/aVKlDAzP9
         T8zzYucQmtHinIeWdb9tPbr08eTf+Az93VX9rRtR8/Xgbo36g1A34K09oGFqRozhQNsF
         fSq+pfAdRl8YmqwznF23RIpjmpxPiUcF4gguBZTZNnyZXr18HOvr2qhlS3EYOPmoUo3c
         hgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423757; x=1772028557;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tLZNDWkTTA0heUrJ4eo8L2rJ+QzFCNvuQAcUnAZ964Q=;
        b=iSYJMshHRirXSwEVRj8u3gIjmaAepoOitgdJMYoZJPXM9EL6h8BFfvOirvyUqly5yT
         hTCTC8TaVsgFUTQ9E74DcrmNa7TcWexqPYBcmCcWEj0gY0zUFeRiDO6AdEcoyF3ufMgX
         IRbTEPAmdKUOWjiomy++xtoqYBFuEUTP24nNJGl31w4A2apvi30UoBCYWdt7eLILArUb
         SprVVkH/+mO4usfmFkZp3upWg6R5MbxXmGiKR6PtxpuZ4AaYoi8AOPI3RsOINq1M5obO
         WqQt7NaCY1luXyzpDMVrWKRGWh7BbdaAuo6obE9I9e2yx1SFzuBZjudArlbVYEm42dQD
         CRnQ==
X-Gm-Message-State: AOJu0Ywiv9tVj29iAZ+Lks2msqMeAM7iTtVst18YEP+b6jjDg2E6uQVA
	7zbbNK2PGyA6SESTpHzwpdEILuzdoqCSxUcPK3NWh+Lg4l473AkmdCwC/fOzNaqI
X-Gm-Gg: AZuq6aLQpYIDTgvJ/i4QxLboeW/c8uSXGdsbkmHkEGdX+17F0D4tAnaCg1aYbweaBBV
	dde5p8HMQbL132wouOBLYy43c6OEWW7e3TY5fCV5W6x+Y3fjP2g4AQAr96jCB+u5fix+2rftLGa
	BC4ddKd42K1sJ2ePxmhE1LFHJMT2AvTU8CBazF6Ak1nPHJSLEr4Lcn+tvZRYYkZKGkpKM+AiJ2O
	RR9kAcW8xy5HbEgWt8Ik7Bhvngwimqr8ogWcM8PvbFz8HNstFXnQ1emU17WTSz8PBfGic4yXyHf
	f0auzDWCS7R9yTeVmSIdA0kwPP3It3TplM56U7p/MuU6UXNzpzwYL9th53La4AwRupydIAxxNyu
	C84Sfntr70M0UIOOf3JqNNPFUdn4XxZKI3e6L/BDqsGHUnWCJHIUbWDk0XWjzKDNz6jrKRVivQj
	bxGsPpnm/UVk6cEd+EkxaTDkNQKA==
X-Received: by 2002:a05:7022:e05:b0:122:2f4:b247 with SMTP id a92af1059eb24-12759a61101mr882698c88.28.1771423756745;
        Wed, 18 Feb 2026 06:09:16 -0800 (PST)
Received: from [127.0.0.1] ([52.159.225.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cada1csm18446756c88.9.2026.02.18.06.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 06:09:16 -0800 (PST)
Message-Id: <557fd77444dcf68277fea7c1a57dae07b2ec993d.1771423748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
References: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
	<pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 14:09:06 +0000
Subject: [PATCH v4 3/5] strbuf: replace strbuf_grow() in strbuf_attach() with
 BUG() check
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

strbuf_attach() documents that alloc must be larger than len, as the
buffer must have room for the NUL terminator. Replace the strbuf_grow(sb, 0)
call, which was silently reallocating when alloc <= len, with an explicit
BUG() to enforce this contract and write the NUL terminator directly.

Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 strbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 3e04addc22..0abed40c91 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -95,11 +95,12 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
 
 void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
 {
+	if (alloc <= len)
+		BUG("alloc must be larger than len");
 	strbuf_release(sb);
 	sb->buf   = buf;
 	sb->len   = len;
 	sb->alloc = alloc;
-	strbuf_grow(sb, 0);
 	sb->buf[sb->len] = '\0';
 }
 
-- 
gitgitgadget

