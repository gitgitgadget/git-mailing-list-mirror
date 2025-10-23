Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B528426E6E8
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761251296; cv=none; b=iByFux8JZt6QF09XoqyFHa+5QHv/YK4GYgk3UfItvhK61192IGa7USJxzQZelFRFxYfobieZn/vLJKfkog4LON4S30N+bjs2M8hXAO8JymdmQ6XKPSmYSbXlFJtx6PsDdLgI10pnWCrYuYDxXZBLMxKxR2Bn5UrkEO4EbQ3yEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761251296; c=relaxed/simple;
	bh=SPrgrkHKe6lVD25SUm8KSto/SOf8sGFomdv4+d7Md9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RUwXJ8aJYf08eB1J6QS0VTDUfFU27lCnijoGenErBxVr0PL03pvXGLv1SWCoD20IdELTJ6B6uySSPyUm0aJJ+uvjN1u4Q8Mr1T5Z77bo+FuEZZxkMTz2RXQviN1RzoFrQNnIrNvVJxVEAIplwr1+OJRFvypXuUDQFqcBtJ15ppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QCGF3aDA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RRmeo76t; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QCGF3aDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RRmeo76t"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4FB27A00B1;
	Thu, 23 Oct 2025 16:28:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 23 Oct 2025 16:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761251293; x=1761337693; bh=yFCOGXFV7C
	OHrBHM5MGMT0cIs7amavLXAuVyc3QsuNQ=; b=QCGF3aDAhyj+Ip0n00Q67F39Sd
	f3mxlOTWhE2iEOumyEv09l8fydv54vCUhInFhYpf+HAZ57asMm67MM5m8DMyHH+9
	uverYzrpcJw4UC/1kwGKXomUGGSnAQSbYdBtzbG5PxhpVbAgTKzQijAyS9w3jDd9
	2uUy5X4PuO/L3AlmDBcvwmcPoVsTWjuRJhCVishrQoYO9/zpLe1qckp5WNunC0gu
	DuCAHwMV11eaRIHlpAI6+R9bYFtQgjPht+m/ROoo7WpxrzIXSEcOepOtOPNFZHaY
	YKBz4emWgNh8Aqshi883mXb4ASwClLqdGx+7/81isIlncrBz2rXioQK8FDpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761251293; x=1761337693; bh=yFCOGXFV7COHrBHM5MGMT0cIs7amavLXAuV
	yc3QsuNQ=; b=RRmeo76ttB0AZ7s5qvsIjivwhgfI2yXvBMs1pRd/ElisF/4pR0S
	z4dEmJyWfi42yu1WhE4++dpmI0Hp5CZm/x0FOKkOu5+ukdxhJ3PvJiLDzZmSckCW
	iqvXZX+LDmHV4XTHAgGa+fIa9u06dXU80midC0DAJRzb1bAWIQpDVvf3T5pOlQV8
	Obe/UPnFg1U6ORp/UClj0wGHe1qF6OZl9+dSr3rB/OyZCsXdCr76zV9EpOMfWxaD
	KhNkw50qEpjyIp7G/JpmKsesHUB108xl0G6ISGP19anvRIMgtJuIJmTKLYTigHh2
	wxkA0/OmGWsi2KL8Ag/tDbKkGNBmtR/IUXA==
X-ME-Sender: <xms:3Y_6aNXMt4NWiLaO-MOR66uG4DAeHoktET_ZLZcoBht9JcU-7bq8mw>
    <xme:3Y_6aElV1CS-m-1Dc-XnUlTcqfUaXJCl6vWojoNo0zyJwsn9p2EHWci9SqPFLR1Bu
    H4Nz6CjQSgkuXQpYb8PIAr_U881NwHGZJpURTtl792b2lzME17A6g>
X-ME-Received: <xmr:3Y_6aObzPc7_WKJ1LR90jdsxWlpI4kAwZ1FOTKpG1ghTVpsUQCWRaq_suDC3gAIluJoJhsK9NyAohEqpHW7rQNeZpB32xynIMkmC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepshhruhhtvggvshhhrdhoshhssehprhhothhonh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3Y_6aPOKqZ6d83ai72yi9_tzJwaZ0zqzH19ekfEB3G31ppNlDM7kUQ>
    <xmx:3Y_6aDaxS2Bd8NQQdql24qOLTjn35vWInGeToPNIgRF0RcarYcbpUw>
    <xmx:3Y_6aN1Fz4HbEHcOr012MWo_bJs0JHbL-NLfHG4mbZiUdQ6hjb0Kzg>
    <xmx:3Y_6aJdgrBOZL4b5BA031-2nfgsaPJwD6Ut6M_8PbiamocrD7MVO4w>
    <xmx:3Y_6aDvcF26s9cmG3XjYUpJVqW-LDEyIR1CkpE-2RtujF7IQNgw-mPuH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 16:28:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] match_pathname(): give fnmatch one char of prefix context
In-Reply-To: <20251014003404.GC1507@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 13 Oct 2025 20:34:04 -0400")
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
	<20251014003404.GC1507@coredump.intra.peff.net>
Date: Thu, 23 Oct 2025 13:28:11 -0700
Message-ID: <xmqq7bwltlb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Subject: match_pathname(): give fnmatch one char of prefix context
>
> In match_pathname(), which we use for matching .gitignore and
> .gitattribute patterns, we are comparing paths with with fnmatch

"with with" -> "with".

> patterns (actually our extended wildmatch, which will be important).
> There's an extra optimization there: we pre-compute the number of
> non-wildcard characters at the beginning of the pattern and do an
> fspathncmp() on that prefix.
>
> That lets us avoid fnmatch entirely on patterns without wildcards, and
> shrinks the amount of work we hand off to fnmatch. For a pattern like
> "foo*.txt" and a path "foobar.txt", we'd cut away the matching "foo"
> prefix and just pass "*.txt" and "bar.txt" to fnmatch().
>
> But this misses a subtle corner case. In fnmatch(), we'll think
> "bar.txt" is the start of the path, but it's not. This doesn't matter
> for the pattern above, but consider the wildmatch pattern "foo**/bar"
> and the path "foobar". These two should not match, because there is no
> file named "bar", and the "**" applies only to the containing directory
> name. But after removing the "foo" prefix, fnmatch will get "**/bar" and
> "bar", which it does consider a match, because "**/" can match zero
> directories.

Ouch.

> We can solve this by giving fnmatch a bit more context. As long as it
> has one byte of the matched prefix, then it will know that "bar" is not
> the start of the path. In this example it would get "o**/bar" and
> "obar", and realize that they cannot match.
>
> In the case that there are no wildcards at all (i.e., the whole prefix
> matches), we'll continue to return without running fnmatch at all. We
> just need to account for the extra byte in our adjusted lengths.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I wonder how much this prefix-matching buys us in practice. There are
> two cases that are helped:
>
>   1. When there is no wildcard in the pattern at all, we skip fnmatch
>      entirely.
>
>   2. We do a raw match of the prefix chars, shrinking the size of what
>      is passed to fnmatch.
>
> My suspicion is that most of the improvement comes from (1), and it
> would be very easy to retain that case and get rid of (2). But I haven't
> done any measuring.

The above matches my intuition as well.

> diff --git a/dir.c b/dir.c
> index 0a67a99cb3..764400d9c5 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1360,6 +1360,13 @@ int match_pathname(const char *pathname, int pathlen,
>  
>  		if (fspathncmp(pattern, name, prefix))
>  			return 0;
> +
> +		/*
> +		 * Retain one character of the prefix to
> +		 * pass to fnmatch, which lets it distinguish
> +		 * the start of a directory component correctly.
> +		 */
> +		prefix--;
>  		pattern += prefix;
>  		patternlen -= prefix;
>  		name    += prefix;

So, checking pattern "fo*o/bar" against "foo/bar", we'd use
"o*o/bar" to match "oo/bar", which is not necessary but our
conjecture is that feeding shorter fnmatch() is not buying
us much, which justifies this change.

If not, we could do a more targetted pessimization, perhaps like
this, ...

        /* the non-wildcard prefix does not match? */ 
	if (fspathncmp(pattern, name, prefix))
		return 0;

	/* the non-wildcard prefix is the whole thing? */
	if (namelen == prefix && patternlen == prefix)
		return 1;

	/* avoid making foo**/bar match foobar */
	if (3 <= prefix && memcmp(pattern, "**/", 3)
		prefix--;
	pattern += prefix;
	patternlen -= prefix;
	name += prefix;
	namelen -= prefix;

... but that is even more specific hack than yours.

> @@ -1370,7 +1377,7 @@ int match_pathname(const char *pathname, int pathlen,
>  		 * then our prefix match is all we need; we
>  		 * do not need to call fnmatch at all.
>  		 */
> -		if (!patternlen && !namelen)
> +		if (patternlen == 1 && namelen == 1)
>  			return 1;
>  	}

In any case, I do prefer doing this "our non-wildcard part matched
the whole thing, so let's return true" before stripping matching
prefix from the pattern and the name (like I showed earlier).

> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 273d71411f..db8bde280e 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -847,6 +847,17 @@ test_expect_success 'directories and ** matches' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '** not confused by matching leading prefix' '
> +	cat >.gitignore <<-\EOF &&
> +	foo**/bar
> +	EOF
> +	git check-ignore foobar foo/bar >actual &&
> +	cat >expect <<-\EOF &&
> +	foo/bar
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  ############################################################################
>  #
>  # test whitespace handling
