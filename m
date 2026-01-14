Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771C39527F
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427392; cv=none; b=pNJQ8EmztVhzSwU59gwUJdavjchrkuNd+N3jjBiQpywBu77VuwmHyRasPmjefbRY9Oqc8gItszdLm6FpxtlFCiRKdfRxb8fxBnDnMXOLZNRXGe76tSld3WkNjGuYN/9EuVOthKXKGdRQDcuy60AZ4SWyhSVZf1MfmyA5pDKzKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427392; c=relaxed/simple;
	bh=l16bDPqhyeZm4lXOGWZFdDqFjh/ZVj5R5Et98p/bb8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=drmkgrngjijzUjaZpI9Xs4kAz6xTd26zfwwLQyXQbnr0n6AnjomNxuCnFEPhONcMnx521kaW8XBX7trZ1Fgde6R8O9YOyqWH1e6BGzTvqoLQDWLi0kj8YPqvw1fcfaOzXzeb6Q2nZhEXYaTLBUlhRwWT5tt73/XlpbSfoa56xJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cAEUgx1D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0COh3EwC; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cAEUgx1D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0COh3EwC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 69D4E1D00126;
	Wed, 14 Jan 2026 16:49:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 14 Jan 2026 16:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768427342; x=1768513742; bh=M2TUVvplnr
	6SzfOAgFbjC/wTr1KsWNtKf9yaCeTVMRY=; b=cAEUgx1DIBTqr/InBAfkyW4xZo
	pQA3svjCGXjysH3Z8BB94case7pzDewxs4kUwWCc5hHttX9tFOWFAvwFoDOCOslw
	mckV9u5Su5TxyBYOK88sGUDwbprLsMiicB6Z9ySHT5k7YVbjZ5sX+SVoQgXow8/7
	xZ4HSskdc3ZiWQYbnympW9mxYQqz00HrAh0VkfjXNctk2BESQVqxRZOdlLrE8zXi
	stxZFvytGbbNOIynX16kpWuh6EkyGpg1rbn6wanNrv6bFOVdXUOIduXqdgJvMsJR
	NaUQoIcljG5yTtOD6VQFA+SUWY5SsV39KYxXr54B6dT2L6JVJmvFYs794TqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768427342; x=1768513742; bh=M2TUVvplnr6SzfOAgFbjC/wTr1KsWNtKf9y
	aCeTVMRY=; b=0COh3EwC00XMB9UK5K55pf2148fCWJ4X57n3rfeQ9I1U7zm2z7t
	mgIcGxYl14Swd/CLlEFcdWzkPZ8JfDd9UN6oOh6SuYCkUXKNnXrU2ip9hXhGfJUd
	yGz7E6jUOfTiVhikaY2xLdzvG/5Z0MKW4M9qcsz8y1iOzp3iNWUauDdKIzI/XB13
	6otxQNKYPUzP/p0gcUH1GErOmGDKxUFjfudKRXxGLAZHclVDtOqRd9/lNERY06Bd
	fdw9NuwP4aroAisN09CB9UfHtCKNHXnsnVwzhHPyowH3ExlG43Ons7pQrZ777Bw+
	7B1UIBFNzBNOPhT/x8gPTyngb52SBSq7m9w==
X-ME-Sender: <xms:Tg9oaTd3EyhNtWuMoOg9w8wcQ35y9vRbSvCJafEhGy4YGge158d0vQ>
    <xme:Tg9oac5tih2iuzWSK7ErCBzg_tJgLFJeAIVLjkBQ5a9S00ls4qHrI9ZhtsqLadLnB
    elmQEJxmL2fnXfdbnk9oNLDL4vreoEfGw3ndFQmacu2Qj3lrFYnRQ>
X-ME-Received: <xmr:Tg9oaWUvQxnziSphBbQkDERlHXXC0KvcH8BBxN-HQseetMuUH0M9gikmphPOzoWytNKQm1u7T3w2iOEk16j6hdXNB3QN9yXomRZJ02A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdegfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:Tg9oab5bOUlz2Ma7Y6b5Vt77YYsDWQ1srm0h84YjcYFL6HAlxzSTlA>
    <xmx:Tg9oaRqTdnPSoptVhBu8ObuDCUO67aWhVVZZ8BUDFCOBpgpp5HMAFw>
    <xmx:Tg9oaekczmiEd5UTwBaPxVVNL1WEzFmR6lLlI3_-yRZ8dnWASuj2ow>
    <xmx:Tg9oadMbkJC5fpkwBJczmWaBN4iNa36m76nAFI87vsjSbDV46Cmy-w>
    <xmx:Tg9oaf6w1HTdDfnMQxVRZfhLlh7taVfATLnU4uF-JoBt3o_jyzsbO44u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 16:49:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 11/18] git-compat-util.h: introduce `u32_add()`
In-Reply-To: <c0c1769464b1c8065c2cea59dfd85a1d37de9dd1.1768420450.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 14 Jan 2026 14:54:48 -0500")
References: <cover.1765053054.git.me@ttaylorr.com>
	<cover.1768420450.git.me@ttaylorr.com>
	<c0c1769464b1c8065c2cea59dfd85a1d37de9dd1.1768420450.git.me@ttaylorr.com>
Date: Wed, 14 Jan 2026 13:49:00 -0800
Message-ID: <xmqqpl7beugj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> A future commit will want to add two 32-bit unsigned values together
> while checking for overflow. Introduce a variant of the u64_add()
> function for operating on 32-bit inputs.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  git-compat-util.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b0673d1a450..db62a6f25c5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -641,6 +641,14 @@ static inline int cast_size_t_to_int(size_t a)
>  	return (int)a;
>  }
>  
> +static inline uint32_t u32_add(uint32_t a, uint32_t b)
> +{
> +	if (unsigned_add_overflows(a, b))
> +		die("uint32_t overflow: %"PRIuMAX" + %"PRIuMAX,
> +		    (uintmax_t)a, (uintmax_t)b);
> +	return a + b;
> +}

Neither this one, nor the original u64_add(), seem to me a
particularly good API.

When things might overflow, it is a given that we should give a
controlled death rather than nonsense behaviour and/or corrupt
output, but shouldn't the diagnosis message given to the end-user
when we find an overflow be given at a bit higher layer?  At this
level, you do not even know what quantities you are adding together
*means*.  Even though your caller might be able to give a more
intelligible message like "the number of packs to combine exceeds
2^32 that is too many".  But dying in these functions means the
callers have no chance to do so.  The only thing the user sees is
some code tried to add two u32 and overflowed---without any hint
what these quantities were or what the addition was trying to
compute.




