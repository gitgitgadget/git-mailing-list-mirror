Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C261591FC
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953882; cv=none; b=shHWcTzjiBlc7Fdh2YIYa8xOGq2gK0Oe7bLEHJyP86arFuraezlk2LsS3KzZpiO54tCp02eyhqLpz2ijEf+9UZEY33oFO7Zy0rYoZkILPa7u5wcmK073Hv1F8QMqYHJQt2PlBYFw+FjnXHuPcIPINknySi8kFh9MgvhCKpkY0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953882; c=relaxed/simple;
	bh=tsL7HQbCzKxYtAm6+Oet7XI4oKJWTRZTBzEuifDGwHM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K4oklv1OU2Z79k+yPYfytP/hDv3JTJc68fQWwaxMnqHwytkbuEiNqakGEZs2Chw7/0FYNy/PxPxWfxW0AJ5V5fmGFgmWB8ynK6g/+pxQ+jzQmgOG/yXDeNFTSeF0CRsIbO4v+5G7NfKv5HcBE3wd9qpuieQNqWpy2zuAUTX06so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NawU4h9s; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NawU4h9s"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41af670185fso5793255e9.0
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 03:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713953879; x=1714558679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qEkT3MeoQc2yw9dFMqKxjby7YGdTyskV4dCrDC0Qr8=;
        b=NawU4h9skKFknk5mM2ItwAM/6xvf5Jtx+ykrlzNRF3xSSMPBp/EQZr8rhvEw0/vg/0
         Ibqe9D2gIGlJOQz24iqeVh4xxw4lfV+PzhOyxZ2ljTF4vOL6BWTu/cC4JGgQ6vyzmZoB
         FetDPEkhEPwzsqXr6Z7hroE856lakEJ3nGikcA8PO1fLyyZ3rH0MBs4dHK/dUAbH63ME
         88EY4U1+dlLdb/jP7HEbhqwsN0iYpQLxx6a7DONyCutfl+urlzOmLkzcNguwq0ZtAsie
         2L6ZxlboSvV0FY0BkiYLxv3sUo+jWjErf6TG5w4uBBcxVh9NfBQPJ45Mph1jPWJfTERw
         7ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713953879; x=1714558679;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qEkT3MeoQc2yw9dFMqKxjby7YGdTyskV4dCrDC0Qr8=;
        b=GPrXtDRV8Hw3/E3x0hz0SRh/9Sy82T0l+E8bBL2HSGjREO29Q011lqoscRo13Bgsq6
         j49lyHYByZwLqTn5yBgd1yzpIMN0wPPKrN0YZIvWLIiFzPcsPMWjTnLCxNPjKT/9Ch+b
         CHbodhKHNNQ8q6dvbmTXX2hRiJ/6KHNDYjS556AFlcfvOyR8HvNmV2N7Hgt0Eo0BtHl/
         ZZTBw7deLkDA6sVgeIXNQs9ZLJZLjHXA5hbzdDf+oMb4vYi809J/pa8snJP7WVoAiMU+
         lxd9y8ug0znhK47N+uyJRWj7+kYuIlb1BSGr02yh5/hCwFBZOD1Xn8/TekRO56vLXd2G
         Q1Kg==
X-Gm-Message-State: AOJu0Yw4Gr9HpnoRorUfeBSh7AoixCRxTRJej5lIV79xAHoKfGIE83N2
	1K7H3KL8GEbiH44bdBJ3mFr2p1Zud99jYn4Orom2sQDfHmxTJ0le
X-Google-Smtp-Source: AGHT+IEfikEBf5PE8O5nUY7WN2R7SkH+4hTruHwI21SpqxvFzSbGFvNNAeoOlMXRa0Zy1DVBkHbtZQ==
X-Received: by 2002:a05:600c:4ec8:b0:418:e2e4:a84c with SMTP id g8-20020a05600c4ec800b00418e2e4a84cmr1462308wmq.30.1713953878624;
        Wed, 24 Apr 2024 03:17:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c0a0900b00418916f5848sm22895508wmp.43.2024.04.24.03.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 03:17:58 -0700 (PDT)
Message-ID: <e4206b6d-13bb-4332-93b3-09721c1b4152@gmail.com>
Date: Wed, 24 Apr 2024 11:17:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] format-patch: "--rfc=-(WIP)" appends to produce
 [PATCH (WIP)]
To: Dragan Simic <dsimic@manjaro.org>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqy1993tc1.fsf@gitster.g>
 <20240421185915.1031590-1-gitster@pobox.com>
 <20240421185915.1031590-3-gitster@pobox.com>
 <f9aae9692493e4b722ce9f38de73c810@manjaro.org>
Content-Language: en-US
In-Reply-To: <f9aae9692493e4b722ce9f38de73c810@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dragan

On 21/04/2024 20:37, Dragan Simic wrote:
> Hello Junio,
> 
> On 2024-04-21 20:59, Junio C Hamano wrote:
>> In the previous step, the "--rfc" option of "format-patch" learned
>> to take an optional string value to prepend to the subject prefix,
>> so that --rfc=WIP can give "[WIP PATCH]".  This commit shows that
>> the mechanism can be extended easily to allow "--rfc=-(WIP)" [*1*]
>> to signal that the extra string is to be appended instead of getting
>> prepended, resulting in "[PATCH (WIP)]".
>>
>> Having worked on the patch, I am personally not 100% on board with
>> this part of the feature myself, and that is why this update is a
>> separate step from the main "--rfc takes an optional string value"
>> step.
>>
>> If a way to prepend an arbitrary adornment is added to the system,
>> and people can now say "--rfc=RESEND" to produce "[RESEND PATCH]",
>> those who used to use "[PATCH RESEND]" by tweaking the subject
>> prefix in other ways [*2*] would do one of three things:
> 
> There are even more issues, such as the grammar-related ones. 

I think it is best to view the subject prefix as a list of space 
separated labels or keywords rather than part of a grammatically correct 
sentence.

Best Wishes

Phillip

  Let
> me explain, please, as accurately as I can do that as a non-native
> English speaker who spent many years studying English grammar.
> 
> Writing "RFC PATCH" puts "RFC" into the role of an adjective, which
> is fine.  The same obviously applies to "WIP PATCH".  On the other
> hand, writing "RESEND PATCH" puts "RESEND" into its only possible
> role, which is transitive verb, and results in "RESEND PATCH" that
> serves as a very simple sentence in imperative mood.  I'm not sure
> that, strictly technically speaking, having simple sentences as the
> prefixes is the desired outcome.
> 
> Technically, we should use "RE-SENT PATCH" to be on the correct side
> from the grammar perspective, with "RE-SENT" serving as an adjective.
> Before you ask, no, we can't use "RESENT" there, because its meaning
> is completely different.  However, nobody uses "RE-SENT PATCH", or
> at least I haven't seen it used yet.
> 
> When it comes to "PATCH RESEND", "RESEND" remains in its transitive
> verb role, but "PATCH", as a noun, becomes a modifier of the verb.
> Thus, the resulting meaning of "PATCH RESEND" becomes something like
> "resend an item that's a patch", but not written in form of a simple
> (or less simple) sentence.  Strictly technically, a noun should only
> modify another noun, but bending English grammar a bit this way is
> much better than actually having a simple sentence as a prefix.
> 
> With all this in mind, I think that allowing the "--rfc=-<string>"
> form is the way to go.  Computer lingo often bends English grammar
> to a certain degree, to achieve compactness, but bending and dumbing
> it down more that it's actually necessary isn't something that we
> should embrace.
> 
> I hope all this makes sense.
> 
>>  (1) keep using their existing ways and keep sending their message
>>      with the "[RESEND PATCH]" prefix.
>>
>>  (2) rejoice in the new automation, switch to use "--rfc=RESEND",
>>      and start sending their messages with "[RESEND PATCH]" prefix
>>      instead of "[PATCH RESEND]" prefix.
>>
>>  (3) complain and demand a way to append instead of prepend so that
>>      they can use an automation to produce "[PATCH RESEND]" prefix.
>>
>> I do not believe in adding slightly different ways that allow users
>> to be "original" when such differences do not make the world better
>> in meaningful ways [*3*], and I expect there are many more folks who
>> share that sentiment and go to route (2) than those who go to route
>> (3).  If my expectation is true, it means that this patch goes in a
>> wrong direction, and I would be happy to drop it.
>>
>>
>> [Footnote]
>>
>>  *1* The syntax takes inspiration from Perl's three-arg open syntax
>>      that uses pipes "open fh, '|-', 'cmd'", where the dash signals
>>      "the other stuff comes here".
>>
>>  *2* ... because "--rfc" in released versions does not even take any
>>      string value to prepend, let alone append, to begin with.
>>
>>  *3* 
>> https://lore.kernel.org/git/b4d2b3faaf2914b7083327d5a4be3905@manjaro.org/
>>      gathered some stats to observe that "[RFC PATCH]" is more
>>      common than "[PATCH RFC]" by a wide margin, while trying to see
>>      how common "[RESEND PATCH]" (or "[PATCH RESED]") were used (the
>>      answer: much less common).  But it wouldn't have needed to
>>      count "[PATCH RFC]" and "[RFC PATCH]" separately if using a
>>      prefix and not a suffix (or vice versa) were established more
>>      firmly as the standard practice.
>>
>>      It is a fine example that useless diversity making needless
>>      work.
