Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA753AFAF4
	for <git@vger.kernel.org>; Tue, 12 May 2026 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595816; cv=none; b=rZhhN2s9VP4ju0ajmvGJKOhG9YIv9j2pz8eMK3h+5t0upoNXjOKSKnP3y5Ci4poRjHB/IxNgK6HhCspKOTGHcRiZel6CeiOYSaTF3eBQGUKDPfecXoVYW8dNMw7d827wA611Lt3ELl+cbNgdgYl7cmm7ZnjYxROm1a3DEWcmWOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595816; c=relaxed/simple;
	bh=D1WKZDeUrio0QQvrgTu/ls1MNtjir2klq+aabL9cJYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSBuXyuLj4z9hTRR6oUC865hkMCHSPjmQo42kCjpc7tgtPkb07AA/2hkpK/nPv1bIOCv88L0SMKK+TZLAQOaYT5kH4RTI4Y2F6HQ3NAUagOoMcGKAyaX6vPkLwvm4umQ7GObLTLXIW47S0pliguZHZltnIZ5UteB4MkdpTgROeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGGmee8i; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGGmee8i"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso51414776d6.3
        for <git@vger.kernel.org>; Tue, 12 May 2026 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778595814; x=1779200614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RP66e67SUh5G5HX++4kFV6L0wh30plQPJofF4Wy5Qq8=;
        b=rGGmee8iEH0YHbXVVP3NtpaDAs1BnSN177Wt4QRnhZiPJ+o7gjFNx4+m0bN8TRpQrO
         M/+xoqK8hYhUpKljX9ef/OnBVmovMmrfL73b6+2cIrL4W8cPZRf8oJJg5bNc1sWbASFi
         ryBvs7BMywf43ThICs5UQl3PZLd4LBa2TqQeNUYzgufyYU1JDP9VxIY0uPkUkjWAu3NG
         vZ8A3EVRIuMLlG62TGT+Zi2T2GhoRRGYseDzKBgMXWB9Xdg+M7PW+TSGsabos8DNsuKb
         pR8PYx8TQGeohQxUPY4ww8LDXhVWhAvjODjmxrORjeIQvxBXTetndpGXqnffjFRE/w19
         Fl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778595814; x=1779200614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RP66e67SUh5G5HX++4kFV6L0wh30plQPJofF4Wy5Qq8=;
        b=gpkxc0z6u4PArnmGSOWwg0ITuCBLQvz5MXpU4rFtTHKcv6enuBGwRX9kI6NYZgpqBz
         tUL+Kz/mKINu1a8usULPrzKM29H5iBL1zAXz6xZaAocKq4C9VTiNxXp7BZDxTweiz0cj
         8kOov7xDWhFcSILfkaeXLNsmZN3R/MoLHqAuumL0M4D9iKaKV4HSRSG+Zb17yDh91Ng8
         CGQEH7+2sij59daILeja6uOJ5PmFaIwtrtjJ5Vt8ElnMdYFgyj/fcEHjywSaCioqbxsv
         8IQsYa2q5zYdo0DcM7yihFkEFddBpT496LveKlxjbPIBSnIqkPSbL+JnFmfponIh9no9
         lOMA==
X-Forwarded-Encrypted: i=1; AFNElJ/1c96W5P+pV7ariU/rDysZJ3Zd4c1HsIt1lBqq5d+GWfBvYXSJ9oVmtV71U/5oEuylOIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZu+GnIVuRGKGlNFEDxoVZcNAPF+RwuPNBQBn+ocoLLgoNU0Ym
	0kphunjTsaaCETCxNwH69W6v92LQgvgkA81jNwQ3jHiPFhuEZthCZPdz
X-Gm-Gg: Acq92OHGhGjO9Ltbed8TWa5kGudKYS7U0nPhSbIq6xH6nMgVVpPhEs/XGiVOd3QpKrP
	UhMZ/ayOmeTFX0jUtZVMiQXY18Ycqdu4gx//kGqR8WjF3GetTbr9fTBQunpAzkgnKVx4ksVQzmJ
	E1SuomcW9GX6F7YxkSrhP4hFlaRhLwJAEU1WQRBQhzPjxZC4ehUzizic5xbEqD/624kFnTdRnIW
	e5fOim+uppDI3UPb9TF1vYc9R4S6TRunl9nCP3NuEUmaoJodrCQKpf3JKj42khLDzOEEN3iDofc
	mrudfDkFMNY6ugrIlN5fa51v+V+uE8v9kuz01RvtOQg0krB6giz+vnSsfQgXgYsn+1BTmk24V01
	9NhRdj//tTxkKlPWV1ZbaYMSJRVWx4vvzcUpa2JfpTrBnWL9FWvyFKaEcNsUOKe4155DK8NZvs6
	wy+eXlbSZPkDplsN+4QBfGmvuO9MY+S9+uoNhhzxgnVmLKWa49D2MQGy8hlOnveEJwA3sWoiGK+
	9r3zEM4aGErEBwYf77j4rXUvL783Jrzs0iOvvHiBVsC73XmarU=
X-Received: by 2002:a05:6214:238c:b0:8ac:a4e1:3f87 with SMTP id 6a1803df08f44-8bc46bc1077mr442625916d6.42.1778595814259;
        Tue, 12 May 2026 07:23:34 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c? ([2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c72e70e095sm6836726d6.0.2026.05.12.07.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 07:23:33 -0700 (PDT)
Message-ID: <a2eab12b-49c0-4786-88cc-15f9996aca2b@gmail.com>
Date: Tue, 12 May 2026 10:23:32 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] fetch: add --negotiation-restrict option
To: Matthew John Cheetham <mjcheetham@outlook.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <fe875399a851ba27ab193463cb6a1faf62aa6835.1776871546.git.gitgitgadget@gmail.com>
 <VI0PR03MB116340D42554FA1D08E51910BC0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <VI0PR03MB116340D42554FA1D08E51910BC0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/26 7:11 AM, Matthew John Cheetham wrote:
> On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>

>> --- a/Documentation/fetch-options.adoc
>> +++ b/Documentation/fetch-options.adoc
>> @@ -49,6 +49,7 @@ the current repository has the same history as the source 
>> repository.
>>       `.git/shallow`. This option updates `.git/shallow` and accepts such
>>       refs.
>> +`--negotiation-restrict=(<commit>|<glob>)`::
>>   `--negotiation-tip=(<commit>|<glob>)`::
>>       By default, Git will report, to the server, commits reachable
>>       from all local refs to find common commits in an attempt to
>> @@ -58,6 +59,9 @@ the current repository has the same history as the source 
>> repository.
>>       local ref is likely to have commits in common with the
>>       upstream ref being fetched.
>>   +
>> +`--negotiation-restrict` is the preferred name for this option;
>> +`--negotiation-tip` is accepted as a synonym.
>> ++
>>   This option may be specified more than once; if so, Git will report
>>   commits reachable from any of the given commits.
>>   +
> 
> By my eyes it looks like two other references to the old name remain and
> could also be updated for consistency (since --negotiation-restrict is
> now the preferred name):
> 
>   1. Documentation/fetch-options.adoc, under `--negotiate-only`:
>        "ancestors of the provided `--negotiation-tip=` arguments"
> 
>   2. Documentation/config/fetch.adoc:
>        "See also the `--negotiate-only` and `--negotiation-tip` options"
> 
> Of course the old name will still work, so this is more a nit-pick :-)

Thanks for catching these! I will make the correct updates in the
next version.

>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index 7e67fdce97..821cc6699a 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -999,6 +999,9 @@ int cmd_pull(int argc,
>>           OPT_PASSTHRU_ARGV(0, "negotiation-tip", &opt_fetch, N_("revision"),
>>               N_("report that we have only objects reachable from this object"),
>>               0),
>> +        OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
>> +            N_("report that we have only objects reachable from this object"),
>> +            0),
>>           OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
>>                N_("check for forced-updates on all updated branches")),
>>           OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
> 
> It's a shame we don't have a nice way to combine the `OPT_ALIAS` and
> `OPT_PASSTHRU_ARGV` functionality, but it's only a small duplication
> cost of the repeated definition.

Actually, I just missed that I should use OPT_ALIAS in 'pull' as well as
how it's used in 'fetch'. Will fix.

Thanks,
-Stolee

