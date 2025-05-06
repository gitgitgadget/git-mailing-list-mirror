Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62AD1388
	for <git@vger.kernel.org>; Tue,  6 May 2025 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564225; cv=none; b=jsWqkEkwowmS0RkW6X1l/WARuhjcImLjngP3kEQ+Esdb2mWFvHiI3MHJWwy/uafT0Wa6QSWuNtqVjCtk2Rvd8ylWOMXFoW6+wsJ2P56Qko7dvFc2F94kIAF6fGFIgbQ/4PQIfyPeVwpvbTMOngnBkkb/TuHxCwTqk/ZmxtWrzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564225; c=relaxed/simple;
	bh=tBCKY4sEAhjvMQFiAuCYagdeYE7lHSSCg2UOIrPrqPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pqIQCCSAXA55k+c5ebG+iwWfj0Wp7BsS0/6R1kSY3SoNIpEkTtyYI3UipjU1iIluzHMlXynF7eXAxz0rO5ACMt9batYSuflt8lEP9wtxU1WBSvOIvc2NRiA1PcCyF1QoyHVEtCog2Ht1wmoLCH8QunzBVPpEsUGU6ondjaMMrr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=prUl8qL1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hgQrCmle; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="prUl8qL1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hgQrCmle"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0665E2540095;
	Tue,  6 May 2025 16:43:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 16:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746564220; x=1746650620; bh=8+skiTgZAx
	zUed4DarDhscFEDhfounXxezumORZRDGs=; b=prUl8qL1IYXeVmWoKIo+xAvxrt
	G/NW1Fi/DRWcdjcHfbfmPju5O4ewMWXRSjzotPRiCZH0kmMifYlvHsMRj2CE+Fpm
	dqtus3RkFHO/9CAmruJu6jMAP92Kvm9IljyYZkzkS79r/Hwy2h/Iez1g+fHSsXSD
	mMtrt+RRQ0223iMAoUfdlpymqjkx1SCoPqWNGmZo7rsOa3374zMY4xpWo1hOwsvy
	pMI/To0ps24Mo8PH5lctWS2lM2wy/lXX4294O4KhZOz8tQ1rQBX39twfqcFfRERE
	otVcQcHaG/9fid4PaFc+FPSb95Ubp7JFzCHbYQJ3eR2YaE+dp749/86KQi5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746564220; x=1746650620; bh=8+skiTgZAxzUed4DarDhscFEDhfounXxezu
	mORZRDGs=; b=hgQrCmleSCOeXNrWXz/uvY/Y9pI4augPfDi75LAFxTf0Igx7+JX
	ujisRSdlCnFqeg+ZLeF0HTGwODESRplE/KZvd//CeHGEbbrCQf9sWc/0GH9uUqOQ
	AD5n5RtQrMm0PhaMnLzEoGeZw9wrJdiN4IVloGtP91JT/VDwCVmAyJaNsmvBvbcb
	lC0Zc0aRf3y/WPKhw5/Xpxdf9vv23Rqs9IdtJND5Sc19drZ97pd8Z3EgHyL/2tSe
	KwWb2gbA9T7b68kYkLt/CPUXFhK9O/Y6+iIxUi9kusvGUm6few1S9h+rU57WFCdf
	H0gi1GyCKwEXjLqgdyfnXeFZdizoGR2YYCQ==
X-ME-Sender: <xms:fHQaaKCf4A8yZ-O3t74iQ26fK8-NyZs5TtcDY2os0AUU-JT75N1-3A>
    <xme:fHQaaEjTg8EJiCNW47wWBONh8YYXlvqsaOwxUUX0__Clnsx78TCAiYW7_62v83GOT
    xwdJ5DZHImHQS4hcA>
X-ME-Received: <xmr:fHQaaNn9swJhlYe_3J8z7otXmHWV7Efv25TbRQDulramcKtF_JsV3CNZtbEG-KhsJUEUeWP6BiLNSRy4dlVOX1NdC6Ga_viTonPC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fHQaaIx3o1MFMQr33vwirTAegLhVc-CdVtmhlpJMj2I6faedLwQ1GA>
    <xmx:fHQaaPRyVVOutkhDQja-_bpNt89zZ0gw_4X5LsJ6g--twhl5-ELmxg>
    <xmx:fHQaaDbGf1L9UKqVJjeXlofk5rfPnpHmX7YTqk98nB3cZ3zZfQdUmA>
    <xmx:fHQaaIR64ewxIgSxugMOBn2XyM8q7nqIvfUne31gcunPo42gT1-rvw>
    <xmx:fHQaaEAHXD5xEhRRtkkbXbBVCgm1QWWqxuxRRm9B-_SdC_F6mYCl61jZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 16:43:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] Spring cleanup of "contrib/"
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
	(Patrick Steinhardt's message of "Tue, 06 May 2025 16:12:33 +0200")
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
Date: Tue, 06 May 2025 13:43:39 -0700
Message-ID: <xmqqmsbph3lw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I have used the following reasons for removal:
>
>   - The tool is clearly broken, e.g. it doesn't even compile.
>
>   - The tool hasn't received any updates for at least the last 5 years.
>
>   - The tool has a clear alternative or just isn't useful anymore.

I've expressed my opinions on many of the individual patches, but
not all of them.  For some, it may be better done at 3.0 boundary
with the BreakingChanges transition like everybody else, and some
others with clear "new home", we can remove them much earlier and
independent from 3.0 plan.  Some others with no "new home" may be
in the gray area, but my gut feeling is that many of them do not
need a careful BreakingChanges transition as some others do.

> With this model, "contrib/" would be closer to Linux' staging drivers
> with the expectation that a tool should eventually be part of proper Git
> in case it proves to be useful, or booted out when it doesn't seem to be
> getting there.

OK.

> Another subsequent step would be to split out some parts of "contrib/"
> to be hosted in their own hierarchy. CMake, Coccinelle, Unicode updates,
> VScode and the like are all tools that are used during development, so
> they should probably not be part of "contrib/" but rather of a new
> "tools/" hierarchy (we can bikeshed the name at a later point, I'm not
> yet doing that in this series).

Yeah, I think we had a discussion like this, and I do not remember
the new names proposed for things that are out of core but still
part of our tree, but "tools" sounds like a good place.

> There's also other bits and pieces that serve as examples. I think we
> should move these into our documentation instead of having those in
> "contrib/".

Sounds sensible.

Thanks for getting the ball rolling.
