Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89F1DE3AB
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741469387; cv=none; b=JN5AwwJNOTt0hY73IrocGrZy1ZhOKs9Xr2dbCvHmv3qmCR6l4RbzrEY8ck/BUnFJNS35hqCyJCYrhyvMcCYthXekiUJB727h8V4jjxm0M7dm2HWvA1DTjKrdWg/ZmnExPkz1A9/tZ6cqUnNt6d4oRC6zEPPkukAsxhFHkPPh3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741469387; c=relaxed/simple;
	bh=jxaptlUlvxd1Z3zWbO/KJQMua9HvftagSs0g1xxpjxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DKknl2uzROzMPzVjUgQjx3wgACLyfZ61xFA+P4ghhDVQNVTEAkw/YKjR/gqTrWu5KPwXf2lciqydGYNbXM6GQrL5CQ0Wb410Gqu8N9SJnWWImK+z1JrgjNzsyRsGzGq3lOvPHF7FtCNsfvsTAnG8Z6LrURk5BNKUXcU9KMjKHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AW/ZUts7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5DkOsg7r; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AW/ZUts7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5DkOsg7r"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 804441380F0A;
	Sat,  8 Mar 2025 16:29:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 08 Mar 2025 16:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741469384; x=1741555784; bh=AEHs+w86Xc
	sZAGaDgGATOqMqfbUE2C6vp4VS/XHGh8g=; b=AW/ZUts7ntk2nolKo+8LkjO0pB
	751tQn8e7/ze0wd/XfWyy0krtqeNAABTaBOCdeLdC7sD+eT3FzXEeHguzV3jnGSL
	LnHNNyTQ3RI6z3GDgFP71HO3KL2tVcTGylEpoaD6L0w9zKCtYzKEvlDCsrR76D0b
	27psZ+y45R0JJdaVFBN4UrGRxPngUgogkGxWQcsIarktVFxhbwdixv2853CkKHC4
	GNo1fJv2X10anqgBud9LJm4l5wYoY9cXEzNYzaVjDQIzp3r4t3XfiLXF0of2xiUy
	HHuq+jkRlMQBRXi1ErLAmYOGIq1DU0zIUz7/rE60GNgSQ24RHCAV+EN5kCUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741469384; x=1741555784; bh=AEHs+w86XcsZAGaDgGATOqMqfbUE2C6vp4V
	S/XHGh8g=; b=5DkOsg7rYZzp0miNFoitgQWSUwYYS8IRtypbaR4vec2S9CYrQci
	mgqSFeAWTCDFDY62JAc+8XkFjn3OfelDEEIQaY1bZiLLOcP3ZaOBVxdRjjMplRJj
	QDFBgQQ+IDceyAMDRBjzZCJ0nTmRl2pQkwDxW/YXjav5sfwcAXcj1aDlxcgTYvmP
	cRAQhn2YDgM54qAEsGjj9mRgnfRYp2cpTGEvnEnluVow4QCcoNMGXlmKcOSVPjIw
	LEGqggau5GzTEnQKlViN9Z5lPWNsFSSmEh2AueHeJcW0mulImLeWr27OlCqnDwcd
	ScUb21un50NCjilEbo9QrgXTpopCrhYBFOA==
X-ME-Sender: <xms:yLbMZx3kqD1nuBRU1KRjz6J1dh73Jb4zse24Dm8H_OPXI-cPH2W7hQ>
    <xme:yLbMZ4FKjbb7MbCaa5mO0xL8UJ-EDTPF4YGbfxIxDHKptmH0qKbCto9XhUol_ykLt
    DTVYiiWonrLpsif3Q>
X-ME-Received: <xmr:yLbMZx73ZC_4n9oniXxX5rcsPO1zYxQ6vMcJToXddpUTwp5XpjWXma5UHXFn1ekroePJiZFZXt6iZG-9pSdEQuAq_e93qXa4mPW2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudegieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhimhgrhh
    gvnhgurhgrtdeltdegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrhigrthhhvggv
    rhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:yLbMZ-2Xjfzwj5lx7UmtQHM36F5EN1TbaHeQGVeYXWwMXqN_r6VmUw>
    <xmx:yLbMZ0FiiI-dOfE0ruJENBJy83p1M1DY3pTtoqzwCmu5ov1b-4vccQ>
    <xmx:yLbMZ__XKhhG9H8CV5PKCQfUHtesiOpms-0H2mdS88FQAbOdabQA8Q>
    <xmx:yLbMZxmj_ntuVmtFf0wmq0B1Gxo1y4M5cEp1QoYMs2cd-DSzZLk53A>
    <xmx:yLbMZwgcrpGdQEmA89w815LjCHpALK6eQGo7-MNNjTCMjNBJdI2inInt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Mar 2025 16:29:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mahendra Dani <danimahendra0904@gmail.com>
Cc: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC] Microproject: Updating Documentation
In-Reply-To: <CABGrwBDLO9=FCjUW_LfJ_RZ95bRXWHFFNvdJfOuiYocGXdj3Mg@mail.gmail.com>
	(Mahendra Dani's message of "Sat, 8 Mar 2025 23:03:45 +0530")
References: <CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYFSY8xFs5eKSRVkA@mail.gmail.com>
	<CABGrwBDLO9=FCjUW_LfJ_RZ95bRXWHFFNvdJfOuiYocGXdj3Mg@mail.gmail.com>
Date: Sat, 08 Mar 2025 13:29:42 -0800
Message-ID: <xmqqo6ybb48p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mahendra Dani <danimahendra0904@gmail.com> writes:

> I'd suggest trying to submit a microproject listed in [1]. Further,
> please go through the General Microproject Information[2] and
> MyFirstContribution[3].

All good suggestions, but we also welcome students who try to
scratch their own itch, as long as it is small enough to be suitable
as a microproject material.  And it is fine to ask if doing X
qualifies as a microproject or if it is too involved.

The primary objective for a micro-project is to get used to the
workflow, i.e. working with the community mainly via this mailing
list, how you explain your changes in your proposed commit log
message, how to work with those who gave you reviews, how your
updated submission should look like, etc., etc.  Given that, it is
rare that anything is too trivial as a microproject material, but
you would not want to choose something too involved, as it would
slow you down in learning the procedure, which is the main focus on
the microproject period.

Another thing I noticed in the original message that is worth
reacting is that you do not need to ask for permission to start
working on anything around here.  "Am I allowed to do X for my
microproject" is not the question you want to ask; rather "I see
document X says A, B, and C, but A is outdated and I think it is
better to phrase it like D.  Would it be a suitable microproject
material?" is something we can work with. Answers may depend on the
nature of A, B, C, and D and would range from "nah, A is fine and D
is not better because ...; don't do it" to "great, yes A may have
been suitable a decade ago, but no longer relevant, and D would be a
great addition", to "Yeah, I agree that A is not great, but D is not
all that better, how about E?", to "Yes that is a great suggestion,
but wouldn't it may be a bit too much as a microproject".

To solicit such productive reaction from others, you'd need to be a
bit more specific than "I see flaws and want to improve".

Thanks, and good luck with your microproject selection.
