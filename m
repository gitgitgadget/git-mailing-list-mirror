Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5635BDCA
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962406; cv=none; b=arn2P+vrl1bmgUnKaCfRyFlrn8g/rnxzaaNu6yUZyJff125/MB2XcZUd9NPrYRVgmsjeMXWl79ree0MXuJgHyEnERrsO3ATaqp044mdJNnb80y/oWkOxY4J7ZSZxdkczkDf/wuCzRfwF3cIvQWuY6yOdUCSanmj9sBa0DpciLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962406; c=relaxed/simple;
	bh=sueJ9ZKTn0L9CU1/ehWxEvZZQm184tY1GQMHDLZgkso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9owzAXqDpB/XeqZjrYE0EZ+3P3n6HcqcMCxiC+4wS2ynNxUPSEYTQ+psDqc0D6j57j5RsJ9LKjTlioJF4ePxKdwG9YAUgURDpjnKdMcUNu0MkvcrLUEAVajcMG4lyKnwqVcnA2rszWhgGfGgT4bjAdNDrFjE4btoSTLRUAlMAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JYykhh7/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPz9jK/n; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JYykhh7/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPz9jK/n"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB9557A0178;
	Fri,  9 Jan 2026 07:40:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 07:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962404;
	 x=1768048804; bh=T9ODrgWrlTfGvL8qi4suJmdyBidw8a/ZUWvFZl6gTqk=; b=
	JYykhh7/vsKkUcIyOq2P3fWk2hAorevRMO1YB166l0dGutoNH0gusnrfCl3AEbKa
	bbBwsVGzQa6jCvRcsnG7wiAj/lcvncbfNEvk5h6X7iw2U0AZ5aTTqSGkqSH5pmmr
	Lknqg0FKI7w/KrNGvgYkVQVL0V4LXBcjRZENU/Ii88BS5d2+R2B15R/DL4SZ54JG
	gDs3V64a8zDpat9OGOk8TF2YPWm365Nl2qv4PbxuVXtfNM1Gw767etKtf4xcmqA5
	NCTixhm5+Fvz9G8rsE8N2oLnchhBJSIN1ggcSqqXebFJ68LvFxMP2lL+V4rR+LI0
	zXow/bZ+GdHcK3XXmk05Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962404; x=
	1768048804; bh=T9ODrgWrlTfGvL8qi4suJmdyBidw8a/ZUWvFZl6gTqk=; b=X
	Pz9jK/nUFsTOP9/PrpkERR5/bkLejU38ynZQLmPSHJQUavjnX3g98YFBC+vGfTP8
	hdFf0o4RD67XXWuAjLa36oRaMFKXBZIEaTliFh+b/sO/7xsHn6oI2VURMpSRe66T
	vsADg3uSXYGwCPzsiQpOlHTeKee6QtHR9vD77Hvw4C/HlmWfsQIuICJCO8cNSaQY
	ly1vyTXHo7cmB0SqX2SfWLAdD7y07waJrHT851q1T8K7AUoIpsTvEbtmRO8gkErl
	6c10CLHfqS3xX9KFoS/g6NOOa2dJORgobHzC3hYiBnjzTFCtpAxYB6TZJsoWnWzA
	PtFw0W8lsfg8uuSin8cog==
X-ME-Sender: <xms:JPdgaYvHYlPKje6MX6uN-se5tW_xEelMV2zY338M3Ur-hDSr9XEyIA>
    <xme:JPdgac7PS3BloQm33-NmnxAa1LTS6z5nukyhOg3YKzAafDCtRl-o2rxX0H9foBKZe
    INdnEaiNBulwvziAhSdTkVPpS-fey6sX9JoEVlNpUEOoGDGKuRB8rU>
X-ME-Received: <xmr:JPdgaRKXYFePyH5-j6Fgctxeh-A5BKO0G_viFMmSiGzUAAe2C8dCCEfU-Gzu5QTAJCy44-NkX57LEu44bnU4Ab1JrVL0iLzJyDjdIIG5DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JPdgaU4CPcWSjGh8PtvoQLC8NG93ksNMLQrCCWFmUSuERca_DSiPtQ>
    <xmx:JPdgacyKVfnPspbY6TUlPFp9jeJ_AGecMk15Y22LshvM4vJJY88KEA>
    <xmx:JPdgaQbiwOodk2ONc5OABmj4pSXsPgo0Zz2tRO3okLI2KDAs_P1pFw>
    <xmx:JPdgaWSqjD4rNy_gyGyvKQCiyTBJUUPmzT8YTdJxQPhUldHf52iZug>
    <xmx:JPdgafV099CirqBdISOyf5MfOICRoN7aa5s5yDZNVm0HlC5_temosuQE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:40:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bfda9da8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:40:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:40 +0100
Subject: [PATCH 11/17] refs/reftable: adapt includes to become consistent
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-11-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Adapt the includes to be sorted and to use include paths that are
relative to the "refs/" directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4319a4eacb..d61790cf65 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -10,9 +10,10 @@
 #include "../gettext.h"
 #include "../hash.h"
 #include "../hex.h"
-#include "../iterator.h"
 #include "../ident.h"
+#include "../iterator.h"
 #include "../object.h"
+#include "../parse.h"
 #include "../path.h"
 #include "../refs.h"
 #include "../reftable/reftable-basics.h"
@@ -26,7 +27,6 @@
 #include "../strmap.h"
 #include "../trace2.h"
 #include "../write-or-die.h"
-#include "parse.h"
 #include "refs-internal.h"
 
 /*

-- 
2.52.0.542.g9473a8513b.dirty

