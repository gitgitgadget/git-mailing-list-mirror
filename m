Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20619C546
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608093; cv=none; b=imJq5yql7eJPPW33IgnkMkRDRHRAdOuHsGtQpU1vcYBwoWuZysrUdJ/YTDiJ4GlERrt2kSqC+N08imm5OcxhElBNthkZOVP9tYKa4Hu8B7ebnWycwi46QhEoRppnVlk83qrsaj/4dMna7rUyxdLYax3jKbaq7XtTo5j9qBMr50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608093; c=relaxed/simple;
	bh=RTygEb3TMBBEoa9H9re03kW8hTirf70w+kPVd7RiVyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m5jEczlWmxWw4xK+veqcGQgZaT79+INqm4Hh0csHHgGDPZRJubGMiNCFWFuFKjiUMduk/SpQCEACkLZJ/zv1IsqwrZJw4KVDRXdEMIR9dV8jP6/KNbuzZndxCeg90wTd/z9eioruDlSoaA9rrkQ4rI5bdSGWD9wQgSRDiU4xxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AzCfTeXR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M7ptLWql; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AzCfTeXR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M7ptLWql"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 966581400036;
	Fri, 20 Feb 2026 12:21:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 12:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771608091; x=1771694491; bh=D32x+Jucnd
	JosmBVED8QErikWMxVasLVn7lTsj6S5Ec=; b=AzCfTeXRiRRBNbiBT+kier2mUG
	98DTOSJqFsrUj6u2atd4peLAheL6wHteWsB1WLIL7dpdGkIsLo2/CuxM1xVj6HOH
	UsJscahri4RfaDd/WII+R/z0R2zTZ5R61iJxtYl/7/8pG187uuaiCQeApxKpcILq
	7lJgAnYVCIojUOUuXPIsgU4KJgTqi3ETDK/FfwWL87V7END+PRzDngat90jiYG+Z
	zi/gcgg+Ij9zBnl6L/Om1SrqbPZX59yQUy2+w/WWhEMaJh/E8xNBMVMiQUUjPi97
	b+KDMjuqE9Y4pQjPXWrGTFOZaD+KP0RpHHphG/WHSLccrn1rbI+OrVL4HyTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771608091; x=1771694491; bh=D32x+JucndJosmBVED8QErikWMxVasLVn7l
	Tsj6S5Ec=; b=M7ptLWqlXTWpisn1IqdCS2WqZlrAil2qEM+wTNjagN1n9u2pp18
	X8jc/CovwOw2GnJWZk3Le3bsbjcB3J6+dY+Enh6eUrz08G0jbHiigjxvIAh6ZNmg
	lKH4Wd+BQgeRWTMfxcOnS67XF2v5VjjKBBKeCHTPzCP4YoMzgc88p4uA6xjkLZwo
	aBW3Bc0NOwdiHSsl/PMFLeknLHWHPy9Eud16biimRU1PBxhizbE5mHoMON6IhwP+
	gGNvgDPmAR/eVm4RNweVLu5kQJnnrP7ejAl7fASnXjHDcqFyCDcqWEyl5MVG24u4
	N55LihTxaLRVihHGAjRaByf87VQ87/5m21w==
X-ME-Sender: <xms:G5iYaXy4pxkhvNJvXzMb9-Y6XicOTovLfuu3Oxdere-_tR2HJejuNw>
    <xme:G5iYaeXv4cR10QtQyqWZmcrx-Tu-YfmJHvI_ur7-WzjtMYUzsdmDf9eDmEAO7oOn8
    QzUuw98tMTUYwwlWhT4GT6dsV8oicKH0ijxMomLJWun2s7-EzJbXA>
X-ME-Received: <xmr:G5iYaXigYyIxX0W034JC9VSe4tb-cikrysBXgT7jyQS07PxmquBGK3DUNjWBr2bQTn8SxrPnaD7RIhrjn07cn5rlMy6cyH3hqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:G5iYaeBAIJprcbN7NAW9zs3zdhxysCP_ToboRKLRBrDMNmTwsJi4Fg>
    <xmx:G5iYadttw9Dto6t60NMholbWB4QHXTneT5tsFd63Eac2m1Q3vRSJSA>
    <xmx:G5iYaSeGhIhUuSXvQbNopeuzdhmvmyZBWaO4swDfjfKLzjUQq3gGJg>
    <xmx:G5iYaS95qzFfjbaWsB3ozsPIxZ0rtVich0WIcPndi0BRgzazSmiBGw>
    <xmx:G5iYaU1YnSy8IYrANAhMRqdH7Eok-h9b4_nzQsC7XaOnS2vQp9mAaKJ5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 12:21:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/8] hook: add internal state alloc/free callbacks
In-Reply-To: <87ldgny4mm.fsf@collabora.com> (Adrian Ratiu's message of "Fri,
	20 Feb 2026 14:35:29 +0200")
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
	<20260218222352.55393-1-adrian.ratiu@collabora.com>
	<20260218222352.55393-2-adrian.ratiu@collabora.com>
	<xmqq4inc2yom.fsf@gitster.g> <87ldgny4mm.fsf@collabora.com>
Date: Fri, 20 Feb 2026 09:21:29 -0800
Message-ID: <xmqq4inbz5ye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> On Thu, 19 Feb 2026, Junio C Hamano <gitster@pobox.com> wrote:
>> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>>
>>> +	/*
>>> +	 * Ensure cb_data copy and free functions are either provided together,
>>> +	 * or neither one is provided.
>>> +	 */
>>> +	if ((options->feed_pipe_cb_data_alloc && !options->feed_pipe_cb_data_free) ||
>>> +	    (!options->feed_pipe_cb_data_alloc && options->feed_pipe_cb_data_free))
>>> +		BUG("feed_pipe_cb_data_alloc and feed_pipe_cb_data_free must be set together");
>>
>> A way to avoid being repetitious may be to say
>>
>> 	if (!!options->feed_pipe_cb_data_alloc != !!options->feed_pipe_cb_data_free)
>>
>> or
>>
>> 	if (!!options->feed_pipe_cb_data_alloc ^ !!options->feed_pipe_cb_data_free)
>>
>> but it (especially the latter) might be a bit too cute for some
>> people's taste.
>
> Thanks for suggesting this. I was actually thinking of ways to simplify
> this and the double negation didn't occur to me. Will do in v3.

Embarrassed.   You do not need !!; (!A != !B) would suffice.
