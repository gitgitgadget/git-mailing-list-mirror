Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81117155389
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742137; cv=none; b=HjDI4AvLVdL2+AETMZmlgUtZjDLc5uAfXH1k2jvxYSmYW0Pmzo6jZm5TeshC/0rl6UXyKO6k7hv4kda5BLkdMZ7HHk/IyqHIN/05Wr8eO5Le3BoJJyhD2c9VhIjNWYC2WdfHVpFWH5K9p7OiM8NZ4V9q9kivbSMpI6lpPrmK+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742137; c=relaxed/simple;
	bh=u1QJnAu8osECABD1AWrdhFALBr9n2EqCvvZcUV1wvzg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OvGF1UmNx+VKVqLm5k9OSQlmCbI+kZy/0JXKZGGdVizQazu8zMH+02a+9CEbBfgzR5uvu0SyQ29uGrJpfgsCmmL5vkJ0JkMt1GRDhBM7UCP3TOfU8blhijNdZOwfQ3biwIqFUHt+zpga47Q4PKmMpt8on755iLVbBglt+L/dnDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWhW/gSQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWhW/gSQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-416a0878ad9so11782755e9.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712742134; x=1713346934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQJmjFGX7Cv2nXtugzTdRBMfoNvtBkEBEvLt1oHVz+g=;
        b=VWhW/gSQ3iAsDObjPEYkYBnhUjuvNLKc+kXx1EvdQ5aWgFuWGtovc7QERfIXK0jzOf
         /Eo1wZfvC6trU69PS1VmFQwwV1Fevi6Jn9iH+gFnVCjcj96bmQxsgkNNJuKNx1eHuvpQ
         93qacKYYocWQhkWWUPXe4SNIxHIvAcj4wUw9a4gy8G/flqqFSbWHzMDh7f1P8EIwwDAP
         ye6h3EGV/7hT0L29Qdo3FcOoXpfTwFxlDcqejJAXJtIAKiBVluxFyMet5iVp5e2ZDFdc
         E3bU/hkoUWyhFQPt086mObJeC4FiwL28VorG0EQdKk/d/KMUEyNZXN2TTR004i4QysSm
         DDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712742134; x=1713346934;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQJmjFGX7Cv2nXtugzTdRBMfoNvtBkEBEvLt1oHVz+g=;
        b=UkvKD8V/DGdTdD62MLLGoAM4Vv7EAt/NG/ww+nkuL473I6NTfNlLVE71Z8W/nrUjC+
         SCtM4w3QUPfHigMkCWQftJ7XpbAquf8Ftf2CX9n6Q5qkDK+coea2XGrotTCKvLBkru0h
         GDsTTU5Q2UYYxvDKurwUibfOy+nCrM5pw4SOljfhk9x04QRoBwB2KP42r8TkdRrc2qhN
         wtIOS0yAcoyYawwQ+Q442b2LCVfAYYqc+mel6praxWTL9zrtx2UDIlmeV5M8NUQnTDzz
         1ha1UWqQZqtpMk1FhSQOgGr+MK7v2y3nxzrD7SFX4oIwgPF0DfsxG5FS3lmIK+x6wR22
         YKBw==
X-Gm-Message-State: AOJu0Yzr5+w/xELFJBHLGP+tFK3BNqBDE5cr5fQ67icu7p39i+1m70EI
	EeSLKvSIf+HMuAfg3/jijlhix0wXKxHHVlsU41Pbp31Wm4BBMwHV
X-Google-Smtp-Source: AGHT+IG9ggZw2x/gkoUei684R0waqLtzxos37qdt/JumgVPJCglq+REIiT0m5JFJ4QEVNTcVUaF1Xg==
X-Received: by 2002:a05:600c:b8b:b0:417:bb6c:8c14 with SMTP id fl11-20020a05600c0b8b00b00417bb6c8c14mr585730wmb.34.1712742133628;
        Wed, 10 Apr 2024 02:42:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b003439d2a5f99sm13335904wrv.55.2024.04.10.02.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 02:42:13 -0700 (PDT)
Message-ID: <6ab115bf-7b78-4633-a64c-9a0925d68e3f@gmail.com>
Date: Wed, 10 Apr 2024 10:42:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] t3428: restore coverage for "apply" backend
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
 <b45af37e3c0a22cc9e0514eb681300be0b968e02.1712676444.git.gitgitgadget@gmail.com>
 <xmqqzfu2yw00.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqzfu2yw00.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 10/04/2024 00:08, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> This test file assumes the "apply" backend is the default which is not
>> the case since 2ac0d6273f (rebase: change the default backend from "am"
>> to "merge", 2020-02-15). Make sure the "apply" backend is tested by
>> specifying it explicitly.
> 
> Hmph, doesn't this lose coverage for the merge backend, though?

I don't think so, we had coverage for the merge backend from the other 
tests before 2ac0d6273f as all of the other tests in this file use the 
merge backend. We're no longer testing "--signoff" without specifying 
some other option that selects a backend but it seems unlikely that we 
could break that without breaking one of the other tests.

Best Wishes

Phillip

> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   t/t3428-rebase-signoff.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
>> index 133e54114f6..1bebd1ce74a 100755
>> --- a/t/t3428-rebase-signoff.sh
>> +++ b/t/t3428-rebase-signoff.sh
>> @@ -38,8 +38,8 @@ test_expect_success 'setup' '
>>   
>>   # We configure an alias to do the rebase --signoff so that
>>   # on the next subtest we can show that --no-signoff overrides the alias
>> -test_expect_success 'rebase --signoff adds a sign-off line' '
>> -	git rbs HEAD^ &&
>> +test_expect_success 'rebase --apply --signoff adds a sign-off line' '
>> +	git rbs --apply HEAD^ &&
>>   	test_commit_message HEAD expected-signed
>>   '
