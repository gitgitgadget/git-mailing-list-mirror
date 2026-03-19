Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724DC282F1D
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897405; cv=none; b=D/JuTlymRbNnVJ/Abx0sqscEDCwgbVd0HUS+18hMbCiAAdzne2TEcNArRGw++EQLV1/jS7QhB1z0qokv5P1ilj8u2T4wdU4/JIa23FV4ORTioMi9xV9NGySnUm/2ER6sTebIn4l21wFlsKbUTsdLizwMzBBa6LdbqSXzuDbZ15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897405; c=relaxed/simple;
	bh=FHilfVpEWE4OTeFjWP9fRQ0yRcCzYy3YW3h6rfrXSYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GDjAhTOXg3mpKtfSv96RLasmGyatMmODUS73Tu0CuB+o8yVW2guTU/bYLDpr0Xdjewi/qTHmaqnoA8Lt+F3Q+pTvjye2UB8HXx31lObFNNseOEwBa7oILCuiCNfp5GNIWKQKeERZEnPgsV3sfjByFVfotdG3M/NYipNNI0hhnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lhEBNWXB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uc32/0aY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lhEBNWXB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uc32/0aY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E3E4EC0260;
	Thu, 19 Mar 2026 01:16:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 01:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773897402; x=1773983802; bh=g9xg/s+UoE
	lxamKWSb3+7Ni72LkL6CgNWBVndunYSsU=; b=lhEBNWXBSHc6Bb89ddSfVHguHb
	dsMg/likyrqpFRER/LYv3Jwn4a1kMDDY29xxFoOYhU2KJOa5SziA8PVV8YW4dzwD
	sBBAWfC9sqVsU4f7Rve4ndqjEkd8EdsqJzeaNwEoo+VKvekO6pacLj8aQGmxKTu7
	MZYI2mI1oPCA9KHg+77ygmGr4UK+2F7mUJS8IX2cY+s2NKegbvQuU02A/hpFIEns
	fkbvoHCCjmHXiAc15hAgcXl6HyCrQJGfMLy74XH+S2DFpcgGR11CLmogu+QoOnWG
	wUDKBYOB9FuJEkf797XuVdyzlX4ako9jDv1Pxr4PCqZ+bOmBAcjPnDDg58XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773897402; x=1773983802; bh=g9xg/s+UoElxamKWSb3+7Ni72LkL6CgNWBV
	ndunYSsU=; b=Uc32/0aYcy3CTSo0X0TysYTPSsZqqsjjTcUe0Nl0hYtKkm11A0G
	aZ58R7Wd7orDf6e3Rua5TzBqPX4wdEzycGgtjQx2wwYkST3u7HsTw2OpbC+zVd31
	MNkcRhVSVo0I94gB3IeLW/vrFHZuXfF0nYn/si+YpugD/TwDZDXst+n6keJ5lYBr
	9+QcnI7JLTfreH89SGNRgIp4AC+NS34UYJhNkBCyPH7WuQpp1FxHYCutlU8JXwIy
	yBZHaPmyQP8J9PP4kz+RD/niwBEVCjxf2R554AMV8pEqr7IgqVjQn2RZbqnUDdcA
	eTJKWnzxmNm3LggucqAy3D++iSw/aBqe4nQ==
X-ME-Sender: <xms:uoa7ab1lOWxCI-M4AKK4fL2yuU47w7N2FcntYVBKmm5rZ_5ymXAa_Q>
    <xme:uoa7aRHgQrkaYbmOOsVTD3Aq3P06HQ361aVI6sHNlfbtm1ZRLcHApxtFyfm5q89-x
    m6h3rnYcdIkr5ci5q4f8eCdLunFJ7C8QKxRi53xWjLdFDvkWbtt>
X-ME-Received: <xmr:uoa7aQ67XrKp5bQgM57Td5x1zUFV8LbilKiQJjlKjZ13PEeZnrvPJiOxq-CosY5fO9buN3pn01e7Pf5Nw9n2t9EXN25NeztQZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrug
    hunhhlrghpsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uoa7aftGbHylWU0o3EFSP5bje2lGcUY3lWhbS7zv5DEhdPxPc_cLnw>
    <xmx:uoa7aZ7whAiEPey1qkgjT-Rql5CMOsvraxbR68g5VU8u_HT8aZOJvA>
    <xmx:uoa7aSW1BjVY_gFddqDfquu2SowEQGEXcQVEoo085Hg3nXr2ITTHag>
    <xmx:uoa7aT9yoTZBFkHl3kAddtxrPjaJSCCfQn8IgEPkTVVEIWByfjiYhQ>
    <xmx:uoa7aVCS3WG4XT7PuCJWSBqWbLAPs7HYq_CZ3Dn89qrmw7oTjfpVhYTt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 01:16:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: git grep failure?
In-Reply-To: <2c943182-d5d7-4f72-ab97-8d07bf4ed216@infradead.org> (Randy
	Dunlap's message of "Wed, 18 Mar 2026 21:42:23 -0700")
References: <7bbcda60-dad4-41d4-b994-c19f83f37e2f@infradead.org>
	<20260319003829.GA3530301@coredump.intra.peff.net>
	<2c943182-d5d7-4f72-ab97-8d07bf4ed216@infradead.org>
Date: Wed, 18 Mar 2026 22:16:40 -0700
Message-ID: <xmqq7br8o0uf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> On 3/18/26 5:38 PM, Jeff King wrote:
>> On Wed, Mar 18, 2026 at 04:28:17PM -0700, Randy Dunlap wrote:
>> 
>>> If I apply the patch at
>>> https://lore.kernel.org/linux-doc/c5bb61cf789df1ecb32facc29df9749987c7ddfc.1773346620.git.ljs@kernel.org/
>>>
>>> Subject: [PATCH 02/15] mm: add documentation for the mmap_prepare file operation callback
>>>
>>> to the Linux kernel tree (e.g., linux-next-20260316), it applies cleanly.
>>>
>>> I noticed a typo in the patch ("struct vma_area_desc" should be
>>> "struct vm_area_desc"). When I run
>>> $ git grep vma_area_desc
>>> the output is empty.
>>>
>>> Is this expected? (but not by me :)
>> 
>> I applied the patch and git-grep does produce one line of output (the
>> instance added by the patch).
>> 
>> Two possible differences:
>> 
>>   - are you sure the patch application succeeded?
>
> 'git apply filename.patch' succeeded AFAICT. git status shows one
> untracked file (the one that is added by the patch).
> Do I need to do 'git commit' also?

"git apply filename.patch" or "git apply --index filename.patch"?
The former will leave the new file unknown to "git", so "git grep"
would not look into it.

>>   - are you in a different subdirectory? By default git-grep narrows its
>>     search to your current working directory and its subdirectories. So
>>     if you are in arch/ or something, it would not find the result in
>>     Documentation/. You can do:
>> 
>>       git grep vma_area_desc :/
>> 
>>     to search from the root of the project.
>
> I'm running 'git grep' from the top-level directory of the
> kernel source tree.
>
> thanks.
