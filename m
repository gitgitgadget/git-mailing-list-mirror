Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA413B590
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998045; cv=none; b=e+CG8tNLWoeRhXgV99a27woMvUK+TL8HHygdeC8UJwOiy7QjZPkD12QSJfZ3dMEXIRLzjBA+2Ox37VoCIl2FAV0L0MObGTy5Nuucu1RqGY/0JEMymFgzw4FJRsmyIXKJBZsqBgiNQyejfJ9oRQwjCAEBrK3Sd90/WvntqCDA9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998045; c=relaxed/simple;
	bh=A52Rsr/d8c/dUW2sMg4PJv0AsAfem0BS0lfZ2iOCb74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r3v4QF7Nczb1zLYxiKfYcKVyNkeYJWJRIkxLoxpors7BY8LThVzNVQBrG8dhyO3ERDhmxwkKqUn+fqD5SrdnB8lxijHHvw2K4Y7ptHf6JDsqpril75yEOtO6rwXyr5GNYNe4H+H7TapInEKMhPJL2mxk/oTHsYISnaP9Mqx8PXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IWttvGWE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SPWM+ba/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IWttvGWE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SPWM+ba/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B88311401BA;
	Fri, 18 Apr 2025 13:40:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 18 Apr 2025 13:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744998041; x=1745084441; bh=A52Rsr/d8c
	/dUW2sMg4PJv0AsAfem0BS0lfZ2iOCb74=; b=IWttvGWE4wkq2w9wZ9wiBHp5Sg
	VSEENTaid3kKC8D7NA8zAQ8RL1hJUVgU/hB1YYEINVG1Zym+I70a4kllfGxfMIY/
	SegZbpFHUXRYytdnHRmRrCehIG1W0Ou1XaBFX4ZRv4ZXUKrRe4b4Kv9fL0fg5ar+
	emgZYDartf3q6M0BBANjdkuSYqOBtxln9Z/GtKZiUyvjRmp3QZGCiex2kESv9x5z
	P6+2kvuFx/DeWDqmLlBos87qirobEm+Ubz0QjLZ41hK2f8OOgHlGXj7PRiFkaU1H
	0Zi5RlBInEFNfylE3wCXYLG/DqtQpEtqijB4D9L2rGlugWZNHcxA/ydQcoUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744998041; x=1745084441; bh=A52Rsr/d8c/dUW2sMg4PJv0AsAfem0BS0lf
	Z2iOCb74=; b=SPWM+ba/1Kd6NXoNVZ77FCaynQBI/Iie5U2hj4UZHQj6g8L54aA
	doltQ9Gnm8FrcG20Wa8tsE76UQBtZVljAHqfdnzLdqr79TNZEBOGzY8dDL7psYvT
	oO9SJxIW8ZVXYQODyefqkaYITlO0Y9apN8ncIbjtYAim2kD0shxV3o8OZM8OarVE
	PVF/aXnvHP7LXvmBT2L4Jz0FjLJVEcn+bHxYgrcK8EAjukUnKmOiEYdkFWq/Vacx
	nSQAV0i32cea/mItH1IuKG+bl+gd6TKSzOHgDrVMFlHJTeR1m/2IbmJGobOrgFfj
	eVcMvGiS1F5RPAFtTo50zMx96LF7giXH8kA==
X-ME-Sender: <xms:mY4CaKFlLVZ6o2JWIK_lIFIUEhy1ooBVN_UqNnsptKYIPusD0CP_Tw>
    <xme:mY4CaLUHBRENmN_p2ZiG15XuEtfv0k9BhqyZ38NGAoEhu5IKtrz-wAW3ClrKCGh5r
    v4325w1T1xyQmSdFA>
X-ME-Received: <xmr:mY4CaEI-TcxT-4geB0f3AJz9_MK6H9v5qSDx3PV1CB9lkztjczX9fMod9ejiUPyCu84TUSqY2DwiIhbGaDUAEFIDy1iBmvk3NOdG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mY4CaEE6jkh7r9FzIddC6u0s9yw7mDZLrSkcVpYDcAWBsnLWIy2vkA>
    <xmx:mY4CaAX4FPtcge4dyVdqVbNB24fSmNHTvozDgj5Wnm8Ar6CHrP7bIA>
    <xmx:mY4CaHO0RDqEm63RBquNLOQygdsk1GUgwBxogwj3minkph1zsVtxQg>
    <xmx:mY4CaH24ARB555ficaYFVUZOQ9rn_PubV-KGCHuzItfY5YtOFfoDqg>
    <xmx:mY4CaIBFSmeWnYlmD-reWNR_RJd8j7NKRMsX_IUQgAAHGXdz3dc4xgOJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 13:40:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] t/meson.build: remove deleted performance test script
In-Reply-To: <67c50fde-d29c-404b-a296-9f0e482acaf3@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 18 Apr 2025 17:59:18 +0100")
References: <67c50fde-d29c-404b-a296-9f0e482acaf3@ramsayjones.plus.com>
Date: Fri, 18 Apr 2025 10:40:39 -0700
Message-ID: <xmqqmscdbc6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Commit 8b0b5c7046 (p5312: removed duplicate performance test script,
> 2025-04-17) removed the 't/perf/p5312-pack-bitmaps-revs.sh' script, but
> forgot to remove it from 't/meson.build', resulting in a broken build.
>
> In order to fix the build, remove the script from 't/meson.build'.

Thanks.


> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Taylor, Junio,
>
> If you need to re-roll the 'tb/pack-bitmap-lookup-tables' branch, could
> you please squash this into commit 8b0b5c7046. (the meson build on the
> current 'seen' branch is broken otherwise).

Unless the topic by Tayor gets rebased on top of what contains
ps/meson-build-perf-bench, which is not even in 'next' (hence I
wouldn't recommend doing such a rebase), this needs to be dealt with
as an evil-merge semantic conflict fix-up, which I did this morning
and pushed the result out.
