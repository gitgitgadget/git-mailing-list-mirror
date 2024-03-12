Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E221E865
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254202; cv=none; b=dEsoBsjsQKeUfyNCmZlgztilA1ZlRNixftLlpehqm+qWbWk1u8JajYgvfUh8j4oqEI8mIrk8FIvqPLlcXKms2QBj6eOMAC0LpjTL6oFNA4sBCku3FZ/qh7KJ/Mr2KNwLgu39XEo+mq6z4JeN8diB6w9dUYDC3aSDbarxMEUPNIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254202; c=relaxed/simple;
	bh=PXm1nwNSWfaPqZQ8rRJHpB5b6KRkDMgPdkeS90InYg4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nNiGWvOXf3hgWbU6/MTLhYiNYJHTaTXZLFZLAKgAd5Z4Owom1ds/t66xQAIHzW8Y6qUuo7F3CzSW2yGRkcLzFUHlu7k/i40CgWDdqHOGMVx7uCue3NsUzdNemT/zZLEMI1MjJvdApzfnIB/YUJmrS5LD6KPXN6K2kvsVQOwDJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue5KBoVq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue5KBoVq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41312232c7aso267435e9.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710254199; x=1710858999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg2WjSqsoywB4NdtHY2J1/Vz1IVlyzmv/PuK9hanE9s=;
        b=Ue5KBoVqkWJuFoaEB2QU8st1QvosUhFCy+AG4sZC10SOfFFb1EB2l/GT1xM+YOLvgp
         JeDE/DgfjZYVrPLh0mcBhnel+mhM2Gde3r9s8xwvB1FKV3NSqFo23+7HVJGZb5H/Zo5r
         UNfPe8VD10MD+D3w+9SIPE8QM2Nf9NQ5sUZy0hR50gVw4ZS3/JZjNBlDpS6QidYvlq3X
         QS5r9rdgQVjqiiCaTGHjI1ezgq5zeopDpmYlHHoyoIpzFImF4LgB7wp1zOeo6bVGSi/U
         sjvKE27krg/TSBUw7DSV0PvOuVS7sB7TKPlMf82BmK9gl1/gvoe06VTPs43rQayRsYsa
         iEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710254199; x=1710858999;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jg2WjSqsoywB4NdtHY2J1/Vz1IVlyzmv/PuK9hanE9s=;
        b=UQtPdAbub0hQgjcsRjvtnuCDHn2jm04BIMxdBIKGNRgG8TJAl53wTfHxaPesl9aLvV
         L6xILc82A4iJMrlgVcHablRaPOo290B07ukC3vSxWS2uZRHTS0ZWgL2Hr4O0kXJWKbWE
         8BpiS30h5bTr4rVlm2KGMXbYLPoux8xnAEvoroUjmv19TGWShuqqPFYSeo2TQ+7chfPG
         BhrMPA6ht4c/PRzsacyh2CNrZBQrXI2Z3hpL9u8QbMs62HUZDdS4k/wCbDq7DkXNSYG3
         nVwRRJmiww2i7/X1s7RAq1Vg1wlbfXxPJ2x+hW45dHVjnaXPhyfADpvL3pIS2gbqh2eu
         DWaA==
X-Forwarded-Encrypted: i=1; AJvYcCU2+wrFHf9A920mU/O8Z/hZCygQ4JhzgPk60jVdNZjnEJDxkPOXzcD+rF0fbrw4xV67OT8sZPJj5jTXI6XcXaxw2h+G
X-Gm-Message-State: AOJu0Yw9eWfbaPVuTty+ZttW98EIcVU5xnQErZ75T5+3Y9NuN69DU0HQ
	yTFxxgecP/AjFSdMh7EuaFJ+SK7aYxci8smvtyExxcQlgvhu3sGx
X-Google-Smtp-Source: AGHT+IHfHAp5y+r65SRozO/OHb9mT7rCQHUsr93wZV0X3zS6iVp7rhKLixytrKJfcLRtjoL+UCL1ww==
X-Received: by 2002:a05:600c:4f96:b0:413:3059:a8a1 with SMTP id n22-20020a05600c4f9600b004133059a8a1mr3402111wmq.14.1710254198720;
        Tue, 12 Mar 2024 07:36:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b00413e523b7f9sm246851wmb.43.2024.03.12.07.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 07:36:38 -0700 (PDT)
Message-ID: <9b63eab9-7b6d-4024-9ec4-b58c5ca3b084@gmail.com>
Date: Tue, 12 Mar 2024 14:36:36 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 11/15] find multi-byte comment chars in unterminated
 buffers
Content-Language: en-US
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, git@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Manlio Perillo <manlio.perillo@gmail.com>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092638.GK2080210@coredump.intra.peff.net>
 <3f823e48-572c-4e19-ab76-e6d7cab9461f@web.de>
 <d82e11f2-15c1-4ecb-8c7c-19667d2c5fb4@gmail.com> <xmqqfrx0hg01.fsf@gitster.g>
 <66a70346-98e8-44dd-a680-36a21df5f32a@gmail.com>
 <20240312081931.GC47852@coredump.intra.peff.net>
In-Reply-To: <20240312081931.GC47852@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 12/03/2024 08:19, Jeff King wrote:
> On Fri, Mar 08, 2024 at 04:20:12PM +0000, Phillip Wood wrote:
>> We could certainly leave it as-is and tell users they are only hurting
>> themselves if they complain when it does not work.
> 
> That was mostly my plan. To some degree I think this is orthogonal to my
> series. You can already set core.commentChar to space or newline, and
> I'm sure the results are not very good. Actually, I guess it is easy to
> try:
> 
>    git -c core.commentChar=$'\n' commit --allow-empty
> 
> treats everything as not-a-comment.
> 
> Maybe it's worth forbidding this at the start of the series, and then
> carrying it through. I really do think newline is the most special
> character here, just because it's obviously going to be meaningful to
> all of our line-oriented parsing. So you'll get weird results, as
> opposed to broken multibyte characters, where things would still work if
> you choose to consistently use them (and arguably we cannot even define
> "broken" as the user can use a different encoding).

I agree newline is a special case compared to broken multibyte 
characters, I see you've disallowed it in v2 which seems like a good idea.

> Likewise, I guess people might complain that their core.commentChar is
> NFD and their editor writes out NFC characters or something, and we
> don't match. I was hoping we could just punt on that and nobody would
> ever notice (certainly I think it is OK to punt for now and somebody who
> truly cares can make a utf8_starts_with() or similar).
> 
>>> Also, what exactly is the definition of "nonsense" will become can
>>> of worms.  I can sympathise if somebody wants to use "#\t" to give
>>> themselves a bit more room than usual on the left for visibility,
>>> for example, so there might be a case to want whitespace characters.
>>
>> That's fair, maybe we could just ban leading whitespace if we do decide to
>> restrict core.commentChar
> 
> Leading whitespace actually does work, though I think you'd be slightly
> insane to use it.

For "git rebase" in only works if you edit the todo list with "git 
rebase --edit-todo" which calls strbuf_stripspace() and therefore 
parse_insn_line() never sees the comments. If you edit the todo list 
directly then it will error out. You can see this with

     git -c core.commentChar=' ' rebase -x 'echo " this is a comment" 
 >>"$(git rev-parse --git-path rebase-merge/git-rebase-todo)"' HEAD^

which successfully picks HEAD but then gives

     error: invalid command 'this'

when it tries to parse the todo list after the exec command is run. 
Given it is broken already I'm not sure we should worry about it here. 
In any case it is not clear how much we should worry about problems 
caused by users editing the todo list without using "git rebase 
--edit-todo". There is code in parse_insn_line() which is clearly there 
to handle direct editing of the file but I don't think it is tested and 
directly editing the file probably bypasses the 
rebase.missingCommitsCheck checks as well.

Best Wishes

Phillip

> I'm currently using "! COMMENT !" (after using a unicode char for a few
> days). It's horribly ugly, but I wanted to see if any bugs cropped up
> (and vim's built-in git syntax highlighting colors it correctly ;) ).
> 
> -Peff
