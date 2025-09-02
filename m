Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75CC2E0909
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845213; cv=none; b=e4uVC58uaO7Ko3lBUQuBykgeqOk+r5ae5Hu9My13BSlu+R2+ZQsrsz1hKFPaOWLw4JLHYS7aefeSMez3L1TVMJLvDT74GyUDJ3GkEcgB6bSr56sn653nJyAfCh3/A0IgIl4b7ql7zVcZ4RPcyVY5GeB0OJ/0BuzfPsPjF+Xi+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845213; c=relaxed/simple;
	bh=2VK3GWs773qC9gPCmquQwAT3bo9nPgcJBPfPrfBNyaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TCQ8ZvzT5Nm3s5gIhLum37sEgcu8LZ3IHYUN9o5LCXvazFZExjDwsA8pjX6fZ4JoQO8IBlVYN+2atqiw3lMTiB7eBGth1u7IPWqgxrqMEHrkZrnnKU+Df9ArEjtaVejiW+Qpx4k3G2aApRG3R1DZzcq3GCici3f1nOR1sIlhBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=30JdBSRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XG1OhweN; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="30JdBSRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XG1OhweN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 936101400112;
	Tue,  2 Sep 2025 16:33:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 02 Sep 2025 16:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756845208; x=1756931608; bh=S3wtZq6t/2
	cJxBbaS1ou9HsYcDJahiuctYTqGNoqVNs=; b=30JdBSROcvNr01KRGsC7v/iSD4
	WBB9L7RMH+EHs5EJA1FwnneXV6spTYplJGU3aowiLy0lrqAB2VLaMEyd0yUvNhxK
	upIfZaTpT9CtE4RbfVSSQrYDVqfoeezatcyh9seXiTtyAXhnaygDQe3J3WdoXulI
	9NJepNWwh7eCEEuThQsZVoEfsLZ27JUrmi8fMofFdiBosuP7ZiLG59wMxtJTZPcq
	O8cLi18TDNvb77iDB18D3Wx5X4ecgzw5Q+rGeJkAMGctC+X7k1jeCjNI8wjc5kHn
	+5uC2DTBo2LWB8MnbRxuMPxNtam6baXHZFMRu3iMLuHB72JLrQkbLRvuArZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756845208; x=1756931608; bh=S3wtZq6t/2cJxBbaS1ou9HsYcDJahiuctYT
	qGNoqVNs=; b=XG1OhweNjJHIDmMqpXsHbtfJTCUYERhuSURtgmzbB17Xw2wwLNl
	r7AM+D6Y3GkUXpG16mT4oM1xPgW2OCu1PNfj1V0IjVCHJsf2jskG9QVROXIjX9BE
	z9TF9cA5U20ckz32+T2LEoRbmico+Gx3U9a9S+Xi07zGgbLkYtGCH4YQ1muLcU1+
	eDADbK6P2ZF4NeiOQBnT+J0WKOJ1hLxz1NfN3/gj1EBEWipeVqNbwk6+Heo4bndK
	uKKISlKGXJBDBEy7qLlYIKlhc2Jjbbn+WVwnoDXrcCla/cIKAEJOFZsmeALsVBpW
	5zq4NRgAIUV7hp9Zde/eCB26NHkZHeiw0Aw==
X-ME-Sender: <xms:mFS3aKTItaFBLqBZFHEb9pXqnhoIVQ1zdvbPxxUW2ZhMz7QEpyzZZQ>
    <xme:mFS3aDDOV5COrxCE0jW2g-BqlX_3qrWBft54QnHipgfnaV-5evk5KaIrfSC7JP3W6
    QtNjuL4JQlBtfmhiw>
X-ME-Received: <xmr:mFS3aBRurPVeBmneVNSp47HDWrR28Jo6YSLFU_yqfMZaxIL3SjIqCTsRp4H--OJnI-WD0FHxdZvumdZttJtNJmWjZPCKenrGXHS-Pzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhrghesmhhl
    uddrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mFS3aBpSIsInHALtIWTz_pA5SYvOsBO6HVeWGjvlhDVXwpFZWVxnhw>
    <xmx:mFS3aDzS6cQ7UbqfPIis2TpZPF1rJcUnPobAXn6EAv1eyvKiMxKW7g>
    <xmx:mFS3aGJ1ky_bfByZAr0Imgq-CxsgMYrlJmXJg5XTgvr4TDexlTnX6w>
    <xmx:mFS3aFLHxVJyMaufYUhQmDFMSsNH93vVkxH2fr9Fn_noHZ_h_NyEow>
    <xmx:mFS3aClxr1k3brwhmJKbatqLsQuxcVKfuN-7-jvhaitpc7iMvNC-vThd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 16:33:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: jorg@ml1.net
Cc: git@vger.kernel.org
Subject: Re: Still using "git whatchanged"
In-Reply-To: <6597b201-8087-462e-adc0-0ddaa8a7402e@app.fastmail.com>
	(jorg@ml1.net's message of "Tue, 02 Sep 2025 19:38:31 +0300")
References: <74c5f07d-6376-4787-a5e2-bb09abc58ce1@app.fastmail.com>
	<xmqqcy88lsw3.fsf@gitster.g>
	<6597b201-8087-462e-adc0-0ddaa8a7402e@app.fastmail.com>
Date: Tue, 02 Sep 2025 13:33:26 -0700
Message-ID: <xmqqa53cioh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

jorg@ml1.net writes:

> On Tue, Sep 2, 2025, at 19:29, Junio C Hamano wrote:
>> jorg@ml1.net writes:
>>
>>> apart from what's stated in the subject, I think it's not logical
>>> to use "--raw" when I want to see what has changed.
>>>
>>> "git log" shows me the log. What's the raw part about wanting to
>>> see what's changed?
>>
>> But that is what "git whatchanged" gives, so when one is so attached to
>> what "git whatchanged" does, "--raw" is what we cite as "compatible"
>> option.
>
> My point was merely that IMO "raw" is not the best name for that
> option. When I specify "--raw" on the command line, I usually
> expect the program to output similar data than without that
> option, but of a less refined state or kind.

Sorry, but you are 20 years too late for *that* party.  Once you
invent a time machine and go back 20 years, you can advocate for
different name(s) that may fit your personal preferences better
there.

But not here and not now.
