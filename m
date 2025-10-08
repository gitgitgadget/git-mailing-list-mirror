Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F132874F6
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931482; cv=none; b=s+dGvitowth8EVfgteV384DWIFVlyPuFzDR7Yq4tPCXbQ/ODsnQvra6tD76GnTMrTpFaVQtHPJWhkc9C0crx5q1Na+xOQpPPGgseX1Xlpr/wCmA6nEc27m+pDfXMhMnDGYeYNoO6DGsf2UHAGLx952gFPryIfEH9z6WMP8RaZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931482; c=relaxed/simple;
	bh=MYwjgiuf6BBkFzG2kHWMdlByhvYlyC6InTjQnxsojJw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QddJlMoKLKjEyjMBpkyOOtfF3wiByMOQiy9k62Js/SSiAdMF5HzFW3wjrqSr+e1XMvrDRzHFXw6H/O8gl7VGWwGTr235QOT5uYyWVdV19ylFCgVPoK9mM//bPsOHp3X/YBzDqFa7kYdERgphnSrsEHJrM964CDLT9vsNATFPx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFsNBAdw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFsNBAdw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so57924965e9.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759931479; x=1760536279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6sb0n5PAsWHJsLCjeZjnhUid/g6nl4DbJRbaWZ0ik0=;
        b=gFsNBAdw79RzMo8AS+HCFv2gdDi+xUnp2zKDFUP+PWiQ77e1fTkYOtsNYv2uVEKg6W
         rWhEf/04V4HBBAtnSXTG9piYSFKsvBbX5FFzA5Irsqq1w6VPQMwyiFv3Y1cKDl5ZAc6l
         R4T3pQhnBRYz11TCTDHQZWHHHmCmgdTM1eVKzTbQdIDOBi2SVmuGMd87iO98o2moaH7M
         1lJMY5QckLgI3hzRqhq8Tl43QBn+6lLS4Dn7iIOj43g6atkBCntU7sBdzZcwENeQHLsJ
         nLUq885626Ri1Fa909t+yynAXI+93zDVXzGvPxt3QB1ISFt/eYi7+TE+iFaCRfKI75Lt
         /GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759931479; x=1760536279;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6sb0n5PAsWHJsLCjeZjnhUid/g6nl4DbJRbaWZ0ik0=;
        b=eXsm7xh07WaBzD9OHs2zpZLg4BIOgjOlfQtOjXKGUOFGEATq77iB6DZszaobP1Zo3U
         9d2XnSFOTpAGxaVR1kGLxRvq3/BteUXGJBPbKLY9sfJICjXk6AVTmE4SpfNtiv8BPUfE
         DjutRqIMBuQe8FxrHHeHuhmW3BgFsUo3uk9AbAi8hrv/kaAMTMwQdzO8WXSP/Glqnq4C
         9uyRbOkBn9gThY49U0cjjACzur/6XJEpG+O/J8iQjLg8BsvZlGw1evMs85+JBO+P8jc3
         QkgWnX1HXxWLXqNMoCn/FMoAkI8pJ/RNeMJZ5rx2FaONfbBCd7fWyMSW7Y9tkXfkQidA
         9O3g==
X-Forwarded-Encrypted: i=1; AJvYcCUOY24fr9wUpSIqyykLCxLkPoAjwPeW29Zah2FBXVZzB5UJwROXSAFCiRKfVZRKYU6JyCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0AuvHZ/DdlSmAIxPYEy3GUDRKcxzw2NDDKe7kwse+KuuDB2R
	Y/j5OV3AvZhIeXgCgM6ozeylxr2MMScof5lC1FlZkS7n+uucl0Jord7K
X-Gm-Gg: ASbGncvO+naJR8c4K/RABqj5fTZkdH0cXCqktAMO2SsshUD+uEvuVPv6pkvZtMa4l3D
	D/SaLO6GwlXoTMjbV5R35Hq4Ua6Va0CS2E3EDbvfw+cIC2U2SzWuNKPeQnJAu4UOVA383PqC4Kh
	Ii4Hbx/XIfEV/qfdrsPF7CesRXovYWLDco4Kkt2MbVTvsEE8cYbtk0GFHjsubZSlQw88GDhYa7+
	/dd/bQ+Be194BLCh+qiWqCncj/+CRJMt5s0hYN+tOP6OTIiQ3R9/yeSGIt1cB9I108wfgJ1ehxr
	XB1mcFG16tW79M9U6biv+KiKkpvGGTgrzvEv3E+zdSBQSYnj6s+DyKKGGiNMJOtP9yucwAp/X1j
	iOYWv+Ebuj2ZuiLUdk6QoWEnQWN/0DKd1MlsenKr158RcvkISwVXHU4JJmTPF360qkOod/aby8X
	dTW9i5OG5fVwJNX9364gVBBEM=
X-Google-Smtp-Source: AGHT+IGwUE65caCqaQSh9NNZHYkbpbBWaDT10aZ7fSIO19GJf8hbXg8lwXpm5CS02797SDBBmZxsCw==
X-Received: by 2002:a05:600c:3f1b:b0:46e:1a14:a81b with SMTP id 5b1f17b1804b1-46fa9b17e09mr22730115e9.36.1759931479019;
        Wed, 08 Oct 2025 06:51:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf8295sm39047395e9.3.2025.10.08.06.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:51:18 -0700 (PDT)
Message-ID: <d7ac0aab-9363-44b3-8ced-28d1693fd85c@gmail.com>
Date: Wed, 8 Oct 2025 14:51:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] add -p: mark split hunks as undecided
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
 <pull.1863.v3.git.1758813038.gitgitgadget@gmail.com>
 <4935dde39933744ecd957d84d3b71287fc274074.1758813038.git.gitgitgadget@gmail.com>
 <xmqq348agzpk.fsf@gitster.g> <58689c52-d692-4a5f-8d55-478325bbd39e@gmail.com>
 <xmqqseg9azdc.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqseg9azdc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/09/2025 18:37, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 25/09/2025 19:21, Junio C Hamano wrote:
>>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> So I like the updated behaviour very much, but I am reluctant to
>>> pretend as if we are siding one camps of folks who think that
>>> splitting a selected hunk is done with an intention to deselect most
>>> of the minihunks most of the time, playing favors.  I think that
>>> is a wrong way to frame the problem this patch solved.
>>> In any case, I no longer have problems with the updated behaviour
>>> with these two patches.  Thanks for working on them.
>>> Will queue.
>>
>> Thanks, do you want a different commit message or are you happy to
>> take them as-is?
> 
> Hmph, what would an improved commit log message would say?  Reword
> the second UI problem above and explain how this change improves the
> situation?

Yes. Having said that I'm about to go off the list until the middle of 
the week after next so maybe we should settle for what we've got.

Thanks

Phillip
