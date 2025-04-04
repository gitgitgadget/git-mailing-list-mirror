Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21621101EE
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768799; cv=none; b=qKJM/gqxQgJrBlMwr9Crn3RKOfu+oG89POCX5nBhQbDj0VhrKN2yl2qbnfgsXfKehmdNqEJQGpLS40qBxBEXMD81v4Kkx6GVd2pfXS8s4vyRxJW7G82NMGlvrX/8kQ47Oh+3ldNO9PF1QjOMk0qW335EBDyHNuxFuXFbYvCOqCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768799; c=relaxed/simple;
	bh=OY2sXczeyJ1fyiyuftTvelIy2NbMJ8pvrHT1TogOVUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L31c1vPtnJiBeMRtxNRRubui4ZlIo93ofewkPJK0I5ItpCusj/fSleV+qBmF1FFQSQO2H09F75oaTqYAIjdyq0fr27rVY/D1Rw3K8eHXFd8yYZuA//4Vc5smm/qHAYeCAENPr33DZxWG25TATjZxbYt3sUkHgQgnxs5sQ39LMuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP58KAgr; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP58KAgr"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f666c94285so22486037b3.3
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743768797; x=1744373597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phwODaD42zUWK7zq79RHJvRd6Agf9w7y2z00MGr8oTY=;
        b=hP58KAgrPZynxTfyO/WVz/XwMuPos1l/Jc/p8iWsMXMx21Qc7AisndXlwixJEkc29Y
         UfLtnMaJucd4TuFzVkwtUNm20xoUQY6G/37rYjW7kMbmkKwK4oCi6Wo6+iD13KV32p3z
         agqrmjDnN30KlAVZxS4N3aVDX778mOf0GQ9WvSINErKM3P7bs4+ztAjBTMHGTzND8/Th
         f1lmhrXsWzNpQAfCq75LliPYhtAVVWBuXjE/SQL+GPZxyfu12dnkStp6Mzev20BWhceQ
         MgUgOApfDJ0HcRXQeNsSChMPzpGC/4nfnRmI09n2pEq2co08I2YjhzG/woJSBdpIB8xa
         nbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743768797; x=1744373597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phwODaD42zUWK7zq79RHJvRd6Agf9w7y2z00MGr8oTY=;
        b=CwFFPPzD9i6a/jnxs27fxlL1k0rHkt7aasE8n8tBE5Y/IPUIMB+djjCW9fdLESh7QX
         Q5KkVKe3td2pwBofmUtt8tacQGIkOmiu4BJxzV9nqJIQ7D9yojUKxFtU3qaafW0RydD8
         RzKi49rQQE/l/TXOeICdfsn6R9sd8OteW/8pARJKZX7xWb4LX8jc443zYOiF9twYnQ4Q
         PntN8W0b1x98Ak83KN7gza834KjiGHamXZIGqcqLQC7m8mOdl+86hXxWA30YwmsV3ZbP
         W0IB7iNgJJ0WRLLLsl2HOmSkR9JQgtxRfGZPpetIB0qwsLW8znCCEWbNGXgIeUpDBiTV
         lQNA==
X-Forwarded-Encrypted: i=1; AJvYcCVvLHmXft1JXhvMJZNn5cNtNQV6djo93HbWgPsqeA1E+AwWxyM4ovVOa3Ttx3sxvt45FD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJnNvDxwC4NzjpESRJFOH1JzsnAEZ+gjfIsRIsqFWBcgN4lVS
	np9tlrZLHFt06M23i2xymHZ34v2wpiMJjrBsMVoeluJzxGOhbL7p
X-Gm-Gg: ASbGncuDoelUuCQOQDhPT8hERfnJ0CCVt2R8OnewkK9DL3gllk8e5JqYs7iTD7g/E6g
	zHkOk+f6mGUcDEtMyK9aOBeNFsIsadDVRMl7mIwnyy/XlfclmKpCqbmyViRyFUenb4JA6CmPkaW
	/nNgi+w8TyIhbSCivflDUjvJvqk767d8Nxxe1/3j3zMN/TLK8Q6GdOt2NZzQciXhTid0AjYS9cG
	d4hH/8b4uDTAl9Y4t42M8x3gl5/eQ7thEBVjYiop0o344rloN5Qec4wKLa/EeMAYRtxTKli9WRG
	NW/T93MiWvjX/EjrTJRSurXGgEM9in22aaSMIy3E/R03Um521XhKnYn6YPE4LSEv5IOGoF4lsLg
	AMkKerfamL+jiGMao5ZJn
X-Google-Smtp-Source: AGHT+IGaeMUII/nyL+WtjfeuO6SR4n0g/IK/GigQzDDgzoimBrerKnTWRI7XU/Rl/kEzd7ICJbH6XA==
X-Received: by 2002:a05:690c:4443:b0:6fd:42ed:c90 with SMTP id 00721157ae682-703e15463b2mr52700107b3.16.1743768796922;
        Fri, 04 Apr 2025 05:13:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:4897:35e1:a617:6e11? ([2600:1700:60ba:9810:4897:35e1:a617:6e11])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e59623sm8505867b3.40.2025.04.04.05.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 05:13:16 -0700 (PDT)
Message-ID: <3bc8a906-ead6-4cce-9658-d45feb76cebf@gmail.com>
Date: Fri, 4 Apr 2025 08:13:15 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: do allow `GIT_PERF_*` to be overridden again
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1900.git.1743764167548.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1900.git.1743764167548.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/2025 6:56 AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> A common way to run Git's performance benchmarks on repositories other
> than Git's own repository (which is not exactly large when compared to
> actually large repositories) is to run them like this:
> 
> 	GIT_PERF_LARGE_REPO=/path/to/my/large/repo \
> 	./p1234-*.sh -ivx
> 

This issue also extends to other necessary variables such as
GIT_PERF_REPEAT_COUNT.  
> +# GIT-BUILD-OPTIONS, sourced by test-lib.sh, overwrites the `GIT_PERF_*`
> +# values that are set by the user (if any). Let's stash them away as
> +# `eval`-able assignments.
> +git_perf_settings="$(env |
> +	sed -n "/^GIT_PERF_/{
> +		# escape all single-quotes in the value
> +		s/'/'\\\\''/g
> +		# turn this into an eval-able assignment
> +		s/^\\([^=]*=\\)\\(.*\\)/\\1'\\2'/p
> +	}")"
> +
>  . ../test-lib.sh
> +eval "$git_perf_settings"
I verified this fix in my local environment. Thanks so much for digging
in and finding the solution here!

-Stolee

