Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3EB2980A8
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885401; cv=none; b=YtjgJ1ie9ZvxIQwtweFvMU4dnfQ+LRVOJdGW4FHVzw/GxOQpNZ14no/YWaqLJq8Qe9ANOStq8jG06uFNq50EkHo3Uv/AB9D5H/mR6058Xd/FC7bSPQToSQl42dz7eunANrZ3G9a+k32TMUYsP7269OGQ8qzv4vnOdfEoAZKCYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885401; c=relaxed/simple;
	bh=KoF1blaU++x290RdKKy/0w3PvxGKfQkGAkivPIuiyss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IS8pH7ItvXoXCT0WD/vn1upJlnugiC49TnB75jTlaUQxlg+epH1NelhIkaYSZXE4lQiyDXKviqSpRn44MRGqdAwHHOyzQLwu1+kaEgtiO/QGsm45TQiSnZARSlNrbNB4amdCEpDhG5RI1H+DIYWU38flYrgGVGC6DXtttJoQFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GvH/hbD8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1lTqHyn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GvH/hbD8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1lTqHyn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 017D5EC0089;
	Fri, 22 Aug 2025 13:56:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 22 Aug 2025 13:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755885397; x=1755971797; bh=aOoXVsuPST
	75lXO8WzuFIDKsVuS6p+wBOCysnWIgyfA=; b=GvH/hbD8tTU0aG9nubWvpVj1kK
	buNLReMpWITIZNRfSxlfk5W97FTDReVJV4HdfzXc+lggE0iik9krW3IVtPeFzYjW
	qDhKGLfS2EuHkXyOlU3O4/goeTA9DO4nuwVePSE3EkPB6wIRqeaJpVkvQUH5HuBA
	GkfipclwR0m9v7juOYnkq1jz5yAT38sfdfi6Ge5Js+3JShsA5svOeY0JZf49dv0o
	BhbfFpq+3H+i5UZKUbzQQwB7zkI1wpFnZ9vUB5d9Ox65cl9Wm2FQXZY16AjkkhJR
	/awHYIwP75ZwD3zhvARC0rqwwTjWICmoYVYz2jwEGW4s9wNrbRKKxK3UOCNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755885397; x=1755971797; bh=aOoXVsuPST75lXO8WzuFIDKsVuS6p+wBOCy
	snWIgyfA=; b=i1lTqHynWeTQuc4kM/hxZVx6XU/cgLvXMqiDccgaYlWKaoycCAp
	zA5PRMZQVk5oiHTO//y2YJReIaDb8AOQZw00axpLxjEqvsSOu2BMNBIMm68/dU1R
	G/nfNx2sDMrY5XREAZJZ7Q1gN0AnegNKQT3x+dpn6y+gMyYzl7GtzmiAJE9O65tQ
	P2Jxiic7cFm5sDqYXvBkET9sqOaISfL6GIiy3AHy9BvEWFvjAtUewAwsrbadU7oM
	0UTqDW3VcJbYU08hAcQ1fy8BkwNDGpa/6WGicZP7HY1nfoRN0x818mrJMmCJXb0a
	A5UWaPYjhVIEm53eMK751bhSUzoEiRC8zTw==
X-ME-Sender: <xms:Va-oaFVijAlPYzEeu_4ioIMBccf3-6D3EG08IIER5X1xqtBU_LiOfw>
    <xme:Va-oaAJKZPtns8x6AstOLOlf7PgNeRv_sFhvhJ_uZLkyiS7U9IpApT3Qe_7zvDdea
    49v0Mk7Zdy7ASE9pw>
X-ME-Received: <xmr:Va-oaN9cKfNm0UZ4T8t5vMCSX-mS3gOcAJGn45UddBU9yR9AjwGMoSe7Ha1US3uNxqrGP-uSh4o6ATpSfZKAnYaExd1XXASC7oW47fY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeggeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggrnhhivghlvghsrghsshholhhisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Va-oaLIa4l6fcPdYalP3Ru66JNrbieS7l3DRsrCgo3138dbMyUJJGA>
    <xmx:Va-oaKmX79CnZA9RJ893hzaDZrbXU5RERHSMYM-OwXYf0qAuqUkvyQ>
    <xmx:Va-oaHN8_B04bm0d4yq1rg5G9J5JzzTOIGRm0K5Nte-XA8qbogq3Dw>
    <xmx:Va-oaI01gSuUkSDj3zxy0OPRLWIvble4y5g7NXbMfCAcHddMLFgGPQ>
    <xmx:Va-oaGm3uq0iqzXCYJy0diNvZEpNAB_KlLHL0DyCxDFgnW7Jeb_Qwsh8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 13:56:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Daniele Sassoli <danielesassoli@gmail.com>
Cc: Daniele Sassoli via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] doc:clarify which remotes can be used when contributing
In-Reply-To: <acbb5f69-98bf-4eab-99ea-08b3155ce9e2@gmail.com> (Daniele
	Sassoli's message of "Fri, 22 Aug 2025 11:14:20 +0200")
References: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
	<xmqqms7vc8mo.fsf@gitster.g>
	<363ac6d1-8444-4d48-a66b-51ea139f4e87@gmail.com>
	<xmqqbjo98zjh.fsf@gitster.g>
	<acbb5f69-98bf-4eab-99ea-08b3155ce9e2@gmail.com>
Date: Fri, 22 Aug 2025 10:56:36 -0700
Message-ID: <xmqq349jxmsr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniele Sassoli <danielesassoli@gmail.com> writes:

> Subject: Re: [PATCH] doc:clarify which remotes can be used when contributing

A space is missing before "clarify".

>> Those started from git/git have to learn what different things they
>> need to do to use GGG by reading this extra piece of documentation,
>> and then if they plan to keep using GGG, they will have to do this
>> extra thing each and every time until the end of time (since your
>> preference is not to teach switching to GGG/git from git/git).
>
> I think for someone's first contribution, the most straightforward thing to do
> is simply to stick with what they have setup so far. If someone finds themselves
> doing this more than once, I would imagine they know what they're doing and are
> not beginners, so can figure out to switch the remote themselves.
> ...
> We're trying to achieve the same outcome, which is why I'm trying to have the
> reader follow the path of least resistance in getting their patch to the mailing
> list. If they then find themselves contributing regularly and realise they need
> the more advanced features of gitgitgadget on a regular basis, I'm sure they'll
> figure to switch the remote themselves.

Having been in this project for longer than some people, I strongly
suspect that "they'll figure to switch" will never happen.  Even
when a solution they have (e.g. "Here is how you work around to use
GGG when you didn't start with GGG") is more cumbersome than it has
to be, people tend to stay there in a local minimum, not necessarily
out of habit and laziness, but because they are not told that there
are better ways.  When they do not know they need to "figure to
switch", they won't.

Having said that, as I said, I do not have strong opinions, so I'll
let other people to discuss and come to their own consensus ;-)

Thanks for writing a patch.
