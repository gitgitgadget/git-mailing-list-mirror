Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066419CD1B
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376943; cv=pass; b=ZCjn2l+RdcWH45GFgjBlJ2Zf5jbLX7Vk8c6Mwo2+M0l1p6ijHVOjeAbdA6wZ/E8NnBXgw3+XGxRc1JMb00ukoBJJR0h4uu/fJ8qqOAQBVIB+PisicfwakTWwzeC5zVAjMeU5mkRckn8JFvibJh9ubo0J8qI/s8VF9hjyGq0qkGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376943; c=relaxed/simple;
	bh=vACaqWPlU0/mAgouaKqCP4Pea1lGRbbCvPZnxSKYBhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kUxGXai3zJZ71KmvpuzLFABbpl2s1YJoDRZ4p4j2muEt+/8BDe6ZVTJ2I1B8GnaNqFkpIzAmao1JutsG9KX+cDEf3eDDtB1Cjf2uJkqktCs68myyiHIkDR/ZotaooH2kBVJgsE+hIX3IkvJOil/KVv0vY0J8wB8BKx6g9ibjPws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=CZhrKb6W; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="CZhrKb6W"
ARC-Seal: i=1; a=rsa-sha256; t=1770376923; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WDRl1ltMaEwvPUEdMDbQ/0fJWxeX7jR03F0lMojrAuo2Km87s5KgFLy4G1jBShh9h5+PNpaXcgnPk216SeDSmKpppdIaSCc3BEiOdreK8AeYW93VSwAtscgggVd4GOOf6mv4eA/zKwmeeCMxhFjUXPrA1Af3MAvSCDxojqnIscI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770376923; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qKAi47KWJ0HQ3cI7uN4Y6AA3H0bNcdJwNnF5bfVnO3s=; 
	b=ga3ld/NJUEfGTFGW2hq/id4n06TPsMqRFZw3cSbxGFSSAvn/jaHvATMH1mClMMcZNcfE23HiC5N3/iQFYu1DD0ycN8/FMafXttkuOcepbDVsopNJzKBNiucrXZY1PwdxvqhhlvfF71UhmfSuIUU5Fy5YziagIKRIJGhpzMYaWdo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770376923;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=qKAi47KWJ0HQ3cI7uN4Y6AA3H0bNcdJwNnF5bfVnO3s=;
	b=CZhrKb6W4tjSSHAEre1klXHjKTzloURFQYL7/YeP4OWqvmozJScynryER4DsdSjI
	cJ35/iVnCyXadwJheW3dE1fDKBTVUr44av0iZdKYDZ1FAQv00kxIjNcWYpLBsbvjMJ8
	cYIVCJBaY4VP71KUbMiSa59FnjMG3kOctkYmAtpE=
Received: by mx.zohomail.com with SMTPS id 1770376922223633.1791614965515;
	Fri, 6 Feb 2026 03:22:02 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 1/4] hook: run a list of hooks
In-Reply-To: <xmqqqzqykg1c.fsf@gitster.g>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260204165126.1548805-2-adrian.ratiu@collabora.com>
 <xmqqqzqykg1c.fsf@gitster.g>
Date: Fri, 06 Feb 2026 13:21:57 +0200
Message-ID: <87ecmy6rsa.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Thu, 05 Feb 2026, Junio C Hamano <gitster@pobox.com> wrote:
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
>> +
>> +	return hook_head;
>> +}
>
> OK.  I would have expected the caller to supply a string_list
> (presumably an empty one would be the most common usage) and the
> only responsibility for this function would be to stuff found hooks
> to the given string_list.  But this arrangement to give a newly
> created string list would work just fine as well.

Thank you for suggesting this potential alternative.

It didn't occur to me that we could pass an existing list to update
instead of creating a new list each time. :)

I will certainly explore this option, because I don't like how
list_hooks() currently returns a new list and the callers have to clear
it each time, even though it's done in just 2 max 3 locations  and the
lists are rather small (how many hooks can one have for each event?).

>>  int hook_exists(struct repository *r, const char *name)
>>  {
>> -	return !!find_hook(r, name);
>> +	int exists = 0;
>> +	struct string_list *hooks = list_hooks(r, name);
>> +
>> +	exists = hooks->nr > 0;
>> +
>> +	string_list_clear(hooks, 1);
>> +	free(hooks);
>> +	return exists;
>>  }
>
> OK.  It is not just "git hook list", but the internal function
> list_hooks() that is the topic of this step of the series.  So
> anywhere that uses find_hook() in the current codebase is a good
> candidate to migrate to use the new function when appropriate, and
> this is one of such places.  I presume that find_hook() will stay to
> be a "find the program in $GIT_DIR/hooks/ directory" function that
> has a single answer (i.e. pathnmame), but the list_hooks() may
> return more than one string_list_item, one of them might be the
> traditional hook and others may come from somewhere else.  Do they
> need to be differentiated in some way (i.e., Is "where did the come
> from?" a legitimate thing for a caller of list_hook() to ask)?
> There are many unknowns while reading this step because we still
> haven't seen the other sources of the hooks.

You correctly understood how it works by the next comment, yes.

We just relied on the fact that the default hooks in the hookdir do not
have a "friendly name", so we gave them an empty name to differentiate.

Not a fan of this either, so I will certainly try out your suggestions
below for v2.

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
>>  
>>  	cp->no_stdin = 1;
>>  	strvec_pushv(&cp->env, hook_cb->options->env.v);
>> @@ -85,33 +126,50 @@ static int pick_next_hook(struct child_process *cp,
>>  	cp->trace2_hook_name = hook_cb->hook_name;
>>  	cp->dir = hook_cb->options->dir;
>>  
>> -	strvec_push(&cp->args, hook_path);
>> +	/* find hook commands */
>> +	if (!*to_run->string) {
>> +		/* ...from hookdir signified by empty name */
>
> Make a macro or a small helper function that takes a single
> string_list_item that is an element in the return value of
> list_hooks(), and tells if it is a program in $GIT_DIR/hooks/
> directory.  Writing code that depends on this "we did not bother to
> invent a way to allow users to give friendly names to traditional
> on-disk hooks, so it is registered with an empty string as its name"
> convention and having to document it is inefficient, both for
> writers of the code and for readers of the code.

100% agreed.

>
> Or perhaps the .util member of each of these can be a pointer to
> something like:
>
> 	struct {
> 		enum {
>                 	HOOK_TRADITIONAL, HOOK_CONFIGURED,
> 		} kind;
> 		union {
> 			struct {
> 				const char *path;
> 			} traditional;
> 			struct {
> 				const char *friendly_name;
> 				const char *path;
> 				... maybe others ...
> 			} configured;
> 		} u;
> 	}
>
> so that this codepath does not even have to ...
>
>> +		const char *hook_path = find_hook(hook_cb->repository,
>> +						  hook_cb->hook_name);
>
> ... run the same find_hook() again here?

Yes, I'll combine all these approaches in v2 to see if I can come up
with something more sensible.

Thank you so much for the valuable feedback, I really appreciate it,
Adrian
