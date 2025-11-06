Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE1277009
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442973; cv=none; b=uiYRPmRZFFw5toVG1IkYfYg83n00HQTcobNuzFk2cptI2YOrIMaDZsoBibTJ+qfK821qsXREoj1658Dt6uEEpf3AGjmp6TQwKnn/wEugKJf/vKiHV9sOISrcea5WYKIf5iJZQ5RkXWERnLQdgYMEVo8kOo/h37J+wjfcurZeHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442973; c=relaxed/simple;
	bh=EC7g7XSyP/ipsSUQhf0Ir1etqQvI4hjy0+GZo5r1Mk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CjZhOMHaIrLUtqlUhpE/KGDWWfQuJrNCZ3Uf9tL2tOirBoPQFKwolOGh8d8omQYGzQ6oFS6d8xL5HHkN7zyBff6TYkKD+lDSXizQQRwsU9Fxk9HU8yZpD1kU/nYgQNQKHCmdtitZ9ThelWdcH1p5GrNm0IXfpmBB7L6V7+pPbOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BSmOrQVJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=av8n00rS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BSmOrQVJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="av8n00rS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 95F68EC0268;
	Thu,  6 Nov 2025 10:29:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 06 Nov 2025 10:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762442970; x=1762529370; bh=3m7JBJURXZ
	yMrgvVRWot/qneqMtUGtYorDmeAGsJs/s=; b=BSmOrQVJzIv/wcYTUaJ/3YPeCR
	5NMEDQCcWw9vo3bo3i/EbpjauqlPBdC2ach+yxGS4o1X9ZHJ4mjPIkSh3ODaFh9q
	H50f0w2ZNje0Y7JdvI4BOycF8rvm75/CV3hDN8CrbfZcs1bPTxcsz+gI1aHtVR7m
	CGec+pQNkZGnryBkiUWxa2RBUqljidkqJuCEXQTTbImfyFU1AXp8uLk9gelm5XDZ
	PMCY0Fe7NOR/KVar+FJz9cYxknxa0Sja+AD/PAMnlJvIsEnVKOowf1TYGvhoX9Qs
	FPCdnLgnjI5X2LRhndBAlCmTTZN+K9tEORuFmO2T2h+HSuTHldW56M2+2uSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762442970; x=1762529370; bh=3m7JBJURXZyMrgvVRWot/qneqMtUGtYorDm
	eAGsJs/s=; b=av8n00rSe+j3WZjsqFUW3m4UY5VXr4RhBxaOBdAh3QtLtdgs9vV
	vhRuH8HQoyHDjTOMB814NBSQPxaK5mexaKkSkOObrE9Tyyb1I2/wMNWHk9ubsjEg
	pwN7xIa7l/wCJrNwfMWcyHT2OYk3FBw/mBvVRNI7Fro53QCK5yGtUyOz+b8DZk/c
	k1Vel8FjLNlS+WxygXmWdkC4nMHQrq94uhdcr6HoZlslbxd/AixWbMY0Q69tDOKU
	1C27pF8iK7CrRocRsLez48PXrg/04uoJdpmdZFfHdushWffMYP2NWBkGpwHPFs05
	PdO3wb1FexitIN5w4mzhvaLJaPAraSaVp7w==
X-ME-Sender: <xms:2r4MaRgjy0xfPv4XXr9GxZKUKoGv74ZmxoEVpFr_ymoynWYO-kD00g>
    <xme:2r4MaZvCllWdij3OZ34KcVgodlBmZT31n-jAJkYu_yTu-Zi9mIbxS7m3b2iz4VILe
    UOiWXSru2Xt7nNI9Cm82AuF0YBS84TKi5dO6UFreoiM9pwNzk_K>
X-ME-Received: <xmr:2r4Maa54r_3O2cexnnbS2Qt7FuLOqfodXsaFI8O-TX_QIO2run1kMHzzowdJ7NG4yMC7FBqwFmA2T-GaNEtcPlC6c4Ckbn2BCden>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegsvghnrdhknhhosghlvgdo
    ghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2r4MadMleLIrZJeEu92i7d1nKJsDeFdZm37KY-tzfQRJL8LMOv0RYg>
    <xmx:2r4MaQt8HS5jiFuVt_MLp_Ejp9h6-8hQAI3RANXWqbM3uHHpfbGA0g>
    <xmx:2r4MaYbRU5MwwykG39haLHbwWpFZ-jzrrHsmIm8j1Hpf-DS8iNxn4g>
    <xmx:2r4MaawQf3KPFt0pQ_c84RXnb7yC_-ckqInQHP8PIMCa-zeFKvEUwQ>
    <xmx:2r4MafF7K2c3pYUyMS6ehb_A1PbsbL7vJiT0L0dyX-ffjlo4cWM6ccZv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 10:29:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  "D. Ben Knoble"
 <ben.knoble+github@gmail.com>,  git@vger.kernel.org,  Todd Zullinger
 <tmz@pobox.com>
Subject: Re: [PATCH] meson: make GIT_HTML_PATH configurable
In-Reply-To: <0930DCB8-D545-4043-87F9-4359EA5351D9@gmail.com> (Ben Knoble's
	message of "Thu, 6 Nov 2025 09:08:10 -0500")
References: <aQxTZNYKKAsmL9Sg@pks.im>
	<0930DCB8-D545-4043-87F9-4359EA5351D9@gmail.com>
Date: Thu, 06 Nov 2025 07:29:28 -0800
Message-ID: <xmqqecqbji1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ben Knoble <ben.knoble@gmail.com> writes:

>> Tiny nit: let's keep these options ordered lexicographically.
>
> Can do. Shall I send v2, Junio?

We would soon be in pre-release freeze starting with -rc1 that would
happen in a few hours, so there is no need to hurry.  v2 after the
final release is good enough.

