Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CBF196C7C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689137; cv=none; b=mWnyA9PnudnWTbyymH+izBzFA/OcpCuAQtLA/Sh3meA7/2+Z6LVfqaMEFnSZ7hT75V8YriZJt6UymEcagm79tiVbKycDnRbQzBS7i6y9JKej7cq4vpXIlo7itqwAkXYOCMcwWcCFOqs3IMIWJr1JNELv+b2wyx7VM5eQDc0fDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689137; c=relaxed/simple;
	bh=qNXVTIl4bFHNloZ1+VvtFu9OoY9t1jjDGU3EtMdcMq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WczPsoQchdNAnNz2kbPWdUah13GhMuIzo5JdTkH/JPzcTrbkIwHQpQ9JGLZ1hw2yQS5hbF3o1aQMhiURFgTfS4hl//fCRgEmw9ulqhboFPe3oVTsenyiXjGcrdbH2iMXkHv+rxRBM7UzxGAk4jfiDgen1k5jYtCKDxSB/W+vPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2IuIrOZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2IuIrOZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42108856c33so13622125e9.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717689134; x=1718293934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VGbs9oMqvocTtUezRD7o5+QYso7gtdx1mr9NSQS2FZI=;
        b=A2IuIrOZ/sN7trWKju5Q2BPjXrb4YCZewmcy0xdJ/p2YUPhhY+6JdFbeSe5i5Z20v6
         FBDWwSZl8x2zNO598W5ZB6nEfdkIBk74gGU5IX3dntH7sfVrsi1tov2p+J8s2YkZfkZM
         U11Dqb1yGgDSQds+Wpi+tFQpaaY+Hmx6oIlBfZlbqMuVSEK0fT4NC8cGftfYLaLjiuAA
         vQPFELIc9gY3DQzxfykuoQsXx84fQLltyYjDMY5LrYQyR2RGYtXyiQ22beTw0B+stPcZ
         B4RerNl8rQxeyBr63zBTNSKhPCewM6CTQqVBDBXk14+1s9rceQAJ2WKKDSAZoqOWAPKh
         pGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717689134; x=1718293934;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGbs9oMqvocTtUezRD7o5+QYso7gtdx1mr9NSQS2FZI=;
        b=en3jZ4xVvBiHIkNVBr8Rn3dD90cBcvv/odgIfK9MPBLPk+BPpiT+r8XbuR5zs7u6CF
         Dt591e2QOrcRByafTtrKHVqnXXaxUjgmOtjKFZhjNpa/DQ04K6SM9meLbgxHG8XI9xu1
         09DYiQYLgs5InFBhmFI6621uOmtqv7oBPpXo7sXvap9p+bL2jrCmyUV5WqA9dm+3BQtI
         VbjlzDH/X67isIM1t4dWBVsc+2SRkZ7BrV2SNfEgMkFe5FZ3BNtidfeDBmFt81Sp+Yd5
         9QGO+NTs8QnRmdtaEGOAHKaFIdebO47n24Jjp+/N7IlTv+woQREqxWap+qB7dDQ9UDSx
         bkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQl6rVLmqoK9Pup5kYuHA/0BmAgkS3q7CcXhnKe5X1GGbbHouxcZLNeMhKWRgKwj7APAXgtZuFRw+T/5/0OnW9cGt3
X-Gm-Message-State: AOJu0Yz9mW3rMmfl+z/rjLUosFpqwwXZ9FBEFdHMwoqz0xFL1mzznj3J
	OOXX9bpTmJvuLz9c76UOqYrVaMTqm4qtfNzlxblV/DxcRfBRbNbC
X-Google-Smtp-Source: AGHT+IEe2Tls3zrquooZ9aR7tLPgwZYaOOtgSOElKmOhU8Phz5FIzEHlK2FZVQHWsJfBrGVBPHX6gQ==
X-Received: by 2002:a05:600c:45cc:b0:41f:c5c5:c9df with SMTP id 5b1f17b1804b1-42164a32c1amr898215e9.14.1717689134260;
        Thu, 06 Jun 2024 08:52:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:124f:b55:b414:cf29? ([2a0a:ef40:641:9001:124f:b55:b414:cf29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2cd247sm26497495e9.40.2024.06.06.08.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 08:52:14 -0700 (PDT)
Message-ID: <4ba1343d-1467-46a0-85b0-b249e1ddedf7@gmail.com>
Date: Thu, 6 Jun 2024 16:52:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 13/29] merge-recursive: fix memory leak when finalizing
 merge
To: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org
References: <cover.1717402439.git.ps@pks.im>
 <930de119116355f0b6df9e7e1d5d0fe38d93755a.1717402439.git.ps@pks.im>
 <CAOLa=ZQ5qN9+GGp2Cmks+J2dCbZpNvd0ZEGTWejedUCtzXF9Ew@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZQ5qN9+GGp2Cmks+J2dCbZpNvd0ZEGTWejedUCtzXF9Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/06/2024 11:50, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> We do not free some members of `struct merge_options`' private data.
> 
> Nit: s/`struct merge_options`'/`struct merge_options`'s/

Either is correct, it is a matter of style whether one adds the trailing 
"s".

Best Wishes

Phillip
