Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D6879DB8
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872530; cv=none; b=quI9xxYxy4wYq9w5wyjMb4w1Jn6RYVmXYJfHaIC1hMvitWOmp5bFywZ9tQ0V8bQ3YUvWMxsaOML9ia2nFwpytBUMRJpoZyI/i8UG6hvQy4UWHHfGtgkIS01MYU2t5frylEvJAsK3nXJzAlP3Du0R+HjNnmZ4e2BO+8RHpd7VfqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872530; c=relaxed/simple;
	bh=/jMfoJoXMFVEqfmSYeY35CecLfWe3Nc0EaCkAeqThh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F88c/FBuvIaLmi6OSOMEXTDHjAa9VJrR6nH7Cy3P4sppqpdZ0Va1fAZFvRV+2wd1rTNED1E9tokrLVklwFT4XgpjxBbxTUF6F+6ADB0s8zNp9jtevSh8zZ6VjeX+I4VY2vtmId+jkTPu1HtI0lttpinNm0R5QkiIJ/i5oEMbCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvYXBbge; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvYXBbge"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fb020de65so16968355e9.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706872527; x=1707477327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8mjFYKPLGzyrLtsyyIfmONxZGQLmS63a+4HngSM7fso=;
        b=NvYXBbge2jgQquPuGToF8OT7HQj0Xp4QI+dVevG6MMFfnLS0Smlqa+6qtOmSfZtOik
         xLTN8TY5z10jYoUiFDulyhr/IFKPE+3qcMN/QtElKA2uAMUK5YXbywx058QfgCV1UNYZ
         NIhQuZ0P/hZjDE9GpBwC8aCmTm9NtNK24OMCldWkPiZ/9sXL7NjPS4e9NUdR66/56P3l
         S+1KYzFigMSqI651tq2n2D0GLa/89m/LKNNpWKcUOdQDIxnizfvwM/vkC1Gag2itG3gj
         x5ms4lHQYS1zcS3qEfoEa1h5uPdDfb2WPmUIv03ez26W+tZqrNjwLgtaUacn7fxu6IaB
         atrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706872527; x=1707477327;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mjFYKPLGzyrLtsyyIfmONxZGQLmS63a+4HngSM7fso=;
        b=cUjpY7fmp32LjcduzaySNfw2UsTWe04iUBz8hBLddVgMYz7V7s+7XJaOTyFIzffaHK
         CtuUi9Diw0iTACwEKbO+fc19s3HcYZK7Hd9n0Bdr5z9ndSAWLCEL81rW2lBJxFwr9Q92
         ykPFOy4cvoVsLhjzkmuslPlH0lQG5WV1g8jS7BTNmfGidxHIvHMgNamve4bZUhYvxp8P
         Ucz+l5vVrrAtaKiMkV6TYf4cR6DIk+209RsLJlDY1Z+3kiAX3AXfXOAYJdYL+JIn24ZX
         VhF1yXv+/pCFXtblT3IH4BWgPHPhNKOp20PseV//GgGxruSRY4peql09NZJXMQ5MNn6Y
         HjZA==
X-Gm-Message-State: AOJu0Yzid/5pfs0tVxLz/Lla+6AV0+etusvg1pX5kOXVb+SDzQyqJDz5
	l3T7WxYytHayWfbglgjt7qu1DdranoBpPd0rrLQRjumU4ORxcyVzASLdsUqc
X-Google-Smtp-Source: AGHT+IGfGlc9S+xRisv4Ssq/WHlILkHvEWMAdk3HyYhUaedRYl6P31Jj4KB/2UUf0FtGU1exM4AwTg==
X-Received: by 2002:a05:600c:470f:b0:40e:f632:723d with SMTP id v15-20020a05600c470f00b0040ef632723dmr6570389wmo.16.1706872526976;
        Fri, 02 Feb 2024 03:15:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUg4Pf41Y9KPUZ5Fwp4rRlttTv83Fpg4DGnFHg6r/bWKoDTGzpfcZtzY6o10lAXLAu0uao2OCITx6wiQS9b7mrkl0FNsJKhudMYd9ecLumFx0gzYIBVYGR9mdpQORMbhgniKkJhWxx7tGw6ycqtvvzMeUP/4RR93ul9aKF5Uzwu9xKkOa+7Y7Rtl5nUqmgA5KlT6eL1dF5/aHMINHEuEHkrhJ7090bFgII4uA==
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id z2-20020a05600c0a0200b0040f0219c371sm2325541wmp.19.2024.02.02.03.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 03:15:26 -0800 (PST)
Message-ID: <0e3e6102-40eb-4462-b541-0c7452e79f42@gmail.com>
Date: Fri, 2 Feb 2024 11:15:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Hans Meiser <brille1@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net> <Zbx5Xzb3kyHvkp7C@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <Zbx5Xzb3kyHvkp7C@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2024 05:10, Patrick Steinhardt wrote:
> On Fri, Feb 02, 2024 at 01:44:03AM +0000, brian m. carlson wrote:
>> On 2024-02-01 at 18:36:48, Hans Meiser wrote:
> [snip]
>>> In the end, it's all just about git. You may create your own git
>>> webserver (https://git-scm.com/book/en/v2/Git-on-the-Server-GitWeb),
>>> or just use an existing one, like the GitLab server:
>>> https://about.gitlab.com/install/
>>
>> The Git project has tried for a long time to be neutral on any
>> particular external piece of software.  Installing a GitLab server as
>> our preferred development platform would promote GitLab as the preferred
>> forge to other users.  Similarly, moving to GitHub would prefer GitHub
>> over other forges.  That's not a thing we want to do.
>>
>> We also don't accept patches or features for the benefit of one
>> particular forge or external project.  Patches and features must be
>> of general benefit to the project at large.
> 
> I think this point is indeed really important in the context of the Git
> project.

Agreed, thank you for making it brian. If we did decide to use a forge 
we'd need to be very clear in our decision making that it was selected 
based on the specific needs of this project and was not a general 
endorsement of one product over another. We'd also need to address the 
important practical problems of finding resources to maintain the 
infrastructure and software to run it.

Best Wishes

Phillip

