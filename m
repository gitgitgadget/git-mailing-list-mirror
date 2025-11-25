Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAED22FDE6
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112532; cv=none; b=NBnXmX/w8uTmiCFXPwLaUJvihMTq2/gy8RH5HcOnYd6rufgHP+7Ofj9IBrx+HR8TWeHBHKhG2hfcuFlEcywyPjJtGqAD3/EXYETLfcnVd9zMH9ZPxF17bTSzb4BI2hQ1LfPha65Ai/0OK7NHPW9iQi0mwU2Mlzl4Rqzw8ERm5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112532; c=relaxed/simple;
	bh=ei9CVfjWl7ES5tbHvfDRsl732GKtCkI7mXzmPh4tWrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bfq2/r1+HueSEgepEDCqnJ8vVBuBQxQ/5Jm/mqswuXRAxjlF1aKmNhCTh/D+t6XYsQWYSd9c7RUpPEo6ku3H6E7d3546tgcWTIkr7KEj7CXOq+Ein+xhGFo0Xn3QDQLvwywRwA2MqsZZHMldBt1VYkNCS9AcK9CodiW/OqGpuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fLwSZQm0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sZnNa0HI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fLwSZQm0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sZnNa0HI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC0CF1400130;
	Tue, 25 Nov 2025 18:15:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 25 Nov 2025 18:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764112528; x=1764198928; bh=u1d+0WVyvP
	QAIe3XbyPoRhQDBHkAHN3D3hB50c7CUB8=; b=fLwSZQm0EgX/oU1WLiDMQsow/6
	gh6lxhxivttXjnS74HEqOJxVJarO3IiKBv7iDJMuWmkeusq2Gvo1gmrMvScltE9h
	TI/dBAu0fi48RhQNncM1SFxbwihazdC1ni2/z2Ftqm/NDoMVQEDXjVOzWsVLoZHI
	c81WY44MeJoe/ZJakI7v5TNSVocqueT8aN/X0N/tzT36Oof3oW5TVwD/cORVHoJL
	fQ8h5cZXbrLvpyJ3m3XYt+YDOHdDs0SD7hXIFMJus8ZEGoTahBkTb0BDJK3bbEkG
	g1aRbxFYWT2STaF2HpyHa4Fpzk/vbaLUR2wPPPPoEA7H3sHaglQKiKkVCvRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764112528; x=1764198928; bh=u1d+0WVyvPQAIe3XbyPoRhQDBHkAHN3D3hB
	50c7CUB8=; b=sZnNa0HI1Qc197XdsWSTbuaqXWU4OmL3g/LPuXvesTEIiN4mCll
	/N8cLbWYfxUEyAr4xfgYI/8uTbENl6qFM/lP0Eh1/hzFViSBB04ke0f1Mfc4W2k0
	MZxQp1ei3OhmXeY0S58qArXe9iiuLRqdVgeJI/B9eip332Pb/Y+/Na2uECON97wn
	iJIdGjr99QYxtGbvd5qQJkEgi0o2Jq2aBEedadW3gzUmhzl3ualKs9d2g9fNa7Jr
	QIArmrgSpOx68izFphIYVvURqlbuBHBwkP3NRS3bacqzLaUeAP0/o1bHjAkpKPQh
	Im5/xsfNQAeXS1smVW8EwvF+43gFz6YkBUQ==
X-ME-Sender: <xms:kDgmaQHP5vj_wyluPo1vH9imbgGkW1nvZEjkwUrcVvxs-B1KVpyxAA>
    <xme:kDgmaRgan83kxqVn4853ktxflGAZqQw_yfmhwA6q29DeH62uqWD00-W1WPnYJ2cJf
    t3E5BzaJRJrveDQh8G-B5lWFeL03iuzDFAjW5Kv1wUHPocwkhQ1GQ>
X-ME-Received: <xmr:kDgmaVtuyuUIu6kFW8VTCksVK4S4M-D9qRumhjcKNuH1B170VFzJFBejRbIfne1mdQC63nU-pUzbUWWc56E0miPvLz056tsYTLmt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:kDgmactEs764x3SI4M9RdsMKYmub0Ub7fxktQDCN46BmCcHQsn4SSA>
    <xmx:kDgmaSHwlK7YE0risfXkxoeZg13OopO6IhmZGVj-SbSQ3kEkzww5bw>
    <xmx:kDgmafO2eBi23h4cl29gliFzmHm776GJGESZEmSRrSefjoDfXJPMVg>
    <xmx:kDgmaZJSkxGfs-IBK59MTdRYOTzxYwhM9ZU-V7_P3R7jcHSewB4ZXg>
    <xmx:kDgmafXKO5kuVmVe3ROED8pA5WqbF-14FCb1Bxc9Mk73fwThZOLmSlrs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 18:15:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Patrick Steinhardt <ps@pks.im>,
  Josh Steadmon <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v3 01/10] run-command: add stdin callback for
 parallelization
In-Reply-To: <20251124172043.1650014-2-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 24 Nov 2025 19:20:34 +0200")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20251124172043.1650014-1-adrian.ratiu@collabora.com>
	<20251124172043.1650014-2-adrian.ratiu@collabora.com>
Date: Tue, 25 Nov 2025 15:15:26 -0800
Message-ID: <xmqqsee1puup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> +static void pp_buffer_stdin(struct parallel_processes *pp,
> +			    const struct run_process_parallel_opts *opts)
> +{
> +	/* Buffer stdin for each pipe. */
> +	for (size_t i = 0; i < opts->processes; i++) {
> +		struct child_process *proc = &pp->children[i].process;
> +		int ret;
> +
> +		if (pp->children[i].state != GIT_CP_WORKING || proc->in <= 0)
> +			continue;

This combination of two conditions is a recurring theme in this
series (e.g., something close to the reverse of this is called
child-ready-for-cleanup later).

I wonder if it makes the code easier to follow if we add a set of
helpers that take a pointer to &pp->children[i] (and we probably
should give the struct that describes each child managed in the
"struct parallel_processes" some name) and asks "is this thing
done?" etc.

> +	/*
> +	 * Child tasks might receive input via stdin, terminating early (or not), so
> +	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
> +	 * actually writes the data to children stdin fds.
> +	 */
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
>  	pp_init(&pp, opts, &pp_sig);
>  	while (1) {
>  		for (i = 0;
> @@ -1792,13 +1864,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>  		}
>  		if (!pp.nr_processes)
>  			break;
> -		if (opts->ungroup) {
> -			for (size_t i = 0; i < opts->processes; i++)
> -				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
> -		} else {
> -			pp_buffer_stderr(&pp, opts, output_timeout);
> -			pp_output(&pp);
> -		}
> +		pp_handle_child_IO(&pp, opts, output_timeout);

OK, this helper roughly does the same thing as the removed if/else
(and a bit more).

> @@ -1809,6 +1875,8 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>  
>  	pp_cleanup(&pp, opts);
>  
> +	sigchain_pop(SIGPIPE);

OK.

> diff --git a/run-command.h b/run-command.h
> index 0df25e445f..e536ed7544 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -420,6 +420,22 @@ typedef int (*start_failure_fn)(struct strbuf *out,
>  				void *pp_cb,
>  				void *pp_task_cb);
>  
> +/**
> + * This callback is repeatedly called on every child process who requests
> + * start_command() to create a pipe by setting child_process.in < 0.
> + *
> + * pp_cb is the callback cookie as passed into run_processes_parallel, and
> + * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> + * The contents of 'send' will be read into the pipe and passed to the pipe.

There is no 'send' seen around here.  Does this refer to something
a later step adds?
