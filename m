Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275E19005E
	for <git@vger.kernel.org>; Wed,  7 May 2025 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612791; cv=none; b=NTrybXQYxKX1g+Le7AOoLUxHaPiDiwOQ3ktRSQJow05J/HmWEdsVEKhWT6pHeotOEg1zpNeJx+oKxYNfbplSsGfCnxmSrYYzdjj5ffw/fiBSTgKdKCfcfQnJGCoHb0qMktD22vEcYCbqyQ4tXiyleUAFs3c44MFZHIUSrulz+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612791; c=relaxed/simple;
	bh=VFMjsd98/SN12KOfOk1Fg9LuwIAL0NrRZvbr3qJGOl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbjmrSk+C13BD4IrSPhNa24swEgCMOCyTAm6We6uHRjBSTLoFDXoFwoi6MDjhMCCBx3lmp8gfcsAOPkqmw8+XOluDDaFjYh76iUfFtFu+4LoEG0VkFmYCg/vaKy7gHyH2XWd3iedyKv90z2wEAKl4d71/m41hQP6LeosKbr4FbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6XdVDll; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6XdVDll"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso4977695e9.0
        for <git@vger.kernel.org>; Wed, 07 May 2025 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746612788; x=1747217588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIhqjvWDgrg9/u7zGkuYlFP+qk8lFq/0EVgXce3U53E=;
        b=l6XdVDllUEaGwCJ069WmezcduLnmfLwy4jyRtoESWUh+q63A7exF1RRLK90Qoal0eE
         IIRnEFUQfapbGWn6AOst5cNybC6OQrvotKQ9/8FeqxNeeu4dUdF1wA72VsIB4yEhiUYb
         fRgwvSTcZSWLubuQJe6V3O0R8lOfqvG7z/Xc0Nw4AkM1mShNx0tbjyUtqfXkHctKMosl
         8pXKrIbJMEFuocBncJ1qGIsaIPVUzSBgTvxUiqmVmuZKhVr/uLro24uDn3RNiQv0fhJQ
         alw6vLbsWwofKDRFo2szFGfSRpW3pWlPxuXu4rsXG9UUc9J45xx4H+ywtQVP4YfTQ1rM
         sX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746612788; x=1747217588;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIhqjvWDgrg9/u7zGkuYlFP+qk8lFq/0EVgXce3U53E=;
        b=lYWa9GvENiLzJ3mVwnwMSyBaA2MHrWdofyQVHVQYxehxxwyda2rYy/ejcbMf+Ogu5v
         Ba3UkOpFKZU7lm1RIwTmxF/ykR8Au/4G1h2BzeYJdrk1nYx0PsqbpTZtm9dmdgtqr8u4
         uv1VfG5hIGzujtHP8C5wo38k0Dh+oS5Qt1OKckLkMok1eoW+ZmV2g/9Edb9nK2C1Qk+R
         D/f/mcRB7khn400MxXWHkQL3AlW0kRu7j/xlJ0vim4pkEnZvGaePysNaZZsFclYjaODA
         hnrFa1FvJw0MiEz/IZdK+vIlzw8EnLSyjH+fpfH0VMBS/C2EQQzCthqI4/24rZTjiMj3
         NreQ==
X-Gm-Message-State: AOJu0YyOxZI1WW9VQA/RnhXg00pmPc4HTDOpEEyxuBKlisbjinj0ztvt
	vjrO+iKapsOGUVonz+5wSzG8e+NQCYXHEkrfYGBE3z/1p6dgQolKmjSxiA==
X-Gm-Gg: ASbGncvYzjgyEIloMxuJYd9JemKYK28WtXf70q4wjwU/yDc9TxJySu21EcCGO+8Wu+I
	5lH2JEItCvc1W7kTQTCcOMTskQRUYSYsXAFwaOEIn+XqC1p7QFhDEOHyre8fua1fidRiclaJvul
	tjdwvaB0j/gCO+GhL4p9fMwoNj4u6bb2LqGFMN160qojzY1YFh0qg4fwRmKSf9QCugXJA0gfvqU
	TeiT1cigsfhYiV5vy4RgAIs7jEXEhabaOQDJO/y7VAakkjZBu4+uBux83HqK//lw2mIL3apJd5G
	EWcsgrxlqItMnBIhv+mSAa4x46Z2oaXhexYv9drNUnZrcHg+8P+LEUZDSbBIRGWT1w==
X-Google-Smtp-Source: AGHT+IEP1h2LpoAfMFeWVZDoWRZqz7GzJaJ+4+o6gE+cTfG+LXHm1tONsjB75yzZAlpM8BnlZurgcQ==
X-Received: by 2002:a05:600c:860b:b0:43d:5264:3cf0 with SMTP id 5b1f17b1804b1-441d3a6e1f8mr32117465e9.11.1746612787361;
        Wed, 07 May 2025 03:13:07 -0700 (PDT)
Received: from [192.168.1.194] ([84.64.112.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d43a765bsm26122655e9.38.2025.05.07.03.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 03:13:06 -0700 (PDT)
Message-ID: <548bec93-ae39-4536-8972-5a9ec538aa3e@gmail.com>
Date: Wed, 7 May 2025 11:12:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] t: fix cases where output breaks TAP format
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
 <20250506-pks-meson-tap-v1-1-5aaab2942a4c@pks.im>
 <49ef0fc1-39f1-4771-88e4-440e0924478f@gmail.com> <aBsDKayGKszubn5i@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aBsDKayGKszubn5i@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/05/2025 07:52, Patrick Steinhardt wrote:
> On Tue, May 06, 2025 at 02:17:09PM +0100, Phillip Wood wrote:
>
>> I think there is an argument that these tests are broken and we should be
>> running these commands inside test_expect_success(). However this patch
>> doesn't make things substantially worse because although we lose the output
>> from test_create_repo that probably isn't going to matter. The changes to
>> the highlighting prereq look fine too.
> 
> Yeah, agreed, our modern style when writing tests should always use
> `test_expect_success()` indeed. So an alternative to this commit would
> thus be to use `test_expect_success()` as you propose. Let me know your
> preference, I'm happy to adapt if you think this is preferable.

If you feel like re-rolling using test_expect_success() that would 
definitely be an improvement but I don't think your patch makes things 
worse than they already are so don't feel you have to.

Thanks

Phillip

