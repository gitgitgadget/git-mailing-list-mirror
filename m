Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07BE757EA
	for <git@vger.kernel.org>; Mon,  6 May 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001566; cv=none; b=iheR5YccUsZrv4eRqmYh/IemlNj0Ylzw8wTb/aAMtG2N7sfnGYeXNvYSEDBdseWQLsGUmoIIaufyjfaVZWGuC9m3MiQkgCr83z0hm7r4B4A2kAZNHs66jQHVExewcFHV6p4ipeNWjOZc4MWbJAG2LbuxB/AJGR5ihwyF5Rnmveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001566; c=relaxed/simple;
	bh=4zRZP753XQZgHcta8mkamHKaq2uM8+Ky0Kj0XYpX9/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkZyKkPiZdkMcF2asjzRkXqLPdM32JGQBqZPga9MvxoAKJMuSspHeK+HeymJ98dxy3DhoD0iCig6S8OsTpDvWTsDdLcj2ZLZueyz+kQXjPigJMrGWRdKyDHoBazB0O6PvBuUXRLpW823YCLKheD6nWH3FXaMRuOxa6XpR4Gj4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgW3zHbf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgW3zHbf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41ecffed96cso7802745e9.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715001563; x=1715606363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4zRZP753XQZgHcta8mkamHKaq2uM8+Ky0Kj0XYpX9/k=;
        b=AgW3zHbfWATpazbVISIOq6Qm8Ix8KED1c1nyDyQXRk74Y71wwszqbQ/fXmFfzE4+Us
         pq4sx9EtYwThW+MxRCLyASr+J9BmT1o4qduA0bRgRVFcr43RZgfTSbBmHjt1gOKHKVja
         bbzMfbXsal7WQL97mptK70CQoABC7nWSl0nk0iL9LjJJqbLHqir4LyQmeOo6QB1bWcT9
         usTrOuPWiaI2WI8pBODK2apNoKAs+cUIxdYQtdi2jO5VvAyNbGv4k+tWEKQ42UUlZ6CF
         Qk5gwoZYtoRec2gsBILSlQ7vAgZz4z6WZs8V2f4kBpbCAaYimAtC4zMtYug+AzAnZkFl
         2K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715001563; x=1715606363;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zRZP753XQZgHcta8mkamHKaq2uM8+Ky0Kj0XYpX9/k=;
        b=PfcMq7HR1hH8AioTB9Z/q6ROlOdwMka1R3s2qRZEbvvQxhJ+WwiNCsc+aQYwUwvPl8
         EVTzkwCi5/nJq7c61elsObqCiVEJ1OwkqlgYP2ReyQuPBOk7hGIl+OAuDDLtbBRxjsRF
         EUyTXIYwtuM2CScMAAstbPUeFnPmQs0PfGjMcwI7Pm7Wzj61lgXptMBwI8wA4JgPTMfK
         zSTXtBOTcoupw++8i+ZpDRE+2j1Za/4fqMrgvtOLi9wLyGRpwLDwgyD8gc0/IT2s0bpw
         EMzpg2zI5RFE6Vm2szeSA7wFs2Xm+JjO6n5YN0ASQMAd2j27sUl5Uixn+6qQBV851nyG
         ZbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5TkzjIEhyswg4JHeNgvR86NqBnbCaZ2/gQ/brinwPz2lMUnaTMLeSRUd+TcgLVX/rTEP/GLQJ0J4QFRztMZK8yKQq
X-Gm-Message-State: AOJu0Yzz+GUEj/3tr1Rsli9MjsbamRND9c4jbxp9ZywlnBjCvIERfJNT
	mufD1ZelA2jKwc7HSwJoisYv2QcIKcUrqjliGLg+WM+gsTZUqTN+2MmM6V6v
X-Google-Smtp-Source: AGHT+IHzz4rztBBUCQ4CgJG8CpyWB71SCxMRmEHaiOtqzCSzap+Hjh0ECbyJCRFXhpfUTOmH535viQ==
X-Received: by 2002:adf:e9cb:0:b0:34d:8ccf:2c10 with SMTP id l11-20020adfe9cb000000b0034d8ccf2c10mr6243794wrn.10.1715001563004;
        Mon, 06 May 2024 06:19:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id o16-20020adfcf10000000b0034b1bd76d30sm10642652wrj.28.2024.05.06.06.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 06:19:22 -0700 (PDT)
Message-ID: <cd84d359-79e2-439d-bae3-b4450aba7adb@gmail.com>
Date: Mon, 6 May 2024 14:19:21 +0100
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
 <6e1f09fc-747c-4704-87b5-a7b2ba18d78e@gmail.com>
 <CAOLa=ZRo00Mty-RFw5sgsckGj=qbgkwaynyqGiEXR5YhuRCMLA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZRo00Mty-RFw5sgsckGj=qbgkwaynyqGiEXR5YhuRCMLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 06/05/2024 12:19, Karthik Nayak wrote:
>
> Overall, I think we're reaching the same consensus, i.e. to export this
> functionality to a generic function and shared between the both
> backends. I will make this change. I think the message used in the
> reftable backend along the lines of 'verifying symref target ...' is
> verbose yet generic enough, so I'll keep those messages.

That sounds good to me

Thanks

Phillip
