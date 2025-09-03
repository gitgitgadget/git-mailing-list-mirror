Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A082EA743
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756933760; cv=none; b=bE6u0jDetj6764G+lrSf8B3UNXUPpModKKe6GLT9FyVN8VHmJqhZYtfOqLGvvo3ozomVLhSPVwLH9q8lH8JBxoObf7pz5JjIZePNiLPIBlXIwz8onVHRVT2SeOm9By4eu+sfyaqSp7IInfss6dkw2AWbqpFn98vxAlLkwhHSGmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756933760; c=relaxed/simple;
	bh=yTw9cPxVKjJrVeU375bGHPf08jjU4Z14FJ9Z7uHDZIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q39iReikRdy0L7ywIphwrE753d5zl4xARUh7w0Ng6+STIOjjYMsNTZNQQ84fV7VvzGQ9j4HJiE6vOK18VC3ObxEKgDkS22T91gvV54H8+8q+vz1k8G556K875qL+1ZTSwma8feSZHrU1pVwyEi8jVg+205OXL2oPxfdgtQaPVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DyBwMXIm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RC/+vzOe; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DyBwMXIm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RC/+vzOe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07CDF1400500;
	Wed,  3 Sep 2025 17:09:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 17:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756933757; x=1757020157; bh=yhYMAseift
	D0Xpe/VA2lDDLMQM5xUFQbEwEM6YIiiXY=; b=DyBwMXImwoi99IbINp6yVlR2wE
	60vzmzmRGnOP/WCoFKZRZSNL/lJDZ2zIDBDWcY7g9syU9UJY9tfPcbwS78mQiGBE
	TiwAyMzn0F8VLFC+iN6Cln6VVKx1tBY00DVKyyvvl9Ruy7NuINXP/o+K7E631ev1
	lDfR4lwMLzVD9XJbYkdawfb5LWDPjHhMg/ClWd5trHmDjrbc+gZKjgopuUt0I5JD
	8tsdJf/DbpOno8MMng7et697a0F3oti4xmFpS0pd5CFdbqXXKuFdm+2kKW03BdfU
	rnzWAWsSIvwv2WMRkx1J94OexlKHCYCsjx3/va71A8AJhis4An1E3I8sRrGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756933757; x=1757020157; bh=yhYMAseiftD0Xpe/VA2lDDLMQM5xUFQbEwE
	M6YIiiXY=; b=RC/+vzOeBqNA+wK4uqfLYFkSFhf4E/JtgA2uIR0AnlSY07DYvaF
	r52k9BSQsB5dx8cKkrnl+H29NWwo1r807hsQBTsBzjUvwYa5KsKf3fWWOtWMq2QE
	LyliSJUrj34f+lqtBoItGohQjVEvT6P/BQFl4CNoJIW5d7wjj7YwimBXqBLQN2Ab
	rsc5PAKaKHLvqiP6znfCQWlJJA0CqBT4ndAWuN+qZvLeV4pni2xxTVodUh5KP0os
	OnZEhOeTSxSNEpo5Y7uKqThzSz3wHkEvl8hYZflAu2fNisNkFV5XNHWes94isrtM
	HP8QI2juKKC8iVgIsHZUN5s+MZUPN6SjxPA==
X-ME-Sender: <xms:fK64aLAFgM0NUROW2XuIMQZQzJFrTglNb_4BRsvGhc8bkhEDGJMaHg>
    <xme:fK64aNAe8QVzgxndrUEMF6Q73eLA7ZlB_yo-9klIz3YLGxGS8fIkNNEvU2JFVADbm
    fKTdeZDe3T50yyG_g>
X-ME-Received: <xmr:fK64aNAounZiR1inRAx43EXVH5GTzNqXjw7iwv67qxTWzHHyx90t0agIGMyxVOoT9582tiZ_kwpyMXril0tpRVdtn0QmZuq64J6Sq7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegs
    vghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvh
    hnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fK64aIr9wwInj32LSMkjBPRZNqBQIgeiS5CD8hLkIzhVhz9fzNMnrw>
    <xmx:fK64aHlJca4PdrKyDEdxH0NshcfOJY_WXzbUQjSIy-cP5rEewHG_Jw>
    <xmx:fK64aIxGBA4F6zhwKa0KjpZ8PFIHF4C2xwJLVLw-3qnfSOnIzupGIg>
    <xmx:fK64aP8StTcZubyLUsOIAatjiI7ORGy8UlxkLU_NpiObk-HDYJRbDA>
    <xmx:fa64aIDPGEhDoxc5cbJRGvRXQprM3p03GYqHzvjtmc69Eb_L1uV-03Vm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 17:09:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 0/6] doc: git-checkout: clarify DESCRIPTION section
In-Reply-To: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Wed, 03 Sep 2025 16:49:56 +0000")
References: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 14:09:15 -0700
Message-ID: <xmqqikhzdz0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * Improve the storytelling in the commit messages
>  * Take a different approach to the git checkout -b description (keep reset
>    in -B, but simplify the description of -B a lot)
>  * Make the description of git checkout [<branch>] more accurate.
>  * Try a different approach to git checkout file.txt ("Discard any unstaged
>    changes...")

Not just you repeat having bulleted list in your proposed log
messages (which I already said something about, remember?), now you
have them in your cover letter, too?  You must be so fond of
bulletted list X-<.

>      @@ Documentation/git-checkout.adoc: $ git log -g -2 HEAD
>       -to checkout these paths out of the index.
>       +When you run `git checkout <something>`, Git tries to guess whether
>       +`<something>` is intended to be a branch, a commit, or a set of file(s),
>      -+and then switches branches, switches commits, or restores the files.
>      ++and then either switches to that branch or commit or restores the
>      ++specified files.

Much better.

>      ++	Switch to _<branch>_. This sets the current branch to _<branch>_ and
>      ++	updates the files in your working directory. Files which are
>      ++	identical in _<branch>_ and your current commit are left unchanged
>      ++	so that you can keep your uncommitted changes to those files.

Here "left unchanged" is technically correct, but somehow it gives
me a (n incorrect) connotation that they are not modified since
HEAD, which is not what you wanted to say at all.  I recall that we
once explained this not as "left unchanged", but as "changes follow
you", and I found the explanation easier to absorb.

I cannot come up with a good way to remove duplicates in the
following desciption, but what we want the reader to understand are
twofold:

 * For paths that are not identical between HEAD and the _<branch>_
   you are switching to, you MUST NOT have a local change.  After
   you switch to _<branch>_, these paths in the working tree match
   that of the _<branch_>.  This is to avoid losing your local
   changes.

 * For paths that are identical between HEAD and the _<branch>_ you
   are switching to, you may have local modifications, and they
   follow you to the switched-to _<branch>_.

>      ++`git checkout -b <new-branch> [<start-point>]`::
>      ++
>      ++	Create a new branch named _<new-branch>_, start it at _<start-point>_
>      ++	(defaults to the current commit), and check out the new branch.
>      ++	You can use the `--track` or `--no-track` options to set the branch's
>      ++	upstream tracking information.
>        +
>      ++This fails without making any changes if there's an error checking out
>      ++_<new-branch>_, for example if checking out the `<start-point>`
>      ++commit would overwrite your uncommitted changes.

OK.  Do people understand "making a(ny) changes" refers to creation
of the new branch, I have to wonder, but if so, the above is much
much nicer than the original text.

    This fails without doing anything and without creating a new
    branch, if checking out the <start-point> has to overwrite your
    uncommitted changes.

might be slightly better?  I dunno.
