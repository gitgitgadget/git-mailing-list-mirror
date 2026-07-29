Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2F361640
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347308; cv=none; b=EVnXSv6e3sLyX/R42Hml/IKxDPzntU8dmSvthjzQav+K538naWiaxIxyyj/m0BadBWXUBc6XmzmsS/fRHEths1OpZMyhF4/liqT9OF+C9RCMw07svSn4NToj/r3TLGaYOc7/p76ZS3oyNR/rIsVJJRont7/CLfywt0sNZGDRJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347308; c=relaxed/simple;
	bh=jEZAiZujIuh/NKl5E4qLv84q077LlvAiJMPkuWjj1bU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xe7+DzzChqDVl5EMIN10Yo3aWj8zxq9KGSGN1bNHJr45akcr+1AXpDbg1Iao6BxuwjfNYy0oYZEegs1nFga/+KbZrIJvScCaZXhNZRQPsPrciB0hXvJk7kbwBLgElnfTUiOrRI/TrnbqSYDAoWmaCvILU4gJ136pWGIiRVBVDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IOcMtmqo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CxOUvrNN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IOcMtmqo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CxOUvrNN"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id AEBCD1D00140;
	Wed, 29 Jul 2026 13:48:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 29 Jul 2026 13:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785347306; x=1785433706; bh=604gkuzN1d
	ye2jgWDrDIMW9v3vIlk18UFJCBq/mr2Hw=; b=IOcMtmqouB3Zc4Xm55rtb9zOCd
	TlcgfMy6yS2SuoJ1MAC3TnhmR4PZ1rLpNz76zIHpSTP7rgMSF2jYwo0QcsxhkSMG
	apMqFBw3AsgFbvHX7nHOSJ63TGJr+eGiJfAX/hnD0MNyaEV1bk4cnCcfKrN6cL5M
	a8DRHsRZYjPE4Uo3hFQ5JrZvCl2HHYCnqvAyuC8wuS5gxksCkxWJ2vuZeuqkE4p9
	duFK5aWvrNpESzTIdgDaPGQZybOqXMkR0HG9xywYR54zz206qUAS6K6NtyGlQsRO
	o6KI991BBNtVbvEtGLwNoCgZJ3eILtIbXZigvfkscplWSILbxJYiJcKjMpOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785347306; x=1785433706; bh=604gkuzN1dye2jgWDrDIMW9v3vIlk18UFJC
	Bq/mr2Hw=; b=CxOUvrNNYsQeZolrvWklcaDJDTeM7njH4IUU4Q5O15tkZiDALQP
	vd9JUemgjUvFpPeq0CNtYr/plY4S4Xc+i55WUCKPJjsNNxDNS98p0a8qUPel4PPh
	4KDe+nway+HolWZcJ8lXvrCI4GpcKM1uXtvLF0KL3mC9MWMb1Cjh9/93CpJ29GMS
	gl4gUZvGyjXl1PBg/F64bDnTSq6FTc1MegRmTkzOBtpVLrp6gGQnu6Mnk6tKJrWX
	w9x/Zj/n99O9quGBaTIr7v27wddzsB6JlV9v+OxwEyialJv+/UY2bpwm8y9dE4ev
	AdrznOrKl95UCG4OhIkRQQkP6uaRXJv8eyg==
X-ME-Sender: <xms:6jxqagaXujHD5jzfYbHSywr0mZhJ6ySbv6li7iGgIzbDJEGwrXNhQA>
    <xme:6jxqaiZy2KBLqwdsf8k9xee4W92TmQyKZyukPPn8rVYkCWhcxDZUOEtG2EAGnmXwj
    HyIaqMAEUZ9DxV9I29VXdsMsaJSdG5J-apCDlL5I0-FSgtVncxjxg>
X-ME-Received: <xmr:6jxqav_LqI_6vQFxRAPWJ2e2LwYeQVIPe38YTw20HKuDzGrVbKPqY3rAy5vAoCSikikSryLSe4UUarHeU4iSRVWCUyCaoeTw9A>
X-ME-Proxy-Cause: dmFkZTG20i4G2o69UtuzNENzt77UsrpghWL6LYsn3gzvmCx/K2Ra/6N6Oieb6gvEUnBRS/
    1lIrhqgCn5Jb7VuDmAE8a370KuMHF5/JJpXKHf1nUzbqAxIdJO6mh16DyB8NYO+Qugr1ow
    CA971yRVWaYXKq/vn0IFmuNoNcxH4EWk7JgoL3x3Kp/mYyM+QkQ2K72nfrn7ojVFV8+4om
    foHQBA8KESFkp4Q71Fv/P5XNSsY9s6dsDg7c0LGyoH7u7SqhwCPenVf4ZnXOUWxKYnWsxg
    jeTbx82bpS/HyqI141o++h48Y61FJ+K9hclpCVIXwqM52VuYDFQQpg3cRla1CMrQfVS2Wq
    mTEl/k83eByL7bNt+3EdtQ122ZNW1nDE7Szob3c79imhx7opUondv2cybsmBL8lnwPS6M6
    0b7bE3aQG/CS4o9ph4sxJ3dHEGGwovWlaugsc4nwIxQDkKKUGBI7FrPoDgntF+YF4E1AVc
    fg9eoeAWO8jRg2j6A7yIF4U3UczCNHTzsDuMojH7nuVZB7oBtiaQisUMAmO5c91cQO6niu
    h+lUKweLI4JuVGN1YS0eevvxNJee7UcXHCUdi+YUpp8nFziHfFrANIi6qpKHQ1gtEIL2w9
    8xQEmqI/qp1Z98JNSvTUmmQszW3oZObcE+HcFxzAtwRzt4/HmgqAAqxNMerA
X-ME-Proxy: <xmx:6jxqapgDWtxBkdOgCgKuXRDAyp-g7uwHaE0HfP8a_FZF_V62xoiDZQ>
    <xmx:6jxqandN734CQ_7kZJfLkEygGkYrQCw4AjKgaxaIunaVvXNaxAmVcA>
    <xmx:6jxqaoozx_UZT_9QKhQLPOCBPGrzHcQpa77RruJQ2XERQSxsneNHMg>
    <xmx:6jxqakABQlVRofLxZRH5RA9oJL4ICXloxs5ivgRvUfQEivE6Vcblng>
    <xmx:6jxqavdGZN_bXqlAVpo0OXX-N9fOw-omSOd46E4EGCt23FztI59EWggu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 13:48:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2026, #12)
In-Reply-To: <414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com> (Phillip Wood's
	message of "Wed, 29 Jul 2026 16:20:56 +0100")
References: <xmqqfr15ruw7.fsf@gitster.g>
	<f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
	<xmqq1pclc210.fsf@gitster.g>
	<414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com>
Date: Wed, 29 Jul 2026 10:48:24 -0700
Message-ID: <xmqqbjbpptzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Perhaps I should re-evaluate the "What's Cooking" report and eject
>> other topics from 'next' as well.  There are indeed topics I did not
>> personally read, relying instead on impressions from busy exchanges
>> (including earlier iterations read by others X-<).
>> 
>> Are there other topics in 'next' that do not deserve to be there
>> yet?
>
> There aren't any others that I'm aware of, but I've not looked at most 
> of them so that probably does not mean much.
>
>> I cannot, of course, afford to be the sole serious reviewer and
>> merge only those I have carefully read through, given that there are
>> only 24 hours in a day and I have other obligations.  So either our
>> quality criteria must suffer, like this episode showed us, or more
>> topics must be ignored.
>
> Yes, we could really do with more reviewers

Perhaps the sensible thing for me to do is to stop taking any new
topics into 'seen', even if I've spotted them, until I see somebody
give them a real review.

Otherwise, it becomes too tempting for me to jump in, give them a
superficial read after seeing them linger in the "What's Cooking"
draft in the "Needs review" state for too long, and, believing I've
seen enough, mark them for 'next'.  If I don't queue a patch that
nobody seems to have read carefully, I won't succumb to such
temptation.
