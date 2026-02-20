Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA741754
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597889; cv=pass; b=rLZLAFTHx5BS7mmU2qyy3dyof972j1MolKvAvvsbRAk6ao0oUP9VS/glpn4RYxIdAUtatpsuZTOhEGK7XiPS+ZJmgFhSL4auBZRp3uXOkPljTskdipQcO8U/Xf17Q47TJ42OECx3AXX8MdLS7nRAEpAUZVQhUQGBrgLw9PRaS8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597889; c=relaxed/simple;
	bh=2d1bxcLa3kyHEWlhzy06EqA16FNWivUnAj4Xqr7U4x8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FpFivD3zlkyWA3DNTsTYFuc5Mw679b5IkZC+HD92fpaq4FtjBvnOHURcfC1w0mMONOGszH+ech1Pp51rp01IGxNc+PfiORBAasyG73Q27HT2oVROhEsbn/MRQEQT/LgvEOkZHcVEehZeBP/RHCYAklyUzDpkdV/TrIrgbju/Lko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ZjkMXw2e; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ZjkMXw2e"
ARC-Seal: i=1; a=rsa-sha256; t=1771597875; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U5JuxhRZTRWJFGu7UUbktP8cQikYhirv5d/ee4KrbhicuC8JzOPKVUg/4h5Hpx+rQeQnHMFjcjUXKd0JHTOgGDmLHWEmZG0OTcXqwqLvBVsLo4ylFJaBtq2Ri9pOgivxhpjiJRS32L0Ure9suP9dba9gqYocFS50h8D0MYZpjtY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771597875; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VUhCHP2dYEzXVIMp4ogkRxg5JOhGhuYJTO+tsnuZJOU=; 
	b=Xajajo+S8IidH8djULwjn/r4Mu4tfwbSmJl/u44io0glGwIJhe8jUUySOarw9eEyv5tbdbIVfB6A8AjBtfM5VNwuG7gHlF3LVoWaWnP+o8oF0DgF/XAzhOGXn/DIiVdiYuJGVPJC1+bKgl/ZekOXQ9URb4VIJxMl2zmhO/4YeUk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771597875;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=VUhCHP2dYEzXVIMp4ogkRxg5JOhGhuYJTO+tsnuZJOU=;
	b=ZjkMXw2eG7nTvpbGR3C+SIv87CcnUJyU7WAcyea+6K1cMkKd9uUAIh37nXzDctT3
	FexJ+y1w9FAVLTy+tSmlwau+DoqHjNZxBa7i5LUB+m0SzdtoXE9h3SFwCyHJ2a6NXQ1
	slXutZRSxXcI3MT60fk6OV/d97EPGDiMn7zNiCLo=
Received: by mx.zohomail.com with SMTPS id 1771597873962159.3333297504047;
	Fri, 20 Feb 2026 06:31:13 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 4/8] hook: include hooks from the config
In-Reply-To: <aZhXm1-jw_Mi8-vL@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-5-adrian.ratiu@collabora.com>
 <aZhXm1-jw_Mi8-vL@pks.im>
Date: Fri, 20 Feb 2026 16:31:10 +0200
Message-ID: <87tsvbwkpd.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 20 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Feb 19, 2026 at 12:23:48AM +0200, Adrian Ratiu wrote:
>> diff --git a/builtin/hook.c b/builtin/hook.c
>> index 51660c4941..e151bb2cd1 100644
>> --- a/builtin/hook.c
>> +++ b/builtin/hook.c
>> @@ -54,6 +56,10 @@ static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
>>  
>>  	if (h->kind == HOOK_TRADITIONAL)
>>  		free((void *)h->u.traditional.path);
>> +	else if (h->kind == HOOK_CONFIGURED) {
>> +		free((void *)h->u.configured.friendly_name);
>> +		free((void *)h->u.configured.command);
>> +	}
>
> The `if` branch also needs curly braces now.

Ack, will fix.

>> @@ -101,6 +107,187 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
>>  	string_list_append(hook_list, hook_path)->util = h;
>>  }
>>  
>> +static void unsorted_string_list_remove(struct string_list *list,
>> +					const char *str)
>> +{
>> +	struct string_list_item *item = unsorted_string_list_lookup(list, str);
>> +	if (item)
>> +		unsorted_string_list_delete_item(list, item - list->items, 0);
>> +}
>
> This looks like a function that could reasonably be added to
> "string-list.{c,h}".

Yes, I'll move the helper there.

>> +/*
>> + * Callback struct to collect all hook.* keys in a single config pass.
>> + * commands: friendly-name to command map.
>> + * event_hooks: event-name to list of friendly-names map.
>> + * disabled_hooks: set of friendly-names with hook.name.enabled = false.
>> + */
>> +struct hook_all_config_cb {
>> +	struct strmap commands;
>> +	struct strmap event_hooks;
>
> Hm, curious that we've got two maps. I'd have expected to have a single
> map from "friendly name" or "hook name" to `struct hook`. But maybe
> we'll assemble these structs for those maps later on.
>

Exactly. I'll explain below.

>> +	struct string_list disabled_hooks;
>> +};
>
> We don't have support for disabled hooks yet. I assume this'll be added
> by a later commit, only.

Good catch.

I need to move this definition to the later commit.

>
> [snip]
>> +/* Populate `cache` with the complete hook configuration */
>> +static void build_hook_config_map(struct repository *r, struct strmap *cache)
>> +{
>> +	struct hook_all_config_cb cb_data;
>> +	struct hashmap_iter iter;
>> +	struct strmap_entry *e;
>> +
>> +	strmap_init(&cb_data.commands);
>> +	strmap_init(&cb_data.event_hooks);
>> +	string_list_init_dup(&cb_data.disabled_hooks);
>> +
>> +	/* Parse all configs in one run. */
>> +	repo_config(r, hook_config_lookup_all, &cb_data);
>> +
>> +	/* Construct the cache from parsed configs. */
>> +	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
>> +		struct string_list *hook_names = e->value;
>> +		struct string_list *hooks = xcalloc(1, sizeof(*hooks));
>> +
>> +		string_list_init_dup(hooks);
>> +
>> +		for (size_t i = 0; i < hook_names->nr; i++) {
>> +			const char *hname = hook_names->items[i].string;
>> +			char *command;
>> +
>> +			command = strmap_get(&cb_data.commands, hname);
>> +			if (!command)
>> +				die(_("'hook.%s.command' must be configured or "
>> +				      "'hook.%s.event' must be removed;"
>> +				      " aborting."), hname, hname);
>> +
>> +			/* util stores the command; owned by the cache. */
>> +			string_list_append(hooks, hname)->util =
>> +				xstrdup(command);
>> +		}
>> +
>> +		strmap_put(cache, e->key, hooks);
>> +	}
>> +
>> +	strmap_clear(&cb_data.commands, 1);
>> +	string_list_clear(&cb_data.disabled_hooks, 0);
>> +	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
>> +		string_list_clear(e->value, 0);
>> +		free(e->value);
>> +	}
>> +	strmap_clear(&cb_data.event_hooks, 0);
>> +}
>
> Okay, this is where we assemble the hooks. Still curious that the result
> isn't a `struct hook` for each configured hook.
>
> [snip]
>> +static void list_hooks_add_configured(struct repository *r,
>> +				      const char *hookname,
>> +				      struct string_list *list,
>> +				      struct run_hooks_opt *options)
>> +{
>> +	struct strmap *cache = get_hook_config_cache(r);
>> +	struct string_list *configured_hooks = strmap_get(cache, hookname);
>> +
>> +	/* Iterate through configured hooks and initialize internal states */
>> +	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
>> +		const char *friendly_name = configured_hooks->items[i].string;
>> +		const char *command = configured_hooks->items[i].util;
>> +		struct hook *hook = xcalloc(1, sizeof(struct hook));
>> +
>> +		if (options && options->feed_pipe_cb_data_alloc)
>> +			hook->feed_pipe_cb_data =
>> +				options->feed_pipe_cb_data_alloc(
>> +					options->feed_pipe_ctx);
>> +
>> +		hook->kind = HOOK_CONFIGURED;
>> +		hook->u.configured.friendly_name = xstrdup(friendly_name);
>> +		hook->u.configured.command = xstrdup(command);
>> +
>> +		string_list_append(list, friendly_name)->util = hook;
>> +	}
>> +}
>
> Okay, here we finally create the hook structures. Is there any specific
> reason why we don't cache these structures directly?

That is exactly what my first local cache implementation attempt did.

I doesn't work because:
1. struct hook contains the internal hook state which cannot be reused
   betwee hook calls (nor can it be cached).
2. struct hook requires the initialization ctx passed to
   feed_pipe_cb_data_alloc() which is different depending on the hook.

So 1 and 2 above make struct hook non-cacheable.

Maybe the following explains it better. :)

We have 3 different operations:

1. Parsing the config file once via hook_config_lookup_all()
2. Storing/reusing the config cache via build_hook_config_map()
3. Creating the struct hooks for execution via
   list_hooks_add_configured().

Caching can only work on the parsed config data, at step 2.
Hope this all makes sense.

Maybe we could rename these steps/functions to better reflect their
purpouse, or document this better somewhere in the source code?
