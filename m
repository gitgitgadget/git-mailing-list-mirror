Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DDB357D0A
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283428; cv=none; b=As20FnGK/6AotpA9Ndf8c8eBemd9t9yVJppypHeJTB+hQEcNKAG/QKeLunpdyAOIS8qhcc4ZvMqGSrRD6xi9OopLQ8KV+LyxJb10uQWoQ8SHE5Go2v2mF6/ANWNu90rcJOv+ZyfGbYETEb2eFRjH+cF3Xl2Tr4APKXXuG1LzyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283428; c=relaxed/simple;
	bh=MjQWg6d7gb2Ij7nrRvcYeHcyArzL98DWBII3xvLMl/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTqhwADzRlH3tlNrdZIa9Jx90i3aIuvjAIR0mVusUdxNlR6r7patHYI4To+/1oPOnvJ/+KVwVRMlzbnJhzJgr/hCHkKyh9Vcr9oaIjXj6k0JHjWlT4jo8MnwbwTged9dDRovEDhNqtjUWrIkny5M8JKGOegnsyKSCYvweuMw5Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jgqwZHWE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xl/wAzU8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jgqwZHWE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xl/wAzU8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2C42E1400160;
	Thu, 20 Aug 2026 23:37:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 20 Aug 2026 23:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787283425; x=1787369825; bh=ZXjcfqjL1N
	xEQBaWa6hiNYEXN60k77LZ6ztMj8v/txY=; b=jgqwZHWEzgvsjBPr2/RUZBfTm4
	Hnq4D0g8G3XMf4o/iBqWYvugeIjqwlgAm/YYYpaRz/a72TaXd6oYoPsBXiZM3KA3
	WumWBeAAwzJ14rdU0U+qTQocnEd7Eb7AiRBoLg5FdHwfMb8duZ5dezp2BgOIZNc9
	WdzXfItkCJJMpRASHX3CT+8hizuYz4384LDRlOfRYzql/QY2cAyZUaxBF20OxJr+
	sUCoDJ9/mHjRrYbxcqwV096psW9QRScBex9VXbuyZYkkF0VSeus4cVdkwvHkLCM2
	1G2a0HTbPrKrfpCVuy5VFXjgJDORspk9mvyGZRiELto2M81XcBkdZ8lXfCUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787283425; x=1787369825; bh=ZXjcfqjL1NxEQBaWa6hiNYEXN60k77LZ6zt
	Mj8v/txY=; b=Xl/wAzU8BUZPl751U2Sy+PQKntvoZJtpIPooWIpMSFdtDLFTDbV
	p7eJ//zRfqfMvX2RyfKfIWgwzTz5c5Gr6Skpn0ift1Cg5Qt+E/J/JBDr6wq4QbV4
	afvOYkRYXG5+d74olsQzqZk4rDGmPkacnBaFzskhfKIgUW17Axw9W8pnSPRsBzOW
	A0kDjvn4V/kkMwwjml/zKZJcWufPNVLuIDjbjSWrGHGSswZI7uCvtdoAXjneFLJu
	a3sVc6QFPl0+eKOEK192G9LYUQaSj5Et1gMTY++ROmKV8Hg8K0N41hr92NoUS8CQ
	/rwoTZ1ZnJCetK76Z9vQYz3aD5+SEA3Myzg==
X-ME-Sender: <xms:4ceHap8QXVK0pVOkYMecVNQAHRyVwf-OtsbjJiveYoW3xMGVNavvEw>
    <xme:4ceHakuuUUZigCy_NrSzSUi__zGclvE-2EVOngz2rQLbgNqDIf4KdGzTSklt_7u3u
    fjwxYfc54whILFcu7ifPqAO_XU_2IYRsxWI7-gLhEhlBh41alTrTl0>
X-ME-Received: <xmr:4ceHasClbHjHBGNOKF4qlliA-a6q_NzIn44y1MREc-wogpikM6BcrfTizEMD0i7S9-fd0ls-uINqLMrsP967r2WH948Yg5h1ig>
X-ME-Proxy-Cause: dmFkZTGuOmnksgIc2DRFSP6elsxpv9CA4g7b4fvit1SoFjkVafcFcxhwqDwCasUJuwLIDG
    PPdHRwqjgqcqx63QDFnjhX1iN380Jc+y1LoAmkL5+g7vCB7mxTpm3eDhFZFal4MVnGum7f
    8SaBf95+qSvY4GFXx1CsXj4gMiispr0zezXLqaV8AOn2IjxEL+RwbiG/RNBc+MgVAuoig9
    bNcB7lZ9x/lc924cs0MEVKFy7nvdrZFtkHfX6XCtNWK55OoeUO8Hl3BRG8zERPD1sOBX+q
    On3z7quhF+/UYUV6kLB41TROxoTbRSwbyG4+A06FU2ua5I0tTHvma1oeZVZNJfZQ40xzQD
    Hs4i7VAjt9YetuXBnU/Z77sFyPLV8F4SEeqvMa+LF1BqJzBAIvGIynBCWLpJ07+4hWd7cb
    GjmwDHfMkLTN24Bme8ixbPOQUIgpG6hRVBBOggY7YKoHuRwf0pCxxUUvZbpCszmBhXhyVT
    3qgFxnz9Blk8/RancF/xxZJwL6E7n1frDdWRvf1RQ6hfrPrt7/loKAVBAEQFr5LZ1YltE8
    OJGtAB9JSHCJz2G58/O90eVDkfsejyimT93RbwqR3bAJxOjzog1hZ8x3Ns0Pu17S9bw1cH
    RaeX1+pWeOuGsn0frQhWsPff7plYMjYcqFFuWb4PCdwJgDtgTODvpYpQ+nkQ
X-ME-Proxy: <xmx:4ceHasUgTQlkgKhaIyJ8BPg2xNmOLVp-FbuEcyDJd-3_sutmq7oo8A>
    <xmx:4ceHaqAnJfrklU6v37u-9qrpkSS8ro6JtgoZzSQTtHoEGe0rkkkUFw>
    <xmx:4ceHav_sgXkI_FRoKjrVZCKQm2Bij3i1y4tvm2jwVs4suNOEMsXVbw>
    <xmx:4ceHahEWPpzVYWRyoLe4yIR5qT9YeT5cTH2TkUh8cTy_DEUA2kqrBw>
    <xmx:4ceHavh7cB1eXT6QSWxkgY-LxMpwaYYNCT0315u23PirKz_iVjestB44>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 23:37:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/2] replay: fail gracefully when a merge input is
 unreadable
In-Reply-To: <CABPp-BGFpLi+FEoJOXvT=wBtexXiDmJ9vXQfc5JnBDrUk+zbDA@mail.gmail.com>
	(Elijah Newren's message of "Thu, 20 Aug 2026 18:44:05 -0700")
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<321af575e0a9e0c22c70c1809f6fbf0265b05d4c.1787092446.git.gitgitgadget@gmail.com>
	<xmqqfr0augls.fsf@gitster.g>
	<CABPp-BGFpLi+FEoJOXvT=wBtexXiDmJ9vXQfc5JnBDrUk+zbDA@mail.gmail.com>
Date: Thu, 20 Aug 2026 20:37:03 -0700
Message-ID: <xmqqh5korvog.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> > +             # Ensure replay gracefully handles the missing object
>> > +             test_must_fail git replay --onto onto base..side 2>err &&
>> > +             test_grep ! "[Ss]egmentation" err &&
>> > +             test_grep "Could not read\|collecting merge info failed" err
>>
>> "test_must_fail" means "the tested command must fail voluntarily and
>> in a controlled way", so a segfaulting git-replay invocation would
>> not pass test_must_fail.  Hence, there is no need to separately
>> test "test_grep ! '[sS]egmentation'".
>
> Oops, you're right.
>
> You said on 2/2 that I don't need to rebase because you're putting
> together an evil merge.  Do you want me to resubmit with this line
> removed (without changing the series' base), or would you rather I
> avoid that to prevent merging work for you?

I can remove that line myself, or you can resubmit on the same base.
The evil-merge machinery uses the usual 3-way merge, so I do not
think removal of that "test_grep !" line would break it either way.

Thanks.
