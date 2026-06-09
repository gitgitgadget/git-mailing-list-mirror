Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF7419303
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009969; cv=none; b=Vxklan5I3vPrSHojm7dFSiZWHRGmtslYA4qMIhi6e0KSqmDXG0z4IOdNGAWF1sZ0Aq0WAtTL4NZhx0TEjODQVmYfVmWzV0D0YQKAxMe35N66Zj4WW23SAGBvG+9aWzD8AXTJGIVJrgC/d7NnnRdS76HdUW/SD2P5c2hYiX69A24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009969; c=relaxed/simple;
	bh=qfuNdjEZs4mswJxFDH1FcRCtj6d54A6MBzDLFckl0Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCoe6uj81mswJEOyzcPM74nStf1Eh8mWXBxYxUTjxGeO1VVwPfYeqTRiUewtOVpdWtLwIv7pm5P7kYt568oAK0FKFvORLTaRKc4nqzPBkcm8yKb7IcZStwGYyzI8MEfhKrKxMmMZR2yxlWrc+SVxer0FTRGs0nmuM9Ygg4F2/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMKzVxjf; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMKzVxjf"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa61503fdaso5643236e87.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781009966; x=1781614766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9Ax3d80IJtcOUGikZ66xp6r71HVJgR6qpH1n5j4Sh4=;
        b=lMKzVxjfviuLqDroZvZmBKJUzYH/LgXmBG+Js+2qXKYSj0tFVtZkV9gf7DxPRgrTHb
         CZyiKgRI25HIPGgX2fACK/ldC7AbSVzPfFFe+Xn8T6BTj/fo6QMmDathi2/718wCUQk7
         e1HZRqHNyWpcRTHgXdAMehRXWA6zal/L37TyfJeAFUaboeWh07m3mKGOEh5p5K+WXPgB
         vod/3PU01fNYIXYeoONV9qIDrYqptdS3eg6lKhddFmzgODFrikoL88wMn2gMmD5byHby
         SAWB887IZKIUHsXwSYB9lmxEQSH6gJB/Qn82OY8P7IlfZb/z02FH2sbUE9NGFrAfpDun
         e2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781009966; x=1781614766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9Ax3d80IJtcOUGikZ66xp6r71HVJgR6qpH1n5j4Sh4=;
        b=m0oHJzKzvL8phBIjuqQAm8UNOOtJQJqXI48RAoC80+QYe4LsH+vwJInzP/klHMzXiO
         x39KsihFLbk+c0E8uIbDoWBmotvoclF8yImAM0mQsCFkCWxwRVhGot6MDHErHzSGIUUq
         n9gNlPOCZIIkBE+w2n8W3d3QdGcbYUDDaRp827tTSS4GOD8S9nP2kV1t3isb5MQ99iPX
         cUDSyYHbYH8lVOde0CUg2LwSqqsD0/Ff7HEMpmNAMsv0o2fgtA5SAgyrz4cXvuXW/9Iq
         7ZN+KZzthQ+tzD8KJLabD4PeMyuFwMU1DjTEIK18Uri7bZ2CW4msyxjXlM5Dlq94/cYV
         Jv4A==
X-Gm-Message-State: AOJu0Yxhkpt2P+dudBcilINMbf3K6QnJp4bxD0kUFQGvAIsB3jQiMggi
	kF3rtBuQzKfMQ8Lz1MZXcUKA+qITxkKyzP5lHaFetnH3nQLUkESyVlfEJv3RBQ==
X-Gm-Gg: Acq92OHAJHYgwJ1I/Yb9rVWFaQdRt5V+bdyAYYVvZmIT/DoaiwhUd+59ZgBqxapzwTg
	Th4QJDCPHduqAWg9HgQFidfcAtr0kkbx+RUxKhN9zOo6PaCioIyP0XVA8kb66aQfsyRISf7NeOY
	y8Pnydte1dgC3y2wHylBWC8MtnEJdYr5pqdySKUTIz7suGBeQSyDW6qo5YhvJ+1e7s0TdhNyYX0
	9g3QcvjJQR6aaPSufOHrEyVTv4DF5+96LfeCbiXslQ1V5AII9ihUFLDRkn62C9rvLys2+3ZpsVk
	SwS26zux78JM+2Lu2pxo4oBVQIxF++gXfgm5m4x8gqkJrFy7pFXlXLbwacQL2XYamD0XuDiRg6K
	kksZZjSPjdnv0UDnKke46zQQYBXP+sAirh4GWwfB6Sh0hI8lYrCuan66JP9MquRMB+JukSF92jm
	j71orln7A2ikA030INva+5HIaQVHjQznvMFPj1FEJ8d7m7vNtjJMB/RDP0fWMmN5f/uyVK/r1Ea
	yl7BQ4=
X-Received: by 2002:ac2:568d:0:b0:5aa:71e1:edab with SMTP id 2adb3069b0e04-5aa886fee66mr4744968e87.23.1781009965699;
        Tue, 09 Jun 2026 05:59:25 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97ac3fsm4589186e87.42.2026.06.09.05.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 05:59:24 -0700 (PDT)
Message-ID: <4d7834c0-d8ab-4dcd-8a7f-ed62c30cbe43@gmail.com>
Date: Tue, 9 Jun 2026 08:59:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] config: allow disabling config includes
To: Jeff King <peff@peff.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
 <20260608225149.GB340696@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260608225149.GB340696@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/2026 6:51 PM, Jeff King wrote:
> On Mon, Jun 08, 2026 at 01:57:03PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> This series introduces a new way to ignore config include directives via two
>> mechanisms:
>>
>>  * GIT_CONFIG_INCLUDES=0 in the environment.
>>  * git --no-includes ... in the command line.
>>
>> My motivation is from a tricky situation where users want to do the risky
>> thing and include a repo-tracked file for sharing aliases and other
>> recommended config. They are then struggling in a later build step that is
>> running Git commands (under a tool we don't control and can't change) that
>> then cause filesystem accesses outside of the build system's sandbox.
> 
> I'm not opposed to global control of includes, but this is just one way
> in which config can escape the sandbox. They can always point to files
> (e.g., core.attributesFile) or even commands that totally leave the
> sandbox (e.g., ext diff or textconv commands). Fundamentally git config
> is equivalent to arbitrary code execution, so pointing an include at a
> repo-tracked file carries the risk of confusion both malicious and
> accidental.
> 
> So I dunno. From the described motivation, this feels like a band-aid
> that fixes only one narrow instance of a greater problem.
> 
> The notion of enabling/disabling includes per-command is itself a
> flexible building block. So it's possible that it has other uses in
> general. But it's also a fairly broad hammer that covers more than your
> use case. If you're planning to use "git --no-includes" in some script,
> then it breaks the config of anybody who uses includes in their
> user-level ~/.gitconfig file.
> 
> So you may need some more directed limiting.

Are you suggesting some kind of internal sandbox to limit Git from
accessing repository paths from config includes and other config-set keys?
That would be a more complete solution, but I'm not sure how we could plug
all of those holes at once. I'll think on it, though.

>> One thing I do worry about is whether or not this would cause a significant
>> break in behavior, or if this is a relatively safe thing to allow.
> 
> Yeah. Consider something like:
> 
>   $ cat ~/.gitconfig
>   [user]
>   name = My Name
>   email = me@personal.example.com
>   [includeIf "gitdir:/path/to/work/stuff"]
>   path = .gitconfig-work
> 
>   $ cat ~/.gitconfig-work
>   [user]
>   email = me@work.example.com
> 
> Using "git --no-include" will silently use the wrong user.email value.
> That's OK if the user is asking for it, but if you are planning to
> sprinkle "--no-include" inside scripts, that's likely to cause
> confusion.

This is exactly the kind of case I was worried about. This specific case
only impacts write operations, but some tools do those things. And this
email case is a common one that users do in their global config to isolate
personal and professional identities.

I'm trying to think if there's a place where we'd have some config that is
critical to the repo functioning not in its local config (like the repo
format version or extensions). Perhaps borrowing from your work/personal
example, a user could use a different credential helper for work than they
use for personal repositories.

Perhaps we need to be very careful to warn users of this option or
environment variable that behavior can change from typical use.

Or: are we venturing into territory where we don't even want to create a
new foot-gun? If there were another way to solve the situation that I'm
facing without these risks, then I'd be open to it. Any ideas?

Thanks,
-Stolee
