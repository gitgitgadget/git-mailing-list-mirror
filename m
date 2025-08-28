Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B9F2E1C78
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414907; cv=none; b=koKi9j2XurrC3gQeloDTiMLI6kwup4tW1AtGpIrnhfuJ7troApOGFKuPNGHH41a6z9clkemc+/vKzmJ2zzk7JzaQh9S9Z8KoRtyeAoepQ1ae5wBv6ssUKs9OyxBr/MZ6gnrNW76WlScAbVFFn9ztLMG70e+dwCUJJ5CpI2sJhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414907; c=relaxed/simple;
	bh=sFR37T80JPSO6T1Tml/lupfSiBYLw4OAs1Zfcbb7phk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PRTKWb5HDNy0/6BQCZRQMtKm7coQb2rLB7u9fDpL6ChfAYvMnatC+KsctueWipUuD3EL4/EBPwFz8xQLsRX7njwFo6q2KhoCeLPIOH9lcE7c4HcqjU/PxqcN1XMRNQT4Q5RRCRU6UIfA8h+8+eJ9h1nvkaim8Y90VKxuLibkcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A172zqL2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BoqymbS/; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A172zqL2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BoqymbS/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CD5D51D00022;
	Thu, 28 Aug 2025 17:01:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 28 Aug 2025 17:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756414904; x=1756501304; bh=sFR37T80JP
	SO6T1Tml/lupfSiBYLw4OAs1Zfcbb7phk=; b=A172zqL2JSJlpvOoz1lnCB3+5u
	VUNr8Zt4sBeKxsei9PKKfr4P59LejbhOEhxiwON/gPPmC5WAO/CsfmIb+MdacLVJ
	D1OwcwThhfiH+BadND13ro9fJBEarBI65jXWPEYYniPP6mtWjauOoK2+IHTw33ab
	uEfG+XsvbpMiD03mlxraODTUufJTevUQowxbl+6ws3KhB0TcnZRiU2Kg8n9tdZqf
	yct9tlWcgFZWvyOkz0bzv0BsXueaPArSJhHVzDIpp2lTe5azjO61eXjBgW57MUWj
	vYGvTttV4NjIq/DzAlF2boiBRzJP8gI6pbawypWYW/MK3W9153PabeQhRnKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756414904; x=1756501304; bh=sFR37T80JPSO6T1Tml/lupfSiBYLw4OAs1Z
	fcbb7phk=; b=BoqymbS/d6j4wvSNeKkmjLze0XFtd+IfCArNPfR7FEBO3I59qa9
	ec6c2Tx88xJWxWbltN11ifR+4ePLGCTtzSXiKobBtjSCNajwrUGUL2H1OKoW81gt
	wDQPRH3FRssDYf6tQOQL6/b5cbZs92JKFrBClXjinDnSPLlSj16PlzLQ4V+kv0Ha
	2BrssM8x6VKXGOjlkoWG11pYvifRklzWtl8cwanjNgl0YT8MXKUoc2G84IAjVFGE
	eKBo0HaVCj3j0fssj7v7t69kC5jhrZyFaT8TMm6K8xyvIBNDeSttP3eEVt7sCjqw
	RBaGMsuqz13KEICaN348+PqL1yZhtGDS9fg==
X-ME-Sender: <xms:uMOwaAXaNB_4SA1n9rOLtdnbOETQAi640ESiNXAJ0dHyI9FiRp7WIA>
    <xme:uMOwaAHlD7uJb4HtNLTLmiH7QPhfD9CrpN7fwAvUiwQhLqlL3TL39R7Pr_ijVvn6-
    SK1PlnCl1okcYHxQw>
X-ME-Received: <xmr:uMOwaK2REG4Y2Y183VOQ5kxxYBbFXzpr1m8L6H4M5X2_evHKnVJgNjSe-PtHs1xNja8UVpkmZx1D0q7ZrC03xGZaNnG06DSPnO95Tko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uMOwaKMxgUbJ4X-1QoGOoPH9GeB8TkTTwWuA2LxWiatO_X6N4xU5Kg>
    <xmx:uMOwaB7u2jd-joyucb7C0Qu6UvU4EC8cKfLMmG2g46BwlLC4DQKHiQ>
    <xmx:uMOwaM2eB1guQTvlfip_upZZsSjKTQPwkR0aaVVGaQxbJAJ137Kn9Q>
    <xmx:uMOwaKwMWHb59VbT0DlQzDVDZoNvLjALzvgDgt2fKCxHt4xJ2wB1wQ>
    <xmx:uMOwaIJm7lMul7EXjiXt9n4Tj-BI5rwXJBR813Qor7n1MOLx8CZWW2Ab>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 17:01:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/5] midx-write: reenable signed comparison errors
In-Reply-To: <eb1abdca32c64cdabbc92008bf318c7ed67b2c1f.1756402795.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Thu, 28 Aug 2025
	17:39:55 +0000")
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<eb1abdca32c64cdabbc92008bf318c7ed67b2c1f.1756402795.git.gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 14:01:42 -0700
Message-ID: <xmqqo6rztb2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The strategy here involves defining the variable within the for loop
> syntax to make sure we use the appropriate bitness for the loop
> sentinel. This matters in at least one method where the variable was
> compared to uint32_t in some loops and size_t in others.

Sounds like a fine way to avoid accidentally breaking these loops.

