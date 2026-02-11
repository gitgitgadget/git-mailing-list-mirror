Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B733451C8
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828411; cv=none; b=YbbN29Raiuxbgjxsg/x5JOqkGcWeauMXznOQKP9NdcqbvuUMpZzFjfGS1xVK/Gs+Agae8fgJ0eDzJYak0QhbW4mqyViMSGqgJNANUDQHt3Ktb6eltbiEA7ehiecs/7dLASK4p4R7l7aQPhieWvOPJwG0pipPzJnNvHiGH7pblw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828411; c=relaxed/simple;
	bh=K90hDmE71UJgRyUG1C7nuO08WD+gjDgRCv6MiRtbV0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IMGpI8epumdIAY3fotAQ5FAvrszi3NQiBZwpG1KpmZRxHYcRYoKmw56BY089feWrJfXlc33XoKR1HnjQtkGwVJPX6rxilz4/hxx/Juo1mtCOvQM9WKBQqEG6ixvAioN5v9mizsCyGT42C2ducYrPx2ZG1DVOolmDJLnHBbr2ZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bq27K6SJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ojv8MObG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bq27K6SJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ojv8MObG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CB10EC0586;
	Wed, 11 Feb 2026 11:46:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 11 Feb 2026 11:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770828409; x=1770914809; bh=84rwl1uUVm
	xvE6GFWcUDmf5F/8GokBZUkGeGTcE5Yn4=; b=Bq27K6SJEE7C4atNZb2bxACAFy
	0qeBXXYKQj0dZnInglsUUM7I1l1//BNBcJOcBap022rhvCN2bcOHXA90wjVsf67q
	dNtIZS0dDe/eMyQHuUSOhmlvkNzNplYgXdivKziXw+s+gRYENFHUWqBQ8a8AEMu/
	PVqwO+JIr9cJ+42M2ZRQ4tM46WWGmLNexsDPRxNGWqP2E6FG0aNmiK0URzktaxeR
	wPEL2ukJ6AbEK03jdC0k1F7LphgcaHe7K3QFaO46ktB1C5Lpgtte0tlL8EUJ4wa0
	kDl3wW6wOuAR7tVw8qkUSMkJV9T41CleCpt7tDBh3lMTajoW2PtRbcmr1pgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770828409; x=1770914809; bh=84rwl1uUVmxvE6GFWcUDmf5F/8GokBZUkGe
	GTcE5Yn4=; b=Ojv8MObGSnK7KfQC3G7hfArqazNQGHJ30FIHb0FJTUSUm3v0lWA
	OMsrUx8EKt8HI1OIXGzFYIzuNJZ7mfaOFwY7Z73xc/Brn1+DGO+RfRk7LL5Yx1Eu
	WrY+yj8R33PfH47SXAS6eGkcybb5kHb9TSWRaHimb8h0vN4sgDq4VZhltXQV+VwY
	H+rlDE/7Z8qL5nzgXYUHj9JrSMs42Z+pL14W6Q8m75UkTopzquvm+H9pq2ogHCrk
	IXNfRaF7nj/0rk5FAARX+mcBhXB1oavk8dz88eprLrK8gP97QF/gH3Vsmr+cfWWA
	64CvJIB2DpYyauAOTuJBGlYuWAzsFw/HSYg==
X-ME-Sender: <xms:eLKMaVcUHvtxfn8p6vfU5WN7AV_ztijTVQbnkFbUU1r0cgc71nIThg>
    <xme:eLKMaRdZwYbnu1-WGhiTsJK9FKvXmx4PETdw4tYFOdTxxR_GG-B6yEZY3CikAU4FA
    JsF7ABqhDR0JWjFSjjIim47Vz2BezQMurlnCe1uTxsgzTMlZChR>
X-ME-Received: <xmr:eLKMaX3c3yBWzcuZjxin1Z_hraV0wqD7fqAuIJNwDYD_XXAAZYLlV5Wt7Qyagadrph14JMZYr38SHjQDHqHPYLyT62PfV8-Dbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsggvlhhkihguleeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:eLKMaR8Cir_c9TWof6ba8qLOxiVzlbswD-hXRtF_UIP_2XQHjteNSg>
    <xmx:eLKMaU7cCTJBEqaSbHFitpjq9eDOGzAUKz7C8Xc88L4tDwst9FQDkA>
    <xmx:eLKMaRtMOqPvP0Ix4JR0Sej2r0_yXFNN5ctgzfZXvJKgmbyVfPz9Ow>
    <xmx:eLKMae3iZzuy35XazIzqG9-YJsjzYAOy1EYAMcOCWsqZSH-qIJPlbw>
    <xmx:ebKMaS-H9gA45Qu2gbJ2BV6kyD0XmsinZrIK9aAUn57ZIN-tje2wiN47>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 11:46:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Bello Caleb Olamide <belkid98@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com,  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com,
  phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
In-Reply-To: <37abfe28-ff89-460a-962d-4503ec3f7975@gmail.com> (Phillip Wood's
	message of "Wed, 11 Feb 2026 09:31:53 +0000")
References: <aYsEpvFwCSHb5DYO@ubuntu>
	<37abfe28-ff89-460a-962d-4503ec3f7975@gmail.com>
Date: Wed, 11 Feb 2026 08:46:46 -0800
Message-ID: <xmqq5x83w7m1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for the backtrace which helped me spot the problem though I 
> should have spotted this yesterday. The problem is in 
> initialize_repository()
>
>>   void initialize_repository(struct repository *repo)
>>   {
>> +	if (repo->initialized)
>> +		BUG("repository initialized already");
>> +	repo->initialized = true;
>> +
>>   	repo->remote_state = remote_state_new();
>>   	repo->parsed_objects = parsed_object_pool_new(repo);
>>   	ALLOC_ARRAY(repo->index, 1);
>>   	index_state_init(repo->index, repo);
>>   	repo->check_deprecated_config = true;
>> +	repo_config_values_init(repo_config_values(repo));
>
> Here you need to use repo->config_values_private_ instead of using the 
> accessor as it is fine to initialize the config values to their defaults 
> in any instance, it is only when we read them that we want to assert 
> that we're reading from "the_repository".

Sorry, but ...

At the beginning of repo_config_values() in the patch, there is a
check to ensure that repo->initialized is true and otherwise you get
an error.  But the initialization is already done in the early part
of initialize_repository() as quoted above.  So I do not see what
difference it would make if we rewrote the last line as

	repo_config_values_init(&repo->config_values_private_);

I am confused.

