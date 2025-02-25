Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D743166F29
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507250; cv=none; b=FothsnTHQ91S20QiFoZsYo1ltXN64Ijv2CevToM/5XLEAElwajKI9rProKQac0e4Hmki9W4BQNhHCM2TRePToEDbrTN6wNqXyHbIb8NnsGzMzyyTJZR6YjZfuSqi6egg3kr/mJAWdEgj3XGAHCQeSU6ELaKNg+QnDxKWxBgMC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507250; c=relaxed/simple;
	bh=9lNdjIQXiVGpsr5xPzbCWwXZ+w/23dw2yfJ/pFQCCIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prKBgTlEsbwSacINGX4Ua+A/c7wwfVpwc6LJdk06rVrVlx2rqZgPAnbhdkgUySmpmNBEmFjLnEJiXPAnFJy0xgrClmzD/a36/v9ZVgmIcX5MNcmb8Ma/3+UvH662ZtcK29vWuApdwI5MzHsoAZMqT5U8ErTpOoXSpPXKlGiRDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bh5FoudI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BcaUnB7j; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bh5FoudI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BcaUnB7j"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A082313814F7;
	Tue, 25 Feb 2025 13:14:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 25 Feb 2025 13:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740507247; x=1740593647; bh=mVC+K3pQri
	N81r47gsyRIZrFMXCSlvEvuELNwxKCMBE=; b=Bh5FoudIaOAa0Jul3y+WQiDCWg
	FxLBu5NSiIBOO3bjecxenQu4yfEnI26RrtvEHqCeHXcd1bu/nOITdgXxZsGS9wwJ
	pn+swhQ/T0UAd58ZAQpdPzMjApGesD6DiNiSpH7nnFoIxSS1ncSvpl4TV2jhgtce
	JANF+KWGzHyf+8bUfU0TMjAzHqsa1kgl+2ziMt+6eEFEr1yl6u69TEHo/f42lvAt
	4Z8FtLm5hTO2Ka+tjnqcXJgNRVECgfGP477LoUnZEbQWFaCpnzlH8aKFO43AU1CE
	xgapOk5fsish+C8k/ph+BttXu8U8jfvth0YRh93FgOJSTEWtiFiRu5P+zefQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740507247; x=1740593647; bh=mVC+K3pQriN81r47gsyRIZrFMXCSlvEvuEL
	NwxKCMBE=; b=BcaUnB7j4p57dN6EyykNzvufDMkwNBAy9Ix0HhhWLeUnfgLlrky
	YBP0/J5DlJpBMzWaNNNcfuJ7dRwN3U9CuSl5tGTkoopj6qiI2g8hE0pdzLo/gLAU
	pVSQ2ASOLqo4Y9w+/9ABI4o3fpE1xunBtGqytjtsxTyU7LJm34OwUAyP5O8DwwWX
	PG+AoDdUF6CIKvmMUjYZoOtpbrQvjmG5XqiObmNoWMWn3HvlzkucpfjoYQKVLWHe
	9mfOvSLgtMSuVzm48Ag1sXgE0JPgymRqDybza1LIs7dNlwmIobLBHKSL5z5TeaOC
	JwGkjFJDEZ3DIF+1YoTEl5BFjJjaJayaxqA==
X-ME-Sender: <xms:bwi-Z_YVRzk9c2rBGR2MMZcGjJk82jrnT5LeUVi29qQ2jRr82Hy2jA>
    <xme:bwi-Z-Z5vRtRez_qsvOE5lduoz8D-92mrs2iGiYNEqxHNT6Fm9bzRuby6prlhGyVl
    l5MAeBDd5lpEYCF8g>
X-ME-Received: <xmr:bwi-Zx_jmdYzLtbK0IAyf9GPmtrcy4IbZBZklUm00ks4KkKdfQsnyy2S5awFOMl7DG1VbZ0lZAaE35YNlgEAcKq9EX_4_yv8HZ0W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeef
    hfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehstghhrggtohhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bwi-Z1r6Cik04KWsyNIphNQv_RKz6514rMURytzBVoPneqmtw1CRzw>
    <xmx:bwi-Z6o41WnTOHqmhYbFhstwd3-AKo7fZShraJ3iOfibPYkPqLM6Ng>
    <xmx:bwi-Z7R4UMqHVxEcpx6akBk4F7Mx93eAcmgnmqHLhaGR3sI6EB7IwA>
    <xmx:bwi-ZyquQkE8tZhyE_PyDAeGHhzCQ17K_eoNmWNdTNLXaTHsMwU14A>
    <xmx:bwi-Z3B8yjPs7cYHRVQDAKaWUo3-laOA7rd68RhzWO3KgMwh3NTLAn4B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 13:14:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>,
    Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org,  Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH] bundle-uri: copy all bundle references ino the
 refs/bundle space
In-Reply-To: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com> (Scott
	Chacon via GitGitGadget's message of "Tue, 25 Feb 2025 13:19:45
	+0000")
References: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
Date: Tue, 25 Feb 2025 10:14:05 -0800
Message-ID: <xmqqv7sxki36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Furthermore, when I bundled just a tag (thinking it would have most
>     reachable objects) it completely failed to work because there were no
>     refs/heads/ available for negotiation - so it downloaded a huge file and
>     then still started from scratch on the fetch.

Nice finding.

>     Now I'm only getting an extra 43k objects, so 1% of the original total,
>     and the entire operation is a bit faster as well.

That makes all sense.

>     I'm not sure if there is a downside here, it seems clearly how you would
>     want the negotiation to go. It ends up with way more refs under
>     refs/bundle (now there is refs/bundle/origin/master, etc) but that's
>     being polluted by the head refs anyhow, right?

I am not sure what you mean by "being polluted by the head refs
anyhow", but we should be equipped to deal with a repository with
tons of local branches, so having the comparable number of
remote-tracking branches instead of local branches now exposed in
refs/bundle/remotes/* hierarchy should work equally as well, or we
would have something we need to fix.  So in principle I do not see
a problem with this approach.

The mapping used to be "refs/heads/foo" to "refs/bundles/foo", but
now "refs/heads/foo" is mapped to "refs/bundles/heads/foo", so that
you would presumably be mapping "refs/remotes/origin/master" to
"refs/bundles/remotes/origin/master", right?  I hope existing users
are *not* looking at their resulting refs/bundles/ hierarchy and
somehow assuming the original mapping.

This is not something this "fix" changes, but unbundle_all_bundles()
apparently is prepared to handle more than one bundles.  I wonder
what happens when multiple bundles expose the same branch pointing
at different objects?  The way I read unbundle_from_file() is that
a new one overwrites the previous value, so even though we may have
all unbundled many bundles, the objects from earlier bundles may
lose their anchors, subject to be garbage-collected.

Imagine creating a bundle with two refs, refs/heads and
refs/remotes, and append that bundle as the last bundle of a bunch
of bundles full of local and remote-tracking branches, that have
populated refs/bundles/ hierarchy with tons of refs.  Now the last
bundle is unbundled, and these two phoney refs would nuke everything
that used to be under refs/bundles/heads/* and refs/bundles/remotes/*
left by unpacking previous bundles, right?

>     Is this a reasonable change?

This is mostly Stolee's design, IIRC, so I have CC'ed; the work is
mostly from 53a50892 (bundle-uri: create basic file-copy logic,
2022-08-09) that is more than 2 years ago.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1897%2Fschacon%2Fsc-more-bundle-refs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1897/schacon/sc-more-bundle-refs-v1
> Pull-Request: https://github.com/git/git/pull/1897
>
>  bundle-uri.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 744257c49c1..3371d56f4ce 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -403,7 +403,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
>  		const char *branch_name;
>  		int has_old;
>  
> -		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
> +		if (!skip_prefix(refname->string, "refs/", &branch_name))
>  			continue;

By skipping only "refs/", "branch_name" is no longer a branch name,
which may be something we may want to fix, but if we were to address
the "names from later bundles seem to overwrite names used by
previous boundles, and unanchor objects obtained from them" problem,
I suspect we'd rather want to create new and unique names there,
without assuming or relying on that the names used by these bundles
are reasonably unique, so this part of the code may have to change
anyway, so we may not care too deeply at this point.

