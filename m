Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019A1F3BBB
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727113; cv=none; b=XLdfhwUzfgU9/22b9krnXi2hdptgGJmMc1CF/G3J05aq4qZVTLB/9XXTP0o5qCJIsxErzsFj2XkF8tcqzvrm4FculRyIDN3BsqWIilprrOEcm7UUMb0DRCoiguL2rGnq6z4nlGToSyd+Y3HGVB8WNcJOkBgT51bq9lgt5gugSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727113; c=relaxed/simple;
	bh=O7LjbiHuS/jhMidGJmhg/9pbdVdBl+Em9iaJ7TfIjeA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uuo+ONc4PxPVgZZwHMVZ3Aj7snQmOwedx9JU10L9cSxUOyVjvB5zruU5Wc/H3XgKjyVj7bgxZ7T+IzxojNN52zojV0MosbeAXqt0Yzxx9CGPKW2oCzZGPtdNNlgGbSqXl8BHlf0iM0sEFlDAHpqc2QmtcAKjeMpaYBXPdtIQng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBjf0yRF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBjf0yRF"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e1cf9fbe6so23663755e9.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758727110; x=1759331910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbGqJPrYGp57EbsgPfUH6FrLn0Mw7zk/O+R/fDyttCs=;
        b=XBjf0yRFIU0Fv68H9R6t8QGpfxVdGDqs+HhqeJ3qJHFEEcz0YPeTk/y3L4LlEPpQpi
         wRoawtSuPC5feR8Dr2AmPane3e4zl8eUZHGTsO3vcKHhqIHi9IuWZ4H03P+Finur2WCy
         +2B6QZU70rnmMxPEMUbi1m7+p/evL2pHu5qIcid+wco4UyCgxgEBKpThx8kASUMnRUXw
         w4uet46KVx6vuu0yfJqk/BC+TrmH4NrEWBzILOHwPiOukUscItcBpr5ja5kBeSQMHSYl
         76AP58LieQh4oziVfl+6hlJL6AqZDjSvEiftjxWFpdQ8DAfT3PKITc4NNZzIa8xln+74
         z2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727110; x=1759331910;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbGqJPrYGp57EbsgPfUH6FrLn0Mw7zk/O+R/fDyttCs=;
        b=xSB6ZmphExswISr4LKxQGjOxE1DCVEk2M8XRJq+Wvau38Zq0GYoLdw6XQ0SNXlCV5r
         YiiFr/Bk1xAju4Ny+B7IqJhB4Z4YcBgmv0jgNuZBOZ3wTuuukYsz0pRggMVGWgOHh/wm
         h0pLf1ylk6S2LMFy+DBWvzkpKJpIWzfQJvSxSEpGFHhPO4lyaHu4X+lteL5iR3DvHRN6
         ldCuIQG8Pg9UpV3kzZ6W7811t9f9kB5WYEqKmiLQXRO8RUnUMWW1Qc7mcBBR3Qwbc97N
         Ecyzj+1R/IVV8ckbkBId+iZmZP0Me9b07RcyoKkO60B0rYfxfT9Uc/5oM6qNOaOwlbXC
         I+dg==
X-Forwarded-Encrypted: i=1; AJvYcCVjNT+iCgR6MIadbh9J2CFQ3X65NN5dLKF4+qsqycr6SfZIAt7gprLLB+fNMlm3TiNP/iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCoYmwZPdithFeK2nn9Ax1bs/o1whbMpZiq3wNElATCgxwYaTy
	Payt9sSz+uk7zO5HLSZ21d0iJ9kG3ERj/nwAHRCdyBBe6me5cDF3F63A
X-Gm-Gg: ASbGncuAiI8R2K5zpZT5XLo7MJ6R5iEFQoDT43qvEOIdEzgbssDN3xkw+4WNrxWg9pv
	4frhl4+h5maq0wmjPcYaBvneMyFM4xIaif458UlTydMhZAJ5ZPjm6ofTZmAfvyfr4lrQQ9A6LB7
	AjYdOOKszhO/NooGJp2Vd4f8HkNbz+EmKrRifNNSqO5rPtKyGTC1GLVFltb0dHyexzPUCkZXRZY
	85trElDNhqs5UzNq4pRQJDNu2/vmSmz7Vl/H8U9YPdcrGJRx12DM5THYEm/QGay5SEvX/SKE8wI
	FiaSGk+H6pPUKSJpAqQW/mszzmq5LPkGp6qM4nmeqN4lVtwD7EjHxGBVpe4/ldWm0xjzXBhb0ar
	OFWnNz9mrRuudRA1t67kKvPcOkhZ1CkXmU8NeKXnW6lAbd0tua4Y13UdDuV5yQk7j7d/q7J8vE+
	c=
X-Google-Smtp-Source: AGHT+IFqXKyPbET03AeUoA0cjXbTLBTre8T8l2A4m2vcmQJ5gA6hJa6oCs9fOc2yYJ04btklJnvFOA==
X-Received: by 2002:a05:600c:444d:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-46e3299a5b5mr2503055e9.3.1758727109580;
        Wed, 24 Sep 2025 08:18:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32bf63cesm51495e9.5.2025.09.24.08.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:18:29 -0700 (PDT)
Message-ID: <1c3461c3-09bb-404d-a4dc-a895baba68f2@gmail.com>
Date: Wed, 24 Sep 2025 16:18:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 12/13] xdiff: use enum macros NONE(0), SOME(1),
 TOO_MANY(2) in xprepare.c
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
 <08a0fceb72b2bd0a2803d24b9874b7f9bd03703a.1758662670.git.gitgitgadget@gmail.com>
 <311f7dbe-b970-4a5b-9d53-05f019cc54cd@gmail.com>
 <CAH=ZcbBcEbTqQ-FpYSdr_QjSM5sKerECKsSVdTyHoSQqG-V9iA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=ZcbBcEbTqQ-FpYSdr_QjSM5sKerECKsSVdTyHoSQqG-V9iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/09/2025 15:46, Ezekiel Newren wrote:
> On Wed, Sep 24, 2025 at 4:21 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
>>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>>
>>> Rename dis1, dis2 to matches1, matches2.
>>>
>>> Define macros NONE(0), SOME(1), TOO_MANY(2) as the enum values for
>>> matches1 and matches2. These states will influence whether changed[i]
>>> is set to 1 or kept as 0.
>>
>> This message also says what is being changed rather than why it is being
>> changed. I think the rename here is a good idea but I'm not sure what
>> "rdis[01]" and "rpdis[01]" are used for and whether they should be
>> renamed if we're renaming "dis[01]"
> 
> "Rename dis1, dis2 to matches1, matches2 to give the variable names a
> more obvious meaning."
>
> Would something like that work, or do I need to refine it further?

I'd maybe add a sentence before that to explain that "dis1 and dis2 are 
used to record if a line has zero, one or many matches on the other side 
of the diff". I don't think any of these patches need huge commit 
messages but a couple of sentences explaining the reasoning would be 
helpful for anyone looking at them it the future.

> I
> would love to rename rdis, rpdis, etc... except that I don't
> understand what is happening or why. Could someone explain the purpose
> of these variables?

Good question, I'm not sure anyone has an intimate knowledge of this 
code. My understanding is that the code aims to remove runs of common 
lines when they occur between unique lines in order to reduce the number 
of lines we need to look at when we're calculating the diff. I haven't 
worked through the code in detail though.

>>>        /*
>>> -      * Limits the window the is examined during the similar-lines
>>> -      * scan. The loops below stops when dis[i - r] == 1 (line that
>>> +      * Limits the window that is examined during the similar-lines
>>> +      * scan. The loops below stops when matches[i - r] == SOME (line that
>>
>> Thanks for updating the comments. Not reflowing the lines makes the diff
>> easier to read but leaves the comments in a rather strange state with
>> random long lines.
> 
> What is the reflow limit for comments? 72? 80?

For code it's 80 columns with a little leaway if that makes things 
clearer. For comments I'd match whatever it is using at the moment.

>>
>>> +     bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
>>
>> Nice use of bool, strictly speaking I don't think we need the !! if
>> we're changing the type from int. I think Junio recently suggested that
>> we might start using (bool) instead of !! for cases like this.
>>
>> Everything below this looks good, though some of the lines are getting
>> quite long with the renamed variables and symbolic values so we might
>> want to break them.
> 
> I didn't add !! and thought it looked funny myself. I didn't remove it
> because I wasn't sure if I should.

Our coding guidelines say not to use "!!x" (I assume we're supposed to 
do "x != 0" instead) but in practice it's pretty common to see it in our 
codebase. I'd maybe try a (bool) cast and see what people say.

Thanks for cleaning up the xdiff code, it is much appreciated

Phillip

