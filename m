Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3223FC2
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837152; cv=none; b=TLactV/6Wz5YaYisD1goP34BxarSqFJuUPMG067IeXjbC6RgVU2V5+6ARV3k9RJiybVPh3/6fQOeIVM2zg8JNzd1GRm6W1CkMta1J53Qpuq/e8GQNd8wRGfQQqd0hwFUxGaRAK7ELNt0HVEgkZJXp/rijbMQ2sGl0QYUicn5bIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837152; c=relaxed/simple;
	bh=Zwc6be3NYZBu4f1Cc0qboFRkxiFploJwhoMR/KMrt3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KD+sPRts/GQg1yppTLnumEuG8HuIKKG0tILbiGi5k5cEVUEf9WFO8TVqeSvRaIxQ1z0etOxcD5U2/51m1omZEhGuRIkBF8A6wsoIzE44UOfE1+8qpIfIVoZl+TPrPUhtUZopvyJoBEH14gCIKGfJ6IUC+rkWJJItEDAcGMZcPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f9FwO+Ka; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3nvuZSB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f9FwO+Ka";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3nvuZSB"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9FC31400128;
	Thu, 25 Sep 2025 17:52:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 25 Sep 2025 17:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758837148;
	 x=1758923548; bh=mbAOwg8AXHEvk8BAfCd53E46JZLI4qcilaMWnVikuZU=; b=
	f9FwO+Ka6dSUzuOSQC+HA9+AhOWRXMM0fIc3a/E9KlM3MN6Fw9SnvBxle09eoAgH
	JEM83jEhU+2znOpOGz4oQyQKHvHDJ5RCvbcaKXX9qSQn+e84rrZb6REBNW758Kie
	KT7Xak0lvEp7IKBopd/8hNzW10QNLrDtuSHM2ITsLgzfER3868/foyK+AiLW37ks
	Sezw3izNRwt0RBBGyAIqoZOVskoLKhuIliy0gBrBeGcsAeuBvBZDZwTduSr+niA3
	30+nP/3NnvfI2ldzqDs+6ggTcA/KNgrzi0+OrYDrz0PId2yKjS07kqPgcF1+sJLG
	tup1aTuzG70ZNlSdfRMqJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758837148; x=
	1758923548; bh=mbAOwg8AXHEvk8BAfCd53E46JZLI4qcilaMWnVikuZU=; b=h
	3nvuZSBoD7C6N0Rd8WFouWp9NzXO5qstadm10TmezkS5VUipG6SH6QfWj+ViC/T7
	llXrkmGXx5M3/1BLqyVQyW+js4akLoJkMtnqkYW5FABSxRrs0tEZISV38L7jwb3B
	MeRZGX5Yj7n54+d4spoy1lanyQurrWL3zTZUMytK4dNNVeDbgwGgnK2S3ZBcicFu
	gc16KLW89QwPOpny6yFMSRIH9fOgJXE3hKPCwKQPjic4Bt+I/9xwDCsXR2Q8I+jd
	Vf0AgX5JgFulTgnPGAhRDv0oYuZgUCTU9j4iF1VktRyzUU7z88ozhF6ho+oc0+lO
	VoMfwqCZqNc/2qkm63IfQ==
X-ME-Sender: <xms:nLnVaNch17G7aOmgXf9ficiPSEWoZws6YLsTwXxeVYhqjwgH1kMqJQ>
    <xme:nLnVaKSNnTNn8ddRX6QUeAnQcFTEvyJ6ZaVK6zBJhpGFULsVR-gdDf4EWV6lija_O
    4mwQ7A_1S_RchuJ3_9FKRclscgGtW67BzxX0-JOIXMwQSdLskx8kw>
X-ME-Received: <xmr:nLnVaMtkE-YjxHgpyc80ZRjywAc6achjpIAdeSbpv1kZTVyXiJwwlQirOaddbTMBRIiW612FOQYsC4M8w8MU1ZMGrrWsLWdye8xU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:nLnVaDdq3cx4izAl_TcTDmVvIxSLBpvJ8kiRPPhzdPViC9Ttk5ytBQ>
    <xmx:nLnVaOYxpuz1fDhP0x86MuN8xiFDshKgBW5rGk2l93uSkxOviQV8ZQ>
    <xmx:nLnVaNbgV2gf3h8GH-jRskOtNRbdKCC4I4C8Hy8z-BUJsNl4y4jVbw>
    <xmx:nLnVaLJPdr25DEjDBDX1fMvWLL0rIpDNB8GseWtV1pj4RRvD1QvFOg>
    <xmx:nLnVaE0M0rHPfS9ag4r0OVntyglDU3ILS5fOXHtutibJlKbKmBiHxr1D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 17:52:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Patrick Steinhardt <ps@pks.im>,
  Josh Steadmon <steadmon@google.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 06/10] run-command: allow capturing of collated output
In-Reply-To: <20250925125352.1728840-7-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Thu, 25 Sep 2025 15:53:49 +0300")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20250925125352.1728840-7-adrian.ratiu@collabora.com>
Date: Thu, 25 Sep 2025 14:52:27 -0700
Message-ID: <xmqqplbedwtg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> Some callers, for example server-side hooks which wish to relay hook
> output to clients across a transport, want to capture what would
> normally print to stderr and do something else with it. Allow that via a
> callback.
>
> By calling the callback regardless of whether there's output available,
> we allow clients to send e.g. a keepalive if necessary.
>
> Because we expose a strbuf, not a fd or FILE*, there's no need to create
> a temporary pipe or similar - we can just skip the print to stderr and
> instead hand it to the caller.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  builtin/fetch.c             |  2 +-
>  builtin/submodule--helper.c |  2 +-
>  hook.c                      |  2 +-
>  run-command.c               | 33 ++++++++++++++++++++++++---------
>  run-command.h               | 22 +++++++++++++++++++++-
>  submodule.c                 |  2 +-
>  t/helper/test-run-command.c | 15 +++++++++++++++
>  t/t0061-run-command.sh      |  7 +++++++
>  8 files changed, 71 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 24645c4653..53bd5552c4 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2129,7 +2129,7 @@ static int fetch_multiple(struct string_list *list, int max_children,
>  
>  	if (max_children != 1 && list->nr != 1) {
>  		struct parallel_fetch_state state = { argv.v, list, 0, 0, config };
> -		const struct run_process_parallel_opts opts = {
> +		struct run_process_parallel_opts opts = {
>  			.tr2_category = "fetch",
>  			.tr2_label = "parallel/fetch",

This ...

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 07a1935cbe..76cae9f015 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2700,7 +2700,7 @@ static int update_submodules(struct update_data *update_data)
>  {
>  	int i, ret = 0;
>  	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
> -	const struct run_process_parallel_opts opts = {
> +	struct run_process_parallel_opts opts = {
>  		.tr2_category = "submodule",
>  		.tr2_label = "parallel/update",

... and this ...

>  
> diff --git a/hook.c b/hook.c
> index 54568d5bc0..199c210b97 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -135,7 +135,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
>  	};
>  	const char *const hook_path = find_hook(r, hook_name);
>  	int ret = 0;
> -	const struct run_process_parallel_opts opts = {
> +	struct run_process_parallel_opts opts = {
>  		.tr2_category = "hook",
>  		.tr2_label = hook_name,

... and this are curious changes that are not explained in the
proposed log message.

> @@ -1841,6 +1852,10 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>  					   "max:%"PRIuMAX,
>  					   (uintmax_t)opts->processes);
>  
> +	/* ungroup and reading sideband are mutualy exclusive, so disable ungroup */
> +	If (opts->ungroup && opts->consume_sideband)
> +		opts->ungroup = 0;

Make it a BUG(""), which may help avoid unintended bugs, especially ...

> diff --git a/run-command.h b/run-command.h
> index 4679987c8e..ad0bab14b0 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -436,6 +436,20 @@ typedef int (*feed_pipe_fn)(int child_in,
>  				void *pp_cb,
>  				void *pp_task_cb);
>  
> +/**
> + * If this callback is provided, instead of collating process output to stderr,
> + * they will be collated into a new pipe. consume_sideband_fn will be called
> + * repeatedly. When output is available on that pipe, it will be contained in
> + * 'output'. But it will be called with an empty 'output' too, to allow for
> + * keepalives or similar operations if necessary.
> + *
> + * pp_cb is the callback cookie as passed into run_processes_parallel.
> + *
> + * Since this callback is provided with the collated output, no task cookie is
> + * provided.
> + */
> +typedef void (*consume_sideband_fn)(struct strbuf *output, void *pp_cb);

> +
>  /**
>   * This callback is called on every child process that finished processing.
>   *
> @@ -495,6 +509,12 @@ struct run_process_parallel_opts
>  	 */
>  	feed_pipe_fn feed_pipe;
>  
> +	/*
> +	 * consume_sideband: see consume_sideband_fn() above. This can be NULL
> +	 * to omit any special handling.
> +	 */
> +	consume_sideband_fn consume_sideband;

... because which one between this and ungroup gets precedence.
Document that they are mutually exclusive, and help the callers
with a BUG("") message when both are set.

> @@ -529,7 +549,7 @@ struct run_process_parallel_opts
>   * emitting their own output, including dealing with any race
>   * conditions due to writing in parallel to stdout and stderr.
>   */
> -void run_processes_parallel(const struct run_process_parallel_opts *opts);
> +void run_processes_parallel(struct run_process_parallel_opts *opts);

This is the same unexplained curiousity I touched earlier.

Thanks.
