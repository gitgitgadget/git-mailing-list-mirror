Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95204126BF7
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773607622; cv=none; b=ZXANyQEt7GYDDcYTS4TGsvxpidYSg46IthEZY+0U/mjWYDZYyEk3yX0KNF/EqnUUCGsbhUyKjTTDkoKzmmwWtPP5rBv6ReitnrxEv8A7FB4Buxrw6FB3bsZQLUoW5A19zq4EAlyxgp8CtUeUYkM6zUcI56g4k2dx+KLlvAfcKrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773607622; c=relaxed/simple;
	bh=3e0WUqf2Hri90pVpzrHaK6fvqOhmdwf92StdLjM/SoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ltuwpejb5+UvZJAMPn7NGah8EPajT/dKcmGv0R8wPTTKELLrodOPFqKjEEIcI/yY7AMuLKdAK4uWShrkp7ZzRFcK7zo6gMx0dqExxDNji/mh4VLXBP2FU/ZW3vuGXTmWQ/YLYqASDaK6X7k98Qh4fB+fs/RDu2YWAMdatqaghDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fDIUmtT9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AzZpcPze; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fDIUmtT9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AzZpcPze"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A05AEC001A;
	Sun, 15 Mar 2026 16:46:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 15 Mar 2026 16:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773607619; x=1773694019; bh=xFJ00LkaSW
	PtgYQ03Y/HBb4CeGjkWsCM7DLkhgGqLJg=; b=fDIUmtT9l9pPFMkGEA4agdaVLM
	AMWG56KUk1cwhSRBP/iubsHzuIF8IJuS7RflWqeN7ktUU/K84sJOvYxBUBrMDqls
	++LaXLkAK5yn3j4u9KP67TyEGvKiQWfYJuhBPx4DuV/McCJtp9O88mNauqLu4PDu
	7FNtl9yRSU458cMxiM4GrH1NL8hZNOh+vjiLduXBo590riLosqwanTyqb7jxa1Cu
	WksrlhVm5ucZRABP+QIvRmPp9Qg225cVgZPhUD//4Dl5Wd+uZSbZW6Bp6BZYbQbc
	crGzLOr0RixSyPZjUYhxZwedDuMqBkqMA+4VJLofmRUEgAKSjqXazSc/QtKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773607619; x=1773694019; bh=xFJ00LkaSWPtgYQ03Y/HBb4CeGjkWsCM7DL
	khgGqLJg=; b=AzZpcPzevWKR3MjvGVs2yYINW2hFxPsQMi0SjADAfdlm51AnNry
	rvPLBmZw4RueQlnwzcNmcyTi85wAugrUvwzZefFKH+sEDESSc+8TsgOG20gQsC+H
	/QEjhbvfN4EPgfecr2pBUUtTdNBBFMCknMHtgY4TAgYQDU9x3NG8pA1jj83LKDOe
	7XcBLIfnQjbiLGx2mNY+O0yH4H5LHVLgqQ9otKcva91JqqKj7N/q/Wuvr+dZXGXn
	omj4MrKYDz4uFCVU7iaPKEy6C9jRQEz9PwJ1C6cXhb3t6E3a9cosTOJp1pisaWBs
	NIOj/He6jA0hwgXPABPvpJ6wyLb6aUx312w==
X-ME-Sender: <xms:whq3afa2Vxvi8jiwG52WRiy4a8o1FEUWjCRamTY3_0Cv1iWlOTOqKg>
    <xme:whq3aWn78zNs5vu8IDB6gIr8RJvldmqtQTqe-HpWY_wmbB-oF8jFh7DQJmEvfLWY-
    em0tvrkWpFeYck9kZsw3ui7BBpP_HanV_TxSLu2i69tdSRMXjypOQ>
X-ME-Received: <xmr:whq3adgjCa-PJtwAamlXIjcGQYDw4JFjKbkdyGP45tfzxEIgvDmAKgYAcgafRFfjIewkJ3ciZ5LJei8LsSVrP3pyafh07GsHIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeigeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegvmhhilhihshhhrg
    hffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:whq3aQTZsHqHq9LUrKq8gQpAk4Jyxd7_zR13fcNRJsKTaK1eCDKwKA>
    <xmx:whq3aWZCRJ-ZNVWiLEswlpFPcjtREXbMpwAGpEoWr-5z7rR7dQZHzw>
    <xmx:whq3aVS8pMTcW64-P7b48pM_5PztQmiRQtPVSkGTS0e6pOyO7U4g0Q>
    <xmx:whq3ad_CkgAPX6RQ6kH8CEtL5gMHynsNX2xeMy6Nbzl0WAZosXJI2Q>
    <xmx:wxq3aXqPbWEWDH0oFw9EviYg8LdWR4727T0noAHLabvTxMW_XPHfq005>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 16:46:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Emily Shaffer <nasamuffin@google.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/9] hook: allow parallel hook execution
In-Reply-To: <20260309133739.294555-5-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 15:37:34 +0200")
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-5-adrian.ratiu@collabora.com>
Date: Sun, 15 Mar 2026 13:46:57 -0700
Message-ID: <xmqqjyvcstvi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> +hook.<name>.parallel::
> +	Whether the hook `hook.<name>` may run in parallel with other hooks
> +	for the same event. Defaults to `false`. Set to `true` only when the
> +	hook script is safe to run concurrently with other hooks for the same
> +	event. If any hook for an event does not have this set to `true`,
> +	all hooks for that event run sequentially regardless of `hook.jobs`.

This is very conservative and safe default.

> @@ -307,6 +316,7 @@ static void build_hook_config_map(struct repository *r,
>  			entry->command = command ? xstrdup(command) : NULL;
>  			entry->scope = scope;
>  			entry->disabled = is_disabled;
> +			entry->parallel = (int)(uintptr_t)par;

Hmm.  The source "par" is (void *) and the destination .parallel
member is a single bit, so would this

			entry->parallel = !!par;

be the same?  A cast first to uintptr_t, presumably not to lose
bits, and then casting it down to potentially narrower int made me
wonder what else is going on here that is tricky.

> +/* Determine how many jobs to use for hook execution. */
> +static unsigned int get_hook_jobs(struct repository *r,
> +				  struct run_hooks_opt *options,
> +				  struct string_list *hook_list)
> +{
> +	unsigned int jobs;
> +
> +	/*
> +	 * Hooks needing separate output streams must run sequentially. Next
> +	 * commits will add an extension to allow parallelizing these as well.
> +	 */
> +	if (!options->stdout_to_stderr)
> +		return 1;
> +
> +	/* An explicit job count (FORCE_SERIAL jobs=1, or -j from CLI). */
> +	if (options->jobs)
> +		return options->jobs;

This could be risky for hooks that claim they do not want to run
with others at the same time, but the CLI user ought to know what
they are using, so this override is very much appreciated.  After
all, the override may be serializing an overly optimisitic set of
hooks that want to run in parallel to avoid interaction between
them.

> +	/*
> +	 * Use hook.jobs from the already-parsed config cache (in-repo), or
> +	 * fall back to a direct config lookup (out-of-repo).  Default to 1.
> +	 */
> +	if (r && r->gitdir && r->hook_config_cache)
> +		/* Use the already-parsed cache (in-repo) */
> +		jobs = r->hook_config_cache->jobs ? r->hook_config_cache->jobs : 1;
> +	else
> +		/* No cache present (out-of-repo call), use direct cfg lookup */
> +		jobs = repo_config_get_uint(r, "hook.jobs", &jobs) ? 1 : jobs;
> +
> +	/*
> +	 * Cap to serial any configured hook not marked as parallel = true.
> +	 * This enforces the parallel = false default, even for "traditional"
> +	 * hooks from the hookdir which cannot be marked parallel = true.
> +	 */
> +	for (size_t i = 0; jobs > 1 && i < hook_list->nr; i++) {
> +		struct hook *h = hook_list->items[i].util;
> +		if (h->kind == HOOK_CONFIGURED && !h->parallel)
> +			jobs = 1;
> +	}

Losing "jobs > 1 &&" from the termination condition and instead
explicitly "break;" out when we demote jobs to 1 would be easier to
read, even though it would spend two more lines, i.e.,

	for (size_t i = 0; i < hook_list->nr; i++) {
        	struct hook *h = ...;
		if (...) {
			jobs = 1;
			break;
		}
	}


Other than that, very cleanly written.

Thanks.
