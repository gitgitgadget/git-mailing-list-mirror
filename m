Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925FA2E8DF6
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246369; cv=none; b=azeZr1Q6/7ei2GJ2r1YrO1XseGvLOVKPTNBQFv9DTXDsFXiW0V1m5H21QCmHfhG4aa0smHXu3TUiGwIeQlJReDHMvizL6fP8fW26IvJ/MMqNIRBFLBjrj5zkMx8zDS4D+cbc79wIARDKRyfCzOazBA1/e5vK8dfsbQJsiuQQrJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246369; c=relaxed/simple;
	bh=i6dOmIS0VCc1dTCYyDsY/RK6hNi3DRMqLkyvyp0Mwrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aErnpTS0Ce3FKXpMielhgUsPLyNe6RSMNz6LEZm0WfYEZEGBj4c6LyKiRzsThd7s8bIhm2IXgTtzhrJHM0y93P3zrlX7AHZYGIqbjbJP8AWDu2wyCoL4GKhxKW7/avParoEASyg34VKqyhPqVNc7B0b7ZTwMSLv5jYS+aNRE4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dJJFyAKI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N8lJGwI+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dJJFyAKI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N8lJGwI+"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B7013EC02D0;
	Fri, 11 Jul 2025 11:06:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 11 Jul 2025 11:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752246366; x=1752332766; bh=TNDKGkh7db
	aNu7766BgPS94PfWCgblaynWFIeaYrr3E=; b=dJJFyAKI5JPMtYbglSsrEGiZ+Z
	Lfg57ypZ5JNv/pPBcqOybC38ShUCn8YSDyVskfQqa+SC4frRcyJm+aBoit6mEPYe
	lqAsQlCI3Ny9JB0bMbO6XmsgOb8sTt/T6DNLXzOR/BHyOYDaisfG+w8KPWnQmF4k
	Z7jbYdHVjzWXn61KonVZcUaNeyIXxUXmvhVm2CA1rOWv7v5aEt5dUG7LE3wxTr97
	GcevpEOa0azdEAMH7A8e4VxevOfD869hOJ6c/Jj/QsYImOn+lBU0kAkYdW+U+8qj
	aAQFh9kDsxgywl5FQpKvZSgjZzzA5BazG0aZ2rX89ZNpEjdBFQmNe5qyI+lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752246366; x=1752332766; bh=TNDKGkh7dbaNu7766BgPS94PfWCgblaynWF
	IeaYrr3E=; b=N8lJGwI+ZkIyAFXmk5wUudbNRmYpo3l5tB9ljUQgjXnhEkm0ovz
	r8o44dMHg+djm+lA32Fv38vsg3az15cnGlsxAAX+0/jomraxQkkSKifF7g2Zq5Mm
	i5ngL/EuR3Lmhh+t819w1xlFuxOFGdFUXkX0zjdbzqkur+ZBAYrUyKNU9lZUwlED
	ef5p3rSmVDCe9M5uwFXRmfqYTTFy1KGzE8MIYezFknI1tHB9QTQ0OKYvwRjmHhuF
	v+WK9RTA1rRmgwufsvaDbUm5ubRqDWI9yCn+l7usPve7wFgjIxqXcH/dNyDCB26A
	J8MNe8t1KmmNc9xInksCKqdn+38s63QA77Q==
X-ME-Sender: <xms:XShxaGI4O8cUbAr4cOgPqAkFGa74QfOQZ44OAXymgtW3Th6Y3IYrkQ>
    <xme:XShxaDghIodVY80liyoVRsKi6pavZ5KTUk0XYnpisrxqS9qXwSO-UmGfm044nGpXJ
    j4BlA2VHA7nDgzgSQ>
X-ME-Received: <xmr:XShxaG5bLX4BJd0BddyTJc8e5-QQer_1WjOxglIpq2cFcrV6ox2WRbpOvY4C9fFEBcQeLR15FTSctz_TjUDgZ7-7qEJy3tbz2cEUQVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephedtvddtvdeg
    feeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XShxaLZU78mqXDHLdHSu-X6CefPZfpj1sMPbE9N0i0e6s8Ke2l71aA>
    <xmx:XShxaL6_a3JmNOqzcejcktkqUHy-XyquOGSRVImWafdloH_278sXqA>
    <xmx:XShxaOAUY0LbZvsjPaLw2Zq_ezyZ4JerpAhllSYGOg5ld7o8WIPASA>
    <xmx:XShxaBd9bcvAjTgufuG1unZJA-rseSgTzMhG4a4zP_87mhy_vWH-gw>
    <xmx:XihxaHf6_ghDtTkuADAuEgU2NK2CKo6UgsqRFxN4Y0WH4HF-l35RCRRZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 11:06:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <502024330056@smail.nju.edu.cn>
Cc: git@vger.kernel.org,  toon@iotcl.com
Subject: Re: [PATCH v5 3/4] bloom: replace struct bloom_key * with struct
 bloom_keyvec
In-Reply-To: <1B012532-E1B3-43CE-871B-B850D86419B1@smail.nju.edu.cn> (Lidong
	Yan's message of "Fri, 11 Jul 2025 20:46:27 +0800")
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
	<20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
	<20250710084829.2171855-4-502024330056@smail.nju.edu.cn>
	<xmqqv7o06mw2.fsf@gitster.g>
	<1B012532-E1B3-43CE-871B-B850D86419B1@smail.nju.edu.cn>
Date: Fri, 11 Jul 2025 08:06:03 -0700
Message-ID: <xmqqy0su3gys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <502024330056@smail.nju.edu.cn> writes:

> Junio C Hamano <gitster@pobox.com> write:
>> 
>> Lidong Yan <yldhome2d2@gmail.com> writes:
>> 
>>> static void prepare_to_use_bloom_filter(struct rev_info *revs)
>>> {
>>> struct pathspec_item *pi;
>>> + struct bloom_keyvec *bloom_keyvec;
>> 
>> This new variable is no longer used, since the code to create a new
>> keyvec is in a helper function and its return value is directly
>> stored in the array of keyvecs.
>> 
>>> char *path_alloc = NULL;
>>> const char *path, *p;
>> 
>> And the "p" variable no longer is used, because the logic it used to
>> create a new keyvec is moved elsewhere.
>
> Will fix in v6, Thanks,

FWIW, what I queued have these two already removed from v5.

Thanks.

