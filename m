Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D61D9595
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391422; cv=none; b=Idty45ZDax6HN+P0xIqLBWL/EXvtkBl5hB30l2fztj3tVh5+dmrdyELLtyUX0+xpixLptOpJMG0bUYFVCPSPFaqykCcNyw+5jENlwiEbAbuPIEe6u3IaME/aSdDIs/3HEkqeMQ+DQpqDKnOVKkn7HCoq19SNLK6NSZw18g8famI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391422; c=relaxed/simple;
	bh=JkYboJKZHZM+ac9wiyc90QKzF5VInOMnSQN9tRtdM3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rINdHm6Xr8oXn/Ca9K6LDShbCB+WKidUSJXgvFCbpux1toH2l4Bdiui8XnNg3+pMxgauYXCVocZapyRxR2F09Y2nmb4ZIG+m9nEqncqOLzaRn+JEviOHqmonOtzNCzWVJ9NhZOklepFt0M3xXfk/wp/ZWdZ6lp4EgFS3in1+t/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rdYep8jR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l5s3+7mL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rdYep8jR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l5s3+7mL"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5FCF61380B8B;
	Thu,  5 Dec 2024 04:37:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Dec 2024 04:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391420;
	 x=1733477820; bh=6lo4x03kqPtlSZAbT88AtH6OR/rU64pzA4QOdeYe26A=; b=
	rdYep8jRyZh5ZQqpTmdx9Vpep1gWe58pC0bqruJM3Cqhme84Ijbu3bLo8yDavFtH
	4fL/ixATYenkQg9fKrpZ1UaRiaDkdGgOR8PV1qwCso1LaO0VRMBrTEd7nOmBTTtc
	fkPxXMIEM5v5e7DOa/vwnMm8lO6KaB3rBStgZKoragJooaH9axU9Mkz87vEihA7H
	SuJIhLDlrJA5bTcRGn6UEKX4h8g8/kQiNGmfBilk+nys2QcIku+erXMvaGB+dwn9
	o98Fx3AlJwSaP1IqG5jhoMeaCPundhvwi0sMDG7kzQe6suBZZFTv6zD36g1fL6zg
	ny3hxSiLDWQbDgtEL3lHAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391420; x=
	1733477820; bh=6lo4x03kqPtlSZAbT88AtH6OR/rU64pzA4QOdeYe26A=; b=l
	5s3+7mL72LBk6mh8xiDZXYftcGrD2YUKZ0LKTdEVKZPm+urMQXWiMNgHH6Itv/6j
	09zEtGIWpJuIW2muAM5TbTir4COK4QjJ+Abmoq8oDQ0YwCVjdl+/ttfZ/pBp1ibk
	Smtw3pJwRpH9KGNXsEBaFduLCOMqUtwQu9XSHhMwDF8TX/WBDzz8FeL6uYIarVEo
	Bln9PXQv5XQUBdAidjZARr2oS92nEoxBLxW3LbPdzz9stwf0XkqZEeoFBSpXaSvZ
	mwAEUpAeCgEYXo5JfrgE9ftOP0h2WgS+SAqiIvF3Oo8vfjhpmUq/2fYCQJaJtIK1
	tTapE5fR1eQ/jeRyjSXyQ==
X-ME-Sender: <xms:PHRRZ6zcOKXbkC_Id0PK7pZwfPx1O75CiHHcoYmJ-9sNrPo9BrKy2w>
    <xme:PHRRZ2SZ_k3NYlfyukxR6KeyZZUi3e6FxMEPsFpfG7tOw3EIaOKCD-xteYOW7EQN0
    mv1iXeC4apuhlIKcw>
X-ME-Received: <xmr:PHRRZ8V_xwqGQ3tdqBsbAHmNTeoAThAYSv8K9T7-8uHz54SOfxY4USTxfZ-8yQe6rmNn1NKPviped2DeE96QgH1KkYSqcH9axuCw4R42RAd_Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PHRRZwjRO7ivfYMGjTi7YUn8CUEhOeAA6XvXSiKKuxlhD7xiQYhP8g>
    <xmx:PHRRZ8D06A5Y5i_yoQI9M7Ghp6WXsyDfQul6aVvzAM6aH6aQDs6VNQ>
    <xmx:PHRRZxJS-0ayDX0zdOSNVJyHFtU6PGZy_5u4F_Z16ev2hayIaiF4LQ>
    <xmx:PHRRZzCv87vKbylG_wwYBbXgRu9g2OKHRNXD_F3QwX1-is_2NGJ1GQ>
    <xmx:PHRRZ__zGQsfpWnUf_FBxKZoxJW8YHHHTtmmlFDa0UP_K13vo6LyP5YZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a613b9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:37 +0100
Subject: [PATCH v3 15/15] t/helper: don't depend on implicit wraparound
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-15-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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

