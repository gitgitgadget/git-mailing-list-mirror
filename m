Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447335948
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464008; cv=none; b=k3MvokX8DS/bwsnaf/fgTn7ir44+hbXleJ38x1MTPItEuFQDkghVE1UoDHBVUb7OJWxpnUv+ZAxBTgD6y7kn2hPB1VVybqgn0VFv4IbLC3m6t7ePip/x0vO7FNgRjAUVhpzYSy5ufn7kCAkE7cVvzeVSd+EvwxzOTIUApn3X9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464008; c=relaxed/simple;
	bh=h0dsT7vE3bvd1EkDgyTeLShcBnLEV/MUZflDCXH4xos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qwkT1vsqyxlJtvghTHOQgkPrI4lP1TEZ/Ikx3guQMGgiKIji+Jna1sU/6Qo20QFnVOqGMKSOkNkbNvJ6BCXJ55bzA8PZnSGPYDh67Qpy6VyDKCph9RJmYH6pDefJoNZ/N9kUax6MkPynGqgVKn7bCKfQ3UDSCUAptTGesnq9Ctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=blOo0sOF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vfFFvZtf; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="blOo0sOF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vfFFvZtf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D6477A00D1;
	Tue, 14 Oct 2025 13:46:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 14 Oct 2025 13:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760464005; x=1760550405; bh=NsFE93OCeY
	mW/PFx95Oj8npalL7rHACdk7SZZNJEiLY=; b=blOo0sOFdh8YwyWFmM9ty/Aa8p
	v7hUrPugn4gCqdnMkRd7qSF52Px+q7NOKI6iPPTknM9zW2j+nBr3pZ6XOAODfazK
	2pq64Py24sD3Nis+ik4NiSD7Y9F41HdcqTyh9E07xV0H8je4jZ1NXAm/6WmqLCSv
	V9OUTfFvbM9iYVGePo6ETFFTuEbBcIsI59Uc6Soy2rocV8C5Nu1r8rSH09x2A6D6
	26rJ9+dv5xsdkjvk/0g8Sfl09h8F/e9BeyHfrINJhi+M5g6d+3BA3BXoIaWL2P2b
	jQXePd59VIFaf7fV68qcczTD5gBUGhPOFAPaQRw7CJNu1dAiHzcgDwW5qOjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760464005; x=1760550405; bh=NsFE93OCeYmW/PFx95Oj8npalL7rHACdk7S
	ZZNJEiLY=; b=vfFFvZtfsknxff6jv7NNCMXxkCTfpEqNlmiAxlngSTO3wDVdlMj
	COPf/2r1h0naMkNE22Z3kdRswnpeanOfgIDKu0XKr+wCuS7ZqgX4cHuFRlggw5NB
	MKTzcRyeQBrzNXoy8ZlsX9DWEw7ml09aWg7gWU7kwfqYqEGlShvLGQDlOQxiz46J
	aep2HIes0OeUqnnZVB3kZx2f/VPriS+6QL0qkkl60KRZ5nYoy2BO4zkyhUVX1LU4
	Ubq1LqPFPZWCWYY4w6rJk6Ulu238E80lWixwGWn40LVThkslUipIYYE5rICCOIC4
	ErmTimWM1Sg9Abk982hjSJghoZo7BwupmlQ==
X-ME-Sender: <xms:hIzuaMso-LO00QTnPJWFHLyWa_ar4KZKUIFOfk_AjsHZ6t3oB-6teQ>
    <xme:hIzuaEDOXaicExPKwW4uZOQSnDemzw_cpaLJZCv6ORj0HqZRbINdnGHuM0kG_5hEi
    lzAe9VwwV8Lk75aeIE0Ugai8qgH71cLsR8Ohy9vuCM4x2oLjjoFuQ>
X-ME-Received: <xmr:hIzuaEVfXnO0APB1jGlqxa8sZF6qIFXsT3Ox_l4H1kBxowjO0tzSCzhX1BKJbecywJB65hA9IB4GHSkkqKIQvTWZfJ__ErMCasWZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdduudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hIzuaCDEoz-4RyYgR5XMImi_Xco2QSD0IZpPLhLsMpPgffYZkB-B1A>
    <xmx:hIzuaH-PBRdtcvdPP4ln1TnBhVU0vhWjE55fuozsaxln07WYb1nEpg>
    <xmx:hIzuaJFGSb-3YrxY_EKPADpqXQdqJW0z4pmbjp7bFX1XK3vAYt5duA>
    <xmx:hIzuaFM4ci5SofPnPE_T9JubfTYe8pF23jojDq-V2PRYrg2B8CVlhg>
    <xmx:hYzuaE91PhOmS3ZqGqMeWnoLAUCWa0Yln7vBH6rI-XddWDjQ3dQ_Wpqj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 13:46:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
In-Reply-To: <CAOLa=ZTRG=x5PofmSSfHhJ3Lig2NjhU8buVWAXU=aKom2PDsDg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 14 Oct 2025 11:08:56 -0400")
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
	<20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
	<aOjsjpE1vuFUXXbh@pks.im> <xmqqwm4y538p.fsf@gitster.g>
	<xmqqh5w250lw.fsf@gitster.g>
	<CAOLa=ZTRG=x5PofmSSfHhJ3Lig2NjhU8buVWAXU=aKom2PDsDg@mail.gmail.com>
Date: Tue, 14 Oct 2025 10:46:43 -0700
Message-ID: <xmqqldldxtoc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Perhaps "--check-" followed by a word specific to what we are trying
>>> to achieve (e.g., if we are trying to see if auto-compaction is
>>> necessary, "--check-for-auto" "check for auto compaction")?  I
>>> dunno.
>>
>> After reading what you did in the previou step, I am reasonably sure
>> "required" is a wrong word to use, with or without other words like
>> "check".  Semantically it is similar to the should_pack_refs() check
>> that we use for pack-refs even before "optimize" came.  We expect it
>> to answer this question cheaply: are we better off if we repacked,
>> or can we go on without repacking for now?  It is not about "are we
>> performing so poorly that we MUST optimize now?"
>
> I agree '--required' isn't the best name, and like we discussed
> '--dry-run' wouldn't be either since that would imply that the work is
> being done but not persisted.
>
> I was leaning towards '--check', which is simple. But It might be nicer
> to be verbose here and simply add something like '--is-worthwhile'.
>
> Being verbose here is okay, since it will only be used sparingly and
> specifically by those who require such a use case.

Nah, "worthwhile" is relative and it would be less meaningful
without expressing for what goal we are judging how it is worthwhile
to do.

Choosing a phrase around "check" is better, I would think.


