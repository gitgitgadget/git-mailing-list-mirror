Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F692248A8
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391294; cv=none; b=usfAlX2JXpdOZMDBWiI2WsTUKcyRbFoaSiGb7dubmJm/BKQHOCZv5uPMNAdHz+2arr12hwBAji5z/DWIWl+WM7zPJov50nHDK/ryk9TJcS8u4GSR9AgsJga2N6/kDPhc2UDaYm+LDPAYvBbw46I+iqc5eaS5v1Owag5ks1nXnY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391294; c=relaxed/simple;
	bh=sKjTvlA1Et5jsntLIW8RDg0yXjZnBl+3HtLXN/LLxek=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCMQvWY5LLsJNOuC1mJl23Wrh19Zm6kKOUHZTdOyyufTRLh8aSujAM4gSa/Smf6LFRMs8eBFNS/DYun4cWRHy28G2tkvLrIPZIElI0vr0Dm4ilYRmcYNLZEItXc7xchPiQNHr2dXxS4T6LM8uLPTV5ju4SNu3Z+pYojmGeiErBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PIzEoMvr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aK+/8mCH; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PIzEoMvr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aK+/8mCH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1CE0DEC0187;
	Tue,  2 Jun 2026 05:08:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 05:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1780391292; x=
	1780477692; bh=mq7QCap9MKjPxe2HLBv4Cpo7ckFGy2RfKNFKO2Ds9yM=; b=P
	IzEoMvr+DKj6bfUqcNGzdQk6DowBzsdkDjgYYBVI9MCi6JTtvUJ58fHSsBV9k3+Q
	1DO+x51YSPeoKsMGxpsIuqYjUJ+ED/GktQMIZvy8/bWYMhI0ZfSHkZ5Xqe+CGW53
	FxZ+fduezcJWnDuidsVbx3tmrPECGMw/tWsCOT8cp71dtL0OiEl+EFlv2rXZQT2f
	2BCwX/GySDOjEcFH/1oOcEI1EL67yMagR1O2VbI8ZcLvYQEV/lpeN436D45EDYBA
	Cq8CMKIPuaMs9FssgWtOHAXimPzKajsBeDuStLlciFj+mQZ/OLrEqWMtMsLY+OW2
	I/M476vN3os3V8CxNUC8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1780391292; x=1780477692; bh=mq7QCap9MKjPxe2HLBv4Cpo7ckFG
	y2RfKNFKO2Ds9yM=; b=aK+/8mCH8DEf+yOzb9m6kSHfPXHKGu+FomHaME5eHd42
	j1Wmkp6YFKKXj0TwqHv+oKtMT4qoefZQWDyNc74ryPGISnzavlS3gW0An+FfflHt
	ZsaKxOwQs9eAEgqlhUR8GM3Xh9ESgUpDYJuO5YbMQP1AXWrbFz21DioOobhak6Xr
	QU2Un/EOP/joMZlEWgmxXVdbdTdYHaTxdQ0EV4wxWBovBKsGXi+YSt0p1vXyscjU
	5BDIlq1Ei9SWpQ3poJ7DNEqsCZF0kjiimq7ionX5E/lrwhnawmeynISOEnersgLQ
	ZiAhy7yu+DlPUB2uxJgwb8zO9q/rhODTIe6O1H6xiA==
X-ME-Sender: <xms:fJ0eare14BoWTCk-i02xjeoZGXTN28W0NMwVLQAukIlLwbHCtGJ5MA>
    <xme:fJ0eanNoN2ReJeuz4roMCkWVT0VX-tf5ECONbvkz-GE6tBGPT9sVHrf09uwXrcv3R
    Mkota9nu1g1kI0QOvohhwFQENChv87X-WCK-lF7BtP5biF3vwreaw>
X-ME-Received: <xmr:fJ0eaiLBu6uULMEi71XH6j8Yb5_vPcFTBtn4pW3pPuWJHIOuE84zs-czeQXMx7HLXxEJCLvKwsu_IHgi3XOKRm_STk2osWITO7u8>
X-ME-Proxy-Cause: dmFkZTEpe36oI+Cbp1T0TkrUjSRW/33NwbAOzOtRozTWOC2noerVlft8G+xb2CMkO5mgJN
    1kqAiuQxacqefNwOID1ILUmni3IJyw0b2xdiGB+GWds3hyzRmnyP+tZaLF6N/TK55TURRb
    4s+BZgZSUwFRKgT+j3sxZtO1KvSPXQZzPiboyeVi0vm56qKWNFJz9jTAJTok9hrxG8jxl5
    +EmimNhtsOrQO7MMcOKwXgdVmVPyhZB9WXJ3i0AWag9M6r6bLLuSYpgsBzSTEplg8KCxhC
    aSBvn/FBr1rFEfRk9T2IbirQhMCU6vRSo8yLR7RRdTcKH1DVV2iEH20j/4Jlfr3/o7gAMJ
    ZNw+JFuoliKEucbClXeVBms4kqG6UahGodB2TFpsuZTocZeuvmU/Db1kgwfasWVtxax4n5
    WWDdLOrVAeOdzjLyscyr4c0XOzZRQPJNq/Ee6II+kVs/81c2xVYq2wA2BSo6zuobEstzkk
    RyY/u38XezybjE0bm4q0Ua+B/a9KsgoxCHOj6ztWdruh1yhpPL6WtguamnfocxaSLIBpzH
    JwSTXSAEJ5DUpDr1v5FzQLIMhktteJQeIfnEjjkZwSKwPSryoYJGpH4ba/wHStHCeXMNEi
    cCL5m3OILNFBrqx1vnHI/htgHNyHj72DuaL3gKWhv5jk5zDWWJOowyvVHyhQ
X-ME-Proxy: <xmx:fJ0eaoEQqH30LYwQRv0HdwDt52WuS_0evbLdpjKigPvUJdi5q1w_zA>
    <xmx:fJ0eaqRqFX4RGmE-_E3jCGfdlJQnVmQ7bfGcZzpon_bT4Nt29s5Sow>
    <xmx:fJ0eakGrtRE9JsJ_Gq2kpb0k6JE_jW9a1tO94gewzFxQDKuQ63fpgg>
    <xmx:fJ0eam8Dt9vkStEEFoSJeQpKBcEvZrozt4n9PBx6efZEdrwpUI2VJA>
    <xmx:fJ0eam3rLWDUmuCKytpwbmx0S-cpKjr6LgBrCYL3YwlWSm3grjq7bz8e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:08:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] SubmittingPatches: separate typofixes section
Date: Tue,  2 Jun 2026 18:08:07 +0900
Message-ID: <20260602090808.87837-2-gitster@pobox.com>
X-Mailer: git-send-email 2.54.0-567-gf25c749695
In-Reply-To: <20260602090808.87837-1-gitster@pobox.com>
References: <20260602090808.87837-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing text said something about tests (with [[tests]] to make
it easier to refer to it from elsewhere) and then flowed into a
different topic of typofixes, but it was unclear where the latter
started.  Add a similar [[typofies]] marker to the document.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d570184ec8..dec8aea4cb 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -237,6 +237,7 @@ Do not forget to update the documentation to describe the updated
 behavior and make sure that the resulting documentation set formats
 well (try the Documentation/doc-diff script).
 
+[[typofixes]]
 We currently have a liberal mixture of US and UK English norms for
 spelling and grammar, which is somewhat unfortunate.  A huge patch that
 touches the files all over the place only to correct the inconsistency
-- 
2.54.0-567-gf25c749695

