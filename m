Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA125D534
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283804; cv=none; b=aS8nzg8oFYuGu9ECZNY6IcrtHvpvy7wffXQR8FItxYsUKm40YLApCGc3l9PRb9gDEtXuS/rbcIIFDivbHVrWmp0XCpiwPmOckH9vbN0qG11eMBBWEdLMfmaEnAU6A7uAOMBbBVaeOhfzAU6d7mks73bRQAUlEWsrq+69BzbRzhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283804; c=relaxed/simple;
	bh=zkkpW4WIVkpoMJB6w7EIi/IYPZ4syJhzZoXX52UPiyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e7hUTrgrO45OmNJLLJ4ftY9+wMXeBRuK3JmgYmjmf3jUIfDqowxTSfREXaqlgxiXIFMDMDV6zYay3/teBfsHClTPSEkeFqlryqy+qLEaArAKUASN3BUikW96/0ElNQGpjfvh3IpC9sxxiITOjTpKtUnDamifbgIdSA5JAJLZPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KW6M5VZa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fvb2qCHI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KW6M5VZa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fvb2qCHI"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C1451140101;
	Thu,  6 Mar 2025 12:56:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 06 Mar 2025 12:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741283801; x=1741370201; bh=Xh48cjRknH
	dfMZAl4V1a2Dt35N68FfmvHrurFMcV3WI=; b=KW6M5VZaf0TiGRp5X8INJDuu1M
	qKiNyoXLziEoyqIRDBJmwyxXxf3clWyitL+k6rKo0AUhi3l+844YE8XGn3rFIg52
	UdInkvhPGkDPiSFROQx7HH7Gi0GO0e2BAAWoPBhxJeZVCRDk+Wfp9/Y/m8MngJDt
	tMgC283yHuZd82dzpDzRu/k5p/Xuy9B3lR4AVexsRELHvgR2HMH0Aq9n+UeztFWX
	cQnzUWdnDbb03JdW7OZmTXemKmV00AWRwTDUFtXTZmrBSKBoWs0VMnUT6R7yTTwk
	bKuI6F/rUkGhaokX9lQ9BSqSQd6VrCABM9657Z88Dl5bMqrBPvZx82jj0sew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741283801; x=1741370201; bh=Xh48cjRknHdfMZAl4V1a2Dt35N68FfmvHru
	rFMcV3WI=; b=fvb2qCHIPwz0Rt5HSuTsKPq9N9d3j/ylje8Nyvg216zF37R3/zH
	yVzCHUjS1IAB5F7pKjcoGSLf3UnFlG7uN/IfaKruuza/R5HD4Ed4ZL65rdHVTZBB
	h4ovKNbB/HjthG3H+kIRE41kRfjmGnDc6iM+r8kjXm8d9aaYrBYOW/SrxmiyJmO0
	5/e8qZ/IxgP1XZlu2V7p5phy6IDMli5JwGuhWHAvKfDv07EL17VreyWIMIklcgoA
	ERXw4Kflj+sCQ5RwzcSNAXYjHp575EEdForTB7wXu+YDRPw+qVa7SLFfJW99en4k
	KwToZxkGrOS86LodIVSZ+tb3gyvoqpln95A==
X-ME-Sender: <xms:2OHJZ4PNjRp8Q4NukbL5g-5KVh78cxwTviiZa876gMyKfJZhLk6dBg>
    <xme:2OHJZ-9OvgtL9FopGGT8EziDqfuXdZn4cGn_A7Sj8t4hFvFgrhZpfa__1a_UVnp8y
    PPK0rAlDupLeUNtPQ>
X-ME-Received: <xmr:2OHJZ_StpvjDu_scl7-stnCFK9ALNq07jUthL4YYuylsqEdJKQUVpLHAt_vWW5_1pCuEWYZ1meAZwG8rt8wc3G92wlyQKSH_EWxr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2eHJZwu1FNlrGdRi4LpW1vIb4cOQV6I5ji2AKVRsES7IUAt6JZSgtA>
    <xmx:2eHJZwe84LQi_nOzK24_gtLpnKvKi8UnMBJ3LL9pdnm0swYyfurNFQ>
    <xmx:2eHJZ031-NUuHIOcnrv-xctEetsoD4lmh6v35KBJJu94umEzgZBk1Q>
    <xmx:2eHJZ08x_SIPdtqB882FgFZx-1Z_GmcObWnq-Lhb7gzCOpbKTAJDhg>
    <xmx:2eHJZ44uvY3EYk8c2IZaTpEKjujPJ_msO4ESDNLsd3LZQj6E5vbjZ1KK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 12:56:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  johncai86@gmail.com,
  me@ttaylorr.com,  ps@pks.im,  shejialuo@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 2/8] builtin/verify-tag: stop using `the_repository`
In-Reply-To: <20250306143629.1267358-3-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 6 Mar 2025 20:05:46 +0530")
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
	<20250306143629.1267358-1-usmanakinyemi202@gmail.com>
	<20250306143629.1267358-3-usmanakinyemi202@gmail.com>
Date: Thu, 06 Mar 2025 09:56:38 -0800
Message-ID: <xmqq8qpihwkp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> When `-h` is passed to the command outside a Git repository, the
> `run_builtin()` will call the `cmd_verify_tag()` function with `repo` set
> to NULL and then early in the function, `parse_options()` call will give
> the options help and exit.

Makes sense.

> diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
> index 6f526c37c2..2c147072c1 100755
> --- a/t/t7030-verify-tag.sh
> +++ b/t/t7030-verify-tag.sh
> @@ -7,6 +7,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY/lib-gpg.sh"
>  
> +test_expect_success GPG 'verify-tag does not crash with -h' '
> +	test_expect_code 129 git verify-tag -h >usage &&
> +	test_grep "[Uu]sage: git verify-tag " usage &&
> +	test_expect_code 129 nongit git verify-tag -h >usage &&
> +	test_grep "[Uu]sage: git verify-tag " usage
> +'

OK.  I am not sure if we want to insist that the "-h" invocation
exits with status 129, but changing it would be totaly outside the
topic.

Will queue.
