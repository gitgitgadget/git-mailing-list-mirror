Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCDC1DB13E
	for <git@vger.kernel.org>; Wed, 14 May 2025 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235599; cv=none; b=SXzA8IunSpdFqPwENwcqGLNdmoxdCNR/NvL+rOSVAWQmLljOlQXKGRrBFgn6JSDr2LDxhBQqKU0Yfo7y4dDUHuG6IDEawRwNuRUrPDP50fhlavJ0hSO1SqO8m1y95k05bPj/na8g5hssseJ4bptVwYJTgAmsIfzep+bamQa5FyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235599; c=relaxed/simple;
	bh=P5A/f1PCLIJBhyqrNm9Aowp/WAqlFa+DIextYaig53U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=am+x8pMjGWELRfzhR5o2rCotXcvN2PpSsIy3mtQzbRlr1IPWk4paAjMXUS/XIBv4WVEVkz9wDKmvubpN24kBivhq8AVu/TZb6fjcrECwMjU4uArkQNoZ7UzlTzhOnTArz19lFOJdtrFO2DPCZXBk02DJcT160ZxFeQuAiEh38ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSY/dvEy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSY/dvEy"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so79771125e9.3
        for <git@vger.kernel.org>; Wed, 14 May 2025 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747235596; x=1747840396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqy1jGtxI/31Mwn4FIyeFJ+dAtq/Cr0n2uvmZAgkYQ8=;
        b=fSY/dvEyGcjLyMKPc3LU6HD/O8cJbYLplqLyAQ3v5pcuZa5tsfc+TmWrasXxEt2rd7
         uuIOJ6o9UxnMzwewxiC5w5YwFjNVDOntW5unN7DeT/uYHX473nrwSmURSq6u/yNBuPUz
         yAJt7r1r+AQgFnzUC04VllY0SNt5uPC+CuePVE1Ey78POrb97osGyXZb1oqlmkSEpZLm
         n5ZmJf1IRtqA+g1lw+PvwfhPhHyLIHhJxfOwR/DRLfBJJK66Fdx7b/MTisXSDz+eP0WO
         ZBWWmLOTMsk+j/n+zJjE9RuLgdpU3EGpG1CVuqZn816bqjwKvSjJ3ERPVkUXzcPi9ZaQ
         ILPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747235596; x=1747840396;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqy1jGtxI/31Mwn4FIyeFJ+dAtq/Cr0n2uvmZAgkYQ8=;
        b=EXB64yXY6lkJyWkOHHaUn128SuC5fpIGtTgwkqv8fkoVuqBH7wF0s1Q4m0+r8vAUJe
         4mMgxozfkhbHTX3Tg84EWKjGPkC1QdFSbsRS8DjpwUDHx5q2zC/4mMhjwBWdQ90jD1FI
         eE4+H52B0+KMqQELmcVjYrO4lrjW8Q5RxZW6Rtp+a64ReC4sxnaNc0wy6SFHXa3iTNn5
         nBeg42bqDl///Hl/e3GOUX7qS8eTXBAMMBct0wEz2K2loqCOPGw5M8rZIhZ3AVVJCBNP
         d2xEDm8AzkmC9ZrIOdEIG57ijWud2m3XP/0qkHmwvDNdyMl+r23M/i5EqhPqMxaTJqIh
         xiMA==
X-Forwarded-Encrypted: i=1; AJvYcCWAaYrzTxKr6IsZALvAWhe7gx9lBXVW4drl50pXDbIt3Yy9nTY9ZgJ5aHeSFH6fFuChGeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMHG9C6d9TbL0SJUZ2+IZC4YT4lMqnUbdrcNLYfbYVW5WUf0ZV
	KaZtg58lIqcN4x/9tHNUciV3bFuiWOo0KKVYmDGkz8NzUbbymbDC
X-Gm-Gg: ASbGncsfkDBUAsfUCC/OhCwF9A8Izf86vdSHHX2zaDtWAxA0NC/uhTK+xeT9Ml4G8xE
	JpujU6lZbuO7BFYZ3GW/N+BnevQ6EQt2XdWyN3gKGJP3EBuvVe+doC/QjG6AxIr3lN6sBv1y3mO
	lRS/qeWKXhcmSMRUok/xxJD0is4HHenl1w2CItDulO/GYAUAvNPVwFpS2M/fY7FkXyBy2lyCFZz
	cUhtZ+AivpMwPtkXMI3zPkklwdehZTF19Gnd2mRqfWSRYWER9N6lPQ7loqD35DDTPcmXicdNXor
	GH9HZEipnRgOqcGE4Z8ndCJxbk0gGvvbeILkat7/Wbqe6hQC71GTRa5E9NABdDeBlmTl9Onzsyr
	JM2aeuOmlhnmdbly0DMq4DicFAK6vs0SHaNv1Ow==
X-Google-Smtp-Source: AGHT+IEHiIJ/w5lV1KDRLXLrFQ5J0ysb4/5I/06x8O7XMlEjwpV+KVStFpTyODPhNOlWB5BJxH4GkQ==
X-Received: by 2002:a05:600c:c059:10b0:43e:ee80:c233 with SMTP id 5b1f17b1804b1-442f21798c7mr19958465e9.32.1747235595637;
        Wed, 14 May 2025 08:13:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f33690a1sm35220805e9.3.2025.05.14.08.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 08:13:15 -0700 (PDT)
Message-ID: <d878fe4d-163d-415d-846f-f5541cacb22a@gmail.com>
Date: Wed, 14 May 2025 16:13:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] add-patch: respect diff.context configuration
To: Junio C Hamano <gitster@pobox.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
 <f16d3de86110ee61599459a25764248b52883b52.1746884789.git.gitgitgadget@gmail.com>
 <f00cdfa1-343a-4fa0-bce5-e06d1ed62c22@gmail.com> <xmqqzffgh5rf.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqzffgh5rf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2025 16:47, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 10/05/2025 14:46, Leon Michalak via GitGitGadget wrote:
>>
>>> @@ -78,6 +82,19 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>>>    	repo_config_get_string(r, "diff.algorithm",
>>>    			       &s->interactive_diff_algorithm);
>>>    +	if (!repo_config_get_int(r, "diff.context", &context)) {
>>> +		if (context < 0)
>>> +			die(_("%s cannot be negative"), "diff.context");
>>> +		else
>>> +			s->context = context;
>>> +	};
>>> +	if (!repo_config_get_int(r, "diff.interHunkContext", &interhunkcontext)) {
>>> +		if (interhunkcontext < 0)
>>> +			die(_("%s cannot be negative"), "diff.interHunkContext");
>>> +		else
>>> +			s->interhunkcontext = interhunkcontext;
>>> +	};
>>
>> Thanks for changing this. This iteration of the code changes looks good
> 
> Lose the ';' (semicolon) after closing {brace}s.
> This is C; you do not need an empty statement after a {block}.

Oh well spotted, I'd missed that

Thanks

Phillip
