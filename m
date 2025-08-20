Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05E2D8764
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723473; cv=none; b=VfddzEM7bkxVhCu0BWA+fOh5gdibjk8b6DE+mMkoNTu/nL0uGhLmJMxuvExFM/fW1aZdwQVdZaCGQXNcd/qqVHNMitxxgw/quayKoutFqfXAiojruvKey5kS420isFc3TlPLsDjoaFGBav1wM5kYJwHJXb/PG1gCobhQllxja5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723473; c=relaxed/simple;
	bh=rZcPdiO/xvA8PvPRmhd2022vEvRPH3uPrF0Yng/8hcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G4sRjg9x5Beo4QTf/DzDAdOWi61FIXE+8IvjhoHincj1fxmhEAQYAw1YAF5nEf/5R9v8KafaQI1Rt+M9qSvpl4L3FBaaWxQY9s8wywDdP3EOfJQ54rwbemfgRv8ZWt6xA5tTgHIuKwuTNiys3i7NYjnPQeuvF0+ZM/yS1Zg9RcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fgRCjf2k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tzc5/MpR; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fgRCjf2k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tzc5/MpR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A07B71D00088;
	Wed, 20 Aug 2025 16:57:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 20 Aug 2025 16:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755723470; x=1755809870; bh=rZcPdiO/xv
	A8PvPRmhd2022vEvRPH3uPrF0Yng/8hcA=; b=fgRCjf2k93Rynq/+uakNFYMNhB
	EV68eD4n0Xq+DyZo/13p1jzXtIvQiG2T9dC9kQippVrURLE9JH6jaRnSfNdCiJ/7
	DtNgTcsJdlzhrncov7wPg8h1KQbCTg4JXcOSMhFXgOsw3+1K3sqO7A+KURpcNFlk
	aGMQ2CQMDGTn2NJSBu0iWuqtK3hJ5gTZ5Nj0Io3o554XROIgvNQ3fnGQKFAqVqti
	merQFOcFXWL39VMlzi80iIdG1ZNo5o20CXt4XpZ48J3FHjmI0T1Y7OzAynaGUa2g
	rzs9JFBFT14SORZ8xzFMtQEyISTGIo+E0JrXFqEoRCvdJ145y5mP6NrPnLGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755723470; x=1755809870; bh=rZcPdiO/xvA8PvPRmhd2022vEvRPH3uPrF0
	Yng/8hcA=; b=Tzc5/MpRqfBndZ0ts31OQfyFXqB8PFNYGX8q9OeZCU/SnS2tISV
	ImKqzKMP/ko0ExsD7XlJGtUBAsgq1mKtIWgqdZ5pNqyVr/wq3Fh6Iilrs5a2iVJ9
	4b/uO7nHJN172uwMOKFKoDnMDB75MpasDq4IeCY2gPA6b1/3JWqjaAB/wh4Ngxal
	yZJLPeenVsUzuZX96oAoMH/kbkRCHPhGD9PVHE0lTJoUsQEw31aWt4SCVciOssp8
	rXMiLACRT3UdxiIlUqMwuLg6EruXHb4WggPXpDmJMwuEQGMgo9amviT6Ag/7mGxw
	haqpbT64+DMDC8SNB6+XFott2MmP/bFxjmQ==
X-ME-Sender: <xms:zjamaB7DdKmWxyrMRdjwVzXFpredIgGogm39TLSwGvXLKqsE7Y3b1Q>
    <xme:zjamaJcVll9RqH74XII9UVoBw3sr7xnivOCytLLi9unfLiXTobshxHBZj9-1uSQH8
    -3sqkEhBPjbkdIPeQ>
X-ME-Received: <xmr:zjamaFDpoDwV2hWrNyMSn2peBgEE8V0pQcaC9zImXyA5c0ycIbv4QbJ7T-u4ziGZchKt9FA8oHpllGDrJL29ZYOUc1eqlqfwnvJMOJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrphhprgiiiihosehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjieht
    sehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zjamaM9sIoU6QAdcwBikpxNNOeYbyO0ljwbUBV5f7bw12FY-U7iOng>
    <xmx:zjamaAKc1Lyw8m7i9Fzd8w-9SSqoUuWvVmptcckF0LioKkc6_ztf6w>
    <xmx:zjamaFhMc4Cg-rogzhCXxlUpV9zLVD18--R4U1Af4yVrx563Fc_f-A>
    <xmx:zjamaA54-xN3UXuG7SCgf11RiPDykcPZewmv7fCpSxaqF21btnQDTg>
    <xmx:zjamaBJBI4uuYquDZLU4JRJntp3qbwxmAdMgsHaIKQTW_XiMHSzNemE->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 16:57:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Rappazzo <rappazzo@gmail.com>
Cc: git@vger.kernel.org,  j6t@kdbg.org
Subject: Re: [PATCH gitk] gitk: add README.md with contribution guidelines
In-Reply-To: <20250820195229.45943-1-rappazzo@gmail.com> (Michael Rappazzo's
	message of "Wed, 20 Aug 2025 15:52:29 -0400")
References: <20250820195229.45943-1-rappazzo@gmail.com>
Date: Wed, 20 Aug 2025 13:57:48 -0700
Message-ID: <xmqq349laeyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Rappazzo <rappazzo@gmail.com> writes:

> +#### Creating and Sending Patches
> +After committing your changes:
> +```bash
> +git format-patch -1 --subject-prefix="PATCH gitk"
> +git send-email --to=git@vger.kernel.org --cc=j6t@kdbg.org *.patch
> +```

Just being curious, but does the project strongly discourage a
multi-patch topic?

It would be really nice if you add "review them here before you run
send-email" step between these two commands ;-).

Thanks.
