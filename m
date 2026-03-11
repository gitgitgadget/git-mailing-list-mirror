Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239337261A
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231876; cv=pass; b=lBTINtrm+RKFAUCn0GVihD95cbHDv8i0yB89knSAZmRxLl3yA6Stv2X09A/VFlW3YBRB0xWvSELtmvwa2jTKZcsGie4r63cDRTs+vmheG149nJSCcgreeY1JgVkB67/y2z/DRdGW7OOZauGyCPmJL+5jLfLz+dNcBqcjiZapO/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231876; c=relaxed/simple;
	bh=ZlkcOrl/JeLuSbmhKJpk/dx40OjVLCQPFI8ynNyTncA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HKdyrbGdzbr3mikyJ/NglKqBOi0W4f/CJhG3DMYLHUpYFIFmpxRSW/BuqRNM9Bup7fQ3az9GDMleLjDug18Lb92TqE5bymPzwHMgi4G0iq+82MEuA4L/9DUBAbDb+cSyXVUg0KwnnQviY9Y+QvdPpQ302mw1h1XORM/2Q/XY3Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=LTAY+82m; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="LTAY+82m"
ARC-Seal: i=1; a=rsa-sha256; t=1773231860; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mp/wrqxj0SW7eT+CSK4YVfS91DL9gN7p9Jn3rTGUzZwaPcX8ZBnLyxKyiipfyx9FTgx87iAzjVLspxt1zrfBvgWS/ZIIei5DikX5emHv6jSxED/XFIJTHMgbw0I78mMV9LQi5Cu6KUN+JrI5Fm/gpRZNyY6GQ9eItfC7nxBSJ04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773231860; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0RJ4DJQ+B8ShXArpYrEjp/XJudTkdO7GVY4N4ijiBcU=; 
	b=bNjxZOeObudam9VGZy0Gvebgh28lCzYMpLeOgtzuYFWru3C06HQzvzqu6nRJZ0LE1KH3H8tHi8itlI6HB9kTODP6/L21aKR1smPcNESjTg6hR+/LU0hNgzmT1DQoocFPjaZ2uM0W1EWOnd/kdpIsYvDhlIfkfTFpQgaZMnnXs6A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773231860;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=0RJ4DJQ+B8ShXArpYrEjp/XJudTkdO7GVY4N4ijiBcU=;
	b=LTAY+82mAo6LtqnGvrpDYArXM6vBw0wLyw6M8qcwmA3+QsZ5g5VznkFSyIX0uE//
	/dQSznIBm9l9CHT+rCgWT6sC31SozfRvBTEbdXzy246B/4jKydOclZzOq2R0uZfVHaQ
	v8w1sf/neQjOc4XukD4yPWLB/20eLp4cm35YxJyc=
Received: by mx.zohomail.com with SMTPS id 1773231858289782.2565289909011;
	Wed, 11 Mar 2026 05:24:18 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Junio C
 Hamano <gitster@pobox.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 10/10] hook: show disabled hooks in "git hook list"
In-Reply-To: <abFC6pEEmicjG6a9@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-11-adrian.ratiu@collabora.com>
 <abFC6pEEmicjG6a9@pks.im>
Date: Wed, 11 Mar 2026 14:24:14 +0200
Message-ID: <87eclqa70x.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 11 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Mar 09, 2026 at 02:54:16AM +0200, Adrian Ratiu wrote:
>> diff --git a/builtin/hook.c b/builtin/hook.c
>> index c806640361..ff446948fa 100644
>> --- a/builtin/hook.c
>> +++ b/builtin/hook.c
>> @@ -72,16 +72,20 @@ static int list(int argc, const char **argv, const char *prefix,
>>  		case HOOK_TRADITIONAL:
>>  			printf("%s%c", _("hook from hookdir"), line_terminator);
>>  			break;
>> -		case HOOK_CONFIGURED:
>> -			if (show_scope)
>> -				printf("%s (%s)%c",
>> -				       h->u.configured.friendly_name,
>> -				       config_scope_name(h->u.configured.scope),
>> +		case HOOK_CONFIGURED: {
>> +			const char *name = h->u.configured.friendly_name;
>> +			const char *scope = show_scope ?
>> +				config_scope_name(h->u.configured.scope) : NULL;
>> +			if (scope)
>> +				printf("%s (%s%s)%c", name, scope,
>> +				       h->u.configured.disabled ? ", disabled" : "",
>>  				       line_terminator);
>> +			else if (h->u.configured.disabled)
>> +				printf("%s (disabled)%c", name, line_terminator);
>>  			else
>> -				printf("%s%c", h->u.configured.friendly_name,
>> -				       line_terminator);
>> +				printf("%s%c", name, line_terminator);
>>  			break;
>> +		}
>>  		default:
>>  			BUG("unknown hook kind");
>>  		}
>
> Hm. This starts to feel less and less like an interface that can easily
> be parsed by a machine, even with "-z". I guess this partly comes from
> our insistence to reinvent the wheel in Git instead of just using
> something like JSON :/

Yes, I agree, a structured output format like JSON would be ideal in
this case.

Please see my previous patch suggestion of mirroring the existing git
config --show-scope by using tab separated prefixes. Maybe we could do
that here as well.

Suggestions welcome.

>> diff --git a/hook.c b/hook.c
>> index 2c03baeaac..4f4f060156 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -119,6 +119,7 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
>>  struct hook_config_cache_entry {
>>  	char *command;
>>  	enum config_scope scope;
>> +	int disabled;
>>  };
>>  
>>  /*
>
> Is there any reason this is an `int` and not a `bool`?

No, I'll change it to bool in v2, it was just an oversight on my part.

>> @@ -217,8 +218,10 @@ static int hook_config_lookup_all(const char *key, const char *value,
>>   * every item's string is the hook's friendly-name and its util pointer is
>>   * a hook_config_cache_entry. All strings are owned by the map.
>>   *
>> - * Disabled hooks and hooks missing a command are already filtered out at
>> - * parse time, so callers can iterate the list directly.
>> + * Disabled hooks are kept in the cache with entry->disabled set, so that
>> + * "git hook list" can display them. Hooks missing a command are filtered
>> + * out at build time; if a disabled hook has no command it is silently
>
> What exactly does "build time" refer to? To me this reads like invoking
> make :)

This is one of my pet peeves: I (mis)use "build time" a lot.

build time in this case == cache construction time. :)

The comment is wrong anyway, because in the end I decided to issue a
warning (see code immediately below) instead of silently ignoring.

I'll reword this in v2. Thanks!

>> + * skipped rather than triggering a fatal error.
>>   */
>>  void hook_cache_clear(struct hook_config_cache *cache)
>>  {
>> @@ -268,21 +271,26 @@ static void build_hook_config_map(struct repository *r,
>>  			struct hook_config_cache_entry *entry;
>>  			char *command;
>>  
>> -			/* filter out disabled hooks */
>> -			if (unsorted_string_list_lookup(&cb_data.disabled_hooks,
>> -							hname))
>> -				continue;
>> +			int is_disabled =
>> +				!!unsorted_string_list_lookup(
>> +					&cb_data.disabled_hooks, hname);
>>  
>>  			command = strmap_get(&cb_data.commands, hname);
>> -			if (!command)
>> -				die(_("'hook.%s.command' must be configured or "
>> -				      "'hook.%s.event' must be removed;"
>> -				      " aborting."), hname, hname);
>> +			if (!command) {
>> +				if (is_disabled)
>> +					warning(_("disabled hook '%s' has no "
>> +						  "command configured"), hname);
>> +				else
>> +					die(_("'hook.%s.command' must be configured or "
>> +					      "'hook.%s.event' must be removed;"
>> +					      " aborting."), hname, hname);
>> +			}
>>  
>>  			/* util stores a cache entry; owned by the cache. */
>>  			CALLOC_ARRAY(entry, 1);
>> -			entry->command = xstrdup(command);
>> +			entry->command = command ? xstrdup(command) : NULL;
>
> You can use `xstrdup_or_null()` here.

Ack, will do in v2.

>>  			entry->scope = scope;
>> +			entry->disabled = is_disabled;
>>  			string_list_append(hooks, hname)->util = entry;
>>  		}
>>  
>> @@ -401,7 +411,16 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
>>  int hook_exists(struct repository *r, const char *name)
>>  {
>>  	struct string_list *hooks = list_hooks(r, name, NULL);
>> -	int exists = hooks->nr > 0;
>> +	int exists = 0;
>> +
>> +	for (size_t i = 0; i < hooks->nr; i++) {
>> +		struct hook *h = hooks->items[i].util;
>> +		if (h->kind == HOOK_TRADITIONAL ||
>> +		    !h->u.configured.disabled) {
>
> Is the first condition required? I would expect that `disabled` would
> always be false for traditional hooks.

Yes, it is required because !h->u.configured.disabled only applies to
non-traditional (configured) hooks.

The "traditional" member of the union doesn't even have a disabled
field, when h->kind == HOOK_TRADITIONAL => always exists = 1;

Basically we're checking two different types here, if they exist and
short-circuiting in the traditional hook case.

Hope that explanation makes sense.

I'll see if I can make this condition clearer in v2.


>> +			exists = 1;
>> +			break;
>> +		}
>> +	}
>>  	string_list_clear_func(hooks, hook_free);
>>  	free(hooks);
>>  	return exists;
>> diff --git a/hook.h b/hook.h
>> index 0d711ed21a..0432df963f 100644
>> --- a/hook.h
>> +++ b/hook.h
>> @@ -31,6 +31,7 @@ struct hook {
>>  			const char *friendly_name;
>>  			const char *command;
>>  			enum config_scope scope;
>> +			int disabled;
>>  		} configured;
>>  	} u;
>>  
>
> Same question here regarding the type of the struct member.

Yes, it can be a bool. Will do in v2.
