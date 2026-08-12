Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D03AA1A7
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521815; cv=none; b=qZ6rmus7w5bR6Y9/2DyRvnc0wzVWhU39TCBywufzOTRWww9gf1+wo+segAlA/Vn2Ti66W0h8y4LNmv407b0+JRnvrifKz6enBG5O9IPWUmHUGsNMAaYOsHQp/PzXCa8txRPXdASWlDBa4RyWbXhOCFzumNa0t1drtUgkms6ysvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521815; c=relaxed/simple;
	bh=uRuYthnJDMTqKQkNBgd4fICcRC+8uHAx6hivKzOfMlE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DlqJrq1hsdPPUwSx2lnPkdGv7pl3eKnjWznAaGJZubqfF/C+7jjHmSdeanPI3AgS5mKyJJujguP8pxat75ue+ZEA9NY2HclgsdYRqVnQdkTDNeYWSDBX4RCsqutPatyQDim8arfL4+WmpvYaOEg3qYMwXP/nq3nQDgAQlv3yn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYHvTFS7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYHvTFS7"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ced3386430so9374855ad.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521814; x=1787126614; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V7QHbyGVJaI5QAVDQFTr8MnHSnlDO2cYxj6P/c7BdE0=;
        b=RYHvTFS76ZgyvfMW3lRzcaCMp9gOLyeXH4TldrIHjTj0JOi8dFz1tMOrJOJHjDbx2r
         L721pjwfuT1NBbZlMVvho5/7R+J9xSE0oBnpUBNWt3c2utMrZVLxH+R7yX7ljfjpRyLa
         Z9IuZjEVFqd8AwFWo9v76+csm6fP2+4v7B63EYTLVHysT81V0pnm0Rpqz7zjySNd587u
         ma01VTR1yoHOaXJzUHWnbN+f5DANBqbDs0AYLCJxyftSEgjsK69VPHcpHTN/20eNgtTh
         xDUCiHS3P2N9pcDlVarhlDFjtV2sCfhJmzfqBAxtM+d2YZLcW/pxNSBdizHY2oblUPg2
         5cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521814; x=1787126614;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V7QHbyGVJaI5QAVDQFTr8MnHSnlDO2cYxj6P/c7BdE0=;
        b=qngJ2VdUEW5sO59wMM3C+ZKQ22LA5UBRT3DG5yFGLLO4qGU8+uFqim3j5TCZdtel3r
         l0hU5HExP/7DsZ2XXlleYffbL4fHHRsIOYmbHL8X6oIQspQLo3Wtblln2x+aKgS4qTkn
         qmKMtbHeu4TIYKnKOegJJ5i9nct7Y1mLxCdrJ2Lxmc3wEXkTO8z40QD4JIhaRDEKTyg7
         wsp9YHivhQJhEJHO/FPtOCTyCnA6t3j7lClpoANGZH1z7HBwciGIzoDelggythUiFidq
         73oQ3nGr/CBOcGaJBCZd3NDOicclbsQ+qyNECarHphlw+6zDXvC9vfrd5ZJPgO6CXz1J
         C1og==
X-Gm-Message-State: AOJu0Yw/E548rHkiPs0hwRiGpX71fTwnSqNeCLh18rhSVBk3giENj8+O
	l6clrvd4LGqhkSb/RCx1WUuw4I5Xg3zWImI6jrnXkR+hzro4n70R3I1LsPCpZHcD
X-Gm-Gg: AR+sD10aCkF553B1ZsrUNAkyDh5vFAwxfVA44bIYGCLnA41s9VVu0mlCRbGVIq4yVvL
	r0yw4tycKI6vXdHp5cnDyNvBmhDD94bbVtUc2X1KxUO5bTsjSQrrB1mCUtbTX6uPIJkVrzMzzqc
	yCdP1U9irNte+i39S7S93juXVasp4lWnJvf1SRQHrVoYJczzQGt/liOuztOIj4Ri22vDmRIqai1
	NsHuvFfL292lxfxsg1eugnlyMDzhF/Objq58ShOVoKGSj23UXsQkCBFHZoc1mHGkCRW82Bg28Z2
	59G0Fzwlg+LC/eUypgi/t9JlFC5LcO2TEKm/ssaoyG7zGS/SjhFm+Q6Kpfy5WeUhgSFZ20rnegA
	YnI3vEXDJze6P1PBf7hzRHs7dD/1iFvxo+dNMBG59Qx+BFr0i8mkGKYXNOLSudt0JvdBk8pgmUc
	O6xTTSMVzqLShD8PCq0UESm2UlrjF+sXr0gbUUExHNoWPudyUZKxGuc+gkLww+vA==
X-Received: by 2002:a17:902:f68c:b0:2cf:ccc2:6088 with SMTP id d9443c01a7336-2d3452b0459mr38147335ad.4.1786521813632;
        Wed, 12 Aug 2026 01:03:33 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d35219da19sm2928185ad.42.2026.08.12.01.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:32 -0700 (PDT)
Message-Id: <66953a65d0a3400eccce197524225a0f71a584da.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:12 +0000
Subject: [PATCH v3 04/12] reftable/block: check deflateInit() return value
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

block_writer_init() allocates a z_stream and calls deflateInit()
to prepare it for compressing log records. The return value of
deflateInit() is silently discarded. If zlib initialization fails
(e.g., Z_MEM_ERROR when the system is under memory pressure), the
z_stream is left in an undefined state.

Subsequent deflate() calls in block_writer_finish() then operate
on this uninitialized stream. Current zlib/zlib-ng versions handle
such a stream gracefully, by returning `Z_STREAM_ERROR`, so in
practice it would likely not result in catastrophic error.

The function already uses REFTABLE_ZLIB_ERROR for deflate() failures
later in the code path, so returning the same error code for
deflateInit() failure is consistent.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/block.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/reftable/block.c b/reftable/block.c
index 920b3f4486..c12fedc5a2 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -87,7 +87,10 @@ int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *block,
 		REFTABLE_CALLOC_ARRAY(bw->zstream, 1);
 		if (!bw->zstream)
 			return REFTABLE_OUT_OF_MEMORY_ERROR;
-		deflateInit(bw->zstream, 9);
+		if (deflateInit(bw->zstream, 9) != Z_OK) {
+			REFTABLE_FREE_AND_NULL(bw->zstream);
+			return REFTABLE_ZLIB_ERROR;
+		}
 	}
 
 	return 0;
-- 
gitgitgadget

