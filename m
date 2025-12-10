Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652B84039
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765376050; cv=none; b=pPxxJK67zQyqPV8obZVuwMS7hg9MMOgbbDQIiO/i33Pg+y4cI1DDkzIIPavwwTGS9THuzRZ3/jJjQmue1OKkLnUTilPmnO7jOwNgWL5WouMPZZzq4PM+/6Z4987JI/lBpRPxGfvFlxGnBf9cntyR21Cb548jAiHOWMpJI3DT+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765376050; c=relaxed/simple;
	bh=LMcQrpCPixlfyZEniJGPhjlCOuZQB0vQXI0kblJdzwo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GcvMwxh+ulVur9R3qY40WnP7yitow0X450kAgVXxCCryrZra++wlzk6KcZ7E8i9wd+5mYUghs5fHrRq91bBwd3XCP7f1ePcxUH7yT7joKDuF58MI8KNRfr131Txh2zEe2qaXqaqH3DB66kjR8OwvQlVHZdfgEuTye1oqWCQJXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MydbOrNk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MydbOrNk"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so53395795e9.3
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765376048; x=1765980848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0AcqXs1XyN+FjS6f4yAoYBBVzh3A8xL6ZxN3lWym1s=;
        b=MydbOrNkslJlQOa06VUoHBwbGfjrts9ZWtkF95P47FQSswkjVshLJtf2ciPaJ7uZK6
         +JPT/djDZKKBLkljU7ef7PHjsatYMdSlcrkgH0fG1OOZf+ohDRJw3jgoUUJDq12zg+tx
         bykrBHyQXnWTX9P3s+cY6bWgnr3iG21EXCiPOqPYJbVpkLUB136j2orhMiPLHl8IBhgA
         Zc04w/9DchWB2jZg/UqzA0dSTqFB84uoFORhXlYuD6+3Dhw3v1npt7nGGqNMrPbJUcIW
         BM4riZVBRezdiouUlET6tqWe9vmqheyugVPmjhVzJ4RY411NCtm0L0LrNzEjHSIKBiWn
         H1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765376048; x=1765980848;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0AcqXs1XyN+FjS6f4yAoYBBVzh3A8xL6ZxN3lWym1s=;
        b=uWCCE9IxFH/CAFp1Xm5Bl10y3yZmBvYDm/1tlZ1t2VhfSTrFhluiymSIMPHgjid9aQ
         ezjCvBRGSB9LhGYIlfvyafTm4W5OOvq6u0txnnIEXZZsO2xKMgItJZAKNKRlpzyX5kut
         9I66MNXG++UB/NcOZfqnpydswNetCpCF7tDNbsVH6wn/RMLTiseEB0AQKlV8uK8OaZSF
         TM2Ca5hWYWx+3FoGFvbuNrPxqJfrBOHPVbPGKxHcg6aLIctqYpM4r6i+MIQm80pfbcku
         4DTXPUZ4C4H0zYlkZTYXRqI0APtENHCGuvKUJt+veptnUACTL7c5oNrrk71LFVTzIrtB
         12wA==
X-Forwarded-Encrypted: i=1; AJvYcCUAPvZmjpIIYocinptrkNQntn2Ru474R2TSii8HV/VicX4uiqcRn8Q5U2ss/ZQSWlwTZT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbuLJkOEi55O0yMNLE3ZGuRquhXkUlSL5/AMrwS69ulLEYSUDa
	TQsXI4EqxeLzZwoKyX68yZg7K5+BL7A+aa5r7xk7ElSjfrcRxu+Axonv
X-Gm-Gg: ASbGncsEL1NmjZP+vC8vFElrVfrr1G2YFlaNJ9Y9y7gtwvpzr0FqLpkDiR8NynsfMRt
	pFA6bsNPxT5/jk9qr/+F8JodNQdN48fzgGQ+Vq6IPZZfp9apV7WpPbBfw+TYDIy0PadufzTWp9q
	kS2sqo8VYyEXlvj/QIigkjgdIV/D+GVCSblLCHMpzjCWJPZHeMbal4hbj27gjlU70zbCgW9gjLQ
	nlkLUmr5gzhgf18TDAhUu4XPNotY8+1OXkAuFMl2pKj12aXrHWv/zwuOcoriMItc70c93r4OdYr
	KN242+pzT7j0F/tmn4T6W05Of4aiHYFV+32qE30pA8yQ9g1xh59jY8px4mOJVeAvFNVb+/Nixp2
	fQFJtrjOyRQisA9fJK+8ixySjhxUWeXqkrMnFftpZlEfPHCeE+MHsE+nF/CtpmuFtcX3GTN4XBR
	SYDoVNqWJXNKPmnIduw0uguLT+5myNagCRj8oDqT5EdJZyoi6rWUmjLIV4/zoLcW0=
X-Google-Smtp-Source: AGHT+IHhEBe3yVgU3c19JLp2HT+VVQf02GCIu/wDyFlQXumE5y0fmBBOMUlXyWgV287+2Cqz1890Tw==
X-Received: by 2002:a05:600c:3b1b:b0:477:a3f9:fda5 with SMTP id 5b1f17b1804b1-47a8379da69mr25721305e9.9.1765376047395;
        Wed, 10 Dec 2025 06:14:07 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82d31ec4sm50419045e9.8.2025.12.10.06.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 06:14:06 -0800 (PST)
Message-ID: <12b0e7dc-4c00-4f0e-bef7-ff76f3054b71@gmail.com>
Date: Wed, 10 Dec 2025 14:14:00 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output on
 conflicts"
To: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Elijah Newren <newren@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>, Toon Claes <toon@iotcl.com>
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
 <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
 <7d0201aa-905c-4da2-932d-47666c923875@gmail.com>
 <202f7015-1e7f-493e-bd82-474e5cefdf01@app.fastmail.com>
 <xmqqzf7ri7q7.fsf@gitster.g> <74a705b5-bafe-4304-86ea-fd3873ae4fb4@gmail.com>
 <xmqq1pl2im8x.fsf@gitster.g>
 <85ce46a9-a097-462a-aa1b-904eeb7b89ad@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <85ce46a9-a097-462a-aa1b-904eeb7b89ad@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/2025 12:04, Kristoffer Haugsbakk wrote:
> On Wed, Dec 10, 2025, at 12:56, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> We do talk about "branch heads" in our documentation and they point
>>> commits. We also use "tip" when talking about the commit the branch
>>> points to so maybe something like
>>>
>>>       Update all branches whose tip is replayed
>>>
>>> though I think it would be clearer if we could say "commit" somewhere as
>>> that's what we're replaying. I find the concept of "contained branches"
>>> rather obscure.
>>
>> Thanks, I do agree that "branch head", "tip of the branch", etc. can
>> be used pretty much interchangeably, and using "commit" somwhere
>> would make it clear.
>>
>> 	Update all branches that point at commits in the replayed
>> 	<revision-range>.
>>
>> perhaps?  I dunno.
> 
> I like this. Or just
> 
>      Update all branches that point at commits in <revision-range>.

I'd be happy with either one

Thanks

Phillip

