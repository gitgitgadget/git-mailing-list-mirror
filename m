Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7E83009EE
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781583; cv=none; b=RtdvPL4HeKyyVZB5I8I98/RearkbAKeMThC35YhoEDB+C7CwjWwFtNNjmpeLh44N1nrLnhLDv6BvKZxQohK7anoZIDbfr+zEPgPNEH3uCiBlkygLe/0jzw7vcVYrcJdHb+qADNSX4juodx6brPoghP3qR6OoKALf4NKIGsgqkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781583; c=relaxed/simple;
	bh=uXz8fUEwzGrJAUfexf9IMW649YTJh8j2lzUwi1oEv+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtwuIBJ8fJlqtEIytYZYGB3kO0F+K1YY8zc1yMkPHWGPB2cBbWSq9JjcnV++kOFMHRMR7YGEg9vfNQcKa1DPq5nPjrO0BmRPCvQD9+7Zx0OFjsP4QgG1HkSFjdLgsZwJCO6ey34dtEhi1V+Lmes3n7LCgN0bEyypeUvprlEGtZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxnQJaZF; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxnQJaZF"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso16663665e9.2
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 02:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767781581; x=1768386381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r6Djq7xahbNzWlnesSnuzMt4+QmZ6gKxYXcff0rbQuY=;
        b=RxnQJaZFUeDN7ansGKjPwe504GXLGdNM/P6KsZcfibrZ4i/hFOLNoXldg+RZwGup+s
         5WMEAc/hdGODkL/FzCRjCJGtnqagwtOHvoFBh6wIMRUUe0AVx2D7PkhahmS1ZGyHbNKm
         A9Cn2+DDAtxUBX3maui+6ZGyz0QWhuC+/V5t4GV9/JMNKT401mYCACTMEj1GTX8us93r
         pFIQp3yyg72o8HvV4mZ3PAXQKhNdO7q8GQVFumSbgVLmQFAwZkj7SjG8o4UiHaGO0d1U
         bij8bOg1x2GQbjNGM9Q3RdFddeUmAwALxf2HkQy8g4QP1a2lvegJ4ELgNare1aVaM/ni
         lNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767781581; x=1768386381;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6Djq7xahbNzWlnesSnuzMt4+QmZ6gKxYXcff0rbQuY=;
        b=rMCNyNB71CLWLl5G7pJ9e/YvmfOXVB/kN0clJcOgHZ9iG1/k6xpAScXswf1zegvdzu
         tQrkfywVGIKKpX2bXvLjtiJydjkSA4JHcKj6euOJJi4cTy1Vez+r58ROf9Ij05z9ctE1
         KZe1TWYrM3iQoK7tXG14uDu8rC+yqXLrtN121ES8Q6Gs2LbEjVfxskAAJbUOC+Il7Bfn
         HIs0mOJs0ErOvwFczcQXfFgJDTMScXfn4NNIfsrtq/0Yk7gmsDh/OucOiFaa1mYVhwt+
         74Bemz4xBNCXWGTMhUG0LEYniMBaOnaCvlkHlOAt/kv9dOlQLDLaQPuAmAvRBnMbw75O
         z4hg==
X-Gm-Message-State: AOJu0Yzq/7S9U4gqJRSPKvUqQeupihgxo+TKXE9e4i9nWVbhVcIhzzwg
	tfPIu8M1ujHHzsYOBIXLb6a0ui3isBWFXlbSROTI4RP2g2vhG+/YMvNnZsWJN2SP
X-Gm-Gg: AY/fxX6o3oilgJXzLFX7qrrTUHaePlLohqBj6wijHMz2aEzxxgiiVfDDdt4bySbcBIe
	S2Rnm92VlQ22iicSANLoh2aEMIU5PYZ+ZsgLGxQCb5f6WiekjBPzqvccH/tDq/JjM3LClqWI4no
	9HUXJwHlFidHUMWd9c3TFQMCaOjKcAbxxztiGaHN+iwchYDD3uvPgQw7XAv3OYRx5lqSyHFYmo4
	PN6fnE9QftxsEag8YCspDthjmDD7XfSv7QdI+CoQgBpJ6z1UnuDeDeXaIRCWxKM0hVhuzjKFJJx
	QZ7m+B1EoO+QZnL0q1N4oY0Rc7OI6XChNxKZBmRraWNMKOnd3ap5or2SG7V4HEcOig0kQno5hln
	5ppeOrEmlJe1/q73Ddcoxb99J2YCVyPg8ApjCuNcR4Jqari83/GF4G0Kn7cJxe92U/kx6Gbbr0I
	nDN3TFvqfcuv0YnXQH7qshXs/w2M+TWSut5JD7IftWzieQZ8jWhS9+gO3e01VBloIZeA==
X-Google-Smtp-Source: AGHT+IH7U0nyUcgnR8NqPGBCz5BGLhlf8NVpKDmLgPrkgDt07YkHUppc+4egdY76xXl+L16B7ejzmw==
X-Received: by 2002:a05:600c:c08b:b0:47d:6856:9bd9 with SMTP id 5b1f17b1804b1-47d84b33bccmr17191835e9.23.1767781580489;
        Wed, 07 Jan 2026 02:26:20 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653c78sm93334585e9.11.2026.01.07.02.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 02:26:20 -0800 (PST)
Message-ID: <922629dc-828c-4bdf-939c-b38b7b59e8e8@gmail.com>
Date: Wed, 7 Jan 2026 10:26:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into
 repo-setting
To: Bello Olamide <belkid98@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau
 <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
References: <aVfzMsN2ouY3UBFG@ubuntu>
 <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
 <3947f777-e08a-4c17-81e3-c4711fe666a0@gmail.com> <xmqqwm1vk83a.fsf@gitster.g>
 <CAD=f0L9BEPSQivgpM7qURT+WFDY-+Ys_M6Knv8hE0JDw4Wjj5A@mail.gmail.com>
 <CAD=f0L9H5Q=zW02nr11OSBNgFH3UMLwVjVjn3zhgZ2rjwE85WA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAD=f0L9H5Q=zW02nr11OSBNgFH3UMLwVjVjn3zhgZ2rjwE85WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/01/2026 13:44, Bello Olamide wrote:
> On Tue, 6 Jan 2026 at 10:33, Bello Olamide <belkid98@gmail.com> wrote:
>>
>> On Mon, 5 Jan 2026 at 23:28, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>>> On 05/01/2026 14:23, Phillip Wood wrote:
>>>>>
>>>>> It is quite common that moving from parsing config settings eagerly by
>>>>> calling repo_config() at startup to parsing them lazily via 'stuct
>>>>> repo_settings' causes regressions like this. We really should find a way
>>>>> to address that before moving more settings into 'struct repo_settings'
>>>>
>>>> See
>>>> https://lore.kernel.org/git/d61c966b-61ae-4ba9-b983-c8dab6e2c292@gmail.com
>>>> for some discussion about a possible solution.
>>>
>>> Nice, but I suspect it would be an improvement already without
>>> passing repository instance via git_default_config() and instead
>>> have the code use the_repository; it is even possible not to have
>>> any repository when the callchain executes.
> 
> But won't this be a temporary solution since the goal is to prevent the use of
> `the_repository`?

Yes but it would be a good start as passing a repository down to 
git_default_config() will be quite invasive. It would certainly be 
better if we can find a solution that uses the repository passed to 
command when it is non-NULL. Unfortunately commands like "git diff 
--no-index" are passed a NULL repository but we have chosen to store our 
config in a `struct repository` and so we need some kind of fake 
repository for those commands. If we stored our config in a separate 
struct we wouldn't need to fake a repository but then we'd have to pass 
the config round separately to the repository which is a pain. Perhaps 
git_default_config() could use `the_repository` when it's given a NULL 
pointer for the callback data.

Thanks

Phillip

