Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC5399D08
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133037; cv=none; b=ii9okG/rP5mUqGsfRlVvEL+v1Fn5KX6RF8rT89VOS2rc84r7ThmmWOUXeKclqTuWajRj4Xk1W2NpYjQ5vWqDbJYCbu80Zixu+fRhEAPukXuQ/ln8YzXOSoiArSX4MgfWuzciZy7xGHyhPMcFkHtYlzszngwyyFu08MhzROh7Sl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133037; c=relaxed/simple;
	bh=yJbwrUNvIP0jN4ljcY6+Wpu5X3D9SnHOhB1nUgp2/zg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J82S5wmQQdQwZtAs64bs6+J/YGrAd0HLp4t7iGqQaQg7nMxaQQW8TT4cs69/FxCEaat/skH264ppMKReekoZftL3HjEPP6cOlI3qMuQt7TjsSz67cJYeWDlCaT9TQ9iTLv3gc+OJ3p54ASitJNqtq2td/kBmI7bi5njPaRIh1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oKObcvJ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mj2lMCTI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oKObcvJ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mj2lMCTI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3ABB31400211;
	Mon, 22 Jun 2026 08:57:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 22 Jun 2026 08:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782133035; x=1782219435; bh=gpkW86kVj2
	433uvWv2xVSuWnuGP9CziccpyRqqjZxpk=; b=oKObcvJ2oKxvgc536ogfh7vBhx
	CpFbd9rksQezBYcAk/8unIaXyqfLm9gA/P6P/pNUPoLa/mjRY4O8Hk7sX5fDOGxo
	GTh7CEguUdh2VcKKkjmHoqe+o1HIfj+vJln9PgBUnlo4xromTfYoyIMlXQf/jRtR
	jPTd71/XQo72WF+liWSt7aQEz10F4EfYCNCoEf+7cU3bjXcgS1w0ojFfmHaaMgf8
	1hufDG4uxdZi6bNCQK0QYWfp+n7WQvdbp3z0KmnBNZBARcHoaQy+RyuxC2xEaxX4
	XFgcTDYS/4T4ZgHl5UXzVm/EmqBf0Zndz0XMJ+C1rwlZpJ2jUlxtHVo8ncxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782133035; x=1782219435; bh=gpkW86kVj2433uvWv2xVSuWnuGP9Cziccpy
	RqqjZxpk=; b=Mj2lMCTI9TIhzEej+ptu+/CthmbXVDGzPmAY6dIFWu1I9mCgO4t
	ptPltQII7c2PqI9cRfXgn3aSPZvYLQWFVE+HyktrHv6spPET3gZkYZ09jVxIqRIL
	MuMYbxwfA3fmGsitA8NPgL9Z9McTrQ0esRjqzzqmOlxUGkqFW0IR6RrpDBvrI+35
	knrm1va3+haHNLSbM/JM/lGSeRWFoOS77f3sZ4ilrv9hQVbBHAYkp8uM3XDMYckr
	5JAHuCZOE8HDu3/ABKidAwLLKV7liftpAZN4nWDwOaAXe/c420u5YvwO9LPgFsKk
	3LC6Ss3UCLppEyhfO56LYm1JhazuCyreHIw==
X-ME-Sender: <xms:KzE5atqBe0Vf43_EDki4QGhJAmGaaEpa0kRqR2_XJzQpiXxCV53n_Q>
    <xme:KzE5amgMZWg9Hfb73oMPlB4nK7-U_OU_-79agKH3XnL2VDVdeVmEs-CWzEIHaoFwo
    BbVBZT0MzzBF8OeTz0NGLSJu52hxa8FnpiirLjujAYVG5lqLBQl2A>
X-ME-Received: <xmr:KzE5aihLHn-IkqfrwrXkuRhfv5gudElhrds4mfkdDmiKp4TqBhaMXI-WSgJ8YwNS-xliyMmsafgif-VH0rslioODsGvd4Jk6IKJtJwY>
X-ME-Proxy-Cause: dmFkZTFPEFuhZqXn3BRk/wZECImOYb5Ok7rjme2nHF1t+Ff8SU9DHjmlNvX9Af0+YFh4TX
    gPf6plKRVW9pIeQwnTy7cPFvBWx3mP2LpMNRvs2VBK8PBfDKBBa+78ftChmtlalv4YmXW0
    hsQiyzLJyIM16PRUbSjklRnkPBhjksfMPtTeLVzf2cIKIDA2zNqpMe+gFqsxE51OnDPF3F
    Xi8LVxohQyK2WaZ7T6XTOw2TM5dNmm4shB463BCt3uJui3FKNUo4+Pr1X68VuULn3pmmgD
    LIlgQlQXMv20g/f2Gq3AgorLjsPWgyAnCvnxFjBnCR5yLcqkkqNSGz6zoN3c6Gfp4kxjkO
    e72KtpkMh+mIveFy931nfqNvUBN5QodNtcChJ7oUB9NshnkkBP1dLnyhGgQ5lX8usjiEro
    9mYpMTnwboj9InRXj9C3zQ6amKKpvMmkdgPe5o/WezIWTNspfNWN+ZbMISRYTOQGsgGm44
    AVPpSU3LdwHCHHc+3cJ+r0m3cU/WDnqXkQfQNU3R8e42aSFsiF98MLehlPPeV7K+csa/Fn
    GnrQ2Cn81UlAxraKtd2YUsS/1vrOM/fi3ZMk59xJVQFln4/2JALdMZl22e3rZlZ3jejpd3
    3YQ2256xuOoY3PO873DbcSMm5PYvMAOyjXtKtnZaoB2BkwGxpLK8IhJYrfQw
X-ME-Proxy: <xmx:KzE5akga7dWRr2Z1th54jX82F0k9q1owxpLL805jXDXpKvd-O7AGaA>
    <xmx:KzE5aqKdBvswrGzxGdgKXFNCCCXYt-06PRAR2GjhmlhT0S6J0wMNHQ>
    <xmx:KzE5arEDxaR3iZPeyKFwPnIoohrG8yJg0rc1pAfYdehbE1qyNnmFDw>
    <xmx:KzE5amTgmGQDnqhyBsg-5LEnv0OWzLyYJi95nBgroX-NYeppBIk0EA>
    <xmx:KzE5anwmUDsO6eHrghdt0zGbNFqhnKYRRhA4J5GkC3Y-K1torkx9uNTc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 08:57:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v4] SubmittingPatches: address design critiques
In-Reply-To: <ajjwYGWZ6hQWr600@pks.im> (Patrick Steinhardt's message of "Mon,
	22 Jun 2026 10:20:48 +0200")
References: <xmqqv7bhxiby.fsf@gitster.g> <xmqqpl1oteoi.fsf@gitster.g>
	<xmqqik7eld2g.fsf_-_@gitster.g> <xmqqeci0g4mz.fsf@gitster.g>
	<ajjwYGWZ6hQWr600@pks.im>
Date: Mon, 22 Jun 2026 05:57:13 -0700
Message-ID: <xmqqh5mu3f86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Jun 20, 2026 at 04:43:00PM -0700, Junio C Hamano wrote:
>> Contributors sometimes fail to answer fundamental design or
>> viability comments from reviewers and submit subsequent rounds
>> without addressing them.  When design decisions are resolved on the
>> mailing list, the final justification should be recorded in the
>> commit messages.
>> 
>> Instruct authors to be particularly mindful of critiques regarding
>> high-level design or viability, to defend their choices on the list,
>> and to accompany new iterations with clearer explanations in the cover
>> letter, responses, and revised commit messages. Also instruct them to
>> explicitly document the resolution of these concerns in the commit
>> message body to keep the historical record complete.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  * Hopefully this will be the last iteration.
>
> This version looks good to me, thanks!
>
> Patrick

Thanks.
