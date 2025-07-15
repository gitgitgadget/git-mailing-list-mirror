Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B8288C9B
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605624; cv=none; b=lAkbhw0r2A0VyezcvXHQPKgsfIaE3pb2GGew/2RW38RIntAf1OWSI9LavQPcv1xzLT62XFE9afW9O+WBMBEFELu5W+k5QeQnm20LsRanjMb+Sq8gsgTyinLPo6/4bHeMzN6Nxt4HkXcXn2PKS4DWV2EmkrN/nhjIWqJ0k/Z3mrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605624; c=relaxed/simple;
	bh=nTzjsa+zQ+P/4YYNbi9dgdv+51EQtlkwu9Y2ydq2oYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uciKJy4rx/R9ZOgclX3nde2NVLfPPJ3GtEsCIwVZ+dyX0QhvDDAKVYVDogVcY3o/BANjp9RSw/Zw/A8wp7bbmPoUdXNcUHJ207Z3Gu53goKD+ehhPYC6bAlyEBwbtp0t9PULO73fDkJ3tywzhFk5uBWhELVUxX851KE0DmFkX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZcJtnk2t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cAfCN6Bd; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZcJtnk2t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cAfCN6Bd"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B84B7A0280;
	Tue, 15 Jul 2025 14:53:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 15 Jul 2025 14:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752605621; x=1752692021; bh=G/h7m84qq+
	I+Y+pDhvBuXHaollvwfqo4H/8M9298RcU=; b=ZcJtnk2tTA0XFFd1vT3H9GIBzw
	lP1Uv6RbTsg0fGiLvnE1BF4TfL2/U50oMY2/mCk+Ie5u3UfqQmlObFh8Bxx0eXoU
	eXFVSGRrXIEF9YKj5UubrbDDaVfkt+220pjV1WQgsD1tyfcFuzuXLu3kNawD9CYl
	idpRGk3qtHU9b0deJvMBR5d6Y79nX/svU9RWsE39sfOA+z2jLCseNCnWpQMwKlCx
	UxO4oKy812dMhVJz76ES382yPQwpvZHHBj4IqRGmVCl879Gm7N0BGyim4++aBPp2
	voP823oqusYP8ZSFNO5wlgUEopCtq4dDreM/M74H0LHUSx1vRU1KQoj0wWig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752605621; x=1752692021; bh=G/h7m84qq+I+Y+pDhvBuXHaollvwfqo4H/8
	M9298RcU=; b=cAfCN6Bd2DAALmX6dkYHLAUnbBmhpGcEH2JP2tMVqAz64qmhLbL
	Nw0agYDGR4JrOush1Qyd0shbRb4O2ojoTw6P+fu6oDGkK2f+YuIySOJkVnWdsbng
	9rKcPKCQxu/CZSba8PzuQGmuowvDv2g5gn8LThI4dngO0euQKQAfQ16Le663V48Z
	2GLhQA3iI+Figfqeezms12RzkDT04nVBw2or+6I+GQ4eY+FtgO/N8ZgO6Iu+uCOO
	00a/iz0eE1MhWDn447eUttoOWHW73PUuEIzU7wynAy7XgLrFxOiGQyC/SsgsLIp6
	Y7pszvLTf5dSNPy6SCZ6nNALK5lpJzkACPA==
X-ME-Sender: <xms:tKN2aL7WvRwO-aEDGRfD5CwyZoTyQElLPGcqoQ9qFSPUIn84G7wtFA>
    <xme:tKN2aEv3n86mxgbOqw7OY4HoZGrbE--Lpvt0LAOBV1W0XJzJQi1tVSmMIgHisG0H8
    xCs4nvQCQOt__pMEQ>
X-ME-Received: <xmr:tKN2aLgMuwfqujWiI8FG_nJVWAGbO_aHJxMZr6DYj0tRRvFf0lagjw916CmtmeplZs9pRht9JWVcdHpmsZqP4sHMxGyPYoXg-I6CAfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfi
    gvsgdruggvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tKN2aPoVjBVGG4TfLpwN9RsIkf8d_9b8ZyZExe7_vocsvabsTOzVIw>
    <xmx:tKN2aIvyRKXSnEr7vp2wSJ3AsSyojUVuKKeZjZ1af_BiX3vYK4-z4g>
    <xmx:tKN2aCbl9AUzU8ri8qGMaD1jMZRTpcIFDRlUmbJOAK5tHIVHQWXMmA>
    <xmx:tKN2aPbSFjfq-tONQcVEYmBa9EzZTMa5DrxKOqKRFuOhzAc2Bk-nSQ>
    <xmx:taN2aNNrNHDQWI8y6jr-IBSwipdtPcxakN2B3th1Xzbpn6yYostNSQkD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 14:53:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  "Brian M . Carlson"
 <sandals@crustytoothpaste.net>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] C99: declare bool experiment a success
In-Reply-To: <CABPp-BHoTxT1UQtgy2bH=mc1re_LPngKX-50GPh_wbtMMZZpyQ@mail.gmail.com>
	(Elijah Newren's message of "Tue, 15 Jul 2025 10:19:27 -0700")
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
	<cover.1752587571.git.phillip.wood@dunelm.org.uk>
	<CABPp-BHoTxT1UQtgy2bH=mc1re_LPngKX-50GPh_wbtMMZZpyQ@mail.gmail.com>
Date: Tue, 15 Jul 2025 11:53:39 -0700
Message-ID: <xmqqtt3dgua4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>>          Since 8277dbe987 (git-compat-util: convert skip_{prefix,suffix}{,_mem}
>>     -    to bool, 2023-12-16) a number of our sting predicates have been
>>     -    returning bool instead of int. Now we've declared that experiment
>>     -    a success lets convert the return type the case independent
>>     +    to bool, 2023-12-16) a number of our string predicates have been
>>     +    returning bool instead of int. Now that we've declared that experiment
>>     +    a success, let's convert the return type of the case-independent
>>          skip_iprefix() and skip_iprefix_mem() functions to match the return
>>     -    type of their case dependent equivalents. Returning bool instead of
>>     +    type of their case-dependent equivalents. Returning bool instead of
>>          int makes it clear that these functions are predicates.
>>
>>          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> 3:  7eaf8042061 = 3:  66968714739 strbuf: convert predicates to return bool
>> --
>> 2.49.0.897.gfad3eb7d210
>
> This version looks good to me, thanks!

Thanks, looking good.
