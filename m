Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142D1FE47B
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234011; cv=none; b=FOWlhPkxjpcBorXmUEGpnEWWHnlciJIa1+eoicrS0vZ00mgwQBYKjrH8jMWJFvSF5qCCz7ILty6dzsDMg4MUknlhc0HtrBf/da27K1ZxHaXtm4kS2lOFdTepNc4eiUg7Yw/1qEkrfjVM+vXeotzMXyoxKUjjEofi62Gw2JJ0nuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234011; c=relaxed/simple;
	bh=DDV0AuZ/2hI++FSRwM/WRBuHDm2W4GIG7SzIZwneZ9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TFgVG3nlcFCXVoNgYP/J6FOxhnadC7jxaRO2nFGl/4EmRzaKyCybz6lfbEvcqiUIRWKnKZp6kcRgef29ofPXTywHYVqCGYnG9/fHJi7hBsppjr2VeG5ljuGnyIcr3blU+xIR8EyQ0JubCXJTrrXPXlf38dsip3p4Fxl0RMdHH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oWfwWNe1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kmem2yOz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oWfwWNe1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kmem2yOz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E75CAEC0311;
	Tue, 26 Aug 2025 14:46:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 26 Aug 2025 14:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756234007; x=1756320407; bh=q37LfjrosB
	cXTIKsblPmiFq2w9Yd9aQi7ZkVAX/uLEo=; b=oWfwWNe1plCyTaC7NqaCSRIP8y
	xjdaI9hD05iO830noVIfBpB1OZ0nUtyhUWyUPuFiFEnpckoeGTdmAgaSMJ19YPy7
	WC3/jcItXrh5whVSlmgs4KyscpnAosIujpeEnfJBGdng3qFBNschzcceHQ1Cb+t8
	a9v5fxRgNI0jv6DBo1RkBMFz5JgdvMZx7cLYW9NcokvdAmaRLb7z3ypBAsrmb5WX
	1YTGhgO17XIev8CsQNbaWhz8+Gg67CUJrrqgbLfZqO6EoVhwDYE4U17oyyV+alWy
	Z7pSujUOgiVjrHEYqWxZwgwcQe9uEU/24kpaIIx53HD0LerVTQg9/6c7W7kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756234007; x=1756320407; bh=q37LfjrosBcXTIKsblPmiFq2w9Yd9aQi7Zk
	VAX/uLEo=; b=Kmem2yOzdoJLp+6WOl1bVH/2ZJfaboIzwvQHW3qDLLQxAXvDduD
	6v94zxjzg0N7RCguP7ZAEvwDBg/GAGze48xD1hw8tI8XJRwsE5T5kfZGjmCTT3IV
	u74Hr8iFg+YVcODFBS65SAqIrJoRMPshxoYQDFEaqaLsZpiWQuAKgxKcYXrZL3IX
	nI/8CylDo1CYRSFl1xivcIFNoNlzqL+FAHNiu2bigVcLn/i1qzvMP3WSyRBE7BJE
	4VM/eDsrjUxbHYp+lpZcqyj2jxv4yGwjwIacKYkA3YgemklZtuGh5ljOzLqTerxT
	YKYJa5c37uLoXzAtz/uR58Ccd8Rz07qWggw==
X-ME-Sender: <xms:FwGuaOb_uK7YteevtQqeIuIqqHR81DnNW1H1mG71Bt2FcZYyI6mpoQ>
    <xme:FwGuaL-mn2SggIdoA-S0ToIg9IqqG1ecC3MUBZ-qto0w_FvWWfQFtbSFne6IpOKiR
    Fl53nPpjcbEJ35cBw>
X-ME-Received: <xmr:FwGuaFin_XqqEDSh0U5b5ceyZnoei4il5VKWWs6gzwnzWaTA380hAq6f0ygVNFIm4oAtQ6VmzebdwG5BMp_6BluDfnLWICNQ3Jg_WVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeitddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:FwGuaDeGuoTLrqeR0tLwImE16QwXfQlckcQ_ATscLtEkiPlYhqkr4w>
    <xmx:FwGuaErdStOYb4hoVWr6n6jHg2qWM3IB7gxODzKRd85tR5vEMHPhAA>
    <xmx:FwGuaADI0-14-pqB6RDa8bdanhCm8WlatjHGjwRRjJkymO_0J9M8Fg>
    <xmx:FwGuaJYOCQQh7fxRbYHQS6z4J5ybMCdqEIkmD07YLrOyyyuuOkPG-g>
    <xmx:FwGuaCJzzoXMEo3fB7zwG4HQJxZ1XExAlgytGUxfNB-wj7ezPoS1NHvk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 14:46:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/5] doc: git-checkout: clarify intro
In-Reply-To: <a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Mon, 25 Aug 2025 19:08:49
	+0000")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 11:46:45 -0700
Message-ID: <xmqqqzwxkjje.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> - Many users do not understand the terms "index" or "pathspec". Clarify
>   in the intro by using an example, so that users can understand the
>   basic idea without learning the full definition of "pathspec".
> - Use the terminology "Switch" and "Restore" to mirror `git switch`
>   and `git restore`
> - Reference (and clarify) the ARGUMENT DISAMBIGUATION section

Avoid bullet points here.  End your sentence with a full stop.

> -Updates files in the working tree to match the version in the index
> -or the specified tree.  If no pathspec was given, `git checkout` will
> -also update `HEAD` to set the specified branch as the current
> -branch.
> +`git checkout` has two main modes:
> +
> +1. **Switch branches**, with `git checkout <branch>`
> +2. **Restore a different version of a file**, for example with `git
> +   checkout <commit> <filename>` or `git checkout <filename>`
> +
> +See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.

As promised in the proposed log message, this conveys the same
information much more clearly.

"A different version of" neatly sidesteps the need to hint we can
check out paths from a tree or the index.  "Restore a different
version of files" (or "files from a different version") perhaps?
The point being you can grab multiple with a single operation, but
they all have to come from a single source.

Other than that, very nicely done.

> +Here's a description of all of the modes:

I am not sure if we want/need this line, though.

>  `git checkout [<branch>]`::
>  	To prepare for working on _<branch>_, switch to it by updating
> @@ -511,14 +515,17 @@ $ git log -g -2 HEAD
>  ARGUMENT DISAMBIGUATION
>  -----------------------
>  
> -When there is only one argument given and it is not `--` (e.g. `git
> -checkout abc`), and when the argument is both a valid _<tree-ish>_
> -(e.g. a branch `abc` exists) and a valid _<pathspec>_ (e.g. a file
> -or a directory whose name is "abc" exists), Git would usually ask
> -you to disambiguate.  Because checking out a branch is so common an
> -operation, however, `git checkout abc` takes "abc" as a _<tree-ish>_
> -in such a situation.  Use `git checkout -- <pathspec>` if you want
> -to checkout these paths out of the index.
> +When you run `git checkout <something>`, Git tries to guess whether
> +`<something>` is intended to be a branch, a commit, or a set of file(s),
> +and then switches branches, switches commits, or restores the files.
> +
> +If there's a conflict, you can use the double dash `--` to distinguish
> +between branches and files:

I do not think you are dealing with a conflict here, rather
ambiguity.  "You can use double-dash `--` to disambiguate between
branches and paths".


> +* `git checkout <branch> --` will force Git to treat the parameter as a
> +  branch name or commit
> +* `git checkout -- <pathspec>` will force Git to treat the parameter as
> +  a set of file(s)

We do not have to teach the full pathspec syntax here, but I wonder
if we should do something to avoid leading a new reader into
thinking they have to list files.  "...as a set of files and/or
directories", perhaps?

