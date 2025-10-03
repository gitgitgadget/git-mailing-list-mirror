Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADAF219A89
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759526654; cv=none; b=RblQbgTexrytdC79vgwiapXxGVFA2Nm/HIBt6mvL9p5LDVm+o1VOeSh/42pYVIYwt2T4iwBQ/LXybj0GXl1jhDYbcAroUGDRtcKY0mDRo0kYdifgj3nzXhW6nItClczGfN89crQwB2UgY3yky8WVLuRm2ioyCyAohL1qP8hI/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759526654; c=relaxed/simple;
	bh=ptipkd2k7GOhQx0VSn/ZZta7T+0sp03izzr4NNXY9xI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ldbya06pCC9lh/p2w9tenybpdIPB04+Xkqfcirh59ciq0noqyGfg5AnjAD6b6C6QbwqIZirZRSSab7aNy/Sy9otLNXNEOuHZRmukT754FioJ9sD7TW3y7sldfPPP3eFk1nI1hEDs4AmZB2zW0znyvlAtVwVUj7uRyvfmdDkodKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SZ6ufp+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UMkxRYCl; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SZ6ufp+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMkxRYCl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CEAC5140013C;
	Fri,  3 Oct 2025 17:24:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 03 Oct 2025 17:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759526649; x=1759613049; bh=r4M52bX/M+
	0TafhUGoUm/GMaSo/YTHm5k8hGHutf7L0=; b=SZ6ufp+YIl89nyRtiJXZN+/vyS
	5IJI6N+CTlBQGuuFVZL3B1KwokCIVP/QXcEUX3svqQASxzfyT+gDZvPOvFP4uWXS
	X7sqnoW2uGZtxHVGZd6cpGjh340vEz/xvvCHSEZVyYliZDWFu2gI1hpcju/lGDMJ
	iQqr4S++HXtPJ81ONb45pZXxVxoqb+T5K0qknZN8mNBC/DXzVFXeO7uJDjKEQDeS
	ASHCYyein93sfq7ammSWFpfdf1HYTVkAkmAmL4A8eUhW/uMfWimQwtgQ58jwUQta
	MqNOYYKFNXUQ5t2pomqcMQpeOph04MJ6PJYPDC5A8g4yDlcwTjdwPzRNlemw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759526649; x=1759613049; bh=r4M52bX/M+0TafhUGoUm/GMaSo/YTHm5k8h
	GHutf7L0=; b=UMkxRYClIt/Z2XjNOGnfyhM7Ji6KRQCu4g/fw6KaINJYPlll3qV
	YNpRnr9cZ83PtiOcLmnPASM17oSiEaA9nSJlG3PcBYI73lGC0iujQfEFNoL7pOmj
	wHrk9nOQxzA7mL1K1mTuOI4hpTELcGjrAD3szsZoIFXcRQejKQaiqn4F2gU40yfH
	/Gt6wE5vY5dlWTkA7D8+3LvzzBsxOS7CZZNVosrr01dHJZY0kDGEl/904tsDO2dL
	MFfNtzkNN5yCfGTcuVja9+cECeLXXZsHX8IwpMoU7LEv5tdIKx1x7SEfzXwtvA3R
	N/LMWYWW38R8+D0xhHZFntFDU5oamQ5WJLg==
X-ME-Sender: <xms:-T7gaFub-LTrhEUToBuwZsXZVdZ_Q_ySO1DKv2gf0uDVmp2QL-9uAA>
    <xme:-T7gaCIpw4Jtb3koA4vhssaGpRq76bPEoUShaO1Ftf9l8qbXWw3RSVlAbeOB7ws2e
    fxcmIZTsU6Y-5bfDORP8BAXzg5OzV4D1x2IEnGz5z1boyLWgh5HPQ>
X-ME-Received: <xmr:-T7gaClqKLTNB-Nwr5yKhTLRIxDqEmzrtcqdHAgDfWJKoKOokpjDBhhMdvW1i-lGHtQRhHv8y7tvKVjJ-NwivZZ1xbpDIChpB2jx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    mhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-T7gaDJ5T1Re7W69hSYUagyXJuaa36emGLRflUqfSuOKUz266zzeyg>
    <xmx:-T7gaH5VR8mtZ7p87TNyLjT4YBcWGuQ96wctIVjvaLW2IeYCMYFlLw>
    <xmx:-T7gaH25hm05k4QRfhLYkmV0BfFdzMi_lIPCENV0KDYO7I2-tv2PeA>
    <xmx:-T7gaNe-RyCsmVpajEXaA8gDnMUoycOaNUNVISdfvTbB9NSVzyAoTg>
    <xmx:-T7gaPsV8A1SLqacoO2wXHJNPuzKlIWi6fZvZbP864bP04Hd-b1DXShR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 17:24:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,
  Johannes.Schindelin@gmx.de,  M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] docs/gitcredentials: describe URL prefix matching
In-Reply-To: <pull.1979.v2.git.1759525133638.gitgitgadget@gmail.com>
	(M. Hickford via GitGitGadget's message of "Fri, 03 Oct 2025 20:58:53
	+0000")
References: <pull.1979.git.1759352209657.gitgitgadget@gmail.com>
	<pull.1979.v2.git.1759525133638.gitgitgadget@gmail.com>
Date: Fri, 03 Oct 2025 14:24:08 -0700
Message-ID: <xmqqwm5bsmpz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> Documentation was inaccurate since 9a121b0d226 (credential: handle
> `credential.<partial-URL>.<key>` again, 2020-04-24)
>
> Add tests for documented behaviour.
>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     docs/gitcredentials: describe URL prefix matching

Hmph, v1 was merged to 'next' already yesterday, so a replacement
patch is not what I was expecting to see.  Can you make an
incremental update instead?

Thanks.
