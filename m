Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB52C236D
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422884; cv=none; b=MfgNSoaTekc1e9Vt6XJWS8yBJG5fA2qFwdXerm5co66/lToh2/Qgx5Dbua+p0G2NcLMkVCE0Tq0NigOcUAkNMdcTfZnwDYQQI23Cago7rbXe70J8x5gM/GAwgE7jbvR+v7LJ2vOWwC8hHMs2OJqzspEt0yptrBCb0tSeYamgs7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422884; c=relaxed/simple;
	bh=y/U4yBpe929q62lFVyG7PMxBYmVF6Ctcc88p+C/WoeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c5ARlWI2+lbN7lAyoQwqihg5BZLxgVAGKN0mV8ccmy6hi/L0Di9k32xdqHrI4uwBj6RxXy0cngfg2qgjorDWmfuKhLcpdPySkTniYqB6T8gsY/4ZXv7X/qtJ5fMq0+io4i0NBsAOUn5csnmynOxxXuKQ2RgmMNLgq3pRmQUv2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WAeipVn/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+GmMPF3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WAeipVn/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+GmMPF3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A50AF7A0155;
	Thu, 28 Aug 2025 19:14:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 28 Aug 2025 19:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756422881; x=1756509281; bh=tTBUgC9NYA
	HrOiGIVOyKgU8iFy/RSRZvO59LKlUawQc=; b=WAeipVn/1dxQ61w4qS2x4mFRN1
	O7tGelsoF7IwQXpKu5s5QmARWLpUL7H+YOpZJz4MpL7ETYLAWxwzeD06Jpc3+2CS
	FyIz5msLOc7V+r9nIRuvxnE4m0mfL32LizwQONX6OY7/Je8AiJo3I9FEQBhVuYw/
	D2YKvYi8X/IQtHSSsficB/ghc1zqOxuRPdMzGOhnl+cgZA/F6Zi41ltk6wQFoGuD
	xmVNOB1bnAGD6bQ05ltWbZ3/uiLuiRPAGareV+dsi8WTUNhIRL+9L0a1vIWeVQfS
	P5o0TgF19cvjXGLyouFve+N/x7QQyKm95S0IPBGLbs2suapgQTr3y3/sujvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756422881; x=1756509281; bh=tTBUgC9NYAHrOiGIVOyKgU8iFy/RSRZvO59
	LKlUawQc=; b=U+GmMPF3kwplAEfoGqXL4KPfbm2shkOzgs2GCtMw+kXUVeulXrj
	Jc1BhKyBFJKO1oxfobcdi9n0R7dr1bo369rPjbqV8Hhnm5+cq056fUETtUAnbymR
	fiLnHp8uaOES6FN73I94mrWSJtaY1kADMhEMFwnOjvddFyvrmdn20jnrrh7bokKE
	AA1UAda444D3lexgP4zTqDB8QVOfKxAheOflgQ1FKGww6D0qod+hEjnG2/MjxVDP
	0KFiHVrpfIxX8KF9FEkLBDwrfelYklehKRXe2CyOcfEf4lIqgU5EhcFhYzJorjiu
	bWhqq/zXhB3kDL55+buh7RhJmqxpwBLrusg==
X-ME-Sender: <xms:4eKwaJ7jAaK8mWYLt0aPV73cE_psJzEm8a4vrQuw5E_y7ZqupLQaKg>
    <xme:4eKwaBfs3_S0vcM3FkIlHYEX0u2nyGbhBpYX9kvw2ISW592HjhmXHHA-7DlFWNp1q
    BNfHlCPjgDAnhotCQ>
X-ME-Received: <xmr:4eKwaNA9yOH53I2fHfnoF9tdLIDOhWIIFCpsWDW0r5rHB5gmr0SIyLJ19D5qQL-FDnZyF6rb00rEzf477_n5DP184qR4zYOsXXsSiRM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4eKwaE9nzBLfOn51A5kfiSBXCCasIt9Tni-yGEojhR8gEKLm5-o8_g>
    <xmx:4eKwaIJEQ7NgNmtrXJVzOKMH7WbfaGmEGyHecyJZb9GKblr2NeQHCQ>
    <xmx:4eKwaNgK9C77e2CT_95ZX0P2JpmsGKv1SSymo5-flVZZQgxh7ikqtw>
    <xmx:4eKwaI6U86lVIQejM0-C_1gkSf2vdeGTi0QmnijqcYv_wW6yHXahsg>
    <xmx:4eKwaJrP0Mnpe7Zl1vfXiUv5dwCbYC2m8RyAHGQqI8AnjWS1q2LmmRIg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 19:14:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Aug 2025, #09; Wed, 20)
In-Reply-To: <aKbFNq_pLasQGjbc@pks.im> (Patrick Steinhardt's message of "Thu,
	21 Aug 2025 09:05:26 +0200")
References: <xmqqo6s97e3t.fsf@gitster.g> <aKbFNq_pLasQGjbc@pks.im>
Date: Thu, 28 Aug 2025 16:14:39 -0700
Message-ID: <xmqq4itrrqcg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> * ps/object-store-midx-dedup-info (2025-08-11) 11 commits
>>  - midx: compute paths via their source
>>  - midx: stop duplicating info redundant with its owning source
>>  - midx: write multi-pack indices via their source
>>  - midx: load multi-pack indices via their source
>>  - midx: drop redundant `struct repository` parameter
>>  - odb: simplify calling `link_alt_odb_entry()`
>>  - odb: return newly created in-memory sources
>>  - odb: consistently use "dir" to refer to alternate's directory
>>  - odb: allow `odb_find_source()` to fail
>>  - odb: store locality in object database sources
>>  - Merge branch 'ps/object-store-midx' into ps/object-store-midx-dedup-info
>> 
>>  Further code clean-up for multi-pack-index code paths.
>> 
>>  Will merge to 'next'?
>>  source: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
>
> There's still an outstanding question for Stolee [1] regarding the
> `--object-dir` option of git-multi-pack-index(1). It would be nice to
> give him a copule of days more to chime in. I've Cc'd him now.
>
> [1]: <aJUn0qeliNQ/nnWr@nand.local>

Then let me give a gentle ping here...
