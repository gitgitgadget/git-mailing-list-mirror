Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCCA1CAA76
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736771803; cv=none; b=hO3gaSgdcKbmILfymT4++fvmZnBe+ekpVEtogVTPce1CtzGXF0UHjH4pVNXC6Iextgfh8+e03HoBAifZnywIB80TiTeWqgdz5cOXouEoszhdIZtUeOj1aIsyH5LGFab5E0TOTvShC/OTltGUtc0ZJvjs8lY4FzLhxgBu4ob1264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736771803; c=relaxed/simple;
	bh=Vc6F175k/L/ja4tsQjmb9tmwLPi9xqk5/hOVx9S/P5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xab/0x9Ey8tANqzRXa3K7W8j8rWou8iTcP7pgJw6l1kbCsaXDfao9eXVQBWhptDeBEBRKQHdOFQAUXXJDFqygnNejQb846IouqBORREOuKDaM+rQ+OrYhzUdr09uX5Fl2ZUqThKXHirtXVTiYuJ5EnC5WG1M5KEdt3kraWJTzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pUfG+I9C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=exgirZJP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pUfG+I9C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="exgirZJP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19C6B1140138;
	Mon, 13 Jan 2025 07:36:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jan 2025 07:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736771800; x=1736858200; bh=/3VUU8lUTh
	kCYuGAxHhc31ueo9qqUwsaHa1CVqsmjso=; b=pUfG+I9CvWyGcJFvU9BIaR+ffD
	ZsIbZ3H+FAspw6Y5O4G/OQ+SJ+rYpRPtVEnph+zAh2kUJw2OspIXZvubwHJ1bsF5
	wP8QfPacvezcSxmc4Ql+sBItsM0NLhkh3SA8bcenw2+KwcORH6T2MyBT7BfDW8NT
	rG1Y++t3q1c+pJiLW/Ft3ZwbinVD+NcOwNSBiDG6M/ttFT0Zp5YKay9TBxrr5R7u
	KUYLiG0VdCkqZ9FJyKrxJv0LYTl5zYDTOJW8sx8h73AHV6cyQau8yMIG05pSpFeg
	92H3+qNiFhkIwCxNYLi+qYLwL6/rKpEoDaddJDPhUpjzeGlVgFZ8ObSaSpdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736771800; x=1736858200; bh=/3VUU8lUThkCYuGAxHhc31ueo9qqUwsaHa1
	CVqsmjso=; b=exgirZJP8JA1eJPGtcxqz29G6GAjwKczDJfwdGjBHgcCzGHSAVl
	f+DVC44erqz6negNWT03uAZ0sv29GZXsYzCi/v4cq2CM3AgXLMUxa1T8TCy95f3z
	x8G8nlPFDcb6ZQnnmO73vl6/3OQJ2ASvcdhRqUWuFaWD0WKXpRZBZxFeb/jnRXIo
	zCxXw1SQ5UuY3ep76jHhWJb82hkNnJGVyhgLTbxuUetAgP6ZEb+w+YQrMgjKVoul
	H57dCcQIK62zIO3vf9SSe8jRD1OYEDiViPOUwb42WLFg6cdhDp5JOQDNtxCp7R0/
	63/vCdmvKvNY7MfTYrFBDKwkExQKfuzccwg==
X-ME-Sender: <xms:1wiFZzj13SsyxtN9Gkh5ZM6a4zmOqB4XPOK3uDE0g5y4vbX0deCVaA>
    <xme:1wiFZwDVZ_-LGznlvakqTtwnbhFDDmwz5527PjghLxohsVEbr8RmKHOwJCZmgj5Kd
    boCe6CBWmHzQAH9pg>
X-ME-Received: <xmr:1wiFZzEJ9FvgWj1hot1jM_P12iJ9SVzqQjcSkH5ZEJ8qNNfw5jrGW9GBZnZzkRK3yMYkj6_i1nenR3yDUmoeseSGHiRcmyKrrjeQm84DyhQO-IqR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhprghluhhssehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1wiFZwRcOaOsva1FMEaCZ7q0oJVAfqLkDcmbF2W087Ol0CsfEBuUNA>
    <xmx:1wiFZwyKC5D1xFYY3WUJTJl765hSogvpHFJHoufXBQggxaCu7UWiRQ>
    <xmx:1wiFZ24r594xWxo21jO2Wu_680-MQWgCQZJ3NH1zcclJixxk_QTmOw>
    <xmx:1wiFZ1zjd3kF9oj7LC9QTIvFR9gtIC8Uot9ayvGmnw87dTLOYdpRKQ>
    <xmx:2AiFZ79MweCda9OJ5gZodJdhgk2BqRjbELvkt7Y9MiefnycHSFXKGrbe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 07:36:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33dd4296 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 12:36:35 +0000 (UTC)
Date: Mon, 13 Jan 2025 13:36:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jan Palus <jpalus@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t8002-blame: simplify padding generation in blank
 boundary tests
Message-ID: <Z4UIWId7ExLB2gWJ@pks.im>
References: <20250111231107.2190448-1-jpalus@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111231107.2190448-1-jpalus@fastmail.com>

On Sun, Jan 12, 2025 at 12:11:07AM +0100, Jan Palus wrote:
> Fixes compatibility with mksh as well:
> $ mksh -c 'printf "%0.s" ""'
> printf: %0.s: invalid conversion specification
> 
> Fixes: e7fb2ca945 ("builtin/blame: fix out-of-bounds write with blank boundary commits")

We don't typically use Fixes tags in our project, but instead embed the
commit into the commit message with `git log --format=reference -1`
together with a description.

The subject can also be adjusted a bit: we use to just write the test
number, and the important aspect is not that we simplify the padding
generation, but that we make it more portable.

So, my suggestion would be:

    t8002: fix unportable printf formatting directives

    In e7fb2ca945 (builtin/blame: fix out-of-bounds write with blank
    boundary commits, 2025-01-10), we have introduced two new tests that
    expect a certain amount of padding. This padding is generated via
    printf using the "%0.s" formatting directive. That directive is
    non-portable and not understood by for example mksh, breaking these
    tests on platforms using that shell.

    Fix this issue by using "%${N}s" instead, which is already being
    used in t5300 and thus portable enough for us.

> Signed-off-by: Jan Palus <jpalus@fastmail.com>
> ---
>  t/t8002-blame.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index 1ad039e123..e98993276a 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -138,7 +138,7 @@ test_expect_success 'blame --abbrev -b truncates the blank boundary' '
>  	# Note that `--abbrev=` always gets incremented by 1, which is why we
>  	# expect 11 leading spaces and not 10.
>  	cat >expect <<-EOF &&
> -	$(printf "%0.s " $(test_seq 11)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
> +	$(printf "%11s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
>  	EOF
>  	git blame -b --abbrev=10 ^HEAD -- abbrev.t >actual &&
>  	test_cmp expect actual

Okay, makes sense. And as mentioned, we already have such a use of
printf in t5300, so it should be portable enough for our use case.

Thanks!

Patrick
