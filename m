Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462C222572
	for <git@vger.kernel.org>; Wed, 14 May 2025 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260651; cv=none; b=V7oGJ+Jg/tYkd31viIQPnRfhmhLMHNZ8bnFBGgn+MRgRL8j7S9cLw5uAzW3Wd3mQ2V8DlUN+tdXdJiQtmW7zMROMQ2WpwweAF+DaF7LtCPo68IOJqMI2gio/HhsGoqm7Ml9kvh3iFLB3/hgRvUxNld9C+jXRmmcai1F3OXYCHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260651; c=relaxed/simple;
	bh=HRHEM8TfPxTW+EMng8w2O9l0F+qOOoJD7b9IDHTOvpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cyRaesS5jANYp1RKkcIEFZWpes7WZ47DrUTik19tWFiGcFOKwKrjxKjVZpg0u9WJbRCibFTtHfDXPcxwOalcr+RP1QjAtwwSNAcGqBHeJRTauFsbqDTFc55BMqVNG/rRNXNU6XYnmi6488FYI75MShMn1YE2sCDMJWCi5jbsAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U0+XyC5X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uXO07YbM; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U0+XyC5X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uXO07YbM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 442DA25400C4;
	Wed, 14 May 2025 18:10:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 14 May 2025 18:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747260647; x=1747347047; bh=Pz1UDv5xxM
	t7CspXu8T2wLhVaJq9Sd40zktFqj6eBRY=; b=U0+XyC5XVi9vnTfbYr+Ai8mqXU
	K4jA3zrfR0yEserYQI6F9wmfePVS/+Cg6n9gjXZzrZ8aowvW/egdFdrTtcMLRcwr
	frWjnOgGkesdugZa1F35GxTOn9nS90fhDX8oDXKoEMRN/Xhdn1zP53b4c7BUJOAM
	CtqHMVmK14Kr0AnEf8XYbskZNma6y9A60JVxTRNdFHQrvYdQJeZy2iSsMoYzeY/i
	wusqnJ1pxvxPBkk0Pd0Lr2JHcyfpGAEyfx4ThNgX8Mbq36Zi3LXpwX4LzrOfYN6S
	Cut5nF+b7gdz3//2V3NsskC23a8IWxDTdMleVAVM/10CBv3mo2b+oFJypRkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747260647; x=1747347047; bh=Pz1UDv5xxMt7CspXu8T2wLhVaJq9Sd40zkt
	Fqj6eBRY=; b=uXO07YbMgb3flLQ/QcXQM7cze2Z6Gq2nl+g4jmeblcjtYkyXuUr
	MLktXzvt9QjjbtAOR67xZeeIBPdacrIFMlBI/mlBrNwNQuo73KGPd0eanrHvPzSc
	yCIvMMfKBIOARKfdzqH8ioUGqhphkoOSMQ34Kqku2rf2Cr/B07/kFQqF+ROd1EO3
	DfpM48ZCIlavoa+p8aiP3WnGr0xdBiXv09HGUmrYb9FjnamZ5VFVcfEez9RVMaWt
	5StGIo9l0sUIBT1d1fRow7Jojepmv7Ez6xdK+gpFAHjKDfzFNNLJqXh60KLGsGOW
	7Sr1TN2oUua1SAYda5x7otdyuRs5QbAHupw==
X-ME-Sender: <xms:5hQlaNpU_0es_WPu-FBq7BGRcaiNk6iBOQ2pQfthKbtNqbyBqsmrFg>
    <xme:5hQlaPoY4ZoQaB16idbx5uwiBsWLoFc49dPR-Hoi6xY2lrImz3DEciZvirJkhI2Cd
    PHyKxCAgrNegoAqlg>
X-ME-Received: <xmr:5hQlaKOWIPizRWdBVts-l057pJ0fKXsZ6ewaNTbXDkrSL6PO904aGigNb3A0fdKOiXuoojgV9-39JDMhtzE4H1l0Bc2aVF4c835p1iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdekudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5hQlaI4BXmpsWLrUN3W7e0-Fe9Lxjr9LeHX_jUWk-LWTdzvQ8DDTmQ>
    <xmx:5hQlaM4BmI41pUeWYGxh8zX-p5b5hCU_CkjcE6R9VOk3Kj4eTVNimg>
    <xmx:5hQlaAh1Jhc7J9D_cjk2ZlpXxjQ1RwG0gHUfmmDd4zyXTVXY0tQHXw>
    <xmx:5hQlaO6Vgq7eoEL_dB3UDO3xJcUerSayRKPQ6olLSwpiC2TrXzGHAw>
    <xmx:5xQlaCGBmqQwokoC_SpoiyqMxWWPvysbRdqP6UiUaO9Ob8Eki_gsCq8p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 18:10:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] replay: replace the_repository with repo parameter
 passed to cmd_replay()
In-Reply-To: <pull.1921.git.1747254806067.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Wed, 14 May 2025 20:33:25
	+0000")
References: <pull.1921.git.1747254806067.gitgitgadget@gmail.com>
Date: Wed, 14 May 2025 15:10:44 -0700
Message-ID: <xmqqplga7sij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     require it and have no current alternatives. However, I still think it's
>     worthwhile to stop using the_repository everywhere while ignoring the
>     repo parameter explicitly passed in.

Sensible.

> diff --git a/builtin/replay.c b/builtin/replay.c
> index 032c172b65e..225cef08807 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -20,21 +20,22 @@
>  #include <oidset.h>
>  #include <tree.h>
>  
> -static const char *short_commit_name(struct commit *commit)
> +static const char *short_commit_name(struct repository *repo,
> +				     struct commit *commit)
>  {
> -	return repo_find_unique_abbrev(the_repository, &commit->object.oid,
> +	return repo_find_unique_abbrev(repo, &commit->object.oid,
>  				       DEFAULT_ABBREV);
>  }

I do not mind this, but I do have to wonder if it is simpler to make
the two callers of this "helper" (which is not quite helping anything)
to make these calls themselves.

>  int cmd_replay(int argc,
>  	       const char **argv,
>  	       const char *prefix,
> -	       struct repository *repo UNUSED)
> +	       struct repository *repo)
>  {
>  	const char *advance_name_opt = NULL;
>  	char *advance_name = NULL;
> @@ -329,7 +334,7 @@ int cmd_replay(int argc,
>  		    "--advance", "--contained");
>  	advance_name = xstrdup_or_null(advance_name_opt);
>  
> -	repo_init_revisions(the_repository, &revs, prefix);
> +	repo_init_revisions(repo, &revs, prefix);

OK, since this command is marked as RUN_SETUP, it is safe to
unconditionally use repo here.  The only situation where it is
called with repo==NULL is when somebody said "git replay -h" outside
a repository, which would have made parse_options() to do the right
thing and exited already without reaching this code, so we should be
able to trust "repo" to be usable.

Will queue.  Thanks.

