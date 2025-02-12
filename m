Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF11209669
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370418; cv=none; b=cHX/+L1OFjEF9IcrAdvGNdpbZJNsKoGNVLz9bOOrAjHyL1g3+uE+A36zoM3Gp7r1qjQAmJJ8S7Cr2zLaBL+be67POdpkcCUh946c75xTkiIy3LfWauKa8l4f5rv1zIu5Am5McgiE6mnnQrTpjfx8qV/WxPebFPUOxoHWNDimtpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370418; c=relaxed/simple;
	bh=9Ak29deNXWiFh0mu5P+lhC+KPCEDkiwbCYsS1mVGaRM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SHQipeHUiYBJQLbt+i063zgwDVa3SUYig+oJ4qg/MEbefrIkXZeiCk2b5GDvW6AaEk93gbyIT9uzAM0l/b5BmKK6SCpsQKtRHO/zjvAUXfKDsi7heOBDGxuWG5HXToutrzq9O2GSnR3KWKGMbC6vPvSz9TOr3wFxUMSxCpx7iyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kReB2lK5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kReB2lK5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394820123dso21027455e9.2
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 06:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739370414; x=1739975214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGDP42YqCZsdmtD4QbvhAaCk2a/Lb2XAO9ZrHZqUo1w=;
        b=kReB2lK55+XFIoQ/hU0Kj9YiEOjdTupsnab3DYH2FwMBS/OBi0kuTZuU9jpk1zfW0+
         WH2NejI9Nhh2kS3lsWo/f0nyw9UoPr4T6w0D9GsHq8mCwF20pjuYQGLv7WyLOGzkKyuH
         hyMcWUL0TKgKBJDG3KnAiRKWBskoUO5pAype1ZXA6qZOs80gOeQ5SQr4LNtCePf0Na+5
         MhxAwzN34FD8vDcZsadrgqfaR69fJ9gWz9V2jDx2WXSTY0iVJXZxpf+98pYwo4KgpTFO
         Q6FkrwQCz+75nie5EXEQQSUBuD41maTx3FjP9aussiBxu7YhdFnQKFIEkhDvLqex2eeA
         LUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370414; x=1739975214;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGDP42YqCZsdmtD4QbvhAaCk2a/Lb2XAO9ZrHZqUo1w=;
        b=RjJ9LT//yXDEkeCtcDLPupNXzt2ZIW5f1s4GLIeldJYApwj8kAqLXz//rwSxYedXoj
         zFk1OUsCNDt302FcvFl6MjNKw9dcrx8vmjmtmguSRpAs0jUENUgvxs51BlX/zdt9mk7D
         CO2s3Y7iYL+rH67zCVYl2RynqCvJlYpthU+IKaabRTicRGsb0i+61I7NxTEDqm6f1bV1
         8jGDyfb4hgdDPLb1a0RldmsaKcCm6FMjDgvyG+PW6WsBc4jhQaW3UPt+o21fMrYfTAwa
         uSD5x15O37DdfsymjoxIIAicmXCToCgDTzrUkbTD0iC92/dfn4oT2SF5pQegcu2rdVwD
         Sgcw==
X-Forwarded-Encrypted: i=1; AJvYcCUVNDiMTQrHXKBincbORDzZKGBpKwsmK9uK9VYO7JVsm5DYa01NycG+1BfPLhaNiM8SJf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCWm2HU1lBBgLUaDAmmUoikX+kHxKY64K7X/K4uPuH9U2QP9OO
	hOpOKmvBScoq85BVE7I1xMwoqQuLboUzIcwwOa6Q7wapqz7TPgAv
X-Gm-Gg: ASbGncuXS6JsdvAtcAPCSlhJjiGfwOyLDKi0+b7/neVgx1oa8n++u3q2F183dSOyZcw
	apdTbaM5lU2OJEPLndTq5q3BApjpyKNnMWr7mTczpPKFeea/RS9gZm/Zw+tgLsxx/OAvymnEBWD
	MWnFmo2dTPRTzjanX3t3gVBHMK1BdLHioz1nbbtOJ9pUg0wHyBWad2UvqO1/AuY4OzZNP22Y1kv
	RDoUSbwdFFOii3piecCYiPfhJcINHqAAZECIOi4837oeJjDwSPxEa25nUCcM5n9tzJ3vuIbyK2n
	g0h8NtorS+pGOcNrEQPp7o0XILw7weM6SRegktX63uOAzxcP/bZrsjveZQ/gTrxqr/4xEA==
X-Google-Smtp-Source: AGHT+IHb12Y328l8ZZxsiM4LVGu7lGZEsIoF+LcQwMf/aPsR28YnGFR/xYkqbIJp8LIEzk80TE049Q==
X-Received: by 2002:a05:600c:1547:b0:434:f335:83b with SMTP id 5b1f17b1804b1-4395815f911mr38009555e9.5.1739370414065;
        Wed, 12 Feb 2025 06:26:54 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a055c7esm21789695e9.14.2025.02.12.06.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 06:26:53 -0800 (PST)
Message-ID: <5b605c3e-ef6a-433a-9637-1e8f277dfde9@gmail.com>
Date: Wed, 12 Feb 2025 14:26:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
To: Ivan Shapovalov <intelfx@intelfx.name>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Alex Henrie <alexhenrie24@gmail.com>
References: <20250210191650.316329-1-intelfx@intelfx.name>
 <1279671f-4063-4347-b153-9f6ff079bd77@gmail.com>
 <f689c263ead8104ec42f63f1e9ed10350a27ae1d.camel@intelfx.name>
Content-Language: en-US
In-Reply-To: <f689c263ead8104ec42f63f1e9ed10350a27ae1d.camel@intelfx.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivan

On 11/02/2025 18:11, Ivan Shapovalov wrote:
> On 2025-02-11 at 14:36 +0000, Phillip Wood wrote:
>> On 10/02/2025 19:16, Ivan Shapovalov wrote:
>>
>> I'm a bit surprised by this - I'd have thought there is more scope for
>> messing things up by making a mistake when editing the todo list that
>> for the non-interactive case. Are you able to explain a in a bit more
>> detail the problem you have been experiencing please?
> 
> I often find myself managing multiple interdependent downstream patch
> branches, rebasing them en masse from release to release. Eventually,
> I found myself typing `git rebase -i --update-refs` more often than
> not, so I just stuck it into the config as `rebase.updateRefs=true`.
> 
> However, sometimes I also maintain those patch branches for multiple
> releases. Consider a (hypothetical) situation:
> 
> - tag v1
> - tag v2
> - branch work/myfeature-v1 that is based on tag v1
> 
> Now, I want to rebase myfeature onto v2, so I do this:
> 
> $ git checkout work/myfeature-v1
> $ git checkout -b work/myfeature-v2
> $ git rebase --onto v2 v1 work/myfeature-v2
> 
> With `rebase.updateRefs=true`, this ends up silently updating _both_
> work/myfeature-v2 and work/myfeature-v1.

Thanks for the explanation. So this is about copying a branch and then 
rebasing the copy without updating the original. A while ago there was a 
discussion[1] about excluding branches that match HEAD from 
"--update-refs". Maybe we should revisit that with a view to adding a 
config setting that excludes copies of the current branch from 
"--update-refs".

Maintaining multiple versions of the same branch sounds like a lot of 
work - whats the advantage over merging a single branch into each release?

[1] 
https://lore.kernel.org/git/adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de/

> With this in mind, I wrote this patch such that update-refs only
> happens for interactive rebases, when I have the chance to inspect the
> todo list and prune unwanted update-refs items.
> 
> Does this make sense? I made an attempt to explain this motivation in
> the commit message, so if this does make sense but the commit message
> doesn't, please tell me how to improve/expand the latter.

I think having the example in the commit message would help - I feel 
like I've now got a clear idea of the problem you are facing whereas I 
didn't understand what the issue was just from the commit message.

>>> Try to find a middle ground by introducing a third value,
>>> `--update-refs=interactive` (and `rebase.updateRefs=interactive`)
>>> which means `--update-refs` when starting an interactive rebase and
>>> `--no-update-refs` otherwise. This option is primarily intended to be
>>> used in the gitconfig, but is also accepted on the command line
>>> for completeness.
>>
>> I'm not convinced allowing "--update-refs=interactive" on the
>> commandline improves the usability - why wouldn't I just say
>> "--update-refs" if I want to update all the branches or
>> "--no-update-refs" if I don't? I also think supporting
>> --update-refs=(true|false) is verbose and unnecessary as the user can
>> already specify their intent with the existing option.
> 
> I make heavy use of aliases for various workflows, which invoke one
> another (making use of the ability to override earlier command-line
> options with the latter ones), and the ability to spell out
> `alias.myRebase = rebase ... --update-refs=interactive ...` was useful.

You can write your alias as

    alias.myRebase = -c rebase.updaterefs=interactive rebase ...

instead. It is not quite as convenient but it means we don't have to add 
complexity to the command line interface that is only useful for aliases 
(I can't think of a use for "--update-refs=interactive" outside of an 
alias definition).

> Re: specifying `=(true|false)`, the intention was to avoid unnecessary
> divergence, both in UX and code (and reuse the parser to simplify said
> code). If you think it will be harmful, I'll remove that.

It would be even simpler if we didn't change the command line interface ;)

>>>    rebase.updateRefs::
>>> -	If set to true enable `--update-refs` option by default.
>>> +	If set to true, enable the `--update-refs` option of
>>> +	linkgit:git-rebase[1] by default. When set to 'interactive',
>>
>> Our existing documentation is inconsistent in how it formats config
>> values. rebase.backend uses "apply", rebase.rebaseMerges uses
>> `rebase-cousins` which I think matches other commands and is therefore
>> what we should use here and rebase.missingCommitCheck uses a mixture
>> with "warn" and `drop`.
> 
> Apologies, I'm not sure I understood what exactly you were suggesting
> here. Did you mean to suggest wrapping "interactive" in backticks
> instead of single quotes?

Sorry that wasn't very clear. Yes that is what I was trying to say.

>>> +	if (v >= 0)
>>> +		return v ? UPDATE_REFS_ALWAYS : UPDATE_REFS_NO;
>>> +	else if (!strcmp("interactive", value))
>>> +		return UPDATE_REFS_INTERACTIVE;
>>> +
>>> +	die(_("bad %s value '%s'; valid values are boolean or \"interactive\""), desc, value);
>>
>> I think we normally say "invalid" or "unknown" rather than "bad" in our
>> error messages. It'd be clearer just to list the possible values as
>> there are only three of them.
> 
> It's not just three (see other review from Junio), otherwise OK

As this is a hint in a error message I don't think we need to 
exhaustively list all the possible synonyms git accepts for "true" and 
"false"

>>> +	/* coerce --update-refs=interactive into yes or no.
>>> +	 * we do it here because there's just too much code below that handles
>>> +	 * {,config_}update_refs in one way or another and modifying it to
>>> +	 * account for the new state would be too invasive.
>>> +	 * all further code uses {,config_}update_refs as a tristate. */
>>
>> I think we need to find a cleaner way of handling this. There are only
>> two mentions of options.config_update_refs below this point - is it
>> really so difficult for those to use the enum?
> 
> See above; I opted to make this change as non-invasive as possible and
> keep the complex argument validation logic (lines 1599, 1606-1609)
> intact because I'm not even sure I understand it right.
> 
> Besides, even if I convert those uses to use enumerators, I still
> wouldn't want to deal with non-tristate values beyond this point.

We could add a new boolean variable which is initalized here and use 
that instead in the code below. Of the code below could just call 
should_update_refs() to convert the enum to a boolean.

Best Wishes

Phillip


