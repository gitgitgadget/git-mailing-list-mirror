Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE877081E
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764201646; cv=none; b=NAfoODrDQDMftPRNx37stxkh8VubzUcfeoLOxQANM7woaNUS8aBU615hy63sirXCBd2RmDowHIicxR9CvvLVSWsf0Cb1AiQ1RQfQD8aKbjbycaYM0eUS0IZ1F1OVNdZRObYmRjBxJIVHHT5p1Ni1JzIhquJLNI4QyxIb+VH7AMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764201646; c=relaxed/simple;
	bh=SAYmy9e8qAdQ9J3ZYMtcuXYlyPgNeKDcGBRhn4EIS68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C0ySXVhJA2x4yZYdR0JIHlzbBF0pxrUbMKQbvWjUjG2zRTJu2itOpamjIPKB5ytSHwMo9xjiLjJcsgMOx5UNVh42uS36whe+eDvYxRTMWO4lbWSoffnbmhZDtgrgBCxZNzf7QCzw2P2sbVZtZyptc59MLaoA3mGxR8TXjftrkDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JjuVJg3c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lKU3fo7m; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JjuVJg3c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lKU3fo7m"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 332BF1D00158;
	Wed, 26 Nov 2025 19:00:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 26 Nov 2025 19:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764201642; x=1764288042; bh=ZD75zIIgSB
	NzeJlrNIStcmKzzEv5K87q3tFcE6PNRfU=; b=JjuVJg3c04BSsJUYDm90AfJ4n5
	frYKiowwu48lQqQtF2fJ42ZsvBYPwf6copD7KoHfF/KxW09atomoCG8/Dm0N9m8y
	QNO8Vyj9y0PsxYRmVNQAMls7kP6TP3Hlafcht1LVnYC4/BwTbArFuhQ4aq389p9F
	93LQv/p4AbOiU3H1I+GE7bVxQ/IJ5LcTQommRFDxlkn8KNlSP9OtXvel/95eCW5H
	s5xmVXpItMS9+5wwcmqRlRk11OXWcLhiJI+yU5hYyqCK1tGVLUrVJ0P9TQFE8tDM
	us4YA9odbzPkt/SFKiZerPAAgzqbX+4fT0xifRo+sruVCRo2wtNkE6mlxrsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764201642; x=1764288042; bh=ZD75zIIgSBNzeJlrNIStcmKzzEv5K87q3tF
	cE6PNRfU=; b=lKU3fo7m+0wpYWwiU+eBWw6VsUyfO9ccCvRJPJMMbb3teDz2/K2
	v8yWJ/eRdRmcOKTFGgXQyl9tVHd2CSrQ/GZ6fIxESzqXqPSH524SdzDaT/cohbbn
	XoNNcwQVdndu7iuDXrf9wQuCxXCmBTqlTJ/AFqGVrUv6HZtWSWYLUYjFlDIP9mve
	coMJA7yCxOHxnGVHJuo/m5E7AGQ2+H/VlktpcR5QWDCti1q43nfo6rP4lKMLNeYD
	m1pFnxP8XNhmct8DON429j5fEPrq96QNvIqyL10I6/1ulXY7pCd5AqcVa5voeLhR
	eEE+q33uXx/zNRtPzM/V4UO0Uh8UIiYQXnQ==
X-ME-Sender: <xms:qpQnaXYEQHvSQEd-q15c-zvNop0ZheJEAkE4oW4PBiWjhHP4BNxJ0A>
    <xme:qpQnaYru2W1lYZrwfpksADG6DLY99QbOjo95mDLWIfcVOgIpqEK4chW73zyY_op17
    zW4jE6fgQIJJl35DFKaNPIjPtoMg90Lt4AdoQyIdzrNEbvAz3D9bw>
X-ME-Received: <xmr:qpQnacNolhBehdgn0-QvzmFIx0nZWGjh143M89HTfsj-UFRhiw3nO9s-w99WzGu8ApslhIYNT7m1-xbR8-vX5hm-UIbDeJbeKCzy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtoheprghtthhhvgifhhhughhhvghsleefgeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qpQnaTo7nW5D7JRVMC3ikqvy_u3l8fyT__FKHJLXpo-FAeTnAXZffQ>
    <xmx:qpQnaRcoVYkYmIXel_iGSZeWUGBmmfkFv_Bcuoq8YC6BvCliGcAwcw>
    <xmx:qpQnaZQbyDS5PCT9zL-eSyJqgGOwtEETc5C-klR2UScB0mB5Mw9r8A>
    <xmx:qpQnaaYRRXqwGBzKOef7wxbLOP_CXKFCIQjYgOGUMd5oQuoUJCqF-A>
    <xmx:qpQnaYSED8dszllhIY5cB9IKkpdCJWlArD2tGRvmMUpL76JuAmjAPHde>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 19:00:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  atthewhughes934@gmail.com,
  johannes.schindelin@gmx.de,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/5] scalar: remove stale config values
In-Reply-To: <156be69a7994f6978a5bae30b82ae374fe4d506a.1764195516.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 26 Nov 2025
	22:18:34 +0000")
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
	<156be69a7994f6978a5bae30b82ae374fe4d506a.1764195516.git.gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 16:00:41 -0800
Message-ID: <xmqqh5ugl4ye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> These config values were added in the original Scalar contribution,
> d0feac4e8c (scalar: 'register' sets recommended config and starts
> maintenance, 2021-12-03), but were never fully checked for validity in
> the upstream Git project. At the time, Scalar was only intended for the
> contrib/ directory so did not have as rigorous of an investigation.
>
> Each config option has its own justification for removal:
>
> * core.preloadIndex: This value is true by default, now. Removing this
>   causes some changes required to the tests that checked this config
>   value. Use gui.gcwarning=false instead.
>
> * core.fscache: This config does not exist in the core Git project, but
>   is instead a config option for a Git for Windows feature.
>
> * core.multiPackIndex: This config value is now enabled by default, so
>   does not need to be called out specifically. It was originally
>   included to make sure the background maintenance that created
>   multi-pack-indexes would result in the expected performance
>   improvements.
>
> * credential.validate: This option is not something specific to Git but
>   instead an older version of Git Credential Manager for Windows. That
>   software was replaced several years ago by the cross-platform Git
>   Credential Manger so this option is no longer needed to help users who
>   were on that older software.
>
> * pack.useSparse=true: This value is now Git's default as of de3a864114
>   (config: set pack.useSparse=true by default, 2020-03-20) so we don't
>   need it set by Scalar.

Thanks for a conprehensive list.  Very well described.

