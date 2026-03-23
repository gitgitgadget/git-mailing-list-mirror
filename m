Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336B154425
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304853; cv=none; b=o8n6renHgGKgs5YMqvVpnLoGJouYpKBLbmyyXqYajv88ntkjhgYaWQ+3bLs7gfZhNkxVtMSKTu87LKXSYRZLHGw5dTTXhyEK7VMTOS3kLHV3IWGokLlJR5ljsogE2r5kPOjgNFThui1au88VYKJfMAX3CwIyP/DbIGJZtHaqwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304853; c=relaxed/simple;
	bh=fS+F9zkcQnP3naZBJusIlGuHbcpEnGpZyl1Mg9WIrW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TXwThd3QY9czTqop+Gbi6wmDjhZ9bFIKbajQtWhQ/wGZtL94IRLqb/tu5Jxs6XMJaRJm86uhrE+HpgM2MLVZSsrHLMcM8ELRhPNmETeao4UK0mm7DRycijf3EBxddjFJIU1sRj/oFh7RjidGZT2/3YwP34kXaPsVHM6AqPak0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PE8TqYhT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSAwtgdm; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PE8TqYhT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSAwtgdm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4ABEF14001A9;
	Mon, 23 Mar 2026 18:27:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 23 Mar 2026 18:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774304851; x=1774391251; bh=TI8UCmOXDW
	gFxhwyfgp4i8M6KI4c4cJa/cD9BiKlmXA=; b=PE8TqYhToIhRvOV1f8vRhX24BW
	YcZ8RNaNIOQEA97/XEUmGhyg9VkH2eNYFTuvMKBL64MtG4MGeYfn9ZG0LHQoFI9v
	Bbol7VhPWkfM6ANg914nhHVFs3HToovYBvi4AOV5qhC3+ASYGVmtoiCcevg1sQZy
	46pOj8OZjH6V9MKxvDdNTBLx0C29dge6PEqoO/vlM73CA/VftZLnxonQNaGb2Vuu
	Gci2VFoxD7vOIOnR748OBNaC/3ATZlveqZod4V/BWKO/r0E3PLyHnR7UOkM5W+qm
	X2Mvp98/BBcmSh5K9c8V5jwtERTzLIOqYX3buZtY7lqVTHGUN3Gvv9Q27CUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774304851; x=1774391251; bh=TI8UCmOXDWgFxhwyfgp4i8M6KI4c4cJa/cD
	9BiKlmXA=; b=SSAwtgdmpVlZJxoocPGuc+rngJG5Us/mz4t1Rn6EtbgfuKwklws
	fZoE/3PlpHYYfM13fywyFB5+HFSeRTeZlkbFThheXiFqGtMLsrhVIkn25e7d0Vnm
	LHgL94DL70WJV1fJK9ZVX2dOOSd+pZMc1g3hzDDiOVz3qeD3t3XZh1niPL9gLtT0
	8aIQUHu9q/umg++TUmLMf16sCUVZUi4a2WdIWKKRYtU6emh2t56kZRtvS7H3fCjR
	QMY5rQMsoi9RrGTdUqDq2wDEIlZlJ8o6Iv1hbTe2ojapWNj+hVWxEESfgsNZzEx7
	GJtbtxmFh+F2ibS1ZNB18w6o+67P88oVpnw==
X-ME-Sender: <xms:U77BadI-nPP0GvBHuASGKK95kWrlae-omQ-dICF4IRlLK4KZguRIZw>
    <xme:U77Bac2sABcyniO94uKUKvnS2-nxtbRVBrp0h0-0rLquEUtMUP9gI7C4w62doYBzO
    -51TjwyQuV9fkcqC0xFpPMPjv_G7jPWculTcM1trzhWi3ksfY4xAQ>
X-ME-Received: <xmr:U77BafgbScI79J3nlun-7LBvKHl5lsP47B59xaHeHmwpykmvEr4KS5S3Z1HKxLz5JqetDNs4sm-oV01qBlCAnhLOPs08XDYKww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeettdduhedthfetudettdffffegffektdeufeehudevledtveekteekuddt
    tdehnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdqshhmrghrthdrshhhnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhholhhishhsgedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhholhhi
    shhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:U77BaVUozyRNft5fh3H2Q0MztErPqv92jKfM45iP-1gD1LG57CkmmQ>
    <xmx:U77BaWVZQhUXv9d8cnHivjBw_13QUh1bS6lMZGmaMTr9BmRYNa2qmg>
    <xmx:U77Badjs3DeJTQGKEt6TRtda1JxHNHat-J2XHD7u0cCl0oGt7xF2vg>
    <xmx:U77BaZZeA_vqvgZ7-FVB75kOB616S5L_1LLUSZQLKeaNsU5GIogiMA>
    <xmx:U77BaSRxpeNPoYA-7kpsYPgz1ePFbVhqCYqMtWXwz_6KFRZyjxUDcqIS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 18:27:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  joliss42@gmail.com,  joliss@gmail.com,  peff@peff.net
Subject: Re: [PATCH v3 1/2] refspec: safely parse refspecs outside a repository
In-Reply-To: <20260322053617.38951-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 22 Mar 2026 11:06:16 +0530")
References: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
	<20260322053617.38951-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 23 Mar 2026 15:27:29 -0700
Message-ID: <xmqq341q41wu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> When git-remote-http is invoked outside of a repository (for example,
> by running `git ls-remote` in a non-git directory with a globally
> configured fetch refspec), `the_hash_algo` is left as NULL by
> setup_git_directory_gently().
>
> parse_refspec() checks whether the LHS of a refspec is an exact OID by
> evaluating `llen == the_hash_algo->hexsz`. With `the_hash_algo` being
> NULL, this results in a segmentation fault. The same NULL dereference
> exists in the negative refspec path.
>
> Note that builtin/ls-remote already works around a related issue by
> setting a fallback hash algorithm before calling into the transport
> layer (see 9e89dcb66a). However, since remote-curl runs as a separate
> process, that fix does not help here.
>
> Guard both dereferences with a NULL check on `the_hash_algo`. When
> operating outside a repository, fetching and pushing are impossible
> anyway, so skipping the exact OID check is safe: the exact_sha1 flag
> only influences ref prefixes sent to a remote v2 upload-pack during
> fetch, and we will never reach that point without a local repository.
>
> Reported-by: Jo Liss <joliss@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  refspec.c                   | 4 ++--
>  t/t5551-http-fetch-smart.sh | 7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)

Looking good.  Shall we declare victory and mark the topic for
'next' by now?

Thanks.

> diff --git a/refspec.c b/refspec.c
> index 0775358d96..a864a0bac2 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -84,7 +84,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
>  		 */
>  		if (!*item->src)
>  			return 0; /* negative refspecs must not be empty */
> -		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
> +		else if (the_hash_algo && llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
>  			return 0; /* negative refpsecs cannot be exact sha1 */
>  		else if (!check_refname_format(item->src, flags))
>  			; /* valid looking ref is ok */
> @@ -101,7 +101,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
>  		/* LHS */
>  		if (!*item->src)
>  			; /* empty is ok; it means "HEAD" */
> -		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
> +		else if (the_hash_algo && llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
>  			item->exact_sha1 = 1; /* ok */
>  		else if (!check_refname_format(item->src, flags))
>  			; /* valid looking ref is ok */
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 73cf531580..a26b6c2844 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -782,4 +782,11 @@ test_expect_success 'tag following always works over v0 http' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'ls-remote outside repo does not segfault with fetch refspec' '
> +	nongit git \
> +		-c remote.origin.url="$HTTPD_URL/smart/repo.git" \
> +		-c remote.origin.fetch=anything \
> +		ls-remote origin
> +'
> +
>  test_done
