Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C3F363093
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631247; cv=none; b=Bv8hmqhT7k/4ioP964QpzI95CSybwCl2JfZBNDYAu1wmJp4RwlkIOD4x9j/GTqTtK7Y0s0ILZXxYCXCU9wDa5xHA/lz1jZLEYVwat69diHuA+racoEMVzrp9U/5zb6b92HENtFnNkadURqbMNNnmRQLbtyR2U7SHPJ/c434xF3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631247; c=relaxed/simple;
	bh=V7mbtPhvJb2RQOgvVKsY2E6yglpvMkbMBJE9x7d7evo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K7zBw6TaEWgV9CJkY5vtAWmIlhHf0V87mH/+Hs4D4xN8ZE5kpqPTaz9jiCSKofbOCrKinq6rYSCMX6JMbGXB/vweW6GwCn5beT8dOYPZmDGSK5uF4YdSdOsgUjNpaPmMdvbR1pAChiq0VpsiHxNRRjxXFOIAC/nbej7BxlxkvTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S1Sb0wpO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V3mCIWMR; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S1Sb0wpO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V3mCIWMR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A48E1D0024B;
	Fri, 27 Mar 2026 13:07:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 27 Mar 2026 13:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774631244; x=1774717644; bh=EOtXRp+P43
	gowwxWl0saNH0SqvefFHsPopJqMkbwx1Y=; b=S1Sb0wpOr42TUE+xE5+ts6UiLR
	ylkxbEx/PwfteL5+ylxhTpTPBaOipJi/ecDwPRJHF7IYWIpwRaVVyvBBHJOc2ByR
	en/QCOKnaP7ZTxq0hSdxONZxkVCoWS3+88EYBiP6f/9CpFPBFz5Wwk0Dco2U4/th
	38+XtaeAG5Xi8UpzPkD1w3+SDlP1wAtjYz9t6VwBJZunj3wiUihv/4R/BjZucOSn
	9K455cOUQReJ+GGzJCaJYp0WTKRH5S/N9KmT/I+2e39yjJEO5dnSAwxsGExTKRjm
	yErS6U9T8aOy3sL784APf9INch+2w3ziGpL3td0RNKxkVxUxZC76YZU54Crg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774631244; x=1774717644; bh=EOtXRp+P43gowwxWl0saNH0SqvefFHsPopJ
	qMkbwx1Y=; b=V3mCIWMR/6xysjrVRLQn61rpg7jk7s7cwj+gxEqgiUS7oFdzbfN
	IYDw6n0n9Khv1OI34Gq7uY8RKiuvN/Nn5H4tQShHFZru8qP/lIndS/YsMc7zGTiC
	qRxSk5DezzWFoSW//7uFqHraDEm0CTfG6xB+CsHfsTkJyE14WKaB2GCUP6s/Mwx1
	PagCfeFYvMLuRnk6d8nnoTdfiDOKIObYy3BHnKjK/NdeNuWTJfh8Y+2AqkroiT3B
	++LmUR2puj7TBGmIL8jjz406yAsFGT+ezgke8WhAGKL/duXfKV4F+Os6kJmPDPAr
	vJO1Sl1j0+cjBGhXEVd04kE58qthvfBmp4w==
X-ME-Sender: <xms:TLnGaVL30GZD-Jc2L94ymeoioJVH0lPhcxicX7tFA85QcO7qgXNAKg>
    <xme:TLnGaYDg8bvTmVI31RpRBjPKtmaWf5yrGuLWOqUYxl_hZHhSebWiRrrdnl8EatVo5
    8oC_DF1-EEx-rOwZx9Uez3J7stgWMwWW8WypevysAuYUExtilOmYw>
X-ME-Received: <xmr:TLnGaWApwu7js2UBlH0mEybMiK5C6CInSuaWagTTTnHXpgs50JZN3pikMd3nVoqARGJHOjNOc_w8xVL3f37qVoDgK8D-lcx3BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshh
    hinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TLnGaSAI-QOY9Xe4layZd-0Fmt33SwAMA0MBJnFD6FC5XIVhyyaNzw>
    <xmx:TLnGaZry6uD6XEcmDqmNn4W9AUjLT_6NYygNpSFvLXqUjrGYEqDhMg>
    <xmx:TLnGaUkB9A9FFtW4qEfajlrK0xF_cet1KLQgkgfQtlEY25FzXASHGg>
    <xmx:TLnGaRxqkdflzUCkMDhi6cMh105WzQ1ILnaqP_xiFvj0X2Fms_QFAA>
    <xmx:TLnGabSWSEu7W9zYaFjE1vihLyXYL3AVbB1lnf2LtyVpBTk7YSXPjH2V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 13:07:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/3] worktree: remove "the_repository" from
 is_current_worktree()
In-Reply-To: <317ed4f7-f88d-4415-bd25-b62b4a076728@gmail.com> (Phillip Wood's
	message of "Fri, 27 Mar 2026 16:40:15 +0000")
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
	<cover.1774534617.git.phillip.wood@dunelm.org.uk>
	<5357c0dd53ee123a4ea064412c83983b0be5e400.1774534617.git.phillip.wood@dunelm.org.uk>
	<xmqqy0jer3qu.fsf@gitster.g>
	<317ed4f7-f88d-4415-bd25-b62b4a076728@gmail.com>
Date: Fri, 27 Mar 2026 10:07:22 -0700
Message-ID: <xmqq1ph5kxpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 26/03/2026 15:48, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> ... it calls get_workree_git_dir() which also depends on
>>> "the_repository". This means that even if "wt->path" matches
>>> "wt->repo->worktree" is_current_worktree(wt) will return false when
>>> "wt->repo" is not "the_repository". Consequently die_if_checked_out()
>>> will fail to skip such a worktree when checking if a branch is already
>>> checked out and may die errounously. Fix this by using the worktree's
>>> repository instance instead of "the_repository" when comparing gitdirs.
>> 
>> It sounds like the above is something we can write in a test to make
>> sure the code with this fix won't regress in the future.  Can we add
>> one?
>
> We'd need to create a struct worktree instance with a repository 
> instance that is not "the_repository" - I'm not sure we can do that in a 
> script.

Ah, so this is more of "futureproofing" than "fix"?  That is fine.
Thanks for clarifying.

>>> -	wt->is_current = is_current_worktree(wt);
>>> +	wt->is_current = true;
>>>   	add_head_info(wt);
>>>   
>>>   	free(gitdir);
>> 
>> I think I found the semantics of get_worktree_from_repository()
>> unclear when we discussed a different patch series, so I may have
>> asked the same question already, but what exactly does it mean to
>> "get worktree from repository", i.e., this function does?  A
>> repository can have one or more worktrees attached to it (that was
>> the whole point of introducing the worktree mechanism), so "I have
>> this repository, give me the worktree for it" is not a sensible
>> request.
>
> A repository can have more that one worktree but a "struct repository" 
> instance has "gitdir" and "worktree" members that point to a specific 
> worktree within that repository. For example
>
> 	repo_get_oid(repo, "HEAD", &oid);
>
> reads "HEAD" from a specific worktree within the repository.

And...?

I _think_ what I am frustrated about is the lack of description on
"what it means to be the worktree among many that is pointed by via
the .worktree member in the repository struct".  Does it correspond to
the worktree being "the current worktree the codepath is working on?"

>> The function's comment in <worktree.h> talks only at the
>> implementation level "construct a worktree struct from repo->gitdir
>> and repo->worktree" as if it is so obvious what the resulting
>> worktree struct means at a higher layer's point of view, which does
>> not help, either.
>
> That comes from me thinking of a struct repository as referring to a 
> specific worktree - would calling it 
> "get_worktree_from_repository_instance" be clearer?

It does not change the descriptive value of the name in any
meaningful way, so let's not do that.  If the answer to my "what
frustrates me" comment above is "yeah, we are getting the current
worktree", then renaming the function to include "current" in its
name would add descriptive value vastly, though.

> I feel I'm struggling to explain this clearly - I find this whole 
> discussion gets confusing because we have "struct worktree" and also a 
> "worktree" member of "struct repository" which means a "struct 
> repository" instance is tied to a specific worktree within the 
> repository. If "struct repository" only had a "commondir" member and no 
> "gitdir" or "worktree" members and we instead used "sturct worktree" to 
> refer to a specific worktree within a repository with functions like
>
> 	worktree_get_oid(wt, "HEAD", &oid);
>
> instead of
>
> 	repo_get_oid(repo, "HEAD", &oid);
>
> it might be clearer but that would be a very big change.

In short, am I hearing the worktree subsystem is not conceptually
clean and it would be a huge undertaking to clean it up?
