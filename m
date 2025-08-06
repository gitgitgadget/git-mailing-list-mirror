Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB006220F29
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514277; cv=none; b=Ijt0ELUWUu8OTkqFXHqXPVJuKz5kfHGg5iTMXE3iAmhwV0EJfP8A8BiktgvyUEO7dmB7gUTazsJZCY4OPUY+C/u8lx07FzUjIDsmu5P8aEHvpNU2rS30Za95IG97QQSEeDLa+HYweAAexdz9aP7DDG9dUhKYaBx6KAXxd4oqs9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514277; c=relaxed/simple;
	bh=pSMHxUQT93J/ssYwpBXqXmSt9iSrclA0VPonRspzCcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RLV7uza83RRsPKAHwPYF11M077zkA7yAqvUoA3U7hC0ky8OuE1SAVxCResURZZCGn3huZ6z7kc3z5/1D7Q3tdOVWVIG0y9cAdzuKM8yZLILJ5H96jl2uv2pE60pJZz6pW9zgIdzPg9n26TOr1CfMGG7h3PfNjIuZ8yDyUzSRt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GDPlXWIf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lHkGcfiB; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GDPlXWIf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lHkGcfiB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1486F7A0108;
	Wed,  6 Aug 2025 17:04:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 06 Aug 2025 17:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754514273; x=1754600673; bh=r8cWOnqZOv
	+NodhrkjL1T7Cv/2D2xThGBegnYQKpr1I=; b=GDPlXWIf9RJyvuru6FBEdmS3Cy
	blK9Q+KGzBtUvC2emToqJZlb7urDn8qYSksT2vDT9Ajwn95sYUcwhUxugpqv5uSW
	hofT3xLu1dmocB8CrZZyCI1JgIu0tZ6OSm2nAh18dCyVZrVmZ10wmP9+7ngr6rbl
	LUO9Jta/Ep97LkctIWs2zpO8VCfJQTrKIS4M7/9yUtDV0CVJNF+D5+g6Nw6L5iaE
	S9nVJ/HmuQQhWLM9RzlgcUj+gg54qlMvAYxZxZw0kog1CAwHY0KR1cG6lHlnApdj
	WOOwBn6pp5PTCzxwNeobvlyLhRi6FU5Yq2EA+6ZgnrmmQlyrZF7rEkdLTBMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754514273; x=1754600673; bh=r8cWOnqZOv+NodhrkjL1T7Cv/2D2xThGBeg
	nYQKpr1I=; b=lHkGcfiBEJVxyFBcWQhFDoXREyAHqnKJOFimJaKSiqbFZKNjGGd
	9N8Wca2OGPgoGKFyuZb5HJlh+y0mYBxOxU9cMYAYy7SPnX+YHklD2Nrx8EIeaZWp
	oEKKSMQQ4pTcdkufacx0VRKMoE1RBxmYZ4fyj2P+wPO9auByHA2ttMKCRDadZLaJ
	Wm3Ew8w9PEGaOuvFq5s96zBqqE2h+jrmSW7YJxvgKJfjfHngye2JZBJaQWf48lVN
	93U/nQSNieEmy/r8aaxMeLLrK5OFDWlmZdUFqqGFhAxis1PQGSc4yvFlWcPxHs34
	EuOvurZqRlJ5E0OhAtRXhCqpm+L5l9Xe2bA==
X-ME-Sender: <xms:YcOTaB1wrEdq8dhKqgoG_w-XKI-0rpjx_YIQufxT_QvlAEM1q-HYLQ>
    <xme:YcOTaBgAI59WE3ffFX7eOaZMO6-N_2BdtxoK3ec8XO8Sz3dXwFX0HD8nqvlS8lNJw
    unEdUd9xc9CE_egrw>
X-ME-Received: <xmr:YcOTaBfosmjrj_SdMVYpW9hphy7Msp8CokcAzlCakUNM7dyu2_Zb6QdK7aYJPDyNxNGfC_6HGfrXuJk-u4EH1YPpLTLRTca1Z7UwsuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeltdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:YcOTaEmP0L-XtvQ6fQ307eFHbuBVnEgWQxDPFlBavcZ2shNqe1FiHg>
    <xmx:YcOTaKt-AY2AQEuvdJn17wWEAJ0GpXorNd2Muyf72t2_m6lI0v2bgw>
    <xmx:YcOTaK8jJxQbUwLp94r-6vlBWcBY5bhzJA7bVb82pQUwAtM5blujIg>
    <xmx:YcOTaMOVruucMHWXsJXYEZ5h96l6ApV47-uM7QDg5GCVpPPU8PoYug>
    <xmx:YcOTaBRsPU91-Q1vAeyEBzo8J81jU8NCgHUDpzT6HpcYObgNlas48ej8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 17:04:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: permit 'drop' of a merge commit
In-Reply-To: <37f6e34c-91aa-4e55-88e1-019d2e042df3@kdbg.org> (Johannes Sixt's
	message of "Wed, 6 Aug 2025 19:38:35 +0200")
References: <37f6e34c-91aa-4e55-88e1-019d2e042df3@kdbg.org>
Date: Wed, 06 Aug 2025 14:04:31 -0700
Message-ID: <xmqqjz3gtb4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> 4c063c82e9 (rebase -i: improve error message when picking merge,
> 2024-05-30) added advice texts for cases when a merge commit is
> passed as argument of sequencer command that cannot operate with
> a merge commit. However, it forgot about the 'drop' command, so
> that in this case the BUG() in the default branch is reached.
>
> Handle 'drop' like 'merge', i.e., permit it without a message.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  sequencer.c                   | 1 +
>  t/t3404-rebase-interactive.sh | 1 +
>  2 files changed, 2 insertions(+)

Thanks.  Now I understand why some people are sometimes tempted to
omit the default arm in switch() and allow compilers complain when
explicit case arms are not exhaustive.  I am not saying we should do
so, and I am not convinced that it is a good idea (there are cases
you cannot afford to be exhausitive, yet the cases your particular
switch must care about are multiple to make an if/else if cascade
impractical).  But this is one of the case it might make sense.

> diff --git a/sequencer.c b/sequencer.c
> index aaf2e4df64..9ae40a91b2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2720,8 +2720,9 @@ static int check_merge_commit_insn(enum todo_command command)
>  	case TODO_SQUASH:
>  		return error(_("cannot squash merge commit into another commit"));
>  
>  	case TODO_MERGE:
> +	case TODO_DROP:
>  		return 0;
>  
>  	default:
>  		BUG("unexpected todo_command");
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 6bac217ed3..34d6ad0770 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -2262,8 +2262,9 @@ rebase_setup_and_clean () {
>  	reword $oid
>  	edit $oid
>  	fixup $oid
>  	squash $oid
> +	drop $oid # acceptable, no advice
>  	EOF
>  	(
>  		set_replace_editor todo &&
>  		test_must_fail git rebase -i HEAD 2>actual
