Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C613C354AEA
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760740336; cv=none; b=W+ODsN/LUYimGFy1hzpFWeCoOArHN015EA2L4nxR33fdFywXFviAh8JT/rMKSTG3UJWbuNK5nbwqktdc4OWlB9JmMatTiMzuYtDbseVhtuwyWJVyL0AE/JoJ2MIkYw9f9apnQ5T2dnMbDlPDio3rD3CWEk29J2QyHsSHHPGcwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760740336; c=relaxed/simple;
	bh=0MMqB4nCV87fMHmBTfNmcwXbXszKghLOAAVYOE5fo3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTjlif0Cwwg8OaxrYmIFIuGGx+Zk2rM0ndC1MHj5k+6WX/ESJfg9jFn45gS9EYmG0cbBtFiVT/ul2bjOvvv9doPYc1/g7U5Fkaf+aUr0LuKKpDi11n3IDqdxAhegStLD3CJ4VbccTIg7csxs3e46cQO+qLywZcheUq+jg99hGdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hT5rpe6p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EoH8v/Bz; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hT5rpe6p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EoH8v/Bz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D2CD81D00117;
	Fri, 17 Oct 2025 18:32:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 17 Oct 2025 18:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760740332; x=1760826732; bh=S7S1qojOEn
	/MIU8jDtlaCQqmFDDWu8AmKI/QBBKH2G4=; b=hT5rpe6p7AFXigWJC+d66XGN+B
	K3W+J2MUwdHHUVYn8ckQeWCn66Zb+S9nBANLDxyr5jiwWjtwgktAsTGTE4omicwr
	rDKCLw0HCwK1pWXa1ygBP2XVxob3SCKygBI6VbUrLd/0T4vZRZO56OzJNnvNG7qn
	OuIlLmbWxaWJg/A9OWwO6NYCiVmk58qUPXQQiK67bZtMNgfRy2AF3VtBD3QaKRAm
	zvhILNqD73eMHXTr1YNTe9Ud6TEpfNWldovys+Q4t+/ZCdIQgjhnt6bc2dv6UOVp
	ycu3hsQYlj1u5AVFvCcwIxWB856z7FBrIMiGuet7IRP3mLK4ACtLQhq3zs9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760740332; x=1760826732; bh=S7S1qojOEn/MIU8jDtlaCQqmFDDWu8AmKI/
	QBBKH2G4=; b=EoH8v/Bz6z6VO7JXjuhDpPvuoHnx2S4zbJ/FO7RszxDJUn2SiPm
	KC1gRo5Kz7lbP8zBG2kz3kZ9XtGgYXPKrMBx/zTLBQyadQYI5iPfrMrUjgjbgqQw
	KpNu/G2czO1/6JQIHq4p/52u8MfRF4gT5GDy3pbH/JceeYzazIoJbsyPvVyTReX4
	LvNDVhEjqItn+1Fizz+Qzi75J8+gWqdZRspVfxWJw8kzfJ9a+ywnXWdqSczPDYaE
	Ns5wRnF6Ob9UaNl8vBXmyTYO/PvMMoElyofLnLU//boXKpTi0AOUBwF0q4lbgUCC
	JmxIbOfpSdBmcJfgPD0QacyP/4hV77QY5Hw==
X-ME-Sender: <xms:7MPyaIROWEoRy817gZVNwzg0UE0msKq4Xbxfu7-oZXETfohGheVtbA>
    <xme:7MPyaMzGAjvYLaD99No4XuMqarpmfJQ4AtJCXxRuAPymRr8QsP4svJndNhc9t5VhR
    g0zu8bI4bbcE7CelGdE9NAHEc2bXgD3hO1LF6D7G2m_aDEBGtf7v3A>
X-ME-Received: <xmr:7MPyaK36wzgOhSBKnuylgmCIEWW_9u_WkuEuGvtaOj2EpAGhA9Dxv-5LD_zNK3-3vvO4TxjUkDP748_qU62X5NeyxSsOx6ENnpA1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtfeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7MPyaK43RTXOMiHfpdGJBftTw8dlkQCcBPubJn1OPe_MJBLGShxHVw>
    <xmx:7MPyaNU-KMQNR8GI9U_WrrVthaJKjmcUgvE4p8Q50isJwfSPpQYnsA>
    <xmx:7MPyaJBsiJ50c4pWHzIa8zbRGmgmz2cKKaS5S4NgTDWtL14LPQ4WQw>
    <xmx:7MPyaM6sSo6p0QnsOxYZMSoyoltg5iEs5gd9TaVWVoYYh2oAnyyO_w>
    <xmx:7MPyaCVbXdESvK5CBi_cnIqclb7YjvjFax4tTrNWPZBlXVG-BZWApnbu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 18:32:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 2/4] doc: git-reset: clarify intro
In-Reply-To: <6b5459b7ab478de33d17f9518906396f8a01e0d6.1760731558.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 17 Oct 2025 20:05:56
	+0000")
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
	<6b5459b7ab478de33d17f9518906396f8a01e0d6.1760731558.git.gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 15:32:11 -0700
Message-ID: <xmqqecr1xiqc.fsf@gitster.g>
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
> From user feedback, there were several points of confusion:
>
> - What "tree-ish", "entries", "working tree", "HEAD", and "index" mean
>   ("I have no clue what the index is", "I've been using git for 20 years
>   and still don't know what a tree-ish is"). Avoid using these terms
>   where it makes sense.
> - What "optionally modifying index and working tree to match" means
>   ("to match what?" "optionally based on what?")
>   Remove this from the intro, we can say it later when giving more
>   details.
> - One user suggested that "The <tree-ish>/<commit> defaults to HEAD
>   in all forms." should be repeated later on, since it's easy to miss.
>   Instead say that HEAD is the default in each case later.
>
> Another issue is that `git reset` consistently describes the action
> it does as "Reset ...", commands should not use their name to describe
> themselves, and that the word "mode" is used to mean several different
> things on this page.
>
> Address these by being more clear about two use cases for `git reset`
> ("to undo operations" and "to update staged files"), and explaining what
> the conditions are for each case instead of forcing the user to figure
> out the pattern is in first form vs the other 3 forms.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-reset.adoc | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
> index 9843682e81..876187dc83 100644
> --- a/Documentation/git-reset.adoc
> +++ b/Documentation/git-reset.adoc
> @@ -3,7 +3,7 @@ git-reset(1)
>  
>  NAME
>  ----
> -git-reset - Reset current HEAD to the specified state
> +git-reset - Set HEAD to point at the specified commit

The command has dual-purpose, and it is a bit disturbing that the
other one is not even mentioned in the original or in the updated
text.  "The other three forms" is about resetting the index without
moving HEAD at all.  Would this work better, I wonder?

    Reset HEAD or index back to a known state

> +`git reset [<mode>] <commit>` changes which commit HEAD points to.
> +This makes it possible to undo various Git operations, for example
> +commit, merge, rebase, and pull.

Good.  These are prime examples of when resetting to a known state
is useful.

> +However, when you specify files or directories or pass `--patch`,
> +`git reset` will instead update the staged version of the specified
> +files without updating HEAD.

I see no however here.

Other forms are not about flipping HEAD to any state we used to have
before.  Instead, they are about populating index entries from the
state taken from an arbitrary tree-ish.

You can view them as enhanced variants of "git reset --mixed HEAD"
(read it as "unstage all changes").  They are enhanced in the sense
that unlike "git reset --mixed HEAD", the treeish the index entries
are taken from does not have to be HEAD, and also in the sense that
unlike "git reset --mixed HEAD", you can limit the index entries to
be affected to a subset of paths.  I am not sure it would make it
easier to understand to explain them in terms of "reset --mixed HEAD"
but I am reasonably sure that it would appear confusing until a
reader realizes that the command has two very disinct mode, one that
is primarily about HEAD, the other that is primarily about index.

>  `git reset [<mode>] [<commit>]`::
>  	This form resets the current branch head to _<commit>_ and
