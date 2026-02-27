Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4D2C2349
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212069; cv=none; b=ZCwCyOAHT4mcOq4NRzqbT9rW8h48vqk/znxJGah9P/FKYULfWA8yugs1PaAhvPU4IUjO/+5UfTtJAdlqFcFEnfnGGlRoZ2C0suDEYRovpH/KEATBQ2MgmVgUtyJAD03dcy8VtP1aYdmuKh4WAsBZh4HnVjeeAyWQhDX4tkJ4nYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212069; c=relaxed/simple;
	bh=qD1H/x5Jjwd+x4v4AABbCYD6JIfowILsdULw/lz/kCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gZmF7NK3uJivc+d1W0r2UN5MFrx0J/L5TzJOTZ0pa4nYEg49qqZBU1Eq/c1jKWF3FQxHRB7a8BUxYRQrvbB+MZzaa6vQR8iOi2HE5R/5686mOEPqWJKfEs0nOo5sVH4qduoPtwrhs+6e18bAHJkzPQH564t6Wxnd6hJhETCho1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qWE3nZfM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zdge6rh1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qWE3nZfM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zdge6rh1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6097A14000F4;
	Fri, 27 Feb 2026 12:07:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 27 Feb 2026 12:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772212067; x=1772298467; bh=CShyREZMcQ
	E1JkhLDfJwEOJ/4fVRf3vlDnAD5WTa3sE=; b=qWE3nZfMOF5Dlo3AkUPu7h8CGp
	oItuLeSmky7h5y/dy1Z65gDN+CEUPAcClEkYEV2pWe0j8phiGqAIJrZWD1bGv65l
	B9VzabFovLb1gmuPfhzM/bZhHSLHgnIcHPwHsq1U3tOzJSZ6DcXmPFrH0ya24jHR
	GS7g5Aa2yXY+7wsQsaL+9b5T4uVKdsErC0yHRIoTHn/KoUXGLaEqBEwOlqQE3JWU
	DxA7VzJqIYBJsWIVnkOHMLsBhKVwL2H6Oq8GiyNA432/AOQRY+ttkCtFSyUo245l
	ZhsRyrPC5dhIO3UA3AImYlRWg+J5eWUQkh6sE7cwe7aCytaoeytpWM1IvPUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772212067; x=1772298467; bh=CShyREZMcQE1JkhLDfJwEOJ/4fVRf3vlDnA
	D5WTa3sE=; b=Zdge6rh1rWuEIyJZ4QDVG9GUrxq7KWWMij0l9Im6Z58h0k03/5Y
	+wkYvrIzQlhP/7y7UcyEeG4SqDe+s/5QmDdZfTC4FuIWKDkge0cVxUpDrqAzPqKW
	BgxplR0kHIgg819YTWj2q6oMzY3M6VufFPybaxO0w8e40LQYmMQSTfxkCG+MqMSy
	avKCrmokecDRyG7yRkSHt9AUDvA9c3J1iVhHM932w4i8RUBkbMcHLGkuVlzj5YDc
	vSj9Fl6KUfKGASq8mp+/eQ94hdRF1cVPk/xkbjyXYXnkCFKaveaPuj25tqrwMqti
	BIiR74z8C3DmXO1lr6xMump5Puh77YNrqOQ==
X-ME-Sender: <xms:Y8-had-KH5VgjhqJZ9cbAeRrXa0VXqJXDlQYr9Z9Fg24jqdQ_Iz6TQ>
    <xme:Y8-haYlh81cW0rtATBV2m6Qp0VVI7R9RCVEI9eF9epuA615Z8lOn21pPgA9RTlnxL
    84tWnDslACejd54eWKW8XelW0WHhOgz4u7xk6Q9KeJlRv3Fm4PKqA>
X-ME-Received: <xmr:Y8-haTUwoHfNlhC5ixFGXXB6L22Eg1KvCovqjZ8X5nwdKzvykZlVzr7jUMz51vVA4MW7hd34hR9uHqXus-DE51e5NwbTNqA_5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohephihorghnnhdrvhgrlhgvrhhisegtvggrrd
    hfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Y8-hadFOAcfobsecM6vID9Fec6NWWLx3DfAbrcYUi_Gh0UsgH8Poqw>
    <xmx:Y8-hafcRIARSo6tTTxlc9DnKnGzWHy2NTJ17atMyCS7MTtdgDYT2AQ>
    <xmx:Y8-haeLpe1fJVB8v8S53ZkspVb9t5fn5XoN89E0wJSumFIcn6PREvw>
    <xmx:Y8-haUHpdIIP1bqM33OsUx5SIEppXGRiB5wex3dmhnX1xSUpkNGJ3w>
    <xmx:Y8-haSh6l0DYt5w1Oq-XWgfvuSln64Qx3ihrVUSnRq4YVbzukuJClsDs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 12:07:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Yoann Valeri
 <yoann.valeri@cea.fr>
Subject: Re: [PATCH v2 2/2] branch: add a no-prefix option
In-Reply-To: <0fbdf031cb9f054e023d44fd3eb3315732d527c0.1772207333.git.gitgitgadget@gmail.com>
	(VALERI Yoann via GitGitGadget's message of "Fri, 27 Feb 2026 15:48:53
	+0000")
References: <pull.2202.git.git.1771574833967.gitgitgadget@gmail.com>
	<pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
	<0fbdf031cb9f054e023d44fd3eb3315732d527c0.1772207333.git.gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 09:07:45 -0800
Message-ID: <xmqqtsv2ru72.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: VALERI Yoann <yoann.valeri@cea.fr>
>
> This patch adds a '--no-prefix' option to 'git branch' to selectively
> override the 'branch.addCurrentBranchAsPrefix' configuration parameter.
> Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
> ---

That is unusual in multiple ways.

The usual way to do so is to give a command line option that is
usable without needing any configuration.  This happens first in
early patches in a series.

And then, assuming that the command line option is widely supported
as useful (but cumbersome to specify every time), help the users by
adding a configuration variable, that can be overridden via the
command line option.  That happens next in later patches in a
series.

And in order to help users discover these two features more easily,
it is customery to give them very similar names.  In other words,
adding "--[no-]prefix-current-branch-name" may be more
understandable if it is added in patch [1/2], if we want to make the
matching configuration "branch.addCurrentBranchAsPrefix" in patch
[2/2].

Even better, have you considered leaving the door open for _others_
to come up with better ideas _later_ by making it extensible, e.g.,

    --no-name-prefix
    --name-prefix=<token>

where the initial implementation the only supported <token> is
"current" (to signal "current branch name")?  That would mean that
the corresponding configuration variable would also be a string, not
a boolean, e.g., "branch.namePrefix = current".

Perhaps those who work with more than one remotes want to give their
branches meant to be pushed to remote A with prefix A- while naming
the branches meant to be pushed to remote B with prefix B-, or
something, that is not based on the current branch but something
else (e.g., @{push} in this hypothetical example).  I am not saying
that you should add such a support to the feature in this series
(quite honestly, I am not convinced at all if prefixing with the
current branch name is even something worth adding myself), but we
do not want to end up with millions of branch.add${Foo}AsPrefix with
different values of ${Foo} when we discover that such prefixing
scheme is useful in the future.

Thanks.

