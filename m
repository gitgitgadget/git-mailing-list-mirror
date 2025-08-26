Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7FB2820C6
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248211; cv=none; b=M/uvtaNeF0l0YjmvwLnU8NJY/JwzqAbkrx2YVdKVXpsJntEMkaqV+uiqTOHl1eyE/G/pz6PKdg3iR2A68CnTl/3mpETmHlClQ/Iq5mmFpwCQ7X/GfR1fshZrThG2GKgDFg4JKLabidtFb/0b8uoQuYakl4/lgZEZF2FWrkZAWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248211; c=relaxed/simple;
	bh=QwZyilrAjglS1NN3qbNXZPcLr9baejYH1qbMT2Whzfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jiMCuxy2MzH7wkdt0UxN4T6/bwEFKY8yOiKkuZEsvf4uHE8cVw4OJdP2fTVA8vWxjWog3bUg4oxyZ8NrA14Beln8FuDxvWkMbRBSa6NdK8mJikEVcUn/xHyrptYsGdc9fvxpvv66J4HVie3xClHzobd0JqGvXBzxMfqXM2bXdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aC4t8/b1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AXsA51rj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aC4t8/b1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AXsA51rj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D25CDEC010B;
	Tue, 26 Aug 2025 18:43:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 26 Aug 2025 18:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756248207; x=1756334607; bh=yHG4H0Fc8S
	mBsYp40XkXqREdvNeuvNJgXv7DcezK044=; b=aC4t8/b169rTqJ0hU1oeLiJ5uD
	uI3gVPErI1IXzomnjim5GsRpos8roy1KNkVYi5Pl9oxj1pednbe39FMNgkFEkUOr
	Fe+yUHK2C85ZgZdwHwev4FOwvcy1tIFKwyrfL16MjoNz9ppXBDO7ournYbbDcW/s
	CYJkcu64gAXjKDhFINt0OxrFuCky/HMMQdo/s/uVY76Fim/xM2OSyp3cEjX4j/B6
	MJwUhqLW3TohUUjNCXHdBSaMVinSpnnY22W44uft8xnTDj3YRvxllq+pB73AIlk/
	6WfIZxPxMxF7zA1XxbnlXQF4v5TvN4Na6pfk5zoxYDGymfYW83u1A0zLQAmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756248207; x=1756334607; bh=yHG4H0Fc8SmBsYp40XkXqREdvNeuvNJgXv7
	DcezK044=; b=AXsA51rj5tojzUf0h9NqIjKOIAonMg2bQxWCfQgqIW8rE8IJxMR
	nM31NRIeall2aleY4SB8CQlSgbxNdPXADX4NFuKhQYZF6S5wNLj062YoqIeyhcgK
	dEOc2S+ADKAcxiJAfH991DM3ZlUs/iRhlS1Tcx3gVwCmgSrKSszNCRE7i1YMJstQ
	qsCuBiDH1rVOMPM+KONiyhwf8ESCotvbSQdarJBmw5KmRgpvRwbveRm/2Wp8Ua3R
	KuqcY3JDjZY/cKgQ+XnGlxcYTuAfgAViM+/h3mgYL7zqZ4ypIeRRyDidLBdDiv43
	WyIHNOJzHCUxUm6fXWiicdrf/No/xAopTDw==
X-ME-Sender: <xms:jziuaFjucOoPNd1rr5CcHAzbjigZfJVJyyZL_q9-dlpJO3tujH1B-Q>
    <xme:jziuaEmZQr_Wn54Zrx4O84s2wJOzOCyM5j9_mDeMcC4vXCKvW2-6WfeZShq4sNz_k
    xw-IQXtLhOKnU1KVg>
X-ME-Received: <xmr:jziuaBrofrvjZRYXZJcp3a-5d4lw2dKy8de6BES_BDvVIPq7Hor3sW6INfqVFDBsgSLxtxSJVupyTQFCKiMUbALZODJGPyAtBMsuLho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:jziuaNFkyQryzFs5ZKpQAixlA6gmRESNDlx4drAwwzKAdtdK-ljDBg>
    <xmx:jziuaNwAlgXdqRiWMTgP3z0t_g1EFMCilwtluVY8TYIKZ-GEEwS5NQ>
    <xmx:jziuaCoZX0DkIMSFayrRSG1AotDJldnjmTZvRd3lk-6JnHWxPhQZLA>
    <xmx:jziuaHhZ_pJ6F75NAoqCDJV98Dhi_I1MSoKrir5eDOc0i8QEsdgIAQ>
    <xmx:jziuaGR6Hf6qRw_vTy8poYVNGRVkTr1qyhUlRGXlskb6H_egYZf2Pc8G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 18:43:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 5/5] doc: git-checkout: clarify restoring files section
In-Reply-To: <b641874627b3898831c3965616e936bd4ee310df.1756148933.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Mon, 25 Aug 2025 19:08:53
	+0000")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<b641874627b3898831c3965616e936bd4ee310df.1756148933.git.gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 15:43:25 -0700
Message-ID: <xmqqiki9hfg2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index b343d292b30b..9f2b86ac5368 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -82,20 +82,21 @@ Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
>  `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...`::
>  `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
>  
> -	Overwrite the contents of the files that match the pathspec.
> -	When the _<tree-ish>_ (most often a commit) is not given,
> -	overwrite working tree with the contents in the index.
> -	When the _<tree-ish>_ is given, overwrite both the index and
> -	the working tree with the contents at the _<tree-ish>_.
> +	Restore another version of the file(s) that match the pathspec.

The same comment about "files and directories from a different
version" applies here.

Also, I am not so sure about the claim that the verb "restore" is
better understood than "overwrite" due to the presence of "git
restore".  If you are working on, say, an older maintenance track,
and want to borrow what is in a few files from the development
branch, you may say "git restore --source=develop files..." go grab
them down to your current working tree.  But at least to me,
"restore" has a connotation to get back what you used to have, but
the contents in these files you are grabbing had not existed on the
older maintenance track you are working on, ever, and "restore" had
always made me go "Huh?".

I am not suggesting to change the command name "restore"; I am
suggesting the operation that command does using a verb that is
different from "restore" (in an ancient thread, we tried to explain
"checkout" without using "checkout" as the primary verb to describe
what it does, it is the same thing).

>  +
> -The index may contain unmerged entries because of a previous failed merge.
> -By default, if you try to check out such an entry from the index, the
> -checkout operation will fail and nothing will be checked out.
> -Using `-f` will ignore these unmerged entries.  The contents from a

> +If you specify a commit or tree to restore from (for example `git
> +checkout main file.txt`), this will restore the version of the file(s)
> +from that commit or tree. This overwrites the file in the working
> +directory and stages the file's contents.

OK.  I suspect the most common is to "restore" from HEAD, and the
"Huh?"ness of using the verb "restore" goes away.  It clearly is
getting you back to where you were back when your working tree was
in sync with HEAD.  Perhaps use "git checkout HEAD file.txt" for the
example?

> +If you do not specify where to restore from (for example `git checkout
> +file.txt`), this will replace the file(s) with the version from the index.

That is a very negative way to state it.  It is not "do not specify
where".  If you do not give tree, you are actively specifying that
you want things from the index.

> +If you check out a file with an unresolved merge
> +conflict, the checkout operation will fail and no changes will be made.

This is confusing in a way different from the original.  During a
conflicted merge, you will see a few stages until they are resolved.

 (1) The working tree file has conflict markers and text from
     multiple variants.  The index has higher-stage cache entry for
     such a path.

 (2) The user edits the working tree file to resolve the conflicts.
     Once all the conflict markers are removed, some people may say
     "the merge conflict has been resolved".  To Git, the path is
     still unmerged.

 (3) The user tells the index what the resolution is, with commands
     like "git add", "git rm", and the like.  The higher-stage cache
     entries in the index for the path are moved and replaced with a
     single stage-0 entry.  To Git, the path is now merged.

So, "a file with an unresolved merge conflict" would not mean what
you wanted to say for those who consider that dealing with the
working tree files is enough to declare victory and consider the
conflict has been resolved.

> +Using `-f` will ignore the merge conflict.  The contents from a

This changes the meaning to most people from what the original
meant.  If you have a file F with merge conflicts in the earlier
part but the later part merged cleanly, does "git checkout -f F"
ignore the conflicted part and overwrite the rest of the file
somehow?

If you wanted to avoid the term "unmerged cache entries", you can
say "unmerged paths".

Taking all of the above into consideration, perhaps...

    When you are in the middle of a conflicted merge (or
    cherry-pick, "stash pop", etc.) and haven't told Git what the
    resolution for these conflicted paths are with "git add" and
    friends, using "git checkout" to check out such an unmerged path
    out of the index would fail and the command exits with non-zero
    exit status.

    When the `-f` option is given, these unmerged paths are left
    untouched, instead of triggering an error.  For all other
    (i.e. merged) paths that match the <pathspec>, the working tree
    files are overwritten by the version recorded in the index.

or something along that line, but with a readability enhancement
like you have been doing in your series ;-).
