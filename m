Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8D15252C
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567330; cv=none; b=I8YTluc4fjBxaKyHzcemYYX4J0PrgOTuqlhDsiEE3G5P6JjJm1IyQQLhvi5BKABRnaiVoI79Lkr0H7zBeJnSGwLZEGUs/iqo0DcyyBOS0a/L5TGx5/Tz3K+UVT/Vdgh9Zb8egHOfELCte3qfjxlUERufv9Ans/8aLdzJI+cqc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567330; c=relaxed/simple;
	bh=4TxRUtrSDY3qZcZV8/L1fzqJjhZFDKQk9NXoPVm0H1s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GbeJ2lfIrXU7troiJxedbXkIu0rQz0iMUySKziXRxNEcgR6azYixmErGlB85VUklt6BHApZDghTSUEJGcjFXLwn6d9w6yq2BN6GZ+grutMy6ezglfktWtkvN0/xf2rGU2nrV8q7afkDHHBtZJpcjA7O/dTZdLh0lp+lb7Fx3sf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EY5DyBUu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY5DyBUu"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36733f09305so222741f8f.3
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 02:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719567326; x=1720172126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIt4eIKKooJWIQKgWwp4yiZXg+WCve8Qd5Lmqvg4onU=;
        b=EY5DyBUuZMstohm5AlczOXP2Qp+s8MgOWSJYbsr31w7AHZe7Dw5CLRNN1tDE0CTJEM
         Ua5KhU3fsHsp1dzSbguBF6IG7QHyM4t9fmg7f2jBoVzGDxJITu/nj0Rk1+3ygC/yJ0Zh
         7JR5CiBizhX9ICTibEgP4wn9UtXQVHtUF75caqclIAMjs67C7tIgDnpW4CuzJmpgaR7G
         PItv8fwUxmcWpdF8j6jw3JOdQZjiSqomy2xjtbeGGjmrRnPhuA4OwNscOwIjtg5TWIes
         vdh5npkJvreMZDfTla/4OtSe9wR6J8x1STpz9d6Ui3pFsyd+5udMtKCHM+bcQKZwmFaS
         h+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567326; x=1720172126;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIt4eIKKooJWIQKgWwp4yiZXg+WCve8Qd5Lmqvg4onU=;
        b=sT6j2pNm3O/wY5mbDZqhHq1F+RP2gcuBeDiz2sz8BQWh8TRNZUgdU/fCbdLzER+FS1
         V9/8DZ8xW7xpPXw7zgFrN2AsmugbKN0sUyAVIkwwXvXq+SPQTTyIMAKqzWewxsRmD4x0
         O1aglYbUTlbu5EeLvq/jLAxlzA+7tKxdHItMGnpUY63WmD0UBBA8qWUBkWcc1VoXV21Z
         ZgW+GOSNkwqtYD6tk4eRsx1wbwkEcW4T4C4GvviMcIuDqJcA8lQLpNYSOXYFoBDqvxxn
         OMxxfwumi5nVmLqRxItOf+hpoJLo5sTMNSY5bgxdqDS7QSS8EQuRNjno5jfR0uIw/0QM
         xdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG/Jx6pjUsZElWNwnnSjeXUAyNmtLOoEfsfNzg3HgsIVqiYt7nWagQV5qmNT6vy7d0117RgbeL0Eow5dwMsFSlLvOA
X-Gm-Message-State: AOJu0YyUGxjLWunNdjF/IlAiUrqzEssHeJiyms81ttcSOjf35nuQCLzt
	G+30SJpobbLbaFc351TZ9bLGNhBNBhAOtSWhDPS1uxaHUP5mqOim9hlZ9g==
X-Google-Smtp-Source: AGHT+IEK9b+Yfr01DckULyuiZvGWS93PPQwlaQPBxTGbIBSbS+/y76Ld1XUsCFZuQxT9a6HNy+3RqA==
X-Received: by 2002:a05:6000:4021:b0:366:e8ac:50b2 with SMTP id ffacd0b85a97d-366e8ac51a9mr14562871f8f.7.1719567326396;
        Fri, 28 Jun 2024 02:35:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8e97sm1694109f8f.33.2024.06.28.02.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:35:26 -0700 (PDT)
Message-ID: <27cadffb-ca3f-487d-86b7-3508c45c446d@gmail.com>
Date: Fri, 28 Jun 2024 10:35:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
To: Junio C Hamano <gitster@pobox.com>
Cc: Florian Schmaus <flo@geekplace.eu>, git@vger.kernel.org,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
 <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
 <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com> <xmqqa5j71snb.fsf@gitster.g>
 <5742e728-a012-4960-a32d-bf3b65c3a2e3@gmail.com> <xmqqpls2v1zx.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpls2v1zx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2024 16:28, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 26/06/2024 19:11, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>>> To expand an this a little - a couple of times I've wanted to checkout
>>>> a bare repository that is owned by a different user. It is a pain to
>>>> have to add a new config setting just for a one-off checkout. Being
>>>> able to adjust the config on the command line would be very useful in
>>>> that case.
>>> True.  As long as it is deemed safe to honor the one-off "git -c
>>> safe.directory=..." from the command line, for the purpose of this
>>> "I who am running this 'git' process hereby declare that I trust
>>> this and that repository", I think it would be the best solution
>>> for the "git daemon" use case.
>>
>> This actually works already, the behavior was changed in 6061601d9f
>> (safe.directory: use git_protected_config(), 2022-07-14). The reason I
>> thought it didn't work was that I remember it failing on Debian
>> bullseye a few months ago but that used an older version of git. There
>> is some more rationale for the change in 779ea9303a7 (Documentation:
>> define protected configuration, 2022-07-14)
> 
> Thanks.
> 
> So, does this more or less conclude the episode about how best to
> deal with the 2.45.1 regression that Florian's patch in this thread
> started? 

I think so yes

> It seems that we already have enough mechanisms to help
> users tweak their existing set-up, so we may not need code changes,
> but I am wondering if we want to add a bit of documentation around
> safe.directory to tell them when it makes sense to set it, what
> value(s) they would want to set it to, etc.
> 
>   * For "git daemon" invocations, because we know the command is run
>     after chdir to a directory with '.' specified as the repository,
>     we recommend to have safe.directory=., either on the command line
>     with "-c var=val" or in daemon user's ~/.gitconfig, in the
>     "git-daemon" help page?  We could recommend safe.directory=*, but
>     they would mean the same thing in the context of running "git
>     daemon".

I think we'd be better to fix the safe.directory check as you suggest 
below if we can but failing that updating the documentation would 
certainly help.

>     We may want to discuss who protects from whom with the
>     safe.directory mechanism and git-daemon-export-ok mechanism.  The
>     former is "the daemon trusts that repositories won't harm the
>     daemon user", while the latter is "the repository owner is OK for
>     it to be published".

Yes that would be helpful

>     Also optionally, we may update the code to take the absolute path
>     of the repository before passing it to the safe.directory check.

I think doing this would be more helpful than updating the documentation 
to recommend adding "safe.directory=.". If we do this we would also want 
to convert "//" -> "/" in the config keys as we've been forcing users to 
add paths like "/srv/git//my-repo" if the --base-path argument to 
git-daemon ended with a "/"

>   * For "http-backend" invocations, we should think about potential
>     additions that would help users, similar to what I listed above
>     for "git daemon".

That sounds sensible.

> Having said all that, I do not think I mind GIT_SAFE_DIRECTORIES
> that is a ":" separated list of paths that is honored just like the
> multi-valued configuration variable safe.directory.  Once an
> attacker can influence your environment variables, it already is
> game over, so trusting it does not make the attack surface any
> worse.

Indeed in that case the attacker can influence the path that we read the 
protected config from by setting $HOME (and do far worse by setting $PATH)

> As Peff explained, we can trigger the more general "git -c
> var=val" mechanism by exporting a set of environment variables, so
> such a specialized environment variable is not strictly needed, but
> it would make writing the "SetEnv" directive in apache configuration
> (and similar ones for other HTTP server implementations) slighly
> simpler and a lot more straight-forward.

Yes having to set all the GIT_CONFIG_* variables can be rather confusing

Best Wishes

Phillip
