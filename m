Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257343CE4B
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768863; cv=none; b=DWMXa+zgYCTcwbui/gIAmoRCgryun4NwTEcrlGo3EJSBR244IqaY1tzNF4KhuHkEtlGWXYtok2kdT4R2oHkP1Fsb6Ht9a3ACvwkRI9cA9f2C8e1b7kkD7N5IrWhyBYMcRPZrOnNIwewclZXCB0MNfCe+sVfGzzMTHdP25NSiceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768863; c=relaxed/simple;
	bh=9RlXZoQWE1QTvQct08TFJHLNl7z8nb/ypJwtlZ+8wgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrpUNxrAe6ZYQbDoI+wfqNIk3bUT4UYVlEqSYhd48lEMqCEB+0SN6cL6sSghVQZK7KooaOeaCR47dDBCO00tBsZCPZ2UQw+ESI2E1Z5lqVz87ddR6c1I4XvkX2gxJ59lp488weCJPP/h3G+zbIL0yzHKpWaG5AaaH49Fs9dgYVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DVVmXOgV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+X2bX1X; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DVVmXOgV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+X2bX1X"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A191EC024F;
	Mon,  7 Sep 2026 04:14:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Sep 2026 04:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788768861; x=1788855261; bh=caJ6ChfsSJ
	JDzW2dutDU725rmx/JD0WbJij75Sf7EXo=; b=DVVmXOgVXxozGUB0CF5wJjHzHU
	Vt5+darG9LnnJl4OAsZpmg9VYoPhbnDDoymSxmFS4GvlTKlSTSCyUFFotr/3j5+s
	Y7qBTut0CLA2SJx3GwdplBRzktsTjgG/NuLSVih8gC9GW0DoM/W27QEpCGs4ZPxs
	5ENzF4kHFoRC6qujwN21VE/6qvEt1bPBfmygGiEP3rHV7sGCAavs4DP4348cemH9
	k+EYylDMZnbCzp9tmDqNF1e1Au/TjP0y/CaDkgykYEK+5EmIYVs9MDWF3cdmaUfj
	C5bGDIPD4GScW6Kc/U+6qOXZcklio0UwsV631gApQfNyWlsTanNk6GxL78LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788768861; x=1788855261; bh=caJ6ChfsSJJDzW2dutDU725rmx/JD0WbJij
	75Sf7EXo=; b=Z+X2bX1XV7Kk541Cut2Xe9chENidxxiB64NQyw7RqZqs/AjKo8L
	XJcV8MnKyxJzH7UYfEfu1XHqs5lCamvC/3ZCOSdrGZf+UeJ9JdPQ2NgDJSWdWSv8
	63YDvfYviSljzjMezkas1++TjYHizbga+UlNa47gnUbAy8utOL+faWMWDpWpp63G
	DiLR0VV0MrK5ASX/ZjGYDryx1FX1WsRP5CHN6Yn9cIZZqHe5b3DOCTVlF1D4s3dx
	6OvGBTqz8ezAdLBm6+w6ASMPO7b9PCk69KXOpFKZPtQTibgVQPv/yqjdr57s8FdV
	3j3x5mqEvLFO2s9bSmt7AslGiVVhKGc80Uw==
X-ME-Sender: <xms:XXKeameavbgoYcOKtEnS10qRzBytd5fhMhfeq5TbNzzNzgQX0ZXgRg>
    <xme:XXKeapi3VI7Yi8pDZiIwEAoYIlENQlFRY4l7du5dxf_5QY-5BxVZ-BijR-dbZCs4d
    9c6lB_I6du1h5x-pqQjDk2ajjO5c3yqRNc0FfUM9rt7LhVtncIVvA>
X-ME-Received: <xmr:XXKeauyKmi30ygCekFAa_G5tnTfU9nRGryz0bURebTl2RMsCcTDl5w>
X-ME-Proxy-Cause: dmFkZTEuDxWEFVPXKjjQlqUlDJ1t8NxWe/2y5zednXE80fnZrtD7msFqXRQTqY3RPW4P/X
    1DrH1hOT6DIqQ0n7novq3egSahQmIOphe/4ZyASFm2WxnOErn0usK9IBgPjEqxgmys7n4U
    J/1WAOVcvBQ70jEhctdPJO7vPz7AhAMvSYojUrJRN/OI8zqk8354KGIvuOWqc3F4EfeoGJ
    WQerx3YObOIx0HYPkMc7h56eZ8btKXkVG7uUz5ymPfeTOMPJ31ZAS0H7gxrAo0N6wEoQ6o
    5/mV8BXvmLkWhadca+2DTtntQtURa1sntdIo/dTdDsb1PFx/FCE6HOC2WNYIRUKIUMKNrT
    J148IxI1EQh7u8d97nn6mSYMlTarQlNJ+LmLcwfYEk0kUn84vN+MdQzQ5f73+rSpg7cxG3
    VOVAyzYAM5g4+sy/H2mEQoz58aR3iYVflwxJQeXWJ3B89kypwzUkBgKKIA49O8lK+i02oF
    60fJYNIg4SSEdfLSz94gFaFFXzwjQaZhN/vXWhXSOK5nAxA6OnSVWBhCI8LcKDoZiw1Awq
    my9cglIuhqPb+eChT7znjLy685akEx55BlSfQqhzMZo913SAtuLCGKdI5Rq1XIFGUZMzbm
    pKTTiQXzIOHH6AhWbRhakg0L6PPF3EHLmp/g09xxLAKHULyk82MCPb8JucXg
X-ME-Proxy: <xmx:XXKealNNXYw9XbetX0q_AKoy-omY-e7n7e9RIMQYPNdzcjGSbL7OFw>
    <xmx:XXKeavX0vufY5279eX6UGomU1y4gL39XYCiSbBfBSDrbp-6bQkoL2w>
    <xmx:XXKeap1uDIOtFFSX9OaUuiG4NLbJYoAlXkK0A2n967P_c--oiQ9ngg>
    <xmx:XXKeatoCrAEe33z8HcT8eFHn5pqkBOOz6W0379H4apAteOUebCG3mQ>
    <xmx:XXKeavAhXjSshfeBmLSOEDmPafY-RQu1GseJ0dU7pvGwT1gHvPGlv8HR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:14:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e4a944a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:14:19 +0000 (UTC)
Date: Mon, 7 Sep 2026 10:14:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v2 3/3] sequencer: keep auto maintenance out of the
 commands a sequence spawns
Message-ID: <ap5yWS5tKLej7BjT@pks.im>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
 <9a6fc0427a8bc7e7abcc0518214b1dafc2efaa6a.1788537086.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a6fc0427a8bc7e7abcc0518214b1dafc2efaa6a.1788537086.git.gitgitgadget@gmail.com>

On Fri, Sep 04, 2026 at 03:51:26PM +0000, Thomas Bachem via GitGitGadget wrote:
> diff --git a/sequencer.c b/sequencer.c
> index 67e1c38762..5df07750a7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1107,6 +1114,27 @@ static int run_command_silent_on_success(struct child_process *cmd)
>  	return rc;
>  }
>  
> +/*
> + * A sequence runs auto maintenance once it is done, not from every command
> + * it spawns along the way: their background "rerere gc" or repack would
> + * race the sequencer for locks and files it still holds.
> + */
> +static void disable_auto_maintenance(struct replay_opts *opts,
> +				     struct child_process *cmd)
> +{
> +	struct strbuf *params = &opts->ctx->config_parameters;
> +
> +	if (!params->len) {
> +		const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
> +
> +		if (old && *old)
> +			strbuf_addstr(params, old);
> +		git_config_append_parameter(params, "maintenance.auto", "false");
> +		git_config_append_parameter(params, "gc.auto", "0");
> +	}
> +	strvec_pushf(&cmd->env, "%s=%s", CONFIG_DATA_ENVIRONMENT, params->buf);
> +}
> +

Why do you set both "maintenance.auto" and "gc.auto"? Setting only the
former should be sufficient, as maintenance uses git-maintenance(1)
exclusively nowadays. Sure, it may trigger git-gc(1) internally. But it
won't ever do so if auto-maintenance is completely disabled.

Patrick
