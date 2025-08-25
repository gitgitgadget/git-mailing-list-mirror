Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF521C84DE
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141230; cv=none; b=cc1FhxJ42bY3aazJXSkVDCoaLGP/ZGHcmdjsz4QyRQWdKYjL9Jmylz7lQ5Apprzcld/DgREImtx5tXiI1Dd2Maaq2vz/xOVtq4HFSu6lVZaoyPLuvn0CT/FukGzlfUhIzhg7O6xhgE2ENPjPDPYALtcD2NhUJXEi77w7rNHdfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141230; c=relaxed/simple;
	bh=l85ao2FvGXFoP1+P8gVh2yrVy+iauwyLBwT1sdmb5AE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lo54C9gq5moMIvPFksZD3nAAvIQu0JjP7FWd6RGEaumc6npEG2ZaEhUeMVHfXL+iLfiLwsV6mPjRf6o33Un9MtyrWv4JiR71d3XhX/Aosu/g4vREjDagQP3LC7bTPqaqm5RSWbNw80/1eziFo/lqFm/aRpGnwuuWFWwycXSZN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cm3N0NRk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MgVa+tLP; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cm3N0NRk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MgVa+tLP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 890A11D000A9;
	Mon, 25 Aug 2025 13:00:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 25 Aug 2025 13:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756141227; x=1756227627; bh=B/AkR6oTd7
	AYlb1qkN9mQmngI2at/4ZAxkw/SxWGVww=; b=cm3N0NRkZyvuqDWKNiZKeUxpFU
	78q5vh7x+Cqx0NHyzPIwJj+JgA0LofbbYxDI0MqjqL+pHUklb5MK/aWH6E1DN3mO
	3XJnrpxY12gUcxI77JIu4uv5j2lusTLIPS4xDzRGshyAJd03i8K14JBNcAQka2+K
	I+UvR9pLq2hsMUHk/nlr6Z4okKBQP3ql0RnNabk0yFeHmb+sNs0ey5+1g/ZPZSkw
	JhBX+gvGJeId/Jq7hTKCy1xU+W/NeyE8fP0yMCw8LDREC5dbaeSpoRiPFpVU1ni/
	HeBgMXyJKUHrzpqmlYl2IBrQYqJ+tZZwFonJmPIBUJcoSbsjyUUEXArAx+OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756141227; x=1756227627; bh=B/AkR6oTd7AYlb1qkN9mQmngI2at/4ZAxkw
	/SxWGVww=; b=MgVa+tLPTEHe1+8Ka3v96s+5lbU2swZjxUF0ZjeTAHNgPAxJNx2
	8Uxwc89GlNhAY6hywhqs5RSopRjfFbBDDDMfoSa98/1hHBAMHJB4gD+GWmOnnue4
	6Cd8HcKi2q7NqqaLSsw/w51rf3LGiHrHl8cb5o+bim7oqNNjbe1Kr0d0+8T5yhMl
	OnuXMFhn6Yww7Y1MTLB8DR2SbemkOUKOW0zImP6kEpz0fN2/wl2WJk46eIrgvXSb
	KbM+vK+46ZP0qznr4IAmf+jTYbT6kaXLpwHyWhnoGQSgwfPOylA/nnonaORA9Tro
	YNSeJsjh59JrEs86mDdjq5/b7KtskGOppPQ==
X-ME-Sender: <xms:q5asaClUWBx5fUWNR3fe6z1hh-M9J8l3fiufdug233yZkyDgwd-DHQ>
    <xme:q5asaCQGyNl7VhvedBvqWDlx_MMNh-TSNvxgL43VaKdPrpMU_pr8quqPnaZqILWwu
    CQGQRwsUVC_6ArgSg>
X-ME-Received: <xmr:q5asaBFlzDQ3CkHBKpge7TYQXnnboziGz7InBmek-3GKNURa96LralaQwVLEtSoujzE5p7a-Im9NesmtflVGr2hi_kooHPP-T7FPxs4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptg
    grrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtthhopehnihgtohesfhhluhignhhi
    tgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:q5asaHEd9m3hv0mpkRobt4wsYX5HaN58AR4LahEt10bL3vaU1N54bA>
    <xmx:q5asaPQtmqHpFABFD00BrFtjQy16HdfZCfQz5udI6aCwP6zLNJFFag>
    <xmx:q5asaII_51ZApofOL4JKFlzM38BNeHMmqBadUFo73ZvgX_f0R1neuA>
    <xmx:q5asaKbaKgrAQj9WHOe1t3GYGcG8cxo1eQc7TL7qbDgrzCPNPaY8NA>
    <xmx:q5asaLMN5qeXBEH6UuRE9LhoAN58jc_Av0Q_5z5gnPHZSLqbFfcV_U9x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 13:00:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
  Nicolas Pitre
 <nico@fluxnic.net>,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] progress: pay attention to (customized) delay time
In-Reply-To: <2d56de10-f829-4bc8-9c76-76eab6b137ae@kdbg.org> (Johannes Sixt's
	message of "Sun, 24 Aug 2025 17:31:18 +0200")
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
	<86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org>
	<xmqq4itxvi3z.fsf@gitster.g>
	<08f405a6-fd2e-40d7-850a-574356b4009e@kdbg.org>
	<2d56de10-f829-4bc8-9c76-76eab6b137ae@kdbg.org>
Date: Mon, 25 Aug 2025 10:00:25 -0700
Message-ID: <xmqq349fs5ee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Subject: [PATCH] progress: pay attention to (customized) delay time
> ...
> until zero is reached. Due to the frequency of the calls, this happens
> without an observable delay in practice, so that the effective delay is
> always just one second.
> ...
> Since we have not had any complaints that the delay of one second is
> too short nor that GIT_PROGRESS_DELAY is ignored, people seem to be
> comfortable with the status quo. Therefore, set the default to 1 to
> keep the current behavior.

OK.  This is documenting the established behaviour, which makes
sense.

>  	struct strbuf *counters_sb = &progress->counters_sb;
>  	int show_update = 0;
> +	sig_atomic_t update = progress_update;

It is somewhat misleading to use sig_atomic_t for "update", which is
never updated via the signal handler.  It confused me a bit during
my initial reading.  If it were

	int update = !!progress_update;

it would have made it more obvious what is going on, at least to me.
In any case, I think it is an excellent idea to clear the global one
first ...

>  	int last_count_len = counters_sb->len;
>  
> -	if (progress->delay && (!progress_update || --progress->delay))
> +	progress_update = 0;

..., while remembering the fact that progress_update was originally
set or unset, and consistently use the latter in the remainder of
the function, like ...

> +	if (progress->delay && (!update || --progress->delay))
>  		return;

... this one and everywhere below (omitted from quote).

Thanks.

