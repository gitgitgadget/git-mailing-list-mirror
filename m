Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A05314A8D
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055282; cv=none; b=sZ6XltqIC6efjDK0YaGPacP/gGhtJw92gyDE6mOJB891ZX2MZ/MQ5PkVjZXyaEmKn0Zkb3kYVeIQII9ZZlxM6TIX64BQu/f5osOdE/pIqY2DGFBQ9Uyj0F14C/jtJielsvXEKcW5hHLb4uK2/OgpKZAiEMJfHDaGhzC900lWBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055282; c=relaxed/simple;
	bh=c9i4ao3tSq92IjRqPTOfSLhXR7SVmcHJhk8hcjgCX7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yn01ptRBh/alxvQEH0DUP1OcdwfFJytuOOiBE+88dFMcmAhlf4tYVHWmY2u+3UrS27j0cw1OzOQRKMBSzgcBDp5ytAesmnEuxD3yUmdDKSzNFVJuyshB3ThFmtg2rOfqP8PgAkz4zx48wepyfNFXSYxsDG1Zf1eRJwd5cYSGjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dI/QOd0F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DtxeCJXR; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dI/QOd0F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DtxeCJXR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BF0D61D00015;
	Thu, 18 Dec 2025 05:54:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 18 Dec 2025 05:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766055279;
	 x=1766141679; bh=rDr4FHG+sBxhKqLN8p3nb1gEnHqUbNeiE/gpIQfCDfk=; b=
	dI/QOd0F0zSaiStb+nkhh20OQ+mj0NSuv3AteNw8XmFXPag9BIdyaSu+/jlEW/c8
	hedEZHFcDE2BfyX3lwma/0JG9rEGKXVl5HjfsvxsfPas0Fvx+Qcq2UODheG1fmWe
	K1l/0EOSpXKFmfwZzrGHMp+mn4Zd1xT4raPmp1uuFF5HUZjFGZMYF/KxJml9CNPU
	r524/+9hRPCez7KpkIjxs/u+HHEHrhDBYZjSlwLyzhXfT7orM5huZ0FP4T5Jqcy2
	KqDrNRAONHIGW+uX/KsZWa1THdH4k8NaC04wX1df3J1Ts+4HtFNBemO9o+7Kz/zs
	EKVF8tPV6Yl8u8j52wqdsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766055279; x=
	1766141679; bh=rDr4FHG+sBxhKqLN8p3nb1gEnHqUbNeiE/gpIQfCDfk=; b=D
	txeCJXRAWx/EUekshzAwIx/LOvhLdi8irz7w99VA/MXBqpBHAb6PUzg29nj3QzQ0
	nvk8cT3z0y5d7sGGobbEQl6cYiO13tVB3fca6PFQPPB5qVYVUB+DdAZXUCJ96dVK
	b2foS6uQnH2b/4p2WsRQCpXo+RMfHH+Xx5uhJTgfHYdcvh0BguFD79VXrn12jUQY
	5spUI2+DSaHyKz6rtBkAtrmAqAVwJtcCzzYHz9nZmXbWcGlWQB9oXbwg3xrmlIho
	Go0e0RtCDi/u9Xq9haF3ntW6EvH/f3vPsaIc3epm3PGa3/wvgHDxd4Br6q2YL6SG
	XOY/pYfasbUNEZxnJRMlg==
X-ME-Sender: <xms:b91DaVKMMS4-R-rFWhhuBNxUaDAuji_u779i__AXsIDjR_uUnetQ-A>
    <xme:b91DaYlilFi0PIVoOgaibWsM6Oetzqo-gNT-hBPWZC59b2nNiBPaG8GNcOqEV5JKE
    ktqXxoIhwv_w4Gv9CTVA5VQLU167E23LsgwpXWeh3mc-LZrxf51gA>
X-ME-Received: <xmr:b91DabESf-DYUg3zrYhog_u8R2O0a9JA7YxVmYv43Zsinp0KH8VA8uiJ8ljhUYalPw2J2SMtS-ba0Va9PuvCombzxYQl0jh_XaHZLB4uBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeghedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfefhueegleehfeejkedtffehvdfhvdetfefgtdduffduveevteegueeutdekhfegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrphhlrghtth
    hnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:b91DaQF_3GIRrJrOQuCSqZ-FbhZ9so_DHNrndA8vw_ksqFwNs_M4pw>
    <xmx:b91DaQN1So8ZvdSmYZ-ZRJJ1p9KGxXd_lZ8WBECR_MtMoSH2X6xO9Q>
    <xmx:b91DaXEFKmtDlRmFjaSUTmFOOSjjCteKCG8LfajQRseZSW1k07cyQw>
    <xmx:b91DafPgxtEb42lARZSkaIRVXLfNMSDlMZrAuZq1DdPq7uxA5bRIQQ>
    <xmx:b91DaZtBnbEjJosEhoWn9mgmNJuJQO2szoOg5R7DTtrsVadWozTmxy6r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 05:54:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 115dd386 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 10:54:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 11:54:18 +0100
Subject: [PATCH v2 6/7] packfile: skip unpacking object header for disk
 size requests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v2-6-62e3e49072bc@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

While most of the object info requests for a packed object require us to
unpack its headers, reading its disk size doesn't. We still unpack the
object header in that case though, which is unnecessary work.

Skip reading the header if only the disk size is requested. This leads
to a small speedup when reading disk size, only. The following benchmark
was done in the Git repository:

    Benchmark 1: ./git rev-list --disk-usage HEAD (rev = HEAD~)
      Time (mean ± σ):     105.2 ms ±   0.6 ms    [User: 91.4 ms, System: 13.3 ms]
      Range (min … max):   103.7 ms … 106.0 ms    27 runs

    Benchmark 2: ./git rev-list --disk-usage HEAD (rev = HEAD)
      Time (mean ± σ):      96.7 ms ±   0.4 ms    [User: 86.2 ms, System: 10.0 ms]
      Range (min … max):    96.2 ms …  98.1 ms    30 runs

    Summary
      ./git rev-list --disk-usage HEAD (rev = HEAD) ran
        1.09 ± 0.01 times faster than ./git rev-list --disk-usage HEAD (rev = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 8c6ef45a67..a2ba237ce7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1586,7 +1586,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
 	off_t curpos = obj_offset;
-	enum object_type type;
+	enum object_type type = OBJ_NONE;
 	int ret;
 
 	/*
@@ -1598,7 +1598,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
-	} else {
+	} else if (oi->sizep || oi->typep || oi->delta_base_oid) {
 		type = unpack_object_header(p, &w_curs, &curpos, &size);
 	}
 
@@ -1662,6 +1662,9 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	oi->u.packed.pack = p;
 
 	switch (type) {
+	case OBJ_NONE:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
+		break;
 	case OBJ_REF_DELTA:
 		oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
 		break;

-- 
2.52.0.351.gbe84eed79e.dirty

