Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A88126B2CE
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054252; cv=none; b=pqqfkJMTmmM+YX4C5Olm/mwX8Dbk5EeRgwiFRv7bAREpqsf36gBfggHEKo6pyAIbA/Z76JVJrATonxE4wPGc0xABm9NPdl64jCeRtI0USxhOwfHMX1ylE74Veg/36rNhwI7Nw4E9u4uyjhJUC5JgOaFsqhiM4jGr5NboHpuCN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054252; c=relaxed/simple;
	bh=8+Mg45wd6ouDAATSGjFmTIz8PhgVEgm/06v8AAcfC/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UyuXXjiWylFKEfNNeZxCj7Fx7gWdCAMNeZ5HPMBlFyOW/HvkyOofzi3X13rPzNSTT44EiACNV2lmeNO96IrYdTtHd+VqBryhNojXTE9S33NZIj2BxfzNBcQXOPKLqFhGZqjRMGkF2XlajFK9jMhnHcjgtOjlNZ+seKvseCX+GXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WOUNpM4z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KU/G4W3o; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WOUNpM4z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KU/G4W3o"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC7B7140015D;
	Wed, 25 Feb 2026 16:17:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 25 Feb 2026 16:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772054250; x=1772140650; bh=fNoxg5knJv
	AVnS5o6WN9IkfaozZZAa/x/mFyBJ8Lmus=; b=WOUNpM4zuTkaJWj4YmC0qqyd1b
	j2eMuDBZdGNWwMn6j6fmTwJWddAlqKck9tLAeXInapiuuZEgbcwYg8LR5jB8lWgx
	iLq+Xrh9EuL1ZmvHGSKFNHYHKfOnY+wVD6a95KliGhwOvqVEMMQbfSFk6FZFyRkG
	aSUUvnQcKReBC8sp2cgw1M/nb5VuNnT53PpxMGfAqEawhtMJnjNSH3HFQfD8t7xt
	WYgxPfAQ+huT6MoYWdIo6TvbB1SnH4Anolgsu3ZE/U+r1O1JZfQz58g92jQOE/qL
	ngkxXuYD7iLho7qVXnp+dhOcozjYzgJELwPvklhbOjjtBAYiP8pGQI9SnN+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772054250; x=1772140650; bh=fNoxg5knJvAVnS5o6WN9IkfaozZZAa/x/mF
	yBJ8Lmus=; b=KU/G4W3olKja8fELdBaY/evhna/91aNziw3jsUQnRnT2dPdMJZY
	0DjzVHJu5qappr9X5ZfAR9scN79nVFupPlYNfLJ32GHPE8GkZKFRXNU9Vv0BgedG
	RIaGtM0j1eJFUtZobeHWlKdsUro+OCg+jSJOcfDd1EWeJPOQByYdxcIqkPsSfpFZ
	frLoHLTqXxCXgAedhCCMy8kpGT/z7PGFWBaT+Pvfr72MbrV9MsJeETt4UZQdVCml
	1g2LIHeMQSHbKZM83MuoEfqjtBoQ+H0/+cke9MzyGz0pB0Xf01b0FrtUIp3TuXdn
	5r4Nv3w5FK/kz2FQP9xeNxTeJjSWKpbl75A==
X-ME-Sender: <xms:6mafaT4m-gwelZXNkxRtiX7-5Bgx2nTyPvq2Bv2ELndg5adDw3nCzQ>
    <xme:6mafafziMmVTIa9YdDT8z2Yk-SlGHCMh67UqrnCTNaH0jGAa_UHsCjS3iV_fLm846
    FvyYvs7aQ73hiLARKIZHGV3d_jLryZzeWdIQznDIkzT9gfUd2RJ5g>
X-ME-Received: <xmr:6mafaSyg-zmJLck9HLjP_CfBrD4kmfY5xkySNpwN204NlBlx8OHn8pRtsq9X5MFcNwHwmmNT6bul6luswV6Oz2p3VGhfuBJGCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvg
    hkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6mafafzkOxhRFEc3tWWeU1wnAlb7PoZj3iw4w2Rv4kap7nfIwOUB7A>
    <xmx:6mafaUakoPYArEzMhK2lE_ts4r2_1KUmUNMU0kjMx009ejyKrWPykA>
    <xmx:6mafaYUvgX6ShNaX761F4MDWvOdr9umYCoMphZJ26EyHpvBgnxbyDg>
    <xmx:6mafaagBiGg_lYM3MBB7fNn4FKrsfp_TWB-ub7sk6GTKLRW4qTrNSg>
    <xmx:6mafaTMvE3tpYIbf7_n2QyEHS1ZK4S2D_Knwt8Us-lxaYPIixxZBgQDB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 16:17:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <github@paulisageek.com>
Subject: Re: [PATCH v6 04/10] fsmonitor: use pthread_cond_timedwait for
 cookie wait
In-Reply-To: <0051a1930349878fd25bb5d2240073beef36da7d.1772050636.git.gitgitgadget@gmail.com>
	(Paul Tarjan via GitGitGadget's message of "Wed, 25 Feb 2026 20:17:10
	+0000")
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<0051a1930349878fd25bb5d2240073beef36da7d.1772050636.git.gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 13:17:29 -0800
Message-ID: <xmqqv7fk8qvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	 * Wait for the listener thread to see the cookie file.

Is this a complete sentence?  Or perhaps something like "see" ->
"check"?
