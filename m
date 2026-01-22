Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB43815C6
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120404; cv=none; b=emaTYIULmMmr3uJhGeRBPi8AIYfPddHt6XGHLYBQEP7noTGOOeOHYuY+HYlpM/ENKA2yj+wOqR0J6nN3q6N33EftM2kwDCVSOo9Uep6cRQ4p9u61SM7l25LdsZVSi83c5PN4pSucocxUpuwTI1Vg4qb1QwDUjQhr0kfv9847bsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120404; c=relaxed/simple;
	bh=ecp5xeDPs6vsy55k5p6l6Kw2tWVbZOCXexcSLSjtBiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=byCM35s7dOtjDL+GVsCZdlzT3KPBbf1IqO6BEbF6Z/yioOqI/BxSkWzfaOG0YQFgwzr0mlGaN/8QU6GhwV5Y4ibKIlTsy8Nmj16aXb2fgY1l2Au3ADtc9PYU9YGPdKtayHPhO4eIdMLePJAhZMcmyLT/1btWDlBKoL30JT5GwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e9ub0OD9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFpW5PYp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e9ub0OD9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFpW5PYp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 199D914010F8;
	Thu, 22 Jan 2026 17:19:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 22 Jan 2026 17:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769120396; x=1769206796; bh=cpiieRKGNb
	JgzbMl9prg9G+IAuHurDuKnRw1Wx+hp3M=; b=e9ub0OD9fGenNMefKIz1bfz+9O
	0F+Wy6VB35eT+TZHL0PyQwpuNY+zssMsuObVBcn5ilfu78AyW0iMTth5rih9kN4Z
	0S1a6FsbPk8Ya9z51kv8xcjjafwKRtVEj2yE3mh0ZWHzf1rDlarRBxDHriLQCgEe
	ZHUsC8ewItdgRvybggHtehlItBjswoYCnUPvP9wmxtegEJMdoUS+arb1vB04IGZ/
	oL2usc8hJVMYBTxjjqtl2mh63GpDd/CNXn5yueCj6E+NFj5LsBmYf3oo9Hbzo3rl
	2Pc+hru81wKc6UivQVerAA9RCH6t2nKSX3W/C66GDAp4eSJLB5jcuirHXkUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769120396; x=1769206796; bh=cpiieRKGNbJgzbMl9prg9G+IAuHurDuKnRw
	1Wx+hp3M=; b=VFpW5PYp5QxnS6Yp9rNEcssnlxNSonlQT7crtXqL28wUft2Mtv8
	FfNWfYpA7stquaJt9Hv34l6xet1dVZtzwQnzBEBuKfm7aJq/7aAsPD+mZDNBGSel
	5g/GOU6YWnFpcL1P+9DoioyQuVRnDoGXxvXP4VMbV8P63BOypIZTpYcIdVl8TISf
	epMhqV862kiuNbIj2YN9DKdUMVnSqGADW60NL7+SDAa0H7+HTBXL21te++QGcQQy
	bWqeNr2jrTPydy5Ep2Zs4pKiWoU5xJ0ovirCelwiF+jqjP2AItMgLTe6MKU401P6
	47vkEkVrn2Il4JciAfgUkauXOTyenhl7hHQ==
X-ME-Sender: <xms:i6JyaUJo6teRJGj083I9apb60ppyOcSk5GwCcgDLxm3I8IRAR3JUzQ>
    <xme:i6JyaWa0H-BPXEob5ePkf6cQZgM6mZdB4rQ98MmK82JUO6aFKp68LrlY1befD3DXk
    GzZxFbn7lFriF4L1xaO-DRCzWlLLrPg0xSo-eVt6mP70FdXDjKwcDE>
X-ME-Received: <xmr:i6JyaW9P35YCEthGKFSXBIW7lcTanXpzvTvD_cXASuDZl35MDyzmXind0EtC6fjZO9IVSyPpldKe9FaUjMgHu_x2cUG7KnXdD2EvQBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghmihhshhhhhhgrrggrrgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:jKJyaXb6demt4XCsWY66ORrUCL8NnSPm6YHxX2Bublvcju248TH9jg>
    <xmx:jKJyaaN8vubKvVqSQIZN3qDXmb9cF3Ejbc_n_GAB_T5Cj6_EzqfwAA>
    <xmx:jKJyaTDjpvWvHvnl2PUMBn0l5WR9m0TckPW1l96qFKMwEBCnhYCl8Q>
    <xmx:jKJyaRI3Rgw9rX4CCtYoozHSpny5coK4LYOxwbEPIg4OW_BiQ60JVQ>
    <xmx:jKJyaad3rOsW3gxvIMJ-nsTOSLwyvBicK6zbtablL5WaeH23CD_8dDPw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 17:19:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,
    =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah  Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 2/2] Replacing calls of string_list_sort and
 string_list_remove_duplicates with the combined variant string_list_u.
In-Reply-To: <20260122171523.94234-3-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Thu, 22 Jan 2026 22:45:23 +0530")
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
	<20260122171523.94234-3-amishhhaaaa@gmail.com>
Date: Thu, 22 Jan 2026 14:19:54 -0800
Message-ID: <xmqq4iodl27p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
> ---
>  builtin/clone.c           | 3 +--
>  builtin/fast-export.c     | 3 +--
>  builtin/pack-objects.c    | 6 ++----
>  builtin/sparse-checkout.c | 6 ++----
>  help.c                    | 3 +--
>  notes.c                   | 3 +--
>  6 files changed, 8 insertions(+), 16 deletions(-)

Nice to see many calls to remove_duplicates() are hidden away, so
that we can check the remaining ones.
