Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1937104C
	for <git@vger.kernel.org>; Fri, 15 May 2026 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809115; cv=none; b=Q4AtM1o2GuNoiT6rjnS2PA4r6yjLtEkxRhJD92kj4kMYXMa+zxzwfmawcrHGutB1ZoP0Ho6mxsc3RU53E0WP3RrvCe0Y5rzaPpO5znfRFybKBvW0PFqb8JiQdhLdEG3qrO9dylZqPgAqzo0iylrGftZppsgdv62o2+XWekXV9Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809115; c=relaxed/simple;
	bh=XdlPtIva3W0amRAnJaaBF9Ji5VMcDo0PqQn4UrVeeh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q+tumFIWiIY/ahTvTFGwJ1abofqXqd03odkKUHQN2agP6eKWACzYvt3JQuYdGa4ZyS0nGUtT70mCorD+bAj/265jOjCZF8E74ji0Ybpgs/XQGqheB02K5oglUvth7yN9OxZvbyq3f5sy09b9xHpGPBS32/IEQJ/qAZsqrSET5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XWB/6HZd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B2hEfE1F; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XWB/6HZd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B2hEfE1F"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E6D9DEC01A2;
	Thu, 14 May 2026 21:38:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 14 May 2026 21:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778809111; x=1778895511; bh=5LxLmZjnTH
	b6GRxbSJNAC6N+K8axKgZ/eOQFhtfUiEw=; b=XWB/6HZdpE5UOHO7hEYg0+kN88
	I3uTppjBa3TWqiaMfuYSXpXIjrGs9PDN+TfPVGbI5/ucUkp8J6gEl8GsATUa0hg6
	OcPA//DnGxHwPeTnJg5x/RuwCkUW3uhbVTveucFATnqPJL8MmJ3rfiOay7X/jcrR
	NJepn0PcniD9TDeIGmEyMFrHnShZfy0vz4OvYC3RXb3KR1xyD8/y19iPG3xnLs2t
	k1kFN4Yat70R4oIcfPVIW5mfSzGZPUcgf7lxae0QpUUpHDIkzQdd7F18QH/pa9iu
	CAhgEC2XpyQTZOab7HMHXhLf552U1n0jNJn+grtSy9URdSqcs3VF4IlS48+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778809111; x=1778895511; bh=5LxLmZjnTHb6GRxbSJNAC6N+K8axKgZ/eOQ
	FhtfUiEw=; b=B2hEfE1F3rdZ/bVUXCUIVWf4VfsRIXiAlDd4Be9CFr54DETRetR
	b9ND4Mv/zx1EGoI4dEiPclXc1PT2nielk3+u3lfW69Mnwz29h24EoDqYo3HneRID
	1YgPRfPm3y8roNrmgAn2yXgy/dTa9abo2vCtc6mEyljMgkGiUytVDLtPXy+Ul+id
	vorNeHIZz2oLeiXQVttenJNKIJAgec4/E8IMuJQtTYB9yCDeLZICVqgHGhjjYyN3
	jSmhkWdtiTvir5cJ4GMzJhn/iZqi5p2O3bauv5Dj6NieuQ22h9Yx+x7/Ieze0yGE
	VvV4NVl2jxHRvtr6pCDC7fjmZXv4Xn/cNSw==
X-ME-Sender: <xms:F3kGakCqTlG5EhPieNYDsvq34iEK6kl0x8XFdUmaCoC-Qofx1fGEaw>
    <xme:F3kGati9oiHXW6ev_1zruq9aLIBpW335h248q-F_zAcsUfrIi7KgAw2QaUeQ6nwtJ
    FbtNFJHIX0Yf7Oz-8jwOTPteO6H2dVHLLIRNgClh2tiS63nwTfqDw>
X-ME-Received: <xmr:F3kGasny5EnOnD1HPdhJbYVsgKcwOM51Bdno6S-P26Setud2xRSLxmfTyQ36L4Co218bxBQPnrtUfeMwhavN4htw5tmxOe1CJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeluddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgrrghhohhlsehuthhurdhfihdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:F3kGapoDCCEKH6yVHpAvB0OC0XHB1wBDhCFomdEbM670_lXr7itNZQ>
    <xmx:F3kGalEa385aZdGTvjvw8fUH5Ybwfkt5XORuuYxYu47Xh745m3RFLQ>
    <xmx:F3kGalxI5VU6vLE3_EreWjne2VSnQz0bqGDb3bqY_5l2KxO4sp4pLA>
    <xmx:F3kGaqqKXZbZsmtbl4jJGwsD18yeyKAiSkLp30uHPXVAcm5Cq_YCJA>
    <xmx:F3kGapFTu2tGZ0rgpb88oScQDkAfso5KWC7AqFVcuieTVvVVonld-OHO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 21:38:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] approxidate: alias "today" to "now"
In-Reply-To: <xmqqik8pea39.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	15 May 2026 10:27:06 +0900")
References: <20260512145430.13212-1-taahol@utu.fi>
	<20260514115520.6660-1-taahol@utu.fi>
	<20260514115520.6660-3-taahol@utu.fi> <xmqqwlx6f1fo.fsf@gitster.g>
	<20260514210742.Yc6NZ%taahol@utu.fi> <xmqqik8pea39.fsf@gitster.g>
Date: Fri, 15 May 2026 10:38:30 +0900
Message-ID: <xmqqa4u1e9k9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Tuomas Ahola <taahol@utu.fi> writes:
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Tuomas Ahola <taahol@utu.fi> writes:
>>> 
>>> >     Sorry, I don't know if I understood.  Does the patch change the behavior of
>>> >     that command somehow?  Is there some kind of edge case I missed?
>>> 
>>> No, I did not think it was a good idea to carve the behaviour in
>>> stone that "git log --since=today" behaves as if it were given "git
>>> log --since=now".  My reaction would have been very different if we
>>> were deliberatly and explicitly saying "today is synonym for now",
>>> but the thing is, it is not a designed behaviour but what
>>> approxidate does for anything it does not understand, e.g.
>>> 
>>>     git log --since=decay
>>>     git log --since=bogus
>>> 
>>> all behave as if it were given --since=now.
>>
>> Thanks for spelling that out.  So, as there is no deliberative
>> decision behind the current behaviour of "today", the code has
>> to remain non-committed on that; we are not at liberty to codify
>> the status quo.  Right?
>
> Not right.  It is more like "Even though we try not to change
> existing behavoiur left and right without a good reason to avoid
> breaking existing users' expectations, we should be able to "fix"
> what is not intended behaviour but is something the code happened to
> be doing, especially if the current behaviour does not make sense.

And the other half of the discussion is that once we explicitly say
"today means right now" and make it official, it makes it much harder
to fix it later.  So we need to be very careful in our first attempt.
