Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2D261367
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714102; cv=none; b=r6JJJURJEY0oxtzwc3cxkBmOWoNlE3yFdRIDSDuVEvQs9NJNnHA7If/4yYkkhCAC543Xvl6nuvcgBxCkZKQGcncqZh7VBIJ6/960ngJjMu/Uf/n0aF0asDACRtQykeuK78n9rF/FRcgZYMlBS/Z/zIJjrT5YEhLJw1bYbObUl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714102; c=relaxed/simple;
	bh=8WTJD3xbjC7Ku/P/O1iulAvIh8LSi5dXj0llgKqbHcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k8DmdHNY1KS2RpU+FkoQa3dMba6xZq+OCz/fsdydOWLmU8VSkxg2q8QNU++syKAyCvYnv2X5FQtOdg3hCHkSkuWGw1645fbpZuDc2/YDNNCrByg7Fw6iJSmUXUgrEmBlljs0qQrtdyPh7M8dNwjPsGKskb3jd8c7srQNjAHpsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A3U/bBn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vW/miSG4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A3U/bBn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vW/miSG4"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 936161140136;
	Tue, 11 Mar 2025 13:28:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 11 Mar 2025 13:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741714099; x=1741800499; bh=8WTJD3xbjC
	7Ku/P/O1iulAvIh8LSi5dXj0llgKqbHcA=; b=A3U/bBn7jLK6uxQoSiI3dPbzmw
	QlmoFCm11WJKrYx1xZ/vIQs3Pvi2aX8P2L+qQ5TAQlVDWR2d8PrQQJ0EdIP6jtrE
	EnUP1/VKJAk8StArENE2BEum9BWTn8tEYxaaQ9geoiuyTAR72e2HpXjHRdu+e+9z
	mLuc2IU6CgTlw8o3fQ7RIa92Q6+rKUTJ3r2vJUHLnu8TENi55O41u/hiWbPF/kIs
	Zar/gWIlTnA1DAwLlNWmi4/mindtxGC+27j3ql2xSr7WsUy69CRLf8t4N8/Pv6Kk
	uOSJHAYrHOocAix/4Hl+l9MUZ/ljJ46YulBUyqwzSsXKzZzKpkHxtHc1ZNGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741714099; x=1741800499; bh=8WTJD3xbjC7Ku/P/O1iulAvIh8LSi5dXj0l
	lgKqbHcA=; b=vW/miSG4kI3j9reS1zYi/ldbtc1o2t1HqRuYjnNtyWsF0gzuZ4M
	ZuoRPnz4BFByBDAPL63skRbJYcw2aNxDnZKkGBIrwkUe3/940pS0WzawS7DcFW8o
	GCjnWwhFyZfUjWrp+fA/JEnnDcniq7hFufM58L7r8lejY0Oc21xSjtDQnofZ6+mo
	F80PzjZfajtxFRxearHrUsd6mGtta6Q4TBmsqeAKLlFR83I9pQ6ywSgCZCjNlIb2
	fwYSA3ZJqF8rcRptkFAr8xQ6BOX8SlNux5qs2ol48hJQVgw3L6QyOZ2jR0aIxi66
	sfTHzy3zUIsFxWnqGxlmBEvDs998aTDD2aQ==
X-ME-Sender: <xms:s3LQZ79R2Y__jeSMeGpUG3Cyf8vzfr_Z1AhPr0OcYlz9EM-TXXrb9w>
    <xme:s3LQZ3uEA8XaJLOOxM_zvDYOmMJy1ISOhVsLgWuQteL55IeNSGkAtYi4G_NB4blBb
    gqgrUTPzyapNf2Xvg>
X-ME-Received: <xmr:s3LQZ5BCSs6aY2U0yaKbGUPO7Chu_Lcv9BMRAeAtnwZanplwe5FHzGdZSZWh21LzOIe_A9a1q3IQWehGMO2Ad8jkymaMCHUKkNtH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegshhgrthgvrghrnhgrvhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:s3LQZ3cjDw8aMmeuGW_V7LVBPxHOZjF3v7eYKiYzcho7ay80YNaKXA>
    <xmx:s3LQZwPIRiPQtsj2PewYAvFTGo54xY0GlsxndT1Vl2mIhBOqmEf8yA>
    <xmx:s3LQZ5l3gBqOLde-BxB908ILUyTswaLUSFDAPkidgTJX3gX8JCPn-A>
    <xmx:s3LQZ6vzzxUzf5xzO0gH-esIDM-S4knRLfcs0-077XyomRsmUMS86g>
    <xmx:s3LQZ1rXnGrzml_dFnrtetzx0ltvy2FWv3Ffovka72Bjshx6ykjju9oT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 13:28:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Arnav Bhate <bhatearnav@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Defining timestamp_t as intmax_t instead of uintmax_t
In-Reply-To: <629c3c21-ab11-42c1-8cb1-34698e736db6@gmail.com> (Arnav Bhate's
	message of "Tue, 11 Mar 2025 15:30:12 +0530")
References: <629c3c21-ab11-42c1-8cb1-34698e736db6@gmail.com>
Date: Tue, 11 Mar 2025 10:28:17 -0700
Message-ID: <xmqqv7sf32a6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnav Bhate <bhatearnav@gmail.com> writes:

> timestamp_t is a data type defined in git-compat-util.h as uintmax_t since
> 28f4aee3fb (use uintmax_t for timestamps, 2017-04-26). It was introduced with
> dddbad728c (timestamp_t: a new data type for timestamps, 2017-04-26) to replace
> use of both time_t and unsigned long for time-related uses.

I do not think the object format and the existing object parsers are
prepared to handle timestamp before the epoch.

You may want to go back to the list archive for discussions around
the choice of the type back then, which should have enough
information to go by.

https://lore.kernel.org/git/20170228200145.ymbqmxwrbbrwagks@sigill.intra.peff.net/

might be a good starting point.

https://lore.kernel.org/git/?q=f:peff@+d:20170201..20170430+timestamp_t

gives 6 entry points to a single large thread that may be worth
following before tackling this topic further.

Thanks.
