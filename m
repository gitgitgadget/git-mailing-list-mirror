Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403262E0408
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993095; cv=none; b=lI9WvcfZRLDd32nou3SCeKSa4NguvRO8A8Bd0XkPNYzZ3P0HoOQAMzFZFYU7uCwSSjQWm/mHRM7B2MGU0mUMfqK0mQqSOsvsE/Y/KL6MPTXGXtmm7OiuIpS9AkMGtCaweH+niDi01j1khVebARtCW2kqKcumO/c/jsTuRUYHa4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993095; c=relaxed/simple;
	bh=i4jZMd9pikjhhvcsqu5cpF2WSeDd1dBs1fp1EVs3HN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dqK/L28ZQqFVW8zd2ehdTNilG9B/P0vHLblRTvZ7pdPBD+JZeqZeCz9w3+J9r3U01Gxm3wg9IlFUlgK1efKsHHEEXaR3YC44O7bPf7aJPhEakHFDb/fhGd4JgtPUSbgoKQciY6Z/bVRgXSvd4Ukgnnx91qwf1p+e3t/NBJCdjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R1rFulVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5MR+MYd; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R1rFulVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5MR+MYd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1AA4B7A0174;
	Mon, 20 Oct 2025 16:44:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 20 Oct 2025 16:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760993091; x=1761079491; bh=LhjUXmIqyf
	/1MqDStxuQtVVKz+fqgAwK5dkMZk8CeTc=; b=R1rFulVR437Iysp+PUrVFp1Mbn
	JzXJ3sTUxPynctS8/rFGP3ESu8S4fqXam0CT/brbMFvVY/w2jWn45xUS7Qbl9xj8
	1He9T/rjRJbowC2rFvspPGrowwSDmTbssiub9X7v4BwCFjbILy08SZ1anKfzbW4q
	L5fIir033oFCBR7t6aBhWmbOF6z8+J+jlph3ndcEWHwcJplRNa7rZ1rLcEwbHeM7
	45Hd0qBMglk+dPa9NnAjz343byADATkH4F1Sx1dUATe0S+x+WYakq+7qQNyyMggX
	oUkM/g+bjKOsHDYSd7rF56VsUAs240ejjUzMWvQ8CoFlx2mAv1zHdKzVtPZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760993091; x=1761079491; bh=LhjUXmIqyf/1MqDStxuQtVVKz+fqgAwK5dk
	MZk8CeTc=; b=f5MR+MYdyNUmDgmW7OvVt20YoKgigHnIfM8bsYWQRa17t3dN795
	feVpkLOY+mAndES/mCni1v21GGJQOJjYVllog7j96p33kCQH4snCC6ar5InqPMc6
	zHQ2hqmbBFm5P7F+w0LqvmzGXQxLeYNy4M3elpQQN2sT94fPiLpSf6DiteNv4EUB
	4XX7/ST+qfHJ4XRsU0h89XDeKGgmEGeoRnVQd1O652E2JxKAL9anucOM1fR1oTeR
	JINW8C+vylJKPML7V++LtuPlJFIsNh9uZOnOZVbKcaEhVXKKrQJRdz65/5GHmlfr
	TYLBgeggJ2zQDfThki14QlIYGJnwoNDGTwQ==
X-ME-Sender: <xms:Q5_2aM_jIViONuWjWhKnonkP_1qqdNF5pssTINhSolZQ-6Y1LC73QA>
    <xme:Q5_2aLu5HOGPX1ZPQs3qZgHQecbOlIh2bnZMYPR1tBxSRCMYyhy6VL9NP42lXtq24
    afnl8ENOd563dnP99DwXygkbgGzTHtrpWcoyg75aIOIA33bdngPJTE>
X-ME-Received: <xmr:Q5_2aHAkZ3gcKlXlQUHfio8dJH19RmkI_KsysdAN5zNEJGkQaURmvVK5OR8bckUjZDucKU0HVtfboRP0WKhZ0mCnPFDYkIrIa8Kh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:Q5_2aLUxB3_mH1im9GFhWKP8VH258BB0Jhnut2ViDKxdXUokZxmisw>
    <xmx:Q5_2aND91QITZ1isy6NrRxpnXHJbfWYBWw7Sd5qMqqqrAiLiib6kfQ>
    <xmx:Q5_2aG8_fCFQ7vBX5DWP0aVupGYWE2BmVHk8IohKMjHgI6EOjvVG4w>
    <xmx:Q5_2aMHPIyfFCXjNMQKBLTZVXbd01ZPqmCUInGNIKNrSxzEFSFyYNw>
    <xmx:Q5_2aKg2SuMXMGDADJLVJCM_YKQLK5IHXhHzo2uZ9hmREYeaSQfxT81p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 16:44:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/4] doc: git-reset: clarify `git reset [mode]`
In-Reply-To: <a6d94c76-c9fe-4688-8eea-3bbab2b5dc07@app.fastmail.com> (Julia
	Evans's message of "Mon, 20 Oct 2025 16:23:44 -0400")
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
	<597ea0f5ce24967974358e18603265b14322ba54.1760731558.git.gitgitgadget@gmail.com>
	<xmqqy0p8x12c.fsf@gitster.g>
	<a6d94c76-c9fe-4688-8eea-3bbab2b5dc07@app.fastmail.com>
Date: Mon, 20 Oct 2025 13:44:50 -0700
Message-ID: <xmqqcy6hz4jh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> On Sat, Oct 18, 2025, at 12:53 AM, Junio C Hamano wrote:
>> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> +`--soft`::
>>> +	Leaves your working directory unchanged. The index is left unchanged,
>>
>> Why not "leave your working tree files and the index unchanged"?
>
> The reason I say "working directory" instead of "working tree" is that
> I've seen a few comments from users saying that they don't know
> what "working tree" means. I'm still not sure what the reason for
> calling it a "working tree" is.

"working tree" refers to the directory that is the top level of a
checkout; I'd view (current) "working directory" can be anything
$(pwd), that may be outside control of any git repository, and that
is why I tend to avoid the latter when I want to be more precise
(and "worktree" is another thing---used to refer to one particular
"working tree" among other working trees attached to the same
repository).

But that distinction was not the part I wanted to comment on.  The
question was about two sentences talking about two things
separately.  IOW

	Leave your working directory and the index unchanged.

is what I would have expected, and I was wondering why they are
treated separately.  After all, the index is part of your working
tree state.

> The reason for keeping them separate sentences is just for symmetry with
> the other commands, and also because (like I mentioned in the commit
> message) "leaving X and Y unchanged" makes it sound like leaving X and
> Y unchanged is a "neutral operation", while actually leaving the index
> unchanged while updating HEAD is actually a fairly weird thing to do.

Sorry, but I do not understand this comment.

The index and the HEAD are two different things, and it is natural
that they can move independently.  After all we update the former
without updating the latter all the time (it is called "git add").

Besides, the two things the --soft does not touch are the files in
the working tree and the index.  The index has what you want to make
the next commit out of, and the working tree has the state that may
come after that state in the index.  Keeping both of them intact
when moving HEAD around is one natural thing to do when you want to
squash the previous N commits after "git add <paths>" by doing "git
reset --soft HEAD~N && git commit".  Contrasting to that, "--mixed"
would leave the files in the working tree intact, while matching the
index to the HEAD you are moving to, essentially undoing your "git
add"s before you decided to reset.  That's another natural thing to
do when you decide to keep the clean slate and rebuild your index from
scratch to prepare for a commit that comes on top of the commit you
are moving to.

So, no, I do not understand the above comment.

> Do you mean `git reset` and `git cherry-pick`, or are there other operations
> that can leave the operation in an unmerged state?

There are many commands that leaves the index unmerged, like "am
-3", "rebase", "switch -m", "stash pop", etc.

