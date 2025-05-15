Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7941BC4E
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314485; cv=none; b=sgaZ1dd7lhCxnulCqd0hTm2Eg7BO0OOaaOt+z2q/++YfnyRoCsP9bwwGqkomVqwnDlIt9Q16TeIjyh36t7KYcPXyc6SDEgDbWs5o8uA3tYOxAJnSXhm9tFLhX6XUbOphvGnHrk3+qIvrTzTLCL50XPfaYXjwqQhw/id0dBR+p2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314485; c=relaxed/simple;
	bh=bXvAw9W+r34JqpIC5c5X4gbtrWg97UYeBJtmUTx2UxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iB3YG/sQyx3Pbqnl83/nq9PklpJtn7/eJWK+e/tXaS6ZKVw9IaeAade2+PacVdcMwhdihf5C9Vj8XPm9F11XYHzzL64Fq2z1Z5axoG+Dq+TWg4tLxUpZ+rbL04zk82y9Z1/ydwSW5kvKj0ULWlyLF1y3NfkxoXatJublmxTockY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sn8H2eqe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bkZYoBZC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sn8H2eqe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bkZYoBZC"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6492B25400F4;
	Thu, 15 May 2025 09:08:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 15 May 2025 09:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747314481; x=1747400881; bh=wJlELQC+h5
	bPTlXLV0rq2t4QEtlIrbJP+kesg4R/9Aw=; b=Sn8H2eqeVAXcYirEDWzWgJFSgi
	lmn7/UHzDvebDmEZLDITv6y19iVIrj/aSw2LQtd/zp7TYC+MxL2tbd/GszbwTpeJ
	fUJrExIBhEh57tzs1eIyUTbD0fYl/2d3/VX1aZN35GKhwWf99JUQ4TZCuxxcJt3J
	2psTWNL2qFoG802fFezcBpwt65I9M8tHUz8MthxVtfrNSBdbbe0V73BYYFmUVheE
	MR6HYE44oK/lWWDzAvqX4nA7gxYQItJyNpx9OOgNU4vfI8StIQTFMyTsI+bo4yKs
	5GyCvVQpdIShuH+97sHrBedFg2/oKam+/gEfpWbATv9UNAEzpoiXlgdl/iDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747314481; x=1747400881; bh=wJlELQC+h5bPTlXLV0rq2t4QEtlIrbJP+ke
	sg4R/9Aw=; b=bkZYoBZCj2ii2PXc36L9Pr72Fwcq7khDw61QuNJzKRxGIjkMRVm
	BOvjX3OWNwtrVOg/rckkNBqC53xcsKm0yxjMRjZa3XVly4Z/CG3IBLhuOdx3UDHW
	6jQUccG79VKOGbwmELJE5aZGeanf7FgwHdqYvKpKM801ZvhbXZ09VDS29luHlQCl
	0TsdRYTzH0f7G5QvWMeVsqPhPSkZcMCzTCyDOFwWh71js+S06zoTNtVzqOWihHUU
	SvXq7xUOwRlmfRdDB+bx1gJRBDpsupCtGOSyNNtgf7kZmPv1RlE0ZWOHAL75uwpg
	bU8tMxOWGaQAr+qrqSJ8P7UJSCpQC9o+q0g==
X-ME-Sender: <xms:MeclaCKOsAMZe9Rja2uypTEbHrSiwVBXl1-BljGxyr13IEUZWW9rsA>
    <xme:MeclaKIsLf3-jZAK4o7b7TIXgR73Y_X8kXHqNhvLW4ZoHu28sWQCShmjKTDFcHmhI
    VhglI0AOTtmla7ixw>
X-ME-Received: <xmr:MeclaCvlDfvy8QB4YEnfjkNb58TmBr2NjZmgdfKqjk-TcznVIQvJS_O4yfLlxgdYh5nuR-QQwCAHIpSpr2yO7hNAv0TgKEh2itQwApw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MeclaHahVjOnePNAAvdsMP1F7mj7VQyVVBgOfP1zUxY_kQUY-C6orw>
    <xmx:MeclaJaH_hn4jG0Or0hhBGkML0_xjslb47tPblZiQYgVf_QmSU8SIg>
    <xmx:MeclaDAbX1LSc2Q9wh9oPIPyJgK-1YglWG1cqae2lYMgBScZazzcbA>
    <xmx:MeclaPZEyaeqJGM7LxYtC1OuTxRKcJcVEAYJ1jhHdcXkZ6hhZ8Tbjg>
    <xmx:MeclaL49Q0APGXWNxsbx6YlIG9mcqfbeKC8eqI-kcbYfP7uvrld2N1Vj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 09:08:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 2/2] merge-tree: add a new --dry-run flag
In-Reply-To: <f11824317a8050764fe35698039f863dd842b0c2.1747182288.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Wed, 14 May 2025
	00:24:47 +0000")
References: <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
	<pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
	<f11824317a8050764fe35698039f863dd842b0c2.1747182288.git.gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 06:07:59 -0700
Message-ID: <xmqqbjru3tu8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +--dry-run::
> +	Disable all output from the program.  Useful when you are only
> +	interested in the exit status.  Allows merge-tree to exit
> +	early when it finds a conflict, and allows it to avoid writing
> +	most objects created by merges.
> +

OK.

> @@ -583,6 +593,18 @@ int cmd_merge_tree(int argc,
>  	argc = parse_options(argc, argv, prefix, mt_options,
>  			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>  
> +	if (dry_run && o.show_messages == -1)
> +		o.show_messages = 0;
> +	o.merge_options.mergeability_only = dry_run;
> +	die_for_incompatible_opt2(dry_run, "--dry-run",
> +				  o.show_messages, "--messages");
> +	die_for_incompatible_opt2(dry_run, "--dry-run",
> +				  o.name_only, "--name-only");
> +	die_for_incompatible_opt2(dry_run, "--dry-run",
> +				  o.use_stdin, "--stdin");
> +	die_for_incompatible_opt2(dry_run, "--dry-run",
> +				  !line_termination, "-z");

Ah, I missed this one.  Would have been caught in the previous round
if we had test coverage for incompatible options.

This round looks quite sensible to me.  Queued.  Thanks.
