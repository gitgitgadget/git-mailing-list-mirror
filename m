Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C920DD54
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141112; cv=none; b=dxRLRp4pLsFSPBW698h0SplGU8bASyGXZgw0rl5viJUhA0Ih7jsJnbDO9m6wnuTFwsCXXMJ3+Kov7Yhq6hK/1DqY4rNwsITgn4AcszjEqmEc8dyxuwcbJUUNr9AkFSwZXMmN403Vkc3RpfRo4i3cMFqaIdNhnmIO9+gKgUmzIv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141112; c=relaxed/simple;
	bh=JkYboJKZHZM+ac9wiyc90QKzF5VInOMnSQN9tRtdM3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JkNssUFJWcAYP+pLNKQeVD6CK8PGA1J+cWoDwJyXPnXMlekKF6AyWy1KBMnEfQko9yDmSQJhDuUhlr5GtYZVWoJxZ+Oh0g3F5C5PaNEuxKCoke8sWUlhvS0WtOcexYXdzWHPNmIC5ovRm6P2i70dWFgxWr1jbizou+D2QqgduCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MNtR12Du; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1Hr/wV0t; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MNtR12Du";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1Hr/wV0t"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F9A5114017F;
	Mon,  2 Dec 2024 07:05:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 02 Dec 2024 07:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141109;
	 x=1733227509; bh=6lo4x03kqPtlSZAbT88AtH6OR/rU64pzA4QOdeYe26A=; b=
	MNtR12DuyY0Wj8QK0gpJBcm1OcthdXzG3R46iRpw6Luzbd2dePb4cVk5q0dG1hw0
	vnBesqKM8yJio0Bpl7stYtxsHzUIkPDtQ6I94IaFQQtI2cAZh01MI65btRZ+vx9Y
	R2BFMWePQ1F+UxkJg3XIWF7mraNaTILeapm2SqFD73fk+8bfdl7S3WTRr0KhIA2S
	e+ftd2D2SHiN6HLy1HR6RGDigS1lzoCDVWfHGXEAUcy4Xt1fe/DcFbL9FADyEzI5
	tGBrAkzmfXM6nl9eARApMYBVEJS9Lq+pFHgTFReqPCTiAkw2Nprpy2HpNwMzYnSH
	jeZ8KoAlFIXUQDhTQuThEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141109; x=
	1733227509; bh=6lo4x03kqPtlSZAbT88AtH6OR/rU64pzA4QOdeYe26A=; b=1
	Hr/wV0to0uxxlRzBQLqpI3TzEC5nMriNLwa8VnLeh1CNCIurFThApNNNpJrDjRAO
	pCQ9qW1bRIuekOg34ChMMEXyR5FdEgIYjpoCPMOGH1LzkpYDN6+cqsGI2/LOkE2h
	1kwBj5+EhV3z4S3EJlmTK5wNxPHvMT1dOP9EHOIvAW1m5c65Mf8Lt99lnvXLbuz4
	jnhgsdczFyJR2fD4viTJRCwmOkImU+/JwoI0pV30E/72EMMnYgZxtGqc1r2gZZTg
	egSwSerTLn4x9r2VFruxf5qwXfas9PvD/O9QWt20mNADSVMFO2qicJrP2UZQqgSY
	0zw3gO+1diVBEESgpc6pw==
X-ME-Sender: <xms:daJNZwU5xwNtYDWNiMNcb_jlfg4qZ-a7guGHqSlcXsN4VtWHZOslUQ>
    <xme:daJNZ0nhn8cxGssidHiH__92YPwUmRDvwMeJwwIoVBGFdqJfSlPUiPbDbRqgCXZFt
    UbSfhoSlEaCh-eo1g>
X-ME-Received: <xmr:daJNZ0baJpgeSC4UtsxjlT82kgqHqzKnb495zmSe3DFnWxaXqJeCx6-Q49BUcPBXsJVt5ivGNoOP2HFwB0xG7UUBmAAcv1noO0wb2BP6VkGfSF9Sxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:daJNZ_U_EeIDNoQup7AUxGGhwf7ybDB5NE7Bi2QVkSuKPhDC_m2nEg>
    <xmx:daJNZ6kd7miJzZ55wLscVXMSSaHLO6gSjDWPkRweZyP7kZ4gfHaZCg>
    <xmx:daJNZ0cTuwIAys-mtoxhJvuj1l-6qmIguJ7miAlhlmT4JGGjbdrvdA>
    <xmx:daJNZ8GQCgc1ISfFLBS3i50y7FQWsZtkU2-VPGEb2qEdLFX6prPv2Q>
    <xmx:daJNZ8j6AVNgsCdYk5NHhvXtAoh1xEp7yibGPlDk59mTqx0Wzm0QPzmY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:05:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab8e6710 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:46 +0100
Subject: [PATCH v2 14/14] t/helper: don't depend on implicit wraparound
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-14-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

In our test helpers we have two cases where we assign -1 to an `unsigned
long`. The intent is to essentially mean "unbounded output", which is
achieved via implicit wraparound of the value.

This pattern causes warnings with -Wsign-compare though. Adapt it and
instead use `ULONG_MAX` explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-csprng.c    | 5 +----
 t/helper/test-genrandom.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
index ea9b9b656307d32bdc1f2e15a91793b1dda9c463..a4a0aca61773b0b30de618955e5a5b61bba2d0cc 100644
--- a/t/helper/test-csprng.c
+++ b/t/helper/test-csprng.c
@@ -1,9 +1,6 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-tool.h"
 #include "git-compat-util.h"
 
-
 int cmd__csprng(int argc, const char **argv)
 {
 	unsigned long count;
@@ -14,7 +11,7 @@ int cmd__csprng(int argc, const char **argv)
 		return 2;
 	}
 
-	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : -1L;
+	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : ULONG_MAX;
 
 	while (count) {
 		unsigned long chunk = count < sizeof(buf) ? count : sizeof(buf);
diff --git a/t/helper/test-genrandom.c b/t/helper/test-genrandom.c
index 5b51e6648d8e698b09f400efcf67a0708c226e9d..51b67f2f87469471a40288e369d9c784eb2ccba0 100644
--- a/t/helper/test-genrandom.c
+++ b/t/helper/test-genrandom.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-tool.h"
 #include "git-compat-util.h"
 
@@ -24,7 +22,7 @@ int cmd__genrandom(int argc, const char **argv)
 		next = next * 11 + *c;
 	} while (*c++);
 
-	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : -1L;
+	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : ULONG_MAX;
 
 	while (count--) {
 		next = next * 1103515245 + 12345;

-- 
2.47.0.366.g5daf58cba8.dirty

