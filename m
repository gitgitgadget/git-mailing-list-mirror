Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A895200BB8
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983075; cv=none; b=CYN1Ua7H1bQeRfdoBrAe0np+Mye6wT3+Fo3KVGqVJkxDCebxG1w2P9QHh2vcY4DYKCfW32xkPPMkJm449zAP+wM+mYyaji/WSt2SuifcbFk37s7Tx5td81//lI/RSJ+cbfmh2qoPlOWwKn2S9LgrrG0AMXoV423wVKN1B4GRQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983075; c=relaxed/simple;
	bh=+8IM53TbqpUgRfB/inFpjOz9489TvwK+2iXKydpy3II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGaOmLqlV47+Zsludg5qHN5I9SVX47YftErI2wIzmXKJoFreyjEE3HnMmLGHW1V3T/IG48SGEKqGRd4SQrz4BLcIZ6AO/7uW045gRbOn5imlODyCXE6yb9YC+2o81I7UVr5F/DRr2xqNm7tbBsTiIfyIHMpr/dbcPL9xAXhp5R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bM/BUr0l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMlzQAMr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bM/BUr0l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMlzQAMr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AF6E11401B7;
	Mon, 27 Jan 2025 08:04:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jan 2025 08:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983073;
	 x=1738069473; bh=fZf1W4LUEYyZlqON29LdWuZDASC2Q90kB/sAd3jZi9U=; b=
	bM/BUr0lnEBSUWwaOb1VXgno3E2zaTIT9YyzLI6nlsAVa0eYh11533RuXj3KLM8r
	CtUwjsAKPu60x5Sg634lLbaR3VY88woNGRJFWvKIKX1x4hqxUa1dj6S9gMtgzbrL
	MCekThMdE3HbzX9JyMYkWqkKmModGykR31I3289QD96U2rvcpm+fD/PWkjUpHH1K
	sNW/4o1ADYMWaM4RagNHHr5fX9T2HjSekw4To+7y2s++FJ9bKg2OMptS62zUlfDn
	pTpMo2/xvhpD8cihg530/x0Y1KS1rNAfZxmBB26yjjgzFfiB7bZW1XlfIZ86mdon
	O9Zc+cxJyExKKXhDhRRRYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983073; x=
	1738069473; bh=fZf1W4LUEYyZlqON29LdWuZDASC2Q90kB/sAd3jZi9U=; b=I
	MlzQAMrvdOwvlasobg4xbq/3zKe7JAk17XhmAbOsFR5penh2Nr3ei7q3zDvyFajV
	hRqDL4xUFPCkqa7MihiN1Njan5kvEC+jVWTdwHlQe5v3ePo2jEY47XQZDXFtADVs
	p9xYu3B5OeGK64UoXAlJeJ/2s8FHS+iNZTY64cBZDK7IZqGc5rGyppB7aYK1Dvxa
	TF9S1WgBSFSW7PJz3nlnRwV4yUodb5xwStTwjp7qNEVUjzfXD5wrW/HdjtGnVR49
	JINjmMZ4/IkjaNoGpEWEmZO25urVBYcg6lxl2dfBVXWItrveP5+5LMnk+j8nTvQS
	DRE8Sqw5cTZewJjOQDVvQ==
X-ME-Sender: <xms:YYSXZ52kIRubKuLvJ3mnZkNTeCqNjVJgk_euRPKftlfhJQ74pNjWuA>
    <xme:YYSXZwFB6vVH7q8iEp4lwYn2msBa_X_GrZQcuQDb3wSAeo1DxUEdNb8Fq7mPULSGg
    -Yr4rM3NJBR4PzM_A>
X-ME-Received: <xmr:YYSXZ57rcO1fZOzLLmbYvvSXaGLsjEfrGbgtMQyBa1Ryjn9Kq_YAWfaa1oxR-UBb9xWq4L0ZHt0cR61RfczrV9vdOewciyuQNE_7B4l8K0Ji>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:YYSXZ22yTwvBRyWBAbBTQQd8r_zaH3xcs_O50PWDwirOKp6vUKl1BA>
    <xmx:YYSXZ8Gq_KkEppOxEeN7bOhsDls99BEqDa0770EkBmlr44AiCy1tJg>
    <xmx:YYSXZ3-20KpTi0IDV5cM9WFv-fgptha44-4p3VBNw22R2Yw2neMGug>
    <xmx:YYSXZ5lfhRBzbmivOtU7fpQVkMSivxKHO9LctoTgYOFQcnt6kNDewQ>
    <xmx:YYSXZxTvTyGERneWMW3tkfNUO9vXKNiP3kMHQpskF39p7S-zKYUaWSO_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ead0ad8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:27 +0100
Subject: [PATCH 19/19] Makefile: skip reftable library for Coccinelle
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-19-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

The reftable library does not use any of the common helpers that the Git
project has. Consequently, most of the rules that we have in Coccinelle
do not apply to the library at all and may even generate false positives
when a pattern can be converted to use a Git helper function.

Exclude reftable library sources from being checked by Coccinelle to
avoid such false positives.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d3011e30f7..dc2ac32e4a 100644
--- a/Makefile
+++ b/Makefile
@@ -946,7 +946,7 @@ FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CMD)))
 FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
 
-COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
+COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES) reftable/%,$(FOUND_C_SOURCES))
 
 LIB_H = $(FOUND_H_SOURCES)
 

-- 
2.48.1.362.g079036d154.dirty

