Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353AA26A08A
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 21:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164946; cv=none; b=kJxGqaL5m52jL2SKUdOz3guJhZHLygPW+gwJkw85gTCMO4R8jfKRVXZEtYhBzN6SiZimNxHqXl16U0za+jmjbiuk98S+D/DrljQ2eZIOK0EwtGP4+kEJjCPYWtWOxVST8bNAgThZAnbgNO7mxQPmYgTPsp1HiXK2uYtG7Vuzirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164946; c=relaxed/simple;
	bh=3XrhqejDug6XUxIZf7s3rpYqKPqrX95CRUdMGHHJvF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NJwc5DTPApUnSwdIl0afKX8MbYYQ0995gnvW/sdmZT/9pVCbxHZmBvdDAWpaFTxWs66svR133KKJxGeofu0xOdRPfz9nQboCzeXCDWDTxkbjH0qsXKqT367Gvj/4FDQ4sKRgw1ql7AQAtDHymbXyz3vXjK3aCMx3L/iBC9TneMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zhdOeCKs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ev5psgXf; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zhdOeCKs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ev5psgXf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D93414001C1;
	Thu,  2 Apr 2026 17:22:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 02 Apr 2026 17:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775164944; x=1775251344; bh=LkYRvl8f4I
	OosqQF3AoU0uTlpgQeCOngKX0AS8qQr9c=; b=zhdOeCKsrnPqQhpfgc1+d0keY9
	PMs7R6wIyrQeORSFs95JF+JHRa+tMdoafB/+CRnhP8l2UyEEYEHLbNBAffJwSm03
	KrW6LhhL4BP2h+Wo3cTdsiNtDxhEBKDedFgOu0ftFbgyp+fGiDw/D4T1lqRsnTvi
	fZlmxJvXHjppXln83DokuWVO6Yx/3YmLY3bzolN8LiaTrogLptGDyckJvg9je1U9
	gP9IP9YOXM4MWgF7XykWmC7XA27+D0Gza698A0n5cwEBYJ0HfH1NWG5b5BBshOXi
	zsZZgN4eh3tp52Z2ydui0j0IFIZCjlBX6CXUIchzsEmDZje7drPAR09PGyoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775164944; x=1775251344; bh=LkYRvl8f4IOosqQF3AoU0uTlpgQeCOngKX0
	AS8qQr9c=; b=ev5psgXfBlXB6yfhYp3chuhnW5aSQR4GM31V5inxE9HHg9fN+/6
	EXTXxmXjOInua5FQvKHLI2KoWATEn7daX1alY0cg+lC61hH+T33WsLHPxfcLIOY6
	kuCvP2UepREbL6+uPM53c7D5lfjLt8dfkhyHb4UGsAuU2mp+MEl9mfmthEcXLz5E
	m0HH8J7uYTrSfHCYH2Gx/scf1puP6R7svsT2OQH72tU26+wx+SP+dAAZ5k/qn8CW
	LgoZz8hdgBro5BK1LugufFR12baAHM75dKFsoFA4ilcDlOhbAYBkE2KXwh6npayC
	tyByvqgvKCvxWGBeNuBCEt56f3JPjLEJ42Q==
X-ME-Sender: <xms:EN7OabDxYqf5P7qTxqyjix79pvkSDIewJ8bOCyyIAxbam4MwMv9LSQ>
    <xme:EN7OaYbusbOEfbqRixN_ETrZPXHeUqLOnecry7v8UvFifl0vo5Q0gx26T3GQHMYLN
    yWXY60PBvmq6-IYndmMXPf3qsD72uUrIqOSqYvAdZgmtmRuBcjyOg>
X-ME-Received: <xmr:EN7Oae6FqRmncmIRLuz-LkVNY1nOgObInHSJhMUB3RdE3dDg0NTjt9ol668uX8NNO_9YAIQKxHAmr59cZWPdxgkGxu_i2PIp2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepuggvvhhnuhhllhdomhgvrdgslhgrtghkqdguvghskhdrtg
    hnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsegslhgrtghkqdguvghskhdrtghnpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EN7OaZYEi5xc4mfmpDi0c7-yQpsqZ2Yil_f4YwobRukbohG44SmReQ>
    <xmx:EN7Oadh0rRCD0Qu8pxUEcNFnUft5aD6h2IKJ4tJuX2WuggO8TljiNg>
    <xmx:EN7Oaa8p8ftSUEXdkS4hbx09y7csQomDv780dK6gjdVLK7doyuvZqA>
    <xmx:EN7OaYpBr3bOYN0mgsqM5UPlEy0l4MWytYvv8I5ENwDVGr-p7cKJ5A>
    <xmx:EN7OaRLAUv1JGx3FcJH5KJKlVKaTFl5NeCTaxLqG-c8bsKi2hUXeWgtU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 17:22:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Chen Linxuan <me@black-desk.cn>
Subject: Re: [PATCH v2 1/3] config: add "worktree" and "worktree/i"
 includeIf conditions
In-Reply-To: <20260402-includeif-worktree-v2-1-36e339b898d7@black-desk.cn>
	(Chen Linxuan via's message of "Thu, 02 Apr 2026 10:58:45 +0800")
References: <20260402-includeif-worktree-v2-0-36e339b898d7@black-desk.cn>
	<20260402-includeif-worktree-v2-1-36e339b898d7@black-desk.cn>
Date: Thu, 02 Apr 2026 14:22:22 -0700
Message-ID: <xmqqv7e9njld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
writes:

> From: Chen Linxuan <me@black-desk.cn>
>
> The `includeIf` mechanism already supports matching on the `.git`
> directory path (`gitdir`) and the currently checked out branch
> (`onbranch`).  But in multi-worktree setups the `.git` directory of a
> linked worktree points into the main repository's `.git/worktrees/`
> area, which makes `gitdir` patterns cumbersome when one wants to
> include config based on the working tree's checkout path instead.
>
> Introduce two new condition keywords:
>
>   - `worktree:<pattern>` matches the realpath of the current worktree's
>     working directory (i.e. `repo_get_work_tree()`) against a glob
>     pattern.  This is the path returned by `git rev-parse
>     --show-toplevel`.
>
>   - `worktree/i:<pattern>` is the case-insensitive variant.
>
> The implementation follows the same structure as `include_by_gitdir()`:
> the worktree path is resolved via `strbuf_realpath()`, the condition
> pattern is prepared with `prepare_include_condition_pattern()` (which
> handles `~` expansion, `./` relative paths, `**/` prefix insertion and
> trailing-`/` expansion), and matching is done with `wildmatch()`.  A
> second attempt using `strbuf_add_absolute_path()` is performed to
> handle symlinked paths.
>
> The condition never matches in bare repositories (where there is no
> worktree) or during early config reading (where no repository is
> available).
>
> Signed-off-by: Chen Linxuan <me@black-desk.cn>
> ---
>  config.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

This probably should be further split into two commits, one that
introduces the "by-path" helper function and reimplements the
"gitdir" and "gitdir/i" support with it (i.e., essentially it
amounts to dropping of "struct config_options *" and using "const
char *path" in place of it, I presume), and another patch that adds
worktree support in terms of the "by-path" helper.  

The documentation updates and additional test should probably be
done as part of the second half of this patch, unless the second half
of this patch to add "worktree" and "worktree/i" is too big to be
reviewed standalone (which I do not think would be the case).

> diff --git a/config.c b/config.c
> index 156f2a24fa00..6d0c2d0725e4 100644
> --- a/config.c
> +++ b/config.c
> @@ -235,23 +235,20 @@ static int prepare_include_condition_pattern(const struct key_value_info *kvi,
>  	return 0;
>  }
>  
> -static int include_by_gitdir(const struct key_value_info *kvi,
> -			     const struct config_options *opts,
> -			     const char *cond, size_t cond_len, int icase)
> +static int include_by_path(const struct key_value_info *kvi,
> +			   const char *path,
> +			   const char *cond, size_t cond_len, int icase)
>  {
>  	struct strbuf text = STRBUF_INIT;
>  	struct strbuf pattern = STRBUF_INIT;
>  	size_t prefix;
>  	int ret = 0;
> -	const char *git_dir;
>  	int already_tried_absolute = 0;
>  
> -	if (opts->git_dir)
> -		git_dir = opts->git_dir;
> -	else
> +	if (!path)
>  		goto done;
>  
> -	strbuf_realpath(&text, git_dir, 1);
> +	strbuf_realpath(&text, path, 1);
>  	strbuf_add(&pattern, cond, cond_len);
>  	ret = prepare_include_condition_pattern(kvi, &pattern, &prefix);
>  	if (ret < 0)
> @@ -284,7 +281,7 @@ static int include_by_gitdir(const struct key_value_info *kvi,
>  		 * which'll do the right thing
>  		 */
>  		strbuf_reset(&text);
> -		strbuf_add_absolute_path(&text, git_dir);
> +		strbuf_add_absolute_path(&text, path);
>  		already_tried_absolute = 1;
>  		goto again;
>  	}
> @@ -400,9 +397,15 @@ static int include_condition_is_true(const struct key_value_info *kvi,
>  	const struct config_options *opts = inc->opts;
>  
>  	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
> -		return include_by_gitdir(kvi, opts, cond, cond_len, 0);
> +		return include_by_path(kvi, opts->git_dir, cond, cond_len, 0);
>  	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
> -		return include_by_gitdir(kvi, opts, cond, cond_len, 1);
> +		return include_by_path(kvi, opts->git_dir, cond, cond_len, 1);
> +	else if (skip_prefix_mem(cond, cond_len, "worktree:", &cond, &cond_len))
> +		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
> +				       cond, cond_len, 0);
> +	else if (skip_prefix_mem(cond, cond_len, "worktree/i:", &cond, &cond_len))
> +		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
> +				       cond, cond_len, 1);
>  	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
>  		return include_by_branch(inc, cond, cond_len);
>  	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
