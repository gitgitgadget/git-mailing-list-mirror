Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCEC148314
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140391; cv=none; b=VwNWx3KvlYu99E9jwP/lW0/W52K+CAOQZcNHpPIAQuAc8+98veT+xxBXY5IjAKymxQoTVTeHNT5qL4TTV+Lu2P0ekHx9s0XHtQj3BB5NTtCe5wApNJAoYa26g+lN3OQtF4jXIuH2Akvkq0+t0WjRHuyagsV/MyRCiTPd2Wb5hmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140391; c=relaxed/simple;
	bh=qYo1QErre5ibg3Q+BANsqgOJYqLJ4+kj13SPiEm3hNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kcCaOWyPTK4B1t0xbOo5RsGrNtAt6qOJ5hBpzpe6DfyFov305WLayQHAzvIlRrfQ1ltm+F+xz+rEoVrZKCyAL+s7niI585lSjCljxISt5bgdIeJ/hK9G7wi4Bo2EFlyh4Ki97VnTgnoV9BaYrJPXP4wr2CI8uQrEpcvcjalVXdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J/p8efrs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r8fmIUHG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J/p8efrs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r8fmIUHG"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 427E9114012E;
	Tue,  4 Mar 2025 21:06:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 04 Mar 2025 21:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741140388; x=1741226788; bh=qYo1QErre5
	ibg3Q+BANsqgOJYqLJ4+kj13SPiEm3hNE=; b=J/p8efrsBFRxHaXaslrVT1k3Hc
	7X4zrNimzlKqUnBI/0HqBt+SapBsdUfHokpvtooSc2sL1ySpdKs19c+j4cdSUCZM
	XR3FwjuLZ2z4VfkorNJ7PIYNEUTATNqQ67LSvFbjsS79ob4BhKxJ4NETlU9zCu2X
	ZOnI8PyM+W/Y64/1eQEEJg9h8lxkvLgIrYx4DGwvwqH/UwyLze/8aeD67WxQI47B
	Eu/LBhkMGEe176RSVyP/r1gXKV2+wb8DFjGzvxDOE4/6X9WSJ39upQc3ahQtMFK4
	7Oav6Bcgzi18hmEfgmxNG4fVgy83NdaCvUJgFUY6xcNN2cfxqT85mcQFbunA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741140388; x=1741226788; bh=qYo1QErre5ibg3Q+BANsqgOJYqLJ4+kj13S
	PiEm3hNE=; b=r8fmIUHGXVlhYW+7w6osFVf2EbOxof70WUsLhQcwbR3XR0CK0Gw
	V6IxJJuGnjRIpQZC9WuIwvbE5AFI1BU35LkqtY4ViqDAbol3vUxhpnHfWGI681jQ
	BwH4zXNt7HU1gfJgVjGFfi530quxYVB3dO7Ob6MgDGaGNN2nz+7LX7q/J54UVNXb
	xsWSIUrVhxGlzQRUGh92lrP3yUKsTKltQQnkfP2+yDtvOyih2cGCQh6RKzvbtICT
	epXPIcGLLp/dkewMyqJDItWJbx5MgWApreUklVhTD0R8CC77czUyEZuellqnj2DK
	HcViw7awyrpGd1HE1Wt62PtF4j2KRdGYyug==
X-ME-Sender: <xms:o7HHZ5bYRbbGRoMUW9HjiHmzEoRcijB5re3GX3nyruWo8G9xI3mPJw>
    <xme:o7HHZwYYkmJFEwXumblRYNNbxfqOA5a8rBdojZIiT_DYfm56Swc8hIcbvih2PZs0-
    ey8_0GjVFlZv3VyGQ>
X-ME-Received: <xmr:o7HHZ7_2sYpsIaKcGI2RE3EaQrLoZwa2ZREkiUkX1dMURCUhIJx83gqNLYn_M7e2jNV9OwvVK0gjlMS5sxeqBRQnSBN-zTe3gQvE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvg
    hikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:o7HHZ3oVbVAwFdhfgx-kRWl0elz6DIwBzKT7glthUllEInl0nY0vog>
    <xmx:o7HHZ0qFeRQ9716S7gAxjc_N6a6pOv7Xfij02L4y-iirnaF7aTiJOA>
    <xmx:o7HHZ9TYnHLIgDMvJxbottlkNtXrrmbg3tWmD8sbXLYewG1O57h8og>
    <xmx:o7HHZ8pbpOVrLHu9UHY1PTLvu-96zlAjl6G_lbtG7CPQcJ53SmDPRg>
    <xmx:pLHHZ_UEMBkJhusH-bzA7YBP46bd_Xi8KZDIWcynpRw_eeQx6JvH15Ll>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 21:06:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC][RFC PATCH 0/6] Add --subject-extra-prefix flag to
 format-patch
In-Reply-To: <7350D94E-39DC-4C9B-926A-3FA2A4C76687@gmail.com> (Lucas Seiki
	Oshiro's message of "Tue, 4 Mar 2025 20:19:43 -0300")
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
	<xmqq7c55vhj8.fsf@gitster.g> <xmqqfrjtt084.fsf@gitster.g>
	<7350D94E-39DC-4C9B-926A-3FA2A4C76687@gmail.com>
Date: Tue, 04 Mar 2025 18:06:26 -0800
Message-ID: <xmqqo6ygmdst.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> Once you stop treating [GSoC] as if it is an independent prefix,
>> everything will fall into place naturally without adding anything
>> extra.
>
> So, instead of changing the behavior of format-patch, would it be
> better if we changed the documentation to ask these patches to be
> sent with `[GSoC PATCH]` or similar instead of `[GSoC][PATCH]`?

Yup, I do not know offhand who are managing these descriptions, but
having extra moniker in the same [square bracket] as PATCH is a more
common practice, and we should follow suit.

Thanks.
