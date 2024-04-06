Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865A2B9CE
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712411434; cv=none; b=ar+Zm2kmHBPpNO6sJnGWK1plf46Y6EryTxtbvfC+kUH2HlFTvzdMCA0oDRlO4nA0RioiNLNzu2I0FuRDzqmKvzHb4InOQrFSnh900cfPlJQeetp6i+MUpy2mKjCvjRwnKxufrGdCUon+q06h/xHtq2CK8KNLZAw4pUwdhmYLFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712411434; c=relaxed/simple;
	bh=D2galtqDW7HV4fusnE4NrlSvtiSpo6kNgZ7x+bLgcto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jvg+w+J/DXPx1a965/tTjP/m7AOqCOijPFacqAb9pLJ7rudlcGWwHC3dBz+WXchhvAbGAKlA0cGBrqNdl2rEy0u2KTNcnNTIxWM52VroLtTd7f/5es63P6rz0lVlakGs0WmJ8HQm89/ZRnNwSE9TxsfFLul8R0EaM252y/bHO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN/AW3+u; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN/AW3+u"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4164a19ce5bso312405e9.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712411431; x=1713016231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xRy60zzddHiP3T+Y9QtGWrQ+OAdHDd/2dft4aLVDmZs=;
        b=IN/AW3+u88I40wvXwyTimnNYl5Uc9b5MeOzZGgDnyG9aXQsPqq5Z+J44FGD47IkJir
         QOl5TCQ1mydY+QqP3xXV933bsGZYmsM4fIbvC6BQj8NmbaqFUBzUdiXvimpYtV3HaChK
         vPqvWXFhF03enSaZ2qmuHvpnQYm4WmVlgcuX4AeaUS0q1/zjc65OoTJA/BVaw2cxoXfM
         q/J5Gy85FNvhOe4iOKvVrvi2Fg1xrALva7vqS9g6nswd1pvrpPaF0ha3KTetYRZdZsE8
         n/FzXEooYwQ5Iey1de+ry46qoNpY+a+7YgrlfPmGlRLePg+ByL4fEf3LLRwMpIJeqTTu
         7B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712411431; x=1713016231;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRy60zzddHiP3T+Y9QtGWrQ+OAdHDd/2dft4aLVDmZs=;
        b=smxaQvSMHqV9TEgQp66zRGwRmTP1bfT0fLRNzidjc1V2Ybvc20UZorzLnUrIO/UDqa
         YQpuQtTgSld+SBTKEmetldOHL6n/TVJ1NX+Xo4ye4PF2DFJo7kOsn0mvFfo3P0krqQX2
         UbZzDdz0olAdkeg5u6liSi3SPT+c73WRYDcecXjSDHK56ciNDMKRqJ1LrvAEHn4v8OTU
         VO8nP6VtOkp2ycJZobmg9JQhZqr9/1+2kJNcz4+a8R/8q7/o2AgK0dMFBAfDpL+UosaK
         o4LaP9PqlrH6egUAZxJIERdDl/DwMlY/6cqW8cu1s0EnhDhwCsL6dmy5mEeTW5cGUFqg
         7e/Q==
X-Gm-Message-State: AOJu0YwLVLWjLZQOJ24BTp7IJ99WrOWiiHGv9I8uKfjZ0W8lazFkE3kk
	+yHklWo24M8XHO0iNPdBzZvFLhGY5iNSMpnsVgZS4zI2t8+kawcB
X-Google-Smtp-Source: AGHT+IExSCsfQn66fe0us0IeYzeMvV2BmnaKuj1e4Exo3UsjzmxKC/ni4TUW9VjVdNwsu8Oe55k9hA==
X-Received: by 2002:a05:600c:3582:b0:414:c1b:4bbc with SMTP id p2-20020a05600c358200b004140c1b4bbcmr3429351wmq.6.1712411430568;
        Sat, 06 Apr 2024 06:50:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id o32-20020a05600c512000b004163321790esm3855986wms.19.2024.04.06.06.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 06:50:30 -0700 (PDT)
Message-ID: <4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
Date: Sat, 6 Apr 2024 14:50:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: Olliver Schinagl <oliver@schinagl.nl>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
 <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
 <xmqqcyr3s3gj.fsf@gitster.g>
 <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Olliver

On 06/04/2024 11:06, Olliver Schinagl wrote:
> On 06-04-2024 03:08, Junio C Hamano wrote:
>> Olliver Schinagl <oliver@schinagl.nl> writes:
>>
>>> Hey all,
>>>
>>> I've also got my work on a branch in my repo, if that helps to look at
>>> things, https://gitlab.com/olliver/git/-/tree/skip_bisect
>>>
>>> Also included is a script to be used as an example. I opted to use
>>> `git show`, which is nice because it works both on commits, but also
>>> on notes.
>>>
>>> Anyway, any thoughts on the bellow before I send the full series?
>>>
>>> Olliver
>>
>> I would not write get_skip_when() before studying the same file to
>> see if there already is a helper to read the whole file used in the
>> vicinity (like strbuf_read_file(), perhaps).
> 
> Fair enough. I'm a little worried about optimization vs readability. I 
> think it makes it mre clear what the code does in its current form; but 
> I'll investigate. Bisecting shouldn't be a computational often happening 
> thing, so I'm not to worried about performance. But I'm not too familiar 
> with the git code base, so I don't know either :p

If you search builtin/bisect.c you'll see some existing callers of 
strbuf_read_file() that read other files like BISECT_START. Those 
callers should give you an idea of how to use it.

>>
>> I do not have enough concentration to follow changes to
>> bisect_auto_next() is reasonable.  Especially I do not know why
>> "bisect-skip_when" wants to exist and what it is trying to do,
>> besides the fact that its name looks horrible ;-).
>>
> naming things, sure. I can look into this absolutly :)

For me it's not just the name but the whole hook thing - do we really 
need that rather than just the command line option?

The other thing I wondered about is the exit code handling for the 
"--skip-when" script. In Junio's example in an earlier message he used a 
successful exit to mean "skip this commit" and an unsuccessful exit to 
mean "test this commit". To me that matches the name of the option - we 
skip when the script given to "--skip-when" is successful. Copying the 
mechanism used by "git bisect run" seems a bit cumbersome as we only 
need to know whether to skip or not, we don't need a special way of 
distinguishing "skip this commit" from "this commit is good" and "this 
commit is bad"

Best Wishes

Phillip

> But in short, bisect_auto_next was returning just after checkout It 
> seemed. So after checkout, running the script seemed sensible. But I 
> look at it as a normal git user. So you checkout, test your commit, skip 
> to the next one if applicable.
> 
> 
> I'll think of your two comments, and see if I can address them as you 
> regain your concentration :p
> 
> But seeing that these are your main concerns, I'm more confident I'm not 
> completly on the wrong path here.
> 
> Olliver
> 
