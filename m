Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06964418EE
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204114; cv=none; b=q1ArRF2gKs3wIZXC03wlGgOW4GSJXcVuxD4mlSuUbUlVb0tVB/3ma/xIrCaJ7T9q0SLhbGkkNk+gKUdCHRhvMTPLgYU8Q+LyKw1FjGkT8C7ZvhHAhPSFuHIIs2nm0qqleTVPN4oIVbF08Jh45/u03tSidlGfdjW6ox0ELzImFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204114; c=relaxed/simple;
	bh=p4VS8lT+MKqIcdW9EOs+c8X38H0Vy9dhwh8hafkNaLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eUzuR3IIP6Tgrg3pY9elcDVGvOAQrpt2IHr2CORkOghB7lJawq+qFsHrPmcMWlfutPEOhqhi424l8MvQwN/AqXk5X1oiaTx/Tm7jMSZoHeXFmtLggb+bF4Lbu2AIw0vlMmXgC6hTHHhxS/vvNwP12FTRYBOAIVr93LqrPFNp9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X0c2pGFy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GS5+IkBJ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X0c2pGFy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GS5+IkBJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 329CEEC01FA;
	Thu, 11 Jun 2026 14:55:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 14:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781204112; x=1781290512; bh=gf0412Q+JF
	KI71E6eSuKKk3LQeL9UI0ITAs5/3IsEm0=; b=X0c2pGFyPolcP3ajes1S24Sdd4
	ngDGcP7hC6ROQ5Zkf5WsvbALAX2r7vWXgg5lWjNt4PpmvG/ZHfT9CR2DhMNWYmv6
	+6tYRee8nbRnyu3HS/4r8W9Ld/r6RhGIjQyrLK0nBstMgqK4LNHNXKo3sPo7flXV
	rgQnZzCTr9MH5W2ZMxqSOO9eAEKmSZDOq98Cvz0msfdH/4wbT9S3XVjs6v0P+i5g
	Ohtl5QFNSnC+fAb22xRBkMAJbLPJQ35p0zRXZ9QAEgNlE2a95qkI8IYbd9fZJx00
	8t/yiO0Ddx5h1WBt/EFMWZayEfyzS7X/1243kOd6NFf+gVVzcedidWcWX3Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781204112; x=1781290512; bh=gf0412Q+JFKI71E6eSuKKk3LQeL9UI0ITAs
	5/3IsEm0=; b=GS5+IkBJAwFvz2zbaS7j8xUJfTVjNLY9k+ZK66RnAThK75EAu6G
	pHKLE8XnVjGrgHKp8Kg0+XpOwXdfQqOSZTcy2Hn+QnJOCQ4taR/m3A7zFXcDNZiC
	Cq21e5C65lW2g2+AGKHyvaoTgdjCVqoo54fabicq8LAVL+uRQ50sxbxwGCRZvVkt
	uJuzVhLAv0V6NDW5kxzu/KI5Dw9EMSYvEGZMMr1HQ2kKAZ6sZO/J+gwXOSgDB09j
	4vg7nEB1qpTIk0nJ5AvH4q7WwgqwkcLZXiHfDqHdblEjhLd9MQ7t5KPxxbjijM1f
	9xSrRdit/ECZOzQVgmz3zzrgIDR9c/BdzWQ==
X-ME-Sender: <xms:kAQrar9gYEd9I0C28zYM-zKrhoFh4lVOQ9LayXYTC8k6-gk-XlrBiw>
    <xme:kAQravLC2n5bivI6w3SasRjNhPUDjguQd7KvKuLbizk8UEHxb4z6HzfMta-4pWozt
    Oi2u9aL-DBECvsygw9XaQt67hPDl4Yw37XDQ8PEBcNgROqJkjPafA>
X-ME-Received: <xmr:kAQramZ14FVD-4kpPiFRll-rJLNDW-NZcd-ZwTn6Oyhdbq0SpMQH9SckCq8aceBUf7iJVoNyZ66u9K9DicDi2Jq9EvXfBaRY0kId>
X-ME-Proxy-Cause: dmFkZTEOcpLodb82QRip/lNV7XzXxTkvg9NWY5pItp0lpsNRnPtwMCcfH/YZchl64iak/8
    1JtAUM5iY3jtjuzNsr32jw4y2nJlzqFrgwIgEvui+D/pRvRWY6v7NBMBE4Gjxs8ZE9hXsQ
    PenEbhxinOMW6b7Nj8wRmkcGfabep1dfIXFkco7zZoE8L/67WGLkfTmX86MebgbqfK0xa0
    1Qllnjb9Y31RpzOLJcq+xDEnY4wmXNoo69BKJmO5es5zut4I7pylgz+lkoFMXguHVL7XW3
    vylu6VxtP8AtcH/ydrvP822qEJzXWGrQNXXwLfQu5pLHyYGbaO1Oqkgz942xW5uzIrMGaP
    Qk7talzz4eQQeh2/FUO9cHx0VGujLoIQJHtF2meu2lMiXfAcdkcL8yzZ9eyzlKPJ851fOo
    eZMQX2Ll96GjBgYeA+lXS3ciAVPU1VSGcOhiNhw5AM5RL8Oq9MtkUmEDjZS7L19FgMOksN
    Fh6/ZB8lKbcsNU8+tL1lSwnrfREcQdk8nKJj9Z8r0U/IIuj2DAP2/XXWblbLlPWxJtn28G
    HcTpUB1xCL+gYrW9HkZJhkvNL36wS4Lhgkm/M8Ibq1YLMfvBD2MyYsjkM4Ef5THRvZsGtL
    0Nyo7nLSpWQePlc5d2mtYezWRV5+9s3RKT1Jw67ClomsoNcrt4UNZ/nmhVQQ
X-ME-Proxy: <xmx:kAQrahIk3tBHP-6U4lxKnVHWT5G2hcWkI0yNOWYRuS1Ol0n3qDtFtQ>
    <xmx:kAQrakAD98kVb5c5ZBcUCjskey8cHJ-KMqMBIEODqyx71tLp9R9nKg>
    <xmx:kAQrampjqXTLns5yVzu78VOFn2SiZPjtVhaB48uJcNoQB9CNtRUqcA>
    <xmx:kAQraviZ-9pmiKAwzzLOrQTLs8IOrxg01ui_6w_DRuignVMDARruCw>
    <xmx:kAQrah0kxWKXC-4Rd9uZDUxT_RfYnIHXlOl82vpTmQqKnLB85ghg0s7t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 14:55:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2026, #04)
In-Reply-To: <airkGWlc69uVsVa8@exploit> (Mirko Faina's message of "Thu, 11 Jun
	2026 18:40:21 +0200")
References: <xmqqmrx1oy9y.fsf@gitster.g> <airkGWlc69uVsVa8@exploit>
Date: Thu, 11 Jun 2026 11:55:10 -0700
Message-ID: <xmqqmrx0nbzl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Thu, Jun 11, 2026 at 09:08:25AM -0700, Junio C Hamano wrote:
>> * mf/revision-max-count-oldest (2026-05-18) 1 commit
>>   (merged to 'next' on 2026-06-09 at 076600fa21)
>>  + revision.c: implement --max-count-oldest
>> 
>>  "git rev-list" (and "git log" family of commands) learned a new "--max-count-oldest"
>>  that picks oldest N commits in the range instead of the usual newest.
>> 
>>  Will merge to 'master'.
>>  source: <xmqq4ijm3p2x.fsf@gitster.g>
>
> Might want to wait and merge it in with [1].
>
> [1] https://lore.kernel.org/git/a804828a046d8f12ef0d03eaf014807b079bb707.1781102091.git.mroik@delayed.space/

Thanks for reminding me.  Will do.

