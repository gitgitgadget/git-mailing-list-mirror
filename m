Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193111C5F39
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668245; cv=none; b=lmay6lQJaURZVNo2IRVg7LgSF0DNVgVHe5ZBLeXZLBNjF++0VfxKiaCjNjJ/pMevcbQua39ODwxA2fSCmQlIV1hXBNzcB8rYYbfj35YgQInCRQjRZ2RcxY0/53NQshlGYNWiH6VulYxQqGK1Am7tdhP2g7KZfjXS6X4shT2cL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668245; c=relaxed/simple;
	bh=aZuWY3OYlc/+4FYmzjgdlZhDw6lQ7Xlaj5K/a+vGI3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MJsFrGzDEUiuMuTID4cMoeRxle2EAmWlPjHP6p0iGfZXCBotNbq2ZiQc9unWR94LFftJPT9BAnF1ZYQI/0+kWMkWNuiSGPJNf+dnDSS5PryORztRdCvRvsVDLKto/IP666yK/BuAVtz+zukX3YHgJSLAt9IgnCgboUx38aPfews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RyxeiETB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aZDxqC84; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RyxeiETB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aZDxqC84"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DF591D000D7;
	Fri,  8 Aug 2025 11:50:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 08 Aug 2025 11:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754668241; x=1754754641; bh=oUJ2bJkpEv
	zQErcfrNQDv+TKyqnwx25MmYq12d6ttXY=; b=RyxeiETBl7eE7HPbL5OM+g06sD
	AQuwEUgJuS85szHV1TsxwLMs7eRnyL/1bYDfQRehU6OrrB5bTvxfZFRj8pG2eZg+
	gG51b8RTHaejf2bqQ2q4IDAxxQd+D7nz2roIuRpnqkSw5v6JQxNsKuu3m3gVIe03
	HiJ8Cpxa0yp4U+ooMCR+9PALL9a3bvoOXEELqys/rVc51V1v2MYSVQt4z+Lwu1/P
	YkLzkeonSZFGe9LfvewvG660CkiwzHu01hRzxa0SyfkpXIxQT3ftEDw+Y2pk/8LF
	PJl52ARImzzp2LEh88q3L1Za/lpoLd03V6cH25bdmg5RGCV0e8MjZBGVnl7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754668241; x=1754754641; bh=oUJ2bJkpEvzQErcfrNQDv+TKyqnwx25MmYq
	12d6ttXY=; b=aZDxqC84oylk3XqgjgsZtq4oE1z0IrExUvNzeMF7an63lHAx4Rf
	sKaJVSS2Eiyd8XPN+fU6ek2hButDi31Xe9iWf+1PPyI2mHoV6G1O1C9hUEPHm4XD
	2dAH+ACR3/qV6C3oMDrTdONch30vqF4j+lM9iQYk5YXeDdJC5isCo0czYNJhYS2U
	aU6QvfJsA3W6mazoXQwG0Zuhcgzd8vka9OkkIhkzF7ygcwLXhf+6sjsVCQzd+OsA
	qa8z6FuPb4ebvouOLsjqLsuqonoekyXXl5i9NUGafYCTOQmBM7l/O0Z2snl8JQNT
	JBO+BTGuBOUjOQ47l5TmRaFqX+4vW+HED/A==
X-ME-Sender: <xms:0RyWaEXElzRdkKWFAByyk6EW1oQKtVElu0l3NXxbFdDN81VII-hcmQ>
    <xme:0RyWaEEioydMxtr5Y5Y3SC2SjU7L6cZ_jRful4Mzw4UDjSb0fjbq5YA_UEiocagaS
    znGPTDXq0STSPtXGQ>
X-ME-Received: <xmr:0RyWaO0lyeh5b-2nAryFmoF5UfnGvA1M6e68DjANFXCtvIG4cs3koJDO4X7ERPbHSrSNHS9rxMx2NWm-jTmSPXv3loW_JdBxzl-thLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeutdeikeekhfdvtedtieefjeeive
    dvgfevfeegtdeffeekgeehffefvddugfekvdenucffohhmrghinheprhgvvhhishhiohhn
    rdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhtrgihlhhorhhrsehgih
    hthhhusgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0RyWaOPQSYfrmsvia8TJzy-mBusFdGHbYkaCD3ISHbmruNR7ioLWTQ>
    <xmx:0RyWaF48Wlv7wIgFUdY4GTqNAiFsZYz4w9ob1FTfFMXqxHSR41unSg>
    <xmx:0RyWaA1wiXhHxXMJweHVK90bkjqa_OHQUzWHKQyg1-TVilTwPuXfLw>
    <xmx:0RyWaOyknVb2qtpSmhU-eKtRima1SwNK7S1kLIjNRmDRjgDYnuFjdQ>
    <xmx:0RyWaBbJmHvSwF-6ri7nqBivGuvGTsPwH_d3hBJcol5R6-qhvCGEFJgo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 11:50:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  ttaylorr@github.com
Subject: Re: [PATCH v2] bloom: enable bloom filter with wildcard pathspec in
 revision traversal
In-Reply-To: <20250808065834.22743-1-yldhome2d2@gmail.com> (Lidong Yan's
	message of "Fri, 8 Aug 2025 14:58:34 +0800")
References: <20250807051243.96884-1-yldhome2d2@gmail.com>
	<20250808065834.22743-1-yldhome2d2@gmail.com>
Date: Fri, 08 Aug 2025 08:50:39 -0700
Message-ID: <xmqqsei1izhs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

>  static int forbid_bloom_filters(struct pathspec *spec)
>  {
> -	if (spec->has_wildcard)
> -		return 1;
> -	if (spec->magic & ~PATHSPEC_LITERAL)
> +	unsigned int allowed_magic =
> +		PATHSPEC_FROMTOP |
> +		PATHSPEC_MAXDEPTH |
> +		PATHSPEC_LITERAL |
> +		PATHSPEC_GLOB |
> +		PATHSPEC_ATTR;
> +
> +	if (spec->magic & ~allowed_magic)
>  		return 1;
>  	for (size_t nr = 0; nr < spec->nr; nr++)
> -		if (spec->items[nr].magic & ~PATHSPEC_LITERAL)
> +		if (spec->items[nr].magic & ~allowed_magic)
>  			return 1;

Quite straight-forward and easy to see that this is a simple
enhancement of the existing code.  Good.

> @@ -693,9 +698,22 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
>  	size_t len;
>  	int res = 0;
>  
> +	len = pi->nowildcard_len;
> +	if (len != pi->len) {
> +		/*
> +		 * for path like "/dir/file*", nowildcard part would be
> +		 * "/dir/file", but only "/dir" should be used for the

Leading "/" makes it look as if the pathspec element can begin with
a slash, but it can not, can it?

> +		 * bloom filter
> +		 */
> +		while (len > 0 && pi->match[len - 1] != '/')
> +			len--;

In a tree that has both "builtin/" directory and "builtin.h" file,
what pathspec_element do we get here when we run

	$ git log "builtin*"

We need to be able to catch commits that touch anything in
"builtin/" and also anything at the top-level that begins with
"builtin", like "builtin.h" and other things that might have existed
ever in the history.  I think len goes down to 0 and that is the
correct behaviour.

The code does deal with the case where len is reduced down to zero,
but a bit poorly.  It would allocate a zero-length string, then
realize it frees it, and returns -1.  As it must know how long the
resulting path is before it allocated, and by definition len is
pi->len if it did not have to allocate, it should be able to take
the "goto cleanup" code path before it even attempts to allocate,
and it should not have to do strlen().  But the current code is not
incorrect.

> +	}
>  	/* remove single trailing slash from path, if needed */
> -	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
> -		path_alloc = xmemdupz(pi->match, pi->len - 1);
> +	if (len > 0 && pi->match[len - 1] == '/')
> +		len--;
> +
> +	if (len != pi->len) {
> +		path_alloc = xmemdupz(pi->match, len);
>  		path = path_alloc;
>  	} else
>  		path = pi->match;

> +test_expect_success 'git log with paths all contain non-wildcard part uses Bloom filter' '
> +	test_bloom_filters_used "-- A/\* file4" &&

We'd ask the Bloom filter: skip commits that you know that can never
be touching either "A/(anything)" or "file4".

> +	test_bloom_filters_used "-- A/file\*" &&

We'd ask the Bloom filter: skip commits that you know that can never
be touching either "A/".

> +	test_bloom_filters_used "-- * A/\*"

What do we ask?  The second one says that a commit that might touch
"A/(something)" is worth investigating, but what about the first
one?  

Ahhh, that one is not quoted, so the shell expands to existing files
(which presumably do not have any wildcard characters).  OK.  If the
lone * were quoted, we shouldn't be using the Bloom filter.

> +'
> +
> +test_expect_success 'git log with path only contains wildcard part does not use Bloom filter' '
>  	test_bloom_filters_not_used "-- file\*" &&

OK, this is exactly the case I wondered about in the above wrt "builtin*"
and I agree with the expectation of this test.

> -	test_bloom_filters_not_used "-- A/\* file4" &&
> -	test_bloom_filters_not_used "-- file4 A/\*" &&
> -	test_bloom_filters_not_used "-- * A/\*"
> +	test_bloom_filters_not_used "-- file\* A/\*" &&

This one I understand.  The first one reduces len down to 0 in the
wildcard stripping loop, and makes us say "a commit that might touch
any path is worth investigating", which amounts to the same thing as
not using the Bloom filter at all.

> +	test_bloom_filters_not_used "-- file\* *" &&

Ditto.  Even if the unquoted * may expand to many concrete paths,
"file\*" that can match any path that begins with "file" that ever
have existed in the history would not help skipping any commit.

> +	test_bloom_filters_not_used "-- \*"

Ditto.

> +'
> +
> +test_expect_success 'git log with path contains various magic signatures' '
> +	cd A &&
> +	test_bloom_filters_used "-- \:\(top\)B" &&
> +	cd .. &&
> +
> +	test_bloom_filters_used "-- \:\(glob\)A/\*\*/C" &&
> +	test_bloom_filters_not_used "-- \:\(icase\)FILE4" &&
> +	test_bloom_filters_not_used "-- \:\(exclude\)A/B/C" &&
> +
> +	test_when_finished "rm -f .gitattributes" &&
> +	cat >.gitattributes <<-EOF &&
> +	A/file1 text
> +	A/B/file2 -text
> +	EOF
> +	test_bloom_filters_used "-- \:\(attr\:text\)A"
>  '

OK.  Good to see negative test cases here, which we sometimes forget
to test when showing off our shiny new toy.

Taking what I suggested above, here is a possible improvement.

 revision.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git i/revision.c w/revision.c
index 2a5b98390e..2a92bdda84 100644
--- i/revision.c
+++ w/revision.c
@@ -696,14 +696,14 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
 	char *path_alloc = NULL;
 	const char *path;
 	size_t len;
-	int res = 0;
+	int res = -1; /* be pessimistic */
 
 	len = pi->nowildcard_len;
 	if (len != pi->len) {
 		/*
-		 * for path like "/dir/file*", nowildcard part would be
-		 * "/dir/file", but only "/dir" should be used for the
-		 * bloom filter
+		 * for path like "dir/file*", nowildcard part would be
+		 * "dir/file", but only "dir" should be used for the
+		 * bloom filter.
 		 */
 		while (len > 0 && pi->match[len - 1] != '/')
 			len--;
@@ -712,19 +712,17 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
 	if (len > 0 && pi->match[len - 1] == '/')
 		len--;
 
+	if (!len)
+		goto cleanup;
+
 	if (len != pi->len) {
 		path_alloc = xmemdupz(pi->match, len);
 		path = path_alloc;
 	} else
 		path = pi->match;
 
-	len = strlen(path);
-	if (!len) {
-		res = -1;
-		goto cleanup;
-	}
-
 	*out = bloom_keyvec_new(path, len, settings);
+	res = 0;
 
 cleanup:
 	free(path_alloc);
