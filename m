Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8621B9F5
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711841; cv=none; b=oiAr+wN2vaUXCmSAkG1W9FS1WY4GeVFPS+eTRG0BFuU+FhvFr88P3ndHbXW+S401MFbQMa4zXanueGfJefSaSFQsKTP/nPtCjbF2Re479/TaP6UiSJb0rSOl72NY4S4hF2o8uISz03dHCvPnBlqTvQjHZM1SujhQXwosCubVAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711841; c=relaxed/simple;
	bh=vMQVFBQ+f0UOrVsfgLPwXsz+Oanqzdwn3KGrW0v//10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tRAATABKxn++ptxgUCqURBIn5L0ZtDPThIUJpQxnlUXZJhHZZieCJQ8fCA62naJRno7SRDRVlwyJe97easAiegbM8hDgg35ykiiNnbG4dKc6g5KOJB7IfegaRKF2XWgEoplvhNvdBN8tFPBrcu5B0HdssOE7C3T+uls2QCiNA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FXyyvHmO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1nQNy5R; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FXyyvHmO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1nQNy5R"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 564B6EC0208;
	Fri, 12 Sep 2025 17:17:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 12 Sep 2025 17:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757711838; x=1757798238; bh=bN3gu5S3UO
	rEUS6Qn3ZW734M+ISsFSRL4iNkGEGpIH0=; b=FXyyvHmO7ykWh/GWnK1+48gwr7
	dnI/ed8rGJ3cE/ydXU/7Kz1eAUb/x/LmjUenPpNdHe1VZR823xqDzzy79WOfgw4L
	yQsqHcVS6mzIDcoLTwMsMmbn6mWAfDWqegXS33Dnmctkgco1uYNdQ9yR2WPfTo8z
	rme4KGOfMfB5jE/jlXfgvv3gp65e0pmvLBWNM8scmLaBGqtD7Zf4q1NJ9qxeCN+a
	gEz0CB/6moj8IhAPuGyo2M0ouy6XcCtnpkwOA+KnjCQSILv6XhK6gpZZCdME2EyZ
	PbBpqtEHD0PYq+eN1bABtVoWl5mzs0lqZbWNQczFpf0iFN1kBpnEFBo+88TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757711838; x=1757798238; bh=bN3gu5S3UOrEUS6Qn3ZW734M+ISsFSRL4iN
	kGEGpIH0=; b=F1nQNy5REd/l6dY3UYxtvGV9icHxvSM2F6vn8mr5h4nIvovNVKr
	Dw1A7oTp/OZgplGWevCZIHtYvS3Gbcx1xiCTsgDtSrsgxarXUXKeMzQkvlP0MWGk
	zGj4gcbPDgpxWVJvuyqAFkHMrmba2jD/i1qzXBVef6a5cyW4ti4i0VWuQVIj9dWR
	AfL3w2w9Jm4yhnOvXRveORU7Jy1uLzOMTArxNHS1o6gVu2wPpZ+NR25onMwuNmHe
	iAQRy/T+MYkM78XFoa2Y1j5u9MlUbbgrnazCWjSZav/CqXERXI9bm32uOY5KA/uV
	Zabd2qJ7kUQD3xzMCCz+L08carGu7c55HmQ==
X-ME-Sender: <xms:3o3EaDl-s69jsxMy7ojt4Oy2ZOgluCUHwt10EFTggSWwZH5Gpka1SA>
    <xme:3o3EaPROIya0_zLk6_DOIs6IwptxgiIvEASAFK4IK5KLm3UP8OKJyoE0Bk1_bkuur
    Oss1vL5m-bwLtj3qw>
X-ME-Received: <xmr:3o3EaKFF1Tr67vI8yiGNUJ9GNGXBliOK7aFVCy-Rttn9IzLSz_ChY-9yZh01nKZbuPwiARXCCL3P4cSTSgRUEnmfSGu8U9z1iG1lU2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftdduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhu
    lhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:3o3EaMEaP95gJV7i9iFhUfUDNlWL_TKYLMMlpfGVgSxuL3YxfZlsKA>
    <xmx:3o3EaATpA-rJsTrB0Tj_udFv6Xg7Jl_afW9HCv99ztXakLeck1V3eQ>
    <xmx:3o3EaFJFvHwZpyxOgt3Y721pPNXn-_lfov7GVpCEMdLPVLG2SdgYLg>
    <xmx:3o3EaDY010QocVxTuxh2l8AekOGp9lA54pygA5QfNO0d3lG1cP16Dg>
    <xmx:3o3EaDLKmNyTTeVmp_ZOfdE0y3YHcR_HaeBy_khGHXwoVhNoHJ04D4JP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 17:17:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v2 2/4] doc: add an UPSTREAM BRANCHES section to
 pull/push/fetch
In-Reply-To: <0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 12 Sep 2025 18:55:07
	+0000")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 14:17:16 -0700
Message-ID: <xmqqa52zl6ar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes-upstreams.adoc
> similarity index 63%
> rename from Documentation/urls-remotes.adoc
> rename to Documentation/urls-remotes-upstreams.adoc

I'd personally recommend against making this rename, as we would
likely add more kinds of information later, just like we are adding
one now with this patch, than we would remove any.  For example, we
may find that this is a good place to also touch upon a triangular
workflow, where you would track your upstream by pulling from there,
and then you publish your work to your own remote that others can
pull from (and the expectation is that your upstream would pull from
that publishing repository of yours, which complets the triangle),
instead of leaving it vague in the `git push` description as "See
push.default and git-config for details" in the section we are
adding in this patch.  We will not rename the file again to
Documentation/urls-remotes-upstreams-triangles.adoc when that
happens ;-).

> index 9b10151198..1e9c56dc5f 100644
> --- a/Documentation/urls-remotes.adoc
> +++ b/Documentation/urls-remotes-upstreams.adoc
> @@ -91,6 +91,41 @@ git push uses:
>  	HEAD:refs/heads/<head>
>  ------------
>  
> -
> -
> -
> +UPSTREAM BRANCHES[[UPSTREAM-BRANCHES]]
> +--------------------------------------
> +
> +Branches in Git can optionally have an upstream remote branch.
> +Git defaults to using the upstream branch for remote operations, for example:
> +
> +* It's the default for `git pull` or `git fetch` with no arguments
> +* It's sometimes the default for `git push` with no arguments. See the
> +  `push.default` section of linkgit:git-config[1] for the details.
> +* `git status` and `git branch -v` will show the
> +  relationship between the current branch and the upstream,
> +  for example "Your branch is up to date with origin/main"

Although I would rewrite the second one (i.e. "push") for clarity,
to be more explicit that we are discussing only about centralized
workflow in this description, the above is a good write up.  Here is
my version, including the push one:

    It is the default for `git fetch` (hence `git pull`) and `git
    push` when no arguments are given, and you are using the
    centralized workflow.  To use a triangular workflow, in which
    you fetch/pull from your upstream but you push your work to a
    third repository, `git push` can be configured to push to
    somewhere other than your upstream remote branch.

    Various commands, including `git status`, `git checkout`, and
    `git branch -v`, reminds you how many commits you have on top of
    your upstream, and how many commits they added to your upstream
    since your branch has forked from it.

When we would upgrade this file with a more detailed description of
the triangular workflow, we'd remove the "To use a triangular..."
sentence from above, and leave it to the new section.

> +The upstream is stored in `.git/config`, in the "remote" and "merge"
> +fields. For example, if `main`'s upstream is `origin/main`:
> +
> +```
> +[branch "main"]
> +   remote = origin
> +   merge = refs/heads/main
> +```
> +
> +You can set an upstream branch explicitly with
> +`git push --set-upstream <remote> <branch>` or `git branch --track`,
> +but Git will often automatically set the upstream for you, for example:
> +
> +* When you clone a repository, Git will automatically set the upstream
> +  for the default branch.
> +* If you have the `push.autoSetupRemote` configuration option set,
> +  `git push` will automatically set the upstream the first time you push
> +  a branch.
> +* Checking out a remote-tracking branch with `git checkout <branch>`
> +  will automatically create a local branch with that name and set
> +  the upstream to the remote branch.
> +
> +[NOTE]
> +Upstream branches are sometimes referred to as "tracking information",
> +as in "set the branch's tracking information".

Everything you wrote here looks like a great addition.
Nicely done.
