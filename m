Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A0C35CB6B
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647285; cv=none; b=iVVKbIj+HEVuTFwDZwTnDBxetbOmOn3Fb0epoZvJjo2ENQue69VEwbncCYf29BvwmbpesZSm0dMS89oi3Sz89UZtpR0+dQrC6OY6q8CGoFS8NkDossoVuYJXCDyFS621a7G/reBB2FvtQZoWISyWic+hLs8nkANHLHxLHA5N6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647285; c=relaxed/simple;
	bh=WN092fGgVqjgKyRs6j2hgkLNXDI5Wlk40R+7Tgd/C2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbd6VDMDTWJ0tXqrSqLmKlquQlEiT1k8RxoG4CI8Bl0axq6wPpU0PgcOz//tJxIFJ+l19r7ufMvl/uyenY5K5Sl2ZD0LsEGyqsBxIQst5HDj9coEfy3ayhoMAgGckYBJzVq25Ljs9DG655SzQ5tTFN22KEYfaZPBMzjtfJmpE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oOhT6wD/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e64D8z4S; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oOhT6wD/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e64D8z4S"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4EDEB7A01D1;
	Mon,  9 Feb 2026 09:28:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 09 Feb 2026 09:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770647284; x=1770733684; bh=GGYel5qugW
	IZwAMJUTai5k/aUdatAfsRrkEplilQHWg=; b=oOhT6wD/Dhf2N1sl7RKQvtnb+F
	BlJY32XAw+VL/rSAZys544jdkyjDVcnR3OwUkTW4k6kDQgPgCzF3jjPSShfDMLuT
	Kq5V5QWSYpQ08fBF5oQkcxHInN6x1KRfleAp+CiWOiqhpd40UnRinfYs9hdEdFF8
	CqWVTn+Bo05joKhEt0RhPzKUPNN+iIz3c+N+AN0OYZbuC9Kgi7U9XAVXLytkeV6v
	JX3aYfgYGlAwpQrscsrs3VC+WHHQIheAQq1jUUQQ08ZNJqJXLhnWT4T1/nZCgHJG
	OF/tYd4H+BTyIBvbdeFF1f7kBk6z/IB2rzYbN9dEKCBT95pYrjKFTcs8dsFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770647284; x=1770733684; bh=GGYel5qugWIZwAMJUTai5k/aUdatAfsRrkE
	plilQHWg=; b=e64D8z4S0qFN6ZsrpfzTr3OMuFZv8ydOJYo2wLyiKYb6HzdI44z
	dzd/B7DaI2+LKDDZYtc/SGfJaxPfj4DkTEFcrNOcJK9rozbVULNR9WwoDq3PNR6q
	l3n5ByLIZmaMyslWVfrNKeJzpeLfI7g6FshC2ctrLtj0OaYJENg+XJatQNpzdmPE
	CN9nAq5Ho9O26TAi8xQpuZYTJuhtjMuiSCwWbAC2RkHUA6TVclGCuLuKGm+uFgGq
	kutSRf+4cZSywcNGNqKtQRvMWpJR+N/scfo9Dfn6Zi7GpACJNFVCdd+QfkLM66rq
	GLkGDxAW4cCmXBfmBI9B4fkjquP8vYZuQvg==
X-ME-Sender: <xms:8-6JaclAagR53CqZ3lxN_yebPfILlj2B2g_cXflQ7HnDOIw9NLJCKg>
    <xme:8-6JaeEvjF2oTZxVo4Y3GjUJCvJ_UrJkHO-D1XwEZZbRwyWMsVNSdenlZG7ATmbnB
    -sZds4M27WLnESWUz1k7txltvvwTJ0xO1iCgRktptHBUDp4G-65hg>
X-ME-Received: <xmr:8-6Jac5kZPQAMja181mB2kaSk_rCvR979vCJKJ6UJfKFglfoDcA3TG6KjGTneH8f8zfOHMCKZ8E3sZtevGNp26fh8L-h8bJlai0jSudcmlI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegr
    ughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsth
    gvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgrfhhf
    vghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8-6Jaelt52GpikW7umCk7rcE0DxZbV57o64iOW4Qycp6lbSZ4R9JmQ>
    <xmx:8-6JaZr2yUQyj-de6sv5ZCU4mCDx7TDVtSHKKGSAa2wXcoE_dmLMwg>
    <xmx:8-6JaVu70fEHACGcSOz9Egetku4fkC6MHNhl518M30Rq4MnpzYt7Mg>
    <xmx:8-6JaWHjXnrGQ4OO0xTc8gLFsPnF3Y2O6A0P41s2-2mg2vwH9wqRNA>
    <xmx:9O6Jaa5l7YrDqfF8zm9mnYEnfPiHUKkFoFWMMWA6GFpqhRG-RrVA44sM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 09:28:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 227f7dae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 14:28:00 +0000 (UTC)
Date: Mon, 9 Feb 2026 15:27:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 1/4] hook: run a list of hooks
Message-ID: <aYnu7e_hbSBwu9_N@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260204165126.1548805-2-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204165126.1548805-2-adrian.ratiu@collabora.com>

On Wed, Feb 04, 2026 at 06:51:23PM +0200, Adrian Ratiu wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
> 
> Teach hook.[hc] to run lists of hooks to prepare for multihook support.
> 
> Currently, the hook list contains only one entry representing the
> "legacy" hook from the hookdir, but next commits will allow users
> to supply more than one executable/command for a single hook event
> in addition to these default "legacy" hooks.
> 
> All hook commands still run sequentially. A further patch series will
> enable running them in parallel by increasing .jobs > 1 where possible.
> 
> Each hook command requires its own internal state copy, even when
> running sequentially, so add an API to allow hooks to duplicate/free
> their internal void *pp_task_cb state.

I think the order in this commit message is a bit off. We typically
first state the problem that we aim to solve before presenting the
solution.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index b5379a4895..72fde2207c 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -849,7 +849,8 @@ struct receive_hook_feed_state {
>  
>  static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_task_cb)
>  {
> -	struct receive_hook_feed_state *state = pp_task_cb;
> +	struct string_list_item *h = pp_task_cb;
> +	struct receive_hook_feed_state *state = h->util;
>  	struct command *cmd = state->cmd;
>  
>  	strbuf_reset(&state->buf);
> @@ -901,6 +902,24 @@ static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_
>  	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
>  }
>  
> +static void *copy_receive_hook_feed_state(const void *data)

Nit: our coding guidelines say that the name of the struct should come
first. So this would be `receive_hook_feed_state_copy()`.

> +{
> +	const struct receive_hook_feed_state *orig = data;
> +	struct receive_hook_feed_state *new_data = xmalloc(sizeof(*new_data));
> +	memcpy(new_data, orig, sizeof(*new_data));
> +	strbuf_init(&new_data->buf, 0);
> +	return new_data;
> +}
> +
> +static void free_receive_hook_feed_state(void *data)

Likewise, this would be `receive_hook_feed_state_free()`.

> diff --git a/hook.c b/hook.c
> index cde7198412..fb90f91f3b 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -47,9 +47,49 @@ const char *find_hook(struct repository *r, const char *name)
>  	return path.buf;
>  }
>  
> +/*
> + * Provides a list of hook commands to run for the 'hookname' event.
> + *
> + * This function consolidates hooks from two sources:
> + * 1. The config-based hooks (not yet implemented).
> + * 2. The "traditional" hook found in the repository hooks directory
> + *    (e.g., .git/hooks/pre-commit).
> + *
> + * The list is ordered by execution priority.
> + *
> + * The caller is responsible for freeing the memory of the returned list
> + * using string_list_clear() and free().
> + */
> +static struct string_list *list_hooks(struct repository *r, const char *hookname)
> +{
> +	struct string_list *hook_head;
> +
> +	if (!hookname)
> +		BUG("null hookname was provided to hook_list()!");
> +
> +	hook_head = xmalloc(sizeof(struct string_list));
> +	string_list_init_dup(hook_head);
> +
> +	/*
> +	 * Add the default hook from hookdir. It does not have a friendly name
> +	 * like the hooks specified via configs, so add it with an empty name.
> +	 */
> +	if (r->gitdir && find_hook(r, hookname))
> +		string_list_append(hook_head, "");

Why is there a check for `r->gitdir` here? Do we ever execute hooks
outside of a fully-initialized repository?

Other than that, we now insert hooks into the list. It's somewhat
surprising that we insert hook "names" here, instead of for example
adding the full hook path to the list. Is there any specific reason for
this decision?

> +	return hook_head;
> +}
> +
>  int hook_exists(struct repository *r, const char *name)
>  {
> -	return !!find_hook(r, name);
> +	int exists = 0;
> +	struct string_list *hooks = list_hooks(r, name);
> +
> +	exists = hooks->nr > 0;
> +
> +	string_list_clear(hooks, 1);
> +	free(hooks);
> +	return exists;
>  }
>  
>  static int pick_next_hook(struct child_process *cp,

And here we verify that there's at least one such hook that we found.
Which would currently mean that the hook in ".git/hooks/" exists.

> @@ -58,10 +98,11 @@ static int pick_next_hook(struct child_process *cp,
>  			  void **pp_task_cb)
>  {
>  	struct hook_cb_data *hook_cb = pp_cb;
> -	const char *hook_path = hook_cb->hook_path;
> +	struct string_list *hook_list = hook_cb->hook_command_list;
> +	struct string_list_item *to_run = hook_cb->next_hook++;
>  
> -	if (!hook_path)
> -		return 0;
> +	if (!to_run || to_run >= hook_list->items + hook_list->nr)
> +		return 0; /* no hook left to run */

Hm, okay. Wouldn't it be a bit more ergonomic to instead store the index
of the current hook instead of storing the string list item itself? In
that case we could verify whether `hook_cb->hook_cur < hook_list.nr` or
something like this.

> @@ -85,33 +126,50 @@ static int pick_next_hook(struct child_process *cp,
>  	cp->trace2_hook_name = hook_cb->hook_name;
>  	cp->dir = hook_cb->options->dir;
>  
> -	strvec_push(&cp->args, hook_path);
> +	/* find hook commands */
> +	if (!*to_run->string) {
> +		/* ...from hookdir signified by empty name */
> +		const char *hook_path = find_hook(hook_cb->repository,
> +						  hook_cb->hook_name);
> +		if (!hook_path)
> +			BUG("hookdir in hook list but no hook present in filesystem");
> +
> +		if (hook_cb->options->dir)
> +			hook_path = absolute_path(hook_path);
> +
> +		strvec_push(&cp->args, hook_path);
> +	}

We could avoid this special casing if we stored the absolute paths in
the hook list right away. But maybe there is a good reason you don't.

> +	if (!cp->args.nr)
> +		BUG("configured hook must have at least one command");
> +
>  	strvec_pushv(&cp->args, hook_cb->options->args.v);
>  
>  	/*
>  	 * Provide per-hook internal state via task_cb for easy access, so
>  	 * hook callbacks don't have to go through hook_cb->options.
>  	 */
> -	*pp_task_cb = hook_cb->options->feed_pipe_cb_data;
> -
> -	/*
> -	 * This pick_next_hook() will be called again, we're only
> -	 * running one hook, so indicate that no more work will be
> -	 * done.
> -	 */
> -	hook_cb->hook_path = NULL;
> +	*pp_task_cb = to_run;
>  
>  	return 1;
>  }
>  
> -static int notify_start_failure(struct strbuf *out UNUSED,
> +static int notify_start_failure(struct strbuf *out,
>  				void *pp_cb,
> -				void *pp_task_cp UNUSED)
> +				void *pp_task_cb)
>  {
>  	struct hook_cb_data *hook_cb = pp_cb;
> +	struct string_list_item *hook = pp_task_cb;
>  
>  	hook_cb->rc |= 1;
>  
> +	if (out && hook) {
> +		if (*hook->string)
> +			strbuf_addf(out, _("Couldn't start hook '%s'\n"), hook->string);
> +		else
> +			strbuf_addstr(out, _("Couldn't start hook from hooks directory\n"));
> +	}
> +
>  	return 1;
>  }

Okay, here we can give a bit more detail in the error message. But that
alone doesn't quite feel worth the additional complexity.

> @@ -172,26 +231,50 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
>  	if (!options->jobs)
>  		BUG("run_hooks_opt must be called with options.jobs >= 1");
>  
> +	/*
> +	 * Ensure cb_data copy and free functions are either provided together,
> +	 * or neither one is provided.
> +	 */
> +	if ((options->copy_feed_pipe_cb_data && !options->free_feed_pipe_cb_data) ||
> +	    (!options->copy_feed_pipe_cb_data && options->free_feed_pipe_cb_data))
> +		BUG("copy_feed_pipe_cb_data and free_feed_pipe_cb_data must be set together");

I wonder whether it would make the commit a bit easier to review if you
split it up into two:

  - One commit that introduces the copy/free callback functions.

  - One commit that introduces the hook list.

Then the changes would be a bit more focussed.

>  	if (options->invoked_hook)
>  		*options->invoked_hook = 0;
>  
> -	if (!hook_path && !options->error_if_missing)
> -		goto cleanup;
> -
> -	if (!hook_path) {
> -		ret = error("cannot find a hook named %s", hook_name);
> +	if (!cb_data.hook_command_list->nr) {
> +		if (options->error_if_missing)
> +			ret = error("cannot find a hook named %s", hook_name);
>  		goto cleanup;
>  	}
>  
> -	cb_data.hook_path = hook_path;
> -	if (options->dir) {
> -		strbuf_add_absolute_path(&abs_path, hook_path);
> -		cb_data.hook_path = abs_path.buf;
> +	/*
> +	 * Initialize the iterator/cursor which holds the next hook to run.
> +	 * run_process_parallel() calls pick_next_hook() which increments it for
> +	 * each hook command in the list until all hooks have been run.
> +	 */
> +	cb_data.next_hook = cb_data.hook_command_list->items;
> +
> +	/*
> +	 * Give each hook its own copy of the initial void *pp_task_cb state, if
> +	 * a copy callback was provided.
> +	 */
> +	if (options->copy_feed_pipe_cb_data) {
> +		struct string_list_item *item;
> +		for_each_string_list_item(item, cb_data.hook_command_list)
> +			item->util = options->copy_feed_pipe_cb_data(options->feed_pipe_cb_data);
>  	}

Makes sense. We cannot just peform a shallow copy of the callback data
as it may contain data itself that needs to be copied. So we have to
handle the copying ourselves.

One thing I wondered is whether it would lead to a cleaner design if
this was instead provided as a callback to allocate and initialize a
completely _new_ callback data. In that case the caller wouldn't have to
first initialize the data only to copy it in a different place, all the
logic would be self-contained in that one callback.

The downside would of course be that we cannot use for example the
stack, and it might make it harder to reuse state across multiple hook
invocations, if that's a feature we care about.

Patrick
