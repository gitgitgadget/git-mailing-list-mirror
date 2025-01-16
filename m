Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0386323
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048245; cv=none; b=fobwuSxfQP5dmi45UiBIQz2/p0Br1bMGy1aOOv/tcGRIKpsj4uDwwytOBxfVb8IihvKScpcrkkitSbhYI3RYwRQOTsJKAITpUIov6JGISdvavkREGZ/qkWbpxGGdf6lLzXAlCvAeL9dtNYuBnti3LX/ZPFUZ2YoHgu2sxIUdqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048245; c=relaxed/simple;
	bh=sKfo6wjO3XP9UTu6s1N13opQ0UouE+TT1AIbQKZqT+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qai8P5/jZ3L9wKo8DwUeOXOAIWu7jN8trr7LvNqDzNsY/zf9YpVG5eyisduRfSgfYI/w9BjxMxlc4c8Zv8avQykdvuYwefo7J+W8KONczPmw5Bbc0hvkyPDsXVcQV1M5sZkqPXng73y/U40cWICMg7zdCQ8eQDuIr0jatvAgTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OVXLnVsT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P29hNy/4; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OVXLnVsT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P29hNy/4"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B8DEF1140186;
	Thu, 16 Jan 2025 12:24:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jan 2025 12:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737048242; x=1737134642; bh=E9p+OVAAji
	OrmwWFV8XeztMQ0uTJMxLowst8PDT9kUg=; b=OVXLnVsTlMVFGntii/WZWXmi+w
	poukPtsJY3TZ4E3EBUWgselQGUM6fa9xMjIfKmxlQcfW8k88yWbhoEwYJmRXCBqn
	fAxTODTINzbyzphVJEU1eUKcAN3iui6xcLRHo8g8HvRod2dt2QbMNQ6o8CTl1bzw
	rxabRZ12wqL+n7G7U0rDW4hAYD4CCrISGYZwk/daDeGMbIIYvNQxVAsJigFeGd+c
	R3+3mfd9+7tYPatRZR7aMoj6ZIjn5n/qHmonfJFKvWpNgVQyTBOJ4eUiKFM4D9UY
	vwlSk+z0yR9trbnyuyUjovnhTh4AucEqqhALNKl0lebK3qvfbG/4UU5iZbYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737048242; x=1737134642; bh=E9p+OVAAjiOrmwWFV8XeztMQ0uTJMxLowst
	8PDT9kUg=; b=P29hNy/4u0lI3BmCjks9cXMP2oT/dqjO1JjejLw9lw5RaPfXlIC
	MwTZexBM/WzAiJP0xqY/KLfmG85CGk3ZDPKe8wrlIYvtj5LZ/msDjFx7sScYYmUc
	h0G55iNN53ApcFvFHEufN90/FwYgKnMdjrB6zjMCZjxOQz02HXm9A22HqFkZd/lA
	zaILSkcPlto1GqOrtzweYRoFtzMJwuLLacS8mUWnIi15B40DcBEKNsf7Rivjx5k/
	5X361Q3arJHAlqziSBkYWUtFw+kDdfdM/5FtzH7gYd32ofEnQxEzsWEP7MwaePC8
	+53/2duv1cgzu85Em2TuDrBcZ/PlWCfMAEg==
X-ME-Sender: <xms:skCJZ1INZsvnWiEvTgL0bnG0eDVZdzlJmvP9kaD9YcF8QJAf2OsryQ>
    <xme:skCJZxJ0-fVA54hQWVu8BPHAE1onLzZlSJpD9eDl_RZTUnBfbkTZGPDB_HA4osy4m
    CIa63vxD00vCuo24w>
X-ME-Received: <xmr:skCJZ9vvdm1mMOF7oE0SiVqGM0qU_wItbVLTUqubKLgaTUcpnl-X0EoJHAR__riTfakXI5uG1p3U03aEDX-P2L75VoC0HMWKvScS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:skCJZ2ZO6sN7H75J5hkOm0U-bbCd2qkdzaSl7Ucs0azddpXXQHY7mQ>
    <xmx:skCJZ8bJfuOAXL4jq-ajdMxD-TN5nm58rMCptmtnHF4tN_uhPrOagg>
    <xmx:skCJZ6Bpsv2b_TFpmM59ERNIJJhLC11ByZgPrjdvdDUrwW50_F89dg>
    <xmx:skCJZ6ZK-uHpup0drZAYMiUvyY0OzaT4vGkqkfM_Gq_39GCsCzTRMw>
    <xmx:skCJZ0FjYg1biIa7uGFFU9mUsA5jULDEx9_BL_hCE-pYvKJUOrdyeHDl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 12:24:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] oddballs: send usage() help text to standard output
In-Reply-To: <20250116104219.GC773990@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jan 2025 05:42:19 -0500")
References: <20250116012524.1557441-1-gitster@pobox.com>
	<20250116012524.1557441-6-gitster@pobox.com>
	<20250116104219.GC773990@coredump.intra.peff.net>
Date: Thu, 16 Jan 2025 09:24:01 -0800
Message-ID: <xmqq7c6uu0y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> ....  Some
>> just do not treat "-h" any specially, and let it take the same error
>> code paths as a parameter error.
> ...
>> +	show_usage_and_exit_if_asked(argc, argv, var_usage);
>>  	if (argc != 2)
>>  		usage(var_usage);
>
> Hmm, what's going on in this one? It does not check "-h" at all.

Yes, this is the one that let the usual error code paths to treat it
as a mere parameter error.
