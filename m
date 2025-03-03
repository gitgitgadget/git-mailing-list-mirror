Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE733F6
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029550; cv=none; b=rQpGCzh/XCsHRy/YpcAuj4dRn22C4TtkIR8x5dPS5XMgC3/VAmcab1/X/51r2gehF/JRtJohgKdAied7nX9v/6iv7pdcZ6lZ6MrBzvkSHxWck7xc33OfStHX4AfZzkFovn7f8MHyAaLyAljw/hw7bwDpFVil+g26pcdVTwwJBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029550; c=relaxed/simple;
	bh=3McvLd6Rx240Ehdy57pA9a09Xr/NSHsTBUcBd2e8BzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUWuUU5usfIqMdvbN2z8k5eiY9gFgowSMZOfnZVvCHdkVQHdMr3PHEVPtMtW9mxHobIpTRy+OEPyK/ofZH8jA6BUS7nTsgCcNI6LNJfxVIZDh1qAVsmh1XbKfnWGx0cohFAWOUHlI2+tiKzJUlj1vCj3MFdfxee2MdtPMnuMDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=+Y39sNLl; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=J7fURw22; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="+Y39sNLl";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="J7fURw22"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-6e8ab9ea2deso15567086d6.3
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 11:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741029547; x=1741634347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YQv1Izh5/f9Fw394NVjWejafSUwIVX+9/kx5LXV7AXs=;
        b=pj+mu1e351dxif6lyvK2jdBYezBkOUq6ITNGD24TEhw5hTTCWhPZhOvOkxpy/mXaVl
         qzQSoR8v3ZcXok6liQz9m+G+1p2lpfKdSSpjFeDIngzunZ6Fo3NE58b4IS/Y9cnA7mHb
         NAeq9md6Cd+bsb60MQ0IWXBoi7htKz09KPj8m4G6RqYBS4OpDlcmcGg3XAhCAhGhoiRZ
         evXB9moc3RWr6ACOriJBqKgJe+loJG2xu4DCjHyuQpi+tMBBuJqTtRtqLzMjXO/UqRy9
         8kXSSJR7ZcqKUwajEf4/0eDPz5vpg+l8530FxVHtUwZm4Wyv06DHEwfIKcLgEWCKiq2G
         vPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbleljc+tCasK7GwdDxpwsMft7w171HcEP/c5od+rLq+FLYAFSnINumZLdGbcsevgzjrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoqwc0zZoasPLhz+A3e5is+E8oXNTIRqB51bdWqyVJd5eQDX97
	tdZXZ7s6Wt2eJOnkR13Rx6DdQLEymrcnaHzZLeXs0Uu3ln9Pw89w23nZQOcooMla2lFYwXM6cq1
	533Lly5gOxcWJLD8d1QOv+3PxIRfKPjhv
X-Gm-Gg: ASbGncsJywIf3KjnKpQXO6QJGk7s6vIAbnICLkLrpIAxxSuc28LJOFs4gDkFO/9mrL2
	+56XNM+WO+cgZmgC5ZiMnlVBJp2QtIzkIHEMnOi0WvMfw890hLY3sb3qwMelKB2IwPafkg6zam0
	tcgakcsSHYuVnZa5dzTxIsGV/Sl3muA1JJegPNuveV7nHh5h+D9t9fOVkFYWDWzawHHOHMLRBB0
	PbXXNdQiBpPie/5c/6Jm0nPTfQRRbKjRr+qtG2qBOHKd+nFHr00Y93IHyMmUaf8zu5sFW2Tn0jD
	PmORUKDsukDTzVy6oq8SWdeMGYmxqtyuaFT+7/xCxeYvjDAWN6eHWR9sti4IN9X7R/GAo3J/Yga
	hL38Fty8hZlBC2xplsn2bMKCDtbmqFg==
X-Google-Smtp-Source: AGHT+IHtJkdeoa/WS2iOfahp5wCUPkxGS22wboJ5YKoudSzYYou6RL4tP+CuKJzDqADPxyjxsBr9tnr6XxT4
X-Received: by 2002:a05:6214:2aad:b0:6e4:4288:61a3 with SMTP id 6a1803df08f44-6e8a0d25f08mr209964676d6.18.1741029546842;
        Mon, 03 Mar 2025 11:19:06 -0800 (PST)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org (pool-108-49-41-183.bstnma.fios.verizon.net. [108.49.41.183])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e897614aaasm4655966d6.41.2025.03.03.11.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:19:06 -0800 (PST)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741029546; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding : from;
 bh=3McvLd6Rx240Ehdy57pA9a09Xr/NSHsTBUcBd2e8BzU=;
 b=+Y39sNLlLLgnA0iyWbickYwBt5WGLuL786P1D4uulToqA1XLrf82mwMeg5bCWqg0zC+l+
 wkx4pYcRsmsrUy+AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741029546; h=message-id : date : mime-version : subject : to : cc :
 references : from : in-reply-to : content-type :
 content-transfer-encoding : from;
 bh=3McvLd6Rx240Ehdy57pA9a09Xr/NSHsTBUcBd2e8BzU=;
 b=J7fURw22QaHZuopFLaBWZsoqU+ofyrNZm+TbgWFZdPl3NKZ5Ea95SabFFSta+tTxps3BW
 IjygsAweKKqwK8KQhE4hfwz09il1EBzM9+mc1koOPHIbDyEGnvglZHVK1SC0OICI5oCTXYB
 E7yCYhnpcZQvM05NwQhyP3kYxFI9/GxO9bcfLxWqvmA610sgIIvYRxbHT/2cYGunydTN1Sl
 kWrP0Kn8TbT9XZJ6dajq5yDo49OwPLcbwnhr56jdVRqSbKo3mSw4OKWDP9Q3T8yBYMBDzZ8
 7rBrzqMu506jgAOZV0CrdhmVG0Pix6H1cRV4F7UT/S4UR5fJIVy435Jp8DCQ==
Received: from [IPV6:fde5:2b79:35f0:2::166] (unknown [IPv6:fde5:2b79:35f0:2::166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4Z67sQ1gBzz10df;
	Mon,  3 Mar 2025 19:19:06 +0000 (UTC)
Message-ID: <42dfc06e-8eb1-46da-9971-9d102f1390ad@mandelberg.org>
Date: Mon, 3 Mar 2025 14:19:05 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: phillip.wood@dunelm.org.uk,
 David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
 <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
 <65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com>
Content-Language: en-US
From: David Mandelberg <david@mandelberg.org>
In-Reply-To: <65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 2025-03-03 om 11:36 schreef phillip.wood123@gmail.com:
> I'm not really sure what a "large" number looks like for people who 
> track a lot of repositories. On windows forking is pretty slow (our 
> shell-based test suite is incredibly slow on that platform) so I think 
> it makes sense to try and avoid adding new processes.

Thanks, I didn't know about forking being slow on Windows.

Do you know if we need to worry about hitting the max number or length 
of arguments to a command? 
https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/limits.h.html 
under _POSIX_ARG_MAX says that at least 4KiB should be supported, which 
seems low enough to maybe cause trouble, but it's a minimum. 
https://www.in-ulm.de/~mascheck/various/argmax/ lists a bunch of values 
for different platforms, and from a brief scan it looks like all the 
remotely-modern platforms have values that are probably large enough for 
this.

>> I'd like to do some testing to get actual performance numbers before 
>> trying to optimize this, because I think the optimization has some 
>> drawbacks, see below.
>>
>> If optimization is needed, another approach is to parallelize the forks:
>>
>> {
>>      local fer_pids=
>>      for ...
>>      do
>>          __git for-each-ref ... &
>>          fer_pids="$fer_pids $!"
>>      done
>>      test -z "$fer_pids" || wait $fer_pids
>> } | sort | uniq -u
>>
>> That might cause spikes in cpu/memory/disk usage that aren't ideal 
>> though.
> 
> Yes, if there were a 100 remotes that's a bit of a fork-bomb.

I also realized after sending that email that it could run into issues 
with the number of available PIDs too. It could be improved by limiting 
to n child processes at a time and waiting for one to finish before 
starting the next, but that's more complication. I think your solution 
below is better.

>>> local sed_cmd=
>>> local remote
>>> # ref names and therefore remote names cannot contain '*?[]^' so we
>>> # only need to escape '.$/'. Using 'sort -r' means that if there is a
>>> # remote called "github" and another called "github/alice" we will try
>>> # and strip "github/alice" first.
>>> for remote in $(__git_remotes | sort -r)
>>> do
>>>      remote="${remote//./\\./}"
>>>      remote="${remote//\$/\\\$/}"
>>>      remote="${remote//\//\\\//}"
>>
>> Just FYI since it took me hours to figure this out myself: I think 
>> this would break tests on macos because of an old version of bash that 
>> handles backslashes weirdly. I think removing the double quotes would 
>> work around that issue, and be safe because word splitting doesn't 
>> happen in assignments.
> 
> Thanks, I'm not familiar with bash's extensions to parameter 
> substitution. The completions can also but used under zsh (git- 
> completion.zsh is pretty much abandoned I think) but it looks like bash 
> and zsh agree on this expansion.

The tests don't automatically run under zsh though, right? Maybe I 
should try to figure out how to do that in a separate patch...

>>>      sed_cmd="${sed_cmd} -e s/^refs\/remotes\/$remote\/// -e t"
>>> done
>>
>> Mostly just a note to myself if I end up using this idea: I think a 
>> space in $remote would break this because bash would split up the arg 
>> to sed. There's probably some way to fix that with extra escaping though?
> 
> I should have said in the comment above that ref names cannot contain 
> space, tab, newline etc. so we don't have to worry about the shell's 
> word splitting splitting the patterns. They cannot contain backslashes 
> either.

Good to know. Is https://git-scm.com/docs/git-check-ref-format the place 
I should have read to understand what escaping is needed and what isn't 
because of the limitations on ref names?

>>> __git for-each-ref --format="$fer_pfx$sfx" \
>>>      ${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>>>      "refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" |
>>
>> This would search for $cur_ in the wrong place because * only matches 
>> one path component, right? Changing to ** might help, but then it 
>> would match in places more it shouldn't.
> 
> Oh, good point I'd missed that. Could we change sed to run with '-n' and 
> generate an expression that looks like
> 
>      -e s|^refs/remotes/$remote/\($cur_\)|\1|p -e t
> 
> with the appropriate escaping of $remote and $cur_ so that we only print 
> the output of for-each-ref that matches $cur_?

I think that would work. I was hoping to avoid sed, and I was thinking 
about using shell's ${parameter#word} to strip and test for matching 
prefixes. But I can't think of a way to do that with 
GIT_COMPLETION_IGNORE_CASE. Modern bash has ${parameter@L} to lowercase 
a string, but I don't think the version of bash on macos has that. With 
sed it would just be a matter of adding the i flag if needed.

I don't think this is an issue, but do we need to worry about putting 
remote names and $cur_ on the command line where any other user on the 
same system can read them? $cur_ was already on the command line before 
this patch, and remote names appear on other git command lines all the 
time, so I doubt they're meant to be secret.

Is a Helped-by trailer the right way to credit you for your suggestions 
on this?
