Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1BD313E0A
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686492; cv=none; b=Hh9oZIJdoWNvSFk6dJSdZq4OUadljmITgNCsle9RNBew56UIH9TUgs3ecweJyyxR1R8fSnzQmDNB+dSJQOKuxZ5rJev1qfptVdHHKb4FP9iH+S0iCysQFzgywAg80KOEOR0unaivWm2WLG1gXdpHAzW83WSCJHjSpVuh3Rl9e68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686492; c=relaxed/simple;
	bh=CJxjmTanj9tu2awq7IJrRElOzMs0jW8uRIb/gE7Q9OY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eud6oar2O95lyPCI59xo1gVlGwyPpb1GHpAqEsj9tV1jg/kwmBGMnO2Sdq6arYfl8mqhyTGIQHLPBgFatb6R/FOKZD7R852NzV1xKyzGs7idpu+MKAEl4q8+pWXM82GcvU1KezLbirKIq52BMBdphb+EnZc5KKeR9UWLHCjR5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rrUAwlll; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZWznlQY; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rrUAwlll";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZWznlQY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id ADCEE1D00335;
	Fri, 12 Sep 2025 10:14:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 12 Sep 2025 10:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757686489; x=1757772889; bh=2H9xss0idC
	KIaXKuBX6pV1Jdp6J+lRQDYn4Zr04FL/E=; b=rrUAwlllI96KpJcYyjWtx/AtuN
	aOFFLJYbE3pdfvswFwwcku58cgEadgqv8ApRpZIPKLtH6bajoD+VCCtZ0zomUuIS
	G5GocTbUtWI6DTjowrq6xjzZhe9YgMcPSQgT0kOkxlbZQVdhPG3u/xp4agJLuHwo
	JxSLjyh0p4Z7TpV+CpjKuI81Mu+k5wqt5jTNGg+ZynjX1Je0oKeKiV021F94oXwg
	sAfsu30sveEwWkkQzU/+IzzZ24tGJrwzXkQneKJrPI26xN5yfovwd93dw703ZEcx
	Tf0UCIn2bRIGP57oIlynWfhVmf7fa0hAgo4lO9mMVwSP4Rx8+CtsxThfIcqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757686489; x=1757772889; bh=2H9xss0idCKIaXKuBX6pV1Jdp6J+lRQDYn4
	Zr04FL/E=; b=dZWznlQY+76omcttUdsIGX0nuB9UR4DU8Xu7U/91xMlby3Rrkhj
	aujZztXzUv1549I6P698oHBYQV9Eo89XYbkrwDzA56WF7MlxjhMJLPAKLyd1flrP
	1sAXXGzVS2lZYpDRRQgc8+IGSlz1L52EFXNC6pmCo29TEM2FqAm1Q9Mhb4tZf+57
	SnfYT6z6QCz2IE5L5XWTAK3bYg6XhLbogQu3RnVlnqOjmM07oEb0NCaN74Sd3uAa
	TTOEKXNeP7IfyS9xjGrkjqFiGWF5RQJxMMO5RKnghOnzLqtgpBr9VegR0afVuO9N
	pfPUz2N4o0G46bQ7J1reW3aIzQtvstxYQAg==
X-ME-Sender: <xms:2SrEaPposOvvQBhCxU1ICg-7wQDTGJqJLcjWu8RldgbfNQ2xZrJDPg>
    <xme:2SrEaGgjA_Jm8X4eXsj62ZLmELfbPLdjoHWK3IN8zHd0nM66Dh0E3bjETf9vIcmnT
    DQrIsyHL_YFOHGRag>
X-ME-Received: <xmr:2SrEaL84kr4cm2vQhADB-H9MP74Ng0fyytswbKZctS0eGw1VUoukd1ZY8FJWuOY5VNCOucOC8uxVGZS2L5BPTWH9rEr45kgvQ57kg70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvledviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2SrEaCXz0fZyYJkigXlRUa4E8Ew8WjiZi21z4rJJm9teZ5bLPuBaJA>
    <xmx:2SrEaPB6lQWOhLDipMQCxhBQgI2-Q74H4kZVJIt9-bYlRwswL_OWHw>
    <xmx:2SrEaHH0X-sPiOM4zJ_cUYddiIsS_CNgV9xU6B_a2BuW8gSXBmwCig>
    <xmx:2SrEaA6BcDuFs6IkJJex5Ilft1gXVFNYB_Op470MFADpsj9FhdurYg>
    <xmx:2SrEaHmxpRtYyKmFuQDKa1uvPw442o_tSdPZHigPVZ2zALYMABwTC9Es>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 10:14:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
In-Reply-To: <CAP8UFD0EAuGdMWY2ff_kjaQnZ3w7VP2ftM6Y4Hr3T4HQTsFB3w@mail.gmail.com>
	(Christian Couder's message of "Fri, 12 Sep 2025 15:35:45 +0200")
References: <20250910080839.2142651-1-christian.couder@gmail.com>
	<20250910080839.2142651-3-christian.couder@gmail.com>
	<xmqqtt1as08f.fsf@gitster.g>
	<CAP8UFD0EAuGdMWY2ff_kjaQnZ3w7VP2ftM6Y4Hr3T4HQTsFB3w@mail.gmail.com>
Date: Fri, 12 Sep 2025 07:14:47 -0700
Message-ID: <xmqqa52zoizs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> ...  Was it so important that we pass a
>> broken signature without inspecting in STRIP mode?  I am guessing
>> that is the reason why the new code tries hard to avoid calling the
>> parse_one_signature() function in these case arms.
>
> Yeah, I thought it was cleaner and a bit faster if we don't parse
> signatures when in STRIP mode. That's why I did it like this.

I do not think parsing performance matters all that much here, but I
think it is a good idea to recover from malformed signature lines if
the parsing code can detect some.  It is likely that the user may be
using STRIP hoping that they can skip bad or unknown signature data
in the incoming stream, so it is beneficial to be lenient there.

> Now as it looks like we don't really mind parsing them, I implemented
> that in V2. In ABORT mode, I still think it might be a bit better to
> ABORT right away though, so that's what I implemented in V2.
>
>> An aside.  I think the warning message about importing should have a
>> word "verbatim" in it, e.g.
>>
>>         warning("importing a commit signature verbatim");
>
> In V2, I have changed the message to what you suggest.

Sounds good.

Thanks.
