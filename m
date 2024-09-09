Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217961B2EFA
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873199; cv=none; b=jX/3bSzLhIQosvznNSA+4NsRp+N89Bapr2nO/jRKAjr8F2sm9HE0xj/aL/kXqg7SoDvusWe+14fvjgxCtxNQTgX6OhJdbZW+7Fp379B5qi+sUnFnYPzT1oijhySL+oUQS4rngmMQilj8cPnJBq1zdHAnzw/ZJR6Rvujth4kvWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873199; c=relaxed/simple;
	bh=9cErfx7Ymg/XRHVE4li60/q8XklC2hIgJLSW5OZKa8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4Ki1lWUxuyjQPSoKx16Kc18MDB+Y257hbWBmiWy7uQxXX1VZgOT3NVqaEV6BS7eCuX7gnEqLBD0nJYZ0YK0+j5t8pe+K7KO37nDjcxbXFckywL1w3H0CRqqc1XoAuBqdWX+1w4zs8a227iJ8lUycCL7eX7hgw56/zZdGA0bj4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFqbqXHd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFqbqXHd"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374b25263a3so2307833f8f.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725873196; x=1726477996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkQe2MBLls6oErqtd9/e0iGHnWNX9mtcSABqLqcYGbQ=;
        b=YFqbqXHdRaxdoAeoY6d3U7m/4rJsxax9J3cnz9y7lz0SzX1W0lgshUroWw+I6gi5EE
         3qjxSh2qqJAA+hz7JuiPxHl2uF2CYPPi2Zpbxy+izhhQA+IsxXVouCb0SIIsvYejvZj4
         OIZN4Oq00jKEg0noasVZxWyKGfp2QYFMfmlz3S3R1ZOmmIk80mhRkishXAHPe34WzRxD
         Nw4MA7q0zW9PmsHJMeXBBECOlmyaAqIxUMpW6wV0uB6wBVrXR9aZ8DRZM1qbVeDHTk+U
         iJwE+egdigEOn5xPTsUxk4tzwpUeIo4qjSRsuu4ggPkla96ayHSj7/N3sWtOqQJXdYpM
         N6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873196; x=1726477996;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkQe2MBLls6oErqtd9/e0iGHnWNX9mtcSABqLqcYGbQ=;
        b=VKAKwHeYU2EtKzrr/uaciYdUbLZ/l55yWbNlkW5Jn0hH30iZVjbX2+4+0rY3QkXpEJ
         4HLvK+uQtZKWit8JuRnpl3ZnXrlJDk1A0YOML0xdh8X8kp7d1BNhl8JJ27IHM8zuyjRo
         5Qm69/Q4xmarxJokbm6XrCWscjkLEi313IZMWjB1E54jM+36fHaKEPs9HHBa3z7KcDTz
         G6KM965uF0n4AQor2Ep37D759s7laSFCD1GM5exwWqSmBq4JvOgI2WFqKJsjoOIbPBbR
         0KjFxJ4gaMtmG0hIAVdJd/bux99IjzYPn9hBsX3RF3iy2rbBIlY6RexiAYPOIYPBVvx7
         P+bA==
X-Gm-Message-State: AOJu0Yy1ORMI66lklcphwJbQ8GmlGVXPZor8MXucq8Pwpbgex5aBdYwB
	8n7DV8xSYIAPRgglxnLrjtNdAoGUz1Cd8Y1e+GEraFi0TmHKTeQpHym9DA==
X-Google-Smtp-Source: AGHT+IERbMGsQPKcHF6xfXeclT6y5Cn0KtYH2hxQHTDJwuFxu+fEsSqnhfxi+u2O8IW63ELg73vrpA==
X-Received: by 2002:a5d:4cc3:0:b0:374:ca4f:bd70 with SMTP id ffacd0b85a97d-37894a6b20amr4058762f8f.53.1725873196214;
        Mon, 09 Sep 2024 02:13:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb1b172c7sm56777225e9.35.2024.09.09.02.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:13:15 -0700 (PDT)
Message-ID: <72635041-576e-42d5-9e12-13e9572b2cf7@gmail.com>
Date: Mon, 9 Sep 2024 10:13:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Re*: What's cooking draft as of 2024-09-06 late night
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Shubham Kanodia <shubham.kanodia10@gmail.com>,
 Derrick Stolee <stolee@gmail.com>
References: <xmqq7cboyq9s.fsf@gitster.g>
 <899eb2c2-bb18-4666-98d8-9255dedfac53@gmail.com>
 <xmqq8qw3xvob.fsf_-_@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq8qw3xvob.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 07/09/2024 17:42, Junio C Hamano wrote:
> --- >8 ---
> Subject: doc: remote.*.skip{DefaultUpdate,FetchAll} stops prefetch
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
>   * Note that "skipped by default" in the original has been rewritten
>     to "skipped" (unconditional), and this is deliberate.  When there
>     is no conditionality and the behaviour is the only available one,
>     it is *not* "by default".

This all sounds sensible, the patch looks good to me

Best Wishes

Phillip

>   Documentation/config/remote.txt   | 13 +++++++------
>   Documentation/git-maintenance.txt |  3 +++
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git c/Documentation/config/remote.txt w/Documentation/config/remote.txt
> index 8efc53e836..36e771556c 100644
> --- c/Documentation/config/remote.txt
> +++ w/Documentation/config/remote.txt
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
> diff --git c/Documentation/git-maintenance.txt w/Documentation/git-maintenance.txt
> index 51d0f7e94b..9d96819133 100644
> --- c/Documentation/git-maintenance.txt
> +++ w/Documentation/git-maintenance.txt
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
