Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F90129BD87
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085418; cv=none; b=ACBuPca+XxJGNAv6TkbWCdvHplCEW2+SpOPPccTdoVHK9oKzzOyMQHZWIDW6OfS0slu7yF1LzPsozjXFojSgjjxvBSJP0Y4ToyCvjOq23oV3y530Tg/VzzNw8uS5qI69Oa8Ii0N2pNqbOY47/Cr8ceU4YBH1wirJrzcECUDzX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085418; c=relaxed/simple;
	bh=cq6NsZI1sp6rcDv3nM1B/M/bPyweKDmb/QOjHpZGzMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lWTZbtbBwGxUI88Ho2P4aATa4pJpmCimv1FNUFjqBaORRsHgvlIxFYhQ7agrbVMNaMWrHfwGyAHvC7taTIBiWbwBzIcPxnb2g8tMO2e+/vg+qyv5rHBJLjKT2AxwnEn+uYuPZ4jUYEnoz8Ms/MUp6HJ6dTLuvi3wFKACuSlsV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T89Ltxbx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cnMS/Bmx; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T89Ltxbx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cnMS/Bmx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02BD67A012E;
	Tue, 21 Oct 2025 18:23:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 18:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1761085414;
	 x=1761171814; bh=fk2nc2HGIolNbxCYNyxmg+V/MzWm19eYjWdfWfBvbs0=; b=
	T89Ltxbx9NIB701jhFOLSW0mwVgfNfn3XRkQVYYfsv9IMec5VJM7mceIgDOZ6dkv
	neimfjxlpVipPYNMJFSxcJvdy/M1xPyQbyW5S59SwHTU8afTTC2K+t77J3NsVyfw
	34CqUuauo3mj35YL2phEvMYLAsamO2mTbWDUMsUAOFkuvIYaS4zd22YRLpIXKV9z
	VKCNYL7IwjhJny8AArIh0HC3G++OXqjSagQ38xPIaRPb8euyG+zhNZiJjdhLTCYj
	x6EcXdP8hya2pfiXfvXHAf+Pf0KTpi/KUx1NMoZDJja6b9yqsMlx7P6qvCgZf1A/
	9pGQuQpP4FE9dnYIrpcHzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761085414; x=
	1761171814; bh=fk2nc2HGIolNbxCYNyxmg+V/MzWm19eYjWdfWfBvbs0=; b=c
	nMS/BmxZ7HYbIfxHjBrADWXKKIRYeT89RSk0TWTQ+mXM46vmGC8ngQn+poVvBTGF
	mDcMVbtXkkXrKZ3yHAU5tzOElFjTIR76KJUikuTZAzD3oQFdASkgyblddYzT0lYT
	Wvm/QI0vxaFdIw2y3O4rUxEWM9gH0onxzl+kdFUeqEzTLzSzwrvkQ9tgPjVU6qcc
	tGbzjr0Kx00nso85/xA7KzCEkSVb78qk2XC19nFx+6pdyAW5uPmUBksjau8Q/DZK
	3v4GAIb3SsxTb7ZjxfgJqyvXjukOKIGPmxNMzr6aV/O6QsYGuKX8ylQ7OjhZvpzx
	734eerGSn8/fYO2BFmZpg==
X-ME-Sender: <xms:5gf4aGy_8XhA5G5TinHbGOQRsjdPnI4iK0PDrKvbOZ6tagdPtR127A>
    <xme:5gf4aJRJqDNh_-m1CWZuvtZEuLjddC8pS3zngc5w4d7Cl9vhXMpq-Y_YGDiz_RZVA
    tNjMDA8zXJGpnP3lcKuFZ_d5TriNqzajaitpdV2wT9UzXuO34sWCQ>
X-ME-Received: <xmr:5gf4aNVZHMtDNlOILaiGVNAdrrmD2pPw3eyw3mbruJ12bOhSn79eiQvqK-74S9ygnabEJXZUsGY5UmFEYAfQI5Ct3k3UrvRGFyk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedukeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopegurghpudessggvlhhlshhouhhthhdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:5gf4aLarQ1O8Pcv4sMMp6HaclYDQO9EICTSHDgPVXCaP7izDfxwxzA>
    <xmx:5gf4aD3WHg1nkeZVAyUvX5TOfkuFWshFEYcWnLNUDTjOkwMJKmGdAw>
    <xmx:5gf4aNhTbv8Y1hBZMPAJ3GaZIfS8uNOjtLy4S-fceQjV_Rr8_Z5R2w>
    <xmx:5gf4aHbWWAQuwjzTtzy9y0hiqS7d9dVY_OHPu4SrZP35KQOv0A2D4w>
    <xmx:5gf4aBZ0HzdarXihXkn8pi2Be7mZXcoM_W_T4G3Y-kmGA_608zAX5M9D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 18:23:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Dennis Putnam <dap1@bellsouth.net>,  git@vger.kernel.org
Subject: Re: Migrating Repository without Network
In-Reply-To: <CALnO6CAKBB=MRUBSv-_pqWuUgi6d1+o_X=iq-fLzfSkCYMaiPw@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 21 Oct 2025 17:23:38 -0400")
References: <94497aac-c61a-4b17-9e4c-8ca9b966829c.ref@bellsouth.net>
	<94497aac-c61a-4b17-9e4c-8ca9b966829c@bellsouth.net>
	<CALnO6CAKBB=MRUBSv-_pqWuUgi6d1+o_X=iq-fLzfSkCYMaiPw@mail.gmail.com>
Date: Tue, 21 Oct 2025 15:23:33 -0700
Message-ID: <xmqqo6pzsxlm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Tue, Oct 21, 2025 at 10:52 AM Dennis Putnam <dap1@bellsouth.net> wrote:
>>
>> I have a server with a git repository whose NIC is no longer working. I
>> need to migrate that repository to a new server using a flash drive. I
>> can only find instructions for migrating when both servers have network
>> access. Can someone tell me how to do a migration without using a
>> network? TIA.
>
> Have a look at git-bundle(1), which was designed for something similar
> to this use case I believe. Or, rsync the repo to the flash drive and
> then off?

But bundle is only about preserving/transporting the history
recorded in the repository.  It does not do the repository config or
the hooks.  Those folks would want to migrate the entire repository
data off of a failing server, so I think "rsync/cp" would be the
more sensible route.

Thanks.
