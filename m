Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326EA1DB927
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459419; cv=none; b=RljddCzRb0VuPP0qC7AmQoYFysvknp6vCkrvoiLU33lrh8y9A74+WnmB0/LheNMCWSG/ps0qTJkQCF+i2eM+siRbeqThHG3t+jj4ENOTlPqNT5WKtZFRbpvFobReMQkbwnlcxe7JSyHKVVy3kSMFwqyROi8O1jDDlGFk5gLWwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459419; c=relaxed/simple;
	bh=Q5KdIoDjTBJLsE13AiXaOA1gHSkz49nEBWxHo1QWn5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5lFG5sHH/WkOVPH/6ePVOq6v82VlKfpGVMbnGmBLVUWDmmYnMPAVppEVilJM6uSxl20t+L0GpVQdo82iHGcQ3ikdI95Hbxe8Rr5DmU6J3zJDTdeHuhfu95GYYpCKNX+mM75XoFFJO9vjxiy4K0u1cy2kXTIaV032nSnnDhuEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H9n5cXN8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xxy86Xog; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H9n5cXN8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xxy86Xog"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5AA4E1380262;
	Wed,  4 Sep 2024 10:16:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 04 Sep 2024 10:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459417; x=1725545817; bh=5y0/1zHWYJ
	X6wD6AkHH3apsZ+ngwF9tMz5q039qz7j4=; b=H9n5cXN84Zm4eSfGSQ0Huw8a6I
	EZ9BeC1qpspShG/pe6U3ei/u5LRprPeiRvUNoNu2CcqAj8Xt89DX2uPAD7sDTA3x
	67b8FtAmO3hT+DLPW/GMO4nNkeTP3Vkp6KhbksdYc5sJoPWPpzw9Uc4F3sMRertD
	r1API/aYvnsdvIo5qCxsUush2Pdm+O1ifc7gGlWd4awWdaex8lsJG1JQ8Ng/0BT/
	bZSbNm3b8L0Qv3gf9BfMHw7AhO6wbvpyWXfDj6n+ba5/k4qf8ThDMiltYb5lnL85
	C90ROzs+Jz0EpSq9cFetvHs1b/8LkDSm+UlXNDaTxy1CRKbCXMlS/+5mFfew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459417; x=1725545817; bh=5y0/1zHWYJX6wD6AkHH3apsZ+ngw
	F9tMz5q039qz7j4=; b=Xxy86Xognq6gfdkk1WppEoupkV6SD63/HOyDCDtHJ+VB
	LXloDwPnDoLS8Jg6SyIJSiQXM8FvzVCPXoSePsZ17BoVkH0SQVOBaAjUbOzpxW6N
	J0AMkqrt/OAIZ/ICHu1ZgyvPhv7fa5D9LYKCttiu3ktCI653LVS1B+LF2NzpUQOo
	/GtmcfJiAeCxEzMZT2zKy/k4nk79z4WZXzCa/yZJydaXRjLNq9AhCXe0MDVXpBH5
	vmOcm/m4FmuneETmu0cz33oc7t1dwc5uWAree4gdQfrhPO/K1VSnTPKqufmBsl8H
	dLDHWutCDlZQ7ENaZtpJzVUgLVYIgb2R9+ACKdyqSw==
X-ME-Sender: <xms:2WvYZgIj7mjZk9hOJRuDAsMx5LSs5IOlZ_nS8WrOX3glsihH7ii18Q>
    <xme:2WvYZgLQpurEAQcaFyIwLPkmuzBb0q20kZzI_RKyBa9gpWEiSUKSZcoU6NiXoQljK
    J6Y4Eu1wLPBksGuSA>
X-ME-Received: <xmr:2WvYZgu1ID38E6hi3u6vxxKuNzhhUKIxScv0mf2RYdpQvznvbEUR8LJ_8peGn6gG5tb956KuA6nPMWabhfqJAbsZIBjhn9fm9ioG3WYBnuDtyW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepshhp
    vggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgv
    gigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:2WvYZtZjnB6RMGfB37NYlXAgXhyRVW-mwOl4Wfuq5iWoVGKcTzA9uQ>
    <xmx:2WvYZnaK1GNtDzsxNzODXOadHCTNxvZYjSbhTRNnZq5X4UOtIaFsTA>
    <xmx:2WvYZpCUk-_yK5Z_ccFCdmYoULlTql3Nen_cLs0b-b1nIetH0ViX6g>
    <xmx:2WvYZtYyreD9MaPbaT0yFoFoA9v-LoeS_LtGGFTQe4q8bpxGyGDjqg>
    <xmx:2WvYZhkmipjnJzQA8JayC65jklAPWWhYuIWLLWtYMcOWSjVvPk39ieiN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:16:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a44b8e92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:16:46 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:16:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 04/14] clar: avoid compile error with mingw-w64
Message-ID: <658a601c5411f38457007ed961582b5d898f813a.1725459142.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725459142.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725459142.git.ps@pks.im>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When using mingw-w64 to compile the code, and using `_stat()`, it is
necessary to use `struct _stat`, too, and not `struct stat` (as the
latter is incompatible with the "dashed" version because it is limited
to 32-bit time types for backwards compatibility).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index 3fc2c768158..e2ebe551d38 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -68,7 +68,7 @@
 #		define PRIxZ "Ix"
 #	endif
 
-#	if defined(_MSC_VER) || defined(__MINGW32__)
+#	if defined(_MSC_VER) || (defined(__MINGW32__) && !defined(__MINGW64_VERSION_MAJOR))
 	typedef struct stat STAT_T;
 #	else
 	typedef struct _stat STAT_T;
-- 
2.46.0.519.g2e7b89e038.dirty

