Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28985139E
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717607; cv=none; b=XU+fC9yuyerPE6NtKVMDLf3FXyg4Gs6ic/xc0kjBdJ5VRTvE5A0V+sjQ/qhJzjMbiOxX7+L3f7HTjLMTzy7KdODctwcMl0ZXrmvqI7LRXEXxMGkz27fTuQW6VFkT6v3PKxkd3JcWrRR32z6UI5VfXlzue0OP+g723iSy0tup5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717607; c=relaxed/simple;
	bh=W4fbUTJUNbEdUCWCE0IYr8Si7hz+6t6ZT84z0h8MHxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q2hLsNrRq/hqM8W//k0o64lTOY/BRN52CusM7A9jXqaGKSCWdhgg6J6AWXmkmDcgLmC2AMsLN7LIw4wUT4tBSgI2foxnthEa+nz0puf3GviNIecctAdDqEbougekxblahYEdeHNlkH9+25P0AjpBXwmt1GDoGqt3dmqPJEF6MaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CV/yrpxG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV/yrpxG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22185cddbffso2139805ad.1
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741717605; x=1742322405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8BaQzOLglAPCxerAuiFb93OdpUZHyH+xwNfcuNjPGg=;
        b=CV/yrpxGZLCi3xOagY8mX8nBLT68UsZW+Ji7FSAgh8AyR34jj5nO131tsPaG//qszx
         Jz1kjsuTmp8i+Ei7dvY/DGr6we3156kgYdYKMQieGqsu3Q6cYnEzR7tyRToPQe20dKqc
         KDwHsgk3ygJEfdDf2gVwcbLS94SDOblNqokvoHVmT8EdNvLJKxrUrbldTjxVp00pCoAm
         0sSAtrpFA7DxGUtMZmk7pJG/XItzYLTLzBUMiIc69HobKYGmWVq+vVTBeIZtIWDeJ9Dp
         Vx9VpLF1gwun+1EdwaHcmwfVKh4OqtMY7tO3GahhcB5tPMlemYymfrh56TzC3B8QmSL4
         8BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741717605; x=1742322405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8BaQzOLglAPCxerAuiFb93OdpUZHyH+xwNfcuNjPGg=;
        b=kfGj/wNHVsck7Yqx/kfeWeFjEBUBGEm6sAbx/yanwT0AH+9qBI1KzRxVjsJAd6BRtN
         9z1LkniXfBzo7cGhq2oXktHpTgfxNBGsBSku5cyymOtSBj1FoSvxd98Dr9oOtcdu6PTE
         Idx2ZHhMPP4M3z/hVlCaPDEJRnkLFnclEkTysaUZnahbfLHr+2bQF49DZbelZ0V/QPDH
         TmDv4q3w1QfAqmqrKdULN1t6g7Rqq+1LdoUyyX6VXZdmXvBwLwD1YdHdmzFNrBYXIIHd
         +NILlq4flEeffGESEt9UoTG5zsonZvaI4I/+IJJgK98lC5yhbvRs2c+BeMZZiDXo9S4g
         YwKw==
X-Forwarded-Encrypted: i=1; AJvYcCXmWJxW+PYWTjjeGjxo6DxmJYtyfIEMZKqhkBN/LqwZQhbuoNMQyW9QQC0/dU1yfPf8ozE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1tUDSoQinZPRKGeA0xtJ5mH7oMmDd4eFUt6GcHzpu8t+YbiXd
	lrxwVVnn3eLgp3PRBeNHftKGvnFLIt4s78JKEqiaVo68ODbvQ233
X-Gm-Gg: ASbGncuDBRZF5CeKldrEztcOhTLhuinx8O5pmtYy/W7jSN4EQkVLKxDwsdLPBWFWGqp
	Jgu5iZQ20B+cDQf4rBSoCdOZ1JAmihh6lEJwjtQNcG6oo17Q2dzbnwCuaurfhka9dhT8F9dCox9
	sSgoqw5gB7BNuQB8ut5OQlKEObFX41PgO9zkPnOz13k0ENNPlDL6A/MpOkRtV/ZINo7Z09FhYe/
	rq/2jkdjgumiU/pg7ZUTJIlCBSYRTMsbOhYVKPDOZ2A59wDL7HCD2CfdH6QqXnAuYXDI70coKnM
	ak+TCWDkcw6osbf5E7r+7rtvIcYcvII/kBfcUZXd9G8ebni6uIc=
X-Google-Smtp-Source: AGHT+IG5Oz2yPPEq7I3BjgW/Pn1jy0AFu6lHWB7t/dkEwoSGvXVUfqtj0tNEbw12S6hf+g01WzsKHg==
X-Received: by 2002:a05:6a00:18a9:b0:728:f21b:ce4c with SMTP id d2e1a72fcca58-736ec60dd79mr6574121b3a.5.1741717605294;
        Tue, 11 Mar 2025 11:26:45 -0700 (PDT)
Received: from [10.61.143.243] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c5e9195dsm6253155b3a.160.2025.03.11.11.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:26:44 -0700 (PDT)
Message-ID: <c7045e4a-51af-4fff-b6e3-36afff005c77@gmail.com>
Date: Tue, 11 Mar 2025 23:56:42 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v2] decorate: fix sign comparison warnings
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <afa6b428-3190-42ae-9eac-540c95b576fd@gmail.com>
 <7c219279-8151-49c0-8fc0-8abe2624aca9@gmail.com>
 <CAOLa=ZS=+UGf5yQO3nVhLFJ7BgsSSxigKA3CTqEVez2zkQKyoA@mail.gmail.com>
Content-Language: en-US
From: Arnav Bhate <bhatearnav@gmail.com>
In-Reply-To: <CAOLa=ZS=+UGf5yQO3nVhLFJ7BgsSSxigKA3CTqEVez2zkQKyoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Karthik Nayak <karthik.188@gmail.com> writes:
> Arnav Bhate <bhatearnav@gmail.com> writes:
> 
>> There are multiple instances where ints have been initialized with
>> values of unsigned ints, and where negative values don't mean anything.
>> When such ints are compared with unsigned ints, it causes sign comparison
>> warnings.
>>
>> Also, some of these are used just as stand-ins for their initial
>> values, never being modified, thus obscuring the specific conditions
>> under which certain operations happen.
>>
>> Replace int with unsigned int for 2 variables, and replace the
>> intermediate variables with their initial values for 2 other variables.
> 
> Nit: worthwhile to mention that we also remove the
> `DISABLE_SIGN_COMPARE_WARNINGS` macro as a result of this change.

I'll keep this in mind for my next contribution.

-- 
Regards,
Arnav Bhate
(He/Him)

