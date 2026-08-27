Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F247D456
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841345; cv=none; b=BAgWZLIcVAhy4KjZysb/a02XYqJqH5Y7bKftCrakMvaGXz3oWEeAaZF4zRYCMBOcbweAQ8fp+d7ZZsVTllTclKDICVdecrLyk0zyN3j/jTIGI5t4VrBtklcVm9RfTTKUmkvu32uMJ3qbyutlazFedxRb9iz8iuRMJuJ6lPdkdeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841345; c=relaxed/simple;
	bh=I/iNfUotgnURS50Ut32jLeN3xYCm+Yt33HaHduRypck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MK5orzKEqzeY+4qvTYO3XlC5HM01sGjzNNE3D8yKb6QX/g9+cJPricb4EzZPzJpKhFpKDhN7LWJXmf5djAEfc4kOV1vkvnEMwCCKCPGkAnJgqVYB8yVNseKSkXujzclWWUnnRMhTr8aQvmjyzb4UOl2ZwXmEaXKkVYfQBRZoVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PvF21C15; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TzN2EqGA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PvF21C15";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TzN2EqGA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 021CF1400174;
	Thu, 27 Aug 2026 10:35:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 27 Aug 2026 10:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787841339; x=1787927739; bh=Cm2/HSkqEE
	m78onG6pX7YgHnXTzjZ/ksZU00CIVqEGk=; b=PvF21C15tnsKIekMd3IkOl6OOU
	HIswUT1AhRrPDNqUOakFGTfxNxIA0CHU2pJ0/0DUGzm2SziHC520ZV8jq4HrCdZJ
	gGP678P4+YIHZO6JxzTfCPFHzDMB5gvp4G+oHhe3fi0FLcnz9BFSFXTH7jXB5KNQ
	N5AGpUbIDGF3H46F7uIQ5Gtoxaqsm0E9aSW1GpQvOaLsPFuXTZXo6ucCGySccqcp
	TaUVyely5Nj4rReBYScm832+pdcTgdZMbRKk11hU4LYbcnM73X+ORIXVG0k3c6Xg
	CtksLCT6990UkPXwK0YfZjVQ1QAtp1Rh+fb6Vvox69Q2M33AM+UxtDThR/CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787841339; x=1787927739; bh=Cm2/HSkqEEm78onG6pX7YgHnXTzjZ/ksZU0
	0CIVqEGk=; b=TzN2EqGAyHopR/BmV9iEIRssrcRuSTipb9hLmTaom4x6sZ+TZkP
	rm2/BohzZRIol0Npw8JDhbC3Zo8IFIWGHdh4Eij7g0cME4Wffd5+2oKE0Ta4QymY
	oTMIW6J9SLeChth51apbrdM3fbEx0iOBh8Anz2h7AH2RuKgn9EI3Q6rChGp/zF7c
	VPJIVlbKLpr1zM6aUz5wCG9DLibB8eboTwvi/WEn5Qj5a8aU+sItB9kNL2DXs4gH
	03QUoGJPlliL8pfMaTyI+AOCWDv+rHIpPQm2dawcJ8xUpedhDqOlm0xC/ZFI1gEd
	TIBuwGa8IGeASZD8E2u9WSiWyXf1ZidwWDA==
X-ME-Sender: <xms:O0uQaj-_dAkOtMnHvYigt_oB9iENAVqmzNQCWg7mH0GeW0iBbgucvw>
    <xme:O0uQai8QGg-U0Yg_2iwS2JoM3J2zjg7FtS1rc2QpQxQZb2rmDoRIsTGtj0jzWXzGq
    qlp_J0NtTx2K6ifHWEMY5IkzuLKzQzw489xRyRxU5_WwSLwi9S11a8>
X-ME-Received: <xmr:O0uQaqehwW56QEOP61VPVs-AzUPxTUZp6rqfjDzyMc2o0cYQ9gPRbi2jmqwIAWIKNxHCxTf-2V1i60kl6wlaYCTkCVMSemqFYQ>
X-ME-Proxy-Cause: dmFkZTGuApHdM2RqL1pF/NOuo5H/ig9nM/TvaJIXxcKGGWAcsbWazyfmotc098GyLnSL0l
    No0uUQPGX3ehJ2KjlW7E1MbdQemyeQEMvR1GuYPewT+rPKaqM6050jkeMFmQafpAlF/Py7
    uPIU1tH26auU75sWwTfEe/FKwzXOAZtjie9lBN6FyGP7o/iWydKUATAUQkl9ecaFlhu5WC
    yrzO/pqlZd111uFOTiufgNTFCXTawJPUZ4z55fbJcefDB9H6hBfBoXCfcrC3B78sliIO6J
    A7apoBSuBJS5tnzeCo6/F0gKjK4cM9LOq7qugpwgL5eaIZCo9n+RUPVHo72hCSiIx+32cI
    u4F5WzSrD4KtfJmltZj1GeDpg/E37XwLfY8eZjo68moxEfAae6R02uB6hsnqzmR2zCf5U/
    1oEnK6Esekpnuh7WKlPO5TvsxORAF4JnVmv2Cj8EU2IGFhwCCKY/DJFWfDycYDu1u8rv71
    61L8KxZ3by4pfLqigqWp6JRtieduJ9QyS1H5XmSHqaQZ+gfuewo8b19pyzidSV1Ws0dFoH
    +5dOH9p5BvjMQ9ugZIkLbuIuhnFNiG4MonzYTK4+qJw1OFJQQ1wwVlwuIBDBrvNDbcFBKX
    Q4QC5R7OkA0om4bfwdFXAKLEJ2S+TksIbMdLVqykQn8TQoJAEaoZvdSENrDQ
X-ME-Proxy: <xmx:O0uQarFZA2I99Jw3Lalx6NdkNNIDbHw81cjYxEfLGq-8juUzOPWCog>
    <xmx:O0uQaoe3v_WAbXGVQQA6-ZiYfLzOQrJ5TzlEhXgbQP11Z5ClTYxr5A>
    <xmx:O0uQalF4y5FbPM6ccUt79WnrqiWgc2QIV6MNV7SxE2_Tdjlp7iQ7qw>
    <xmx:O0uQahXBlW0H33EW53UXWuomcXOizyjhtIFNOVqAjYNwu4yxSRsNxw>
    <xmx:O0uQalDJ0TZSmPcX989kGgvFoJrZ_tSZReu-IxfrGBuDO8mx-J4vA1Xm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 10:35:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] die_for_incompatible_opts(): accept more than four
 options
In-Reply-To: <20260827045515.GA176544@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 27 Aug 2026 00:55:15 -0400")
References: <20260826233152.1703497-1-gitster@pobox.com>
	<20260826233152.1703497-3-gitster@pobox.com>
	<20260827045515.GA176544@coredump.intra.peff.net>
Date: Thu, 27 Aug 2026 07:35:38 -0700
Message-ID: <xmqqv78vbphh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> It took me a minute to understand why we would even want to have an
> arbitrary-sized input if we are capping at 4 anyway. The answer is that
> we are capping at 4 options _that the user actually specified_. But the
> input can be the total set of conflicting options, which is greater. OK.
>
> Really we could cap at 2 if we wanted to be technically correct, but it
> might annoy the user to find each pair iteratively.
>
> So that makes sense. Of course the follow-on question is whether any
> callers actually want to pass more than 4 options. I don't see any
> patches adding new calls.

There isn't.  While I was writing [*], I wondered if the two calls
next to each other for opt3 and opt4 want to be combined to opt7.

  *  https://lore.kernel.org/git/xmqq1pbkefh0.fsf@gitster.g/



>> -void die_for_incompatible_opt4(const char *opt1_name, int opt1,
>> -			       const char *opt2_name, int opt2,
>> -			       const char *opt3_name, int opt3,
>> -			       const char *opt4_name, int opt4)
>
> One nice thing about foo4() without varargs is that the compiler will
> tell you if you messed it up. The obvious downside being that you have
> to count in order to avoid messing it up. ;)

Yes.  I like that and that is why the static inlines are kept to
cover the most common cases.

I think I can do without [1/2], by the way.

 - die_for_incompatible_optN() (2 <= N <= 4) will keep accepting N
   pairs of <int, const char *>

 - die_for_incompatible_opts() will take pairs of <int, const char *>,
   expects "int" to be 0 (not set), 1 (set), or EOF==-1 (sentinel).

 - static inline void die_for_incompatible_opt2() emulation layer
   will call die_for_incompatible_opts(!!opt1, opt1_name, !!opt2,
   opt2_name, EOF).  Similarly for opt3() and opt4() variants.

> Using ARRAY_SIZE() is nice, because we could in theory bump this 4
> later. Though sadly here:
>
>>  	switch (count) {
>>  	case 4:
>>  		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
>> -		    opt1_name, opt2_name, opt3_name, opt4_name);
>> +		    options[0], options[1], options[2], options[3]);
>
> we still hard-code various count values. It probably would be fine to
> allocate a buffer for the message, though I guess that pushes
> translators into lego-land.

Very true.

We could switch to dynamic allocations immediately after we see
option[] filled, as we are committed to die() at that point and can
afford to waste cycles.  That way, for die_for_incompatible_opt10()
when the end-user uses 7 of them, we can fill option[4], switch to
dynamic allocation to collect all 7 of them and report.

The reason I chose not to is primarily because we cannot use the
existing message templates in that case, hurting i18n/l10n.
