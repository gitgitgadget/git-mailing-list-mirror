Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630A50A9D
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914816; cv=none; b=mC2+reFzXqsZcwNySnjLM/UL2JK/DZqmjz+ZdCVxd82D0j3OcPYQEdwm9m9jdsCiT4vtCs7XEv4A4UQDwjXHjq4MmDElMaS1bf911t+JzgNvxOiR95JBHWlqEZPHKzo6589dFxveMiO+rShoeCzu3yf4jJQnofQf4DDaxJMMzzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914816; c=relaxed/simple;
	bh=g8XI0EU14mfgTGOScIzpRTwjeEw8Jgc1ms0zzBszXfs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HvojaF9byO8iSu1psALtahgdNGjdZncvMMlkMEeASS1PdmScPGhc99mQw//85OSQ6orhCIaBXDvHULaLNSAcvFUIOX37iqAgNqkC6XcBf4x/PBTdAdEMVrxZJGXC7Dh/psJuH6zQLLRxv47KbPziWqahF+7yMC/l/MyVdC/CvCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaN9FuWL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaN9FuWL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-413175397f0so6481835e9.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709914813; x=1710519613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n1SHXJzW8nccDi8P6EF1VR2LzQdGdpDDYTAV6c+vZ5o=;
        b=gaN9FuWLMU4p0xZjnE8Ev/NJrdivl2EzmLf/ZX+SuUBdJoQdku8cZ2+bV4URDFxlmz
         bf5h0rWZU6EMyqSBo1erVh2dS0/VD1xqmhgBUBFzevZsQqJrXXTjN9lkANR5jt2zkQFX
         raArQiLCPJaa6PmZn5Is/RVKkzem6k3FxCJ11U5h50LQYx/yEoD2kS1YhJ4xbDXvbDsh
         2W4SsKA//Jyt/4PvtRKZi3WfLJpb/GfitPuCnq6hujt2snbfro7FPfC4zUOBrBUmnJJP
         N9ZySOb87VFB9Ab3GT1aL62g0tQjVbrgTtWDeZThbmL/yybwbGkCYGNw1wAkp3JKcpgi
         l6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709914813; x=1710519613;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1SHXJzW8nccDi8P6EF1VR2LzQdGdpDDYTAV6c+vZ5o=;
        b=WjR8DNd80IOtw/q4uCqOeRb0RgkK4MlyIMpljoRUnK3Vg8CezRbEPE30nozsuenDql
         1Fy2bQUti7+/MITH2v+zUcqrlxWhDilmwhFVctIdS+OTmb4V80Dzmg5S8v7eYexn87ba
         ksaRhSAPSo9SvS9VrYUrjqysGbbwhD4sx3G8hR5C1g2/dOmLx69pGcH0+O/uJh84qxS3
         KUGQTzchFZ/jk9p9OiRND6jF9Zsr84mEAOjIS9VynuRbXS2IkOyNoD6FfVMefyyCK+K9
         +vJoJhOnQGl/0roTBzG8FQ/r074xPReaubJ2544oPyt1O1Ud+TtAG2Wj4S2NwyeMAUL6
         Vc3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIZ3m16az4d3dcXZawbFr13zmP+n9IVymSEs1VvDa2bYf1S5TrDYwvtWXLTkQASTtCKNIzNFqeTCWjlFCMnsYS2I89
X-Gm-Message-State: AOJu0YwTLuFZwdk2kSS9dnt8sRdmXIh7kPlobzjkxKxAO1ezFB2kXoPf
	0wtxaAvqkoNfiGyVj9ZzZa1eyELWV0EZXhFlM7BHST0+tXJzQeZFwEEiJ4pSDTA=
X-Google-Smtp-Source: AGHT+IHoRQ6jZXtd+WWiXZ9ToeK66si59FJw64yDTdEIZHJXsasyXgYjTOhU/pZStEWBM9ueVMulZg==
X-Received: by 2002:a05:600c:1c15:b0:412:efd6:2d28 with SMTP id j21-20020a05600c1c1500b00412efd62d28mr8630377wms.27.1709914813085;
        Fri, 08 Mar 2024 08:20:13 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244? ([2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b004127057d6b9sm6447162wmq.35.2024.03.08.08.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 08:20:12 -0800 (PST)
Message-ID: <66a70346-98e8-44dd-a680-36a21df5f32a@gmail.com>
Date: Fri, 8 Mar 2024 16:20:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 11/15] find multi-byte comment chars in unterminated
 buffers
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Jeff King <peff@peff.net>,
 git@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Manlio Perillo <manlio.perillo@gmail.com>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092638.GK2080210@coredump.intra.peff.net>
 <3f823e48-572c-4e19-ab76-e6d7cab9461f@web.de>
 <d82e11f2-15c1-4ecb-8c7c-19667d2c5fb4@gmail.com> <xmqqfrx0hg01.fsf@gitster.g>
In-Reply-To: <xmqqfrx0hg01.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/03/2024 15:58, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I agree with your analysis. I do wonder though if we should reject
>> whitespace and control characters when parsing core.commentChar, it
>> feels like accepting them is a bug waiting to happen. If
>> comment_line_char starts with ' ' or '\t' that part will be eaten by
>> the strspn() above and so starts_with_mem() wont match. Also we will
>> never match a comment if comment_line_str contains '\n'.
> 
> Another thing I was wondering is what we want to do a random
> byte-sequence that may match from the middle of a multi-byte UTF-8
> character.
> 
> The reason I haven't mentioned these "nonsense input" is because
> they will at worst only lead to self-denial-of-service to those who
> are too curious, and will fall into "don't do it then" category.

We could certainly leave it as-is and tell users they are only hurting 
themselves if they complain when it does not work.

> Also, what exactly is the definition of "nonsense" will become can
> of worms.  I can sympathise if somebody wants to use "#\t" to give
> themselves a bit more room than usual on the left for visibility,
> for example, so there might be a case to want whitespace characters.

That's fair, maybe we could just ban leading whitespace if we do decide 
to restrict core.commentChar

Best Wishes

Phillip

>>> Not sure why lines that start with CR are considered comment lines,
>>> though.
>>
>> I think it is a lazy way of looking for an empty line ending in CR LF,
>> it should really be
>>
>> 	|| (bol[0] == '\r' && bol[1] == '\n') ||
> 
> My recollection matches your speculation.
> 
> IIRC the lazy persono was probably me but I didn't run "git blame".
