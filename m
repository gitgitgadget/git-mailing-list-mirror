Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B7334372
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770328786; cv=none; b=NIUeLlFSafqI700sxjCmfbCvhXil0C4G4Xo1Btc9284vbcF6rJlmohYqoPTi1YqeKVYs52XneotnayV4qhFiSALgB43C0hWN5hWgUwdQQfnRDdh0wEy7ieoiQhcE9mnZ8JvlTO7SMh1/tHJDQE4xM9bhpV8XUzR5Z+qSCnwK5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770328786; c=relaxed/simple;
	bh=7Z4gYTJkiJAjE6cAXDH2WDeqO2JI4aLb+bJyct7rMms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r+HlvgEI0zBi1UyuonQvXjZ/8O2wwCRcxeKfPR613zhP/zjnzIjmXaYdG6lvsCGGxfTjcFue2WvdlENBEj14dxAEiS3rW+KPcgyBri/D8+1mLe8+C2bf321TFoVch+ir/jwD7pey3IIS8WkzcbYybHSCtzRJ+9/vZ7SbD6YfcmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RzoD4o5E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cLk0VKO3; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RzoD4o5E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cLk0VKO3"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C24C5EC00DF;
	Thu,  5 Feb 2026 16:59:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 05 Feb 2026 16:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770328785; x=1770415185; bh=W2/q0gXh5r
	SPSlz2DxTcX5sdsDGpI2dX8AINA7Ys/AE=; b=RzoD4o5Ecvgrn6k7SSqXgm5oID
	Hq087zj34Lm5ne3AIzehxmQ0q/rxGmFTRp6P9hrPcR8wA2znxS+SYpnhGuhpSnRa
	Qodj3R1+Os3gvWG+FUXEjTwI1iwWYPjRT2MxkUVZuzzMPdSbANa0sjHxvBGxcwzI
	b+u12rFKNKCVFmInHKKtuLbJE0PnzY8Jam5pZpII0iXcbz0vJ0UE2q+KFUtQV39C
	HlawZx0A9SYjqlg1lks2Pm29HsNEWaWirNLB1F46H7YadXauCNyx8GOF4JhiPX80
	6riqBT7Qz9RU4qS/XvBn/Qywfmuwi415sZ2TLeW+IuZ+Z5weY8Og9Kjo84Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770328785; x=1770415185; bh=W2/q0gXh5rSPSlz2DxTcX5sdsDGpI2dX8AI
	NA7Ys/AE=; b=cLk0VKO3ghjiipQlhw3Z23SVXsJpLRF+RQ0BXyXowqXqtt4apk2
	tCc0L9He08jXZDGEaekp7o66Q1pIyG/0DVs4d/rr9y5WMqx/ai/CimkmPi3J3Uox
	01PTJ4fVRx5I+ZgpaVp71lk5P/zUoE1scs47Ph2UPVLj8SD1b/4ceSBchfdfwMwF
	L5Y7QR0nFTq6LaRgc0DwZEW8gA0BDEkyE1s1i+llhhk0KsWd6Srk/3mlvfhHlJqy
	8+/4SGcuRlF/Lb0M3loTwApXB99biolbhhy26Q8CxO1H8T7zps2cDnJeuuq7xCEk
	IWeMnbAOTOgYoOpCI70AtIh1jXg75jB3IAg==
X-ME-Sender: <xms:0RKFaTq71iRfDA9OHviedWBBWiEM-EzFEsgb8pDHPIG2SjFLV_L2qQ>
    <xme:0RKFacvOhA8FfgPw_WpqlC1nalE6k_5qg6aajd6FNafEa73eO2YcFusPpeVdC2pdE
    q34SlBypajGlId5xbCxcKqXl3y1kTQFtlACQHKNvEsxweX_6BHdCA>
X-ME-Received: <xmr:0RKFaWYsBy7WktH0cUoVjMTL0tCAdIjLgRTnQ57GrliIDlCQpyTOki7cHu1kR1uBvxl7z3d1g-Ig0enRGWzoAeVHj3TlutiQ8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeigeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0RKFaTap4uGVt3MfxT5vAUV0_zwku0Ksj_EO5FB64q0JO-9J6-6Csw>
    <xmx:0RKFaXkej8skCpX1QVxieMan6JQYZep2J0odBd99PD2MF5rKxrWA3g>
    <xmx:0RKFaW2tlCcSBbypMWfGx9ra3GEVJEbGUTwZ9f_FRbD5SUadZoHx6A>
    <xmx:0RKFaf0VXVdX5ToI_RalT0JpzXVRLwt7KPN3D_wRP4xYsqSf9L50Tg>
    <xmx:0RKFaRtzAwH7-D0gd_X8rMv69OsPbZrxQMW5aDCzDK-Qlm25a1N4OHgX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:59:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 1/4] hook: run a list of hooks
In-Reply-To: <20260204165126.1548805-2-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 4 Feb 2026 18:51:23 +0200")
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
	<20260204165126.1548805-2-adrian.ratiu@collabora.com>
Date: Thu, 05 Feb 2026 13:59:43 -0800
Message-ID: <xmqqqzqykg1c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

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

So the new calling convention is to give a string_list_item to the
callback function, whose .util member has the historical "state".  OK.


> @@ -944,6 +963,8 @@ static int run_receive_hook(struct command *commands,
>  	strbuf_init(&feed_state.buf, 0);
>  	opt.feed_pipe_cb_data = &feed_state;
>  	opt.feed_pipe = feed_receive_hook_cb;
> +	opt.copy_feed_pipe_cb_data = copy_receive_hook_feed_state;
> +	opt.free_feed_pipe_cb_data = free_receive_hook_feed_state;
>  
>  	ret = run_hooks_opt(the_repository, hook_name, &opt);
>  
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
> +
> +	return hook_head;
> +}

OK.  I would have expected the caller to supply a string_list
(presumably an empty one would be the most common usage) and the
only responsibility for this function would be to stuff found hooks
to the given string_list.  But this arrangement to give a newly
created string list would work just fine as well.

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

OK.  It is not just "git hook list", but the internal function
list_hooks() that is the topic of this step of the series.  So
anywhere that uses find_hook() in the current codebase is a good
candidate to migrate to use the new function when appropriate, and
this is one of such places.  I presume that find_hook() will stay to
be a "find the program in $GIT_DIR/hooks/ directory" function that
has a single answer (i.e. pathnmame), but the list_hooks() may
return more than one string_list_item, one of them might be the
traditional hook and others may come from somewhere else.  Do they
need to be differentiated in some way (i.e., Is "where did the come
from?" a legitimate thing for a caller of list_hook() to ask)?
There are many unknowns while reading this step because we still
haven't seen the other sources of the hooks.

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
>  
>  	cp->no_stdin = 1;
>  	strvec_pushv(&cp->env, hook_cb->options->env.v);
> @@ -85,33 +126,50 @@ static int pick_next_hook(struct child_process *cp,
>  	cp->trace2_hook_name = hook_cb->hook_name;
>  	cp->dir = hook_cb->options->dir;
>  
> -	strvec_push(&cp->args, hook_path);
> +	/* find hook commands */
> +	if (!*to_run->string) {
> +		/* ...from hookdir signified by empty name */

Make a macro or a small helper function that takes a single
string_list_item that is an element in the return value of
list_hooks(), and tells if it is a program in $GIT_DIR/hooks/
directory.  Writing code that depends on this "we did not bother to
invent a way to allow users to give friendly names to traditional
on-disk hooks, so it is registered with an empty string as its name"
convention and having to document it is inefficient, both for
writers of the code and for readers of the code.

Or perhaps the .util member of each of these can be a pointer to
something like:

	struct {
		enum {
                	HOOK_TRADITIONAL, HOOK_CONFIGURED,
		} kind;
		union {
			struct {
				const char *path;
			} traditional;
			struct {
				const char *friendly_name;
				const char *path;
				... maybe others ...
			} configured;
		} u;
	}

so that this codepath does not even have to ...

> +		const char *hook_path = find_hook(hook_cb->repository,
> +						  hook_cb->hook_name);

... run the same find_hook() again here?

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

Ditto.

> +			strbuf_addf(out, _("Couldn't start hook '%s'\n"), hook->string);
> +		else
> +			strbuf_addstr(out, _("Couldn't start hook from hooks directory\n"));
> +	}
> +
>  	return 1;
>  }
