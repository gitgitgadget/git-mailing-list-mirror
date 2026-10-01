Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9151A150
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869058; cv=none; b=VRFT7iuYZIGMAyaaWJM+zMbHEDScmuDJP2Fqm7qjvLmrONV1nmUuXu4sFwiyVok2nsRQuPuUDZd8z7ArHD3/kNbEqPbY/HBSZKbav0DQDCHAFdOJlv4Aqsw31D2CtFt48q0S0hmloW6a0qyZmytIhyF2w4dKhv7jBUPpXgtzZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869058; c=relaxed/simple;
	bh=GajjvaejogwKrGYMiCGUOWyxzAOCqSDUYZHTr001kJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I+vL/hKV4Ie2j0ZMsKoE2Kb/ulgR+4odt5N6ksgTptS2X/qDFVfLxhGuSSmKdju+Pk8gUysu4bQ3UagNIb3kLwOn1ZHJVw/A9YQ9IM7mcUUaOsbYnqRjpnGyZn6zKoHAKQqRJquwENN0j/ub2RBa48hkC3SHq0R+zBtVr9cXP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bZjzzp1v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZuIXfPDY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bZjzzp1v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZuIXfPDY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EF2614000E6
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 11:37:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 01 Oct 2026 11:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790869056; x=1790955456; bh=WK86bIacR3
	aPcn5A2l/tr+TGkj0yRWpmqbfBf35RfE0=; b=bZjzzp1vgmeuC0qJywzjV8rmnU
	9dR/8IQYYGII1SP9/F6C+kcjJPGmOB9rs3GySScSwWsiaBoKn/1FFc0n+w1AZ38M
	BIw3sJwuvKYgCJeZec9G6ksYwfBZ+T0XmPI/IBsZVgkwgRA9ewUDUQeFaL2KnmjE
	h+bKgvI15uT7HGSj5gYr6HtAsrGQ9Ilzej4UQxt3Ku7/VMRKtTTslNrpb8mc3yHt
	DxpS1u03PV90KdZ9C02ObclTJjq4MWJo0khXutp1aTYn9sDXNVxoyf1+xjtCkgFm
	TH7cjeHEy0XnobsUuK9mQqaG6DxGSaMYALVD6u5NG4tK9touiWyE7qnYtGBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790869056; x=1790955456; bh=WK86bIacR3aPcn5A2l/tr+TGkj0yRWpmqbf
	Bf35RfE0=; b=ZuIXfPDYyl7Eeggsm9M8FUhfWm+OXaaYeTrITzgO3zLZ5LwB8XU
	vWwnxq277/v1BY/hwh2Jfh1+Cu63p01T8d7q8ueHK6T+wHtT7ezhiYoKQU7khW+X
	x1LztGCcAKW9wF5qFZOBNVxbDFKPsBEwn+Oz8Ko+WHnD+J5HaWV6pheJZbz75DcB
	TTRgAIaOGeXIcXUtKllmCE4ymVeiEml+wS0s/17rbHX9+LbB7WYZyEHBCns0pOhE
	sYQh/dwhV2ZSHDdB7DJ/LUsz/OmOYz6Yir1tQ+tfhuXQlPc059KPGCv9vug56ht2
	O8QM3woR86Kztlkl3SmeTWDmPlCLlwgxgJQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790869056; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:iy7p5MQOdG3xXngc17AHqgTNfply7vMTZSg9vcJHisu2em7
	RY2QnI4jr9bN/tw/MixOKl8uwqN/5TgX/22jmQncbBHBEi7qjm/LXFeDEf5rt7cq
	Yr6T7uRKGxtfEH79ZD/P+W+CTYDk/lkZpf3GtqtruJu6gxsdYouZXfx2QkBDdu5p
	7DccJzusqQptBLzL6VlyIYFnBuRHH6Ga6q3W+wZzLtc++xX90MmCLOsXc8vc2ECn
	73wpDFWvhJQfTpQx6tnmL7VhUzeaQuIb/gvqh3/wYxa87fLjVE+1/IwQ+mmWs2cY
	C8d5WWSj61bcZL7WrTLiZpTRqexdJPIdv2pfX8g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:K9GQ5GUitqY7f8487MVGmevR+2/KzkUor1bcg2zxkso=:GajjvaejogwKrGYMiCGUOWyxzAOCqSDUYZHTr001kJY=;
X-ME-Sender: <xms:QH6-avhYqDZrPJjzFfU-x_6b0uFr8XRXMaCCwXh1jVYPH5g8ukE-cw>
    <xme:QH6-ajBya_1HyE2vr7ZAV2AsSGkDsBh2gxPcm6VtWJWlQNqdFMw5qAtyIgDeZR_SU
    QF9NTHp0V0EeVLgg2FZG5keZDvYVcC12KJhCmyiQqoYnTOaJtNEwoE>
X-ME-Received: <xmr:QH6-akHMgMGgXjJ-n5Kkkd8PI6CS1ukTvXJgGHhzvH9AUc6WrTZeW3OaEy57EonPQMCAdda7dMbW3afxIBCDEdEEfbCbpLg98UHn>
X-ME-Proxy-Cause: dmFkZTGukX/alvJAgAiHYTkXpBRTQpjxd9DFPcsdxKlzBY8xaBOFbAG1L+pAZcx0/f+N+b
    7BbwsZdEDLSPee1ylAzsJMHg1K08X91i1iG0aiXohETOrAbAgF2dR0GqnhPYSzWVq0qYTR
    Kdvc7bXInqupoWKZknp3ZVsj5rnT2j7XzEOAArw0u7y977OkoO4lqGxrI6Q99ndjXkmcDf
    lQO+/qDZgfWKtYu6SS5NSXzAtVPTtBzdFQ1U7896ZGR+4Fqe2UhEeU4EkjNiH14yvHEDD1
    1V2b6U1aiB62JRphBQzTFrSjGJtXzHlpEMufNM6fo7BnoyakSm6MYXlFRJ4xqvl53iLtq0
    DTmVrKlgiP8AedOVRveDPEbncF3AkuuQCQhlQQEBQ/gVL5TOquNAlHtMxrqkpIXGHMgVJ1
    +F0Tgs8Wxutn6V63v9nbCVvDcFbU2qOAPhGoA1zRKaSO98ptRHa3HhVfGjmZ3Pm/GgDL2k
    h4vyxBuB4RC+JciN5cJ9CgAFZGQigK3crN3m2kgCvt7H5RWiQGHjB7adaoayQgmpE60MLx
    0+vFcSox3fV4RSnqHplHI2SqfvSkRkDEQBh5dYP+a909ACr1GloNX9PWUhz5Z75Z3qrcIe
    8F9u9Libx0wJl0QV0gU7cVZIm+n9sEO3soIkGXI1m21y4o1kYjAijXt5Xw1A
X-ME-Proxy: <xmx:QH6-arJrZZ7ls5mcNLhMccVB_iFzi1m-c-Q-lrJHCnt81rrASmOGqA>
    <xmx:QH6-aon8SeHeaNbbC56hT9cSD6Wqr1b7bffjDuOlOr0qGNZmCs-mRw>
    <xmx:QH6-ajTqRVDgi5sFVFCS3qmzFzMP1pifwVMpYajRxs1RLX6RHQhhYw>
    <xmx:QH6-aqKDCoaGcGkix7nAgtjHaqH0s0YRhWFE4b0Ai_eV2VdgvqhUxg>
    <xmx:QH6-auB9cz5XbB6Si40lH_L6XI_21XGRhp8tyBJ4r5GIAGVkTlYDy_Xb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 11:37:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/5] merge-ll: report an error when reading external
 merge results fails
In-Reply-To: <20260930224142.GB763270@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 30 Sep 2026 18:41:42 -0400")
References: <20260929204157.GA1733321@coredump.intra.peff.net>
	<20260929204421.GB1734030@coredump.intra.peff.net>
	<xmqqv77neowx.fsf@gitster.g>
	<20260929214943.GA1735259@coredump.intra.peff.net>
	<xmqq8q4ibouf.fsf@gitster.g>
	<20260930224142.GB763270@coredump.intra.peff.net>
Date: Thu, 01 Oct 2026 08:37:34 -0700
Message-ID: <xmqqpkxt77pd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Sep 30, 2026 at 11:01:28AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Here's a resend of that final patch (not just a squash, because the
>> > commit message mentioned the chmod).
>> 
>> Makes sense.
>> 
>> These 6/5 and 7/5 are probably better squashed into 5/5 than left as
>> "oops that was bad, so here is a preliminary clean-up to make the
>> fix easier (6/5), and here is the fix of the fifth step (7/5)", no?
>
> I don't think it is the fault of 5/5 at all (which carefully tried to
> maintain the NULL behavior). The problem fixed by 7/5 existed before my
> series.

Ah, OK, rereading the code before 5/5 is applied, I notice that we
are not declaring the result is bad when we jump to "bad:" label
after noticing an I/O error.  The code only paid attention to the
status returned by run_command().

> In theory that fix _could_ come earlier in the series, but it's actually
> much easier to fix after 5/5, because we have a single spot to error
> check.

True.  Thanks.
