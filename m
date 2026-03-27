Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C235DA44
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628900; cv=none; b=DD55Hzh03TDHvBW70gvjp3jJ2yiATn//i3SRexFgUEQkRKpcxwrdQEWIga6kN+e7Oaar7BA3hYs0k5+CXmc288AbDI5GCRlrRhqktVzrWHnpt3RFQi0PLWAElwtSqJGor/fzA1geCOE2RjKBdeY9N8/BvMaS4CARfw1X5RIpDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628900; c=relaxed/simple;
	bh=Ja16ZnBG2qnUIWnY/vP76jOIwmHcqqUgt2H2Ex0mXao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W6HtL8JnadQlci5MYec3PyV6xpx1a6doa6V49e8R3GGSwGvMJ2asZB0ZUrypeMRRbAmcV7Kp3S0QPH+EKNs48wl5RxOI+YVlF75Gq7q4tI3ypJmdvy+RhTs1frZG2EPCH7gHO21sdeTDqh/EMcGOJEqtC+8fQDb8gCOllBG44TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lioVGLon; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qg1JIZqe; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lioVGLon";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qg1JIZqe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F1A37A0231;
	Fri, 27 Mar 2026 12:28:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 27 Mar 2026 12:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774628898; x=1774715298; bh=YZ53abfYhW
	CTPO8cfpLiq3bW9jpLczcjybxzRr5mjRI=; b=lioVGLonTQVk9yCXjixenxUK7M
	tAtxjR/Hg+I0EhIa0YhUVLzMveIwad/PSicBdkjIh0X0apvdtWyCRY3iBtSl+rCb
	LtFpII+RVHs1WxKY0ozyUNAo8Ndkw/cisGOpg4rSdu5VP9OW4iWfedbgrO+8fH3x
	q7B/5r328aCGeLwKsVsI2QqhIAnTILrHKamLSR/e4n/u7UCdn1B47Xeoih0PzE1Q
	8agcWpVs8V/ins0ybPVMLnOreQUKamtEwsIy5LfOZPSkf1+cw31y/NVka1G8WrOW
	KcOm6YseNma3rd3eGO2EE19zl6Pv14LBSq10H2AU/FSn+vNvNBu8BcFoQFdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774628898; x=1774715298; bh=YZ53abfYhWCTPO8cfpLiq3bW9jpLczcjybx
	zRr5mjRI=; b=qg1JIZqel8jRHpuBQciLq6hzSGP4mDm0um7BW60OsTfAyWK07Sa
	7KXMxTXHd5qGbLTmPit3YR4xkgOIrwN5wA3RnXLlABEopOzySUt5gGRpRPfTTwrh
	EBgktI+ZGA8IiBW/zErpZdBxR96NYpWtdx92XkfFm+IvJtd8Gr3q+l/BSaR17PRG
	k5SQGG4rPWMMRtxIFbZIUNEOGoxaTpJ0+yl0V47t47kKMgnn4vrWGicynUlmh5Rm
	AcFyFOp/RU7TQyVndsPJXvB+SRI2Ephtrf7g+8K/whCKCH2Jv3Ty1NsDy06Ewb2z
	UG4zUUCDKbrheIz0108g0iOaZZvuXyKjUoQ==
X-ME-Sender: <xms:IrDGaUUSCf70DJY_ycusg-ImeMw5J5rwyntJXdZk6iaJStT3sMdfSA>
    <xme:IrDGaXrAS4yshlV2o_8NTtOsFnJCZJjqAV81a1AtK8TqFmUWasnSqeoUayCNh4vjn
    uv0e1vbCXlR1Qhyxt640pxenQRRLugJnLbs-y5lP3W3kBihpCOs>
X-ME-Received: <xmr:IrDGaelNM5sLzHaTMZm6nelSld9GIt9YUQMbirkFlhGH89uUL16lOSb3wZLyBAL28DqhwGIPongUA7GOvCSVfYrnOyG8OplSdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhgrhigvshhhuggrghgrleelsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IrDGaf2fjIK7DJT7mF-VM18nAXNEy7RXIsT5huc3UiRM23-E3fGP0g>
    <xmx:IrDGaTT7F_lVKoWbEyIpUMa8yLgj_FSLG9zz5G1VD8Aki4FwPiN15g>
    <xmx:IrDGaQyrjidRXqMLbkGgiDrMOoaU-6GNDKlGQmhe93Ysmi6NcMPvXA>
    <xmx:IrDGabDsPp9jJj5iBP1da05ZvbjsZ36d8jXZDOp1WIUD8624BouqcQ>
    <xmx:IrDGaS2Pa-3sOaDLbRAsrvE4qIyHDWg6ykTr9JKlyNgY-4oQA3AriWrF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:28:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Jayesh Daga <jayeshdaga99@gmail.com>
Subject: Re: [PATCH] read-cache: use index state repository for trace2 logging
In-Reply-To: <770465fe-c38f-45a9-b1b0-0ad682a35fab@gmail.com> (Derrick
	Stolee's message of "Fri, 27 Mar 2026 09:48:55 -0400")
References: <pull.2253.git.git.1774606086325.gitgitgadget@gmail.com>
	<770465fe-c38f-45a9-b1b0-0ad682a35fab@gmail.com>
Date: Fri, 27 Mar 2026 09:28:16 -0700
Message-ID: <xmqqqzp5kzj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 3/27/2026 6:08 AM, Jayesh Daga via GitGitGadget wrote:
>
>>     Robustness: The ternary fallback ensures we avoid potential NULL pointer
>>     dereferences while maintaining existing logging behavior in edge cases.
>
>> +	r = istate->repo ? istate->repo : the_repository;
>
> If I understand correctly, it is a bug if istate->repo is NULL.

Because INDEX_STATE_INIT(r) assigns the repository as the first
thing, I tend to agree.  A (bare) repository can lack the index
so repo->index might be NULL, but if you have an istate instance,
it should always know which repository it came from.

>> +	trace2_data_intmax("index", r, "read/version",
>>  			   istate->version);
>> -	trace2_data_intmax("index", the_repository, "read/cache_nr",
>> +	trace2_data_intmax("index", r, "read/cache_nr",
>>  			   istate->cache_nr);
>
> Other than that, this is a minor improvement in the right direction. I'd
> rather that it be more complete if you are working in this file.

;-)  Long timers always aim higher than posted patches.

> If you are already working in this space, then I recommend figuring out
> how much we can rely on istate->repo and then apply that knowledge to
> these cases as separate commits:
>
> 1. Replace the uses in the trace2 calls with istate->repo
>    and delete the TODO comments.
>
> 2. Replace the other uses of the_repository when an istate
>    exists already.

Excellent suggestion.
Thanks.

By the way, Jeyesh, do you really want to be known with a numbered
"jayesh0104" as your name?  These author identities are cast in
stone in commit objects and will stay with the project.

Also see Documentation/SubmittingPatches::[dco,real-name].

