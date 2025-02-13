Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9EF20766A
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439804; cv=none; b=ohxhAZPQV1+u9YY502KsBRjFxsU80tWitup2mARllLQHfV2TSXRrFQyOWlNppSnjWldpW7GPs0/XC0yhYmDhEs29mjKMpWbElTZ6wKAugYjmlHDpH29RIQBgw6QyU1QT5BhElb+1QAy2BpoK91sF86eP1iBcdZ49ULzlJS1zzCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439804; c=relaxed/simple;
	bh=6IF6Prryf1WAaAU5JtgXAAtIgePM67ARj4HQ3IvIOPc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ktmalL2Z+Ua4R8KJv6cEhW4u86QdW87S0GCJVbBOcrMW7L80ZNxPkYZBHKpj1nXlBKDo0xwScM6af6j87xMh1f4tjYj0cGKWbkpwyrJRX81p28+4HGhiNs9F1G5PQTKAhRUxa4Na2kaDTXGkB6tSRzx83pX+CJbKHLor5aOFZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDRD+7Qg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDRD+7Qg"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dd93a4e8eso496572f8f.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739439801; x=1740044601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDwlOPXyOdp+k0gw034WrDDThVoMUEv/v+FkYhS2dTk=;
        b=lDRD+7QgFjPnc+6PcYMuMO8/FzkKXYxKDb0ONykuQ6i5xiVc/MBwYaM8+cIGU7X7Ky
         m3Fprewk7gTuq7m6FwR2vGPBjG5J5PbfklugowbJVwxNDg6ip0kHPZJLOsepy7Q23Jh6
         wZCLW77eStOf338ADGbWmQ3NSG8tnA9Xe4n2olQAks7Mn3m4OdScTu4iemkNuBC5dGsu
         sZ2pa1ctRbO06LYxY9jcfJ98KpOwhA5fMvLYo4D6BY+f/gsfoc90g+ITzKFTDE1qGnU+
         UdHdcq2uV9Qi8WZVD9TdlEjBb25jT5rq+XnH5skf/6ebz5nyY2KAi56SZkdW/s8UdIQV
         gstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739439801; x=1740044601;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDwlOPXyOdp+k0gw034WrDDThVoMUEv/v+FkYhS2dTk=;
        b=H6sEaZdR1vb27ZGRAQ5IuzVkcz5Pn9RjMeDbQTDXZOIFHOPg0UlD3JkxbTPGFgPwID
         Lk14cQwGQMU3zSQ6Lm87BXDFOZ46oJOxaIPS8bEc5Pa6oVkhvrQpKEK8dVLOR/iRvBjp
         dk/07G63jUtRtvRkYaHmcVi9Z3fSno8Ki0hezbSLOW4mIjjM6Ip4deejoh+kvfoyH2NC
         15C7s65Wh/L9QpXFatENk6TuUxPz4aQl8rb6fj13bl7wzBkeuOKaF0BhhsTIoGP7QaWw
         jwqGIK/yZhDVaokjODL2oOKFOtOdXqhPkefW2VObhO7qFX7rJ4EtEKEdcwAqY1uii845
         fHNA==
X-Forwarded-Encrypted: i=1; AJvYcCWizLQbjzfgz2HnmyKjnvj4WGxmuCMBEYBKTySndNYGqpl8Q4VtHK6ERoRiRIOD/36Fc4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsd6vWOtt60M+p0pFd6elmLl1PuujKs5wxZPmVpDmvXfTABx3T
	BgI2EJSdBoj6Qefln05M4ddX3te04khSza2VdIzYcBuQHDRsJfJ3
X-Gm-Gg: ASbGncu6k68oA5UTpzMBc0sku9d5Yg8339UX9fPYUwufl7xk1ZDzJFG7ee7a2uWCWLU
	NLPt9mewbR1MeVnuxTmkE4KFwsJscHdwpLpesl4dRSnYqPEfswX+GlIN4cedivMUOr/tpqA9HiP
	ntXfyS8GC8HmnGWXL4KVA1j2ABH78b3O5alwQAdzJ020ummoeCNDwpr56dujFDPWebG92DYM56A
	xIyUlfY7OrXGYgymuJ3sCLZv8BfrZF0ZOgSDkpHL+BkbOTvMpNUo7y9g7c41YR9VjXVtnLrGMLG
	DQJAtIYPBqpYN24rCpmXUJz1cA6CrG6YYS+f6ogkamzJHNTNTodMLfNHXSCx73h73pjhMg==
X-Google-Smtp-Source: AGHT+IEw6BKSqnvv0pr5NShm2XUWz9V8ZnTiaLzcffMf3ZfxmfLcn/Xci2x/lW8KFbbKF5uN3HuZtQ==
X-Received: by 2002:a05:6000:12c6:b0:38e:d026:820 with SMTP id ffacd0b85a97d-38f244e539dmr2603703f8f.16.1739439801271;
        Thu, 13 Feb 2025 01:43:21 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccdesm1372087f8f.26.2025.02.13.01.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:43:20 -0800 (PST)
Message-ID: <27f4e010-e2fb-4e80-b64d-3843c9fc3f55@gmail.com>
Date: Thu, 13 Feb 2025 09:43:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
To: Junio C Hamano <gitster@pobox.com>
Cc: Ivan Shapovalov <intelfx@intelfx.name>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>
References: <20250210191650.316329-1-intelfx@intelfx.name>
 <1279671f-4063-4347-b153-9f6ff079bd77@gmail.com>
 <f689c263ead8104ec42f63f1e9ed10350a27ae1d.camel@intelfx.name>
 <5b605c3e-ef6a-433a-9637-1e8f277dfde9@gmail.com> <xmqqh64zumkw.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqh64zumkw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2025 16:58, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Maintaining multiple versions of the same branch sounds like a lot of
>> work - whats the advantage over merging a single branch into each
>> release?
> 
> Making a single branch that would merge to each release track
> cleanly, with preparing and maintaining semantic fixes necessary for
> each track, is probably equally a lot of work, if not more.  I try
> to do that for this project only because I am a perfectionist for
> these things (and do so for fun), but I can understand if many
> others (a pragmatist in me included) consider it not worth the
> effort.  After all, it stops mattering once the branch finally gets
> merged.

Thanks for that insight, I'd assumed the benefits of having a single 
source of truth for each branch outweighed the costs but it seems that 
is not necessarily the case.

Best Wishes

Phillip
