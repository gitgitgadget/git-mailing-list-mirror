Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1393C4563
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101188; cv=none; b=u2/OywZ2E4W9jLUaEtGKAm97vlFakpqHY1NlFsoALVR/JoWsdpI/Qd4x9uCxgxrN7DUIcSlRMOUVX8QZrt48v549eAZZC/MMgVTxM6tFkEdiYsJ+zbFLFN+3dJ/2sunYZAx7T+5XLzNzoD5b+dRzlL4QxK7YQLulyG6/T8rRUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101188; c=relaxed/simple;
	bh=dO/pAeL0jWM0kANWqPtKsnLSIDh39hY1RgGTrq6M5tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h6rsNa2ZsdM8Umr2m3eX7NxnOO1a836SyllwfNciPyqZHm/IYzN9vxKv3c0kBqigKcrnbIm+NZ0g9m8gK8TiUfmcpddjNnF/bG7NYtuwprnFCIDDCGyFoKRiVLZr7H5Th1Q/WoASAgXvIaVTjCCgfTOATpy1mRk3kAkKMQsnRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IeUDRl9E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QMRwzjz7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IeUDRl9E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QMRwzjz7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E85D1D00124;
	Wed, 15 Jul 2026 03:39:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 03:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784101184;
	 x=1784187584; bh=O/rhcjCqMJBB8+D0aMwoThQTHGiW3MQc0RfcbFmt+ik=; b=
	IeUDRl9E6HZXE2jeiLEM3oMaj0Uz/CiGtuBz7lEb72DRvqMPaaIF7udEh8z58y4n
	4WnWy9mMBttUTgjg7BlBMr4fX2v26BxUey+0QMwwDgn5o/7o4ejXudwgNJsbG9BF
	hQxuKpUYhZBMrmfiQMFcnCcMEG7WwKuP6eYsG8BW45VggWxaaQJpPkqiAE0u5e1z
	mPEU/7ORkYqMTkPlzZpEENt1a7YsIxqPHb49b6Pws2XMrW2mWnMCzhZVBk7Zqn5W
	/E+dRQKlWI3Ed3w9PXG6ePudN0U5MHc83YclsnfoHKEF4GHY1TYnPkshhpcdbnCR
	UzBhYx0GQz96ljixUhSsPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784101184; x=
	1784187584; bh=O/rhcjCqMJBB8+D0aMwoThQTHGiW3MQc0RfcbFmt+ik=; b=Q
	MRwzjz7EC8H0LfEQG+OqSOgBf2vgYrm1N/H5QMC4aOivV//sQ+/RJoyMVCPAEnh1
	lhlJUc01KlXu1OJsTmlBFPC1v7QTdUR1jAluPRmRWxkuxVbawecL4TtcaULl32FP
	ABljTw4l9q4kXJseImYpnD3Mjn0UBOWAOMq1p4iJGuGFPAhoKx0iZ0EpvN1wRjgb
	VfIIEC75itU1b1Nv0ac6my3cMQYlkFqWlnY2r/VTl/9itOG7v1OqJg4eZmcA21Hs
	4ozn7d75L4W9tP/ziJ6WnlUxhSqJOXE726ljsqmBoV3LZFB0m3XlKS7IQu06fPT2
	ml9aIxjkI60Q9Qm8SncKg==
X-ME-Sender: <xms:QDlXavxS32i17GdZIzy2J5hUF_12TEFwZo9ShSJYd0BDAHyrXrPSrQ>
    <xme:QDlXatRciCwhmIQj_ErRbQMHG-98OLQ7BcS-xLWxrZHEWR6iYMqS0bwIC2SdZGEeP
    TwThW-fBcXdUZiXe1PY9OnbIsgbvvAAUhMyn27SsN_U5mt59gP0ZA>
X-ME-Received: <xmr:QDlXam_0LhnoSqRgW5TsOlEJZaL0ZEe2DjWCEvRxvS-Nr8vRtPcKHada-Ehy63vD8kmJv0PfYQM86pMFEtzCL4wyue5BAxQKnSHfJ2FTbTo>
X-ME-Proxy-Cause: dmFkZTGK3e1xq10g9H+eaI8Qca7IIpa67ANoiOnlBVJnvZo9C1IvtIQiKmonJXHo0c02+G
    5ZqJdeFCWDuNinkqdf9LW+S5rFn/XO0RZb2l4qfJXhxtO/kNxi+MhlQ7Zsr/7hc5EwzrBa
    jZjUayygEG8Bfp9r8u4BA7lQrdE5+2R9wKDRb02dCwg9U4zY3tnxdNdUNBbauIbxmAWco5
    fP//QiR8VIQ1qcx9jsqkMD1IiR0ygxr+NwzVjNVjOtMOrEhKmX7K1H49k3Y0eBfkAGep+X
    OM5JZzWWukbyXy2Ez3SAgW2ZLfjX/RhhSFgM8/c5+aevfNfgNdFSMJ5+O1JeinxMWvOaQs
    LVZnQeKNrWJthZzVseYdNgGVgiDJc2+3j9janUTs/ceLsLLVwImFfY4GG/vi2TBo0fQ/xZ
    XW7PxPsveOh5ZAhlKVtuL8kf+oJjnM1JwaCCT537VBEu2fwkTY2nU+p8FQCmprqSLNy3rU
    KVJBI73INypNbUlVmtVK4k5Q6Qaun1msAqRofZjLkU1jPe8E/LgL7azVRSRTaCBxsWl+eI
    eIu0paq6Y0d5DnvI81vI7PCmd/n6+XdygZCO/TJje875Geql5YSzk4tNoGw86GMnLLEoPS
    DWjpPH7TE0jOI3R4uJg/m7cr53sbE7KfH4UI8K/6EFX0cv+w2PuE3WX0HChQ
X-ME-Proxy: <xmx:QDlXakoWyKiH2-F-ZYo-pFepVDLY6t_yZxes3K5lDT69ESPO0B6r8Q>
    <xmx:QDlXajl3NkMtapZXXjk8MjG_WTdzAphDrz7TatHub4gLnAnz589Gsw>
    <xmx:QDlXarLkcYHMeg5rQCisiYrQrBa58at9bXnozNga-I8lODXc3YDrPQ>
    <xmx:QDlXaoz-onweDVLXQykLqa9Crc_TAlbITxL2s0iPsj5a0_oDFMv-Hg>
    <xmx:QDlXajKPpZzMGtV3Q1XDflbtfhlleVly7SI20BGgdjNY5eo7XGwnSlOQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 03:39:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd4034a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 07:39:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 09:39:35 +0200
Subject: [PATCH v2 2/7] refs/packed: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-refs-wo-the-repository-v2-2-d00d364f5a3e@pks.im>
References: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
In-Reply-To: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

There's a single user of `the_repository` in the "packed" reference
backend. Convert it to instead use the backend's repository and drop
`USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 14b27d24ec..c5d96793fa 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "../git-compat-util.h"

-- 
2.55.0.313.g8d093f411d.dirty

