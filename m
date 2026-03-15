Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6935F609
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773609468; cv=none; b=SjJiC6Lf0tdUlHni/kPGmiQ/n1Y0U01IP7uUk8xDwWMDvf8Lnv3uvRcEBFwPkhacELmf1NZ5qKeaRfXUEVzj65/qj2a7hI3fZhtEUNkTNPIlsU1duw0N1hWXAxkUWZvLl/8NORHPFvXs+qoyavt7SHLNd++7a0X3hrjq47TZGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773609468; c=relaxed/simple;
	bh=Y1Lmmvt1d6afrbGeLZ5dSetlrr0JiLUN4UWtF2Zs5nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cvQeYf78htabxdlfAKv1z0M9NNwETjvDs+k30RQJGCCJWXiYh87QyORUHRi2cpp5QizvEQTYVePQXF2pHBZYiAk59LLpn+jAIVViUy6gPy0Ia4av9V08b/XF0M73VBrcpDIhU/YpdTMAl/xYRpxc0pBv0Iw+3pMNQmWxFC3DT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aSu0KikD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qb9aIvnt; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aSu0KikD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qb9aIvnt"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56F8F14001CD;
	Sun, 15 Mar 2026 17:17:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 15 Mar 2026 17:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773609466; x=1773695866; bh=bNr34tqS+Z
	hr87P/FzE/1C6JCfufeFVcuH2hf4/RwxM=; b=aSu0KikDsRDtwGd96unTwRpAt9
	1gCQEPPzpzgbRQJJlCSkFos8kpiJjb/G1ZL2MPgsSHMCZkHHC2+T8Hj0CsS8Jucm
	il3FA2MX+u5wZzMBDt20vvkpZy6eRFpzScHdkEwldGkhXx5oE42Ied+wHae+Bmaz
	PvdZeezMhJHSYqE9GSDJao/JNY9HGaigX7T2fOUV7gTZgcZ5LTDTTemnq0OQJPRY
	8HrZzbRZR4T4vza4kuo5kmGf1+uysYptNSBJHguJ+hRTnXuhuv3sJIawhKoPm8NF
	CxqWslCuftyWApuUrtcQClv0xuP2xKz3+lI3SSRDVqvS7E0g2rF9M++op3xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773609466; x=1773695866; bh=bNr34tqS+Zhr87P/FzE/1C6JCfufeFVcuH2
	hf4/RwxM=; b=qb9aIvntHTubMkOs3aSy3/WNQ8YIxxjEHFCWLr+a2QEgXPWgleb
	ve1CpE+y3RyyqVzN8fpID3BSRF9zAaFiU07Uip+hME7cfUGCAmsL+Kau+LsJ0m40
	TwNGGz9xfPtMPaW13fqALnA8f5uhe7TSlIsxi/sP6Vqvv8DktVDBN+l0IbJQSNBL
	vG1TwDWrOc/vn9nnna5NDjM1+RM4pYKjhOOhzuitRyT3mYBPBWxWCMFqhcG5TQAo
	0soZqU6XsxhEh8kJ1CKYf/ETrl/W4OTOSFd8ekeITI4qhLf+zO8X8aifGPB50TUZ
	36PuIJ9UnTmEuLNEcbjNSXbKOroCV3bJ9Ig==
X-ME-Sender: <xms:-iG3abXeh8QV4bzcedsyK3fgQRkpN7AZ0zO_T-o-GBoO6LczXNiovQ>
    <xme:-iG3abBonraot-sCTBVXNKEIilBsQtnfrMhKOuwEOrMPR1hVdIaRhA0hDhlNa1Sgw
    oyb8Ova-w6K8UZFkVnDrX00cXjPGqOXii8QRkfxBALYWuCEpNv4aw>
X-ME-Received: <xmr:-iG3aUy7PmqfNSSoYLozWlUulrrqyzqqJSRi46NA-0Lwx5_r9jNc0C_lgbHd4xo90pDYQVoYzg_nZhXvflGxYWEPXQ9qz0icYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeiheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:-iG3aQCL1hMgP1Jg7wSb5_uk4pwgT8BmJ9o3kndaj_FZRu55n6rHUg>
    <xmx:-iG3aZaqnMEQvU4jgpkOUZ9ml3bVrZvO0skJggztljm6T6iiiMZNIg>
    <xmx:-iG3aQjn0JEKES5Mxj9pUMwtT8l42e9aiE1alXN6u7piN2fTfqeruQ>
    <xmx:-iG3aT6Yth6kmneS7p05KrqQ0tefjhUInrK3NKWhOfVMyMaBAB9zCw>
    <xmx:-iG3afDO82DccXQGsW4PTWuxZk69iVm0IXpwgBBfi2qMbiUwF8RAXtWj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 17:17:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] worktree: stop using "the_repository" in
 is_current_worktree()
In-Reply-To: <cover.1773591528.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Sun, 15 Mar 2026 16:18:49 +0000")
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
	<cover.1773591528.git.phillip.wood@dunelm.org.uk>
Date: Sun, 15 Mar 2026 14:17:44 -0700
Message-ID: <xmqqzf48rdvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Range-diff against v1:
> 1:  075700a2256 = 1:  075700a2256 worktree: remove "the_repository" from is_current_worktree()
> 2:  ae2a368e7e7 ! 2:  c3c5767725d worktree add: stop reading ".git/HEAD"
>     @@ builtin/worktree.c: static int can_use_local_refs(const struct add_opts *opts)
>      -			free(wt_gitdir);
>      -		}
>      +		if (!opts->quiet)
>     -+				warning(_("HEAD points to an invalid (or orphaned) reference.\n"));
>     ++			warning(_("HEAD points to an invalid (or orphaned) reference.\n"));
>       		return 1;
>       	}
>       	return 0;
> 3:  1151b5b3020 ! 3:  75eecc8492e worktree: reject NULL worktree in get_worktree_git_dir()
>     @@ worktree.c: struct worktree **get_worktrees_without_reading_head(void)
>       	else if (!wt->id)
>       		return xstrdup(repo_get_common_dir(wt->repo));
>       	else
>     +
>     + ## worktree.h ##
>     +@@ worktree.h: int submodule_uses_worktrees(const char *path);
>     + 
>     + /*
>     +  * Return git dir of the worktree. Note that the path may be relative.
>     +- * If wt is NULL, git dir of current worktree is returned.
>     +  */
>     + char *get_worktree_git_dir(const struct worktree *wt);
>     + 

Ah, I somehow expected to see that we say "passing NULL to wt is an
error", but that is misleading.  When something expects a worktree
instance, and it accepts NULL as a special case, then that is worth
commenting, but otherwise, it is not worth mentioning.

All look good.  Will replace.  Thanks.
