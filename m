Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B7215B140
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834525; cv=none; b=hHqm6lEBgCn0sRC8L6KR8VTGvnJBlTEK+OgNQNNaZcNhyzOqn61OM0KVxIdRrAC8kvkGlRrpuVWEM9DhtaEhRwHq1q/s+42Gue6lJwfPPGM0F/c/la0qCeY7fgxy8qyN9o3s8CVfYRd3UAapTo6Q4OgXmEEnIUtvYCevhxfoa5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834525; c=relaxed/simple;
	bh=7UXehJdfaXst8rJOUEt/OjP3aZPxmybee0KpPPnIH50=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AvbZec0xNE+/7sphCH1q1ktQoWZt0+RzZJhrZd1SK20GDhxCmkn84ot9T7D1DNNroUi7wcF1pb80IXd2nmS4MNXVX29y/HxCWutClp8DdEh+Rlt/si2BSfQVCSWGys62nRLlV0AXiOu7eWVYHbl+cTE9I/lw1u0jnxs/eL08xkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAFCG9eH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAFCG9eH"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3686b285969so3319226f8f.0
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721834522; x=1722439322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g12quOD9tFxVLeSZ5ehMv9pzmUP37NGFAHHD7uLt/sE=;
        b=WAFCG9eHsBHo/z8cYtQg+eMKw8I8YzpEUZzd6udEIXjEITmbww5n5yuwbz5e3HN3s/
         eI6SIEoKVZOTR2ldl+srIPHZbkDNX2lz9RH6BN1gGpZkLdZae32MSJ6OWtAab6pS18gG
         DlV5a96gz+wr8t5v9+LO/A4HkCc3MyGGTZ04/sa4jC70SBA6X+3LXRK1Fl5wyUJaV9/v
         fzHbjgOKKX+pJ1SWZC0MCd42SeMFg9s29qYMGLaViqz9j2gLXe1oJy/KWomKjq6dgDdH
         gKAVmt+66HER3/pCaMe+zBnuYLGKexNmX/wulUc4RgTtT7YF++kDuco4S84Hu3lC7+X3
         5iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834522; x=1722439322;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g12quOD9tFxVLeSZ5ehMv9pzmUP37NGFAHHD7uLt/sE=;
        b=JqaPEQM0/Qhrn/iGq60nPlusi5NWUhGDXmG24ac5k4AqYy98KtC7DLDxf0hCITf2oL
         5CPPpSj+KI7gnEyGxVIUEIArafjWh206aNxEh38astjh5G3v21tRciJIGfJ4jpvipX2s
         3NoILrrfFni+aBU1JMY48Vb/yMC+N/mo0fYOiE27CGiPikdAxU3kDCIPSnejE2HZKOet
         35AAt4YRq/nipkq1FH8BO4xpBgn6rSRrAueggkv8tWULl/nCMJZ4kp479rLPXbg2cO+g
         OhkVKbT3iOUVB9MWDFdy7Kxy0QE3y1jOUftaWEodtZXJ8azOBPn0eDVygGS/1yOw80/Y
         TUwA==
X-Gm-Message-State: AOJu0YyFOEtojdt0pdejUnEhZN3KvcDtuIbuG9RaWzc4mFfogbYKb9oL
	NLtIl/NBZYNNsvLSWItTaZR4f1W1tKViyUHejqS0vcVoPtzQ5Ib4
X-Google-Smtp-Source: AGHT+IFjnpyxTiRHzh+PLGvj+It4HHENZpGCUtLg8rxE9lrlveiqQ+KfCvWOErg19ArCB7XFe1iMqw==
X-Received: by 2002:a05:6000:1b0a:b0:367:9107:9e11 with SMTP id ffacd0b85a97d-369bb2a94bemr9296269f8f.62.1721834521925;
        Wed, 24 Jul 2024 08:22:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868b24csm14584798f8f.25.2024.07.24.08.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:22:01 -0700 (PDT)
Message-ID: <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
Date: Wed, 24 Jul 2024 16:21:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] add-p P fixups
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
Content-Language: en-US
In-Reply-To: <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 23/07/2024 23:08, Rubén Justo wrote:
> On Tue, Jul 23, 2024 at 10:15:03AM +0100, Phillip Wood wrote:
> 
>> As rj/add-p-pager is only in seen I
>> assume you'll re-roll with these squashed in once everyone is happy?
> 
> Junio has already integrated these changes into the branch he has in his
> tree, including a small change to the message to adjust it to his
> comments, which I think is good.
> 
> I hope that what we already have in Junio's tree is the final iteration
> of this long series and that we can let it settle before making further
> changes.

The resulting tree is good, but the history is not bisectable. You 
should squash the fixups locally, updating the message of the fixed up 
commit as needed and submit the result as the final version.

Best Wishes

Phillip

>>
>> Best Wishes
>>
>> Phillip
>>
>> On 23/07/2024 01:39, Rubén Justo wrote:
>>> Rubén Justo (1):
>>>     t3701: avoid one-shot export for shell functions
>>>     pager: make wait_for_pager a no-op for "cat"
>>>
>>>    pager.c                    | 3 +++
>>>    t/t3701-add-interactive.sh | 6 +++++-
>>>    2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> Range-diff against v1:
>>> 1:  c3b8ebbae7 ! 1:  15fbf82fff t3701: avoid one-shot export for shell functions
>>>       @@ Commit message
>>>                VAR=VAL command args
>>>       -    it's a common way to define one-shot variables within the scope of
>>>       +    is a common way to set and export one-shot variables within the scope of
>>>            executing a "command".
>>>            However, when "command" is a function which in turn executes the
>>>       @@ Commit message
>>>                $ A=1 f
>>>                A=
>>>       +    Note that POSIX is not specific about this behavior:
>>>       +
>>>       +    http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01
>>>       +
>>>            One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running dash
>>>            0.5.10.2-6, so we failed the test t3701:51;  the "git add -p" being
>>>            tested did not get our custom GIT_PAGER, which broke the test.
>>> 2:  f45455f1ff ! 2:  b87c3d96e4 pager: make wait_for_pager a no-op for "cat"
>>>       @@ Commit message
>>>            "cat" [*2*], then we return from `setup_pager()` silently without doing
>>>            anything, allowing the output to go directly to the normal stdout.
>>>       -    Let's make the call to `wait_for_pager()` for these cases, or any other
>>>       -    future optimizations that may occur, also exit silently without doing
>>>       -    anything.
>>>       +    If `setup_pager()` avoids forking a pager, then when the client calls
>>>       +    the corresponding `wait_for_pager()`, we might fail trying to terminate
>>>       +    a process that wasn't started.
>>>       +
>>>       +    One solution to avoid this problem could be to make the caller aware
>>>       +    that `setup_pager()` did nothing, so it could avoid calling
>>>       +    `wait_for_pager()`.
>>>       +
>>>       +    However, let's avoid shifting that responsibility to the caller and
>>>       +    instead treat the call to `wait_for_pager()` as a no-op when we know we
>>>       +    haven't forked a pager.
>>>               1.- 402461aab1 (pager: do not fork a pager if PAGER is set to empty.,
>>>                               2006-04-16)
