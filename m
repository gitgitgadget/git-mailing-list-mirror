Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE02F1BD4F2
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768048; cv=none; b=XBNRrgYUYdi4nPqBaELr3s+T0jj2jR4m2HzwXHXhs1Aqs9Y8IzcoMfg+mto8+6lr22Xs5Bx7uS9Nez49K3YCS5g0e5UFHiikSt9AZOnbQYyzkqAOzU4CC/NsZSVKO3Teg1CWyp2kSxPl93932u56M1J3bkEpBJpkLaoc5PnVN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768048; c=relaxed/simple;
	bh=GfpFDHuvkzmr2mZ7pLelYruDRlpjn3+4kCpUKsVehtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tdJU7efCwhRl1Z7QjyvuoDsyqPqSMbk/yqQ8Wjbv6FqsePaJZlwPgj79syor/7KHpPaJBh/YBnhgOfFgEgqIM1I8K4nyrI+l7CbYxpr2MfekGfN75x4q6AgIOMMsKW1VjnWVIueTLIhfyjxwJG/j1lYQ4iC/Hu9VY5etzQcwmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m8jd1qIg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N4O/vReu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m8jd1qIg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N4O/vReu"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85A221141B42;
	Tue,  1 Oct 2024 03:34:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 01 Oct 2024 03:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727768044; x=1727854444; bh=FK54mNpErD
	qE7z4VdYBjt6wBnmFrcqhNQ4is6DUG3UE=; b=m8jd1qIg7RMvtQjRNGJ2wdMppd
	wsc0slPYyv4RPoDWWQppD/mtWGeAh6gGpj8jwIbRijXb/6fWkGEQk0Jj34YWV2yH
	TYfIuHFQgKn87GJA2hkjqNAPmtWWEgrzlWZSjyD7dyCNkkEsffZxUqe0LqX7swaE
	SARvQJcxM56kG0I1M0Dinn23CzNfFcP8SuhD7ZpWCpbbC0yvdQI7y4UqB573qdnD
	efVJGmm01koQYtwh37rbM7pCSUZIjZdC7nTgj368QrIS4gLJ2Pa31Q7rDUn5w+I0
	Drzam/yicnAxdUM4jJmaIGMOxqWS/EV1ZwVHI+t2Dd4nyvBSoobSzGOEX1tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727768044; x=1727854444; bh=FK54mNpErDqE7z4VdYBjt6wBnmFr
	cqhNQ4is6DUG3UE=; b=N4O/vReuciXirHmAADNC4lR2dSc7TyJVMvrNniZkMhM/
	4b7oUNufGNTV56vA1vqcvH0LLjX6LZK2c9ms9xJCnGm9IQinAEaA8lpLw2Hqh2Ce
	9yHvopwH8itZTbDWpACeC2j5Eoqm1larKRaazV2TljIBnZbCJ6oee/A2UCzXZAsd
	pA1DuKjhf6/+IS3+EYlHApH4YJOCRtXHTwMlLk8O7BoCr0rGqaHsxgsnZC+0FeJR
	l0CKgbRxLozP4fA1J/TqmmAJVBRntXrG2hqgcj2ImetQgeVvBGEBt4xlcK6UXnLx
	FJrzFjzQ94JYtmZLSFWBGvbFqg9mn60nKAIGxbmRyQ==
X-ME-Sender: <xms:7KX7Zo3Wge1_YjvdkFfW5GGdWv_p7qeWFFf4QCBfrzcvHXm2FtVOXA>
    <xme:7KX7ZjEk_R4gKVRwAhlyt8liyKHPUQmsnqx5-6LR9hFhnRkXeQkBSXSCkWf6iQ6KK
    vMp9OUo6uu7OIHF-A>
X-ME-Received: <xmr:7KX7Zg7H2HIri78_cSExNtPUeWkHn1UVKc7R4HsYSjkRgcZ1L-6aFd0J5LpbCWJ6pnAFbw0GthbDeX3QG8FZGVfJrTMTdwpCVOhgGO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvrggumhhonh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtph
    htthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7KX7Zh3B7pKCrFetkAeiQBXIj67uz9GHaUoYJeN18lo9pFb2QyxHEA>
    <xmx:7KX7ZrELKHp5YVel5GAfx25ugW5iHM3tpj3Y3Aaw5ozHCdxwYdwiOg>
    <xmx:7KX7Zq-coMNrf0XJ4CmZsQfF0cs50o3qyI5MRaG0kyHoIuPDFW5ESA>
    <xmx:7KX7ZgmCGT4XplnXuslelxHIDBipSl0EFoQ4BdDXyoS03v61oEwX3A>
    <xmx:7KX7ZhaPn4SQjOgxZjFOIxRteEOp9ece5J6M36_bwd7Rs7J3IAzHImtR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 03:34:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jeff King <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  James Liu <james@jamesliu.io>
Subject: Re: [PATCH v4 3/3] refs/reftable: reload locked stack when
 preparing transaction
In-Reply-To: <c4lz3begoplgde5iimvk4k7cufiyryntccqo46u3fy5qvqauv3@tta5wfg2ik5t>
	(Josh Steadmon's message of "Mon, 30 Sep 2024 15:19:04 -0700")
References: <cover.1726578382.git.ps@pks.im> <cover.1727155858.git.ps@pks.im>
	<9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>
	<20240927040752.GA567671@coredump.intra.peff.net>
	<c4lz3begoplgde5iimvk4k7cufiyryntccqo46u3fy5qvqauv3@tta5wfg2ik5t>
Date: Tue, 01 Oct 2024 00:34:01 -0700
Message-ID: <xmqqjzes2s5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> On 2024.09.27 00:07, Jeff King wrote:
>> On Tue, Sep 24, 2024 at 07:33:08AM +0200, Patrick Steinhardt wrote:
>> 
>> > +test_expect_success 'ref transaction: many concurrent writers' '
>> > +	test_when_finished "rm -rf repo" &&
>> > +	git init repo &&
>> > +	(
>> > +		cd repo &&
>> > +		# Set a high timeout such that a busy CI machine will not abort
>> > +		# early. 10 seconds should hopefully be ample of time to make
>> > +		# this non-flaky.
>> > +		git config set reftable.lockTimeout 10000 &&
>> ...
>
> We're seeing repeated failures from this test case with ASan enabled.
> Unfortunately, we've only been able to reproduce this on our
> $DAYJOB-specific build system. I haven't been able to get it to fail
> using just the upstream Makefile so far. I'll keep trying to find a way
> to reproduce this.
>
> FWIW, we're not getting I/O errors, we see the following:
> fatal: update_ref failed for ref 'refs/heads/branch-20': cannot lock references
>
> We tried increasing the timeout in the test to 2 minutes (up from 10s),
> but it didn't fix the failures.

Thanks for a report, and please keep digging ;-).

Is your build, like Peff's, for Windows, or your variant of Linux?

Thanks.
