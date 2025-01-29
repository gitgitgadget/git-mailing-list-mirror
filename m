Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3A6DDCD
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738193814; cv=none; b=fzfW/NLZt6h6vMoB6vzUlM5aExsCRnTAQPojw+2XQU8W5WmgnqR7Hc4IKKVFJGDnmbECfPDkf0WoU0BRfre6uTn9iCM8PjSiYNJHujRBY0fCX+0TKiMZ03jfuWSYo9YIcshxpzOQzPUY4YzneU//1MhrvWjETPWGxN0PdUf3dAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738193814; c=relaxed/simple;
	bh=meAuQ+cES4rLkYdJLGY75cfZtO9sjs2olUGQld+dcXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSKDGS431RbAs6zt7HIZyimAtVilQ/NUkxqQkLFoKDjZWTgmebB0T4C6CU70OIG5mV3gI2jyCFuEsJvF/Hss7qZ8FdJ5RNAGcWh+sC/XGjqZm2zDdl+L851L81EIZv8oo0tFKAF1YjqWVmJ5UlQAi+hP5+B+W2GJOgJ7c8Jfh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eQeLvNya; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jKLw2kmO; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eQeLvNya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jKLw2kmO"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 97664114019F;
	Wed, 29 Jan 2025 18:36:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 29 Jan 2025 18:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738193810; x=1738280210; bh=l4bJ3hHyCi
	Y9htiwYLM7a+GgytwKXZIzmCzE8ZJNwLI=; b=eQeLvNya17SgH0wFfWpT4InRF3
	40U/VOcdzg7fsNZ8iYkv/ritZirs4HLTdqYwye9mlZaQOy6w0di5CywayX91XZQG
	bvqUAVzhXW0qbJ1o5GLYhdzQ64byf/NBWyVjqFjwuw09zjkLY+xyeOvi4aHs+j3h
	Iofi0e0EMH56oaN3cyJYmvp2w2hQKG3GEbk/5LRiJzdtYUfwWfg3o8wFJgGKWOOs
	4sz8jjBWQlUN8QATndK0LG63IzhFQPzogyNfOl2us2KLI1/YlbJP2L4FfP7kU3mT
	Mt5hCHBoAT6BX4qxs/9E3ZXMTUQr1mVsa25Y5vzWC+BsYg6U5xbZR6lhXHvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738193810; x=1738280210; bh=l4bJ3hHyCiY9htiwYLM7a+GgytwKXZIzmCz
	E8ZJNwLI=; b=jKLw2kmOggz8e3ve7OY6wOj0qKeYqWcUluAak65tWFae8Avp7QE
	I59MqgZGK2aolxsyvAh3qb+sgmgMV71a3iogiYVXNO7yRJRXl43c4Ni4ClUkaoAz
	9B7QOIsxib24Gpf3cQHNawGocydkKD56j3/G1RZtuIXbmXPgWCd3+6Ef7LC+TRqe
	avOytBHZCqH4d5oJ9bBs9G/xRjaswopz9x23k10UTAFHH1O4mC3+iU43oQ9Ghgsd
	DPFcJa1rOqXmpp7jxIGfC3J2tWCPrusx+/K48b7RBFJtmMG+kdzHOFiUeTOkVbqX
	d7X3SoVIEWydrs7AiFbErGi2kheFS34mFew==
X-ME-Sender: <xms:kruaZ8a_bzoVYkUS3fFrRgq3AYyawYdZca0cqhUo6nToZog1BxwVHA>
    <xme:kruaZ3anXg7J6MRubTMG_M2Id8ENRXHvXXzFrLTVmZ6Jm139EjfxZNtaoO41-cXsh
    onDy08FEz9SDoeWvA>
X-ME-Received: <xmr:kruaZ2-p6dT1l7IjrzjzKN_kup30xlDllzRxkoCvZA8VckVHegc4u4fxZxhNUeGUk1zFW7DQSGSTwSx7CMA2nvplnBl1VVKKpsM7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeive
    ffhefgvedugeejkedtheevfeeigeehuefguddtjeeliedtffetgfejjeejhfenucffohhm
    rghinhepghhithdqshgtmhdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:kruaZ2pK7k7jMYgnHENkoqfq49porhrTZI2BO1V0MNyuRGgHYbOpvA>
    <xmx:kruaZ3qvTHQfoJpc0SUhRQ_IIwUNp1Z1QYB4eBEJp_VFMgTip42Utg>
    <xmx:kruaZ0TvrHuyF7FYJL6a54chyQBSC-1XMEvDFgOTEzJuhRWCJEKxXA>
    <xmx:kruaZ3qJ5gT2pzs6kt6AdWU42LWE4grbjZJL9-D3r_C3bQEKWBSRpg>
    <xmx:kruaZ2V5YhC_9YFcGrEZ3JswIVYu1wmMOHIFXvRPo4-0LhSDDXVAGbi9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 18:36:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [BUG] PREFIX environment variable ignored by git config --system
In-Reply-To: <009c01db728d$164a60d0$42df2270$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 29 Jan 2025 15:33:36
	-0500")
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>
	<xmqqbjvpk1wo.fsf@gitster.g>
	<008201db726f$6e6990b0$4b3cb210$@nexbridge.com>
	<xmqq5xlxidh6.fsf@gitster.g>
	<009c01db728d$164a60d0$42df2270$@nexbridge.com>
Date: Wed, 29 Jan 2025 15:36:48 -0800
Message-ID: <xmqqwmedgpkf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On January 29, 2025 3:15 PM, Junio C Hamano wrote:
>><rsbecker@nexbridge.com> writes:
>>
>>> The documentation on the Environment Configuration page seems to imply
>>> that
>>
>>Sorry, I am totally lost.  Whose documentation on what software are you
> referring
>>to?
>>
>>  $ git grep -i -e 'environment configuration'
>>
>>comes back empty.
>
> It is here:
> https://git-scm.com/book/ms/v2/Git-Internals-Environment-Variables

It is news to me ;-).

    $ git grep '[^_]PREFIX[^_]'

does not have any hits in the source, so I do not see how we _could_
be paying any attention to such a thing.

The description seems to originate at

  https://github.com/progit2-ms/progit2/commit/c24f22d6a6b0572f5756afd64f0c2e9fa6f804fa

that was more than 10 years old.  I do not know how reliable the
description there is.


