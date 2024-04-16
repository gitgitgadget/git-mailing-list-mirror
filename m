Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C27131196
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282424; cv=none; b=FB1HMyOWEaPbkj2HNXaWNSkoubfoA/TlRR/MGbT5t430a+5kUU4ar5aBdrKJ4NVO1y1nzgeK6QjxBFwNfb6P25jEwkoQuD1Yl4RR8ol7n8UaJMOqEOSQomPUsDyVlPFqE7MGThvEkZRPuoCrGHJI6XTnKQ0ijt44pZXzLad2K6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282424; c=relaxed/simple;
	bh=4lB6Z67z78/Zo0jl+Px0+zLuZ69eMhnhbXEFmh+AE74=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TwWIX9Fs1yDAw7FzCNp0//ka2KOKsxesaztzTMgVMDM4tnYl68VCbHjSKECoaXFM7tvEXU2DmlBCoegPiMQaLNGyN93Z7AwCxTIfnRmsM4mxOORl/HyRXkGO9IXy4IfJC6BFNXa/rrK3tRvX2bHYAN51qtMxtxC0kiGXXlahKzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVBXSD3P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVBXSD3P"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41550858cabso28758105e9.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713282421; x=1713887221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsfDU21FhKxenabgsyKIoy7AJYDiW4oFU7sVZ4mGsPE=;
        b=cVBXSD3PTHbRlDVQQh09g54/q48/HdG9M4VysRU1XLbPpFCPtT2nsR+tYaTSxYEy/C
         m1mJRF8n9uacq41aoAXUji71/ceVzbASQ9SERnuPx91aw9vbsGk0ZQOcXyW1HAsMl6oa
         LuBkqgYbwRtjhuLPUFZxep4xf2DVl7dX22AedcP+QHrLApIIBnuB2gZ6JGd7/fuilWkJ
         WnknWs5RtlbcPixKFv6ISGlcZs+faSotx59W8m+SLtxcaHTPcAueZ9QE8e5fU3j3PWj2
         40Uj3ENhPvsyI6wKub5yR3qH/5Up9cj3btnq6bnXHfhvHTWBiIjdAwUCFQTJDsmLNj0O
         tJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282421; x=1713887221;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsfDU21FhKxenabgsyKIoy7AJYDiW4oFU7sVZ4mGsPE=;
        b=gXc/e4bzvUQw+FVYlAVdBwtCSjpRKFr/S4RHrLeyR9iTL+IPgqAJMmdjpJZ58sBVyP
         Xj79Bt/L13aVWxoZfV4b3PVtzjFjCNznu9Ar2OpxxR1iOFkKhJo1LvXglHxz4QeMw+u4
         z5w0PkCM2eKEuqcpL5Mj6xLKNepQUPO/UQmfPs5vlpE+3o3lanQ4pgedZ9w2DslwysLX
         K9fXN7dTqYKnuxqbpJ/DXR6DTsoB+tuotv7vMnTsylmYF2uOLAim6Ns0YycRfwVh/PHu
         sjZLiUj25TpKK2L6EeqALJezkgEl+yPrOYxE+SY5oLR2Az2Ib/68RxRyD2OXlJNs2bLh
         cuCA==
X-Forwarded-Encrypted: i=1; AJvYcCWDoicH8K/jqD/KPHA4kJcPJhv4PWZEKWeQN/UE6JDuAt2WCLZ72z5rDyMACvNvdbIpjbBGfKHQ8eco2yQcsvS2KwW9
X-Gm-Message-State: AOJu0Yy1t39v9bkUTY0SZQLL7YfaXT/6xJveQ/etklvdfgy1EfhtSdXM
	xlpcbs7n75r4MvHIR/Q7JhlOX+qZMPsIKXkr0U5pMD/v7cgSfRRF
X-Google-Smtp-Source: AGHT+IFxJgFI4iTKz7ge4dBvUGaEvRCmD2ZkTBCK5OOVyN1fIv5Hg+Qq1jrPiS+X7jG9MGV+sVFABA==
X-Received: by 2002:a5d:584a:0:b0:341:aec7:c583 with SMTP id i10-20020a5d584a000000b00341aec7c583mr10636141wrf.53.1713282421212;
        Tue, 16 Apr 2024 08:47:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id x11-20020adfcc0b000000b0034658db39d7sm15283835wrh.8.2024.04.16.08.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 08:47:00 -0700 (PDT)
Message-ID: <e2e72c39-2975-4307-a356-19e661cafb75@gmail.com>
Date: Tue, 16 Apr 2024 16:46:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add-patch: response to invalid option
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <xmqq5xwhhacm.fsf@gitster.g> <64d4ba8e-0dfe-407c-9b32-d02f1ce40393@gmail.com>
 <xmqqr0f5fi2b.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqr0f5fi2b.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/04/2024 16:22, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> That flow of thought makes sort-of sense, if the choices that are
>>> offered are too numerous (say, around a dozen or more), but with the
>>> current command set, I am not sure if this change is an improvement
>>> (note: I did not say "I do not think that"---I simply am not sure).
>>
>> The complete list of help is 15 lines long (we don't always print
>> everything but if you're in the middle of staging several hunks from
>> the same file we do)
> 
> Ah, OK.  Even though I was the one who stole this feature from
> elsewhere, I forgot that we had that many commands, and it makes the
> decision a lot simpler ;-)

Yes, it always surprises me how many there are when the help is printed.

> So the log message may want a bit of rewrite in the title and the
> introductory part, with a clarification that '?' is what we already
> had and not what this adds (from Patrick's comment), and there may
> be other small improvements we want to see that I may have missed,
> but other than these small-ish points, the basic direction of this
> patch is good?

I think so.

> This is a tangent, but I think we _mostly_ take these commands case
> insensitively (e.g., you can say 'Q' to quit the program, as well as
> 'q' that is listed above).  But 'k' and 'j' (there may be others)
> act differently when given in the uppercase.

'J' and 'K' are the only keys where we have different actions for upper 
and lowers cases. The implementation looks a bit confused though - we 
treat y,n,q,a,d case insensitively but not g,s,e,p. As no one has 
complained about the latter we should perhaps leave them as is in case 
we ever want to add upper case variants.

>  This would limit our
> ability to later add capitalized variant of an already used lower
> case letter without retraining users---should we find it disturbing,
> or is "add -p" mostly done and we do not have to worry?

I think its mostly done. I'd like a way of selecting lines from a hunk 
that does not involve making the user edit the hunk and I wish the 
search remembered the last string but I don't think we're in danger of 
running out of keys for new commands.

Best Wishes

Phillip

