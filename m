Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCBE21FF5F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075324; cv=none; b=f+krgDjXjY6FoULqFuTTlUrrkwzpsCkvlMWRbe4IN3oZMXfnM5RgVqMhXkhXe5DVLgt8XUxU5KrZrlNxZ8CHMdis3TJPqP7Cw9oXnjfbeMHTrCV0occt2KHnWGG7MhGElWG9LM7GH04Li3i74vGE69KNzfvC28VWKXBnh6JrKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075324; c=relaxed/simple;
	bh=baUoOHaaLTONuPNj5+YWGATTJn4+R59MAUf3iq8/zQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZNjFfhkd1dOT3X2gAFZTFYnNttD5PYSKKxCsjPGVSMI39DXWc5ZMKvg/XG0dKUOC3DtAIgb52B6S/Y05w6IAwnlVMO8U9iXGimxwhZiszmAPtovpB1cydRuwcEpzDHajUEtjozLkW86dJgXerG76C3xba/FD0zltFz0EKbA1fj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HO6BMxAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=glama1iU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HO6BMxAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="glama1iU"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4546E140003E;
	Wed,  9 Jul 2025 11:35:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 09 Jul 2025 11:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752075322; x=1752161722; bh=JVuE0FW54l
	RHtMdx2TtYt+dgAJpKigzDay3I4B7ZLZI=; b=HO6BMxAH/seQqX303fHvwuFnhF
	UqeldJ1Goi+nHskHjoYlVqJYken/+fGgvQQuAVg87GhPcOY1+jq/XkLRdYkJZnq2
	iZhsYBmMH9UQU3uSZjBHdpbf06mUEiTIrrZP2hrK15h8OT3AhDlP01v+7vX+xJAB
	9TOBG+zI/VT5CEVw8lTiDrLC1i7ULGBxWlsOihZXz98uoeE7Wmi79+XF+8fC07zf
	m+dFoBoOcPahxH5BJsaQKfIGz+gN6vQWSIHjcUEo1E9WjQ50JDrBpwiM4LLH/i9/
	dYt1dCjH74sUsfb74YjWKh7nuqmclRamO9BG4WQllStBwxKb8xYfCZrw3gJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752075322; x=1752161722; bh=JVuE0FW54lRHtMdx2TtYt+dgAJpKigzDay3
	I4B7ZLZI=; b=glama1iUy6EMmTJvZdD6n29ZO//blrRzM/c5s4+0syUr13R9Ye4
	3pYLVyCphjolDau4nuWXOk1FLK7JieCGk+ykZeP+8SSLbOXhPKq4UPKYFCBk8D0y
	QsMULJJ3EcczL2o+Ai2HpJpvY1ldjTGRrf+l50K7LWJTFGtnoqiGYaUEamrd7vCn
	VUK5Xft08D7ckpfHGGU9cYSiehIYTMkvViI5l0m7IrW5+KVJCVE8h0bpLdQ6SiQc
	AgwXf3ZG7Rio5Dqy+HOihB+ovXC60YVFCoBFx98RtGYN/EdC+lHdf5FOfw/ixXXH
	RF5gNeB2g75cENNe2OWuLYMG4cUObmC/0cw==
X-ME-Sender: <xms:OYxuaMYexNT1lbugjy5q4N76NrSb1-5cvkgAJiuvqgN4RUXcgtrE9g>
    <xme:OYxuaETTzGQgxftgj4swb_LWuwXGUY-u8GKGECsZqDyhxUQdpf-Xl1YvB_EjLz8le
    Viq95hnJWi283xGNg>
X-ME-Received: <xmr:OYxuaGvBQbnSJqpfzSQkFU4gHEkVdtGT7ZnWLYVFuRNg_qP5fpfod9kLfiU1G8Fp8wTgFtNu6BbYeOOCuR_3z3BEKNSlFsuFI_t6n4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OYxuaGGs6Y6kkJoSIvFAz8bYE5fww0SEEvngMFX4tqNmyW6PT2Gsyw>
    <xmx:OYxuaHxBa-PUBJDQa6FNgVETP0ZxtHQsK9iLNg_LQztr8wOaGZGsEg>
    <xmx:OYxuaA1G1-D8_UkvYTD7kitH_X2maLFXurTl4kRzLDAskzDaEzsS0Q>
    <xmx:OYxuaHpoYHY4sIyg1pMCa8wCniJDaMOTafTgVsbw7ppcVMcP1QlLzg>
    <xmx:OoxuaFXZ3W6QfVRJN6TO-dzH40La7s1wnQXDCLytKj9QUdgcNMl0ADLs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 11:35:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
In-Reply-To: <CAP8UFD1mgKT0AFuoYfisHMinP6KEDahcXCwiK6-wRFBKKymfsQ@mail.gmail.com>
	(Christian Couder's message of "Wed, 9 Jul 2025 02:19:06 +0200")
References: <20250618151821.528627-1-christian.couder@gmail.com>
	<20250619133630.727274-1-christian.couder@gmail.com>
	<xmqqbjpv1ucb.fsf@gitster.g>
	<CAP8UFD223ja7jKU+wb6TiGkc9frh5dt1rCJkOkk+O+J2MPokrw@mail.gmail.com>
	<xmqqwm8jxoj3.fsf@gitster.g> <aGy82TiRFcij5V_9@pks.im>
	<CAP8UFD1A+eV9hbmp4P3pC71+oSTrtLgxtWGyt++J8a+bk497qA@mail.gmail.com>
	<xmqqbjpuwsbm.fsf@gitster.g>
	<CAP8UFD1mgKT0AFuoYfisHMinP6KEDahcXCwiK6-wRFBKKymfsQ@mail.gmail.com>
Date: Wed, 09 Jul 2025 08:35:20 -0700
Message-ID: <xmqq34b5pebr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> And I totally agree with you that reviews often deserve very well
>> reasoned responses, which take time to prepare; a response that
>> comes as spinal reflex without much thought is often not very
>> useful.
>>
>> It really depends on the definition of "fast" in "fast response".
>>
>> If we need a week to come up with a newer iteration,
>
> The issue is that whatever the time we could set as a norm, like "a
> week" here or 2 or 3 days, or one month, or whatever,

Yeah, topic sizes varies.

Historically, summer is a slower season and these messages I sent
are primarily for me to keep track of topics on flight.  "I am on
vacation for a few more weeks so expect response time longer than
usual" would have been a perfectly fine response.

Not even acknowledging receipt of review comments was what I
primarily saw as a communication gap.
