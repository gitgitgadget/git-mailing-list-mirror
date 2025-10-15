Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E32E3218A6
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530480; cv=none; b=Hr2xUq9AlwTQVRUYXOhyxijm/MU2BhFH+rGBTeY9m8OTHt6j/mwvHU3gEanpYIrZYGu+TMN/j7K1um+8GRZ1/rafoJT1JvDF8IO9NyKwyGR5TuMv8OeVHk5+n/Y474BTFHfXpV9AUET8vPDrfz42VHJrjyAFLVL1HKXzt50TQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530480; c=relaxed/simple;
	bh=QQkcOrcAz0fjMhdjbxpE5EF5B4Q5lPdtjqxN1HgLVuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjdxJN1Kvs/yC51xgjSRObB586HYEav50xuro5jzBjWMFPvaU9VSCaC0TWMvjRc+YGw9/jNarJRO/JBQxjZJcoR1sGPJcDmpzqwv/rubNyYz4MqssCbHb870SfYANJwqEj6pIs+uQcU8DKDgU1UoyTBvs3EEPaHjKsB3jJPNqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y2OBkY6p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=toBIkGZ7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y2OBkY6p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="toBIkGZ7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA4BE7A0159;
	Wed, 15 Oct 2025 08:14:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 15 Oct 2025 08:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760530476; x=1760616876; bh=7BLZ528vnH
	ToLMJJtXFCt9qJYpfcpShPNQQYmhaNEr8=; b=Y2OBkY6p4agDfFTZbzlzeS47t6
	IUEIHTMMNtbG0KXv9LeelVm2JOJZvTmRdgm8PMUQRVSeDiG78MuxH8xAZ23aTdd5
	kQjwutQTfwOGBpd3UlGAIF3i90eI1gNIa52N5s1R7nNDrMbw5dsiIcdUUZmLpBzm
	eINyfhIsmrqntoQ0Z+OrYnR8LmiNGiGgq1PxDgyNhw2xltMVbnMvkyDJJGycyUBR
	IeFh9kKxXjUTar5tBaSVL39GTvMOzeOe+W+JR8VbNA3AnfXy2FDbcj1o5Z/zmFXC
	Kfp2I+e5os2rBPIEnkn5WCjxqqp2zyNOjOMh2zcTRztLMhXFQaVceTWr5IWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760530476; x=1760616876; bh=7BLZ528vnHToLMJJtXFCt9qJYpfcpShPNQQ
	YmhaNEr8=; b=toBIkGZ7ZWWbIj/VTJlNZppoNa0esbqVex3dR/gfoXsUX1TbwPN
	4ycUZOyHGQNxz62xYylHLKGmj8CoBKY1upRBSt2Gu3SCeBeIqPmKt1hv/IWJZzfU
	hd8fcB0H8mYIY/TfT34ZjM98u2RM7CNYqlnvahDX833g57udbA0Pc6Q1yQfAslFa
	YC1Vryswh/3Ds5ami0VeysQvTSmnn8fP1vEN81cGdTY6Bv0j00tbSG9WqBC/S/wf
	Mj4iejyLiwisMrbLYeiXutQlPnJbkZhgfj9w+gy4wFoFhSw4vPZzfwhKYJW5mSwv
	C2X5TeqA+BobhA7DffokHx6t6/aepWKqEIw==
X-ME-Sender: <xms:LJDvaC5kzKTLSpQD3ENjrmSTcZ-Zv4es8tIc2-XArzo5dgCarKp5jw>
    <xme:LJDvaDXzQb0FfTne9PQFUf3ZdYQU_Y2zMC8sVw2LxVWYj8-Ah5E5oDbxIZTWGYE9s
    _XX843tCn9ZqbNd1fUP5lo5o2cFMJl-hwe3_ZyiJnFYZxQVHovbNA>
X-ME-Received: <xmr:LJDvaO0z8DR9bI2q4j1DwjOj9dFCz-tv1wAeL5OImOl-l-8fdHMv9GRihLMfQv1U90UpdnwkdHv7uWNMphnu4MjPTViu1OjpDqZSm2qz58ZL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeffeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:LJDvaI2NM6ZcO-iKKeMWldUl6yD3DEWqmYoDhICims8Ye1TKO8qjAw>
    <xmx:LJDvaJ9ufUOsLiQuqEhBviIF5ivTj-eWwCq2KQl5xO3HAvkW7Xfu9g>
    <xmx:LJDvaN108FS_Fc_8N0VBnERrBKOPgQtfKDZ5TGt-CEKZqsm_OtiTuw>
    <xmx:LJDvaO9Z7wJphM0Vax2ddmOpSbha599wBdQumxG1y6OyOzOgCXEdSw>
    <xmx:LJDvaLXR1rvgAXOm4OchgQ6nubZIuTipjqDxyIT081AOdjaxNBIZZfEo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 08:14:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90ebde9c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 15 Oct 2025 12:14:33 +0000 (UTC)
Date: Wed, 15 Oct 2025 14:14:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
Message-ID: <aO-QIn7KAVlBmfRq@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
 <aOjsjpE1vuFUXXbh@pks.im>
 <xmqqwm4y538p.fsf@gitster.g>
 <xmqqh5w250lw.fsf@gitster.g>
 <CAOLa=ZTRG=x5PofmSSfHhJ3Lig2NjhU8buVWAXU=aKom2PDsDg@mail.gmail.com>
 <xmqqldldxtoc.fsf@gitster.g>
 <CAOLa=ZQj20e_p99dzWjmrQ2i-RnLjsnEN9ihuDirV4iPN0QqPg@mail.gmail.com>
 <CAOLa=ZRdxm787nE4FSr2VUHDB+hW06Ggc6yUcKmeTKAb6B7YOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRdxm787nE4FSr2VUHDB+hW06Ggc6yUcKmeTKAb6B7YOA@mail.gmail.com>

On Wed, Oct 15, 2025 at 02:29:35AM -0700, Karthik Nayak wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Karthik Nayak <karthik.188@gmail.com> writes:
> >>
> >>> Junio C Hamano <gitster@pobox.com> writes:
> >>>
> >>>> Junio C Hamano <gitster@pobox.com> writes:
> >>>>
> >>>>> Perhaps "--check-" followed by a word specific to what we are trying
> >>>>> to achieve (e.g., if we are trying to see if auto-compaction is
> >>>>> necessary, "--check-for-auto" "check for auto compaction")?  I
> >>>>> dunno.
> >>>>
> >>>> After reading what you did in the previou step, I am reasonably sure
> >>>> "required" is a wrong word to use, with or without other words like
> >>>> "check".  Semantically it is similar to the should_pack_refs() check
> >>>> that we use for pack-refs even before "optimize" came.  We expect it
> >>>> to answer this question cheaply: are we better off if we repacked,
> >>>> or can we go on without repacking for now?  It is not about "are we
> >>>> performing so poorly that we MUST optimize now?"
> >>>
> >>> I agree '--required' isn't the best name, and like we discussed
> >>> '--dry-run' wouldn't be either since that would imply that the work is
> >>> being done but not persisted.
> >>>
> >>> I was leaning towards '--check', which is simple. But It might be nicer
> >>> to be verbose here and simply add something like '--is-worthwhile'.
> >>>
> >>> Being verbose here is okay, since it will only be used sparingly and
> >>> specifically by those who require such a use case.
> >>
> >> Nah, "worthwhile" is relative and it would be less meaningful
> >> without expressing for what goal we are judging how it is worthwhile
> >> to do.
> >>
> >
> > I see what you mean.
> >
> >> Choosing a phrase around "check" is better, I would think.
> >
> > How about simply `--check`. Since the flag can be used with other
> > existing flags, it would make more sense to do
> >
> >   git refs optimize --all --auto --check
> >   git refs optimize --check
> >   git refs optimize --all --check
> >
> > I will send in a new version around this and we can discuss further on
> > top of that!
> 
> After speaking to Patrick today about this and his work on 'git
> maintenance', we realized we can actually broaden the scope. We could
> implement something like 'git maintenance needed'. This would check on a
> whole if repository maintenance is needed for refs and objects.

Yup. The idea here is that git-maintenance(1) is already split up into
different tasks, one of which is the "pack-refs" task. And each of these
tasks already has a callback to verify whether or not we need to execute
the task.

So if we build on top of that mechanism we can easily broaden the scope
of this patch series to:

  - Check whether maintenance is needed for any of the enabled tasks.

  - Check whether maintenance is needed for a single task.

  - Check whether maintenance is needed given a specific maintenance
    strategy.

Another benefit is that it's a bit easier to put a verb into a proper
subcommand of git-maintenance(1) instead of having to add a verb-ish
flag to git-pack-refs(1). `git maintenance is-needed` feels way more
natural to me at least compared to `git refs optimize --check`.

Thanks!

Patrick
