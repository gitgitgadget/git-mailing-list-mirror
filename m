Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C6130AED
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225435; cv=none; b=Wolea1TOYtjnICY+89S/h8msr/S0363/aebzAhXe/uYn84sNGcFN218cU+HiQw3BXZtHOk0389Lolc8ARZS1dbI7Prd7dtNH1kKMjUcRKF2PVY59qUdZFTlIjMl4iP520gnIsc+z+k94o6aGtq6gCZCVrLTRb3bRbAYZk+7Vh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225435; c=relaxed/simple;
	bh=EsYEbp9ixAPl0p80wK6ZQH0IQqvX6U+Le1na1u7eCEA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c32ipz67+iQp/g6oTIsByNF5DG1Khwy0A3hJuffvVSYV6641ms3qzNUjI3XVT7Efzz67AcloRNj4ovDpha9+o9gHXgLRnPJMrvkMGo2/A6G4Mq5aJNCMJNoClEprVs68NcdyPSiHVsyHZXYivDfBagorjvrkv8wXuyDmUjTySck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHQWEiGo; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHQWEiGo"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e2b46800b2so89364a34.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 05:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707225432; x=1707830232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFJ+eTV9x+3gj0bCC0BpEjYC+Xmqrt5RhWKrC0v5F5Y=;
        b=lHQWEiGoQVCOwegTY44LToSFc0hAAAJJ41i4LUPmJYMAktGLM3ji5jIQl9JLcgrEUe
         a9ipeEXxVH1Kd2OtAVOX1j0kLlRDTlmRkbigtFqhz2NmK+6inLDyD/LeaznDjSOzAQ7P
         FQ61sMEjDqybDCe+uZNW2qjGJ28bUSci83qvTENH9+F87vq7Pi9l3DTS2vjCTbF8yUUE
         p9AhNHoYrbP5QGuNQV90edB1F3pyNWYBdQ9KK2qM7TlmkjzwAxINpxAOKapZC79kGReN
         oHDLa9AHzJ6cQMDLYaBmPOanII/3cfMIj8m1WmGivJr8frpofQ+/yPfHmmLkq15+6yoW
         hJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707225432; x=1707830232;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFJ+eTV9x+3gj0bCC0BpEjYC+Xmqrt5RhWKrC0v5F5Y=;
        b=v2hLMRs4rwOkAGXyojkwJiTk0m5/mV8CTeqvEbfwMNhHZPdneR4gsuMRNBWvN8NLf5
         x3tS/cpSTnVPeyX/nUbnlNsQs7iCLaGnP3jTsNxymZo2ZM5+MK5Na8vYqvy8Gfr9zUqF
         EukUEDXs4OxtFchbdTNbCzG6c1+9fT0leUN6a9MSkPy03lim1iBbm8qffW8oe4faWz5S
         tp7aBJSmHGb/8r5uJmsIOoreskccOiLihIw65kdVVORTfZrTZAGIMrMr6pUZ7UIcVtBn
         gZcXl5C5inplpVXo5DkkphZq1jwHS/hXS3+skQ+nTAUudf/xFPxhPG9Rzh0jAgoqJzLV
         +1Bw==
X-Gm-Message-State: AOJu0YyyvP8+jK67DmTsIJeEwoc/6xmxsGkffuortKNqPRP/VamaYSg7
	q+/67zzecCSQyNz/nARoDrqmpK0uuoINAJYblpfSH+K2DoXmczhH
X-Google-Smtp-Source: AGHT+IFotRWPLazPX5MBTXfCZ9HhQE9dx1pZLYL0ESoz0ehgwVWZ0KUiUzXDwU6l8/N2k4t3HqmUZA==
X-Received: by 2002:a05:6830:13c1:b0:6e2:9de1:456c with SMTP id e1-20020a05683013c100b006e29de1456cmr2893367otq.11.1707225432329;
        Tue, 06 Feb 2024 05:17:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX5P6Sh6+m+vO8hHCp2VNPG17oQDy2XPyr2IwJ+Me/W7yaqMRkYLlVlY7o76hPEF3rPLXU6CbXiPNuCoXenp+O0vcdc33fo3MwKgwuXHQ0/DU2eeX+BsNKY+LFeoVqXpZpgmg==
Received: from ?IPv6:2606:6d00:17:3855:50a0:1013:2324:cbfd? ([2606:6d00:17:3855:50a0:1013:2324:cbfd])
        by smtp.gmail.com with ESMTPSA id l15-20020ad4408f000000b0068c9cd2cf88sm988744qvp.60.2024.02.06.05.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 05:17:11 -0800 (PST)
Subject: Re: [PATCH] .github/PULL_REQUEST_TEMPLATE.md: add a note about
 single-commit PRs
To: Junio C Hamano <gitster@pobox.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1665.git.git.1707069808205.gitgitgadget@gmail.com>
 <xmqqsf28oufw.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <b7789242-5eee-3b1b-54e7-cafce96f2340@gmail.com>
Date: Tue, 6 Feb 2024 08:17:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqsf28oufw.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2024-02-04 à 15:17, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
>> index 952c7c3a2aa..65fa3a37173 100644
>> --- a/.github/PULL_REQUEST_TEMPLATE.md
>> +++ b/.github/PULL_REQUEST_TEMPLATE.md
>> @@ -4,4 +4,8 @@ a mailing list (git@vger.kernel.org) for code submissions, code reviews, and
>>  bug reports. Nevertheless, you can use GitGitGadget (https://gitgitgadget.github.io/)
>>  to conveniently send your Pull Requests commits to our mailing list.
>>  
>> +If you use Gitgitgadget for a single-commit pull request, please *leave the pull
>> +request description empty*: your commit message itself should describe your
>> +changes.
>> +
>>  Please read the "guidelines for contributing" linked above!
> 
> Making it easier for contributors to come up with the right output
> is greatly appreciated.  I think "If you use Gitgitgadget for" ->
> "For" is probably a good change, for two reasons (one, we do not
> take pull request except for GGG gateway in the first place, and
> two, PR messages being similar to cover letters, you do not want to
> have a detailed PR message that (a) takes extra time to write, (b)
> can duplicate what the you already have written, and (c) could
> contradict what the commit log message says.

Good idea, I'll tweak that in v2.


> I wonder if such a rule can be also enforced at the GGG side?  It
> apparently knows if it is dealing with a single-patch request or a
> multi-patch series (as the types of messages this documentation
> update tries to address are the only ones that get duplicates under
> the three-dash line), and I've seen GGG complain on the contents of
> the commit log message (e.g., "not signed off") so there is enough
> support to inspect things in a PR and add instruction to the PR
> discussion.  Unless the machinery GGG uses lack the ability to read
> the PR message (unlike the commit log messages that it can read
> apparently), it may be able to enforce that "for a single patch, PR
> message should be empty" rule before the /submit instruction.  It
> might make things even more helpful if it can notice the commit log
> message is similar enough or superset of PR message and refrain from
> inserting it after the three-dash line, but that might be asking too
> much ;-)

Yes, it probably is possible, and Dscho suggested the same in [1] and [2].
I'll maybe get a crack at it eventually, but I hope in the meantime this
simple addition to the PR template will help a bit.

Thanks,

Philippe.

[1] https://github.com/gitgitgadget/gitgitgadget/issues/340#issuecomment-717782054
[2] https://github.com/gitgitgadget/gitgitgadget.github.io/pull/8#issuecomment-1133758832
