Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BC1CD31
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728254626; cv=none; b=XlkEk6VnxvV7gyOnlTDSK2DaOaEN9iFuaKPbuG2gkMHGd70qKg0WwODPW1wtL3cXkCku+R3PUb+IwCuUxlaXmXA/lOzeVauNj+T577U26e2GGmixMQsgQ3FR4fq/+4096CPGwSnBlb92iOTH0Z7g1Jbkr9RS1mK+ZZfyqAhwnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728254626; c=relaxed/simple;
	bh=uiGmOgm2Y9AuiTyr8UxuKO8DmHe+K50AR8QuOtPL8LU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BbzMY7C4ba+9y/GahuaxnTQ8bev82pXbHMvtuLks22EirSHfCQ8AkBbWlxWb5mP0BQmj26KFFlroU0+ijEr+JVFScNCauP3cffOrGFSFm0zpeix2ZK+GgOhgFdtpfh0vAaKtuxoHAuakZAQWC5uNPUWE5WcZI8GEwwCLb8OQsNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FNH/LfC1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NQ3k1tlE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FNH/LfC1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NQ3k1tlE"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 276E211400E3;
	Sun,  6 Oct 2024 18:43:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 06 Oct 2024 18:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728254619; x=1728341019; bh=Y0HKhnOHPM
	iVaKgfQn+hpJU8IMjyVU3+3CID5V7gOYI=; b=FNH/LfC1GycYaYGtU3hLaufuan
	gMC7XtXF+p8bEcsYCnF9CysLdfuqwEOz7yjCbvPranxNTFYSuJim32gQdBGg0nI9
	3XWaVeY81wnocgR9OrYzliNXNKKpXnLdd705pmgdzfNOrmVT55KUygzsJIbSRLnB
	m4RaKb7W77rnANl0clQka3fEAQSLxrfDJ2Eb+bDAIGwwpq2ZrLqnAqe3TUtmCGBr
	wWQUZJTNOeefT6tWVKSWTBDZKoQz1tDpJoGTpfVawwy7jngwt755SvweAdd6vL0l
	sGWnpNEyQlrGPcQs0prrKNPSYkJRXuacrBqqnCn4zajZBlq1Q15LUPb/6EVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728254619; x=1728341019; bh=Y0HKhnOHPMiVaKgfQn+hpJU8IMjy
	VU3+3CID5V7gOYI=; b=NQ3k1tlEllSeZyJ7V3YyO0YWYrAssR5j3JVCCkKUns4k
	1h8O03pS071inZDiv7T5huYNeMIgt+EClYRuPmajGb/6U01zxYwrLIBKsCySsKJR
	OTBkYcHQS5qgPx0flgaclnjWAtz8YHHHzIg6Kx4qGA4i5Y/bv8OhwFD+u3XgTrVn
	3OqF39lPhjqfwREuZL7nao7kZlrkTdMVBXsE6viRphbBWWNAEIJY+TW1cYOK9bua
	BAlcoFeyfK1YdarrXxMc0jbCEQOsTumstAVxUKlBadM1+x8K/rymFWC0QNhjAv/b
	lzNX6UM9FRDTfN888JSuQV0gw8ZDw6xE/bpcg4PqRQ==
X-ME-Sender: <xms:mhIDZ1wG1LBaZMKab74saHYBuARr5qxcP80M5-DSildLCdfwPSVJuQ>
    <xme:mhIDZ1R5w7TAL6xhSj8nTvrM60TICiGdQPsQ6OP8d9x5R9viVglWPt1DYaopsJbml
    mgqXtivSafvglXFjQ>
X-ME-Received: <xmr:mhIDZ_V4DD-O-1WT10b-nObU0YchFH0eoMJLKTSXXSJn5hjahTEqWF32lrjBWL8gD5ikSykl8C9InzPj6-o5cR9I-A2RLLLFlylLYsI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohephhgrnhihrghnghdrthhonhihsegshihtvggurghntggvrdgtohhmpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepshhokhgtvghvihgtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mhIDZ3gKu0lCL1IBq_jxNohf2B6ja2fgkW-xdt1j2BFYgp-Yv3zp-A>
    <xmx:mhIDZ3AJ72K2cf6XQ2kleJ-Xq9Y1BjSxBrpuLSScZVICSt1q5sk7Lg>
    <xmx:mhIDZwJBaDb_h7FLZIC2RbC6pVIMOyBUrZtewK5SqA-1jcQ9tW1gDQ>
    <xmx:mhIDZ2ALQfF0qwTJIizfO1jIYsuL8QIYker2ysSHaxYre1j-Y27CMQ>
    <xmx:mxIDZ5AADtnwdAr7D6kDulH6V8SvtkFheS2JJCs9slS61vpKcPEXRNJ4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Oct 2024 18:43:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Han Young
 <hanyang.tony@bytedance.com>,  Jonathan Tan <jonathantanmy@google.com>,
  sokcevic@google.com
Subject: Re: [RFC PATCH] promisor-remote: always JIT fetch with --refetch
In-Reply-To: <20241003223546.1935471-1-emilyshaffer@google.com> (Emily
	Shaffer's message of "Thu, 3 Oct 2024 15:35:46 -0700")
References: <20241003223546.1935471-1-emilyshaffer@google.com>
Date: Sun, 06 Oct 2024 15:43:36 -0700
Message-ID: <xmqqset8c0o7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emily Shaffer <emilyshaffer@google.com> writes:

> By the time we decide we need to do a partial clone fetch, we already
> know the object is missing, even if the_repository->parsed_objects
> thinks it exists. But --refetch bypasses the local object check, so we
> can guarantee that a JIT fetch will fix incorrect local caching.
> ...
> The culprit is that we're assuming all local refs already must have
> objects in place. Using --refetch means we ignore that assumption during
> JIT fetch.

Hmph.  The whole lazy fetch business looks more and more broken X-<.
There is a comment in the refetch code path that tells us to "perform
a full refetch ignoring existing objects", but if an object truly
exists, there should be no need to refetch, and it starts to smell
more like "ignoring somebody who gives us an incorrect information
that these objects exist".

But a ref that points at a missing commit is "somebody giving a
false information" and an option to ignore such misinformation would
be a perfect tool fit to sweep such a breakage under the rug.

But is this sufficient?  Looking at how check_exist_and_connected()
does its work, I am not sure how it would cope with a case where an
object that is pointed by a ref does happen to exist, but the commit
that is referred to by the commit is missing, as it only checks the
existence of the tips.

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 9345ae3db2..cf00e31d3b 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -43,7 +43,7 @@ static int fetch_objects(struct repository *repo,
>  	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
>  		     "fetch", remote_name, "--no-tags",
>  		     "--no-write-fetch-head", "--recurse-submodules=no",
> -		     "--filter=blob:none", "--stdin", NULL);
> +		     "--filter=blob:none", "--refetch", "--stdin", NULL);
>  	if (!git_config_get_bool("promisor.quiet", &quiet) && quiet)
>  		strvec_push(&child.args, "--quiet");
>  	if (start_command(&child))

The documentation for "git fetch --refetch" says that this grabs
everything as if we are making a fresh clone, ignoring everything we
already have.  Which makes the change in this patch prohibitively
expensive for asking each single object lazily from the promisor
remote, but is that really the case?  If there is a reasonable
safety that prevents us from doing something silly like transferring
one clone worth of data for every single object we lazily fetch,
perhaps this would be a workable solution (but if that is the case,
perhaps "git fetch --refetch" documentation needs to be rephrased,
to avoid such an impression).

Thanks.
