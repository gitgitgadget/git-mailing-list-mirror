Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B1347FC7
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208607; cv=none; b=OHxNP0fjBaKk017xymW9o/nkVaOqmDSnIuz8qMoePJHGbOr+UEYnrqdTbkzUtC14PM9sggPWRMd0v1ynxIt5OVripcBRhJdrudt5Vp+7pyggPYvVgLxMtMdSBSZmNg1olvZtHiTw6yXyb0mh1E8IC98sh6uNjDlThQyB935fXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208607; c=relaxed/simple;
	bh=P/KaV1VoINnQBxLDmPrI8b2br0mvziLZ8EBkoEWyx8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXi1eu8YCTrQQRUSu4I3HQaTh7ivvCLdJzcHS8+hIyNKX8KcRLDx6j1PjXF1iK0DOEc6KrAMn3QYcQlBxjWBWMpO6k8gvxrFWIXfvAnfeObKkPDazP/XCHcutPKoDz+38b1UiZutq3t2ObsA5agfpvi4uD3kpI1eXZ9rNcP9dbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GK2Iuk1A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O868ZNuq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GK2Iuk1A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O868ZNuq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7452A7A00AC;
	Mon, 12 Jan 2026 04:03:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 04:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208605;
	 x=1768295005; bh=dc/T5MurzIHxMmPggWuKdIA4GeDd4fHIo2cxkZVeNVw=; b=
	GK2Iuk1AMwkbIp3WD9q9EvGF5tlm5v4xDC305pPL70JIvqCjvEXPbxoCoPBEw8qA
	s6DqbJ3VjChJBMMTAyfZAY3SVSwW7fSMajOQEKXDCwuFFo9f4ffWlEHtz5L225xt
	qE8oGNAsmwnFP5j4FTBFneeH7RbyvPvNnKVG6xoIk7iJN5RrjaJALbnTzkZh+R98
	t2+zYEGV+a5y0rYN3w6kZ/m4HNGrQTWfYz8jbNximGR2sW6oPwcGYdcfA7qibtTA
	Dx/IFZshGzvEHL7LrDrx3dcwwmBJdmdbRE44EMx0Y8XkED5hGqMajEGE3pyHv6p2
	AQhgm3GOPGQuhssHorObIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208605; x=
	1768295005; bh=dc/T5MurzIHxMmPggWuKdIA4GeDd4fHIo2cxkZVeNVw=; b=O
	868ZNuqFQe8n7ukhNweknoXRHqoOb/xrNqwDaMUTn+Y9BuCs2MVHY6kUmi9xOWGc
	VXp+wKZqaFcRIqs+3Z+lUiD4TsiNdVkpgBSDPXG0SdEKHp4LY9t25rINXJTjAaFW
	6TqqoYC82r+HIPijvY0jBBwUBQHVmNfoMrPTbmfQRjSihnVE8gyRDcVp4nMe9k8Q
	ZlWoHhWxjv44p3H2YPPJi4M9rns8Dvbz6zv1sJCT1cDBPH3iAmJKZu1dXDwPjwx1
	ZyUls1KKHyeZLPCLk099mTB9SkQP+MQc/uOc+AZ8ZEjIXR5T4+g2QWl/49Px7CSm
	wxdp5B3FTkTGPaN5Yetrg==
X-ME-Sender: <xms:3bhkaQQq-60bT2jXuo7oE-h7SKmJZtjMMDNUZkC87yDxTFPRn0FnTA>
    <xme:3bhkaVNzMqF0LV9ObDQugLcFBGJWcU9JeIncSmt43Yp2euuKWPKX7Uo_1jMuT6Oak
    C6uF3hwixEg7q7HEGFFpEiyymLWipw-tnbeIoJZIG9UcyjeSt7x0Q>
X-ME-Received: <xmr:3bhkabO0GXXN55PqORbqxn5474T60HvqNMAF6Fva-kxmW7B2g1KwrQLxpdtag5vSvI3qeTB4MIpLCiQ3a7iXQFCW6Ewy_XrfbywoJhgkBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3bhkadtFGayyAajE4KHO0j4Uljq7GURqLWLIV2USCn1kN8mWI9tCkA>
    <xmx:3bhkadX7yrXnXX2r4kzJsMa1c0-YB_lk7COnxErxUXouBrHLLxgXrw>
    <xmx:3bhkadsYnK5FmlubmvN6hz-bJDKGzKOErS02BYuHAG7EghafvwXI_g>
    <xmx:3bhkaRVhgti_pf0B3ej9gPkcsB4G8PvAdPr-YmmGF-wZG_p_dvuoig>
    <xmx:3bhkacoIJvew8WQmU19aETxfNRxqyjS2Ya3ISN34batCzkAmBoEIvpUN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6aba8ee9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:03:00 +0100
Subject: [PATCH v2 11/17] refs/reftable: adapt includes to become
 consistent
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-11-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
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
2.52.0.590.g1f87b77810.dirty

