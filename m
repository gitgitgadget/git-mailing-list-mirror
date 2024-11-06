Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B817B50E
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857133; cv=none; b=YLUGREb7Dd/+F2RZrf7Wlzuhmsw+CyWXwjjTtHylxdXCHVMrObQwwowFYmlvCs5zHteeNkg8/eIFsymMoSYbciMrnspRfzVQ+N9ndtmDG1Nf5fdwJ0vswDEF1Jei2UJh7F4Q6W3FNDvSWAf1qR5GJW98ZhNqEGeNUrTl4lrk9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857133; c=relaxed/simple;
	bh=Bk3nh5mhxNLU0ZQUxu+GvXO/XP5me6xUe0EfB6e7YB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nGYUkyis/pXyy3QQG/0FxQ7R5zZKaTUKalN4blEn26ZMF777edGbrINRNrVJnvWvhzZLhMme3A91kwdM55O22jI7OmuHpxYmZ4jb8s9c2HA+UG6fUEv/mRfSO39sZrw5DO8gDecOqBtW7LJ/kggjopIW2za0biY5Xty4F6XoBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g9qw2iyx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=neNNyWav; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g9qw2iyx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="neNNyWav"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C1D71140126;
	Tue,  5 Nov 2024 20:38:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 05 Nov 2024 20:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730857130; x=1730943530; bh=I2fiVwAzkE
	Fqu3bj44YHiJr1IbBiKkTAb5wHZ+cQNUs=; b=g9qw2iyxy1drQm+s2oT/w73FcB
	0KMQ9uEbP/M/Y5vPVa1y5K5K0b8Aqg0L9i4QaVFR4AvrJWA41HrRvJZ6oRMr7p9p
	Q59CDcVvMvzx3QCvJICRt5qGmt33UoCyd5veDhRJJzNjgOG3LPgJjOyrhpEeSFgC
	Tm7I2d7JJwiVZ5kh08GSji69cFxs5jYfllPZbj9UhbVj06IJIsJzqLG7wugdQHmu
	Jq5ZlpGP1VKvPHS5y5tRsDU1/yI3TfsHai5E1MPRfJIEaKies8PfocM/3MMDSBkA
	Wl1OuwMelpZZpaSbwDo1y8OVlQ8Yt86womJeiYgxOp5xqhDkUqBqbfaqLebA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730857130; x=1730943530; bh=I2fiVwAzkEFqu3bj44YHiJr1IbBiKkTAb5w
	HZ+cQNUs=; b=neNNyWav8bbfOwxwK+iQPdO1iVSMA0y/PGgQ1DUzSRWVEjghHr+
	RYZTkfBUERRa5tveTVxzbgSyUn0daWbuhEdfL0NK1pxMs4Yc86oGOauzFMBX2Yig
	nBxfg7nw0JjNPEgKClhnITXWFiWdtXY5HxthIfUHlBxfaCVSXqLQlunvbzxVkHXq
	3Eq7KrQkBj/Ys/abNYrQknxOm16RVw3cngonlxakTpN6zJ9OoF+zinMYRXm8Ff3N
	kWVXie2qG7HZPEXAIBTdPFzmJviWZnbkBDR0YGAnUh9yvH3CE0Z4/hH61HUYtFHo
	QeDNMSZL96smfibFCx2htVmYwZI+qTLHkmQ==
X-ME-Sender: <xms:qcgqZ2pGf4l7_BwgEatk3YdT1jcViJJX2pPcsdKRl_xP0iYMPNoCig>
    <xme:qcgqZ0pTIgL9Mzzw9LvYdt9JoREX782_R7fC1feGGC9oDUAcR3UE-bL11VNWhJAOD
    vhQmIlDAUJJkX9A5g>
X-ME-Received: <xmr:qcgqZ7NKCqtIfkZnOf5ZC_2ubn-u2RLoE-vd3o0du2gEZIiCC0EN_28z7FYPq0ZMHulKroPXQhiENlW_w6omaku4ZIrlB-WmHmVa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qcgqZ14MZm4aTDtv1z8OWL3mSL6dRFEp9iDMJzhLCrYHMOQBIfvI4w>
    <xmx:qcgqZ158e9fWcRZpyA--YZiX1aS_chgtsbVJj7iJQl7vUep_wMTT-g>
    <xmx:qcgqZ1gE31yZfCzTcWoWqJf76jpfonYqsC6AtVO5n4su3veOtjtxKw>
    <xmx:qcgqZ_56maxh_POwnXUMkKjWkLdd3WzyKhBoCDpl8prJPqx2hrYjlw>
    <xmx:qsgqZysaUzsc5c4aPZcnVuls66gN2gQjonZOjBw_lwaRjHEvivc1pROX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 20:38:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] t/helper/test-sha1: prepare for an unsafe mode
In-Reply-To: <0e2fcee6894b7b16136ff09a69f199bea9f8c882.1730833507.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 5 Nov 2024 14:05:14 -0500")
References: <cover.1730833506.git.me@ttaylorr.com>
	<0e2fcee6894b7b16136ff09a69f199bea9f8c882.1730833507.git.me@ttaylorr.com>
Date: Tue, 05 Nov 2024 17:38:48 -0800
Message-ID: <xmqqcyj9qgyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> -int cmd_hash_impl(int ac, const char **av, int algo)
> +int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
>  {
>  	git_hash_ctx ctx;
>  	unsigned char hash[GIT_MAX_HEXSZ];
> @@ -27,7 +27,10 @@ int cmd_hash_impl(int ac, const char **av, int algo)
>  			die("OOPS");
>  	}
>  
> -	algop->init_fn(&ctx);
> +	if (unsafe)
> +		algop->unsafe_init_fn(&ctx);
> +	else
> +		algop->init_fn(&ctx);

It may be just me, and it would not matter all that much within the
context of the project because this is merely a test helper, but
giving a pair of init/unsafe_init methods to algop looks unnerving.
It gives an impression that every design of hash algorithm must come
with normal and unsafe variant, which is not what you want to say.

I would have expected that there are different algorighm instances,
and one of them would be "unsafe SHA-1", among "normal SHA-1" and
"SHA-256" (as the last one would not even have unsafe_init_fn
method), and the callers that want to measure the performance of
each algorithm would simply pick one of these instances and go
through the usual "init", "update", "final" flow, regardless of the
"unsafe" ness of the algorithm.

IOW, ...

>  	while (1) {
>  		ssize_t sz, this_sz;
> @@ -46,9 +49,15 @@ int cmd_hash_impl(int ac, const char **av, int algo)
>  		}
>  		if (this_sz == 0)
>  			break;
> -		algop->update_fn(&ctx, buffer, this_sz);
> +		if (unsafe)
> +			algop->unsafe_update_fn(&ctx, buffer, this_sz);
> +		else
> +			algop->update_fn(&ctx, buffer, this_sz);
>  	}
> -	algop->final_fn(hash, &ctx);
> +	if (unsafe)
> +		algop->unsafe_final_fn(hash, &ctx);
> +	else
> +		algop->final_fn(hash, &ctx);

... I didn't expect any of these "if (unsafe) .. else .." switches.

