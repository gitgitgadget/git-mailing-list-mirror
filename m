Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3371D5CFD
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652025; cv=none; b=Um6ARFa99o3l7MWzpycQuYWMcdbm+66MBjBbJmgqvmv52YAD/99nLyTUpTnDrFY91pN8t0fZweoCrnU/0a/iVJj8jqgiceAy89IVMKYkNTCuBYrjZUUpm1aZ2fM78wbEtN1EwPo98zjuE+0xHCQzbhOpus5A+c2FDAt9ObqNDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652025; c=relaxed/simple;
	bh=IAQn9ei/zVVHSvS1pFLkL3WYn15RHe7ni4i3RGIW7d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlbQbnmseQx4U+1LusMNmeEd409HQqqoagi6BXolcnS85c/XgibhY4vhir+k579m1//aT0GWIbEr93gflkcozWJHSDqmDNMd1+KJRzHZ5rVJEuMVnd3sl5b0OWiHMHy+7tlTfqNqtPSzTYdsMQ+Oc8h1ZN5/CJjTMlYSVD39BGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX3zn2Tr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX3zn2Tr"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so1877740a91.0
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725652024; x=1726256824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sqMyXOTkyOWJsMEj09nitgToOVOhsNKT9RDuiXqQaA=;
        b=WX3zn2TrjH2Kl01acTCDeO6RZvBu0NVGwkupt17CbMY029cG0D5GQLZDK4VDWLn0W2
         T6u9XZ46CQJr35iJ3vM7nx+u8H66au3vf2F3ry4ZWf6ZWBoyG1MW7/5/g/JNzAFJnnk1
         vYu52ReK8z56c48tvP+zz+HQL1WW7ET90mDx7+7HZL3U6ApxiEyMKuwYf21cbktoxSXC
         tkBeaqRUglM5s/xFOm/jIOk55rBzR7Z6X4EY/CSzTStSkV98wpluI3La1RQuzRkO8YOh
         vC23NJBDSUuuLtspa8Ds3sxrUXCitM+kTMhXAHBDFa7+KjJ3r4nDorqD/ct3BtdVAfnJ
         zYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652024; x=1726256824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sqMyXOTkyOWJsMEj09nitgToOVOhsNKT9RDuiXqQaA=;
        b=hdUmCwmKBZOnG1exkSD1I6975F/j5pyxpYbhJtaDlrvqK0cU5YFgEcO6/iYrq2BqrT
         5D9pCzdheHQqaKBEO3xGob6sCViqKqzpmDHjLKAIoUR6v9HU3Wje/X9FRpmpebw79zCC
         knEVKt2LhuyHXAAXH5njlP+gGh15HS25nkIu68dBpFdMzdGvPqXBGkAEcDcrKobNNz2E
         haWqGdAXnSgWvp+rvAHiQW9acbKmZwb/stUOZXJrGW86tei0n9NiVYTtOYJRe8A84lj+
         5VJbDx/tqnR8NZC4ujUyvbXDmDq58KXg+VIoLwEmZW6xUFGrpOVv00z+n5hG51710dz+
         5YEA==
X-Gm-Message-State: AOJu0Yy33WdF227Kd52Wp9EcA3c5Cwn3V32M5YnFonbTj/sVH/3AdKJj
	aieYwNXqgxx5Jnxr9J1FWOTHcCkb8TWHNWh+0PUpIEdF7Rb+/oOBSTThig==
X-Google-Smtp-Source: AGHT+IEVKtQ47Z5bbN5yfMmLBF3qm4tARNC59Ag4MqxDGehMIO+U7A+gOWyrXDu4AVKJs55WgsXsVQ==
X-Received: by 2002:a17:90a:d143:b0:2d8:905e:d25b with SMTP id 98e67ed59e1d1-2dad4ef223emr4372606a91.9.1725652023625;
        Fri, 06 Sep 2024 12:47:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d? ([2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0a7c9dsm2005973a91.49.2024.09.06.12.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 12:47:03 -0700 (PDT)
Message-ID: <a60b6cda-6f55-4133-9b26-5475e20cc839@gmail.com>
Date: Fri, 6 Sep 2024 15:47:01 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: recommend GIT_ADVICE=0 for tools
To: Eric Sunshine <sunshine@sunshineco.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
 ps@pks.im, james@jamesliu.io, Jeff King <peff@peff.net>,
 Gabor Gombas <gombasgg@gmail.com>
References: <pull.1781.git.1725559154387.gitgitgadget@gmail.com>
 <CAPig+cSGry+QMpkkiJb8A94w1M+J_5beEKaT-xrGeL34xME4hA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cSGry+QMpkkiJb8A94w1M+J_5beEKaT-xrGeL34xME4hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/5/24 2:02 PM, Eric Sunshine wrote:
> On Thu, Sep 5, 2024 at 1:59 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The GIT_ADVICE environment variable was added implicitly in b79deeb5544
>> (advice: add --no-advice global option, 2024-05-03) but was not
>> documented. Add documentation to show that it is an option for tools
>> that want to disable these messages. Make note that while the
>> --no-advice option exists, older Git versions will fail to parse that
>> option. The environment variable presents a way to change the behavior
>> of Git versions that understand it without disrupting older versions.
>>
>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>> ---
>> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
>> @@ -1,8 +1,12 @@
>>   advice.*::
>>          These variables control various optional help messages designed to
>> -       aid new users.  When left unconfigured, Git will give the message
>> -       alongside instructions on how to squelch it.  You can tell Git
>> -       that you do not need the help message by setting these to `false`:
>> +       aid new users. These are output to `stderr` by default as they are
>> +       intended to help human readers. Tools that execute Git as a subprocess
>> +       can disable these messages by setting `GIT_ACVICE=0` in the environment.
> 
> s/GIT_ACVICE/GIT_ADVICE/

Thank you for catching my typo!
-Stolee

