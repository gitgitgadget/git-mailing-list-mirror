Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727553376
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030526; cv=none; b=ch2kPEN6lOz+8T2ilQckVySuTSoIFRgNFLiO0fNlRZ5hdY9fCOMzQ+SIKqSDywh9kEOU5EPR2SNy9bFF9CTXWMLBp+hZbJ84QRmoiZatIylDdXJlt30hOCTxaEFweDgSv9Fbzg2+FjG36MUlHr25WgspB37OQGbGE+ONbVKgQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030526; c=relaxed/simple;
	bh=tYtUxs8MDCeEHLyKe1yHslx4nGY7x4AqJNrEToGvpAM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dd59+2hE+aXUwpFFg/RD3O6xhXBgKV2F55fjVmbaHkZog878Ic0+gpL7/eYo23fypieBCPmmgE0zv6Zr6o9IP6s1yfv+hNbIVdY+u4Sjvr+f219FnsbqTyYIJvhMzaBrT/7oqCRNG9joggA4PzByxQRM/zTGlTMwYE16zaRODnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgKi8IVw; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgKi8IVw"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512f7332252so3321104e87.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 02:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709030523; x=1709635323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbo/Nh/eeCd4hyCTeSmGwFUAX80qplClo0BDURI70/o=;
        b=kgKi8IVwtiqMCtuvyp2HTBoecpM5YEb+hSZ91qJ8JGLS5PkQ2jpWUnCSJlMVZnfdC9
         mtgJTJf9twPW7eql9ggXvbLOYM5iSIEn3s/IPu1T7uXDNm/C+BzMXm007/hYVL9mq8qc
         Lj7wyZXgz7JsI+zr9o5saR7I2YnsB1oEYnUBQgYb3bdlwcqMsPblT3u8ZkiKq9ld08gE
         PxUyqMHz5CKwPhziFP9xn1+kfgdejIW+e4kUnztCnrR99Qpcq6RZIl605iqgDaBf34Vw
         Exyfe8b4Jq3P6hbQEcjUVmvJGQHOPOtQiLF9nm3lilH38ZARMQcXvZj49ef5d3cqgeL3
         cWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709030523; x=1709635323;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bbo/Nh/eeCd4hyCTeSmGwFUAX80qplClo0BDURI70/o=;
        b=hCuWnV/dZgCkbt/q7HnYtkcE7btIgwzRspW4rSRCxhm4e2hWZqDMEKaP22jx9+x6uV
         XZ5/SdZxkPWi1BfJ7HKT7H/qrB9zLqqEc1pKcvReqt9J8kl+1BeM/cvJfj0aDwF1Ed0s
         AAaJ7Z1lCLBrCxxz8cUQ8Kvu36sHNj0diyk3r5a4P1KrMNA866eKz/0JEW9P1AXEDP3r
         WDLva6rkAA25HX8rRkaKcCgGfjzf8bRm0wV6EgVP8mbL/UUmJILdzGZWSrKL0LyF2uih
         pPSMieqvLB6UNJUCEFVS97w0o2H2tKGjSsW//xGxrSxecno086jy1gDdzIgqjP678IZN
         s8eg==
X-Gm-Message-State: AOJu0Yw2xpPfACFrz9X2jbSqUt1cQexY45Ot6porVncavjD+heh9lly/
	rkX8rJOpkJwiv7KTczM//OMhC+0l2aiau8r2MN3AFyIVQQWNmtqn
X-Google-Smtp-Source: AGHT+IFxjX6nRDWU1F5UKQA+wLysdOK8AEy0fV7awucCkllvJJ34OWsrGSfKzjmqrsViIqpbmXh4rw==
X-Received: by 2002:ac2:4102:0:b0:513:f34:f4c1 with SMTP id b2-20020ac24102000000b005130f34f4c1mr570327lfi.20.1709030522649;
        Tue, 27 Feb 2024 02:42:02 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id u9-20020a056000038900b0033cffd1a302sm7717629wrf.57.2024.02.27.02.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 02:42:02 -0800 (PST)
Message-ID: <2f749aae-697b-4d35-a6ed-7d2a2faa596a@gmail.com>
Date: Tue, 27 Feb 2024 10:41:54 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Interactive rebase: using "pick" for merge commits
Content-Language: en-US
To: Stefan Haller <lists@haller-berlin.de>, phillip.wood@dunelm.org.uk,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <424f2e08-a2ad-4bb2-8a6b-136c426dc127@haller-berlin.de>
 <ad561600-faf6-4d3c-80b2-34b3d1a1b99e@gmail.com>
 <65c65f6b-5ec8-4fa0-a17c-0f2c0d32b390@haller-berlin.de>
 <ZcnFl8kypKRYeLo3@tanuki> <040f142c-7ee2-429e-88eb-d328b01a4b8c@gmail.com>
 <2739325d-93b1-445c-aac9-3e0ec54a27e4@haller-berlin.de>
 <b4781808-f722-4be5-906f-4c3409c3295c@gmail.com>
 <6a557891-ffcd-4c42-9768-ec2da0fce92a@haller-berlin.de>
In-Reply-To: <6a557891-ffcd-4c42-9768-ec2da0fce92a@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2024 19:07, Stefan Haller wrote:
> On 26.02.24 11:56, Phillip Wood wrote:
>>> It probably makes more sense to teach lazygit to visualize the
>>> .git/sequencer/todo file, and then use git cherry-pick.
>>
>> If lazygit is generating the todo list for the cherry-pick could it
>> check if the commit is a merge and insert "exec cherry-pick -m ..." for
>> those commits?
> 
> That's a good idea, but it wouldn't buy us very much. We'd still have to
> add support for conflicts during a cherry-pick; when there's a conflict
> during a rebase, lazygit has this nice visualization of the conflicting
> commit (we talked about that in [1], and it turned out to be working
> extremely well), so it would have to learn to do the same thing for a
> conflicting cherry-pick (although this does seem to be a lot easier).
> And then it would have to learn to call "cherry-pick --continue" rather
> than "rebase --continue" after resolving. But if we do all these things,
> then we're not so far away from being able to just call git cherry-pick
> ourselves.

Oh I'd forgotten about handling conflicts - that does make my proposal 
less attractive.

Best Wishes

Phillip

> -Stefan
> 
> [1] <https://public-inbox.org/git/
>       961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de/>
