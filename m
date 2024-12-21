Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9138D13D521
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734801196; cv=none; b=ACCYCbtgiP+HY0tZv2sFZicQbW0iSbfGD+UtA0EQFlrOXSz2+HTgR074IxuSygGV5QZeQjnaHcFWYhYNPTkgXNX+b8oXnGM3o/adAo6YlrVhqk1zoCsMntfF5AZXOMFdNNR9v1urVv3F1z3LuPm/AusVromdgW7kMenAd+/mOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734801196; c=relaxed/simple;
	bh=AtZk/7H3ThIsfgaAwlk1RIcRuOlooFAqmAggf5oUou0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t/zCR62ehUJdXE9Sp+Gsytd8+18AqWD3fAQ3+prZHQDRTu8kGqjWz0BZAAKEl9+fYXsOvIr/hnc2VR40Bp5FnuPPd8ISd1KAXq7VgJvWCC0V3sV0BQ0De/SMUFB/BRY1mSuIX0bi75qhJcy8Z/nR/t8f/LddgLIEYMYdBCil7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zomi/k+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sRONISW8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zomi/k+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sRONISW8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 85D10138016D;
	Sat, 21 Dec 2024 12:13:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 21 Dec 2024 12:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734801193;
	 x=1734887593; bh=rUn9ixaaSIg4WxbXUF7BbGNpt9Cvrm6lRkUflRydZk4=; b=
	zomi/k+YVX6cDWYCztCbd1P3zgCsO/l/qFeOBOHLB4IRqM7+XZ7sa1njjJjjCxwf
	e18uCvES7oYeqbYLX09R3LcV7BBR8ZA9uwbYotLfLYlRlXTufeT9gKR9AQVGfjOA
	awwpIiMFYjagBRSA89wniLOXQCy3rIqswS9Gudug6sIt92UyGOEOTbD8jfcLNx/z
	x53hG1yKTJo3uiWJKGcR49O2usktYBekBdnT0H8j/7Y8IdmD+YTXFsuakQUp0NVO
	H90j0+2huxFgW9PmFslxbr9vzzRC2yGIos/6HdT9OIGAshTT+sTNwDqJcACwUA7U
	HeHUVHw6+nNc0JkebGrzog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734801193; x=
	1734887593; bh=rUn9ixaaSIg4WxbXUF7BbGNpt9Cvrm6lRkUflRydZk4=; b=s
	RONISW8odjswhchOwkDIbxNTCR2kgLkVtLAE+wTmCCMyISIGnkL+r2NvXgoDNmav
	EYgqU3WJXDDYEUPJn/TZLCxjnGNM3dio/2ThgmMhBcjwEM/k98qu6QPDG93Vb6Rc
	X5QOKuzDa6GLrx8UYmxuAfquuVE0LqwA6Yi06JOYlS5sudJW+XG967aglAkanjFR
	Vx7JlzCYKUA5z31KD/FWe5Q/8YtkpfQedsJU1qYGCJbIHGALTN3CHNOjw/8cutA0
	Ozowtme2IKNDw/ikLkfANhHPKP80ZxqakhXuQdXq//F4PTNLl4FJWInquVcjjThf
	ylRUdjStyuYE2nTkIx6iQ==
X-ME-Sender: <xms:KfdmZ9FrYrxuYnh5UvCX5gaE5YS33lJwaBjWIRhv4IiMSR9zLOnYgA>
    <xme:KfdmZyXKZ40OzBqeKt1L-BPG1zAAw9fSmcz-Vnlq6NzMGmCIaCkIgkN03oQ5SfxGf
    34Qu8L_hxb6h9g7xg>
X-ME-Received: <xmr:KfdmZ_KnStxRKmUF-98f6Q3cm-LnjBXjnAybCqEPCSw_1G8xIxMlm9B6nohqv2D4ak7CHb7l6zbqIJ7pbD2fbP8XN3nCKHsTxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KfdmZzFaqNIBJDNqHmCkDGRpOZXNDl5tc21dTv4MfXgXkQ6jvbsN5Q>
    <xmx:KfdmZzUxJtIsbCN_bZWuU-SfS7mTCJuSl-2q9ISD6RxIOliQ8XOSXg>
    <xmx:KfdmZ-MtO56pC3DqSwgnbX2rneCK3vpND6nz4KFfkZKS1GQBIBnMCw>
    <xmx:KfdmZy0NTiSHxU9flEeO7XbZAGwT09PFPZ5tIOwqUSV82VTVsD1snw>
    <xmx:KfdmZ5eE0Id4TZ1lZ2vQ9-82D01fGgA41zlbAJnLjWWTm2ZnlFdCoZxK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 12:13:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  git@vger.kernel.org,  "Randall S.
 Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 2/4] reftable/merged: fix zero-sized allocation when
 there are no readers
In-Reply-To: <b4ba502a-b689-4736-9712-443a137b5d2c@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 21 Dec 2024 13:40:32 +0100")
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
	<20241221-b4-pks-reftable-oom-fix-without-readers-v1-2-12db83a3267c@pks.im>
	<b4ba502a-b689-4736-9712-443a137b5d2c@app.fastmail.com>
Date: Sat, 21 Dec 2024 09:13:11 -0800
Message-ID: <xmqqikrdc63c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Hi
>
> On Sat, Dec 21, 2024, at 12:50, Patrick Steinhardt wrote:
>> It was reported [1c
>
> A Neo user, I see.
>
> s/c/]/
>
>> [snip]
>> the result. Now that we do we notice and thus return an out-of-memory
>> error to the caller.
>
> s/Now that we do we/Now we do notice/
>
> Repeat of “we”.  And “that” can’t be be used since it has nothing to
> connect to.

I read "Now that we do, we notice and ..." a perfectly sensible
construct, though.

Thanks.

