Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E021B241136
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927996; cv=none; b=nqvxmLFD5GZR66tuPGZreEHUQeAvObC/rHHfm4ZfVn4kGgdn420Hmk7aLe2S2/UMcMLVf5dS8abLe3EGnRFDEqL96kTE1APH5Ri84rJKcHkNOxKcUHora7yxjqrVfUZ7bN6MB7OpZmbp4o0P8ybiiiAiu79nxgjS3knjbrMgjwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927996; c=relaxed/simple;
	bh=sR85VH9Lf2m5IEjj8n6JfS340wgQ9lUi5KBu8FFow7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ksmkEE3fKxG2natXo3FAV+wfN+afDvJhkdchO9R2Molt3RSd6oNY8siZgOPsiQtpgQJ4uyEKk7FifhYFbuMRgpbZA6qlzhVEv32QwL5xiqBD7+W3h60qD15+W57SF+P9m3oaIA22NOcpE/K/KGL/E/XIggtDfdnCABE8eG+ZyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PsX1db+D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zy9oROm9; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PsX1db+D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zy9oROm9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A746F1D00098;
	Mon, 11 Aug 2025 11:59:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 11 Aug 2025 11:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754927993; x=1755014393; bh=XRQ/yf1tzk
	9SRxYP5xIucKJcswVz2qtnkbPtLVVsMwc=; b=PsX1db+D41Jc3cIw6kCZ8/ydBJ
	g5cFfbopt8jtr/0UfM0Upf+77K2UINV1j6lQRIbCHKOsCbMFvLpq80TCk+UEAmzo
	0vkjjbAKyN67Oc6rBEo48536scLK9TMN9T23zlpkAb+jq8Af3VaE1Uy7L8m5bn4p
	C5sSR5QXTRGXXbfn2Mlu4SkPED0E58P+e5VbKt74m940wA2a4J3MSAsvRY+1KdbW
	Gmxjvr1wTRBC/AJ0W/1qzk6m5d8PHVpPW7c6MNHQvfpjdfFJQ2tIM5/yRBXfhoP2
	TvVb5XknRSf6LHYEvarTxrg9J7f76+NSrVZjGUR9J2qhF8hWSXGPc/KQ9ENQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754927993; x=1755014393; bh=XRQ/yf1tzk9SRxYP5xIucKJcswVz2qtnkbP
	tLVVsMwc=; b=Zy9oROm919WIZ8kj5XqBqxwUPo5dF16jitvJiM0mXs1v6JD8/o7
	2AYoq82BoxhH1Imtxn5N9TybkK/c9myWNotpTXYSZN9wFDrEg59tXwpdrsmArphs
	WpXMPp3DO91SF6sT2Qb0xEpnDIInpAr3StPw5W3I5wbf0tyKT+dI7oVyGd6OO4ds
	vh0YX27JUVxeQWvMWPuPNL3/Fg7rrNNj3vJMwF3jB8+HjqvfTWtuqUMGyUa4SBO+
	3L72zHOYLEGKVVcre2vGj3xL0DbG1uCpJYuHYZUc83BfVt5DzvnUAB3tcsagth3W
	fNssH7m9MeFrQ7sxQu5utbqWlQPrdNOfk+g==
X-ME-Sender: <xms:eROaaPeSYDDBW5fRMLzKGgBQJiqShkniVUq6F374fiKN4TLxav5BKg>
    <xme:eROaaPyKxnghL6iQvyubUHZaLwOjyMlajri9EqxfhHrZOKF9tZzmCBynlaj-qR1bj
    O8oU9vp4_0F68ycAw>
X-ME-Received: <xmr:eROaaFGj1067rBE-5R1RVi71p9FGk_cPK85EvT12XapURRoImjcuPIzcgSIlm1L3X07Qh_xYqVux98A_hGRPls3VvTsNejXOuYz8nuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvkeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:eROaaDyFeMgn7RVjrrDzyQtVGYIFsz4-6P9M_gmgjmDn51WxouBewQ>
    <xmx:eROaaGvw6sz02RVfU-_wOdAlhD_YFSiFgbqsxeEUTzGnbseWtXu_DQ>
    <xmx:eROaaA2Tl0i8LzxgcyJO75uMALGRcxwcfvpEZK13EO14S27rQbx1Dw>
    <xmx:eROaaB8x0AeLnnZ_feugdEcKMPYdaKHUa-iRmTeJGDajMkeNUs4t3A>
    <xmx:eROaaPPwNc_RHROn3LH3SB29Q3_OPfR83TopMixzj8LqcksXEF5z6PjW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 11:59:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH] for-each-ref: call --start-after argument "marker"
In-Reply-To: <CAOLa=ZQqY8MDTs846mkVsxXrmOmC5O_sv6BxUHqYjGk1Ag+Osw@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 11 Aug 2025 02:19:39 -0700")
References: <1a32a666-fcf4-4f05-a468-2afa07fa0e2d@web.de>
	<CAOLa=ZQqY8MDTs846mkVsxXrmOmC5O_sv6BxUHqYjGk1Ag+Osw@mail.gmail.com>
Date: Mon, 11 Aug 2025 08:59:51 -0700
Message-ID: <xmqqtt2d3l3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> -		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-after"), N_("start iteration after the provided marker")),
>> +		OPT_STRING(  0 , "start-after", &filter.start_after, N_("marker"), N_("start iteration after the provided marker")),
>>
>
> Ah! I did fix a typo here, but your fix is better. Thanks.

Here where?  Is that "fix a typo" something I should go around and
make sure I do not miss?

Thanks.

>
>>  		OPT__COLOR(&format.use_color, N_("respect format colors")),
>>  		OPT_REF_FILTER_EXCLUDE(&filter),
>>  		OPT_REF_SORT(&sorting_options),
>> --
>> 2.50.1
