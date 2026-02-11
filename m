Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133129B8E5
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818716; cv=none; b=Z0teFgt49f5O2eZ14s4n8WhE95/hdt4RtO6SiZeyRZZr0r7NVy1j8KnvTPpWPGb1RCMeMs/x+kgLyIBEONn55SS4G6XBNsq89vdJoQ2WWOOIRt48r1pjaiuma0gpxyI2OUM1mWitomBWzlMyJod1wX+9UPelN/lHT3Em0Dlf2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818716; c=relaxed/simple;
	bh=qGy4yYf75KMTucP9aXM/OKP58U2JMDd7mkdflw+0QMo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RYBHFXwHPdfLaFyvKdaIWHcnC8dFYLuICVdvXLajLb+zt1WOu9zLwpgBs1zrrBu5QUWoCVtVVjF94XU9x+vFK0jNmjGugt5T4PZ3WTwgsN248rQkaIYkunXHJ+IGe8YbpWNHNFk8c7RdStF+VfQimMbCIYWQKgp9wegP7jbGZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xqo3bdym; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqo3bdym"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b8876d1a39bso748958666b.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 06:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770818713; x=1771423513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=roLwHroitjcRIiH9BYFw4uLlNl0zU7O8coqfFOp/tvo=;
        b=Xqo3bdymdxG9PChqGhJydf+fVPZwSjRiC9TANyS29fS8brpILM/M/ujDz9VbBSHCx8
         T7Vw6fgZp9yf3gzxVz4/ufPRPZvaYQO8gtsD+ZsWYACTzsMGUzxZem1XeI4JHTy/oMes
         mkLKPFqoVfVqS0yJwxKFEZ14rcmuifL3kiNPTkbp0M03VXBlA4tEbSBcMMgANhDNIpyM
         063u+da3EOiALb11ZWZtXdig75c7Lag3r3Lo0gbv3RhWGrTHmyjC3n6x/Bo7sdnV2nrk
         PH6NTpF6b5PBP92CLlzi32j2O7pmmXvIBmHvqxqrhKpXuLjWx/eXFM46JWT1TgbqcVM+
         FlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770818713; x=1771423513;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roLwHroitjcRIiH9BYFw4uLlNl0zU7O8coqfFOp/tvo=;
        b=KIPi9Nlkzvt/6pKju42HMjBHT2rmH2gkGnuDdz4wbtmPEgpWHY9k0NvCaKFqofcyB3
         qrkOpUknOaFI3c9l4H5InegGnOoXrdqIlKGoTAeHTfbul24Qpig3Hj5p5Mza0gnyLH3t
         Z8KZEZ6e+2l7VglcLT5IpEMVkHiF2sIYET6G5EKKGizdWkkO0suRPdmy9RCN6WOLZqp+
         5sooGmFxWaYPuNq5p/O/x/GNNOfFi1nte+w8jHJcKIruh8KKMFz8ODGTMg4pmbaePz3X
         pTP65zXbqT/9eqIITx9HC3ep0zrcFHWDlY2m7TA8bVgFTaZrgR/v8sL1H+H8wxazvADq
         a6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWdKnWAz1MVRGpcWpR66lSBt8qzsb1yI2TB+kTfb0YdtIxKDPiMBbDcf+6Gj9NN1J0ae8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3KzDrr6nMUvRXt+Qxcc30VE7oJ5pIKBGl3AhyfJC3q7RylLD
	Nd/EKY0lJy8+0N/yeLMYDzCuwoyAm6y+B6jwy/CnGmfukSpYYVkHRmpl
X-Gm-Gg: AZuq6aIkKOvY0bueWzUJgP2dg3saYfHgMNctxEOnAGdg0dejazxz6BLtW4RK3Hd1QwP
	0dGEcD6dFiaTZeK/10wUxovXAd7pleVyByhBwydgYsci5dHIwkU12bbvw7WyFUkCvomuUpb3dFQ
	l5A+N0sWCVVA2vCUobCp3CA0tlE+Lau51oNNILw53pRncQR5CSXteOJVkFWrlKsZd/T/IHDgc3z
	QIt6Ns+Ev4wj/kh1hXaTA+xv7upou8b3wOwcywdjTr67H0LX0xbFm3MWrnCOyAvjnH+C4Zgfi++
	tg9f0SLsrePjK+JWtJ/l9LLoCiOPyI2EGHT9Cgd57fMZBXCtmTUq01b3zhPj/g1f0HEF1IDpBwC
	6BREJ9SQLKC7CYOzFVONRD00gyw3PX9HoPDeJXDehZHtSpGOhvc9LCEeJ3ZLZHwvFuEr4o52P+p
	LZtW/fmpGMEHpsngT2X2EuRWHupwbFWCZftOrmkhnfCI3hG4dMeASpLqeIi7wKUmUuqVK2rJ1rW
	frJDQ==
X-Received: by 2002:a17:907:9343:b0:b87:117f:b6f9 with SMTP id a640c23a62f3a-b8f6a92e4cdmr163322066b.8.1770818712235;
        Wed, 11 Feb 2026 06:05:12 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f82e70799sm20907566b.8.2026.02.11.06.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 06:05:11 -0800 (PST)
Message-ID: <171c0724-7891-41d7-8a70-94fbbf8b43b2@gmail.com>
Date: Wed, 11 Feb 2026 14:05:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation
 changes
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, Evan Martin <evan.martin@gmail.com>
References: <aYn8XKv2hH2HX2xO@pks.im>
 <20260209215015.25867-1-ben.knoble+github@gmail.com>
 <aYwzAt-dugh_acj9@pks.im> <4a566010-821b-4078-9563-9ca00ada55a0@gmail.com>
 <aYxguUQ6A1cuphCe@pks.im>
Content-Language: en-US
In-Reply-To: <aYxguUQ6A1cuphCe@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/02/2026 10:58, Patrick Steinhardt wrote:
> On Wed, Feb 11, 2026 at 09:44:48AM +0000, Phillip Wood wrote:
>> On 11/02/2026 07:42, Patrick Steinhardt wrote:
>>> On Mon, Feb 09, 2026 at 04:50:06PM -0500, D. Ben Knoble wrote:
>>>>> On Sat, Feb 07, 2026 at 04:59:17PM -0500, D. Ben Knoble wrote:
>>> [snip]
>>>> Only, things are behaving oddly. For example:
>>>>
>>>>       λ meson setup build2
>>>>       λ ninja -C build2
>>>>
>>>> works fine, but
>>>>
>>>>       λ ls -l build2/config*
>>>>       -rw-r--r-- 1 benknoble benknoble 17169  9 févr. 16:39 build2/config-list.h
>>>>
>>>> I don't see the dependency file.
>>>
>>>> Further, re-building seems to get stuck (I get
>>>> similar symptoms if I add or remove a relevant config.adoc file, but let's keep
>>>> it simple for now):
>>>>
>>>>       λ ninja -C build2
>>>>       ninja: Entering directory `build2'
>>>>       [1/28] Generating GIT-VERSION-FILE with a custom command (wrapped by meson to set env)
>>>
>>> With "stuck" you mean that it doesn't do anything, or that it doesn't
>>> actually rebuild?
>>>
>>> I guess it kind of makes sense that a new file wouldn't trigger a
>>> rebuild, even though I would have expected a removed one to trigger one.
>>> After all, the dependency file only tracks the set of _existing_ files
>>> so that we know when to rebuild, and of course the dependency file only
>>> gets regenerated in case any of those files changes.
>>
>> If anyone adds a new file under Documentation/config/ they will need to
>> update Documentation/config.adoc which should then trigger the rebuild. That
>> rebuld will then add the new file to the list of dependencies. If they
>> remove a file we should pick that up with the dependencies that are already
>> listed.
> 
> Oh? Well, if that's the case then the additional changes should indeed
> not be required.

I think so. The only problem I can think of is that if you delete a 
file, build, restore the file without changing anything else and build 
again then config-list.h will not be rebuilt because the deleted file 
would have been removed from the list of dependencies by the previous build.

>>
>> It would be really nice if we can avoid regenerating the depfile with every
>> build.
> 
> Agreed. So maybe the first patch I sent is sufficient after all?

We need to add the script to the list of dependencies and reading the 
comments in 
https://github.com/ninja-build/ninja/blob/master/src/depfile_parser.in.cc 
we should be backslash escaping space, hash and backslash in the 
filename when we write the dependencies. Apart from that I think it is ok.

I guess the alternative is to bite the bullet and list these 
dependencies explicitly as we do for other targets.

Thanks

Phillip

