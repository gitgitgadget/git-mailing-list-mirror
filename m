Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95F233947
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782712223; cv=none; b=IZcUgi4y/kq4VFZvZIaheIZPtW/Sux9P1YGimrJJIbbBZT1mRi/wtH5rTJLmcwS6w0SBSGk6hSwsRs5ETlWKN4rjk7+tl8bUzrk3bqlWu+QUc1HiVcP111CNxaQOTCwdE+w3KanSfDXnC1rlOK6fr3s8RXuGg7mITRw/4hwRkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782712223; c=relaxed/simple;
	bh=Jmt2rdzeFQQ9Pqn9kgiApPowYvG/K4GW2ma8SIzaZeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TnbywSR9wx+1o3aR+qyvoX35eKIQbDw6GZOWMftGtoPYn8Jlco2SaETUQmGAi2GLMMPdYFHAm35kW77fGni5Nb0zLk7qHf/t+lJcpENQZhVhQnFRPk9r7ETczYp8RMzK42lHUPmFB2Ey7MdFSyaUcMgXJRuuStZrbht/vBsL304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G8pwFUvz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JzXr2lSD; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G8pwFUvz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JzXr2lSD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 023F17A00B8;
	Mon, 29 Jun 2026 01:50:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 01:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782712220; x=1782798620; bh=FagxXGOwV6
	iTwoh5W6SVMetDsYz7pZlW1CemKlc1FOQ=; b=G8pwFUvzp4T3q6wM/9sg7zRD5S
	68TyroM5nJ4v0REtMG2ZPZW8XuFHYwDXmBFWnWB4kUMLSrCoSibdMx4QuNZrva08
	kTmcWncfS6diLWUk/o5Fla6RZJMPLlPI31pDAbj8oM+KHyuj+6Xo4v0P9lOC5rry
	0FKV9EOxUpIQbqZ3vdjjq5UmrL3XDTp9owlHL969RT5a//JoGrfIOFBbhzR0YHCS
	mvdMX34kUKDftS1wCF/oaHe8JiRcmL9X2npPz92YqV/4VJZA0OjodAL4LsPKoGO1
	DymtqX1dWT5WG8sHbVMgVNQ6Ye6x+Gl5ugF4rMHX5edpb7T3W61MPBYY/X1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782712220; x=1782798620; bh=FagxXGOwV6iTwoh5W6SVMetDsYz7pZlW1Ce
	mKlc1FOQ=; b=JzXr2lSDhxkrHSbvkBb4nOAS5YdKkzHN+2u7wKbSeNonVoru7nj
	vdOyjTZ8erTWhdHiw71RemDuAm5zh/hH2jb3F2Z+fu7Lz7hdG6KxEqbuqfeYPPYX
	16hGLenvPvBKS7Kje1uXeeoFiarMOnn1ys21fdOG1J436MXeTJWTNr9L/t51P6j7
	MWHLXHyU51IeAc3v+pPyE838kU71Suo27/O+/6ZEZ0eBxtjNqxYefV3YlreWiNLa
	GBbKpKPJgc3rdRgNl0knMLTv2nRQlDW1gUO2jZDn64iq3IvBPg9HG8zMHRZ95Qtp
	RwLTurlFK+fvZ0EMk6aeG+/CskqGqttfI5A==
X-ME-Sender: <xms:nAdCagw09LdMkciz79hTzWcxGa_R4QwBwanVgro56DetTMfFHDQJgA>
    <xme:nAdCarSx-3-0rRcHwA6w_EQb9ci3ox1lRkdgbB3MlMWd6TZAX0GB9zGWuQv--6SMv
    kHTpoKUTTVGtVumqChVzMH01cwnZmLaM5KQXLnKL4oRIzoGk-LYtg>
X-ME-Received: <xmr:nAdCanVvrPeC1DNxeibgaTMqTQTuKE2a81t6KiQBdZyNY8qlNw-wsmrD-q3XGbuqj-7OwWTnm2M0emlB-btkiEhClKxtqr6rZNfteb4>
X-ME-Proxy-Cause: dmFkZTFBgu9jWG9OV0YU/mZCxmpsLztSr51Ek5pnwdw8AGoe2eCz35HBK0ByLtVSEmZIgN
    ZDbUMImfNrsuGwezmNhZlGxlkllDhQKMOyXSidbo6yRMFkAlXlmLfDCd/K0yQX96ToPbPU
    yteQneNVQTX/dGu9zC4aJxZwc9zN3p2R1fjTj/ijwrnSrygS7mwHS4Nuv5paTs3eP71B6Z
    xG2K7KI0/oZwFrG3JXCHpRnE8270kEiFL7KvCOT/zg2sNJjHPm/X139uXFWVhLHT1xXT3G
    pGPSDCYU5U4P8Zz1xpbS2Krtdx7+448DSg67XopqL3EnhcU/0C7la5CTbJpK3okV/FJ8ra
    0Ra6UlLiyMoNzPBUZ7qHoAIma8kwhEY5FAOHaJTCWsYSpeA7Ikwf8fxzmyzyTXbeCDh9HM
    LIuDgZnMH7jht5uxFVlmgbokgLiz+kfSGcxLS/v02gB3ivfIugQ7ZtBZRIHkFXJie8QqlM
    hyX4MVmWOXLGC9wCo16HIc22UlV2OHKkRJUPT7yZHhrNFlSGlLAyygzp+1prZALcwAaM5g
    pAia8f/Lz9U40SkcDxC5+uIZFEn/u/MzAN/1hN5x7WB5OCnKaXHuptbd4kFgDbMMFVevpW
    mKcWE7VBOY+2cQd34pfgBmjoiGszq49SUYX9jt57fGzA72QLvEYixpFTydkg
X-ME-Proxy: <xmx:nAdCatagim_5gBcN0HISwlJCjvRWREXnkZhXqyd2Fx7mG_MdNZYxhQ>
    <xmx:nAdCat30D5EOGKr5tghyh2C_ERLBoBXMr17Y-za0SjKt8YtPR5cTkQ>
    <xmx:nAdCavgdHMrFrsoHp2L0xXTtWerTvqnw3eR6-_bb_gLLpwCaRbL49w>
    <xmx:nAdCahamcInujA9j2nu5uy8lqrI8jLan92O3K3PckbU8tRqMTzFuqg>
    <xmx:nAdCau2Z1BltOWOAFaeZR_U29WA5YfxGv3zx8syTmmVJftqAI72woRxn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 01:50:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v6 3/4] history: add squash subcommand to fold a range
In-Reply-To: <811e393ab48e2f79e6f8c78d883a5b92311791b3.1782635349.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sun, 28 Jun 2026
	08:29:08 +0000")
References: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
	<811e393ab48e2f79e6f8c78d883a5b92311791b3.1782635349.git.gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 22:50:19 -0700
Message-ID: <xmqqse65zyhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -11,6 +11,7 @@ SYNOPSIS
>  git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
>  git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
>  git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
> +git history squash <revision-range> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]

Not your fault at all, as there are existing violators but the
gitcli tells us that the canonical order of arguments on the command
line is to have dashed options early before any real arguments.

Seeing <commit> followed by --dry-run, --update-refs, etc. with the
existing subcommands should also be corrected and this new command
should not spread the existing violation by mimicking.  The revision
range (which is not just a single token A..B, but the usual range
notation that rev-list takes, like ^A B..C) should come after all
these dashed options.

> +The range is given in the usual `<base>..<tip>` form, where _<base>_ is
> +the commit just below the oldest commit to squash. For example, `git
> +history squash @~3..` folds the three most recent commits into one, and

It is OK to use in your personal development, but in the official
documentation, avoid cryptic @ and always spell HEAD (except for a
single place that explain that @ can stand in for HEAD, for obvious
reasons).  It is extremely annoying and confusing to read as these
look so similar to reflog notation for the current branch, e.g., @~1
vs @{1}.

So "squash HEAD~3..HEAD" specifies a range of commits HEAD~2, HEAD~1
and HEAD (three commits), these are squashed into one commit on top
of HEAD~3, creating a sibling to HEAD~2 whose tree matches HEAD.

OK.  Looking good.


