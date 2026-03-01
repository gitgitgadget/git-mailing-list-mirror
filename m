Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC27175A79
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772361416; cv=none; b=HSB438I11xvFvLrg5+MSHCZM/eu20Z589NMx46Fwx2GYHNTCDxi/PgetskPSK5o8znH70zVuIHiuRhww3pFmm7HbLBkO5mPwkoWE0RzEO7J9FXbkBzqrXhoHVR+pyXuN+HsoF/wC1QiBs+JZOBBmRthwnyZic696zI+TGCefAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772361416; c=relaxed/simple;
	bh=eDCsg3/PCDG3Xxy/avAU7ovsGlrevYQEtk+ltdq8dRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i43kuTxLdPgRf6PHkXfxJKI+RAWVwE5sj5UQWMjWZ2wQuq3VzSyvOyqRcC9AR4NatB7OjgUxYqFBahDFcL8/75lKhpC/mpe+CTwlPwPwUoF4UP4oe4RZg/IiowoDTu55jtH82IM80DRIluWna5irsu768NBRn5LNHOMMmePTfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyTUC7Cx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyTUC7Cx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso38149885e9.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772361413; x=1772966213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ07QUncZyFk5SeAPcPvsN2c6w1sJmIp4aFu6ljxZHs=;
        b=DyTUC7CxAEI377P6eBVgn+Gh18WIF0uUrV7Y2J9Q6L3p5Giqb1LuTXDHVuUA+myEcA
         BdiX4zQzuNOZobtas/GPJtcUp/DpQwWvP0/f58hXLLmNczu3qiPNpusTdLAAzzLdvJIg
         p/vAXJ4UugGntQXNnO+2nWJ48LUy/w5bbsVf3tF3ST41jDbvbaUNLqBMEQQY6FfCLXrH
         52470rEUkpHYWb696Vlpy0vBNahc64/tFmEECjJAXNfLNL0wBlw+TvGI1uVPPp2fgMxF
         E30ocMhtD+bGqZu9njj0pnUlsigcvtbc8ZGXv+8YPetGL1G/Jo86OTY6KODJKWP1I5lm
         c6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772361413; x=1772966213;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ07QUncZyFk5SeAPcPvsN2c6w1sJmIp4aFu6ljxZHs=;
        b=P6kLizyIDewJKcSc2YYOwO43ItCps2V75SzxiNNm6CbAT9j6ll/J3Zr+tLsMNt9gIt
         YD5Oq4xpBUV/wf6gyaX7ORjummaVkAQZUxA7EvXwinpMAwCdDpCHrpk9R9Lru9Ag6t7o
         6ll2eM9cNEZV1ALAeJf3johML/fAq6/7C2ZZItOKgze6bpBDmLyqsqyAqYA9/Qe2Nxy8
         vnCvb55AQKoeuhkB9p3b55C8KNMwQawrYNqqqEBxrTJ0555exC4mWcWy/AUcDx6jP4oY
         5AkLgPlU9Cxh4qVVNWEdjgkZCFhNZb8tj3nYx5sojK/JIG2f/L2NsBYptturrQMTmhHr
         YKnA==
X-Forwarded-Encrypted: i=1; AJvYcCX9FYsRmhghlqpS2GzVrvk5k0Yil4/ACXIAWuRLP+75DRPQG2/e2XAR6IWGParDsW8BoBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykt+ZBQ498xWolpP0f2L5KbvCeZ2X3uHJOl409JFxBg/W8kOAz
	xQtxJmE2AgUsWLh5WS9m41PiHgXoGfpMq2/elPHyQ0jNg+5qFs3Sx2RkRaulAg==
X-Gm-Gg: ATEYQzxWF9ISk2zTsmnmdEr7uoa/tsRnKjISz8ZtRN7PyEOlLTjyZvj3qayCEV+5EzV
	O7rb2rGEKemUB4dtX2BBKYx1xfolezJKoBpzN+S8c9BXCXiY1jtcRKMdmyBCfWFZjR6ajKPBo8G
	oakiyrhOXRag0MZ6ss/U+/6nFSpwmWCoWScDZUIIgk+MGjKQkSJgQeaU3uWjp9RakRCWy9YqPov
	HBM55crEuczyKSRYYQIUlqa5yWUuBn55YkIqsiY6n677SpXGR/tB1tEC0i/T/rwGNRRwQ5kc1k/
	yEqeNpAb08Yk+mXxdD74GfChVA56Dv8O/RCb65IfoE7ZQjKT0gD9C3Tmp6CMPxBwifKDxw2yv13
	EV1dH+5/lSBZGCewsa2L3ewoMXUGbl5TivqShpctTH2EwDukn8P0B4pvqaTv6pI94xFK/wLyIEF
	DTUtOMCUaxS/ickCz34ALi7+9wTtDcVOz6RTsb9hBb+LGn2e4fripGsfLxrqacWoTkxk6/TDuVY
	a/sre+gDcYAi4yF
X-Received: by 2002:a05:600c:a4b:b0:483:71f7:2797 with SMTP id 5b1f17b1804b1-483c9ba3785mr160348385e9.14.1772361413241;
        Sun, 01 Mar 2026 02:36:53 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f3124sm334828315e9.1.2026.03.01.02.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 02:36:52 -0800 (PST)
Message-ID: <58d46ec7-99cd-4878-b05d-a378ca119a68@gmail.com>
Date: Sun, 1 Mar 2026 10:36:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 02/10] repo: add path keys to repo info
To: Junio C Hamano <gitster@pobox.com>
Cc: Eslam reda ragheb via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, eslam reda <eslam.reda.div@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
 <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
 <6d5b9ff07566e1cc28a672cf1f47988e9c8c45da.1772140487.git.gitgitgadget@gmail.com>
 <3c4d4909-4eb1-47f4-b601-8f877a07ddd5@gmail.com> <xmqqldgeotgi.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqldgeotgi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2026 19:51, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> +	{ "path.objects-directory", get_path_objects_directory },
>>> +	{ "path.packed-refs-file", get_path_packed_refs_file },
>>> +	{ "path.refs-directory", get_path_refs_directory },
> 
> The same comment applies to these entries as well, as the pluggable
> object database support is just beyond the horizon if I understand
> correctly.

Good point. Also what is the "shallow file" below and should scripts be 
poking it directly?

>>> +	{ "path.shallow-file", get_path_shallow_file },
>>> +	{ "path.superproject-working-tree", get_path_superproject_working_tree },
>>> +	{ "path.toplevel", get_path_toplevel },
>>
>> 'path.toplevel' matches the git-rev-parse option but 'path.work-tree'
>> might be more descriptive?
> 
> I think the "git repo" thrust comes primarily from being unfamiliar
> with "rev-parse" (and I wouldn't particularly encourage new people
> to become familiar with it---it grew pretty much organically driven
> by scripting needs without taking UI cleanliness into consideration
> very much), so not many folks would find it disturbing that
> "--toplevel" corresponds to "topOfTheWorkingTree".  Given that we
> have a token to ask for superproject's working tree, giving a name
> made after the same phrasing philosophy for the current project's
> working tree would be a good thing, i.e., "path.working-tree".

That's a good idea

>> What happens if 'path.toplevel' is requested in a bare repository?
> 
> FWIW "git rev-parse --show-toplevel" dies with "must be run in a
> work tree".  Better or worse,
> 
> 	rm -fr new
> 	git init new
> 	cd new/.git && git rev-parse --show-toplevel
> 
> also dies the same way, which I am not sure we want to inherit when
> we are making a new interrogator command.

Yes, I think printing an empty value after the key would be better - I 
don't think there are any paths where we care about the distinction 
between NULL and ""

Thanks

Phillip

