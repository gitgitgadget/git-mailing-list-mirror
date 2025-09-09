Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4430100E
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401578; cv=none; b=RV0JooORTwuE+2t44oWrdf7FM47eQaWq9xAhGLosTFrqRYXKSV/vIGzbZFeh0Z077pj8/iMz99X+5b/rV/Zsvi1E30TsN7zwV+stSGYMsTM6gQbDxoThgGQ1uS7RLjiDqb3r5JbqfESz6ezc+/efI2pej7H4wguvoukXolNrXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401578; c=relaxed/simple;
	bh=AhuVpV8C+Y5V/xUB1ZPIgEsJkQcVjy+rk4eMDu6nPoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiBiAHO4J/90de27mfGTTniU6YznIuUSlNCIvx5j1HYo2sGtua1tCrwVTvUE9xIbn8Qj8ee72uPsyY4BqlbQxM/oAAT5869/ez5vNvwYIOdm3VdH8ZlnMA6aDHgN2Y9JABth/5D05E3KiC+OjfmuTnu9up4Quauyf5GntxnxC74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwGeqPqC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwGeqPqC"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32b959b4895so3537875a91.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 00:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757401574; x=1758006374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=De1q6DxWs2wCuRLzCkuuIxpozWztfLfvDglPEGHeeYo=;
        b=hwGeqPqCt9BjilAf7hwXjQmGlptLmEMyv0bTqxSJWLcH78hokzxWDuXnMZmSlF7h5L
         6iBKOGdS9TRiIQvkP90vtiLzIRQs96tGS5YJcUGeMFIqV07R6hyCn9gc73QFNbLpNvyX
         /vrpchxwEXtnYaRJdUirBo86WJ5Ir+yblgZDfKraO58iWdNycG33nM60KIQg2V4udnim
         HZL8uwYUJU75xSu4kzNC8ug+PMDjJ6V1pHipcjKyJhcw8VHFb2TUmrqigNfLMDOTHKKo
         YvaVNMwivQWQOlMjJfnEwNUj3webF/YNpUgUCwxC1ir12LiMqbSupAjMLZZSyZNuDvUN
         Xsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401574; x=1758006374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=De1q6DxWs2wCuRLzCkuuIxpozWztfLfvDglPEGHeeYo=;
        b=AQ3J5MyiwqkCX5b1NqY/0gdfEVBKifELX6u629jWo0VCjmTKYIBQF1ZWDUXQ/GiSpY
         obOWx41aKq/pxbPJCwzX4qSMU00vn/jvg9du+a4wf8lzR+887dMmWZqI31ohJg3asOBH
         yil/Ip1jUbDlKMMLtlHjr2JRRNbLVIxTBmL2tPAMctH1mvLGSy1ywwJ19WGOOIdcAJ0z
         atRt7r+/ZKwYqK/ah1l8p5D/xE2mQx1TlqUv1agPzQcUq6xk8ro7Et4zwlPmFO0Pum+7
         wIS1RKNS03vx5MU9OlYFNWod/zkOoHEn53J+jLu6mqmYEcporXMqHV6nK98zO4MfKyNi
         +lyA==
X-Forwarded-Encrypted: i=1; AJvYcCVjsI3rqU41Spz4v9wcvwEdJrjYj1B20zaax6bx8aX13uzlAbypxZ0IqarXc1QoPQZLQ1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRSx5w+AO5ffKekjwc8+eMn9V4Je5ctdX1rZSLcb/AIezPQc1H
	jT8pHjfFOcm/TxkF1HqXu1qvfauuXaefxbtIREjb/oX59I+BGnvFPlKm
X-Gm-Gg: ASbGncsJ+9y7HrUcyBOmBO+HzA73/NL2bjrEnqGRnxYNAn9iIzZADc1FrLzZPgZHGnm
	gUcuwCvFzlWCoA0CrSiB9GnvXfzZ9O2/s9mEsliZLkJBqu6ROkgpdRfkq82/f/wFs8+bB3orMoG
	92REu3KCdBy5xSQbYUy/WXd71N1Pjtvn6aLi9aHpjAOTbLexYoYaJwmncANqL3lXQDsWt3bIQVZ
	bBl/g1Qi8pT7iajcz68x+LYgpoxU1iGYKuDW372RqHmQ7ZWrqp9oib5qPZuoW3t3045t8Dx5Cf2
	C6GH/chnxZm9goUtwDVp2SSkKruve6Cwxmw/IfSTrlNaWLEt9SSOg1kIzpiDeuZQWQ9bh0zzAKc
	GtBdUxhivgDf2FxkJAoVRcsuV0Jpw0Tfs2HGPy4IoyN+KdL6NVsRw2625Lrr9Joa2VoIDYHe9xb
	ulvtbNjkt07KybRLH/34kOmZ7e5wFL4Zo=
X-Google-Smtp-Source: AGHT+IFZ2c/Cea3j7ig47TXODlqw6J0mMZX5+ttDVh1HM+dNXCrVPaKtwd3DVdATpKyn+pJHPHu3NA==
X-Received: by 2002:a17:90b:2683:b0:327:ba77:a47 with SMTP id 98e67ed59e1d1-32d43f05b51mr15853344a91.15.1757401573740;
        Tue, 09 Sep 2025 00:06:13 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:7e97:4c88:d5cc:6104:3a86? ([2406:7400:56:7e97:4c88:d5cc:6104:3a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466290d6esm1033367b3a.49.2025.09.09.00.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 00:06:13 -0700 (PDT)
Message-ID: <d070bbe1-8142-4811-b8ec-6d705b969381@gmail.com>
Date: Tue, 9 Sep 2025 12:36:08 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] replay: document --update-refs and --batch options
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Toon Claes <toon@iotcl.com>, John Cai <johncai86@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250908043620.57848-3-siddharthasthana31@gmail.com>
 <ecdd1191-844b-47ca-9737-cc2ffb72b37d@app.fastmail.com>
Content-Language: en-US
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <ecdd1191-844b-47ca-9737-cc2ffb72b37d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/09/25 20:10, Kristoffer Haugsbakk wrote:
> On Mon, Sep 8, 2025, at 06:36, Siddharth Asthana wrote:
>> [snip]
>> diff --git a/Documentation/git-replay.adoc
>> b/Documentation/git-replay.adoc
>> index 0b12bf8aa4..cc9f868c2f 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -9,16 +9,17 @@ git-replay - EXPERIMENTAL: Replay commits on a new
>> base, works with bare repos t
>>   SYNOPSIS
>>   --------
>>   [verse]
>> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> |
>> --advance <branch>) <revision-range>...
>> +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--update | --update-refs [--batch]] <revision-range>...


Hi Kristoffer,


> Another downside of making a separate commit for the documentation is
> that now `t/t0450-txt-doc-vs-help.sh` will likely fail for your first
> commit.  One of the tests makes sure that the synopsis and the `.adoc`
> is in synch.


You are right, I will combine the documentation with the implementation 
patch in v2 to avoid the test failure.

Thanks,
Siddharth


>
>>   DESCRIPTION
>>   -----------
>> [snip]
