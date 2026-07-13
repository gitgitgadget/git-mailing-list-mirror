Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFF735FF6C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921835; cv=none; b=cw3r/D18qQY2OFBUwTR7YBdwJnGObF+OZg1qV1qePssTdIAkWfx/3xzlAiQdI+L3OYojmGd2yEy8rVSMHszDwebndi12ztG/6UscOtwHrvo+SxVeFQEoffpApsM7qwxYOnb4Bw4EdjEOdIcW4OTigP23CUvyS517Fh5OZWlUFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921835; c=relaxed/simple;
	bh=+dWjmrKwsBXLE6dB9N4iUa5uZs4zC+UTxdmtX1l0DmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hH9Pw7pmxKAmE2Q6DPzAbl96R60azMw/cDn06doBv3jNxbWcRcrmxdACSKsju7bWBZ+u7e2nUaKL+5/2i+c3qVkSTOt4mKZrnVQ/LMLVxhpKymgmOZlkiJPznRVSCpjmHwIOAF5+Y50h+YyyHhw8DtrJZnYY4deXzi6mIpKLV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TKIQv+iL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cfpUY3W6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TKIQv+iL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cfpUY3W6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51172140008B;
	Mon, 13 Jul 2026 01:50:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 01:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921833;
	 x=1784008233; bh=sQ+z9RqD7MqxikXTAgcTvfO0F88HuNA+UQHCcwHEB5s=; b=
	TKIQv+iLL71LxUiZEZd1Wt1Q7pLq1dfZ9RHqIn/64n+qLjaXUp1UzA6vV1vBvIJp
	Un4HdOwik1YuFgI52STqaYYVFeFzHDbA1pwFgJlZqxJsGaDjUps321zx89C5npt7
	CYD4zXWSdY2lRJUnuZ3eUyI7pTh01y3gDXStGvZMZaKO3Uwck1kMjz0eqAOftZSD
	l+IJxCLqCSodcS0Chz8mS24UFOy00bn1+dKwvWS64dCnSAdXWKDFTwYaa/bNoSsh
	ToyZChLp8Umx/BggqkyrWtjhmYyyRwlXD+Mdxlzj/zSXWaoil2fkflMXf+cqGLQI
	yP9hd7JWcQeeNhBb95yszA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921833; x=
	1784008233; bh=sQ+z9RqD7MqxikXTAgcTvfO0F88HuNA+UQHCcwHEB5s=; b=c
	fpUY3W6Om4Wjeac+i9tMMVSqLP03K/tPTsvcWGtnvr/m8hrpVrkdUFChsUBS6pzk
	rWU4ad+cVeVI+JUN4ZMcpJpoYJliwCoGz95swXAISNBj9ooHQJWp450q7HIPX3kn
	OiL+U+YBkzhubjGEFre3W1ZUaraTgRhsz/x1gXYfVQjkT0OtbPtCXp+NVd6tPO5J
	vlKA228Bchd+OHso9Z9wqY1H2PcrdpUOiqP5LBZY4YPmD6X7Z3M/O96TsYw+1whH
	S+7Q7aOwVO6WLgzMF8bVitLZXIKjzPVRucTQ42TzQ5pIBbV07rZrITPBb5vM96hR
	TKg3L6Dv5M7jMSzZX9Eww==
X-ME-Sender: <xms:qXxUahQ0LrCZgui-AyVhWg6t5Uc5VGaObBmV4aXaEgZ7lsqVkF-GVw>
    <xme:qXxUarPah_KszAjPbmeDS2uf-tZ9kaLllmc_w37XpIgYHzXwS_02eL2XeRB_3F5mi
    FMdT8cGWUpeW6-co7zn8ga4shloXh098fs_cl_tlBrQZI2UkcT-vg>
X-ME-Received: <xmr:qXxUanjsX_LbiJMdwXo7TqVKocCTsFTKYHurEeSdFjl3dzl1kiIyKwvbL1jxqXNJb2K8bOMya-tNShsrWTP4csxtLm2BIWHAG-21KTC9>
X-ME-Proxy-Cause: dmFkZTG2Bkv3tCsNdMyIH3f5AZWcpha09tRm/Pog4e2p109A0F3xpUetr/ab2wTA54rPJB
    K8MESWxLrp1rdQ2vvxqes8z8Y5+NxmJ9SWpKkVpTWMytappZGZqKGzycu/BkW6C4wyUHyx
    RFkRGeAmoZKr+yPwJx8IliUa2okGQ/YBMOgOSF6rYigBO1zAgViy3n20oZSjGVGdglxGAv
    RUwykMCgJyGG9+VZG7cJ4ALgrEbZmvMx/w/GojXMjYwQ8Iiy2oiJ8u9xkoK/+Z9PpnN5jk
    HW7doeG3Vx+KdXI0CvCBmFh8kGowjFfdaH983EVqsQWbLpLh/WL/JUy6LahI2OW93oZ+K+
    4Z7BslGXniSJ5F+fhjvI0BPKCcl5wHiYjR2xuKSKDgjG8LoXixg7B7sQDNA5ALekW0Zknj
    0PxU6n6A/Ish8MOurKHg7QfiUllK+k495dvxqXnSVs29zNXHsDzXfhJisI6E2/ijwGx12F
    Wt6arHQ7Lig+TEvXLX0cpoykqleyF4FnMkhPO2R2YY358aCA2VgHDG+R/LH0ypx8x66aYN
    S9luaekRNqI6WvKNGhYOg9EVgXzGPzxWrpXQvo+MyMKWwDv3J52Ml4rJhIJKahIc6mnYgK
    YePzX5lOPOJFeNNKfFMNpkqSW41x121luYXI5qsBDBSndK2n9xm1VAUx/73g
X-ME-Proxy: <xmx:qXxUaglmt-fZR_NM-AahUeIPpxHRrK1jiDmJx8xyw6lZCcAznwG-_Q>
    <xmx:qXxUarjAtMA1pfXnoIszx_9Q1JwYowhcrrELTpdE9oWQuUSBkN1GjQ>
    <xmx:qXxUarFfMNy6VuU9EeWBXfJlfgnCP6L_bpAYKfhz4_1dwduEtrtfag>
    <xmx:qXxUaluc20cmg-VU94qEKoE04rap9kaxVco-QQYAHXsLgX8_DGp8Ow>
    <xmx:qXxUauk-PG2bG4SrTvefOSm3Xu1j8x-Qc8eiL5pq3h01eot8ES0YfVYU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:50:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2b0c1ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:50:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:50:15 +0200
Subject: [PATCH RFC v4 1/2] t/helper: prepare "test-example-tap.c" for
 introduction of "lib/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pks-libgit-in-subdir-v4-1-696240876eb1@pks.im>
References: <20260713-pks-libgit-in-subdir-v4-0-696240876eb1@pks.im>
In-Reply-To: <20260713-pks-libgit-in-subdir-v4-0-696240876eb1@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In the next commit we're about to introduce a new "lib/" directory and
move all of our files into it. With this split the compiler won't be
able to find one of the includes in "test-example-tap.c" anymore. Adjust
it to a relative include to prepare for this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-example-tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
index 998a1f0b42..50d46669d1 100644
--- a/t/helper/test-example-tap.c
+++ b/t/helper/test-example-tap.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "t/unit-tests/test-lib.h"
+#include "../unit-tests/test-lib.h"
 
 /*
  * The purpose of this "unit test" is to verify a few invariants of the unit

-- 
2.55.0.313.g8d093f411d.dirty

