Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC82EFD9B
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110489; cv=none; b=LXaJlOmmrUal27Hg9vSiQdX9CkAq1RB9kMxy92ilEwbj863s74tSn7T9ncCK3hGXRRV4MSJEGSPMBvzNs1y6DRPiA80wXezQyvzmn3LAFaUbj9jfH2cb43IWbPN86HeVj2h2O1AicG3qJmBb6fuKkf97El8YpQ3S3luiUFivCtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110489; c=relaxed/simple;
	bh=FefeteEZbsI503CXbnFmK75gBFQ00JnavNkykXIk4i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwtA66Px3uk6lkJTsQihfgCU9HnEGUwMGKYLdJNkHqETFVjOJFR99HXC5uKt2WGsPm72toePNU/AEe6Glr6MxRxHUHHWslhlUsX6D2QwWW75L1dzFOewjNgKle3v5/v6pIR3HWIu2qhOIQTnNX4XFkepftgbTiKWSxFN8VcNUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6+iWy+m; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6+iWy+m"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47ffaa8ebbdso1373772f8f.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786110475; x=1786715275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fK2s5PMQTa+UNhsFHNop1sMUdrUY1eYXUtP77GaLZC4=;
        b=O6+iWy+mh9qtjtHBpIxUEBZHWJILnm5vqHDWNpTW4nhrkuL8suaxe61hSf1y0beX5Z
         nVe2N2orn6uqIpFDLrlRxEtyi7feYLv6NMMc43mTrYSER+uu+ezuyibJ55IWINPV4Tok
         89T7AGdilcriLqQtS/KTfZh/JKSvM6utuN4tGkhZljsfbRpI7p4oDxG/YQfSJ5Hne6St
         53rJrL751Fb6CUKMI+HlJOlFtwRMAWpAwUEmA6pJfZx6tovSx75dtchABu4nVa61lBhd
         rBtyXq3U7nkH+xDCLj172EGkndk8e5nmLVclY5fquucXxEbgdw4L578ZvgIo89vGJB8S
         x2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110475; x=1786715275;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fK2s5PMQTa+UNhsFHNop1sMUdrUY1eYXUtP77GaLZC4=;
        b=p33EJVRzjx13fGPfuqPwgj9tBsm3iUMhL8Jh6nAb7lS2uD/QA0pcZ01q2maGW4ZbmR
         5uzhIxeGPtIP15TJG0UDF7DDCRoUxC8HXirx90OpbzJZ8hdPA083j0PDOxSvOkLdSmDX
         6qvk6yiGEj59esPdjY8noxzDpJCNGwaXueBeTYtlfDMLqUVPUfms68lkYJqLP07R1UHV
         kfdhotHyVo0ibCCBEwbd1F3wPqoSWyN+atq08+f3rHZtqUaQyEd9+Rej87Rk7MUd4PqF
         eHIy6UHMFhJ+8pIscLdjLTJqj7ZUvN2O1h03ogfIogkrQzwqCO+5rFWC8Ye9xzMm4izJ
         NUEg==
X-Forwarded-Encrypted: i=1; AHgh+RoLjQA3MJpPv08w2h+1VQ///QZ7byLHrTOH/mP8MXGfbFt/wpiKRStFMwQfbHz6xrRMeZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6Fb1/DCCzQggujlLD3lTMwYEPbMyWeQnGFTi5Vu/sh+Ndb4I
	oKJNSi7KLNSrCIgAAQrxQglJMeS9UR2aYt+VOeZ2FuEK7pVSVeP0ad1d
X-Gm-Gg: AR+sD11n91xSV+Nx9p4eEAzvg1rqx8BU3i2KEkvjV/HjooawQ+xELsjOrim3OxxFnNL
	VzjCuNSYJSFCwMDdeuOx2VrzG7G2xrn8t9rMW/NrjTvOZ+Izd0H3eZz5Psmkfo/1G/XAVCSFpIz
	q5BfNdB5XAEs9lrpk8zmYJ4ET9DpF7V4S59RajeoCDv+owFUQ0ipvGk4jZL/+nMzyoMo4Qmi6wj
	VwCYBqNABUPYA71V/so2c41zMiiMobzMgyvlX6gb5gonq4QEhYxdeDtO5aimYAg3HGxts0ef80C
	PVW9wdH1hVCE0uFiQaGtbv9WG3YobnowhrhHJUNepoEdcNfe460m4ML/jy5BZe2+43yAC2Ysb+b
	4S1udMrrfcf849tiJ32YwbVlo/M+Wf26OCwA7C4d456eN/RR/kKvlZNgSLJoZTbKD9LTKqK34uZ
	pEe9m5wKwi5xHkR6OtkYHyCD3+58c3QLw/gZ9+BfUBZszS2u2VCHfyne8CNtM9Mq92k2jkQjykq
	b5C76B6rjLUPnrU4YgpJJy1R252qPOVGm4NqLZecyM=
X-Received: by 2002:adf:f184:0:b0:47f:8fc8:af01 with SMTP id ffacd0b85a97d-47fec63302bmr28483293f8f.27.1786110475088;
        Fri, 07 Aug 2026 06:47:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220ab04sm5491874f8f.37.2026.08.07.06.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 06:47:54 -0700 (PDT)
Message-ID: <bf9384e9-3707-4d34-82bf-cfda84a17d94@gmail.com>
Date: Fri, 7 Aug 2026 14:47:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v10 3/5] history: add squash subcommand to fold a range
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunlem.org.uk>, git@vger.kernel.org,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Matt Hunter <m@lfurio.us>,
 Patrick Steinhardt <ps@pks.im>, "D . Ben Knoble" <ben.knoble@gmail.com>
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
 <cover.1785750108.git.phillip.wood@dunelm.org.uk>
 <CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
 <xmqqqzkevx62.fsf@gitster.g>
 <CAHwyqnXJLQ_naFb1RRQWS3eft0FXL7ripviSA15Zy5D6nvHGAQ@mail.gmail.com>
 <xmqq8q6ltwsb.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq8q6ltwsb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/08/2026 22:12, Junio C Hamano wrote:
> Harald Nordgren <haraldnordgren@gmail.com> writes:
> 
>> Hi Phillip and Junio!
>>
>> I admit I’m trying to expedite the process. Especially given what
>> feels like endless review cycles, and some frustration that this topic
>> was queued for ’master’ and now it feels like we’re miles away again.
>> I recognize that this mindset is not a good collaborative attitude, so
>> I’ll try to step back and re-adjust my mindset.
>>
>> I am used to a work process where moving fast is paramount, and good
>> enough is good enough in terms of code quality.

We don't have the luxury of being able to easily roll-back features that 
have been merged and are being used in the wider world so need to have a 
considered approach to designing new features.

Hardly anyone who is employed to work on git is given work time to 
review random patches that are not of direct interest to their employer, 
   the reviews are mostly from people volunteering their own time. 
Therefore comparing it to what happens inside a company where it is part 
of the job to review others code is not a realistic comparison.

>> I’m not seeing a
>> healthy code review process here — any feedback halts the process
>> completely. Should it really take months to merge a topic?

I'm not sure what you mean by "any feedback halts the process 
completely". If you spot something you want to improve, you can flag 
that on the list and still work on your patches while you're waiting for 
a review. Though, if you're frequently doing that, then it is an 
indication that you're posting patches that are not ready for review.

The communication around the code is just as important as the code 
itself and, especially in the early stages of a topic, when the design 
is being thrashed out, it is more important than the code. Sending out a 
re-roll immediately in response to every comment is not productive, as 
it leads to a multitude of different versions with small changes between 
them. It's far better to reply to any questions and comments, and allow 
others time to comment as well, so that we reach a consensus before the 
next set of patches are posted. If you're not following other topics on 
the list then it might be a good idea to start - you'll see others are 
not posting 20 revisions before their work is merged.

> When you reroll too fast without waiting for reviewers, it
> invalidates almost-done-but-yet-unpublished reviews.  If you
> repeatedly do so, it exacerbates the problem by discouraging
> reviewers from even looking at your topic, as they wonder if a
> rapid reroll will invalidate their reviews yet again.

Yes, I've definitely waited a couple of days to see if another iteration 
is going to appear before starting a review.

> If it is taking months, I suspect that half of that is due to your
> rapid rerolls, which have discouraged people from engaging, as they
> cannot make a time commitment to a bottomless time sink.  The summer
> being a relatively slow season certainly has played a role, too.

I've found these series taking more time than I'd like to review. Part 
of that is the rapid re-rolls, the other part is the very brief cover 
letters that are not very detailed or explicit with regard to what 
exactly has changed in the implementation and behavior [1] since the 
last version.

I'm going to be off the list next week, so it be a while before I look 
at these patches again. I'm hoping to see a reply to [2] when I'm back.

Thanks

Phillip

[1] For example in <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>

     * Protect branches transitively required by a surviving local
       upstream stack. Traverse upstream chains once and defer delete-set
       mutation until traversal completes.

That was actually a change in behavior from the previous version but it 
was not clear to me at all. It would have been much more helpful to 
explicitly call that out as a change in behavior and explain why the 
behavior had changed.

[2] 
https://lore.kernel.org/git/ddd0160c-7f4c-41c7-855f-58288db00050@gmail.com

