Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA525385D67
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927210; cv=none; b=khwQt3LUfcNVFsgEUsN+rIYzMo3ruZqVzTu9BQL1I0tZBcW97otVGzbaSs6Pzx0FDWeUoS+1HOMOBtV4PTOPb9NZET1ObUsBD5INwmIqxXU8khH/9BZA8J1aP/teOGAaadokBX6l0J9m14vYPElgQZ3xykOkPlvsVzhicntBLkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927210; c=relaxed/simple;
	bh=+qZ2FCUK7p/Mbs/XyG14xmgKv9A9z4pSXmPM4K259nA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mwnFjrOHN4TjspFQ4fVhd8ntS/+r/UIY6yQj0YtAlRWaigh7eGo9Dkhk+XjRDQDU/J7TwpR0zxG3jvx/w0uWUAR0P72i+h8NgnzzXl0225kzZfz2gmsIocp1VPVKQ7P9EWVZbzeCG/VIMf9HNYPjrc57PgojtmXRDEHWKzThqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=haokpvHV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=anyc197g; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="haokpvHV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="anyc197g"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E1B21400138;
	Wed,  1 Jul 2026 13:33:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 13:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782927208; x=1783013608; bh=w1ZK9L+ALy
	PtryZ1jmqjfpExC3BOeIjLdRsFhxoWmjc=; b=haokpvHVNntvmnavk8vEhXoNAi
	SGqgr2K1LRjeMoc2uS9Kbh0KK5jad/o0p8g2cAII1pqHWODOP4JRYoNzORTslGq6
	nvAAFnZehXu3ajcuT1L8UjYJ5kd7WQ7i2ewLXdiTzOnYXOW+/HiyP2lRWniCpl00
	rDUYRoWw5FuYBM+YfiiOmDreebzr1cT19l0t21GjnxSjGhptzhw3Ev82o5GgjWGO
	20fkNIHjrQ2XYJjR11J7QoJtRkxMR/EHqUWj2PpO8x+djiu04lKURagVCzmdDIWB
	ZB05WulmcUUwBHPYOFYgzV1E3TA0iAFci+N8GulfYGePwkufUEGX1PdKsUWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782927208; x=1783013608; bh=w1ZK9L+ALyPtryZ1jmqjfpExC3BOeIjLdRs
	FhxoWmjc=; b=anyc197gw0dBhGe0VjbOzB3lN8mE9I5l+f5EHDAhGLDhRs5J5j/
	pvznKgB8l8zS104hXW2YlX39FbbfMVJolpSOoTScjY+V1aNh01WlHFisdTLbuqdL
	vT6YGfHWjz1AWRkyuNOJINWizIp2/L3FTu3sJZZccAhgy9GxyjAVHrQE9YpHxOne
	k1zfX5Rc8ulzuhQ7ias0FInK3x24hwOGUjeJG2fjnQTLUaRUR0LL9oExXJ0Qgfzb
	dq7ngca9cm00jryLlNKNKOPgf8XIF7vQotZHVuRtC4ae+I6Qfq2GXtWJ7A17B8Li
	zlPOmROXtd9HIiq3ghhhIpNJVbl5JhoZExQ==
X-ME-Sender: <xms:Z09FajLet2XgwtHiCkxAFkH-ROzc51CX9oocJyaHucbhfXlfeqDuqg>
    <xme:Z09FauBtL85L58XkgItVwwHxCf2dX7g10my1yz1Vy5S1zqCUil7_JWAGMJAHvjdlU
    pEXmPWJCeU6PvQNN3xVpJaYkpsp7oTt5qDY1tGT7aJNW6ZbUh6xqAo>
X-ME-Received: <xmr:Z09FakCbe5RTC32FQJ_lHpy9zWSG1PODOVe1SDfTgdP2tX2X59XIwespuUeP0IXJ27DpBLfcLvIZ12-riQ2MObRjexoa7a0cy-QPVOw>
X-ME-Proxy-Cause: dmFkZTFtv97kZFQ9kBUHvcqGjbZKoDkeNECcTLHaWSLbABGmPdv8zpJ7F5f6lUD+Wkx6v/
    vxzOF3DKYFFt4mwr7YVXx/DPvEyVgdsrbsucsX8sIjS2hGuOz++b4zhN7Bbg0swCrWojaW
    9rhCF7Clx5vQ/CyrEE2dG9p0wndkylhSSSGU6KMxw0oNTb1xw3PNzqFpHn8AQMezNx48Ho
    cpCbXMffQjTCZV3n4xtFSlr/XiT1ay9N6FIR5HFiJ9G7q5SrSos6kHFNuIUEQ101Oqy22m
    T07MFpeXppAPn7gon8KTd65kImuGAx9YtbZ7UPZm3Uwv2Zq73c+2uP4OjipmJ7YaxQvoTp
    GN5H8pAyGj0H8JCoDuc8LTO+9UVDKXv1NwHMdDR9TX8m8JCBsjDxEOWg5qxKPPjjcx0juj
    Nxo67/LrWsNfYbTAskBULVbfLQkixq0osESlIIGYWNdMSi2j5dLRdP2UnHhL/FjgB//PuU
    sYtxTFJsLb0iYFkDBA7Npev6S0JimFS+XDuZIEbvSflbdYeYOtVwfw7//sqwie08sc/1r2
    99/y/h9d1iPK8RJaWh2eGPShS5T7LnOIjSor5ZtPnl4pXMy707DtY5Ql3+3mCD9iqJwotK
    7VWDhQ3+dj52EVqwQEIBV1D00Ww3E6IKraXiejgVJtwSqnU0ShWtV9oUv35g
X-ME-Proxy: <xmx:Z09FaoDEvWr1GKeOH1JjkbCxvzijpJIM-bBJd2uanyLOq_IVxIM6mA>
    <xmx:Z09FanpnbUyeu7kH9BnIgqJs3nLWCPgLRyPYmAxOclR4dhpNoLg9jQ>
    <xmx:Z09FaqkEAQpYabrnrS0mOI_z4ZjJln2_MWzz-FrJwgI3suEzjFZioQ>
    <xmx:Z09FavwZpFwuHmLHfNqkv6OaKE11RRc6vqo9jSh0uchSefqo_WMt0A>
    <xmx:aE9FaoiusONurTc33lWD4Y5Vp2Ppa-6T7bMWEDs6AnMFJb84jrng7v2u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 13:33:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 0/3] bloom-related leak fixes
In-Reply-To: <b641aed4-ad52-477b-b1d8-9d8e470be46f@gmail.com> (Derrick
	Stolee's message of "Wed, 1 Jul 2026 10:32:39 -0400")
References: <20260701063538.GA2579765@coredump.intra.peff.net>
	<b641aed4-ad52-477b-b1d8-9d8e470be46f@gmail.com>
Date: Wed, 01 Jul 2026 10:33:26 -0700
Message-ID: <xmqqo6gqobrt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 7/1/2026 2:35 AM, Jeff King wrote:
>> Here are a few small leak fixes that only show up when you run the test
>> suite with GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1.
>> 
>> Combined with the commit-graph leak-fix here:
>> 
>>   https://lore.kernel.org/git/20260630064301.GB3733961@coredump.intra.peff.net/
>> 
>> and Kaartic's pending fix from this thread:
>> 
>>   https://lore.kernel.org/git/20260614141600.620272-1-kaartic.sivaraam@gmail.com/
>> 
>> This will fix most of the leaks we'd see if we ran linux-TEST-vars jobs
>> with leak-checking. There are a few more related to building with
>> openssl for sha1, but I'll tackle those separately.
> Thanks for fixing these leaks in the simplest way possible in
> each scenario.

Yup, these were delight to read.
