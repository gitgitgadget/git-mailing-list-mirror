Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC651F17E8
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751928204; cv=none; b=t0CN9q27uco3mR8kNUyhg/daHRKXXGkWwK3GYt24ZVIW7LMMQkSkm4w9O5zelTaoiUwUV7EdcGDQTFggLZI05ALQoqVkA26tDCB5VuLfPx64LInaT37FoKkUY58jhyTDJRACS4hQT79EQNjrzuWZPFxqnauGJRG7gqtkXSEZKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751928204; c=relaxed/simple;
	bh=I/ODsjuE8gVuJbkRAsz2sGA4X53j8h2tK5yKhJbPsR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b2vVcUUx2EPoh4TQpGBuhj2eOUhTjNVaa7aVN3rWOsyV/y8WQrdDsTHBWzjJHaP1d8SVXL4RxjN94nCdqs0rZhhfVAlsiBfwtoz3p6Hm7J0Jqi/xVtthUAoK1r4PhoaxkHuNOJ6ef5Zhyhq3FgbkFc9ACftsLpFGJcdLN+VNy/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LI7X++Qz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sv1d7HHZ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LI7X++Qz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sv1d7HHZ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B259A1400181;
	Mon,  7 Jul 2025 18:43:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 07 Jul 2025 18:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751928201; x=1752014601; bh=I/ODsjuE8g
	VuJbkRAsz2sGA4X53j8h2tK5yKhJbPsR4=; b=LI7X++Qz52HXa4ja5mWjKTArhN
	r0tzkOUdhRQjSWBx47R9Vs3m0qT9CUUG4eETURKfP35+/ZZ6+gZHUpI2Yd6sVkRb
	5pjXacARPrAgUGCOJQmUt+1cBGsogCgvXZ4bP7p0HXwqrEMFnMVDYdptt3fsVHqZ
	vkt2QRo23kf14aXKdUDA/mnEk2EbPZ+KzTc5QrUrsnRkPl1tn0U1Bm0/R32BJZFO
	s5sP5DMGOKRus0j8lQjkLY9RZFAv/2lCn4YvJykeg7ZNAQfXkQsMSbLn70NJmqgV
	HpeJTx5AwhRQdIN7cDypEfyuA5MJdUOxcGXjygorS52t1UFKCZ/goBSSOJhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751928201; x=1752014601; bh=I/ODsjuE8gVuJbkRAsz2sGA4X53j8h2tK5y
	KhJbPsR4=; b=Sv1d7HHZn8On6/HEwpiynyeEeEPOgpRIqwyDuZuvOFqftRAyMCh
	t/wATJsc4HliiPNzKA2Sgx/RASpjMb+4dRw7VfWC1nceI3eCJqbixS/Nfq/tggYd
	MrROFGd1u6PsJRLzPC6a2YowzGOlYnO791tMKIekIvFitMvtfdrazpUvxTwrmrO8
	/7Lipgk7LjTXsO67XNQUXbNQ7cQItRIgs3avtae5wEEeiyO3SiauvZZsqLevVZpY
	u/z5RReY5MsV+WQWUDTNfv6Q78si2K+p4G31kg/KOat7jo/pwQYtyDMtBLrkbKR3
	d4oNvvdEEzJIUtKXfgCO4GnZDmsfbaoiTmQ==
X-ME-Sender: <xms:iU1saGsuEMR4Fxntm07FZf0p8RCER6xvaCdp7Iwy0-thA_SZIfjOlw>
    <xme:iU1saOvtuc0-fudFJa6xWRhGoJG_mzr0dZ95u9i8ZQ1J_Zl0IYqnV1C7Xb_IMsAZC
    ekc_J12eCDY5Rk7PQ>
X-ME-Received: <xmr:iU1saLPyWatdPCyHergokMFZkmcwty7C639ULc-vSHneeMsmhsjcO53c5yyGvBaZJ700pcOGlryGgUMpJgu9cRXiFOpTiGS_U9F_N8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgvsg
    grshhtihgrnhessghrvggrkhhpohhinhhtrdgttgdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:iU1saM2jvib6ubFKPk7jqvJDOlvNfn6_QEQm8ZoAYP7Wh0vnfkpKYQ>
    <xmx:iU1saHNt45dD7B88DMYA8VKnZLAY62D4ctCD04YPVemUeONKmNrOHw>
    <xmx:iU1saM31AQ49vwyynz6twcSzn4qAB69BI2m1NJuvVk274Rk1AESbMg>
    <xmx:iU1saOGW1nthWsRf4H4T8QWhf_JWuTtUKUA5_hBPZoguSth4KXDWrQ>
    <xmx:iU1saE5IymSG_tWDU_CQMeOS9xP7mADS5n8-ReVO3NsrbwF87msJ35md>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 18:43:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/6] bswap.h: Rework ntohl handling
In-Reply-To: <20250611221444.1567638-1-sebastian@breakpoint.cc> (Sebastian
	Andrzej Siewior's message of "Thu, 12 Jun 2025 00:14:36 +0200")
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
Date: Mon, 07 Jul 2025 15:43:20 -0700
Message-ID: <xmqqo6tv1v1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <sebastian@breakpoint.cc> writes:

> since the add of bswap32/64() support based on __builtin support, the
> usage of ntohl() macros is broken on big endian machines because the
> macros are always overwritten providing a swap.
>
> The first patch in the series reverts the change and the following
> patches try to improve the situation by allowing to always provide an
> optimized version.
>
> I've been looking at recent compiler and they manage to recognize the
> manual shifting and use an optimize opcode if available. The ntohl
> version provided by glibc already provides an "optimized" version which
> makes an optimisation in git almost not needed.
> One of the motivation behind overwriting/ providing an optimized
> version was to provide a macro instead of using a function call. One
> libc that is still providing ntohl as a function call is musl. So it
> might makes sense to keep it.
> While ntohl() is provided by the libc, the ntohll() is not. I found it
> only on Windows provided by winsock.h.
>
> I haven't touched the put/get_be*() macros. gcc & clang are both smart
> enough to swap the content accordingly and perform a single store/ load.
> Only the msvc seems to strugle here and performs multiple bytes stores/
> loads and shifts.

Now, I see many comments and suggestions on the thread since this v2
iteration was posted:

https://lore.kernel.org/git/20250611221444.1567638-1-sebastian@breakpoint.cc/

and I think the ball is in the author's court to respond.

I'll mark the topic as Stalled in the draft of the next issue of
"What's cooking" report.

Thanks.

