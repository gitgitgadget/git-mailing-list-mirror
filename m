Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926E382398
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773438130; cv=none; b=Mvfme5lZpC13dD+7TkekIGfLU/wWZekjPjwanvkwWRsI7gWwfTPIFnwrmcqEHsbJZf+uYL2zG1HBq/UnIBsd0ae4rN9JxwTMyq7sWBPNzp7GCZuy3f/Tf6CUAX+9whX5QmlJLXz6UW95h4APC0pkknIdCqpfTEZB+gn19CWXZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773438130; c=relaxed/simple;
	bh=CqxNnRHp97kwO0Z+hSwzYab62P9RCwfv487665Wx7Tg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BpENZUt72hyeCHeA83TRKmitXoQX9d8THIxTILjk1s1vNzQltyLwNC4mw4k60+7XYgBTy0yQ1vrqobh0G20eu9ZJS+l/JYVhmbM32YvuOrlJ+M/1uAtJIOd1gsD+SBB3z2GlsrvsjLzsCU8j0iVl3R3VPi1graewBXzvwsYx1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jTBVlt2A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRPeZ/Sa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jTBVlt2A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRPeZ/Sa"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E92B1D001B9;
	Fri, 13 Mar 2026 17:42:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 13 Mar 2026 17:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773438128; x=1773524528; bh=Tuf8Rilkle
	83IOF/X0JixNAm6yKitj1FUFsphhAXy38=; b=jTBVlt2A8UV7xAXBbXZkeVPUXC
	eMCp11nPPNxVLCh9gbupyun9xtSNcj68AhdkGUQn18Qh2OO92dKIJ1qo/PBgCbdl
	NRntnG5v/6ZdDgB2onKUVKx/rOuQisLtkhtvOfsOQc0I6QCDI8YebA07cb/FXA8v
	TwKuMQ5/xi2XjA6XOi53SnsiDs7di2HjujUJiPkpajohIhnPwWzb8lj9JE092wn7
	iDqAp8U5RsfzzKK96ShvAY23Rn6pujtDFtCdRwqVM2IOv2Z0kHvT+4Og/ppbpvBs
	Nowtc2Og1g9mXAr5VodQXSgGuDROknVBA44FpyCfJVrDl2NKQQGRKkhlauwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773438128; x=1773524528; bh=Tuf8Rilkle83IOF/X0JixNAm6yKitj1FUFs
	phhAXy38=; b=eRPeZ/Sa9AdI/0Qs0/+CLaZ5BkBXokRf4jH+x3y35BOOpqe9oPQ
	+uBkjIRcQES8cgBMpYzwBI+ofLEgbP5flcgDz6aXrSSsdFM2ugnipUYrLo1b8Ly0
	9iKWGsPr3GAiLwRCa9zrG0p2sO9dQ/PO2rkMcp7E/QYC1gOkmW1iG4WV21l7MiKh
	0RnERWaCock3HDVpubry2S1BRQvdE1hlSX4GxnHV1MotHKqAzu6WTKqwG5zBXhmR
	3BGMSsMSb4rFwzP9sQ2kmTGRHD7IWOCIdryEanuGbLVgxPo8G4GqlstIsDXZB/sr
	7qYn+a8rNRj7D6kxlCch1YeYDXjGMW+QsCg==
X-ME-Sender: <xms:sIS0aaH365sNEI3IIYLDiqHyqYYc31QHZ5ZgM0oBbIW7YXs446qiGw>
    <xme:sIS0aSwNMfwuK3y7GBm5YOT3EinPUpBxJht89RTBA6Fu3cjzN5CzNGoAY9c35579r
    9Tqoqf_FQ3HQLzH4Z3v53KM4knLuzK2njqgJvYrkAwqs_BMvW2ogA>
X-ME-Received: <xmr:sIS0aRgsxvNW1L0Hz9SAONaNrD0H4SIBGGPlxeeSnj74HS_pNm1WRl7wPPpMYAqX68V1XCqh5e9yIw9cWRfmqBaX0GqDiiZwFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sIS0adzZ6DUEpUcVRiWxkm7ZUc88Z8GOEkLBYvNkij8opSXLUv2iwA>
    <xmx:sIS0aULmETHiRVvhUri01kobFlQ5PeVgP8XudH_iXtR-798_WbWCEA>
    <xmx:sIS0aUTX54SeRjB9NRubu0VOOfQ63UdqsKj1W7cm5hVkUQ4YsgVXoQ>
    <xmx:sIS0acrJoLoEDjHd8nVCHgNWbX8kYXA6LtsqARpflfbwDmeqGg9Www>
    <xmx:sIS0aWxmlnA5tyjOw9FoshY05oPHPRbLq2Ekf1d5NfmHMBL3WSqNEoxv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 17:42:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] worktree: reject NULL worktree in
 get_worktree_git_dir()
In-Reply-To: <1151b5b302069b4f3414a37e3be4bdbbc7e40686.1773411586.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 13 Mar 2026 14:19:50 +0000")
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
	<1151b5b302069b4f3414a37e3be4bdbbc7e40686.1773411586.git.phillip.wood@dunelm.org.uk>
Date: Fri, 13 Mar 2026 14:42:07 -0700
Message-ID: <xmqqfr632yq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This removes the final dependence on "the_repository" in
> get_worktree_git_dir(). The last commit removed only caller that
> passed a NULL worktree.
>
> get_worktree_git_dir() has the following callers:
>
>  - branch.c:prepare_checked_out_branches() which loops over all
>    worktrees.
>
>  - builtin/fsck.c:cmd_fsck() which loops over all worktrees.
>
>  - builtin/receive-pack.c:update_worktree() which is called from
>    update() only when "worktree" is non-NULL.
>
>  - builtin/worktree.c:validate_no_submodules() which is called from
>    check_clean_worktree() and move_worktree(), both of which supply
>    a non-NULL worktree.
>
>  - reachable.c:add_rebase_files() which loops over all worktrees.
>
>  - revision.c:add_index_objects_to_pending() which loops over all
>    worktrees.
>
>  - worktree.c:is_current_worktree() which expects a non-NULL worktree.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  worktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/worktree.c b/worktree.c
> index 344ad0c031b..1ed5e8c3cd2 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -227,7 +227,7 @@ struct worktree **get_worktrees_without_reading_head(void)
>  char *get_worktree_git_dir(const struct worktree *wt)
>  {
>  	if (!wt)
> -		return xstrdup(repo_get_git_dir(the_repository));
> +		BUG("%s() called with NULL worktree", __func__);
>  	else if (!wt->id)
>  		return xstrdup(repo_get_common_dir(wt->repo));
>  	else

<worktree.h> still has

    /*
     * Return git dir of the worktree. Note that the path may be relative.
     * If wt is NULL, git dir of current worktree is returned.
     */
    char *get_worktree_git_dir(const struct worktree *wt);

which needs a matching adjustment.
