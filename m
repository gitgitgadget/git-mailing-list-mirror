Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A038886B
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118250; cv=none; b=T+fxHyf5XkSWq8XGZhi1JzyhLMmdlnscP3VyiUU+SWGYCmK+QkastQWOqySzN2M1J5Pv/dlmaUzRpHVzbirko5lHoEwbuMRbz3zt5rFqzckJvvl8De7wfAvJ2cpRhA0qbpSusMUonspCZnJrfqFXqhd4Vf06XGCM5yBoj5xiWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118250; c=relaxed/simple;
	bh=ZWeeehNl8sg/ihkiYH7WedtFpLzT4S//B4lKD4TYnJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PAfV81yg3duXD6pedlmGr5NA/imA0qUayAHTknEQDk0D1TxgZbZ1q7F66UJ+EGATsnMvN9q7yZ5IXIk+4C/vmFdv1KuS5/qIiqnRrW0Jt+WRYrvRFoakhwlwIALS2ibsdASSJRYYga5DIchXUO4Mab9Eq+cMZT1OzXdSdpR2I70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YM/zKVtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KloB8f+M; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YM/zKVtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KloB8f+M"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0FE0D1400EFF;
	Thu, 22 Jan 2026 16:44:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 22 Jan 2026 16:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769118242; x=1769204642; bh=RWWVtE97xu
	1YxAr1EIoHmeBxRIylT2ojxjKn+XDP9SE=; b=YM/zKVtWZuEHdbvWIGtz/Me/wk
	qtjOm6dQKqJ51joGbrJCzhUiS0ZDi+b6OgS2WjhVueP8rjP1XvJJ3vfN2B2A3p+3
	MpAdjM6I3GUYUlhDC8PQHwDtGlPvaQcDrMTvrbrbmmUfFWmw1jo0sZoHpUuSexKL
	J8unNamV/ikNFQzCaUsbXGNPLqEKvlc5G/UEP9hbaFqnJlRTzq5THk9lwpm6q8VL
	3a1U3G9j/LQRb/h6HEI+85IsWba58AG/zQKqOXQ8Krpgk9vOD+6KqdvtIEzgob8k
	MfauB+KQsiQkldHXtT+gpZ1TNjyeV+ezqziOnPULGR0aWT1/ZWFs7/27PTbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769118242; x=1769204642; bh=RWWVtE97xu1YxAr1EIoHmeBxRIylT2ojxjK
	n+XDP9SE=; b=KloB8f+M7SMGPgvXjVH/x/oeHkOWEVcQxQvs0VzM7gbUk9RXunF
	cjjvt/JhU7xZ8uiKCcKf+6HsLbaeLECYSxf5EBxe7AvhoP7kr8uv68DOwXWbzWus
	ZQSYo3N7lvoVZggsKbqZcpurnkPBC8c9SCi9LEwz/4diGFyLSvgxYiQ1rZXGh2Zd
	BYFB+ZmwIK/yJPUQ1AOQ/Aj3Uf18o2oQ3VojQwP9AF2IdOMKap13z+utVymoVvIC
	k/ORLjDrf7U7TxYz96Xaz0+xrLN07kHDUvc/IvTf1tahMT9FEOkGPv3Bb6eXZ/6S
	uVEICRTTwQywJhJ+twVniya5F2Sy8FWI8AQ==
X-ME-Sender: <xms:IZpyaey-46-FU_oEjNqaqKJPk04nsu6HDeyCd5h1wU91vzKXgagv4g>
    <xme:IZpyaRI5PUb729jA8WZ92we0mOlIRZoNltOLTT0spY3265ysbhrq481QT3Rk0YmHB
    ZYYqWYWfXdYq74Q9CEHDIvvZdeRk4YewWrCFgYj8XCPQMu27RERCw>
X-ME-Received: <xmr:IZpyaYoLAsVJsodM97_KksGt8xtosd5MwMOiS3U6AiYSumU9oMOFWgTno9LINRvQfR7OndUG3JMZBF7G9V7xoo9u4egTFJA5AYtazDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IZpyaQIQFo32c9Hcf_SGTBUAYUX6m2Pf5_5PVKh30TDF9aaUpC8-lA>
    <xmx:IZpyadRZtJdDmwRFbpeMG8PV4KAwn6csXa_CXIDCE2bqoEbwNZsuSQ>
    <xmx:IZpyafsQ60vsgqpVD3brSVwvNbKYT3NKS3IqBA9WTK73H4mQpl-ToQ>
    <xmx:IZpyaeYE9StbelmQHfZvmfM8nQrTjRiKQFr9phRoW1MB76QMQCJ-rA>
    <xmx:IppyaQYqkgNR7W8XYcgclr7OC2oJZwq6O8sknUKuFnnalpjETuWm6Evv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 16:44:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2] revision: add --maximal-only option
In-Reply-To: <pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Thu, 22 Jan 2026 16:05:58
	+0000")
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
	<pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
Date: Thu, 22 Jan 2026 13:44:00 -0800
Message-ID: <xmqqikctl3vj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     My motivation for this feature is very similar to the bundle URI
>     application. I can get around it by creating a tool that uses git
>     rev-list --parents and then uses a hashset to collect the parent list
>     and filter out any commits that ever appear as parents. It would be more
>     efficient to use Git's native revision-walking feature.

How does this relate to "git merge-base --independent", or do they
compute completely different things?


