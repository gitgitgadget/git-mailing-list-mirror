Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052B130A47
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897566; cv=none; b=a3F01/Q1vDAA34hEF9ZV2IK127V0XqY5eqJvQ63mu+JlF7SshzAl8VqlZe1tYmuHDlwkBQQZWFAewIf6Yg3gC2RG+rcNPOyg8bjUu9E8HuanSWT/XEavXONBy3i1D0JgEqkzRvL3JfPH/IXfg+A6r92IYAI0tx4bSrbBceSvkLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897566; c=relaxed/simple;
	bh=pg6prZiNj8pyBNLB1sOfsXQzLEQj7g+LT8+TVelKeyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MQn/ILVhHySoJONAOYaqhbpuqzQ5G7BB2liXbZ7Qd4+Wh07fu3KzpQsfYNKySXiJec29sU0WUr9qIqidd6FGmfFe/tEBvizHa5TzdoHc1k2JTlgrHslnr+Bu8gL/B/2SfB+zJNRGSgMyYb6xyu+21BlNz63sfzur9+wSrRYLtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZIYwyuas; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TE24gu/e; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZIYwyuas";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TE24gu/e"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C982013801B8;
	Wed,  2 Oct 2024 15:32:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 15:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727897563; x=1727983963; bh=2Iw2bdjI42
	cKMo+gwHQR6nWibFJ3JflkDK0gHD3QArE=; b=ZIYwyuasFK/03aGoRqr42IXQgO
	XmXBQUuFI6yOdSrpvOnWz+We0IY/UY9/NEYONZau4XyPSVnJYbYMsXQbSw9Ce62Q
	8lBJEjQK4nZSUMXM4ubTdpcKNRmRS4A05kbFTamlIrrrmTSUPENaASwGUjKan6Kn
	nb/1LzMea7rSA/8e/imA9SFKAQg5L1o1wXtl0IiGDbN8qL1HswEQbyjpPvSly75F
	hNiqaFbDb8zGU2tNBB/hGT6YB2uotOazBYf3/l2FJs4SPV60eoVkM2LlVTAnip9s
	KetZMa3K5R13abhKOQCNyqNMLajCVM9wY5zmFuLPaeNztGUB1q15BdnyQSYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727897563; x=1727983963; bh=2Iw2bdjI42cKMo+gwHQR6nWibFJ3
	JflkDK0gHD3QArE=; b=TE24gu/eR7vhFJC9FzFB24scEcIk5k0zKMKaQ6tBlNtV
	L4rPiL5g12HcX4PsJF/Qu7LGPcq1wB+UzJTQyPulAiEcrxBVWiQmJn8Q4qgBsX6+
	2fwcXfYgM0Elefl7IiSZ2e29r3IAEJNUyHjjHKhMpcpjQe3Zbqrss3U0X0bUcOaU
	ergi+NpL9Aucp4ZSu2WsUKOqzC9kuxKk+ykETdUG3OCNwZDex99JLE/+W65G0NAD
	xDt9QFfL29QtvA/D9W3PJai+/dwx1oyYKi6xIE7gjowt/ROMgCBlzHWptqkRLSIA
	WILJg8RCk7i5kHPsSThoH/LY48DcyIirlj0aEjNReA==
X-ME-Sender: <xms:25_9ZsqDs5eOTVRLvP8qwSwJ0T3DlR2Iuu-yMQTrgEvAU-SbSHtTCA>
    <xme:25_9Ziq1BNLC4c-AnzsKvQQGQzJ37nQ8m7Jl73qsWo9FmMPSrijThWQzAHBpxg7YP
    36LDHtBo4Yj1zwzJw>
X-ME-Received: <xmr:25_9ZhM33QwOTQSvW4dU8-hdW0n5BFXTj0zRtSQn1HLf8zN0xmCSTcfkGQ5wFLr-RWaWXxLbieE6AAdf1_3yZ8cOa9nGDvT_zsPgtAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhope
    hlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:25_9Zj7xEr6s0RAefK-vfm_1dqf1XobvfA05i9HrKOMqFFQFitL_zw>
    <xmx:25_9Zr4vOlijQJH_47cwwo8ZgcorBzh2hARh36B_9tAvfxGkmHoxow>
    <xmx:25_9ZjikuR-ZnOY_nBBBtReEoCtZks7ZrEB-4mFtyPPUJOkpfRhBmg>
    <xmx:25_9Zl7N0rEiGbFCkZ_g3aC3PvjJCyKIRjhAUDGL7Aia2CoNo8pDHg>
    <xmx:25_9ZhT-yRSFnQbcFP2UDBokDhPK6D0Z0avpcXwBw4_hGK4IIAARB3Ku>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 15:32:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v5 00/25] reftable: handle allocation errors
In-Reply-To: <cover.1727866394.git.ps@pks.im> (Patrick Steinhardt's message of
	"Wed, 2 Oct 2024 12:55:22 +0200")
References: <cover.1726489647.git.ps@pks.im> <cover.1727866394.git.ps@pks.im>
Date: Wed, 02 Oct 2024 12:32:41 -0700
Message-ID: <xmqqv7yal2qu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes compared to v4:
>
>   - `#undef` standard allocators before banning them.
>
>   - Explain why we don't ban `FREE_AND_NULL()` and related as well as
>     `xmalloc()` and related.

Looking good.

Let me mark the topic for 'next' so that it can graduate in the
first batch after the upcoming release.

Thanks.
