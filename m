Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749CE2110
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749399613; cv=none; b=YBIaiF8FYB1cgNbWk3AZ2ue5YayFuDsvvzuPA/nyHaW1rDhHvusoREbKBYpWwUz1NRbfuPWSrPx4v2gYzf7946VgP9e8/W9yOzUJvGrMuk8LGQFwFJ1sKPJbR9J+6vRCpW0suv7G3IJMsQDcu1/pMOnWxQtFLSN1PW/73zvaQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749399613; c=relaxed/simple;
	bh=Q5NwaU2nscOQMlP/s5UnT1YcYzVNyQMGjvAJO4uLpS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o19vThi77NP9pWhASU6rjZkwsF11I6/Wg7ydVCQ+DsmpcpVxuP5jMrmElHeJZgoE1NQfTOQ7XlNfEbwfupdP/3xCCWc3IP8wgV3uCv2dXNevOX6cmteMwYf8dIJ6RHjtve1SZWATzVKTjYQPZLn5m0wPsApqmMqQ2dPqHiqw+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0IexlUbz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9XoofTI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0IexlUbz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9XoofTI"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6171925400D3;
	Sun,  8 Jun 2025 12:20:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 08 Jun 2025 12:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749399610; x=1749486010; bh=wj2/nTuAwO
	gPtdUVibmkIWbz9EEp1K32EMw8pn/75tA=; b=0IexlUbzpfUczt/Q2xdLuUFhAy
	STQmIv1Y9IB7YrEmxK0oOexAHW3JVLeIck6pvooBTZAnh9TWcqxZALuyayi8IhpZ
	ucAlgKY4KFyFxcLZamEf4srz85FWARNik/sOWvmP+0xxD1pohASltu+xmQkFrubO
	eDBoVoxW38VdJgQs9//vuQsEz/GgJpjYLrAvUMtlQgatLbkkQdwc7jXSD75xgscT
	tkhPhPdrRQagSYqexhgf3Rr5PY30JRtINN0uYPi5t0tuBfOUno/kjAFxMVHXxoPH
	3BeMIZ4mDyep6PghclMt2maGMkBJe3cEEs3vUQSyhL0VA/K4jRKQIWXTPvgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749399610; x=1749486010; bh=wj2/nTuAwOgPtdUVibmkIWbz9EEp1K32EMw
	8pn/75tA=; b=F9XoofTIIuKtnYhMF9N+UcXLN3oDFy6DCuBqWK0Q14X2QOMl/09
	FbuMuLTH7jbhws/tduzml9q6aQ+1E1d9ehEzrrPoqmCr9QnzAThVjUQfgnUDgyrB
	LGOGNG1SkC6WqCK7ZUD99p+mxsM1j9MrsUZ8D62GyUja6kQxWF6GdGYhhnl0DnIw
	SMOZ3DkrInOi0IT72JJbUtdc5r9hpXFviyvK2aE4oHs8pbbzs9jh/1rE5BMqdj2B
	jqRPLKpB3DB057qRd6jL3HrI9ry6U+KlgklBbHQlpgb20Rm3ZQE/U3iKS17jm+Z+
	Z+NM//9TzuSfkotpkW67DCit9OTrPilwvcg==
X-ME-Sender: <xms:ObhFaBDZwyh8VeRQ-x6lca6sE00gz97xFccpF6ggXGlNQf6P-nYl7Q>
    <xme:ObhFaPjnHZP9XWsErlqFA4AJNKJCyNqsnfUO34DlA0KKQQJaF3eVts6pjixE8l8SJ
    HytgmQlYUJnNeknrw>
X-ME-Received: <xmr:ObhFaMnsJGIFl56duDPd0Xytfei8Wd6ekiZak54NREvO2Lbs9PNHDJ7FERdPvk1CWyd9X-rRyNa6fVvDOR8iQMMGZ26lOQyCksNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdektdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvggvrh
    hthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhs
    rdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhmrggtughonhgrlhgusehkrghimhgrghhinhhgrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ObhFaLzTpNLEOHvhSmWCuoyNM_zi-RNEDAldMnXLwPh_7Xi4f9mwpg>
    <xmx:ObhFaGTT_DtnmklzGYOH-prhwuqKLZceQrI2QaK8ZR33pTyIxuFFoA>
    <xmx:ObhFaOZ1qMnzftpd1bkkpkbmxHmEDgB6rz5ufA7x8iwN4uw1dnBOGw>
    <xmx:ObhFaHRoTM0GGivnwfijF8tdvykmVGJyT7Zp7mX3Co42Iyu4hThVAw>
    <xmx:OrhFaLKrOFP-YDSaUXzzUvyAfngUBHY9DaJsNGNYkmjQQXKUOCelzYzY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 12:20:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: l.s.r@web.de,  git@vger.kernel.org,  smacdonald@kaimaging.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v2] stash: fix incorrect branch name in stash message
In-Reply-To: <20250608144542.275836-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 8 Jun 2025 20:15:42 +0530")
References: <f46443ac-eb7f-47db-8f4b-a06384e6fde5@web.de>
	<20250608144542.275836-1-jayatheerthkulkarni2005@gmail.com>
Date: Sun, 08 Jun 2025 09:20:07 -0700
Message-ID: <xmqqo6uyw6h4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> When creating a stash, Git uses the current branch name
> of the superproject to construct the stash commit message.
> However, in repositories with submodules,
> the message may mistakenly display the submodule branch name instead.
>
> This is because `refs_resolve_ref_unsafe()` returns a pointer to a static buffer.
> Subsequent calls to the same function overwrite the buffer,
> corrupting the originally fetched `branch_name` used for the stash message.
>
> Use `xstrdup()` to duplicate the branch name immediately after resolving it,
> so that later buffer overwrites do not affect the stash message.
>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---

Nicely described.

> @@ -1372,6 +1372,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>  	const char *head_short_sha1 = NULL;
>  	const char *branch_ref = NULL;
>  	const char *branch_name = "(no branch)";
> +	char *branch_name_buf = NULL;
>  	struct commit *head_commit = NULL;
>  	struct commit_list *parents = NULL;
>  	struct strbuf msg = STRBUF_INIT;
> @@ -1401,11 +1402,16 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>  		ret = 1;
>  		goto done;
>  	}
> -
> +	

Addition of trailing whitespace?

You can avoid such mistakes in the future by enabling our sample
pre-commit hook, which essentially does

	git diff-index --check --cached $against --

where $against is HEAD (or an empty tree object while preparing for
an initial commit).

>  	branch_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
>  					     "HEAD", 0, NULL, &flags);
> -	if (flags & REF_ISSYMREF)
> -		skip_prefix(branch_ref, "refs/heads/", &branch_name);
> +
> +	if (flags & REF_ISSYMREF) {
> +		if (skip_prefix(branch_ref, "refs/heads/", &branch_name))
> +			branch_name = branch_name_buf = xstrdup(branch_name);
> +	} else
> +		branch_name = "(no branch)";

Do we need the else clause?  The original did not have it and showed
the "(no branch)" message without an issue, and I do not see anything
is changed by what happens inside the other side of this if statement.
Am I missing something?

> @@ -1495,6 +1501,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>  	strbuf_release(&msg);
>  	strbuf_release(&untracked_files);
>  	free_commit_list(parents);
> +	free(branch_name_buf);
>  	return ret;
>  }

Makes sense.

This is a common pattern we use with a variable whose name contains
"to_free" (e.g., "branch_name_to_free"), but "branch_name_buf" is
pleanty readable and easy to understand what is going on.

> +test_expect_success 'stash reflog message uses superproject branch, not submodule branch' '

The title looks a bit on the overly-long side.  Would

    stash message records the superproject branch

be sufficient?  The fact that the stash is implemented as reflog
is invidible and irrelevant at this level, so "reflog message" is
wasting bytes without adding any useful information.

What we want to make sure is that the message records the current
branch name, whether the project has any submodules or not, and from
that point of view,

    stash message records the correct branch name

ought to be good, but not quite, because this test is trying to
trigger a bug that was present only when there are submodules, so
not mentioning superproject/submodule at all would not work well.

Would

    submodules does not affect the branch recorded in stash message

work?  That is the best one I can come up with offhand.

> +	git init sub_project &&
> +	(
> +		cd sub_project &&
> +		echo "Initial content in sub_project" >sub_file.txt &&
> +		git add sub_file.txt &&
> +		git commit -q -m "Initial commit in sub_project"
> +	) &&

It is easier to debug the test script if you avoid using --quiet too
much.  Regular "sh ./t3903-stash.sh" will squelch these output
anyway, and they can be seen when the test script is run with "-v".

> +	git init main_project &&
> +	(
> +		cd main_project &&
> +		echo "Initial content in main_project" >main_file.txt &&
> +		git add main_file.txt &&
> +		git commit -q -m "Initial commit in main_project" &&
> +
> +		git -c protocol.file.allow=always submodule add --quiet ../sub_project sub &&
> +		git commit -q -m "Added submodule sub_project" &&
> +
> +		git checkout -q -b feature_main &&


> +		cd sub &&
> +		git checkout -q -b feature_sub &&
> +		cd .. &&

These three lines can be written more compactly as:

		git -C sub checkout -b feature_sub &&

> +		git checkout -q -b work_branch &&
> +		echo "Important work to be stashed" >work_item.txt &&
> +		git add work_item.txt &&
> +		git stash push -q -m "custom stash for work_branch" &&
> +
> +		git stash list >../actual_stash_list.txt &&
> +		grep "On work_branch: custom stash for work_branch" ../actual_stash_list.txt
> +	)
> +'
> +
>  test_done

Thanks.
