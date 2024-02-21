Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222C785628
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542811; cv=none; b=MV+v9B9XYjtHV1yXMAtIykB/egSKhsKbtZcK0wzh3e9eDfXMN1yQV/koXFGobfriqAnPCRwmZ2GC0eA19CvG76ivqoZuVpOd/hWsXZJewrZ0h2SyGpQRbkQjrXcqQ1K1B4t2bq1pLjyRK4MgVU/U61tGVFaO7DM1UaTY031tB7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542811; c=relaxed/simple;
	bh=0RFlZQeZ8a3jhSr6oK397+c7eoHMYIST/BXqf04L1GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1wQsSz8zTLcaSg5vXgKuU5JQ1QkSOiYwu01ADLBNk3boobuVFygkBVAu6A5JIYMeW+0k3qUd6QZ1ItWtVdVzScoKJOwqT85wNCHgEEqx4v52QqtolyE62dRuSxh/PYtbNimk8rLN7QKpFa1ZvvX6EbbRNxFj8690YwyFmwABUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqJ0nAMu; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqJ0nAMu"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68f9e399c91so9950086d6.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 11:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708542809; x=1709147609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pyMsyyyg4Vg9/u62GS9ED158nFjInfso7l1LnRZ8lSo=;
        b=DqJ0nAMurQvpgSCheowUVlIIiDRaFgkQXhw8C4WUMslcFkcK7MN50Y4KUbysl7Hpvw
         7qfkgbvN5d/F85q+BW+Mk2YmveQ3wnNdoVb5uoPABThOp5KCISwtcNRTTXUQqomMl/QQ
         bwuveQFz7XuW6LmSZ72Qnqj3cIJg3atJ3NoepDtgNkZCluqieQSszz8XOLP1K5GQyvZ4
         F+s3TWr+Md3ODNadAU1av07vTZ1DjnLw9xVdrHt7L+1nZpIbPTuJZBPzAqXBdrhDX4VX
         NszDBKCiWiDq0vC1x7x72n5WVhoyl22ITEe/YZrsfaKpHSmgAzlU0O4tJ4vtv63zoGQd
         S13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708542809; x=1709147609;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyMsyyyg4Vg9/u62GS9ED158nFjInfso7l1LnRZ8lSo=;
        b=uxukHFrQBkLaCRPjdwIivh1JLE9jGX3Ct9yXHldjxZ1B460tUreh4BGefG13RWtqsi
         t+WP0A5jbtemVGZKn/N4pC+2Ptag3NN8o8RLiBc86qqjA1Fxmkm7HV4txIcw+561Vmq/
         ZDv3WhHC5ii46jCzY4ErySgpYiIb7Vf5q3Kaw+rFqb+Jyd4Jfa9UByQnlPoINVv84VR8
         1f2aBnXsm8uh72VEhzXtYATtp3ouqFNc1YCRTRGLWfzHE2GuLtHX8oS5Ig2SKrwnq6cb
         nzQ40zJ+6xYDdipstJ8zf3qfTsuzZUuiywI2vbU0jBUlWDcbo+YyqOEohbNADXHV0zli
         h1ww==
X-Forwarded-Encrypted: i=1; AJvYcCV8oqL7UCuxCM2Q57VuoRu9Z6HLJBqQOkxSSYCFGaVSOiQIWjPSHUmGeVltcSBTR1jDkXRUcYMMTa3Le8OWJn3KDesF
X-Gm-Message-State: AOJu0Yy4AFjXiq9sMnZJZpZTzPoNaHcAXADfg68vtewM4bkTaFOLdBg0
	AtnnWb4DLYiB5YAO+BuJIWJcdVF4UuH1l1uNuqfmLgOD2A4YsRJkzpD6NZqyFqAGjA==
X-Google-Smtp-Source: AGHT+IHw7DmhB62AIwVg21CTYPZ92Nj4G7yFPfuWJBbotxG6+8CgD/sX/ptUY/NqcT1CNEGnygZItQ==
X-Received: by 2002:a0c:9782:0:b0:68f:2d56:fc11 with SMTP id l2-20020a0c9782000000b0068f2d56fc11mr16908947qvd.51.1708542808989;
        Wed, 21 Feb 2024 11:13:28 -0800 (PST)
Received: from [10.197.96.0] ([152.3.43.40])
        by smtp.gmail.com with ESMTPSA id qq1-20020a0562142c0100b0068cdc0a0d42sm284102qvb.25.2024.02.21.11.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 11:13:28 -0800 (PST)
Message-ID: <b84e77a1-93e4-4de0-a0cd-4d76a5691a9b@gmail.com>
Date: Wed, 21 Feb 2024 14:13:27 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <20240218033146.372727-2-rpc01234@gmail.com>
 <99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com>
 <df020dcc-afe8-4dd8-b476-4ca032206214@gmail.com>
 <78a8733b-c74a-4017-8905-d29b2e05adb1@gmail.com> <xmqqjzmzqb85.fsf@gitster.g>
From: Ricardo C <rpc01234@gmail.com>
Autocrypt: addr=rpc01234@gmail.com; keydata=
 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
 jjbjCH/5+g==
In-Reply-To: <xmqqjzmzqb85.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 12:47, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> That's a good idea but I think it would be better to test that "git
>> stash create" is not affected by the config as we don't want to change
>> the behavior of its behavior.
> 
> Yup.  Making sure "stash create" stays the same is a very good
> thing.  Thanks for suggesting it.

I agree. I'll make sure to add testing for it if/when we decide to go through 
with this change.

> Regardling the need to have an escape hatch that is well publicized
> long before a potentially harmful switch can safely happen, one way
> out might be to
> 
>   - Declare "git stash create" is a plumbing, but the rest is
>     considered Porcelain.  Publicize it well and wait for the word to
>     spread out.  Folks who are in favor of adding these configuration
>     variables to the system may need to do some legwork, spreading
>     the word around at stackoverflow and various other venues,
>     scouring public repositories at GitHub and other hosting sites
>     and studying third-party uses of "git stash" that should be
>     replaced with "git stash create" followed by "git update-ref",
>     and raising issues to notify the owners of such projects, etc.
> 
>   - Add breaking configuration variables after a few year
This feels like quite a lot of work. I guess that the main question now is 
whether this change is worth the effort. What would publicizing this look 
like? Updating documentation? Sending out an announcement?

I can also imagine some tools would dislike having to switch to the more 
manual stash+update-ref, so maybe easier plumbing should be added?

> FWIW, I can see how permanently enabling "include untracked" may be
> OK in a workflow, but I cannot see the utility of permanently
> enabling "keepindex" at all.  Sometimes I'd want to clear the slate
> so that I can try building and testing what I added to the index and
> that is why I want to use the option.  But a lot of other times, I
> want to clear the slate to go back to the very pristine state that
> is equal to the HEAD.  As the need to switch between the two modes
> happens quite often, the way to defeat configured stash.keepindex
> takes quite many keystrokes, and in general I think the regular
> stashing happens far more often than keepindex stashing, I'd find
> that using shorthand "-k" on the command line occasionally without
> having this configuration variable would be what people would end up
> using anyway.

Permanently enabling keepIndex is mainly intended for people that like to 
stash their unstaged changes before committing (e.g., for testing them 
independently of other changes). The main issue with what you recommend is 
that, if they forget to use `-k`, then the entire state of the index is lost, 
which is especially problematic if the changes were interactively staged. A 
report of someone having issues with this workflow is here[1].

Perhaps a better solution would be to provide some mechanism by which to also 
save the state of the index when stashing changes, and also restore it when 
applying the stash. I figure this change in behavior would be much less 
problematic.

Another option would be to go closer to the route of `git switch` and `git 
restore`, where a separate command with a more user-friendly interface is 
added. Then all of `git stash` could be kept as plumbing, and this new command 
would be entirely porcelain. I don't think that this change would be worth 
introducing a new command for, but if there are other changes that could also 
be included, then it might make sense.

> And there is always "[alias] stk = stash -k" available ;-)

Yeah, currently I use a shell alias for `git stash -ku`, but that doesn't help 
when I'm using other git frontends.


[1] https://bsd.network/@ed1conf/111783574839749798
