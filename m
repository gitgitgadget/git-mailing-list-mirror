Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47B79CF
	for <git@vger.kernel.org>; Tue, 20 May 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759524; cv=none; b=clKPyATrF33vOe4hrm1tRFYLzml12ZN3RbG1J1pZ7TDhC6W9AtZ3sdf/3+/RldptSGCONWXn4y9uMibYWBlOc4jAEGsK6u2IJmbhtP5Tvm6jt7100kenxrN8yK205Zwb/Sch2YXuh0Vql08kIAutJEA+2wlQxpv82KFk+mVpHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759524; c=relaxed/simple;
	bh=7BND5TQivY0Q+XAE/Efmj7viqqyZLE0WDP9U/wmM5wY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PkfE0iLjqJarihjH3t6OrI3Gsn0GWMC0zKaGeDadgmSJ+0F5/gqmp9wmGOlr1mSpg5xduS6+dfF3AjHTpx1H5jtLDcqMRClNRelc3Xi0lGTrg1ksQBH4QI90TdjpHxBQlDL1fTs9Mx/9QH7M04gSqA3xOjv1SIwnpjF8Ig31BZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LsRHPMZV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t8nIpu4B; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LsRHPMZV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t8nIpu4B"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F2D5B1140156;
	Tue, 20 May 2025 12:45:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 20 May 2025 12:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747759520;
	 x=1747845920; bh=uFiwQWtdVZDjhf+dgP4bV8r3x9O8l1gpmsftaEoCQkw=; b=
	LsRHPMZVa09Kc0qs9+cecyCbgN9SUxPtG2s2Azy4r+DpStNQX5YydO4pCQkm/bmf
	BZsOuoLLGwPCLIWBhgEvG9SRs4bhC3+Tt7qdtnDE684BEk/AVFiLWvC4R1icsKw2
	sQP9XF2ny7hQx6gmu68KJCS6A7zto+yYYFjBHQ5+K9tGusdrjG0Y7/3FcqVb9xmV
	X5xmNbe3bqeP2cnA6SZPNWMhS23dTvrS0jPlQSaL71cQ5sORTlRoC1+frMhJP7Gk
	Eb9C9Cgx6dYBSDV0a5gMPZ/2zoPT5ih4zBnJM8fi6I4V4pDJwGoWjEkn/cvrukPs
	RZ+WwldmA8mEsCmbSOeAdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747759520; x=
	1747845920; bh=uFiwQWtdVZDjhf+dgP4bV8r3x9O8l1gpmsftaEoCQkw=; b=t
	8nIpu4B7rCqWi1Mw1A4pWvBRCnxmyvjvbQN6Sj3UCw08iH3IOQZGFQxcZfqg70MR
	x3fXybbNNFr4YL8CFPBGcJv6+NIGWn4Pt33cQzBp+p+cJ0MEsftaCdWqpzCG8dKH
	LFIlrlz48pICjqoXQvZvSdk06xuCFaIInVwZlyQzjlsMjb477s5LtxwPohe5Lzga
	cRJK5xB7ZOkuimRcJWlJ1XcTvnX874TPoabyVT6dR21mXClx1KZlt3O2ixFwif1m
	QSarARfDfW8mzXwKDXtai9hdU771BbHMeUNRR9NUd1BzDobJk9haIATe5HybbbBj
	8kLvhu4aIIcc86trgSBEg==
X-ME-Sender: <xms:oLEsaJE-drqhApX1qMSZlz1qaEujjqM_QVH-NPWBjWdKVJMxRQbcCA>
    <xme:oLEsaOUFMVRECS1OJYNNkMgL6-mpnShQzaUhagHxerZH1fXA2AUa7cpBGF65SovDV
    hZN_9NP0hIjZ7ZwFA>
X-ME-Received: <xmr:oLEsaLKYp-BUfebaM1DDEbsOUWns3ex20n8OSuRIG3R-KTggqtgobYf9EzJYNMOxh_ZMJPixraLmpetE-TR8YyoAxNh7t7ksnfTOslQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejfeculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgf
    gggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhephfetvdejhedu
    heegleehfeeivedtgeelfedvffdtvedtudffieekieeijedvlefhnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    ejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhu
    uggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oLEsaPFbh59nD3ARtaEePGuKq4xEF__wY_RbUTXzw6R6aXlNYd2DUQ>
    <xmx:oLEsaPVvrIVQwdRku4e5-oMuwlnrmLnirwvrUwQwsn8xBwxAtPhBxw>
    <xmx:oLEsaKNlxAMQipwvJN7oqycIXZvR38renFuePPAbslqPOyFqiMVpLw>
    <xmx:oLEsaO1J0YzJE2Ps5e5kqHWrISCOm1LmZN2HBqvnxOXCbvshLupSOg>
    <xmx:oLEsaOCZV3h5N6I3eGa-HxtSdEDWQtpUHR6IPSstFIUA2q9JS85UKcM->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 12:45:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/5] promisor-remote: refactor to get rid of 'struct
 strvec'
In-Reply-To: <CAP8UFD2XtyPD7b=sE+t9d-kyXDt4hYMqVotwz7hJZEO+5TfXGg@mail.gmail.com>
	(Christian Couder's message of "Tue, 20 May 2025 15:32:56 +0200")
References: <20250429145243.992252-1-christian.couder@gmail.com>
	<20250519141259.3061550-1-christian.couder@gmail.com>
	<20250519141259.3061550-2-christian.couder@gmail.com>
	<CAOLa=ZRnL_PLVpQrmHPMXtJd9e965B5iz8widkk5GNSDvh21Pg@mail.gmail.com>
	<CAP8UFD2XtyPD7b=sE+t9d-kyXDt4hYMqVotwz7hJZEO+5TfXGg@mail.gmail.com>
Date: Tue, 20 May 2025 09:45:18 -0700
Message-ID: <xmqqr00ji63l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, May 20, 2025 at 11:37 AM Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> [snip]
>>
>> >
>> >  /*
>> > - * Find first index of 'nicks' where there is 'nick'. 'nick' is
>> > - * compared case sensitively to the strings in 'nicks'. If not found
>> > - * 'nicks->nr' is returned.
>> > + * Find first element of 'p' where the 'name' member is 'nick'. 'nick'
>> > + * is compared case sensitively to the strings in 'p'. If not found
>> > + * NULL is returned.
>> >   */
>> > -static size_t remote_nick_find(struct strvec *nicks, const char *nick)
>> > +static struct promisor_info *remote_nick_find(struct promisor_info *p, const char *nick)
>>
>> Nit: while we're here wouldn't be nicer to rename this to
>> `promiser_info_list_find_name` or similar?
>
> Junio suggested this name in a discussion of a previous patch series:
>
> https://lore.kernel.org/git/xmqqa5bbq0nb.fsf@gitster.g/

Don't blame me for that name ;-)

The name was for a hypothetical variant that took "struct strvec *"
as its first parameter, and the name was given only because it did
not make much sense to call the helper after "strvec".  A function
name that signals that we are finding (something) using "nick"-name
was a much better choice.  Since your final one finds in "struct
promisor_info *", not a generic "struct strvec *", I wouldn't be
surprised if a name that is about promisor-info (whatever it is)
more clearly describes what it does.  If this is a file-local
helper, promisor_info_find() or find_promisor_info() may be
sufficient, if "by nickname" is the primary and only way for the
application to find an instance of promisor_info.

Is promisor_info primarily be found by their names before its other
members are accessed?  If so, I wonder if a strmap or string_list
that uses the nickname as the key with a pointer to a promisor_info
structure as the data more appropriate than a hand-crafted linear
linked list.

Thanks.
