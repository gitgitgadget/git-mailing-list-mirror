Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994952459F7
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597350; cv=none; b=MH2aHnTZcIkEVX0GhC6v9UUArMucpgFqLZcknaXo1UT+mEuCRFbw7FazZLsYTANPo4xEWVSC7NkLKO38W3t/gECzB8qCQv7MplRMlexjIdDNqEl4NxxpQGR5+F6IJmFOh7jbqvRKqfNK7go8Ja9ryUJgBfaTU7DBw88zMJJaMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597350; c=relaxed/simple;
	bh=hAdhH3mstw0GEWeaY+zqSg0OSIpeYkS7hhX+/oEb2LY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tvxZJ8Likn/doaIgIy6YkUOYBVH1hZGwMNVGARwwvMs3c4L1pVlzs9mR8UFDILtyARhQxQ+fHr+588xYYNnrDv1x79DYba4NejcBvv5g9jF6K/YhgO6+WUR3mTgQyu/QKfShlxFVqX5r9vqNSpIc+iokRcfbTOvmcCIF4bv7rWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jazu8eOg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wli1qKwH; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jazu8eOg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wli1qKwH"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5EF817A01E5;
	Tue, 15 Jul 2025 12:35:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 15 Jul 2025 12:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752597347; x=1752683747; bh=uOlrJg3oJU
	ssVRflylW4kNnNKaMHfFMgiX6e5t/atxE=; b=jazu8eOgRARFOlVEYGEMPvFHTb
	yf2UXuKV9CaaL+R8aRSd7UzC5ujpSdGNopfR88pTc+ErMtbCOz3vwiOkfym0VgNg
	kUpu26Oj2/XLfRQKS9hNdEjpduOM0g/1zhqYf15r6o1vwpeahjk2yGgvfVL0z+GD
	IBm81gOqIY0uN2ApUTdtd0PWl1YBUmT2goFe5NhKWQP1UD3eSSn69r+4FhvCIC93
	syECig8NBtm4FgDNUYhgwpBuxibN1IIWOTPU+kQRJB6Lj/yYk5fcYsQEUzwA/tBK
	a31Q34qp1XIRfH9lzmRymU7xoybGjefYST682N9b8iAv7xvQi9aoGsm1vdwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752597347; x=1752683747; bh=uOlrJg3oJUssVRflylW4kNnNKaMHfFMgiX6
	e5t/atxE=; b=Wli1qKwH6IX7qEhlk3u6Mw6GhTI2iV0J9UoR4z4oifV/SAyte/+
	TBp/XCBNLmqnG4i3CBuO8tdJ0je4oN96g8Q58gJjtq3chfHEkN3c6ItNdv5YB2Q1
	tblKhKOwFjYi1qF+lhavLgYjN1pIUhzYDFtE2VPxbyJ07rGK/C/RY5PkX/iwhkxC
	M7EEMeFQwFh8XyJX651Ce4/LrheeHT5R4N6EetL2HFFGz00sJOscuHTSYPrx/RiR
	aql9N+VH9u67S81C6en6kSBskM79lzRP355GZoOSyh6qyTYAyQiy+8rBu3a2ECs/
	FsY6309/NEC9W7lOwjQE+kD9Hu6WngpTsGA==
X-ME-Sender: <xms:YoN2aKCWS8Ns34Ig4iDf7KOkArLeeqNiqT4Jy7mz1wsgA8PadESxQQ>
    <xme:YoN2aM88xvTHzn-5yC5PJfjAQ0gMZ_0FS69thY1J5jl6556P12WaJzFnVyyyk4tHt
    NhoZgTVXv6l4WR6SA>
X-ME-Received: <xmr:YoN2aOBNy8fg6WuDg8nMZBQqCsQhSvvm8zX3TqfQa3AoM4zFQ-wqxCK7BSb0Ly5sTszCCMwlioorCxJGRyi5hvqzv-jj8RmLhVEG6d8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Y4N2aJQ3fSp9rHps_kUqRNEkGw7-3XF4RzNvJr5ud2o1pmOWLP3hFA>
    <xmx:Y4N2aNvA37oDNRv3f41NoqRLZU9zkKheMAyEKsltSpGdLZlEr68yWA>
    <xmx:Y4N2aN1VdlryC98s14oYoe3Sf5zqDUOQmFhO9T0hAoQFY_2XrSgK3Q>
    <xmx:Y4N2aGUhEaJGntD6ZBQ_-Kmc_1C2mO2VSAwxu2t41VvAO3YRJscVPQ>
    <xmx:Y4N2aLiJhGcIXM_b-yRVueHx97XJI6POM_oq82QH9CiC0OFDp3kdZgxH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 12:35:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  schwab@linux-m68k.org,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 3/4] refs: selectively set prefix in the seek functions
In-Reply-To: <CAOLa=ZS6ASf1+nbUnCTeeH1Di=kgmhQUEQ5UXPZu051rfqx9Pw@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 15 Jul 2025 18:49:03 +0900")
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
	<20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com>
	<aG9hMP9gEFLhVgJL@pks.im> <xmqq8qkqvjnu.fsf@gitster.g>
	<CAOLa=ZS6ASf1+nbUnCTeeH1Di=kgmhQUEQ5UXPZu051rfqx9Pw@mail.gmail.com>
Date: Tue, 15 Jul 2025 09:35:45 -0700
Message-ID: <xmqqms95if8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> so after (true) seeking that does not have the SET_PREFIX flag on,
>> wouldn't our iterator-advance run through the end since it no longer
>> is aware of where to stop?
>>
>
> That's also right and that is indeed the intention. We're trying to make
> the actions more intentional.
>
> So if a user sets a 'prefix' for the iterator, all previous state of the
> iterator is reset. So, the same function for seeking an iterator should
> also have the same side-effect of resetting the previous state.

Perhaps we have different definition of "previous state" in mind?
So let's imagine an iterator is walking over all branches (i.e. the
prefix is set to refs/heads/, to allow it to stop once it steps
outside refs/heads/ and moves over to refs/imerge).  It starts
iterating and I see branches whose name sorts early in alphabetical
order.  I tell it to seek to refs/heads/master and keep iterating.

Wouldn't it be a lot more natural if it still stops iterating after
it finishes showing the last branch, iow, a ref in refs/heads/
hierarchy?  In other words, I am not sure why ...

> There could be a usecase where we add support for keeping the prefix,
> while also seeking the iterator. That would be an explicit change

... that is the optional and unimplemented feature, not the other
way around.  Is it just the ease of implementation?

