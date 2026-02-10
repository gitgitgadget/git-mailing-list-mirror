Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E203612C1
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721053; cv=none; b=pq2LT/hhZcHZ3DHki267pWaZtRbDEOK4L6xkinb1zmIIBk1lRfEpOiZ4wkXKklTrGrEfh6TtXGp+HzltjU+X1hlAWBDp1wPuDftbrny5RVUEVuhjBRHXNGGZEYLZ6Al5/B386E7azfT9vl5Y0gIQY1Ro99WrOyLuslrn4MQht2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721053; c=relaxed/simple;
	bh=75taNo6QXbEdsk9lKvBXQuGiM5EmiDWwHmpyxsqYTnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epsfwNeK4GFSUGIvGRq+7zmCnGkSOgF94mIbJK9+5O8wqoKdxBQROPjPu6cjs0q8E5qUGqYWWp6N+iUQpQ7xAIOSGH2snKHPlwSYBbOKkigj9yuMj1djSLSs5ojKAnNuwSYH8MEddoxONlWVritb38b+3QkrKq2MagQz8N9srBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBAY+lcN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBAY+lcN"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4358fb60802so3659575f8f.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 02:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770721050; x=1771325850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRBd+OWZNvcE5sSbB/HiCSXAnOZkp22n1XabDGemtf8=;
        b=OBAY+lcNfGa7lWPvGBw/Ocb4mBt7GhNGcFHs/rA6y61KAQZmYDIjbAYHdMN5kH1/G+
         aDx+UPR89Yth3vOwwxLzLEDMjB1XJ1dyX+7vIoUbC7Lj6Ns3hgKlW8X3sdYEfFAbVxHY
         LQPW9+Gl1Z+cVpU+XvNm2mbE/UqOsgJDhDd4Dm8JA61XecdwbK/j7/I7WrvueDIcFpcA
         TitZcsIM4xufT+fR5KtLgTByx+5VXVRW4H/tZcUCBqIGDZv07xDfgblVY2qHh67FlUmh
         K28YPLXgoVrz+VIacM+ZDXKSecg9dhUOW0Ee0e4kZ72uqcfMYAakW3LBNa9NrzceMSZN
         TPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770721050; x=1771325850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRBd+OWZNvcE5sSbB/HiCSXAnOZkp22n1XabDGemtf8=;
        b=Plz1nqG726ToJoN7mD/HlKDiQ1xj1Vivc3j2lf8dRTmr2W/hfrumAcGXmT1AhA4Gg0
         HPjHJ3mqnAswqYJwTFKsdE10TyQnv8f7sTcli75J3g8j7ZyUrfTH5jfGoxTLfmRszsii
         xwUt/2DjZ2RVGKI6HFUiD0rMCWMY33aACDF06l/xkeirFb/Bw0nePnyd6bMjSa0MK0eL
         NHWeY9+ZIJSO6i5H03oFxPh4S8CE3FNvdzL8JgZ/PKzqwyvxW73YFFXV/HZhM3Iow/Ab
         GC8hcqFZlpQo8tF0tw6i6qd7yXs8tghQagGf4SGOiX1j+FS4X27gudasCv3MTVYMPftW
         ZLdg==
X-Forwarded-Encrypted: i=1; AJvYcCX5J1+bCQeWuHz8qaWvtdeX0yShYIQ2uzem9e0B25iihWRDwofZGxnTGvCaLiOuf3FAcRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1c9B9lR5aiywECkTkgIs/5giKBiL8i+y7JZI393EO6sb/x60
	x8ILPPpa40mysfQDq9Ps1x3oEQU9aTAPgyn7ngwAXrEF3ZHrbVudlx+iR1tq1A==
X-Gm-Gg: AZuq6aJ2vxmNf/rMg5EINMCl2FNYc0SiBU0yQ3N0NotfZSlhzJTJbg6JiXV33lhtx7h
	iPe4ZZkX1IOpnyqDmL+yqfyu9HGok4zrsQATeqIOTKpFqoSq5ugT3N9B3X//VTm8yofAqBJ1zeL
	3b8RpMWKMB5Pgv8MGY/L1Nl2J9flLu5xgKjBqEoXmSg8yxTWW0yjq+l7uIoSAEFMvipl4cSHmxX
	I1Q8OiK7+gHBuf38Y3UF78EbkFoywPMuqPEJGQLZ95r4Yd37PUMirHpf/mlwiwJnFw74R6iBlea
	+4do1tsnVmglmU3RvHw3wojVGhj1XuENFTwLGjgJVVVPRrJcOc36VeVwm19VndEX9RxsID+ANBW
	rgOu6+pmKyMWjmFkdi3Qe+AT+sKVJTb9ZUuQR6jVOklBcPQxPLHBYzdgoAtoiH979beq0/CEByY
	VeZge5ju+SUYSsK/wfFsj1mASP6aPDgM+hWw/rTRMk0zfushbUzyvkSin18bActp/vcrn34VTp4
	Ut/fpNuSSgEz/Aza2YGPA==
X-Received: by 2002:a5d:64c6:0:b0:432:5a4e:c023 with SMTP id ffacd0b85a97d-43779fed381mr3120714f8f.13.1770721049886;
        Tue, 10 Feb 2026 02:57:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:881b:6538:b006:6700? ([2a0a:ef40:627:1f01:881b:6538:b006:6700])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974b230sm37081246f8f.36.2026.02.10.02.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 02:57:29 -0800 (PST)
Message-ID: <7e6a19c0-332c-40dd-8aee-f6dd9324bcfa@gmail.com>
Date: Tue, 10 Feb 2026 10:57:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: add caveat about roundtripping format-patch
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Matthias Beyer <mail@beyermatthias.de>,
 Christoph Anton Mitterer <calestyo@scientia.org>,
 Matheus Tavares <matheus.tavb@gmail.com>,
 Chris Packham <judge.packham@gmail.com>, Jakob Haufe <sur5r@sur5r.net>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <format-patch_caveats.281@msgid.xyz>
 <bf5d1e84-2a59-4e1b-a524-c8b251dbae70@gmail.com>
 <c70adde6-e3db-4a46-bb29-a19d7aba8c7e@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <c70adde6-e3db-4a46-bb29-a19d7aba8c7e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 09/02/2026 17:59, Kristoffer Haugsbakk wrote:
> Hi Phillip
> On Mon, Feb 9, 2026, at 17:42, Phillip Wood wrote:
>> On 08/02/2026 00:11, kristofferhaugsbakk@fastmail.com wrote:
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>
>>> [snip]
>>> +Patches produced by linkgit:git-format-patch[1] or
>>> +linkgit:git-send-email[1] are inline. This means that the output of
>>> +these two commands can lead to a different commit message when applied
>>> +with linkgit:git-am[1]. It can also mean that the patch is not applied
>>> +correctly.
>>
>> Is this last sentence referring to diffs in the commit message being
>> applied? I don't think there are circumstances where the patch itself is
>> not applied correctly.
> 
> I tested with a line like
> 
>      Index x
> 
> Yesterday and got an empty patch when running git-am(1). But I couldn’t
> reproduce now. I must have made a mistake.

Oh, if you use "Index: x" (with a colon) does that mess up the patch 
application?

> 
> I think this should be changed to:
> 
>      It can also mean that the patch that is applied is not the same as
>      the one that was generated.

That's a nice concise way of putting it

> 
> (generated = shorthand for made by git-format-patch(1))
> 
> This sentence would then serve as an introduction for the “Furthermore,”
> paragraph later.
> 
>>> [snip]
>>> +----
>>> +```
>>> +diff ...
>>> +```
>>> +----
>>
>> I'm not sure the markdown really adds anything here
> 
> I don’t understand? It demonstrates a markup for code which does not use
> indentation.

But I think the markup is a distraction from the problem which is that 
the diff is not indented. Also calling it "Github MarkDown" is 
unfortunate as we try not to favor one forge over another and many sites 
support that syntax.


Thanks

Phillip

> Well, maybe it should be:
> 
>      ----
>      ```
>      diff ...
>      ...
>      ```
>      ----
> 
> Or maybe...
> 
>      ----
>      ```
>      diff --git a/example.txt b/example.txt
>      ...
>      ```
>      ----
> 
> I’m leaning towards the latter.
> 
>>> [snip]
>>> +One might want to use a general-purpose utility like patch(1) instead,
>>
>> "Given these limitations, one might be tempted to ..."?
> 
> That’s good. That leads with the problem instead letting it trail off at
> the end of the sentence. I’ll use that.
> 
>>> +given these limitations. However, patch(1) will not only look for
>>> +unindented diffs (like linkgit:git-am[1]) but will try to apply indented
>>> +diffs as well.
>>
>> This is useful context.
>>
>> Thanks
>>
>> Phillip
> 
> Thanks for taking a look. It’s always appreciated.

