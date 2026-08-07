Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706D331ED4
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786135931; cv=none; b=tWBYg5rDxMJDHARk47BtwuxlsYlaLcPB4H7LeD5eBpnHCa9rt2J0NVcCccoPvFweNaibdUGysOcOErGrtg+6wTFGJKMGryfmrxun3iVARz7jtx17kTPLls6am1eihaQn9VBRGVaX9mT3ZyCAREHNtbZBUPcNCA69ucPM9/2Iw8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786135931; c=relaxed/simple;
	bh=isARywcsO4tf+O2VF4p212KwcO0OLPekSbsri7FWG84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L0sC1cVtUw9ysiJ7e1MU/dkah9a012cCU2blij5U+vHzIzB/xtZZMHsloJ2TA235o4qUMhybkOlfjIDEbcDI7MFoZbSd4X5Fax0Z9eboY4aUj/+58ym26YQCBaMeciZgT7Zg7EfK1ttmj9Xl8FnzSbLnQaleYJcpX53tL0mE1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O2kRtpmP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CEAttt9K; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O2kRtpmP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CEAttt9K"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E48B1D00046;
	Fri,  7 Aug 2026 16:52:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 07 Aug 2026 16:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786135928; x=1786222328; bh=iuJ+0k4nBC
	Mj/coRNbIAGCe5HqTWc+YPKoir2gxgIs0=; b=O2kRtpmPfGphCes7AY9FZJS8Zu
	MLWjK2VN0pjCbP4KLnRUB92sqo6zWvGRZ5G3MqroUaErSJ69D0//MpDfN/cz4RWY
	Psw8MpyGKBQIQx7Vy/VrRtoypjqZVJwIJWJuLgeffC6mWnbHljAvH8GXu1tw/Qj3
	bMyv9gjgDkbe6r3GEBUo6a10KUorIlUV7N46K2czOSOCkpI/Q6bOujpuwMm0aumq
	euTmQ8MN+0z2yFwadmSK8oT608Vz7vOxfxhYUmNJimHNTKmHCTDLs+pXCfB1dQYL
	GXU4OJ/MahyRobH8RCEiTbNNIoXIrj6YhedxpY1ZSr9LoPkg4QqzW98xN7Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786135928; x=1786222328; bh=iuJ+0k4nBCMj/coRNbIAGCe5HqTWc+YPKoi
	r2gxgIs0=; b=CEAttt9KrhREkaBfOUw8Gt9svCFFo1/6h1XBpnSUnXjoTsRTID5
	OfTv+k1a3L9rjgJUud3x8hIFd1AESIt7buItgMsAi1zWVz3QcrFf/eu5i3/0x5HE
	thLIRPgwmrGwfotVMmOhnIHJSS0kqM+u2zgs8nD1Xytyw2fw2F3rwVGryDN+HYzm
	TIa+fJfQnK5XEX32ja4ALBzJYk+8mHls46I1jmYCHCV8OjB1hN48YB473mfkqiXF
	Mo3m5MbWVLOWm21VPlfl72BByA4aNXR0VzpGP0AYvWoPtTwqqZp+q1+B6o8gOaGg
	OiyFJqhXDpFslofR8rbLTW/jOE0ah0B7SXA==
X-ME-Sender: <xms:eEV2arbZky-PRYCOlUMbMjC5lz6JKGFbaE0r5V79VEbu54iGF7ukig>
    <xme:eEV2am8dIRdIvKiPzxZxoJKnHg5Adp3jqBfcrvJUO4purtj95jY-dvCJ7OHW8xhpb
    yN4jLgHBqPg16gylPlQavvhrxJ-o4HMYAVPVr8jnn2xM1htdUkKDHw>
X-ME-Received: <xmr:eEV2aiZ7hXHqwb-N7ZYOZq9Gesg2JaVtyIpjTeVUlyOal13vaydn58wMSj0ahmz8hg3L-rGIW1H8rPejlDjf88p4LtmVyOuKAA>
X-ME-Proxy-Cause: dmFkZTEply4jE2jCfEg+t9T3zyNFlB5CTKM4XfGQAUDksRwRAgoiGKXWSzvDsAKz9GRbji
    USgGPG/s9CzN/3oVvxeSJH+55Jgq9vffGrzp5mise8nry/wd2iyWg4a7KfxBFDVP9Eb6NO
    lD5iLqGvbcyhUckvlIxzITGUgJgR4jhR15rJ4qCkGhWaY+Iw0cNp3NW9vU/88Aeg04WkQY
    9rLIxdP02fFtnhkyERgxzSKzTqcLUufOLNti+gZMZK8dh6V8XWuq59cohxbOyH8XVmf6Fn
    ULyg2hWe+OqzthFypApoId+mMC9qm2mti78XJzCqmCFTGza5dRT2u22LvWPXnrkuOzjeL/
    uA7B6rET+vid/ErciRLvw+5v/pE9trbu3kxhhTQb9QA1X3pexr5Izd+kl7PFQry2y26qyA
    owzcLP4HfDe/KnZH4Z1T6KfZhZ3yja4kK0LgnUNhu2X9qW7DbTtXt2O0l6GYiEntWsqLQv
    Me4xT+5x1yDWCGMemY1WvcmgNhMtViLlHYDeLALCL/9O0UxPUMPGy+wMeeuzgOtGfrzsQA
    cqsx6LFOyFQ0vdRhXq7af9bo4Nd57IUqtPd7RpaXfpVDglFep0XpfDW09HMzE2BmB603SU
    WJQpMameVc/75Un6i3kgaYFAq9n4td4mUi7MH7R6AerlGvRashDdsd8p/ZMw
X-ME-Proxy: <xmx:eEV2aoeU9u3_QKTQSe120Id3Gt8GMm8FzPH2iHceNJIptncoRcCNhA>
    <xmx:eEV2anlfADYQ8CrhTQZGZubNHbo9ov3u3V_SELcsK4UVx62pLM346w>
    <xmx:eEV2ag3UfR7agHfeifWAKCTdtLJ27Z3j1fE5LWy78Yvk_RylBX_6Tg>
    <xmx:eEV2aodg011wT4vrNjBDndFgRDaAA2kmboIHsRB2R_wv0haEv7lZtw>
    <xmx:eEV2aiiaXVvAFF-vQEh52kqNmGtm_TLpdRsdGEMitK_SBWnXqdXmSeJP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 16:52:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  ttaylorr@openai.com,  me@ttaylorr.com,
  ps@pks.im,  johannes.schindelin@gmx.de,  l.s.r@web.de
Subject: Re: [GSoC PATCH v3 0/7] repack: add --drop-filtered to reclaim
 space in partial clones
In-Reply-To: <CAGWgyh9sDrHb2nXw+mmgQg4-x_H-_mLcwtpAt7QFYHydWNDg+w@mail.gmail.com>
	(Siddharth Shrimali's message of "Fri, 7 Aug 2026 14:36:39 +0530")
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
	<20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
	<xmqqpkzuhoyr.fsf@gitster.g>
	<CAGWgyh9sDrHb2nXw+mmgQg4-x_H-_mLcwtpAt7QFYHydWNDg+w@mail.gmail.com>
Date: Fri, 07 Aug 2026 13:52:06 -0700
Message-ID: <xmqqbjbdejrd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> On Fri, 7 Aug 2026 at 03:49, Junio C Hamano <gitster@pobox.com> wrote:
>> Have these patches been reviewed and tested?  Is this a new breakage
>> in v3?
>>
>> I think the accumulated fixes so far I have are as follows, but I
>> suspect they need to be split and squashed into multiple patches (I
>> didn't check).
> sorry for the trouble, these are my mistakes: i ran t7706 but not the full
> test suite, so i missed the t0450 SYNOPSIS check and the lint errors.
> The -h usage string wasnt updated to match the new .adoc synopsis,
> and i left a bare grep in the test. I'll fix all three, before sending a v4

Please do not limit yourself to "all three".  Do not expect
reviewers to be exhaustive.  You are expected to be.

IOW, do not just run a selected few tests.  Run the full testsuite,
and then some more, like making a trial merge to 'next' and to
'seen' and run full testsuite on the results.

Thanks.
