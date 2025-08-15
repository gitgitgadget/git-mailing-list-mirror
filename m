Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52C188000
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272757; cv=none; b=UQP32IBREeWsDRsuZfTlzuG8a824vfOUNp5VFf+ghce37az1kJWcc5Gc4kPLvolnI2yErzlOG4E6I+TjKWswDTjVVKEi/h+QjDT0AWnnqoGrXTpRxdYgoMJTGUvAy1bn9kkAzsJbai7qHPRZzJ2fBMBseohqrWBfhOnNN2+4w5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272757; c=relaxed/simple;
	bh=NR3RZYFBq/Jlvd1cL0yPl0ZQrutm0aeQsTIjeMIFmyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MBESXz/pK7hiQAAuWcsMgcyjfL+1kefUMvwyJ1cWWRPlAvL7uYQRBxwtdJyporCCDnh9GQU35fAvxBqVkgMPezVRY5pbJkbB5e2oZQBDIylHQ28bIFQrf8DKk2yVjD7LV2yVnzJFIEc35MuSY+d/IKOIblbQ+LY1v8zFZagUVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FmvgSClD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=geRgFcNN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FmvgSClD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="geRgFcNN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3E0A7A0186;
	Fri, 15 Aug 2025 11:45:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 15 Aug 2025 11:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755272754; x=1755359154; bh=/q+0gAK024
	A/GzGtdlKxp1lXNy5LPE21qNXqxWC9wZg=; b=FmvgSClDDwKp2vQ43VtelLLvw6
	QI7RbAhezSz5L7J3EyoZvimVUJddywujg67147T3RldDinzVGKCI5WMNqQvGue8E
	rF1HSxDJzROlCsaug+jnUgniH7riSX3MqNWFoAv+Y6F5yefm0yi5ly7AYa/+GOZz
	MIww90qUO7cCBnE6Nr5OV/eLMIJCxiWfUwxw8mBT22tmEA2HElTL7qUAoUffqsU6
	O+J4eusbw+5oh265SUJfAQ5EI0XgwHGoEb98H3Mh+prbDMO/Bxzfkf+v4vkTJxaB
	s4ybKgCTNw11HfRnr+7eJsvAtbFkK1IpW4g3VfSz3xEXEj/5wGbjYinOJ9hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755272754; x=1755359154; bh=/q+0gAK024A/GzGtdlKxp1lXNy5LPE21qNX
	qxWC9wZg=; b=geRgFcNNbS/AINU/b08ZXfcniTSqDJNZzn5mlXiTD8ZCPCiq+a9
	MbhM84KiKct8/5mnatODORZ326+dniC28Qd67UGC/0/Daf8vJlQ8+9c+lVlUk68N
	JthljQ5yCnd+p5PoXeogk7bFUEOrY1AsMRK8gs7MGdhlb/vsR2zn7QSD2LZU7UZ9
	30gLKrWHoku95bWRbkVJrTAYWKaecsi6mxPdGwheHVtzfZ9WdSYmV+CXfllwBlaQ
	VJguK9OUMfQt5fvlqAG1KI1RxxW3lj4oBgjj0TAblbU832lTPBxkv9xM1w9SCrAz
	hxMLcUxWK5FLtpgxQJGAU55mQDhW1PH/Bkw==
X-ME-Sender: <xms:MVafaCJ833V3H3c_83Sw4Y840OSqSLIlXbMcUa_9UmTgc2dyhuHjjg>
    <xme:MVafaEyWhmbnv91bj1jhIIBlgfeWGc3kL85tz_0UdHzPys0gHCaElRdeif573h1TR
    y3pRQOlAoMn1IQLOQ>
X-ME-Received: <xmr:MVafaIv8BxoZsBOC_SBLW5nI7ok3dyDjP3D3taTwXIZ9qjUjbgfO69SlUBJfNY4olhkLKHgEOvlyKY1phUY-ZeZunHZXfhfhDqB-aa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:MVafaHBldmXugOMrDH2UrnEIQtAzFD5w_9p-UhQxvM5Nmgde4Z3Sqw>
    <xmx:MVafaKG3l620Dy002VBeUD6eP7LlWXQL_9xkZCuTr0Jg_taSHKveuQ>
    <xmx:MVafaHAOppLvgIAnufMN6N15ysnwuwKe4Zu01nPGCRQrd4aE6se7Kw>
    <xmx:MVafaAnHYUHQXbNXGlJMnRAGCjClDWVFm9Km9IMMwWxBwif4Vxt-NA>
    <xmx:MlafaByYgEbzByRGd1AqcNOLPCknJRqMZvSolVkuEs6dmLn8dNeM8BCF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 11:45:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Julia Evans <julia@jvns.ca>,  phillip.wood@dunelm.org.uk,  Julia Evans
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v6 0/5] doc: git-rebase: clarify DESCRIPTION section
In-Reply-To: <c9a4d7ef-8cdf-4d5b-b0af-f43ffc6b7450@gmail.com> (Phillip Wood's
	message of "Fri, 15 Aug 2025 11:25:13 +0100")
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
	<pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
	<52504ef0-7d4c-4298-af11-10477673e9d0@gmail.com>
	<aa1c2758-79f9-47f6-87d4-16b19fa5bd63@app.fastmail.com>
	<xmqq5xepzjnu.fsf@gitster.g>
	<c9a4d7ef-8cdf-4d5b-b0af-f43ffc6b7450@gmail.com>
Date: Fri, 15 Aug 2025 08:45:51 -0700
Message-ID: <xmqqa540twpc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Although the cherry-pick detection happens inside "git log" that
> command has a fast step (find the commits on both sides of the merge
> base) and a slow step (detect cherry-picks) so I think it depends
> where one draws the step boundaries. The cherry-pick detection is
> known to be slow when there are a lot of new upstream commits which
> was the motivation for adding --reapply-cherry-picks in 0fcb4f6b62
> (rebase --merge: optionally skip upstreamed commits, 2020-04-11)

Correct, in the description of "reapply-cherry-picks", it may need
to be discussed to guide the readers decide when to use the option.

But would it really help understanding of readers to give such level
of detail in "here is roughly how it works" description?  I am not
sure about that.


