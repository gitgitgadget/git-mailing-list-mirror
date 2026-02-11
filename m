Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E19312821
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806085; cv=none; b=nMrdZwxfqcKVUXeZv2JEtEYD+hOd35AJNfNgyhkRs+BbNOWEK5LX2SpyrUTbs6SL3lDVALwMWcsvgp/9ISdCGoZnAlEJJl5Ry/ZZ7jUewBZFMg/JKk7DzD+TP+BmbtT/4JvSmLscT+CS5esMGLHMnuhdXcEBm+3JbsCWQjeqbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806085; c=relaxed/simple;
	bh=re6N+2iZ9x3onmDuR5KgpEZkj3D+5Zz47SFVJP4MNc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4VIWJ8D2ghxRf+UK6z39FSxzVN53GVeFouAWP/iohV0THFVEs0Us6o1wWHhyFm/JthOw9Bw/jD5tB3uaFd/CT6PhdDy8Q7IGS98X86+iQx7UZ5IQHGGkWqg6s/LrryagZnKknmJ8QDR097pss63Efh71mz+IMCZvdef+rYYGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JbuNyFgf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4P+oVXO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JbuNyFgf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4P+oVXO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30C997A00AB;
	Wed, 11 Feb 2026 05:34:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Feb 2026 05:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770806084;
	 x=1770892484; bh=hqqS92WKEXovTxHBvRVuGFklv4SEB+U7hxhGAH6Crrk=; b=
	JbuNyFgf6SAbPQmhwAsGeaNDgbzQS428GROVFmg68bBmCHFGbPTEKVzrqcsr5Xeg
	7ts08lMIqLrM9Y7l3BMbEB3vWOb5U+7Y4uTUiOmL3T+CIEnhJfheGOJvaRnSc3Hd
	5HiW96mY8Np94r9iyv03DwAmewZvUT9rWQIG4LXDxxbJGbYpiQg7u1wXU3CUhXT0
	6q4+H4LksYl4nu0EUbyInoLMXkcRINbKLwKg2i4UBkKZ19HxAXiAgzwPY4jnC/+A
	y4LNRMRKhZjZ3lTbL5LB5A7PhT2nOuHVojMzVGdYTvUYQtUN/PVdTXd3OknmLANd
	SDlng3IQ5ctnvvII12Kf1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770806084; x=
	1770892484; bh=hqqS92WKEXovTxHBvRVuGFklv4SEB+U7hxhGAH6Crrk=; b=M
	4P+oVXOl6YHRSX0SQc3ojgdyo6aDpDi8uD5pGiCk1yE9cTgwikrZftR0JGATTNuE
	ne33jyFjRVm0i3ULwOVSpOjrXq6/yVxkLwQPVqwAxzLcbgoSiStpNsmdg3Qjd/cG
	1vG5n3jn3M3HdkcWepNLCdu+vWq8luTjhi+/PB9EGadNKG4v0NwSNPCtDF0fl2ZZ
	YK/ytXIEvYHE7j52Ov+Ll5TgjUl3MzHwV4J7dJ6tSGJ42y1FpmSl7ECjZzK2S1EX
	MKECP94nd6z0/ZJoTqW2dmW+av4xuCPRLC3Zu8S19V/KlnjRh1XLUcsr9kVXO9rO
	tghHRBk/W2bmVyQaewQBQ==
X-ME-Sender: <xms:Q1uMaXLzwWBJhEWm98CyWmBPlN6j5_0LWDOse6fpapg5lNn8t3ItIg>
    <xme:Q1uMaVshTyoPvyd19nDuHAPU-17MnbW-u63Jj2uXaYwuOj5DD74gI4OK0bum3bPK0
    NyKbrgZx53dV6I3YOnAiioLH7lNVZHX2CdFXhReqQM0l4T99mu43w>
X-ME-Received: <xmr:Q1uMacQDrZ6v2MRuzFpyNnH3G7zpGKbIaEV8Hvnivk3JLEeV6knTjekn4ziwTha-c97X4Cg1la2CVN7ZC-Q7fMGKZG42EuM29e_9DYdRGNR->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:Q1uMaTPo_R7lT1uFCG6MMOGUbdm1Po8Ouw22izwCgCc-oYoa0RliNg>
    <xmx:Q1uMaZb9U-j8K14yaHGuA9eiXuP-SBT7_LAohKyhoRNyIaF2bzwsXA>
    <xmx:Q1uMaVzQysNKCOk6RYqGAQ55Eox6b85H0484__GmvCKSOszhLnmbDQ>
    <xmx:Q1uMacJFioydxw27vKNzps7mBz9f2Ogcqvxlh3tWqLU1191anmt1sA>
    <xmx:RFuMaeYWEQgH_0_jT79F9aOweDd0-cKsCAeqN9Wq33AnPY2-AFi96nKI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 05:34:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a77b9fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 10:34:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Feb 2026 11:34:27 +0100
Subject: [PATCH 1/7] ci: handle failures of test-slice helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-b4-pks-ci-meson-improvements-v1-1-cb167cc80b86@pks.im>
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
In-Reply-To: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

The "run-test-slice.sh" script executes the test helper to slice up
tests passed to it. As the execution is part of a pipe though, we end up
ignoring any potential error code returned by the helper.

Make the code more robust by storing the tests in a variable first so
that we can split up the pipeline.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-test-slice.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index 0444c79c02..ff948e397f 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -5,9 +5,9 @@
 
 . ${0%/*}/lib.sh
 
-group "Run tests" make --quiet -C t T="$(cd t &&
-	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
-	tr '\n' ' ')" ||
+TESTS=$(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh)
+
+group "Run tests" make --quiet -C t T="$(echo "$TESTS" | tr '\n' ' ')" ||
 handle_failed_tests
 
 # We only have one unit test at the moment, so run it in the first slice

-- 
2.53.0.295.g64333814d3.dirty

