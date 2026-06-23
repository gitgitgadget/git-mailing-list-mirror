Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C83845CF
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224264; cv=none; b=sFbGb4lfDPFzVZHSdcA4zlY774TIW5/0rXnOHVY2jqJcgek0g4HoJqok1JPFcHob/Jk9XDUUb/Yefr5zi10xnSJmW36kv0UI0hNljwiHqEqZY6b6DXbEgFEncoTozaczHwFmkF8jj9F74NxjrMvvMnGxm9I7/5Ti/IvEvSdeC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224264; c=relaxed/simple;
	bh=RtwsXdUdIKN5xrda73uUVXI8sYRdvo10dlYyv15vvDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIvJ94XSd7cpvbH06Mm38lGPgqzG/Ws7mem+E8xnINSNKl6wjEQ+QsstScsb1ogc0+x0oxdtEp+Ly+4hKjoOwVXXC13i4XitMfF3nH0rRLIXaQzkrMAgFMOvQcs5OPlFQ7/2hxUd5CWbzEnakAdnn7/Pd37Q6cLc/FGzUq2hyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pA+MupY/; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pA+MupY/"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92542fa7d07so115679185a.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782224262; x=1782829062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZdSXpU7M0LaVhFmq7oRtwaCMngHc4wGygdQbzqKR/GM=;
        b=pA+MupY/BqDQrYu3YX5wT5f0tZr4M1F9cSKMMZvyIo1pM5gCsj2LWPVWNX6NOsUoPH
         Q+eexJ7nYUYB0AD3Vpa/LZYlKaJEkfSsYuKWZJH3zKAhprgF48+aoIM5A/U5AgmvyGVb
         jg9Oy/A8mOrYWTK48RwJCw1+mmiziNcsFjjr5n0d2xxH/rjEM5gpdISr8Firm3AD2n5c
         u2CYlgBiB3fkCwL2pl4mcgZ7hXT3cIKiUB5tuXQJtvQrlZr8tmzfR0Ppjh6rlJTO38sJ
         +y4isE4y3Cd1vIukMG/78rjNNfmKzfNq7KXWKmpkJd7+kPj9OZpijgu3JU8KbF6UwfwA
         VeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224262; x=1782829062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdSXpU7M0LaVhFmq7oRtwaCMngHc4wGygdQbzqKR/GM=;
        b=Hq0SpGZVpYGg0i7cFsaADGyUKSvFgbzOPnX+BwJzUrM3AshcBy/wGLdCg2Cq4S3X3p
         jGy0WQ2+1cua8rCri2U19fzYyrHvasj3jM6LkNMx6ohKRayLBH6pxnpgSUMi3148FU1d
         PWYJykFny++w1DN4vNpRyYDa2hYoiVoUMg1YjpNbw4/m4cLu+0vEfQi3N9vKHFPtFxCR
         c/OZNVpSdwjncFvl3+KYlYwNDWq8M7B1zmRhh2zGsTP56nU+rG5oQME+toDP6TsB3dSo
         Vvs8uVf9vjFCeZPTL3GMa+LzN0NM7GyXJGRd1kinRLhcWo5irmpO/9VSYYqt9zLETMPk
         CNUg==
X-Forwarded-Encrypted: i=1; AFNElJ+ObLhlSsS+bcppPJXkosDoVRsptlIUjtbEmZxnqNCqMR+uPzvMMMQuq2VuglGAsYGrpZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFri/+dZPjrRygWIM/SHZv90Zg1DJd7b0RS5DsCxMOJMC+HOu6
	F804arZAf8pBGmT10F0QPtEuqSAq/ztwOl0O0RuzEpO7llpMlngtlFrN
X-Gm-Gg: AfdE7cm8X1FKsZIrdH3RjwpcOLVB8rZ4u1Q7ImBTV23mmSqKg4ew83t4WYwL9Ql4/HK
	3+BJDs5MeXWPK19qAX4WaK26xwx/8G5CXTdHEQovAnpPsn6iVKVEyQjtaMuZ0LpYVoTvFenS93y
	Z3kaG0JXr4Z2k8dcWQMUdujE5PErQqzGIX3tsstNIexAVFZsCLCykiB46T1802lugxUEUMho5H6
	Shlka3J9dIjD49zF60+HcS7p8obg1dNcXpaRq81CHK1qXazT1+uVSqJu8StePG5sRj7SBj51kQh
	9L5u2znHPbZd04bc7a0XT/Hcbiy389uclicPFZP+ZtWReqg1FHQD79f19Xtre7ILQghaRZezkY0
	OXnI3ehKsqysgO1YaZ5HTjhCz29bG1XTtdn+VgwO2KV/jme5lOnLLM0Fir1oiXaXS2pVjSYbjvm
	8H8yYpKpbArzTovHB0nD+RVDhflGDixkCSRNbuthWy+IfcVCbQgkkXQvUQkg==
X-Received: by 2002:a05:620a:28cc:b0:916:1785:57bf with SMTP id af79cd13be357-925ffecfe25mr583657085a.6.1782224261522;
        Tue, 23 Jun 2026 07:17:41 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c1cecsm282187385a.24.2026.06.23.07.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 07:17:41 -0700 (PDT)
Message-ID: <ec241a02-546c-4b5f-8ef7-06b4355d8fec@gmail.com>
Date: Tue, 23 Jun 2026 10:17:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 2/6] commit-reach: introduce struct paint_queue with
 per-side counters
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <316e4dfe261043730c77142639f86f5c3cabe370.1781951820.git.gitgitgadget@gmail.com>
 <f0c9eb6e-60b1-4eb6-86be-3af4d87afe85@gmail.com>
 <CAL71e4Pcw-UUbHBw_j6PFx2bXmxZ93VLMWG+3Qap=RmCJa_ZgA@mail.gmail.com>
 <8d07f5a9-82fa-4aed-b407-363e659f6851@gmail.com>
 <CAL71e4NFHz_zVCWPvmTO8UPNyaKkDFqNQdd3CJykoiGmEhfUTA@mail.gmail.com>
 <509fa950-fb9b-468d-b917-6c0eb7823d64@gmail.com>
 <CAL71e4PzjdNCaVRtXg7wh9s6DxBeA4ock1aTzq8VPxKCmE-obA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4PzjdNCaVRtXg7wh9s6DxBeA4ock1aTzq8VPxKCmE-obA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/2026 10:09 AM, Kristofer Karlsson wrote:
> On Tue, 23 Jun 2026 at 15:50, Derrick Stolee <stolee@gmail.com> wrote:

>> How much of this data that you are passing into the method could be
>> state in the paint_queue struct? Could we have the paint_queue manage
>> all of the state necessary to make decisions around the walk
>> termination?
> 
> Good idea, I think adding last_gen to the struct is doable and makes it cleaner.
> If needed we could also add the mb_flags there (but would be a followup patch)
> Minor note: I renamed the struct to paint_state so that I could rename
> the prio_queue to queue and not have "queue.queue" which felt
> confusing in the code.
> 
>> Or, could we do a peek into the queue to see the "top" commit, and
>> check if it is a finite commit or not? I know that 'last_gen' is
>> supposed to be the commit walked in the previous cycle, but it seems
>> that we only care about "the remaining commits are finite" as our
>> condition.
> 
> Yes, peeking into the queue would work too, but it would feel awkward,
> 
>   commit = prio_queue_peek();
>   if (halt conditions) return NULL;
>   prio_queue_get();

Good instinct to notice that peeking and getting from the same
method is awkward.
> And if we get first, the condition is not valid - that said, it would be doable
> to instead put the halt conditions _between_ popping the commit and
> updating the counters. I am not sure how ugly or confusing it would be,
> but I could add a comment to explain why that sequencing is important.
> (Popping the commit and updating the counters may lead to temporary
> 0 counts, but then when we enqueue parents of the commits they
> move away from the 0 anyway). It would become something like:
> 
> // dry-/pseudo-coded
>   commit *paint_queue_pop() {
>     commit = prio_queue_pop();
>     if (!commit) return NULL;
>     if (halt_condition(state, commit.generation)) return NULL;
>     // important: don't decrement counters before checking the halt condition
>     paint_count_update(state, commit->object.flags, -1);
>     return commit;
>   }
I think this would be an appropriate way to handle this. If we
pop and return NULL then it's ok that we removed data from the
queue because it shouldn't be reused.

Thanks,
-Stolee
