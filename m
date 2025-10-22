Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F435965
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154938; cv=none; b=T+OhchdVhsrCDDO++Z967y0pzPGbsLNXAqiGPMhVho+eM3L1EObneWlLrBtmQKa//B8d+PaBacvUvei317sWVMvoCwHIbkaX/3zuYqkEcCZ3JzUtZQ/CYxyfzh47jy34QRRANfZbtGvwThuKOJdBjSTQ9kLojV9oQQryc1p6qH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154938; c=relaxed/simple;
	bh=x3HQ2wc/Jrpsn+JfSRivgvOxWRICHDdcjlwjkvNzWvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dMrhkPdc9mCWlYummnrbJ1tVlNFiRuPWRXvrgPpBjdYJQw5xxgPeDJ+780dIoBOI6YWvXodgJDUHP5lxTRmx9uQHKHwkBD/swXY1YlNzK9dKEh6c1DA1XrdzjOuFA3HBsJZhNpTHb/hJ1t80l2Tbiz82h8zqPbkRaMV0MOOt7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P9iamrAl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frObUAlN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P9iamrAl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frObUAlN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7597614000D4;
	Wed, 22 Oct 2025 13:42:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 13:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761154935; x=1761241335; bh=rN2fQggdE8
	JsZ71Wezrr0WFEsavjqD7GQr8e5cmBqXQ=; b=P9iamrAlvUn+uJQZPWITUn7V+U
	4x2n7w8CseLvZOab/WRLB05vhB8WIu9wMvrvh6zq+RzWGJ9nYAqr2mcA/SBja8ZJ
	LeV3iQFtTF6kRSmbUlEeh7Zy6OOgufdSOqLAkSHyh8XZjAnyxK7vyzVqCeJy7mZ9
	JL1Ck/XRDbj0Qn6SXmH8isNHaXYW2pKGxoM5Tr4mk926gdhS0ULC1eHKLXVz5iPD
	lYmk0G63GO0q6t6KOzf6V6RFvO+1gMqL2+x9EIw+DaqsKxwZy8wXX4rmXBNzripy
	g3hS0Ii9fd5bLn52wWQ8CaanvBTYXSAi8UT8jQAqIiMMY+9+AwrqsMusK1xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761154935; x=1761241335; bh=rN2fQggdE8JsZ71Wezrr0WFEsavjqD7GQr8
	e5cmBqXQ=; b=frObUAlNZN0H2wiWVioQEY0rCKHklQs+HYQR11afufCQ8CU7Ce5
	a/kOOYqNCuK124ZE/KsXWqZNgj53t7fe0QJW6b72jw/RehdWrb48JVsjz946jZb0
	uEljHSQh4R9nhOpevDkt9FE8nPYywa1iLh4/dT1aq5d01AAy0vqGU0QQZnX5N2mc
	DBl2kbBR3UHUHAZtjko+ze29/hno41tyHVq5hit9/gHVDGfurRC7Lrc61z7NKYSF
	zPuUW4FTCfwCOglw/wTVp37J5/tngZoqP4r0xgxW6COBGbDHk2vyNIP3K5eVpbUo
	W13euIjPump79ZLy8gTFyR+L8c1OJjFGe+A==
X-ME-Sender: <xms:dxf5aOXaKJ0A0O4z0WGvvVUv6tx60LYikaK7W1XbVK6ngZOqUW8pCw>
    <xme:dxf5aJrsk47qHjg3QLjCtMIvBixylGySddhPYKISBXs1s-Yf0c9oJQnrSrfY5aD2F
    KIe3YTv_MO_-gOGyvPfpSuRnxy9AECbPMvZYPRIkCT_dNF6TlRUkg>
X-ME-Received: <xmr:dxf5aInXEtmpphAFzVDIaUF9OvaL1yYVgnvpeHvorxqX0lUNcwzKb5LD2ncbsg7yisW6WvGw6o_GttTC_0dwm8B99LYnu0Pf4P9O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopegvmhhilhihhigrnhhgrdhgihhtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dxf5aB35309-RaLi9h9J8zLWbT8_oG30_zGBOQfQKbZaeFe3edLXfg>
    <xmx:dxf5aNStJzGsbUFNzHh15mD5IkXz6l843C8dCr_4b3jMAo-f-7kyCQ>
    <xmx:dxf5aCx5OYwKST3oKhk_LXEJGe2Nou366WiAaU-o64WSUZcL5HhOvA>
    <xmx:dxf5aFBwqbb2u9_dgpg7BvbWrgkiZ0BvottvJOLUEGduTs3HrPgeDw>
    <xmx:dxf5aGnV6yNvDK372v2tqZA6YbKTz4FnwXoiVm-PSeWDh8Gdq2nn17kg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 13:42:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Emily Yang via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  me@ttaylorr.com,  ps@pks.im,  newren@gmail.com,
  Emily Yang <emilyyang.git@gmail.com>
Subject: Re: [PATCH v2] commit-graph: add new config for changed-paths &
 recommend it in scalar
In-Reply-To: <dfb978ab-993f-49c3-ba55-d12d47dc659f@gmail.com> (Derrick
	Stolee's message of "Wed, 22 Oct 2025 10:53:47 -0400")
References: <pull.1983.git.1760043710502.gitgitgadget@gmail.com>
	<pull.1983.v2.git.1760734739642.gitgitgadget@gmail.com>
	<dfb978ab-993f-49c3-ba55-d12d47dc659f@gmail.com>
Date: Wed, 22 Oct 2025 10:42:13 -0700
Message-ID: <xmqq8qh2zvd6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 10/17/2025 4:58 PM, Emily Yang via GitGitGadget wrote:
>> From: Emily Yang <emilyyang.git@gmail.com>
>
>>     What's included in v2:
>>     
>>     I received feedback about the confusion around the config explanation,
>>     so in v2 I added more clarification in the doc and commit message,
>>     hopefully it helps!
>>     
>>     Thanks, Emily
>
> Thanks for these updates. I'm happy with the new version.

Thanks, both.  Will queue and mark it for 'next'.
