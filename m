Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AE2DC763
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059438; cv=none; b=T+ZKyUl56O5fFsM6G6e1B+KRAfKQOjy/vFGrQd0oamnkJLUDzA8WYtSuxlfpFwL6tbKFywB1TsMcNw2Woi6m5i7W65Xv6wlFfY2tIfDw3xb3JmUGHuPsbmGMKIfMvbLY+nRofK3JLg9yn1FTOnoX7rwRG84j/JViNyYYFIA4Dzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059438; c=relaxed/simple;
	bh=Jy97xbBvzqr1HCW19AGQ8DUNKgQa83dGWG7vCz9X4B8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CSmob6Dj9l3Rq5pHa2KR6sENAwzv8wdFxngEcvbJV7To6X5X+nOXF+cG6kdJ5xWGivHlg5JZ2JE4UX+uCt4pjrIvSUDNBdJ/a1MgQH1R2wLpaUxyEbYaxiGiI0OB/7YS3wzjIqwBoer8CElzxzCJ3CsV1wcS6dX2N4LJ6L3GKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DclvvPzN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Di2MOfMj; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DclvvPzN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Di2MOfMj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 194147A0130;
	Mon,  2 Feb 2026 14:10:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 02 Feb 2026 14:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770059435; x=1770145835; bh=Jy97xbBvzq
	r1HCW19AGQ8DUNKgQa83dGWG7vCz9X4B8=; b=DclvvPzNHwqznkSoC6fm2bUwP4
	S/YHdnWhR8flg0HaATcxn8WazwDngj1BHbPHZlBRfXT5uX8w5qIzXNPzY/4i9CMh
	xx0i67LdkWtnGb5fO37a96OFEdIjEvS9Bb1H97cEWJjyUmvvM7wR2tZJZLubiBdP
	3diZoIZWyyyBBWYt+XoLglRfBlO+gy1D6hvf7UBV+kod1O9TjIUaIiZ0jqKBx/ha
	3MBKOedwNgi4CJUOQ12Aii6QLEKmA1vYotgsE5WBfdC0rB+3xxL/3bVwRRa+oYsW
	ayQY9FOcSHKYKnP/7+DtpEQ1QhDBNvYibt6KC87A6DXtzDKqNtHukuAWPZZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770059435; x=1770145835; bh=Jy97xbBvzqr1HCW19AGQ8DUNKgQa83dGWG7
	vCz9X4B8=; b=Di2MOfMj4y3lT5PKumEfBYBDY2lJlyp0Ls2KbC41SztbmyYEWZL
	5xBH2zJ429cd7JNT5HZxGdwtaSjDP98eGQkMTt9h/mQ73OqhiAy9DtzjL9/qqRBI
	ZzpE01NUkQoekZq2QQuApfBl0bIsYuCfWD9iht41ik8xo8F5w+Ez7pCIOlEcZY+v
	zF8cbxJ8OkB+qr4xPvD6rU8xHiV8qNmlrbcxWPwwTUJyt4fypeSvSOtSuLp6Fhhi
	DUA77tSxFHZ+vKq4o53eolWxhsZvJhBRhga/wJfUGxKzuFKi9E4yPhZ0K5MSP4HT
	EZeZiSJiZcl4uG4ewIVt9ugAcbWdVT+LCNQ==
X-ME-Sender: <xms:q_aAaRUHlHCDaX1c2Ue0CnICTYiVOReylZXVUOvoR6kBsoS8SXSSYw>
    <xme:q_aAaYmi7g2uXB2BTU3CJ1pY5Hd858k1fFKzQVrLMpI8sQVKSjmS-FFi4OIo6uOr1
    tMhWUBeyew5FZmTKXghTcib322Sv6NH_XrXIyx9zFn68NbGgRZLew>
X-ME-Received: <xmr:q_aAaSZY2GaBkdneiaKn_e2WdFVdc5-CIpmO8ykRTpO0blhhgZWHIaYlDA6CI40Va6mSFr4dd96A_mIC6R5Xrqii0rtqN7WbXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehpuhhshhhkrghrkhhumhgrrhhsihhnghhhudeljedtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q_aAaTO6dzlOGxmCvV3BWRsaQQzW3lpQ2YCwEEH2f-JbHpJ787ZhDQ>
    <xmx:q_aAaXZPiZcIMddDlY1g2Wc9nmBXNMboGmRYdWdaPt9XVchZiuxQ4g>
    <xmx:q_aAaR0nOcbCURZ4ecMHRnUor8iiCpyhYXNBpP8x2IcGqSWGd0aw3Q>
    <xmx:q_aAadfIIHzZqgKuJCUM19iit89VSSegY8xAxPYFNgQay8dDnfxJRg>
    <xmx:q_aAabK2lU8L5WOx7D6M7dEFYrbuU9BmXNjLzUcuEpHgVA4y1ZYdBHRs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:10:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3] subtree: validate --prefix against commit in split
In-Reply-To: <7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
	(Josh Steadmon's message of "Mon, 2 Feb 2026 10:54:13 -0800")
References: <xmqqh5smdejc.fsf@gitster.g>
	<20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
	<7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
Date: Mon, 02 Feb 2026 11:10:33 -0800
Message-ID: <xmqqwm0vx8pi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> Unfortunately, it seems this patch breaks the subtree tests. We noticed
> a failure in our build system at $WORK, and I was able to bisect the
> failure to this commit:
>
> $ git bisect start 54b18a3513eed9ed5ced5c238ade55a434fd619a 66b2238f5c17644ddf15f75a53c76faeca6d9f1e
> $ git bisect run sh -c 'make && make -C contrib/subtree && make -C contrib/subtree test'
>
> The tests fail on case 17 - split requires path given by option --prefix
> must exist.

Thanks for a quick regression report while it is still in 'next', so
that we can revert it out of 'next' without breaking the 'master'.
