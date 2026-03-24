Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EB3D5258
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373584; cv=none; b=TMYxCQCTkHbCrL8LOZIcIYwWDoA0S2bEDYk8z9FDI24eSjD8cDgGLeHw7FPkuTzLNF0uwa0VpuK0cNycLopcVXWvm/Ql3dt0ldtLTaSeEGgm/SdcbVIFEhj67znDl884C5AWLiZNs9CAF6OvGgyQnBn/PvztAQwH6QmXq1eDgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373584; c=relaxed/simple;
	bh=+E/9DSKY/tCm32ZZZbEiY9/SrOW8yac7yR+V7cF+RA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qPixFPBQIk1MxryC18beDA19yXQeKVbDQ+b16LdMi7clZn3sVZGVAWG2SLa2/AmECBXI7cnOyrgSwZnC7u1In11Uihf7E2uoooOsx9RTNYKVRUmZORTEh9uvZZesUj4frA9tyfc/fLKRhVetfs0wEcFTGihOzTIT+Pc39ejrS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k2gqD6Q2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5Bi0jIY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k2gqD6Q2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5Bi0jIY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2F6E14001FE;
	Tue, 24 Mar 2026 13:33:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 24 Mar 2026 13:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774373582; x=1774459982; bh=FVAhhHKICq
	FZ4Ph9DUYVzuyRkuvuSs5DeKRYZEMt0eY=; b=k2gqD6Q26SPQctA9e3QMWlXPg5
	+6uLGb+/4/617FWeNXpuKXxSQ2kuA0MLaVExlcTujUC3iPA8ByMawjqQvTqi08xq
	B6q9L2oNDhk2IyGrQRXgElj2KHItNZ0bMfvBEywIZe/x8SZxhaQ2g3P8cEK1hjX7
	1mtqwzqqERR+miJp2+d4edveOdi+2ozCGwvFW9Ji1EGEfdVso8l8vrNrHbhKjZaQ
	jlzur5D78Fi9DfeRizM/HnVk+WxvLRE0P21mKw7LPWFc1mck8T8h0G74eQFNasbx
	qt9ieJhWgJaTktABnh5SQDOHSGPaIt2gnGMcYSEYgWPkELud3SBjsnTUuF1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774373582; x=1774459982; bh=FVAhhHKICqFZ4Ph9DUYVzuyRkuvuSs5DeKR
	YZEMt0eY=; b=W5Bi0jIYzxGfy/qKOVS41RKGrRlfpw1aP/lk4uDAA0JRz5Wuj4v
	/YcIyfaijcsR2YbE6Y/h9nHaxpTMiciI7MXH1B9HLyOxmi9yM1A6vuqXL3fJNccQ
	aPIWWBWEvMlNyN3/UQJwYaRphbVTtSBk5qxdKX9aZTurjPMuOPQjYu+zvgDH2wOo
	mpo9BsNyPuzRZCrensW9FG75NU68mUi2mrkr5UXqtld4eqNH7zPKNwYBk6772da2
	fqMhiOiuWQWKLH0nj4NkGwUtngGdOf7/ULZ+coppog/Wrxvqz/B2yAouV49OkUb7
	ZA6zew4NwdV3Gp0OiD8Pc3b7wfOO/0btmAQ==
X-ME-Sender: <xms:zsrCadgarnyO76udzqlsRQh9HfOUlRqG8PvV1ao62f6LL3gGpeo92Q>
    <xme:zsrCaVu_0IieLRskRjMgxBEkXH24NnB91nVTFiBNcNBRvYGUBB0ef9M6u6TZvqf1o
    ziMso7pLQq5fFiW6nsrWrBO-3jpB2lqaG9DUtx28xR5mOOm6DKynQ>
X-ME-Received: <xmr:zsrCaW6WdGeVXP2Otf6zsgYUv4izMuUiKbwQqaJEAB1BLl31jT4Qp0-JEtMisuTbMUeWTADDdFEzvKlbK5pec5g-huVJLu-GpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehkvghrnhgvlhesshgthhhlrghrrghffhgvnhhlrghnrdgu
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghhrhhishestghhrhhishguohifnhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zsrCaZNQIMFAb7qwTLFruX48t_MWNykjkMctLbJ2HVuQKaqV8uHwkA>
    <xmx:zsrCacsvIGtrjQ-r_Zz2-k8ynPSpPH20nLgSjPbsxNmkkVn88Lk3ZA>
    <xmx:zsrCaUba-C8aMUHEwEEi0NFO664sZo7H2hxqgOG0aY6Rf_6r8nimQw>
    <xmx:zsrCaWxKoPvx9r6_oMGYSyfHhQgIjbUYs7bl3xiAwXfbnTPvTbLLwQ>
    <xmx:zsrCae3rF67UTpe1LWGQ6Uatz4Jghkaay77YDaE3vQCQPKvOmYqzFvgz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 13:33:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Jonas Rebmann <kernel@schlaraffenlan.de>,  git@vger.kernel.org,  Chris
 Down <chris@chrisdown.name>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] bisect: use selected alternate terms in status
 output
In-Reply-To: <f8f7a220-c40a-480d-b0d0-abfcf5c83157@gmail.com> (Phillip Wood's
	message of "Tue, 24 Mar 2026 10:43:06 +0000")
References: <20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de>
	<20260323-bisect-terms-v2-1-8d6bdb2c9c7e@schlaraffenlan.de>
	<f8f7a220-c40a-480d-b0d0-abfcf5c83157@gmail.com>
Date: Tue, 24 Mar 2026 10:33:00 -0700
Message-ID: <xmqq7br116b7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Jonas
>
> On 23/03/2026 22:48, Jonas Rebmann wrote:
>> 
>> diff --git a/builtin/bisect.c b/builtin/bisect.c
>> index 4520e585d0..ee6a2c83b8 100644
>> --- a/builtin/bisect.c
>> +++ b/builtin/bisect.c
>> @@ -465,13 +465,16 @@ static void bisect_print_status(const struct bisect_terms *terms)
>>   		return;
>>   
>>   	if (!state.nr_good && !state.nr_bad)
>> -		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
>> +		bisect_log_printf(_("status: waiting for both %s and %s commits\n"),
>> +				  terms->term_good, terms->term_bad);
>
> If we're going to start using alternative terms it might be better to 
> enclose them in single quotes to make it clearer that we're referencing 
> the term names. Looking at the test below
>
> 	"status: waiting for both 'term1' and 'term2' commits"
>
> is clearer to me than
>
> 	"status: waiting for both term1 and term2 commits"

Excellent.  I failed to consider this, but your reasoning makes
perfect sense.  When we were limited to hardcoded good and bad,
they were clear enough without 'highlighting' with quotes, but that
is no longer the case.

>>   test_expect_success 'bisect start with one term1 and term2' '
>>   	git bisect reset &&
>> -	git bisect start --term-old term2 --term-new term1 &&
>> -	git bisect term2 $HASH1 &&
>> +	git bisect start --term-old term2 --term-new term1 >bisect_result &&
>> +	grep "status: waiting for both term2 and term1 commits" bisect_result &&
>
> Using test_grep would make debugging test failures easier as, if it 
> fails, it prints a helpful diagnostic message.
>
> Thanks
>
> Phillip

Thanks for helping.
