Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C82F3C3D
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065381; cv=none; b=AsnEncEjqNuG6OfsGGxh4hZ4RrJa0iQrj4U3bLHGPEvt1qq3LCP2clhzVQnfiQbTgrQo7J6EvDGc357ElCrUqsGUgxP6lDhRmiQkFSB+VEkhVZGosZUV3eb2YCA/c5VXUtc0SzBrWzAJxG46+ed1U4ELaF0ga3s8gORTbs+jcWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065381; c=relaxed/simple;
	bh=YmNMIRM4aiu45SAewZMcwBEzWyBtayxMhMUd4Pf8aIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YBafOkYz0HQFSM63JwTp32UCUkPRQ7sy7+0tRIriL2IHk0KiwTAnq0rnHl2uDO0AcySriASrCEm1/CDJVKAfunSQWBKnIV/9OLNdkybujaWNuLGG9U4JjRv7r6Kxqi7A1im3BEBGLEm7r6OXuclkEzFVdr5BWEAHW6DMwuBS9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s6B5MCWI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JFf0683M; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s6B5MCWI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JFf0683M"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 68E1F1D00056;
	Mon,  2 Feb 2026 15:49:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 02 Feb 2026 15:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770065378;
	 x=1770151778; bh=YmNMIRM4aiu45SAewZMcwBEzWyBtayxMhMUd4Pf8aIs=; b=
	s6B5MCWIyJ4nd+UJ0oM+ArPvR7TPsC5NgaAEtJg9+YQPnNNg3cFcabGyyiixk5d8
	YPVNVKM2Co96DU8pFWVe6K+k15PLpuYWkbEi+G3wWMFLOjh4wTvwI8/0DLnAgRf8
	2Q/sswv1M6ww2D0v/HwUbOz/tuPJBkkjFEGK0Vhhlpgy0TMa8NvmOjE7xl3Tl71d
	6XksPZ0TohPUBMui2GOTL39IQ8N18QDm4Rhhwrp53Nmw01Q4qIKCY4d2Hmy3vC+g
	ddGeP5jRtObyEv9LErlJyOcHGd5OjdUsy/u828egnVc699oZP1YayOVobQd9BNTk
	RwAiYf65r8vnVAjzpapyyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770065378; x=
	1770151778; bh=YmNMIRM4aiu45SAewZMcwBEzWyBtayxMhMUd4Pf8aIs=; b=J
	Ff0683MQFdI2/RnnVMYhT4ORNyEvJsOUDbXYqOJH84hPtbDTHWyjE7KhIt8Nyvnf
	Yp7X4yT0G39bRKnfRL/DOOkqKajgu5EZPWu4z9VAA5Ydw40GrUHTqJxaRvOnC19e
	d7q+lkKLL2UbU5ZHTGhYaxLMzAYmkOfi5AxAzkBllNyP53q+ugPsUbLY1S5db42T
	IHxvRR6f3n+iDzGBj4JV+j/EuG65Z1lEQfSroEZ/l4jYcC1t4RJESBmSZck6cjvT
	mUEZzE26gxGbk8U8+4SeFJyh17qiSYOSynJRy2OGYM80pAxsln5RkDjrVTHgYfwW
	D7MYxMM6NH1cD8zkvVw7w==
X-ME-Sender: <xms:4g2Baap9yilBG_QQhBM6Sl1Y7UO826kzpheaHtlYvHtMr8TjE_LiqA>
    <xme:4g2BafgjAxiMeh2WmNnyyf4R0xtc9Ukq_EZs5K5mv2J8m_ZiYrjONduTxy9kM4M33
    IXEhANWZZGcb7YxBIsHUy7ZzDdOgp_CY2MaX3MrP9qzBm9VbaIBamc>
X-ME-Received: <xmr:4g2BaXizWech4HTybweWlKtoKP0_Ai6WFxd54A1KGHscvqXuuqoesGmuF6QTyNRCY_wjxEb19--ruQwitIZEqPKI7CL2LEwvrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehlohhllhhighgvrhhhrghnshesghhmgidruggvpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpuhhshhhkrghrkh
    humhgrrhhsihhnghhhudeljedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4g2BaVhksCCYGNaMaQeDilHWGjc_VQeA7KswGahUyiV4jn4cH0t5ZA>
    <xmx:4g2BaXKGd2sG-wjVeVaMznqeFAFDD_CqLDCsYHwHRJ3d6YjMeiRWxg>
    <xmx:4g2BaUEEw_XrRJwyRi_Wu7-uBn4cINh7g0RBk20RYmplspWHY9nDIA>
    <xmx:4g2BabR9AHoLONcAH3Ic-el3H-ZVhz2rw5-5pWeG54aoQvXLCgp4tQ>
    <xmx:4g2Bab5ylazMEOLhBAc053SBC1_ToERludtWbq4A2GCu8petRT16d1-e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:49:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: lolligerhans@gmx.de,  git@vger.kernel.org,  Pushkar Singh
 <pushkarkumarsingh1970@gmail.com>
Subject: Re: [BUG] git log --graph --pretty=format misplaces graph
 characters when -p given
In-Reply-To: <CALnO6CCqwnTcQWSUBPV+o3OO=sMZJjj6jRuMNnBjV3F-dYx+0w@mail.gmail.com>
	(D. Ben Knoble's message of "Mon, 2 Feb 2026 15:27:22 -0500")
References: <trinity-ed0884d3-098e-44be-aa1a-a96f664ce7ca-1770049279182@trinity-msg-rest-gmx-gmx-live-5dd78c558c-fv4g4>
	<CALnO6CCqwnTcQWSUBPV+o3OO=sMZJjj6jRuMNnBjV3F-dYx+0w@mail.gmail.com>
Date: Mon, 02 Feb 2026 12:49:36 -0800
Message-ID: <xmqqo6m6yiov.fsf@gitster.g>
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

> On Mon, Feb 2, 2026 at 11:22 AM <lolligerhans@gmx.de> wrote:
>>
>> Hello,
>>
>> Git can pretty-print a commit graph with git log --graph and a custom --pretty
>> format. I alias some uses of git log --graph --pretty, to which I then want to
>> manually add "-p" upon invocation.
>> ...
> Yep. I think this is because format:%h doesn't add a newline by
> default. With tformat:%h or format:%h%n, the issue goes away. (See
> "git help log" under "tformat:"—this is probably what you want in
> order to get "oneline"-style format.)

FWIW, "git log --pretty=tformat:<whatever>" has a handy short-hand
that is "git log --format=<whatever>" ;-)
