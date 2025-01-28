Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32CF1DFD9C
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052901; cv=none; b=qjlXr9Kc57LBPM8SIApT21MukdNL9Z3XcYdbE/jsxsf1Mj96quY06e+vol6Y0zlYSPTwZPjWKwJJ5Pf9Y3DXZ5DYckO0U89uigT+/ISVfh7/B8+BSdEE+xWrMwq5IR1SpiJ9yJudHQu4CLUfXXGtiQldBULGb9ZtiwwvHcoN294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052901; c=relaxed/simple;
	bh=isW44sI+hPQmmM/id5qyNHnGUjfiKjltOXrxxnn+FhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lel4cxkTGu7KFsKVTVZfUNFj13FaX10UKD4DWbx8cM3wt5DCbeLZotPqYpThuxvkr47heUv0UFtYsFrjwh/sCd9qbYYpeLTp+c0auXcd9IGN2vSK0eWUTedUJW8QMj0aH2Vw/UtZfbz128x8hTbWa9tRZeTKRDQqyU/xW2sUGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O88wPDR4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ja6rxpAu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O88wPDR4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ja6rxpAu"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BD4641140149;
	Tue, 28 Jan 2025 03:28:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 28 Jan 2025 03:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052898;
	 x=1738139298; bh=OX7TtIP6uvImCavOgAuwk2ZK66HkAEPH4PAUW1rGZn8=; b=
	O88wPDR42EOe8k2FiuO3O4m9TaGaD5Rp4Sqnn2XCOcKl+5nZg+uzIORvoV5Dy8e2
	56kQD5n+I+naMopG7M6NfDOEzV2PXNZzRP/gr+utQSRccXCjRUOLUaCDtfdK7D2b
	5FX7iU4fgqW4SsTbd0ZXLZfM6XsSo8qq3jLHgl4zMAZZKJwJXotW/v0OHKh9i+X7
	yjzd2ETAtMOvSX+DgmPsq4Jj4341onA03xTPttliyr+IrmxQIFwnPS0kTgv3zyCx
	RsDPvRohaF0iSxGF4FsVsrLwKP5VeGi/jnI8tRrtvciG5j7f2iNZaqdzToCG9U4t
	tTuW2eP9SoxmLM8TxvKp9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052898; x=
	1738139298; bh=OX7TtIP6uvImCavOgAuwk2ZK66HkAEPH4PAUW1rGZn8=; b=J
	a6rxpAuSL9g5L4M9JJEsNDhr59PW/F0TihAFX/rEp5htVO0TSHJj2KGlHapkNHyE
	QQMmmDjWcgCsw7+zQYi1hhNRDk0ScCzkkE+UdXsFEfBDBarQ3ZFbC8fvOZgYn3ik
	N9F47YbPFcG0fW+KOqQ+AXS25hDA6yvmGx/X7mZwn7kMBhBjU+cWesN4KhvSYnh8
	4XxK/ysOAIHJNcgKSHyJ1Y2Emv+9CfOCIlw7QOZRJOdE+7fQpJ2yPjhwC2Huc0t3
	ipZPdMQaynpUv+68ss39Hnji2QeTbPO8eZ62FUqHRjaoZPuYiXhCggIP057cL7zC
	MXYbo30bKwjXmLeRe8scA==
X-ME-Sender: <xms:IpWYZ8tOP0DA9tikWQFmMA7nOK4UGBDYHziKGNGVEg02vlQAPfoSvw>
    <xme:IpWYZ5cK2TC2oNH1WZSxByzzRKwhisv5UE4_M7ZTud-bkTc0mKL3AjNUynwDkNC6G
    kr7LiD3d2oxRNg2lw>
X-ME-Received: <xmr:IpWYZ3yEgXg9EwPYFQeHztJDsGJ57Dgdc4EPIJLCaMdfJyvej-T6hUE0yFNkN1iNpi4MSBvFinCmDxwGv6uo6ftw_ypyHCWrR4h5xTgKRTE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:IpWYZ_M8YJt-eCbXVVBsO9g9EiV034aqE4mYiKiI47RWRxf1l7j6GA>
    <xmx:IpWYZ88JBMVfFt8yEhhJO6QlUTCO5RY9rAWDsUFZVga4BlQ0txmOuw>
    <xmx:IpWYZ3XDQpHX_Sylz4-gySJU9dQs2Z-AECad95hTNxAjk6N0mGnhWg>
    <xmx:IpWYZ1foge3QZkOh7woDideVs12mmRKPzqK0l9amXDt--eFAO0N2DQ>
    <xmx:IpWYZwaLkT9SqVJu1W9X-TBBN_8nQgZZ0yYPbRENCo8ywU21C6SzjF-m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e502448b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:05 +0100
Subject: [PATCH v2 04/20] reftable/record: stop using `COPY_ARRAY()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-4-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Drop our use of `COPY_ARRAY()`, replacing it with an open-coded variant
thereof. This is done to reduce our dependency on the Git library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/reftable/record.c b/reftable/record.c
index 8919df8a4d..d1664c47ca 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -508,7 +508,8 @@ static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
 	if (!obj->offsets)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	obj->offset_len = src->offset_len;
-	COPY_ARRAY(obj->offsets, src->offsets, src->offset_len);
+	if (src->offset_len)
+		memcpy(obj->offsets, src->offsets, sizeof(*src->offsets) * src->offset_len);
 
 	return 0;
 }

-- 
2.48.1.362.g079036d154.dirty

