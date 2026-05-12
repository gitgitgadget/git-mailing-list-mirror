Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91BD531
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548767; cv=none; b=Q5Te2U0YoMrAmG1o6/91hsXIxJO3ESd6Bb5v81dLXnHNfwkMiW/5OTuut4Fw7b6WFdzxDcjzyKVn3ZnhUYNYgGPws64ZjryQoWNLbbCkNliy7+hc90N9UdiLOApcV+qzmlRktIixZ5M/Nq+rhFdmOIDo3ADKofSl6SSfut9auo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548767; c=relaxed/simple;
	bh=VG+KcQfUZGt/QxCpm8UqRHVba9Y1FoDUpbvZkTY3Bno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1rP7oVt3cyCzAOT7koVwgGUqD4QGrA6V7O/+89U6nRvomYUUllO7JTii1Abed35toaJQiS1Yrds2sKtMFC8nY9Xo3fuzt5Rm1O9MpYQsKyIcdnZyB/Sljmm4rjUbQpWE08NIjtw1tIs6QeI0+5EzQ5Wo86k34u9Xv5ftWD0P8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xbtMOUre; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfT3/hmp; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xbtMOUre";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfT3/hmp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 21C287A0111;
	Mon, 11 May 2026 21:19:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 21:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778548764; x=1778635164; bh=LuTeOZMj1l
	+64fKY43PUL8NBh11/MxJqhgLqs4DChBs=; b=xbtMOUre+N3bz7Afa4CgJVsn7G
	jT6ZyRFmm3rr+2a4ng0bKyCkuaiAY+jZ5jBw17Zj9ea5t707KVgnfiGd0+uPXDLD
	epMq/e02mM5TO1lVOBVfeIYJBc/kBxzr21NlpHD/rNxlkdb0kkWwfp+AvYXpBpQA
	zGzem4ElqMh0TGAYZarsx7dtbah5qhCTMapnkynpcpADZRTmYFWf6i/LbT3pqxsb
	DvlfuFlKBWmLt93xqZQM0ROPfV6/LZxlxwa2ElSurfsQh3sXxtr6atR1oFCrkHtJ
	0DfhCo7ZpMoBHX/aGkAmAqErAIjbHhVAqHt0oozxcN7WM28yrJZ6ygEBxKAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778548764; x=1778635164; bh=LuTeOZMj1l+64fKY43PUL8NBh11/MxJqhgL
	qs4DChBs=; b=hfT3/hmp1Tatm1y35A9ucysEQYxPEnHZdi+UzoEDaqS/R8G+N6n
	ydLLA1aa0xOD9f9KhiGWMSn+ov8ZJtRAxSEiEr4kmFz3489pEXTHVxsVh1CS91bG
	nSAvd2SGcoMhKVx8lliuKUbzqFUm9yPx1WEE5V6/ILYO8nf6ot1XdCw2EFddOSws
	wDD9dcpKdsQN52vyINbYIIrBfQR6l4rO0WMrSB7h39S/OAxAjanMtvTRNRxNlnzn
	Kq2sbSrB/R7eHcJA7Wd1Sfn8sIZL5t2xnfDov928uJxnFPJ5/HpTQpT/L9HphkYw
	KoHX75872dUJkPjoJC7OUZUoACck1U0PRWA==
X-ME-Sender: <xms:HIACajOnLEUICOAraTBogtX_iYMtWyN9BWs-bNqCyN82bntfjGnjxQ>
    <xme:HIACatD9p33BNjJRSwfMRm3l8rnDWstS8p1EYFphimIYQEQcHDTBIGfJFAwo0an3Z
    FVlD5OWSzTeoEAApxH3hqU1qMvRqhdDhN0sscIwKoW7jMtJWPAf>
X-ME-Received: <xmr:HIACaoev3F0njEkMTJpgRDO1leESXndoMn4qUbtTUH3CKwQsG-tWGVEJ617dBn_lA6AR_BC_p8PafoL6-nuUAv-8zPaaF4pboA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggtthhiohhnmhihshhtihhq
    uhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhgrtghhuhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HIACakMkB5RTwYN3_LiYmvJythNi_2F08Qxli23aCEZ3_yxrlBm_6A>
    <xmx:HIACagIxoSEn0ANDYx08_dqCXUGkl9Nb_cSCgB4ZFA4HLjdpg8QY5A>
    <xmx:HIACasKnOe7aZDdMjm9Mh7oN7e0yQ0NJ2Thnq9dcKvJb63qDHndvMg>
    <xmx:HIACai4K4KBChilDYWaNrAXgiInd82YZ3BsCYyz7sFuDMnLY36QWoQ>
    <xmx:HIACamxm7VIj8aS7wdgAJ7VMA4-_ll2KdyP7H5QCZsXLwj8GPW5EVD2d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 21:19:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jean-Christophe Manciot
 <actionmystique@gmail.com>,  Mikael Magnusson <mikachu@gmail.com>,  Jeff
 King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 1/2] builtin/maintenance: fix locking with "--detach"
In-Reply-To: <20260511-pks-maintenance-fix-lock-with-detach-v1-1-ccd7d62c9a40@pks.im>
	(Patrick Steinhardt's message of "Mon, 11 May 2026 14:29:55 +0200")
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
	<20260511-pks-maintenance-fix-lock-with-detach-v1-1-ccd7d62c9a40@pks.im>
Date: Tue, 12 May 2026 10:19:22 +0900
Message-ID: <xmqq4ikdqvad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 3a71e314c9..09cb92ac97 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1810,10 +1810,32 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
>  				   TASK_PHASE_FOREGROUND))
>  			result = 1;
>  
> -	/* Failure to daemonize is ok, we'll continue in foreground. */
>  	if (opts->detach > 0) {
> +		pid_t child_pid;
> +
>  		trace2_region_enter("maintenance", "detach", the_repository);
> -		daemonize();
> +
> +		child_pid = daemonize_without_exit();
> +		if (!child_pid) {
> +			/*
> +			 * We're in the child process, so we take ownership of
> +			 * the lockfile.
> +			 */
> +			lock_file_reassign_owner(&lk, getpid());
> +		} else if (child_pid > 0) {
> +			/*
> +			 * We're in the parent process, so we assign ownership
> +			 * of the lockfile to the child and then exit immediately.
> +			 */
> +			lock_file_reassign_owner(&lk, child_pid);
> +			exit(0);

The point of reassigning the owner to somebody else is so that we
won't clean them when we exit as the tempfile.c::remove_tempfile()
function checks the "owner" is "me" and refrains from unlinking
those that do not belong to us, so there is nothing wrong in this
code, but this somehow felt awkward.  In a sense, child_pid here
does not have to be what fork() returned but anything that is not
our own pid.  Perhaps "we assign ... to the child" -> "we relinquish
... to prevent us removing upon exiting" would convey the intention
better?  I dunno.

> -int daemonize(void)
> +pid_t daemonize_without_exit(void)
>  {
>  #ifdef NO_POSIX_GOODIES
>  	errno = ENOSYS;
>  	return -1;
>  #else
> -	switch (fork()) {
> -		case 0:
> -			break;
> -		case -1:
> -			die_errno(_("fork failed"));
> -		default:
> -			exit(0);
> -	}
> +	pid_t pid = fork();
> +	if (pid < 0)
> +		return -1;
> +	if (pid > 0)
> +		return pid;
> +
>  	if (setsid() == -1)
>  		die_errno(_("setsid failed"));
>  	close(0);
> @@ -2180,6 +2178,21 @@ int daemonize(void)
>  #endif
>  }
>  
> +int daemonize(void)
> +{
> +#ifdef NO_POSIX_GOODIES
> +	errno = ENOSYS;
> +	return -1;
> +#else
> +	pid_t pid = daemonize_without_exit();
> +	if (pid < 0)
> +		die_errno(_("fork failed"));
> +	if (pid > 0)
> +		exit(0);
> +	return 0;
> +#endif
> +}

I was hoping that we can do without the #ifdef in this caller as
daemonize_without_exit() already has exactly the same condtional
compilation.  If the NO_POSIX_GOODIES side can just return silently
wit ENOSYS, shouldn't the callers be also fine if we return failure
instead of calling die_errno(_("fork failed")), I have to wonder.

But because (1) as long as we have to call die_errno() here, we must
keep the conditional compilation in daemonize() as well as
daemonize_without_exit(), and (2) changing what the callers get when
fork failed here is totally outside of this topic, I would say that
the code around here is good as-is.

