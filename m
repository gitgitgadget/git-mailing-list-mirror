Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F81C32
	for <git@vger.kernel.org>; Wed, 21 May 2025 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747864060; cv=none; b=CVBnGf/qDjWOi1qy9cH6yefuyVOzdPiMlEBJbko7jh1VgjoEfFRRoidIAcSblMY0JdGu95NYgTJ0SE0/USSAwUQMcfLMItOWOXruh4HCEpbIkL1eIqoQgHDTl28zvOmCya4w9ptuP/cpbih9b0M2S5xtJQMVlAeYQChRsIq49PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747864060; c=relaxed/simple;
	bh=eU0rI2qpwXQxnJ2eWKmI9Ree7vCn+kQX4IdZWrUV5yM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lOt7RMQn9wlWmwACY5muYxUMisGwOpFXlexhSmy6MASl70w9yj6WiYWDn8GLmrq17+EGrcZWAvN983w7GVkuG8RMh7KsWJW+3qS/15Afw1ST2ZicDoM3svDXDH9f6QtaqnXG/Q9dHc+gokAPjty4E0lg94cVpNJKdD29xhyPUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZGFaCM6I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YKqw73xL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZGFaCM6I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YKqw73xL"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 346091140178;
	Wed, 21 May 2025 17:47:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 21 May 2025 17:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747864057; x=1747950457; bh=8QAgol0mki
	uB8QCTiUma8uBswD4f9R9e4w6QA4N0ATI=; b=ZGFaCM6IQZUEVxvyOP8kq3Ig35
	nfaXInUUv37pcZLuuRvMMu0I3QaB8AhdtOgozjixuO/OHBzTblIZ4SBQpfhu4QH6
	TPoY4EzopJ6U5jm3WmGwhfGxBbG0sqrMkVqs8aXvKePm+7e+UiLW3GAO4yL7Olod
	Ojs4LIeYKcNJQThC/On/32VZgwRKn/VIUlW6EZf0GELzHu+r0kVOaSpke9HTw7ea
	rorW/McWPM90cIZI5ZucgSUOfADiAL81DHw26IrZ6XEFBZbMPMAzk8obOu6ir7fU
	fpdbfsvnRJIMe73ALNGiDuKnshBvLvwHrb7beucltpMU+tvch59OzrD10KEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747864057; x=1747950457; bh=8QAgol0mkiuB8QCTiUma8uBswD4f9R9e4w6
	QA4N0ATI=; b=YKqw73xLjyETEZKzHCtrtWRQXvUAzfKiISjnFvOajf9Rhz+yIs/
	K8M6AyQv4nkwp53fKYPVgW61KUG3y8seKHH3d8v8UcqBp2hMLpX7LT4w2yE2Dkw/
	uD2P6peDQkncSYC2XJ15RlFSofYZQ6P5SwHHXI9oJnGLlsADzvmwBkmsDQQVw39z
	9g75AFkUzNjlJLQB6lL7TF8u3g42qTd+32lEr2EGjW8HoiHLsA3yHJsC8e3zh3RN
	Bg02BU2V2QqB/bM+X8bkwlOyaFT4z+BMNXzRGyDvMJgsBx+ygxZXI5U4Vzmbw4zm
	jGEhh47HyEDRnMqZaFl6H81N/kWcV1/ATzg==
X-ME-Sender: <xms:-UkuaLBpSgBjG4bOHmWjzsim8G9kUh188X9Wc5n3GpqKpQsUtK7oIA>
    <xme:-UkuaBg82VAc4ksG4WF7KfFgij1Jzn3pFJslH1K6gvR6JnhTdzaBb_G5tj4QbgMlT
    lW8K92D7U1afy_ajw>
X-ME-Received: <xmr:-UkuaGl-_MUC0pqh2pNQmI4Yp0qakp_0lPSIFHC4OTjyUHfb-fWdgk0UU3GOdV0jnRheKMB7ULK2WINt3QeInvVHUnZr0y19Uw1NqjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegudelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhhfohigsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-UkuaNyUwwFq4dB4L1iaJynl7sXhA-sFkDA7TYuBsEEAWvj5yaPDwQ>
    <xmx:-UkuaATOF7fdxJ4CJaSbvgAP3ATHsSAuUYDCqB5AnpDeZ8niLM-iOg>
    <xmx:-UkuaAbs0DzBWTC5f4yFoI6h5RbNFKFnVx8qmWWfvgD04_pdW9hFGg>
    <xmx:-UkuaBR0J9WMjpVPE66HP8gQQDrM1YQCb9Vu2cWnJvY-lzxnTQ9dwg>
    <xmx:-UkuaKQs9l0OFJJvG5W5AJNa0g-2163Hm-M4OEKf9T7VExkk7UijBzkE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 17:47:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Alex Mironov via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Alex Mironov
 <alexandrfox@gmail.com>
Subject: Re: [PATCH v3] name-hash: don't add sparse directories in threaded
 lazy init
In-Reply-To: <pull.1970.v3.git.git.1747862971672.gitgitgadget@gmail.com> (Alex
	Mironov via GitGitGadget's message of "Wed, 21 May 2025 21:29:31
	+0000")
References: <pull.1970.v2.git.git.1747858585623.gitgitgadget@gmail.com>
	<pull.1970.v3.git.git.1747862971672.gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 14:47:35 -0700
Message-ID: <xmqqa5758wlk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alex Mironov via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alex Mironov <alexandrfox@gmail.com>
>
> Ensure that logic added in 5f11669586 (name-hash: don't add directories
> to name_hash, 2021-04-12) also applies in multithreaded hashtable init
> path.
>
> As per the original single-threaded change above: sparse directory entries
> represent a directory that is outside the sparse-checkout definition.
> These are not paths to blobs, so should not be added to the name_hash
> table. Instead, they should be added to the directory hashtable when
> 'ignore_case' is true.
>
> Add a condition to avoid placing sparse directories into the name_hash
> hashtable. This avoids filling the table with extra entries that will
> never be queried.
>
> Signed-off-by: Alex Mironov <alexandrfox@gmail.com>
> ---

Sounds quite sensible and the above reads better.

> diff --git a/name-hash.c b/name-hash.c
> index d66de1cdfd5..b91e2762678 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -492,8 +492,10 @@ static void *lazy_name_thread_proc(void *_data)
>  	for (k = 0; k < d->istate->cache_nr; k++) {
>  		struct cache_entry *ce_k = d->istate->cache[k];
>  		ce_k->ce_flags |= CE_HASHED;
> -		hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
> -		hashmap_add(&d->istate->name_hash, &ce_k->ent);
> +		if (!S_ISSPARSEDIR(ce_k->ce_mode)) {
> +			hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
> +			hashmap_add(&d->istate->name_hash, &ce_k->ent);
> +		}
>  	}


This unfortunately gives us deeper nesting than your previous round,
but the conditional matches the original commit and easier to see
what is going on by comparing the uni- and multi-threaded variants.

Nicely done.  Will queue.

Thanks.


