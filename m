Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCE737FF6A
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345891; cv=none; b=F7xpCPZpJSVtPAkS+Y/mpwW2z2jFQTXdWE56Yg8jVUqbMHSgEoTPT9bEqq/Dq5VBEhbJ+Ja3H76V/tV7SU4mD7DafztRpDkovfzcNl6vMNSa82O4MxyDgOk+qSQqNNljg3BSYzA5fzK/3/WKUcm2ZaSYYAWYcRZBk7Mmg35tPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345891; c=relaxed/simple;
	bh=/BAcspREZXtAQryU7kFyLYLDIU8+WFNmnOljplY3a2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFTaM1EYnMKbbakD69JNqvNS+babDokPZjdtRr2wqUhh1OMosn/K+kha826QumU8r9xrCTCsN8kCsZpMhAmX8c/3hEGwZPh8oHjM4GSGexLwMyi+MBVwCUyhAeOX/9D+PzmbO0xYNqW8YomWvgag8oxRbY3gi+Za3wao0DwzB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wKzDC9br; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iJSZ/dbf; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wKzDC9br";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iJSZ/dbf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D5BB1D0024E
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 09:24:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 16 Apr 2026 09:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776345888;
	 x=1776432288; bh=97Q+A7FBUYXjRdorj4OKNrFhG7de6PAdBrxNURMz2+o=; b=
	wKzDC9br6prEa1n/IcUGOB8hFFf+04Sq1MgGuSq0mbDTpsEgKgSbRgKxSh0tQfyS
	bbxsXqBQvXZHOGOjwDHqLVyizs0ynO8+9w7WflA5GBnsQLA6mojvom3yyh483mAD
	R8FdKnuuy4h161/A+zj2ICLIwB5RYDkp11ztJQRCE4OLSkCV0YBfLzvk9BlypuVQ
	zrNm0YQ7Ho6VO4hhJUudI/tnCgMoPotnVKGrEjAuB21JPLvzHmFhxZe71oWVy1yH
	wmBcdphcueJMfFICUmzvwLN3iCN2aP2RzShjbk4kbIc7a0dTJlT5XTTBZVPMhtcu
	yz4ttZPnaX90jnyFxCyCxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776345888; x=
	1776432288; bh=97Q+A7FBUYXjRdorj4OKNrFhG7de6PAdBrxNURMz2+o=; b=i
	JSZ/dbfx8dgjy7x3WDCkNeF44NUZrnDKrwiZONFh8CT0jNN16agWLSLAQUEQoS6F
	s054WokyAcaDJ0FjDohreVMw55EDSy69dkqUikECyGBYYzp2vp6PFvWOYTtFSqrh
	lquQTi8H0OtNAHlc0PSWwZrewhQ3/RbtvDigML2io5mZe4+3neX6DXsfbinREodG
	WLMuhsjQlRuUBDFJrfUI4AcJsynhh1Hcljtue+PTzL9LCk44TQ6wuQ6Sk1kjEtNl
	jch5tzHRRibGhjjdH9MOeuYkkeO9Jn/1mzYr4JHesV+Uc8T28mmpb1MCj/n8e8cm
	Df2cHtEXtFwMrA8R3m72w==
X-ME-Sender: <xms:IOPgaa7KEtiMriPXgbhlNq_X9fhZHvzNXPgTTfkkvl7xiNzCtsG6Bw>
    <xme:IOPgaa20IEVa2RJNv8iU-MURrEPzDpe1AdSu7M_NNgT710xkyDGjes5jQZiNkEmKw
    6FynUijO68nyzchF7HMUVxHiu8palCbsaBp5YI9vU3ofciTCZ6-Tg>
X-ME-Received: <xmr:IOPgafHG3uIMSkIwwpFSd51KCyeurpNg_zgw2igqXkYyIxhHpIBVVt27oj1P824QNKS9z0h1-SJkpnIe1Pqfus3M5DCTDxRkHobFe6qYBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:IOPgacS7OIz_URqGr-UKYipVdJUDWnCpwdq7QjGRIKo6ibEaLNR7kw>
    <xmx:IOPgaeD_rl6sbzpXbV0a3chveHnoYoXTWmpKmFzTOYdIH2vq2h8Dzg>
    <xmx:IOPgaU0fkW5e0scg2WtpQDaBbqyWBVDlLYQMBig0bI329VxsEW0cfA>
    <xmx:IOPgaUWL5CVPsWyDH2oHsEbxE-P52Q1tqUIvtxCxirHqDJAYEFfLZA>
    <xmx:IOPgaTaEowIDyrGELJa7O4CgyE50HMzrVmgWEAq-awRsBNZbOkk-hB6K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Apr 2026 09:24:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6448ee32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Apr 2026 13:24:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 15:24:30 +0200
Subject: [PATCH RFC 1/2] t/helper: prepare "test-example-tap.c" for
 introduction of "lib/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-pks-libgit-in-subdir-v1-1-03afc731df55@pks.im>
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
In-Reply-To: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

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
2.54.0.rc2.529.gd9106f7525.dirty

