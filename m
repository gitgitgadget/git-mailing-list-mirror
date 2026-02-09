Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09A35CB6B
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647293; cv=none; b=gbXOTEioahlekGD1ppVqdBB+fDDshr7TYwYYkuYKzM6KQ63aw6zZUYJF0vm2wU5WQ1iJhIhRpMTFMF/LieD4rMj8ozOBKMdZ9RHrenRX5YQ1B3Zhup7CFDO/e753ELsgNsLLkEdDDZ9NZ1HUM1PinXmBkLHmFH2C/8b/6Gv4XYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647293; c=relaxed/simple;
	bh=W7ajFymaPsO4rKPj0R2Xwzfcaiw+sjmclUXnHHu9NIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2+JHtQn2VrbQQcYx+eJkwZTx5sUz+MBN8etwfA4snPK4o3VPIMt0FcWWnf5JE/Ld6euKo3fyFFmOLFfmas43Cv4jLtBR/1vRS7sZU7NyMLsyQBeWrU+l6hZnTd/Du/jis8Jr+xY3uqs1QhoRGtgTcPVTD6zCd7NPjui3wjYGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X7oaZ7Ep; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oqpDiscb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X7oaZ7Ep";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oqpDiscb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39C9C7A01D3;
	Mon,  9 Feb 2026 09:28:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Feb 2026 09:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770647292; x=1770733692; bh=Kd/CEO3C+h
	FbmLSD8LygeeaKl0gYaSLiie1l2OWTud0=; b=X7oaZ7EpP4Auf/cgsG9PYIqSc5
	zYHcvZfTfWV350Q2TxihLEh/cgQsBB4JEisDOnBHArMkxbqepod2jUArQz1QGqH5
	uXOsifp0eFEXxmLtr4xYGcMOWOn1816G5WcifWCr2l+kZHvJ9FwWz+j5nJkqH8av
	/LFn2frtouEh3SN6D/xV7pA05sXeCuvHrd5I+QvNoyw8YNaEqIvOa2xfU8Di1PaV
	0nj5DZXUiqtr/UFzIJctstwxk31f0xghP1Md9bdl8fV7IjUxqPUywFx2AP7oF3PJ
	hcWLr3KyWXqqItQ8hzX0yzYUoS8MFyp4Bq/qNZS1m6slNSz/vtsMXG6LQrdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770647292; x=1770733692; bh=Kd/CEO3C+hFbmLSD8LygeeaKl0gYaSLiie1
	l2OWTud0=; b=oqpDiscbRnWzEAwszqEjP+GB0rF3VcBIw55/8uyzbkIsbGbRTA0
	eKej9fjGUyLhbrffTzcOyCK27uuZRiesdaYkD7+vnJbTJjk7zgUsdgLx/qYGovUo
	Y9naHQIfZWHrJOGKE7kbfr75xmzk0N7d7BeuKUpGwNdehgonYlH/oFpRob1j8Jcz
	mnKHOCjihYtlgVS95d65uE/K5k/+4QNiHNfcGcn61xboElLFFU8bxCjh2vEH57iF
	vvlkkumCJHpLlqhb4RNVJkHXC/ybbwNVFfoIB3ds1W2Bi8jPD3S+S4EKeIz2ARQn
	xjufMGqG9VOwotoUhGeDWjN/cQAnMAnFbVQ==
X-ME-Sender: <xms:--6JaaKqn_Vmu-On3Oglyf3lVnve_cCEKMhn3T3Ok5H2VdbZAyLY7Q>
    <xme:--6JaUY3b9BdN7jcH2qc8wqhbYv1TsLJQNx0MGTrnvVtPqgK8VVbUD3mq2WklVQHl
    satgcTZC2NpXqO0lGoOZy5bccNnHPRkr9d2GABTzfQcsBQYcuhIWA>
X-ME-Received: <xmr:--6Jac9Izz4PIZouoxWCW49XcGUWDRyBFchxV7J1dgHiCyIpwPKshopjDhCTlPGTGF_HUmItU-sHPxhGeibApnzhlIlTWENaol4XLH_z2nU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoh
    epshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:--6JaVZoLynfBLllOpm7NtlYXJNjNM7ILJASsPXBpIXo3HXiUt_coA>
    <xmx:--6JaQOF6SsBfB_Iorl2B2-eKVF1cO7C8gOIEMy21a5nuMnpIKsxEg>
    <xmx:--6JaRC0_wonnqYt_Dn2dH1vBTxbl5hKAT6aVfA096dApRj4_ietQw>
    <xmx:--6JaXJmQL2eSOxQXwokKlAan8M5C4nqwCOR_0TwB3SgLT1NvH0iNQ>
    <xmx:_O6JaWObM-QRgdgjEYrtfuTY2cVO6UjFS0vUX0S9bcelnqF-KZd4sPxC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 09:28:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a3dee21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 14:28:09 +0000 (UTC)
Date: Mon, 9 Feb 2026 15:28:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 3/4] hook: include hooks from the config
Message-ID: <aYnu9gJATVJeKEjZ@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260204165126.1548805-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204165126.1548805-4-adrian.ratiu@collabora.com>

On Wed, Feb 04, 2026 at 06:51:25PM +0200, Adrian Ratiu wrote:
> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
> new file mode 100644
> index 0000000000..49c7ffd82e
> --- /dev/null
> +++ b/Documentation/config/hook.adoc
> @@ -0,0 +1,17 @@
> +hook.<name>.command::
> +	A command to execute whenever `hook.<name>` is invoked. `<name>` should
> +	be a unique "friendly" name which you can use to identify this hook
> +	command. (You can specify when to invoke this command with
> +	`hook.<name>.event`.) The value can be an executable on your device or a
> +	oneliner for your shell. If more than one value is specified for the
> +	same `<name>`, the last value parsed will be the only command executed.
> +	See linkgit:git-hook[1].
> +
> +hook.<name>.event::
> +	The hook events which should invoke `hook.<name>`. `<name>` should be a
> +	unique "friendly" name which you can use to identify this hook. The
> +	value should be the name of a hook event, like "pre-commit" or "update".
> +	(See linkgit:githooks[5] for a complete list of hooks Git knows about.)
> +	On the specified event, the associated `hook.<name>.command` will be
> +	executed. More than one event can be specified if you wish for
> +	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].

I'm not exactly sure how you'd execute it on multiple events after
reading this description. Is this by comma-delimiting them? Or is the
event key a multivalue variable? If the latter (which I think would make
most sense), can you also reset the value by e.g. saying "event = " like
we support with other multivalued keys?

I would have also expected a "hook.<name>.enabled" option so that you
can disable globally configured hooks.

> diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
> index 93d734f687..5f339dc48b 100644
> --- a/Documentation/git-hook.adoc
> +++ b/Documentation/git-hook.adoc
> @@ -17,12 +17,94 @@ DESCRIPTION
>  A command interface for running git hooks (see linkgit:githooks[5]),
>  for use by other scripted git commands.
>  
> +This command parses the default configuration files for sets of configs like
> +so:
> +
> +  [hook "linter"]
> +    event = pre-commit
> +    command = ~/bin/linter --cpp20
> +
> +In this example, `[hook "linter"]` represents one script - `~/bin/linter
> +--cpp20` - which can be shared by many repos, and even by many hook events, if
> +appropriate.
> +
> +To add an unrelated hook which runs on a different event, for example a
> +spell-checker for your commit messages, you would write a configuration like so:
> +
> +  [hook "linter"]
> +    event = pre-commit
> +    command = ~/bin/linter --cpp20
> +  [hook "spellcheck"]
> +    event = commit-msg
> +    command = ~/bin/spellchecker
> +
> +With this config, when you run 'git commit', first `~/bin/linter --cpp20` will
> +have a chance to check your files to be committed (during the `pre-commit` hook
> +event`), and then `~/bin/spellchecker` will have a chance to check your commit
> +message (during the `commit-msg` hook event).
> +
> +Commands are run in the order Git encounters their associated
> +`hook.<name>.event` configs during the configuration parse (see
> +linkgit:git-config[1]). Although multiple `hook.linter.event` configs can be
> +added, only one `hook.linter.command` event is valid - Git uses "last-one-wins"
> +to determine which command to run.
> +
> +So if you wanted your linter to run when you commit as well as when you push,
> +you would configure it like so:
> +
> +  [hook "linter"]
> +    event = pre-commit
> +    event = pre-push
> +    command = ~/bin/linter --cpp20
> +
> +With this config, `~/bin/linter --cpp20` would be run by Git before a commit is
> +generated (during `pre-commit`) as well as before a push is performed (during
> +`pre-push`).
> +
> +And if you wanted to run your linter as well as a secret-leak detector during
> +only the "pre-commit" hook event, you would configure it instead like so:
> +
> +  [hook "linter"]
> +    event = pre-commit
> +    command = ~/bin/linter --cpp20
> +  [hook "no-leaks"]
> +    event = pre-commit
> +    command = ~/bin/leak-detector
> +
> +With this config, before a commit is generated (during `pre-commit`), Git would
> +first start `~/bin/linter --cpp20` and second start `~/bin/leak-detector`. It
> +would evaluate the output of each when deciding whether to proceed with the
> +commit.
> +
> +For a full list of hook events which you can set your `hook.<name>.event` to,
> +and how hooks are invoked during those events, see linkgit:githooks[5].
> +
> +Git will ignore any `hook.<name>.event` that specifies an event it doesn't
> +recognize. This is intended so that tools which wrap Git can use the hook
> +infrastructure to run their own hooks; see "WRAPPERS" for more guidance.
> +
> +In general, when instructions suggest adding a script to
> +`.git/hooks/<hook-event>`, you can specify it in the config instead by running:
> +
> +----
> +git config hook.<some-name>.command <path-to-script>
> +git config --add hook.<some-name>.event <hook-event>

Let's use the modern equivalents:

    git config set hook.<some-name>.command <path-to-script>
    git config set --append hook.<some-name>.event <hook-event>

> +----
> +
> +This way you can share the script between multiple repos. That is, `cp
> +~/my-script.sh ~/project/.git/hooks/pre-commit` would become:
> +
> +----
> +git config hook.my-script.command ~/my-script.sh
> +git config --add hook.my-script.event pre-commit
> +----

Likewise.

> @@ -46,6 +128,46 @@ OPTIONS
>  	tools that want to do a blind one-shot run of a hook that may
>  	or may not be present.
>  
> +WRAPPERS
> +--------
> +
> +`git hook run` has been designed to make it easy for tools which wrap Git to
> +configure and execute hooks using the Git hook infrastructure. It is possible to
> +provide arguments and stdin via the command line, as well as specifying parallel
> +or series execution if the user has provided multiple hooks.
> +
> +Assuming your wrapper wants to support a hook named "mywrapper-start-tests", you
> +can have your users specify their hooks like so:
> +
> +  [hook "setup-test-dashboard"]
> +    event = mywrapper-start-tests
> +    command = ~/mywrapper/setup-dashboard.py --tap

Ah, interesting. Would that then also look for
".git/hooks/mywrapper-start-tests"?

> diff --git a/hook.c b/hook.c
> index 949c907b59..9f59ebd0bd 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -47,24 +47,74 @@ const char *find_hook(struct repository *r, const char *name)
>  	return path.buf;
>  }
>  
> +struct hook_config_cb
> +{

Formatting: the curly brace should not go on a standalone line.

> +	const char *hook_event;
> +	struct string_list *list;
> +};
> +
> +/*
> + * Callback for git_config which adds configured hooks to a hook list.  Hooks
> + * can be configured by specifying both hook.<friendly-name>.command = <path>
> + * and hook.<friendly-name>.event = <hook-event>.
> + */
> +static int hook_config_lookup(const char *key, const char *value,
> +			      const struct config_context *ctx UNUSED,
> +			      void *cb_data)
> +{
> +	struct hook_config_cb *data = cb_data;
> +	const char *name, *event_key;
> +	size_t name_len = 0;
> +	struct string_list_item *item;
> +	char *hook_name;
> +
> +	/*
> +	 * Don't bother doing the expensive parse if there's no
> +	 * chance that the config matches 'hook.myhook.event = hook_event'.
> +	 */
> +	if (!value || strcmp(value, data->hook_event))
> +		return 0;

Okay.

> +	/* Look for "hook.friendly-name.event = hook_event" */
> +	if (parse_config_key(key, "hook", &name, &name_len, &event_key) ||
> +	    strcmp(event_key, "event"))
> +		return 0;

So we only care about parsing "hook.<name>.event" here, and I assume
that we would look up the command at a later point in time? That design
is somewhat weird -- I would have expected that we scan through all
config keys and already pull out both the command and event so that we
don't have to extract the config a second time.

But I guess this is another consequence of the string list only caring
about the name, not about the actual path.

> +	/* Extract the hook name */
> +	hook_name = xmemdupz(name, name_len);
> +
> +	/* Remove the hook if already in the list, so we append in config order. */
> +	if ((item = unsorted_string_list_lookup(data->list, hook_name)))
> +		unsorted_string_list_delete_item(data->list, item - data->list->items, 0);
> +
> +	/* The list takes ownership of hook_name, so append with nodup */
> +	string_list_append_nodup(data->list, hook_name);
> +
> +	return 0;
> +}
> +
>  struct string_list *list_hooks(struct repository *r, const char *hookname)
>  {
> -	struct string_list *hook_head;
> +	struct hook_config_cb cb_data;
>  
>  	if (!hookname)
>  		BUG("null hookname was provided to hook_list()!");
>  
> -	hook_head = xmalloc(sizeof(struct string_list));
> -	string_list_init_dup(hook_head);
> +	cb_data.hook_event = hookname;
> +	cb_data.list = xmalloc(sizeof(struct string_list));
> +	string_list_init_dup(cb_data.list);
> +
> +	/* Add the hooks from the config, e.g. hook.myhook.event = pre-commit */
> +	repo_config(r, hook_config_lookup, &cb_data);

There are cases where we invoke the same hook multiple times per
process. One such candidate is for example the "reference-transaction"
hook, which is executed thrice per ref transaction. Would it make sense
if we cached the value in `r` so that we can avoid repeatedly parsing
the configuration for this hook?

We could even go one step further: instead of caching the value for
_one_ hook, we could parse _all_ hooks lazily and store them in a map.

> @@ -125,6 +175,24 @@ static int pick_next_hook(struct child_process *cp,
>  			hook_path = absolute_path(hook_path);
>  
>  		strvec_push(&cp->args, hook_path);
> +	} else {
> +		/* ...from config */
> +		struct strbuf cmd_key = STRBUF_INIT;
> +		char *command = NULL;
> +
> +		/* to enable oneliners, let config-specified hooks run in shell. */
> +		cp->use_shell = true;
> +
> +		strbuf_addf(&cmd_key, "hook.%s.command", to_run->string);
> +		if (repo_config_get_string(hook_cb->repository,
> +					   cmd_key.buf, &command)) {
> +			die(_("'hook.%s.command' must be configured or"
> +			      "'hook.%s.event' must be removed; aborting.\n"),
> +			    to_run->string, to_run->string);
> +		}
> +		strbuf_release(&cmd_key);
> +
> +		strvec_push_nodup(&cp->args, command);
>  	}
>  
>  	if (!cp->args.nr)

Okay, so here we do an extra step to extract the commands. I think this
would fit more naturally in `hook_config_lookup`.

Patrick
