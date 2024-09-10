Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649AE14A4C3
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957738; cv=none; b=tRRvxARqCiF+UrSvCQGnylC4h0k/Y1DuaL/OT7vxW4ZWo/DtmXyx+4hD+bkf1IZurX0FlJEu2Y4btbxrP7phRs9kJqaonZ5/POp91qifrWdIT0AMMemf656s12ExgmJu7YlCEsyHFJpsE4EqjRTsIdwh0l/OWHduIPSx7ZD1ZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957738; c=relaxed/simple;
	bh=RL/s1mWJwebmHWSOmYANcCrnvLOCqt6K+Y+a2d962dU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LAfkHbZmLEPGM5ANtOy9ZNti+AoFgm+7YfH+teNdI9B+yiFEo0LAe4pSxJz49ou3j88V5b8HgqXJpWoHU7XLXOlQpBi9vgkkmS36pvEBLjxFQdTJryex6bH+VlBcSnFDxtPqzro1gnT8jswK6S95DRH2UR28NJWCoYaHETKcQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzlMYZpX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzlMYZpX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb2191107so18569225e9.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725957735; x=1726562535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjMuvZTeWKgjLsJqLdzzIBd+rbkJt4uzoK50LGMF3P4=;
        b=SzlMYZpXFBq7qb7tRrHfWgaD0wuuThNDjgBMnslGuK5BJhmW1teZcfSPXlu9weJdDJ
         gcEXdkH8+CemDg3hO1XkNXSTjlApB/4Hs7IDA3Ev3zR5DL73XSYhLhz9EC5luw9IGlBU
         sswAjqQanSnUxMTb6J2KnJdC0Xz4bSUczvw5F/qQTEplujZpEPwO3KSFdMsEBsdo2sD+
         qZbBF7tIQja5OCGsTVbpNnNQQLQkRgux0QxlmTthK/v2tdVhyBdyq6E0XdidFAKCl0xL
         Bk8RALKFZhKL4PfOzzdYhDD+dUMgwXHxR+4/UnJF2zFsGSjbPNQmynVPeJ5O5d/7Y7Cb
         AxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725957735; x=1726562535;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjMuvZTeWKgjLsJqLdzzIBd+rbkJt4uzoK50LGMF3P4=;
        b=tTb5gPMtSbUf0MRJ9NMSWbFWHlgHvHOU4rQtidNfObkRWZO41c0wDIK6MzGtStjOtn
         BRng55+zQK3VALpO3VKpOV5xK6SKvxXJJtURedDqVhNZ/SDbpIrxwtCOlPg1kZZHkYPY
         ld66nOTlLJ++uGe6p68fRmsIVK58focTvSQQJnkPhfL6gsKdu0IiUYQrYABW1dGlgdz5
         wCA25/HgsKWc4/7rQlNnw56dOfXbqCPC19VQGlevXv072VQ3bW4V/kHajEs2JtzHK0IR
         Ww+8ZAMP1fP3zz/aT/nJdYs6go56t3SfpqLK3ClUoBgNvwOi7PhV/qJnaILlP/Gxv36o
         sr5g==
X-Forwarded-Encrypted: i=1; AJvYcCVGM6y0SsabO04+yGweWEi0S43CUWaGKCxX3/15tkSLTxu5ItUSC7H6m6ayacjnYkZ9wVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JNuEXkcjG03Dxy2G4quwFlmeevwOLVVE3ufHief3LRGIkwNx
	tn22AGrbwZNUj4FC48ex7PGDrC4ApYTcdqiwd1M9TTV6BP5NxbmWcN4VPQ==
X-Google-Smtp-Source: AGHT+IF1NaH0nCAWsCKdh+YUlRAGpayspsVtwgc157T3iXHFvWg0AcUwuALP0HMMivsGqK1geuUoig==
X-Received: by 2002:a05:600c:5104:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-42cad746459mr72090865e9.8.1725957733794;
        Tue, 10 Sep 2024 01:42:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8b7fcsm104051415e9.47.2024.09.10.01.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 01:42:13 -0700 (PDT)
Message-ID: <490bd831-836a-4d7e-9695-8cb50c83317d@gmail.com>
Date: Tue, 10 Sep 2024 09:42:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Re*: What's cooking draft as of 2024-09-06 late night
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>, git@vger.kernel.org,
 Derrick Stolee <stolee@gmail.com>
References: <xmqq7cboyq9s.fsf@gitster.g>
 <899eb2c2-bb18-4666-98d8-9255dedfac53@gmail.com>
 <xmqq8qw3xvob.fsf_-_@gitster.g>
 <CAG=Um+0X3Umt-2TQ-BGeefqdGxfVoy2Ug0tGKLycrX=_pj=oJw@mail.gmail.com>
 <125aab1b-d017-45c1-b93c-ee43fef9bd71@gmail.com> <xmqqseu8u8m0.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqseu8u8m0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/09/2024 16:53, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> The only place `skipFetchAll` is currently documented is in this large
>>> master list of configs that are easy to miss —
>>> https://git-scm.com/docs/git-config.
>>
>> We could perhaps expand the documentation of `git fetch --all` to
>> mention skipFetchAll
> 
> Like this (interdiff at the end)?

That looks good to me

Best Wishes

Phillip

> --- >8 ---
> Subject: [PATCH v2] doc: remote.*.skip{DefaultUpdate,FetchAll} stops prefetch
> 
> Back when 7cc91a2f (Add the configuration option skipFetchAll,
> 2009-11-09) added for the sole purpose of adding skipFetchAll as a
> synonym to skipDefaultUpdate, there was no explanation about the
> reason why it was needed., but these two configuration variables
> mean exactly the same thing.
> 
> Also, when we taught the "prefetch" task to "git maintenance" later,
> we did make it pay attention to the setting, but we forgot to
> document it.
> 
> Document these variables as synonyms that collectively implements
> the last-one-wins semantics, and also clarify that the prefetch task
> is also controlled by this variable.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   Documentation/config/remote.txt   | 13 +++++++------
>   Documentation/fetch-options.txt   |  5 +++--
>   Documentation/git-maintenance.txt |  3 +++
>   3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
> index 8efc53e836..36e771556c 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -42,14 +42,15 @@ remote.<name>.mirror::
>   	as if the `--mirror` option was given on the command line.
>   
>   remote.<name>.skipDefaultUpdate::
> -	If true, this remote will be skipped by default when updating
> -	using linkgit:git-fetch[1] or the `update` subcommand of
> -	linkgit:git-remote[1].
> +	A deprecated synonym to `remote.<name>.skipFetchAll` (if
> +	both are set in the configuration files with different
> +	values, the value of the last occurrence will be used).
>   
>   remote.<name>.skipFetchAll::
> -	If true, this remote will be skipped by default when updating
> -	using linkgit:git-fetch[1] or the `update` subcommand of
> -	linkgit:git-remote[1].
> +	If true, this remote will be skipped when updating
> +	using linkgit:git-fetch[1], the `update` subcommand of
> +	linkgit:git-remote[1], and ignored by the prefetch task
> +	of `git maitenance`.
>   
>   remote.<name>.receivepack::
>   	The default program to execute on the remote side when pushing.  See
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index e22b217fba..80838fe37e 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -1,6 +1,7 @@
>   --[no-]all::
> -	Fetch all remotes. This overrides the configuration variable
> -	`fetch.all`.
> +	Fetch all remotes, except for the ones that has the
> +	`remote.<name>.skipFetchAll` configuration variable set.
> +	This overrides the configuration variable fetch.all`.
>   
>   -a::
>   --append::
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 51d0f7e94b..9d96819133 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -107,6 +107,9 @@ with the prefetch task, the objects necessary to complete a later real fetch
>   would already be obtained, making the real fetch faster.  In the ideal case,
>   it will just become an update to a bunch of remote-tracking branches without
>   any object transfer.
> ++
> +The `remote.<name>.skipFetchAll` configuration can be used to
> +exclude a particular remote from getting prefetched.
>   
>   gc::
>   	Clean up unnecessary files and optimize the local repository. "GC"
> 
> Interdiff:
>    diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
>    index e22b217fba..80838fe37e 100644
>    --- a/Documentation/fetch-options.txt
>    +++ b/Documentation/fetch-options.txt
>    @@ -1,6 +1,7 @@
>     --[no-]all::
>    -	Fetch all remotes. This overrides the configuration variable
>    -	`fetch.all`.
>    +	Fetch all remotes, except for the ones that has the
>    +	`remote.<name>.skipFetchAll` configuration variable set.
>    +	This overrides the configuration variable fetch.all`.
>     
>     -a::
>     --append::
