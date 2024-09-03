Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F601A3AA4
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354891; cv=none; b=UWvU1GukH3X5mKdJTb9x6F78Niz1eLW7oKZvBlb7Fbkb+u5LeXPOn8im0Ch6YVAOnb8N+QyxC3kWk5nvfHvsgn6mZRGDDoLvCLMprApZNUZRShG4lzS9TisX4JUfAmhN6e1hIzDvidrPo6zgZop72SGjYKGMM1UPEHu98xEOucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354891; c=relaxed/simple;
	bh=0fyQvM2FEPi3i3CG2dpJM7QRyfkiVX5/0CaO1OY8+Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJXj74nYmczoYUDmDHq6CDbo2vhWTJVJxv/VFZWjMVF9UuXi7f3Ql9hPV0ql+kFtMVATXTGDNpFHitn0YTYfjHjXYM4FMqLR42ou3y2BcDHC6qw27z2RUN6cywqkzzi6S0cpgKcS6qaVInwz6qU9rc69jRMZQBg+7u/az9KHZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rYSmopzl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gIgBXT0w; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rYSmopzl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gIgBXT0w"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D47B11402DD;
	Tue,  3 Sep 2024 05:14:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Sep 2024 05:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354889; x=1725441289; bh=+2XmeVreAq
	Puhzif37oJpaNSKtzjS2WxILwJTxj0W38=; b=rYSmopzlktfcCG8ngl06mkPbUA
	xznP3lDV5Wjm3UJbZjpU1OtqqnX92ml3Gejz5YCXhBq70lJFCltH76qtVvgpkhBT
	UkLp0oCwDPPF1s/gT0aGlnfFrnozpinyEL5h9tECwK4yYRON8SacO3HgcLjJpkPo
	8tFbLCRLhyVYGl7SoEXdmD/l8gFEEIEjDvNCmx5Io8rCBk+Oz8J/bO34QvdoPOxA
	MQwLKnJwF4pRSHcp7Nz8oJyGJrpH5d7G6is+6r2OqNqdDLZEzQGkEEjVwgfNsNt5
	OoFvYgtgLggFcDvcutVbPhFyMXVAvs660DYMSao+j/vdbC9GwNsd1aP8jaiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354889; x=1725441289; bh=+2XmeVreAqPuhzif37oJpaNSKtzj
	S2WxILwJTxj0W38=; b=gIgBXT0wAi/wD9rEXPYsqxUEgg4nJr78+Hs1+AqnPJP1
	kMr979rqKUQs7Sihncc/Z8RwjhGN1e3ycc5AdNFclCGbhDGQLspduGx7OVLL6w4q
	71qIEcrpK3/wQnwgwpTZoPPn1FCRAbEUHo1Y7qM5aFz44fNZrfZntdyKb/gDoeTE
	gKas7mg/26Bgcf4IbhUCFU9QFuKiK+OV3E7zIL3nHaEYKV3n5YXK9XS1QXbGTkJR
	RgEe342nrw6YcWW+DTRiW6hdahdVsHQIu2chTCI2FR7NjgezF6heDKZexhsWc+Z9
	MEAgy7a4c8hZkBza4nJNRp4KLjiMIjLfVF5T358gCQ==
X-ME-Sender: <xms:iNPWZoO-1SBPPtTEVD2G6liRnpr-62MUzI7p0MrefGs867jt-cqs6Q>
    <xme:iNPWZu_r5YYgJ7kkBokG4LteSY-NGfGUXnrQjMjx8T2DnwPtUQDQKEHaHOuj6DS8j
    qYBrxsMIBqrjw64Iw>
X-ME-Received: <xmr:iNPWZvSGkrsVENDVunk2H8OTmBtefIs0nM6hHhdcH57CmD7FS6gkUgcG--oyKl1hTC6olOTYH7x5QVAcs4-1UkHRnnlxZg9iGDMPpkigHF24yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvg
    hthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepshhp
    vggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhssg
    gvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:iNPWZgsadsg9pNW6GDB5NCyR5ivLZja8CD0r3V-SdgIWEJGs8WTY4Q>
    <xmx:iNPWZge9Fj7GJPsuZDgWOi-k5ei1NchabD4jr-dfmW0qv1Ya4oZf4A>
    <xmx:iNPWZk1i3bL3Brh6C9q-n3S10VRa26ftWRSzcZEfcKbRBqzRbSO4Ug>
    <xmx:iNPWZk-aLebofypCoQBT_pkpYiyAIuY0e7kplTm7_Hoi7hmr8un82g>
    <xmx:idPWZo7TQdx9_TDIxM3Cj6Dnex71G97pfCQ-SBJogYYcnnb9zkEaG21c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:14:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4766d17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:14:40 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:14:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 04/14] clar: avoid compile error with mingw-w64
Message-ID: <658a601c5411f38457007ed961582b5d898f813a.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725349234.git.ps@pks.im>

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
2.46.0.421.g159f2d50e7.dirty

