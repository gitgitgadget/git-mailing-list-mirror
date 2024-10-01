Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC098645
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796235; cv=none; b=RWScRcklg/nOSnXsjoCUaiCOJhwJ35yZhFJ3Vt+AbUiOiOif7KaQa/dTgrux6RpePnvIZuFKekzEBXn/DXewYS3C+O+myo9RiL+AmOrFdpaTiuLACrr0c1tcrkYyXrxP/Q0VqitQXkJdNu+UUQfAZxNoB3KNNKHdnWOrJY+a9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796235; c=relaxed/simple;
	bh=4EzRVIHAmsvJphOJ6q154RrjDy+1HhMlDNRyZ8ugNs0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TC7Cg+gRDu7aXgKtr3yDQlZ7sNvXI0ElF8qEoD84iV7ieH3CULGYXzMomwJLSYjblqT/719fB2joP6HdxWOTr0f0hnqw/EAwTcngYOlEd84kH9yYcPz2MwT5rD5qmEswgd0ZgFE5rLLjak1IviA3HTLN7frSNGac+V0BFfd8kaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e36y4ZDG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e36y4ZDG"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8ce5db8668so981255666b.1
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727796232; x=1728401032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9qo671l4IxV0UftVXVSGGX5p/at9Gau6QBWBJMNNUI=;
        b=e36y4ZDGorrPG5X/99L7Xsbhk3U09ggrp8urFhg3ivjnS5xjIfpRERs6uDvad2+BqM
         N+QZKWukyqzSjojX5Wlwj75lvFIwAQFORrKLXrvB9T/pwR4MvGhIVqv4oV0X0GtE4+6K
         McT53ScYa5/7oWGhNLnSwePobaZVNsO+gzyEszfObfgR/2QpKaKBWZVruW6NolF1P0Q4
         6CR6P1Z/3RBEe46+RpzdkkR9rUuQbV0BPuefYn0/zL+jlI5d3/mOhwAUgRsVrJ3l2k9o
         yXI+/lS9FR2wSRihSDKedI2QJqoGeDVuhEgSRD0mteFZKIc+wZ0ZSjI2yXMMzE2V6qaD
         e0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796232; x=1728401032;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9qo671l4IxV0UftVXVSGGX5p/at9Gau6QBWBJMNNUI=;
        b=Iac7jMC/+FhXye4gI1BxuTfXZN0hvEJSiA3xs7hbCYzxLGDg3kgoEZwbMRCQ8SRa9m
         5k3hVzbQXUBcAnpL8cj8ubrDDD0YiVNfBk1twE+sWBLXoQsJDWiNSn36drib8ChsqRjs
         6ENkgDYHIMvmu9yHIxE01B2SpSZ8Yc1/MU9QodFxg/VTrWZOgNlSWbrLeKa6Aa6IVnpN
         ScDL0F1woRtODstdZcq7/qo4LC5hc/t2mTb4UlE1OXT40XhfJHoufcl/7rzJ8AB3F1vN
         iaFheL0Pq/vKbNLK9M/PSkx+UjpOtZjudF6uBECMxydUHdKzvczisFKeYYwiOImv0W9N
         CwHg==
X-Forwarded-Encrypted: i=1; AJvYcCXwAJuh9BF3XPXsyKCzZa67RP1l7C0CTHrxBQVZFXRMQgBo9pKQM1BLXvpyct34K8vOMfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4sawrWALa0mwnA1DIl98nOH1vpVmMGxs3R8IE22IkRIyD2WC
	xDjNrw7TyTH7QRA7DeQVKZ93J1zqHcxo/49lx820vG8Z4ioaBMsO
X-Google-Smtp-Source: AGHT+IElW/Z4+NHNG6A2DSCsykb2RKsTc9qX5mpfl6u7621+7dTWu495TSD415J8ICcBIiMeETSorg==
X-Received: by 2002:a17:907:2d0a:b0:a8a:43bd:a9e8 with SMTP id a640c23a62f3a-a93c4a9d65dmr1824161066b.65.1727796232063;
        Tue, 01 Oct 2024 08:23:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297c2c7sm722735766b.180.2024.10.01.08.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 08:23:51 -0700 (PDT)
Message-ID: <3eb55b24-0890-4093-abf5-362b35cab1bd@gmail.com>
Date: Tue, 1 Oct 2024 16:23:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [TOPIC 07/11] New Contributors and Discord
To: Junio C Hamano <gitster@pobox.com>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Kousik Sanagavarapu <five231003@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 git@vger.kernel.org
References: <Zu78E+0Uk5fMSeQv@five231003> <xmqqsetr5wl1.fsf@gitster.g>
 <20240923-spirited-lime-lyrebird-fe90d5@lemur> <xmqqbk0exdk4.fsf@gitster.g>
 <4e2b5740-6863-4ab6-8483-2e933b4c427c@gmail.com> <xmqqed54gauq.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqed54gauq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/09/2024 20:22, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> If it's easy to set up it might be worth a try. My memories of using
>> bugzilla in the past are that it wasn't too bad for issue
>> tracking. Most of the pain came from trying to use it to review
>> patches which we wouldn't be doing.
> 
> The biggest pain point I remember with bugzilla was to find bugs
> that are still relevant to make sure they are assigned to somebody.
> IOW, curating the collection to make sure false alarms are marked as
> such quickly enough.

That's certainly a pain, but I don't think it's specific to bugzilla 
though. I agree that to be useful the list of bugs needs curating.

Best Wishes

Phillip
