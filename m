Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DDE33263A
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727672; cv=none; b=MGdWQjjeq8qPd7jVUU21J3a+6RcPb60WAouWJQlqBQi5Xtm+0ijTBv6YFSfoKMHOOyYhfQo5FMgRzsSeATeByYZdFm2uL/6nJjmiQy7cMgRVbfUP44qB1JeOXvTkzHAWbnwXKOSQfirsoD51SmBQpxfERhdTfTELHp3xPsk1//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727672; c=relaxed/simple;
	bh=hwpga7mZQ1YQkuZMABR9BckuI19aKD1aK5pgsBvx2AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDlf8OG6lpvDIU6yP1YhwryCR8lUTbIjZiy/smgiNMjPtoMncuQb+7yjsehpqVFbMM+ulL1aqU1J9oRHkNMr/EEniE8uqA1/KK17uwVlJhadT4CS54vG+IvVZe2rJZZ4xTJTTCr+6VELlpK4N0AnyREX4BJ8buEBNogkKC0Otr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj2Rrx+w; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj2Rrx+w"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ce9df31840so1021116d6.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781727670; x=1782332470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/Ya4eLF2tspqN2iRs8PWUKIPHGMWOxSdVPMcraJVvM=;
        b=Aj2Rrx+wjjfiB3ZvlxNYkcF8hEe2Gosjh3bj3PvsUC6/+9kajVHjZgoD51VvoHpQmI
         oUX02vt/Z7Epp6lv8U7UoOH9rioc40bHpuCAMOjWr0p7DUETaprkVSkFIDTuAkkaWVLl
         CEPhWupZ1Z7AmV+vazfZa++DCDRqOmAlC9V6BFyo1uWHPwgY9ApJszt8MkTNDV8ovLoR
         WKS2WKaonlFATH8gvp7vq1LmBEQlndETamQpJoSrYgPuW1xJz3gZiN1xq0uJQLSI6GmQ
         TVAZtc8qqTZ3o1MG8N5A6SOWUjzfms/3De7ygdREfl2aeCHthFpfdMqUzuSIiumjkugm
         dLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781727670; x=1782332470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/Ya4eLF2tspqN2iRs8PWUKIPHGMWOxSdVPMcraJVvM=;
        b=nE/Y4/cHp14rh9Zvi2l7qtO0wTOBLXm1YgD+VfYwr+5J96vwS3GToiY5xQMNEdWeMn
         zHwAIW2IQy36ae4I8OXxjABSq/DEOiOfYer8EGyez724KRiCwRPIY+rgRjTq2yHiHicR
         qlhBt/7SmqjhirR9EAXkznO12LgVBSC1CaHEBH6c2vyKpoPrEjwYQowY28P3CGAx8663
         uHT7QdlOVeuuV+vhC6t6PqNzKLViz99eMaU54cC3sAqfENEGDU6gwK661Ls97ZVWhRB0
         iLTm9M5UympkadELdJDF+1+OoqXNIpRx34BfGvaoRcwbISMJYXYU3aksoA54s6vcKMys
         SdnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/n9b0h8RVgQ5ceswSFaUX/Rc1ouC+geBJbJ8kGjejntWCc0gDQtsnLsKeuHGgv4OWJ5qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDjUfSZ4N9smQeLVTPGk7lLrWCA6KX80KSUYZeBAeFGZ/Byf3S
	qKWsDD4y4rfQGERBQqD9jgzFDJtbCZWOMyJEFbnAB5F0DYfG1aAJcCL8
X-Gm-Gg: AfdE7cmjA+DTSTvIS5+sByHRNhbQhJXPci8Qn7IqC5avJVZoUrWF2cnptjgEeuZL3kw
	ckc4WYTLkxyalsELITk00NGDAb0+260ljUFU5bsBq/sjX6/oOw4uWyPTcqr0Sv85XWH0c0TY5e6
	RmchIT/g8YkVmIXX+dY4n3NiG0rukARZdosTvjabJKhTF1mH8ETWuW5z+7/KQvvwt86r8WPbYa4
	BtKd3+XZ5ZFPc3znFy7Djzk+2Qw5OmIPemHu5fUEb3r2maBq+dbJu+f7KITx81AzLQtXZThwgVM
	bajz16jQqHSvVXkJp/KhBt4nWe4lBr8zPQFO/QeLyzz3qofkj4AozekNqs8ZeKigkLyG2EQwaxy
	CYe9LzdvUIGoaSde+WNxv14NFtWAaVAaqr8hm+VFPefsXurHON4w9Gv0k+zJ1sDiXbTVkvH1fP+
	dEcW8HxyfttP3vbIYIJcWUPpnHOT7Q63aL4VEcuruABVLCebjXmR78wDvywA==
X-Received: by 2002:a0c:e017:0:b0:8cd:b80e:6157 with SMTP id 6a1803df08f44-8db5b0db909mr91390526d6.14.1781727669734;
        Wed, 17 Jun 2026 13:21:09 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f122b21bsm71392746d6.4.2026.06.17.13.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 13:21:09 -0700 (PDT)
Message-ID: <e88c6e7d-1236-4595-9dea-26c33eab6432@gmail.com>
Date: Wed, 17 Jun 2026 16:21:08 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] config: allow disabling config includes
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
 <20260608225149.GB340696@coredump.intra.peff.net>
 <4d7834c0-d8ab-4dcd-8a7f-ed62c30cbe43@gmail.com>
 <20260611083943.GJ2191159@coredump.intra.peff.net>
 <539713c4-b291-42e6-8541-a16a454518f5@gmail.com> <xmqqzf0tuhfm.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqzf0tuhfm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/2026 2:53 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 6/11/2026 4:39 AM, Jeff King wrote:
>>> On Tue, Jun 09, 2026 at 08:59:22AM -0400, Derrick Stolee wrote:
>>
>>> I'm not sure I entirely understand the problematic case, though. The
>>> user points to in-repo config (which we already tell people is a bad
>>> idea), and then that config breaks for some reason? Because the include
>>> is relative and git is run from another directory?
>>
>>>> Or: are we venturing into territory where we don't even want to create a
>>>> new foot-gun? If there were another way to solve the situation that I'm
>>>> facing without these risks, then I'd be open to it. Any ideas?
>>>
>>> Yeah, the more I think on it, the more it seems like a foot-gun. Like I
>>> said, I'm not sure I entirely understand the use-case. If you could
>>> flesh out an example, that might help.
>> The case I'm struggling with is that our build system has sandboxing
>> restrictions to make sure the build is deterministic based on a certain
>> number of inputs. A tool we don't control is calling Git commands and
>> these users with included config are getting errors because the build
>> is looking at files in the repo that are not registered as build inputs.
>>
>> Files within $SRCROOT/.git/ are ignored as "internal to Git" but when
>> the users update their config to include other files, this error occurs.
>>
>> I'd much rather that this tool doesn't call Git at all, but I'm unable
>> to make that change to a third-party tool. But this environment variable
>> would make it possible to disable this behavior. And I'd also rather
>> that these users don't use includes in this way, but they are using a
>> checked-in file to share aliases and other quality-of-life things when
>> a human uses Git, not "critical" settings.
>>
>> This series is my attempt to see if we can find a solution that enables
>> this behavior, but maybe we've found enough concerns with the idea that
>> we can push back on the users to say "stop doing that."
> 
> It seems that the thread went dark after this message.  Should I
> take silence as an agreement, and mark the topic as retracted?
> 
> Thanks for an interesting discussion.

Yes, consider this retracted. I saw you made that note in the What's
Cooking email so I thought it was understood.

I believe that the risk is not worth the reward here.

Thanks,
-Stolee
