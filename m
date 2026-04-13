Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135293B52FD
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073798; cv=none; b=pnq+o7lnlvnpiwGkRvYwtOEkAl0Z4Eueq0ojp5rFwqxgTyH6XYDAUdSj4AD3iTH2k0QwUTNFQMgz5IeCCpvoTGNa6jq+OfWGdHbaWcGF33FqYeKAKZ21qXMKB972cJclCOZTJ2r0XPAuKoJA93hJ9Nua9spXu/g6Ztd92nv3Mak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073798; c=relaxed/simple;
	bh=c+JJ2eWHokL7/u5dzrojgm+5czAUEM7meNb0CeFWnHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hBdRbMa8NioEsKq5ax5eff3uuFcB9OZcIw1V+Okru6SRwqlw/oaXhvjn486nY+JeDkZIW/wY51XwsfO3acUs3EiU4ld6PKguSJd0R8lDNlN5ahb2y7ZJBaSpV8M2R1eIFUtMHnfoc44HtH4nPQhLYdByRBKIRVGxSkULFXvmqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uvVLn+BN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JF2xSAvq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uvVLn+BN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JF2xSAvq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5AEF3140011B;
	Mon, 13 Apr 2026 05:49:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 05:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073796;
	 x=1776160196; bh=++33QL4HnZ8/I8YGXAvLccOof6xdsQhnTNr3tKIxlYc=; b=
	uvVLn+BNXaabtCBpbdANYqgpwxr0+c4rVGEvnPCR3GmCIfSA0sZJeMDmYmoUAwMs
	NxlENXDziMDHiQJ+BbMW3P/1sERUw8YhaCUIDy1Sk0eq8CtZWzXdzI7o8q/iQ5W9
	/MeKH6xqiHKqBahXy5hRyI9JgYm0RxxYuNmFeBoZHlL+TPSbvibUVN1QVqjRD7xj
	TBA2F6xPN2tWL1r9InxDs6Fov5NFyqeB0GBFiINu0jO4fRrUx4UYF6Kzu20VNaqd
	yPWUsos44gqxQmLRfyudcGIoPaLeprrsbqp/GszA7Np1hPgQ1H3u5yy9bS1gbdex
	3HlWVtED0K3rz4xI6mvdSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073796; x=
	1776160196; bh=++33QL4HnZ8/I8YGXAvLccOof6xdsQhnTNr3tKIxlYc=; b=J
	F2xSAvqEHTgtic5pKKXt0PbTVJSwERYWw32aJPzd5eyJbs996sB2XvXw87HFlFP0
	rOc2JBD3HChi2HHXzC0SBV2AApyMKnzkZ9/Bui6ZB9IlsG17/J12ebdjt8eouXtq
	rnFtcQsH3cuudZG7M14nVKikDbz/uyI9mxWOxMhFbVf7nd93uTul2t+UVXjfG9w9
	nQlCjsZYQZ3sJvWxNqr8qwPRiqtnHe23t50l4z+oNhRgDVMgMuBkfSwvB5mdoULz
	+kXwzJH65tZb9seRiMTStlp6orL/WhL0n2y7p/tDoplYC/atJFspWCQqZ86u5CQI
	RoZTNahg01zgRdzazeVNw==
X-ME-Sender: <xms:RLzcabGfnIU5_05Vda74ffJF6aVa4x9-zHVwTpNX9GgcEHXyRRXPjw>
    <xme:RLzcaeWj6CjGV2NBL18MnK8P7ZlttHgJ2iBbTi0Ex3SthAunAfTZ_fD1_o85ZYUIV
    AlZD-Z1_OqhBU9XPFifWuMtIE1B1C-nHkMGeEceCyz4GsGEcHozkQ>
X-ME-Received: <xmr:RLzcaax8sk9jSHgDQpKsH7tgeVJ5ID3wE150pofAdl1IZOYUV3aWM6NO8Vwxu9sW55cZhTrhNxfw6HeroUHZY5VB98uvPoo_QwjPePjpW1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RLzcaUPma4lCvXLTc1vHmKjVfTJIYlavjXeW-wCSJi1swDQvewQtwA>
    <xmx:RLzcaT66W70iVC-ZXGKOg7jaFMicL9LCemam1_phpJDITSskWM1X2g>
    <xmx:RLzcadPrIRylOcrMazVe8FUZZDJaeTUgyJyWDkD9RcFJRmw06RZk3Q>
    <xmx:RLzcaZmtabDu0egaCYpeMznqSCSD0eGMHo0yZIWlrgJfafvdrq3sNQ>
    <xmx:RLzcaWdamLfw0zrWtOPsKrLCybHocilp1FhJvyRGlQhKOaXeGsSiKYDZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 47e66e64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:32 +0200
Subject: [PATCH 11/12] t9902: fix use of `read` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-11-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

In t9902 we're using the `read` builtin to read some values into a
variable. This is done by using `-d ""`, which cause us to read until
the end of the heredoc. There is a gotcha though: when the delimiter
isn't found at all, then the read builtin will return an error. This
hasn't been an issue until now as we didn't run with `set -e`, but
that'll change in a subsequent commit.

Prepare for this change by silencing the error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f9a597ec7..e3a7df7691 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -590,7 +590,7 @@ test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '
 
-read -r -d "" refs <<-\EOF
+read -r -d "" refs <<-\EOF || :
 main
 maint
 next

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

