Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBC379C2B
	for <git@vger.kernel.org>; Tue, 12 May 2026 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570054; cv=none; b=jx4DEGmzxArpg5AkrKb69q5XpaIlfNaZIZyI+1RHlyzd01noJdT/a9vkq5eaVnCDzuD981P2iLWX9kW6kUbR/cUkYyH+v+vNOLarzQ7sh8rhrhBoCcIIYWCD2G8QQethXC66k6yHOz3cqh2XuP2Co+/rzeUDN6y5oc2X3FL8cFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570054; c=relaxed/simple;
	bh=SwnBQDpAX0eKs7838N0ZGHKF1+g1x7PdUSZxwoDQRCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGRDngFXeuheyW9Dq1oBtS63+5gUawf2kdBTR1E7dZAmISMj15EvWdfCaczZvVauemNPH23xNwuHpKLDsuC3LecE1ym3g/XpymSQt7f9eKvl1tKs2bR+udprckJIYwwfCK3I9o5K1EWWC9D1OiexDYTVI3hWp+R1g19jPJJFxyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VPzE2wif; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OS0HrJkW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VPzE2wif";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OS0HrJkW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BC931400085;
	Tue, 12 May 2026 03:14:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 03:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778570047; x=1778656447; bh=gNUnmJefYA
	mw0HaaNvX+S6RH4u6BbgU7PhvRBhh9pMU=; b=VPzE2wif3Ta3bJbsP2ww9xpW4C
	sRcXFVFIFt6cLOyJs+MV5EH+jq0gtuUjUsQYJMkHfTmP3yGYk8r2P4uhVLUbwPUI
	s8ZQ59tr0lUbmDjP54lVpe23aIUJo+XyUQP/gkTWcbRDMnBLez7b8uL1N207rdxg
	227K2KXbYAx9XVFE1kTKTk57mc3f6AQA40BfcvyoK/Wyh4ADvp1ayHV5v9+Zbql0
	jU6GXDMrbqPQtQ0LHSMxPOIqgZhELvwWuWLDM0ptA2qF0E6LsPE9LkXOldslpJWF
	NJkwH2Bf6Wfb1ndhSntQa36d9CJbf8s2escuxDufXpWtG90sGZNF5eAliZ3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778570047; x=1778656447; bh=gNUnmJefYAmw0HaaNvX+S6RH4u6BbgU7Phv
	RBhh9pMU=; b=OS0HrJkWh8x+DAjvvbywrhuW+t/srfT7BnxoX71P5BDCiPgZVSX
	LtPZq6w2Mt4RqzZwYEf/7qP9Kra4R95/ShV9Q2Lnx9vRRc/3v0Q5AlWckCord3f+
	j6hx+ekxKb3QHYcNkHS4ubpv3IlUR82XaWmxQHCsXwYt+dxbY1XJwoXPg1BpEvF6
	NKb5RM8Ik62uDYRvNmjdvXdJ1ssbhAVVJtgyQgjpjCawDIEPq2F079xP0es+jlYa
	31k+hgQy2eiqxqOZyXHnEKGX4PKd+rIzhy6ONDZib8enHAXwDeumadF9WQQ5FPC0
	hrEpwf8FPrqoHrD9GMBK7wpI/LQtTIa6+ww==
X-ME-Sender: <xms:PtMCaq1qo_0JcyzOdOVNIG0r9bhT9XAVCJy9ICsJXU-d9Y4siamUzg>
    <xme:PtMCakGaFpHM89HEQTcriAqDl5M_8hmuJu6OBqG4_st9WWAtmXVaU21tEDsAutvzM
    xNLRbOxAO2lVIe0kSEfPFm12Zs5_dA5FX4aoKDm1mWlxsjND029Ag>
X-ME-Received: <xmr:PtMCan4hDBWTsjCZEWn5_fO4nKY5A0nLKfLj7rZXuafVtvD8NdLBjSURL7_1dJt8OwJ-DoHvMpdTNXaegtHzvg5Y4nYYEaqmHVyaySZnbz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgessghlrg
    gtkhdquggvshhkrdgtnhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:PtMCaquEidlOLCluen14jY1szpoqVH7lD1pSp5ZR3sD4aTDbsbGmLg>
    <xmx:PtMCao5UpHFXI4A7TiL1DVupOIRWXjOySp-90QrF8KK4FPC3GJl-aA>
    <xmx:PtMCalXibWxi13ytVsaqUPtLbwqtrrhA8ePzMaDOjtKcuFJxcqKHfw>
    <xmx:PtMCaq_PaMgnqtVDkGDmIGirgHrnqAEQ75MtArBkj3KO6lx_TYJCuA>
    <xmx:P9MCamHjWkhkhCnivxL98Gtjm-us6Gptj761LWNzyV1KrVmzY0x2BoMw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 03:14:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d125f1dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 May 2026 07:14:05 +0000 (UTC)
Date: Tue, 12 May 2026 09:14:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: me@black-desk.cn
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] config: add "worktree" and "worktree/i" includeIf
 conditions
Message-ID: <agLTO0amktCWMsiE@pks.im>
References: <20260403-includeif-worktree-v3-0-109ce5782b03@black-desk.cn>
 <20260403-includeif-worktree-v3-2-109ce5782b03@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-includeif-worktree-v3-2-109ce5782b03@black-desk.cn>

On Fri, Apr 03, 2026 at 03:02:29PM +0800, Chen Linxuan via B4 Relay wrote:
> From: Chen Linxuan <me@black-desk.cn>
> 
> The includeIf mechanism already supports matching on the .git
> directory path (gitdir) and the currently checked out branch
> (onbranch).  But in multi-worktree setups the .git directory of a
> linked worktree points into the main repository's .git/worktrees/
> area, which makes gitdir patterns cumbersome when one wants to
> include config based on the working tree's checkout path instead.
> 
> Introduce two new condition keywords:
> 
>   - worktree:<pattern> matches the realpath of the current worktree's
>     working directory (i.e. repo_get_work_tree()) against a glob
>     pattern.  This is the path returned by git rev-parse
>     --show-toplevel.
> 
>   - worktree/i:<pattern> is the case-insensitive variant.

Seems sensible.

> The implementation reuses the include_by_path() helper introduced in
> the previous commit, passing the worktree path in place of the
> gitdir.  The condition never matches in bare repositories (where
> there is no worktree) or during early config reading (where no
> repository is available).

Right. This is because `repo_get_work_tree()` would return a NULL
pointer in these cases, and `include_by_path()` exits early in that
case.

> diff --git a/Documentation/config.adoc b/Documentation/config.adoc
> index 62eebe7c5450..a4f3ec905098 100644
> --- a/Documentation/config.adoc
> +++ b/Documentation/config.adoc
> @@ -146,6 +146,48 @@ refer to linkgit:gitignore[5] for details. For convenience:
>  	This is the same as `gitdir` except that matching is done
>  	case-insensitively (e.g. on case-insensitive file systems)
>  
> +`worktree`::
> +	The data that follows the keyword `worktree` and a colon is used as a
> +	glob pattern. If the working directory of the current worktree matches
> +	the pattern, the include condition is met.
> ++
> +The worktree location is the path where files are checked out (as returned
> +by `git rev-parse --show-toplevel`). This is different from `gitdir`, which
> +matches the `.git` directory path. In a linked worktree, the worktree path
> +is the directory where that worktree's files are located, not the main
> +repository's `.git` directory.
> ++
> +The pattern can contain standard globbing wildcards and two additional
> +ones, `**/` and `/**`, that can match multiple path components. Please
> +refer to linkgit:gitignore[5] for details. For convenience:
> +
> + * If the pattern starts with `~/`, `~` will be substituted with the
> +   content of the environment variable `HOME`.
> +
> + * If the pattern starts with `./`, it is replaced with the directory
> +   containing the current config file.
> +
> + * If the pattern does not start with either `~/`, `./` or `/`, `**/`
> +   will be automatically prepended. For example, the pattern `foo/bar`
> +   becomes `**/foo/bar` and would match `/any/path/to/foo/bar`.
> +
> + * If the pattern ends with `/`, `**` will be automatically added. For
> +   example, the pattern `foo/` becomes `foo/**`. In other words, it
> +   matches "foo" and everything inside, recursively.

This whole listing here is the exact same as we have for the `gitdir`
condition. Can we maybe deduplicate these into a common section?

> diff --git a/config.c b/config.c
> index 7d5dae0e8450..6d0c2d0725e4 100644
> --- a/config.c
> +++ b/config.c
> @@ -400,6 +400,12 @@ static int include_condition_is_true(const struct key_value_info *kvi,
>  		return include_by_path(kvi, opts->git_dir, cond, cond_len, 0);
>  	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
>  		return include_by_path(kvi, opts->git_dir, cond, cond_len, 1);
> +	else if (skip_prefix_mem(cond, cond_len, "worktree:", &cond, &cond_len))
> +		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
> +				       cond, cond_len, 0);
> +	else if (skip_prefix_mem(cond, cond_len, "worktree/i:", &cond, &cond_len))
> +		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
> +				       cond, cond_len, 1);
>  	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
>  		return include_by_branch(inc, cond, cond_len);
>  	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,

I feel like this is something that we might eventually want to convert
to be table-driven. But I think that doesn't have to happen as part of
this patch series.

> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index 6e51f892f320..8a5ba4b884d3 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh

Just because it was explicitly mentioned: we might also want to have a
test that verifies this works with early-config parsing. We already have
a similar test for "gitdir:" in "conditional include, early config
reading".

And should we also have a "nongit" branch where we verify outside a
repository?

Other than that this series looks good to me, thanks!

Patrick
