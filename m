Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3A311978
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540324; cv=none; b=AA9HkHzXGxmruJ2mVXQx2VC1u40j73+aP/zTNkeL26A9NLtyNW2FyiUaBwRGX5Bvyt6KTtNRCeR6jMgcRtOydEcy7NzOeykyNsxZ2wdbt4unN/lAm1og4pxdq3oL692zHu41/TFdWHSryUfpxHwblgfvf9fAZASi+g88cFeIjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540324; c=relaxed/simple;
	bh=lnDuLsYtubQY5RkTZ5gb00MgtVjdoI12xRgidlPI2X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wk1y+u6jWKQeGWhfxNMS2smykkeNblt3ULxKMK6YCezXunSGK1RVhpklAXq4V2n5McD80IhnJb5srWaO/eT5B7zi+YMLsdwEUbZdpb9ps5vO0RhlQfYV2fYR+oPy/Mh4vpm9YNmTAy5y9RL1gIwvQB6EvYHt1Ue2z/l8I1EGV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vrFYZaRy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iZ+MLkNn; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vrFYZaRy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iZ+MLkNn"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B732A1400291;
	Wed, 10 Sep 2025 17:38:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 10 Sep 2025 17:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757540321; x=1757626721; bh=rNsC0RS7t2
	xuppr14ivfBsy3ZeZqMCT/O1thE94qywY=; b=vrFYZaRyxuw3eYdATNW0z074hP
	LkqRsiES18VBv+NyjuQQeEafoqwXGo0fk++80lIJ87OgxzD4IPASOYE+0oDIW0i+
	jO+tfTkwBzxyMdmhZF7CD5Wvqpduv70dPB6FFrqZ2sYg8wZCarC1DwJRvdOqqep1
	K6UwF+9FzCv7ZUvQw1zZl7F4cA5KBPoq8yn7ccoGrLqG4ZGrWh6mWt0bAk4UXazr
	3qjmEyr0mdBqPIP2XzxGJ6o9WPqimJPmfSf//sHLFd0EUZJ/Czf8/EDkK3OY7DqP
	e6Llc/qcgN7IZ0EyWpY18UkA4sZYA6J8nkva065UsGLI2/2gK1yaIueIbSZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757540321; x=1757626721; bh=rNsC0RS7t2xuppr14ivfBsy3ZeZqMCT/O1t
	hE94qywY=; b=iZ+MLkNnQFbv2LRGe9xg+nZURpLnaawl16cyj1J8hypBqk03nw2
	uzzozG1QT89yPiTA6vlboQ5B8ujR5bok74JdiOAYNUzpTvpg3Iz5tByB0QOFCeE1
	ir7g6e5fpTiBHwHMVe7HcGtn+3iTmNmQUbq7ytmqFnXdLSXGxRWHpxyRePmmnW48
	DYvf4k20BtGKDczCuezfbHzxepmi3gU8Dyz2GWv0CNmVC4jP3yWH+mMf0vaIuwpA
	WsXg2LXMoGfDTKfJuzLQVQ0MbIMl0VEC6d2DVb8uGg/95el2YS6IC/0jbb0xR/Xb
	a8IcXvNpR7CFgFDpEZs7YtJmjEriKBrpZog==
X-ME-Sender: <xms:4e_BaGcVCUxliWrfbgitOD5S3BwokqDcwz4m_3OFgLirt2_CbgzvRQ>
    <xme:4e_BaDevisouMXOCYo1YhYhanNNT5XDucQTwwrTM-PJMKGW-IKBqDLTqgoJ_5gQ7g
    LJ6caf7V4xk6wuWYQ>
X-ME-Received: <xmr:4e_BaA-I9vfolXMd8esFEOTvWUlgpZoK4GInLJfU-S8JbXPmXk4Z_6uqMjVWpRdnaWcRwer440JC0MQfzDr5dbLWyF1KSLvvcb7m-0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4e_BaPnjauxnjtymHXZtzDHBgVTp99aH7uQNVqgYmszhocuoMHX1oQ>
    <xmx:4e_BaC9IctSi8VAe_6Qb_sJdZhHuViZsWJWzHGtqJYiohsN7nHVi5Q>
    <xmx:4e_BaNn_qdxQBqSPPkT6xRDADrMjhMdIDDV4bupROBJzcVTwR99VeA>
    <xmx:4e_BaP2leR0fqDluBMlZ4KeC-mpduDsVyq5HmIk5K_fqryinHONIfQ>
    <xmx:4e_BaIGuJjJOYjjpBqNXGd5Z0oGMpW0CUEbFb6sFMGILUPzptDz0na75>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 17:38:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #03; Mon, 8)
In-Reply-To: <a70731d7-6886-4394-a0a9-0bfbad231a24@gmail.com> (Phillip Wood's
	message of "Wed, 10 Sep 2025 16:32:03 +0100")
References: <xmqqjz28v21e.fsf@gitster.g>
	<a70731d7-6886-4394-a0a9-0bfbad231a24@gmail.com>
Date: Wed, 10 Sep 2025 14:38:39 -0700
Message-ID: <xmqq4itaq97k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 09/09/2025 02:37, Junio C Hamano wrote:
>> * pw/3.0-default-initial-branch-to-main (2025-09-04) 4 commits
>>   - t0613: stop setting default initial branch
>>   - t9902: switch default branch name to main
>>   - t4013: switch default branch name to main
>>   - breaking-changes: switch default branch to main
>>   Declare that "git init" that is not otherwise configured uses
>>   'main' as the initial branch, not 'master', starting Git 3.0.
>>   Will merge to 'next'?
>>   source: <cover.1756992089.git.phillip.wood@dunelm.org.uk>
>
> I've just sent V3 with some small changes in response to the feedback
> on V2. c.f. <cover.1757518141.git.phillip.wood@dunelm.org.uk>
>
> Thanks
>
> Phillip

Thanks.  Took a look and replaced.
