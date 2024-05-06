Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69105CDD0
	for <git@vger.kernel.org>; Mon,  6 May 2024 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989301; cv=none; b=Xp2NbLJk89ldFrJ4+xLhni2gqe6/CTjb1NntFG8CJjpMN37crouCYZXtAFS7me/1L8gy7WT+wfcLVEpZVkzVvqGoVXUvH2CyRTxNW21ryDvHtaNvJjcNCcqS54zoDZ4O5Cr2VJGT6WFhPmfdZ7jLW+xG/w4VYXT5Nl2wh+SP8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989301; c=relaxed/simple;
	bh=PB3J0cxACR6Ut+/ESRDywaGxilmRBJPtJLJ4KfTGB8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWvf7qVtJlGOoUMQwwN9N3Ja2M6FunIjbe6q2jSQm/G95OKNTdIuIr/mRYh5lww3RYgqK2xSAEIt0L9aNG+Rf+aSjHs5HVUw6CqGGv01AdeiZ8bHbIIfVUMrklZ4hu0wGUh/4cvAzYu8YfZkyRx0+W4ZQehfmr48UHcuArnItBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1vau38f; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1vau38f"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34ddc9fe4a1so1315789f8f.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714989298; x=1715594098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LM8a5xmH1UW7OnriU79T2YRjw9i+jKe50UW86N8R5NY=;
        b=L1vau38f4qBtYL0WQaEUftGXChMSTnwYck3K0l9Mq+L0Om3znnOgkDiT0lOPXXNlcS
         EUm5rshKWaWKCDkfKV/oiZPc2f5JaaSov24uhTjZS+GI4KQT4NuRKJDTAXmW0O9sCBCP
         3dGLbv45iyyZ/35FkR+j0ibBAW4MdYNNOiNV/aSni9I7L3cc8F/VEj6HBde3pxpXbho/
         Docm55zWOZersWR0qCNlF22pwGXGayZSxq8lSylUTRpcVb71vFnowZg5DMIIVxYwr8Wb
         Bhh/neW2F15/OqS8vpDPpEGvHdpMQbchydOUvWJCK1IX8UKjUCBVhapCCDcvo32dqJtN
         vVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989298; x=1715594098;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LM8a5xmH1UW7OnriU79T2YRjw9i+jKe50UW86N8R5NY=;
        b=Ou747MGvmHYCNBpJgdlTi2iQaPsywrL6eK+th9hfTx9gPHmtTTdzBieoPqu/j//X7R
         W07ZNLK4A/YIbsixQMjjXq0WR+E684qd7ss0ksTI1vN+e/Qo3AhKpUnxQ4hFvO04qIND
         lfTJCBn3RSzF7ilB4gMTyvEuT60EBW9wTId6nN5UbAQ9s09wc7AHtZ/ElcjpKoukKLnb
         8olY7y0lf9mSKeDhksEalGWkrzoM2vmtNuVb4XTnpJw+Vug8nUZUC+mvwecKwzcnYWuK
         nX7xFHc0Wq1uR2YB6C53lC6I9g2Bz+whBFL+5+ZqBDPMWmHcFYUOs9Q8qmmFlOEYHZci
         wK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4YmnyNpL4e/zJlOp7Jj/NPTyJA3I8yDVnaXJELz/egcazihZYUSCmIsn4Og8yDOyxLbh+zXzcWQKuOpyu6AzVayig
X-Gm-Message-State: AOJu0Yxm1fKoYOCc40J3bhD6ZMX0TbXJ83vtxzAJWGnwwiFIyXmyqGAA
	r4LBlmaMr5fK0Wv/HKNbrMztXkUKDWWniI6B0gUx6t8Lw4wvnNav
X-Google-Smtp-Source: AGHT+IFQeeluXKF1VUhsA7G9XXjPBY9nlJPQ81MBncHyek4nrybRLSjd+mLvOYKDxWaZsJ0ycg6oBg==
X-Received: by 2002:a5d:53ca:0:b0:34f:41f7:98f4 with SMTP id a10-20020a5d53ca000000b0034f41f798f4mr879692wrw.3.1714989298068;
        Mon, 06 May 2024 02:54:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d5647000000b0034e52844757sm8843286wrw.95.2024.05.06.02.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 02:54:57 -0700 (PDT)
Message-ID: <dff080ee-946c-4a44-a448-294ae8ee241f@gmail.com>
Date: Mon, 6 May 2024 10:54:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 4/7] refs: add support for transactional symref updates
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 ps@pks.im
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
 <20240503124115.252413-5-knayak@gitlab.com>
 <17c71b18-20b4-4bbd-b52c-c29ef8d3860e@gmail.com>
 <CAOLa=ZR5a0Tj1abM4z4SAVm5cw5+EA0qyoOMs8QH8MoS6eJGiQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZR5a0Tj1abM4z4SAVm5cw5+EA0qyoOMs8QH8MoS6eJGiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 05/05/2024 17:09, Karthik Nayak wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> I'm slightly concerned that splitting out the update-ref changes means
>> we don't have any test coverage of the new code beyond the part that is
>> used by refs_create_symref()
>>
> 
> This is definitely true. But I also caught a bunch of edge cases this
> way because the tests which indirectly use 'refs_create_symref()' are
> quite intensive.

I forgot to say in my last mail that this is good to know. So it sounds 
like the only new code that isn't being exercised by the tests is the 
check for the old value?

Best Wishes

Phillip
