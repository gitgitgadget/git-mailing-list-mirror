Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE930E849
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430576; cv=none; b=Tsb+dO1GFjqpju6Ah7Z31b+VYWlRTmE3e4DVB1AVFZXfqXrvsAqAxQfuIl1b/D56m/RQj3g8xFLqeJur6Cd46E0w7Pfk1PTp/Qwf+m5vk0SajRoxVyZ29kMOd4NPptp6q9y0DkKkpnVRz21Lrm5MaQ0QvGZEG0+bOwkqKa5Gre8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430576; c=relaxed/simple;
	bh=Gsc8I1u9Cb8cjPk0ra/Z0PDqeHBJyTkpja8rpRBhDEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDj+2ZR/CD4W3+5hOVdyXDKkUqPZKgsFEObHCP0otc9NPbPsD5N7F1nc+yUTZwsgtpbYVEZWzE17RHSVJ901qejHpIgisnX1YswIu/7m+3nJpEjGuvqKBhgShoB5Hl7MrEVPokXIlry5RA1i+ADnQFxP7sUEihOLXvuOdaQM4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fLfOzsNn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YTWI48yH; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fLfOzsNn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YTWI48yH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EBD8C1D00154;
	Thu,  6 Nov 2025 07:02:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 06 Nov 2025 07:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762430573; x=1762516973; bh=bMuAVXdra8
	UG0US4EGch7bNVPx2BfZhFB9qR9EsHlvE=; b=fLfOzsNnpApErGlruOH9W5YoDw
	a+OeyFmtUmzZOHkDZ24cSWAOXuE23vJ7OtbwmbKKJlspVJTjYOfn2yWIs3FzvsnZ
	ibgRAf+KgaV4SrW2WxiTOFJfuscFNMc4tnkwMd/+JZZz1EY5slieljKOyZxmTU7T
	kb+u4SaNqJcCecn1JHy1NJmVta5qP4b6QbRKWHe0VC4IW7zc8AnXin/THcjFTk4O
	oyxywVYV0zkQTtZl3Vz5J8GC7IYnZzTX2K81h8RKt5+xXbbzssCbG91N2Ixjnc8a
	98eamOqoXWzPfkAXxN/wdm1lkToPtJm8nYqJlaQ0kcUIYXk2acCHQbCYLRVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762430573; x=1762516973; bh=bMuAVXdra8UG0US4EGch7bNVPx2BfZhFB9q
	R9EsHlvE=; b=YTWI48yHaDgJuT4Z61bB96wJ5GFwGqDhivUgti1zcdKPmYs5q5w
	z2rfqcnwNgeHIScDLSykDB8GAqRi0TIBv/w9q/gXY6AgROK3vrSa1VVBB8NwZh4T
	GR2K0jR/VjCO82DSUiHMdTcuy9dE2+jgYrrZCq8xZ3ywpNFrVEon4koTTzBjRyVQ
	QAG9bwsDhpqpEA9efCTKARuRzMrt8CbxMgo1foZrhzd8AbIqR6eSqgUeIVjsU6zS
	HxBzHm9PcI+sAa0O+am3Er04j0DmjJEoZiUwRr2fMXcYUisdTnhp0zFu06oWVzhK
	vgOpuQdibOLoslJT6Cvqz8QR4zzwuWQeF8w==
X-ME-Sender: <xms:bY4MabLS9Zop7uVqELTfXZ5ATJCNpS2kJPSPOt6TA0QN5I2wH9jwhQ>
    <xme:bY4MaWJiPdEPWeIR7Fb1N3UqraySZLIfM3NX7dYrYJtjhtAJ69GlTREC9-GWuIWqC
    7PT2PbKP2up7nGOkQFy-EaxqExU5g1jJmS2AprXfr7HVuzdPU2E8Q>
X-ME-Received: <xmr:bY4MaYv9yFnmRVBy7w76yIVIsy-jtRUus7EBi5mJgOojuOCVOMCtK9TIo1-VM2pMQCxMPAXg68GnLqej3i_ffFnd1dlr0OYmYvWhVOfFZ9mt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeijeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bY4MaTTkou0JwPI6-KLdWFxHgXiDKaE1hPKP5qsYDYLuQDzE-QgaQw>
    <xmx:bY4MaeMXk6wpbr8z9zWaZ9ZPjPn1eN3rr8JItrVq7TSnK8MSOMPvIQ>
    <xmx:bY4MaYZr8c_Ny3yHEwTck8oWr00OycoXTyE3A8vmP-Ehaxj8LFl7lg>
    <xmx:bY4MaYw_2EtbF8PEQxujb5SXIL07_hb1Qw8dpyUPoUU7U9UZEKWoAw>
    <xmx:bY4MaYNfEcAaAYfDn3KNC6w7EM502UCPJh2UjxGcDTfTN3eayjtwmiSE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 07:02:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28dbb771 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 6 Nov 2025 12:02:51 +0000 (UTC)
Date: Thu, 6 Nov 2025 13:02:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 5/5] maintenance: add 'is-needed' subcommand
Message-ID: <aQyOZ0e6HO0_77Au@pks.im>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
 <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-5-d611a2a95cf5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-5-d611a2a95cf5@gmail.com>

On Thu, Nov 06, 2025 at 09:22:34AM +0100, Karthik Nayak wrote:
> diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
> index 540b5cf68b..37939510d4 100644
> --- a/Documentation/git-maintenance.adoc
> +++ b/Documentation/git-maintenance.adoc
> @@ -84,6 +85,16 @@ The `unregister` subcommand will report an error if the current repository
>  is not already registered. Use the `--force` option to return success even
>  when the current repository is not registered.
>  
> +is-needed::
> +    Check whether maintenance needs to be run without actually running it.
> +    Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
> +    Ideally used with the '--auto' flag.
> ++
> +If one or more `--task` options	are specified, then those tasks are checked

I spoke too soon, forgot that there's one more patch :) s/\t/ /

> +in that order. Otherwise, the tasks are determined by which
> +`maintenance.<task>.enabled` config options are true. By default, only
> +`maintenance.gc.enabled` is true.

This could use a pointer to "maintenance.strategy", but I see that you
took this explanation from the "run" subcommand. I think this is good
enough for now.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index c3e7a84ec2..e5ba2a2e72 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -3253,7 +3253,59 @@ static int maintenance_stop(int argc, const char **argv, const char *prefix,
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
> +	if (argc)
> +		usage_with_options(builtin_maintenance_is_needed_usage, options);
> +
> +	gc_config(&cfg);
> +	initialize_task_config(&opts, &selected_tasks);
> +
> +	if (opts.auto_flag) {
> +		for (size_t i = 0; i < opts.tasks_nr; i++) {
> +			if (tasks[opts.tasks[i]].auto_condition &&
> +			    tasks[opts.tasks[i]].auto_condition(&cfg)) {
> +				is_needed = true;
> +				break;
> +			}
> +		}
> +	} else {
> +		/* When not using --auto, we should always require maintenance. */

Nit: we might add a TODO comment here.

    /*
     * When not using --auto we always require maintenance right now.
     *
     * TODO: this certainly is too eager, as some maintenance tasks may
     * decide to not do anything because the data structures are already
     * fully optimized. We may eventually want to extend the auto
     * condition to also cover non-auto runs so that we can detect such
     * cases.
     /

Patrick
