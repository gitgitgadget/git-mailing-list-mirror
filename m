Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B23AAF70
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339652; cv=none; b=LnkX9hUFiACyEv3++JGLQaMkQdIqcNOe6TgAof6cyl1uXpUZXH3WTdRFIaFSWpLxMRp4UDUJcNoCpKLW/PQcoUy/a7w4+VvBPcVmsSoqD1Nhl6Alu4gWljRMcTA2vHjIowGM7pPCtfxhursZNYg3NWtKK7wMRnKYDKZGBjlcKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339652; c=relaxed/simple;
	bh=eFWisWXFAiiigCscmptN/2j4q0KSduRcLNPJOwmcLK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RsMnHJCxiGMJ0tF0G4dIxYzqeHc04Bfz5kNvNVLSYOrCx+dzkBVYMwNAtyIiaNxJeo5mK2X1yuqYZj5+3sDws2wprHMKnRC2Gg1rheZ71UWbi5f8yI27vv6KGyZTd2uBdcV1GmvUMt1ti6Cw4y6l4I8Qork74orrtt1oJ81beok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KkexNRSX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cn/RL74H; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KkexNRSX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cn/RL74H"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2512B7A019A;
	Wed, 29 Jul 2026 11:40:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jul 2026 11:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785339650; x=1785426050; bh=vx6RzTFUCC
	4dgOIqYYCun3q1ASHfsv2wKr36aDG2GO0=; b=KkexNRSXJIqK358PhZrI2s8X0k
	TAS3o+d9rPFl59LcRcWCOAXtKd37Ib70l/x/ZHzEK/+cGaOmOX3oEbXHnH4ogwVq
	8lmpAWnCrG/90LC4QjFdhtuPHGNzCCwt0wvdYsAkKAcZ6f/6LM/1XPGClcenodai
	4yVEIoNI4bzIfYt35I3C6GiHNlYpByt85HHAc8swGiWq4k2idJ/AxGpQKOkrwFkE
	4ncCRWWV1bmN41BCKz82+5HDG2x2QEgUz3ksys7tTBHKxWWF0L5gPHH53yHVI6+M
	EMEOTO2jnFTPonJNLREOHP2srUMszEc2EP69J3C3Blbv3BSzhDED8nvLVA9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785339650; x=1785426050; bh=vx6RzTFUCC4dgOIqYYCun3q1ASHfsv2wKr3
	6aDG2GO0=; b=Cn/RL74HMTGuVT0fz0kPjTVk3vwflMuNqQNx6F/OPaPq21HQ+Al
	uoATVzvVB0x7GMWu8Ar2RIc0PuhQybSBN9XCsD2TC/8uG+H2coL6rXyN631E9Y6c
	7I/x5/+C6yvY1d5YZC4f7qUUyodWLKdT7XV/xO4ewof1+rptUGu1HtZh26ap52p7
	pv/2dyh1qfJk/KyHQWNDqvCG8Fz02DBvRNGRDP6WDM62s3gAAJ5QNze9baduweVj
	y/ZSn6XO4sDfcLbdDuCPWvZ4GKrJyUiIDcQoxhjq2hlkKi2pY4BRf66JdrUG100c
	xiHgBm8AZVV+PyDqJKSumHc19QxL3oVWVMw==
X-ME-Sender: <xms:AR9qarfX--MtRf1-0ZIiv0ch9FwSazCHqaUMC8GNg8SSsHXNxzzILg>
    <xme:AR9qaoEp6v8GNbXvnHViUafME_jvEwolYtHxBsNyh_ms3qoeLcd3v2Mv51Tz0q0NJ
    2HC6p0t82kabNQBw9-8D2Qs56D7PkfkEdjVwShMO6Kg54t54FDAMQ>
X-ME-Received: <xmr:AR9qas0k_Bv23ZOs0JL5XxnmWaWdskujuaELTqaxQeWObAby3CzAe9HdgIig4mkePDNTJnqExqK5D6paAf5JFVYCXILFTwAoIw>
X-ME-Proxy-Cause: dmFkZTEWkEpXLPWo8BPACH1+hO+YZ4OMkeLA9r5t+N2LXBbAOh+JvjNLSwmth+LET9zu6n
    ylP/RS1eejZiM2p39usd1Wthy6Hzkq6UTCm8UJny9uX4y44YqYqORuGZarDMJrafpR1hPW
    3hZ66+qB/Ys1vMOQb/9clECApNjNQ5Bz/m6ACXb7pW42y5GWAVxvE8axycSs9r5mWcvG0C
    HkAdr6q3YDoBdw6nStZDEzGuWNwi/zjZOIXNWBcSTOCkoSw66/4O64LbiO1sA21cfi26+5
    vFXZwp3Zak4MlfW7DJRfE1SMKfVBtBKwWWMvQ3SXZTqCYQgt+IJbnemY11L3UgbOcm5/Y+
    cCLVMBTiBiBBC38eA4rKgL6vuaZVLcZANMg5rSkJOTYHaGtonBElTjyIsOuJgCk4kGhzwV
    j473Zto42siKaHdQh/Hge+JNFaLpqBVONcZRDRuKF/mGL0PSyR3h/XUB+K1ec/ZTxtR7kw
    2Dp0k4n1Xy9TrC5DXq2iY/Ssml3Tkj4UJ56hPwVSX+3JcJOmiq5ON+BonCdog4OPuNmN+O
    BgimHaLLDwnbKqKrM86Y6DK2nPgttfCKLfWNr4jenGy2mFv5WSbKb2YmnDer/Dt7xM0DvA
    Vcg0W3hzLp64g+97EdeBv9apvD3zVrlRjtWe+BDnPtkrHA4viXiKJ6kZ3uLQ
X-ME-Proxy: <xmx:AR9qaokDCazkaVVbuukNVMaspO6d9XX3Tp0k28gn41pTzCCJZLM_wQ>
    <xmx:AR9qak9UZZ77h_vjfWTNNy5WKxe328oagGgv-hHhKB3cA84GWj5LgA>
    <xmx:AR9qalo5tLkH2Ix9fOcd2dHeHct4iXq0aaXkknRdH8nM25Gs0R1I0A>
    <xmx:AR9qalmPdD4FKjn6ncSMUQFqVl-qs-Sbtz_Y5vHXjUBHf0HtVnkh8A>
    <xmx:Ah9qav3KEsDqf4gnejVM37EqspSrYVGttN6-ujQXKO_vWO4e2i_3gqtH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 11:40:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com
Subject: Re: [PATCH GSoC 1/5] protocol-caps: add type support to object-info
In-Reply-To: <CA+J6zkQFAqZvi-6UaQi6v_OBiT4ihZtCN45vyGCGTbo9TJLJbg@mail.gmail.com>
	(Chandra Pratap's message of "Wed, 29 Jul 2026 15:23:23 +0530")
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
	<20260725-objecttype-support-v1-1-2d4ca3bbabf1@gmail.com>
	<CA+J6zkQFAqZvi-6UaQi6v_OBiT4ihZtCN45vyGCGTbo9TJLJbg@mail.gmail.com>
Date: Wed, 29 Jul 2026 08:40:48 -0700
Message-ID: <xmqqecglajnj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chandra Pratap <chandrapratap3519@gmail.com> writes:

>>                 if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
>>                         packet_writer_error(
>>                                 writer,
>> -                               "object-info: protocol error, expected to get oid, not '%s'",
>> +                               "object-info: protocol error, expected to get "
>> +                               "oid, not '%s'",
>
> I assume this is a style change? The original line doesn't seem
> long enough to wrap though.

A 92-column line is much wider than our usual ~70 column limit.

> Also, this would break the grep-ability of this error string.

I've heard this a few times, but so what?  You can still grep for
"object-info: protocol error," and will find it just fine.

>> +       cat >expect <<-EOF &&
>> +       size
>> +       type
>> +       $(git rev-parse two:two.t) $(wc -c <two.t | xargs) blob
>> +       $(git rev-parse two:two.t) $(wc -c <two.t | xargs) blob
>
> Can we not use the `test_file_size` tool to do this instead?
> That should also be much more portable.

Well spotted.
