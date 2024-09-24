Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B113B780
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172347; cv=none; b=Nl+WqJJWbCZioAdNwHS0ju/84YcnQ3ZFuanxsQym+sWhmVP2j4wquf4/pce/73VpDq0RL7Xd6Hgh4V8SC0cJeswAWtuy1Fs296P17OsaZ5AfRJopkxhCBIitnnLkw37jBinUzrfBy5i+s3DGDT8zaQjdIfvS7IN2pK4CO7dbs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172347; c=relaxed/simple;
	bh=V7ESbtRhPGEQDL8CjJcP2JgW1NYuGVgaKxLYqaG9YfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkxPmNKRjjXzA4pn2Tg9VYCQH3VhHtSKxjle9ImrTEfa1efQVFRiJ6Ifp+dPzeproybj6HKfKMrfDDduknHkdGymdAo5kK9aNT46IcyYQ/mD2RBFLBDBr/fbnESIL81M6cLTgZK3JhLkUp42feylFdXoeV+3qg9a/uWVnA2UA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GYSNFk2u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o8dskOs6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GYSNFk2u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o8dskOs6"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B01C611401B9;
	Tue, 24 Sep 2024 06:05:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Sep 2024 06:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727172344; x=1727258744; bh=ldVdXIYd2b
	bYxSkPS7u0/BT5BNs7/vuNLIPfr1xe68o=; b=GYSNFk2uN3gbgyn6ANp8yOKZHI
	OLLKiWBTvDGR3RqPa5zLeUO8purscux0M3CYMlhoFAzQMZ61WfjaxKrVTzlsoM0h
	eCJStshjGtqboEwmmCMc7uCaXHC9ORTpQ+VJfSSKYYGvXXmemv8qUrF2r0StfZg8
	EMB5HEHillqFtDgIkuiOdIqwDPrC/943j7ONqwcEy1RDywg9Yjcnb7PKVWa335hI
	eIsDE1je+dmoSa1MbhX9XEPDxYAt2pRgB/TiIFho6Uoe4U5qUTSLnizNT4Gpgo6Y
	vG7z+/Y8lzGPqaVLifrsYeac+Y962KsvTPvl9uWQgsQ3UeWs3LMFdp/usA2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727172344; x=1727258744; bh=ldVdXIYd2bbYxSkPS7u0/BT5BNs7
	/vuNLIPfr1xe68o=; b=o8dskOs602qxPigd5eZFPJfddKmG33H26Gg96kTFOpRO
	5ZztGgmSl1eyisPDzbKo1GLh5hRByJMtaXSfwB8kcTIoohr2EvS3eDBkcVaw9P1w
	APK15Fn/gGU1sSo2bUZW85X8W5fW1APxebeTkcdnxjhCq0uKCNr41YSkwztnVgXr
	hA5Jx8o6enS8Syw9DNPJwekWE0Ccmre+P1MiTmMwu6p3Q7JyUelaPlntmGj6/WEa
	A5OqmuEOi3ncV8dR0JK1iysSBaJK/MHTnku/yKmzkLNShPZSdnOwOTxDrLH/rMoI
	2s+b5K3Ss0kvR42/JdJd2qwfY5jNHO68dcOGAW1Eow==
X-ME-Sender: <xms:-I7yZh8_x-AlhbhaKfuf20E6k_X6QWyKKCNN5B73lzBCu3SAvX1LGA>
    <xme:-I7yZlvWFRKz6QtnlkHBVZUYrJFOlc9Uzg-4hhLnkkJ_JsrcpuoPRyELtYAC1AWqB
    21YGj3svDljT4csUw>
X-ME-Received: <xmr:-I7yZvBeJs-99o5COTL6mQI5XWjWQsoqi4_nkCjg7c7dZhcI52bhH9xNWEXOp6vsafNALtwBaJcTSWLRmeiITSIVDiEjXXmF66JNF2lspjxfOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoheprh
    honhgrnhesrhhjphdrihgvpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-I7yZld4xZYFVr9EhIwXelJ0qlhKG9EY7atq2lgfUlV7hNMLF-RQFg>
    <xmx:-I7yZmMrqjpcVqXNg3-b9bfhWFKGEAH_iTELfS4fIGgCwmrdBhNASA>
    <xmx:-I7yZnkHmjdxfRKr8oE2fNEqIY99vL7bbAtbKkintftg3R3urp7u4w>
    <xmx:-I7yZgt2dVO7NuxIvmGNulwlU-7bbcMj2rdCT_XAWlNo-C6nYSxWig>
    <xmx:-I7yZjqb_e9DvMuPq5wmJ-NmljRRalhHrfX-B6E69lSRO-cgGl-8tn19>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 06:05:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f148505 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 10:05:09 +0000 (UTC)
Date: Tue, 24 Sep 2024 12:05:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ronan Pigott <ronan@rjp.ie>, shejialuo <shejialuo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 0/2] config: fix evaluating "onbranch" with nonexistent git
 dir
Message-ID: <cover.1727171197.git.ps@pks.im>
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>

Hi,

this small patch series fixes evaluating "includeIf.onbranch" conditions
when running outside of a repository with an invalid gitdir.

Thanks!

Patrick

Patrick Steinhardt (2):
  t1305: exercise edge cases of "onbranch" includes
  config: fix evaluating "onbranch" with nonexistent git dir

 config.c                  | 15 +++++++++------
 t/t1305-config-include.sh | 40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.46.0.551.gc5ee8f2d1c.dirty

