Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9B26E6E4
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583308; cv=none; b=RPmUgsINUXr/AnooVBtSELRCE/TyCc1+tByr9yDr1FGk0yrdEcpCsJ8rlKB25Y0eAMStVCKDtGrvdaqOhGarPiyB/RSukmzVkKET5trVlk2CJ53mDsDMzFzDHH42RkuEekNusE0ZTVHOtDsQRp75s6Hl+RvhHl36ydH2oh/RL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583308; c=relaxed/simple;
	bh=SZT7hqHS2rNme+b9j1CFXVxMaQjcSvuSGW54sh/+VUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVKCo9MwbbrRFYhuB4w78oH9xJ0Thtmvo4RoUS+5miXt8VzQ8uLAI3loY1ul83DIhdyzvJX5KyHd/ptWP3yVxmxkOi8mvNFI39tc6uyEKjocouj75ByvGT58ZYPrO4ANo9WtWgyaCYBieBQOhzvHdWtoEWxbqVYRTtKFa0+BF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XCRfy5W/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PeuZbnI4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XCRfy5W/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeuZbnI4"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 33D867A01C1;
	Thu,  7 Aug 2025 12:15:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 07 Aug 2025 12:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754583304; x=1754669704; bh=JWzlfjKIlZ
	r0cc1aK+JE6hJT+NL/INvF2KB7FP2yRIs=; b=XCRfy5W/hLyu4PqD98e5rO2XAq
	ywvKJRjV4JkTvupQVJC3JtEQ7xxnFLCg6Bqy3Du2OJVNpH/IHJCwcylTDRDLE32c
	I143Plggysmrfhb5DTeM+ptwAx5L30TU22gS526l2Yew/X/Rmpl/sV6v+ijHB5G0
	7pM+YQa4lSbHutRTIIBVMK5IGpbppGoJxQm2G3Q8al9khTqVeej+cvgtTgubkD4n
	4TZmV4Lex1oxvWc8juP3t/V9D397Qb36odOMnmV30EduJat4Bp+AkwokXouKnGtS
	XV4IK6W4AViqKIwe32e3hreb6b0jAtdwsT+IyVL0XELWz/3Jp/nRKpnl+vow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754583304; x=1754669704; bh=JWzlfjKIlZr0cc1aK+JE6hJT+NL/INvF2KB
	7FP2yRIs=; b=PeuZbnI4LxiQcexLmNbj4oiMsPKlLIYFSnHblriJoYgVNXavN+z
	2Ie/t11EDYQyhwp9wMJO/REWdZTITVo3fDz8VCv+wcJsVCYLIM5ktwUFMaUp6ySC
	KXCD4nq9LF5xJBu2i/yS/NveQV0/p1RbMOFfjTxrWRHs1r/MhUJL+JJs2pOsPiYn
	RYziqZWX0e57cdiWHiqmMnNJYPyqDIwsy+3BPuxhrDjxFan0FAg5luFtIfu6TSm3
	AmRZwvIVgIboZNPOdfYY1CZAXrBwnVLx+3zFiICBLDuX3PzLyq32DOtNdJR8b5Iw
	lct5ZJdWX30mn74VYvdqr2aWq3MCV72wYFA==
X-ME-Sender: <xms:B9GUaObUTybNeWS7sEfW4zbPkEFQh_EptdCtBdB9uzQ_HnSQfhcljQ>
    <xme:B9GUaJ2kDwqiQNWDdnQtjiJLVmDAuJ-xU7zkrvksXPicoHruXx3u3wqKA_EzqCdeP
    0-KsOxejWRzutj3jg>
X-ME-Received: <xmr:B9GUaJaUNyEzcu-ATeE37jwtzA97k5sPmG-A0TcZDjQcaOakWnqMm6ZZB68-EY_CwbtfLaoSwCgZuAWY_NPm71N0w931UCUC31e1t48>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopeihlhguhh
    homhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepthhtrgihlhhorhhrsehgihhthhhusgdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:B9GUaBLX5oiw_ZE5qCR1MXxjNf_G_LBa2_ZtZttUymMJ_LebxUAUfg>
    <xmx:B9GUaIHdSx-CE_EU2Jy7ZrkKKLjQO37isn1afDoatxpilEV4KRWGsg>
    <xmx:B9GUaIusQ5udiFg906hzPwEa8n9GeKgiekiknGspqomo7rPi3BQq0g>
    <xmx:B9GUaHtdx4HTl0fKDs1m4eHILfvsyahfKUmhB5qWPw_2Vn1kF9_ULQ>
    <xmx:CNGUaGyZMlQrgbuFIvh9dIGyAwcpF_D1180YRtg88Ti1lE70ckmdsbO1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 12:15:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  git@vger.kernel.org,
  stolee@gmail.com,  ttaylorr@github.com
Subject: Re: [PATCH] bloom: enable bloom filter with wildcard pathspec in
 revision traversal
In-Reply-To: <aJRMaYfMd3PlRtoz@pks.im> (Patrick Steinhardt's message of "Thu,
	7 Aug 2025 08:49:13 +0200")
References: <20250807051243.96884-1-yldhome2d2@gmail.com>
	<aJRMaYfMd3PlRtoz@pks.im>
Date: Thu, 07 Aug 2025 09:15:01 -0700
Message-ID: <xmqqa54brtve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 07, 2025 at 01:12:43PM +0800, Lidong Yan wrote:
>
> In the subject it should be s/enable bloom/enable Bloom.
>
>> When traversing commits, a pathspec item can be used to limit the
>> traversal to commits that modify the specified paths. And the
>> commit-graph includes a Bloom filter to exclude commits that definitely
>> did not modify a given pathspec item. During commit traversal, the
>> Bloom filter can significantly improve performance. However, it is
>> disabled if the specified pathspec item contains wildcard characters
>> or magic signatures.
>
> Let's add a paragraph here, as we now switch into the "what is being
> done mode".

I agree, a paragraph break is very welcome here.  I was confused
when I read this first that you are suggesting to add a new
paragraph with unspecified contents.

>> Also Enable Bloom filter if magic signature is not "exclude" or
>> "icase".
>
> This explains what is done, but not why this is safe to do.

And for that, the enumeration needs to be done inclusively, e.g. "we
know :(literal) is OK because we can do X; we know :(glob) is OK
because we can do Y".

The numbers are impressive ;-)

>> diff --git a/revision.c b/revision.c
>> index 18f300d455..ef8c0b6eca 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -671,12 +671,13 @@ static void trace2_bloom_filter_statistics_atexit(void)
>>  
>>  static int forbid_bloom_filters(struct pathspec *spec)
>>  {
>> -	if (spec->has_wildcard)
>> -		return 1;
>> -	if (spec->magic & ~PATHSPEC_LITERAL)
>> +	int forbid_mask =
>
> The mask should be `unsigned`.
>
>> +		PATHSPEC_EXCLUDE | PATHSPEC_ICASE;
>
> I think instead of a forbid-mask we should use an allow-mask. Otherwise
> it can happen quite easily that we add new magic that isn't compatible
> with Bloom filters but forget to update this part here. I'd rather be
> slow but correct than fast but incorrect.

Good suggestion.  From the use of &-, it is obvious it is a mask, but
"allow-mask" is not clear among what kind of things some are
allowed, so how about calling it:

    unsigned allowed_magic;

Thanks.
