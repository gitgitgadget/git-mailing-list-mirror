Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130128690
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829147; cv=none; b=eBD3g6w4j2IgZIbz+fY6vFamUFUL7jUl91dUTZnlv9PCn3GprkkdBYgyzdU/pTwsKodMcZ+Xhlb6PUUSKSbLFiCSxUQ7rjCpjv4k7QdC2oH/NerzkLAybFWNuaTw3LPUTpHwnvz3h07uZ7I9n2nEDDcvuvvWvBZKcASu0UChP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829147; c=relaxed/simple;
	bh=8wt/Af9RSGKLYTXhDFUN05vnEKW1368NsQ20Q0HnUAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u1BcIR93MmaAhEq/mZm6Y6V2PrHD/G8y4YPJo25dp2fsCPsKb3OCGlAfSsPuGu72cNybXAxsjDeWIZSE5PsemXIqAmapXoelkdy3L7gT6WI7gfbBcLwBiy/63IJY3+50Uawq5ZeNphoqt/+xINAh1H6dj8nCsrJkHwXoSslg4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gzcsqFVU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cdRVccc7; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gzcsqFVU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cdRVccc7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 133B0EC054D;
	Wed, 11 Feb 2026 11:59:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 11 Feb 2026 11:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770829146; x=1770915546; bh=8wt/Af9RSG
	KLYTXhDFUN05vnEKW1368NsQ20Q0HnUAA=; b=gzcsqFVUncNErHHBl3BrTHWBP5
	eHedbpmxUCh5hd+hutNj3T5hk+LPJMt2P0qDjlF+kAalx5kiDqDhlUcQjb1JcANP
	yRZIxDs/fUqTl3rpiJH2og9Be/nuYhjQroWi/ePVnx0fXYZ673kK0ogHzmQy9wHX
	4umK8FXilxraYxlweLWGm/JoNCJl2uNbwznEC+aUa6yztqM7H5TQVhYJ//0Liko2
	f2s79uPQeT2DEyDgzDprqNIWkv5T4aYbUVuxxyOEdHron1VZKY4lmCcJVQAA2zTS
	dYQ/Zii4e7VJaDZ3gFkWG1ofC8l2Lxhe+MHyZrwdas1kBtNkE3kE5X9G6OAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770829146; x=1770915546; bh=8wt/Af9RSGKLYTXhDFUN05vnEKW1368NsQ2
	0Q0HnUAA=; b=cdRVccc79oEiD7VjH/wKvA1HsXq82x4uG+4Ca2Kp7IXfKzcOIp1
	0ScpmNqm9N0Rv3MFZp3iPQ42OKPWiTn7wZKdw8nso7QTNAICPsKqQ1rSe80u0wdb
	X3vChDpMQDnz1UbwK3RJPQeTugWj4j486LSPclBl8iWvrsH+ya6JbGSoV2qZi7Zb
	vGEfEWzOyYPlWZuz0fmOFXpTe1/cc20g0uJ7Xi3nnv/AiVp/5ymca3B/F3ODiMu7
	rgZrIXnZB2r1lgrHsZgsrM3WWFklQviZTrgNKS09xT7Qigy++U5fTYNRT4kLt85K
	0aCihis0URZt53R9TvUXbmWENOmrNgVAQQA==
X-ME-Sender: <xms:WbWMaQ_bWZKK3poRPLLEIIWbSXGCRryAt1sZFAPDZQTQx_eWgbyCBA>
    <xme:WbWMaXy6To3ZKsTwKf9ZthyQJNS4uq1Zy2tZT7c0f0FufRI-PQzSTYFw3eWiZc5L1
    6k8yVoZhXLj9x30Ynzr3PO8wrJc7eoNQc3jOJqc2mMGCPa34rDByA>
X-ME-Received: <xmr:WbWMacOM7etBgH54p0AN0IhGDggW0uq6aul6GE1A6Ra0WR5JgaXXJthUCPSDTkkL8NT9cI5euEoB4HZ5mjJSQtA2NO7ZMwmknQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegthhhrih
    hsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtoh
    holhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:WbWMac8-STO3AEXW57PQQGSFkGgE0cMHAaNxaIRSyy17FYbs9NXj3A>
    <xmx:WbWMaZ5GsDWKF3r-2qS6JahB17mIHsaR-I1zLSPVPbDVrOVFl1-qsw>
    <xmx:WbWMaS4D4Dld8d7uzQQuWG6AnLh35aPmx22yisyCO3QMiBUKI1Lcuw>
    <xmx:WbWMaSr_ZzyHA9e2OpEb6QoqdrTJ0-zwrzqgVF77Envkx6EXy2hTQg>
    <xmx:WrWMaR-Dvi7YlvAO_wsL-wrmAudhtW3daHUmX-l392FUgecpaoekyTX7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 11:59:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Taylor Blau <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,
  Elijah Newren <newren@gmail.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH 8/9] promisor-remote: keep advertised filter in memory
In-Reply-To: <aYxslPnqyKP-mgcM@pks.im> (Patrick Steinhardt's message of "Wed,
	11 Feb 2026 12:48:36 +0100")
References: <20251223111113.47473-1-christian.couder@gmail.com>
	<20251223111113.47473-9-christian.couder@gmail.com>
	<aV4v9WhL95Gcqr2t@pks.im>
	<CAP8UFD1za=FowTWBqjanyRFANKBsc-+LOcbSsuBzjeiK8T_fkw@mail.gmail.com>
	<aYxslPnqyKP-mgcM@pks.im>
Date: Wed, 11 Feb 2026 08:59:04 -0800
Message-ID: <xmqqwm0jush3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Another alternative would be `accepted_filters` to stress the fact that
> it's not the complete list of filters. I'd be happy with either though.

So advertised is a superset, from which we chose some and becomes accepted?
Sounds very logical to me.

;-)
