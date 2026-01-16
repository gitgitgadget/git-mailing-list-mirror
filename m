Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF44318E1F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583768; cv=none; b=bwZ+VQVMsps7mGZcFkrL4wAiU+qT19+e60WyEBSLYaleS7QdUMaSvujXWwXPiuMobuVzqsW8FGl4Q1RfMm4bf8No1bRBb5WsONK3ujMSj3BARROjEeZ0fBeqD9G8TxXkAtCHwI78qj1pF4JhS6yw6iHWZMqGWDSFdMLJ6gDRbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583768; c=relaxed/simple;
	bh=SUVIAxiGq7NnBDJjRA54zbtaT/fhJJCAvGigE1S2eAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s4yUy5Qs6jkL35R5Q9rJPcxoYJCejAYHFv7mXNH8H5Pavq1sMx58Bzx/UsoYOcjFhEZJqOB8DUM2LkWbzkfWmzKJMz5I8A772GKbdL049W8U5YLIrSQ8VKRz8ai0mSzl1osL7ZNXeai7vkyMj4TRwSiyQ18Zc+dOeDGQj5slRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UqLve0OY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkYlwhDV; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UqLve0OY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkYlwhDV"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id BB4291D0014C;
	Fri, 16 Jan 2026 12:16:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 16 Jan 2026 12:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768583765;
	 x=1768670165; bh=eFNf4lo7EqcCKcrnp2XpjeP9DnyqcaeXkBk7c4UZBGw=; b=
	UqLve0OY7iZEnemfec1wnsoJmEStzFs2pd3GEZ/HEFjkdTWYRKxD8JCvFT/iPbqy
	E998J3q/hUZ6ABjcxJ0/b5v9MTEA9hY8xwneDjiE3XiW+PNyRwdjRzUtaytZVMH3
	nEqewiLUT+VN+G6ghffikZWN7/vNax9pNGazdcDKsMcg3de+S4xiS+qe0MxZZSMl
	vGW3gqNhyS55ji/pCMAVR2z//2zHYLcTkFZYbHq6hPC2p7bQRKM+eMU3cZviZdyl
	8PO0oL4ptL0iSXyD2bwQVzw0HuoPE49Qwd+viLkHSUiLKPkfd/kcruVpscZH8Op1
	HB4G1HJfAfBI9Io4GPP4OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768583765; x=
	1768670165; bh=eFNf4lo7EqcCKcrnp2XpjeP9DnyqcaeXkBk7c4UZBGw=; b=X
	kYlwhDVWYH7cmWTY98rJdRGYMBclvNrlMxh3gJUKIZmG8cgbEH/kpHJ5FcY9yt6B
	cNrfFCX645J2vzv2pJzevUX7eT9f2+ctXjwpHaVzMMHtq+X7XUcr8HTwWOi1ussX
	PKk05BthK54XSl4LAMDizFQk4OzIcQ8AhDGrf5ZxG/3VwEYF0YWOUPBGzx0AgQyI
	GMmMWAw4r08h7HaiolpsnyQDWY7ZIn3vxypH7HrviCIUVJevAXymLeQ3hZkelwvd
	f+U7jv569gVk5l/z0GY+xhD3fmkLw5Yc0j4/UX9zim0CvZOBw+N/RJBJrIZiAG71
	tSezEi8+0fYLwvmXn6FXA==
X-ME-Sender: <xms:VHJqac0tKq8thI8nVxG3nCf3QozpMLgb11la3QkCpk75Nx-1fFRSTg>
    <xme:VHJqad-URJT1LUO5gu7GFWijro6D_CD9j958xKW8oPKr2QzWylcu9nBq7urX10Dp3
    brZdsw2rncFrLNk1Kd13BlWp3NZsGhXGGJbrZgLAtX6MfVOtI1TZA>
X-ME-Received: <xmr:VHJqadNPmgH9E5iVmQHMzkY1UC7sMXh04SU9hlgathlRxyDZ0S2P2N8xqed7DQLQYStsxrWCmuzeqX0ibO0hITk2BG7s9YcZBpTMGpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VHJqaRe5kGijwfMsTRpF6kNQkb22xJycXPRVPcuMClqxlJ2hsxu4Vg>
    <xmx:VHJqacU1M1QZP5KV8VkZd4dPxAbJDZs-fi1EcIIOWlwo2YkOZ8AATw>
    <xmx:VHJqaZg8tUc9Hu0rPGm_8zORTyDwdCVBb9fw5KlwSezeVsAZVctPag>
    <xmx:VHJqab-k9F7ou3UB0PXClz5ZZJm0Vyr1VCDXUY6aWOJ3WvoqFB12wA>
    <xmx:VXJqaWobWbwc9SSv5v0FCfVL_0t_e6QmrexOizVEQ5jnLD_xdyUcuoFZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 12:16:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Toon Claes
 <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] last-modified: rewrite error message when more
 than one revision given
In-Reply-To: <aWnkJ_GpgbXBPwFp@pks.im> (Patrick Steinhardt's message of "Fri,
	16 Jan 2026 08:09:27 +0100")
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
	<20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>
	<aWd2SLrBQRBC1e2S@pks.im> <87jyxjjejz.fsf@iotcl.com>
	<aWjVWC71rFeTsHLP@pks.im>
	<ca6cfd7a-3392-46ce-99ab-3d93c9ce90dd@app.fastmail.com>
	<aWnkJ_GpgbXBPwFp@pks.im>
Date: Fri, 16 Jan 2026 09:16:03 -0800
Message-ID: <xmqq3445a370.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

>> Surprised that “revision” is a synonym for commit? Why is that?
>
> Because in my mind a revision can resolve to any object type.

Yup, in the early days of this mailing list (like in 2005 ;-), the
word "revision" was used more or less interchangeably with "object
name", but "a revision" was much more likely to refer to a commit
than "an object name".  The name of the file that implements one of
the more core-ish part of the system is "revision.c" and talks about
"revision traversal", which is mostly about following parent pointers
in commit DAG, but also follows into trees starting from commits.

> Also, it's confusing to conflate the way to name a commit with a commit
> itself. "HEAD~10" is a revision, but taken by itself it's not a commit.

I do not know about this.  If HEAD~10 does not resolve to anything,
it would not be a commit and it would not be a revision, either.

> It's not even clear whether it resolves, so it feels sensible to me to
> keep these two concepts separate from one another.
>
> Patrick
