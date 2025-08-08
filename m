Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0752874E9
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670609; cv=none; b=l8J0C4aO5asIZ2fbgaorjzbcsRxyQEv+inENkFNIEfY4FywpqqT9fwlv8rZS7nvKtiG1FLM+JNeORKmyJfCGeu+LJrHWAhMRgo+lcczDamiWLjTASwUt+uExAiRvUsNeq/fURYHQMWE+jEWRIiY9B2Y2Nc4u748z/yDCreDjX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670609; c=relaxed/simple;
	bh=v1NTgEORvvmDbdNS2q9WoaqqVKFk2ogrFJzUYoaU/X0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W9urCDoAI+TUhVH2L8YBVVv41JN6sNHyiFFrjAbiIvYZgyPEsX+2LQmxQjSN2Zrv//PtWaRufSUVWlZsmL6ks1WCVIsVLhYAIyVTrUd2/S80n5OTzqltWfI8qaLVhb/JPX15xxdKoN8fVBNh8zMUEaSxLmqtZPZgYYtpSj3MpQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TDe8/Jox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+ubQv8F; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TDe8/Jox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+ubQv8F"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C793C7A0306;
	Fri,  8 Aug 2025 12:30:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 08 Aug 2025 12:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754670606; x=1754757006; bh=V+Yax5cd8m
	44SUdQfztzg/ZmFEZ1MPqvdM/+HiauMPk=; b=TDe8/Joxr/xrkSFm6+LDitEtsU
	1/5ytQqqz77e7fwphb+KuVdrbgtufuefUnXCuHX3lhM80Q76l9IDTlu3hHgHa3aX
	16jvPd3WT88yge1uY7ocDThk80A9zXRIi5bmlJmK9y1hRn5gHVQ7Nt+Izl74kn09
	/Jiumy2GwUP+oOyCQ2d8IClsMYyoSaG4mOKMgmfYUnmGT4Sh/GWCPHZL0zbODJJ6
	R/ViRRE2M/UWJrtR7lk1suK8M6OVTeMOU5dn5CzTmwUSF5eAQj39eUGfqwyE+yHV
	X4iZElrhVDkImV+qtrTG63tiysSJg3q/ngcgPm0GiWeOGwI2dGWNKphV6DDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754670606; x=1754757006; bh=V+Yax5cd8m44SUdQfztzg/ZmFEZ1MPqvdM/
	+HiauMPk=; b=m+ubQv8F0SKSH3L32vKGHWYTx/4TJBdi/lZ0Nf4StoPWi2k3XJ6
	c7RKw5EHSNYqm/7kqK0WYgeRmwJzoWp9JgQxJ7/x+ZuI+3G2jX9kroVDZLUAZ0oP
	H7TIEcbZrt6JZBSLFlxzUqzODCLjQeUafv2IPZ7ciG/JZsdBOExeCI0oF+8UWUsj
	xDIxuwtekmkqSiTngpFgYqkgLhuUEHn3EK0oLg2enhX9s8TiB167o+xHeC7sH9gE
	h5S1ffvLi3raKbrqg0m01cpAP3NLiR078jOTJlneEG0xiS6JT3gR9F5kcGk2Y8Ak
	cT9nZD3Og1KLqXVsducY9RzbVh6Rbql18uQ==
X-ME-Sender: <xms:DiaWaLQtCuhZldTVYX1i4oSP7yxEuGLfqjm2vcGaoEG_QQTSnO_QEw>
    <xme:DiaWaHU7P5lDsMXvi8DP5VqIAMNtdu85AXxZYJvC5UYjdnJf1_0pZ2_ki-LFjJsqr
    Pnu2FzQOIWYy5Teug>
X-ME-Received: <xmr:DiaWaNZ8Uy5z7zsS4DGXhudpFBCkDFoSYZFdrqWXTHBu06-yP8vDfUORHa04jm4zO_6GcCQEniXHzU5w0gnEON1RIIVPV_fKOpdeZX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegvdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DiaWaN2gPRKR9O_kgc2SE7zTlZzD-eZiZpKtBuOLpe43e2-9et6Vxw>
    <xmx:DiaWaPhZFmO21EFjJI6O9UVw7kAkCljClJ_W9foN_59kQ2uaSlb1jQ>
    <xmx:DiaWaBYy5M0gb79a-ZJZ8-NirvzZC8b0B8fhClkDcqIPxyjk9j9N7A>
    <xmx:DiaWaPT9nQpxOSWdaOcTyPJJprldGyKbrtw8Y8FgLuqZUefFwv3M6Q>
    <xmx:DiaWaCDSeA5a2-mHHrzpJjBL4JoPjpfN_9zXEQewZOL6fyPX3_3d7h58>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 12:30:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/5] doc: git-rebase: start with an example
In-Reply-To: <ac3a91c04bfa5ab2b0e479c0bfeb2ba275fe1d56.1754666665.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 08 Aug 2025 15:24:21
	+0000")
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
	<ac3a91c04bfa5ab2b0e479c0bfeb2ba275fe1d56.1754666665.git.gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 09:30:04 -0700
Message-ID: <xmqq34a1ixo3.fsf@gitster.g>
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
> Start with an example that mirrors the example in the `git-merge` man
> page, to make it easier for folks to understand the difference between a
> rebase and a merge.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-rebase.adoc | 46 +++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 956d3048f5a6..fee73623990d 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -16,6 +16,26 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> +Transplant a series of commits onto a different starting point.

It is an excellent idea to start with what it does, before
explaining how you would drive it.

> +For example, assume the following history exists and the current branch is `topic`:

The line is a bit overly long, and the style a bit on the
"description of dry facts" side, which might want to give
a bit more "motivation" to help readers.

Here is my attempt.

    Imagine that you have been working on the `topic` branch in this
    history, and you'd want to "catch up" to the work done on the
    `master` branch.

      *** Illustration of "before" state ***

    You want to transplant the commits you made on `topic` since it
    diverged from `master` (i.e. A, B, and C), on top of the current
    `master`.  You can do so by running `git rebase master` while the
    `topic` branch is checked out.  `git rebase master topic` works
    as a short-cut to `git checkout topic && git rebase master`.

      *** Illustration of "after" state ***

perhaps?  

Note that you lost the mention of `git rebase master topic` syntax
and the explanation that the form being a shorthand for checkout
followed by rebase, which I do not think appear anywhere else in the
document, so my suggested rewrite above resurrects it.

> +------------
> +          A---B---C topic
> +         /
> +    D---E---F---G master
> +------------
> +
> +Then `git rebase master` will find all of the commits since `topic` diverged
> +from `master` and copy the changes in each of those commits on top of the
> +`master` branch.
> +
> +------------
> +                  A'--B'--C' topic
> +                 /
> +    D---E---F---G master
> +------------
> +
>  If `<branch>` is specified, `git rebase` will perform an automatic
>  `git switch <branch>` before doing anything else.  Otherwise
>  it remains on the current branch.
> @@ -58,32 +78,6 @@ that caused the merge failure with `git rebase --skip`.  To check out the
>  original `<branch>` and remove the `.git/rebase-apply` working files, use
>  the command `git rebase --abort` instead.
>  
> -Assume the following history exists and the current branch is "topic":
> -
> -------------
> -          A---B---C topic
> -         /
> -    D---E---F---G master
> -------------
> -
> -From this point, the result of either of the following commands:
> -
> -
> -    git rebase master
> -    git rebase master topic
> -
> -would be:
> -
> -------------
> -                  A'--B'--C' topic
> -                 /
> -    D---E---F---G master
> -------------
> -
> -*NOTE:* The latter form is just a short-hand of `git checkout topic`
> -followed by `git rebase master`. When rebase exits `topic` will
> -remain the checked-out branch.
> -
>  If the upstream branch already contains a change you have made (e.g.,
>  because you mailed a patch which was applied upstream), then that commit
>  will be skipped and warnings will be issued (if the 'merge' backend is
