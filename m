Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0EA286D6E
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053905; cv=none; b=PwFu6GBzBDmO0YgZ5OyOyGiva3/FZyDTnq1TH1K7934didT9wY+O0cmJQYMIlDHNGN6rWIpNQw73KnhY2q66rZ2mxmQv7OO/RH6FbChWgU2SggeSrkFV5fw2qhWU5+wN1elkeURQfRxdEYLx71Rw6nvUGoyM/XhaPxzADHkt7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053905; c=relaxed/simple;
	bh=IVNFVWlJi2m6H7yBTtschwIjRrYVe1auBk9KT8XCvN4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=baOZqTliu8kfTip/ercfvMBsScnKkgvn8w9o7r1eBz4UuFcXRu1WwVHChYZ0LixA+tpR5fy4PFBBFSsSqw/fA+oRjK4JriEgJV9L217Hlv7aICl1OOdhzys5IxwHhQVUg0V3uqI1w+BF0P9e6aipU5VtU3vUO3yOZRaStQg0rpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOykRudT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOykRudT"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so29152435e9.2
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752053901; x=1752658701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LIV0+ddN7Jz+LXwbtgQsFw4OsAYOlAkrXPy6mp6u8I=;
        b=OOykRudTdPNi1pmvaFANZkweqxa8h+32Q//XLH0bIVRpGX1uKgJmWBD6UB2bjrah08
         7EneSP4+8bMKUQfH1vMuf+8CmUL6rDH0Jiqu8DxTA/Wdd3VfGheHFQT6M2xKwgobuJ7O
         WqME7KLvk5dwCbz44Fn6V8HRLuuICGI/7K26PdeYt9/MyRA2M/bksRS64yap7Evv7Fob
         ikMj6L0+hjMsrM0vXn4JIWHsobPVqZu9RHd8tKVlwRdJ5AVSX9nToC50sDCbZ88SYCpQ
         sUHjWB+B61cWbZbGAnKnm+9vy2twMqB0GJJJ+sMO6t8HV/HftCJbtVusyMSUmsKzowoN
         GpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752053901; x=1752658701;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LIV0+ddN7Jz+LXwbtgQsFw4OsAYOlAkrXPy6mp6u8I=;
        b=Xqo8y77kH0/ip5/xIbDxZ+Vn2B8QjECL7i5JU/ILtei+j9XmrXm80HXLJaPlQZ9IBf
         KiPva1LsP5Qmnxi3CRsn1pdB5ZRuMXt8WLy5LJAUHYVeLIjkh3HTIHgK46xYgPuzt6h0
         CEPXY8ZsysoKfjdbqQ5LkTH+84M3XxS7sZJX9kYgaVdp41zwp9zWF5/Z+508bTw89xPt
         ddCJXQvUnmfkJaSp6tkR5rFZNERnh88hz9NpfaJhmlS/JyJ5cpVhZlrS8XPfJwzwnFsi
         nlJHrVCttM+V6nvrNvAnPQ8KJRzfrUxCRJNxzmnLSFTUu0t0x6g+W9WZ+U6RsAVGcePd
         DOcg==
X-Gm-Message-State: AOJu0Yy0nnG4IIEZq7sS9u5ZsGJdb56q1cxWm3KkNv4QPwRxcdDd7dQa
	OWEtXOBFQT7qt7ZKar+kQOX8UoEbu+NwYQASUh+WqGm1KlL/P+EM15rxQaHwag==
X-Gm-Gg: ASbGnct2fVq3jV5gJTEKtoxlRfZx3K5E4NfJtREbN91QT7YTMAakaIUt9WUw9oFlaXV
	UkSsPqKYFoyeh2GxVVHuzdjCg3/sLqJNpIqYCsxAEnob4240hRCYSHXuOLdjzWtQ9D5D2LH8U4a
	/aLBfyFDGyM2ZXaUxDL5etVn2N1q7A7aMCsDwf2iQTaxnuQUgNJX8kqeoIXAme3avWwnrnIWm4q
	y9cvbCwCcyWZ0kvvma57kA1tW21Tw3svbFiHaX/LL67jZFX3tW6rwU1p1qo751ctH1D41ppRQDC
	pmC9K2ZgreR6OzcFmjUKvzZHh+W88lxkHZ3wfoqUkEtiAgkpCh4qEu35XpD/yRi0NAiEpOPKCVg
	aOuVTlgHUTooZwhNqLcyGWBEgchIJu96/1OGDuQ==
X-Google-Smtp-Source: AGHT+IEl/hPmu04LPLKAAtjGUNUg7Zv5c3/yz3adPnpwQuheRKsGb8DqCIf45tRTW/83Z9f+EVYk6Q==
X-Received: by 2002:a05:600c:548d:b0:454:ac5d:3919 with SMTP id 5b1f17b1804b1-454d530eb35mr14923165e9.2.1752053901299;
        Wed, 09 Jul 2025 02:38:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5061450sm17165375e9.22.2025.07.09.02.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 02:38:20 -0700 (PDT)
Message-ID: <f679151a-c843-44d4-9e28-27112d26f30c@gmail.com>
Date: Wed, 9 Jul 2025 10:38:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for
 core.commentChar=auto
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Taylor Blau
 <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <xmqqjz4iv7mt.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqjz4iv7mt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2025 19:51, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> This series implements the plan to deprecate and remove support for
>> core.commentChar=auto outlined in [1]. This feature has been the
>> source of a couple of bug reports recently [2,3] and as explained in
>> the first patch the design is tricky to fix. When git sees the
>> deprecated config setting it will print advice like the example below
>> to help the user either remove the setting or set a custom comment
>> string.

With hindsight I should have been clearer here that the advice given is 
based on the user's config settings. In this case the files look like

~/.gitconfig:
     [core]
         commentChar = auto

~/$XDG_COMFIG/HOME/git/config
     [core]
         commentString = %
         commentString = !
         commentChar = auto

>> hint: Support for 'core.commentChar=auto' is deprecated and will be removed in git 3.0
>> hint:
>> hint: To use the default comment string (#) please run
>> hint:
>> hint:     git config unset --file ~/.config/git/config --all core.commentString
>> hint:     git config unset --file ~/.config/git/config core.commentChar
>> hint:     git config unset --global core.commentChar
> 
> We'd need to clear both variants from all scopes, wouldn't we?
> 
> 	for scope in "" --local --global --worktree
> 	do
> 		for variant in commentString commentChar
> 		do
> 			git config unset $scope --all core.$variant
> 		done
> 	done

The advice includes commands to clear all the scopes that are set. It 
correctly handles include files and correctly handles cases where both 
.gitconfig and $XDG_CONFIG_HOME/git/config exist (where "git config 
unset --global <key>" will only unset <key> in ~/.gitconfig)

>> hint:
>> hint: To set a custom comment string please run
>> hint:
>> hint:     git config set --global core.commentChar <comment string>
>> hint:
>> hint: where '<comment string>' is the string you wish to use.
> 
> I do not particulary find it sensible to nudge users to use the same
> commentChar across all projects with possibly different project
> conventions by suggesting use of the --global option here.

The advice will recommend a command that updates commentChar in the 
scope where it is currently set so if it is set globally it will not 
prompt you to set it locally in each repository and if it is set locally 
it will prompt you to update it there.
> It would be necessary to special case "auto" after 3.0 boundary
> anyway, whether we (1) die when we notice the value is set to
> "auto", and refuse to work until the user chooses a comment char, or
> (2) use "#" or something hardcoded.  Either would be better than
> using literal string "auto" as comment char.

We can do that if you've changed your view from 
<xmqqfrj6vfsn.fsf@gitster.g>

> So, a simpler approach might be to treat literal string "auto" as if
> "#" was specified under WITH_BREAKING_CHANGES so that the end-user
> does not have to do anything when they want to "revert" to the
> default comment string.  Then we do not have to give any large text
> like the above.  We can instead say something like
> 
> 	The 'auto' setting of core.commentChar (or core.commentString)
> 	will change its meaning in Git 3.0 and later and will always
> 	use the default '#'.

That's certainly simpler for us but it does not help the user to update 
their config. Presumably they're using the auto commentchar because '#' 
does not work for them.

Thanks

Phillip
> Hmm?
> 
>> [1] https://lore.kernel.org/git/6a3154e0-e7bc-45ae-b554-67ccab18727a@gmail.com
>> [2] https://lore.kernel.org/git/20250315140913.577404-1-oswald.buddenhagen@gmx.de
>> [3] https://lore.kernel.org/git/20250626132233.414789-1-ayu.chandekar@gmail.com
>>
>> Base-Commit: f0135a9047ca37d4d117dcf21f7e3e89fad85d00
>> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fremove-auto-comment-char%2Fv1
>> View-Changes-At: https://github.com/phillipwood/git/compare/f0135a904...83d0d3ece
>> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/remove-auto-comment-char/v1
>>
>>
>> Phillip Wood (2):
>>    breaking-changes: deprecate support for core.commentString=auto
>>    commit: print advice when core.commentString=auto
>>
>>   Documentation/BreakingChanges.adoc |   4 +
>>   Documentation/config/core.adoc     |  20 ++-
>>   builtin/commit.c                   | 192 +++++++++++++++++++++++++++++
>>   config.c                           |   4 +
>>   environment.c                      |   2 +
>>   environment.h                      |   2 +
>>   t/t3404-rebase-interactive.sh      |   2 +-
>>   t/t7502-commit-porcelain.sh        |  32 ++++-
>>   8 files changed, 252 insertions(+), 6 deletions(-)

