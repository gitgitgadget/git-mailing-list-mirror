Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB78F48
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484548; cv=none; b=kI72sZ1/e/Iti9z6C+/UT2ydHN6TBGiwEYM1q3RH4wxPMJLBqNw4EtKXpD0+8vm1Rv3QE50JXW2Iaj+sDmfmNBqqBwGgW3FvyQPgyGAzVPNHq9JegV4LC+QojucU3iohz9i+VqHquh098K2bXGxZwJWJqqBGXtT4Dgk2IWFT3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484548; c=relaxed/simple;
	bh=sSKYPoXPG6BHnpRYDW+A4LMoXnSmf3BjADijdiiP77c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iW20hfl19MAzWxu3RefilWT+3iheUklN5xlesEoHMgMUD6Am3xXyKiwA7aRMr448gP0V2v02Meh6Q4SXtDFbJdy2nj3Dd6wD1YNSDaxzU1rU1XJS0JTsC9HfovzZ1YAqypxw2rJd5rTxyctlY63FOSwePwef/u2E6UBnGajEvIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=z6LAJ35s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BH73qb92; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="z6LAJ35s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BH73qb92"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CF507A0199;
	Fri, 29 Aug 2025 12:22:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 29 Aug 2025 12:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756484545; x=1756570945; bh=V2uV/NdNLL
	ZpJHoZVj8KVp6WKRUUyKOwTzd01zhoRTE=; b=z6LAJ35sEmkQDulciX0gXIom1W
	X9kwN+SdwHdPNwvea+195eHcSN1/u289tZBuWqt8ee5GDC8eW3EiAilPBkQmohZC
	LWFrv399S1S4rAGyPrdrD+FGxfilPHjQID7NSj/qtvAXyiJgH4VjWFSMIDQHGeyH
	AU/vIG+rwvibtmlSKx7devdV7dLNmK2erIJ7y0A+K3Z63jB6tyLfNAUOtBpdQOs9
	R50+eF/ZvWPGiLpC+2T5ZxIucKrTnP8FtMYxYbB8k9yQC93twKYVgw0wdD7zp+ea
	FPdXcHGc96pPTZOhPfi/QlRriDJiPcU0H0UVoshx1zLxGtjRMGIvF4iWu0rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756484545; x=1756570945; bh=V2uV/NdNLLZpJHoZVj8KVp6WKRUUyKOwTzd
	01zhoRTE=; b=BH73qb92c5fYIZjQ5RciTdOCmQ65vFu+pqr893Mh3KUqV81GxoS
	HlRWjw2pAKDo1EMLAqYOHvgsh743QDGmBosRuMdTE94DMQUYbDJmy+o03xKiuFSz
	f46oYlqQA8/YpunItcjWpTEcELoLrybziy6qvVtKrmnTy5H6hHI2BKnMBvNsNUj6
	sftpPoEhM7PwdB+0XJdrBgd050Rg1xgiHfmE5eVaLsF7AFPr7JYDkLOlWY0irSb7
	VqJuhu+V/BcuVUNQVM8Q0hgF8KV+EVua0lqT5vxrzAwvnolMla+MfctQK7cGNjCZ
	GbNU2lPgUXvMPPHDOUqmVaNMe34e2Wezrig==
X-ME-Sender: <xms:wdOxaC9KT1OsIODkXhy7rb9e4AJ0owlXYOr3B388ALzvc_7Q9p0GUw>
    <xme:wdOxaONiz31ztRr0UhT3FiS6Kn2Kd_SaHWNehGqH4ASRXP9kFTgvCsxjQbVdgy3jv
    g07fANJkJLKXztJGw>
X-ME-Received: <xmr:wdOxaOc2Cm10cRE9tAzVQQ4gAIvIJ_OVhSArhJk06qO_1GLqQH9fhQyf89hQClyq91BBsaW5Ug9-32mxSUc6fJ01rDtsLKwV1gGCB3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrse
    hjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wdOxaFWntr5CFCGOqGdka5109XhNnbER1Zxa8BE5lozd9M8VK0ftiw>
    <xmx:wdOxaOj2c0ra_jjqZlnvIh6pVLFPy_aulSmq-wVocNqIcaKa11LZ3Q>
    <xmx:wdOxaM_YTQeiDOgejTDvt1h5eG-J9c7ozTqyKR7K4PwQ4Tq0I-y_dw>
    <xmx:wdOxaIaLNGVmuSXzaX8iWnphQpnQ4RMC_2Rg2NQnhQftB8vosyh8Eg>
    <xmx:wdOxaAuFqu8BdItAu4IbTEbGkxoZpDSNweUONJ5MVb98D3f_Dv5l5nIA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 12:22:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 3/5] doc: git-checkout: don't use "reset"
In-Reply-To: <360051d2a656727ca42d489de81ffec9b23a6386.1756467934.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 29 Aug 2025 11:45:32
	+0000")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<360051d2a656727ca42d489de81ffec9b23a6386.1756467934.git.gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 09:22:23 -0700
Message-ID: <xmqqh5xqnlmo.fsf@gitster.g>
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
> Many Git users don't know what the term "reset" means. Resolve this by:

Even though it is the name of one of the most often used commands?
And yet a separate step in this series made the claim that everybody
knows what "switch" means because it is the name of another command?

I think the source of the problem is not that they "don't know what
the term means" at all.  Isn't the real problem that the use of the
verb in the original sentence you are correcting in this patch is
vague and does not say what the branch is reset *to*?

> - Expanding it into its definition, in one case

    The description says "-B <branch>" resets the branch if it
    exists, but does not say what it resets to.  Rephrase to clarify
    that it is made to point at the specified commit.

or something?

> - Giving a simpler but still accurate explanation ("the branch will not
>   be created or modified"), in the other case

By the way this kind of use of bulleted list in a proposed log
message I do not mind all that much.  What I reacted to was a list
without the introducing text (in the case of this patch, "resolve
this by doing these things:").
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-checkout.adoc | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index 4de3ac6680..e4614674f0 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -54,18 +54,17 @@ to print out the tracking information for the current branch.
>  	`--track` without `-b` implies branch creation; see the
>  	description of `--track` below.
>  +
> -If `-B` is given, _<new-branch>_ is created if it doesn't exist; otherwise, it
> -is reset. This is the transactional equivalent of
> +If `-B` is given, _<new-branch>_ is created if it doesn't exist;
> +otherwise `<new-branch>` is forced to point at the commit. ...

Good.

> ... This is the
> +transactional equivalent of
>  +
>  ------------
>  $ git branch -f <branch> [<start-point>]
>  $ git checkout <branch>
>  ------------
>  +
> -that is to say, the branch is not reset/created unless "git checkout" is
> -successful (e.g., when the branch is in use in another worktree, not
> -just the current branch stays the same, but the branch is not reset to
> -the start-point, either).
> +that is, the branch will not be created or modified unless
> +`git checkout` is successful.
>  
>  `git checkout --detach [<branch>]`::
>  `git checkout [--detach] <commit>`::

This is in response to "transactional equivalent".  I've always felt
that there is no need to say "transactional" in this at all.  IOW, I
wouldn't have minded if we rewrote this more heavily.

When you have to clarify with things like "that is", "what this
means is", etc., after some text, I've often found that the result
becomes crispier and more clear if we removed fuzzy text that needed
such clarification and rewrite the sentence using elements form only
the clarifying text.

    If `-B` is given, _<new-branch>_ is created if it doesn't exist,
    otherwise, it is made to point at the given commit.  And the
    branch is made the current branch.
    +
    Creation of the new branch or reseting of the existing branch to
    point at the commit happens only if the resulting branch can be
    successfully checked out.  Oterwise branch creation is not done
    and the exiting branch is left as-is.

or something?  I dunno.

