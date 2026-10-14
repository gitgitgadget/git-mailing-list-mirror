Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC04749F6
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007103; cv=none; b=KIOl/QETUHlwBpfz9T5N7fl2YQDED3UUA9iOagzw8lcEPjQzUrBx2MOK87qW8mdjQY6fjQiDIhKd3hqaRewMS/hmo0qiBlRn705GphrbwVQ4iRDGRd6DJykCHhx7yDPdwB3edpWHHeLNK03BTxKXNy692X1Uj1P/p+bnE0EFwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007103; c=relaxed/simple;
	bh=3HqzPbLXg0XAZHk7B3rBHy/T9g028Ue6KRJCgJA74N8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kTx5l3to1QQnedr+gbjLSDiqOTO9ZdA8xkcy1oSmOBuH06SNk7ZMGXDbKnFWNejWyeYWk8bJjBCYcLMTRyzXJgZOrd0J0UUWqE2lxXImoLJMYnInqOx/s/0qs3+ClOMG8dlvxU0wiTgVLqU1zAa1Ym3pbm3TDLZeYtiZwZDLUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J7JAjlO5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wOlTZAbC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J7JAjlO5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wOlTZAbC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4EF1DEC049C
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:45:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 14 Oct 2026 15:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792007101; x=1792093501; bh=1ROz1h7Lr4
	oQViFaVHce7kC4QED6CdahhyfWSusifks=; b=J7JAjlO5bzbXOtX8OAXRcJOP2Q
	DIrILC34MQPKJZYWHLg7ryQmiyjF7+QvmBix6aR0UGEh+KynOqSz6swKaWxoJhF7
	r3TNf4zHPDfAVBeRlAUkfAqDPaNlOjYSirXdlwkY7rSW4OMOXwSaHu6cu7uKzTUk
	7ylLFIjp9jz9mUvgt8RXp3RbShayIJ9rtMxxXXO5XEzduZQlghB3vmCpcTwrI8Wo
	GRv/lfmjt3E/smIL9Ehrqxa7fElS2uRbrCefOVTIz7a25hXZQph1frmzjTp+0SDH
	HYbUY/6PjrWcUiwP1644APYkHZ0bUcVtHbYVAHeN9nAQfN6iXdBAY7koGmUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792007101; x=1792093501; bh=1ROz1h7Lr4oQViFaVHce7kC4QED6Cdahhyf
	WSusifks=; b=wOlTZAbCEvdqBzU9vQZ9fGxyEdvtBYmfB4GlHj4vhXFshOPxIJv
	dGvp7ZQKBPb/c8Sc4KsSzmYfwv0JMMsdCbH5dvrR+xSHgNZcqx+z8J4xUmN0SCG+
	KNXMN9ujAbob0u5qOUi0PXzFwgmCq/BB0AdyXPiMN43QD4V4Hwp+CYlXf/OfSNqh
	Bw6luSFJBBX7RhdFBsJ5ZRZ0FKxf9ElgoIjpyDHFxkLbYYUVpARrMoNlNpTmJ9Dg
	O9PkdjVRNoM5K/9bxcR29qRHJ1D01/+JsZFVlCKnrgTroAXYmUDt3XOXaWoJlm25
	Ww1aQOm7FDEikn1gx8i8AglGqv0MAJy6IVQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792007101; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ebpPzmj4hD6qGMgUf5qlvNzPXTeWLvT66NP4eiRmgShztoh
	vZ23g05gcLqo8wqr5ZQesDzrrfllMPaFPjfJhfu7/C/1NOXQ2nKqmdA4fd3ukUc9
	vK12N/2d4k6h4Q8jOPZ4GzwU4AyCBbI7l04/KptrHZKNRbEF9RTwlf29qCJ59DIc
	Pfms7ChxEE6M/g4g1/6OVct2R/jG/dIujKjxzVJjlu61nv/lEzmJfUKS7sBiV5dd
	2KNeUiPsYhXPv/8ftHt7F+NEwjWomiM4z1cB71XZyRPCm4zkVsUpffuCLyVTCrjj
	Id2DgsLGJY0JvgUefssfEPNgbCx9dzxp6WNDJvw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2hwETmFg1C07KXmCDbQHNCsgeknLqSm/z3V7eHyrpaE=:3HqzPbLXg0XAZHk7B3rBHy/T9g028Ue6KRJCgJA74N8=;
X-ME-Sender: <xms:vNvPagjH1XHGnbzkUaACH1fcrzZo4TlQf9bwHK14Vxx-zqM8RL9KVA>
    <xme:vNvPaqgY2HmCnrgwiwyEtqpGXbeB5jc6z1BFie_1T3knB29DThgmVeepBdu1GOI8Z
    dqyaTOQ18374zDMkIoFbmFw3Cf0iU3tf312PV9-TjyHkXlMgZr0gs8>
X-ME-Received: <xmr:vNvPaoIsH6e87aUxbcS9PbWIqAElsgPSR8MZq7ZCG3F2cSZRBQjjR_mz86o4W_ldQCsRS139MLVt9taKsCa5N4QE_seawCDDjgr4>
X-ME-Proxy-Cause: dmFkZTEv7YoFgMXQrqlICXIOo46pLQmZnxgWwaQH11XEmAajYuj/3qCYJg0YmTIvlMG1q5
    rtZXBBHfDq6BFJzsZ3374S+YpPkzJaTldv46Fry5PxVRQ2rn8ylcCBsH7FIbOK1BqVAMsz
    uXq78tRpbLkHsvImV3aQX+73Ejfh/MC0RqCbTW8hQEDrVp3BUX4TIbEPDf2Y8eKq/Z2DbM
    2At6RRTMg5fJI4xmN/AudEWdzc4tJ91lKOlRu1lmh/UqnCaEv7rXok5mB/Evr4UbrCLgFa
    pwSTVffubDYJFapKhRTiCfgtnZKdawPTN4gZt4glPDHuTpaMXGwByqVf/KYPZaqF5atIKO
    Nk6RGLIe9a0pajPm+V3ulH/nbckNS8sNy9ArYB+gndpJrFeEoL3BBSa2jV+SWVqv5T6RKL
    eG2sIRVxhjCx5IJ+/N3P5z+czoRfayB8+QPcrMkOOJ72C7qGR+7bRnZd/KkHsFYOWBgny7
    46c6hurOpPW6/mcz7iiPFeuZ7+kXfnYfR5x0aikFdVhSfGabyuwrBU+rXkCyHxPEh2uiZS
    lwDmzDEnpITtAkxNJoxf9EPsPArbyQVYFbSfPSxpmKE3tHovbj8aqMcyljdfL8CN+FapDb
    nUiuhv4x6VPARc/aFE6dqip2H0L7xF12DhD74MU6NzZJCe+5bIrIWm+ZfiPA
X-ME-Proxy: <xmx:vNvPahEZF_L8TCoyS-Fo6nhVlVjEYiafam2G2Xmbu_sVKwqQoVYQBw>
    <xmx:vNvPakQ6QAQ0AQnO0uFyW-BfQMBYNaXVR45jv6P9v_FngX5x6uFu3Q>
    <xmx:vNvPalco0ynqjrEAwr8avOfNerPJkVmBRsmmpVytHHnIuLAGcY1Y3Q>
    <xmx:vNvParqxHXAvutmZkWDTRQcQdjF01q3roM-z56S1qPCRz_ED_hbdDg>
    <xmx:vdvPasXBm0rTdS5fjhq66TD652Nz7GW6kibmR7QBU103dpbDTA3ZGln2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 15:45:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] sequencer: don't clobber HEAD ref name in worktree lookup
In-Reply-To: <20261014165824.2214234-1-andy.koppe@gmail.com> (Andy Koppe's
	message of "Wed, 14 Oct 2026 17:58:24 +0100")
References: <20261014165824.2214234-1-andy.koppe@gmail.com>
Date: Wed, 14 Oct 2026 12:44:59 -0700
Message-ID: <xmqqik34qd6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Koppe <andy.koppe@gmail.com> writes:

> add_decorations_to_list() skips the branch that HEAD points to, because
> the rebase updates it anyway, as per aa37f3e1d89 (sequencer: ignore HEAD
> ref under --update-refs, 2022-07-19).
>
> However, it keeps the name of that branch in the static buffer returned
> by refs_resolve_ref_unsafe(). If another branch on the same commit is
> checked out in a different worktree, branch_checked_out() overwrites
> that buffer. If the current branch comes after the other branch in the
> list of decorations, it gets a "checked out" comment in the todo list
> instead of being skipped, and the branch whose name ended up in the
> buffer is skipped in its place.

So obviously broken original, so cleanly corrected.  I very much
like it.

Will queue.  thanks.

>
> Decorations are processed in reverse alphabetical order, so this depends
> on the branch names. The test added in 94304b9f48e (sequencer: comment
> checked-out branch properly, 2024-11-25) happens to trigger the problem
> and expects its result.
>
> Fix it by using refs_resolve_refdup(), correct that test's expectation,
> and add a test with checked-out branches sorting both before and after
> the current branch.
>
> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
>  sequencer.c       | 11 ++++++-----
>  t/t3400-rebase.sh | 21 ++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 6dae43e4db..c672b6e127 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6577,11 +6577,11 @@ static int add_decorations_to_list(const struct commit *commit,
>  				   struct todo_add_branch_context *ctx)
>  {
>  	const struct name_decoration *decoration = get_name_decoration(&commit->object);
> -	const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> -						       "HEAD",
> -						       RESOLVE_REF_READING,
> -						       NULL,
> -						       NULL);
> +	char *head_ref = refs_resolve_refdup(get_main_ref_store(the_repository),
> +					     "HEAD",
> +					     RESOLVE_REF_READING,
> +					     NULL,
> +					     NULL);
>  
>  	while (decoration) {
>  		struct todo_item *item;
> @@ -6633,6 +6633,7 @@ static int add_decorations_to_list(const struct commit *commit,
>  		decoration = decoration->next;
>  	}
>  
> +	free(head_ref);
>  	return 0;
>  }
>  
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index accaaba4d4..0e7ef33eb1 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -483,7 +483,26 @@ test_expect_success 'git rebase --update-ref with core.commentChar and branch on
>  	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
>  		 rebase -i --update-refs base &&
>  	test_grep "% Ref refs/heads/wt-topic checked out at" actual &&
> -	test_grep "% Ref refs/heads/topic2 checked out at" actual
> +	test_grep ! "Ref refs/heads/topic2" actual
> +'
> +
> +test_expect_success 'git rebase --update-refs ignores current branch with branches on worktrees' '
> +	test_when_finished git branch -D base current a-topic z-topic &&
> +	test_when_finished git checkout main &&
> +	test_when_finished git worktree remove z-topic &&
> +	test_when_finished git worktree remove a-topic &&
> +	git checkout -b base main &&
> +	git checkout -b current &&
> +	test_commit msg4 &&
> +	git worktree add a-topic &&
> +	git worktree add z-topic &&
> +	git checkout base &&
> +	test_commit msg5 &&
> +	git checkout current &&
> +	GIT_SEQUENCE_EDITOR="cat >actual" git rebase -i --update-refs base &&
> +	test_grep "# Ref refs/heads/a-topic checked out at" actual &&
> +	test_grep "# Ref refs/heads/z-topic checked out at" actual &&
> +	test_grep ! "refs/heads/current" actual
>  '
>  
>  test_done
