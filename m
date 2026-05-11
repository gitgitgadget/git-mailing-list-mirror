Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB117555
	for <git@vger.kernel.org>; Mon, 11 May 2026 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778458388; cv=none; b=smZr4ikSWrPVHhMKQFBORPILFuIsUKMu7JCPK5zVN3BI5g+jh7suynD0dletYoCK743lK/6ArkZNTw6huR0CaUQckGyksBs9mEkdKP4bvt7SABrYxIemgwwMygezQ7ktkdioMlRc9MrHKx++0Yr5rNA7r09ZOhDou3YVxU16ESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778458388; c=relaxed/simple;
	bh=jI1v9X5cJh3vGkfD7S0u0t4BT8ud1kfRsWRhPnkF9OY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dybFEXBwyIPgrssstzS6Ku4BKD/kdW7tKDYQWV4xbApw8VHlcYOlCW/0qFX4dkUHfiwkdMUh2bi3yGvdihLDVtv4EWNDZcBD8DA5dEBPJ7BvrK+DAEfhEhryWbu3n5NhlwseAT2/0peHCMEcsxbmWUh5jP5xImxHnXjVGi8I/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l3riTLBg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c+3T4QP6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l3riTLBg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+3T4QP6"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AA9C7A008E;
	Sun, 10 May 2026 20:13:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 10 May 2026 20:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778458386; x=1778544786; bh=dAj3Rj62iY
	Bq7y+JNojNYaAzQzmt/hZbwr8wZtujWaM=; b=l3riTLBgLjqXb+Dk5P9TcCEhrW
	5ld9Sbn8+PE4xv97caJqBAnsideFIw0qafr86V6ci+xIvDEvZwrFPMTWHLIPvFuo
	aMbU9jHvLeBXNG9bsJ8riqDjz7YVtVI02k135mhyUYAo4nU9LEY8uQBO1U8PGwCu
	+n6RTCqi4RubHexYEj/D+OyBwOGNHMqTC9etgvB2OL1Z1Ic/WSQnmH3t2SPO7lQ2
	uDgd2R7pCt83YKYokPHNa/84oBkgCANAtcYXAg6ocUUEFKzt9rd0Y1pVZ2V94/PK
	bBWvZFBSf4J0Z2T3GpskbugIOjVfXgKopO2XiTZfUl91OVnmivo/Ey7sB3qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778458386; x=1778544786; bh=dAj3Rj62iYBq7y+JNojNYaAzQzmt/hZbwr8
	wZtujWaM=; b=c+3T4QP6ivWMe6WTxcnHQjENA8CdyGl6R9sKFt02pHej13LlOZS
	otTh78mUdgQi9e7kbxqsx3ai3RTEInKUBK2lA+v+sh3ghWA0B2EXjTZqE1cTrXVE
	SJ0zZN4tjjHgsZc8W+YH/FXUN/xxSD9hvt4SAQun8b3HtxkUQPLKxU12J21P/ao0
	bAJCgvn8u0S+uDp96YgdG/MWy+tNizIhLa4WSgBKrNu9GBgqPbBDUE4B9KaYVWQk
	YpSf7uPGbnoIjsRXlhe0AfUsVE3RXDCa/UOC+u6tNFlJL2k7sKFFQx0Ry7ahxnQp
	etbxxE19ZQkf/0kScobsZxVTGcHBqpOsLIw==
X-ME-Sender: <xms:Eh8BamngOM91kXuIk4boGvLjMyA0bLSFmL5Lngu5SybOqkQjKQ7_Hg>
    <xme:Eh8Bak2j0KaHI4LibLDX0lI6KoZlonKJTwtIGCHJ8Xe6gmns-YQBgxwjCHoEsh9RG
    2AQvZ_ikYHpYRpVVKm4R_MDrUXa5If7L-sAbkBaTaCqgYKPAc9aEow>
X-ME-Received: <xmr:Eh8BaprDcjg8KFND4bt0tgqcXOm3fu5WJeM9kqcQUx7GYKx0raEkQ8uXBw-e8M8-Sdzhzy9AQXzmsrDumh-thmxImB2oHQSfrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghv
    ihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:Eh8BapeysdsIuJwmC1uDSmF9o4Vo-4yq6rJ3-zTcrtPgoCJUo7OOug>
    <xmx:Eh8BagrqkXNR4FyDf3LvetyObwDXUlwi6T6sQJyo1xSuTVDNy2ZE1A>
    <xmx:Eh8BaiHwMwnCq908ttMcm3naJFBHCyKRKvPauxZRzVlQFXZTqlYOcw>
    <xmx:Eh8Baov3MRkeWHkfOzHJv4QS6VaDrI-uJ_g1VQZf6bwFfOOxY23w3g>
    <xmx:Eh8BarrT3RPkfn4qnuQblKWaoCukWwYF43fqCYK-JlJ6QZg3tCWm6Xwg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 20:13:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v3] doc: clarify --follow and log.follow for git log
In-Reply-To: <CAJ-ks9mPzCr3obAw5cE071GNjzy_ZLzF4mQdnUbQY5H4WPw3sA@mail.gmail.com>
	(Tamir Duberstein's message of "Sun, 10 May 2026 20:07:43 -0400")
References: <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
	<20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com>
	<xmqqik8u95yn.fsf@gitster.g>
	<CAJ-ks9mPzCr3obAw5cE071GNjzy_ZLzF4mQdnUbQY5H4WPw3sA@mail.gmail.com>
Date: Mon, 11 May 2026 09:13:04 +0900
Message-ID: <xmqqv7cux0q7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> I observed this "undefined" behavior, which is why I started working
> on this patch. I think it is not reasonable to deal with undefined
> behavior by pretending it doesn't exist. The documentation should
> acknowledge and explain what happens when this option is used for all
> ways that it can be used.

No, you are misguided.

Undefined behaviour can change without notice, and users should be
strongly discouraged from using it.  Describing what the current
implementation happens to do moves us exactly in the opposite
direction.

`--follow` is a checkbox feature. You can use it "only with a single
filename on a linear history" or all bets are off otherwise.

That is what we should describe if we want to be honest.
