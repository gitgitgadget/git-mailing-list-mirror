Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6B1DFE0B
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378890; cv=none; b=cC3rGT3ei1P+HNnS8cGqyffXXGtq3X5b1uN4EnnRn6nEVY3x4UuA5iEeD/Vdby+sdFr5UMVIfppkOWDzVnldKxWtaeL5pA/1UWRHt31snysakShqVE4AoWA9Efntx+du1vu+pCDxagznRCVQzFSYLD0uDqz6m1cvU30xrDGg+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378890; c=relaxed/simple;
	bh=F3P9T7S0ng7xp55QbTbU3rXDyxUnuW03yV5WXhpTB1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uEu6GDYfcki6IbUkJK1/z8qydqhjhpLgQAWBhd3P4tCOVUsQa/H7hGYV/8PCTo9Kvk1CBozag1XkbxjfWR0X3iqxYFlqd7royjE2sSI7Par8IpHof/CB3D9Dpa53bMqmD0QiZ3DukFfdxFhusIKSeVZT2mGL92P7EA49ih51Suk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sfEvTodc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDkBhcWv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sfEvTodc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDkBhcWv"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 623287A05EA;
	Thu, 24 Jul 2025 13:41:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 24 Jul 2025 13:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753378887; x=1753465287; bh=Xc2dq9ypL/
	APsQy3CzR0zUwwy6yisKS4tUCE/b0UhUM=; b=sfEvTodcrJHUkhZLCMaEt+2n7J
	D2YUj94UgTZVYfvVwAf28ZchSZQlBuH2LELLXSAAzwmgrb5XcARqkoZUXw62GZhS
	AeUCYDWx4ZMXgQQ8VXhbCel+3E23Yt1H2Ly+csHm7SJo718vTR/9Q7ZGMThC9Fmv
	n5A1ELLeDOuN5jU51EGIyRmpatnDUbpyfLjJPISiBlV9FqGE1HnK6gERd2P9rEZh
	1Vk4anvpqxagD2ouDRwOzEmOscE98uOZYrthhz7BGZzaHaf0yMzpJYCEcRGHi+7R
	1m18W7Xys8Lpmk87cg7/liDYWjhbJFg3KqCL8XEuiVXZ3MkHRillOzRE8CNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753378887; x=1753465287; bh=Xc2dq9ypL/APsQy3CzR0zUwwy6yisKS4tUC
	E/b0UhUM=; b=KDkBhcWvVug2gk1X6mvAY3m7K4OgTP87x7/wTNMF+PTP5IYzhhz
	8whHF5FuemSDdXGMGP6X1NqtzFmDDuwRaWprAB8Gn4rvx1DFECK/jI4LMw3gd9E1
	u7iWxwkhUZJJEvu7qTWagMBcwmw5/+Xo0mGK5tJKbYjwqmHeJLjr8IukI1Own3e5
	pNKXR0uoQU6D8M+4e0ZGF9DbIGY3RHI3inLdjJwcq6c0OKVCjbwq3HLWUx6GC0Xg
	cxV3YHv2kFCGd2ChhMYna8lqFABgLANAibShwfmFRNf1pRnFz5wZCLj/bY5siZK7
	c/2Muykvwi1A1qTuF/NXbT99kygJATM656w==
X-ME-Sender: <xms:R3CCaIQdLrQQNBjG_lHWRLy-VEvpwntfmmVDb8cpc40pJzYYZoMpFQ>
    <xme:R3CCaJAxVQgsZIMpZdsaIjKYjoKdsKEZoXg5vB_nR1rt6blbRoLAbQLg6yE75fy_q
    Xjl2BVNZwKTbcEr0g>
X-ME-Received: <xmr:R3CCaPT9V5BW2YZ-HzyFMVWVfRhMeTv9FHQ3FcTQIepdJ--K2tq2CW-DtFpS87-ugqz6v4m15B4jCuKCOknxLYRUG7eIVMi9yYZVyyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:R3CCaHrU8aJMWJ6s3tx_RZGsVLTsqPULIOpRRj83Xzsveszj0qunjg>
    <xmx:R3CCaByV5lyFz4C8HmicspCRgur2xtCBUqwxb1uQgdzNkgjTFxQyWA>
    <xmx:R3CCaMKux-PDQYPB_lk6nCzBLTVKDCsvOP0tZuoWaODxn_ou95VTYA>
    <xmx:R3CCaDJ1Dh3j7fxgzcNZomObBjoyLPyucOu_8G3JOVDemdJnCumQkw>
    <xmx:R3CCaBo6UZnCiToGyD6_mQdlmveFDOg1lDPn-X5L3DCUFNkmetLV2AJC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 13:41:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] ref-filter: small cleanups and fixes
In-Reply-To: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com> (Karthik
	Nayak's message of "Thu, 24 Jul 2025 10:14:41 +0200")
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
Date: Thu, 24 Jul 2025 10:41:25 -0700
Message-ID: <xmqqtt31h4fu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> This series contains a few of the small fixes and comments which I've
> gathered from reviews of my earlier series [1] to add the
> '--start-after' flag to 'git-for-each-ref(1)'.
>
> Individually each patch doesn't hold too much weight on its own, but
> together these small improvements add up. That said, if these patches
> are too small for the noise generated, we could simply drop it or
> combine some commits together.
>
> This is based on top of 3f2a94875d (The twelfth batch, 2025-07-21) with
> 'kn/for-each-ref-skip' merged in.
>
> [1]: https://lore.kernel.org/r/20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.adoc |  9 +++++----
>  builtin/for-each-ref.c              |  2 +-
>  ref-filter.c                        |  5 +++--
>  refs/ref-cache.c                    |  5 +++--
>  t/t6302-for-each-ref-filter.sh      | 19 +++++++++++++++++++
>  5 files changed, 31 insertions(+), 9 deletions(-)

Will queue.  All of them made sense.

Thanks.
