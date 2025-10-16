Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB854409
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646771; cv=none; b=nYBHP7XFH8rMxEkKRuclgrWBTxlpVVIYh8OfohuBKgmHp27NKKcb819zwKN1CqLuAqmLftbjz25STyBKOGp8VLiJgRpqQeQgBCYPEgkA9J01eTObYeyFqHQVbZMYIwHuSaUVyjxBAikZO1FBggA9i+5+de5thoUpszK8h6Aad3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646771; c=relaxed/simple;
	bh=/YBGzJZG98RwA16P/WBOB59URGmyGLnqMhq+T4awKJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KyznHfaLuhFKVRwVXTlYRiqmTyFj49fScHMkMjvugMxxJkMJKJR8qCQC/Pe4OsvkSuYb0UDp4OjjINKhAyUJJTFJBTWmMVR1xTYcmjy+n65r4U4qGBEarLrM/57VjU36tRb4qJ4ZzpD5HdGaRbs4rjBHeH98nijF66xqXajd1wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jgwyb1jC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dt5oZhvt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jgwyb1jC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dt5oZhvt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BB8DEC012D;
	Thu, 16 Oct 2025 16:32:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 16 Oct 2025 16:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760646767; x=1760733167; bh=Xd9Uaf4ImS
	XoLZUNlkHoPxlTGs01qiP70OZIsCbDmgY=; b=Jgwyb1jCNEzj3DrXDPGHQKT5VM
	GN3q5HqVjzvVaudsqkai7s0i9PU9HACXH9JPxGhm10ciw7nkCVthb23P4k1/MViU
	b3MTY042wPgGDcvS5/dTU8lkQ/p/FL2Z5RiWstvZ/sgpp0nVKzz30g0RltYthEee
	7/9OfXkhMFSxVrH/fn5HQ0CKRYYMAsqYx+rl2TA5+vZ1r4n+9KwepBRLcdN0StfW
	6WoOBTU0mGdf5oNOegM4XmjBXGrGiuIDkSmftS/c29Uw5Nws7Er5fQwjZPdAzlcz
	3996xlsfyWxKv06cv/k5JJ7tI63XoQKBs7ieMRVTz1dGFYNes0TuxQgjBqvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760646767; x=1760733167; bh=Xd9Uaf4ImSXoLZUNlkHoPxlTGs01qiP70OZ
	IsCbDmgY=; b=Dt5oZhvt+15Iv7iryVZwi98gTmg6RRlIs0Cj++W0DhGB1xOaHZf
	NQiTMLuohCx10SbD2z812UJNKP2F6NG8cXWgyMN/Yo5piIpmw+/triSoqqLTq5UK
	LLfgB3lqSECU8pGshiCe7nW4JYLr+AWuoCqMPUy88JzRtYYr/P26ku8yl7wFwH9y
	8urJo9tEoj9YTQgAgx5Iuw138yhsNnrM3ydD3Wu5c1LZgk851fcIG/dNTsQEGhWf
	JLMlDugdjl8Vwq/oD98ejl6tGqN/Btxhuvhkh4n4SIBr/Ha5GTW8joDtEySeFxMg
	thjQ73HDOkR5/3H4g90l+d7Bw0QTdDaWUgw==
X-ME-Sender: <xms:b1bxaI1ffBv1DknugRV_qwqZlAxAr_tguIBz7SMxL35rZE_1GOT73g>
    <xme:b1bxaKhUm39NcS1fTzie-9LuHYlPLwxrNXUTFhJZ7talShZvvwFGIdJY7uxpmxtWw
    4cxQbc_LFY6W_uOB0MGwtC0YSfEY5OysZ5gi5wWgycKVmF-qUgadA>
X-ME-Received: <xmr:b1bxaOQDkNLzznkQ8l6L-PVQJAwE_DNIVAvNJCYpKa_5uKz05lJK-juOYcU0W_0AP8011GnL1D2QnSetsx2CvpdVUraGB2NyJba->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrg
    hmvghsrdgsohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghrshhhihhprdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:b1bxaLgDy0GGZlA52jR_hwen5ZOCB74tvRKW4R0gc-47SkQECIQsmw>
    <xmx:b1bxaO5gydA5pAmTW5KIFIPcbJlcLiSmL1eIQrMcBSp6Iga3qFl8xw>
    <xmx:b1bxaICazZwoaEzxxO7u4-WnbmHMKY35mMAC5JmZI7UjMLw4Rb0pvg>
    <xmx:b1bxaFbSLFhBXLeb-gkgebiPHoP-WEVp_t0ROabbm1nVE4AoquSNqg>
    <xmx:b1bxaCMTX0fELK8QlpwRUOvF707unVJiS9u96KMdt9F3FybssQJdy3aV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 16:32:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] add a message-id header to git
In-Reply-To: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
	(James Bottomley's message of "Thu, 16 Oct 2025 14:57:55 -0400")
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
Date: Thu, 16 Oct 2025 13:32:45 -0700
Message-ID: <xmqqfrbi37v6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> There has been some debate in the kernel community about how to link
> commits back to email, which is the basis of a lot of scripting we do
>
> https://lore.kernel.org/ksummit/a7878386f3546ba475cdf7250ab4f5a6af2a1676.camel@HansenPartnership.com/
>
> However, this problem is one that goes beyond the kernel, so having
> git always track the message-id of the email used to create the commit
> will be useful beyond our tools as well.  The design of this
> message-id header is that it never shows up except in --pretty=raw
> output, so it will never be ordinarily visible, but can be extracted
> by scripts.  Some projects use the -m flag of git-am to add the
> Message-Id to the trailers and for backwards compatibility, this
> functionality is not changed although it is hoped that it is now
> redundant.

I am perfectly fine with mailinfo changes and it is OK to add it to
commit trailer, but to the commit object header?  Having to maintain
an extra header is a headache, in that you have to worry about what
rebases and cherry-picks would do to them.  Please don't.

I haven't carefully read [2/3] yet, but do we now forbid to run the
poor-man's rebase "git format-patch ... | git am" pipeline by
insisting that state->msg_id to exist in parse_mail()?  The output
of format-patch over existing commits may not have the message-id
headers.



