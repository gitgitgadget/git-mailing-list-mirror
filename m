Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2F3A1E95
	for <git@vger.kernel.org>; Thu, 21 May 2026 23:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407599; cv=none; b=DQwQm/GVECw2wap3dFr+WKC0mYyTpRhBQZ8pJF13anqnZQMIByVEdnVNzLdVpNcrbFgRGsZvfWVGSyYX72b74TNZLYwmUnDTPkYw9ccezI7vfRnYBNeA/16aP7KVhLAg4n/KtP7gF2DTyn4dADBqchN6qVSMZnTauyNk3u8LF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407599; c=relaxed/simple;
	bh=FPhstGDinF/gFp3tGd4vYo2qimW5/lkjunpPgUzNfZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eXvsHRlt0pVGR27zm0HO0PwfuZ8lJhzn1ssj6je/Rn4Fjx4fOj9wBYrMbHOmT4dSj7tAsOSuRGR0U/lMwlP1SERO8XxZ8lXaYzylE5AFAa2rp9PQHypBnX09xxBxG8mpvzVaqRXLBiMwG7Cx5y1Dw23q8a+FfGRL4NXU1X9VlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TT+obGlR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCjbGMU5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TT+obGlR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCjbGMU5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B46FB14000A1;
	Thu, 21 May 2026 19:53:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 19:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779407588; x=1779493988; bh=ckV/XBxcp6
	G5VvSKBC5i8xIzzzJ0fjMUiop5tBlXC7w=; b=TT+obGlR9ZqDIq6xroD/2VnOQy
	TY8qdkMNpjPe5z9TaFXH5WOTfIn+ng4vwXz/7zK5YMhzoLlkdmti0br3V79sCmlD
	xzjoMlVHt2aEOnCdoJz5YKhNuOI5c0Hrb5yy+hlTtbbmBMYWn7q8WUcMnZ3wbR0n
	p1MTHQKJAW+S7bagVt7vXoNfOPwvaA/qgiH/c2Kh488Q2VboxfPvxuqMCZul2TyQ
	IlzQPnx+lGrJi57LGK52/4uTMnkS6W7Al2CgMMtIaZDjnc4qM0CqNActotmtCWkC
	Y7L8oVwwpKpJBSmKBvss+4STlnzcsIRt/xv9MBap4xGzz5jFhcD6pzsRMONw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779407588; x=1779493988; bh=ckV/XBxcp6G5VvSKBC5i8xIzzzJ0fjMUiop
	5tBlXC7w=; b=XCjbGMU5SN1Ks8u58jyW4R/W4tKkYNDRbljWoeSDVT7whikmNC6
	eUjM62/xmgZM6wYYL3KFypGJLgvzZ1YIzmOXqRP361874fBurwH7MRZeujH5Bcc5
	Y/dyPq7nIrNsTZioZ//0I5w39cpiHugFR8fYB3Mw+oRV1/daPo4s8t2pNDyeCkN6
	yzFTSzbEE+Y2W0RzubLSqfoOBWHiFx2KNZ+Tw3asZ0Rz4ASDxZuDWjx7XyHsq1dP
	GghDvaE4h01KdSN5UltOic4gCdohC7p9dz8kp0aIBMHBhv+j+xZmoYk92ETS3wRI
	qhTESprIRXW0ObzWQpbUQ+n8/PpcD2nwTNw==
X-ME-Sender: <xms:5JoPas4IfmGTyyKDwu02nARicF8wik9RbKnX6zQW8mjtPWH2wy2VPA>
    <xme:5JoPai2JB447s9TqfVNtNY2JucD9KO1BIkEfvQT2BhmyC2grUZvasdNVvanPvoywj
    zS2dHEtPwZH5ImTdCaHEBb9WiOdkWZca5Cju5AK2NTI4dJFhJrjtA>
X-ME-Received: <xmr:5JoPavsFcDu2wvE8U8PdS4Mgqvq6VokCQGPDsRyxYQeeOOkGx3NqaKI9kXkpRwJ1gXT05Ee_fimIaR1dtYQULXxH6RQK9lru9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprh
    grmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegs
    vghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmrghr
    tghnrghrtgesghhmrghilhdrtghomhdprhgtphhtthhopehhrghrrghlughnohhrughgrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:5JoPag7EFzMIticVggTCOwVzaLn73in7p_JQUqyhXSZgiQEJahkc2Q>
    <xmx:5JoPajcKMsWNNX8rBTpt_sLFp19uwwUQZnGaYmGUkKV9xcLAQMn3ig>
    <xmx:5JoPalyq-3-Io7PpX2ZFtEzY6gM6O59sc3k-5Yo_wbzQbKZ78-UbXA>
    <xmx:5JoPag9qrOFU9zNf9Sslr4P3ts-VUD5UOrhW3pTDLtycubWnzcSiMw>
    <xmx:5JoPamBHfw-TuRClFTmeMJJJiR7F0ukHF21Wxor0I5kELEH4XhDB53r0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 19:53:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud <marcnarc@gmail.com>,
  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v11] checkout: extend --track with a "fetch" mode to
 refresh start-point
In-Reply-To: <01526f43-86aa-466f-a1e8-054284e1a2e1@gmail.com> (Phillip Wood's
	message of "Thu, 21 May 2026 15:06:35 +0100")
References: <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
	<pull.2281.v11.git.git.1779177508772.gitgitgadget@gmail.com>
	<xmqq1pf77kml.fsf@gitster.g>
	<b8932b27-8006-4b43-b7e5-1fac0fbf42c7@gmail.com>
	<xmqqtss02a2o.fsf@gitster.g>
	<01526f43-86aa-466f-a1e8-054284e1a2e1@gmail.com>
Date: Fri, 22 May 2026 08:53:07 +0900
Message-ID: <xmqqzf1sxqu4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:
> Don't we want to avoid creating a branch with an ambiguous upstream so 
> that a subsequent "git pull" works though? Looking at 
> branch.c:setup_tracking() it seems to reject upstream branches that 
> match more than one remote.

Yes.  We may try to avoid creating misconfigured branches in the
first place, but we'd want to make sure other parts of the system
that consumes existing branches to behave as sensible as possible,
no?

Thanks.
