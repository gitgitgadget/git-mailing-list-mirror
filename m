Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962A9443
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568659; cv=none; b=BsZlJGXD+xG7f0bukf55w7n3HWt0czJEUJm2KNZDNxBVieWmGGQPllbngFXSND6cceEBuVTYsh5XFOWs+5QxxUlUPK+M9USb40HbvbI9qunRsn+KAQCGLQdns/SInWS9B3TimDaNTwckTno0wOB4a0NcnboyK+V52JlGmX20GNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568659; c=relaxed/simple;
	bh=F1qXKKxn6qlOhhcaSnL3eXwfcredXi8fPUmb5AcXRqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXkzANmfrN9zgCZL0qaB8HilS4afI4zWOCqzuRVIfrj21XQ8YMd2rvyV0fNG36z2SB44GRoHzPmMcQkdqPobEJJr0zw10pOgkO6hX/tQzd9geH2MuoveG02fSULJ427+/Lk3/q77YSUMrQdiur+78/UftdXNS2fKghOVf2M+J9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KnfO5GcE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QpnR5Kgh; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KnfO5GcE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpnR5Kgh"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7CD6825400E9;
	Mon, 30 Dec 2024 09:24:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 30 Dec 2024 09:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735568656;
	 x=1735655056; bh=h2Rg+tajdGUbOw0XncBtF+Me1PMA2j8MSqO5VdtDHrk=; b=
	KnfO5GcEbC1Kd6JwK1SzvLpN0qiSaPurrsZO5D6LteGl50O9PhxRZVFphAA43oNf
	CI2laseV1JxGYP2r/u70cGG4v9HuFbpps0sSHTa+cRP0wTD+257xebRoV+xgyx+K
	Yz/BnGZsOcwFo/vpY20pB6m8PgPbcA8wdwCzntvApCgfYZJWIrPKnkc+VucK3dWn
	zsrEDH2fHFxmsEgz4ETSMkIFQRpRLlmhRZL93cYWmrky3bPZoqHyGzWOGUFmcSB0
	z14lI3kC216JoXBAkxa/+v+VN+XsGYSl1dyX3ViLQmtwiAhpCrjSykAYuX0OAsZl
	EMji6DgAcUKCsmfMzrbSnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735568656; x=
	1735655056; bh=h2Rg+tajdGUbOw0XncBtF+Me1PMA2j8MSqO5VdtDHrk=; b=Q
	pnR5KghCE1fw5s5nomHX8XdvdRfNFJ7NvAHzGzeE0HYpC21f3OUzqYd3nFcGJC+0
	xkorn+gSpQxlSY+Hmx8XRxttBdt69+SQckShDgSXdnSOxOfdQsIFwp9AhGDflvij
	Dz6UjkdLBEoVV2KePyL4JUnXLQ6DZxwaSztBKQQ1v99lgISCa4219MApktnQ16nZ
	MKajzMR/qJSF8L8fv3HFF7ngycym4ZDbZuyyjiq45z9wqLJEjWU1jRNqWruelrUU
	Tt53grHsK52BijV+elpXjvxQMCDLpnsv1mK1sKXj9gsULQL4WVEr/r4YO4ZNj0gA
	fwnCGMJOwl3k0cLJI2mog==
X-ME-Sender: <xms:EK1yZ5-kYYSKukZN1KgvuHEHwW6i1KJ3-p0XtEO84dLxUEwoXatZwg>
    <xme:EK1yZ9sNBAT-3nL2undxxY82Yh3Po9DrYmgZ4VixaS2A5tMVU5u4SamW4f_1JWdFA
    aTaqiydiwpWZAaUUg>
X-ME-Received: <xmr:EK1yZ3AAcQFwpeyh8G0C_eKbB24K5z3spqo4kgoZ9DRE519R1g-HIaWKvPKWgAXtXyKICcAjS38PwEG3LdIV1A4eLwRaYv0LKKs2s0oer5Bpp1BR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:EK1yZ9c7pe_Pb5EDQioOwm5Ghy-6W9H2Cneveq_NSqWDlkM6s0ujJQ>
    <xmx:EK1yZ-NolVUyXl-VzcH1UyECsTxWN-Bs5sEF1eX5oMHBp8vigLH03Q>
    <xmx:EK1yZ_k2BLlGF7-E_mVfJWPN4ELwd5inmFvWdxWXluhZ4PcjLg-K4w>
    <xmx:EK1yZ4uvWJ7EvAjHadX5UcfyX2U2HC419RSZkj29AgTjhhzco0ZVPw>
    <xmx:EK1yZ7oiVfbbMdFh6Op0w7BbIs97RcAA6HkodVmsrc6WrQiFwrCN4loh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:24:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 053b75c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:24:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Dec 2024 15:24:10 +0100
Subject: [PATCH 10/10] meson: provide a summary of configured backends
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-pks-meson-sha1-unsafe-v1-10-efb276e171f5@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

There are a couple of backends from which the user can choose for HTTPS,
SHA1, its unsafe variant as well as SHA256. Provide a summary of the
configured values to make these more discoverable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/meson.build b/meson.build
index dc82c23cb4f07646a9a7bb96fefcf832f9840975..7361eb2eaad422e7a6c6ed95d275615836c21cdb 100644
--- a/meson.build
+++ b/meson.build
@@ -1943,3 +1943,10 @@ summary({
   'perl': perl_features_enabled,
   'python': python.found(),
 }, section: 'Auto-detected features')
+
+summary({
+  'https': https_backend,
+  'sha1': sha1_backend,
+  'sha1_unsafe': sha1_unsafe_backend,
+  'sha256': sha256_backend,
+}, section: 'Backends')

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

