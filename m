Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED42D46AF
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004204; cv=none; b=LqjacgUxP+YpdwhV+jPb/UJQ3WxDf/tP5ccraoLYMGoyRncigYchlSO5+R17lEHyhkodeIjuFra1DfrMwPj1WAYULdb6wMLJTVryPV3RidDh5NK1qa2Krj3sFDSBA06kzO7+CfZ0fa/kKImrhs7hYpcsP1a6A96ye3Zrqrc9Miw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004204; c=relaxed/simple;
	bh=6IGuomfapTaWUiGSDKvWBLJc1oDUqpEf/RRSO4BFtCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d6vLtkH52xVyR35BhmZd0dERf0cK0NGpg54Gt7tMxDVRN8LctbbyGaR8L1uExvTakUeOydnxeeisliSCKe4ZYiZetCY2Np2KCJ62nZusqLf1ju+Y4sAbOWWsUMqxubYU6rIpcVCPbomk53H4QAxJHPRwe98qCVMGIB40aPNZAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gptnv7iU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QwJ94L0L; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gptnv7iU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QwJ94L0L"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2BCC9EC0053;
	Thu,  4 Sep 2025 12:43:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 04 Sep 2025 12:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757004201;
	 x=1757090601; bh=iW6bgZoiHyxptdvCMMN4Nf2Bc3C3hERKip0ZRznqThk=; b=
	Gptnv7iUv2Pub1oeu1WAtknJjV0ZuiwGagvngaX+ub4WeEgmIZUJbZOq8ns9OqNU
	dOV8iBSggHV7vMB+tSdkHLOjUsbyla1wuW6VIm0BSRa+z+9ZOkZxBAeZ+rwLZ2OF
	C5N8jrbDLbyg+LWGHMOP35dhH9lc09/Mpgwv9MXkVrJGnou3SVZR2SZpUjTblHtu
	mRRiVFLzX2KSi/rhh/dpThIe0vB3PzLrHmCQvNt/DkvSVpuFOCilMR3+R7AT4nQG
	2muphzA0rG9S8bjZat9MvQJKiB3NMwdBWXYEi8daf/ZTPSs5+TU498OS4H1K1rcJ
	Wui9YkI9vGOLvMaDibQ+IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757004201; x=
	1757090601; bh=iW6bgZoiHyxptdvCMMN4Nf2Bc3C3hERKip0ZRznqThk=; b=Q
	wJ94L0L/cnzAmvdKinV5rA/FWcypO3zmqZPmZtfCGdPZfIKt8cewNQUIMGzoBdMZ
	G3Vh5D3AbjIBplgSiDJ8X7EjEJSvy6/Egi+ZLEmuaacaiJ6b9i2hkqNz2OsWcwGq
	4lvFiFTj2mJ/ZcpEfQzOjAlvEMIm3dQ/D3g+aBmuZc8yc1kpGbL/YDNbwXRX6i+h
	P96LaM+/Gfn1AAF52eyWRwXoNpPBxd9dKqNr632fM9hgF1GT7/xwX7YY7ungeUSk
	Dsut9INgkvzaO28uNX9W+QaGcsXXAhuO4iXNeopvaN/Blz77XFNtVdYfJZGEr9Yy
	wnJocIUfP+TI2WmioDcqw==
X-ME-Sender: <xms:qMG5aM3nai7ZK7bVvO4EzWq7_1_RkI9ogFw9zu7D4JFRCZ4AAG5jYw>
    <xme:qMG5aBrurLQBL_jjRq6P6FIF3kiTCPNzUEAbNkMBwlO96-lIzt8ZgaRu6EXmLRnHf
    SyYmWoDpPpyHglhzA>
X-ME-Received: <xmr:qMG5aBfLpDDBLFxs9Cc5YRg5FnIwPMv33A1tChb2H2ELObS8JDh0E_GzFXWs0ys2FHfWD6SeraTjoeLMCSQ2rKqDLDYawOjYIdqsaeY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeihedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnohhurhgrvghllhhmsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qMG5aIpYFp0BzDwlNMC_5fh_1ibwZNAe2TnjyZ0mph-FCGf7OqaP5A>
    <xmx:qMG5aKH83Y9pVfoXSkKoIxULFXODiOsay9jhmH_ioy72iATBMq1Xig>
    <xmx:qMG5aAtK1LyNFYNZanEO1sEmoL3CMYef0DiheXruGHYzgh1biOtBjA>
    <xmx:qMG5aEVPOggV2MVwU0soWGuFsnaG4-lv3u2EsLakaRLyfw4QYTcQbw>
    <xmx:qcG5aKEbQY329dhW_LaxuMI4CajYpoMM4FUX6k6bEKXutstx3tm6DH25>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 12:43:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?44OO44Km44Op?= | Flare <nouraellm@gmail.com>
Cc: =?utf-8?B?44OO44Km44Op?= | Flare via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4] alloc: fix dangling pointer in alloc_state cleanup
In-Reply-To: <c8137063-c928-45a1-aae5-9de2b35e5150@gmail.com>
 (=?utf-8?B?IuODjuOCpuODqQ==?= |
	Flare"'s message of "Thu, 4 Sep 2025 15:25:57 +0200")
References: <pull.2040.v3.git.git.1756472406487.gitgitgadget@gmail.com>
	<pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
	<xmqqh5xibqvu.fsf@gitster.g>
	<c8137063-c928-45a1-aae5-9de2b35e5150@gmail.com>
Date: Thu, 04 Sep 2025 09:43:19 -0700
Message-ID: <xmqqms7a9niw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

ノウラ | Flare <nouraellm@gmail.com> writes:

> The point of the check was to avoid subtle crashes
> aligning with defensive programming requirements.

It is a programming error, period.  Do not silently return.  That's
not being defensive.  That is sweeping a problem under the rug.

We can always do assert() or if (condition) BUG("...") if we are
unsure about the ability of our developers to grok subtle
pre-conditions to call into certain code paths, and I would call
that defensive.

But I do not see a need for _this_ particular call.  Our developers
should be able to see what they are supposed to call it with just
fine.

Thanks.
