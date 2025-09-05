Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A244C9D
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083167; cv=none; b=p2aJTvQ9BI/WqwibcD5UF0AESd8FTUS86B3EapHW4DOeVjKjL13RY0KMDol0LxdObIxLZsAwhQKQQnz/CVU346kQ2u2PQKdbhpIQWrju4BC7x/T0V0+/iYrWENhJa8ys5zOlu0W+Us1tbVpICDit5gmq2vLO8RSLIYXLv9VF1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083167; c=relaxed/simple;
	bh=BiK0c278qOOh1usJ6TaOiKLiuEjyFWqeQ/Jgwvyy2ZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l09aYjgxlb8Y1utGSkDSTJF1SCQBamfcbFQDz4vfhrCPD6Q5T1LmImccg9g/ymt1nga6THzDHP6+QNXI3ytGFegv5SnHDFSJf75GwdCbwffYM8jlQXR1jPwstlOoFqV3lQ10hTbk0hqE4AJyfHbpj+Y4BwsYnW+iJBsY3TTjTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YIETXGgu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lqYBqF2h; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YIETXGgu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lqYBqF2h"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE4D5140030A;
	Fri,  5 Sep 2025 10:39:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 05 Sep 2025 10:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757083164;
	 x=1757169564; bh=0gyk3zo2LGPPGfJLirprRbSyEQORTqExOKS52KQoad4=; b=
	YIETXGgukGXFHGTEEG69DfeGa48TMQM9EbkJERzItl/LY9ZGIhuF6FXeW+r4jtKK
	9/sRrrsNuqtLyxCRglR31fw6EDqbyf3s7m9gu1fdgdmesFqEN5jAVzhvHGU/DR6s
	DlrFsFfo0No+PXsUZV4ayYBFRGgLAXcyqjbphge2CB0Fo6Hpa5A1GM84SPEY0jdC
	yjB5L1yKKYM7tPcenc3EgHL8nJrqfJdmI2cbjy/w1v1NDb2CNkbHHDWb2ToF4yIm
	KxDwYN0d5d3cjF2dJsJrZ6DrRai+rtN4y8yZ+9we3rAx4RQwsQVQozbbphHewUN7
	9wafObyMGu2IjWNLYKcJlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757083164; x=
	1757169564; bh=0gyk3zo2LGPPGfJLirprRbSyEQORTqExOKS52KQoad4=; b=l
	qYBqF2hjO3BMhQFZw4BuCd3WhYsxpiiGWSDx63SQUacMmr1DwVJLytPtHlKh7cLw
	l8dTp6l1V+JkvM03em3dgj/j/W1pSfylAJ9aOC9dPSVh7j50bPSJOJe090PaPSMN
	UizVQOFTD8yfVMfjqESay6wasDEeefnj7k2IH9HEviKtkMQPCLvhvKO8d0mqxkpZ
	5R8MrngYR6vsY6QjU7S04gtFW4CGKWXRO6QOyKHt9ABCnEF28Ji3//GUWsauN4e6
	mzNmgoPbvp5whq5oa8PydmUIzQV4SbcRZv8L1G//5ksmZuAJgcYafXKMsHgY1haa
	I//t3dnEOOEjA335Y8zUQ==
X-ME-Sender: <xms:HPa6aC84sxbTeRnf1oXinR3f3CQAJlqtyPzX4rvM9xQb4dSNVMlQew>
    <xme:HPa6aOO4L9-Nvu6OXMhjI0_gKQ5yxaLNlX8hGKrMYjHq1JfkGZmyvFix3WSoddVlL
    2eRSu4btd620sOLoQ>
X-ME-Received: <xmr:HPa6aOfUUriIMvzsBG4J6lM-oAANzcpkP0dpUpEiwFAVJy3Dasd_XSoSUCs5OQePkNAadMOfcCZnAw4Xln1CaxuJ5KqO4Ly0g7kJmHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeludehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnohhurhgrvghllhhmsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HPa6aFXtlbIh9lnbn_U40UqBbVAgKrJoErM5e5qyWB9Iqb-nc9CiYg>
    <xmx:HPa6aOjEaEHIMRV1Vkb-CxedDY2TXLxIiFzLhoT1TKY03uCV3ElbpA>
    <xmx:HPa6aM-OnQbYB1uxzk3ZmIZywThw3jIju8_iXFF6ctfyI025WNqLWQ>
    <xmx:HPa6aIYJqX-CBXHoaStF6HNlAOOHfM4Qv0efdQfMmtCnJXOEo2wABQ>
    <xmx:HPa6aCIQwBNeXHp3uoQodcSxlpCASlF3zzNwMaeKtcGgoR9MvBtceAdP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 10:39:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?44OO44Km44Op?= | Flare <nouraellm@gmail.com>
Cc: Jeff King <peff@peff.net>,  =?utf-8?B?44OO44Km44Op?= | Flare via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
In-Reply-To: <88ae6c7b-0a69-48bd-9e73-672331a22197@gmail.com>
 (=?utf-8?B?IuODjuOCpuODqQ==?= |
	Flare"'s message of "Fri, 5 Sep 2025 02:25:55 +0200")
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
	<pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
	<20250904204932.GD30633@coredump.intra.peff.net>
	<xmqqjz2d7t2q.fsf@gitster.g>
	<52fb3fea-4842-4532-8572-df41537da5f9@gmail.com>
	<88ae6c7b-0a69-48bd-9e73-672331a22197@gmail.com>
Date: Fri, 05 Sep 2025 07:39:23 -0700
Message-ID: <xmqqecsl55gk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

ノウラ | Flare <nouraellm@gmail.com> writes:

> By *s I am referring to *s_ so a sanity check with: if (!*s_) return;

Because we

	s = *s_;

upfront, exactly because we do want the code to segfault if the
caller passes NULL to the function (so s_ that is NULL will cause a
NULL dereference right there), after that happens checking the NULL
ness of s and *s_ is equivalent.

And the whole point of doing "s = *s_" upfront is because readers
can easily get confused when they have to deal with double pointers.
The only reason why we pass the address of the pointer variable is
so that we can assign NULL to it at the very end, and before we can
do so, we want to be able inspect the innards of alloc_state object.
By dereferencing s_ early into s, the code can work with the object
itself without having to worry about following double pointer, so
even though if (!*s_) and if (!s) may be equivalent, writing the
latter is more in line with the whole reason why we have a variable
's' that is separate from 's_'.
