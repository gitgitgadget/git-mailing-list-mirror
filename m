Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2FD370AC8
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780469; cv=none; b=dLMzk2pvwF4ZWPjjdX4dclyBVFoxevT4novKyTkG57a3GT88QJTINYpwuk/Dlq4AEZoLyTnU/kOPTRuKL2Md3TVI22+QD3IVFHLpsnLM8dCKIaxSP8ykd/yMZfbqWzXHP8fpUSowdfJtTWDvyRV78rjFzTnMZfA+1noXn4cFG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780469; c=relaxed/simple;
	bh=H4GNSSw96YoKjDXRoEZ2jc7Ik92AqcEsF8ukAGKmvy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPhOTLSTxIxP75NSoqAyaF7cgjfzSBlAo2rgJObH7CYdh5DOfSr1KWX/+8SdHt3kSi3ezEkFlg4N7IXEXVywvupSDw4WZbAlbV2NkY6ZpwX03UFBX1ho8cEMwmFEZKfqox6fvZm3poqSrNJ6bgwcJvdSITFrZ3yDahR+axJPqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QFjYcB9U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lvhl3Zhz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QFjYcB9U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lvhl3Zhz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D77AEEC0041;
	Wed, 30 Sep 2026 11:00:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 11:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790780458; x=1790866858; bh=/vcm902tRL
	32zwIAt5d2VKNDxcO6iRKk41yeJYfEWGI=; b=QFjYcB9UbamLwSl+8Lsez4ugG0
	PL3kRxvJZ0ofZnWJeWsZ7sszGvhdUIDv4OPs/yoFOZy3qhEfVQzxhsu4VYt8xlNT
	NQce1bquogQQwEXp2cgzDhyOJ35qym1E04WB/jbMo4Y/UYSSEiSrKuUh8lL6frP7
	4vJFLEa71qGQAxKmcEU48ddrC92ag86Jy6X2UyjjYB8ywDaJHE4cjsLZ1qVeNHoB
	0okFD/Vu/o/Eor+8/vPMe6ekX86rsjRke3ISxYfpR56V5Ik+/Ds00gsEYHIVJY2j
	pVKs8Bk8iZS8PlTRkc7RrETKZXvC9ErsyRJKC3jZZMomBPsRTvYhCW8tx0Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790780458; x=1790866858; bh=/vcm902tRL32zwIAt5d2VKNDxcO6iRKk41y
	eJYfEWGI=; b=Lvhl3ZhzgmoyxLQVxrXmcF5yR2XZ5815EekQRCpO8D4gzFz7+Ka
	4X+7yrJczaRiJUCcPfCPIxws+vUaY59bPalCaSGDMmW5wiOCxm9CoCTWEFQ0ukbw
	Dqu72SAtfxPoA1q0Ng3gzBUcfrklZSTO/qSRONhfJegpH4mZS4cgvEGnV+tARwUZ
	vsJWwhj32PtxIw8kJo3DGVloTsHx5dy1qUdkubpaKIk5Rm7G1wdOZ8U05tV978kq
	6INJwCK7BHF7bKEJqJtLtJWGBZ0CMBhpV5/4OiFf1ZolRpdPh5wqpui7VQfBAv1p
	DL5hxe1Jophhy1YdWO8nP/pXm4OiQsjye+w==
X-ME-Sender: <xms:KSS9avSFXmASpd2d2qYAb7mq0pgvAjwmwAh_PR9YsgZ2Kd0vxk8RGQ>
    <xme:KSS9aqGwde3rfBZ57cw1lm4UVd9k8vWCdzmFguqROeVGXtbfJW4b3QzfY4G0tXrxR
    c_42StVrAyEhrabXOgzKJWySdJHJF13eUNYOjYDJq4x5Hj5ifPsMa0>
X-ME-Received: <xmr:KSS9asGprrCs7uSsBN0cYgwpRGHU2ivkSPc1OR_ivfjrqB6b4pGrrQ>
X-ME-Proxy-Cause: dmFkZTFrOV7/uXxSkJtr09StS4BSJr1lZcQnTNqHI1tunDACML+mMXvkguwTbBiZAKFjWf
    Dk+Wm9AR9yS1r06MraeDfEP4Y9vmYhQ60yaOV5o4FN4oSgC+2or/Dk3LCE3OJ4viEsLgdT
    qmW6fXWq7MncpZWwBcma6iBG6DjoMlRFu5uEODNhDUTfgDq8WOObi/OdCJPiurvXFgjKJF
    XIQuP6yYeaE8vusrveQY/hXYgB+8+LtO2uTdKy9W/rvBER9blcrTi9ncAmh4D17buchcx/
    dP4bGuWbdaAP8c2H0QyO2G8DhE+8M/FhgYd4InLG3aQHwtdSmTYFegMBO7v8z9RMdhPQqU
    /dnEjWih/MT/AM2iPROs6xaYA7RXawGTw04eenXOd4upqKfpQJDCqqQMlXr48ayH8HY0HI
    CkEfjRZvpTBkiNNDvp+DYMji4Hi3CpnAXFL8N4EQ83GygEQ0RvHcLgzt22c5sbooJEmkz1
    6zC4xEkquXwB8W0uSGM2+m1pMqGxs7YEm5t5ShHAXvFKBxGjqTs2UBpFcojoaO+U2FXpFt
    im4reJro88VOJ0HHlmOQl6lTOKsMKMx7QMub4pEdc5dQpoMb+qCY64tLaGBCMXWPHTNmHF
    FRq/maiy40fEgL2CxsUydJ4GsVEZ03QV1rb2GLpw96nqXxO/Y+iJODitzlUA
X-ME-Proxy: <xmx:KSS9agTM_ZH-4r7cJoqpsTmoYmu8SuNIPCM8AsBbMBiGlEOz4xfnWw>
    <xmx:KSS9alLsE8iln8LK_GFrzwi3P8OZcpAIoNS53oSAfysrFj1dDFSd-Q>
    <xmx:KSS9ajZPMw2XTBai4ofF4c7d5aSuMP86RmMdFsuSPdy4ENSQmzoNYg>
    <xmx:KSS9av8ZD333FQKMYG-hSl22PS6UsDJcKZ-hG_txqjw9UotcPVJwTA>
    <xmx:KiS9agMVx4mvdpMR5zXIGYelN8x-JVKK27OiKpGIHPltgBoyJyMt94U0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 11:00:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4363eba5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 15:00:55 +0000 (UTC)
Date: Wed, 30 Sep 2026 17:00:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v5 2/3] rerere: add "gc --auto" that skips a held lock
Message-ID: <ar0kJPdY1WSsWvP8@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v5.git.1790596702.gitgitgadget@gmail.com>
 <27673137aae961105a3d3b6ea615879e0686cc65.1790596702.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27673137aae961105a3d3b6ea615879e0686cc65.1790596702.git.gitgitgadget@gmail.com>

On Mon, Sep 28, 2026 at 11:58:21AM +0000, Thomas Bachem via GitGitGadget wrote:
> diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
> index 4e6ab9a27c..da7a1d093e 100644
> --- a/Documentation/git-rerere.adoc
> +++ b/Documentation/git-rerere.adoc
> @@ -63,14 +63,17 @@ Print paths with conflicts that have not been autoresolved by rerere.
>  This includes paths whose resolutions cannot be tracked by rerere,
>  such as conflicting submodules.
>  
> -'gc'::
> +'gc' [--auto]::
>  
>  Prune records of conflicted merges that
>  occurred a long time ago.  By default, unresolved conflicts older
>  than 15 days and resolved conflicts older than 60
>  days are pruned.  These defaults are controlled via the
>  `gc.rerereUnresolved` and `gc.rerereResolved` configuration
> -variables respectively.
> +variables respectively.  With `--auto`, which `git maintenance run
> +--auto` and `git gc --auto` pass, `gc` does nothing while another
> +process holds the rerere lock.  Without it, `gc` waits for the lock
> +as long as `rerere.lockTimeout` allows and then fails.

It's a bit weird to have git-rerere(1) document who calls it. We may
want to document why specifically this is useful though.

> diff --git a/builtin/rerere.c b/builtin/rerere.c
> index a056cb791b..2a8871df41 100644
> --- a/builtin/rerere.c
> +++ b/builtin/rerere.c
> @@ -56,16 +57,21 @@ int cmd_rerere(int argc,
>  	       struct repository *repo UNUSED)
>  {
>  	struct string_list merge_rr = STRING_LIST_INIT_DUP;
> -	int autoupdate = -1, flags = 0;
> +	int autoupdate = -1, auto_flag = 0, flags = 0;
>  
>  	struct option options[] = {
>  		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
>  			N_("register clean resolutions in index"), 1),
> +		OPT_BOOL(0, "auto", &auto_flag,
> +			 N_("skip gc while another process holds the lock")),
>  		OPT_END(),
>  	};

Thinking about this a bit... I know it was my suggestion, but I wonder
whether "auto" is misnamed. We don't let any heuristics kick in like we
typically do for other commands like `git pack-refs --auto`, we only
know to skip garbage collection if the lock is taken. So there is a bit
of a mismatch here.

How about we instead call this "--skip-locked"? We could even mark it as
a hidden option and not even document it, as it feels very specific to
how git-maintenance(1) wants to invoke it. If so, we could maybe remove
it again at a later point.

An alternative could be to instead call `rerere_gc()` directly, and if
so we wouldn't have to add this flag at all. But that may result in some
bigger changes, so I'll leave it up to you to decide.

>  	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
>  
> +	if (auto_flag && (argc < 1 || strcmp(argv[0], "gc")))
> +		die(_("the option '%s' requires '%s'"), "--auto", "gc");
> +
>  	repo_config(the_repository, git_xmerge_config, NULL);
>  
>  	if (autoupdate == 1)

Oh dear, this is a mess. The file could really use a refactoring to use
proper subcommands.

But anyway, that's certainly outside the scope of this patch series.

Patrick
