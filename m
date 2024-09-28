Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B591219F42E
	for <git@vger.kernel.org>; Sat, 28 Sep 2024 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727517852; cv=none; b=MuDI5q61Ntf04vWbL1cKwJ6ubGhSlvvinhBIlvn1vBB/mbK5ttyqSXOydC20fac2kSy3yEquuqUkeu6Wgq8QaGm2Bdwinm0cByVakDjIXp3ZFhIFqcabeKSPHqlIBt3bmhpBb6bbT7b1s6NmlFalNkICaqGqewbbBFRluqxZY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727517852; c=relaxed/simple;
	bh=SCRwTs37XdQ1uB5N2YR0BjWZ+U3oIhWr1srFruFYXWo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Twva7NUXnly4eCZ3QZTNux54jYoMxwNy7b4tdGrvtsWeidoPbK6jYZ0ZMTIE0uLXj3TxeuEuJFxnInfSUSyd5+T9BSWWxDWMz/h2tORRHhvo1tmdqDR9B2DQfUon0MxcMJe90gbiYJfQfKEPGm1A73w2dO6DgEmoL40mc71vPUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCg4lzlc; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCg4lzlc"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c42f406fa5so1897266a12.0
        for <git@vger.kernel.org>; Sat, 28 Sep 2024 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727517849; x=1728122649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWMgwO2sxfoRQdPeqdZRjxLGCR4MCdd7M4Uc9abCuQc=;
        b=CCg4lzlc2GQTLSakVVssojWBn0dsVkOamNREDCU2/PFd9txQBliJD9pnBqXRbe1ZIF
         bX0c+KGfEzd7YweVtbaNwIKmF2irTWQ9CCMxx1ePWfsm6GJU08XYMBHbF9Ky5+MHqmCO
         GYnAVRDLE+4xyaN/eVcc1rhzgdAU3HowLomvGtPmT64sb6mEJXbzuG+F0rGsCgizc07v
         qvBqufeDXjARk8IVElwocOdXhELfLlGrogF9jY1PtXUqgz4XLj4OvQ7AFh5v9CqLm6IV
         bSAKXIPIsLGwhFhHy54lN7vB0gkhvDGhiu2uZc6ZGux8kwPWqcDZevOBa7QLg2DM3hWI
         6FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727517849; x=1728122649;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWMgwO2sxfoRQdPeqdZRjxLGCR4MCdd7M4Uc9abCuQc=;
        b=de9mnzqacEjIxOi+O7vGZMqy9mOhfTt2BiEMIWXRJGrFGvaE5d7kes1SBMkHhGMdbs
         XJs/9YfTl9362JPQ2EcjuRYUsVj9aTL+Mz1FL1bRIyOj0V1u0kJWtQkBj182D2s5RJCO
         hwXxniMU1CcgOpmLkgQXcokgPFARmD1YO4UED+wBANPaPgmefOKuWPzCRHk2NEgw9r1Z
         DFDdmmZOd/lwc6rn2xWhh7KvZqHjKFi0TSiRr0JBqFDr6GOMTGhsYH6B9Mn2lhvbR0XD
         kZw73/VP9afhG8qBduIPfJ3KJIr7iCzijfaF5GKFphl9ibu4NVw/VwIj7DPfynYuEUUi
         pJFA==
X-Forwarded-Encrypted: i=1; AJvYcCXypRre7gZMQ25/rvyp6GJTFvHUMw8Lytdbm7yUnZkGRoEbIP8xPtD+pqe2jFhnsKVjRig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvbnKkuZ4sK/+bafeBIY73Obe42B876YI9z5sPP3JWa6uHPBa
	nieTyrhkqkzYw1m/c4zhTjaEeKbuiHl0JguHxjuE8gptfgJbtJfUKQcXaw==
X-Google-Smtp-Source: AGHT+IEdU+UcnpqshKZPMma2S2ZTGj9bu3RYCKDBkA3COv2ursjdVZ+jlHQbJDuxpDwgq/mAFbgPSQ==
X-Received: by 2002:a05:6402:280d:b0:5c8:850d:ad4a with SMTP id 4fb4d7f45d1cf-5c8850daf0emr5020884a12.11.1727517848770;
        Sat, 28 Sep 2024 03:04:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88d7f3282sm214259a12.30.2024.09.28.03.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 03:04:07 -0700 (PDT)
Message-ID: <6d6b2ff0-b4e4-4442-a3be-9b31742db280@gmail.com>
Date: Sat, 28 Sep 2024 11:04:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: How dangerous is --committer-date-is-author-date these days?
From: Phillip Wood <phillip.wood123@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>, Git Mailing List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <aa981bb7-dd3b-4e63-9769-0fc2559983e6@gmail.com>
Content-Language: en-US
In-Reply-To: <aa981bb7-dd3b-4e63-9769-0fc2559983e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/09/2024 10:49, Phillip Wood wrote:
>> - Should we remove it?
> 
> It is only a problem when re-arranging commits 

Of course it's also a problem if one is rebasing onto a commit that is 
newer than the commits that are being rebased. That makes it more of a 
concern, though the option has existed since 2009 and I don't recall 
anyone complaining about the effects of using it. We should certainly 
spell out the potential problems in the documentation.

Best Wishes

Phillip
