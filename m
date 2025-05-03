Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62021BC41
	for <git@vger.kernel.org>; Sat,  3 May 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746293539; cv=none; b=h3wuyvvBQE0wiYM2gghKl7/KfDJteNJ9PQaeyo6CgKOz6wLjiwzsG0YO871qyRWvsRN/YPmcUDl1Y44rymzkByGumnwd5h+R4I3Pte7JDeXNZtNNSZL0PWSGvMafIl7NfEDivttgD58sHLOuieVuQPjbflb8Jd6RI8HkKjMSbWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746293539; c=relaxed/simple;
	bh=HllpEr2ffGnnEM542mRf/EQA1wblP1r6HUtjVLzUcsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ntRRDUXBevE1XCqy8pLbsE80FczE3MM1JgeEDnmd1zd1HoOSkejqYf9RO5kzIljwlKkFIck4AQr5vUGx5IJKSUoEfipt3Hz8PNXGn2e72mrrQFJ9KV+fofPqqjF99+fUxEkoykIqyMeNDyH6H81zF/6A5ZldvO/IbccbmNzVk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EVaRko7F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4F4rxGy; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EVaRko7F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4F4rxGy"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B5E6D1380467;
	Sat,  3 May 2025 13:32:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 03 May 2025 13:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746293535; x=1746379935; bh=JdK03kYyGg
	oq0XWPfEAeglPmVfZgzrt5dHiSsLVd0Qc=; b=EVaRko7Fsc8LTu8oVTV1SZMRp8
	XK2tztsKQufly/9YOOVr6z+F14IRNwPTKyXynyelz7fl34kyRSWWxhKfss3jlL3W
	QYYUW95QTkdArrREYvYAQKs1dU9O4/n/1rto9ECrj3/H1cNTlqNNc46DQc9ZXtZm
	Aa0XyGkVkBwaD+69Ws1AjzAfD1w6oo1DarPfaRbeZcQUD5M81KEM/Y6iXhgQsaMJ
	34cOezauAZVLV/Q9f8i9EcV+MJY41mIIMzD1i4CEus8UWqy5/oYzCedn9kcmRlK2
	Em6s3khGDP9ml3NeyV0Ru+zu1mHnfo8nxMjq+0GvqtW5kmEznXtmkn1xGnug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746293535; x=1746379935; bh=JdK03kYyGgoq0XWPfEAeglPmVfZgzrt5dHi
	SsLVd0Qc=; b=g4F4rxGy9eE4JSqCz0fr1cNITZTjW3Weupca4+LumPTjYHgI8cK
	e/wZzDybTbbVSy6zaaUdaGmhCuy/tPeQk40b7UxCnt/6iM87lLz6Bsfk00YuuMTS
	iexbyuSj0NjLy1rqbyX3Y8Y88UGeIKCGG1vt+xq2CixZI8xOdDaDY7SXj+ApPDvR
	XmnjDB+YmgyAHTGl1gVxD7aZ1tNVsgvIkq5Wil0JuHMstd/J93Nn5Ac2Y+oUbjWK
	vbW5WgL+iwIGNjFyKmmE0YCwsi5dOBKkK5fnNVRyQ9POjC92PWb+E/pGhYkSflUm
	IyCyndv/fGjE3nsGUirSY+XIHI/LyyPDFkw==
X-ME-Sender: <xms:H1MWaFUDfIZJJxMz-IjD4ApXFSQ2RTf5IPTrg9ooF8NWX2mU-LveJw>
    <xme:H1MWaFnlHb6MSvcpwpZEewM6xM-D3J_mffD5jDsn4QoWD08Nf-y0OwIqwHdZpXif2
    qINd9Sy0Y0y9qV-1Q>
X-ME-Received: <xmr:H1MWaBb1NGI6guOazrHPqDYjERb1XNj1xfNOkH0IRDxEdJ5bnoPJv1Id6mSlJPdSwWQw67hfOjrZJKM_ThSy9737AVvzlEvaB4Br>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeehleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptgholhhlihhnrd
    hfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:H1MWaIWK6a259cWK6DPENHLkOIZGXufw3NegMUG-GxBJhmTB8R2TRQ>
    <xmx:H1MWaPk8wyO1rAV9ni0xftHSHlXDBDRANfJN0_YIchXxjmM4ierk5A>
    <xmx:H1MWaFdIW0elcMPSZyjcir8m4Cs0ibbg1R7R0OJ9jPePxP9x9nU43Q>
    <xmx:H1MWaJGIrfnEh0TON_z5bOhToJe7cc3WBCv-7IDVD-YTAWKdGyjhug>
    <xmx:H1MWaDyvSEgxL2NUpCGyVbKupcA7Ox1hk4PUUwrSQ9wY8EP3ux_1683g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 May 2025 13:32:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  shejialuo@gmail.com,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
In-Reply-To: <87jz6ycojo.fsf@gmail.com> (Collin Funk's message of "Fri, 02 May
	2025 21:21:15 -0700")
References: <20250502233403.289761-1-collin.funk1@gmail.com>
	<aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
	<xmqqtt62sdv9.fsf@gitster.g> <87jz6ycojo.fsf@gmail.com>
Date: Sat, 03 May 2025 10:32:13 -0700
Message-ID: <xmqqjz6xsiqq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thanks, both.  Will queue after fixing the proposed log message a
>> bit (the sample must be indented, especially when it contains lines
>> that look like a patch).
>
> Yes, that looks better. Thanks!
>
>>> I suspect we'll also hit this on FreeBSD, which has a similar issue in
>>> that it returns `EMLINK` instead of `ELOOP`.
>>
>> I won't expect Collin or you to redo this patch to cover FreeBSD;
>> anybody with FreeBSD box/vm can do a separate patch on a different
>> day.
>
> It is no problem. I have access to a FreeBSD 14.2 machine. I can confirm
> that it fails with EMLINK.

Excellent.
