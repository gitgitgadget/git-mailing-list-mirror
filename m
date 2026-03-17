Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65393F87EC
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774083; cv=none; b=RRIzjZwFALs4RL9x1I+Q2JJoCuc6qOIefMyGGaEMuqYVq2p/htw22SC/O2JUW0irvjayFwcLwylQBtxr5wuGyJBj9PipaDqlN5+vxYHepAgmWsVE7xmdl/m0cZR0ji8wGUd4AN8R3KAj4UCdRs+LWF23+rI0EmL4mKY/Xvgifxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774083; c=relaxed/simple;
	bh=xSgmjjN9DxsNsb+K6/Frc59dgTOV9y/H95vtgEXqVCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lqmIgATtoQPOyaoVs7jvAAfR/LeWcLxLD6CtJOzxNUsMs0M2ONfnZRs+Rl6lRPLmjN9GK9qeZ3k0gV1M/w/d/l0Vo7/WiZYZChnd1NEmlstaa6YsnuKOP0fQmgJBMSuDlUwMxW2bErBMYjVcvSFo0WoRRFD6UzHDlerEbKZM8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JbFEgkCr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYqhBkUX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JbFEgkCr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYqhBkUX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED0DA7A01BE;
	Tue, 17 Mar 2026 15:01:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 15:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773774080; x=1773860480; bh=4dicIX1d/i
	kk77fk1QAOB+W00A2lrhkNl2OlN+mR81I=; b=JbFEgkCrT7g8yFYLaJMdJT9aX7
	SCcnIzkD9/+Quk5ntTS8g6JCQDPcqXGXu0T0B+uCT1G5d0x2UtBnKob+ZyaOgwYe
	mWKkWrK/F9qzw1l36huhfmtVzPlYQtwD4vtlXFlhBQSPnohC3Ba+614WrjLH1y1q
	WNzTp0EfTyFBxA8Ci1EEnIdgmcJZ5RIjxC1re7qYjkVTygQdvyTx8oJoe92vEy6d
	LqxYLCDvMkyqfrKZuh0VA4/wXHqCPtMIbyAc8xbn1XZutr3PXHnLxFnzEkEi0B8R
	cD3Zr01JWrZzI0B/P2CzBhja75XEynOonr4oavvI3XxXZVl8BqZ3c/3tX8YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773774080; x=1773860480; bh=4dicIX1d/ikk77fk1QAOB+W00A2lrhkNl2O
	lN+mR81I=; b=JYqhBkUXxxRWzalHDa3sz0VAaWyF+ZIgdxev2mZxQLw0K3aMZUb
	SnwLQnVSOEKLd/VwBS3PWEaw7Mxwq/L8el6E4sLu5QvcM6wsElyMpWIG4gdBhRtg
	yyYU1A7VGT6bDKZc+8/l3YHJgptOH+7ODnbYKa/E0jRgeixRStcuoyXPiAVjvfVj
	8zgvUofKA6o1lOTLks71Ru7ZYUB8VP6dqdLsLqYzMGXn7+zF0aGQ4llPCW+FZ3dV
	tXwuK9RBBEItMaHxIt4iaA0Y3ohZzSlcEMT1INz1UdWcMBwOn4i0xCP27zd/4F1e
	VgaBdz+pAsBXx3S7X68ocxZDvTOeBgQzs3Q==
X-ME-Sender: <xms:AKW5adCA3yRMr3YVL4tnu8_0-d9PG2NJOz1_Y0-MSMK3zB-Qa0BlWg>
    <xme:AKW5aS-wdlKXZfxPk076l_e4gtO6g9fElgwhfkrGvfVr1pWdWIi7UkL8pVQ37RDXg
    uz0V9Kf6KQOZUggKOJ3hNwfTqQ9rFFiqAhGXFGi5LfEl7OheczZyw>
X-ME-Received: <xmr:AKW5aV9GpSCjxdDy1LCnELCL3Qsi6Pyg-SJWNB8Q2XDqvIxIHOZt0UIHwAtbT3FwBGrsvdEkdQMY_0uszL_srKAzfxMGV7ZLVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgvrhhrhiifrghnghdukeefseihrghhohhordgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AKW5aRfU9o1fiRwxVS-kwuhHCGEBRjAz8CHZWJKJ09F2P1kBbtAnhg>
    <xmx:AKW5aWFzOhbOTMHI4Oe2IfG5oW4MlhswCZKZ11JhH-4COhvGDYSmHQ>
    <xmx:AKW5aXfHiYAvIUpTjEXl0Cgb3fnlNT2myCYTAUUfR1kf1XmeIKEHoA>
    <xmx:AKW5aYHhZQXHUC6PQ4LUgUGCR_X-ko0k3OciLh3A9L5FQLt0KRwMLw>
    <xmx:AKW5aT6jVW7Cf9fyyz5asxzaJJzCRomsHTrudC-TSpWfjhaodgfX4gra>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 15:01:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jialong Wang <jerrywang183@yahoo.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] t2203: avoid suppressing git status exit code
In-Reply-To: <20260317185048.74421-1-jerrywang183@yahoo.com> (Jialong Wang's
	message of "Tue, 17 Mar 2026 14:50:36 -0400")
References: <20260317185048.74421-1-jerrywang183.ref@yahoo.com>
	<20260317185048.74421-1-jerrywang183@yahoo.com>
Date: Tue, 17 Mar 2026 12:01:18 -0700
Message-ID: <xmqq7bral1q9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jialong Wang <jerrywang183@yahoo.com> writes:

> Subject: Re: [GSoC PATCH] t2203: avoid suppressing git status exit code

We saw a patch <20260317011544.65952-1-jerrywang183@yahoo.com> that
looks similar, sent by you about 18 hours ago.

Please do *NOT* send an update without marking it as updating what
other patch it is replacing.  Turning "[PATCH]" to "[PATCH v2]" is a
minimum.  Explaining what changed below the three-dash line after
your sign-off would be a standard practice.  Sending the updated
patch as a reply to the original would also be a good idea.

> When git status is piped into grep, the exit status of the Git
> command is hidden by the pipeline. Capture the status output in a
> temporary file first, and then filter it as needed, so that any
> failure from git status is still noticed by the test suite.
>
> Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
> ---
>  t/t2203-add-intent.sh | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 192ad14b5f..44c1936e4d 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -16,7 +16,8 @@ test_expect_success 'intent to add' '
>  '
>  
>  test_expect_success 'git status' '
> -	git status --porcelain | grep -v actual >actual &&
> +	git status --porcelain >actual.raw &&
> +	grep -v actual actual.raw >actual &&
>  	cat >expect <<-\EOF &&
>  	DA 1.t
>  	A  elif
> @@ -26,7 +27,8 @@ test_expect_success 'git status' '
>  '
>  
>  test_expect_success 'git status with porcelain v2' '
> -	git status --porcelain=v2 | grep -v "^?" >actual &&
> +	git status --porcelain=v2 >actual.raw &&
> +	grep -v "^?" actual.raw >actual &&
>  	nam1=$(echo 1 | git hash-object --stdin) &&
>  	nam2=$(git hash-object elif) &&
>  	cat >expect <<-EOF &&
> @@ -171,17 +173,20 @@ test_expect_success 'rename detection finds the right names' '
>  		mv first third &&
>  		git add -N third &&
>  
> -		git status | grep -v "^?" >actual.1 &&
> +		git status >actual.raw.1 &&
> +		grep -v "^?" actual.raw.1 >actual.1 &&
>  		test_grep "renamed: *first -> third" actual.1 &&
>  
> -		git status --porcelain | grep -v "^?" >actual.2 &&
> +		git status --porcelain >actual.raw.2 &&
> +		grep -v "^?" actual.raw.2 >actual.2 &&
>  		cat >expected.2 <<-\EOF &&
>  		 R first -> third
>  		EOF
>  		test_cmp expected.2 actual.2 &&
>  
>  		hash=$(git hash-object third) &&
> -		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
> +		git status --porcelain=v2 >actual.raw.3 &&
> +		grep -v "^?" actual.raw.3 >actual.3 &&
>  		cat >expected.3 <<-EOF &&
>  		2 .R N... 100644 100644 100644 $hash $hash R100 third	first
>  		EOF
> @@ -211,11 +216,13 @@ test_expect_success 'double rename detection in status' '
>  		mv second third &&
>  		git add -N third &&
>  
> -		git status | grep -v "^?" >actual.1 &&
> +		git status >actual.raw.1 &&
> +		grep -v "^?" actual.raw.1 >actual.1 &&
>  		test_grep "renamed: *first -> second" actual.1 &&
>  		test_grep "renamed: *second -> third" actual.1 &&
>  
> -		git status --porcelain | grep -v "^?" >actual.2 &&
> +		git status --porcelain >actual.raw.2 &&
> +		grep -v "^?" actual.raw.2 >actual.2 &&
>  		cat >expected.2 <<-\EOF &&
>  		R  first -> second
>  		 R second -> third
> @@ -223,7 +230,8 @@ test_expect_success 'double rename detection in status' '
>  		test_cmp expected.2 actual.2 &&
>  
>  		hash=$(git hash-object third) &&
> -		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
> +		git status --porcelain=v2 >actual.raw.3 &&
> +		grep -v "^?" actual.raw.3 >actual.3 &&
>  		cat >expected.3 <<-EOF &&
>  		2 R. N... 100644 100644 100644 $hash $hash R100 second	first
>  		2 .R N... 100644 100644 100644 $hash $hash R100 third	second
