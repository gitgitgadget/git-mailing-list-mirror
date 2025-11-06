Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4218270ED2
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442665; cv=none; b=JOdI9p2SruDV6gNubRSBmp53OZNYAJEQNhWh6FZSOKFFEoAXEa9x0yF/Nfm2PWemZtPwAS4knXRLntykqznD303jlXaShrZ8KjvsxHy5enYU8h3myvkzHwONB+elQ1Zw2bBw6e16SERtxhlDec9mnK+NhWGwtNmWbV+3WgioWUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442665; c=relaxed/simple;
	bh=w+GPwXRHxoxQa0883hKzL8ssKt/HlXS7Aa4gNnu+7Qc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L1U5FlqEqF3sSbvWrt9dGOcsJNirp8Zuvl0C2s/RW+O4ZApnNd9MKHjdv4ry2qvl5nCCtAIdM8OLHL7uXGrAoLZTv43EzMYmMntIFfu3MJsUpBezUfLZNVp6aJLxO8H7Kf9wuoDdJr3qrVEXyEHcSZqkGfKRBP03G7ZEg+sDPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZJUBDXPS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R8RSKXRl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZJUBDXPS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8RSKXRl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F780140017C;
	Thu,  6 Nov 2025 10:24:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 06 Nov 2025 10:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762442662; x=1762529062; bh=7ZPUo8szYY
	aaNILENv/EZ5xv4RzlQN1HDAet2MZdpys=; b=ZJUBDXPS9TE8KGZIY/Oi4wm7FI
	glLF9zncGKplzUi2dAWsGwU8kq+rg3PyjuvcdiAmXL4brotRucLDoCt41qhBPikR
	uXWBrjAZxh77HqTX2691vRs9JCh2fGOwD6zsOCicyRMEaoaqZRlHV5NYmsPc18S2
	w8p5xn3G3TImqWZxOiqPs3fv5URoDUTMMieLGY6AjJuLbn2KMPI/c/Bt+d+khOfD
	cOBw0urkkODyfI9ED7hCYDZSMNEyzfEPUzAapCdTyziFsFEdywdaEXyBi6hkEYm4
	JrSl/QrxGFvGbumgu3tsL/vVsDvo8WzvgZ8oaLIDFkRPhZ4AvLvGpc9nPN7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762442662; x=1762529062; bh=7ZPUo8szYYaaNILENv/EZ5xv4RzlQN1HDAe
	t2MZdpys=; b=R8RSKXRlm1HdWFNE2Ik0KJDA5eh8tLnP7M4h+agP4VVPnO5Ce1G
	li6sLr37l3lE/Wuoa0+5iirKKhTDrB7gtBPI0d//6p4f9EpGLn0UlPSJuE7nESQ0
	moKhK7fzhLl/ljPsnKFIUOWcIBUSsT7zPIf28WDdVWNxzUDCFnZRojqN2WaZVM1Y
	m/AyG24maHnKVEWtgEsPFKmeZ6DnZ5a5mukw7fwCjVjZDcRNafq5dMFuHRM/QjMy
	I1YNEGhLUKMV4ll6He47a3elj8KmW80wyRfGkWBRLYZ7m0AbItAMr157rcL3F/SS
	IjAhOUL8loROURqHcHDzGjHwhi8gfWc0/Wg==
X-ME-Sender: <xms:pb0MaVlJWspRaFfzfYNH0AJpohSV8b50Pqh2CI-tXRTXGYg-zJ_aDQ>
    <xme:pb0MaXsXkC1ThtDEXrCyHymAdxvUV0H2G0f1eS9xexFgkutb9OEj4pI26hXKE7igO
    9Ir5evtMbYwju4RfGKKrKEI0tI95FHtDQqn1DEM45sfSAB9jjFoRQ>
X-ME-Received: <xmr:pb0MaT8U6c0TijGF3YRsZfz2F-lrhmJrvXYiOGQsSBeCky0o9wmRugcC4_xzKizSe8-7DqBbHtvsfk2piLY9amHH9EVIT0ftO7RU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pb0MaRNjI-YaEo9wAp_nO4KUECjcGCv9lgO3uSlmCc_isKHha1gQhQ>
    <xmx:pb0MaRH-rczt31dnqrUjSn4NLoOh_YAV2EpO-0-LxuhCcwmKbhYDQQ>
    <xmx:pb0MafTMAHIiviSPOFNbl1L159BMdJxdZndiT8kGpABhNHexLjlL3A>
    <xmx:pb0MaevDoyFxkko238PiwKkF7DhZTlAB2W9JcQEmlpr-1tAYtuxGRg>
    <xmx:pr0MaQc7QtXjuk9iMtEc2KZXzsqdKj4mkORPm2AEF8z_ZeXeG2alS_CE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 10:24:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com
Subject: Re: [PATCH v3 4/5] maintenance: add checking logic in
 `pack_refs_condition()`
In-Reply-To: <aQyNSOdPWAxm15U3@pks.im> (Patrick Steinhardt's message of "Thu,
	6 Nov 2025 12:58:00 +0100")
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
	<20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-4-d611a2a95cf5@gmail.com>
	<aQyNSOdPWAxm15U3@pks.im>
Date: Thu, 06 Nov 2025 07:24:20 -0800
Message-ID: <xmqqpl9vjiaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +	/* Check for all refs, similar to 'git refs optimize --all'. */
>> +	string_list_append(optimize_opts.includes, "*");
>> +
>> +	if (refs_optimize_required(get_main_ref_store(the_repository),
>> +				   &optimize_opts, &required))
>> +		return 0;
>> +
>> +	clear_ref_exclusions(&excludes);
>> +	string_list_clear(&included_refs, 0);
>> +
>> +	return required == true;
>
> Tiny nit: I think in our codebase this can be written in a more
> idiomatic way by saying `!!required`.

Comparing for equality with Boolean in general is stupid, as
Booleans are designed to be usable as-is.  If it is "true", it is
true, and you do not have to compare it with "true" to ascertain
that it is true.

I do 100% prefer "!!required" over "required == true" or "required
!= false" all the time, since it is more idiomatic, but I vaguely
recall we had something that contradicts it in the CodingGuidelines
document.  Perhaps we'd want to fix that.

Thanks.


[Footnote]

But doesn't your suggested rewrite potentially change the meaning?

The original allows required to be "true" and nothing else, while
"!!required" allows it to be any form of true (and in C, things that
are not zero, even a pointer that is not NULL, are all true).
