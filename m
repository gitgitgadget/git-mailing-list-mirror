Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051B825D550
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628379; cv=none; b=YFe4cPvQOAZjg6E9C0Fb2Gas70wFrt0k1mQetD9mi9e2raF6RbHtcqpbEwwFOGgZ44C0J/EBuxPaBM81QKE0ElIKYc6wqUSrouswYSqMSP28nEW73x+qGZAY86bYHTjouW/HkjmbChyZ2ObIV7nAjqbZNcPHO0yFTOBoro5T1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628379; c=relaxed/simple;
	bh=/lZgxpjRYd19iFCqDaYDdvJeGe4X0Jhc7aPVLf/L8uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYZ5/rXgggxaCtXvNv5Slw/g2JRfjdPfMGFAS01WOadFSuSpelsQn0plh3cLRLKJEVMvp447ljIeu7qEAfZtm2X7LKgvQBGf1t4NNzs2vHbsIdRwyVvHyo5EWZv5nJvb86Jvdgldp+tWtZ7UqgIwTPgSeJeAfXbo08TIwgSRnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAyBgRLM; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAyBgRLM"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso4632081276.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744628377; x=1745233177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wU1fyx0/OK3YUj/caqOUcQ6oW2rBybsaz4HTrrzzFOc=;
        b=PAyBgRLMsd6e2b3IijcvJKxsay6bzynCZBnQ7xuhxd3RlqvMsb2zHns4glssTJCA4V
         hU0aCOxyEJ9SSbNn6bYq8nM4kBB4FH8C7BW69uLOZyyQoPHNQ70vEYMIRcyparTIfPf6
         LzT7JgzGhidbzCYc4SNY9e3KGaZ4Zbo05eVnR3rR6TSbsSwxyaS9QXgorEGt3GE0EOIP
         j8q7EqWrQ4itf3kAG6IJR9Dpi0U3PRehp6CUHqCGpPB5sgYfpgBs7f+f+5T47Cz8lm+V
         e/Q14y2Ku5X6zEi4Fh8sxJPovQWoYF96dbQC546a8oIK4djSNL6MwU/ceJ+VAkxl3WnJ
         lhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744628377; x=1745233177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wU1fyx0/OK3YUj/caqOUcQ6oW2rBybsaz4HTrrzzFOc=;
        b=E8c96EID84BaOviHI4ILcG3FqpT4NsWwd6OVW41U3L3SViXtmodOB6vYl04wNCqqwm
         xNBNJXKhbCSLLMj0Cv+W5NNXFjvdj2zAaJDplPTU4wwO/zeJW/VHjDr9FOcmvhiH1CaH
         8QQK+Z5KNefzxgc9pAVx4NR0kwrC7B+tzuJRyAs1dexBEIu4x3QrehgHftEmL74z+0Mj
         iR4VJP90qvv4lXf0/hUI23n02AnfbFBHYr0c/7NqAEJAGEAL8wUx1kEoLUFYRjF78/Zb
         rdio5kP5k29paUNbbyPuxw1sXp0ZHEi4aPt8x1LihqbdhkgsrwWsN6w0jyJsYEmmLsb0
         iYVg==
X-Forwarded-Encrypted: i=1; AJvYcCUwK+HBS6vZQ5a1NAbBmSoOE8YpW+pNu5DVFB/mrS2PAVwWnBxS67Eqt/K8DtMrBgKyZmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9WdA0bKFmOo7QIGIGHTKXHfwUHfat3PL4B/oFGGg0RNeglpih
	/69FprB7EC+pCHEzaOwItWdZSI5uUEa6RFi9y7puvlAjhmBVvZDG
X-Gm-Gg: ASbGnctixdY8OrEdbOMpHv0Q/PU902v4oldHaqq/m7v+X7NprgaGiP4XHuWjO4M3D8S
	T7fDQouOv/2Gvr/QDgKYRSIh2f6UtGi1VVBdseqNJ2yuq3jCC9p5yp0lkFDpTC4IlNbwGdd7ZpA
	b7yIJnxe5qtPuoXdAgF/+MCJmtKNCuzQlSPnOxSy4x3+gU9jdkUVSPwOzxgTm+HdXQ/Q3RwkmJS
	2eAdXHGE0BT2AAvX/2aoRm4gNqBmccNleZqJfwCR8/a9r6TWYxXfEzKDRn8aZ5yW429NnzJxiT7
	d3IfifKdIXxZiiTgoHImOdT/iBbYyDIjQ530LQ9BmEZuChwtpgY7pw8FjbewsZznkxE8fv3zejj
	xGPyoG2vp
X-Google-Smtp-Source: AGHT+IESwPOOT8QQonl+2+ISookyb7JxCdXiED9SsHtCzpFg/9iveZW4b8aabjI20QYHxp3VJgIsYg==
X-Received: by 2002:a05:6902:4889:b0:e6d:d7d8:7fcf with SMTP id 3f1490d57ef6-e704dffc269mr20171129276.24.1744628376637;
        Mon, 14 Apr 2025 03:59:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:7c:2672:658:1757? ([2600:1700:60ba:9810:7c:2672:658:1757])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e70324051b2sm2797031276.4.2025.04.14.03.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 03:59:35 -0700 (PDT)
Message-ID: <cb3d080b-51a3-4096-9650-34ec4ed68f1d@gmail.com>
Date: Mon, 14 Apr 2025 06:59:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git: add --no-hooks global option
To: phillip.wood@dunelm.org.uk,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, james@jamesliu.io,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
 <2c7994bc-2be0-43a5-9627-0d530746b3ab@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <2c7994bc-2be0-43a5-9627-0d530746b3ab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/2025 10:15 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 03/04/2025 23:38, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> In some situations, these hooks have poor performance and expert users
>> may want to skip the hooks as they don't seem to affect the current
>> situation. One example is a pre-commit hook that checks for certain
>> structures in the local changes, but expert users are likely to have
>> done the right thing in advance.
> 
> Next they'll be saying that they never make a mistake when writing a
> one line patch! More seriously I agree there are times when one may
> want to bypass the pre-commit hook but we already have "git commit
> --no-verify" to do that. In general hooks that are so slow that the
> user wants to bypass them are self-defeating and I'd argue that the
> solution is to fix the performance of the hook rather than make it
> easier to skip it.

Both can also be an option.

> One solution for speeding up pre-commit hooks is
> to process files in parallel. Unfortunately git does not provide
> support for that but there are hook frameworks that do.

>> I have come across users who have disabled hooks themselves either by
>> deleting hooks (supported, safe) or setting 'core.hooksPath' to some
>> bogus path (seems unsafe).
> 
> I thought "git -c core.hooksPath=/dev/null" was a fairly standard
> way of disabling hooks on a one-off basis - what makes it unsafe?

You're right. I was thinking about setting it to a "directory that
doesn't exist" (but actually could be a path that exists accidentally
like "/bogus") but I forgot that we could use /dev/null.

I'll remove this "(seems unsafe)" wording. 
>> The supported process is painful to swap
>> between the hook-enabled scenario and the hook-disabled scenario.
>>
>> To that end, add a new --no-hooks global option to allow users to
>> disable hooks quickly. This option is modeled similarly to the
>> --no-advice option in b79deeb554 (advice: add --no-advice global option,
>> 2024-05-03). This uses a GIT_HOOKS environment variable to communicate
>> to subprocesses as well as making this a backwards-compatible way for
>> tools to signal that they want to disable hooks.
>>
>> The critical piece is that all hooks pass through run_hooks_opt() where
>> a static int will evaluate the environment variable and store that the
>> variable is initialized for faster repeated runs.
> 
> That certainly makes the implementation much more viable. However I'm
> not really convinced this is a good idea.

I don't read a strong reason in your message that this is a _bad_
idea either. As in, there's nothing that hints that this will cause
significant harm to users other than providing a new footgun (and we
have plenty of those for folks willing to look, including the
_existence_ of hooks).

Thanks,
-Stolee


