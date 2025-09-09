Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516329346F
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409166; cv=none; b=HGvcBJU7oCX1ipEJ/erE2AAXpsf8hW7lUlEzNuptOssbMkvmcMvAokIRwY2e7wYgeoV56cMqR77ZQLYBq9bhwjicLY95bY/LfnFXBe2exHMWQHKDLKIf4IVfclc44qgYiQ8xZde7xBl0Q/DOh6PQhOun5h55xEv7W5UTQVryHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409166; c=relaxed/simple;
	bh=le5Gtmun6it5OjTSnYpu4wcM/N0C8rsmq9YUDkpo+mQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CeMpbpXdbba8uIbzdvv5itubIys2I5KEQxv+xIBb6mBL0Nxy1neVMIkdPRK2QJZx1Gb93eFmTQQYf9QthYGPOemfOydnLRDrxOC0UcGtVhttkcmd4mBkGLKzswOGkaK/cFMhpkK/EDtwtf2z2N0nsJDSq1YzUY9/EUF34kcjAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXUEqVSJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXUEqVSJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45df09c7128so3117675e9.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409163; x=1758013963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXday8qecRXHEeqMvKsOd3jADlJ8cmeBOIb6/3vTjgs=;
        b=jXUEqVSJj4k2JR5VftIpuRWVX3lcP8azRrIxVGqwyJfQcrU+YhrOS8QKmyY+2jzyC2
         FbJNZHU6PETri8iBJbutbIZtk6m6FuWvJ4Fc23PBP3V2QD7s7UYSkt24z4kRza+9EhKR
         Qq1TfDRwOAfa9oK3Qy9JPWBfBJm7eDPZuktlf9zC8K7+IZfY7FCItG5V6Qo/cuelZOCI
         ZBqbgLoiLBNuxoP8W7jBrObN/iTQBeseC//oZhKg7JJUgrK6X8yTHtR7IL9V7qYh4YXw
         ZgIUemk0YsraqoMgF4bD7qS7whAzRv6GjfuE6sbN7RuW2FxwYEGHefxKkhd0rmBM5pvP
         K4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409163; x=1758013963;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXday8qecRXHEeqMvKsOd3jADlJ8cmeBOIb6/3vTjgs=;
        b=rspeo42x7SLGjWH++JA+wxTomiFfXPNAHxGrZCnFiXbZHUFxkyiLjMQfdOlKCO/1e/
         rBFwzHYCzslydQMKFWFd0MIQEwZqGEhPNeDuqF0gSWp8Vw/RH6nfGtF/D7mTYTDl9Gmq
         wFmbDKKFaf28GnISSYubYtRaKpbbGG6hFNJ/uN+apFzCLt+f8qDhgZgXnZwb/yB4KXTP
         hrYjB2h9qLFnCNxy17cC5VfmMEwLTbWUoPO4TRRaQ6TbRq2eiM6M9XmcyyBm9O8I3Z2Z
         NSoErZRIwy/CPxuCsQUfq+g6PGIo49NsXH7rRBegVp21T4cNvs/TWAb7L9LAAhNJpZ2q
         SRGg==
X-Gm-Message-State: AOJu0YwsXb9tOdcnFE++PNFs6ZnWs0u3Jx6RMrlWMODnZBOHSY6q4Bdf
	lwT7RoRnq7WWkPM9G7YYpAHQagjCyj//+38ClMldmH+H30cpzAWmgFnW
X-Gm-Gg: ASbGncvpmLkkk1PFzplmEcmyqe3e1dVlEB3ZahjYR7b4N612F/kZfBJFBUNjkqZ8VhJ
	2GWpnixWD+x6zKnF+2pFrgFsn1FNWFD2EMGtYUibRUiMG5cyNhcu6entX/5x1dMsHMhrOYDqlrX
	5OO6JoMjXoxhrqIwfnV6Im+CMPleojCVuLBAUlZjTbVDuW7x8TCPIWhrXVL0vZNdCXiAjTsopCF
	OOco/9xIycmp4MSfhTMqFG/GqcgEIkfq1gbUw5b69oAqDZBMJ4ljattR/fK/gO5Yxo8FkkF8bA7
	1H0hKzDAsO9+1bbEUPiJXEq75NUD/1M/XZ8AuSWxy9a5dPLtixKFeuKhXteqLOmuqOQUXHXSZ6e
	XACUOASCuxDyu1vvfZ0f+ge/sTqkHvGFhFM3XVJZ5FY0Uwfqp2imlk3Gl65ODBQ8pAJYJbheKwj
	BPhgUi/ADYs7qWwHM=
X-Google-Smtp-Source: AGHT+IFIJ3c4xvRI8iORcJUxI7p8+kZKPUTzDD84p2Y4eeI1FBcJawOW2CkyySMra0KRk8GkoT60RQ==
X-Received: by 2002:a05:600c:1daa:b0:45b:92a6:63e3 with SMTP id 5b1f17b1804b1-45dd5b68e02mr116337975e9.9.1757409163145;
        Tue, 09 Sep 2025 02:12:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df3353ae6sm2862745e9.0.2025.09.09.02.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:12:42 -0700 (PDT)
Message-ID: <7c25d5a6-1b34-485e-93f9-25bbe37d5bd4@gmail.com>
Date: Tue, 9 Sep 2025 10:12:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>,
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com> <aLrzqR2Z9jz5CuJu@pks.im>
Content-Language: en-US
In-Reply-To: <aLrzqR2Z9jz5CuJu@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 05/09/2025 15:28, Patrick Steinhardt wrote:
> On Fri, Sep 05, 2025 at 03:14:25PM +0100, Phillip Wood wrote:
>>
>> It looks like this version does include the necessary Makefile changes which
>> is great. I do think though, that for the test balloon to be valuable, we
>> need make building with rust the default with an error message that tells
>> people how to build without rust if that fails. Otherwise it is easy for
>> people building on platforms without rust support to miss that we're going
>> to be making it mandatory soon.
> 
> I have a plan layed out in the BreakingChanges document that mentions
> how I'm proposing to do the transition:
> 
>    1. We introduce it with auto-detection for Meson and default-disabled
>       for our Makefile in Git 2.52.

I'm not sure how much this helps us. You've said elsewhere that you 
don't want to be inundated with bug reports which is fair enough, but 
I'm fairly skeptical that we're going to get enough people enabling this 
get a useful amount of early feedback. So I wonder if it would be better 
just to bite the bullet and enable it by default from the start. I think 
I saw Elijah making a similar argument elsewhere in this thread.
> In the end it kind of hinges on when we think we want to release Git
> 3.0. If we can agree on the above plan, we could also think about making
> Git 2.55 become 3.0 instead. That'd be in a bit less than a year from
> now, which I think is a good timeframe for that breaking release. I
> personally don't see a reason to push it out into the future for way
> longer than that, and it would be good anyway if we built some consensus
> around its release date.

It would definitely be good to firm up the date for a Git 3.0 release. 
I've been thinking whether there are any config defaults we might want 
to change like "commit.verbose" and "merge.conflictStyle" and enabling 
"--reapply-cherry-pick --empty=false" by default for "git rebase". 
Having a firm deadline would focus my mind!

Thanks

Phillip


> Patrick

