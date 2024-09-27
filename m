Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FC1BBBED
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431706; cv=none; b=Nqt13/wv9NREL1iM50fHeFGj2Fw27xbXUX/kS6ZI8eJoZ5FhYRrj9lRiuYb0HijuvyatwD9dPG1p+ShHj8gLoK16xRTgazrjeQy1AH5op5/g6ltEDCBtHKNPuGcxIHmdj0DttQtRSqBonnspreAC84RrFYcwtJao40P+BCbswGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431706; c=relaxed/simple;
	bh=hj+2iInRRJJdV1o8q68EZkrY6EIOKsj1wB1fRW5ot1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pR5jP/a5NyEGv3pYllQBcycIAImezTX+4hOcRH41c+EJ8KfrWlAnSTFtc8NmeRI+jqJm8CvF7MGfqiGQ1ORYVPRdqrPo4dbEbiZXN1yL1hS/PUtGDKkPMzoMu/dOdvGO3hJw7SYPOVLbzMOGmZdfnuUjv/I67nzU468IwPyTqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEvUnq86; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEvUnq86"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c46680a71bso2159931a12.2
        for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727431704; x=1728036504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lDHuMB6KJDitzMYvoUkXjNOV7rrW2aUM4m8toV41xB0=;
        b=lEvUnq86sDl2BDdE6c1NIZvribrqxiuw+MiKwJkYwqY3ZSx/SIkSUAnz56U7HU01Wh
         7c48WY6LCSj5AcAIjMwjTMNe3J4Jeo/AGgHt5WGXqUtoB7AIQfVmrjnA/RxrQYnpW5Cg
         dYbPwMhkIsQoRwYcqTUIRlr2/DVZmYuDsLRBeo2kfFWERU+t+7opFgZ3IthNuAf2q9+j
         tchPWtgcWEK7VwWzGFiOK+K6z56oAWlxCXT4eiGcspndsQcvdPLnsvbXF6eghREuYsnF
         BDV0CE5640xcInMCTphc2v6gGtB//p/qBHEGJUlN4BLvli9zGxlibF/MdGOyy+iDfxt9
         6yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727431704; x=1728036504;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDHuMB6KJDitzMYvoUkXjNOV7rrW2aUM4m8toV41xB0=;
        b=Eac32Y4PfP03fFWctJ0KxNWT27MdfdwSmAFARSrTcl2lhQu/v8AARJebguTTRQ7Mvq
         xfI9i09shMwoM5zBufvMomusW3jnWfR+Vcy8JImAhYFCwwIj1OlbJAE/0My6vycNTSA1
         fB8vr7QDBtHtKS7v/ZrEN9D14GmxbJjsMYPxMPlRj+BWocZ0ocKdoGZR6Vo8DYkGKddg
         kpq29iDxL1CR/Dj5Abn1ra7KRkLC6d79MMAd08VqCtyxHkmcifG0aAq+VuaU+JOwP2d+
         ne+JdVyXHbeMJq+E4+G7rhXm3C5xjBJcktMoODZwVO2nnWc6YdGoYsIbmgMk60jNYKN3
         jOTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWimfz+MIIX2XCR4AGjcLcvQ1ZGBqup2BVCZny5/Uu9N636ohN2dJhgbCborqDbU/+z9Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxAcrfvQ9H+f45QiXZ3rfeht+Vxp7N86xIuUiAD7gIFtguqS/C
	5zgQkuUbTF67XmOzsIc059c5TdYEo735eWh5f/wxNyPdfZ+mh7Lz
X-Google-Smtp-Source: AGHT+IGCYoOkEBCgUM3K5nKTJuq5A4w0lkl3VoO71n3So5963h1jgcYgs9EfOucVgnQt/ESpEFNy0g==
X-Received: by 2002:a05:6402:1d48:b0:5c8:784e:149c with SMTP id 4fb4d7f45d1cf-5c882607903mr2108688a12.31.1727431703305;
        Fri, 27 Sep 2024 03:08:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245ea57sm969117a12.55.2024.09.27.03.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 03:08:22 -0700 (PDT)
Message-ID: <4e2b5740-6863-4ab6-8483-2e933b4c427c@gmail.com>
Date: Fri, 27 Sep 2024 11:08:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [TOPIC 07/11] New Contributors and Discord
To: Junio C Hamano <gitster@pobox.com>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Kousik Sanagavarapu <five231003@gmail.com>, Taylor Blau
 <me@ttaylorr.com>, git@vger.kernel.org
References: <Zu78E+0Uk5fMSeQv@five231003> <xmqqsetr5wl1.fsf@gitster.g>
 <20240923-spirited-lime-lyrebird-fe90d5@lemur> <xmqqbk0exdk4.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqbk0exdk4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2024 22:31, Junio C Hamano wrote:
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> 
>> I can chime up and offer bugspray bot integration for the list. This is a new
>> tool I've been developing for integrating the mailing list with bugzilla. I've
>> been using it on the tools mailing list over the past year with reasonable
>> success.
> 
> Intriguing.  Everybody loves to hate bugzilla, but would bugzilla
> become less smelly with bugspray enough to make it palatable to all
> of us?

If it's easy to set up it might be worth a try. My memories of using 
bugzilla in the past are that it wasn't too bad for issue tracking. Most 
of the pain came from trying to use it to review patches which we 
wouldn't be doing.

Best Wishes

Phillip

>> Bugs can, of course, be easily queried, assigned, and tagged with keywords
>> that can be filtered.
>>
>> Bugspray is still in early development, but I plan to continue expanding its
>> set of features, because we hope to make bugzilla actually useful for kernel
>> bug reports.
> 
> ;-)
> 
