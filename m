Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C71FF1A1
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208380; cv=none; b=MaxQji5p7FcfL51E9TzjWZP1gXNQ4Rxf9QQk/KGKEgB6xtoXtV2QzqtbL5BIIF3NzSsRhmLV2jsrVbsvrRNRXCTyDgG/CjlZfkWgVkG9xftieuoE4ajpKkg4UBneeC+5mZG6FJTINWk/g3vFo3nW0FcYDLyyedIFXN+6RQpHhuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208380; c=relaxed/simple;
	bh=EamhBvY8LZtqxKX3bgFdjAt4+Jg+/iKdnEg7efb1r3I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fP08bGx2sbV95h/A4pZVibGM4bOVcj7maKS+PvDUsTrzWGhj+rpuHPkuZEVzq1iXW0NaPdin/8Yg3AYXlRbXYy+YM3yTR3b8J1v3aLuQp6WjroMWgIfwWR2iMzFnTStO2EuQaKGl6qyHJQALWOLEb9VwIXTJckLrRNMxTdO7rn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOxELTD2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOxELTD2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45f2f10502fso6592365e9.0
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758208377; x=1758813177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKAKdm6f8agol4PZhNQbeE4MNb5/rtWa5UivxZ+xWCM=;
        b=UOxELTD2c4xfjkUp7G7JyOo6zUYKGxTEQicj88EQnMDw54SR7vpXkO7BmVSIh+nr/v
         7c83Y8voiUjFESSX3T+kckZGFE4g7nlg1oXmeGXqO7DLK4aAJ7LpjPmFOUzqC6TYVpEl
         pApTI+JyWlBhhbpFegf4UOX79Me8oYoveABT8dZo3vW/iTXDB5t2J/0g2gnojkI3kFUJ
         ukiziPSAhM2ZR17QoZas7jBJXXYAnIztOeBRvlxepq417KjwgQ97NsX/6iNimMUPweNd
         8HBDYuw5U61H77pBqlhsvo1faAiShm7JQ1NFtsnUcpcqjbeqVwHr4hwyFOhc8v3g5Nag
         rPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208377; x=1758813177;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKAKdm6f8agol4PZhNQbeE4MNb5/rtWa5UivxZ+xWCM=;
        b=Jc+lsFvK5L9dggwWto7v6I2Xmz9RNFMYN3rH+xSLWgDhobsRdkvuJfWZZeeeBHe+zF
         VipqJrcQkQhxpdqDGR/aQTBF91vU1tOooWbnzcmhzPZJkOjYCk31Y/JoZB2O6xIkwMn1
         es8hQMYRIVhHc6DzDCScLG9GmAjfTgUA5oNpPlo9Apsw6q94P1L+saMl7BrOUaxw6vqy
         c4jDXtY+mj1I8TGfuBWiCnN6juM1EQ/9RJTz/D1vrE1qKHX/42x5CsmJW3vJoGnpoHTc
         SA1zRX2jy5rt+pu6ItShgtvOUUX580VS+rhxlI92kvKpKo54jXmaSOcIzMfhIqJaPVYD
         5/9w==
X-Gm-Message-State: AOJu0YxavNU2+SSSP9gCbMiGQYiBqeqIAfTkM50HRJanYubpdrVKFx7d
	lGwyuyoDdS3Oj6IxO3VqNhwOZT5K7eMUtXfLLyt+pLMzC2wc9Qpb3Okh+43sIw==
X-Gm-Gg: ASbGncsUaufIr8h7EVQDUKloIX5LZHGwH9QU+hYsF+4N9wAUA0BiLi4Or4te2jxOOFf
	O6aMoKW8a7YCBmpwqd+8W9S3W2z2Y7uTwit3+fkvcXHY1cN03pF2ODWwcQxAcHr+e43/PGxc1Rf
	jpxo+jzA/4cgJH7xiCOo1vmYgrhpdUfDvrmF2Ugc4h8MwM4L2B+9iwI6HovW/29hPgYkvVA2Glt
	TlxP1mDOzBkdLnkv5L/TUWINDUve7Am4Y5eYgG+PduaZyokAb67ZU8ENeRNJezI2j0kxIG/8gf2
	/gOfkc+Mo2k2GG8HkFxMM17TZXszOND9khZinHNSgTfZ+s3AzPaYPyBzKJcEmEmijSt3wHWT96C
	+Ivn/5I5+fElKMkTlVCCjedWpXYXRep696PPvBTqii+msZ0UvyTPlaFRx8zfNSgXZEAiQ+Vb8Kg
	DJGd7fPVhvjXd0duUU0w==
X-Google-Smtp-Source: AGHT+IEjPRG9KXB+0R7nY7y9RTuZNnXLzVAyETUsTeIpQGlFqm6adrRDDbX9bytogU4qzzfG81kyeg==
X-Received: by 2002:a05:600c:1991:b0:45b:9afe:ad48 with SMTP id 5b1f17b1804b1-4620348f459mr83940945e9.16.1758208377016;
        Thu, 18 Sep 2025 08:12:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad30csm51345405e9.23.2025.09.18.08.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:12:56 -0700 (PDT)
Message-ID: <ff67849a-74d5-4a3a-bfee-de261aa66ca3@gmail.com>
Date: Thu, 18 Sep 2025 16:12:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Bug] commit cleanup does not happen during autosquash rebase
To: Simon Cheng <cyqsimon@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <CA+itcS3DxbgpFy2aPRvHQvTAYE=dU0kfeDdidVwWLU=rBAWR4w@mail.gmail.com>
 <63e7901f-4210-438e-9389-8117d5fb83b6@gmail.com>
 <CA+itcS2Knde3K_JuVru6_s=Eh0rPBPi1aa1=y0_wyA-=A7CXsQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+itcS2Knde3K_JuVru6_s=Eh0rPBPi1aa1=y0_wyA-=A7CXsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 10:03, Simon Cheng wrote:
> Resending because I accidentally used HTML mode.
> 
> Thanks Phillip,
> 
> Sorry for replying so late. I forgot to set up notifications for this
> email address, so I had basically completely forgotten about this
> matter.

You're reply turned out to be timely as I was thinking about this bug 
just before I read it on Monday. I've sent a patch which you should be 
Cc'd on. For anyone following the discussion on the list it is available 
at 
https://lore.kernel.org/git/cover.1758186038.git.phillip.wood@dunelm.org.uk/

> Yes I fully agree with your proposed approach. Also it's probably a
> good idea to update the `git-config(1)` man page to document all the
> commands affected by `commit.cleanup`.

That's a good idea but it will mean a little bit of work to audit how 
commands are affected by that config setting.

Thanks

Phillip

> Cheers,
> 
> Simon
> 
> 
> On Mon, 18 Aug 2025 at 23:14, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Simon
>>
>> On 13/08/2025 12:39, Simon Cheng wrote:
>>>
>>> What did you do before the bug happened? (Steps to reproduce your issue)
>>>
>>> 1. Initialize a git repo with `git init`
>>> 2. Install a custom `prepare-commit-msg` hook that injects some comments
>>>     - Intention: inject the output of `git log --oneline -n10` during
>>> interactive commit, so I can see past commits
>>> 3. Run `git config commit.cleanup strip`
>>>     - Intention: strip the injected comments too in non-interactive mode
>>> (e.g. `git cherry-pick` & `git rebase`)
>>> 4. Run `touch foo && git add -A && git commit -m "Initial commit"`
>>> 5. Run `touch bar && git add -A && git commit --fixup=@`
>>> 6. Run `git rebase --root --autosquash`
>>
>> Thanks for providing a simple way to reproduce this
>>
>>> What did you expect to happen? (Expected behavior)
>>>
>>> Git would perform the autosquash, while keeping the commit message of
>>> the squash target unchanged.
>>>
>>> What happened instead? (Actual behavior)
>>>
>>> Git performed the autosquash, but the commit message of the squash
>>> target is now clobbered with my injected comments.
>>
>> It looks like this stems from f7d42ceec52 (rebase -i: do leave commit
>> message intact in fixup! chains, 2021-01-28) which was added in response
>> to a bug report[1]. That commit switched from always cleaning up the
>> fixup message to never cleaning it up. I wonder if instead we should be
>> respecting the user's commit.cleanup setting. The commit message says
>> that should not respect commit.cleanup because we want to use the
>> message verbatim but that is not what we do with "pick" commands which
>> respect commit.cleanup if it is set. Given that we call the
>> prepare-commit-msg hook we cannot be sure that we're reusing the
>> original commit message verbatim anyway so I think we should probably
>> change "fixup" commands to use the same cleanup flags as "pick" commands.
>>
>> I'm going to be off the list for a week from tomorrow but I'll try and
>> look at this again when I'm back if no one else has picked it up in the
>> meantime.
>>
>> Thanks
>>
>> Phillip
>>
>> [1]
>> https://lore.kernel.org/git/CANVGpwZGbzYLMeMze64e_OU9p3bjyEgzC5thmNBr6LttBt+YGw@mail.gmail.com/
>>
>>> What's different between what you expected and what actually happened?
>>>
>>> I expected commit cleanup to happen during the autosquash. It seems
>>> like that didn't happen.
>>>
>>> Anything else you want to add:
>>>
>>> Here is my `prepare-commit-msg` script. But I expect this issue to be
>>> replicable with anything that injects comments.
>>>
>>> ```
>>> #!/usr/bin/env bash
>>> {
>>>     echo '# Last 10 commits:'
>>>     git log --oneline -n 10 --decorate=short | sed 's/^/#   /'
>>>     echo '#'
>>> } >> "$1"
>>> ```
>>>
>>> Please review the rest of the bug report below.
>>> You can delete any lines you don't wish to share.
>>>
>>>
>>> [System Info]
>>> git version:
>>> git version 2.50.1
>>> cpu: x86_64
>>> built from commit: d82adb61ba2fd11d8f2587fca1b6bd7925ce4044
>>> sizeof-long: 8
>>> sizeof-size_t: 8
>>> shell-path: /bin/sh
>>> libcurl: 8.14.1
>>> OpenSSL: OpenSSL 3.5.1 1 Jul 2025
>>> zlib-ng: 2.2.4
>>> SHA-1: SHA1_DC
>>> SHA-256: SHA256_BLK
>>> uname: Linux 6.12.41-1-lts #1 SMP PREEMPT_DYNAMIC Fri, 01 Aug 2025
>>> 20:42:03 +0000 x86_64
>>> compiler info: gnuc: 15.1
>>> libc info: glibc: 2.42
>>> $SHELL (typically, interactive shell): /bin/bash
>>>
>>>
>>> [Enabled Hooks]
>>> prepare-commit-msg
>>>
>>

