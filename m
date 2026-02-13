Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB0330B27
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973993; cv=none; b=iRA43UIs/cnoxIMshlenT/wRuRxuHNeRwc/2tBZ5OXSVJHLfuO4NLrUM6eJIMCRRJ0FIvXR9ztmU6wTnAWZilfrldZEPhPDnvJ+wbhuXn83AilyWF6StleHirw8WNfKr7S9oS7UG7dtHIsSU6q7s+OOjN25PnFoWP7spjmbh/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973993; c=relaxed/simple;
	bh=5XwLmW40GX9zGxDbLv098P6YcBGvbyeqtGn6z/ylDvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2ANRdY4br6z+Lhs38F40GYNXmp79ITzp+FWlVoMypuZqSI8mDekKV6AiNwwlc7NW+AL3bmgDc32ab4JqfdbisAipMgFZ8RMeQ8oAyZ5YDdvu4AsvPEXwWeY0oopV0m+GNZygVNSdQ3zI3FvW9fC4IHTEN2jJxYKAJsHYwwNH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dtVkg2oe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZtUns/j2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dtVkg2oe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZtUns/j2"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25774140013A;
	Fri, 13 Feb 2026 04:13:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 13 Feb 2026 04:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770973991;
	 x=1771060391; bh=g7vI9gZRnPFRcm+y8RHkt+lGlGSYJGZWhioPG1Cj8x4=; b=
	dtVkg2oeyiPOhiphVnzz/8LeeZYU3CSi9e9lziRrtE8K1ScZunkKQo4TTtCrfSjI
	6GHErEKwzyxg4kzZio0iF14wngO+l8xks/lt7ByxjUkmNSQeg8zu95Jn8xVAF1HJ
	hcOJuscWc00c//wkCw/ZCiBDmq3yJguHh6vFTU7gK59RJC5bJ7WoaiQQryTEXUEZ
	5Tn1n5wJg5GEm1HbH7wMthiI3KIiuMcSw6K2iCwBwS5+HWc2Ir0ypvP5YSLXUbYb
	XAWmSNPWJAmaZlDI+w39JEZsmaTdl//Z2Qaxw6drtBGytrRKJVWYsm9O4NvznD/d
	3XRyXKkTbpTckAhgPkeBLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770973991; x=
	1771060391; bh=g7vI9gZRnPFRcm+y8RHkt+lGlGSYJGZWhioPG1Cj8x4=; b=Z
	tUns/j2DWxrXH6AUKvwhVtgJ782/R/zmduYYtDmC5cSMyoIwwS0LG7yBpYGYqbDs
	0l3Kx262SYAqGy6/Lr9/sOsv6Z6Wbyfz1zgJHMLwfFS9cBOmip686F2DpO7xrhGp
	HQD0ZESPYB0LapgBuXcmOxDIerpz/ppRjCblt4o8APxHkhuEXi6Z5movpnJU7q+8
	jAfXiQ0bEcbW4+IQh5YMoCgZMHthYFLo1nF8eeYt1psTkSM5DeqQC4EiNJ3hnQyD
	KJI6tKcUSkWZ7vHXE7ektJo9wnxS2SzFWkKyRAtg6K9TU+OnDmU/aLohxrRRsl/4
	AoBeLx2/cGwluCqZvXIDw==
X-ME-Sender: <xms:J-uOaQgBda0rdjsVptWZiwGWNf_AYfL3VK6XDPo9LtftkTG7rg101w>
    <xme:J-uOaQeY8I6-9SwYwAbpcSau_XqT790E67maxVvEdRt7DNUrv5DbUIwdPsZf8-aZB
    -xsjbGcXPUb-4Y15BfVfACDEvziW2ni_RoAQoBTgwT1ijaB1sAMLQ>
X-ME-Received: <xmr:J-uOaVcN-XGB2ZHgrm30e6JeZMKRvjIEH0XKWl6a57pVIu4Wd3ZIB9TwEyiVI1hbmT-MCBYxGAnhWzGpRLpeDSCHoMfDapUHgY46HMVPlUkW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:J-uOaa9bBfDeHklxTkCqPAjTiQ-_ho262Bw4W_B1MiLnWxyvrDCLRg>
    <xmx:J-uOaRm_XLTn56xDMYbCvdn0jT738KQq4bQRlklpBTb7G1GUqhp53A>
    <xmx:J-uOac9UywKThjHH2dexkYn4cYvgQJTeG7Jt7YiHhmSk7t9Hkp6omg>
    <xmx:J-uOafkfbP0zWAP4RpNdPevb_pGpA_T091ARflI9_N77_ss75Xb1LA>
    <xmx:J-uOaQfxYvD0SVsKVDegzKlHNrIsnd1I3DnpVD3d7kWaifZtQkPI9szA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 04:13:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa30faf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 09:13:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Feb 2026 10:12:51 +0100
Subject: [PATCH v2 5/5] Documentation/git-history: document default for
 "--update-refs="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-b4-pks-history-dry-run-v2-5-756ac376e9e5@pks.im>
References: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
In-Reply-To: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: b4 0.14.3

While we document the values that can be passed to the "--update-refs="
option, we don't give the user any hint what the default behaviour is.
Document it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 4dbe665ec4..cc019de697 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -70,7 +70,7 @@ OPTIONS
 	Control which references will be updated by the command, if any. With
 	`branches`, all local branches that point to commits which are
 	descendants of the original commit will be rewritten. With `head`, only
-	the current `HEAD` reference will be rewritten.
+	the current `HEAD` reference will be rewritten. Defaults to `branches`.
 
 GIT
 ---

-- 
2.53.0.352.gd1286b26eb.dirty

