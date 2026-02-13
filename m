Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860D2737F9
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998773; cv=none; b=s0gf2wUC6b6cJYy6dyEqxypo3JbBcXXpClxCH67DwfOeLHnvJdSNHwVHBkmtzHIMvBrlGLGbdXF+Kta2mpUfKX1kBkAiFIIQ87O1Cbp1Zq/DhiO7h/A1FhiHCfsjRF+xrudCSKgcwulucrw6npHvpEPM5I37Y+LGEezjFC+CbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998773; c=relaxed/simple;
	bh=mETZIa8OHTTndfYcYTSIZ/ca75zLoOCqfLUvY+1WqOs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JjA7uJmo3wY1W3HaUHrakP51rmduim7jVIBVngtIx9Oty0HxcAaUE+2bxeQBSKkSP626M2o470qo93QFlmFNJ6PFnC0lB55rc1MLBSTS3n4ll5uVGpalljDF4KOiCEwV7BNaD6d+CozXmc6dbutuyh4TA7KtiAzhL90devijj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eX+5DXJ8; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX+5DXJ8"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4806bf39419so23321255e9.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770998770; x=1771603570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rx+dukQFfX9k6vrbusexwo6wsNInrFrAC7NDF9fX/vk=;
        b=eX+5DXJ8QK3LeHEAGHkcbNZdsMJi0ab5lIZ+M/7KD9Y59MLgIv/vMVkDXFlulZvzw6
         gdoWqbUjP0SiH1S169UHyEdh7nYhIvGoOHYtAl7czIkQ9PhqIT430h8z5hap9zxWWpcF
         goORWvwFjTNoqXro96YSVrXGWEI/xhqD2Yzu2PKAnz7BnpAJ1URsDA4agebQTgKPQ5K0
         gD+C+YdD62hSe7+HjPqrs/EUq6iH4tEZ9w41fQWEoHMTZ9OK99MEo+EWGJmG87ZJawis
         moLxFjxPwU+Ol7/qu+epxrTptoZhnmWKHGKquabjkhknOQRdIfnbLo0BWcALn5Ahys7Y
         B8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770998770; x=1771603570;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rx+dukQFfX9k6vrbusexwo6wsNInrFrAC7NDF9fX/vk=;
        b=QVwUMGhtoKdkkVS84ERU7DsCDVS1wY8E2HX0IgUnXrnO2sbYbefBieGSGRZytZjvrM
         7bgUHR64ZAotjkdsBQUyIqa3XwlZZQHA+inTx6CkIz8OFjZHLokUIXu7ms9oQivJ0eCD
         XttTGlqW3yd3OXnR1QDoGdw7r1RxbaQpML2maI+Bkc4oAlePOhuMf2QsUuzJwzaekGC5
         YP1714OiYO/+/R9UrkLZpzGfrsky8TNdk9mY937PTCRJrLgQH/4RsxsOow5PKDLj1af3
         MY6JAVbW6L3n/07kY2jmyMG5J6pnrgiiJJALEmqIq3Lred9AYvA9+DPxW85xjMwvV15b
         zwKg==
X-Gm-Message-State: AOJu0YxlarYli+5IVafZWH4fRZR5MqxCKZc4/bn9kZS5COVFUssw6SS1
	+/1Q1F4WomaZCDaKMnOLikSolT7ltTxQmSIQz2OicnhxHOMQCDCvNYBAYlCJi/JA
X-Gm-Gg: AZuq6aL6oYYRJnt2Bc+Apem0LoNHwpSlmrUJ6V+4LaumC2I/OFzjizo9LMYnodUGGld
	//J5GdgYz1/StvTn1P6kuBD3n1JR47V5ozySWx/EcQsCB1oecjU0R1ZPL2QlqoSgTCmADxnEW/G
	muQzvjqwT8amwllapwh31215vQui96nUOMaefW8brulKLga9dG4GQhFEICtCSXljNvPZcfcKM7A
	B52YAFIBwfdYVvF0d/aY1g5zEqf59oDs9NNcq4XvNCIP6rBoZd/6xDdCf0JoTEMj5/FJ2o6wq3/
	Og2lbbuAMoAXWruNiN1oSVA2PFTJMW9pq9JAnjJMtdMhA2EGCQhq4U5OAiuaBAmslUAhXyWV0BZ
	106i+yjxwAyfB8SI8PoR4sPgMPEZyJgL+jNMphBgGvDS4KLTCAUS6TXc1V+U6pDYavrbbk6XqKu
	Nb3IM3h2IYYQdNHYyb+/pPL96RrCIVZTYq803d/4f0ChI38c6GHC4A4uQSZaErtWC+9VPP7l15E
	OhP6A==
X-Received: by 2002:a05:600c:4e55:b0:477:a71c:d200 with SMTP id 5b1f17b1804b1-48378d958e9mr13440395e9.11.1770998769557;
        Fri, 13 Feb 2026 08:06:09 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd0deeasm188138535e9.12.2026.02.13.08.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 08:06:08 -0800 (PST)
Message-ID: <44b29844-1d3b-47cc-8a82-3ae167661f59@gmail.com>
Date: Fri, 13 Feb 2026 16:06:07 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Feb 2026, #04)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq5x84xms1.fsf@gitster.g>
 <53696dd3-1920-4777-a62e-bf7818bd228c@gmail.com> <xmqq3435rk70.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq3435rk70.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2026 16:38, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 10/02/2026 22:21, Junio C Hamano wrote:
>>>
>>> * pw/commit-msg-sample-hook (2026-02-07) 3 commits
>>>    - templates: detect messages that contain a separator line
>>>    - templates: detect commit messages containing diffs
>>>    - templates: add .gitattributes entry for sample hooks
>>>
>>>    Update sample commit-msg hook to complain when a log message has
>>>    material mailinfo considers the end of log message in the middle.
>>>
>>>    Will merge to 'next'?
>>>    source: <cover.1770476279.git.phillip.wood@dunelm.org.uk>
>>
>> I'm planning a re-roll to handle subject lines that start with "diff -"
>> after using this hook while preparing
>> <2a8cc2d6c37f25a58823b501500165d597321749.1770911599.git.phillip.wood@dunelm.org.uk>.
>> Such subject lines are safe because "git format-patch" prefixes them
>> with [PATCH]. I think I'll probably drop the last patch as well.
> 
> OK.  Even though the "[PATCH] " prefix is optional in format-patch
> output, it will be on the line that begins with "Subject:", so it
> should be safe, so you can safely exclude the lines in the first
> paragraph of a commit message from the check.

Good point - I'd forgotten that the subject ends up in an email header. 
I've sent v2 as <cover.1770993281.git.phillip.wood@dunelm.org.uk>

Thanks

Phillip
> Thanks.

