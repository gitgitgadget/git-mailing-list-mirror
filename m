Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E0202F70
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770514412; cv=none; b=Jk6qfxgtH6koOgFQ4WsBkgBibdbVedu+448S3YkP8RCHShEpPj9Uq8HO6zMpBZIgjyfB9Ww77XqU05220m86xfeZJu52Px4VBYNbKIJkYhCRrr3aZndv02y6fHLUnI6DGGmynW+KyeXp2Y6lx+rkiAzEibxERy5YaoShT5uqOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770514412; c=relaxed/simple;
	bh=1yRI+W59108MQR60o4QOypcVFA6BDqUJWiN1yq45smo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JpMUzqhz+SMUVJINAxC2NNNHCinMBX0OnC3Pjb9P5tvHQgi/4at1sFQF/qamNx/Hz4WhnoYhFV9xAVhe+MLDyxvnmHEvb4T5c4vnZXg3OVarSJ2AOQ1LNhDaqeAUBKdx1WpSIHO44H0zFrReNCPIMkZo8YH85FZfY7nRo0sBw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PS+EVWIo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbO+tRr6; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PS+EVWIo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbO+tRr6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 288B714000A2;
	Sat,  7 Feb 2026 20:33:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 07 Feb 2026 20:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770514411; x=1770600811; bh=ELhvdr4RxH
	xeYY82Qb4avghgZWBrWKbdsb7f5cw62bw=; b=PS+EVWIoq9dVDnaRRCGxJ3fPsM
	fa7J2It75faTT5eWwA2xMkB3pwyWJ0GvIWIh7iXsXXSWq9WQeJAjNdc6DuDOemUX
	bNRl4uccafZ1wBuCHcbHTDBhNL70FKH1SXUl9vLb8NeQLExe4kgWb2zYG2TYunH7
	MpN/48j7TahWBDwlPiTb9DhPivDQm9bCx3KQyOUpfPOfmSVu6NEhlQlYqjQtwcWx
	mVeJGtEufYAfWuKECLPAYbVpFJL/q/eWwIfNuKSToVpo4pV4pcPe8+XNKB9g3wBS
	YOws0K9Mqj+hSjbkTDjT8JS1MUt/5V3e53VUKYJP3bNPl8Tgy5dSTuUbhQQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770514411; x=1770600811; bh=ELhvdr4RxHxeYY82Qb4avghgZWBrWKbdsb7
	f5cw62bw=; b=TbO+tRr680LZTtah8z19D+L4fyn/5DW0qaj9iAc+gdjFLtkESiy
	r00CNFExMdlD8YK8YvYUe7i11S4/pjT82zKFRVStdU5oWsnsnQF2/TL4oTLmkRvA
	d5sTiLu0z92WhbpSFYoZiacE8nw0XuriV7pTL4wIW7HLwRGr5+eDXH91lAICI302
	3VaXZgFwvpRXVbiq+3NcjmaTs37OwXqPBzk6LcboXQcNW3yTEcpTVzKBNiwdeGEA
	SBDaQLUGCyZW4TCbACt6zCmn7mKZHc3qb8HaE4cJCIPOfNfKC2Jbpkbs5FqxISCD
	vz7NySeDmUHtDDNhvK+OZenuOSbvMJEy5oQ==
X-ME-Sender: <xms:6-eHaZtamES9R9Wl-2sd9Xn7RcoAbdO4kYBD6i6lGmYtSeP1vp3vcw>
    <xme:6-eHaZeWWGpaVkArqqLf3TdfF00lxZU_nfXGr564ZKE7LypoPvOPmF8ghFxZUHMFT
    7tNLmqdBKP1l4NLnRZG3x9hf2FyzyQ-5iLyO0Vz07Lmqh8vBOYl0w>
X-ME-Received: <xmr:6-eHaRzWIRI2-j9KcYUgguH7ux86qqW1YqZTNPx5LYwXjgGb61ynaM3pIJCROe05LJKnJ8e7es506ganBRG7lzcig-bRKrVTVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledviedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhiuhdruggvnhhtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6-eHafFftaE3Bii62tbHjs_ftRU91m__j2f19yT__GXXjgMeE-ns8g>
    <xmx:6-eHaVyV2esJhDqk8K5bvL3U_Z-45f9XA30q-brSTOvbV-d89bM4rQ>
    <xmx:6-eHaQuOO6_yttsGjwCIp-aJRxd32UIi7G3RSu-0gKLEtGRRLiT1Qg>
    <xmx:6-eHaS1wCCIcmI1eeTqJYIv1-x3jtPbP9kP7_BYwSPo_GaTlGM2nkw>
    <xmx:6-eHaVQ3h1k_0q45XCvQpfuhGDbxrBCgDdij7mt92tpOJyUqzYvOajTR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 20:33:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] completion: add stash import, export
In-Reply-To: <20260207215924.28863-1-ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Sat, 7 Feb 2026 16:59:16 -0500")
References: <20260207215924.28863-1-ben.knoble+github@gmail.com>
Date: Sat, 07 Feb 2026 17:33:29 -0800
Message-ID: <xmqqpl6g9fyu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> These newer commands lack completion; implement basic support for
> options and arguments.
>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 538dff1ee5..a8e7c6ddbf 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3465,7 +3465,7 @@ _git_sparse_checkout ()
>  
>  _git_stash ()
>  {
> -	local subcommands='push list show apply clear drop pop create branch'
> +	local subcommands='push list show apply clear drop pop create branch import export'

Makes sense, but in the longer term, we should devise a way to make
this script and parse-options infrastructure cooperate so that we do
not have to update it, just like options are completed using the
special "git cmd --git-completion-helper" option.

In any case, will apply.  Thanks.

> @@ -3491,6 +3491,9 @@ _git_stash ()
>  	show,--*)
>  		__gitcomp_builtin stash_show "$__git_diff_common_options"
>  		;;
> +	export,--*)
> +		__gitcomp_builtin stash_export "--print --to-ref"
> +		;;
>  	*,--*)
>  		__gitcomp_builtin "stash_$subcommand"
>  		;;
> @@ -3502,7 +3505,10 @@ _git_stash ()
>  					| sed -n -e 's/:.*//p')"
>  		fi
>  		;;
> -	show,*|apply,*|drop,*|pop,*)
> +	import,*)
> +		__git_complete_refs
> +		;;
> +	show,*|apply,*|drop,*|pop,*|export,*)
>  		__gitcomp_nl "$(__git stash list \
>  				| sed -n -e 's/:.*//p')"
>  		;;
>
> base-commit: 2a3d6836805534f45cf545da7be25ce1c759c514
