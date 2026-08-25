Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816A3A5456
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648908; cv=none; b=rMl02XAZ3Kmiv+cmsiaMuYXCBuumkQyfumsxyNixARULVGiOu3a1BHQY1YuO0OvoYVVgTNUwzfP0v05BmXDMGY+V92oyLryEdnmcmd/cDD3MtYzMfp3TrIorANQB+sC6/e/4+0jqn7oHDowaA2yr++4lBj7J746TIHVccBzNrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648908; c=relaxed/simple;
	bh=Wos9Tss1D5uP7iLsV9HHHp7wwoH6jTO7nk8v0/6LKkM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qZuBILrkbTC4Gt2YZtLuIHjeejeOlrKnrqNPCJiZKpruOTO7pL3mdZoDqLQxR9CTR/4YHidvVwCsGrX5OHV4ukDxyANYOWwVVC0F5lNbwx31HaSd+rZTcMViM2EQvTbFg6LyMQQ0RXBE80zh6I6FwiGTLkrd1EBZ5XLwxcfOJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3EK+GT8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3EK+GT8"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1938815f8f.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 02:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787648905; x=1788253705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ss+04u/df5PpvVfUCtVALmb2MJyOdBEJ3l7q1LL9Lo=;
        b=I3EK+GT8IKIUaR0H89uRQneVNN6ObhlPhH9S1H9oLElt6qiuQdDDgbNsH9OrXvdrYz
         8VZCZZAQpiMSiSoKrW7QURxxQBQEVzBY9okkup2mcyJV62DHq5E0Px3YXOQ8Xd5M61UD
         kMbiCFqaSC2QJPJfC0Euk2l5oXLO8zrJFtjGvv/U2Q6HLwqB/KfHyIYCho00tU96hluk
         xzB/3QgvO3/FIH1XBVaX/LIUqDy313h2CxaERkB2Eaj3nxdr2uN15QqM/+xBFJJ8nid2
         7IuBLJryVjyZoO2VXjoQuk+pIfctd685hrj2FjVN0o5Zh6l6ysBCNBkX0amlgVa/Gzry
         f1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648905; x=1788253705;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ss+04u/df5PpvVfUCtVALmb2MJyOdBEJ3l7q1LL9Lo=;
        b=fB0c+JIWT+5Lcol2b8CHP1amXHU6rbdtscjQilW4ZjUj4uXHW0rCXfAwqU+DsajmkE
         JcIrBtg9FHuI3oH9FMJtUmQ8vAihtEGVVclFpMq5z3fFGpRn/80mJX4DpLar2pmcYLSr
         xUODsJq4em32HLog3fZAwsBbXYKQe3PaUt2lgC52hu1a1toGxtn45OL4/Mtl/LhUXzCT
         PBzxSbSa6hjNsbCblpJYHiohkYkz/ASvWl7rnDJHTobmKdAmPBU8/Rv6etm+LXWqRqcm
         T0+QMwUOjoIzMpcldyN0ApkPwXvTrUsOaaFJK1fCZMplK0G/OTWkBz+1R107boDDZUSN
         W/FQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrZZp6/N0qtQwT5V60A+RITpd1C8FEHnNELCfWQk8Y5bQ6FXPta+nNFkaE+J/yvzrRJ/o=@vger.kernel.org
X-Gm-Message-State: AFuF++kSvSpL7cegq/necy5aDwBm5oiNPzCi5sqp3K8EYiIJyh0/J68S
	wWFmYzxU+p1HFLSkOf5JyY3DMNL0AGKEejHk8ppvzHjr2tstkyOaTuw/
X-Gm-Gg: AR+sD13NY543g58xekY9wplguhsdYf3TPvgKImAk8smejfzjDe8Kj3jBEC+zUVgwdNl
	/vt8a41PxjY8YjO+GPgexl/iUJ95tJ2OfDoVRKoVkLf9hIXpEtJmvGSulhgCbNPf3UcapSAk9qF
	Zb2tGcRBm9shTM0ZHou4T3yW3zTNJmDZPKp9NIh/a8wn5v3V7qywQMErHIw3XyhKBPsK42iPGsc
	9vAD3X+SPE5SICp1UBgkiopaRUccjBF6kO5BytItteaE557QmX3uGE/yoCkP0L4DhdfaiTX1haB
	jx71OLdX6VoH6uufDSTEKnnbVGsKQvk0UwO8l3DWfvHVXJpXjhTgQrlqM5n8QRsNs8YW8Wnk6f4
	frZ9zzz871h+KfgyLRi6WRShi3QZXPcmLNC/pc3BrIc3/97tCRHIp8P0LeACerQqMtJ4qUD0gFP
	M0f5AeN7F6XkhWzYqA1mDZKfErveQMlY4kjgiLXn8V90w4QS1hYBA5SBFbaTEbKBJLNeJcSjW2S
	MgFuHLE9Ogc/M6DpSdJRcUmSHOJ4V6I9N+2E8yJZBw=
X-Received: by 2002:a05:6000:4543:b0:482:c5ee:c7a9 with SMTP id ffacd0b85a97d-482c5eece65mr28165553f8f.17.1787648905510;
        Tue, 25 Aug 2026 02:08:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482dd853b8fsm888918f8f.8.2026.08.25.02.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 02:08:24 -0700 (PDT)
Message-ID: <39664e65-6997-40d4-83d4-1d2cae27ac50@gmail.com>
Date: Tue, 25 Aug 2026 10:08:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v14 7/8] history: create squashed commits without editing
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Matt Hunter <m@lfurio.us>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Tuomas Ahola <taahol@utu.fi>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
 <pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
 <03528d3b34c202b990cc42865a009a5786255b7c.1787249432.git.gitgitgadget@gmail.com>
 <xmqq4igov9h9.fsf@gitster.g> <29ada18c-b849-4bc3-aad3-b4fdc09c81f9@gmail.com>
 <xmqqbjarsgjd.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqbjarsgjd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/08/2026 16:07, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 20/08/2026 21:10, Junio C Hamano wrote:
>>> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> +	/*
>>>> +	 * Allow "fixup! <hex object id>", but not "fixup! HEAD^" or
>>>> +	 * "fixup! main". If the target is not being squshed check the subject
>>>> +	 * to allow "fixup! abc123" and "fixup! <subject of abc123>" to be
>>>> +	 * squashed together.
>>>> +	 */
>>>> +	target = lookup_commit_reference_by_name(s);
>>>> +	if (target && istarts_with(oid_to_hex(&target->object.oid), s)) {
>>>
>>> Why istarts_with()?  "fixup! ABCdef" should not be accepted, should it?
>>
>> I agree there isn't really a compelling case for mixed case oids, but
>> accepting all uppercase, or all lowercase seems reasonable, or are we
> 
> Tell that to brian who wrote the bc/restrict-hex-to-lowercase topic
> in <20260729233215.398654-7-sandals@crustytoothpaste.net>.
> >> planning to completely ban uppercase oids as brain has suggested? The
>> aim here is to accept any oid that rebase would, but not accept ref names.
> 
> I understand that we never emitted hexadecimal containing uppercase
> letters ourselves, so 'commit --fixup' and friends wouldn't have
> added anything that requires istarts_with().  So accepting any oid
> that we would have given the users after "fixup!" but not refnames
> can be achieved by starts_with() just fine, no?

If they're using "git commit --fixup" then yes. If we're going to reject 
uppercase hex everywhere then clearly we should be using starts_with() 
here, but if we keep accepting uppercase hex elsewhere why should we 
reject it here?

Thanks

Phillip

