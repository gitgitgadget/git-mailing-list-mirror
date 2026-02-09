Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B9F2874F5
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661017; cv=pass; b=sKXDaNBBiO7gIqLOH2bB0WKm5B7dgmoxLY5GPlaCU/XtHeewahKddPD15nklp5Xr8qQF8Ymu2pAnBF1W5Z/cy6RJLax57yI9IMKn7zbLH08oocyi92WAwbfbhyca10Ih1VAiMpCtyTMoh1tqJVikP5SGwNM0p+fTtDX4q/KKSl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661017; c=relaxed/simple;
	bh=3B4uWi3AlyVCi4Nhc0beZC5mpUfKG5CgUCFZlqBjqfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gOTE5wwzoiVYXc0OK2st14lM2l6gh0/lFmpZ26SKZJPKKT/dFA0NujiCvg7R2DgLj/mCjtIBEojGH7m1OMcVeO29otttaXdExvgKo4HNPjen/sN+A2DJ8TBmPBHzf0rwHUon7vNIEo+3CKH0ZJNm5AvMgbXxut3s0NT+hjD6jXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=fLQ9YARD; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="fLQ9YARD"
ARC-Seal: i=1; a=rsa-sha256; t=1770661001; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=binEmghuQFzCGeBBNsvcoGuU0eat+W9fgJj1GoxDEQ9P/UH0zXMreOwbsN0SLMbYPKVoz0kiX+Fq05T06pdEN0hYv7WV+2XMSDW2AZxqx6aZn6jquZ+1hW+mEP7MN2QP8zVTyieRWFs2PN9seuv7DDysPclToqs6pSzauAABZU8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770661001; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q5roTvhY9iL2Kra7eliZP/oEnfeehYUuuN1YryQyjxA=; 
	b=n2lOHJIrCwtT9xW9jzhGy2eLqcH+K9w0A+yzoCDWxg1yDUBvQJhTpzBtsgokZL34TyxKzlYExH+dHqPsLt5EjVDkW2lvhenexp7hBKTxVn1Y9Ak51f/SUtCRSMcOv3b3MSsUkGD2Kvg5Ck3C1UglaOUk4iSAoUvvvlj6m9yKNes=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770661001;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=Q5roTvhY9iL2Kra7eliZP/oEnfeehYUuuN1YryQyjxA=;
	b=fLQ9YARDNlgeNKVLbrUECGiZxTPrN2ghxSsOevRVLMzK7NOPFjlmApTsXJsxkY3t
	4j2V7Hbl9xcscY70VtiizAP6GIgsJ9pRITWUzWCzmrCcczko9eeWhzrAmKZrDpysRDY
	vkJfBMzt9ojIp17yuIC3tPs5jk+sH7bGjwliWjk4=
Received: by mx.zohomail.com with SMTPS id 1770660999087120.38985573588047;
	Mon, 9 Feb 2026 10:16:39 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 1/4] hook: run a list of hooks
In-Reply-To: <aYnu7e_hbSBwu9_N@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260204165126.1548805-2-adrian.ratiu@collabora.com>
 <aYnu7e_hbSBwu9_N@pks.im>
Date: Mon, 09 Feb 2026 20:16:35 +0200
Message-ID: <878qd1235o.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 09 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Wed, Feb 04, 2026 at 06:51:23PM +0200, Adrian Ratiu wrote:
>> From: Emily Shaffer <emilyshaffer@google.com>
>> 
>> Teach hook.[hc] to run lists of hooks to prepare for multihook support.
>> 
>> Currently, the hook list contains only one entry representing the
>> "legacy" hook from the hookdir, but next commits will allow users
>> to supply more than one executable/command for a single hook event
>> in addition to these default "legacy" hooks.
>> 
>> All hook commands still run sequentially. A further patch series will
>> enable running them in parallel by increasing .jobs > 1 where possible.
>> 
>> Each hook command requires its own internal state copy, even when
>> running sequentially, so add an API to allow hooks to duplicate/free
>> their internal void *pp_task_cb state.
>
> I think the order in this commit message is a bit off. We typically
> first state the problem that we aim to solve before presenting the
> solution.

Ack. Will fix in v2.

>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index b5379a4895..72fde2207c 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -849,7 +849,8 @@ struct receive_hook_feed_state {
>>  
>>  static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_task_cb)
>>  {
>> -	struct receive_hook_feed_state *state = pp_task_cb;
>> +	struct string_list_item *h = pp_task_cb;
>> +	struct receive_hook_feed_state *state = h->util;
>>  	struct command *cmd = state->cmd;
>>  
>>  	strbuf_reset(&state->buf);
>> @@ -901,6 +902,24 @@ static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_
>>  	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
>>  }
>>  
>> +static void *copy_receive_hook_feed_state(const void *data)
>
> Nit: our coding guidelines say that the name of the struct should come
> first. So this would be `receive_hook_feed_state_copy()`.

Ack will fix in v2 together with the below nit.

<snip>

>> diff --git a/hook.c b/hook.c
>> index cde7198412..fb90f91f3b 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -47,9 +47,49 @@ const char *find_hook(struct repository *r, const char *name)
>>  	return path.buf;
>>  }
>>  
>> +/*
>> + * Provides a list of hook commands to run for the 'hookname' event.
>> + *
>> + * This function consolidates hooks from two sources:
>> + * 1. The config-based hooks (not yet implemented).
>> + * 2. The "traditional" hook found in the repository hooks directory
>> + *    (e.g., .git/hooks/pre-commit).
>> + *
>> + * The list is ordered by execution priority.
>> + *
>> + * The caller is responsible for freeing the memory of the returned list
>> + * using string_list_clear() and free().
>> + */
>> +static struct string_list *list_hooks(struct repository *r, const char *hookname)
>> +{
>> +	struct string_list *hook_head;
>> +
>> +	if (!hookname)
>> +		BUG("null hookname was provided to hook_list()!");
>> +
>> +	hook_head = xmalloc(sizeof(struct string_list));
>> +	string_list_init_dup(hook_head);
>> +
>> +	/*
>> +	 * Add the default hook from hookdir. It does not have a friendly name
>> +	 * like the hooks specified via configs, so add it with an empty name.
>> +	 */
>> +	if (r->gitdir && find_hook(r, hookname))
>> +		string_list_append(hook_head, "");
>
> Why is there a check for `r->gitdir` here? Do we ever execute hooks
> outside of a fully-initialized repository?

Nice find. The answer is yes, see the last commit in this series.

I've been cleaning up and untangling this series for quite a while now:
- It used to be combined with the other parallel hooks series.
- It used to implement its own linked list abstraction.
- It used the hook.h string-list APIs AEvar didn't like.
- and so on.

This cheeck is just a leftover bit I missed during my cleanups and I
really should be moved this to the last commit. I've been moving a lot
of code around to make it as clear as possible.

I'll do it / test in v2. Many thanks!

>
> Other than that, we now insert hooks into the list. It's somewhat
> surprising that we insert hook "names" here, instead of for example
> adding the full hook path to the list. Is there any specific reason for
> this decision?

I'm also not a fan of this design, as I mentioned in the reply to Junio.

We just need to differentiate between "new" hooks (from config) and
"default/legacy" hooks (from the hookdir) and we kind-of abused the fact
that the default hooks have no friendly name, so the name is empty, to
differentiate them. :)

Junio suggested we use a struct/union and a specific type to
differentiate between the "default/legacy" hooks (from the hookdir) and
the new config-based hooks.

That way we don't have to rely on the name anymore and we can also use
the full path here, as you suggested.

I'll do all this in v2. Thank you!

<snip>

>> @@ -58,10 +98,11 @@ static int pick_next_hook(struct child_process *cp,
>>  			  void **pp_task_cb)
>>  {
>>  	struct hook_cb_data *hook_cb = pp_cb;
>> -	const char *hook_path = hook_cb->hook_path;
>> +	struct string_list *hook_list = hook_cb->hook_command_list;
>> +	struct string_list_item *to_run = hook_cb->next_hook++;
>>  
>> -	if (!hook_path)
>> -		return 0;
>> +	if (!to_run || to_run >= hook_list->items + hook_list->nr)
>> +		return 0; /* no hook left to run */
>
> Hm, okay. Wouldn't it be a bit more ergonomic to instead store the index
> of the current hook instead of storing the string list item itself? In
> that case we could verify whether `hook_cb->hook_cur < hook_list.nr` or
> something like this.

This is actually a great idea, thanks! I will do it in v2.

(It is yet another leftover from when this series used to roll its own
linked-list implementation. :)

>> @@ -85,33 +126,50 @@ static int pick_next_hook(struct child_process *cp,
>>  	cp->trace2_hook_name = hook_cb->hook_name;
>>  	cp->dir = hook_cb->options->dir;
>>  
>> -	strvec_push(&cp->args, hook_path);
>> +	/* find hook commands */
>> +	if (!*to_run->string) {
>> +		/* ...from hookdir signified by empty name */
>> +		const char *hook_path = find_hook(hook_cb->repository,
>> +						  hook_cb->hook_name);
>> +		if (!hook_path)
>> +			BUG("hookdir in hook list but no hook present in filesystem");
>> +
>> +		if (hook_cb->options->dir)
>> +			hook_path = absolute_path(hook_path);
>> +
>> +		strvec_push(&cp->args, hook_path);
>> +	}
>
> We could avoid this special casing if we stored the absolute paths in
> the hook list right away. But maybe there is a good reason you don't.

Yes, will fix this in v2, trying to also use Junio's struct/union
suggestion to help make the difference between hook types.

>> +	if (!cp->args.nr)
>> +		BUG("configured hook must have at least one command");
>> +
>>  	strvec_pushv(&cp->args, hook_cb->options->args.v);
>>  
>>  	/*
>>  	 * Provide per-hook internal state via task_cb for easy access, so
>>  	 * hook callbacks don't have to go through hook_cb->options.
>>  	 */
>> -	*pp_task_cb = hook_cb->options->feed_pipe_cb_data;
>> -
>> -	/*
>> -	 * This pick_next_hook() will be called again, we're only
>> -	 * running one hook, so indicate that no more work will be
>> -	 * done.
>> -	 */
>> -	hook_cb->hook_path = NULL;
>> +	*pp_task_cb = to_run;
>>  
>>  	return 1;
>>  }
>>  
>> -static int notify_start_failure(struct strbuf *out UNUSED,
>> +static int notify_start_failure(struct strbuf *out,
>>  				void *pp_cb,
>> -				void *pp_task_cp UNUSED)
>> +				void *pp_task_cb)
>>  {
>>  	struct hook_cb_data *hook_cb = pp_cb;
>> +	struct string_list_item *hook = pp_task_cb;
>>  
>>  	hook_cb->rc |= 1;
>>  
>> +	if (out && hook) {
>> +		if (*hook->string)
>> +			strbuf_addf(out, _("Couldn't start hook '%s'\n"), hook->string);
>> +		else
>> +			strbuf_addstr(out, _("Couldn't start hook from hooks directory\n"));
>> +	}
>> +
>>  	return 1;
>>  }
>
> Okay, here we can give a bit more detail in the error message. But that
> alone doesn't quite feel worth the additional complexity.

Nice find. I 100% agree.

I actually asked myself this multiple times before posting the
series, because it would significantly simplify the implementation if we
don't do this distinction here and just write a single "generic" can't
start hook message. :)

I'm still uncertain if this is worth it, becaute this is the only
callback which uses it and it's the only reason we changed the
"pp_task_cb" convention in ALL hook callbacks.

Very likely I'll dorp this in v2, or at least split it out into its own
commit, if possible, so we see the full complexity cost of this one msg.

>> @@ -172,26 +231,50 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
>>  	if (!options->jobs)
>>  		BUG("run_hooks_opt must be called with options.jobs >= 1");
>>  
>> +	/*
>> +	 * Ensure cb_data copy and free functions are either provided together,
>> +	 * or neither one is provided.
>> +	 */
>> +	if ((options->copy_feed_pipe_cb_data && !options->free_feed_pipe_cb_data) ||
>> +	    (!options->copy_feed_pipe_cb_data && options->free_feed_pipe_cb_data))
>> +		BUG("copy_feed_pipe_cb_data and free_feed_pipe_cb_data must be set together");
>
> I wonder whether it would make the commit a bit easier to review if you
> split it up into two:
>
>   - One commit that introduces the copy/free callback functions.
>
>   - One commit that introduces the hook list.
>
> Then the changes would be a bit more focussed.

Yes, this makes sense. As I mentioned above, I've been splitting and
simplifying these commits for quite a while now.

This would be very natural continuation.

>>  	if (options->invoked_hook)
>>  		*options->invoked_hook = 0;
>>  
>> -	if (!hook_path && !options->error_if_missing)
>> -		goto cleanup;
>> -
>> -	if (!hook_path) {
>> -		ret = error("cannot find a hook named %s", hook_name);
>> +	if (!cb_data.hook_command_list->nr) {
>> +		if (options->error_if_missing)
>> +			ret = error("cannot find a hook named %s", hook_name);
>>  		goto cleanup;
>>  	}
>>  
>> -	cb_data.hook_path = hook_path;
>> -	if (options->dir) {
>> -		strbuf_add_absolute_path(&abs_path, hook_path);
>> -		cb_data.hook_path = abs_path.buf;
>> +	/*
>> +	 * Initialize the iterator/cursor which holds the next hook to run.
>> +	 * run_process_parallel() calls pick_next_hook() which increments it for
>> +	 * each hook command in the list until all hooks have been run.
>> +	 */
>> +	cb_data.next_hook = cb_data.hook_command_list->items;
>> +
>> +	/*
>> +	 * Give each hook its own copy of the initial void *pp_task_cb state, if
>> +	 * a copy callback was provided.
>> +	 */
>> +	if (options->copy_feed_pipe_cb_data) {
>> +		struct string_list_item *item;
>> +		for_each_string_list_item(item, cb_data.hook_command_list)
>> +			item->util = options->copy_feed_pipe_cb_data(options->feed_pipe_cb_data);
>>  	}
>
> Makes sense. We cannot just peform a shallow copy of the callback data
> as it may contain data itself that needs to be copied. So we have to
> handle the copying ourselves.

Yes, this is the heart of the problem, especially when we start running
hooks in parallel, they each really need their own internal states.

> One thing I wondered is whether it would lead to a cleaner design if
> this was instead provided as a callback to allocate and initialize a
> completely _new_ callback data. In that case the caller wouldn't have to
> first initialize the data only to copy it in a different place, all the
> logic would be self-contained in that one callback.

It's a very interesting proposal which I will certainly explore for
v2. Many thanks for this as well!

> The downside would of course be that we cannot use for example the
> stack, and it might make it harder to reuse state across multiple hook
> invocations, if that's a feature we care about.

I'm not worried about reusing the internal state (pp_task_cb) accross
multiple hook invocations, because that's why the "context" is passed
(pp_cb) to each hook cb. The internal state is never reused. 

Thanks Patrick, very thoughtful review as always.
