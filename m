Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98B1AA1FE
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568657; cv=none; b=AKeAYdrpgVUBTwRQd97ZLdcbS7Lc36b5z0xFF5E6LepvoXvngNNzDJXUWAlJie80AGXCAu0x/Ae8LPh2h2LqP73NBUdRXsPSImhFlCA2Pnx+D9hope0qeRifU2t3Ib7o49JRM9IqWIfG6lqjpVoAAxR2ndMYPe+zUqJVJ86NAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568657; c=relaxed/simple;
	bh=fBGsxttnHHDLqfdgCsaDtfFl8Le/fzc39NtqfJA2dA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqUjRU2BpexYm/srHTsS1RjwhMKBGft+ihuDfDhzYhHpA8VDjBStYvT/KFmnN9gyRK/YYYC4ib21iCM0mKEOwADL8vUCLrWsMEoko8tnYQPot0v2NwYggrHDsOTVVFjyy8NLU/zkyNLsOGpkyVWRMTpciVmqYy4XQc/lT3hCiMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jyvn9vZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=snkm3eJx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jyvn9vZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="snkm3eJx"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A230225401ED;
	Mon, 30 Dec 2024 09:24:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 30 Dec 2024 09:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735568654;
	 x=1735655054; bh=vIKSq9J2yV8MQCRaHguzZXVsGIAM+SVClJ7OdBMzfZc=; b=
	Jyvn9vZWGq+tssyii1tUh3WmJ7iF1WKfJCWNcIBs5l8qHdHL78D+oyZtoN/ionpM
	2g4AgzntnhcpZj5hlQKqMKbIB1qKXHBxs9OFIukjcJRb7cZPg1GHfw85YuxlbbzS
	J2IJ75UADbCHFbQ8lySlAgB/LIOGr0/pbVo8CaLTCAvi6eqXbVwx8o6D6PiJUp7g
	hDDi3szQXqUeJRCdOzMMVjcDBRvmvtdC7khVROyHryVX1pnedCxq34j9iySYz9vG
	2J6yd8HrQIhRUkN9P+672y8Nl9s7Glf79vnjhiR2sTETL13ACq8cynJ9hX962/81
	7eUVYWUpcAtGFpCTcf8d7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735568654; x=
	1735655054; bh=vIKSq9J2yV8MQCRaHguzZXVsGIAM+SVClJ7OdBMzfZc=; b=s
	nkm3eJx1zoHVHSraXAMmQZelVRdPYyb2lhvSyyqocHjVeXcNF0Z03AozaVIV4/6C
	FhJPUBacFM1r+07ZUQKuEh/N061LZVMUQkB5MHdpeUAxnAi45yy2+IYvOrUMjZ8E
	dG2FmnP0Nun23uLi2Xx7QEkGXg/kwbgYciWTEkBX0DG6yzOtUycQfBcyE9qxyGcH
	/N838MCzr8pIE7a9faq90/FSl8uMqXzPGmG/ZTtdYPnao6BC2XjO+J+L1yDV2c7e
	nWI+pZLSUn+IzXtnZo86SZNgNG4bidOFlTZg0ylBnVS7saJrQov4BcV4J0r/WWV/
	CSwgkFVcyISw/fo+0bjqA==
X-ME-Sender: <xms:Dq1yZ5SgRjNBCLcghT5hReA-6vgjdG74mJGJqrDY4ShZIn882dW_eQ>
    <xme:Dq1yZyxzvfHzBb3CDnKmgEqaq5CMLphdiMBS3yoWBKaXOYsUTJZxBRwc7QSnXOgPq
    KU8fTPCmjosoRHXUg>
X-ME-Received: <xmr:Dq1yZ-3pE2-YfK8SdJzQ6dgplYh8yNJlbsIYXDLduJDrJvq8tLRNCffXq2QY1YMu80flRyDwqfU9QwmPXjenGV0JDj8jU5rXSI-tFcB3M2Hb2raP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:Dq1yZxD0BKFhQ4jIoV1a89j6c2dtmHx5cHHUqRVFRrrnwDI4OFYfrA>
    <xmx:Dq1yZygPZh3dfJuzVrpu1bWlTy1SdlWjgOnVOyK1__tetofKn1A4sA>
    <xmx:Dq1yZ1oA2V_Q3kni8oSLrckPlDqU-jCP8kGEBIQ6WlExKATafqCxrw>
    <xmx:Dq1yZ9iTS5fglSOhwopa-uDcHu547FZHtHaNKyvfib51TRvf54GOLg>
    <xmx:Dq1yZztX2_q0IW-Utq-EtG-ajJTL1NNkamGalkBBLCzCvawoD6AFBXVt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:24:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6914e682 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:24:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Dec 2024 15:24:07 +0100
Subject: [PATCH 07/10] meson: simplify conditions for HTTPS and SHA1
 dependencies
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-pks-meson-sha1-unsafe-v1-7-efb276e171f5@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The conditions used to figure out whteher the Security framework or
OpenSSL library is required are a bit convoluted because they can be
pulled in via the HTTPS, SHA1 or SHA256 backends. Refactor them to be
easier to read.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index bc75ad954a4949342125b769d3d8d8362ef4e8a3..46f807899b7bae33dd6aa7a94a54931d69ab0d62 100644
--- a/meson.build
+++ b/meson.build
@@ -1329,13 +1329,13 @@ https_backend = get_option('https_backend')
 sha1_backend = get_option('sha1_backend')
 sha256_backend = get_option('sha256_backend')
 
-security_framework = dependency('Security', required: https_backend == 'CommonCrypto' or sha1_backend == 'CommonCrypto')
+security_framework = dependency('Security', required: 'CommonCrypto' in [https_backend, sha1_backend])
 core_foundation_framework = dependency('CoreFoundation', required: security_framework.found())
 if https_backend == 'auto' and security_framework.found()
   https_backend = 'CommonCrypto'
 endif
 
-openssl_required = https_backend == 'openssl' or sha1_backend == 'openssl' or sha256_backend == 'openssl'
+openssl_required = 'openssl' in [https_backend, sha1_backend, sha256_backend]
 openssl = dependency('openssl', required: openssl_required, default_options: ['default_library=static'])
 if https_backend == 'auto' and openssl.found()
   https_backend = 'openssl'

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

