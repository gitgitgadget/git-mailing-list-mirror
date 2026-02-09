Received: from sender4-pp-e105.zoho.com (sender4-pp-e105.zoho.com [136.143.188.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CA03EFD2F
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664250; cv=pass; b=CibWBwdRfqWYosCUI3cgCQwyQ3aImo3aZke9r01vFKbOpTO9BldN4BlZ1NhcaH+K83HC9m0p94JI5J0QOyXqYXGzMTzViBJbyKhPv4wKr2dACLpLeqjGVb0EriaX2dnxh66j+LWgcDKmmrEkjg3D7W0GhuVLBFF/FK6t0t44Eh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664250; c=relaxed/simple;
	bh=v9IrS4Y/6fY932DFFOzFFnAPzBjlO/1F0ShytFE15PA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dmNpIl6S6im3ikzV4KVqm2JY+C5Wr/2XV8f2lKowjglCqZLjxrMqrInf8Nxkr8u4CIjrPPqF+3ie31CYlGH5Wr39/7icSBtuRi5QbDXFKN573kqoawI9VX+sPSF4gG8/U4faJQuuX5cQT+yIEKRvSCuCCSXiloGKJKWTSBMDzX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=byeTykhV; arc=pass smtp.client-ip=136.143.188.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="byeTykhV"
ARC-Seal: i=1; a=rsa-sha256; t=1770664231; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XBOQPJISnS9oi5nSPZ7HiXZ4g8D9+m3hnewgST+2qb/Ih5NG6dn22PmgRxOYzuqFAzdvQB5KkbvuCAIAeQOAyXmbC+Kd1Yy5ejRqUDQWik2bEakyGZAA98kUCfbBoyFWVrCFa/yaFxNU3VFAKa0ZsD5uAX0tqVNNgOa0re9Pzhg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770664231; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MgKgqYFtKthy6o1dOTD8xdGiN8PklMoalBsI60/QpxI=; 
	b=RvtEIL/kOxlp7Y4RsWSs3mVLXBX52hyLdKu3WzdhbjwsPXiON2sKwlOF1ephLexggqaMdJ44vp7p4oMPnV0w65WKwKerN4VXHk/cAyEPQqCCDbfV++t9k2P+oxQLsRa0ZXFSoJoo+SdUMv9tqZWkpHSC14ocx6YnWoPTQ13DuPQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770664231;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=MgKgqYFtKthy6o1dOTD8xdGiN8PklMoalBsI60/QpxI=;
	b=byeTykhVfFpCTVS4EEsF6H/612oogr/1t8B+haAy0MxTXoocb2z+QQsMl2Ag9VKA
	4NoMsYgpt0nQX96+fZcWyJVNSymoLJNYeVKKrqQS7g0TP9bN02Y9BM1xLkGz6cO81jd
	3cTc8OJItLZfbX8Bqo0gf320q/hbDNkG2VmvvAeE=
Received: by mx.zohomail.com with SMTPS id 1770664228294991.8670415738196;
	Mon, 9 Feb 2026 11:10:28 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 3/4] hook: include hooks from the config
In-Reply-To: <aYnu9gJATVJeKEjZ@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260204165126.1548805-4-adrian.ratiu@collabora.com>
 <aYnu9gJATVJeKEjZ@pks.im>
Date: Mon, 09 Feb 2026 21:10:25 +0200
Message-ID: <87343920ny.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 09 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Wed, Feb 04, 2026 at 06:51:25PM +0200, Adrian Ratiu wrote:
>> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
>> new file mode 100644
>> index 0000000000..49c7ffd82e
>> --- /dev/null
>> +++ b/Documentation/config/hook.adoc
>> @@ -0,0 +1,17 @@
>> +hook.<name>.command::
>> +	A command to execute whenever `hook.<name>` is invoked. `<name>` should
>> +	be a unique "friendly" name which you can use to identify this hook
>> +	command. (You can specify when to invoke this command with
>> +	`hook.<name>.event`.) The value can be an executable on your device or a
>> +	oneliner for your shell. If more than one value is specified for the
>> +	same `<name>`, the last value parsed will be the only command executed.
>> +	See linkgit:git-hook[1].
>> +
>> +hook.<name>.event::
>> +	The hook events which should invoke `hook.<name>`. `<name>` should be a
>> +	unique "friendly" name which you can use to identify this hook. The
>> +	value should be the name of a hook event, like "pre-commit" or "update".
>> +	(See linkgit:githooks[5] for a complete list of hooks Git knows about.)
>> +	On the specified event, the associated `hook.<name>.command` will be
>> +	executed. More than one event can be specified if you wish for
>> +	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].
>
> I'm not exactly sure how you'd execute it on multiple events after
> reading this description. Is this by comma-delimiting them? Or is the
> event key a multivalue variable? If the latter (which I think would make
> most sense), can you also reset the value by e.g. saying "event = " like
> we support with other multivalued keys?

Yes, event is a multivalue variable, however the current implementation
does not allow resetting using "event = ".

I'll allow it in v2 and also make the doc clearer.

> I would have also expected a "hook.<name>.enabled" option so that you
> can disable globally configured hooks.
>

Good idea. I can add that in v2.

<snip>

>> +git config hook.<some-name>.command <path-to-script>
>> +git config --add hook.<some-name>.event <hook-event>
>
> Let's use the modern equivalents:
>
>     git config set hook.<some-name>.command <path-to-script>
>     git config set --append hook.<some-name>.event <hook-event>
>

Ack, will do in v2.

<snip>

>> @@ -46,6 +128,46 @@ OPTIONS
>>  	tools that want to do a blind one-shot run of a hook that may
>>  	or may not be present.
>>  
>> +WRAPPERS
>> +--------
>> +
>> +`git hook run` has been designed to make it easy for tools which wrap Git to
>> +configure and execute hooks using the Git hook infrastructure. It is possible to
>> +provide arguments and stdin via the command line, as well as specifying parallel
>> +or series execution if the user has provided multiple hooks.
>> +
>> +Assuming your wrapper wants to support a hook named "mywrapper-start-tests", you
>> +can have your users specify their hooks like so:
>> +
>> +  [hook "setup-test-dashboard"]
>> +    event = mywrapper-start-tests
>> +    command = ~/mywrapper/setup-dashboard.py --tap
>
> Ah, interesting. Would that then also look for
> ".git/hooks/mywrapper-start-tests"?

Yes, because list_hooks() gathers all hooks for the event, including the
"legacy/default" hooks from the hookdir. 

I also just noticed this doc mentions parallel execution, which is not
yet possible (that is a separate series). I fix this and add the parallel
comment back in the other series.

>> diff --git a/hook.c b/hook.c
>> index 949c907b59..9f59ebd0bd 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -47,24 +47,74 @@ const char *find_hook(struct repository *r, const char *name)
>>  	return path.buf;
>>  }
>>  
>> +struct hook_config_cb
>> +{
>
> Formatting: the curly brace should not go on a standalone line.

Ack, will fix.

<snip>

>> +	/* Look for "hook.friendly-name.event = hook_event" */
>> +	if (parse_config_key(key, "hook", &name, &name_len, &event_key) ||
>> +	    strcmp(event_key, "event"))
>> +		return 0;
>
> So we only care about parsing "hook.<name>.event" here, and I assume
> that we would look up the command at a later point in time? That design
> is somewhat weird -- I would have expected that we scan through all
> config keys and already pull out both the command and event so that we
> don't have to extract the config a second time.
>
> But I guess this is another consequence of the string list only caring
> about the name, not about the actual path.

That is correct.

I do plan to change this design in v2 and we might as well also look up
the path at the same time.

I see nothing preventing us from doing it.

>> +	/* Extract the hook name */
>> +	hook_name = xmemdupz(name, name_len);
>> +
>> +	/* Remove the hook if already in the list, so we append in config order. */
>> +	if ((item = unsorted_string_list_lookup(data->list, hook_name)))
>> +		unsorted_string_list_delete_item(data->list, item - data->list->items, 0);
>> +
>> +	/* The list takes ownership of hook_name, so append with nodup */
>> +	string_list_append_nodup(data->list, hook_name);
>> +
>> +	return 0;
>> +}
>> +
>>  struct string_list *list_hooks(struct repository *r, const char *hookname)
>>  {
>> -	struct string_list *hook_head;
>> +	struct hook_config_cb cb_data;
>>  
>>  	if (!hookname)
>>  		BUG("null hookname was provided to hook_list()!");
>>  
>> -	hook_head = xmalloc(sizeof(struct string_list));
>> -	string_list_init_dup(hook_head);
>> +	cb_data.hook_event = hookname;
>> +	cb_data.list = xmalloc(sizeof(struct string_list));
>> +	string_list_init_dup(cb_data.list);
>> +
>> +	/* Add the hooks from the config, e.g. hook.myhook.event = pre-commit */
>> +	repo_config(r, hook_config_lookup, &cb_data);
>
> There are cases where we invoke the same hook multiple times per
> process. One such candidate is for example the "reference-transaction"
> hook, which is executed thrice per ref transaction. Would it make sense
> if we cached the value in `r` so that we can avoid repeatedly parsing
> the configuration for this hook?
>
> We could even go one step further: instead of caching the value for
> _one_ hook, we could parse _all_ hooks lazily and store them in a map.

I think this can be done, yes, though I'm unsure of the performance gain
vs the added complexity. Since after the first lookup the config files
are hot in the OS page cache, the next lookups are cheap/fast and we'd
be shaving off only a few microseconds of parsing.

So I'm unsure if this added complexity is worth it or not.

>> @@ -125,6 +175,24 @@ static int pick_next_hook(struct child_process *cp,
>>  			hook_path = absolute_path(hook_path);
>>  
>>  		strvec_push(&cp->args, hook_path);
>> +	} else {
>> +		/* ...from config */
>> +		struct strbuf cmd_key = STRBUF_INIT;
>> +		char *command = NULL;
>> +
>> +		/* to enable oneliners, let config-specified hooks run in shell. */
>> +		cp->use_shell = true;
>> +
>> +		strbuf_addf(&cmd_key, "hook.%s.command", to_run->string);
>> +		if (repo_config_get_string(hook_cb->repository,
>> +					   cmd_key.buf, &command)) {
>> +			die(_("'hook.%s.command' must be configured or"
>> +			      "'hook.%s.event' must be removed; aborting.\n"),
>> +			    to_run->string, to_run->string);
>> +		}
>> +		strbuf_release(&cmd_key);
>> +
>> +		strvec_push_nodup(&cp->args, command);
>>  	}
>>  
>>  	if (!cp->args.nr)
>
> Okay, so here we do an extra step to extract the commands. I think this
> would fit more naturally in `hook_config_lookup`.

Agreed, especially after I implement all other feedback to not rely on
the "empty" name to distinguish hooks, I think these can be consolidated
in one place.
