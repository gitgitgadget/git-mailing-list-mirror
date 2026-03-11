Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3766276058
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252483; cv=none; b=LdM5Gky0Xa7MMthEpUaUZ6oCs6/PZ94BXQSJsthxXhMywLnQ1YW750aipr8ua1A3zWs0VIeOUErPxx1215P5axupWR+CARxvn+Kise4yuwOEvDoIpin8RzXhUiY45ob06SGcQUf0FJHurZTQnSHwwAGpw1fqOLINe4+Fw9ubRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252483; c=relaxed/simple;
	bh=9V/8XtrWXYGvV5VxV4aPpjn+OyxYRVtw+6Fg5vvhpCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KuV8l7kZi9zFMQWsEP2MPei0+wTYe1NLWiiuFdHQh33cHh1mYDrRX/lRBrKJTPlgZrYO9lhYXy9q5tnGq8DB56iTbfYlaasSCfsVI+gveQSQjamWbr9DT1g5sovpb2DUXATCYUFDQIZZE5fKulx15DqKfixhDg9PdbBsDgSWACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BgCK7VOU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ym9GKLVh; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BgCK7VOU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ym9GKLVh"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B78DD1D0011D;
	Wed, 11 Mar 2026 14:08:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 11 Mar 2026 14:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773252481; x=1773338881; bh=o//TT+xlvP
	hq95z9Nj+66Ddv0OaQ3uknVaiMqSQ7xCU=; b=BgCK7VOUMzYj9sQma5voBs7UWq
	fT9ysQpHiycAa0DhFt+HQ2ZPpEHVdLSI49KNKjYwhHP5MVHzP27p8EXkV3mnWA8E
	FsrCSZZ94QRT6y5PYzlGFcZBQojcbErgPfQp7/PndTkWgMYUYRRBszfNzs39EMKB
	aAE8c8QdcO0clTSIlTTFkV8L1vhHm9AG8HQeLqWOoMAPT0G/+JI+jzpKQnHoYDuA
	X0xE33wP1iLxk/eensPPEFlKxLgwy+K6nVS1h6Q+uIbkUc9ibBrLc1wL0503fqr6
	S/25cDPPVyo1ZloJEI2J1BeqmhBkI21/6NNBcv47Y0rWer/RoNZoqoLZLV1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773252481; x=1773338881; bh=o//TT+xlvPhq95z9Nj+66Ddv0OaQ3uknVai
	MqSQ7xCU=; b=Ym9GKLVh3H0ToiawaL2ybZHAJ1BEKoWz92sBhScexhS7QCX0Rxk
	ZwiCK6xB5lx36xgcXP7+MaM32SrAAoj3fd1JXqNlKHgcScxWkY48nPyDD5TlRIee
	V75FAlRZqrn07YdKC+JJcR/X1Gmgtqk4HDBc51rGKJDfbb/PwwDAhJFKEJPZi4h2
	lWx97iWeXCcizWQnGREADe4t0cH6N0UGmWqwPpyTqWTVHxopBqOgC3xABnDkmMRi
	7+PmA3bW5XhRTCbNipbgG3m35l+uQkzCwjloQTvxpR4cI9javOz/kQecJDIoCm6S
	KkrwMNfU363p6yNGnEsiM9Fi57MAholYjMQ==
X-ME-Sender: <xms:ga-xaU6gx6mrsDH_Eg0rUjTpaUUCSkQl74j9OjYQim9KD7Gk5LpeXw>
    <xme:ga-xac4VHHOtckgJRWLE41_ZI6phiikfry2L_zdZcRRnePbLknXmB9k_18eJVjQsb
    gFfaXo_9YaM_umLc1y6ObcSwdHNsReGEVUtQ6unJhyjFX6qxEBz5Q>
X-ME-Received: <xmr:ga-xaYdqXmo2F7zd4GhHNz9uU3LKlDL-BCgFxHe9Y0DwhEYHf02awi8MX6EdU2aXOReqiq0aqKYRLTf-NU0GOKyhEaPg2HAcRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepuggvvhgvshhhihhguhhrghgrohhnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ga-xaYCzfD07SfeEPG9VDiYgZxFWhu2DtDjtihbPZtvXkcIBeCKCrw>
    <xmx:ga-xaT-jnl79me1duqm-lm301TzOdGoatB3PW2cNe5jsmEhOS6pDUw>
    <xmx:ga-xabJp4D4R-fKFWwY50pyRN3ogxkv9lNMJ39yhxAUzfO4v5Og9bQ>
    <xmx:ga-xaUgAhrhyyPvD-cb8yTu2S2jqloVuT8vIv4gV8giPMTV4pxL4rQ>
    <xmx:ga-xaWaiKzo0J1gD7IRDvP8YrTKGeD623AJvVMmnFf18Zi1pTeFW96rB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 14:08:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] list-objects-filter-options: avoid
 strbuf_split_str()
In-Reply-To: <20260311174548.GA1900488@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 11 Mar 2026 13:45:48 -0400")
References: <20260311132041.12044-1-deveshigurgaon@gmail.com>
	<20260311132041.12044-3-deveshigurgaon@gmail.com>
	<xmqqo6kuqqje.fsf@gitster.g>
	<20260311174548.GA1900488@coredump.intra.peff.net>
Date: Wed, 11 Mar 2026 11:07:59 -0700
Message-ID: <xmqqo6kup7cw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I don't think this is quite right. After we skip the first "+" and "p"
> points to the second one, then strchrnul() will find that second "+",
> not NUL. And so we have a 0-length spec, and feed the empty string to
> parse_combine_subfilter(), which complains.

Ah, I misread gently_parse_list_objects_fiter(), which makes a NULL
arg a silent no-op, but fully complains on an empty string.  Thanks.

> But yeah, it is somewhat inconsistent that we complain about an empty
> spec in the middle, but not at the end. If we were starting from
> scratch, I'd probably forbid it everywhere. But since we allow it in
> some cases now, it may be worth being more permissive.
>
> It is easy to check in the loop, or even just teach the helper to make
> empty specs a noop:

Yup.
