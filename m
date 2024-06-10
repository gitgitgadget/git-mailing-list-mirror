Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2912FB26
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028598; cv=none; b=CZ1RxasZ8Rh9uFE3upJQ8ZvP5XYp0p8N8c7VM51mpCiTdQwLFqUefAKC60JIBVKY/x0BoHjYli0OlHwoFOYGYKFS5VVvrPlQDVZm3+sgThwpM3VoaNLUtljQFmKlAVoLXi99Fj8DqodjbZEcx+Y5zXhbcRBA8tfcc82EKspwgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028598; c=relaxed/simple;
	bh=Y5IO4yRtlR0fn7NKCzOx4eShtwPzH/Z0kO67TlUqNxA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KwMXxPvCTgu/qcQ36qO6/taOEeoSP4vptkZRndFqVRii4+QGLDsRMRL81PwnwQ0cYK3XGBRTEQpVT+7KbZZlsgMRRF3xXmmfBmYiMiwd3VKb+H+hKWkwE9zNi7c7CoblCc9zo2/moSPiR3bbLFIaaceCoJ3jwCRuPxo4XcGtcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL3V4Rsq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL3V4Rsq"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c7fbad011so2260186e87.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718028595; x=1718633395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0yrHi4ezu2W5M/H3ne2ZK5zgXOo+RJ2FqSLerQHrLbE=;
        b=bL3V4RsqMna1Q77pS/cN0U5yVZAjh62pp/2AUtxC5QtukFGdzfYli9p62VGl2EDmFi
         IWQmBaFQLtB//PqU62BpMiDLGPNHdl3eT7MKk92scykMuBZgxJBUak1wmtnBGzyd8jSr
         7mymTGmDct0WW/e/IDZJN86VO1FTHC9FDUGbaF183g+rRWUN/aBk9XlINecf+C9w/Vta
         eYN/C/+2AqsrWqki5iRoDDU6wBCKs2oknmPd51Eux1HoKAlZb4aDWoA4vu0x7m94q8KP
         VGfvI/iwu9IJnsBuk8VZmO+pDMThcWYnlftP5T5JXeS1BhBHkcKDIt3C54Pkzh6GVU3B
         C8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718028595; x=1718633395;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0yrHi4ezu2W5M/H3ne2ZK5zgXOo+RJ2FqSLerQHrLbE=;
        b=tU23f9EVhY/JxaivOPJu9i/7JFOcSzqXyI5MZCqhlVHvgtP7WFnbJlgJvt8qgjQpge
         YBqF9T0mibTqqjcOZsBlO4U5LsM4zrzjFgY5s6+Lzqbkbfr8SsBVwaWvb1oxueJxD91r
         EAL6OwIkKPP1oZLsLmaUH8UIG32RBMfFfxU+dNQixn8mfZ1cGIvomRV3ScKnPaqizlCM
         LyVBacTvF3aUw2I0hPj8ng/84K6X6PD3sSIYApnZKGYSPjaxH5cVwvi7DWSSqLiJZvFS
         65A0Qg8mrxQwYOWSrlWkn784VcGMC+xxx68lNo+TagihHMYKa0B9+e1q53JQussblcwB
         Lc8A==
X-Forwarded-Encrypted: i=1; AJvYcCUM2V9J9EzTpLujW1XK6VbqsTgvfyj4ADowJVo6mi5YfoIqekY37lszwaMUtSBdLcqhxIeD41VuHlQL6cB/YxnBCFTk
X-Gm-Message-State: AOJu0YwJnkn8j4mSNFx27vIASI3Oj66LtznZ1ZHKzul7Ig1C58UK70FZ
	IlY5+7MZNfaJMGRtd8eiJywN4AWZUtntfZE8Z0ApiEtHTLomgk+w
X-Google-Smtp-Source: AGHT+IExpd4Fgg6Xvyd0vRcrS21WdH6rx57mPcWIoqP7rzDWCzrnQxNB7fGRzqD88nrmjIsMydIQPg==
X-Received: by 2002:a05:6512:114a:b0:52c:8a39:83d7 with SMTP id 2adb3069b0e04-52c8a39846emr2194279e87.52.1718028594540;
        Mon, 10 Jun 2024 07:09:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2024b1c8sm4065587f8f.39.2024.06.10.07.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 07:09:54 -0700 (PDT)
Message-ID: <9f1884ae-0f9f-4d9f-a262-b6929b81d7d8@gmail.com>
Date: Mon, 10 Jun 2024 15:09:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
 <219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
Content-Language: en-US
In-Reply-To: <219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 09/06/2024 08:44, Rubén Justo wrote:
> On Sat, Jun 08, 2024 at 07:54:34AM +0200, Dragan Simic wrote:
> 
>> When "|xyz" is used instead, the version of the hunk with no coloring
>> escape sequences should be piped to xyz.
> 
> That is a sane and conservative approach, and I'm not opposed.  However,
> giving the colorful version though a custom pager is a good thing to
> have, I think, i.e: allowing a simple "head" without losing the
> coloring.
> 
> Let's recap a bit.
> 
> Initially, this series aimed to enable sending chunks to the pager
> during "add -p" sessions.
> 
> To reduce the blast radius of spawning a pager for each chunk, we
> introduced a new command "P".
> 
> Junio suggested opening up the command to allow specifying a custom
> pager, in the form of "P<program>".
> 
> The "P" command started to resemble a lot to the common pipe operator.
> Thus, we shifted to "|<program>".
> 
> Some concerns were raised about controlling when to send coloring escape
> sequences.

I'm still not really convinced that the escape sequences are a problem. 
As Peff has pointed out [1] this new command exists primarily to display 
the current hunk. I've asked for concrete examples of programs that it 
would be useful to run from "git add -p" where the escape codes are a 
problem [2,3]. Sadly the replies talked in generic terms about an 
imaginary program without any reference to displaying or processing a 
hunk from "git add -p". Without a clear use case for stripping the 
escape codes I think we should add a single command that pipes the 
colored output to a user specified program. We can make it clear in the 
documentation that the input to the user's command will contain escape 
sequences unless they pass "-c color.diff=false" when starting "git add 
-p". If it becomes clear that there is a use for the plain output we can 
add that at a later stage.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/20240605090935.GF2345232@coredump.intra.peff.net
[2] 
https://lore.kernel.org/git/a2a59f5e-fd55-41d3-8472-b99256e1f428@gmail.com>
[3] 
https://lore.kernel.org/git/1ae0715d-df76-4019-995e-f00f3506f2ac@gmail.com

> Several ideas were discussed to address this, including
> introducing a new command ">", a modifier for "|": "||", and others.
> Alternatively, we could leave it up to the user to filter as needed.
> Or, simply, do not send escape codes at all.
> 
> So, looking back at the ideas discussed in the thread, perhaps a
> reasonable next step might be to reintroduce the 'P<program>' command
> and let '|<program>' be the way to send raw, uncolored, chunks.
> 
> This approach makes sense to me.  I'll wait a bit before sending a
> reroll to gather feedback, though.
> 
> Thanks.
