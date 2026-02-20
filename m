Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932C296BA5
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771590501; cv=pass; b=hil77j5Xlb/8OTSQLrgJohlA7rsrcB0OlxuvzJIep/gKv0eW1T9WKHiz5DBOQQfk4tDouyKR8STd/vOdHigX67wrZWQ1FXn6ymJpUWpD4nsrJH3qjTk8NgxvzELHIkRqxxYnIMRpni/zD6HXhBt4VcYOjJErj0G4RZcsugku2B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771590501; c=relaxed/simple;
	bh=fJDE7BVybr4GgdtvlE3rvQdgJZfAocSVXEqtfLkyRpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MC8JLXXPpEI2FKoie//BiKIyBynsOPGlfWd6yVId6tvFPz73eOcu9CjoHlAqQuMImRjncsRA6OsKaQTSN49FGjjslME+fN7GP1+Npgkrglj7rMUqcouNfmidWuEOW7GCY6BxgwAGCJ9GXlE8+y1yD/JKpNSUqS/4cgwx59iepF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=jsGrsuSi; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="jsGrsuSi"
ARC-Seal: i=1; a=rsa-sha256; t=1771590485; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SUISpBFg+t1q+wqBLhPZV646KxFp55IICgFILcWWJjujLQ43YlBju4oeAAxNfYx6HJvpoqImpAd77pJPP0fawxBaXFJxukC3Q957j9R4WoGhapIgG7lQZduoNa/0dlpLzMbgn4C1wjltgZrcX479Ye4S0Adam2ZXnVlf2KiG9wI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771590485; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T2s8Xo4PI8yiNFYDOQ50eo7/cWi1CBpwWa9NTmQ8ppA=; 
	b=O6DQGzKYXE/toFJkFDy2kZGPPD8+SbU4t6CI7YQuGs2kB1dWZ3sMrvWF/A0AnhNIDk7w5m0Huhk1vpo40/HXCMKQghOcmZwjWy05Xwm9QodEV5zSvoYVLbFDwk/j+dHihK+sJHrI/4RAcTprZcdRBMNc5uD3zROztMeu+w9+W7g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771590485;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=T2s8Xo4PI8yiNFYDOQ50eo7/cWi1CBpwWa9NTmQ8ppA=;
	b=jsGrsuSiVs4dW+4cmvTsCVwtytNdD3Ch35d4304Z9jLICdHIivf+POgbHiHa24ZZ
	jWFzr2/rm34CKZlhrKybIjGQ6fovLwJHILiKjyBcFJenAxxpQRyXQTT97umcttXL3xp
	fmFJKDhTNudKWLR/GWUake6fVYYC84gz/R7CJw9k=
Received: by mx.zohomail.com with SMTPS id 1771590482677172.25669338434716;
	Fri, 20 Feb 2026 04:28:02 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 4/8] hook: include hooks from the config
In-Reply-To: <xmqqy0ko1iri.fsf@gitster.g>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-5-adrian.ratiu@collabora.com>
 <xmqqy0ko1iri.fsf@gitster.g>
Date: Fri, 20 Feb 2026 14:27:58 +0200
Message-ID: <87o6ljy4z5.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Thu, 19 Feb 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Examples:
>>
>>   $ git config --get-regexp "^hook\."
>>   hook.bar.command=~/bar.sh
>>   hook.bar.event=pre-commit
>
> This is all good when you know where you defined your pre-commit
> hook, but you would want to know in which scope the configuration is
> made, wouldn't you, especially when you are trying to diagnose why
> some command that you do not necessarily recognise when you run a
> Git command?

Yes, I assumed the user knows where his hooks are defined. :)
Obviously this is not the case.

This also applies to the "git hook list" command added later in this
series, we might want to tell users where the hooks come from there as
well.

>> @@ -10,17 +11,22 @@ struct repository;
>>   * Represents a hook command to be run.
>>   * Hooks can be:
>>   * 1. "traditional" (found in the hooks directory)
>> - * 2. "configured" (defined in Git's configuration, not yet implemented).
>> + * 2. "configured" (defined in Git's configuration via hook.<name>.event).
>
> Wouldn't it be easier to understand if we do "<name>" -> "<friendly-name>"
> to match the member name used in the struct below?

Yes, name here referes to "friendly-name" :)

I'll make this consestent in v3 across the patch series, to use
friendly-name.

>>   * The 'kind' field determines which part of the union 'u' is valid.
>>   */
>>  struct hook {
>>  	enum {
>>  		HOOK_TRADITIONAL,
>> +		HOOK_CONFIGURED,
>>  	} kind;
>>  	union {
>>  		struct {
>>  			const char *path;
>>  		} traditional;
>> +		struct {
>> +			const char *friendly_name;
>> +			const char *command;
>
> If we wanted to report which config scope defined a particular hook
> we need to record where the configured hook came from in this
> struct, right?

Yes, this is the place.

We can do it when parsing the configs (in v2, at Patrick's suggestion we
just parse once then cache & reuse if possible). 

>
>> +		} configured;
>>  	} u;
>
>> +	if (repo->hook_config_cache) {
>> +		hook_cache_clear(repo->hook_config_cache);
>> +		FREE_AND_NULL(repo->hook_config_cache);
>> +	}
>
> It is a minor point, but after applying the hole series, there are
> only two calls to hook_cachje_clear(X) and they both are followed by
> free(X) or FREE_AND_NULL(X).  I wonder if we simply want
> hook_cache_free() instead of _clear()?

Yes, we can do this.

I think I have another place where I can apply this pattern in addition
to this, to avoid calling both clear() + free() afterwards.

Will make all these uses consistent on a single _free() in v3.

Thanks,
Adrian
