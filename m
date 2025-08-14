Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C521A454
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184549; cv=none; b=eA6/9mS1/yr/3GacujRmnN8IPsK9R1JIgF6rUcttV2Gd0eZHvsOPhk8Ofyc8gXd/8UpQH/KC14DdioxYjJCHpT2SBSvyoeicvVFPDaDVB2shA9gCn9vkIIIA2tv3ZWIhcSVS1XBCulq8Ob697SA5xgzBrhk0WZczXBwQZkLFFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184549; c=relaxed/simple;
	bh=bydAT5cmGWYXfjuI2DXPx4n8uGU4Ahog5qcCWY5I2LA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hg9h2iDTBZv6B77MYjFMUpRnl213O+G0Lbs9Sr5DrCjYpthMvLSKq1hsDYHSp0xPQeQNDqi7qjvyTXdJyrCj8BdYQpNNqGVLJP/Sl+tWF9iCNod9F7j5OO3IDaH6L4tcpff1crJtZAmsdeab5bX8kPpwuq3jP35zHEp/ilYaDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F0VDj8LF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iFwq40XF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F0VDj8LF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iFwq40XF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 179D9EC01BF;
	Thu, 14 Aug 2025 11:15:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 14 Aug 2025 11:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755184547; x=1755270947; bh=O6akVDeEvu
	3rSU6yMbZiJTVqrxbWiAL/1nR+uH2hoRI=; b=F0VDj8LFpjvtqDPYTRzGuk0YSq
	kv1uEVlhzuKFQ80YNAtcDGPijFjbVe9hi6JgxPPCJBdDMjAY8Hr3fhj0a82pYotn
	0YDqWk2iFYP3F/xJhyqg4I5J8/YiHAY/AhXpEr3es0/orMRJMUqvuWJpWnj49LOA
	n/KqVqN7UYFjS6Sej1wX28ki4TJjJT9oha6CUIgX7lv6q8AyT6cLGKAQX0xsIMuh
	ZXkUjbltjGXlcYUDkuyVrfEacLlyzoZ6JeePARQA8PFrdaiI5WU9+wAE7iP+HDAY
	B6xGmrK/l2vnH04hKJUqx6OiCeFJ4cLcjXpO9oO3QvSkrC4ZaAuQgCXjDSDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755184547; x=1755270947; bh=O6akVDeEvu3rSU6yMbZiJTVqrxbWiAL/1nR
	+uH2hoRI=; b=iFwq40XFpH/Lw8YLzdcXVUZmOAX2Lo2Q7K27k0O2+a5VliiAw7E
	7NnqMuO4hx59mpuLrh+uG7L9gRvRIl6JSGVTuOECvR4GoCJdXOXLDu0K7nl7eD/n
	WyjjF2DK5TgRrdUM02rmqDkLbj1krhhijt0+BVOwexkO/npxvvtGp9LA7RAJmg6x
	obQd8ALDhkJxoMeowPKnX5Hu6Zj+4NbyZqV76BkS7pQ8DX1T/uojf5pVE3dMXUdP
	7cG547LMhf8d9LzUrSn21yDf0ANxbDnQl1cGJGyvaJZrCXu/PU7dTAl3Wv1rbcHR
	hmpzR29CBQaRZS9GpFoOXJfhc7kQvz4aIMw==
X-ME-Sender: <xms:ov2daHaah71ACnSb8xngCVqvY_xblMhBuIYWJk-PJLTHcvfMfiJYEw>
    <xme:ov2daO0iDonUqhY_dElpju8oIPqD0DQ4nUJH_wrBxgk-PVYm-S9istkfqXdGUDA0_
    OFIVPyhbqo4YskAQg>
X-ME-Received: <xmr:ov2daKY8z6o27HpVOeoYWcXUVL1vQzAHTGx7MoMEgkUr6u59VJyMUye2cUOEiNrFwN83yZWqguMA7Vm7lhlXfKrBPf5zTsworWYCWUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedugeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghl
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ov2daOLFNy5jXMFRI8w4fyilZF0GqIt2pWHEGP09FDC7gBfXmoMtOQ>
    <xmx:ov2daBFsEMGSAUVG80FzuuQqR7gG7CbAokSTV76pNRb2gHWw8yB6ig>
    <xmx:ov2daNu_yWD8WN9waNC5sscB8L1fEvcTYn8vQAMSMY-ZRqR8JL1fbA>
    <xmx:ov2daIt29z4-jCW-hBp6lvY9UJdOUsHF-eldAKvEck8RW9bC1bTo8w>
    <xmx:o_2daPHkjHrJ2GINYR-7N8DaMKpjLHGLpQ4e3N-eSH-CrWZFRbVft3W4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 11:15:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>,  Jeff King <peff@peff.net>,  Justin Tobler
 <jltobler@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/3] Teach git-diff-tree(1) option --max-depth
In-Reply-To: <20250807-toon-max-depth-v2-0-50b7e5c81665@iotcl.com> (Toon
	Claes's message of "Thu, 07 Aug 2025 22:52:55 +0200")
References: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
	<20250807-toon-max-depth-v2-0-50b7e5c81665@iotcl.com>
Date: Thu, 14 Aug 2025 08:15:44 -0700
Message-ID: <xmqqbjoi6ijj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Changes in v2:
> - Added unit-tests for within_depth() in dir.c. Originally the patch
>   was a oneline change by Peff, but I've added a bunch of code and
>   extended the commit message, so I've set myself as the author and set
>   a Based-on-patch-by trailer for Peff. I hope that's okay?
> - Added support for --max-depth=-1 and extended code comments why we
>   need the max_depth_valid flag. With these modification it did no
>   longer feel appropriate to keep Peff's Signed-off-by trailer.
> - Made die() messages translatable.
> - Small tweaks to the docs.
> - Added some const-correctness.
> - Switched from `die("BUG: ...")` to `BUG(...)`.
> - Link to v1: https://lore.kernel.org/r/20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com

This round seems to have attracted no comments, after seeing and
reacting to a few comments in the previous rounds.  Should this be
a part of the first batch after 2.51 final gets tagged?

Thanks.

