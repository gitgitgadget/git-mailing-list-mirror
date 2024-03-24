Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F38175AD
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711292103; cv=none; b=bFKnUhAAMG9ukjV5xV60Q8HUg8HqfCyFFiun18Sq+cnutvHvzyqbtim4cZlJyF7MM7jIQl18junH+ZQxiTefFQzts12iFh7+OobBIK13Gx26340u47DnDTTm1Abq4NemPsgVZq0lx904hxRTdnX3UQ3iflNu+qLDu+CJhGEtA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711292103; c=relaxed/simple;
	bh=tmyW5nLf5AmPBlSpjMv0+YiccBWyCS0ZcE0M3zKefMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UE+5tTDOj7Lime7MlqEzDB5bSjGESW/PK7Gzz3Mg693w7YTdH/hLylxunUoj0MYEMGBM7Ioe2FFefq4AXgMxBpJLTglSihQzhsMHJfG11V3kDSmmXBT93r2zyzpwDsdkpTcT+qhzIVmcgs37ZebYO7vEY19JUG14xq3JNGISq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXlSIshJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXlSIshJ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ececeb19eso2246865f8f.3
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711292100; x=1711896900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RmUbbSL8Uf08vcie1hOMieLlMzGIiqdrEIp59W7sX7M=;
        b=TXlSIshJ4EfqbmK9MNNlVDfl6YtevCJ2LrSfUyBI8vfYCQfr52lDwuH+vuC+/SMirW
         l4tQYd0f1E3zD19TSfg9s3huhxNzgm9ZVrVV62wn5cEmC4liOePzHGxHK4AXBF7zudY3
         /WWSkGscasmtikSvPE83yQrJLPKNZc8yxZj3lYqXyWyaRjrcyhG9z/Dz7nkuLxJBRrPg
         /0hU+tQPJYkILKoFzaZMu0PUjCCWX1gPqv3rZXn/JniQh8tz9/Rh0/KKri/rM0RPiBwp
         NqtvmHj5bs5wlrD5fchMSuICHelqO7ukXBHZJ8J+0tVtR8TEkyOE4EJd6hk2ExWlTTsR
         35QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711292100; x=1711896900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmUbbSL8Uf08vcie1hOMieLlMzGIiqdrEIp59W7sX7M=;
        b=aW8uXP08Cal8P1UuaLmbO35kTapwW1sDhT0w8NEOSaBwzfK66oF6FWUqjTYTqGHG7a
         XBQl7JjubLtp9mqeEWfXkyi3OEEMALF/9HwWRxypZiEXQzBuCtHGiHlgm35WWDiXghcV
         zq3AhOy3hutBoNHt3YnyYCSAfi/dnyxxDa+kkoc7jY41yGfAHcvt7MKtakz1fduDMwG8
         TUgawIJZ/myzGXLBE/zD8LP05KZGhSdZv/ZZgKprHcgE/MdIW0r4sKJx6I4sktI/3iMA
         lDZNz3Q4xLbq+rRRyfGEP1PT2x8C1byjAWdCDWEdIaCX12KtRVu9qYP48KVNm+/ix4gn
         +vUw==
X-Forwarded-Encrypted: i=1; AJvYcCWEKZrVuzfiUY7jqFmkZZzX0FqsrwtFWl/MZF6VQqu3rF6mLO09IFCBbd9koeRJKw/622ds2a0uOjgGTkCcmYBesYU6
X-Gm-Message-State: AOJu0YxgyxIrPqARiGBLq5C/9beaP67fPS0UcyAc0fP6cU9wXqipv6Iz
	NQmJkQVkfQdCr2686HTIc9bjJkLYLYtAiD2droM/o3cOW78fvJHi
X-Google-Smtp-Source: AGHT+IGwUsz9ppoV8wSGrrVvItTR3wTPUUVIK+gLcNFpjTLkU9/ijfpm6il+M3WYhY13yZVpXCdtQA==
X-Received: by 2002:adf:f7c5:0:b0:33d:c6dd:b4b6 with SMTP id a5-20020adff7c5000000b0033dc6ddb4b6mr3236521wrq.0.1711292099967;
        Sun, 24 Mar 2024 07:54:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d5042000000b00341c162a6d4sm3863750wrt.107.2024.03.24.07.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 07:54:59 -0700 (PDT)
Message-ID: <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com>
Date: Sun, 24 Mar 2024 14:54:58 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/6] maintenance: use packaged systemd units
Content-Language: en-US
To: Max Gautier <mg@max.gautier.name>, git@vger.kernel.org
Cc: =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
 Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20240322221327.12204-1-mg@max.gautier.name>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240322221327.12204-1-mg@max.gautier.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Max

On 22/03/2024 22:11, Max Gautier wrote:
> * Distribute the systemd timers used by the `git maintenance start` with
>    the systemd scheduler as part of git, rather than writing them in
>    $XDG_CONFIG_HOME.
> 
> This allows users to override the units if they wish, and is more
> in-line with the usual practices of distribution for systemd units.

Thanks for suggesting this, I think this is a useful change, but the 
implementation could be improved.

> We also move away from using the random minute, and instead rely on
> systemd features to achieve the same goal (see patch 2). This allows us
> to go back to using unit templating for the timers. This is also a
> prerequisite to have static unit files.
> 
> Note that even if we really need more specific OnCalendar= settings for
> each timer, we should still do it that way, but instead distribute
> override alongside the template, for instance for weekly:
> 
> /usr/lib/systemd-user/git-maintenance@daily.timer.d/override.conf:
> [Timer]
> OnCalendar=<daily specific calendar spec>

We should definitely do that. Using systemd's random delay does not 
prevent the different maintenance jobs from running concurrently as one 
job may be started before a previous job has finished. It is important 
to only have one job running at a time because the first thing "git 
maintenance run" does is to try and acquire a lock file so if the hourly 
job is running when the daily jobs tries to start the daily job will not 
be run. As the daily job is a superset of the hourly job and the weekly 
job is a superset of the daily job so it does not make sense to run more 
than one job per hour.

> The cleanup code for the units written in $XDG_CONFIG_HOME is adapted,
> and takes care of not removing legitimate user overrides, by checking
> the file start.

This points to an alternate strategy for supporting user overrides - 
don't overwrite the unit files if the user has edited them. I think that 
there is still a benefit to moving to system wide unit files though as 
it means that if we improve the unit files in the future systemd will 
pick up these improvements automatically. That is an improvement over 
the status quo where the users' unit files are written once and never 
updated.

I think it would help to reorder the changes in this series as follows:

1 - simplify the invocation of "systemctl --user"
   This would be the current patch 3 without adding "--force" or
   moving "--now" combined with the relevant test changes from patch 6.
   This would make it clear that those changes are a simple clean up that
   is independent of the other changes made in this series.

2 - don't delete user edited unit files
   This would be based on the current patch 4 and would show that we can
   avoid deleting unit files that the user has edited without the other
   changes in this series. This change should have an associated test.

3 - start using systemd's random delay function
   This would be the current patch 1 without the template changes and the
   commit message should explain that it is in preparation for disturbing
   system-wide unit files.

4 - install system-wide systemd unit files
   This would be based on the current patch 2 with the addition of
   overrides to prevent more than one job running per hour. The unit
   files should be installed under $XDG_DATA_HOME when $(prefix) starts
   with $(HOME), not just when they are equal. The associated test
   changes from patch 6 should be moved here as well as the "--force"
   change from patch 3.

5 - documentation updates
   I'm on the fence about having these in a separate commit like the
   current patch 5 or updating the documentation when the code is
   changed.

Best Wishes

Phillip

> Testing:
> The simplest way to simulate having the units in /usr/lib is probably to
> copy them in /etc/systemd/user.
> 
> Changes since v1:
> - Reorganization of the commits and their messages to try to address
>    review comments
> - Dropped the DON'T APPLY PATCH, added a TODO to the cleanup code
>    instead
> - Updated the git-maintenance tests to work with the new logic.
> - Conditional installation of the units files
> - Fixing some style/consistency issues
> - template the systemd service file to use $(bindir)
> 
> Max Gautier (6):
>    maintenance: use systemd timers builtin randomization
>    maintenance: use packaged systemd units
>    maintenance: simplify systemctl calls
>    maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
>    maintenance: update systemd scheduler docs
>    maintenance: update tests for systemd scheduler
> 
>   Documentation/git-maintenance.txt        |  33 ++-
>   Makefile                                 |   5 +
>   builtin/gc.c                             | 298 ++++-------------------
>   config.mak.uname                         |  10 +
>   systemd/user/git-maintenance@.service.in |  17 ++
>   systemd/user/git-maintenance@.timer      |  12 +
>   t/t7900-maintenance.sh                   |  50 ++--
>   7 files changed, 126 insertions(+), 299 deletions(-)
>   create mode 100644 systemd/user/git-maintenance@.service.in
>   create mode 100644 systemd/user/git-maintenance@.timer
> 
> Range-diff against v1:
> 1:  ea54a6e50e < -:  ---------- maintenance: package systemd units
> 2:  b29dbb9fdd < -:  ---------- maintenance: use packaged systemd units
> 3:  47bd6712b8 < -:  ---------- maintenance: add fixed random delay to systemd timers
> -:  ---------- > 1:  42d88c7f81 maintenance: use systemd timers builtin randomization
> -:  ---------- > 2:  18d51b1dd1 maintenance: use packaged systemd units
> -:  ---------- > 3:  3aa7446e95 maintenance: simplify systemctl calls
> -:  ---------- > 4:  daff7b4d60 maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
> 4:  fac57db55e ! 5:  5f6a8e141f maintenance: update systemd scheduler docs
>      @@ Metadata
>        ## Commit message ##
>           maintenance: update systemd scheduler docs
>       
>      +    The `git maintenance` systemd scheduler no longer writes units in
>      +    $XDG_CONFIG_HOME.
>      +
>      +    Describe the new behavior.
>      +    Instead of explaining manual ways to modify the timer, suggest the
>      +    systemd standard tool: `systemctl edit`.
>      +
>           Signed-off-by: Max Gautier <mg@max.gautier.name>
>       
>        ## Documentation/git-maintenance.txt ##
> 5:  d888fbd0c3 < -:  ---------- DON'T APPLY YET: maintenance: remove cleanup code
> -:  ---------- > 6:  4d4bcd6233 maintenance: update tests for systemd scheduler
