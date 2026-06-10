Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE453B14B1
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083449; cv=none; b=hvQog8ARUH013ZpglWV4gxWnOGf9+3JWwoPPcWLFAmXBMWkZfMlpNerofqdNRcG01MzaURyT7A8Ftl/El5qwYRaJHYfTeZM6rQ/lET6B9Lji6TJrYNssHatpk00G8zWYELZs1Y1wblEyLHaBe0u9MvfrTRDBqIQBcbRikTxipkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083449; c=relaxed/simple;
	bh=UtF4qJuuhPC1OYfncZ5TwF7+blBAu6wcX8b7o2BeLCE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k5MOXBQJGDkd95OrewfVfigCcymn/hfJkeOXlQ/F1GTds0dSZcAZ4rBf3kUwGp772m2Cp/3OMPThGNHwvvN7mwpuV3nzBHJCrp9bo92MX1O97aHW4oHeJplFIK8U86T1+kO/KCBWgyCNYixHwPJ5BqSoEbgWffEhrcgkw8Ho2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyiCprOS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyiCprOS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so44364955e9.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781083446; x=1781688246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/O1EYGPs9o5EttXUoxrH02HR7eRu7hW/tlrWq2K0s0=;
        b=eyiCprOSWoMw68jSHzr+baVcz2C7ncVLaQL+TFnEs0r0uY9z8UsKnCGohOqSAMJNBg
         Yj5qJFqSnldyOON/7+tAY6oJoLzc1kU5lv3zc6/Gc4fpt+7KcUdQ1sQRn1rguBKt/Bxb
         wjidYyFqEkbK/0teJV17KXgSEEmFH0hcovO4VmE60XC00ygZr2j2zsdMb5b0kTBEtRlC
         MEtcnvvYLWUdZ7vf2S44nBONQ/czMUiJp/3ixoT1UVapQNmvWCnXJ6TKl9/5tJjwnw58
         QHivm5cFM/GGxHvomFzcnrivt5Zk3S0dtw8jOIUEgyUu4iLnuDf+LqKjmCwjESxBGpcJ
         /jIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083446; x=1781688246;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/O1EYGPs9o5EttXUoxrH02HR7eRu7hW/tlrWq2K0s0=;
        b=ep62JibhuWdx0zJa28zQrYG5NZyzmCZ6xt4902XsXVk234lv15c5/Hdcbou0wyE0n5
         58xYl194Mi1uujK8pJNtVKw54Vynk3HAR+xYiJYUz/1i6x0gZ0Nv4aJW6CxVwsnKVT1l
         +JpyriPzI4zRiQZRI9TgkJLZovOVl7VdvW8UhEoYQ8KJ8pplMWCbfVIE8cevnjog3Yhd
         /73fVzKC4VGHJxj7dcznPaP+Vet4VArn4jV2IKizVrWLGQ7DG5lFLk+yERC2Eqs2W1hx
         R5yyTEX4y/LCA7uhl+nqeA3YHJcqnO0AywP0W7gBtyt+0Si4s0RYMAGyIel5AbUf9uWa
         CBUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+r1NT69W/96Z91/TkO0R6/jbUrMRFJftraDq1gEx91HLqvBW+KAKeu5rh+Y1+vn8+27Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHkQJtcqRErX8vhG8eB386T0B8elX52fXE4uKblANpcTqoa1NU
	H44YFUGMNyKuz2dNS8cFF19TdPkDCtjzuclYgiInesZBwH+H56iPbbaj
X-Gm-Gg: Acq92OE9wTlwHK+NeiR9qApAGxPHksuG/ocQ2q6zFEShZwwYNZcE0wNcpMSDNvDV9gG
	SXueJRZpcXkPatBkkPE49el7423UVrAey09PDjOXVlnZxU+KC5ZumwC0wLcvCTXqMWIWOEFqdLL
	Np/NKcG72Km5GYjnZptLWZgfi1sxfShYgCgeUo/a+ib6XTC7XV70GeRqEyQEGI9Z7m5Wt5J7ayA
	cqftK05fPfSRdFaM4FrDuWjzPwDvU8Qdk1dJvFYFXqnHfLNx59lXZA4Tp8LWLqJACAUr83SeqPU
	Wr7hRhxYAwyhxg6SUHYg17SqEItKneEe3j2vSQWiS4nhq4AyLvCm+/oeInYe3mmS8K1ef8usVdM
	BcED3wiCVPw7Vgl9Wq33cvqii71WGje/30A7OMT0W85fRLqLNy2uXzJolYo6ktYYEvHpMRJ0iXs
	uNLYHdW5jXTJUahpBlcSnrRtWHtYXoxTOZzK3i19fUQqRRihGUfmbj+031xOsEKd5D5L0fOlGXK
	77Feqz0RbhyXxaw
X-Received: by 2002:a05:600c:46d2:b0:490:b645:3213 with SMTP id 5b1f17b1804b1-490c25f17ecmr409608045e9.19.1781083446233;
        Wed, 10 Jun 2026 02:24:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b82sm580690445e9.1.2026.06.10.02.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 02:24:05 -0700 (PDT)
Message-ID: <56beb82a-9d6b-45d9-b795-c66e945c03db@gmail.com>
Date: Wed, 10 Jun 2026 10:24:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
To: Junio C Hamano <gitster@pobox.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org,
 cat@malon.dev, ps@pks.im, kaartic.sivaraam@gmail.com, ben.knoble@gmail.com
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
 <20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
 <54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com> <xmqq4ijbsn2m.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq4ijbsn2m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/06/2026 17:20, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Hi Pablo
>>
>> On 09/06/2026 11:42, Pablo Sabater wrote:
>>>    static int commit_tree_ext(struct repository *repo,
>>> @@ -135,6 +136,13 @@ static int commit_tree_ext(struct repository *repo,
>>>    					  original_body, action, &commit_message);
>>>    		if (ret < 0)
>>>    			goto out;
>>> +
>>> +		if (flags & COMMIT_TREE_ABORT_ON_SAME_MESSAGE &&
>>> +		    !strcmp(original_body, commit_message.buf)) {
>>> +			fprintf(stderr, _("Message unchanged, aborting reword.\n"));
>>> +			ret = 1;
>>> +			goto out;
>>> +		}
>>
>> I wonder if we should check that the committer identity is unchanged as
>> well in case anyone is using this to fix commits after committing with
>> the wrong identity.
>>
>> Aborting when the message and committer identity are unchanged seems
>> like a good idea.
> 
> I am not sure why it would be a good idea.  The user wanted to make
> the commit have this message, and the commit ended up having the
> same message as the user gave.  That message may have been identical
> to what the commit originally had, or it may be different.  Why is
> the former an abort-worthy event?  A simple note, I may understand,
> but aborting with an error message?

What I really meant was skipping rewriting history makes sense, I don't 
have a strong opinion on the exit code. My feeling is that some kind of 
message saying we haven't rewritten anything probably a good idea.

Thanks

Phillip

