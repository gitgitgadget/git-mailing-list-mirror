Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05615ADB4
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178443; cv=none; b=CDGDHuyVve/rFDdNwC1/ZoVw5Tsf9HcBZSpINwdQVXvS/HBsx2fte8lm9cIUj6qAa+Rjw2DNvXvlWyp1QPaP/qBvg7K2DnpB+gtxadl0zDDvq541RbfD1bIK2N1wbSs1Oy8uuKUBDcyoDgbB9v7io6lTmDIZoXZtMxccV6+l7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178443; c=relaxed/simple;
	bh=pHw/gItFNxqIfRKADURtwdLr48JsOJHgxmmYjoKg1B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0dxnuJ/eg8b4fTXK2sGXB4WDUePV02qKN7PmeEBINBhhA+7HlXRVOzuHrvqqibu1j07dlvVVV0Ypd5aBDHFNO/2JwCicHkCExZqsJoCPXqfH0Ne1VzWwsXvcQ6P0J1odacxB7V5KDYZHuS2Sjdce+ZXYfYhmS3xCq6qLaZb7bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kZuozLQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MddYliUt; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kZuozLQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MddYliUt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3145B7A01B9;
	Mon,  3 Nov 2025 09:00:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 03 Nov 2025 09:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762178440; x=1762264840; bh=BVUHDlC2HD
	1nE0mGEP8Yc2XUq9xcwEoywICmN4r5EZc=; b=kZuozLQ1mRHn2it5T2E1NeMbWH
	CM/fHG21W25EdGRzAphTyk3TRA3YdAjMhQJeRnrntbVDcl1TxH5pJKQCrljYtpTV
	BdKfii+rdJtfV8HMbbDa3FDJMb4J6RuwJ+dcfDytsUiDaiEzSOqka2+GJ5cUanQK
	nPkyPp47FJjIfuN1FmgIQgLFBoOImFpCPnOybKGM3RjddrFJA3ZBHBvkM3cYvgUH
	YTGWY0QuZJdHZmnMlD+YgumQjyql7Xt+zhXHhx42Q+YE3+Wbhr+I5WYG9gddtDE5
	FHyKCHimZ9RfN4t9uqPZHFfBq5uBCPAPDVgvvBhwl36O2dlE0SXLO0zFyG4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762178440; x=1762264840; bh=BVUHDlC2HD1nE0mGEP8Yc2XUq9xcwEoywIC
	mN4r5EZc=; b=MddYliUtwLTbmP/l0PcWy2GSobE+3VmRo2PbOwuhl/o8g1fG6lE
	ISzYrXNQ07vrAID5hmsFYY/IeTbzecbDfeYDRzIWFOW3Xh3FNh/OCNLZj+1pfIUD
	HoMeU2ZqOlGbcgxsvTg6FErUaS8Ln5BP7t+NDrsoHg8iKxzXrRVhtidy2DCGDQsJ
	IsdsCM/yh9GWM6vpXVSx6yYxKIBvB1PmFh5Gd8blvjssKJOgOFZ/MEqYktXJtNsH
	v24Vq+dt9vc8rO/ePRIRMEXNmDdTH9PX017txftPuVzxx/IZAoMdoXDx4yocBzNE
	UQ2do0mLfNMabiNtPQJi17NCIdHwmVLYcHA==
X-ME-Sender: <xms:h7UIaUj-15MmXimqHdgkKwGYE6WwL6zj5S8tOsAeb_6OE_4wKJZ8LA>
    <xme:h7UIaTCUX7TePTz7aNYV8FhxNoY7PmSORQ_d73cyMiN4IA4TodkAxs5usIoyE_uDi
    tgnrji2hW0PWTfsgDTiGCtrjvq7QmgmAlsC3W9ZYGcby1AsPZug3Yo>
X-ME-Received: <xmr:h7UIaZsuXhw0OUp8MknHBKQoGPXvhO-pbASUzzp6c36meg9XNGARX6GSIEvXE5220FZCR4nX-zt0YM3r9Pitsu3WNjfcfeLbjuXgu9Ab9V9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:h7UIaQZjtzrlyykLkLFKyH3tE3XRcM0HYQ9ot0CCbuw-nOQ1e_L_OA>
    <xmx:h7UIaUULWyro4q-x9Keaj6IrVDfiP8UFQJwtiEMbXS1ZOBY9p7YsMA>
    <xmx:h7UIac61F6wYiPXXzLlYtT9Pc_rpmV4JpB7h462l7p1OM_5R-l4V0g>
    <xmx:h7UIaXgv7KyAbWPlkdF9SPM4ettKRmcsSR19pN68waadhhaQk6k0BA>
    <xmx:iLUIacSdFzIDqJICkTe38tXr_cSf2fxqa9w2CxjvBkcG4uRhDKMCklDc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 09:00:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5a6e189 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 14:00:38 +0000 (UTC)
Date: Mon, 3 Nov 2025 15:00:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] maintenance: add 'is-needed' subcommand
Message-ID: <aQi1g9TX7FoDgo9n@pks.im>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-5-a03d53e28d0e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-5-a03d53e28d0e@gmail.com>

On Fri, Oct 31, 2025 at 03:22:25PM +0100, Karthik Nayak wrote:
> diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
> index 540b5cf68b..edcc88f4d0 100644
> --- a/Documentation/git-maintenance.adoc
> +++ b/Documentation/git-maintenance.adoc
> @@ -84,6 +85,11 @@ The `unregister` subcommand will report an error if the current repository
>  is not already registered. Use the `--force` option to return success even
>  when the current repository is not registered.
>  
> +is-needed::
> +    Check whether maintenance needs to be run without actually running it.
> +    Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
> +    Can be used along with `--task`. Ideally should be used with '--auto'.

Okay. I assume when `--task` is not given we'll check all tasks
specified by the configured strategy? Might make sense to document if
so.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 72177305ff..4d20487ed6 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -3253,7 +3253,60 @@ static int maintenance_stop(int argc, const char **argv, const char *prefix,
>  	return update_background_schedule(NULL, 0);
>  }
>  
> -static const char * const builtin_maintenance_usage[] = {
> +static const char *const builtin_maintenance_is_needed_usage[] = {
> +	"git maintenance is-needed [--task=<task>] [--schedule]",
> +	NULL
> +};
> +
> +static int maintenance_is_needed(int argc, const char **argv, const char *prefix,
> +				 struct repository *repo UNUSED)
> +{
> +	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
> +	struct string_list selected_tasks = STRING_LIST_INIT_DUP;
> +	struct gc_config cfg = GC_CONFIG_INIT;
> +	struct option options[] = {
> +		OPT_BOOL(0, "auto", &opts.auto_flag,
> +			 N_("run tasks based on the state of the repository")),
> +		OPT_CALLBACK_F(0, "task", &selected_tasks, N_("task"),
> +			       N_("check a specific task"),
> +			       PARSE_OPT_NONEG, task_option_parse),
> +		OPT_END()
> +	};
> +	bool is_needed = false;
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     builtin_maintenance_is_needed_usage,
> +			     PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +	gc_config(&cfg);
> +	initialize_task_config(&opts, &selected_tasks);
> +
> +	if (argc)
> +		usage_with_options(builtin_maintenance_is_needed_usage, options);

Shouldn't this check be directly after the call to `parse_options()`?

> +	if (opts.auto_flag) {
> +		for (size_t i = 0; i < opts.tasks_nr; i++) {
> +			if (tasks[opts.tasks[i]].auto_condition &&
> +			    tasks[opts.tasks[i]].auto_condition(&cfg)) {
> +				is_needed = true;
> +				break;
> +			}
> +		}

Okay, we need to guard against the auto-condition not existing indeed.
This is only due to the "prefetch" task though, all the others do have
the callback.

> +	} else {
> +		/* When not using --auto, we should always require maintenance. */
> +		is_needed = true;
> +	}

I guess for now this is good enough, but it's not quite true. Some tasks
won't require maintenance even without `--auto`, like for example when
the reftable stack only has a single table.

Patrick
