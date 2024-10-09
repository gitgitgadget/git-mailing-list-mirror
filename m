Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83F5684
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499582; cv=none; b=OvfQ7xTAX9nxB6Mt+1ucAypigjpHz9g9JyHQkbbVxPlri4KAxWDQ3mhSAeg4pd65vHoP0OAs3Q1qWkAAHlTr4hhOo5yX173ctJMlA+SvFAvvH/6yOBIZvDJi2SP1H7KyadNWw4HxJRzNhFc9VEiHIXU/6ffdlbYQy0vvQiD8n2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499582; c=relaxed/simple;
	bh=hS4Jneb5g4QqX4zUgbZi0CuuQZIEqjZ7kU9rSl6TR5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LknZyA7OfE5kmeR4hHATxht58OXS6x5pu1evu1YDaADSEczkK7V+5Rx6iFi5bqn97U3EQpuCqJG9+WB86A7cI9P5udygXj2yM6an0Cy8ufvS+Bhxx4mNxBQaeevGkCLHo1tVzjQ3VyKxfO6CABxvaaLYQqydV2QQ1RmIlXRJSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jNnGtybs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SiGMQWgm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jNnGtybs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SiGMQWgm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16E20114018A;
	Wed,  9 Oct 2024 14:46:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 09 Oct 2024 14:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728499579;
	 x=1728585979; bh=PhS+xrWoStx5Hgfpciwr2SR3WvHLxQI+8i53kJNXwDg=; b=
	jNnGtybsKZZcuwPbO/lNvKfLdWxskMMJkgaz1/Ofjv4lQXSAy4gL8NZ0F1APaNyT
	gJleXezY9SXSTSn5bS+I6TMv7hh6Yt+SSqgaErnYE6z5TXPr5QOwhSDQYT1ivoPn
	h7nCNPbGgYRMu1GCrSZCpQ4qtnzSmOmoPo9GwACmdJ/E5dTCqR77XdWk4Z/F0Vz0
	RE77Olpv3uooE2wK5KYyFEQXOBUOoRXbJ2gKWKoJMEdI9lD4UhWVDXmYEICcwxES
	jJf0RMAIF+9VssHflb6OmoPeoUcUeTLb9s6lSlsm8yGaxj+5DzXXQxNLIw5yFeCu
	IDOqxOaemtxTNRpSUAJWCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728499579; x=
	1728585979; bh=PhS+xrWoStx5Hgfpciwr2SR3WvHLxQI+8i53kJNXwDg=; b=S
	iGMQWgmP9M2MjvVfmEGaV7zaMeoqCoZlmsTq/qRbh/vgqddZRyvMmt1/ZNZzh2zi
	5xUTmgoJHMgxGi2p9AVMy4rDERA7fzOR8B3u2pIPQ7jqzWdCxC7JCnPgF+50NzVd
	tNOZ1csUvYBAXuYOwp36FPF1AHjwQXW+92PhVskMTImUtK6mbSD7TOMWhI76E4m9
	RFXK4j3ETXwtxF3mr2pu+UtrqNf9K/2nuiIrp0UcF0itiUXPimk2cc/Dfsp9pa0U
	u67Lh5LWpcdN4Rr/hb7MVHaqJZ5ePEVPtwergZL1ROeF3hjjzucJnDmNqfafv4aN
	Vyn9d40qzBRSh3Vw5i9Rg==
X-ME-Sender: <xms:es8GZ1BGmiBpJH1FVJvC9bWSfaJpFamKbM4b1Llsc4NsoaoOsZLqUQ>
    <xme:es8GZzjskfYlZCJaGj2eglxW-SFhQU0bN-Gn9qHrghx_rFaNKR7FwELr5fmckTn-K
    rEx5EQZPVa_Vgm9HA>
X-ME-Received: <xmr:es8GZwk8XGGvbOlitPLlQQh2lFtDkJY2jQ7joVXyfpwhxkw0T0NebWsJn1kmHp6Q9Nbq2gxeB6th3fQiNTdiBZ_JXzJU42a-j0ls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:es8GZ_wRZb29H4F79vUZ26esiyN8ObbDlinroXj1xW-AnhhwbhSa7A>
    <xmx:es8GZ6TUxMr3BpkZKiGCDSOatmO5twbTJz36ShLeLS9Wck9dyvrUqQ>
    <xmx:es8GZyZ-8OzmKIgkGyW7i4vQnbH3EXYsYSAAzi9jgjlsktNoJ_5v5Q>
    <xmx:es8GZ7RrYaUFPmbvfh8IVqssJ1ZB9SIzi7cCdUAdrfITaFTYgiwNvQ>
    <xmx:e88GZwM9aYXugEMC8b2QwbxOfTPFxkVOzbY8upkJ8Ayu7U_JI2uQMW20>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 14:46:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH] checkout: refer to other-worktree branch, not ref
In-Reply-To: <259fcbb61f13873421d50df77f151130fdbf0166.1728494795.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Wed, 9 Oct 2024 19:27:58 +0200")
References: <259fcbb61f13873421d50df77f151130fdbf0166.1728494795.git.code@khaugsbakk.name>
Date: Wed, 09 Oct 2024 11:46:17 -0700
Message-ID: <xmqqh69lru6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Notes (series):
>     I also change “is holding” to “is using”.  This has plenty of
>     precedence:
>     
>     1. The code ultimately calls
>       `builtin/checkout.c:die_if_switching_to_a_branch_in_use` which says
>       that we die if the branch is “in use” by another worktree, just like
>       we do here for the new description string on
>       `--ignore-other-worktrees` (c.f. “holding the given ref”).
>     2. `man git checkout` uses the phrase “in use by” when talking about the
>        branch being checked out in another worktree.

Good to see an update is done with such an attention to detail.

A branch "in use" includes, but is not limited to, being checked
out.  For example, "git rebase" may first detach the HEAD when it
goes to work, but it fully intends to switch back to the branch it
rebased when it is done.  It does not want somebody else mucking
with the branch from other worktrees, so "checkout" or "switch"
would consider such a branch is "in use".

>  --ignore-other-worktrees::
> -	`git checkout` refuses when the wanted ref is already checked
> -	out by another worktree. This option makes it check the ref
> -	out anyway. In other words, the ref can be held by more than one
> +	`git checkout` refuses when the wanted branch is already checked
> +	out by another worktree. This option makes it check the branch
> +	out anyway. In other words, the branch can be held by more than one
>  	worktree.

As you are updating the usage string, we may want to unify the use
of the same word, just like the original said "be held" here to
match "is holding" over there.  Perhaps

	... branch is already checked out or otherwise in use by
	another worktree. ... the branch can be in use by more than
	one worktree.

or something?

>  --overwrite-ignore::
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 9c30000d3af..c449558e663 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1716,7 +1716,7 @@ static struct option *add_common_switch_branch_options(
>  			   N_("update ignored files (default)"),
>  			   PARSE_OPT_NOCOMPLETE),
>  		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
> -			 N_("do not check if another worktree is holding the given ref")),
> +			 N_("do not check if another worktree is using this branch")),

Good.

>  		OPT_END()
>  	};
>  	struct option *newopts = parse_options_concat(prevopts, options);

Thanks.

