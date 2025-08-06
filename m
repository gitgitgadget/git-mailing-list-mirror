Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAE28F95E
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493466; cv=none; b=Lc41TseRyxTxazZ9Z2uTZpqHojtVqxaZ89Yv40rhHOO8DTV8yM0A40vndM58eOV+9x47uPn8FvELuvpCx23/bL1wIAdqtENcth/YvWFAcIEvDNZBphe8NVqcWA29NctI83JRwOm4GPbK3n4V9pIMD4QVZhdMjeCws5uQUfhqElw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493466; c=relaxed/simple;
	bh=lI9GNvj5rAPYYPZe+fBj6kknt7P7NEaJ/JJCzgPVJdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HbauESWJvBqMVn5NSsz9+D9KgDddtdP3d386ag52800k2kxGWI6h6cN8uzpkSFq+7D/sOyZG26ZA801ZWQTiEkE8+B121R+gqpOCrtug6z4uXk6rX7gvgHB+rhFbErQfw4Dr+AWBpqGaVawObFKsRbv+QCQHBte6HnfYY068tsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dAZ91I8U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbWeQ9P3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dAZ91I8U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbWeQ9P3"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E518B7A00BC;
	Wed,  6 Aug 2025 11:17:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 06 Aug 2025 11:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754493462; x=1754579862; bh=HfSNVGSydW
	VkuaQpSlsQz8pwErPV5OZRsdH4DBjnWU8=; b=dAZ91I8UcPGwWHB95WX2+tIURE
	zRvuZNfXBXEc7+wydwqiYx1TQG5z477+GnxIsr6N41qTbwpakHxvjo0/J5xsgBtz
	Fp++W+aWrbRSidjP1RKW1GovPL0YN+6QZVIQQWd8WdZrf1eHiV9nGfW71LNDhzOW
	B9Hld1oLfMw7bBMPUNNFqv32KC7A4Cn+F/GFkB29wkMc8RjLs8hVcFIbYOhcLjah
	JP/UiOG9oN+8IZ0/9B3eNQ4kRXK9zGKsFG3zi0Yy0S0ndrhkDOrgGLIr9XsWSy/G
	zca6sJn5qtrwYvGlTzJ8stsgwf0ElB565Gye0B7tj+R4pPz4j4NiTmdUV2Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754493462; x=1754579862; bh=HfSNVGSydWVkuaQpSlsQz8pwErPV5OZRsdH
	4DBjnWU8=; b=IbWeQ9P38w4DMgtrnhNZ+0eUa6oWiRLSTR+VKMgzpQ3NzqnmJeR
	GXT/eRH8wp5R0C1IO6+Qk2Xd/8A5Rb2NjCRsN9joHBlJW9UcxQA/RKz5VFZ7i0xX
	U0KcLyhcB3NyV2cMyjmWKpnSbEJQob+mIlzwqfGJN1nGo1SXkUFjTVtvWa1o+c4L
	AGfz8S1Md45Iw1oKpRv5VHCc6T6cMBxr/doQkAIRLDb5B7Aqrr2UPUq3xVELucue
	lkBWuTRdtIefqwAjG/IIJw4f/ioC2sfzA4Xkv7njtWpM4ojeTl3v+p2yVPdU8rrK
	Na8DaNKbVgFrI8FepmrxY1NXiwdMcq2DPFQ==
X-ME-Sender: <xms:FnKTaH6F0_Oa4VhaHxNvxR-ZR-UioNqZIL_gmEB-ajkY_vNrlVnTEQ>
    <xme:FnKTaHcYEZ1fNwhF0mn1zR8yS2HhFhK80esOAPw7bBKHGBtdkbfqkSQMufUemGk1L
    gtkuZ6H3H7wKFV1cA>
X-ME-Received: <xmr:FnKTaLBiFtWng_xzN0wwIw6ov4X-2JqWg1cqjl2Gxtdt4kc_xxVpyjrJeCVmXQT0XSKZ0C7MPorHXGtQT-zhhOcuRr1b8bXbCMzbjrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehlihhurd
    guvghnthhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FnKTaK9asx4PSUHaVdXdENpqT4iPLK3ueh7fDbxB8IX0B7meYCSlLw>
    <xmx:FnKTaGIkwd-E_kGo0YnQdZ_aakzySOIRjY5ZTZSYr1_Ku2z2gysg8A>
    <xmx:FnKTaDidL9oiUlKFIRUuV9w5o_3VHc4liJEO6oZCICYhj8cFR7N3hA>
    <xmx:FnKTaG4nU0hSDgV4Yg7X_nPQggkajDYHk730cZDHB8OnwQbFvE_3mw>
    <xmx:FnKTaHrMia2Fl7DOdbw6BUQQqZymTnEZwTbrjT_SKf0JecQKJewp3gk2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 11:17:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Denton Liu <liu.denton@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] remote.c: remove BUG in
 show_push_unqualified_ref_name_error()
In-Reply-To: <aJLywm9xWQQUADH1@pks.im> (Patrick Steinhardt's message of "Wed,
	6 Aug 2025 08:14:26 +0200")
References: <cover.1754375026.git.liu.denton@gmail.com>
	<cover.1754455931.git.liu.denton@gmail.com>
	<938dfb8d4e37ef962c811d6e0f32122a2522deb5.1754455931.git.liu.denton@gmail.com>
	<aJLywm9xWQQUADH1@pks.im>
Date: Wed, 06 Aug 2025 08:17:40 -0700
Message-ID: <xmqqv7n0wkbv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This reads a lot better, thanks. We could arguably convert the
> if-else-chain into a switch to make all of this read a bit better, but
> that is a subjective style change and definitely not something that you
> have to do as part of this series.

I concur.  I admit that using switch never occured to me but I agree
100% with you that it would make the result nicer, and that it does
not have to be part of this series.

> One thing I wondered is whether it's okay to not die anymore via
> `BUG()`. The other error cases already don't die though, so this ought
> to be fine. Going up the callchain shows that we do bubble up the error
> as expected until we end up in `match_push_refs()`. There's multiple
> callers of that function, and all except one perform error handling for
> it.
>
> The only exception is git-remote(1) in `get_push_ref_states()`, where it
> gets executed via `git remote show $remote_name`. As far as I understand
> we would end up not showing any references that are broken, and we would
> print the above advise. Which I think is reasonable.
>
> So all of this looks good to me, thanks!

Nice to see somebody thinks through the potential impact for all the
callers.  Very much appreciated.

Let's merge the topic to 'next'.

Thanks.
