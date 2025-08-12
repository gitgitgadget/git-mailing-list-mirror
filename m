Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054522EACE2
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009215; cv=none; b=sGh/u8cW9dW/Ml02XRXj9uKNp2EzWLO6L9rrsB0N9JsOSNFTgFs+GAWK1K4A7CpLMjcVE6bK9nFXSLbDMsCatsGYrVLnSPfv8/CeoNgCAkFjjYDCJ9ClHuI2BQTZp58VfofDJAnM4kHl5xqmmALrJX0q2BrvEkJLn/T0IZ8aoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009215; c=relaxed/simple;
	bh=qoQnkFCgTG7bPBNJvHEsnCV4A+iG+fJkvlOwEh+0gyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HzMi0twHTBZXDIzPrsUuW9UQYGlGLnkdjwiacFD7QoyBziDWG6pIWAxgdcYwonpqSYptpaN3ghuK+Dfj1C4mn21VB+LKEpYKdtJwc3zVwahVJDLDK+NyqIY1JofvI5jFO0MWD48BoXwZqNlZpciH0mMr/ttQ0Fg+34bAZL79afI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QrLSvUWE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ekSfUkVp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QrLSvUWE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ekSfUkVp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E0ADEC033A;
	Tue, 12 Aug 2025 10:33:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 12 Aug 2025 10:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755009213; x=1755095613; bh=HHWHn/HH+H
	DX4cCq+rgLhFvUNrpDJtmYWirG9m2+TIs=; b=QrLSvUWEMuWnnZFa+1+eDeInPa
	v8fx5zAAFKmleensBIpBtdc/RsPWb7QLM1u1Oky1C5Kcr7FWXGG8fQ6KO/draHfU
	6JneiH1Ru68ZKD1KFq39iuVvD8tVhFwHTTllPBgU1EhDXTUcqRX0nYzu7ogjMZYX
	WNqtNIjwGj0P0S9v0U4vvZiysjFF795K03mI4bEeLYXjK3clptZTN7H0Udmmc/77
	LK+PZnTZ1XwW9mRnqYmRawCGEhFlPGCNQ+L7yK/eC+hjpZypOCgrYDexxbyRk/A1
	QofZDu2DzH+pRaiijmOyXV7yOaVGsd8MWzOMyPgtrlc/vU6gl6FOsq99aIew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755009213; x=1755095613; bh=HHWHn/HH+HDX4cCq+rgLhFvUNrpDJtmYWir
	G9m2+TIs=; b=ekSfUkVpsqjDUhYGCAKISEWsRQAxD5pLTL2Sq3EJrHy91lC7uCL
	GyxhLPFFTpVuofBWhrdpDLfSGxBnnPtyMrg2uIOylgwfJhj+Rdq8XnTAwWvFXq1u
	0HTkG/i5FGTf/tkPrXaeOYIOc7bGcdQhSyqHNWgWXw+b0PYjd9Jcjr1j3pSWfQM0
	1TbXpyZ+MLUFVRNUdPslmDF7YRtz1wP3qRPg6M4ya5dMLcBJGs2sV2n5eqIVdUnw
	DyPWmGWYgN39Rh92qCerYMfDRHHfD/SDf6S/UX0wK7PS4ovhE5j8iwR7ECUEV4xs
	PmN2tHhnBGW9sTlMupNAfhRaVpcC0WoeTAA==
X-ME-Sender: <xms:vVCbaC-iDZDKZWVFl6DV-hEfirr4q2PIsaT7A9P0DnxGvhQJ1tcbBg>
    <xme:vVCbaNRVwkhqAKzWjm6G8g9Tz_jfWQiDo8CuUZKK8WjTQoFubSeng_mj5wEuoyHq-
    B_yQuhCqQmaeTkYwQ>
X-ME-Received: <xmr:vVCbaEkRa2SBRUO1zOlxVgC4d33t73DbfTETFeYyvdicZJbdXdelIWwDICkusAP-kXBOCW0WnidUt1sliQupjpdW7ma32YgOLQFhII0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:vVCbaNQnq91lpyBabGIj8FbVpi5nlCptqz9gIvbQtgWn432xhJerBg>
    <xmx:vVCbaCO7rgXjpVqyOE1GAKvEosXVvi9P3d8PsIMnBjXSSpjx7xN9Jg>
    <xmx:vVCbaGUzts1VbTuy14wDTbS5aL_9rzW868Q3TnV-F551ivcnqqgM5Q>
    <xmx:vVCbaJeGCVs6TF-Kfk4fZb31XYQ13RteNysADdZv13wnnbDocS7o3g>
    <xmx:vVCbaGvDTmHxgPvKos7EejqUYWuL8HZzh4LpLgcAR80MfcRVpKsLQm5g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 10:33:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH] for-each-ref: call --start-after argument "marker"
In-Reply-To: <CAOLa=ZQGaZA=Yynv5JkYpSbYBczfVnemwmzABrqB6er19Utfeg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 12 Aug 2025 02:08:55 -0700")
References: <1a32a666-fcf4-4f05-a468-2afa07fa0e2d@web.de>
	<CAOLa=ZQqY8MDTs846mkVsxXrmOmC5O_sv6BxUHqYjGk1Ag+Osw@mail.gmail.com>
	<xmqqtt2d3l3c.fsf@gitster.g>
	<CAOLa=ZQGaZA=Yynv5JkYpSbYBczfVnemwmzABrqB6er19Utfeg@mail.gmail.com>
Date: Tue, 12 Aug 2025 07:33:31 -0700
Message-ID: <xmqq349wy5hg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>>> -		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-after"), N_("start iteration after the provided marker")),
>>>> +		OPT_STRING(  0 , "start-after", &filter.start_after, N_("marker"), N_("start iteration after the provided marker")),
>>>>
>>>
>>> Ah! I did fix a typo here, but your fix is better. Thanks.
>>
>> Here where?  Is that "fix a typo" something I should go around and
>> make sure I do not miss?
>
> I meant my earlier patch fa0f4e46f5 (for-each-ref: reword the
> documentation for '--start-after', 2025-07-28) which is merged to master
> now.

Hmph, so what does mentioning of your earlier typofix add to review
of this new patch?  We should revert your earlier change and replace
it with this one?  Or there were two typos, you fixed only one, and 
this patch ties a loose end left by it (but then that is not what
I'd describe "yours is better", so I am still puzzled)?

Thanks.
